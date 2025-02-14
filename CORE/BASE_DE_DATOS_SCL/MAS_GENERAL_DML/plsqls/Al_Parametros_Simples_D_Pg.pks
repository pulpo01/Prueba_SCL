CREATE OR REPLACE PACKAGE AL_PARAMETROS_SIMPLES_D_PG
IS
 FUNCTION AL_ELIMINAR_PADRE_FN
               (EN_codigo IN ge_parametros_td.cod_parametro%TYPE
               )
 RETURN NUMBER;
 FUNCTION AL_ELIMINAR_HIJO_FN
               (EN_codigo_padre IN ge_parametros_td.cod_parametro_padre%TYPE
               ,EN_codigo_hijo IN ge_parametros_td.cod_parametro%TYPE
               )
      RETURN NUMBER;
END AL_PARAMETROS_SIMPLES_D_PG;
/
SHOW ERRORS
