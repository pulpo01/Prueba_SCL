CREATE OR REPLACE PACKAGE GE_ERRORES_KNL_D_PG
IS

 FUNCTION GE_ELIMINAR_FN
               (
               EN_cod_mensaje ge_errores_td.cod_msgerror%TYPE
               )
 RETURN NUMBER;


END GE_ERRORES_KNL_D_PG;
/
SHOW ERRORS
