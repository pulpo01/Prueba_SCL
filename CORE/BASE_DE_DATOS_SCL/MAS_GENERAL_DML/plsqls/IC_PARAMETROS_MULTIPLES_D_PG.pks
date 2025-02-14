CREATE OR REPLACE PACKAGE IC_PARAMETROS_MULTIPLES_D_PG
IS

 FUNCTION IC_ELIMINAR_HIJO_FN
               (EN_codigo_padre IN ge_parametros_td.cod_parametro_padre%TYPE
               ,EN_codigo_hijo IN ge_parametros_td.cod_parametro%TYPE
               )
      RETURN NUMBER;
END IC_PARAMETROS_MULTIPLES_D_PG;
/
SHOW ERRORS
