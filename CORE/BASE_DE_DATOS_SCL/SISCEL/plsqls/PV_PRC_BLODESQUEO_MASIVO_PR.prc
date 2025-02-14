CREATE OR REPLACE procedure PV_PRC_BLODESQUEO_MASIVO_PR
(VP_COD_OS         IN VARCHAR2,
 VP_RESULTADO     OUT INTEGER,
 VP_SQLCODE       OUT VARCHAR2,
 VP_SQLERRM       OUT VARCHAR2  )
IS
  V_NUM_ABONADO           ICC_MOVIMIENTO.NUM_ABONADO%TYPE;
  V_COD_ACTABO            ICC_MOVIMIENTO.COD_ACTABO%TYPE;
  V_NOM_USUARIO           ICC_MOVIMIENTO.NOM_USUARORA%TYPE;
  V_CAUSA                 ICC_MOVIMIENTO.COD_SUSPREHA%TYPE;
  V_COD_OS                PV_INTERFAZ_PREPAGO_TO.COD_OS%TYPE;
  V_FECEJE_OS             PV_INTERFAZ_PREPAGO_TO.FEC_EJECUCION%TYPE;
  V_NUM_OS                CI_ORSERV.NUM_OS%TYPE;
  V_NUMTRANSACABO         GA_TRANSACABO.NUM_TRANSACCION%TYPE:=NULL;
  ERROR_PROCESO           EXCEPTION;

  VP_COD_OS_AUX           CI_TIPORSERV.COD_OS%TYPE;

  g_sNumMov               ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE;
  sEstado                 GED_PARAMETROS.VAL_PARAMETRO%TYPE;
  LN_CANTIDAD             NUMBER(2);

  --CURSOR C1 (LN_COD_ESTADO   PV_INTERFAZ_PREPAGO_TO.COD_ESTADO%TYPE)   IS
  CURSOR C1  IS
  SELECT NUM_ABONADO,FEC_EJECUCION, COD_ACTABO, NOM_USUARIO, COD_CAUSA,COD_OS
  FROM   PV_INTERFAZ_PREPAGO_TO    
  WHERE  COD_ESTADO = 0 and cod_actabo IN ('BQ','DQ') --Abonados preparados para procesar
  AND    FEC_EJECUCION <= SYSDATE;


BEGIN
  --Pl que permitirá bloquear o desbloquear un abonados en forma masiva,
  --debera leer la tabla de interfaces indidividual PV_INTERFAZ_BLODESQUEO_TO
  --y serán procesados los que cumplan la condicion de procesar y la fecha
  --sea igual o menor al sysdate.
  --Por ultimo deberá ejecutar la orden de servicio llamando al pl PV_PRC_INS_CIORSERV_PR
  --Y actualizar la fecha de proceso y el codigo estado de la tabla interfaces.
    BEGIN
        
        
        VP_RESULTADO := 0;

                
                OPEN C1;
                LOOP
                        FETCH C1 INTO V_NUM_ABONADO,V_FECEJE_OS,V_COD_ACTABO,V_NOM_USUARIO,V_CAUSA,V_COD_OS  ;
                        EXIT WHEN C1%NOTFOUND;

                                PV_PRC_BLODESQUEO_PR(V_NUM_ABONADO,V_COD_ACTABO,V_COD_OS,V_NOM_USUARIO,0,V_CAUSA,
                                                     VP_RESULTADO,VP_SQLCODE,VP_SQLERRM,V_NUMTRANSACABO);

                                IF VP_RESULTADO = 1 THEN

                                         SELECT num_movimiento
                                        INTO g_sNumMov
                                        FROM icc_movimiento
                                        WHERE num_abonado = V_NUM_ABONADO
                                        AND cod_actabo = V_COD_ACTABO
                                        AND fec_ingreso IN (SELECT MAX(fec_ingreso)
                                                            FROM icc_movimiento
                                                            WHERE num_Abonado = V_NUM_ABONADO
                                                            AND cod_actabo = V_COD_ACTABO);


                                        SELECT COD_OS
                                        INTO VP_COD_OS_AUX
                                        FROM CI_TIPORSERV
                                        WHERE COD_TIPMODI = V_COD_ACTABO
                                        AND COD_OS =  V_COD_OS;


                                        PV_PRC_INS_CIORSERV_PR(VP_COD_OS_AUX,V_NUM_ABONADO, 1, V_NOM_USUARIO,V_NUM_OS, VP_RESULTADO, VP_SQLCODE, VP_SQLERRM);

                                           SELECT val_parametro
                                        INTO sEstado
                                        FROM GED_PARAMETROS
                                        WHERE nom_parametro = 'COD_EST_TRX_PEND'
                                        AND cod_modulo = 'GA'
                                        AND cod_producto = 1;

                                        UPDATE CI_ORSERV
                                        SET        num_movimiento = g_sNumMov,
                                                   cod_estado = sEstado
                                        WHERE  num_os = V_NUM_OS;

                                        UPDATE PV_INTERFAZ_PREPAGO_TO
                                        SET    COD_ESTADO = 1,  FEC_PROCESO = SYSDATE, NOM_USUARIO= V_NOM_USUARIO,
                                                   NUM_OS = V_NUM_OS --Codigo 1 = procesada
                                        WHERE  NUM_ABONADO = V_NUM_ABONADO
                                        AND    COD_ACTABO  = V_COD_ACTABO
                                        AND    FEC_EJECUCION = V_FECEJE_OS
                                        AND    COD_OS = V_COD_OS;

                                ELSE

                                        UPDATE PV_INTERFAZ_PREPAGO_TO
                                        SET    COD_ESTADO = 2,  FEC_PROCESO = SYSDATE, --Codigo 2= error
                                                   NOM_USUARIO= V_NOM_USUARIO,NUM_OS = V_NUM_OS
                                        WHERE  NUM_ABONADO = V_NUM_ABONADO
                                        AND    COD_ACTABO  = V_COD_ACTABO
                                        AND    FEC_EJECUCION = V_FECEJE_OS
                                        AND    COD_OS      = V_COD_OS;

                                END IF;

                                COMMIT;
                END LOOP;
                CLOSE C1;


            VP_RESULTADO := 1;
            COMMIT;

        EXCEPTION
            WHEN ERROR_PROCESO THEN
                 VP_SQLCODE      := SQLCODE;
                 VP_SQLERRM      := SQLERRM;
                 VP_RESULTADO    := 0;
            WHEN OTHERS THEN
                 VP_RESULTADO := 0;
                 VP_SQLCODE      := SQLCODE;
                 VP_SQLERRM      := SQLERRM;
    END;
END PV_PRC_BLODESQUEO_MASIVO_PR ; 
/
SHOW ERRORS
