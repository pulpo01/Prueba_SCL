CREATE OR REPLACE FUNCTION          "CO_FGETTIPPLANCELULAR" ( pCodPlanTarif in TA_PLANTARIF.COD_PLANTARIF%TYPE ) RETURN VARCHAR2
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * Funcion            : CO_fGetTipPlanCelular
-- * Salida             : Tipo de plan
-- * Descripcion        : Obtiene el tipo de plan utilizando el
-- *                      codigo de plan.
-- * Fecha de creacion  : 02-2003
-- * Responsable        : Manuel Garcia
-- *************************************************************
RETURN GED_CODIGOS.COD_VALOR%TYPE;
v_RetornoSql VARCHAR(100);
BEGIN
	SELECT DES_VALOR
	  INTO v_RetornoSql
	  FROM GED_CODIGOS G, TA_PLANTARIF T
	 WHERE T.COD_PLANTARIF = pCodPlanTarif
	   AND T.COD_TIPLAN = COD_VALOR
	   AND G.NOM_TABLA = 'TA_PLANTARIF'
	   AND G.NOM_COLUMNA = 'COD_TIPLAN'
	   AND COD_MODULO = 'GE'
	   AND COD_PRODUCTO = 1;

	RETURN v_RetornoSql;

EXCEPTION
	WHEN NO_DATA_FOUND THEN
		RETURN 'ERROR';
	WHEN OTHERS THEN
		RAISE_APPLICATION_ERROR( SQLCODE, 'ERROR : '|| TO_CHAR(SQLCODE) ||' ' || SQLERRM );
END CO_fGetTipPlanCelular;
/
SHOW ERRORS
