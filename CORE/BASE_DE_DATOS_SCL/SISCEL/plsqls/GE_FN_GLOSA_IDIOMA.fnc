CREATE OR REPLACE FUNCTION        GE_FN_GLOSA_IDIOMA(
   v_nom_tabla ge_multiidioma.nom_tabla%TYPE,
   v_nom_campo ge_multiidioma.nom_campo%TYPE,
   v_cod_producto ge_multiidioma.cod_producto%TYPE,
   v_cod_concepto ge_multiidioma.cod_concepto%TYPE,
   v_cod_idioma ge_multiidioma.cod_idioma%TYPE) RETURN VARCHAR2 IS
--
   error_proceso EXCEPTION;
   v_des_concepto ge_multiidioma.des_concepto%TYPE;
BEGIN
   SELECT des_concepto INTO v_des_concepto
   FROM ge_multiidioma
   WHERE nom_tabla = v_nom_tabla
     AND nom_campo = v_nom_campo
	 AND cod_producto = v_cod_producto
	 AND cod_concepto = v_cod_concepto
	 AND cod_idioma = v_cod_idioma;
   IF SQLCODE <> 0 THEN
      RAISE error_proceso;
   END IF;
   RETURN v_des_concepto;
--
   EXCEPTION
   WHEN error_proceso THEN
      RETURN 'ERROR obtiene_direccion, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;
   WHEN OTHERS THEN
      RETURN 'ERROR obtiene_direccion, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;
END;
/
SHOW ERRORS
