CREATE OR REPLACE PACKAGE GE_OPERADORAS_KNL_D_PG
IS

 FUNCTION GE_ELIMINAR_FN
               (
               EV_cod_operadora ge_operadoras_td.cod_operadora%TYPE
               )
 RETURN NUMBER;


END GE_OPERADORAS_KNL_D_PG;
/
SHOW ERRORS
