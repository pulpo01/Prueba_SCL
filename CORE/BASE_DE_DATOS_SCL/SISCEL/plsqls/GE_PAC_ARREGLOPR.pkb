CREATE OR REPLACE PACKAGE BODY          "GE_PAC_ARREGLOPR"  IS
--
PROCEDURE GE_PR_RetornaArreglo(v_param_entrada IN VARCHAR2, Param IN OUT GE_TABTYPE_VCH2ARRAY) IS
i          NUMBER:=1;
pos	   NUMBER:=1;
maxparam   NUMBER:=50;
subparam   VARCHAR2(100);
caracter   VARCHAR2(1);
--
BEGIN
   WHILE pos <= maxparam LOOP
      SELECT SUBSTR(v_param_entrada,i,1) INTO caracter FROM dual;
	  IF caracter IS NOT NULL THEN
	     IF caracter <> '|' THEN
	        subparam := subparam || caracter;
	     ELSIF i <> 1 THEN
	        Param(pos) := subparam;
--            dbms_output.put_line(to_char(i)||','||to_char(pos)||'='||Param(pos));
	        subparam := '';
            pos:=pos+1;
		 END IF;
	  ELSE
	     pos:=maxparam+1;
	  END IF;
      i:=i+1;
   END LOOP;
END GE_PR_RetornaArreglo;
END GE_PAC_ArregloPR;
/
SHOW ERRORS
