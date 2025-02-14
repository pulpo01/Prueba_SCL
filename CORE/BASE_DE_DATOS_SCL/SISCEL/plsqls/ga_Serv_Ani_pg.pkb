CREATE OR REPLACE PACKAGE BODY ga_Serv_Ani_pg
AS

PROCEDURE Ga_Des_Serv_Ani_pr(EN_num_abonado	IN  ga_abocel.num_abonado%TYPE,
			     EV_Servicio	IN  VARCHAR2)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "Ga_Des_Serv_Ani_pr".
      Lenguaje="PL/SQL"
      Fecha="28-12-2006"
      Versión="1.0"
      Diseñador=""German Espinoza".
      Programador="Esteban Fuenzalida".
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
     <Descripción>Procedimiento que Desactiva SS dependientes>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_abonado" Tipo="NUMERICO">Numero de Abonado</param>
			<param nom="EV_servicio" 		Tipo="CARACTER>SS dado de baja/param>
         </Entrada>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
   PRAGMA AUTONOMOUS_TRANSACTION;

   SN_cod_retorno	ge_errores_pg.coderror;
   SV_mens_retorno	ge_errores_pg.msgerror;
   SN_num_evento	ge_errores_pg.evento;


   V_DESCRIP		CI_TIPORSERV.DESCRIPCION%TYPE;
   N_TIP_PROCESA	CI_TIPORSERV.TIP_PROCESA%TYPE;
   V_COD_MODGENER	CI_TIPORSERV.COD_MODGENER%TYPE;
   N_TIP_ESTADO		PV_ERECORRIDO.TIP_ESTADO%TYPE;
   V_DES_ESTADOC	PV_ERECORRIDO.DESCRIPCION%TYPE;
   N_NUM_OS		NUMBER;
   N_NUMTRANS		NUMBER;
   V_COD_TECNOLOGIA	GA_ABOCEL.COD_TECNOLOGIA%TYPE;
   N_COD_CENTRAL	GA_ABOCEL.COD_CENTRAL%TYPE;
   V_TIP_TERMINAL	GA_ABOCEL.TIP_TERMINAL%TYPE;
   N_NUM_CELULAR	GA_ABOCEL.NUM_CELULAR%TYPE;
   N_COD_CLIENTE	GA_ABOCEL.COD_CLIENTE%TYPE;
   N_COD_CUENTA		GA_ABOCEL.COD_CUENTA%TYPE;
   N_COD_SISTEMA	ICG_CENTRAL.COD_SISTEMA%TYPE;

--Var para cadena .
   V_COD_SERVICIO	ga_servsuplabo.COD_SERVICIO%TYPE;
   V_COD_SERVSUPL	VARCHAR2(500);
   V_COD_NIVEL		VARCHAR2(500);
   V_CAD_DES		VARCHAR2(500);

   N_COUNT		NUMBER;
   V_COD_SS		PV_CAMCOM.CLASE_SERVICIO_DES%TYPE;

   LV_DES_ERROR 		GE_ERRORES_PG.DESEVENT;
   LV_SSQL        		GE_ERRORES_PG.VQUERY;

-- CUR 1 .
	CURSOR c_ss_hijos (V_COD_SERVICIO ga_servsup_def.cod_servicio%TYPE,
		   	   V_COD_SISTEMA  icg_serviciotercen.cod_sistema%TYPE,
                           V_TIP_TERMINAL icg_serviciotercen.tip_terminal%TYPE,
                           V_TIP_TECNOLOGIA icg_serviciotercen.tip_tecnologia%TYPE)
	IS
    SELECT b.cod_servsupl, b.cod_nivel, A.COD_SERVDEF
	FROM GA_SERVSUP_DEF a, ga_servsupl b, icg_serviciotercen c
	WHERE a.COD_PRODUCTO = cn_cod_producto
	AND a.tip_relacion = '1'
	AND b.tip_servicio = 1
	AND a.COD_SERVICIO = V_COD_SERVICIO
	AND SYSDATE BETWEEN a.FEC_DESDE AND NVL(a.FEC_HASTA, SYSDATE)
	AND a.cod_producto = b.cod_producto
	AND a.cod_servdef = b.cod_servicio
	AND b.cod_producto = c.cod_producto
	AND b.cod_servsupl = c.cod_servicio
	AND c.cod_sistema = V_COD_SISTEMA
	AND c.tip_terminal = V_TIP_TERMINAL
	AND c.tip_tecnologia = V_TIP_TECNOLOGIA;
-- FIN CUR1

-- CUR 2 .
	CURSOR c_ss_padres (V_COD_SERVICIO ga_servsup_def.cod_servicio%TYPE,
		   	    V_COD_SISTEMA  icg_serviciotercen.cod_sistema%TYPE,
                            V_TIP_TERMINAL icg_serviciotercen.tip_terminal%TYPE,
                            V_TIP_TECNOLOGIA icg_serviciotercen.tip_tecnologia%TYPE)
	IS
        SELECT b.cod_servsupl, b.cod_nivel, A.COD_SERVICIO
	FROM GA_SERVSUP_DEF a, ga_servsupl b, icg_serviciotercen c
	WHERE a.COD_PRODUCTO = cn_cod_producto
	AND a.tip_relacion = '1'
	AND b.tip_servicio = 1
	AND a.COD_SERVDEF = V_COD_SERVICIO
	AND SYSDATE BETWEEN a.FEC_DESDE AND NVL(a.FEC_HASTA, SYSDATE)
	AND a.cod_producto = b.cod_producto
	AND a.cod_servicio = b.cod_servicio
	AND b.cod_producto = c.cod_producto
	AND b.cod_servsupl = c.cod_servicio
	AND c.cod_sistema = V_COD_SISTEMA
	AND c.tip_terminal = V_TIP_TERMINAL
	AND c.tip_tecnologia = V_TIP_TECNOLOGIA;
-- FIN CUR2

BEGIN
        -- NUMERO DE SOLICITUD .
	SELECT CI_SEQ_NUMOS.NEXTVAL INTO N_NUM_OS FROM DUAL;

	-- NUMERO DE TRANSACCION .
	SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO N_NUMTRANS FROM DUAL;

	-- Datos del abonado.-
	SELECT COD_TECNOLOGIA,   COD_CENTRAL,   TIP_TERMINAL,  NUM_CELULAR,   COD_CLIENTE,  COD_CUENTA
	  INTO V_COD_TECNOLOGIA, N_COD_CENTRAL, V_TIP_TERMINAL, N_NUM_CELULAR, N_COD_CLIENTE, N_COD_CUENTA
	  FROM GA_ABOCEL
	 WHERE NUM_ABONADO = EN_num_abonado;

	SELECT COD_SISTEMA
	  INTO N_COD_SISTEMA
	  FROM ICG_CENTRAL
         WHERE COD_PRODUCTO = cn_cod_producto
           AND COD_CENTRAL = N_COD_CENTRAL;

	--  ******* BUSQUEDAS PRINCIPALES **************.-
	-- ciclo para buscar hijos.-
	OPEN c_ss_hijos(EV_Servicio, N_COD_SISTEMA, V_TIP_TERMINAL, V_COD_TECNOLOGIA);
           LOOP
           FETCH c_ss_hijos INTO V_COD_SERVSUPL, V_COD_NIVEL, V_COD_SERVICIO;
           EXIT WHEN c_ss_hijos%NOTFOUND;

           V_COD_SERVSUPL := SUBSTR('00' || V_COD_SERVSUPL, LENGTH('00' || V_COD_SERVSUPL) - 1, 2);
           V_COD_NIVEL := SUBSTR('0000' || V_COD_NIVEL, LENGTH('0000' || V_COD_NIVEL) - 3, 4);
           V_COD_SS := V_COD_SERVSUPL || V_COD_NIVEL;

		   -- Reviso si EL SS a dar de Baja esta de Alta.-
	 	   SELECT COUNT(1)
	 	     INTO N_COUNT
	 	     FROM GA_SERVSUPLABO
	 	    WHERE NUM_ABONADO = EN_NUM_ABONADO
	 	      AND COD_SERVICIO = V_COD_SERVICIO
	 	      AND IND_ESTADO = 2;

	       IF N_COUNT > 0 THEN
			   -- Reviso si existe OOSS de Desactivacion existente para el SS Encontrado.-
			   LV_SSQL:='SELECT COUNT(1) ';
		 	   LV_SSQL:=LV_SSQL || ' FROM PV_CAMCOM A ';
		 	   LV_SSQL:=LV_SSQL || ' WHERE NUM_ABONADO = ' || EN_NUM_ABONADO;
			   LV_SSQL:=LV_SSQL || ' AND EXISTS (SELECT 1 FROM PV_IORSERV WHERE NUM_OS = A.NUM_OS AND COD_ESTADO < 210) ';
		 	   LV_SSQL:=LV_SSQL || ' AND CLASE_SERVICIO_DES LIKE ''%' || V_COD_SS || '%''';

			   EXECUTE IMMEDIATE LV_SSQL INTO N_COUNT;

	 	       IF N_COUNT = 0 THEN
	 	           V_CAD_DES := V_CAD_DES || V_COD_SS;
	 	       END IF;
		   END IF;
           V_COD_SS := '';

       END LOOP;
       CLOSE c_ss_hijos;

       V_COD_SS := '';
	-- ciclo para buscar padres.-
	OPEN c_ss_padres(EV_Servicio, N_COD_SISTEMA, V_TIP_TERMINAL, V_COD_TECNOLOGIA);
           LOOP
           FETCH c_ss_padres INTO V_COD_SERVSUPL, V_COD_NIVEL, V_COD_SERVICIO;
           EXIT WHEN c_ss_padres%NOTFOUND;

           V_COD_SERVSUPL := SUBSTR('00' || V_COD_SERVSUPL, LENGTH('00' || V_COD_SERVSUPL) - 1, 2);
           V_COD_NIVEL := SUBSTR('0000' || V_COD_NIVEL, LENGTH('0000' || V_COD_NIVEL) - 3, 4);
	   	   V_COD_SS := V_COD_SERVSUPL || V_COD_NIVEL;

			-- Reviso si EL SS a dar de Baja esta de Alta.-
			SELECT COUNT(1)
			INTO N_COUNT
			FROM GA_SERVSUPLABO
			WHERE NUM_ABONADO = EN_NUM_ABONADO
			AND COD_SERVICIO = V_COD_SERVICIO
			AND IND_ESTADO = 2;

           IF N_COUNT > 0 THEN

			   -- Reviso si existe OOSS de Desactivacion existente para el SS Encontrado.-
			   LV_SSQL:='SELECT COUNT(1) ';
		 	   LV_SSQL:=LV_SSQL || ' FROM PV_CAMCOM A ';
		 	   LV_SSQL:=LV_SSQL || ' WHERE NUM_ABONADO = ' || EN_NUM_ABONADO;
			   LV_SSQL:=LV_SSQL || ' AND EXISTS (SELECT 1 FROM PV_IORSERV WHERE NUM_OS = A.NUM_OS AND COD_ESTADO < 210) ';
		 	   LV_SSQL:=LV_SSQL || ' AND CLASE_SERVICIO_DES LIKE ''%' || V_COD_SS || '%''';

			   EXECUTE IMMEDIATE LV_SSQL INTO N_COUNT;

	 	       IF N_COUNT = 0 THEN
	 	           V_CAD_DES := V_CAD_DES || V_COD_SS;
	 	       END IF;

		   END IF;

           V_COD_SS := '';

        END LOOP;
        CLOSE c_ss_padres;

	IF V_CAD_DES IS NOT NULL THEN

		-- ****** INGRESO DE LA OOSS DE DESACTIVACION DEL SS.- ******

		--obteniendo datos desde ci_tiporserv de la ooss .
		SELECT descripcion,  tip_procesa,   cod_modgener
		into   V_DESCRIP,    N_TIP_PROCESA, V_COD_MODGENER
		FROM ci_tiporserv WHERE cod_os = 10120;

		N_TIP_ESTADO := 3;

		INSERT INTO pv_iorserv(num_os, cod_os, num_ospadre, descripcion, fecha_ing, producto, usuario, status, tip_procesa, fh_ejecucion,
	                               cod_estado, cod_modgener, num_osf, tip_subsujeto, tip_sujeto, path_file, nfile)
			       VALUES (N_NUM_OS, '10120', NULL, V_DESCRIP, SYSDATE, cn_cod_producto,
				       USER, 'Proceso exitoso', N_TIP_PROCESA, NULL, 10, V_COD_MODGENER, 0, '', 'A', '', '');

	        -- Valores para INSERT .
		SELECT des_estadoc into V_DES_ESTADOC FROM fa_intestadoc WHERE cod_aplic = 'PVA' and cod_estadoc = 10;

		INSERT INTO pv_erecorrido(num_os, cod_estado, descripcion, tip_estado, fec_ingestado, MSG_ERROR)
					   VALUES(N_NUM_OS, 10, V_DES_ESTADOC, N_TIP_ESTADO, SYSDATE, 'OOSS INSCRITA POR JOB');

		INSERT INTO pv_movimientos(num_os, ord_comando, cod_actabo, ind_estado, carga)
				    VALUES(N_NUM_OS, 1, 'SS', '1', 0);

		INSERT INTO pv_camcom(num_os,num_abonado,num_celular,cod_cliente,cod_cuenta,cod_producto,bdatos,num_venta,num_transaccion,
	                              num_folio,num_cuotas,num_proceso,cod_actabo,fh_anula,cat_tribut,cod_estadoc,cod_causaelim,fec_vencimiento
			              ,clase_servicio_act,clase_servicio_des,ind_central_ss,ind_portable,tip_terminal,tip_susp_avsinie,pref_plaza)
			       VALUES(N_NUM_OS, EN_num_abonado ,N_NUM_CELULAR,N_COD_CLIENTE,N_COD_CUENTA,cn_cod_producto,'SCLPRECOL',NULL,N_NUMTRANS,
			              NULL,NULL,0,'SS',NULL,NULL,0,NULL,NULL,NULL, V_CAD_DES, NULL,0,V_TIP_TERMINAL,'','');

	   	--Activar Movimiento .
	   	UPDATE PV_MOVIMIENTOS SET COD_ESTADO = 0 WHERE NUM_OS = N_NUM_OS;

	        COMMIT;
	END IF;
EXCEPTION

   WHEN OTHERS THEN
      SN_cod_retorno := 100;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error := 'Ga_Des_Serv_Ani_pr('||EN_num_abonado||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno,CV_version, USER, 'ga_Serv_Ani_pg.Ga_Des_Serv_Ani_pr', LV_sSql, SN_cod_retorno, LV_des_error );
      ROLLBACK;

END Ga_Des_Serv_Ani_pr;

END ga_Serv_Ani_pg;
/
SHOW ERRORS
