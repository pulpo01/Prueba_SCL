CREATE OR REPLACE PROCEDURE        P_LIQUIDA_ABONADO(
  VP_PRODUCTO IN NUMBER ,
  VP_CLIENTE IN NUMBER ,
  VP_ABONADO IN NUMBER ,
  VP_FECSYS IN DATE ,
  VP_PROC IN OUT VARCHAR2 ,
  VP_TABLA IN OUT VARCHAR2 ,
  VP_ACT IN OUT VARCHAR2 ,
  VP_SQLCODE IN OUT VARCHAR2 ,
  VP_SQLERRM IN OUT VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento que refleja la liquidacion de abonados marcando
-- la misma en las tablas de interfase con tarificacion y facturacion
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
BEGIN
   VP_PROC := 'P_LIQUIDA_ABONADO';
   IF VP_PRODUCTO = 1 THEN
      VP_TABLA := 'GA_INFACCEL';
      VP_ACT := 'U';
      UPDATE GA_INFACCEL
         SET IND_ACTUAC = 4
       WHERE COD_CLIENTE = VP_CLIENTE
         AND NUM_ABONADO = VP_ABONADO;
   ELSIF VP_PRODUCTO = 2 THEN
      VP_TABLA := 'GA_INFACBEEP';
      VP_ACT := 'U';
      UPDATE GA_INFACBEEP
         SET IND_ACTUAC = 4
       WHERE COD_CLIENTE = VP_CLIENTE
         AND NUM_ABONADO = VP_ABONADO;
   ELSIF VP_PRODUCTO = 3 THEN
      VP_TABLA := 'GA_INFACTRUNK';
      VP_ACT := 'U';
      UPDATE GA_INFACTRUNK
         SET IND_ACTUAC = 4
       WHERE COD_CLIENTE = VP_CLIENTE
         AND NUM_ABONADO = VP_ABONADO;
   ELSIF VP_PRODUCTO = 4 THEN
      VP_TABLA := 'GA_INFACTREK';
      VP_ACT := 'U';
      UPDATE GA_INFACTREK
         SET IND_ACTUAC = 4
       WHERE COD_CLIENTE = VP_CLIENTE
         AND NUM_ABONADO = VP_ABONADO;
   END IF;
EXCEPTION
   WHEN OTHERS THEN
 VP_SQLCODE := SQLCODE;
 VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
