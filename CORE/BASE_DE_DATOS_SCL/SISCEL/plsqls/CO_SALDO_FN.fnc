CREATE OR REPLACE FUNCTION CO_SALDO_FN ( p_Cod_Cliente IN NUMBER )
RETURN NUMBER
IS

v_nSaldo     CO_CARTERA.IMPORTE_DEBE%TYPE;
iValorUno    NUMBER;
iValorCero   NUMBER;
szCartera    VARCHAR2(10);
szTipDocum   VARCHAR2(12);

BEGIN
	iValorCero:= 0;
	iValorUno := 1;
	szCartera :='CO_CARTERA';
	szTipDocum:='COD_TIPDOCUM';

	BEGIN

   	SELECT NVL(SUM(IMPORTE_DEBE - IMPORTE_HABER),iValorCero)
    	INTO   v_nSaldo
   	FROM   CO_CARTERA
      WHERE  COD_CLIENTE   = p_Cod_Cliente
      AND    IND_FACTURADO = iValorUno
      AND    COD_TIPDOCUM NOT IN (SELECT TO_NUMBER(COD_VALOR)
   		   			             FROM   CO_CODIGOS
   					                WHERE  NOM_TABLA   = szCartera
   					                AND    NOM_COLUMNA = szTipDocum);

      EXCEPTION
   	  WHEN OTHERS THEN
           v_nSaldo:=0;
	END;

	RETURN v_nSaldo;

END CO_SALDO_FN;
/
SHOW ERRORS
