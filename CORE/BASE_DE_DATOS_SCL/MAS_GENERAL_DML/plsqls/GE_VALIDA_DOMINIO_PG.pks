CREATE OR REPLACE PACKAGE GE_VALIDA_DOMINIO_PG
AS

	 CN_dominio_codigo_ok CONSTANT NUMBER(2) := 0;

	 CN_dominio_not_found_codigo NUMBER(2) := 1;

	 CN_dominio_invalid_codigo NUMBER(2) := 2;

	 CN_tipo_dominio_valor NUMBER(1) := 1;

    FUNCTION GE_VALIDA_VALOR_DOMINIO_FN (EV_nom_tabla IN GE_DOMINIOS_TD.COD_DOMINIO%TYPE
                                   ,EV_nom_columna IN GE_COLUMNAS_DOMINIOS_TD.NOMBRE_COLUMNA%TYPE
								   ,EV_val_dominio IN GE_VALORES_DOMINIOS_TD.VALOR%TYPE
								   ) RETURN NUMBER;

END GE_VALIDA_DOMINIO_PG;
/
SHOW ERRORS
