CREATE OR REPLACE PROCEDURE Pv_Pr_Suspension (
   n_num_abonado    IN       NUMBER, -- Número de Abonado
   v_nom_usuarora   IN       VARCHAR2, -- Usuario Responsable
   n_cod_error      OUT  NOCOPY    NUMBER, -- Código de Error   --XO-200509030583: German Espinoza Z; 11/09/2005
   s_men_error      OUT  NOCOPY    VARCHAR2 -- Mensaje de Error --XO-200509030583: German Espinoza Z; 11/09/2005
)
IS
   s_ooss            VARCHAR (32);
   i_n               INTEGER;
   v_tip_seleccion   gad_causas_ooss.tip_seleccion%TYPE;
   v_cod_causa       gad_causas_ooss.cod_causa%TYPE;
   i_stmt            INTEGER; -- indica donde ocurre un error
   v_msj             VARCHAR (255); -- mensaje de error
   v_nom_proc        ga_errores.nom_proc%TYPE             := 'pv_pr_suspension'; -- nombre de proc
   v_nom_tabla       ga_errores.nom_tabla%TYPE;
   v_cod_act         ga_errores.cod_act%TYPE;
   v_cod_sqlcode     ga_errores.cod_sqlcode%TYPE;
   v_cod_sqlerrm     ga_errores.cod_sqlerrm%TYPE;
   error_proceso     EXCEPTION;

   FUNCTION fn_validaciones (n_num_abonado NUMBER)
      RETURN BOOLEAN
   IS
      v_nn           INTEGER;
      exp_invalido   EXCEPTION;
   BEGIN
      /*
         Pv_Pr_Ejecuta_Restriccion
         PV_PR_EJECUTA_RESTRICCION('6177','GA','1','ST','','|PSU|1||ST|504749|405276|OSF|508846|10090||');
      */
      /* verifico si existe suspencion programada */
      SELECT COUNT(1)--SELECT COUNT (*) XO-200509030583: German Espinoza Z; 11/09/2005
        INTO v_nn
        FROM ga_petsr
       WHERE num_abonado = n_num_abonado;

      IF v_nn > 0
      THEN
         RAISE exp_invalido;
      END IF;

      /* verifico si existe suspencion pendiente */
      SELECT COUNT (1) --SELECT COUNT (*) XO-200509030583: German Espinoza Z; 11/09/2005
        INTO v_nn
        FROM icc_movimiento
       WHERE num_abonado = n_num_abonado
         AND cod_actabo = 'ST'
         AND cod_modulo = 'GA';

      IF v_nn > 0
      THEN
         RAISE exp_invalido;
      END IF;

      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN FALSE;
   END;

   /* Inserta ooss */
   FUNCTION fn_insertar_ooss (n_num_abonado NUMBER, s_nooss VARCHAR)
      RETURN BOOLEAN
   IS
      n_numooss        INTEGER;
      v_descripcion    ci_tiporserv.descripcion%TYPE;
      v_tip_procesa    ci_tiporserv.tip_procesa%TYPE;
      v_cod_modgener   ci_tiporserv.cod_modgener%TYPE;
      v_cod_aplic      ci_tiporserv.cod_aplic%TYPE;
      v_des_estadoc    fa_intestadoc.des_estadoc%TYPE;
      v_cod_causa      gad_causas_ooss.cod_causa%TYPE;
      rw_ga_abocel      ga_abocel%ROWTYPE; -- registro ga_abocel

	  rw_ga_aboamist    ga_aboamist%ROWTYPE;  		      --XO-200509030583: German Espinoza Z; 11/09/2005
	  LN_CodServ		pv_param_abocel.cod_servicio%TYPE;--XO-200509030583: German Espinoza Z; 11/09/2005
	  LV_NomParametro	ged_parametros.nom_parametro%TYPE;--XO-200509030583: German Espinoza Z; 11/09/2005
	  LV_TipAbonado		VARCHAR2(2);--XO-200509030583: German Espinoza Z; 11/09/2005

   BEGIN
      /* numero de orden de servicio */
      SELECT ci_seq_numos.NEXTVAL
        INTO n_numooss
        FROM DUAL;
      /* INSERTAR OOSS*/
      /* OBTENIENDO DATOS DESDE CI_TIPORSERV DE LA OOSS */
      SELECT descripcion, tip_procesa, cod_modgener, cod_aplic
        INTO v_descripcion, v_tip_procesa, v_cod_modgener, v_cod_aplic
        FROM ci_tiporserv
       WHERE cod_os = s_nooss;

      INSERT INTO pv_iorserv
                  (num_os, cod_os, num_ospadre, descripcion, fecha_ing,
                   producto, usuario, status, tip_procesa, fh_ejecucion,
                   cod_estado, cod_modgener, num_osf, tip_subsujeto,
                   tip_sujeto, path_file, nfile)
           VALUES (n_numooss, s_nooss, NULL, v_descripcion, SYSDATE,
                   1, USER, 'en proceso', v_tip_procesa, SYSDATE,
                   10, v_cod_modgener, 0, '',
                   'A', '', '');

      /* OBTENIENDO DESCRIPCION DESDE FA_INTESTADOC */
      SELECT des_estadoc
        INTO v_des_estadoc
        FROM fa_intestadoc
       WHERE cod_aplic = v_cod_aplic -- 'PVA'
         AND cod_estadoc = 10;

      INSERT INTO pv_erecorrido
                  (num_os, cod_estado, descripcion, tip_estado,
                   fec_ingestado)
           VALUES (n_numooss, 10, v_des_estadoc, 1,
                   SYSDATE);

      INSERT INTO pv_movimientos
                  (num_os, ord_comando, cod_actabo, ind_estado)
           VALUES (n_numooss, 1, 'ST', '3');

	  --XO-200509030583: German Espinoza Z; 11/09/2005
	  /*SELECT *
        INTO rw_ga_abocel
        FROM ga_abocel
       WHERE num_abonado = n_num_abonado;*/

	  BEGIN
	      SELECT *
          INTO rw_ga_abocel
          FROM ga_abocel
          WHERE num_abonado = n_num_abonado;

		  LV_TipAbonado:='PO';

	  EXCEPTION
	  	  WHEN NO_DATA_FOUND THEN
		  	 SELECT *
	         INTO rw_ga_aboamist
	         FROM ga_aboamist
	         WHERE num_abonado = n_num_abonado;

			 LV_TipAbonado:='PP';
	  END;

      /* PARAMETROS */
      /*INSERT INTO pv_camcom
                  (num_os, num_abonado, num_celular, cod_cliente,
                   cod_cuenta, cod_producto, bdatos, num_venta,
                   num_transaccion, num_folio, num_cuotas, num_proceso,
                   cod_actabo, fh_anula, cat_tribut, cod_estadoc,
                   cod_causaelim, fec_vencimiento, clase_servicio_act,
                   clase_servicio_des, ind_central_ss, ind_portable)
           VALUES (n_numooss, n_num_abonado, rw_ga_abocel.num_celular, rw_ga_abocel.cod_cliente,
                   rw_ga_abocel.cod_cuenta, 1, '______', NULL,
                   NULL, NULL, NULL, 0,
                   'ST', NULL, NULL, 0,
                   NULL, NULL, NULL,
                   NULL, NULL, 0);*/

	  IF LV_TipAbonado='PO' THEN
		  INSERT INTO pv_camcom
	                  (num_os, num_abonado, num_celular, cod_cliente,
	                   cod_cuenta, cod_producto, bdatos, num_venta,
	                   num_transaccion, num_folio, num_cuotas, num_proceso,
	                   cod_actabo, fh_anula, cat_tribut, cod_estadoc,
	                   cod_causaelim, fec_vencimiento, clase_servicio_act,
	                   clase_servicio_des, ind_central_ss, ind_portable)
	           VALUES (n_numooss, n_num_abonado, rw_ga_abocel.num_celular, rw_ga_abocel.cod_cliente,
	                   rw_ga_abocel.cod_cuenta, 1, '______', NULL,
	                   NULL, NULL, NULL, 0,
	                   'ST', NULL, NULL, 0,
	                   NULL, NULL, NULL,
	                   NULL, NULL, 0);
	  ELSIF LV_TipAbonado='PP' THEN
	  		INSERT INTO pv_camcom
	                  (num_os, num_abonado, num_celular, cod_cliente,
	                   cod_cuenta, cod_producto, bdatos, num_venta,
	                   num_transaccion, num_folio, num_cuotas, num_proceso,
	                   cod_actabo, fh_anula, cat_tribut, cod_estadoc,
	                   cod_causaelim, fec_vencimiento, clase_servicio_act,
	                   clase_servicio_des, ind_central_ss, ind_portable)
	           VALUES (n_numooss, n_num_abonado, rw_ga_aboamist.num_celular, rw_ga_aboamist.cod_cliente,
	                   rw_ga_aboamist.cod_cuenta, 1, '______', NULL,
	                   NULL, NULL, NULL, 0,
	                   'ST', NULL, NULL, 0,
	                   NULL, NULL, NULL,
	                   NULL, NULL, 0);
	  END IF;

      --FIN/XO-200509030583: German Espinoza Z; 11/09/2005

	  /* codigo de causa de suspencion */
      SELECT cod_causa
        INTO v_cod_causa
        FROM gad_causas_ooss
       WHERE cod_os = s_ooss
         AND nom_tabla = 'GA_CAUSUSP'
         AND SYSDATE BETWEEN fec_desde AND fec_hasta;

	  --XO-200509030583: German Espinoza Z; 11/09/2005
	  IF rw_ga_abocel.cod_tecnologia='GSM' OR rw_ga_aboamist.cod_tecnologia='GSM' OR rw_ga_abocel.cod_tecnologia='FIJO' OR rw_ga_aboamist.cod_tecnologia='FIJO'  THEN
	  	 LV_NomParametro:='COD_SERVSUSPT_GSM';
	  ELSIF (rw_ga_abocel.cod_tecnologia='TDMA' OR rw_ga_abocel.cod_tecnologia='CDMA') OR (rw_ga_aboamist.cod_tecnologia='TDMA' OR rw_ga_aboamist.cod_tecnologia='CDMA') THEN
	  	 LV_NomParametro:='COD_SERV_SUSPT';
	  END IF;

	  SELECT val_parametro
	  INTO  LN_CodServ
	  FROM ged_parametros
	  WHERE nom_parametro=LV_NomParametro
	  AND cod_modulo='GA'
	  AND cod_producto=1;

      /* parametros especiales */
      /*INSERT INTO pv_param_abocel
                  (num_os, num_abonado, cod_tipmodi, fec_modifica,
                   nuom_usuarora, num_celular, tip_plantarif, tip_terminal,
                   cod_plantarif, num_seriehex, cod_ciclo, cod_causa,
                   cod_servicio)
           VALUES (n_numooss, n_num_abonado, 'ST', SYSDATE,
                   USER, rw_ga_abocel.num_celular, rw_ga_abocel.tip_plantarif, rw_ga_abocel.tip_terminal,
                   rw_ga_abocel.cod_plantarif, rw_ga_abocel.num_seriehex, rw_ga_abocel.cod_ciclo, v_cod_causa,
                   '59');*/

	  IF LV_TipAbonado='PO' THEN
		  INSERT INTO pv_param_abocel
	                  (num_os, num_abonado, cod_tipmodi, fec_modifica,
	                   nuom_usuarora, num_celular, tip_plantarif, tip_terminal,
	                   cod_plantarif, num_seriehex, cod_ciclo, cod_causa,
	                   cod_servicio)
	           VALUES (n_numooss, n_num_abonado, 'ST', SYSDATE,
	                   USER, rw_ga_abocel.num_celular, rw_ga_abocel.tip_plantarif, rw_ga_abocel.tip_terminal,
	                   rw_ga_abocel.cod_plantarif, rw_ga_abocel.num_seriehex, rw_ga_abocel.cod_ciclo, v_cod_causa,
	                   LN_CodServ);
	  ELSIF LV_TipAbonado='PP' THEN
	  	  INSERT INTO pv_param_abocel
	                  (num_os, num_abonado, cod_tipmodi, fec_modifica,
	                   nuom_usuarora, num_celular, tip_plantarif, tip_terminal,
	                   cod_plantarif, num_seriehex, cod_ciclo, cod_causa,
	                   cod_servicio)
	           VALUES (n_numooss, n_num_abonado, 'ST', SYSDATE,
	                   USER, rw_ga_aboamist.num_celular, rw_ga_aboamist.tip_plantarif, rw_ga_aboamist.tip_terminal,
	                   rw_ga_aboamist.cod_plantarif, rw_ga_aboamist.num_seriehex, rw_ga_aboamist.cod_ciclo, v_cod_causa,
	                   LN_CodServ);
	  END IF;
      --FIN/XO-200509030583: German Espinoza Z; 11/09/2005

      /* ACTUALIZA ESTADO DE OOSS inicial en PV_IORSERV */
      UPDATE pv_iorserv
         SET status = 'Proceso exitoso'
       WHERE num_os = n_numooss;


/* ACTUALIZA ESTADO DE OOSS inicial en PV_ERECORRIDO */
      UPDATE pv_erecorrido
         SET cod_estado = 10,
             descripcion = v_des_estadoc,
             tip_estado = 3
       WHERE num_os = n_numooss;
           RETURN TRUE;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN FALSE;
   END;

BEGIN
   s_ooss := '10502'; -- codigo de orden de servicio
   v_cod_act := 'S';
   i_stmt := 1;
   v_msj := 'Error, verificando si hay ordenes pendientes';
   v_nom_tabla := 'GA_INTARCEL';


   --SAVEPOINT tr_suspension;

/* verifico si existen ordenes de servicio pendientes para el abonado */
   SELECT COUNT (1)--SELECT COUNT (*) XO-200509030583: German Espinoza Z; 11/09/2005
     INTO i_n
     FROM pv_iorserv e, pv_erecorrido f, pv_camcom g
    WHERE e.num_os = f.num_os
      AND e.num_os = g.num_os
      AND g.num_abonado = n_num_abonado
      AND e.cod_os = s_ooss
      AND e.num_os NOT IN (SELECT a.num_os
                             FROM pv_iorserv a,
                                  pv_erecorrido b,
                                  pv_camcom c,
                                  pv_arcos d
                            WHERE a.num_os = b.num_os
                              AND a.cod_os = s_ooss
                              AND (   a.fh_ejecucion IS NULL
                                   OR a.fh_ejecucion <= SYSDATE
                                  )
                              AND a.num_os = c.num_os
                              AND c.num_abonado = n_num_abonado
                              AND a.cod_modgener = d.cod_modgener
                              AND d.atrib_estado IN (2, 3)
                              AND d.cod_aplic = 'PVA'
                              AND b.cod_estado = d.est_final
                              AND b.tip_estado = 3
                           UNION ALL
                           SELECT a.num_os
                             FROM pv_iorserv a,
                                  pv_erecorrido b,
                                  pv_camcom c,
                                  pv_arcos d
                            WHERE a.num_os = b.num_os
                              AND a.cod_os = s_ooss
                              AND a.num_os = c.num_os
                              AND (   a.fh_ejecucion IS NULL
                                   OR a.fh_ejecucion <= SYSDATE
                                  )
                              AND c.num_abonado = n_num_abonado
                              AND a.cod_modgener = d.cod_modgener
                              AND d.atrib_estado IN (2, 3)
                              AND d.cod_aplic = 'PVA'
                              AND b.tip_estado = 4);

   IF i_n > 0
   THEN
      i_stmt := 2;
      v_msj := 'Error, existen ordenes pendientes';
      v_nom_tabla := 'GA_INTARCEL';
      RAISE error_proceso;
   END IF;

   i_stmt := 3;
   v_msj := 'Error, rescatando causa de os';
   v_nom_tabla := 'GAD_CAUSAS_OOSS';

/* codigo y vigencia de causa de orden de servicio */
   SELECT tip_seleccion, cod_causa
     INTO v_tip_seleccion, v_cod_causa
     FROM gad_causas_ooss
    WHERE cod_os = s_ooss
      AND nom_tabla = 'GA_CAUSUSP'
      AND SYSDATE BETWEEN fec_desde AND fec_hasta;


/* validaciones */
   IF NOT (fn_validaciones (n_num_abonado))
   THEN
      i_stmt := 4;
      v_msj := 'Error, abonado no valido';
      v_nom_tabla := '';
      RAISE error_proceso;
   END IF;

   i_stmt := 5;
   v_msj := 'Error, verificando suspencion total';
   v_nom_tabla := 'ga_petsr';

/* verifico que no tenga suspension total */
   SELECT COUNT (1) --SELECT COUNT (*) XO-200509030583: German Espinoza Z; 11/09/2005 --num_peticion
     INTO i_n
     FROM ga_petsr
    WHERE num_abonado = n_num_abonado
      AND tip_susp = 'T'
      AND (   SYSDATE BETWEEN fec_suspension AND NVL (fec_rehabilita, SYSDATE)
           OR TO_DATE ('01-01-3001', 'DD-MM-YYYY') BETWEEN fec_suspension
                                                       AND NVL (
                                                              fec_rehabilita,
                                                              SYSDATE
                                                           )
           OR (    SYSDATE <= fec_suspension
               AND TO_DATE ('01-01-3001', 'DD-MM-YYYY') >= fec_rehabilita
              )
          );

   IF i_n > 0
   THEN
      i_stmt := 6;
      v_msj := 'Error, abonado con suspencion total';
      v_nom_tabla := 'ga_petsr';
      RAISE error_proceso;
   END IF;


/* cargo basico no procede */

   IF NOT (fn_insertar_ooss (n_num_abonado, s_ooss))
   THEN
      i_stmt := 7;
      v_msj := 'Error, insertando OOSS';
      v_nom_tabla := '';
      RAISE error_proceso;
   END IF;
EXCEPTION
   WHEN OTHERS
   THEN
      v_cod_sqlcode := SQLCODE;
      v_cod_sqlerrm := SQLERRM;
      --ROLLBACK TO tr_suspension;
      /*
      INSERT INTO ga_errores
                  (cod_actabo, codigo, fec_error, cod_producto, nom_proc,
                   nom_tabla, cod_act, cod_sqlcode, cod_sqlerrm)
           VALUES ('RT', n_num_abonado, SYSDATE, 1, v_nom_proc,
                   v_nom_tabla, v_cod_act, v_cod_sqlcode, v_cod_sqlerrm);
      */
      --COMMIT;
      n_cod_error := i_stmt;
      s_men_error := v_msj;
END;
/
SHOW ERRORS