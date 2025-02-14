CREATE OR REPLACE PACKAGE BODY VIEW_PARENT_TABLE_PKG AS
   --
   PROCEDURE VIEW_TABLES(tabla		VARCHAR2) IS
   --
   t_tabla	  		  ALL_CONSTRAINTS.TABLE_NAME%type;
   v_comentario		  ALL_TAB_COMMENTS.COMMENTS%type;
   --
   CURSOR q_tablas IS
   SELECT table_name
   FROM ALL_TABLES t
   WHERE t.owner = 'SISCEL'
     AND ( t.table_name like ('%') OR  t.table_name = tabla);
   --
   BEGIN
      OPEN q_tablas;
	  DBMS_OUTPUT.PUT_LINE('-----------------------------***** INFORME INTEGRIDAD DE TABLAS *****-----------------------------');
      LOOP
    	 FETCH q_tablas INTO t_tabla;
    	 EXIT WHEN q_tablas%NOTFOUND;
		 --
		 BEGIN
		    v_comentario:=NULL;
		    SELECT COMMENTS
			INTO v_comentario 
			FROM ALL_TAB_COMMENTS
			WHERE table_name = t_tabla;
		 EXCEPTION WHEN OTHERS THEN
		    --
            DBMS_OUTPUT.PUT_LINE('Error --> '||sqlerrm);
			--	
  		 END; 
		 --
 	     DBMS_OUTPUT.PUT_LINE('***** ANALIZANDO TABLA '||t_tabla|| ' '||v_comentario);
		 VIEW_PARENT_TABLE_PKG.VIEW_PARENT_TABLE(t_tabla); 
	  END LOOP;
   --   	 
   EXCEPTION WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('Error --> '||sqlerrm);	
   END;
   --
   PROCEDURE VIEW_PARENT_TABLE(tabla		VARCHAR2) IS
   --
   p_tabla	  		  ALL_CONSTRAINTS.TABLE_NAME%type;
   p_r_nombre		  ALL_CONSTRAINTS.R_CONSTRAINT_NAME%type;
   p_nombre		  	  ALL_CONSTRAINTS.CONSTRAINT_NAME%type;
   p_tipo			  ALL_CONSTRAINTS.CONSTRAINT_TYPE %type;
   h_tabla	  		  ALL_CONSTRAINTS.TABLE_NAME%type;
   h_nombre		  	  ALL_CONSTRAINTS.CONSTRAINT_NAME%type;
   h_tipo			  ALL_CONSTRAINTS.CONSTRAINT_TYPE %type;
   c_columna		  ALL_CONS_COLUMNS.COLUMN_NAME%TYPE;
   --
   CURSOR q_padre IS
   SELECT p.table_name, p.constraint_name, p.r_constraint_name,p.constraint_type 
   FROM ALL_CONSTRAINTS p
   WHERE (p.table_name      like ('%') OR p.table_name  = tabla)  
     AND p.constraint_type <> 'C'
  	 AND owner not in ('SYS','SYSTEM');
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
   		 --
		 valor:=0;
		 fecha:=null;
		 --
	     SELECT SYSDATE INTO fecha FROM DUAL;
		 --
		 --DBMS_OUTPUT.PUT_LINE('Fecha '||fecha);
		 --
		 --
		 OPEN q_padre;
    	 LOOP
    	 FETCH q_padre INTO p_tabla, p_nombre, p_r_nombre, p_tipo ;
    	 EXIT WHEN q_padre%NOTFOUND;
		 --
		 IF (p_tipo = 'P') THEN
    	   DBMS_OUTPUT.PUT_LINE('*** PRIMARY KEY');
    	   --dbms_output.put_line('Tabla      --> '||p_tabla);
    	   DBMS_OUTPUT.PUT_LINE('Nombre PK   --> '||p_nombre);
		   OPEN q_cols(p_nombre);
           LOOP
   	   	      FETCH q_cols INTO c_columna;
   	   	      EXIT WHEN q_cols%NOTFOUND;
		      --
		      DBMS_OUTPUT.PUT_LINE('Columna     --> '||c_columna);
			  --
           END LOOP;			   --
		   CLOSE q_cols;
		 ELSIF  p_tipo = 'R' THEN
		   --
		   linea:=linea+1;
    	   DBMS_OUTPUT.PUT_LINE('*** FOREIGN KEY '||TO_CHAR(linea));
    	   DBMS_OUTPUT.PUT_LINE('Nombre      --> '||p_nombre);
		   DBMS_OUTPUT.PUT_LINE('Referencia  --> '||p_r_nombre);
		   --	   --
		   OPEN q_hijo(p_r_nombre);
           LOOP
    	   	   FETCH q_hijo INTO h_tabla, h_nombre;
    	   	   EXIT WHEN q_hijo%NOTFOUND;
			   --
			   DBMS_OUTPUT.PUT_LINE('Tabla       --> '||h_tabla);
    	   	   --dbms_output.put_line('Nombre FK--> '||h_nombre);
			   --
			   OPEN q_cols(p_nombre);
               LOOP
    	   	   FETCH q_cols INTO c_columna;
    	   	   EXIT WHEN q_cols%NOTFOUND;
			   --
			   DBMS_OUTPUT.PUT_LINE('Columna     --> '||c_columna);
    	   	   --dbms_output.put_line('Nombre FK--> '||h_nombre);
               END LOOP;			   --
			   --
			   CLOSE q_cols;
			   --			   
           END LOOP;
		   --
           CLOSE q_hijo;
		   --		 	     			   		
		 END IF;		
		 --
       END LOOP;
       CLOSE q_padre;
	   --
   EXCEPTION WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('Error --> '||sqlerrm);	
   END;
END VIEW_PARENT_TABLE_PKG;
/
SHOW ERRORS
