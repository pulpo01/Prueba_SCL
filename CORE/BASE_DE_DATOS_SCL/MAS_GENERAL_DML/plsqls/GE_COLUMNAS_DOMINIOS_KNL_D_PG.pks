CREATE OR REPLACE PACKAGE GE_COLUMNAS_DOMINIOS_KNL_D_PG
IS

 FUNCTION GE_ELIMINAR_FN
               (
               EV_cod_dominio ge_columnas_dominios_td.cod_dominio%TYPE
               ,EV_nom_tabla ge_columnas_dominios_td.nombre_tabla%TYPE
               ,EV_nom_columna ge_columnas_dominios_td.nombre_columna%TYPE
               )
 RETURN NUMBER;


END GE_COLUMNAS_DOMINIOS_KNL_D_PG;
/
SHOW ERRORS
