CREATE OR REPLACE PROCEDURE        P_MODIF_FRIENDS(
  VP_CLIENTE IN NUMBER ,
  VP_ABONADO IN NUMBER ,
  VP_ESTADO IN VARCHAR2 ,
  VP_FECSYS IN DATE ,
  VP_PROC IN OUT VARCHAR2 ,
  VP_TABLA IN OUT VARCHAR2 ,
  VP_ACT IN OUT VARCHAR2 ,
  VP_SQLCODE IN OUT VARCHAR2 ,
  VP_SQLERRM IN OUT VARCHAR2 ,
  VP_ERROR IN OUT CHAR )
IS
--
-- Procedimiento que refleja el estado del servicio de Friends y Family
-- para cada uno de los abonados (1-Activo 0-Desactivo las tablas de interfase
-- con tarificacion
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
   V_ROWIDACT ROWID;
   V_ROWIDSUP ROWID;
   CURSOR C1 is
   SELECT ROWID,COD_CLIENTE,NUM_ABONADO,IND_NUMERO
     FROM GA_INTARCEL
    WHERE COD_CLIENTE = VP_CLIENTE
      AND NUM_ABONADO = VP_ABONADO
      AND VP_FECSYS BETWEEN FEC_DESDE
                        AND FEC_HASTA;
   V_ABONADO GA_INTARCEL.NUM_ABONADO%TYPE;
   V_CLIENTE GA_INTARCEL.COD_CLIENTE%TYPE;
   V_NUMERO GA_INTARCEL.IND_NUMERO%TYPE;
BEGIN
    VP_PROC := 'P_MODIF_FRIENDS';
    VP_TABLA := 'C1';
    VP_ACT := 'O';
    OPEN C1;
    LOOP
       VP_ACT := 'F';
       FETCH C1 INTO V_ROWIDACT,V_CLIENTE,V_ABONADO,V_NUMERO;
       EXIT WHEN C1%NOTFOUND;
       VP_TABLA := 'GA_INTARCEL';
       VP_ACT := 'U';
       UPDATE GA_INTARCEL
          SET IND_FRIENDS = VP_ESTADO
        WHERE ROWID = V_ROWIDACT;
       UPDATE GA_INTARCEL
          SET IND_FRIENDS = VP_ESTADO
        WHERE COD_CLIENTE = V_CLIENTE
          AND NUM_ABONADO = V_ABONADO
          AND IND_NUMERO = V_NUMERO
          AND FEC_DESDE >= VP_FECSYS;
    END LOOP;
EXCEPTION
   WHEN OTHERS THEN
 VP_SQLCODE := SQLCODE;
 VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
