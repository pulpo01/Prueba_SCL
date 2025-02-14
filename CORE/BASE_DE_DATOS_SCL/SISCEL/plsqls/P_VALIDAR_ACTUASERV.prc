CREATE OR REPLACE PROCEDURE        P_VALIDAR_ACTUASERV(
  VP_PRODUCTO IN VARCHAR2 ,
  VP_ACTABO IN VARCHAR2 ,
  VP_TIPSERV IN VARCHAR2 ,
  VP_SERVICIO IN VARCHAR2 ,
  VP_CONCEPTO IN OUT NUMBER ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento de validacion de conceptos ya creados
--
-- Los valores del codigo de retorno seran los siguientes :
--         - "0" ; Se encontro el concepto para el servicio
--         - "1" ; El concepto para el servicio no se encuentra creado
--         - "4" ; Error en el proceso
--
BEGIN
   SELECT COD_CONCEPTO
     INTO VP_CONCEPTO
     FROM GA_ACTUASERV
    WHERE COD_PRODUCTO = VP_PRODUCTO
      AND COD_TIPSERV  = VP_TIPSERV
      AND COD_SERVICIO = VP_SERVICIO
      AND COD_ACTABO <> VP_ACTABO
      AND COD_ACTABO <> 'FA'
      AND ROWNUM = 1;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
        VP_ERROR := '1';
   WHEN OTHERS THEN
        VP_ERROR := '4';
END;
/
SHOW ERRORS
