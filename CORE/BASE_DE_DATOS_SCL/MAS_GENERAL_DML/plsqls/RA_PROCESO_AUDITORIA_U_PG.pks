CREATE OR REPLACE PACKAGE RA_PROCESO_AUDITORIA_U_PG
IS

 FUNCTION GE_MODIFICAR_FN

               (
                EV_valor ge_valores_dominios_td.valor%TYPE
                           ,EV_estado ge_valores_dominios_td.ind_estado%TYPE
               ,EV_descripcion_valor ge_valores_dominios_td.descripcion_valor%TYPE
                           ,EV_usu_modificacion ge_valores_dominios_td.usu_modificacion%TYPE
               )

 RETURN NUMBER;

END RA_PROCESO_AUDITORIA_U_PG;
/
SHOW ERRORS
