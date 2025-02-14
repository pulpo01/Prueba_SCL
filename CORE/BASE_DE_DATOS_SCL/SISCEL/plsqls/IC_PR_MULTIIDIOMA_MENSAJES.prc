CREATE OR REPLACE PROCEDURE        IC_PR_MULTIIDIOMA_MENSAJES(CodMen icg_mensaje.COD_MENSAJE%TYPE,DesMen icg_mensaje.DES_MENSAJE%TYPE ) IS
-- Procedimiento que es llamado desde el Trigger ICG_AFIN_MENSAJE
-- y que ingresa a la ge_multiidioma los registros nuevos en un idioma
-- alternativo.
   vDescripcion icg_mensaje.DES_mensaje%TYPE;
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
	 AND NOM_COLUMNA = 'COD_IDIOMA'
     AND COD_VALOR <> Ge_Fn_Idioma_Local();
BEGIN
   nCodProd := 1;
   nCont := 1;
   vDescripcion:= DesMen;
--
   vIdioma := Ge_Fn_Idioma_Local();
--
   INSERT INTO GE_MULTIIDIOMA(NOM_TABLA,
                              NOM_CAMPO,
							  COD_PRODUCTO,
							  COD_CONCEPTO,
							  COD_IDIOMA,
                              NOM_CAMPO_DES,
							  DES_CONCEPTO,
							  FEC_ULTMOD,
							  NOM_USUARIO)
                       VALUES('ICG_MENSAJE',
                              'COD_MENSAJE',
                              nCodProd,
                              CodMen,
                              vIdioma,
                              'DES_MENSAJE',
                              vDescripcion,
                              SYSDATE,
                              USER);
--
   FOR vIdioma IN OtrosIdiomas LOOP
      vDescripcion:='SIN DESCRIPCION';
      INSERT INTO GE_MULTIIDIOMA (NOM_TABLA,
	                              NOM_CAMPO,
								  COD_PRODUCTO,
								  COD_CONCEPTO,
								  COD_IDIOMA,
                                  NOM_CAMPO_DES,
								  DES_CONCEPTO,
								  FEC_ULTMOD,
								  NOM_USUARIO)
                          VALUES ('ICG_MENSAJE',
						          'COD_MENSAJE',
								  nCodProd,
								  CodMen,
								  vIdioma.COD_VALOR,
                                  'DES_MENSAJE',
								  vDescripcion,
								  SYSDATE,
								  USER );
   END LOOP;
--
   --COMMIT;
--
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
  -- ROLLBACK;
   vDescError := 'Registro ya existente en la tabla';
   RAISE_APPLICATION_ERROR(-20002, vDescError);
WHEN NO_DATA_FOUND THEN
   --ROLLBACK;
   vDescError := 'No existe Idioma Local';
   RAISE_APPLICATION_ERROR(-20003, vDescError);
WHEN OTHERS THEN
   --ROLLBACK;
   vDescError := 'Error inesperado en ge_pr_multiidioma_categrecl, Codigo:'||SQLCODE||'  Descripcion:'||SQLERRM;
   RAISE_APPLICATION_ERROR(-20004, vDescError);
END;
/
SHOW ERRORS
