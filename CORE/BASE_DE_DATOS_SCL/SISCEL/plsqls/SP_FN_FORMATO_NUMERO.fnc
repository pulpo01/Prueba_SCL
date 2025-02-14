CREATE OR REPLACE FUNCTION          "SP_FN_FORMATO_NUMERO" (p_nrosinformato  number, p_num_decimal number) return varchar2
is

v_nroconformato     varchar2(30);
v_nroformatostd     varchar2(30);
v_nroformatopas     varchar2(30);
v_sep_decimal_st    varchar2(1);
v_sep_miles_st      varchar2(1);
v_formato_numero    varchar2(30);
v_sep_decimal_local varchar2(1);
v_sep_miles_local   varchar2(1);
v_num_dec           number;
v_parte_entera      varchar2(30);
v_parte_decimal     varchar2(30);
v_parte             varchar2(30);
begin

      --Separador de decimales usado por Oracle
      SELECT substr(value,1,1)
	  INTO  v_sep_decimal_st
	  FROM sys.v_$nls_parameters
      WHERE parameter='NLS_NUMERIC_CHARACTERS';

	  --Separador de miles usado por Oracle
	  SELECT substr(value,2,1)
	  INTO v_sep_miles_st
	  FROM sys.v_$nls_parameters
      WHERE parameter='NLS_NUMERIC_CHARACTERS';

      v_formato_numero:='9'||v_sep_miles_st||'999'||v_sep_miles_st||'999'||v_sep_miles_st||'999'||v_sep_miles_st||'999'||v_sep_miles_st||'999'||v_sep_decimal_st||'9999';
      dbms_output.put_line(v_formato_numero);


	 v_sep_decimal_local:=v_sep_decimal_st;
	 SELECT nvl(val_parametro,v_sep_decimal_st)
	 INTO v_sep_decimal_local
	 FROM ged_parametros
	 WHERE nom_parametro='SEP_DECIMALES_MONTOS'
     AND cod_modulo='GE'
	 AND cod_producto=1;


	 v_sep_miles_local:=v_sep_miles_st;
	 SELECT nvl(val_parametro,v_sep_miles_st)
	 INTO v_sep_miles_local
	 FROM ged_parametros
	 WHERE nom_parametro='SEP_MILES_MONTOS'
     AND cod_modulo='GE'
	 AND cod_producto=1;


	 SELECT decode(p_num_decimal,0,0,p_num_decimal + 1)
	 INTO v_num_dec
	 FROM dual;


	 v_nroformatostd:=ltrim(rtrim(to_char(p_nrosinformato,v_formato_numero)));
	 dbms_output.put_line(v_nroformatostd);
	 v_nroformatopas:= replace(replace(v_nroformatostd,'.','d'),',','m');

	 v_parte_entera:=substr(v_nroformatopas,1,(instr(v_nroformatopas,'d') -1));
     dbms_output.put_line(v_parte_entera);

	 v_parte_decimal:=substr(v_nroformatopas,instr(v_nroformatopas,'d'),v_num_dec);
	 dbms_output.put_line(v_parte_decimal);

     v_parte:=ltrim(rtrim(v_parte_entera||v_parte_decimal));

	 v_nroconformato:=replace(replace(v_parte,'d',v_sep_decimal_local),'m', v_sep_miles_local);
     dbms_output.put_line(v_nroconformato);


	 RETURN v_nroconformato;

EXCEPTION
  when OTHERS then
       raise_application_error(-20147,'Error Conversion Numero');

end;
/
SHOW ERRORS
