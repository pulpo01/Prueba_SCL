CREATE OR REPLACE PACKAGE RA_TIPO_AUDITORIA_D_PG
IS

 FUNCTION GE_ELIMINAR_FN

               (
                EV_valor ge_valores_dominios_td.valor%TYPE
               )

 RETURN NUMBER;

END RA_TIPO_AUDITORIA_D_PG;
/
SHOW ERRORS
