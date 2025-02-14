CREATE OR REPLACE PACKAGE GE_TIPO_VENDEDOR_D_PG
IS

 FUNCTION GE_ELIMINAR_FN
               (
                EV_valor ge_valores_dominios_td.valor%TYPE
               )
 RETURN NUMBER;

END GE_TIPO_VENDEDOR_D_PG;
/
SHOW ERRORS
