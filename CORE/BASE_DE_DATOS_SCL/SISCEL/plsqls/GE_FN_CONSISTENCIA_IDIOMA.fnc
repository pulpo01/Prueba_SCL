CREATE OR REPLACE FUNCTION        GE_FN_CONSISTENCIA_IDIOMA RETURN VARCHAR2
IS
-- Funcion que valida que las tablas que estan en GE_MULTIIDIOMA tengan
-- la misma cantidad de resgistros que esta. Retorna un string concatenado
-- por pipes con el numero de resgistros diferentes para cada tabla.
-- Creacion : 10 de abril de 2002
-- Autor Doris Soto A.
--
   v_comando_sql  VARCHAR2(256) := '';
   v_existe NUMBER;
   v_salida VARCHAR2(1500) := '';
   v_consistente NUMBER := 0;
--
   CURSOR tablas_idiomas IS
   SELECT DISTINCT a.nom_tabla as tabla
   FROM ge_multiidioma a
   WHERE a.cod_idioma = ge_fn_idioma_local()
   ORDER BY nom_tabla;
--
BEGIN
   FOR TI IN tablas_idiomas LOOP
      SELECT COUNT(*) INTO v_existe -- Valida existencia de tabla
      FROM all_tables
      WHERE table_name = TI.tabla;
      IF v_existe > 0 THEN
         v_comando_sql:= 'SELECT a.contador - b.contador FROM (SELECT COUNT(*) AS contador FROM ';
         v_comando_sql:= v_comando_sql || TI.tabla || ') a, (SELECT COUNT(*) AS contador FROM ge_multiidioma WHERE nom_tabla = ''';
         v_comando_sql:= v_comando_sql || TI.tabla || ''' AND cod_idioma = ''' || ge_fn_idioma_local() || ''') b';
         EXECUTE IMMEDIATE v_comando_sql INTO v_existe; -- Obtiene la diferencia entre tabla origen y GE_MULTIIDIOMA
         IF v_existe > 0 THEN  -- Diferencia positiva. Tabla origen tiene mas conceptos
            v_consistente := 1;
            v_salida := v_salida || '|' || TI.tabla || ' tiene ' || TO_CHAR(v_existe) || ' registros mas que ge_multiidioma';
         ELSIF v_existe < 0 THEN  -- Diferencia negativa. Tabla origen tiene menos conceptos
            v_salida := v_salida || '|' || TI.tabla || ' tiene ' || TO_CHAR(ABS(v_existe)) || ' registros menos que ge_multiidioma';
            v_consistente := 1;
         END IF;
      ELSE
         v_salida := v_salida || '|' || TI.tabla || ' no existe con usuario ' || user;
         v_consistente := 1;
      END IF;
   END LOOP;
   IF v_consistente = 1 THEN
      v_salida := v_salida || '|';
   ELSE
      v_salida := '0';
   END IF;
   RETURN v_salida;
EXCEPTION
WHEN OTHERS THEN
   RETURN '|Error en ge_fn_consistencia_idioma.' || TO_CHAR(SQLCODE)|| ', ' || SQLERRM || '|';
END;
/
SHOW ERRORS
