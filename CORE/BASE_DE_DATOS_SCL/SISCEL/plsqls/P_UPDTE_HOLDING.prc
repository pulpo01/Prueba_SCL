CREATE OR REPLACE PROCEDURE        P_UPDTE_HOLDING(
  VP_PRODUCTO IN NUMBER ,
  VP_HOLDING IN NUMBER ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento de actualizacion de datos de holdings
-- afectados por transacciones de ventas incompletas.
--
-- Los valores del codigo de retorno (VP_ERROR), seran los siguientes :
--         - "0" ; Los holdings han sido actualizados correctamente
--         - "4" ; Error en el proceso interno
--
BEGIN
    UPDATE GA_HOLDING
       SET NUM_ABONADOS = NUM_ABONADOS - 1
      WHERE COD_PRODUCTO = VP_PRODUCTO
        AND COD_HOLDING  = VP_HOLDING;
EXCEPTION
   WHEN OTHERS THEN
        VP_ERROR := '4';
END;
/
SHOW ERRORS
