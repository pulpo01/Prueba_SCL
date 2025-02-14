CREATE OR REPLACE PACKAGE GE_ERRORES_KNL_I_PG
IS

 FUNCTION GE_AGREGAR_FN
               (
                EN_cod_mensaje ge_errores_td.cod_msgerror%TYPE
               ,EV_des_mensaje ge_errores_td.det_msgerror%TYPE
	       ,EN_grupo ge_errores_td.cod_grupo%TYPE
	       ,EN_cod_msgcliente ge_errores_td.cod_msgcliente%TYPE
               )
 RETURN NUMBER;


END GE_ERRORES_KNL_I_PG;
/
SHOW ERRORS
