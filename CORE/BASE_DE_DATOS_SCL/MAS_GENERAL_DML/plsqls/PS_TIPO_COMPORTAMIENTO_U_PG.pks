CREATE OR REPLACE PACKAGE PS_TIPO_COMPORTAMIENTO_U_PG
IS

 FUNCTION PS_MODIFICAR_FN
               (

               EV_valor GE_VALORES_dominios_td.valor%TYPE
			   ,EV_estado GE_VALORES_dominios_td.ind_estado%TYPE
               ,EV_descripcion_valor GE_VALORES_dominios_td.descripcion_valor%TYPE
			   ,EV_usu_modificacion GE_VALORES_dominios_td.usu_modificacion%TYPE
               )
 RETURN NUMBER;


END PS_TIPO_COMPORTAMIENTO_U_PG;
/
SHOW ERRORS
