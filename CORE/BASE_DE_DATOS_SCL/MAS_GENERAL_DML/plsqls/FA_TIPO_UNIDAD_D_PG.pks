CREATE OR REPLACE PACKAGE FA_TIPO_UNIDAD_D_PG
IS

 FUNCTION FA_ELIMINAR_FN
               (
               EV_valor ge_valores_dominios_td.valor%TYPE
               )
 RETURN NUMBER;

END FA_TIPO_UNIDAD_D_PG;
/
SHOW ERRORS
