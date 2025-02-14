CREATE OR REPLACE PROCEDURE PV_INSCIORSERV_PR
(
VP_NUM_OS                 IN NUMBER,
VP_COD_OS                 IN VARCHAR2,
VP_COD_PRODUCTO   IN NUMBER,
VP_TIP_INTER      IN NUMBER,
VP_NUM_ABONADO    IN NUMBER,
VP_USUARIO                IN VARCHAR2,
VP_COMENTARIO     IN VARCHAR2,
VP_RESULTADO      OUT NUMBER,
VP_SQLCODE        OUT VARCHAR2,
VP_SQLERRM        OUT VARCHAR2
-- Inicio modificacion by SAQL/Soporte 13/04/2006 - RA-200602210820
, VP_FECHA          IN DATE := NULL
-- Fin modificacion by SAQL/Soporte 13/04/2006 - RA-200602210820
)
/******************************************************************************
   Nombre        :     PV_INSCIORSERV_PR
   AREA          :     Desarrollo Post-Venta POSTVENTA
   Creado                :     17 noviembre 2003  Proyecto
                                           Patrcica Castro R.
   Comentarios   :     Proyecto Traspaso Abonado Prepago


MODIFCIACIONES
   Fecha                                Comentarios

******************************************************************************/
IS
ERROR_PROCESO           EXCEPTION;
begin
         VP_RESULTADO := 0;

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
                VP_USUARIO,
                -- Inicio modificacion by SAQL/Soporte 13/04/2006 - RA-200602210820
                --SYSDATE,
                VP_FECHA,
                -- Fin modificacion by SAQL/Soporte 13/04/2006 - RA-200602210820
                VP_COMENTARIO);

                VP_RESULTADO := 1;

 EXCEPTION
    WHEN ERROR_PROCESO THEN
         VP_SQLCODE      := SQLCODE;
         VP_SQLERRM      := SQLERRM;
         VP_RESULTADO    := 4;
         WHEN OTHERS THEN
              VP_RESULTADO := 4;
              VP_SQLCODE      := SQLCODE;
              VP_SQLERRM      := SQLERRM;


END PV_INSCIORSERV_PR ;
/
SHOW ERRORS
