CREATE OR REPLACE PACKAGE BODY ge_seguridad_web_pg AS

   PROCEDURE ge_optener_ticket_seguridad_pr (
     sv_username   OUT NOCOPY VARCHAR2,
	 sn_sid        OUT NOCOPY NUMBER,
	 sn_serial     OUT NOCOPY NUMBER
   )
   IS
   BEGIN

	  SELECT username, sid, serial#
	    INTO sv_username, sn_sid, sn_serial
        FROM v$session a
       WHERE a.username = USER
         AND a.status = 'ACTIVE';

      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            NULL;
   END ge_optener_ticket_seguridad_pr;

   PROCEDURE ge_valida_ticket_seguridad_pr (
      ev_username    IN       VARCHAR2,
	  en_sid         IN       NUMBER,
	  en_serial      IN       NUMBER

   )
   IS
       n_can_reg      NUMBER;
	   error_m_canreg EXCEPTION;
	   error_n_canreg EXCEPTION;

   BEGIN

      SELECT count(1)
	    INTO n_can_reg
        FROM v$session a
       WHERE a.username = ev_username
         AND a.status = 'ACTIVE'
         AND a.sid = en_sid
         AND a.serial# = en_serial;

	  IF n_can_reg > 1 THEN
	     RAISE error_m_canreg;
	  ELSIF n_can_reg < 1 THEN
	     RAISE error_n_canreg;
	  END IF;

      EXCEPTION
	     WHEN error_m_canreg THEN
		    NULL;
		 WHEN error_n_canreg THEN
		    NULL;
         WHEN NO_DATA_FOUND THEN
            NULL;
   END ge_valida_ticket_seguridad_pr;




   PROCEDURE PV_Id_Seguridad_PR
           (
		     COD_USER 			   IN	 			VARCHAR2,
	  		 ID_PROGRAMA 		   IN				VARCHAR2,
	  		 ID_USER 			   OUT NOCOPY		VARCHAR2,
	  		 SN_cod_retorno        OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      		 SV_mens_retorno       OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      		 SN_num_evento         OUT NOCOPY		ge_errores_pg.evento)

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_Id_Seguridad_PR
	      Lenguaje="PL/SQL"
	      Fecha="22-08-2006"
	      Versión="La del package"
	      Diseñador="Oscar Jorquera"
	      Programador="Oscar Jorquera"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción></Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SO_Seguridad " Tipo="estructura">estructura de seguridad</param>>
	         </Entrada>
	         <Salida>
	            <param nom="" Tipo=""></param>>
	            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
	            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
	            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/

	LV_des_error	   ge_errores_pg.DesEvent;
	LV_sSql			   ge_errores_pg.vQuery;

	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;

		LV_sSql := 'SELECT sid ||''|''|| serial# ||''|''|| USERNAME ||''|''||PADDR ||''|''|| USER#  ||''|''|| PROGRAM ||''|''|| UPPER(OSUSER) into ID_USER';
        LV_sSql := LV_sSql || 'FROM v$session ';
        LV_sSql := LV_sSql || 'WHERE audsid = ' || USERENV('SESSIONID');
		LV_sSql := LV_sSql || 'and UPPER(USERNAME) = UPPER('|| Cod_User ||') ';
		LV_sSql := LV_sSql || 'AND UPPER(PROGRAM) = UPPER('|| Id_Programa ||') ';


		SELECT sid ||'|'|| serial# ||'|'|| USERNAME ||'|'||PADDR ||'|'|| USER#  ||'|'|| PROGRAM ||'|'|| UPPER(OSUSER)
		  into ID_USER
		  FROM v$session
		 WHERE audsid          = USERENV('SESSIONID')
		   AND UPPER(USERNAME) = UPPER(Cod_User)
		   AND UPPER(PROGRAM)  = UPPER(Id_Programa);

		SV_mens_retorno := LV_sSql;


	EXCEPTION
	  WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 913;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := 'NO DATA FOUND';
	      END IF;
		  LV_des_error   := ' PV_Id_Seguridad_PR ('||Cod_User||','||Id_Programa||'); - ' || SQLERRM;
		  SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 1, SV_mens_retorno, 1, USER, 'ge_seguridad_web_pg.PV_Id_Seguridad_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

	  WHEN OTHERS THEN
	      SN_cod_retorno := 913;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := 'Error no clasificado';
	      END IF;
		  LV_des_error   := ' PV_Id_Seguridad_PR ('||Cod_User||','||Id_Programa||'); - ' || SQLERRM;
		  SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 1, SV_mens_retorno, 1, USER, 'ge_seguridad_web_pg.PV_Id_Seguridad_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


end PV_Id_Seguridad_PR;


PROCEDURE PV_Id_VerificaSeg_PR
           (
      SO_Seguridad        	   IN OUT NOCOPY	PV_IDSEGURIDAD_QT,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento)

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_Id_VerificaSeg_PR
	      Lenguaje="PL/SQL"
	      Fecha="22-08-2006"
	      Versión="La del package"
	      Diseñador="Oscar Jorquera"
	      Programador="Oscar Jorquera"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción></Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SO_Seguridad " Tipo="estructura">estructura de seguridad</param>>
	         </Entrada>
	         <Salida>
	            <param nom="" Tipo=""></param>>
	            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
	            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
	            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/

	LV_des_error	   ge_errores_pg.DesEvent;
	LV_sSql			   ge_errores_pg.vQuery;
	LV_Valor  VARCHAR2(1);
	LV_SEPARADOR  NUMBER(2):= 0;
	LV_CADENA	  VARCHAR2(100);
	LV_ID NUMBER;
	LV_serial NUMBER;
	LV_USERNAME varchar2(30);
	LV_PADDR raw(8);
	LV_USER number;
	LV_PROGRAM varchar2(48);
	LV_OSUSER varchar2(30);
	lv_existe  number;

	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;
		SO_Seguridad.resultado := 0;


		WHILE length(SO_Seguridad.id_user) <> 0 LOOP
			   LV_Valor := substr(SO_Seguridad.id_user,1,1);

			     If LV_Valor = '|' then
			   	  LV_SEPARADOR := LV_SEPARADOR + 1;


					   IF LV_SEPARADOR = 1 THEN
					   	  LV_ID := TO_NUMBER(LV_CADENA);
						  LV_CADENA := '';
					   END IF;

					   IF LV_SEPARADOR = 2 THEN
					   	  LV_serial := TO_NUMBER(LV_CADENA);
						  LV_CADENA := '';
					   END IF;

					   IF LV_SEPARADOR = 3 THEN
					   	  LV_USERNAME := LV_CADENA;
						  LV_CADENA := '';
					   END IF;

					   IF LV_SEPARADOR = 4 THEN
					   	  LV_PADDR := LV_CADENA;
						  LV_CADENA := '';
					   END IF;

					   IF LV_SEPARADOR = 5 THEN
					   	  LV_USER := TO_NUMBER(LV_CADENA);
						  LV_CADENA := '';
					   END IF;

					   IF LV_SEPARADOR = 6 THEN
					   	  LV_PROGRAM := LV_CADENA;
						  LV_CADENA := '';
						  LV_OSUSER := substr(SO_Seguridad.id_user, 2, length(SO_Seguridad.id_user) - 1);
						  SO_Seguridad.id_user := '';
					   END IF;
			   END IF;

			   If LV_Valor <> '|' then
			   	  LV_CADENA := LV_CADENA || LV_Valor;
			   end if;

			   if length(SO_Seguridad.id_user) >= 2 then
				  SO_Seguridad.id_user := substr(SO_Seguridad.id_user, 2, length(SO_Seguridad.id_user) - 1);
			   end if;

    	END LOOP;

		LV_sSql := 'SELECT count(*) into SO_Seguridad.resultado ';
        LV_sSql := LV_sSql || 'FROM v$session ';
        LV_sSql := LV_sSql || 'WHERE sid = '||LV_ID||' and ';
		LV_sSql := LV_sSql || 'serial# = '||LV_serial||' and ';
		LV_sSql := LV_sSql || 'upper(USERNAME) = upper('||LV_USERNAME||') and ';
		LV_sSql := LV_sSql || 'PADDR = '||LV_PADDR||' and ';
		LV_sSql := LV_sSql || 'USER# = '||LV_USER||' and ';
		LV_sSql := LV_sSql || 'upper(PROGRAM) = upper('||LV_PROGRAM||') and ';
		LV_sSql := LV_sSql || 'UPPER(OSUSER) = upper('||LV_OSUSER||') ';


		SELECT count(*) into SO_Seguridad.resultado
		  FROM v$session
		 WHERE sid = LV_ID
		   AND serial#         = LV_serial
		   AND upper(USERNAME) = upper(LV_USERNAME)
		   AND PADDR           = LV_PADDR
		   AND USER#           = LV_USER
		   AND upper(PROGRAM)  = upper(LV_PROGRAM)
		   AND UPPER(OSUSER)   = upper(LV_OSUSER);

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
       	  SN_cod_retorno := 913;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := 'Error no clasificado';
	      END IF;
		  LV_des_error   := ' PV_Id_VerificaSeg_PR ('||LV_serial||','||upper(LV_USERNAME)||','||LV_PADDR||','||LV_USER ||','||upper(LV_PROGRAM)||','||upper(LV_OSUSER)||'); - ' || SQLERRM;
		  SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 1, SV_mens_retorno, 1, USER, 'ge_seguridad_web_pg.PV_Id_VerificaSeg_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	  WHEN OTHERS THEN
	      SN_cod_retorno := 149;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := 'Error no clasificado';
	      END IF;
		  LV_des_error   := ' PV_Id_VerificaSeg_PR ('||LV_serial||','||upper(LV_USERNAME)||','||LV_PADDR||','||LV_USER ||','||upper(LV_PROGRAM)||','||upper(LV_OSUSER)||'); - ' || SQLERRM;
		  SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 1, SV_mens_retorno, 1, USER, 'ge_seguridad_web_pg.PV_Id_VerificaSeg_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


end PV_Id_VerificaSeg_PR;


END ge_seguridad_web_pg;
/
SHOW ERRORS