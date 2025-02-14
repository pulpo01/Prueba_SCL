CREATE OR REPLACE PACKAGE PS_TIPO_COMPORTAMIENTO_I_PG
IS

 FUNCTION PS_AGREGAR_FN
               (
                EV_valor GE_VALORES_dominios_td.valor%TYPE
			   ,EV_estado GE_VALORES_dominios_td.ind_estado%TYPE
               ,EV_descripcion_valor GE_VALORES_dominios_td.descripcion_valor%TYPE
	       ,EV_usu_creacion GE_VALORES_dominios_td.usu_creacion%TYPE
               )
 RETURN NUMBER;


END PS_TIPO_COMPORTAMIENTO_I_PG;
/
SHOW ERRORS
