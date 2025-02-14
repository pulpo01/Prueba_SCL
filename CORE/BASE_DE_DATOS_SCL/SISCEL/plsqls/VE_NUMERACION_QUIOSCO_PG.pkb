CREATE OR REPLACE PACKAGE BODY ve_numeracion_quiosco_pg AS

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


FUNCTION p_selec_reutilizables_fn(
	     vp_actabo  IN VARCHAR2 ,
	     vp_subalm 	IN VARCHAR2 ,
	  	 vp_central IN NUMBER ,
	  	 vp_uso 	IN NUMBER ,
	  	 vp_celular OUT NOCOPY NUMBER ,
	  	 vp_cat 	OUT NOCOPY NUMBER ,
	  	 vp_fecbaja OUT NOCOPY DATE ,
		 sn_cod_retorno  OUT NOCOPY  ge_errores_pg.coderror,
      	 sv_mens_retorno OUT NOCOPY  ge_errores_pg.msgerror,
      	 sn_num_evento   OUT NOCOPY  ge_errores_pg.evento
)RETURN BOOLEAN IS

lv_ssql    VARCHAR2 (1000);

	BEGIN

		sn_cod_retorno  := 0;
    	sv_mens_retorno := '';
    	sn_num_evento   := 0;

		lv_ssql := 'SELECT a.num_celular,a.cod_cat,a.fec_baja ';
		lv_ssql := lv_ssql || 'FROM   ga_celnum_reutil a, al_usos y ';
		lv_ssql := lv_ssql || 'WHERE  a.cod_uso   = y.cod_uso ';
		lv_ssql := lv_ssql || 'AND    cod_subalm  = '||vp_subalm||' ';
		lv_ssql := lv_ssql || 'AND    cod_central = '||vp_central||' ';
		lv_ssql := lv_ssql || 'AND    cod_cat IN (SELECT  cod_cat ';
		lv_ssql := lv_ssql || 'FROM   ga_catactabo ';
		lv_ssql := lv_ssql || 'WHERE  cod_actabo = '||vp_actabo||') ';
		lv_ssql := lv_ssql || 'AND    uso_anterior = '||vp_uso||' ';
		lv_ssql := lv_ssql || 'AND    fec_baja + y.num_dias_hibernacion <= '||SYSDATE||' ';
		lv_ssql := lv_ssql || 'AND NOT EXISTS (SELECT num_celular ';
		lv_ssql := lv_ssql || 'FROM   ga_aboamist b ';
		lv_ssql := lv_ssql || 'WHERE  a.num_celular = b.num_celular ';
		lv_ssql := lv_ssql || 'AND    b.cod_situacion NOT IN (BAA,BAP)) ';
		lv_ssql := lv_ssql || 'AND NOT EXISTS (SELECT num_celular ';
		lv_ssql := lv_ssql || 'FROM   ga_abocel c ';
		lv_ssql := lv_ssql || 'WHERE  a.num_celular = c.num_celular ';
		lv_ssql := lv_ssql || 'AND    c.cod_situacion NOT IN (BAA,BAP)) ';
		lv_ssql := lv_ssql || 'AND NOT EXISTS (SELECT num_telefono ';
		lv_ssql := lv_ssql || 'FROM   al_series d ';
		lv_ssql := lv_ssql || 'WHERE  a.num_celular = d.num_telefono) ';
		lv_ssql := lv_ssql || 'AND NOT EXISTS (SELECT num_celular ';
		lv_ssql := lv_ssql || 'FROM   al_celnum_reutil e ';
		lv_ssql := lv_ssql || 'WHERE  a.num_celular = e.num_celular) ';
		lv_ssql := lv_ssql || 'AND ROWNUM < 2 ';

		SELECT a.num_celular,a.cod_cat,a.fec_baja
		INTO   vp_celular,vp_cat,vp_fecbaja
		FROM   ga_celnum_reutil a, al_usos y
		WHERE  a.cod_uso   = y.cod_uso
		AND    cod_subalm  = vp_subalm
		AND    cod_central = vp_central
		AND    cod_cat IN (SELECT  cod_cat
		  			   	   FROM    ga_catactabo
					       WHERE   cod_actabo = vp_actabo)
		AND    uso_anterior = vp_uso
		AND    fec_baja + y.num_dias_hibernacion <= SYSDATE
		AND NOT EXISTS (SELECT num_celular
						FROM   ga_aboamist b
						WHERE  a.num_celular = b.num_celular
						AND    b.cod_situacion NOT IN ('BAA','BAP'))
		AND NOT EXISTS (SELECT num_celular
					    FROM   ga_abocel c
						WHERE  a.num_celular = c.num_celular
						AND    c.cod_situacion NOT IN ('BAA','BAP'))
		AND NOT EXISTS (SELECT num_telefono
					    FROM   al_series d
						WHERE  a.num_celular = d.num_telefono)
		AND NOT EXISTS (SELECT num_celular
					    FROM   al_celnum_reutil e
						WHERE  a.num_celular = e.num_celular)
		AND ROWNUM < 2;

		lv_ssql := 'DELETE ga_celnum_reutil a WHERE a.num_celular = '||vp_celular||' AND a.cod_cat = '||vp_cat||' AND a.fec_baja = '||vp_fecbaja||' ';

		DELETE ga_celnum_reutil a WHERE a.num_celular = vp_celular AND a.cod_cat = vp_cat AND a.fec_baja = vp_fecbaja;

		RETURN TRUE;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
		 sn_cod_retorno := 12499;
         sv_mens_retorno:='Error en el proceso';
		 sn_num_evento  := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo, sv_mens_retorno, cv_version || '.' || cv_subversion, USER, 'P_NUMERACION_PG. P_SELEC_REUTILIZABLES_FN', lv_ssql, SQLCODE, SQLERRM);
		 RETURN FALSE;
	WHEN OTHERS THEN
	  IF SQLCODE = -54 THEN
	     sn_cod_retorno := 12498;
         sv_mens_retorno:='Numero se encuentra bloquedo temporalmente';
		 sn_num_evento  := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo, sv_mens_retorno, cv_version || '.' || cv_subversion, USER, 'P_NUMERACION_PG.P_SELEC_REUTILIZABLES_FN', lv_ssql, SQLCODE, SQLERRM);
		 RETURN FALSE;
	  ELSE
	     sn_cod_retorno := 12499;
         sv_mens_retorno:='Error en el proceso';
		 sn_num_evento  := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo, sv_mens_retorno, cv_version || '.' || cv_subversion, USER, 'P_NUMERACION_PG.P_SELEC_REUTILIZABLES_FN', lv_ssql, SQLCODE, SQLERRM);
		 RETURN FALSE;
	  END IF;

END p_selec_reutilizables_fn;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


FUNCTION p_selec_rangos_fn(
		 vp_actabo  IN VARCHAR2 ,
		 vp_subalm  IN varchar2 ,
		 vp_central IN NUMBER ,
		 vp_uso 	IN NUMBER ,
		 vp_celular OUT NOCOPY NUMBER ,
		 vp_cat 	OUT NOCOPY NUMBER ,
		 sn_cod_retorno  OUT NOCOPY  ge_errores_pg.coderror,
      	 sv_mens_retorno OUT NOCOPY  ge_errores_pg.msgerror,
      	 sn_num_evento   OUT NOCOPY  ge_errores_pg.evento
)RETURN BOOLEAN IS

v_libres    ga_celnum_uso.num_libres%TYPE;
v_num_hasta ga_celnum_uso.num_hasta%TYPE;
lv_ssql    VARCHAR2 (1000);

	BEGIN

		lv_ssql := 'SELECT num_siguiente,cod_cat,num_libres,num_hasta ';
		lv_ssql := lv_ssql || 'FROM   ga_celnum_uso ';
		lv_ssql := lv_ssql || 'WHERE  cod_subalm  = '||vp_subalm||' ';
		lv_ssql := lv_ssql || 'AND    cod_central = '||vp_central||' ';
		lv_ssql := lv_ssql || 'AND    cod_cat IN  (SELECT cod_cat ';
		lv_ssql := lv_ssql || 'FROM ga_catactabo ';
		lv_ssql := lv_ssql || 'WHERE cod_actabo = '||vp_actabo||') ';
		lv_ssql := lv_ssql || 'AND    cod_uso = '||vp_uso||' ';
		lv_ssql := lv_ssql || 'AND    num_libres > 0 ';
		lv_ssql := lv_ssql || 'AND ROWNUM < 2 ';

		SELECT num_siguiente,cod_cat,num_libres,num_hasta
		INTO   vp_celular,vp_cat,v_libres,v_num_hasta
		FROM   ga_celnum_uso
		WHERE  cod_subalm  = vp_subalm
		AND    cod_central = vp_central
		AND    cod_cat IN  (SELECT cod_cat
			   		   	    FROM ga_catactabo
							WHERE cod_actabo = vp_actabo)
		AND    cod_uso = vp_uso
		AND    num_libres > 0
		AND ROWNUM < 2;

		IF vp_celular = v_num_hasta THEN

            lv_ssql := 'UPDATE ga_celnum_uso ';
            lv_ssql := lv_ssql || 'SET    num_libres = num_libres - 1 ';
            lv_ssql := lv_ssql || 'WHERE  num_siguiente = '||vp_celular||' ';
			lv_ssql := lv_ssql || 'AND    cod_cat = '||vp_cat||' ';
			lv_ssql := lv_ssql || 'AND	   num_libres = '||v_libres||' ';
			lv_ssql := lv_ssql || 'AND    num_hasta  = '||v_num_hasta||' ';

			UPDATE ga_celnum_uso
            SET    num_libres = num_libres - 1
            WHERE  num_siguiente = vp_celular
			AND    cod_cat = vp_cat
			AND	   num_libres = v_libres
			AND    num_hasta  = v_num_hasta;
        ELSE

			lv_ssql := 'UPDATE ga_celnum_uso ';
            lv_ssql := lv_ssql || 'SET num_siguiente = num_siguiente + 1, ';
            lv_ssql := lv_ssql || 'num_libres    = num_libres - 1 ';
            lv_ssql := lv_ssql || 'WHERE  num_siguiente = '||vp_celular||' ';
			lv_ssql := lv_ssql || 'AND    cod_cat = '||vp_cat||' ';
			lv_ssql := lv_ssql || 'AND	   num_libres = '||v_libres||' ';
			lv_ssql := lv_ssql || 'AND    num_hasta  = '||v_num_hasta||' ';

			UPDATE ga_celnum_uso
            SET num_siguiente = num_siguiente + 1,
                num_libres    = num_libres - 1
            WHERE  num_siguiente = vp_celular
			AND    cod_cat = vp_cat
			AND	   num_libres = v_libres
			AND    num_hasta  = v_num_hasta;
		END IF;

		RETURN TRUE;



EXCEPTION
	WHEN OTHERS THEN
		IF SQLCODE = -54 THEN
		     sn_cod_retorno := 12498;
	         sv_mens_retorno:='Numero se encuentra bloquedo temporalmente';
			 sn_num_evento  := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo, sv_mens_retorno, cv_version || '.' || cv_subversion, USER, 'P_NUMERACION_PG.P_VALIDA_CELNUM_USO_PR', lv_ssql, SQLCODE, SQLERRM);
			 RETURN FALSE;
		  ELSE
		     sn_cod_retorno := 12499;
	         sv_mens_retorno:='Error en el proceso';
			 sn_num_evento  := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo, sv_mens_retorno, cv_version || '.' || cv_subversion, USER, 'P_NUMERACION_PG.P_VALIDA_CELNUM_USO_PR', lv_ssql, SQLCODE, SQLERRM);
			 RETURN FALSE;
		  END IF;

END p_selec_rangos_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


FUNCTION p_valida_ga_reserva_fn (
		  vp_celular  	  IN ga_reserva.num_celular%TYPE,
		  vp_uso	  	  IN ga_reserva.cod_uso%TYPE,
		  sn_cod_retorno  OUT NOCOPY      ge_errores_pg.coderror,
      	  sv_mens_retorno OUT NOCOPY      ge_errores_pg.msgerror,
      	  sn_num_evento   OUT NOCOPY      ge_errores_pg.evento
)
RETURN BOOLEAN IS

v_rowid    ROWID;
lv_ssql    VARCHAR2 (1000);


    BEGIN

   	    sn_cod_retorno  := 0;
	    sv_mens_retorno := '';
	    sn_num_evento   := 0;

		lv_ssql := 'SELECT ROWID ';
		lv_ssql := lv_ssql || 'FROM   ga_reserva ';
		lv_ssql := lv_ssql || 'WHERE  num_celular  = '||vp_celular||' ';
		lv_ssql := lv_ssql || 'AND	  cod_uso      = '||vp_uso||' ';
		lv_ssql := lv_ssql || 'FOR UPDATE OF num_celular NOWAIT ';

		SELECT ROWID
		INTO   v_rowid
		FROM   ga_reserva
		WHERE  num_celular  = vp_celular
		AND	   cod_uso      = vp_uso
		FOR UPDATE OF num_celular NOWAIT;

		lv_ssql := 'INSERT INTO ga_hreserva (cod_cliente, cod_vendedor, origen, fec_reserva, num_celular,cod_subalm, cod_producto, ';
		lv_ssql := lv_ssql || 'cod_central, cod_cat, cod_uso, fec_baja,ind_equipado, uso_anterior,fecha_desreserva, causal_desreserva, nom_usuarora) ';
		lv_ssql := lv_ssql || 'SELECT cod_cliente, cod_vendedor, origen, fec_reserva, num_celular, cod_subalm, cod_producto, ';
		lv_ssql := lv_ssql || 'cod_central, cod_cat, cod_uso, fec_baja,ind_equipado, uso_anterior, '||SYSDATE||','|| cn_uno||','||USER||' ';
		lv_ssql := lv_ssql || 'FROM ga_reserva ';
		lv_ssql := lv_ssql || 'WHERE ROWID = v_rowid ';

		INSERT INTO ga_hreserva (cod_cliente, cod_vendedor, origen, fec_reserva, num_celular,cod_subalm, cod_producto,
		cod_central, cod_cat, cod_uso, fec_baja,ind_equipado, uso_anterior,fecha_desreserva, causal_desreserva, nom_usuarora)
		SELECT cod_cliente, cod_vendedor, origen, fec_reserva, num_celular, cod_subalm, cod_producto,
		cod_central, cod_cat, cod_uso, fec_baja,ind_equipado, uso_anterior, SYSDATE, cn_uno,USER
		FROM ga_reserva
		WHERE ROWID = v_rowid;

		lv_ssql := 'DELETE ga_reserva WHERE ROWID = v_rowid ';

		DELETE ga_reserva WHERE ROWID = v_rowid;

		RETURN TRUE;

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
		     sn_cod_retorno := 12497;
         	 sv_mens_retorno:='Numero asignado por otro usuario';
		 	 sn_num_evento 	:= ge_errores_pg.grabarpl (sn_num_evento, cv_modulo, sv_mens_retorno, cv_version || '.' || cv_subversion, USER, 'P_NUMERACION_PG.P_VALIDA_GA_RESERVA_PR', lv_ssql, SQLCODE, SQLERRM);
			 RETURN FALSE;

		WHEN OTHERS THEN
		     IF SQLCODE = -54 THEN
		        sn_cod_retorno := 12498;
         	 	sv_mens_retorno:='Numero se encuentra bloquedo temporalmente';
		 	 	sn_num_evento  := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo, sv_mens_retorno, cv_version || '.' || cv_subversion, USER, 'P_NUMERACION_PG.P_VALIDA_GA_RESERVA_PR', lv_ssql, SQLCODE, SQLERRM);
				RETURN FALSE;
		     ELSE
		        sn_cod_retorno := 12499;
         	 	sv_mens_retorno:='Error en el proceso';
		 	 	sn_num_evento  := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo, sv_mens_retorno, cv_version || '.' || cv_subversion, USER, 'P_NUMERACION_PG.P_VALIDA_GA_RESERVA_PR', lv_ssql, SQLCODE, SQLERRM);
				RETURN FALSE;
		     END IF;
END p_valida_ga_reserva_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION p_valida_celnum_uso_fn (
		  vp_celular  	  IN ga_celnum_uso.num_desde%TYPE,
		  vp_uso	  	  IN ga_celnum_uso.cod_uso%TYPE,
		  vp_subalm		  IN ga_celnum_uso.cod_subalm%TYPE,
		  vp_central	  IN ga_celnum_uso.cod_central%TYPE,
		  vp_cat		  IN ga_celnum_uso.cod_cat%TYPE,
		  sn_cod_retorno  OUT NOCOPY      ge_errores_pg.coderror,
      	  sv_mens_retorno OUT NOCOPY      ge_errores_pg.msgerror,
      	  sn_num_evento   OUT NOCOPY      ge_errores_pg.evento
)
RETURN BOOLEAN IS

v_num_des  ga_celnum_uso.num_desde%TYPE;
v_num_has  ga_celnum_uso.num_hasta%TYPE;
v_num_sig  ga_celnum_uso.num_siguiente%TYPE;
v_rowid    rowid;
lv_ssql    VARCHAR2 (1000);

BEGIN

	sn_cod_retorno  := 0;
    sv_mens_retorno := '';
    sn_num_evento   := 0;

    BEGIN

		lv_ssql := 'SELECT num_desde,num_hasta,num_siguiente,ROWID ';
		lv_ssql := lv_ssql || 'FROM   ga_celnum_uso ';
		lv_ssql := lv_ssql || 'WHERE  cod_subalm  = '||vp_subalm||' ';
		lv_ssql := lv_ssql || 'AND    cod_central = '||vp_central||' ';
		lv_ssql := lv_ssql || 'AND    cod_cat     = '||vp_cat||' ';
		lv_ssql := lv_ssql || 'AND    cod_uso     = '||vp_uso||' ';
		lv_ssql := lv_ssql || 'AND    num_libres  > '||cn_cero ||' ';
		lv_ssql := lv_ssql || 'AND    '||vp_celular||' BETWEEN num_siguiente AND num_hasta ';
		lv_ssql := lv_ssql || 'FOR UPDATE OF num_siguiente NOWAIT ';

		SELECT num_desde,num_hasta,num_siguiente,ROWID
		INTO   v_num_des,v_num_has,v_num_sig,v_rowid
		FROM   ga_celnum_uso
		WHERE  cod_subalm  = vp_subalm
		AND    cod_central = vp_central
		AND    cod_cat     = vp_cat
		AND    cod_uso     = vp_uso
		AND    num_libres  > cn_cero
		AND    vp_celular BETWEEN num_siguiente AND num_hasta
		FOR UPDATE OF num_siguiente NOWAIT;

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
		     sn_cod_retorno := 12497;
         	 sv_mens_retorno:='Numero asignado por otro usuario';
		 	 sn_num_evento 	:= ge_errores_pg.grabarpl (sn_num_evento, cv_modulo, sv_mens_retorno, cv_version || '.' || cv_subversion, USER, 'P_NUMERACION_PG.P_VALIDA_CELNUM_USO_PR', lv_ssql, SQLCODE, SQLERRM);
			 RETURN FALSE;

		WHEN OTHERS THEN
		     IF SQLCODE = -54 THEN
		        sn_cod_retorno := 12498;
         	 	sv_mens_retorno:='Numero se encuentra bloquedo temporalmente';
		 	 	sn_num_evento  := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo, sv_mens_retorno, cv_version || '.' || cv_subversion, USER, 'P_NUMERACION_PG.P_VALIDA_CELNUM_USO_PR', lv_ssql, SQLCODE, SQLERRM);
				RETURN FALSE;
		     ELSE
		        sn_cod_retorno := 12499;
         	 	sv_mens_retorno:='Error en el proceso';
		 	 	sn_num_evento  := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo, sv_mens_retorno, cv_version || '.' || cv_subversion, USER, 'P_NUMERACION_PG.P_VALIDA_CELNUM_USO_PR', lv_ssql, SQLCODE, SQLERRM);
				RETURN FALSE;
		     END IF;
	END;

	  BEGIN

         IF vp_celular = v_num_sig THEN
            IF vp_celular = v_num_has THEN
			   lv_ssql := 'UPDATE ga_celnum_uso ';
	           lv_ssql := lv_ssql || 'SET num_libres  = num_libres - '||cn_uno||' ';
	           lv_ssql := lv_ssql || 'WHERE ROWID = v_rowid ';

               UPDATE ga_celnum_uso
                  SET num_libres  = num_libres - cn_uno
                WHERE ROWID = v_rowid;
            ELSE
			   lv_ssql := 'UPDATE ga_celnum_uso';
               lv_ssql := lv_ssql || 'SET num_siguiente = num_siguiente + '||cn_uno||', ';
			   lv_ssql := lv_ssql || 'num_libres    = num_libres - '||cn_uno||' ';
               lv_ssql := lv_ssql || 'WHERE ROWID = v_rowid ';

               UPDATE ga_celnum_uso
                  SET num_siguiente = num_siguiente + cn_uno,
                      num_libres    = num_libres - cn_uno
                WHERE ROWID = v_rowid;
            END IF;
         ELSIF  vp_celular = v_num_has THEN

			lv_ssql := 'UPDATE ga_celnum_uso';
            lv_ssql := lv_ssql || 'SET num_hasta  = num_hasta - '||cn_uno||', ';
            lv_ssql := lv_ssql || 'num_libres = num_libres - '||cn_uno||' ';
            lv_ssql := lv_ssql || 'WHERE ROWID = v_rowid ';

			UPDATE ga_celnum_uso
               SET num_hasta  = num_hasta - cn_uno,
                   num_libres = num_libres - cn_uno
            WHERE ROWID = v_rowid;

			lv_ssql := 'INSERT INTO ga_celnum_uso ';
            lv_ssql := lv_ssql || '(num_desde,num_hasta,cod_subalm,cod_producto,cod_central,cod_cat,cod_uso,num_libres,num_siguiente) ';
            lv_ssql := lv_ssql || 'VALUES ('||vp_celular||','||vp_celular||','||vp_subalm||','||cn_uno||','||vp_central||','||vp_cat||','||vp_uso||','||cn_cero||','||vp_celular||') ';

            INSERT INTO ga_celnum_uso
                   (num_desde,num_hasta,cod_subalm,cod_producto,cod_central,cod_cat,cod_uso,num_libres,num_siguiente)
            VALUES (vp_celular,vp_celular,vp_subalm,cn_uno,vp_central,vp_cat,vp_uso,cn_cero,vp_celular);
         ELSE

			lv_ssql := 'UPDATE ga_celnum_uso ';
            lv_ssql := lv_ssql || 'SET num_hasta ='||vp_celular||' - '||cn_uno||', ';
            lv_ssql := lv_ssql || 'num_libres = (('||vp_celular||' - '||cn_uno||') - num_siguiente) + '||cn_uno||' ';
            lv_ssql := lv_ssql || 'WHERE ROWID = v_rowid ';

            UPDATE ga_celnum_uso
               SET num_hasta = vp_celular - cn_uno,
                   num_libres = ((vp_celular - cn_uno) - num_siguiente) + cn_uno
             WHERE ROWID = v_rowid;

			lv_ssql := 'INSERT INTO  ga_celnum_uso ';
            lv_ssql := lv_ssql || '(num_desde,num_hasta,cod_subalm,cod_producto,cod_central,cod_cat,cod_uso,num_libres,num_siguiente) ';
            lv_ssql := lv_ssql || 'VALUES  ('||vp_celular||','||vp_celular||','||vp_subalm||','||cn_uno||','||vp_central||','||vp_cat||','||vp_uso||','||cn_cero||','||vp_celular||') ';

			INSERT INTO  ga_celnum_uso
                   (num_desde,num_hasta,cod_subalm,cod_producto,cod_central,cod_cat,cod_uso,num_libres,num_siguiente)
            VALUES  (vp_celular,vp_celular,vp_subalm,cn_uno,vp_central,vp_cat,vp_uso,cn_cero,vp_celular);

			lv_ssql := 'INSERT INTO  ga_celnum_uso(num_desde,num_hasta,cod_subalm,cod_producto,cod_central,cod_cat,cod_uso,num_libres, num_siguiente) ';
            lv_ssql := lv_ssql || 'VALUES ('||vp_celular||' + '||cn_uno||','||v_num_has||','||vp_subalm||','||cn_uno||','||vp_central||', ';
			lv_ssql := lv_ssql || ''||vp_cat||','||vp_uso||',('||v_num_has||' - ('||vp_celular||' + '||cn_uno||')) + '||cn_uno||','||vp_celular||' + '||cn_uno||') ';

			INSERT INTO  ga_celnum_uso(num_desde,num_hasta,cod_subalm,cod_producto,cod_central,cod_cat,cod_uso,num_libres, num_siguiente)
            VALUES (vp_celular + cn_uno,v_num_has,vp_subalm,cn_uno,vp_central,vp_cat,vp_uso,(v_num_has - (vp_celular + cn_uno)) + cn_uno,vp_celular + cn_uno);
         END IF;

		 RETURN TRUE;
      EXCEPTION
          WHEN OTHERS THEN
               sn_cod_retorno := 12499;
         	   sv_mens_retorno:='Error en el proceso';
		 	   sn_num_evento  := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo, sv_mens_retorno, cv_version || '.' || cv_subversion, USER, 'P_NUMERACION_PG.P_VALIDA_CELNUM_USO_PR', lv_ssql, SQLCODE, SQLERRM);
			   RETURN FALSE;
    END;
END p_valida_celnum_uso_fn;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION  p_valida_celnum_reutil_fn (
		  vp_celular  	  IN ga_celnum_reutil.num_celular%TYPE,
		  vp_subalm	  	  IN ga_celnum_reutil.cod_subalm%TYPE,
		  vp_central  	  IN ga_celnum_reutil.cod_central%TYPE,
		  vp_cat	  	  IN ga_celnum_reutil.cod_cat%TYPE,
		  vp_uso	  	  IN ga_celnum_reutil.cod_uso%TYPE,
		  sn_cod_retorno  OUT NOCOPY      ge_errores_pg.coderror,
      	  sv_mens_retorno OUT NOCOPY      ge_errores_pg.msgerror,
      	  sn_num_evento   OUT NOCOPY      ge_errores_pg.evento
)
RETURN BOOLEAN IS

v_rowid    ROWID;
lv_ssql    VARCHAR2 (1000);

	BEGIN

		sn_cod_retorno  := 0;
		sv_mens_retorno := '';
		sn_num_evento   := 0;

		lv_ssql := 'SELECT a.rowid ';
		lv_ssql := lv_ssql || 'FROM   ga_celnum_reutil a, al_usos b ';
		lv_ssql := lv_ssql || 'WHERE  num_celular  = '||vp_celular||' ';
		lv_ssql := lv_ssql || 'AND    cod_subalm   = '||vp_subalm||' ';
		lv_ssql := lv_ssql || 'AND    cod_central  = '||vp_central||' ';
		lv_ssql := lv_ssql || 'AND	  cod_cat      = '||vp_cat||' ';
		lv_ssql := lv_ssql || 'AND    uso_anterior = '||vp_uso||' ';
		lv_ssql := lv_ssql || 'AND    a.cod_uso    = b.cod_uso ';
		lv_ssql := lv_ssql || 'AND    ind_equipado = '||cn_uno||' ';
		lv_ssql := lv_ssql || 'AND    fec_baja + b.num_dias_hibernacion <= SYSDATE ';
		lv_ssql := lv_ssql || 'FOR UPDATE OF  num_celular NOWAIT ';

		SELECT a.ROWID
		INTO   v_rowid
		FROM   ga_celnum_reutil a, al_usos b
		WHERE  num_celular  = vp_celular
		AND    cod_subalm   = vp_subalm
		AND    cod_central  = vp_central
		AND	   cod_cat      = vp_cat
		AND    uso_anterior = vp_uso
		AND    a.cod_uso    = b.cod_uso
		AND    ind_equipado = cn_uno
		AND    fec_baja + b.num_dias_hibernacion <= SYSDATE
		FOR UPDATE OF  num_celular NOWAIT;

		lv_ssql := 'DELETE ga_celnum_reutil WHERE ROWID = v_rowid ';

		DELETE ga_celnum_reutil WHERE ROWID = v_rowid;

		RETURN TRUE;

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
		     sn_cod_retorno := 12497;
         	 sv_mens_retorno:='Numero asignado por otro usuario';
		 	 sn_num_evento 	:= ge_errores_pg.grabarpl (sn_num_evento, cv_modulo, sv_mens_retorno, cv_version || '.' || cv_subversion, USER, 'P_NUMERACION_PG.P_VALIDA_CELNUM_REUTIL_FN', lv_ssql, SQLCODE, SQLERRM);
			 RETURN FALSE;
		WHEN OTHERS THEN
		     IF SQLCODE = -54 THEN
		        sn_cod_retorno := 12498;
         	 	sv_mens_retorno:='Numero se encuentra bloquedo temporalmente';
		 	 	sn_num_evento  := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo, sv_mens_retorno, cv_version || '.' || cv_subversion, USER, 'P_NUMERACION_PG.P_VALIDA_CELNUM_REUTIL_FN', lv_ssql, SQLCODE, SQLERRM);
				RETURN FALSE;
		     ELSE
		        sn_cod_retorno := 12499;
         	 	sv_mens_retorno:='Error en el proceso';
		 	 	sn_num_evento  := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo, sv_mens_retorno, cv_version || '.' || cv_subversion, USER, 'P_NUMERACION_PG.P_VALIDA_CELNUM_REUTIL_FN', lv_ssql, SQLCODE, SQLERRM);
				RETURN FALSE;
		     END IF;
END p_valida_celnum_reutil_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


PROCEDURE p_numeracion_manual_pr (
  		  vp_tabla 	 	  IN varchar2 ,
  		  vp_subalm  	  IN varchar2 ,
  		  vp_central 	  IN varchar2 ,
  		  vp_cat 	 	  IN varchar2 ,
  		  vp_uso 	 	  IN varchar2 ,
  		  vp_celular 	  IN varchar2 ,
		  sn_cod_retorno  OUT NOCOPY  ge_errores_pg.coderror,
      	  sv_mens_retorno OUT NOCOPY  ge_errores_pg.msgerror,
      	  sn_num_evento   OUT NOCOPY  ge_errores_pg.evento
)IS

error_controlado  EXCEPTION;
lv_ssql           ge_errores_pg.vquery;
lv_des_error      ge_errores_pg.desevent;


	BEGIN
		  sn_cod_retorno  := 0;
	      sv_mens_retorno := '';
	      sn_num_evento   := 0;


		  IF vp_tabla = 'R' THEN
		  	 lv_ssql := 'p_valida_celnum_reutil_fn ('||vp_celular||','||vp_subalm||','||vp_central||','||vp_cat||','||vp_uso||','||sn_cod_retorno||','||sv_mens_retorno||','||sn_num_evento||')';
		  	 IF NOT p_valida_celnum_reutil_fn (vp_celular,vp_subalm,vp_central,vp_cat,vp_uso,sn_cod_retorno,sv_mens_retorno,sn_num_evento) THEN
			 	RAISE error_controlado;
			 END IF;
		  ELSIF vp_tabla = 'S' THEN
		  	 lv_ssql := 'p_valida_ga_reserva_fn ('||vp_celular||','||vp_uso||','||sn_cod_retorno||','||sv_mens_retorno||','||sn_num_evento||')';
			 IF NOT p_valida_ga_reserva_fn (vp_celular,vp_uso,sn_cod_retorno,sv_mens_retorno,sn_num_evento) THEN
			 	RAISE error_controlado;
			 END IF;
		  ELSE
		     lv_ssql := 'p_valida_celnum_uso_fn ('||vp_celular||','||vp_uso||','||vp_subalm||','||vp_central||','||vp_cat||','||sn_cod_retorno||','||sv_mens_retorno||','||sn_num_evento||')';
		     IF NOT p_valida_celnum_uso_fn (vp_celular,vp_uso,vp_subalm,vp_central,vp_cat,sn_cod_retorno,sv_mens_retorno,sn_num_evento) THEN
			 	RAISE error_controlado;
			 END IF;
		  END IF;

	EXCEPTION
	      WHEN error_controlado THEN
	         lv_des_error := 'P_NUMERACION_PG.P_NUMERACION_MANUAL_PR' || '); - ' || lv_ssql;
	         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo, sv_mens_retorno, cv_version || '.' || cv_subversion, USER, 'P_NUMERACION_PG.P_NUMERACION_MANUAL_PR', lv_ssql, SQLCODE, SQLERRM);

END p_numeracion_manual_pr;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE p_numeracion_automatica_pr(
		  vp_actabo 	   IN varchar2 ,
		  vp_subalm 	   IN varchar2 ,
		  vp_central 	   IN varchar2 ,
		  vp_uso 		   IN varchar2 ,
		  vp_celular	   OUT NOCOPY  ga_abocel.num_celular%TYPE,
		  vp_cat 		   OUT NOCOPY  ga_celnum_uso.cod_cat%TYPE,
		  vp_fecbaja 	   OUT NOCOPY  DATE,
		  vp_tipocelular   OUT NOCOPY  VARCHAR2,
		  sn_cod_retorno   OUT NOCOPY  ge_errores_pg.coderror,
      	  sv_mens_retorno  OUT NOCOPY  ge_errores_pg.msgerror,
      	  sn_num_evento    OUT NOCOPY  ge_errores_pg.evento
)IS

error_controlado  EXCEPTION;
lv_ssql           ge_errores_pg.vquery;
lv_des_error      ge_errores_pg.desevent;


	BEGIN
		 sn_cod_retorno  := 0;
	     sv_mens_retorno := '';
	     sn_num_evento   := 0;

		 lv_ssql :='p_selec_reutilizables_fn ('||vp_actabo||','||vp_subalm||','||vp_central||','||vp_uso||','||vp_celular||','||vp_cat||','||vp_fecbaja||','||sn_cod_retorno||','||sv_mens_retorno||','||sn_num_evento||')';

		 vp_tipocelular := 'R';
		 
		 IF NOT p_selec_reutilizables_fn (vp_actabo,vp_subalm,vp_central,vp_uso,vp_celular,vp_cat,vp_fecbaja,sn_cod_retorno,sv_mens_retorno,sn_num_evento) THEN
		 	lv_ssql :='p_selec_rangos_fn ('||vp_actabo||','||vp_subalm||','||vp_central||','||vp_uso||','||vp_celular||','||vp_cat||','||sn_cod_retorno||','||sv_mens_retorno||','||sn_num_evento||')';
			vp_tipocelular := 'L';
			IF NOT  p_selec_rangos_fn (vp_actabo,vp_subalm,vp_central,vp_uso,vp_celular,vp_cat,sn_cod_retorno,sv_mens_retorno,sn_num_evento) THEN
			   RAISE error_controlado;
			END IF;
		 END IF;

EXCEPTION
	      WHEN error_controlado THEN
	         lv_des_error := 'P_NUMERACION_PG.P_NUMERACION_MANUAL_PR' || '); - ' || lv_ssql;
	         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo, sv_mens_retorno, cv_version || '.' || cv_subversion, USER, 'P_NUMERACION_PG.P_NUMERACION_AUTOMATICA_PR', lv_ssql, SQLCODE, SQLERRM);

END p_numeracion_automatica_pr;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END ve_numeracion_quiosco_pg;
/

SHOW ERRORS
