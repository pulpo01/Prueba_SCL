CREATE OR REPLACE procedure PV_PRC_INS_CIORSERV_PR
(VP_COD_OS        IN VARCHAR2,
 VP_NUM_ABONADO   IN NUMBER,
 VP_COD_PRODUCTO  IN NUMBER,
 VP_NOM_USUARIO   IN VARCHAR2,
 VP_NUM_OS                OUT NUMBER,
 VP_RESULTADO     OUT NUMBER,
 VP_SQLCODE               OUT VARCHAR2,
 VP_SQLERRM               OUT VARCHAR2  )
IS
  V_NUM_OS        CI_ORSERV.NUM_OS%TYPE;
  ERROR_PROCESO           EXCEPTION;


BEGIN
  --Pl que ejecutara la orden de servicio, es decir insertara en la tabla
  --CI_ORSERV

  VP_RESULTADO := 0;

         SELECT CI_SEQ_NUMOS.NEXTVAL
         INTO VP_NUM_OS
         FROM DUAL;

         INSERT INTO CI_ORSERV
           (NUM_OS,
                COD_OS,
                PRODUCTO,
                TIP_INTER,
                COD_INTER,
                USUARIO,
                FECHA,
                COMENTARIO)
         VALUES
           (VP_NUM_OS,
            VP_COD_OS,
                VP_COD_PRODUCTO,
                1,
                VP_NUM_ABONADO,
                VP_NOM_USUARIO,
                SYSDATE,
                ' ');


     VP_RESULTADO := 1;

    EXCEPTION
    WHEN ERROR_PROCESO THEN
         VP_SQLCODE      := SQLCODE;
         VP_SQLERRM      := SQLERRM;
                 VP_RESULTADO    := 0;
         WHEN OTHERS THEN
              VP_RESULTADO := 0;
              VP_SQLCODE      := SQLCODE;
              VP_SQLERRM      := SQLERRM;


END PV_PRC_INS_CIORSERV_PR ;
/
SHOW ERRORS
