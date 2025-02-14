CREATE OR REPLACE PACKAGE AL_ESTADOS_IP_D_PG
IS

 FUNCTION GE_ELIMINAR_FN
               (
               EV_cod_dominio ge_valores_dominios_td.cod_dominio%TYPE
               ,EV_valor ge_valores_dominios_td.valor%TYPE
               )
 RETURN NUMBER;

END AL_ESTADOS_IP_D_PG;
/
SHOW ERRORS
