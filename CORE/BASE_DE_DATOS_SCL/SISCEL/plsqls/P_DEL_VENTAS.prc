CREATE OR REPLACE PROCEDURE        P_DEL_VENTAS(
  VP_VENTA IN NUMBER ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento de borrado de ventas incompletas.
--
-- Los valores del codigo de retorno (VP_ERROR), seran los siguientes :
--         - "0" ; Los seguros han sido borrados correctamente
--         - "4" ; Error en el proceso interno
--
BEGIN
    DELETE GA_VENTAS
     WHERE NUM_VENTA  = VP_VENTA;
    DELETE GA_DOCVENTA
     WHERE NUM_VENTA = VP_VENTA;
    DELETE GA_DET_PRELIQ
     WHERE NUM_VENTA = VP_VENTA;
    DELETE GA_PRELIQUIDACION
    WHERE NUM_VENTA  = VP_VENTA;
EXCEPTION
   WHEN OTHERS THEN
 IF SQLCODE = -2292 THEN
    NULL;
        ELSE
           VP_ERROR := '4';
        END IF;
END;
/
SHOW ERRORS
