CREATE OR REPLACE PROCEDURE CUENTA_FILAS AS
--
CURSOR c_tablas IS
SELECT TABLE_NAME FROM ALL_TABLES WHERE OWNER = 'SISCEL';
--
CURSOR c_tablas_lnk(nombre_tabla  ALL_TABLES.TABLE_NAME%TYPE) IS
SELECT TABLE_NAME 
FROM ALL_TABLES 
WHERE OWNER = 'SISCEL'
  AND TABLE_NAME = nombre_tabla;
--
comando			   		varchar2(100);
comando_lnk 	   		varchar2(100);
l_match_records    		number:=0;
l_match_records_lnk		number:=0;
--
BEGIN
    --
    FOR r_tablas IN c_tablas LOOP
	    l_match_records:=0; 
  		comando:='SELECT COUNT(*) FROM '||r_tablas.table_name;
		--
		EXECUTE IMMEDIATE comando INTO l_match_records;
		--
		IF (l_match_records > 0) THEN
		   DBMS_OUTPUT.PUT_LINE('#reg tabla '||r_tablas.table_name||' '||l_match_records);
		END IF;
		--
		--
		/*
		FOR r_tab_lnk IN c_tablas_lnk(r_tablas.table_name) LOOP
		   comando_lnk:='SELECT COUNT(*) FROM '||r_tab_lnk.table_name||'@MORIA';
		   EXECUTE IMMEDIATE comando INTO l_match_records;
		   --DBMS_OUTPUT.PUT_LINE('#reg tabla '||r_tablas.table_name||' '||l_match_records);
		END LOOP;
	    --si existen diferencias se imprime tabla y cantidad
		DBMS_OUTPUT.PUT_LINE('contador 1 '||to_char(l_match_records));
		DBMS_OUTPUT.PUT_LINE('contador 2 '||to_char(l_match_records_lnk));
		IF (l_match_records <> l_match_records_lnk) THEN
			DBMS_OUTPUT.PUT_LINE('SID TITAN_TMM	--> TABLA --> '||r_tablas.table_name||' --> '||l_match_records);
  			DBMS_OUTPUT.PUT_LINE('SID MORIA		-->       --> '||l_match_records_lnk);
		END IF;
		*/
		--
    END LOOP;
	--    
END CUENTA_FILAS;
/
SHOW ERRORS
