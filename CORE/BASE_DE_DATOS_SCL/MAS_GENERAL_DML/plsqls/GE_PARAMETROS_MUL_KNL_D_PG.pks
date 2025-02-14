CREATE OR REPLACE PACKAGE GE_PARAMETROS_MUL_KNL_D_PG
IS
 FUNCTION GE_ELIMINAR_PADRE_FN
               (EN_codigo IN ge_parametros_td.cod_parametro%TYPE
			    ,EV_codigo_modulo IN ge_parametros_td.cod_modulo%TYPE
               )
 RETURN NUMBER;
 FUNCTION GE_ELIMINAR_HIJO_FN
               (EN_codigo_padre IN ge_parametros_td.cod_parametro_padre%TYPE
               ,EN_codigo_hijo IN ge_parametros_td.cod_parametro%TYPE
			   ,EV_codigo_modulo IN ge_parametros_td.cod_modulo%TYPE
               )
      RETURN NUMBER;
END GE_PARAMETROS_MUL_KNL_D_PG;
/
SHOW ERRORS
