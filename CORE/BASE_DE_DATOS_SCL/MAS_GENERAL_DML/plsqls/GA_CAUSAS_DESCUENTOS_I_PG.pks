CREATE OR REPLACE PACKAGE GA_CAUSAS_DESCUENTOS_I_PG
IS

 FUNCTION GA_AGREGAR_FN
               (
                EV_valor ge_valores_dominios_td.valor%TYPE
			   ,EV_estado ge_valores_dominios_td.ind_estado%TYPE
               ,EV_descripcion_valor ge_valores_dominios_td.descripcion_valor%TYPE
	       ,EV_usu_creacion ge_valores_dominios_td.usu_creacion%TYPE
               )
 RETURN NUMBER;


END GA_CAUSAS_DESCUENTOS_I_PG;
/
SHOW ERRORS
