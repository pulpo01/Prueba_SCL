CREATE OR REPLACE PROCEDURE        P_VALIDA_BORRACONC(
  VP_CONCEPTO IN NUMBER ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento de validacion de borrado de conceptos
--
-- Los valores del codigo de retorno seran los siguientes :
--         - "0" ; El concepto puede ser borrado
--         - "1" ; El concepto esta asociado a otro registro de actuaserv
--         - "4" ; Error en el proceso
--
 VAR1 NUMBER;
BEGIN
   SELECT COUNT(*)
     INTO VAR1
     FROM GA_ACTUASERV
    WHERE COD_CONCEPTO = VP_CONCEPTO;
   IF VAR1 > 1 THEN
      VP_ERROR := '1';
   END IF;
EXCEPTION
   WHEN OTHERS THEN
        VP_ERROR := '4';
END;
/
SHOW ERRORS
