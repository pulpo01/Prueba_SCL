CREATE OR REPLACE PROCEDURE        GE_PR_MULTIIDIOMA_CATEGRECL(
pCodCategRecl RE_CATEGRECL.COD_CATEGRECL%TYPE,
pDesCategRecl RE_CATEGRECL.DES_CATEGRECL%TYPE )
IS
-- Procedimiento que es llamado desde el Trigger GE_TRG_AFINS_RECATEGRECL
-- y que ingresa a la ge_multiidioma los registros nuevos en un idioma
-- alternativo.
-- Adicionamente ingresa registros sin descripcion para asegurar consistencia.
-- Creacion : 02 de mayo de 2002
-- Autor : Alejandra Montealegre
--
   vDescripcion RE_CATEGRECL.DES_CATEGRECL%TYPE;
   vDescError VARCHAR2(50);
   vIdioma GED_CODIGOS.COD_VALOR%TYPE;
   nCodProd NUMBER(1);
   nCont NUMBER(1);
--
   CURSOR OtrosIdiomas IS
   SELECT COD_VALOR
   FROM GED_CODIGOS
   WHERE COD_MODULO ='GE'
     AND NOM_TABLA ='GE_CLIENTES'
     AND COD_VALOR <> ge_fn_idioma_local();
BEGIN
   nCodProd := 0;
   nCont := 1;
   vDescripcion:= pDesCategRecl;
--
   vIdioma := ge_fn_idioma_local();
--
   INSERT INTO GE_MULTIIDIOMA (
      NOM_TABLA,NOM_CAMPO,COD_PRODUCTO,COD_CONCEPTO,COD_IDIOMA,
      NOM_CAMPO_DES,DES_CONCEPTO,FEC_ULTMOD,NOM_USUARIO)
   VALUES (
      'RE_CATEGRECL','COD_CATEGRECL',nCodProd,pCodCategRecl,vIdioma,
      'CODIGO CATEG RECLAMO',vDescripcion,SYSDATE,USER );
--
   FOR vIdioma IN OtrosIdiomas LOOP
      vDescripcion:='SIN DESCRIPCION';
      INSERT INTO GE_MULTIIDIOMA (
         NOM_TABLA, NOM_CAMPO, COD_PRODUCTO, COD_CONCEPTO, COD_IDIOMA,
         NOM_CAMPO_DES, DES_CONCEPTO, FEC_ULTMOD, NOM_USUARIO)
      VALUES (
         'RE_CATEGRECL','COD_CATEGRECL',nCodProd,pCodCategRecl,vIdioma.COD_VALOR,
         'CODIGO CATEG RECLAMO',vDescripcion,SYSDATE,USER );
   END LOOP;
--
   COMMIT;
--
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
   ROLLBACK;
   vDescError := 'Registro ya existente en la tabla';
   RAISE_APPLICATION_ERROR(-20002, vDescError);
WHEN NO_DATA_FOUND then
   ROLLBACK;
   vDescError := 'No existe Idioma Local';
   RAISE_APPLICATION_ERROR(-20003, vDescError);
WHEN OTHERS THEN
   ROLLBACK;
   vDescError := 'Error inesperado en ge_pr_multiidioma_categrecl, Codigo:'||sqlcode||'  Descripcion:'||sqlerrm;
   RAISE_APPLICATION_ERROR(-20004, vDescError);
END GE_PR_MULTIIDIOMA_CATEGRECL;
/
SHOW ERRORS
