CREATE OR REPLACE FUNCTION          "GE_FN_LARGO_DESIDIOMA" (v_nom_tabla VARCHAR2) RETURN NUMBER
IS
-- Funcion que retora el largo del campo descripcion de la tabla ingresada
-- por parametrio y que tiene su descripcion en GE_MULTIIDIOMA
-- Creacion : 12 de abril de 2002
-- Autor Doris Soto A.
--
   v_comando_sql  VARCHAR2(256) := '';
   v_largo NUMBER;
   v_nom_campo_des VARCHAR(256);
--
BEGIN
   SELECT COUNT(*) INTO v_largo -- Valida existencia de tabla
   FROM all_tables
   WHERE table_name = v_nom_tabla;
   IF v_largo = 0 THEN
      RETURN 0; --tabla no existe
   END IF;
   SELECT DISTINCT nom_campo_des INTO v_nom_campo_des
   FROM ge_multiidioma a
   WHERE a.nom_tabla = v_nom_tabla
     AND a.cod_idioma = ge_fn_idioma_local();
   IF v_largo = 0 THEN
      RETURN 0; --tabla no existe
   END IF;
   v_comando_sql:= 'SELECT data_length FROM all_tab_columns WHERE table_name = ''';
   v_comando_sql:= v_comando_sql || v_nom_tabla || ''' AND column_name =''' || v_nom_campo_des || '''';
   EXECUTE IMMEDIATE v_comando_sql INTO v_largo;
   RETURN v_largo;
EXCEPTION
WHEN OTHERS THEN
   RETURN -1; -- Error de otro tipo
END;
/
SHOW ERRORS
