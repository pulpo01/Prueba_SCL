CREATE OR REPLACE TRIGGER "EBZ_SISCEL".NP_NPTPEDIDOS_BEUP_TG
BEFORE UPDATE
ON NPT_PEDIDO
FOR EACH ROW

DECLARE
V_COD_PEDIDO NPT_PEDIDO.COD_PEDIDO%TYPE;
V_ESTADO_PEDIDO NPT_ESTADO_PEDIDO.COD_ESTADO_FLUJO%TYPE;
V_ESTA VARCHAR2(4);
BEGIN

	V_COD_PEDIDO := :old.COD_PEDIDO;

	SELECT NP_ESTADOFLUJOPEDIDO_FN(V_COD_PEDIDO)
		   INTO V_ESTADO_PEDIDO
	FROM   DUAL;

	SELECT 'ESTA' INTO V_ESTA
	FROM  DUAL
	WHERE TO_CHAR(V_ESTADO_PEDIDO) IN (SELECT VALOR_PARAMETRO FROM NPT_PARAMETRO WHERE ALIAS_PARAMETRO='ESTVALCAM');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
	   :new.CAN_TOTAL_PEDIDO := :old.CAN_TOTAL_PEDIDO;
	WHEN TOO_MANY_ROWS THEN
	   NULL;
	WHEN OTHERS THEN
	   RAISE_APPLICATION_ERROR (-20175, 'ERROR EN TRIGGER NP_NPTPEDIDOS_BEUP_TG');
End;
/
SHOW ERRORS
