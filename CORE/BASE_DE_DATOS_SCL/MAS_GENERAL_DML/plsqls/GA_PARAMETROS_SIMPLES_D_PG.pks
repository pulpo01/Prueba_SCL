CREATE OR REPLACE PACKAGE GA_PARAMETROS_SIMPLES_D_PG
IS
 FUNCTION GA_ELIMINAR_PADRE_FN
               (EN_codigo IN ge_parametros_td.cod_parametro%TYPE
               )
 RETURN NUMBER;
 FUNCTION GA_ELIMINAR_HIJO_FN
               (EN_codigo_padre IN ge_parametros_td.cod_parametro_padre%TYPE
               ,EN_codigo_hijo IN ge_parametros_td.cod_parametro%TYPE
               )
      RETURN NUMBER;
END GA_PARAMETROS_SIMPLES_D_PG;
/
SHOW ERRORS
