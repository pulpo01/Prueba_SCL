CREATE OR REPLACE PACKAGE PF_CANAL_DISTRIBUCION_U_PG
IS

 FUNCTION PF_MODIFICAR_FN
               (

               EV_valor GE_VALORES_dominios_td.valor%TYPE
			   ,EV_estado GE_VALORES_dominios_td.ind_estado%TYPE
               ,EV_descripcion_valor GE_VALORES_dominios_td.descripcion_valor%TYPE
			   ,EV_usu_modificacion GE_VALORES_dominios_td.usu_modificacion%TYPE
               )
 RETURN NUMBER;


END PF_CANAL_DISTRIBUCION_U_PG;
/
SHOW ERRORS
