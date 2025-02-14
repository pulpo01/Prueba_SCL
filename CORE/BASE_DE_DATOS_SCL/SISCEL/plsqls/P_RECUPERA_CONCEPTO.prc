CREATE OR REPLACE PROCEDURE        P_RECUPERA_CONCEPTO(
  VP_PRODUCTO IN NUMBER ,
  VP_TIPSERV IN VARCHAR2 ,
  VP_SERVICIO IN VARCHAR2 ,
  VP_CONCEPTO IN OUT NUMBER ,
  VP_CONCFACT IN OUT NUMBER ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
--
-- Recuperacion del codigo de concepto del servicio modificado
--
-- Los valores del codigo de retorno seran los siguientes :
--         - "0" ; Se recupero algun tipo de concepto
--         - "1" ; No existe ningun concepto asociado al servicio modificado
--         - "4" ; Error en el proceso
--
BEGIN
   VP_ERROR := '1';
   BEGIN
     SELECT COD_CONCEPTO
       INTO VP_CONCEPTO
       FROM GA_ACTUASERV
      WHERE COD_PRODUCTO = VP_PRODUCTO
        AND COD_TIPSERV  = VP_TIPSERV
        AND COD_SERVICIO = VP_SERVICIO
        AND COD_ACTABO <> 'FA'
 AND ROWNUM = 1;
     VP_ERROR := '0';
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
          NULL;
     WHEN OTHERS THEN
          VP_ERROR := '4';
   END;
   IF VP_ERROR <> '4' THEN
      BEGIN
        SELECT COD_CONCEPTO
          INTO VP_CONCFACT
          FROM GA_ACTUASERV
         WHERE COD_PRODUCTO = VP_PRODUCTO
           AND COD_TIPSERV  = VP_TIPSERV
           AND COD_SERVICIO = VP_SERVICIO
           AND COD_ACTABO   = 'FA';
        VP_ERROR := '0';
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
             NULL;
        WHEN OTHERS THEN
             VP_ERROR := '4';
      END;
   END IF;
EXCEPTION
   WHEN OTHERS THEN
        VP_ERROR := '4';
END;
/
SHOW ERRORS
