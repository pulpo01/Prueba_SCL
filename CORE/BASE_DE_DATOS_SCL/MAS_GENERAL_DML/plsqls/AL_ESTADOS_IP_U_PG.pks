CREATE OR REPLACE PACKAGE AL_ESTADOS_IP_U_PG
IS

 FUNCTION GE_MODIFICAR_FN
               (
                EV_cod_dominio ge_valores_dominios_td.cod_dominio%TYPE
               ,EV_valor ge_valores_dominios_td.valor%TYPE
			   ,EV_estado ge_valores_dominios_td.ind_estado%TYPE
               ,EV_descripcion_valor ge_valores_dominios_td.descripcion_valor%TYPE
			   ,EV_usu_modificacion ge_valores_dominios_td.usu_modificacion%TYPE
               )
 RETURN NUMBER;


END AL_ESTADOS_IP_U_PG;
/
SHOW ERRORS
