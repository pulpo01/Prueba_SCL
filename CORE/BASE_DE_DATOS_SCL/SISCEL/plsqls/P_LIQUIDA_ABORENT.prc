CREATE OR REPLACE PROCEDURE        P_LIQUIDA_ABORENT(
  VP_ALQUILER IN NUMBER ,
  VP_PROC IN OUT VARCHAR2 ,
  VP_TABLA IN OUT VARCHAR2 ,
  VP_ACT IN OUT VARCHAR2 ,
  VP_SQLCODE IN OUT VARCHAR2 ,
  VP_SQLERRM IN OUT VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento que refleja la liquidacion de abonados roaming marcando
-- la misma en las tablas de interfase con tarificacion y facturacion
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
BEGIN
   VP_PROC := 'P_LIQUIDA_ABORENT';
   VP_TABLA := 'GA_INFACRENT';
   UPDATE GA_INFACRENT
      SET IND_ACTUAC = 4
    WHERE NUM_ALQUILER = VP_ALQUILER;
EXCEPTION
   WHEN OTHERS THEN
 VP_SQLCODE := SQLCODE;
 VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
