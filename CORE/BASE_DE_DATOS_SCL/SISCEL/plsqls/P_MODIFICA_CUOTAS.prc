CREATE OR REPLACE PROCEDURE        P_MODIFICA_CUOTAS(
  VP_ABONADO IN NUMBER ,
  VP_CLIENTE IN NUMBER ,
  VP_PROC IN OUT VARCHAR2 ,
  VP_TABLA IN OUT VARCHAR2 ,
  VP_ACT IN OUT VARCHAR2 ,
  VP_SQLCODE IN OUT VARCHAR2 ,
  VP_SQLERRM IN OUT VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento que realiza la modificacion del cliente en las tablas
-- de cuotas al rechazar una venta de distribuidor
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
BEGIN
   VP_PROC := 'P_MODIFICA_CUOTAS';
   VP_TABLA := 'FA_CABCUOTAS';
   VP_ACT := 'U';
   UPDATE FA_CABCUOTAS
      SET COD_CLIENTE = VP_CLIENTE
    WHERE NUM_ABONADO = VP_ABONADO;
EXCEPTION
   WHEN OTHERS THEN
 VP_SQLCODE := SQLCODE;
 VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
