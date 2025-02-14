CREATE OR REPLACE FUNCTION        GE_FN_OPERADORA_SCL
RETURN ge_operadora_scl.cod_operadora_scl%TYPE IS
	cod_operadora ge_operadora_scl.cod_operadora_scl%TYPE;
BEGIN
	SELECT a.cod_operadora_scl INTO cod_operadora
	FROM ge_operadora_scl_local b,ge_operadora_scl a
	WHERE a.cod_operadora_scl=b.cod_operadora_scl;
	RETURN cod_operadora;
END;
/
SHOW ERRORS
