CREATE OR REPLACE PACKAGE IC_PARAMCDMA_PG IS
----------------------------------------------------------------------------------
-- Funciones.
----------------------------------------------------------------------------------

  FUNCTION IC_ICCDEC_FN(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
  FUNCTION IC_CODPLAN_FN(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;
  FUNCTION IC_TECNOLOGIA_CDMA_FN(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING;

END IC_PARAMCDMA_PG;
/
SHOW ERRORS
