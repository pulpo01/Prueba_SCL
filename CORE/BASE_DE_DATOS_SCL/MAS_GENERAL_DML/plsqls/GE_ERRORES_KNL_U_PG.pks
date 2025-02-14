CREATE OR REPLACE PACKAGE GE_ERRORES_KNL_U_PG
IS

 FUNCTION GE_MODIFICAR_FN
               (
               EN_cod_mensaje ge_errores_td.cod_msgerror%TYPE
               ,EV_des_mensaje ge_errores_td.det_msgerror%TYPE
	       ,EN_grupo ge_errores_td.cod_grupo%TYPE
	       ,EN_cod_msgcliente ge_errores_td.cod_msgcliente%TYPE
               )
 RETURN NUMBER;


END GE_ERRORES_KNL_U_PG;
/
SHOW ERRORS
