CREATE OR REPLACE TRIGGER GE_TRG_AFUP_CLIENTES
AFTER UPDATE OF COD_OPERADORA
ON GE_CLIENTES

DECLARE
BEGIN
     RAISE_APPLICATION_ERROR
   (-20001,'NO SE PERMITE MODIFICAR OPERADORA' ,TRUE);
END;
/
SHOW ERRORS
