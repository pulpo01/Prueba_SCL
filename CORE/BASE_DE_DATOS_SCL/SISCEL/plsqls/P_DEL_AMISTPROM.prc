CREATE OR REPLACE PROCEDURE        P_DEL_AMISTPROM(
  VP_ABONADO IN NUMBER ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento de borrado al abonado amistar de promociones
-- afectados por transacciones de ventas incompletas.
--
-- Los valores del codigo de retorno (VP_ERROR), seran los siguientes :
--         - "0" ; Los seguros han sido borrados correctamente
--         - "4" ; Error en el proceso interno
--
BEGIN
    DELETE GA_ABOAMI_PROM
     WHERE NUM_ABONADO  = VP_ABONADO;
EXCEPTION
   WHEN OTHERS THEN
        VP_ERROR := '4';
END;
/
SHOW ERRORS
