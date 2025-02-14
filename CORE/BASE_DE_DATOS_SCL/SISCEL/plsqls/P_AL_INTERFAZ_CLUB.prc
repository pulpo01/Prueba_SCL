CREATE OR REPLACE PROCEDURE        P_AL_INTERFAZ_CLUB(
v_num_abonado   	in CHAR,
v_usu_proceso   	in CHAR,
v_fec_proceso   	in CHAR,
v_cod_causabaja   	in CHAR,
v_cod_estado           in CHAR
)
as
vp_cont_estado   	number;
vp_num_abonados         number;
vp_estado        	al_tarjetas_club.cod_estado%type;
vp_num_serie     	al_tarjetas_club.num_serie%type;
vp_serie     		al_tarjetas_club.num_serie%type;
vp_cod_usuario   	al_tarjetas_club.cod_usuario%type;
vp_dur_vigencia  	al_club_general.dur_vigencia%TYPE;
vp_cod_cliente   	ga_abocel.cod_cliente%type;
vp_rango         	al_rangos_club.cod_rango%type;
vp_can_rango     	number;
vp_num_abonado  	al_tarjetas_club.num_abonado%type;
vp_usu_proceso   	al_tarjetas_club.usu_peticion%type;
vp_fec_proceso   	al_tarjetas_club.fec_peticion%type;
vp_cod_causabaja   	al_tarjetas_club.cod_causabaja%type;
vp_cod_estado           al_tarjetas_club.cod_estado%type;
BEGIN
vp_num_abonado  	:= to_number(v_num_abonado);
vp_usu_proceso   	:= v_usu_proceso;
vp_fec_proceso   	:= to_date(v_fec_proceso,'DD-MM-YYYY HH24:MI:SS');
vp_cod_causabaja   	:= v_cod_causabaja;
vp_cod_estado           := v_cod_estado;
   if vp_cod_estado = 'PD' then
	SELECT COUNT(*) INTO vp_cont_estado FROM AL_TARJETAS_CLUB
        	WHERE NUM_ABONADO = vp_num_abonado
        	AND COD_ESTADO IN ('NU','EN','RE','PD');
         if vp_cont_estado >= 1 then
		 raise_application_error (-20260,
		    'CLUB:' || to_char(SQLCODE)|| ' ERROR PD');
         end if;
	 if vp_usu_proceso is null  then
		vp_usu_proceso := USER;
 	 end if ;
         if vp_fec_proceso is null then
		vp_fec_proceso := SYSDATE;
	 end if;
         SELECT DUR_VIGENCIA INTO vp_dur_vigencia FROM AL_CLUB_GENERAL;
         SELECT COD_CLIENTE INTO vp_cod_cliente FROM GA_ABOCEL
         WHERE NUM_ABONADO = vp_num_abonado;
         SELECT COUNT(*) INTO vp_can_rango FROM GE_CLIENTES A,AL_RANGOS_CLUB B
         WHERE A.COD_CLIENTE = vp_cod_cliente
         AND A.COD_CATEGORIA = B.COD_CATEGORIA;
         If vp_can_rango = 0 Then
            vp_rango:= '000';
         else
            SELECT B.COD_RANGO INTO vp_rango FROM GE_CLIENTES A,AL_RANGOS_CLUB B
            WHERE A.COD_CLIENTE = vp_cod_cliente
            AND A.COD_CATEGORIA = B.COD_CATEGORIA;
         End If;
	 dbms_output.put_line(to_char(vp_cod_cliente));
	 SELECT count(*) into vp_num_abonados
		FROM GA_ABOCEL WHERE COD_CLIENTE = vp_cod_cliente
		AND COD_SITUACION ='AAA'
	 	AND FEC_ALTA < ADD_MONTHS(vp_fec_proceso,- 2)
		AND ROWNUM < 2;
	 if vp_num_abonados =0 then
		 raise_application_error (-20261,
		    'CLUB:' || to_char(SQLCODE)|| ' ERROR PD NA');
         end if;
	 SELECT AL_SEQ_CLUB.NEXTVAL INTO vp_num_serie FROM DUAL;
         vp_serie:= vp_rango||vp_num_serie;
         SELECT COD_USUARIO INTO vp_cod_usuario FROM GA_ABOCEL WHERE NUM_ABONADO=vp_num_abonado;
         INSERT INTO AL_TARJETAS_CLUB(num_serie,cod_estado,cod_usuario,num_abonado,cod_producto,
                                      usu_peticion,fec_peticion,usu_creacion,fec_creacion,usu_envio,
				      fec_envio,usu_recepcion,fec_recepcion,usu_baja,fec_baja,
				      usu_vigencia,fec_vigencia,cod_causabaja) values
                                      (vp_serie,vp_cod_estado,vp_cod_usuario,vp_num_abonado,
				      1,vp_usu_proceso,vp_fec_proceso,null,null,null,null,null,null,
                                      null,null,vp_usu_proceso,ADD_MONTHS(TRUNC(SYSDATE,'MONTH'),vp_dur_vigencia + 1),null);
    elsif vp_cod_estado = 'BA' then
            SELECT COUNT(*) INTO vp_cont_estado
            FROM AL_TARJETAS_CLUB
            WHERE NUM_ABONADO = vp_num_abonado AND COD_ESTADO = 'RE';
            if vp_cont_estado = 0 then
		raise_application_error (-20262,
		    'CLUB:' || to_char(SQLCODE)|| ' ERROR BAJA.');
            else
		if vp_usu_proceso is null or vp_fec_proceso is null then
			vp_usu_proceso := USER;
			vp_fec_proceso := SYSDATE;
	 	end if;
               	UPDATE AL_TARJETAS_CLUB SET usu_baja = vp_usu_proceso,fec_baja=vp_fec_proceso,cod_causabaja=vp_cod_causabaja,cod_estado=vp_cod_estado
               	where NUM_ABONADO=vp_num_abonado AND COD_ESTADO = 'RE';
            end if;
   elsif vp_cod_estado = 'AB' then  -- Anulacion de baja de abonados
	    SELECT COUNT(*) INTO vp_cont_estado
            FROM AL_TARJETAS_CLUB
            WHERE NUM_ABONADO = vp_num_abonado AND COD_ESTADO = 'BA';
            if vp_cont_estado = 0 then
		raise_application_error (-20263,
		'CLUB:' || to_char(SQLCODE)|| ' ERROR ANULABAJA.');
            else
	       if vp_usu_proceso is null or vp_fec_proceso is null then
			vp_usu_proceso := USER;
			vp_fec_proceso := SYSDATE;
	       end if;
               UPDATE AL_TARJETAS_CLUB SET cod_estado='RE',
	       usu_rev_baja = vp_usu_proceso,fec_rev_baja=vp_fec_proceso
               where NUM_ABONADO=vp_num_abonado AND COD_ESTADO = 'BA'
	       and FEC_BAJA =
			(SELECT MAX(FEC_BAJA) FROM AL_TARJETAS_CLUB WHERE
			NUM_ABONADO=vp_num_abonado AND COD_ESTADO = 'BA')
	       and ROWNUM < 2;
            end if;
   end if;
EXCEPTION
   WHEN OTHERS then
	if SQLCODE = -20260 then
		raise_application_error (-20260,
		'CLUB:' || to_char(SQLCODE)|| ' ERROR PD');
	elsif SQLCODE = -20261 then
		raise_application_error (-20261,
		'CLUB:' || to_char(SQLCODE)|| ' ERROR PD NA.');
	elsif SQLCODE = -20262 then
		raise_application_error (-20262,
		'CLUB:' || to_char(SQLCODE)|| ' ERROR BAJA.');
	elsif SQLCODE = -20263 then
		raise_application_error (-20263,
		'CLUB:' || to_char(SQLCODE)|| ' ERROR ANULABAJA.');
	else
		raise_application_error (-20264,
		'CLUB:' || to_char(SQLCODE)|| ' ERROR GENERICO.');
	end if;
END;
/
SHOW ERRORS
