CREATE OR REPLACE PACKAGE GE_DOMINIOS_KNL_U_PG
IS

 FUNCTION GE_MODIFICAR_FN
               (
               EV_cod_dominio ge_dominios_td.cod_dominio%TYPE
               ,EN_tipo ge_dominios_td.tipo%TYPE
               ,EV_nombre ge_dominios_td.nombre%TYPE
			   ,ED_usu_modificacion ge_dominios_td.usu_modificacion%TYPE
               )
 RETURN NUMBER;


END GE_DOMINIOS_KNL_U_PG;
/
SHOW ERRORS
