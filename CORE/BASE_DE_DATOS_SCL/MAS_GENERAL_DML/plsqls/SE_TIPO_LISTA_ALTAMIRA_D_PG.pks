CREATE OR REPLACE PACKAGE SE_TIPO_LISTA_ALTAMIRA_D_PG
IS

 FUNCTION SE_ELIMINAR_FN
               (
                EV_valor GE_VALORES_dominios_td.valor%TYPE
               )
 RETURN NUMBER;

END SE_TIPO_LISTA_ALTAMIRA_D_PG;
/
SHOW ERRORS
