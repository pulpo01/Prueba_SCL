CREATE OR REPLACE PROCEDURE        P_DEL_MOVIBOX
 (V_CLIENTE IN GA_ABOCEL.COD_CLIENTE%TYPE,
V_ABONADO IN GA_ABOCEL.NUM_ABONADO%TYPE,
V_ERROR IN OUT VARCHAR2)IS
V_FILA_CAB ROWID;
V_FILA_DET ROWID;
BEGIN
  DELETE GA_DET_MOVIVOX
  WHERE NUM_ABONADO=V_ABONADO;
  DELETE GA_CAB_MOVIVOX
  WHERE COD_CLIENTE=V_CLIENTE
  AND NUM_ABONADO=V_ABONADO;
  V_ERROR:='0';
EXCEPTION
  WHEN NO_DATA_FOUND THEN
     NULL;
  WHEN OTHERS THEN
    V_ERROR:='4';
END;
/
SHOW ERRORS
