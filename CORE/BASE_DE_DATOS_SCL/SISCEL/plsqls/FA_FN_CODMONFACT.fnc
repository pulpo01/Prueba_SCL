CREATE OR REPLACE FUNCTION        FA_FN_CODMONFACT RETURN CHAR IS
	 valor FA_DATOSGENER.COD_MONEFACT%TYPE;
BEGIN

	 SELECT COD_MONEFACT
	 INTO	valor
	 FROM   FA_DATOSGENER;

	 RETURN valor;

   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       NULL;
     WHEN OTHERS THEN
       NULL;
END FA_FN_CODMONFACT;
/
SHOW ERRORS
