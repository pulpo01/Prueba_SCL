CREATE OR REPLACE PROCEDURE        P_BAJA_SEGNUM(
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
-- Procedimiento que refleja el cambio y efectividad del nuevo segundo numero
-- de celular en las tablas de interfase con Facturacion y Tarificacion
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
   V_ROWID ROWID;
BEGIN
   VP_PROC := 'P_BAJA_SEGNUM';
   VP_TABLA := 'GA_INTARCEL';
   VP_ACT := 'S';
   SELECT ROWID
     INTO V_ROWID
     FROM GA_INTARCEL
    WHERE COD_CLIENTE = VP_CLIENTE
      AND NUM_ABONADO = VP_ABONADO
      AND IND_NUMERO = 1
      AND VP_FECSYS BETWEEN FEC_DESDE
                        AND FEC_HASTA;
   VP_TABLA := 'GA_INTARCEL';
   VP_ACT := 'U';
   UPDATE GA_INTARCEL
      SET FEC_HASTA = VP_FECSYS
    WHERE ROWID = V_ROWID;
   DELETE GA_INTARCEL
    WHERE COD_CLIENTE = VP_CLIENTE
      AND NUM_ABONADO = VP_ABONADO
      AND IND_NUMERO = 1
      AND FEC_DESDE >= VP_FECSYS;
EXCEPTION
   WHEN OTHERS THEN
 VP_SQLCODE := SQLCODE;
 VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
