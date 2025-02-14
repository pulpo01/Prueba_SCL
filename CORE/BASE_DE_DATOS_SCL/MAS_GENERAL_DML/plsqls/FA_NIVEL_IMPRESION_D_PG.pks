CREATE OR REPLACE PACKAGE FA_NIVEL_IMPRESION_D_PG
IS

 FUNCTION FA_ELIMINAR_FN
               (
               EV_valor ge_valores_dominios_td.valor%TYPE
               )
 RETURN NUMBER;

END FA_NIVEL_IMPRESION_D_PG;
/
SHOW ERRORS
