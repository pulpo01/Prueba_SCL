CREATE OR REPLACE PROCEDURE VIEW_PARENT_TABLE(tabla		VARCHAR2) AS
--
p_tabla	  		  ALL_CONSTRAINTS.TABLE_NAME%type;
p_r_nombre		  ALL_CONSTRAINTS.R_CONSTRAINT_NAME%type;
p_nombre		  ALL_CONSTRAINTS.CONSTRAINT_NAME%type;
p_tipo			  ALL_CONSTRAINTS.CONSTRAINT_TYPE %type;
h_tabla	  		  ALL_CONSTRAINTS.TABLE_NAME%type;
h_nombre		  ALL_CONSTRAINTS.CONSTRAINT_NAME%type;
h_tipo			  ALL_CONSTRAINTS.CONSTRAINT_TYPE %type;
c_columna		  ALL_CONS_COLUMNS.COLUMN_NAME%TYPE;
--
CURSOR q_padre IS
SELECT p.table_name, p.constraint_name, p.r_constraint_name,p.constraint_type
FROM ALL_CONSTRAINTS p
WHERE p.table_name      like UPPER(TRIM(tabla))
  AND p.constraint_type <> 'C'
  AND owner = 'SISCEL';
--
CURSOR q_hijo(foranea				VARCHAR2) IS
SELECT h.table_name,h.r_constraint_name
FROM ALL_CONSTRAINTS h
WHERE h.constraint_name = foranea;
--
CURSOR q_cols(v_constraint			VARCHAR2) IS
SELECT c.column_name
FROM ALL_CONS_COLUMNS c
WHERE c.constraint_name = v_constraint;
--
valor 	 	   	 INTEGER:=0;
fecha 			 VARCHAR2(10);
linea			 INTEGER:=0;
--
BEGIN
    DBMS_OUTPUT.PUT_LINE('***** INFORME INTEGRIDAD DE TABLAS *****');
    --
	valor:=0;
	fecha:=null;
	--
	select sysdate into fecha from dual;
	--
	dbms_output.put_line('Fecha '||fecha);
	--
	--
	OPEN q_padre;
    LOOP
    	FETCH q_padre INTO p_tabla, p_nombre, p_r_nombre, p_tipo ;
    	EXIT WHEN q_padre%NOTFOUND;
		--
		IF (p_tipo = 'P') THEN
    	   dbms_output.put_line('*** PRIMARY KEY');
    	   dbms_output.put_line('Tabla      --> '||p_tabla);
    	   dbms_output.put_line('Nombre PK  --> '||p_nombre);
		   OPEN q_cols(p_nombre);
           LOOP
   	   	      FETCH q_cols INTO c_columna;
   	   	      EXIT WHEN q_cols%NOTFOUND;
		      --
		      dbms_output.put_line('Columna  --> '||c_columna);
           END LOOP;			   --
		   CLOSE q_cols;
		ELSIF  p_tipo = 'R' THEN
		   --
		   linea:=linea+1;
    	   dbms_output.put_line('*** FOREIGN KEY '||TO_CHAR(linea));
    	   dbms_output.put_line('Nombre      --> '||p_nombre);
		   dbms_output.put_line('Referencia  --> '||p_r_nombre);
		   --
   		   --exit;
		   --
		   OPEN q_hijo(p_r_nombre);
           LOOP
    	   	   FETCH q_hijo INTO h_tabla, h_nombre;
    	   	   EXIT WHEN q_hijo%NOTFOUND;
			   --
			   dbms_output.put_line('Tabla    --> '||h_tabla);
    	   	   --dbms_output.put_line('Nombre FK--> '||h_nombre);
			   --
			   OPEN q_cols(p_nombre);
               LOOP
    	   	   FETCH q_cols INTO c_columna;
    	   	   EXIT WHEN q_cols%NOTFOUND;
			   --
			   dbms_output.put_line('Columna  --> '||c_columna);
    	   	   --dbms_output.put_line('Nombre FK--> '||h_nombre);
               END LOOP;			   --
			   CLOSE q_cols;
			   --
           END LOOP;
           CLOSE q_hijo;
		   --
		END IF;
		--
    END LOOP;
    CLOSE q_padre;
	--
EXCEPTION WHEN OTHERS THEN
    dbms_output.put_line('Error --> '||sqlerrm);
END;
/
SHOW ERRORS
