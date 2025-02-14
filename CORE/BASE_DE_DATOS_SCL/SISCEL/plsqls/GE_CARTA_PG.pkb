CREATE OR REPLACE PACKAGE BODY GE_CARTA_PG
IS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION ge_recupera_texto_carta_fn (
		EV_cod_os   	         IN               ci_tipcartas.cod_os%TYPE,
		sv_text_carta            OUT NOCOPY       ci_tipcartas.texto%TYPE,
		sv_query                 OUT NOCOPY       pv_qry_cartas.query%TYPE,
        SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        SN_num_evento            OUT NOCOPY		  ge_errores_pg.evento) RETURN BOOLEAN
    IS
	/*
	<Documentación
	  TipoDoc = "Funcion">>
	   <Elemento
	      Nombre = "ge_recupera_texto_carta_fn"
	      Lenguaje="PL/SQL"
	      Fecha="13-08-2007"
	      Versión="1.0"
	      Diseñador="Marcelo Godoy"
	      Programador="Marcelo Godoy"
	      Ambiente Desarrollo="BD">
	      <Retorno>SO_planTarif</Retorno>>
	      <Descripción>Recupera el codigo de vendedor de un usuario</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="EV_cod_os" Tipo="CARACTER">codigo de orden de servicio</param>>
	         </Entrada>
	         <Salida>
				<param nom="sv_text_carta" Tipo="CARACTER">Texto de la carta</param>>
				<param nom="sv_query" Tipo="CARACTER">Query para extraer la carta</param>>
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

		LV_sSql := ' SELECT ci.texto, pv.query';
		LV_sSql := LV_sSql || ' FROM ci_tipcartas ci, pv_qry_cartas pv';
		LV_sSql := LV_sSql || '  WHERE ci.cod_os = pv.cod_os';
		LV_sSql := LV_sSql || '  AND ci.cod_os = ev_cod_os';

        SELECT ci.texto, pv.query
		  INTO sv_text_carta, sv_query
          FROM ci_tipcartas ci, pv_qry_cartas pv
         WHERE ci.cod_os = pv.cod_os
           AND ci.cod_os = ev_cod_os;

		RETURN TRUE;

    EXCEPTION

	WHEN NO_DATA_FOUND THEN
		  RETURN TRUE;

	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'ge_recupera_texto_carta_fn('||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ge_carta_pg.ge_recupera_texto_carta_fn', LV_sSQL, SN_cod_retorno, LV_des_error );
		  RETURN FALSE;

    END ge_recupera_texto_carta_fn;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	   PROCEDURE ge_val_exit_carta_pr (
      EV_cod_os   	    IN              ci_tipcartas.cod_os%TYPE,
	  can_reg           OUT             NUMBER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "ge_recupera_carta_pr"
	      Lenguaje="PL/SQL"
	      Fecha="18-07-2007"
	      Versión="1.0"
	      Diseñador="Marcelo Godoy"
	      Programador="Marcelo Godoy"
	      Ambiente Desarrollo="BD">
	      <Retorno>SO_planTarif</Retorno>>
	      <Descripción>Retorna información del cargo básico</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SO_carta_10020" Tipo="estructura">estructura de la carta 10539</param>>
	         </Entrada>
	         <Salida>
				<param nom="sv_text_carta" Tipo="CARACTER">Texto de la carta</param>>
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
	error_ejecucion    EXCEPTION;
    v_query            pv_qry_cartas.query%TYPE;


	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;

		LV_sSql := ' SELECT count(1)';
		LV_sSql := LV_sSql || ' FROM ci_tipcartas ci, pv_qry_cartas pv';
		LV_sSql := LV_sSql || '  WHERE ci.cod_os = pv.cod_os';
		LV_sSql := LV_sSql || '  AND ci.cod_os = ev_cod_os';

        SELECT count(1)
		  INTO can_reg
          FROM ci_tipcartas ci, pv_qry_cartas pv
         WHERE ci.cod_os = pv.cod_os
           AND ci.cod_os = ev_cod_os;


	EXCEPTION
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'ge_val_exit_carta_pr(); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ge_carta_pg.ge_val_exit_carta_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	END ge_val_exit_carta_pr;



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ge_recupera_carta_pr (
      so_carta_10060    IN              ge_carta_10060_qt,
	  SV_TEXTO_CARTA	OUT NOCOPY      ci_tipcartas.texto%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "ge_recupera_carta_pr"
	      Lenguaje="PL/SQL"
	      Fecha="18-07-2007"
	      Versión="1.0"
	      Diseñador="Marcelo Godoy"
	      Programador="Marcelo Godoy"
	      Ambiente Desarrollo="BD">
	      <Retorno>SO_planTarif</Retorno>>
	      <Descripción>Retorna información del cargo básico</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SO_carta_10020" Tipo="estructura">estructura de la carta 10539</param>>
	         </Entrada>
	         <Salida>
				<param nom="sv_text_carta" Tipo="CARACTER">Texto de la carta</param>>
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
	error_ejecucion    EXCEPTION;
    v_query            pv_qry_cartas.query%TYPE;


	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;

		LV_sSql := LV_sSql || ' ge_recupera_texto_carta_fn ('||so_carta_10060.cod_os||','||SV_TEXTO_CARTA||','||v_query||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';

	IF NOT(ge_recupera_texto_carta_fn (so_carta_10060.cod_os,sv_texto_carta	,v_query,SN_cod_retorno,SV_mens_retorno,SN_num_evento))THEN
	   RAISE error_ejecucion;
	END IF;

	sv_texto_carta	 := REPLACE(sv_texto_carta, '<NUM_CELULAR>' ,so_carta_10060.num_celular);


	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 210;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'ge_recupera_carta_pr(); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ge_carta_pg.ge_recupera_carta_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'ge_recupera_carta_pr(); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ge_carta_pg.ge_recupera_carta_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	END ge_recupera_carta_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


   PROCEDURE ge_recupera_carta_pr (
      so_carta_10231    IN              ge_carta_10231_qt,
	  SV_TEXTO_CARTA	OUT NOCOPY      ci_tipcartas.texto%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "ge_recupera_carta_pr"
	      Lenguaje="PL/SQL"
	      Fecha="18-07-2007"
	      Versión="1.0"
	      Diseñador="Marcelo Godoy"
	      Programador="Marcelo Godoy"
	      Ambiente Desarrollo="BD">
	      <Retorno>SO_planTarif</Retorno>>
	      <Descripción>Retorna información del cargo básico</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SO_carta_10020" Tipo="estructura">estructura de la carta 10539</param>>
	         </Entrada>
	         <Salida>
				<param nom="sv_text_carta" Tipo="CARACTER">Texto de la carta</param>>
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
	error_ejecucion    EXCEPTION;
    v_query            pv_qry_cartas.query%TYPE;


	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;

		LV_sSql := LV_sSql || ' ge_recupera_texto_carta_fn ('||so_carta_10231.cod_os||','||SV_TEXTO_CARTA||','||v_query||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';

	    IF NOT(ge_recupera_texto_carta_fn (so_carta_10231.cod_os,sv_texto_carta	,v_query,SN_cod_retorno,SV_mens_retorno,SN_num_evento))THEN
	        RAISE error_ejecucion;
    	END IF;


	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 210;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'ge_recupera_carta_pr(); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ge_carta_pg.ge_recupera_carta_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'ge_recupera_carta_pr(); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ge_carta_pg.ge_recupera_carta_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	END ge_recupera_carta_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ge_recupera_carta_pr (
      so_carta_10020    IN     ge_carta_10020_qt,
	  SV_TEXTO_CARTA	OUT NOCOPY ci_tipcartas.texto%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "ge_recupera_carta_pr"
	      Lenguaje="PL/SQL"
	      Fecha="18-07-2007"
	      Versión="1.0"
	      Diseñador="Marcelo Godoy"
	      Programador="Marcelo Godoy"
	      Ambiente Desarrollo="BD">
	      <Retorno>SO_planTarif</Retorno>>
	      <Descripción>Retorna información del cargo básico</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SO_carta_10020" Tipo="estructura">estructura de la carta 10539</param>>
	         </Entrada>
	         <Salida>
				<param nom="sv_text_carta" Tipo="CARACTER">Texto de la carta</param>>
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
	error_ejecucion    EXCEPTION;
    v_query            pv_qry_cartas.query%TYPE;
	lv_des_plantarf	   ta_plantarif.des_plantarif%type;
	ln_num_unidades	   ta_plantarif.num_unidades%type;


	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;

		LV_sSql := ' ge_recupera_texto_carta_fn ('||so_carta_10020.cod_os||','||SV_TEXTO_CARTA||','||v_query||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';

	IF NOT(ge_recupera_texto_carta_fn (so_carta_10020.cod_os,sv_texto_carta	,v_query,SN_cod_retorno,SV_mens_retorno,SN_num_evento))THEN
	   RAISE error_ejecucion;
	END IF;

	LV_sSql := 'SELECT des_plan_tarif, num_unidades';
	LV_sSql := LV_sSql || ' FROM   ta_plantarif' ;
	LV_sSql := LV_sSql || ' WHERE  cod_plan_tarif = '||so_carta_10020.cod_plan_tarif;

	SELECT des_plantarif, num_unidades
	INTO   lv_des_plantarf, ln_num_unidades
	FROM   ta_plantarif
	WHERE  cod_plantarif = so_carta_10020.cod_plan_tarif;

	sv_texto_carta	 := REPLACE(sv_texto_carta, '<1>' ,' '||so_carta_10020.cod_plan_tarif);
	sv_texto_carta	 := REPLACE(sv_texto_carta, '<2>' ,lv_des_plantarf);
	sv_texto_carta	 := REPLACE(sv_texto_carta, '<3>' ,TO_CHAR(ln_num_unidades));
	sv_texto_carta	 := REPLACE(sv_texto_carta, '[fecha_ciclo]' ,so_carta_10020.fec_ciclo);


	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 210;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'ge_recupera_carta_pr(); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ge_carta_pg.ge_recupera_carta_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'ge_recupera_carta_pr(); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ge_carta_pg.ge_recupera_carta_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	END ge_recupera_carta_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ge_recupera_carta_pr (
      so_carta_10022    IN     ge_carta_10022_qt,
	  SV_TEXTO_CARTA	OUT NOCOPY ci_tipcartas.texto%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "ge_recupera_carta_pr"
	      Lenguaje="PL/SQL"
	      Fecha="18-07-2007"
	      Versión="1.0"
	      Diseñador="Marcelo Godoy"
	      Programador="Marcelo Godoy"
	      Ambiente Desarrollo="BD">
	      <Retorno>SO_planTarif</Retorno>>
	      <Descripción>Retorna información del cargo básico</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SO_carta_10022" Tipo="estructura">estructura de la carta 10539</param>>
	         </Entrada>
	         <Salida>
				<param nom="sv_text_carta" Tipo="CARACTER">Texto de la carta</param>>
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
	error_ejecucion    EXCEPTION;
    v_query            pv_qry_cartas.query%TYPE;
	lv_des_plantarf	   ta_plantarif.des_plantarif%type;
	ln_num_unidades	   ta_plantarif.num_unidades%type;


	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;

		LV_sSql := ' ge_recupera_texto_carta_fn ('||so_carta_10022.cod_os||','||SV_TEXTO_CARTA||','||v_query||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';

	IF NOT(ge_recupera_texto_carta_fn (so_carta_10022.cod_os,sv_texto_carta	,v_query,SN_cod_retorno,SV_mens_retorno,SN_num_evento))THEN
	   RAISE error_ejecucion;
	END IF;

	LV_sSql := 'SELECT des_plan_tarif, num_unidades';
	LV_sSql := LV_sSql || ' FROM   ta_plantarif' ;
	LV_sSql := LV_sSql || ' WHERE  cod_plan_tarif = '||so_carta_10022.cod_plan_tarif;

	SELECT des_plantarif, num_unidades
	INTO   lv_des_plantarf, ln_num_unidades
	FROM   ta_plantarif
	WHERE  cod_plantarif = so_carta_10022.cod_plan_tarif;

	sv_texto_carta	 := REPLACE(sv_texto_carta, '<1>' ,' '||so_carta_10022.cod_plan_tarif);
	sv_texto_carta	 := REPLACE(sv_texto_carta, '<2>' ,lv_des_plantarf);
	sv_texto_carta	 := REPLACE(sv_texto_carta, '<3>' ,TO_CHAR(ln_num_unidades));
	sv_texto_carta	 := REPLACE(sv_texto_carta, '[fecha_ciclo]' ,so_carta_10022.fec_ciclo);


	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 210;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'ge_recupera_carta_pr(); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ge_carta_pg.ge_recupera_carta_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'ge_recupera_carta_pr(); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ge_carta_pg.ge_recupera_carta_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	END ge_recupera_carta_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ge_recupera_carta_pr (
      so_carta_10034    IN     ge_carta_10034_qt,
	  SV_TEXTO_CARTA	OUT NOCOPY ci_tipcartas.texto%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "ge_recupera_carta_pr"
	      Lenguaje="PL/SQL"
	      Fecha="18-07-2007"
	      Versión="1.0"
	      Diseñador="Marcelo Godoy"
	      Programador="Marcelo Godoy"
	      Ambiente Desarrollo="BD">
	      <Retorno>SO_planTarif</Retorno>>
	      <Descripción>Retorna información del cargo básico</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SO_carta_10034" Tipo="estructura">estructura de la carta 10539</param>>
	         </Entrada>
	         <Salida>
				<param nom="sv_text_carta" Tipo="CARACTER">Texto de la carta</param>>
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
	error_ejecucion    EXCEPTION;
    v_query            pv_qry_cartas.query%TYPE;
	lv_des_plantarf	   ta_plantarif.des_plantarif%type;
	ln_num_unidades	   ta_plantarif.num_unidades%type;


	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;

		LV_sSql := ' ge_recupera_texto_carta_fn ('||so_carta_10034.cod_os||','||SV_TEXTO_CARTA||','||v_query||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';

	IF NOT(ge_recupera_texto_carta_fn (so_carta_10034.cod_os,sv_texto_carta	,v_query,SN_cod_retorno,SV_mens_retorno,SN_num_evento))THEN
	   RAISE error_ejecucion;
	END IF;

	LV_sSql := 'SELECT des_plan_tarif, num_unidades';
	LV_sSql := LV_sSql || ' FROM   ta_plantarif' ;
	LV_sSql := LV_sSql || ' WHERE  cod_plan_tarif = '||so_carta_10034.cod_plan_tarif;

	SELECT des_plantarif, num_unidades
	INTO   lv_des_plantarf, ln_num_unidades
	FROM   ta_plantarif
	WHERE  cod_plantarif = so_carta_10034.cod_plan_tarif;

	sv_texto_carta	 := REPLACE(sv_texto_carta, '<1>' ,' '||so_carta_10034.cod_plan_tarif);
	sv_texto_carta	 := REPLACE(sv_texto_carta, '<2>' ,lv_des_plantarf);
	sv_texto_carta	 := REPLACE(sv_texto_carta, '<3>' ,TO_CHAR(ln_num_unidades));
	sv_texto_carta	 := REPLACE(sv_texto_carta, '[fecha_ciclo]' ,so_carta_10034.fec_ciclo);


	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 210;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'ge_recupera_carta_pr(); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ge_carta_pg.ge_recupera_carta_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'ge_recupera_carta_pr(); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ge_carta_pg.ge_recupera_carta_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	END ge_recupera_carta_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ge_recupera_carta_pr (
      so_carta_10233    IN     ge_carta_10233_qt,
	  SV_TEXTO_CARTA	OUT NOCOPY ci_tipcartas.texto%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "ge_recupera_carta_pr"
	      Lenguaje="PL/SQL"
	      Fecha="18-07-2007"
	      Versión="1.0"
	      Diseñador="Marcelo Godoy"
	      Programador="Marcelo Godoy"
	      Ambiente Desarrollo="BD">
	      <Retorno>SO_planTarif</Retorno>>
	      <Descripción>Retorna información del cargo básico</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SO_carta_10233" Tipo="estructura">estructura de la carta 10539</param>>
	         </Entrada>
	         <Salida>
				<param nom="sv_text_carta" Tipo="CARACTER">Texto de la carta</param>>
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
	error_ejecucion    EXCEPTION;
    v_query            pv_qry_cartas.query%TYPE;
	lv_des_plantarf	   ta_plantarif.des_plantarif%type;
	ln_num_unidades	   ta_plantarif.num_unidades%type;


	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;

		LV_sSql := ' ge_recupera_texto_carta_fn ('||so_carta_10233.cod_os||','||SV_TEXTO_CARTA||','||v_query||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';

	IF NOT(ge_recupera_texto_carta_fn (so_carta_10233.cod_os,sv_texto_carta	,v_query,SN_cod_retorno,SV_mens_retorno,SN_num_evento))THEN
	   RAISE error_ejecucion;
	END IF;

	LV_sSql := 'SELECT des_plan_tarif, num_unidades';
	LV_sSql := LV_sSql || ' FROM   ta_plantarif' ;
	LV_sSql := LV_sSql || ' WHERE  cod_plan_tarif = '||so_carta_10233.cod_plan_tarif;

	SELECT des_plantarif, num_unidades
	INTO   lv_des_plantarf, ln_num_unidades
	FROM   ta_plantarif
	WHERE  cod_plantarif = so_carta_10233.cod_plan_tarif;

	sv_texto_carta	 := REPLACE(sv_texto_carta, '<plan>' ,' '||so_carta_10233.cod_plan_tarif);
	sv_texto_carta	 := REPLACE(sv_texto_carta, '<descripcion>' ,lv_des_plantarf);
--	sv_texto_carta	 := REPLACE(sv_texto_carta, '<3>' ,TO_CHAR(ln_num_unidades));
--	sv_texto_carta	 := REPLACE(sv_texto_carta, '[fecha_ciclo]' ,so_carta_10233.fec_ciclo);


	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 210;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'ge_recupera_carta_pr(); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ge_carta_pg.ge_recupera_carta_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'ge_recupera_carta_pr(); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ge_carta_pg.ge_recupera_carta_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	END ge_recupera_carta_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ge_recupera_carta_pr (
      so_carta_10508    IN     ge_carta_10508_qt,
	  SV_TEXTO_CARTA	OUT NOCOPY ci_tipcartas.texto%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "ge_recupera_carta_pr"
	      Lenguaje="PL/SQL"
	      Fecha="18-07-2007"
	      Versión="1.0"
	      Diseñador="Marcelo Godoy"
	      Programador="Marcelo Godoy"
	      Ambiente Desarrollo="BD">
	      <Retorno>SO_planTarif</Retorno>>
	      <Descripción>Retorna información del cargo básico</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SO_carta_10508" Tipo="estructura">estructura de la carta 10539</param>>
	         </Entrada>
	         <Salida>
				<param nom="sv_text_carta" Tipo="CARACTER">Texto de la carta</param>>
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
	error_ejecucion    EXCEPTION;
    v_query            pv_qry_cartas.query%TYPE;
	lv_des_plantarf	   ta_plantarif.des_plantarif%type;
	ln_num_unidades	   ta_plantarif.num_unidades%type;


	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;

		LV_sSql := ' ge_recupera_texto_carta_fn ('||so_carta_10508.cod_os||','||SV_TEXTO_CARTA||','||v_query||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';

	IF NOT(ge_recupera_texto_carta_fn (so_carta_10508.cod_os,sv_texto_carta	,v_query,SN_cod_retorno,SV_mens_retorno,SN_num_evento))THEN
	   RAISE error_ejecucion;
	END IF;

	LV_sSql := 'SELECT des_plan_tarif, num_unidades';
	LV_sSql := LV_sSql || ' FROM   ta_plantarif' ;
	LV_sSql := LV_sSql || ' WHERE  cod_plan_tarif = '||so_carta_10508.cod_plan_tarif;

	SELECT des_plantarif, num_unidades
	INTO   lv_des_plantarf, ln_num_unidades
	FROM   ta_plantarif
	WHERE  cod_plantarif = so_carta_10508.cod_plan_tarif;

	sv_texto_carta	 := REPLACE(sv_texto_carta, '<1>' ,' '||so_carta_10508.cod_plan_tarif);
	sv_texto_carta	 := REPLACE(sv_texto_carta, '<2>' ,lv_des_plantarf);
	sv_texto_carta	 := REPLACE(sv_texto_carta, '<3>' ,TO_CHAR(ln_num_unidades));
	sv_texto_carta	 := REPLACE(sv_texto_carta, '[fecha_ciclo]' ,so_carta_10508.fec_ciclo);


	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 210;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'ge_recupera_carta_pr(); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ge_carta_pg.ge_recupera_carta_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'ge_recupera_carta_pr(); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ge_carta_pg.ge_recupera_carta_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	END ge_recupera_carta_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ge_recupera_carta_pr (
      so_carta_10530    IN     ge_carta_10530_qt,
	  SV_TEXTO_CARTA	OUT NOCOPY ci_tipcartas.texto%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "ge_recupera_carta_pr"
	      Lenguaje="PL/SQL"
	      Fecha="18-07-2007"
	      Versión="1.0"
	      Diseñador="Marcelo Godoy"
	      Programador="Marcelo Godoy"
	      Ambiente Desarrollo="BD">
	      <Retorno>SO_planTarif</Retorno>>
	      <Descripción>Retorna información del cargo básico</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SO_carta_10530" Tipo="estructura">estructura de la carta 10539</param>>
	         </Entrada>
	         <Salida>
				<param nom="sv_text_carta" Tipo="CARACTER">Texto de la carta</param>>
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
	error_ejecucion    EXCEPTION;
    v_query            pv_qry_cartas.query%TYPE;
	lv_des_plantarf	   ta_plantarif.des_plantarif%type;
	ln_num_unidades	   ta_plantarif.num_unidades%type;
	ln_cargobasico	   ta_cargosbasico.imp_cargobasico%type;
	lv_des_plantarf_ori ta_plantarif.des_plantarif%type;
	ln_num_unidades_ori ta_plantarif.num_unidades%type;
	ln_cargobasico_ori ta_cargosbasico.imp_cargobasico%type;


	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;

		LV_sSql := ' ge_recupera_texto_carta_fn ('||so_carta_10530.cod_os||','||SV_TEXTO_CARTA||','||v_query||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';

	IF NOT(ge_recupera_texto_carta_fn (so_carta_10530.cod_os,sv_texto_carta	,v_query,SN_cod_retorno,SV_mens_retorno,SN_num_evento))THEN
	   RAISE error_ejecucion;
	END IF;

	LV_sSql := 'SELECT a.des_plantarif, a.num_unidades, b.imp_cargobasico';
	LV_sSql := LV_sSql || ' FROM   ta_plantarif a, ta_cargosbasico b' ;
	LV_sSql := LV_sSql || ' WHERE  cod_plan_tarif = '||so_carta_10530.cod_plan_tarif;
	LV_sSql := LV_sSql || ' AND	   a.cod_cargobasico = b.cod_cargobasico';
	LV_sSql := LV_sSql || ' AND	   SYSDATE BETWEEN b.fec_desde and b.fec_hasta';

	SELECT a.des_plantarif, a.num_unidades, b.imp_cargobasico
	INTO   lv_des_plantarf, ln_num_unidades, ln_cargobasico
	FROM   ta_plantarif a, ta_cargosbasico b
	WHERE  cod_plantarif = so_carta_10530.cod_plan_tarif
	AND	   a.cod_cargobasico = b.cod_cargobasico
	AND	   SYSDATE BETWEEN b.fec_desde and b.fec_hasta;

	LV_sSql := 'SELECT a.des_plantarif, a.num_unidades, b.imp_cargobasico';
	LV_sSql := LV_sSql || ' FROM   ta_plantarif a, ta_cargosbasico b' ;
	LV_sSql := LV_sSql || ' WHERE  cod_plan_tarif = '||so_carta_10530.cod_plan_origen;
	LV_sSql := LV_sSql || ' AND	   a.cod_cargobasico = b.cod_cargobasico';
	LV_sSql := LV_sSql || ' AND	   SYSDATE BETWEEN b.fec_desde and b.fec_hasta';

	SELECT a.des_plantarif, a.num_unidades, b.imp_cargobasico
	INTO   lv_des_plantarf_ori, ln_num_unidades_ori, ln_cargobasico_ori
	FROM   ta_plantarif a, ta_cargosbasico b
	WHERE  cod_plantarif = so_carta_10530.cod_plan_origen
	AND	   a.cod_cargobasico = b.cod_cargobasico
	AND	   SYSDATE BETWEEN b.fec_desde and b.fec_hasta;

	sv_texto_carta	 := REPLACE(sv_texto_carta, '<1>' ,' '||so_carta_10530.cod_plan_tarif);
	sv_texto_carta	 := REPLACE(sv_texto_carta, '<2>' ,lv_des_plantarf);
	sv_texto_carta	 := REPLACE(sv_texto_carta, '<3>' ,so_carta_10530.num_celular);
	sv_texto_carta	 := REPLACE(sv_texto_carta, '<4>' ,ln_cargobasico);
	sv_texto_carta	 := REPLACE(sv_texto_carta, 'cargo fijo 1' ,ln_cargobasico_ori);
	sv_texto_carta	 := REPLACE(sv_texto_carta, '- cargo fijo 2' ,'+ '||ln_cargobasico);


	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 210;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'ge_recupera_carta_pr(); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ge_carta_pg.ge_recupera_carta_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'ge_recupera_carta_pr(); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ge_carta_pg.ge_recupera_carta_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	END ge_recupera_carta_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ge_recupera_carta_pr (
      so_carta_10539    IN     ge_carta_10539_qt,
	  SV_TEXTO_CARTA	OUT NOCOPY ci_tipcartas.texto%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "ge_recupera_carta_pr"
	      Lenguaje="PL/SQL"
	      Fecha="18-07-2007"
	      Versión="1.0"
	      Diseñador="Marcelo Godoy"
	      Programador="Marcelo Godoy"
	      Ambiente Desarrollo="BD">
	      <Retorno>SO_planTarif</Retorno>>
	      <Descripción>Retorna información del cargo básico</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SO_carta_10539" Tipo="estructura">estructura de la carta 10539</param>>
	         </Entrada>
	         <Salida>
				<param nom="sv_text_carta" Tipo="CARACTER">Texto de la carta</param>>
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
	error_ejecucion    EXCEPTION;
    v_query            pv_qry_cartas.query%TYPE;
	lv_des_plantarf	   ta_plantarif.des_plantarif%type;
	ln_num_unidades	   ta_plantarif.num_unidades%type;
	ln_cargobasico	   ta_cargosbasico.imp_cargobasico%type;
	lv_des_plantarf_ori ta_plantarif.des_plantarif%type;
	ln_num_unidades_ori ta_plantarif.num_unidades%type;
	ln_cargobasico_ori ta_cargosbasico.imp_cargobasico%type;


	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;

		LV_sSql := ' ge_recupera_texto_carta_fn ('||so_carta_10539.cod_os||','||SV_TEXTO_CARTA||','||v_query||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';

	IF NOT(ge_recupera_texto_carta_fn (so_carta_10539.cod_os,sv_texto_carta	,v_query,SN_cod_retorno,SV_mens_retorno,SN_num_evento))THEN
	   RAISE error_ejecucion;
	END IF;

	LV_sSql := 'SELECT a.des_plantarif, a.num_unidades, b.imp_cargobasico';
	LV_sSql := LV_sSql || ' FROM   ta_plantarif a, ta_cargosbasico b' ;
	LV_sSql := LV_sSql || ' WHERE  cod_plan_tarif = '||so_carta_10539.cod_plan_tarif;
	LV_sSql := LV_sSql || ' AND	   a.cod_cargobasico = b.cod_cargobasico';
	LV_sSql := LV_sSql || ' AND	   SYSDATE BETWEEN b.fec_desde and b.fec_hasta';


	SELECT a.des_plantarif, a.num_unidades, b.imp_cargobasico
	INTO   lv_des_plantarf, ln_num_unidades, ln_cargobasico
	FROM   ta_plantarif a, ta_cargosbasico b
	WHERE  cod_plantarif = so_carta_10539.cod_plan_tarif
	AND	   a.cod_cargobasico = b.cod_cargobasico
	AND	   SYSDATE BETWEEN b.fec_desde and b.fec_hasta;

	LV_sSql := 'SELECT a.des_plantarif, a.num_unidades, b.imp_cargobasico';
	LV_sSql := LV_sSql || ' FROM   ta_plantarif a, ta_cargosbasico b' ;
	LV_sSql := LV_sSql || ' WHERE  cod_plan_tarif = '||so_carta_10539.cod_plan_origen;
	LV_sSql := LV_sSql || ' AND	   a.cod_cargobasico = b.cod_cargobasico';
	LV_sSql := LV_sSql || ' AND	   SYSDATE BETWEEN b.fec_desde and b.fec_hasta';

	SELECT a.des_plantarif, a.num_unidades, b.imp_cargobasico
	INTO   lv_des_plantarf_ori, ln_num_unidades_ori, ln_cargobasico_ori
	FROM   ta_plantarif a, ta_cargosbasico b
	WHERE  cod_plantarif = so_carta_10539.cod_plan_origen
	AND	   a.cod_cargobasico = b.cod_cargobasico
	AND	   SYSDATE BETWEEN b.fec_desde and b.fec_hasta;

	sv_texto_carta	 := REPLACE(sv_texto_carta, '<1>' ,' '||so_carta_10539.cod_plan_tarif);
	sv_texto_carta	 := REPLACE(sv_texto_carta, '<2>' ,lv_des_plantarf);
	sv_texto_carta	 := REPLACE(sv_texto_carta, '<3>' ,so_carta_10539.num_celular);
	sv_texto_carta	 := REPLACE(sv_texto_carta, '<4>' ,ln_cargobasico);
	sv_texto_carta	 := REPLACE(sv_texto_carta, 'cargo fijo 1' ,ln_cargobasico_ori);
	sv_texto_carta	 := REPLACE(sv_texto_carta, '- cargo fijo 2' ,'+ '||ln_cargobasico);


	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 210;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'ge_recupera_carta_pr(); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ge_carta_pg.ge_recupera_carta_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'ge_recupera_carta_pr(); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ge_carta_pg.ge_recupera_carta_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	END ge_recupera_carta_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ge_recupera_carta_pr (
      so_carta_10541    IN     ge_carta_10541_qt,
	  SV_TEXTO_CARTA	OUT NOCOPY ci_tipcartas.texto%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "ge_recupera_carta_pr"
	      Lenguaje="PL/SQL"
	      Fecha="18-07-2007"
	      Versión="1.0"
	      Diseñador="Marcelo Godoy"
	      Programador="Marcelo Godoy"
	      Ambiente Desarrollo="BD">
	      <Retorno>SO_planTarif</Retorno>>
	      <Descripción>Retorna información del cargo básico</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SO_carta_10541" Tipo="estructura">estructura de la carta 10541</param>>
	         </Entrada>
	         <Salida>
				<param nom="sv_text_carta" Tipo="CARACTER">Texto de la carta</param>>
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
	error_ejecucion    EXCEPTION;
    v_query            pv_qry_cartas.query%TYPE;
	lv_des_plantarf	   ta_plantarif.des_plantarif%type;
	ln_num_unidades	   ta_plantarif.num_unidades%type;


	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;

		LV_sSql := ' ge_recupera_texto_carta_fn ('||so_carta_10541.cod_os||','||SV_TEXTO_CARTA||','||v_query||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';

	IF NOT(ge_recupera_texto_carta_fn (so_carta_10541.cod_os,sv_texto_carta	,v_query,SN_cod_retorno,SV_mens_retorno,SN_num_evento))THEN
	   RAISE error_ejecucion;
	END IF;

	LV_sSql := 'SELECT des_plan_tarif, num_unidades';
	LV_sSql := LV_sSql || ' FROM   ta_plantarif' ;
	LV_sSql := LV_sSql || ' WHERE  cod_plan_tarif = '||so_carta_10541.cod_plan_tarif;

	SELECT des_plantarif, num_unidades
	INTO   lv_des_plantarf, ln_num_unidades
	FROM   ta_plantarif
	WHERE  cod_plantarif = so_carta_10541.cod_plan_tarif;

	sv_texto_carta	 := REPLACE(sv_texto_carta, '<1>' ,' '||so_carta_10541.cod_plan_tarif);
	sv_texto_carta	 := REPLACE(sv_texto_carta, '<2>' ,lv_des_plantarf);
	sv_texto_carta	 := REPLACE(sv_texto_carta, '<3>' ,TO_CHAR(ln_num_unidades));
	sv_texto_carta	 := REPLACE(sv_texto_carta, '[fecha_ciclo]' ,so_carta_10541.fec_ciclo);


	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 210;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'ge_recupera_carta_pr(); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ge_carta_pg.ge_recupera_carta_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'ge_recupera_carta_pr(); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ge_carta_pg.ge_recupera_carta_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	END ge_recupera_carta_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ge_recupera_carta_pr (
      so_carta_10120    IN              ge_carta_10120_qt,
	  SV_TEXTO_CARTA	OUT NOCOPY      ci_tipcartas.texto%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "ge_recupera_carta_pr"
	      Lenguaje="PL/SQL"
	      Fecha="18-07-2007"
	      Versión="1.0"
	      Diseñador="Marcelo Godoy"
	      Programador="Marcelo Godoy"
	      Ambiente Desarrollo="BD">
	      <Retorno>SO_planTarif</Retorno>>
	      <Descripción>Retorna información del cargo básico</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SO_carta_10020" Tipo="estructura">estructura de la carta 10539</param>>
	         </Entrada>
	         <Salida>
				<param nom="sv_text_carta" Tipo="CARACTER">Texto de la carta</param>>
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
	error_ejecucion    EXCEPTION;
    v_query            pv_qry_cartas.query%TYPE;


	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;

		LV_sSql := LV_sSql || ' ge_recupera_texto_carta_fn ('||so_carta_10120.cod_os||','||SV_TEXTO_CARTA||','||v_query||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';

	    IF NOT(ge_recupera_texto_carta_fn (so_carta_10120.cod_os,sv_texto_carta	,v_query,SN_cod_retorno,SV_mens_retorno,SN_num_evento))THEN
	        RAISE error_ejecucion;
    	END IF;


	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 210;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'ge_recupera_carta_pr(); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ge_carta_pg.ge_recupera_carta_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'ge_recupera_carta_pr(); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ge_carta_pg.ge_recupera_carta_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	END ge_recupera_carta_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ge_recupera_carta_pr (
      EO_carta_40009    IN              ge_carta_40009_qt,
	  SV_TEXTO_CARTA	OUT NOCOPY      ci_tipcartas.texto%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "ge_recupera_carta_pr"
	      Lenguaje="PL/SQL"
	      Fecha="18-07-2007"
	      Versión="1.0"
	      Diseñador="Marcelo Godoy"
	      Programador="Marcelo Godoy"
	      Ambiente Desarrollo="BD">
	      <Retorno>SO_planTarif</Retorno>>
	      <Descripción>Retorna información del cargo básico</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="EO_carta_40009" Tipo="estructura">estructura de la carta 10539</param>>
	         </Entrada>
	         <Salida>
				<param nom="sv_text_carta" Tipo="CARACTER">Texto de la carta</param>>
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
	error_ejecucion    EXCEPTION;
    v_query            pv_qry_cartas.query%TYPE;


	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;

		LV_sSql := LV_sSql || ' ge_recupera_texto_carta_fn ('||EO_carta_40009.cod_os||','||SV_TEXTO_CARTA||','||v_query||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';

	    IF NOT(ge_recupera_texto_carta_fn (EO_carta_40009.cod_os,sv_texto_carta	,v_query,SN_cod_retorno,SV_mens_retorno,SN_num_evento))THEN
	        RAISE error_ejecucion;
    	END IF;

/*		LV_sSql := 'SELECT des_plan_tarif, num_unidades';
		LV_sSql := LV_sSql || ' FROM   ta_plantarif' ;
		LV_sSql := LV_sSql || ' WHERE  cod_plan_tarif = '||so_carta_10541.cod_plan_tarif;

		SELECT des_plantarif, num_unidades
		INTO   lv_des_plantarf, ln_num_unidades
		FROM   ta_plantarif
		WHERE  cod_plantarif = so_carta_10541.cod_plan_tarif;*/

		sv_texto_carta	 := REPLACE(sv_texto_carta, '<numOS>' ,EO_carta_40009.num_os_ant);
/*		sv_texto_carta	 := REPLACE(sv_texto_carta, '<2>' ,lv_des_plantarf);
		sv_texto_carta	 := REPLACE(sv_texto_carta, '<3>' ,TO_CHAR(ln_num_unidades));
		sv_texto_carta	 := REPLACE(sv_texto_carta, '[fecha_ciclo]' ,so_carta_10541.fec_ciclo);*/



	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 210;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'ge_recupera_carta_pr(); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ge_carta_pg.ge_recupera_carta_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'ge_recupera_carta_pr(); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ge_carta_pg.ge_recupera_carta_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	END ge_recupera_carta_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END GE_CARTA_PG;
/
SHOW ERRORS
