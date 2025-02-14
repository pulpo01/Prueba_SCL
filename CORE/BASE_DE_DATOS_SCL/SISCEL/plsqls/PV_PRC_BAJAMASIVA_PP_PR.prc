CREATE OR REPLACE PROCEDURE PV_PRC_BAJAMASIVA_PP_PR
is

 CURSOR C1 IS
   SELECT NUM_ABONADO, FEC_EJECUCION, COD_ESTADO, COD_ACTABO, FEC_PROCESO, NOM_USUARIO, NUM_OS,COD_CAUSA
     FROM PV_INTERFAZ_PREPAGO_TO
    WHERE COD_ESTADO = 0
          AND COD_ACTABO = 'BP';
--          FOR UPDATE NOWAIT;   Prueba del 10062003

  V_NUM_ABONADO          PV_INTERFAZ_PREPAGO_TO.NUM_ABONADO%TYPE;
  V_FEC_EJECUCION        PV_INTERFAZ_PREPAGO_TO.FEC_EJECUCION%TYPE;
  V_COD_ESTADO           PV_INTERFAZ_PREPAGO_TO.COD_ESTADO%TYPE;
  V_COD_ACTABO           PV_INTERFAZ_PREPAGO_TO.COD_ACTABO%TYPE;
  V_FEC_PROCESO          PV_INTERFAZ_PREPAGO_TO.FEC_PROCESO%TYPE;
  V_NOM_USUARIO          PV_INTERFAZ_PREPAGO_TO.NOM_USUARIO%TYPE;
  V_NUM_OS               PV_INTERFAZ_PREPAGO_TO.NUM_OS%TYPE;
  V_COD_CAUSA            PV_INTERFAZ_PREPAGO_TO.COD_CAUSA%TYPE;
  V_NUM_TRANSACCION      GA_TRANSACABO.NUM_TRANSACCION%TYPE;
  V_COD_RETORNO          GA_TRANSACABO.COD_RETORNO%TYPE;

begin

   OPEN C1;
   LOOP
      FETCH C1 INTO V_NUM_ABONADO, V_FEC_EJECUCION, V_COD_ESTADO, V_COD_ACTABO,
                                        V_FEC_PROCESO, V_NOM_USUARIO, V_NUM_OS,V_COD_CAUSA;
          EXIT WHEN C1%NOTFOUND;

                        SELECT GA_SEQ_TRANSACABO.NEXTVAL
                        INTO V_NUM_TRANSACCION
                        FROM DUAL;

                        PV_PR_BAJA_PREPAGO_PP_PR(V_NUM_TRANSACCION,V_NUM_ABONADO,V_COD_ACTABO,V_NOM_USUARIO,V_COD_CAUSA,0);

               BEGIN

                        SELECT COD_RETORNO
                        INTO V_COD_RETORNO
                        FROM GA_TRANSACABO
                        WHERE NUM_TRANSACCION = V_NUM_TRANSACCION;

                        IF V_COD_RETORNO = 0 THEN
                            UPDATE PV_INTERFAZ_PREPAGO_TO
                                   SET COD_ESTADO = 1
                                 WHERE NUM_ABONADO   = V_NUM_ABONADO
                                   AND FEC_EJECUCION = V_FEC_EJECUCION
                                   AND COD_ACTABO    = V_COD_ACTABO;


                        ELSE
                            UPDATE PV_INTERFAZ_PREPAGO_TO
                                   SET COD_ESTADO = 2
                                 WHERE NUM_ABONADO   = V_NUM_ABONADO
                                   AND FEC_EJECUCION = V_FEC_EJECUCION
                                   AND COD_ACTABO    = V_COD_ACTABO;

                        END IF;

                        DELETE GA_TRANSACABO WHERE NUM_TRANSACCION = V_NUM_TRANSACCION;

                        COMMIT;
                EXCEPTION
                              WHEN NO_DATA_FOUND THEN
                                 NULL;
                              WHEN OTHERS THEN
                                 NULL;
                END;

   END LOOP;
   CLOSE C1;



end PV_PRC_BAJAMASIVA_PP_PR;
/
SHOW ERRORS
