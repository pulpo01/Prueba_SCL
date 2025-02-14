CREATE OR REPLACE PROCEDURE        P_UPDTE_EMPRESA(
  VP_PRODUCTO IN NUMBER ,
  VP_EMPRESA IN NUMBER ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento de actualizacion de datos de empresa
-- afectados por transacciones de ventas incompletas.
--
-- Los valores del codigo de retorno (VP_ERROR), seran los siguientes :
--         - "0" ; Las empresas han sido actualizadas correctamente
--         - "4" ; Error en el proceso interno
--
BEGIN
    UPDATE GA_EMPRESA
       SET NUM_ABONADOS = NUM_ABONADOS - 1
      WHERE COD_PRODUCTO = VP_PRODUCTO
        AND COD_EMPRESA  = VP_EMPRESA;
EXCEPTION
   WHEN OTHERS THEN
        VP_ERROR := '4';
END;
/
SHOW ERRORS
