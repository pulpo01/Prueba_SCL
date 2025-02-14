CREATE OR REPLACE PROCEDURE        P_INSERTAR_ACTUASERV(
  VP_PRODUCTO IN VARCHAR2 ,
  VP_ACTABO IN VARCHAR2 ,
  VP_TIPSERV IN VARCHAR2 ,
  VP_SERVICIO IN VARCHAR2 ,
  VP_CONCEPTO IN OUT NUMBER ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento de insercion de servicios por actuaciones de la
-- actuacion "Paquetes"
--
-- Los valores del codigo de retorno seran los siguientes :
--         - "0" ; Se inserto correctamente el registro
--         - "4" ; Error en el proceso
--
BEGIN
   INSERT INTO GA_ACTUASERV
              (COD_PRODUCTO,
               COD_ACTABO,
               COD_TIPSERV,
               COD_SERVICIO,
               COD_CONCEPTO)
       VALUES (VP_PRODUCTO,
               VP_ACTABO,
               VP_TIPSERV,
               VP_SERVICIO,
               VP_CONCEPTO);
EXCEPTION
   WHEN OTHERS THEN
        IF SQLCODE = -1 THEN
           NULL;
        ELSE
           VP_ERROR := '4';
        END IF;
END;
/
SHOW ERRORS
