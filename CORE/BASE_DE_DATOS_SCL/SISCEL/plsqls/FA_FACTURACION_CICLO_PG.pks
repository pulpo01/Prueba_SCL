CREATE OR REPLACE PACKAGE FA_FACTURACION_CICLO_PG IS

FUNCTION FA_COD_SEGMENTACION_FN ( EN_Cod_Cliente IN NUMBER ) RETURN VARCHAR2;

END FA_FACTURACION_CICLO_PG;
/
SHOW ERRORS
