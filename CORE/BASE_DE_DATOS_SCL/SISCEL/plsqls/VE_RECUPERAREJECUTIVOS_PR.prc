CREATE OR REPLACE PROCEDURE VE_RecuperarEjecutivos_PR(TipComis NUMBER,
			  				 						  SALIDA OUT GR_TIPOS_PG.ref_cursor) IS

ssql         VARCHAR2(800);
cursor_local GR_TIPOS_PG.ref_cursor;
BEGIN

	ssql:= 'SELECT DISTINCT(A.cod_vendedor) ';
	ssql:= ssql || 'FROM ve_redventas_td A, ve_redventas_td B ';
	ssql:= ssql || 'WHERE A.cod_vende_padre = ' || TO_CHAR(TipComis);
	ssql:= ssql || 'AND A.cod_vende_padre != A.cod_vendedor ';
	ssql:= ssql || 'AND A.cod_vende_padre = B.cod_vendedor ';


	OPEN cursor_local FOR ssql;

	SALIDA:= cursor_local;

END VE_RecuperarEjecutivos_PR;
/
SHOW ERRORS
