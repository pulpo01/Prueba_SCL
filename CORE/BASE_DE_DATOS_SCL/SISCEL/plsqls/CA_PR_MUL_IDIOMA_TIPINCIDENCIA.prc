CREATE OR REPLACE PROCEDURE        CA_PR_MUL_IDIOMA_TIPINCIDENCIA(
pTipIncidencia CA_TIPINCIDENCIAS.TIP_INCIDENCIA%TYPE,
pDesIncidencia CA_TIPINCIDENCIAS.DES_INCIDENCIA%TYPE )
IS
-- Procedimiento que es llamado desde el Trigger AC_TRG_AFINS_CATIPINCIDENCIAS
-- y que ingresa a la ge_multiidioma los registros nuevos en un idioma
-- alternativo.
-- Adicionamente ingresa registros sin descripcion para asegurar consistencia.
-- Creacion : 30 de mayo de 2002
-- Autor : Alejandra Montealegre
--
   vDescripcion CA_TIPINCIDENCIAS.DES_INCIDENCIA%TYPE;
   vDescError VARCHAR2(50);
   vIdioma GED_CODIGOS.COD_VALOR%TYPE;
   nCodProd NUMBER(1);
--
   CURSOR OtrosIdiomas IS
   SELECT COD_VALOR
   FROM GED_CODIGOS
   WHERE COD_MODULO ='GE'
     AND NOM_TABLA ='GE_CLIENTES'
     AND COD_VALOR <> Ge_Fn_Idioma_Local();
BEGIN
   nCodProd := 0;
   vDescripcion:= pDesIncidencia;
--
   vIdioma := Ge_Fn_Idioma_Local();
--
   INSERT INTO GE_MULTIIDIOMA (
      NOM_TABLA,NOM_CAMPO,COD_PRODUCTO,COD_CONCEPTO,COD_IDIOMA,
      NOM_CAMPO_DES,DES_CONCEPTO,FEC_ULTMOD,NOM_USUARIO)
   VALUES (
      'CA_TIPINCIDENCIAS','TIP_INCIDENCIA',nCodProd,pTipIncidencia,vIdioma,
      'DES_INCIDENCIA',vDescripcion,SYSDATE,USER );
--
   FOR vIdioma IN OtrosIdiomas LOOP
      vDescripcion:='SIN DESCRIPCION';
      INSERT INTO GE_MULTIIDIOMA (
         NOM_TABLA, NOM_CAMPO, COD_PRODUCTO, COD_CONCEPTO, COD_IDIOMA,
         NOM_CAMPO_DES, DES_CONCEPTO, FEC_ULTMOD, NOM_USUARIO)
      VALUES (
         'CA_TIPINCIDENCIAS','TIP_INCIDENCIA',nCodProd,pTipIncidencia,vIdioma.COD_VALOR,
         'DES_INCIDENCIA',vDescripcion,SYSDATE,USER );
   END LOOP;
--
   COMMIT;
--
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
   ROLLBACK;
        vDescError := 'Registro ya existente en la tabla';
        RAISE_APPLICATION_ERROR(-20001, vDescError);
   NULL;
WHEN NO_DATA_FOUND THEN
   ROLLBACK;
        vDescError := 'nO SE ENCONTRO EL REGISTRO';
        RAISE_APPLICATION_ERROR(-20002, vDescError);
   NULL;
WHEN OTHERS THEN
   ROLLBACK;
  vDescError := 'Error inesperado, Codigo:'||SQLCODE||'  Descripcion:'||SQLERRM;
        RAISE_APPLICATION_ERROR(-20003, vDescError);
   NULL;
END;
/
SHOW ERRORS
