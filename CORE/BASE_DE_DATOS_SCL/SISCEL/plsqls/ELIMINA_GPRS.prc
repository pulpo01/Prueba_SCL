CREATE OR REPLACE PROCEDURE elimina_gprs
(p_dn IN ga_aboamist.num_celular%TYPE,
 p_resultado OUT NUMBER)
IS

v_abonado ga_aboamist.num_abonado%TYPE := 0;

BEGIN

	p_resultado:=0;

	SELECT num_abonado
	INTO v_abonado
	FROM ga_aboamist
	WHERE num_celular= p_dn;
	dbms_output.put_line(v_abonado);

	delete ga_servsuplabo
	where cod_servicio='75' and num_abonado=v_abonado;

	if(SQL%NOTFOUND) then
         dbms_output.put_line('Algun error ocurrio con la BD (Delete)');
		 p_resultado:=-1;
	else
		BEGIN
		UPDATE ga_aboamist SET
		clase_servicio=REPLACE(clase_servicio,'750001',''),
		perfil_abonado=REPLACE(perfil_abonado,'750001','')
		WHERE num_abonado=v_abonado;

		if(SQL%NOTFOUND) then
        	dbms_output.put_line('No se actualizo ningun registro 75');
		end if;

		UPDATE ga_aboamist SET
		clase_servicio=REPLACE(clase_servicio,'850001',''),
		perfil_abonado=REPLACE(perfil_abonado,'850001','')
		WHERE num_abonado=v_abonado;

		if(SQL%NOTFOUND) then
        	dbms_output.put_line('No se actualizo ningun registro 85');
		end if;

		UPDATE ga_aboamist SET
		clase_servicio=REPLACE(clase_servicio,'850002',''),
		perfil_abonado=REPLACE(perfil_abonado,'850002','')
		WHERE num_abonado=v_abonado;

		if(SQL%NOTFOUND) then
        	dbms_output.put_line('No se actualizo ningun registro 85-2');
		end if;

		UPDATE ga_aboamist SET
		clase_servicio=REPLACE(clase_servicio,'900001',''),
		perfil_abonado=REPLACE(perfil_abonado,'900001','')
		WHERE num_abonado=v_abonado;

		if(SQL%NOTFOUND) then
        	dbms_output.put_line('No se actualizo ningun registro 90');
		end if;


		UPDATE ga_aboamist SET
		clase_servicio=REPLACE(clase_servicio,'900002',''),
		perfil_abonado=REPLACE(perfil_abonado,'900002','')
		WHERE num_abonado=v_abonado;

		if(SQL%NOTFOUND) then
        	dbms_output.put_line('No se actualizo ningun registro 90-2');
		end if;

		commit;
        dbms_output.put_line('Commit ok');


		EXCEPTION
		when others then
			       dbms_output.put_line('Algun error ocurrio con la BD...');
				   p_resultado:=-3;

	    END;
	end if;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
       dbms_output.put_line('No existe el DN: '||p_dn);
  	   p_resultado:=-2;
	when others then
	       dbms_output.put_line('Algun error ocurrio con la BD...');
    	   p_resultado:=-3;
END elimina_gprs;
/
SHOW ERRORS
