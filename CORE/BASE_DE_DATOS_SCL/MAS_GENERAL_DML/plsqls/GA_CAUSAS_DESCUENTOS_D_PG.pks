CREATE OR REPLACE PACKAGE GA_CAUSAS_DESCUENTOS_D_PG
IS

 FUNCTION GA_ELIMINAR_FN
               (
               EV_valor ge_valores_dominios_td.valor%TYPE
               )
 RETURN NUMBER;

END GA_CAUSAS_DESCUENTOS_D_PG;
/
SHOW ERRORS
