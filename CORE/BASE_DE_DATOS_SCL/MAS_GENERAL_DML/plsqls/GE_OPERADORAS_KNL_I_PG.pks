CREATE OR REPLACE PACKAGE GE_OPERADORAS_KNL_I_PG
IS

 FUNCTION GE_AGREGAR_FN
               (
               EV_cod_operadora ge_operadoras_td.cod_operadora%TYPE
               ,EV_des_operadora ge_operadoras_td.des_operadora%TYPE
               )
 RETURN NUMBER;


END GE_OPERADORAS_KNL_I_PG;
/
SHOW ERRORS
