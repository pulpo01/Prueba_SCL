CREATE OR REPLACE PACKAGE GE_VALORES_DOMINIOS_KNL_D_PG
IS

 FUNCTION GE_ELIMINAR_FN
               (
               EN_tipo_ingreso IN ge_dominios_td.tipo%TYPE
               ,EV_cod_dominio IN ge_valores_dominios_td.cod_dominio%TYPE
               ,EV_valor IN ge_valores_dominios_td.valor%TYPE
               )
 RETURN NUMBER;


END GE_VALORES_DOMINIOS_KNL_D_PG;
/
SHOW ERRORS
