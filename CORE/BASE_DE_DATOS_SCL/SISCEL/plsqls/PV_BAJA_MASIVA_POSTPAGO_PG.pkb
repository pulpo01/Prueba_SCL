CREATE OR REPLACE PACKAGE BODY PV_BAJA_MASIVA_POSTPAGO_PG IS

--PV_BAJA_MASIVA_POSTPAGO_PG v1.0 COL-63261(MA)|11-06-2008|GEZ creacion de package por MA
--PV_BAJA_MASIVA_POSTPAGO_PG v1.1 COL-63261(MA)|18-07-2008|GEZ
--PV_BAJA_MASIVA_POSTPAGO_PG v1.2 COL-63261|08-09-2008|DVG
--PV_BAJA_MASIVA_POSTPAGO_PG v1.3 COL-71027|29-09-2008|GEZ
--PV_BAJA_MASIVA_POSTPAGO_PG v1.4 71649|16-10-2008|EFR.
--PV_BAJA_MASIVA_POSTPAGO_PG v1.5 COL-75763; 15-01-2009; AVC

	FUNCTION PV_DESCERROR_FN(LECodError IN NUMBER) RETURN VARCHAR2 IS

	LBError			BOOLEAN;
	LVDescErr		VARCHAR2(2000);
	LNCodErr		NUMBER;

	BEGIN

		 LNCodErr:=LECodError;
		 LBError := MAS_GENERAL_DML.GE_ERRORES_PG.MENSAJEERROR ( LNCodErr, LVDescErr);

		 IF LBError THEN
		 	RETURN  SUBSTR(LVDescErr,1,200);
		 ELSE
		 	RETURN 'DESCRIPCION DEL ERROR '||LECodError||' NO EXISTE';
		 END IF;

	END;

	PROCEDURE PV_INICIALIZA_PROCESO_PR( LSEstado	  	  OUT	NUMBER,
									  	LSDescProceso	  OUT	pv_baja_masiva_to.desc_err%TYPE,
								  	  	LSTabla	  	  	  OUT	pv_baja_masiva_to.nom_tabla%TYPE,
								  	  	LSAccion	  	  OUT	pv_baja_masiva_to.cod_act%TYPE,
									  	LSCodOra		  OUT	pv_baja_masiva_to.cod_sqlcode%TYPE,
								  	  	LSErrOra		  OUT	pv_baja_masiva_to.cod_sqlerrm%TYPE) IS

	LNIdProceso		pv_baja_masiva_to.id_proceso%TYPE;


	BEGIN

		 LSEstado:=3;

		 LSTabla:='PV_BM_IDPROCESO_SQ.NEXTVAL';
		 LSAccion:='S';

		 SELECT pv_bm_idproceso_sq.NEXTVAL
		 INTO	LNIdProceso
		 FROM 	dual;

		 LSTabla:='PV_BAJA_MASIVA_TO';
		 LSAccion:='S';

		 UPDATE pv_baja_masiva_to
		 SET    id_proceso  = LNIdProceso
		 WHERE  id_proceso  = 0;

		 LSDescProceso	  :='0';
		 LSTabla	  	  :='0';
		 LSAccion	  	  :='0';
		 LSCodOra		  :='0';
		 LSErrOra		  :='0';

	EXCEPTION
		WHEN OTHERS THEN

			  LSCodOra		  :=SUBSTR(SQLCODE,1,15);
			  LSErrOra		  :=SUBSTR(SQLERRM,1,1000);

			  LSDescProceso := PV_DESCERROR_FN(1875);

			  LSEstado:=5;
	END;

	PROCEDURE PV_HISTORICO_PR(  LSEstado	  	  OUT	NUMBER,
								LSDescProceso	  OUT	pv_baja_masiva_to.desc_err%TYPE,
								LSCodOra		  OUT	pv_baja_masiva_to.cod_sqlcode%TYPE,
								LSErrOra		  OUT	pv_baja_masiva_to.cod_sqlerrm%TYPE) IS

	TYPE tbl_NumCelular IS TABLE OF pv_baja_masiva_to.num_celular%TYPE;

	LVNumCelular	   tbl_NumCelular;

	LNplsi             PLS_INTEGER      := 0;

	CURSOR bajamasiva IS
	SELECT num_celular
	FROM pv_baja_masiva_to;

	BEGIN

		 LSEstado:=3;

		 OPEN bajamasiva;

		 LOOP

			FETCH bajamasiva BULK COLLECT INTO LVNumCelular LIMIT 500;

		    LNplsi := LNplsi + 1;

		    FORALL LNplsi IN 1 .. LVNumCelular.COUNT
				   INSERT INTO pv_baja_masiva_th
			  	   (num_celular, id_proceso, cod_estado, fec_ingreso, cod_sqlcode, cod_sqlerrm, desc_err
				   , nom_tabla, cod_act, nom_usuario, num_os, fec_historico)
				   SELECT num_celular, id_proceso, cod_estado, fec_ingreso, cod_sqlcode, cod_sqlerrm, desc_err
				   , nom_tabla, cod_act, nom_usuario, num_os, SYSDATE
				   FROM pv_baja_masiva_to
				   WHERE num_celular =LVNumCelular(LNplsi);

			FORALL LNplsi IN 1 .. LVNumCelular.COUNT
				   DELETE pv_baja_masiva_to
				   WHERE num_celular =LVNumCelular(LNplsi);

			COMMIT;

		    EXIT WHEN bajamasiva%NOTFOUND;

		 END LOOP;

		 LSDescProceso	  :='0';
		 LSCodOra		  :='0';
		 LSErrOra		  :='0';

	EXCEPTION
		WHEN OTHERS THEN

			  LSCodOra		  :=SUBSTR(SQLCODE,1,15);
			  LSErrOra		  :=SUBSTR(SQLERRM,1,1000);

			  LSDescProceso := PV_DESCERROR_FN(1851);
			  LSEstado:=5;
	END;

	PROCEDURE PV_ACTUALIZA_ESTADO_PR( LENumCelular 	  IN	pv_baja_masiva_to.num_celular%TYPE,
			  					  	  LEIdProseso	  IN	pv_baja_masiva_to.id_proceso%TYPE,
   			 					  	  LEEstadoIni	  IN	pv_baja_masiva_to.cod_estado%TYPE,
									  LEEstadoFin	  IN	pv_baja_masiva_to.cod_estado%TYPE,
									  LSEstado	  	  OUT	NUMBER,
									  LSDescProceso	  OUT	pv_baja_masiva_to.desc_err%TYPE,
								  	  LSTabla	  	  OUT	pv_baja_masiva_to.nom_tabla%TYPE,
								  	  LSAccion	  	  OUT	pv_baja_masiva_to.cod_act%TYPE,
									  LSCodOra		  OUT	pv_baja_masiva_to.cod_sqlcode%TYPE,
								  	  LSErrOra		  OUT	pv_baja_masiva_to.cod_sqlerrm%TYPE) IS

	BEGIN

		 LSEstado:=3;

		 LSTabla:='PV_BAJA_MASIVA_TO['||LEEstadoIni||'-'||LEEstadoFin||']';
		 LSAccion:='S';

		 UPDATE pv_baja_masiva_to
		 SET    cod_estado  = LEEstadoFin
		 WHERE  num_celular = LENumCelular
		 AND	id_proceso  = LEIdProseso
		 AND	cod_estado  = LEEstadoIni;

		 LSDescProceso	  :='0';
		 LSTabla	  	  :='0';
		 LSAccion	  	  :='0';
		 LSCodOra		  :='0';
		 LSErrOra		  :='0';

	EXCEPTION
		WHEN OTHERS THEN

			  LSCodOra		  :=SUBSTR(SQLCODE,1,15);
			  LSErrOra		  :=SUBSTR(SQLERRM,1,1000);

			  LSDescProceso := PV_DESCERROR_FN(1852)||'['||LEEstadoIni||'-'||LEEstadoFin||']';
			  LSEstado:=5;
	END;

	PROCEDURE PV_ACTUALIZA_PROCESO_PR( LENumCelular   IN	pv_baja_masiva_to.num_celular%TYPE,
			  					  	   LEIdProseso	  IN	pv_baja_masiva_to.id_proceso%TYPE,
   			 					  	   LEEstadoIni	  IN	pv_baja_masiva_to.cod_estado%TYPE,
									   LEEstadoFin	  IN	pv_baja_masiva_to.cod_estado%TYPE,
									   LENumOS		  IN	pv_iorserv.num_os%TYPE,
									   LEDescProceso  IN	pv_baja_masiva_to.desc_err%TYPE,
								  	   LETabla	  	  IN	pv_baja_masiva_to.nom_tabla%TYPE,
								  	   LEAccion	  	  IN	pv_baja_masiva_to.cod_act%TYPE,
									   LECodOra		  IN	pv_baja_masiva_to.cod_sqlcode%TYPE,
								  	   LEErrOra		  IN	pv_baja_masiva_to.cod_sqlerrm%TYPE) IS

	BEGIN

		 UPDATE pv_baja_masiva_to
		 SET    cod_estado  = LEEstadoFin
		 	   ,num_os		= LENumOS
		 	   ,desc_err	= SUBSTR(LEDescProceso,1,200)
			   ,nom_tabla	= SUBSTR(LETabla,1,50)
			   ,cod_act		= SUBSTR(LEAccion,1,1)
			   ,cod_sqlcode	= SUBSTR(LECodOra,1,15)
			   ,cod_sqlerrm	= SUBSTR(LEErrOra,1,1000)
		 WHERE  num_celular = LENumCelular
		 AND	id_proceso  = LEIdProseso
		 AND	cod_estado  = LEEstadoIni;

	END;

	PROCEDURE PV_VALIDA_USO_PG( LENumAbonado 	 IN	 	ga_abocel.num_abonado%TYPE,
			  					LSEstado	  	 OUT	NUMBER,
								LSDescProceso	 OUT	pv_baja_masiva_to.desc_err%TYPE,
								LSTabla	  	  	 OUT	pv_baja_masiva_to.nom_tabla%TYPE,
								LSAccion	  	 OUT	pv_baja_masiva_to.cod_act%TYPE,
								LSCodOra		 OUT	pv_baja_masiva_to.cod_sqlcode%TYPE,
								LSErrOra		 OUT	pv_baja_masiva_to.cod_sqlerrm%TYPE) IS

	LNEsUsoPostpago		NUMBER;

	BEGIN

		 LSEstado:=3;

		 LSTabla:='GA_ABOCEL-USO';
		 LSAccion:='S';

		 SELECT COUNT(1)
		 INTO	LNEsUsoPostpago
		 FROM 	ga_abocel
		 WHERE 	num_abonado = LENumAbonado
		 AND 	cod_uso	    IN (SELECT cod_valor
		 					    FROM   ged_codigos
								WHERE  cod_modulo='PV'
								AND    nom_tabla='GA_ABOCEL_USO'
								AND    nom_columna='USO_BAJA_MASIVA');

		 IF LNEsUsoPostpago=0 THEN
		 	LSEstado:=4;
			LSDescProceso := PV_DESCERROR_FN(1612);
		 END IF;

	EXCEPTION
		WHEN OTHERS THEN
			  LSCodOra		  :=SQLCODE;
			  LSErrOra		  :=SQLERRM;

			  LSDescProceso := PV_DESCERROR_FN(74);
			  LSEstado:=5;
	END;

	PROCEDURE PV_VALIDA_ST_PG(  LENumAbonado 	 IN	 	ga_abocel.num_abonado%TYPE,
			  					LSEstado	  	 OUT	NUMBER,
								LSDescProceso	 OUT	pv_baja_masiva_to.desc_err%TYPE,
								LSTabla	  	  	 OUT	pv_baja_masiva_to.nom_tabla%TYPE,
								LSAccion	  	 OUT	pv_baja_masiva_to.cod_act%TYPE,
								LSCodOra		 OUT	pv_baja_masiva_to.cod_sqlcode%TYPE,
								LSErrOra		 OUT	pv_baja_masiva_to.cod_sqlerrm%TYPE) IS

	LNEstaST		ga_abocel.ind_disp%TYPE;

	BEGIN

		 LSEstado:=3;

		 LSTabla:='GA_ABOCEL-ST';
		 LSAccion:='S';

		 SELECT ind_disp
		 INTO	LNEstaST
		 FROM 	ga_abocel
		 WHERE 	num_abonado = LENumAbonado;

		 IF LNEstaST=0 THEN
		 	LSEstado:=4;
			LSDescProceso := PV_DESCERROR_FN(1853);
		 END IF;

	EXCEPTION
		WHEN OTHERS THEN
			  LSCodOra		  :=SQLCODE;
			  LSErrOra		  :=SQLERRM;

			  LSDescProceso := PV_DESCERROR_FN(1854);
			  LSEstado:=5;
	END;

	PROCEDURE PV_VALIDA_INTARCEL_PG(  LENumAbonado 	 	 IN	 	ga_abocel.num_abonado%TYPE,
			  						  LSEstado	  	 	 OUT	NUMBER,
									  LSDescProceso	 	 OUT	pv_baja_masiva_to.desc_err%TYPE,
									  LSTabla	  	  	 OUT	pv_baja_masiva_to.nom_tabla%TYPE,
									  LSAccion	  	 	 OUT	pv_baja_masiva_to.cod_act%TYPE,
									  LSCodOra		  	 OUT	pv_baja_masiva_to.cod_sqlcode%TYPE,
								  	  LSErrOra		  	 OUT	pv_baja_masiva_to.cod_sqlerrm%TYPE) IS

	LNCodCliente		ga_abocel.cod_cliente%TYPE;
	LNVigTarificacion	NUMBER;

	BEGIN

		 LSEstado:=3;

		 LSTabla:='GA_ABOCEL-CLIENTE-INTAR';
		 LSAccion:='S';

		 SELECT cod_cliente
		 INTO	LNCodCliente
		 FROM 	ga_abocel
		 WHERE 	num_abonado = LENumAbonado;

		 LSTabla:='GA_INTARCEL-VIG';
		 LSAccion:='S';

		 SELECT COUNT(1)
		 INTO	LNVigTarificacion
		 FROM 	ga_intarcel
		 WHERE 	cod_cliente = LNCodCliente
		 AND	num_abonado = LENumAbonado
		 AND	SYSDATE BETWEEN fec_desde AND fec_hasta;

		 IF LNVigTarificacion=0 THEN
		 	LSEstado:=4;
			LSDescProceso := PV_DESCERROR_FN(1855);
		 END IF;

	EXCEPTION
		WHEN OTHERS THEN

			  LSCodOra		  :=SQLCODE;
			  LSErrOra		  :=SQLERRM;

			  LSDescProceso := PV_DESCERROR_FN(1856);
			  LSEstado:=5;
	END;

	PROCEDURE PV_VALIDA_INFACCEL_PG(  LENumAbonado 	 	 IN	 	ga_abocel.num_abonado%TYPE,
			  						  LSEstado	  	 	 OUT	NUMBER,
									  LSDescProceso	 	 OUT	pv_baja_masiva_to.desc_err%TYPE,
									  LSTabla	  	  	 OUT	pv_baja_masiva_to.nom_tabla%TYPE,
									  LSAccion	  	 	 OUT	pv_baja_masiva_to.cod_act%TYPE,
									  LSCodOra		  	 OUT	pv_baja_masiva_to.cod_sqlcode%TYPE,
								  	  LSErrOra		  	 OUT	pv_baja_masiva_to.cod_sqlerrm%TYPE) IS

	LNCodCliente		ga_abocel.cod_cliente%TYPE;
	LNCodCiclo			ga_abocel.cod_ciclo%TYPE;

	LNCodciclfact		fa_ciclfact.cod_ciclfact%TYPE;

	LNVigFacturacion	NUMBER;

	BEGIN

		 LSEstado:=3;

		 LSTabla:='GA_ABOCEL-CLIENTE-INFAC';
		 LSAccion:='S';

		 SELECT cod_cliente,cod_ciclo
		 INTO	LNCodCliente,LNCodCiclo
		 FROM 	ga_abocel
		 WHERE 	num_abonado = LENumAbonado;

		 LSTabla:='FA_CICLFACT';
		 LSAccion:='S';

		 SELECT cod_ciclfact
		 INTO	LNCodciclfact
		 FROM	fa_ciclfact
		 WHERE 	cod_ciclo=LNCodCiclo
		 AND	SYSDATE BETWEEN fec_desdellam AND fec_hastallam;

		 LSTabla:='GA_INFACCEL-VIG';
		 LSAccion:='S';

		 SELECT COUNT(1)
		 INTO	LNVigFacturacion
		 FROM 	ga_infaccel
		 WHERE 	cod_cliente = LNCodCliente
		 AND	num_abonado = LENumAbonado
		 AND	cod_ciclfact=LNCodciclfact;

		 IF LNVigFacturacion=0 THEN
		 	LSEstado:=4;
			LSDescProceso := PV_DESCERROR_FN(200);
		 END IF;

	EXCEPTION
		WHEN OTHERS THEN
			  LSCodOra		  :=SQLCODE;
			  LSErrOra		  :=SQLERRM;

			  LSDescProceso := PV_DESCERROR_FN(1857);
			  LSEstado:=5;
	END;


	PROCEDURE PV_VALIDA_LIMCONSUMO_PG(  LENumAbonado 	 	 IN	 	ga_abocel.num_abonado%TYPE,
			  						  	LSEstado	  	 	 OUT	NUMBER,
									  	LSDescProceso	 	 OUT	pv_baja_masiva_to.desc_err%TYPE,
									  	LSTabla	  	  	 	 OUT	pv_baja_masiva_to.nom_tabla%TYPE,
									  	LSAccion	  	 	 OUT	pv_baja_masiva_to.cod_act%TYPE,
										LSCodOra		  	 OUT	pv_baja_masiva_to.cod_sqlcode%TYPE,
								  		LSErrOra		  	 OUT	pv_baja_masiva_to.cod_sqlerrm%TYPE) IS

	LNCodCliente		ga_abocel.cod_cliente%TYPE;
	LVTipPlan			ga_abocel.tip_plantarif%TYPE;
	LVCodUso			ga_abocel.cod_uso%TYPE;

	LVUsoHib			ged_parametros.val_parametro%TYPE;

	LNVigLimConsumo		NUMBER;

	BEGIN

		 LSEstado:=3;

		 LSTabla:='GA_ABOCEL-CLIENTE-CONSUMO';
		 LSAccion:='S';

		 SELECT cod_cliente,tip_plantarif,cod_uso
		 INTO	LNCodCliente,LVTipPlan,LVCodUso
		 FROM 	ga_abocel
		 WHERE 	num_abonado = LENumAbonado;


		 LSTabla:='GE_FN_DEVVALPARAM-USO-HIB';
		 LSAccion:='F';

		 LVUsoHib:=GE_FN_DEVVALPARAM('GA',1,'COD_USOCONTROLADA');

		 IF LVUsoHib<>LVCodUso THEN

			 IF LVTipPlan='I' THEN

				 LSTabla:='GA_LIMITE_CLIABO_TO_INV';
			 	 LSAccion:='S';

				 SELECT COUNT(1)
				 INTO	LNVigLimConsumo
				 FROM	ga_limite_cliabo_to
				 WHERE 	cod_cliente=LNCodCliente
				 AND	num_abonado=LENumAbonado
				 AND	SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE);
			 ELSE

			 	 LSTabla:='GA_LIMITE_CLIABO_TO_EMP';
			 	 LSAccion:='S';

			 	 SELECT COUNT(1)
				 INTO	LNVigLimConsumo
				 FROM	ga_limite_cliabo_to
				 WHERE 	cod_cliente=LNCodCliente
				 AND	num_abonado=0
				 AND	SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE);
			 END IF;

			 IF LNVigLimConsumo=0 THEN
			 	 LSEstado:=4;
				 LSDescProceso := PV_DESCERROR_FN(1858);
			 END IF;
		 END IF;

	EXCEPTION
		WHEN OTHERS THEN
			  LSCodOra		  :=SQLCODE;
			  LSErrOra		  :=SQLERRM;

			  LSDescProceso := PV_DESCERROR_FN(1859);
			  LSEstado:=5;
	END;

	PROCEDURE PV_EVALDEUDA_PR(    LENumAbonado 	 	 IN	 	ga_abocel.num_abonado%TYPE,
			  					  LSEstado	  	 	 OUT	NUMBER,
								  LSDescProceso	 	 OUT	pv_baja_masiva_to.desc_err%TYPE,
								  LSTabla	  	  	 OUT	pv_baja_masiva_to.nom_tabla%TYPE,
								  LSAccion	  	 	 OUT	pv_baja_masiva_to.cod_act%TYPE,
								  LSCodOra		  	 OUT	pv_baja_masiva_to.cod_sqlcode%TYPE,
								  LSErrOra		  	 OUT	pv_baja_masiva_to.cod_sqlerrm%TYPE) IS

	    LNCodCliente	  ga_abocel.cod_cliente%TYPE;
		LNDeudaPermitida  co_cartera.importe_debe%TYPE;
		LVCodProceso	  gad_procesos_perfiles.cod_proceso%TYPE;
		LVCodCategoria	  ge_clientes.cod_categoria%TYPE;
		LVCodTasa	  	  co_categorias_td.cod_tasa%TYPE;
		LNDiasAplicacion  co_intereses.dias_aplicacion%TYPE;
		LNDeuda 	      co_cartera.importe_debe%TYPE;

		LNCuentaPermi	  NUMBER;

	BEGIN

		LSEstado:=3;

		LSTabla:='GA_ABOCEL-CLIENTE-DEUDA';
		LSAccion:='S';

		SELECT cod_cliente
		INTO   LNCodCliente
		FROM   ga_abocel
		WHERE  num_abonado = LENumAbonado;

		LSTabla:='GE_FN_DEVVALPARAM-DEUDA';
		LSAccion:='F';

		LNDeudaPermitida:=TO_NUMBER(GE_FN_DEVVALPARAM('GA',1,'DEUDA_ABONADO'));

		LSTabla:='GAD_PROCESOS_PERFILES';
		LSAccion:='S';

	    SELECT cod_proceso
		INTO   LVCodProceso
		FROM   gad_procesos_perfiles
		WHERE  nom_perfil_proceso = 'PER_PL_PERMISO';

		LSTabla:='GE_SEG_PERFILES-GE_SEG_GRPUSUARIO';
		LSAccion:='S';

		SELECT COUNT(1)
		INTO   LNCuentaPermi
		FROM   ge_seg_perfiles a, ge_seg_grpusuario b
		WHERE  b.nom_usuario  = USER
		AND    a.cod_grupo    = b.cod_grupo
		AND    a.cod_proceso  = LVCodProceso;

		IF LNCuentaPermi=0 THEN

			LSTabla:='GE_CLIENTES';
			LSAccion:='S';

			SELECT cod_categoria
			INTO   LVCodCategoria
			FROM   ge_clientes
			WHERE  cod_cliente = LNCodCliente;

			LSTabla:='CO_CATEGORIAS_TD';
			LSAccion:='S';

			SELECT cod_tasa
			INTO   LVCodTasa
			FROM   co_categorias_td
			WHERE  cod_categoria = LVCodCategoria;

			LSTabla:='CO_INTERESES';
			LSAccion:='S';

			SELECT dias_aplicacion
			INTO   LNDiasAplicacion
			FROM   co_intereses
			WHERE  cod_tasa = LVCodTasa
			AND    SYSDATE BETWEEN fec_vigencia_dd_dh AND fec_vigencia_hh_dh;

			LSTabla:='CO_CARTERA';
			LSAccion:='S';

			SELECT NVL(SUM(importe_debe - importe_haber),0)
			INTO   LNDeuda
			FROM   co_cartera
			WHERE  cod_cliente   = LNCodCliente
			AND    ind_facturado = 1
			AND    fec_vencimie  < TRUNC(SYSDATE)
			AND    fec_vencimie  + LNDiasAplicacion  < TRUNC(SYSDATE)
			AND    cod_tipdocum  NOT IN (SELECT TO_NUMBER(cod_valor)
			   	   					  	 FROM 	co_codigos
			 						  	 WHERE  nom_tabla   = 'CO_CARTERA'
									  	 AND 	nom_columna = 'COD_TIPDOCUM');

			IF LNDeuda > LNDeudaPermitida THEN
			   LSEstado:=4;
			   LSDescProceso := PV_DESCERROR_FN(1860);
			END IF;
		END IF;

	EXCEPTION
	     WHEN OTHERS THEN
	          LSCodOra		  :=SQLCODE;
			  LSErrOra		  :=SQLERRM;

			  LSDescProceso := PV_DESCERROR_FN(1861);
			  LSEstado:=5;
	END;

	PROCEDURE PV_REVISA_OSPENDIENTES ( LENumAbonado 	 IN	 	ga_abocel.num_abonado%TYPE,
			  					  	   LSEstado	  	 	 OUT	NUMBER,
								  	   LSDescProceso	 OUT	pv_baja_masiva_to.desc_err%TYPE,
								  	   LSTabla	  	  	 OUT	pv_baja_masiva_to.nom_tabla%TYPE,
								  	   LSAccion	  	 	 OUT	pv_baja_masiva_to.cod_act%TYPE,
								  	   LSCodOra		  	 OUT	pv_baja_masiva_to.cod_sqlcode%TYPE,
								  	   LSErrOra		  	 OUT	pv_baja_masiva_to.cod_sqlerrm%TYPE) IS

		 LNCodEstNoFin		pv_iorserv.cod_estado%TYPE;
		 LNCodEstCance		pv_iorserv.cod_estado%TYPE;
		 LNCantOSPend		NUMBER;

	BEGIN

		 LSEstado:=3;

		 LSTabla:='GE_FN_DEVVALPARAM-MENSAJE';
		 LSAccion:='F';
		 LNCodEstNoFin:=TO_NUMBER(GE_FN_DEVVALPARAM('GA',1,'ESTADO_PV_MENSAJE'));

		 LSTabla:='GE_FN_DEVVALPARAM-CANCELADA';
		 LSAccion:='F';
		 LNCodEstCance:=GE_FN_DEVVALPARAM('GA',1,'EST_BAJA_CANCELADA');

		 LSTabla:='PV_IORSERV-PV_CAMCOM-PV_ERECORRIDO';
		 LSAccion:='S';

		 SELECT COUNT(*)
		 INTO 	LNCantOSPend
		 FROM 	PV_IORSERV A, PV_CAMCOM B, PV_ERECORRIDO C
		 WHERE  A.NUM_OS = B.NUM_OS
		 AND 	A.NUM_OS = C.NUM_OS
		 AND 	B.NUM_OS = C.NUM_OS
		 AND 	B.NUM_ABONADO = LENumAbonado
		 AND 	A.COD_ESTADO <  LNCodEstNoFin
		 AND 	A.COD_ESTADO <> LNCodEstCance
		 AND 	A.COD_ESTADO = C.COD_ESTADO
		 AND 	C.TIP_ESTADO <4;

	     IF LNCantOSPend > 0 THEN

			LSEstado:=4;
			LSDescProceso := PV_DESCERROR_FN(1862);

		    LSCodOra		:='0';
		    LSErrOra		:='0';

		 ELSE
		 	LSTabla	  	    :='0';
		    LSAccion	  	:='0';
		    LSCodOra		:='0';
		    LSErrOra		:='0';

	     END IF;

	EXCEPTION
	   WHEN OTHERS THEN
			LSCodOra		  :=SQLCODE;
			LSErrOra		  :=SQLERRM;

			LSDescProceso := PV_DESCERROR_FN(1863);
			LSEstado:=5;

	END;

	PROCEDURE PV_INSCRIBE_IORSERV_PG ( LENumOS			 IN		pv_iorserv.num_os%TYPE,
			  					  	   LSEstado	  	 	 OUT	NUMBER,
								  	   LSDescProceso	 OUT	pv_baja_masiva_to.desc_err%TYPE,
								  	   LSTabla	  	  	 OUT	pv_baja_masiva_to.nom_tabla%TYPE,
								  	   LSAccion	  	 	 OUT	pv_baja_masiva_to.cod_act%TYPE,
								  	   LSCodOra		  	 OUT	pv_baja_masiva_to.cod_sqlcode%TYPE,
								  	   LSErrOra		  	 OUT	pv_baja_masiva_to.cod_sqlerrm%TYPE) IS

		 LVCodOsBaja		ged_parametros.val_parametro%TYPE;
		 LVCodOsBajaAbo		ged_parametros.val_parametro%TYPE;	 --COL-71027|29-09-2008|GEZ
		 LVCodOsSolicBaja	ged_parametros.val_parametro%TYPE;	 --COL-71027|29-09-2008|GEZ
		 LVCodOsBajaOptaPP	ged_parametros.val_parametro%TYPE;	 --COL-71027|29-09-2008|GEZ

		 LVDescOS			pv_iorserv.descripcion%TYPE;
		 LNTipProcesa		pv_iorserv.tip_procesa%TYPE;
		 LVCodModgener		pv_iorserv.cod_modgener%TYPE;
		 LNCodEstado 		pv_iorserv.cod_estado%TYPE;	 		 --COL-71027|29-09-2008|GEZ



	BEGIN

		 LSEstado:=3;

		 LSTabla:='GE_FN_DEVVALPARAM-CODOS';
		 LSAccion:='F';
		 LVCodOsBaja:=TO_NUMBER(GE_FN_DEVVALPARAM('GA',1,'CODOS_BAJA_MAS'));

		 --INI COL-71027|29-09-2008|GEZ
		 LSAccion		  := 'F';

		 LSTabla		  := 'GE_FN_PARAM-CODOS_BAJA';
		 LVCodOsBajaAbo	  := TO_NUMBER(GE_FN_DEVVALPARAM('GA',1,'CODOS_BAJA_ABONADO'));

		 LSTabla		  := 'GE_FN_PARAM-CODOS_SOLIC';
		 LVCodOsSolicBaja := TO_NUMBER(GE_FN_DEVVALPARAM('GA',1,'CODOS_SOLICITUD_BAJA'));

		 LSTabla		  := 'GE_FN_PARAM-CODOS_BAJAOPTA';
		 LVCodOsBajaOptaPP:= TO_NUMBER(GE_FN_DEVVALPARAM('GA',1,'CODOS_BAJA_OPTAPREPA'));

		 --FIN COL-71027|29-09-2008|GEZ

		 LSTabla:='CI_TIPORSERV';
		 LSAccion:='S';

		 BEGIN
			 SELECT descripcion,tip_procesa,cod_modgener
			 INTO	LVDescOS,LNTipProcesa,LVCodModgener
			 FROM 	ci_tiporserv
			 WHERE 	cod_os=LVCodOsBaja;

			 LSTabla:='PV_IORSERV';
			 LSAccion:='I';
			 LVDescOS:=LVDescOS || ' SOLICITUD MASIVA';  /* COL-63261|08-09-2008|DVG  */

			 INSERT INTO pv_iorserv(
	    	 num_os,cod_os,descripcion,fecha_ing,producto,usuario,status,tip_procesa,cod_estado,
	    	 cod_modgener,num_osf,tip_sujeto,comentario)
			 VALUES(
			 LENumOS,LVCodOsBaja,LVDescOS,SYSDATE,1,USER,'EN PROCESO',LNTipProcesa,
			 DECODE(LVCodOsBaja,LVCodOsBajaAbo,10,LVCodOsSolicBaja,1,LVCodOsBajaOptaPP,10,10),
			 LVCodModgener,0,'A','BAJA MASIVA CONTRATO POR ARCHIVO');

		 EXCEPTION
		 	WHEN NO_DATA_FOUND THEN
				 LSEstado:=4;
				 LSDescProceso := PV_DESCERROR_FN(1864)||'['||LVCodOsBaja||']';
		 END;

	EXCEPTION
	   WHEN OTHERS THEN
			LSCodOra		  :=SQLCODE;
			LSErrOra		  :=SQLERRM;

			LSDescProceso := PV_DESCERROR_FN(1865);
			LSEstado:=5;

	END;

	PROCEDURE PV_INSCRIBE_CAMCOM_PG ( LENumAbonado 	    IN	 	ga_abocel.num_abonado%TYPE,
			  						  LENumOS			IN		pv_iorserv.num_os%TYPE,
			  					  	  LSEstado	  	 	OUT		NUMBER,
								  	  LSDescProceso	 	OUT		pv_baja_masiva_to.desc_err%TYPE,
								  	  LSTabla	  	  	OUT		pv_baja_masiva_to.nom_tabla%TYPE,
								  	  LSAccion	  	 	OUT		pv_baja_masiva_to.cod_act%TYPE,
								  	  LSCodOra		  	OUT		pv_baja_masiva_to.cod_sqlcode%TYPE,
								  	  LSErrOra		  	OUT		pv_baja_masiva_to.cod_sqlerrm%TYPE) IS

		 LNNumCelular		ga_abocel.num_celular%TYPE;
		 LNCodCliente		ga_abocel.cod_cliente%TYPE;
		 LNCodCuenta		ga_abocel.cod_cuenta%TYPE;
		 LVTipTerminal		ga_abocel.tip_terminal%TYPE;

	BEGIN

		 LSEstado:=3;

		 LSTabla:='GA_ABOCEL';
		 LSAccion:='S';

		 SELECT num_celular,cod_cliente,cod_cuenta,tip_terminal
		 INTO 	LNNumCelular,LNCodCliente,LNCodCuenta,LVTipTerminal
		 FROM 	ga_abocel
		 WHERE 	num_abonado=LENumAbonado;

		 LSTabla:='PV_CAMCOM';
		 LSAccion:='I';

		 INSERT INTO pv_camcom
		 (num_os,num_abonado,num_celular,cod_cliente,cod_cuenta,cod_producto,bdatos,cod_actabo,
		  ind_central_ss,tip_terminal)
		 VALUES(LENumOS,LENumAbonado,LNNumCelular,LNCodCliente,LNCodCuenta,1,'SCEL','BA',
		 1,LVTipTerminal);



	EXCEPTION
	   WHEN OTHERS THEN
			LSCodOra	  :=SQLCODE;
			LSErrOra	  :=SQLERRM;

			LSDescProceso := PV_DESCERROR_FN(1866);
			LSEstado	  :=5;

	END;

	PROCEDURE PV_INSCRIBE_ERECORRIDO_PG ( 	LENumOS			IN		pv_iorserv.num_os%TYPE,
			  					  	  		LSEstado	  	OUT		NUMBER,
								  	  		LSDescProceso	OUT		pv_baja_masiva_to.desc_err%TYPE,
								  	  		LSTabla	  	  	OUT		pv_baja_masiva_to.nom_tabla%TYPE,
								  	  		LSAccion	  	OUT		pv_baja_masiva_to.cod_act%TYPE,
								  	  		LSCodOra		OUT		pv_baja_masiva_to.cod_sqlcode%TYPE,
								  	  		LSErrOra		OUT		pv_baja_masiva_to.cod_sqlerrm%TYPE) IS

		 LVDesEstaDoc		fa_intestadoc.des_estadoc%TYPE;

		 LNCodEstado 		pv_iorserv.cod_estado%TYPE;	 		 --COL-71027|29-09-2008|GEZ

	BEGIN

		 LSEstado:=3;

		 LSTabla:='FA_INTESTADOC';
		 LSAccion:='S';

		 SELECT des_estadoc
		 INTO	LVDesEstaDoc
		 FROM 	fa_intestadoc
		 WHERE 	cod_aplic='PVA'
		 AND 	cod_estadoc = 10;

		 --INI COL-71027|29-09-2008|GEZ
		 LSTabla:='PV_IORSERV';
		 LSAccion:='S';

		 SELECT cod_estado
		 INTO	LNCodEstado
		 FROM 	pv_iorserv
		 WHERE  num_os=LENumOS;
		  --FIN COL-71027|29-09-2008|GEZ

		 LSTabla:='PV_ERECORRIDO';
		 LSAccion:='I';

		 INSERT INTO pv_erecorrido(num_os,cod_estado,descripcion,tip_estado,fec_ingestado)
		 --VALUES (LENumOS,10,LVDesEstaDoc,3,SYSDATE); 			--COL-71027|29-09-2008|GEZ
		 VALUES (LENumOS,LNCodEstado,LVDesEstaDoc,3,SYSDATE);   --COL-71027|29-09-2008|GEZ

	EXCEPTION
	   WHEN OTHERS THEN
			LSCodOra		  :=SQLCODE;
			LSErrOra		  :=SQLERRM;

			LSDescProceso := PV_DESCERROR_FN(1867);
			LSEstado:=5;

	END;

	--INI COL-71027|29-09-2008|GEZ
	PROCEDURE PV_INSCRIBE_SOLIC_PR ( 	LENumAbonado 	IN	 	ga_abocel.num_abonado%TYPE,
			  					   		LENumCelular	IN	 	ga_abocel.num_celular%TYPE,
										LECodCliente	IN	 	ga_abocel.cod_cliente%TYPE,
										LENumOS			IN		pv_iorserv.num_os%TYPE,
			  					  	  	LECodCausa		IN		pv_solicitud_bajas_to.cod_causabaja%TYPE,
										LSEstado	  	OUT		NUMBER,
								  	  	LSDescProceso	OUT		pv_baja_masiva_to.desc_err%TYPE,
								  	  	LSTabla	  	  	OUT		pv_baja_masiva_to.nom_tabla%TYPE,
								  	  	LSAccion	  	OUT		pv_baja_masiva_to.cod_act%TYPE,
								  	  	LSCodOra		OUT		pv_baja_masiva_to.cod_sqlcode%TYPE,
								  	  	LSErrOra		OUT		pv_baja_masiva_to.cod_sqlerrm%TYPE) IS

		 LVCodOS		pv_iorserv.cod_os%TYPE;
		 LVCodOficina	ge_seg_usuario.cod_oficina%TYPE;

		 LVCodOsSolicBaja 		ged_parametros.val_parametro%TYPE;

	BEGIN

		 LSEstado:=3;
		 LSDescProceso	:='0';
		 LSTabla	  	:='0';
		 LSAccion	  	:='0';
		 LSCodOra		:='0';
		 LSErrOra		:='0';

		 LSTabla		  := 'GE_FN_PARAM-CODOS_SOLIC';
		 LSAccion		  :='F';
		 LVCodOsSolicBaja := TO_NUMBER(GE_FN_DEVVALPARAM('GA',1,'CODOS_SOLICITUD_BAJA'));

		 LSTabla:='PV_IORSERV';
		 LSAccion:='S';

		 SELECT cod_os
		 INTO	LVCodOS
		 FROM 	pv_iorserv
		 WHERE  num_os=LENumOS;

		 IF LVCodOS=LVCodOsSolicBaja THEN

			 BEGIN
				 LSTabla:='GE_SEG_USUARIO';
				 LSAccion:='S';

				 SELECT cod_oficina
				 INTO	LVCodOficina
				 FROM	ge_seg_usuario
				 WHERE 	nom_usuario=USER;
			 EXCEPTION
			 	WHEN NO_DATA_FOUND THEN
					 LVCodOficina:=NULL;
			 END;

			 LSTabla:='PV_SOLICITUD_BAJAS_TO';
			 LSAccion:='I';

			 INSERT INTO pv_solicitud_bajas_to
	         (num_os,cod_os,num_celular,num_abonado,cod_cliente,
	         cod_causabaja,cod_oficina, fec_ingreso , Cod_Estado,
	         cod_prioridad, obs_solicitud, fec_ultmod, nom_usuario)
	         VALUES (LENumOS,LVCodOS,LENumCelular,LENumAbonado,LECodCliente
			 ,LECodCausa,LVCodOficina,SYSDATE,1,1,'BAJA MASIVA POR ARCHIVO',SYSDATE,USER);

		 END IF;

	EXCEPTION
	   WHEN OTHERS THEN
			LSCodOra	   :=SQLCODE;
			LSErrOra	   :=SQLERRM;

			LSDescProceso  := PV_DESCERROR_FN(2347);
			LSEstado	   :=5;

	END;
	--FIN COL-71027|29-09-2008|GEZ

	PROCEDURE PV_INSCRIBE_PARAM_PG ( 	LENumAbonado 	IN	 	ga_abocel.num_abonado%TYPE,
			  					   		LENumOS			IN		pv_iorserv.num_os%TYPE,
			  					  	  	LSEstado	  	OUT		NUMBER,
								  	  	LSDescProceso	OUT		pv_baja_masiva_to.desc_err%TYPE,
								  	  	LSTabla	  	  	OUT		pv_baja_masiva_to.nom_tabla%TYPE,
								  	  	LSAccion	  	OUT		pv_baja_masiva_to.cod_act%TYPE,
								  	  	LSCodOra		OUT		pv_baja_masiva_to.cod_sqlcode%TYPE,
								  	  	LSErrOra		OUT		pv_baja_masiva_to.cod_sqlerrm%TYPE) IS

		 LNNumCelular		pv_param_abocel.num_celular%TYPE;
		 LVCodUso			pv_param_abocel.cod_uso%TYPE;
		 LVTipPlan			pv_param_abocel.tip_plantarif%TYPE;
		 LVTipTerm			pv_param_abocel.tip_terminal%TYPE;
		 LVCodPlan			pv_param_abocel.cod_plantarif%TYPE;
		 LVCodCargoBas		pv_param_abocel.cod_cargobasico%TYPE;
		 LNCodEmpresa		pv_param_abocel.cod_empresa%TYPE;
		 LNCodCiclo			pv_param_abocel.cod_ciclo%TYPE;
		 LNNumMin			pv_param_abocel.num_min%TYPE;
		 LNCodCausaBaja		pv_param_abocel.cod_causa%TYPE;

		 LNCodCliente		ga_abocel.cod_cliente%TYPE; --COL-71027|29-09-2008|GEZ

		 LNExisteCauBA		NUMBER;

	BEGIN

		 LSEstado:=3;

		 LSTabla:='GE_FN_DEVVALPARAM-CAUSA';
		 LSAccion:='F';
		 LNCodCausaBaja:=GE_FN_DEVVALPARAM('GA',1,'CAUSA_BAJA_MAS_CONTR');

		 LSTabla:='GA_CAUSABAJA';
		 LSAccion:='S';

		 SELECT COUNT(1)
		 INTO	LNExisteCauBA
		 FROM 	ga_causabaja
		 WHERE 	cod_causabaja= LNCodCausaBaja;

		 IF LNExisteCauBA=0 THEN
		 	 LSEstado:=4;
			 LSDescProceso := PV_DESCERROR_FN(1868)||'['||LNCodCausaBaja||']';
		 ELSE
			 LSTabla:='GA_ABOCEL';
			 LSAccion:='S';

			 SELECT num_celular,cod_uso,tip_plantarif,tip_terminal,cod_plantarif
			 ,cod_cargobasico,cod_empresa,cod_ciclo,num_min
			 ,cod_cliente  --COL-71027|29-09-2008|GEZ
			 INTO	LNNumCelular,LVCodUso,LVTipPlan,LVTipTerm,LVCodPlan,LVCodCargoBas,LNCodEmpresa,
			 LNCodCiclo,LNNumMin
			 ,LNCodCliente  --COL-71027|29-09-2008|GEZ
			 FROM 	ga_abocel
			 WHERE 	num_abonado=LENumAbonado;

			 LSTabla:='PV_PARAM_ABOCEL';
			 LSAccion:='I';

			 INSERT INTO pv_param_abocel(num_os, num_abonado, cod_tipmodi, fec_modifica, nuom_usuarora,
			 num_celular, cod_uso,tip_plantarif, tip_terminal, cod_plantarif, cod_cargobasico, cod_empresa,
			 cod_ciclo, cod_causa,num_min, obs_detalle)
			 VALUES(LENumOS,LENumAbonado,'BA',SYSDATE,USER,LNNumCelular,LVCodUso,LVTipPlan,LVTipTerm
			 ,LVCodPlan,LVCodCargoBas,LNCodEmpresa,LNCodCiclo,LNCodCausaBaja,LNNumMin,'BAJA MASIVA POR ARCHIVO');

			 --INI COL-71027|29-09-2008|GEZ
			 PV_INSCRIBE_SOLIC_PR(LENumAbonado,LNNumCelular,LNCodCliente,LENumOS,LNCodCausaBaja,
								  LSEstado,LSDescProceso,LSTabla,LSAccion,LSCodOra,LSErrOra);

			 --FIN COL-71027|29-09-2008|GEZ

		 END IF;

	EXCEPTION
	   WHEN OTHERS THEN
			LSCodOra	   :=SQLCODE;
			LSErrOra	   :=SQLERRM;

			LSDescProceso  := PV_DESCERROR_FN(1869);
			LSEstado	   :=5;

	END;

	PROCEDURE PV_INSCRIBE_MOVIMIENTO_PG ( 	LENumAbonado 	IN	 	ga_abocel.num_abonado%TYPE,
			  								LENumOS			IN		pv_iorserv.num_os%TYPE,
			  					  	  		LSEstado	  	OUT		NUMBER,
								  	  		LSDescProceso	OUT		pv_baja_masiva_to.desc_err%TYPE,
								  	  		LSTabla	  	  	OUT		pv_baja_masiva_to.nom_tabla%TYPE,
								  	  		LSAccion	  	OUT		pv_baja_masiva_to.cod_act%TYPE,
								  	  		LSCodOra		OUT		pv_baja_masiva_to.cod_sqlcode%TYPE,
								  	  		LSErrOra		OUT		pv_baja_masiva_to.cod_sqlerrm%TYPE) IS

		 LVCodOsBaja		pv_iorserv.cod_os%TYPE;

		 LVCodActabo		pv_movimientos.cod_actabo%TYPE;

		 LNExisteActabo		NUMBER;

	BEGIN

		 LSEstado:=3;

		 LSTabla:='GE_FN_DEVVALPARAM-CODOS';
		 LSAccion:='F';
		 LVCodOsBaja:=TO_NUMBER(GE_FN_DEVVALPARAM('GA',1,'CODOS_BAJA_MAS'));

		 LSTabla:='PV_ACTABO_TIPLAN';
		 LSAccion:='S';

		 SELECT cod_actabo
		 INTO	LVCodActabo
		 FROM 	pv_actabo_tiplan
		 WHERE 	cod_os=LVCodOsBaja
		 AND	cod_tipmodi=(SELECT cod_tipmodi FROM ci_tiporserv WHERE cod_os=LVCodOsBaja)
		 AND 	cod_tiplan =(SELECT b.cod_tiplan
		 				   	 FROM 	ga_abocel a,ta_plantarif b
							 WHERE 	a.num_abonado=LENumAbonado
							 AND	b.cod_plantarif=a.cod_plantarif);

		 LSTabla:='GA_ACTABO';
		 LSAccion:='S';

		 SELECT COUNT(1)
		 INTO	LNExisteActabo
		 FROM 	ga_actabo
		 WHERE 	cod_actabo=LVCodActabo
		 AND 	cod_tecnologia=(SELECT cod_tecnologia FROM ga_abocel WHERE num_abonado=LENumAbonado)
		 AND 	cod_modulo='GA';

		 IF LNExisteActabo=0 THEN
		 	LSEstado:=4;
			LSDescProceso  := PV_DESCERROR_FN(1870)||'['||LVCodActabo||']';
		 ELSE

			LSTabla:='PV_MOVIMIENTOS';
			LSAccion:='I';

			INSERT INTO pv_movimientos(num_os,ord_comando,cod_actabo,ind_estado)
			VALUES(LENumOS,1,LVCodActabo,1);

		 END IF;

	EXCEPTION
	   WHEN OTHERS THEN
			LSCodOra		  :=SQLCODE;
			LSErrOra		  :=SQLERRM;

			LSDescProceso  := PV_DESCERROR_FN(1871);
			LSEstado:=5;

	END;

    -- INI COL-75763;15-01-2009;AVC
	PROCEDURE PV_INSCRIBE_PROG_PR ( EN_NumOS		 IN	  PV_PROG.num_os%TYPE,
									ED_FechProrroga  IN   PV_PROG.F_PRORROGA%TYPE,
									EV_Usuario       IN   PV_PROG.USUARIO%TYPE,
									EV_Observacion   IN   PV_PROG.OBSERVACION%TYPE,
			  					  	LSEstado	  	 OUT  NUMBER,
								  	LSDescProceso	 OUT  pv_baja_masiva_to.desc_err%TYPE,
								  	SV_Tabla	  	 OUT  pv_baja_masiva_to.nom_tabla%TYPE,
								  	SV_Accion	  	 OUT  pv_baja_masiva_to.cod_act%TYPE,
								  	SV_CodOra		 OUT  pv_baja_masiva_to.cod_sqlcode%TYPE,
								  	SV_ErrOra		 OUT  pv_baja_masiva_to.cod_sqlerrm%TYPE) IS
	BEGIN
      LSEstado:=3;

	  IF ((EN_NumOS IS NOT NULL) AND (ED_FechProrroga IS NOT NULL))  THEN
	     SV_Tabla:='PV_PROG';
		 SV_Accion:='I';

	     INSERT INTO PV_PROG
	     (NUM_OS, F_PRORROGA, USUARIO, OBSERVACION)
	     VALUES(EN_NumOS, ED_FechProrroga, EV_Usuario, EV_Observacion);

	  END IF;

	  EXCEPTION
	   WHEN OTHERS THEN
			SV_CodOra		  :=SQLCODE;
			SV_ErrOra		  :=SQLERRM;

			LSDescProceso  := PV_DESCERROR_FN(1871);
			LSEstado:=5;

	END;
-- FIN COL-75763;15-01-2009;AVC



	PROCEDURE PV_INSCRIBE_OS_BATCH_PG ( LENumAbonado 	 IN	 	ga_abocel.num_abonado%TYPE,
			  						   	LSNumOS			 OUT	pv_iorserv.num_os%TYPE,
			  					  	   	LSEstado	  	 OUT	NUMBER,
								  	   	LSDescProceso	 OUT	pv_baja_masiva_to.desc_err%TYPE,
								  	   	LSTabla	  	  	 OUT	pv_baja_masiva_to.nom_tabla%TYPE,
								  	   	LSAccion	  	 OUT	pv_baja_masiva_to.cod_act%TYPE,
								  	   	LSCodOra		 OUT	pv_baja_masiva_to.cod_sqlcode%TYPE,
								  	   	LSErrOra		 OUT	pv_baja_masiva_to.cod_sqlerrm%TYPE) IS

	LVAplicOSACiclo		VARCHAR2(10); --COL-63261(MA)|18-07-2008|GEZ
	LD_FechHastallam    fa_ciclfact.fec_hastallam%TYPE;  -- INC-75763; COL; 15-01-2009; AVC

	ERROR_FECHA			exception;

	BEGIN

		 LSEstado:=3;

		 SELECT ci_seq_numos.NEXTVAL INTO LSNumOS FROM 	DUAL;

		 PV_INSCRIBE_IORSERV_PG(LSNumOS,LSEstado,LSDescProceso,LSTabla,LSAccion,LSCodOra,LSErrOra);

		 IF LSEstado=3 THEN

				--INI COL-63261(MA)|18-07-2008|GEZ
				LVAplicOSACiclo:=GE_FN_DEVVALPARAM('GA',1,'APLICACICLO_BAJA_MAS');

				IF LVAplicOSACiclo='TRUE' THEN
 		     -- INICIO INC-75763; COL; 15-01-2009; AVC
		                BEGIN
				               SELECT fec_hastallam+(1/(24*60*60)) - 1
				               INTO LD_FechHastallam
  				               FROM fa_ciclfact
				               WHERE cod_ciclo=(SELECT cod_ciclo FROM ga_abocel WHERE num_abonado=LENumAbonado)
				               AND SYSDATE BETWEEN fec_desdellam AND fec_hastallam;

				   		EXCEPTION
				        	WHEN OTHERS THEN
						       RAISE ERROR_FECHA;
                        END;
		     -- FINAL INC-75763; COL; 15-01-2009; AVC

				   LSTabla	  	:= 'PV_IORSERV';
				   LSAccion		:= 'U';


				   UPDATE pv_iorserv
				   --INI 71649|16-10-2008|EFR.
				   --SET	  fh_ejecucion=(SELECT fec_hastallam+(1/(24*60*60))
				   -- SET	  fh_ejecucion=(SELECT fec_hastallam+(1/(24*60*60)) - 1  -- INC-75763; COL; 15-01-2009; AVC
				   SET	  fh_ejecucion= LD_FechHastallam -- INC-75763; COL; 15-01-2009; AVC
				   --FIN 71649|16-10-2008|EFR.
		   		  			--	FROM fa_ciclfact						-- INC-75763; COL; 15-01-2009; AVC
							--	WHERE cod_ciclo=(SELECT cod_ciclo FROM ga_abocel WHERE num_abonado=LENumAbonado) -- INC-75763; COL; 15-01-2009; AVC
		   		  			--	AND SYSDATE BETWEEN fec_desdellam AND fec_hastallam) -- INC-75763; COL; 15-01-2009; AVC
				   WHERE num_os=LSNumOS;

		   		   PV_INSCRIBE_PROG_PR(LSNumOS, LD_FechHastallam, USER, NULL,LSEstado,LSDescProceso,LSTabla,LSAccion,LSCodOra,LSErrOra);

				END IF;
				--FIN COL-63261(MA)|18-07-2008|GEZ

				PV_INSCRIBE_CAMCOM_PG(LENumAbonado,LSNumOS,LSEstado,LSDescProceso,LSTabla,LSAccion,LSCodOra,LSErrOra);

				IF LSEstado=3 THEN

				   --INI 71649|16-10-2008|EFR.
				   IF LVAplicOSACiclo='TRUE' THEN
					   LSTabla	  	:= 'PV_CAMCOM';
					   LSAccion		:= 'U';
					   UPDATE pv_camcom
					   SET	  FEC_VENCIMIENTO=(SELECT fec_hastallam+(1/(24*60*60)) - 1
						   		  			   FROM fa_ciclfact
											   WHERE cod_ciclo=(SELECT cod_ciclo FROM ga_abocel WHERE num_abonado=LENumAbonado)
						   		  			   AND SYSDATE BETWEEN fec_desdellam AND fec_hastallam)
					   WHERE num_os=LSNumOS;
					END IF;
					--FIN 71649|16-10-2008|EFR.

				   PV_INSCRIBE_ERECORRIDO_PG(LSNumOS,LSEstado,LSDescProceso,LSTabla,LSAccion,LSCodOra,LSErrOra);

					IF LSEstado=3 THEN
					   PV_INSCRIBE_PARAM_PG(LENumAbonado,LSNumOS,LSEstado,LSDescProceso,LSTabla,LSAccion,LSCodOra,LSErrOra);

					   IF LSEstado=3 THEN
					   	  PV_INSCRIBE_MOVIMIENTO_PG(LENumAbonado,LSNumOS,LSEstado,LSDescProceso,LSTabla,LSAccion,LSCodOra,LSErrOra);
					   END IF; --PV_INSCRIBE_PARAM_PG

					END IF; --PV_INSCRIBE_ERECORRIDO_PG

				END IF; --PV_INSCRIBE_CAMCOM_PG

		 END IF;  --PV_INSCRIBE_IORSERV

	EXCEPTION
	   -- INI INC-75763; COL; 15-01-2009; AVC
	   WHEN ERROR_FECHA THEN
	       LSCodOra		  :=SQLCODE;
		   LSErrOra		  :=SQLERRM;
		   LSDescProceso  := PV_DESCERROR_FN(1872);
		   LSEstado:=5;
           -- FIN INC-75763; COL; 15-01-2009; AVC

	   WHEN OTHERS THEN
			LSCodOra		  :=SQLCODE;
			LSErrOra		  :=SQLERRM;

			LSDescProceso  := PV_DESCERROR_FN(1872);
			LSEstado:=5;


	END;

	PROCEDURE PV_VALIDA_LINEA_PR( LENumCelular 	  IN	pv_baja_masiva_to.num_celular%TYPE,
			  					  LEIdProseso	  IN	pv_baja_masiva_to.id_proceso%TYPE,
   			 					  LSEstado	  	  OUT	NUMBER,
								  LSNumOs		  OUT	pv_baja_masiva_to.num_os%TYPE,
								  LSDescProceso	  OUT	pv_baja_masiva_to.desc_err%TYPE,
								  LSTabla	  	  OUT	pv_baja_masiva_to.nom_tabla%TYPE,
								  LSAccion	  	  OUT	pv_baja_masiva_to.cod_act%TYPE,
								  LSCodOra		  OUT	pv_baja_masiva_to.cod_sqlcode%TYPE,
								  LSErrOra		  OUT	pv_baja_masiva_to.cod_sqlerrm%TYPE) IS

		LNCantLineas			 NUMBER;
		LNCantSituacion			 NUMBER;
		LNEstado	  	  		 NUMBER;

		LNNumAbonado			 ga_abocel.num_abonado%TYPE;
		LNNumOS					 pv_iorserv.num_os%TYPE;

		LVDescProceso	  		 pv_baja_masiva_to.desc_err%TYPE;
		LVTabla	  	  			 pv_baja_masiva_to.nom_tabla%TYPE;
		LVAccion	  	  		 pv_baja_masiva_to.cod_act%TYPE;
		LVCodOra		  		 pv_baja_masiva_to.cod_sqlcode%TYPE;
		LVErrOra		  		 pv_baja_masiva_to.cod_sqlerrm%TYPE;

	BEGIN

		LSEstado:=3;

		LSTabla:='GA_ABOCEL-COUNT';
		LSAccion:='S';

		SELECT COUNT(1)
		INTO   LNCantLineas
		FROM   ga_abocel
		WHERE  num_celular=LENumCelular;

		IF LNCantLineas=0 THEN
		   LSDescProceso  := PV_DESCERROR_FN(1873);
		   LSEstado:=4;
		ELSE

		   LSTabla:='PVD_ACTUACION_SITUACION-COUNT';
		   LSAccion:='S';

		   SELECT COUNT(1)
		   INTO	  LNCantSituacion
		   FROM   ga_abocel
		   WHERE  num_celular=LENumCelular
		   AND 	  cod_situacion IN (SELECT cod_situacion
		    	  				    FROM pvd_actuacion_situacion
		   	   				 	    WHERE cod_actabo='MB'
									AND cod_producto=1);

		   IF LNCantSituacion>1 THEN
		   	  LSDescProceso:='LINEA EXISTE '||LNCantSituacion||' VECES EN GA_ABOCEL CON SITUACION PERMITIDA';
		   	  LSEstado:=4;
		   ELSE

			  BEGIN

				  LSTabla:='GA_ABOCEL-ABONADO';
		   		  LSAccion:='S';

				  SELECT num_abonado
			   	  INTO	 LNNumAbonado
			   	  FROM   ga_abocel
			   	  WHERE  num_celular=LENumCelular
			   	  AND 	 cod_situacion IN (SELECT cod_situacion
			    	  				       FROM pvd_actuacion_situacion
			   	   				 	       WHERE cod_actabo='MB'
										   AND cod_producto=1);

		   	  EXCEPTION
			  	  WHEN NO_DATA_FOUND THEN
				  	   LSDescProceso  := PV_DESCERROR_FN(323);
		   	  		   LSEstado:=4;
			  END;

		   END IF;

		END IF;

		IF LSEstado=3 THEN

		   --valida que uso de la linea sea postpago
		   PV_VALIDA_USO_PG(LNNumAbonado,LSEstado,LSDescProceso,LSTabla,LSAccion,LSCodOra,LSErrOra);

		   IF LSEstado=3 THEN

			  --valida si el abonado esta en servicio tecnico
			  PV_VALIDA_ST_PG(LNNumAbonado,LSEstado,LSDescProceso,LSTabla,LSAccion,LSCodOra,LSErrOra);

			  IF LSEstado=3 THEN
			  	 --Valida vigencia en tabla ga_intarcel
				 PV_VALIDA_INTARCEL_PG(LNNumAbonado,LSEstado,LSDescProceso,LSTabla,LSAccion,LSCodOra,LSErrOra);

				 IF LSEstado=3 THEN

					PV_VALIDA_INFACCEL_PG(LNNumAbonado,LSEstado,LSDescProceso,LSTabla,LSAccion,LSCodOra,LSErrOra);

				 	IF LSEstado=3 THEN
						--Valida Vigencia de Limite de Consumo
						PV_VALIDA_LIMCONSUMO_PG(LNNumAbonado,LSEstado,LSDescProceso,LSTabla,LSAccion,LSCodOra,LSErrOra);

						IF LSEstado=3 THEN
						   PV_EVALDEUDA_PR(LNNumAbonado,LSEstado,LSDescProceso,LSTabla,LSAccion,LSCodOra,LSErrOra);

						   IF LSEstado=3 THEN
						   	  PV_REVISA_OSPENDIENTES(LNNumAbonado,LSEstado,LSDescProceso,LSTabla,LSAccion,LSCodOra,LSErrOra);

						   	  IF LSEstado=3 THEN

								 --inscribir OOSS BATCH
								 PV_INSCRIBE_OS_BATCH_PG(LNNumAbonado,LNNumOS,LSEstado,LSDescProceso,LSTabla,LSAccion,LSCodOra,LSErrOra);

								 IF LSEstado=3 THEN
								 	NULL;
								 END IF; --PV_INSCRIBE_OOSS_BATCH

						   	  END IF; -- PV_VALIDA_LIMCONSUMO_PG
						   END IF; -- PV_VALIDA_LIMCONSUMO_PG

						END IF; -- PV_VALIDA_LIMCONSUMO_PG

					END IF; -- PV_VALIDA_INFACCEL_PG

				 END IF; --PV_VALIDA_INTARCEL_PG

			  END IF;--PV_VALIDA_ST_PG

		   END IF; --PV_VALIDA_USO_PG

		END IF;

		IF LSEstado<>3 THEN
		   ROLLBACK;
		END IF;

		PV_ACTUALIZA_ESTADO_PR( LENumCelular,LEIdProseso,1,2,LNEstado,LVDescProceso,LVTabla,LVAccion,LVCodOra,LVErrOra);

		IF LSEstado=3 THEN
		   PV_ACTUALIZA_PROCESO_PR( LENumCelular,LEIdProseso,2,3,LNNumOS,'PROCESO EXITOSO',NULL,NULL,NULL,NULL);

		   LSDescProceso:='PROCESO EXITOSO';
		   LSTabla	  	:='0';
		   LSAccion	  	:='0';
		   LSCodOra		:='0';
		   LSErrOra		:='0';
		   LSNumOs		:=LNNumOS;

		ELSE
		   PV_ACTUALIZA_PROCESO_PR( LENumCelular,LEIdProseso,2,4,NULL,LSDescProceso,LSTabla,LSAccion,LSCodOra,LSErrOra);

		   LSNumOs		:=0;

		   IF LSCodOra IS NULL THEN
		   	  LSCodOra:='0';
		   END IF;

		   IF LSErrOra IS NULL THEN
		   	  LSErrOra:='0';
		   END IF;

		END IF;

	EXCEPTION
		WHEN OTHERS THEN
			LSCodOra		  :=SQLCODE;
			LSErrOra		  :=SQLERRM;

			LSDescProceso  := PV_DESCERROR_FN(1874);
			LSEstado:=5;
	END;

END PV_BAJA_MASIVA_POSTPAGO_PG;
/
SHOW ERRORS
