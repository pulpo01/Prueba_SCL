CREATE OR REPLACE FUNCTION        ge_fn_consumofolio_scl
RETURN GED_PARAMETROS.val_parametro%type IS
sval_parametro ged_parametros.val_parametro%TYPE;
BEGIN
        SELECT val_parametro INTO sval_parametro
        FROM GED_PARAMETROS
        WHERE COD_PRODUCTO = 1 AND COD_MODULO = 'GA' AND NOM_PARAMETRO = 'IND_CONSUMOFOLIO';
        RETURN sval_parametro;
END;
/
SHOW ERRORS
