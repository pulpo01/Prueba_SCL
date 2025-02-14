CREATE OR REPLACE PROCEDURE consulta_scl_basico
(p_dn IN ga_aboamist.num_celular%TYPE,
 p_resultado OUT NUMBER,
 p_tecnologia OUT varchar2,
 p_plan OUT varchar2)
IS

v_central icg_central.nom_central%TYPE;
v_uso ga_abocel.cod_uso%TYPE:= -1;

BEGIN

	p_resultado:=0;
	p_tecnologia:='';
	p_plan:='';

	SELECT b.nom_central,a.cod_uso
	INTO v_central, v_uso
	FROM ga_abocel a, icg_central b
	WHERE a.num_celular= p_dn and a.cod_central=b.cod_central
	and rownum <2 ;

	--	dbms_output.put_line(v_central);
	--	dbms_output.put_line(v_uso);

	if(v_central like '%850%') then
	     dbms_output.put_line('Es 850');
		 p_tecnologia:='850';
	elsif(v_central like '%1900%') then
	     dbms_output.put_line('Es 1900');
		 p_tecnologia:='1900';
	else
	     dbms_output.put_line('ES GSM');
		 p_tecnologia:='GSM';
	end if;

	if(v_uso=10) then
		 dbms_output.put_line('Es Ahorro');
		 p_plan:='Ahorro';
	else
		 dbms_output.put_line('Es Postpago');
		 p_plan:='Postpago';
	end if;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
       dbms_output.put_line('No existe el DN en ga_abocel. se busca en ga_aboamist: '||p_dn);

	 BEGIN
	   SELECT b.nom_central,a.cod_uso
	   INTO v_central, v_uso
  	   FROM ga_aboamist a, icg_central b
 	   WHERE a.num_celular= p_dn and a.cod_central=b.cod_central
	   and rownum <2 ;

	 --  dbms_output.put_line(v_central);
	 -- dbms_output.put_line(v_uso);

		if(v_central like '%850%') then
	     dbms_output.put_line('Es 850');
		 p_tecnologia:='850';
		elsif(v_central like '%1900%') then
	     dbms_output.put_line('Es 1900');
		 p_tecnologia:='1900';
		else
	     dbms_output.put_line('ES GSM');
		 p_tecnologia:='GSM';
		end if;

		if(v_uso=10) then
		 dbms_output.put_line('Es Ahorro');
 		 p_plan:='Ahorro';
		else
		 dbms_output.put_line('Es Prepago');
 		 p_plan:='Prepago';
		end if;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
       dbms_output.put_line('Tampoco Existe en ga_aboamist: '||p_dn);
	   p_resultado:=-2;
	END;

	when others then
	   dbms_output.put_line('Algun error ocurrio con la BD...');
       p_resultado:=-3;


END consulta_scl_basico;
/
SHOW ERRORS
