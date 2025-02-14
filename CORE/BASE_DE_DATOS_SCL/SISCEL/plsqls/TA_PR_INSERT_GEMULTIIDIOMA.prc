CREATE OR REPLACE PROCEDURE  TA_PR_INSERT_GEMULTIIDIOMA
(
   pNomTabla    GE_MULTIIDIOMA.NOM_TABLA%TYPE,
   pNomCampo    GE_MULTIIDIOMA.NOM_CAMPO%TYPE,
   pCodConcepto GE_MULTIIDIOMA.COD_CONCEPTO%TYPE,
   pNomCampoDes GE_MULTIIDIOMA.NOM_CAMPO%TYPE,
   pDesConcepto GE_MULTIIDIOMA.DES_CONCEPTO%TYPE
)
IS
--
   vIdioma       GED_CODIGOS.COD_VALOR%TYPE;
   vDescripcion  GE_MULTIIDIOMA.DES_CONCEPTO%TYPE;
   nCodProd      NUMBER(1);
--
   CURSOR OtrosIdiomas IS
   SELECT COD_VALOR AS CodIdioma --, TRIM(DES_VALOR) AS DesIdioma
     FROM GED_CODIGOS
    WHERE COD_MODULO ='GE'
      AND NOM_TABLA ='GE_MULTIIDIOMA';
      --AND COD_VALOR <> ge_fn_idioma_local();
--
BEGIN
   nCodProd := 0;
   vIdioma  := ge_fn_idioma_local();
--
  -- INSERT INTO GE_MULTIIDIOMA (
  --    NOM_TABLA,     NOM_CAMPO,    COD_PRODUCTO, COD_CONCEPTO, COD_IDIOMA,
  --    NOM_CAMPO_DES, DES_CONCEPTO, FEC_ULTMOD,   NOM_USUARIO)
  -- VALUES (
  --    pNomTabla,     pNomCampo,    nCodProd,     pCodConcepto, vIdioma,
  --   pNomCampoDes,  pDesConcepto, SYSDATE,      USER);
--
   FOR Cur IN OtrosIdiomas LOOP
      vDescripcion:= 'SIN DESCRIPCION' ;--||' EN '|| Cur.DesIdioma ;
      INSERT INTO GE_MULTIIDIOMA (
         NOM_TABLA,     NOM_CAMPO,    COD_PRODUCTO, COD_CONCEPTO, COD_IDIOMA,
         NOM_CAMPO_DES, DES_CONCEPTO, FEC_ULTMOD,   NOM_USUARIO)
      VALUES (
         pNomTabla,     pNomCampo,    nCodProd,     pCodConcepto, Cur.CodIdioma,
         pNomCampoDes,  vDescripcion, SYSDATE,      USER);
   END LOOP;
--
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
   ROLLBACK;
   RAISE_APPLICATION_ERROR(-20002, 'Registro ya existente en la tabla');
WHEN NO_DATA_FOUND THEN
   ROLLBACK;
   RAISE_APPLICATION_ERROR(-20003, 'No existe Idioma Local');
WHEN OTHERS THEN
   ROLLBACK;
   RAISE_APPLICATION_ERROR(-20004, 'Error inesperado en ta_pr_insert_gemultiidioma, Codigo:'||sqlcode||'  Descripcion:'||sqlerrm);
END;
/
SHOW ERRORS
