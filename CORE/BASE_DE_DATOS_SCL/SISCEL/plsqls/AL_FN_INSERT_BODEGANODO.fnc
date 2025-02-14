CREATE OR REPLACE FUNCTION AL_FN_INSERT_BODEGANODO  (V_OPERADORA GE_OPERADORA_SCL.COD_OPERADORA_SCL%TYPE,
                                                                                                  V_COD_BODEGANODO AL_BODEGANODO.COD_BODEGANODO%TYPE,
                                                                                                  ACCION NUMBER) RETURN VARCHAR2 IS
           VP_COD_BODEGANODO AL_BODEGANODO.COD_BODEGANODO%TYPE;
           ERROR_SALIDA EXCEPTION;
BEGIN

         SELECT COD_BODEGANODO
         INTO VP_COD_BODEGANODO
         FROM GE_OPERADORA_SCL
     WHERE COD_OPERADORA_SCL = V_OPERADORA;

         IF VP_COD_BODEGANODO IS NULL AND ACCION = 1 THEN
            UPDATE  GE_OPERADORA_SCL SET COD_BODEGANODO = V_COD_BODEGANODO
                WHERE COD_OPERADORA_SCL = V_OPERADORA;
                COMMIT;
                RETURN 'TRUE';
         ELSE IF ACCION = 2 THEN
                        UPDATE  GE_OPERADORA_SCL
                        SET COD_BODEGANODO =  NULL
                        WHERE COD_OPERADORA_SCL = V_OPERADORA;
                        COMMIT;
                        RETURN 'TRUE';
                 ELSE
--                      RETURN 'FALSE';
                        RAISE ERROR_SALIDA;
                 END IF;
        END IF;
 EXCEPTION
     WHEN ERROR_SALIDA THEN
           RAISE_APPLICATION_ERROR(-20101, 'FALSE');
    WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR(-20100, 'ERROR ' || TO_CHAR(SQLCODE) || ': ' || SQLERRM);

END;
/
SHOW ERRORS
