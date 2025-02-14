CREATE OR REPLACE PROCEDURE        P_RECUPERA_CICLOS(
  VP_ABONADO IN NUMBER ,
  VP_CICLO IN OUT NUMBER ,
  VP_FECHA IN OUT DATE ,
  VP_PROC IN OUT VARCHAR2 ,
  VP_TABLA IN OUT VARCHAR2 ,
  VP_ACT IN OUT VARCHAR2 ,
  VP_SQLCODE IN OUT VARCHAR2 ,
  VP_SQLERRM IN OUT VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento que recupera un posible cambio de ciclo de facturacion para
-- abonados de la compania en modalidad de roaming
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
BEGIN
   VP_PROC := 'P_RECUPERA_CICLOS';
   VP_TABLA := 'GA_FINCICLO';
   VP_ACT := 'S';
   SELECT COD_CICLO,FEC_DESDELLAM
     INTO VP_CICLO,VP_FECHA
     FROM GA_FINCICLO
    WHERE NUM_ABONADO = VP_ABONADO;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
 VP_CICLO := NULL;
 VP_FECHA := NULL;
   WHEN OTHERS THEN
 VP_SQLCODE := SQLCODE;
 VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
