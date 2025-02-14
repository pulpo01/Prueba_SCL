CREATE OR REPLACE TRIGGER GE_TRG_AFINS_RECATEGRECL
AFTER INSERT ON RE_CATEGRECL
FOR EACH ROW

DECLARE
pCodCateg RE_CATEGRECL.COD_CATEGRECL%TYPE;
pDesCateg RE_CATEGRECL.DES_CATEGRECL%TYPE;
-- Trigger desde re_categrecl que llama al un prodecimiento para asegurar
-- consistencia entre esta tabla y ge_multiidioma
-- Creacion : 02 de mayo de 2002
-- Autor : Alejandra Montealegre
BEGIN
        pCodCateg:=:new.COD_CATEGRECL;
        pDesCateg:=:new.DES_CATEGRECL;
        BEGIN
                 GE_PR_MULTIIDIOMA_CATEGRECL (pCodCateg,pDesCateg);
        END;
    EXCEPTION
     WHEN OTHERS THEN
       NULL;
END GE_TRG_AFINS_RECATEGRECL;
/
SHOW ERRORS
