CREATE OR REPLACE PACKAGE BODY VE_BLOQUE_VENDEDOR_PG
IS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE ve_rec_estado_vendedor_pr (
	    en_cod_vendedor          IN               ve_vendedores.cod_vendedor%TYPE,
		sb_ve_indbloqueo         OUT NOCOPY       BOOLEAN,
        sn_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento            OUT NOCOPY		  ge_errores_pg.evento)
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
    n_ve_indbloqueo    ve_vendedores.ve_indbloqueo%TYPE;
    BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;

		LV_sSql := 'SELECT ve_indbloqueo FROM ve_vendedores WHERE cod_vendedor = '||en_cod_vendedor;

        SELECT ve_indbloqueo
          INTO n_ve_indbloqueo
          FROM ve_vendedores
         WHERE cod_vendedor = en_cod_vendedor;

        IF n_ve_indbloqueo = 0 THEN
		    sb_ve_indbloqueo := FALSE;
		ELSE
		    sb_ve_indbloqueo := TRUE;
		END IF;

    EXCEPTION

	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 999;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'ge_recupera_texto_carta_fn('||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ge_carta_pg.ge_recupera_texto_carta_fn', LV_sSQL, SN_cod_retorno, LV_des_error );

	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'ge_recupera_texto_carta_fn('||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ge_carta_pg.ge_recupera_texto_carta_fn', LV_sSQL, SN_cod_retorno, LV_des_error );

    END ve_rec_estado_vendedor_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	PROCEDURE ve_bloqueo_vendedor_pr (
      en_cod_vendedor          IN               ve_vendedores.cod_vendedor%TYPE,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento)

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>10530
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
	            <param nom="SV_TEXTO_CARTA" Tipo="CARACTER">Texto de la carta</param>>
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

        LV_sSql := 'UPDATE ve_vendedores'
                || ' SET ve_indbloqueo = '||ind_bloqueo
                || ' WHERE cod_vendedor = '||en_cod_vendedor;

        UPDATE ve_vendedores
           SET ve_indbloqueo = ind_bloqueo
         WHERE cod_vendedor = en_cod_vendedor;


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
	END ve_bloqueo_vendedor_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	PROCEDURE ve_desbloqueo_vendedor_pr (
      en_cod_vendedor          IN               ve_vendedores.cod_vendedor%TYPE,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento
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


	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;

        LV_sSql := 'UPDATE ve_vendedores'
                || ' SET ve_indbloqueo = '||ind_desbloqueo
                || ' WHERE cod_vendedor = '||en_cod_vendedor;

        UPDATE ve_vendedores
           SET ve_indbloqueo = ind_desbloqueo
         WHERE cod_vendedor = en_cod_vendedor;

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
	END ve_desbloqueo_vendedor_pr;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE ve_rest_usu_vendedor_pr (
	    ev_param_entrada         IN               VARCHAR2,
        sn_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento            OUT NOCOPY		  ge_errores_pg.evento)
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

	p_arreglo          ge_tabtype_vch2array             := siscel.ge_tabtype_vch2array('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	LV_des_error	   ge_errores_pg.DesEvent;
	LV_sSql			   ge_errores_pg.vQuery;
    n_ve_indbloqueo    ve_vendedores.ve_indbloqueo%TYPE;
	error_ejecucion    EXCEPTION;
	p_cod_vendedor     ge_seg_usuario.cod_vendedor%TYPE;
    p_cod_tipcomis     ge_seg_usuario.cod_tipcomis%TYPE;
    BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;

		ge_pac_arreglopr.ge_pr_retornaarreglo(ev_param_entrada, p_arreglo);

		p_cod_vendedor := p_arreglo(10);
        p_cod_tipcomis := p_arreglo(20);


        IF (p_cod_vendedor IS NULL) THEN
    	   SV_mens_retorno := 'El usuario no esta dado de alta como vendedor';
    	   RAISE error_ejecucion;
    	END IF;

    	IF (p_cod_vendedor IS NULL) THEN
    	   SV_mens_retorno := 'El usuario no esta dado de alta como comisionista';
    	   RAISE error_ejecucion;
    	END IF;

    EXCEPTION

	WHEN error_ejecucion THEN
		  LV_des_error   := 'ge_recupera_texto_carta_fn('||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ge_carta_pg.ge_recupera_texto_carta_fn', LV_sSQL, SN_cod_retorno, LV_des_error );

	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'ge_recupera_texto_carta_fn('||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ge_carta_pg.ge_recupera_texto_carta_fn', LV_sSQL, SN_cod_retorno, LV_des_error );

    END ve_rest_usu_vendedor_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END VE_BLOQUE_VENDEDOR_PG;
/
SHOW ERRORS
