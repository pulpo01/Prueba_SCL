CREATE OR REPLACE PACKAGE SC_PARAMETROS_SIMPLES_D_PG
IS
 FUNCTION SC_ELIMINAR_PADRE_FN
               (EN_codigo IN ge_parametros_td.cod_parametro%TYPE
               )
 RETURN NUMBER;
 FUNCTION SC_ELIMINAR_HIJO_FN
               (EN_codigo_padre IN ge_parametros_td.cod_parametro_padre%TYPE
               ,EN_codigo_hijo IN ge_parametros_td.cod_parametro%TYPE
               )
      RETURN NUMBER;
END SC_PARAMETROS_SIMPLES_D_PG;
/
SHOW ERRORS
