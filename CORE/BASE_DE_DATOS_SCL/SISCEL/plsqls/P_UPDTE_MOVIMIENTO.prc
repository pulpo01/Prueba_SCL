CREATE OR REPLACE PROCEDURE        P_UPDTE_MOVIMIENTO(
  VP_PRODUCTO IN NUMBER ,
  VP_ABONADO IN NUMBER ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento de actualizacion de movimientos a centrales
-- generados por transacciones de ventas incompletas.
--
-- Los valores del codigo de retorno (VP_ERROR), seran los siguientes :
--         - "0" ; Los movimientos han sido actualizados correctamente
--         - "4" ; Error en el proceso interno
--
BEGIN
    IF VP_PRODUCTO = 1 THEN
       UPDATE ICC_MOVIMIENTO
          SET COD_ESTADO = 10
        WHERE NUM_ABONADO = VP_ABONADO;
    ELSIF VP_PRODUCTO = 2 THEN
       UPDATE ICB_MOVIMIENTO
          SET COD_ESTADO = 10
        WHERE NUM_ABONADO = VP_ABONADO;
    ELSIF VP_PRODUCTO = 3 THEN
       UPDATE ICR_MOVIMIENTO
          SET COD_ESTADO = 10
        WHERE NUM_ABONADO = VP_ABONADO;
    ELSIF VP_PRODUCTO = 4 THEN
       UPDATE ICM_MOVIMIENTO
          SET COD_ESTADO = 10
        WHERE NUM_ABONADO = VP_ABONADO;
    END IF;
EXCEPTION
   WHEN OTHERS THEN
        VP_ERROR := '4';
END;
/
SHOW ERRORS
