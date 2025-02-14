CREATE OR REPLACE PACKAGE GE_DOMINIOS_KNL_D_PG
IS

 FUNCTION GE_ELIMINAR_FN
               (
               EV_cod_dominio ge_dominios_td.cod_dominio%TYPE
               )
 RETURN NUMBER;


END GE_DOMINIOS_KNL_D_PG;
/
SHOW ERRORS
