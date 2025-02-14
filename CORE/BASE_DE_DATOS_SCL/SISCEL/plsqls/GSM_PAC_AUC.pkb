CREATE OR REPLACE PACKAGE BODY Gsm_Pac_Auc IS
-- *************************************************************
-- * Paquete            : GSM_PAC_AUC
-- * Descripción        : Subsistema de Gestión de Simcard.
-- * Fecha de creación  : Noviembre 2002
-- * Responsable        : Maritza Tapia A.
-- * Versión            : 1.1 Incidencia RA-200602060706 IGOR SANCHEZ BUSTOS 14/02/2006
-- *************************************************************


PROCEDURE P_INSERTA_ICC(v_solicitud_auc IN      GSM_SOLICITUD_AUC_TO%ROWTYPE) IS


        TN_cod_actabo    ICC_MOVIMIENTO.COD_ACTABO%TYPE;
        TN_cod_actuacion ICC_MOVIMIENTO.COD_ACTUACION%TYPE;
        TV_tip_tecno     ICC_MOVIMIENTO.TIP_TECNOLOGIA%TYPE;
        v_serie_simcard  VARCHAR2(150);
        v_glosa_error    VARCHAR2(20);
        v_retorno        VARCHAR2(512);
        V_TABLA          VARCHAR2(200);
		CN_zero          PLS_INTEGER:=0;
        CN_uno           PLS_INTEGER:=1;
		CV_des_respuesta CONSTANT VARCHAR2(20):='PENDIENTE';
		CV_cod_modulo CONSTANT VARCHAR2(20):='GS';
        ERROR_PROCESO_GENERAL EXCEPTION;
        v_i         INTEGER:=0;
        TYPE Tip_NumSimcard IS TABLE OF GSM_SIMCARD_TO.NUM_SIMCARD%TYPE INDEX BY BINARY_INTEGER;
        TYPE Tip_CodCentral IS TABLE OF ICG_CENTRAL.COD_CENTRAL%TYPE INDEX BY BINARY_INTEGER;
        TYPE Tip_Secuencia IS TABLE OF ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE INDEX BY BINARY_INTEGER;
        c_NumSimcard  Tip_NumSimcard;
        c_CodCentral  Tip_CodCentral;
		c_NumMovimiento Tip_Secuencia;



---------------------------------------------------------------------------------------------
-- CURSOR
---------------------------------------------------------------------------------------------

CURSOR Parametros IS
                SELECT  COD_IDENTIFICADOR, DES_PARAMETRO, COD_PARAMETRO
                FROM  GSM_PARAMETROS_TD
                WHERE COD_IDENTIFICADOR = 'VALACTAUC' AND (COD_PARAMETRO = 'TIP_TECNO' OR COD_PARAMETRO = 'ALTA' OR COD_PARAMETRO = 'ACTABO');

BEGIN
        V_TABLA := 'GSM_PARAMETROS_TD';
        FOR Param IN Parametros LOOP
                IF Param.COD_PARAMETRO =  'ALTA' THEN
                        TN_cod_actuacion := Param.DES_PARAMETRO;
                ELSE
                         IF Param.COD_PARAMETRO =  'TIP_TECNO' THEN
                                                TV_tip_tecno := Param.DES_PARAMETRO;
                        ELSE
                                                IF  Param.COD_PARAMETRO =  'ACTABO' THEN
                                                        TN_cod_actabo:= Param.DES_PARAMETRO;
                                                ELSE
                                                        v_retorno := 'Parametro invalido '|| Param.COD_PARAMETRO;
                                                        RAISE  ERROR_PROCESO_GENERAL;
                                                END IF;
                        END IF;
                END IF;
        END LOOP;

        BEGIN
                V_TABLA := 'ICG_CENTRAL/GSM_SIMCARD_TO';
				/*SELECT a.num_simcard, 89, icc_seq_nummov.NEXTVAL BULK COLLECT INTO c_NumSimcard,	c_CodCentral, c_NumMovimiento
				  FROM GSM_SIMCARD_TO a --, ICG_CENTRAL b
				 WHERE a.num_seq_solicitud = v_solicitud_auc.num_seq_solicitud;*/


				 SELECT a.num_simcard, c.cod_central, icc_seq_nummov.NEXTVAL BULK COLLECT INTO c_NumSimcard,	c_CodCentral, c_NumMovimiento
				  FROM icg_central c, GSM_SIMCARD_TO a
				 WHERE a.num_seq_solicitud = v_solicitud_auc.num_seq_solicitud
				   AND c.cod_hlr = a.cod_hlr
				   AND c.cod_central =
				          (SELECT MAX (x.cod_central)
				             FROM icg_central x
				            WHERE x.cod_producto = 1
				              AND x.cod_tecnologia = 'GSM'
				              AND x.cod_hlr = a.cod_hlr);



				EXCEPTION
                WHEN NO_DATA_FOUND  THEN
                        v_retorno := 'Error en Recuperar las Simcard';
                        RAISE  ERROR_PROCESO_GENERAL;
        END;

        V_TABLA := 'FORALLICCMOVIMIENTO';
		FORALL v_i IN c_NumSimcard.FIRST .. c_NumSimcard.LAST
				INSERT INTO ICC_MOVIMIENTO
				       (num_movimiento, num_abonado, cod_estado, cod_modulo,
				        num_intentos, des_respuesta, cod_actuacion, cod_actabo,
				        nom_usuarora, fec_ingreso, cod_central, num_celular, num_serie,
				        tip_terminal, ind_bloqueo, num_min, tip_tecnologia, icc, imsi
				       )
				VALUES (c_NumMovimiento(v_i), CN_zero, CN_uno, CV_cod_modulo,
				        CN_zero, CV_des_respuesta, TN_cod_actuacion, TN_cod_actabo,
				        USER, SYSDATE, c_codcentral (v_i), CN_zero, '0',
				        'D', CN_zero, 'min', TV_tip_tecno, c_numsimcard (v_i), '*'
				       );


	   V_TABLA := 'FORALLGSM_DET_SOLICITUD_AUC_TO';
	   -- INICIO INCIDENCIA XO-200510190905 C.C.A. 19-10-2005
       FORALL v_j IN c_NumSimcard.FIRST .. c_NumSimcard.LAST --IN 1..v_i
	   -- INICIO INCIDENCIA XO-200510190905 C.C.A. 19-10-2005
						INSERT INTO GSM_DET_SOLICITUD_AUC_TO
						            (num_seq_solicitud_auc, num_simcard,
						             num_movimiento, num_intento, fec_actualizacion, cod_usuario
						            )
						     VALUES (v_solicitud_auc.num_seq_solicitud_auc, c_numsimcard (v_j),
						             c_NumMovimiento(v_j), 0, SYSDATE, USER
						            );

       V_TABLA := 'FORALLGSM_SIMCARD_TO';
	   -- INICIO INCIDENCIA XO-200510190905 C.C.A. 19-10-2005
       FORALL v_k IN c_NumSimcard.FIRST .. c_NumSimcard.LAST --IN 1..v_i
	   -- INICIO INCIDENCIA XO-200510190905 C.C.A. 19-10-2005
                        UPDATE GSM_SIMCARD_TO
                        SET     IND_AUC = 2,
                                COD_ESTADO = 'PA',
                                FEC_ACTUALIZACION = SYSDATE
                        WHERE NUM_SIMCARD = c_numsimcard (v_k);



    EXCEPTION
        WHEN ERROR_PROCESO_GENERAL THEN
        RAISE_APPLICATION_ERROR (-20001,'P_INSERTA_ICC ERROR :' || V_TABLA ||' ' ||v_retorno);
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20002,'P_INSERTA_ICC ERROR : Envio SIMCARDS AUTENTIFICAR EN SIMCARD '|| v_serie_simcard || ' Error :' || V_TABLA || ' '|| TO_CHAR(SQLCODE) || ' ' ||SQLERRM);
END P_INSERTA_ICC;


PROCEDURE P_ACTUALIZA_ICC (v_simcard IN GSM_SIMCARD_TO.num_simcard%TYPE, v_actuacion IN ICC_MOVIMIENTO.COD_ACTUACION%TYPE, v_movimiento IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) IS
-- Proceso : Actualiza el AUC de la SimCard e inserta en histsrico de estados
-- Autor   : Maritza Tapia Alvarez
-- Fecha   : 21 Noviembre de 2002
-- Modificado : 27/08/2004

     v_solicitud      GSM_SIMCARD_TO.num_seq_solicitud%TYPE;
	 v_det_solicitud  GSM_DET_SOLICITUD_AUC_TO%ROWTYPE;
     v_glosa_error              VARCHAR2(20);
     v_retorno                  VARCHAR2(512);
	 CV_AUC CONSTANT  NUMBER(5):= 1500;
     Error_Proceso_General EXCEPTION;
     BEGIN
                  v_retorno:='OK';
                  IF v_simcard = '' OR v_simcard IS NULL THEN
                     v_retorno := 'ERROR : NO SE HA INFORMADO EL NUMERO DE ICC';
                     RAISE  ERROR_PROCESO_GENERAL;
                  END IF;

	              IF v_actuacion = '' OR v_actuacion IS NULL THEN
                     v_retorno := 'ERROR : NO SE HA INFORMADO EL NUMERO DE ICC';
                     RAISE  ERROR_PROCESO_GENERAL;
                  END IF;


				  IF v_actuacion = CV_AUC THEN
			              -- Actualiza AUC de la Simcard
			                  v_retorno := 'ERROR : NO SE HA PODIDO ACTUALIZAR TABLA GSM_SIMCARD_TO PARA '|| v_simcard;
			                  UPDATE GSM_SIMCARD_TO SET IND_AUC ='1',
			                         COD_ESTADO ='DD',
			                         FEC_ACTUALIZACION = SYSDATE
			                  WHERE  NUM_SIMCARD = v_simcard;

			                 --  Recupero numero de solicitud asociada a la Simcard
			                  v_retorno := 'ERROR : NO SE HA PODIDO RECUPERAR DATOS DESDE GSM_SIMCARD_TO PARA '||v_simcard;
			                  SELECT NUM_SEQ_SOLICITUD INTO v_solicitud FROM  GSM_SIMCARD_TO        WHERE NUM_SIMCARD = v_simcard;

			                 --- Actualiza total AUC autentificada
			                  v_retorno := 'ERROR : NO SE HA PODIDO ACTUALIZAR TABLA GSM_SOLICITUD_AUC_TO PARA '|| v_solicitud;
			                 UPDATE GSM_SOLICITUD_AUC_TO
			                 SET    num_cantidad_auc = num_cantidad_auc + 1,
			                        fec_actualizacion = SYSDATE
				             WHERE  num_seq_solicitud = v_solicitud;

							 -- INICIO INCIDENCIA XO-200510190905 C.C.A. 19-10-2005
							   SELECT * INTO v_det_solicitud
       						     FROM GSM_DET_SOLICITUD_AUC_TO
    							WHERE NUM_SIMCARD = v_simcard;

    						 v_retorno := 'ERROR : NO SE HA ELIMINADO REGISTRO EN TABLA GSM_DET_SOLICITUD_AUC_TO '|| v_solicitud;
							  DELETE FROM GSM_DET_SOLICITUD_AUC_TO
							   WHERE NUM_SIMCARD = v_simcard;

							 v_retorno := 'ERROR : NO SE HA ACTUALIZADO TABLA GSM_DET_SOLICITUD_AUC_TH '|| v_solicitud;

							   -- INICIO INCIDENCIA RA-200602060706 INSAB 14/02/2006
							   INSERT INTO GSM_DET_SOLICITUD_AUC_TH
							   (
							   NUM_SEQ_SOLICITUD_AUC,
							   NUM_SIMCARD,
  							   NUM_MOVIMIENTO,
  							   NUM_INTENTO,
  							   COD_ESTADO,
  							   DES_ERROR,
  							   FEC_ACTUALIZACION,
  							   COD_USUARIO
							   )
							   VALUES (
							      v_det_solicitud.NUM_SEQ_SOLICITUD_AUC,
								  v_det_solicitud.NUM_SIMCARD,
								  v_det_solicitud.NUM_MOVIMIENTO,
								  v_det_solicitud.NUM_INTENTO,
								  v_det_solicitud.COD_ESTADO,
								  v_det_solicitud.DES_ERROR,
								  SYSDATE,
								  -- FIN INCIDENCIA RA-200602060706 INSAB 14/02/2006
								  v_det_solicitud.COD_USUARIO);
							 -- FIN INCIDENCIA XO-200510190905 C.C.A. 19-10-2005



				ELSE
			                  v_retorno := 'ERROR : NO SE HA PODIDO ACTUALIZAR TABLA GSM_DETSOL_ANULACION_TO PARA '|| v_simcard;
			                  UPDATE GSM_DETSOL_ANULACION_TO
							  	 SET COD_ESTADO ='AN',
			                         FEC_ACTUALIZACION = SYSDATE
			                  WHERE  NUM_SIMCARD = v_simcard
							    AND	 NUM_MOVIMIENTO =  v_movimiento;

			                 --  Recupero numero de solicitud asociada a la Simcard
			                  v_retorno := 'ERROR : NO SE HA PODIDO RECUPERAR DATOS DESDE GSM_SOL_ANULACION_TO PARA '||v_simcard;

   							  SELECT NUM_SEQ_ANULACION INTO v_solicitud FROM  GSM_DETSOL_ANULACION_TO WHERE NUM_SIMCARD = v_simcard and NUM_MOVIMIENTO = v_movimiento;


			                 --- Actualiza total de Anulaciones
			                  v_retorno := 'ERROR : NO SE HA PODIDO ACTUALIZAR TABLA GSM_SOL_ANULACION_TO PARA '|| v_solicitud;
  			                  UPDATE GSM_SOL_ANULACION_TO
  			                  SET    num_cantidad_anu = num_cantidad_anu + 1,
  			                         fec_actualizacion = SYSDATE
  				              WHERE  num_seq_anulacion = v_solicitud;


							  v_retorno := 'ERROR : GSM_ANULACION_AUC_PKG.GSM_PREFIJOS_RECICLADOS_PR  PARA LA SOLICITUD '|| v_solicitud;
							  Gsm_Anulacion_Auc_Pg.Gsm_Prefijos_Reciclados_Pr(v_simcard);
				END IF;


        EXCEPTION
                  WHEN ERROR_PROCESO_GENERAL THEN
                       RAISE_APPLICATION_ERROR (-20003,'P_ACTUALIZA_ICC ERROR : '|| v_retorno);
                  WHEN NO_DATA_FOUND THEN
                       RAISE_APPLICATION_ERROR (-20004,'P_ACTUALIZA_ICC ERROR : '||v_retorno);
                  WHEN OTHERS THEN
                       RAISE_APPLICATION_ERROR (-20005,'P_ACTUALIZA_ICC ERROR : '||v_retorno ||' ' ||SQLERRM || ' ' || SQLCODE);
END P_ACTUALIZA_ICC;

PROCEDURE P_ACTUALIZAESTADOSICC (v_modulo IN ge_modulos.cod_modulo%TYPE,
v_icc IN GSM_SIMCARD_TO.num_simcard%TYPE, v_icc_nue IN GSM_SIMCARD_TO.num_simcard%TYPE,
v_actabo IN GSM_SIMCARD_TO.cod_estado%TYPE ) IS

                 v_glosa_error    VARCHAR2(20);
                 v_retorno             VARCHAR2(512);
                 cod_estado        VARCHAR2(3);
                 ERROR_PROCESO_GENERAL EXCEPTION;
     BEGIN
	 	          v_retorno:='OK';
                 IF v_modulo IS NULL OR v_modulo = '' THEN
                        v_retorno := 'ERROR : NO SE HA INFORMADO EL MODULO';
                        RAISE  Error_Proceso_General;
                 END IF;
                 IF v_actabo IS NULL OR v_actabo = '' THEN
                        v_retorno := 'ERROR : NO SE HA INFORMADO EL ESTADO';
                        RAISE  Error_Proceso_General;
                 END IF;
                 --Incidencia RA-200511170134, PIC 18-11-2005. Se saca validacion.
                 /*IF v_icc IS NULL OR v_icc = '' THEN
                        v_retorno := 'ERROR : NO SE HA INFORMADO EL NUMERO DE ICC';
                        RAISE  Error_Proceso_General;
                 END IF;*/
                 --Fin Incidencia RA-200511170134.

                 -- Valida que exista estado para el modulo de la ICC
                 BEGIN
                         SELECT COD_ESTADO INTO cod_estado
						   FROM GSM_ESTADOS_TD
						  WHERE COD_MODULO = v_modulo
						    AND COD_ESTADO = v_actabo;
                         EXCEPTION
                               WHEN NO_DATA_FOUND  THEN
                               NULL;
                 END;
                 -- Cambio el estado de la Simcard

                  IF cod_estado IS NOT NULL OR cod_estado <> '' THEN
						UPDATE GSM_SIMCARD_TO
						   SET cod_estado = v_actabo,
						   	   cod_modulo = v_modulo,
							   fec_actualizacion = SYSDATE,
							   cod_usuario = USER
						WHERE  num_simcard = LTRIM(RTRIM(v_icc));


                        IF v_modulo = 'GA' AND  v_actabo = 'SA' THEN
                          IF v_icc_nue IS NOT NULL OR  v_icc_nue <> '' THEN
                                          UPDATE GSM_SIMCARD_TO
                                          	 SET cod_estado = 'AT',
                                                 cod_modulo = v_modulo,
                                                 fec_actualizacion = SYSDATE,
                                                 cod_usuario = USER
                                          WHERE  num_simcard =LTRIM(RTRIM(v_icc));
                           END IF;
                         END IF;

                  END IF;

        EXCEPTION
             WHEN Error_Proceso_General THEN
             	  RAISE_APPLICATION_ERROR (-20006,'P_ACTUALIZAESTADOSICC : ' || v_retorno);
             WHEN NO_DATA_FOUND THEN
			   	  RAISE_APPLICATION_ERROR (-20007,'P_ACTUALIZAESTADOSICC ERROR : datos no encontrados...');
             WHEN OTHERS THEN
			 	  RAISE_APPLICATION_ERROR (-20008,'P_ACTUALIZAESTADOSICC ERROR : '||SQLERRM || ' ' || SQLCODE);
   END P_ACTUALIZAESTADOSICC;

   PROCEDURE P_ERROR_AUC_IC (v_num_solicitud IN GSM_DET_SOLICITUD_AUC_TO.num_seq_solicitud_auc%TYPE) IS
-- Proceso : Verifica el estado de simcard a autentificar en Centrales
-- Autor   : Maritza Tapia Alvarez
-- Fecha   : 10 de junio de 2003
	v_glosa_error VARCHAR2(20);
	v_retorno     VARCHAR2(30);
	v_respuesta   GSM_DET_SOLICITUD_AUC_TO.DES_ERROR%TYPE;
	v_actuacion   NUMBER(5);
	v_estado      ICC_MOVIMIENTO.COD_ESTADO%TYPE;
	v_movimiento  ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE;
	v_intentos    ICC_MOVIMIENTO.NUM_INTENTOS%TYPE;
	-- INCIDENCIA  RA-200602060706   C.C.A.  16-02-2006
	v_simcard	  GSM_SIMCARD_TO.NUM_SIMCARD%TYPE;
	Error_Proceso_General EXCEPTION;

---------------------------------------------------------------------------------------------
-- CURSOR : Recupera prefijos asociados a una solicitud
---------------------------------------------------------------------------------------------
  CURSOR  AUC IS
  SELECT A.NUM_MOVIMIENTO,A.COD_ESTADO, A.NUM_INTENTOS
  -- INCIDENCIA  RA-200602060706   C.C.A.  16-02-2006
  , B.NUM_SIMCARD
  FROM   ICC_MOVIMIENTO A, GSM_SIMCARD_TO B, GSM_SOLICITUD_AUC_TO C
  WHERE  C.NUM_SEQ_SOLICITUD_AUC = v_num_solicitud
  AND    B.NUM_SEQ_SOLICITUD = C.NUM_SEQ_SOLICITUD
  AND    B.IND_AUC = 2
  AND    A.ICC = B.NUM_SIMCARD
  AND    A.COD_ACTUACION = v_actuacion
  ORDER BY  1;

  BEGIN

---------------------------------------------------------------------------------------------
-- Validación  parametros de entrada
---------------------------------------------------------------------------------------------
     v_retorno:='OK';
     IF v_num_solicitud IS NULL OR v_num_solicitud = '' THEN
        v_retorno := 'N° de solicitud no informada';
        RAISE  Error_Proceso_General;
     END IF;

  BEGIN
   SELECT TO_NUMBER(des_parametro)
   INTO   v_actuacion
   FROM gsm_parametros_td
   WHERE cod_identificador = 'VALACTAUC'
   AND cod_parametro = 'ALTA'
   AND cod_vigencia = '1';
   EXCEPTION
     WHEN NO_DATA_FOUND THEN

   v_retorno := 'No existe parametro de codigo de actuacion';
   RAISE  Error_Proceso_General;
  END;


 FOR R IN AUC
 LOOP
 EXIT WHEN AUC%NOTFOUND;
	v_estado := R.COD_ESTADO;
	v_movimiento := R.NUM_MOVIMIENTO;
	v_intentos := R.NUM_INTENTOS;
	-- INCIDENCIA  RA-200602060706   C.C.A.  16-02-2006
	v_simcard  := R.NUM_SIMCARD;

  /* select IC_ESTADO_PROVISIONAMIENTO_FN (v_movimiento)
   into v_respuesta
   from dual;*/
   v_respuesta := IC_ESTADO_PROVISIONAMIENTO_FN (v_movimiento);

   UPDATE GSM_DET_SOLICITUD_AUC_TO
   SET   DES_ERROR = SUBSTR(v_respuesta,1,2048),
         COD_ESTADO = v_estado,
		 COD_USUARIO = USER,
		 FEC_ACTUALIZACION = SYSDATE
   -- INICIO INCIDENCIA  RA-200602060706   C.C.A.  16-02-2006
   WHERE NUM_SIMCARD = v_simcard
     AND NUM_SEQ_SOLICITUD_AUC = v_num_solicitud;
	 -- num_movimiento = v_movimiento;
   --  FIN INCIDENCIA  RA-200602060706   C.C.A.  16-02-2006

    END LOOP;

        EXCEPTION
             WHEN Error_Proceso_General THEN
                 RAISE_APPLICATION_ERROR (-20009,v_retorno);
             WHEN NO_DATA_FOUND THEN
               RAISE_APPLICATION_ERROR (-20010,'ERROR : datos no encontrados...');
             WHEN OTHERS THEN
       RAISE_APPLICATION_ERROR (-20011,'error'||' '||SQLERRM || ' ' || SQLCODE );
  END P_ERROR_AUC_IC;


PROCEDURE P_SERVICIO_MOVIMIENTO(p_Num_Movimiento IN VARCHAR2 ,p_Servicio IN VARCHAR2)
IS
    resul VARCHAR2(200);
	Error_Proceso_General EXCEPTION;
	BEGIN
	  resul := IC_SERVICIO_MOVIMIENTO_FN( p_Num_Movimiento, p_Servicio);
	  IF resul IS NULL OR resul = '' OR resul <> 'OK' THEN
	  	  RAISE  Error_Proceso_General;
	  END IF;

	EXCEPTION
	WHEN Error_Proceso_General THEN
         RAISE_APPLICATION_ERROR (-20012,'Respuesta Función'|| resul);
    WHEN OTHERS THEN
         RAISE_APPLICATION_ERROR (-20013,'error en función'||' '||SQLERRM || ' ' || SQLCODE);
END P_SERVICIO_MOVIMIENTO;

END Gsm_Pac_Auc;
/
SHOW ERRORS
