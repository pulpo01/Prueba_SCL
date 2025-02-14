CREATE OR REPLACE FUNCTION        GE_FN_ELIM_IDIOMA_ALT (v_nom_tabla ge_multiidioma.nom_tabla%TYPE, v_cod_idioma ge_multiidioma.cod_idioma%TYPE) RETURN VARCHAR2
IS
-- Funcion que elimina de GE_MULTIIDIOMA cuando nom_tabla=v_nom_tabla
-- y cod_idioma = v_cod_idioma
-- Creacion : 11 de abril de 2002
-- Autor Doris Soto A.
   v_salida VARCHAR2(1500) := '';
BEGIN
   DELETE FROM ge_multiidioma
   WHERE nom_tabla = v_nom_tabla
     AND cod_idioma = v_cod_idioma;
   RETURN '0';
EXCEPTION
WHEN OTHERS THEN
   RETURN 'Error en ge_fn_elim_idioma_alt' || TO_CHAR(SQLCODE)|| ', ' || SQLERRM;
END;
/
SHOW ERRORS
