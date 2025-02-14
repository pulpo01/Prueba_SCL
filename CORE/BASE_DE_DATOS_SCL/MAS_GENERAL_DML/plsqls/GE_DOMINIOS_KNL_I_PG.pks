CREATE OR REPLACE PACKAGE GE_DOMINIOS_KNL_I_PG
IS

 FUNCTION GE_AGREGAR_FN
               (
               EV_cod_dominio ge_dominios_td.cod_dominio%TYPE
               ,EN_tipo ge_dominios_td.tipo%TYPE
               ,EV_nombre ge_dominios_td.nombre%TYPE
               ,EV_usu_creacion ge_dominios_td.usu_creacion%TYPE
               )
 RETURN NUMBER;


END GE_DOMINIOS_KNL_I_PG;
/
SHOW ERRORS
