CREATE OR REPLACE PROCEDURE        P_DELETE_ABORENT(
  VP_ABONADO IN NUMBER ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento de borrado de abonados rent a phone generados de
-- transacciones de ventas incompletas.
--
-- Los valores del codigo de retorno (VP_ERROR), seran los siguientes :
--         - "0" ; Los abonados han sido borrados correctamente
--         - "4" ; Error en el proceso interno
--
BEGIN
    DELETE GA_ABORENT
     WHERE NUM_ABONADO = VP_ABONADO;
    DELETE GA_PERABORENT
     WHERE NUM_ABONADO = VP_ABONADO;
    DELETE GA_GARANRENT
     WHERE NUM_ABONADO = VP_ABONADO;
EXCEPTION
   WHEN OTHERS THEN
        VP_ERROR := '4';
END;
/
SHOW ERRORS
