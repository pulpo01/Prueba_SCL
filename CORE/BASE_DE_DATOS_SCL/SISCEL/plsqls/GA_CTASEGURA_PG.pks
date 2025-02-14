CREATE OR REPLACE PACKAGE GA_CTASEGURA_PG IS
-- *************************************************************
-- * Paquete            : GA_BORRA_TMP_PR
-- * Descripcion        : Procedimientos de Carga cuenta segura
-- * Fecha de creacion  : Septiembre 2004
-- *************************************************************
   PROCEDURE GA_BORRA_TMP_PR(pNombreTabla in Varchar2);
END GA_CTASEGURA_PG;
/
SHOW ERRORS
