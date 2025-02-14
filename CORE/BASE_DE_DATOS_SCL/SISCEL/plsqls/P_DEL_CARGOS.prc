CREATE OR REPLACE PROCEDURE        P_DEL_CARGOS(
  VP_ABONADO IN NUMBER ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento de borrado de cargos generados en
-- transacciones de ventas incompletas.
--
-- Los valores del codigo de retorno (VP_ERROR), seran los siguientes :
--         - "0" ; Los cargos han sido borrados correctamente
--         - "4" ; Error en el proceso interno
--
BEGIN
    DELETE GE_CARGOS
     WHERE NUM_ABONADO  = VP_ABONADO;
EXCEPTION
   WHEN OTHERS THEN
        VP_ERROR := '4';
END;
/
SHOW ERRORS
