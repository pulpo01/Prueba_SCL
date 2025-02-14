CREATE OR REPLACE PACKAGE BODY VE_VENDEDORES_SB_PG
IS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION ve_rec_codvendedorusuario_fn (
	    SO_descuento    	     IN OUT NOCOPY    GE_PROCESOS_QT,
		SO_ve_descuento	         IN OUT NOCOPY    VE_DESCUENTO_VEN_QT,
        SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        SN_num_evento            OUT NOCOPY		  ge_errores_pg.evento) RETURN BOOLEAN
    IS
	/*
	<Documentación
	  TipoDoc = "Funcion">>
	   <Elemento
	      Nombre = "Recupera_CodVendedor_FN"
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
	            <param nom="SO_planTarif" Tipo="estructura">estructura de plan tarifario</param>>
	         </Entrada>
	         <Salida>
				<param nom="SO_planTarif" Tipo="cursor">estructura de plan tarifario</param>>
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

        LV_sSql := 'SELECT cod_vendedor, cod_oficina, cod_tipComis INTO FROM ge_seg_usuario WHERE nom_usuario = '||SO_descuento.usuario;

        SELECT cod_vendedor, cod_oficina, cod_tipComis
		  INTO SO_descuento.codigo, SO_descuento.cod_oficina, SO_descuento.cod_tipComis
          FROM ge_seg_usuario
         WHERE nom_usuario = SO_descuento.usuario;

		 RETURN TRUE;

    EXCEPTION

	WHEN NO_DATA_FOUND THEN
          so_ve_descuento.ind_creadto := 0;
		  so_ve_descuento.prc_newdto_inf := 0;
		  so_ve_descuento.prc_newdto_sup := 0;
		  RETURN TRUE;

	WHEN OTHERS THEN
	      SN_cod_retorno := 1;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'Recupera_CodVendedor_FN ('||SO_descuento.usuario||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'VE_VENDEDORES_SB_PG.Recupera_CodVendedor_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
		  RETURN FALSE;

    END ve_rec_codvendedorusuario_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    FUNCTION ve_recupera_codvenderaiz_fn (
		SO_descuento    	     IN OUT NOCOPY    GE_PROCESOS_QT,
        SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        SN_num_evento            OUT NOCOPY		  ge_errores_pg.evento) RETURN BOOLEAN
    IS
	/*
	<Documentación
	  TipoDoc = "Funcion">>
	   <Elemento
	      Nombre = "Recupera_CodVendedor_FN"
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
	            <param nom="SO_planTarif" Tipo="estructura">estructura de plan tarifario</param>>
	         </Entrada>
	         <Salida>
				<param nom="SO_planTarif" Tipo="cursor">estructura de plan tarifario</param>>
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
	N_cod_vendedor     ve_vendedores.cod_vendedor%TYPE;
    BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;

        LV_sSql := 'SELECT cod_vende_raiz FROM ve_vendedores WHERE cod_vendedor = '||SO_descuento.codigo;

        SELECT cod_vende_raiz
		  INTO N_cod_vendedor
          FROM ve_vendedores
         WHERE cod_vendedor = SO_descuento.codigo;

		 SO_descuento.codigo := N_cod_vendedor;

		 RETURN TRUE;

    EXCEPTION

	WHEN NO_DATA_FOUND THEN
		  RETURN TRUE;

	WHEN OTHERS THEN
	      SN_cod_retorno := 2;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 've_recupera_codvenderaiz_fn ('||SO_descuento.codigo||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'VE_VENDEDORES_SB_PG.ve_recupera_codvenderaiz_fn', LV_sSQL, SN_cod_retorno, LV_des_error );
		  RETURN FALSE;

    END ve_recupera_codvenderaiz_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    FUNCTION ve_rec_descuento_vendedor_fn (
		SO_descuento    	     IN               GE_PROCESOS_QT,
		SO_ve_descuento	         IN OUT NOCOPY    VE_DESCUENTO_VEN_QT,
        SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        SN_num_evento            OUT NOCOPY		  ge_errores_pg.evento) RETURN BOOLEAN
    IS
	/*
	<Documentación
	  TipoDoc = "Funcion">>
	   <Elemento
	      Nombre = "Recupera_CodVendedor_FN"
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
	            <param nom="SO_planTarif" Tipo="estructura">estructura de plan tarifario</param>>
	         </Entrada>
	         <Salida>
				<param nom="SO_planTarif" Tipo="cursor">estructura de plan tarifario</param>>
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

        LV_sSql := 'SELECT b.ind_creadto, b.prc_newdto_inf, b.prc_newdto_sup FROM ve_vendperfil a, ga_perfilcargos b '
		        || 'WHERE a.cod_vendedor = '||SO_descuento.codigo
				|| ' AND b.cod_perfil = a.cod_perfil'
				|| ' AND '||SYSDATE||' BETWEEN a.fec_asignacion AND NVL (a.fec_desasignac, '||SYSDATE||');';

        SELECT b.ind_creadto, b.prc_newdto_inf, b.prc_newdto_sup
		  INTO so_ve_descuento.ind_creadto, so_ve_descuento.prc_newdto_inf, so_ve_descuento.prc_newdto_sup
          FROM ve_vendperfil a, ga_perfilcargos b
         WHERE a.cod_vendedor = SO_descuento.codigo
           AND b.cod_perfil = a.cod_perfil
           AND SYSDATE BETWEEN a.fec_asignacion AND NVL (a.fec_desasignac, SYSDATE);

		RETURN TRUE;

    EXCEPTION

	WHEN NO_DATA_FOUND THEN
          so_ve_descuento.ind_creadto := 0;
		  so_ve_descuento.prc_newdto_inf := 0;
		  so_ve_descuento.prc_newdto_sup := 0;
  		  RETURN TRUE;

	WHEN OTHERS THEN
	      SN_cod_retorno := 3;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 've_recupera_codvenderaiz_fn ('||SO_descuento.codigo||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'VE_VENDEDORES_SB_PG.ve_rec_descuento_vendedor_fn', LV_sSQL, SN_cod_retorno, LV_des_error );
		  RETURN FALSE;

    END ve_rec_descuento_vendedor_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	PROCEDURE ve_val_descuento_vendedor_pr (
      SO_descuento  	       IN OUT NOCOPY    GE_PROCESOS_QT,
	  SO_ve_descuento	       IN OUT NOCOPY    VE_DESCUENTO_VEN_QT,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento)

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "TA_consCargoBasicoPlanTarif_PR"
	      Lenguaje="PL/SQL"
	      Fecha="18-07-2007"
	      Versión="1.0"
	      Diseñador="Raúl Lozano'
	      Programador="Raúl Lozano"
	      Ambiente Desarrollo="BD">
	      <Retorno>SO_planTarif</Retorno>>
	      <Descripción>Retorna información del cargo básico</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SO_planTarif" Tipo="estructura">estructura de plan tarifario</param>>
	         </Entrada>
	         <Salida>
				<param nom="SO_planTarif" Tipo="cursor">estructura de plan tarifario</param>>
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
    n_cod_vendedor     ge_seg_usuario.cod_vendedor%TYPE;
	error_ejecucion    EXCEPTION;
	error_parametros   EXCEPTION;
	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;

	IF (SO_descuento.usuario IS NULL) THEN
	    RAISE error_parametros;
	END IF;

    IF (ve_rec_codvendedorusuario_fn(SO_descuento, SO_ve_descuento, sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
	    IF (SO_descuento.codigo IS NOT NULL) THEN
		    IF (ve_recupera_codvenderaiz_fn (SO_descuento,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
		        IF NOT (ve_rec_descuento_vendedor_fn (SO_descuento,SO_ve_descuento,SN_cod_retorno,SV_mens_retorno,SN_num_evento)) THEN
			        RAISE error_ejecucion;
    			END IF;
			ELSE
			    RAISE error_ejecucion;
			END IF;
		END IF;
	ELSE
        RAISE error_ejecucion;
	END IF;

	EXCEPTION
	WHEN error_parametros THEN
	      SN_cod_retorno := 98;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 've_val_descuento_vendedor_pr ('||SO_descuento.usuario||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'VE_VENDEDORES_SB_PG.ve_val_descuento_vendedor_pr ', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 4;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 've_val_descuento_vendedor_pr ('||SO_descuento.usuario||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'VE_VENDEDORES_SB_PG.ve_val_descuento_vendedor_pr ', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 5;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 've_val_descuento_vendedor_pr ('||SO_descuento.usuario||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'VE_VENDEDORES_SB_PG.ve_val_descuento_vendedor_pr ', LV_sSQL, SN_cod_retorno, LV_des_error );
	END ve_val_descuento_vendedor_pr ;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	PROCEDURE ve_reg_solicitud_descuento_pr (
      SO_sol_des    	       IN OUT NOCOPY    GA_SOL_DESCUENTO_QT,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento)

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "TA_consCargoBasicoPlanTarif_PR"
	      Lenguaje="PL/SQL"
	      Fecha="18-07-2007"
	      Versión="1.0"
	      Diseñador="Raúl Lozano'
	      Programador="Raúl Lozano"
	      Ambiente Desarrollo="BD">
	      <Retorno>SO_planTarif</Retorno>>
	      <Descripción>Retorna información del cargo básico</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SO_planTarif" Tipo="estructura">estructura de plan tarifario</param>>
	         </Entrada>
	         <Salida>
				<param nom="SO_planTarif" Tipo="cursor">estructura de plan tarifario</param>>
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
    n_cod_vendedor     ge_seg_usuario.cod_vendedor%TYPE;
	error_ejecucion    EXCEPTION;
	error_parametros   EXCEPTION;
	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;


		LV_sSql	:= 'INSERT INTO ga_autoriza (num_autoriza, lin_autoriza, cod_estado, nom_usuaautorizaventa, num_venta, cod_oficina, cod_vendedor, num_unidades, '
                || 'fec_venta, nom_usuar_vta, prc_origin, ind_tipventa, cod_cliente, cod_modventa, cod_concepto, imp_cargo, cod_moneda, num_abonado, num_serie, cod_concepto_dto, '
                || 'val_dto, tip_dto, origen, ind_modifi) VALUES ('
				|| so_sol_des.num_autoriza||', '||so_sol_des.lin_autoriza||', '||so_sol_des.cod_estado||', '||so_sol_des.nom_usuaautorizaventa||', '
				|| so_sol_des.num_venta||', '||so_sol_des.cod_oficina||', '||so_sol_des.cod_vendedor||', '||so_sol_des.num_unidades||', '
				|| so_sol_des.fec_venta||', '||so_sol_des.nom_usuar_vta||', '||so_sol_des.prc_origin||', '||so_sol_des.ind_tipventa||', '
				|| so_sol_des.cod_cliente||', '||so_sol_des.cod_modventa||', '||so_sol_des.cod_concepto||', '||so_sol_des.imp_cargo||', '
				|| so_sol_des.cod_moneda||', '||so_sol_des.num_abonado||', '||so_sol_des.num_serie||', '||so_sol_des.cod_concepto_dto||', '
				|| so_sol_des.val_dto||', '||so_sol_des.tip_dto||', '||so_sol_des.origen||', '||so_sol_des.ind_modifi||')';

        INSERT INTO ga_autoriza
                    (num_autoriza, lin_autoriza, cod_estado, nom_usuaautorizaventa,
                     num_venta, cod_oficina, cod_vendedor, num_unidades,
                     fec_venta, nom_usuar_vta, prc_origin, ind_tipventa,
                     cod_cliente, cod_modventa, cod_concepto, imp_cargo,
                     cod_moneda, num_abonado, num_serie, cod_concepto_dto,
                     val_dto, tip_dto, origen, ind_modifi
                    )
             VALUES (so_sol_des.num_autoriza, so_sol_des.lin_autoriza, so_sol_des.cod_estado, so_sol_des.nom_usuaautorizaventa,
                     so_sol_des.num_venta, so_sol_des.cod_oficina, so_sol_des.cod_vendedor, so_sol_des.num_unidades,
                     so_sol_des.fec_venta, so_sol_des.nom_usuar_vta, so_sol_des.prc_origin, so_sol_des.ind_tipventa,
                     so_sol_des.cod_cliente, so_sol_des.cod_modventa, so_sol_des.cod_concepto, so_sol_des.imp_cargo,
                     so_sol_des.cod_moneda, so_sol_des.num_abonado, so_sol_des.num_serie, so_sol_des.cod_concepto_dto,
                     so_sol_des.val_dto, so_sol_des.tip_dto, so_sol_des.origen, so_sol_des.ind_modifi
                    );

	EXCEPTION
	WHEN OTHERS THEN
	      SN_cod_retorno := 5;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 've_val_descuento_vendedor_pr (''); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'VE_VENDEDORES_SB_PG.ve_val_descuento_vendedor_pr ', LV_sSQL, SN_cod_retorno, LV_des_error );
	END ve_reg_solicitud_descuento_pr ;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	PROCEDURE ve_cons_solicitud_descuento_pr (
      SO_sol_des    	       IN OUT NOCOPY    GA_SOL_DESCUENTO_QT,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento)

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "TA_consCargoBasicoPlanTarif_PR"
	      Lenguaje="PL/SQL"
	      Fecha="18-07-2007"
	      Versión="1.0"
	      Diseñador="Raúl Lozano'
	      Programador="Raúl Lozano"
	      Ambiente Desarrollo="BD">
	      <Retorno>SO_planTarif</Retorno>>
	      <Descripción>Retorna información del cargo básico</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SO_planTarif" Tipo="estructura">estructura de plan tarifario</param>>
	         </Entrada>
	         <Salida>
				<param nom="SO_planTarif" Tipo="cursor">estructura de plan tarifario</param>>
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
    n_cod_vendedor     ge_seg_usuario.cod_vendedor%TYPE;
	error_ejecucion    EXCEPTION;
	error_parametros   EXCEPTION;
	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;


		LV_sSql	:= ' SELECT num_autoriza, lin_autoriza, cod_estado, nom_usuaautorizaventa, num_venta, cod_oficina, cod_vendedor, num_unidades,'
		        || ' fec_venta, nom_usuar_vta, prc_origin, ind_tipventa, cod_cliente, cod_modventa, cod_concepto, imp_cargo, cod_moneda, num_abonado,'
				|| ' num_serie, cod_concepto_dto, val_dto, tip_dto, origen, ind_modifi'
				|| ' FROM ga_autoriza'
				|| ' WHERE num_autoriza = '||so_sol_des.num_autoriza;

        SELECT num_autoriza, lin_autoriza, cod_estado, nom_usuaautorizaventa, num_venta, cod_oficina, cod_vendedor, num_unidades,
               fec_venta, nom_usuar_vta, prc_origin, ind_tipventa, cod_cliente, cod_modventa, cod_concepto, imp_cargo, cod_moneda,
			   num_abonado, num_serie, cod_concepto_dto, val_dto, tip_dto, origen, ind_modifi
		  INTO so_sol_des.num_autoriza, so_sol_des.lin_autoriza, so_sol_des.cod_estado, so_sol_des.nom_usuaautorizaventa,
               so_sol_des.num_venta, so_sol_des.cod_oficina, so_sol_des.cod_vendedor, so_sol_des.num_unidades,
               so_sol_des.fec_venta, so_sol_des.nom_usuar_vta, so_sol_des.prc_origin, so_sol_des.ind_tipventa,
               so_sol_des.cod_cliente, so_sol_des.cod_modventa, so_sol_des.cod_concepto, so_sol_des.imp_cargo,
               so_sol_des.cod_moneda, so_sol_des.num_abonado, so_sol_des.num_serie, so_sol_des.cod_concepto_dto,
               so_sol_des.val_dto, so_sol_des.tip_dto, so_sol_des.origen, so_sol_des.ind_modifi
   		  FROM ga_autoriza
         WHERE num_autoriza = so_sol_des.num_autoriza;



	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 4;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 've_val_descuento_vendedor_pr (); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'VE_VENDEDORES_SB_PG.ve_val_descuento_vendedor_pr ', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 5;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 've_val_descuento_vendedor_pr (); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'VE_VENDEDORES_SB_PG.ve_val_descuento_vendedor_pr ', LV_sSQL, SN_cod_retorno, LV_des_error );
	END ve_cons_solicitud_descuento_pr ;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION ve_recupera_texto_carta_fn (
	    SO_descuento    	     IN OUT NOCOPY    GE_PROCESOS_QT,
		SO_ve_descuento	         IN OUT NOCOPY    VE_DESCUENTO_VEN_QT,
        SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        SN_num_evento            OUT NOCOPY		  ge_errores_pg.evento) RETURN BOOLEAN
    IS
	/*
	<Documentación
	  TipoDoc = "Funcion">>
	   <Elemento
	      Nombre = "Recupera_CodVendedor_FN"
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
	            <param nom="SO_planTarif" Tipo="estructura">estructura de plan tarifario</param>>
	         </Entrada>
	         <Salida>
				<param nom="SO_planTarif" Tipo="cursor">estructura de plan tarifario</param>>
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

        LV_sSql := 'SELECT cod_vendedor INTO FROM ge_seg_usuario WHERE nom_usuario = '||SO_descuento.usuario;

        /*IF (1) THEN

            SELECT ci.texto, pv.query
            FROM ci_tipcartas ci, pv_qry_cartas pv
            WHERE ci.cod_os = pv.cod_os
            AND ci.cod_os = [cod_od];

        ELSIF(2) THEN

			LV_sSql := 'SELECT ci.texto,pv.query'
			        ||' FROM ci_tipcartas ci,pv_qry_cartas pv, '||nombre_tabla
			        ||' ga, ge_clientes ge WHERE ga.'||campo ||' = '||valor
                    ||' AND ga.cod_cliente=ge.cod_cliente'
                    ||' AND ge.cod_idioma=ci.cod_idioma
					||' AND ci.cod_os = pv.cod_os'
                    ||' AND pv.cod_os= '||codos;

		ELSIF(3) THEN

            SELECT ci.texto,pv.query
            FROM ci_tipcartas ci,pv_qry_cartas pv,  [nombre_tabla] ga, ge_clientes ge
            WHERE ga.[nombre del campo]= [valor del campo C o A]
            AND ga.cod_cliente=ge.cod_cliente
            AND ge.cod_idioma=ci.cod_idioma AND ci.cod_os = pv.cod_os
            AND pv.cod_os= [cod_os]

	    END IF;*/



		 RETURN TRUE;

    EXCEPTION

	WHEN NO_DATA_FOUND THEN
          so_ve_descuento.ind_creadto := 0;
		  so_ve_descuento.prc_newdto_inf := 0;
		  so_ve_descuento.prc_newdto_sup := 0;
		  RETURN TRUE;

	WHEN OTHERS THEN
	      SN_cod_retorno := 1;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'Recupera_CodVendedor_FN ('||SO_descuento.usuario||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'VE_VENDEDORES_SB_PG.Recupera_CodVendedor_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
		  RETURN FALSE;

    END ve_recupera_texto_carta_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	PROCEDURE ve_reg_venta_prebilling_pr (
      EO_venta      	       IN OUT NOCOPY    GA_VENTA_QT,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento)

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "TA_consCargoBasicoPlanTarif_PR"
	      Lenguaje="PL/SQL"
	      Fecha="18-07-2007"
	      Versión="1.0"
	      Diseñador="Raúl Lozano'
	      Programador="Raúl Lozano"
	      Ambiente Desarrollo="BD">
	      <Retorno>SO_planTarif</Retorno>>
	      <Descripción>Retorna información del cargo básico</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SO_planTarif" Tipo="estructura">estructura de plan tarifario</param>>
	         </Entrada>
	         <Salida>
				<param nom="SO_planTarif" Tipo="cursor">estructura de plan tarifario</param>>
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
    n_cod_vendedor     ge_seg_usuario.cod_vendedor%TYPE;
	error_ejecucion    EXCEPTION;
	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;

        INSERT INTO ga_ventas
                    (num_venta, cod_producto, cod_oficina,
                     cod_tipcomis, cod_vendedor,
                     cod_vendedor_agente, num_unidades,
                     fec_venta, cod_region, cod_provincia,
                     cod_ciudad, ind_estventa,
                     ind_pasocob, ind_tipventa,
                     cod_cliente, cod_modventa, cod_cuota,
                     nom_usuar_vta, ind_venta,
                     tip_foliacion, cod_tipdocum,
                     cod_plaza, cod_operadora
                    )
             VALUES (eo_venta.num_venta, eo_venta.cod_producto, eo_venta.cod_oficina,
                     eo_venta.cod_tipcomis, eo_venta.cod_vendedor,
                     eo_venta.cod_vendedor_agente, eo_venta.num_unidades,
                     eo_venta.fec_venta, eo_venta.cod_region, eo_venta.cod_provincia,
                     eo_venta.cod_ciudad, eo_venta.ind_estventa,
                     eo_venta.ind_pasocob, eo_venta.ind_tipventa,
                     eo_venta.cod_cliente, eo_venta.cod_modventa, eo_venta.cod_cuota,
                     eo_venta.nom_usuar_vta, eo_venta.ind_venta,
                     eo_venta.tip_foliacion, eo_venta.cod_tipdocum,
                     eo_venta.cod_plaza, eo_venta.cod_operadora
                    );

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 4;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 've_val_descuento_vendedor_pr (); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'VE_VENDEDORES_SB_PG.ve_val_descuento_vendedor_pr ', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 5;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 've_val_descuento_vendedor_pr (); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'VE_VENDEDORES_SB_PG.ve_val_descuento_vendedor_pr ', LV_sSQL, SN_cod_retorno, LV_des_error );
	END ve_reg_venta_prebilling_pr ;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE ve_rec_direccion_vendedor_pr (
      SO_direccion     	       IN OUT NOCOPY    GE_DIRECCION_QT,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento)

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "ve_rec_direccion_vendedor_pr"
	      Lenguaje="PL/SQL"
	      Fecha="11-09-2007"
	      Versión="1.0"
	      Diseñador=
	      Programador="Elizabeth Vera
	      Ambiente Desarrollo="BD">
	      <Retorno>SO_direccion</Retorno>>
	      <Descripción>Obtiene direcciones de la oficina</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SO_direccion" Tipo="estructura">estructura de direcciones/param>>
	         </Entrada>
	         <Salida>
				<param nom="SO_direccion Tipo="cursor">estructura de direcciones</param>>
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
   		LV_sSql := 'SELECT A.COD_PLAZA, B.COD_REGION, B.COD_PROVINCIA, B.COD_CIUDAD';
		LV_sSql := LV_sSql || ' FROM ge_ciudades A, ge_direcciones B, ge_oficinas C';
		LV_sSql := LV_sSql || ' WHERE C.COD_OFICINA   = '|| SO_direccion.COD_OFICINA;
		LV_sSql := LV_sSql || ' AND   C.COD_DIRECCION = B.COD_DIRECCION';
		LV_sSql := LV_sSql || ' AND   B.COD_REGION    = A.COD_REGION';
		LV_sSql := LV_sSql || '	AND   B.COD_PROVINCIA = A.COD_PROVINCIA';
		LV_sSql := LV_sSql || '	AND   B.COD_CIUDAD    = A.COD_CIUDAD';


	    SELECT A.COD_PLAZA,B.COD_REGION, B.COD_PROVINCIA, B.COD_CIUDAD
			   INTO SO_direccion.COD_PLAZA, SO_direccion.COD_REGION, SO_direccion.COD_PROVINCIA, SO_direccion.COD_CIUDAD
        FROM ge_ciudades A, ge_direcciones B, ge_oficinas C
        WHERE C.COD_OFICINA   = SO_direccion.COD_OFICINA
		AND   C.COD_DIRECCION = B.COD_DIRECCION
		AND   B.COD_REGION    = A.COD_REGION
		AND   B.COD_PROVINCIA = A.COD_PROVINCIA
		AND   B.COD_CIUDAD    = A.COD_CIUDAD;



	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 4;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 've_rec_direccion_vendedor_pr (); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'VE_VENDEDORES_SB_PG.ve_val_descuento_vendedor_pr ', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 5;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 've_rec_direccion_vendedor_pr (); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'VE_VENDEDORES_SB_PG.ve_val_descuento_vendedor_pr ', LV_sSQL, SN_cod_retorno, LV_des_error );
	END ve_rec_direccion_vendedor_pr ;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_obtener_vendedor_pr (
      SO_vendedor    	       IN OUT NOCOPY    VE_VENDEDOR_QT,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento)

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "ve_obtener_vendedor_pr"
	      Lenguaje="PL/SQL"
	      Fecha="25-09-2007"
	      Versión="1.0"
	      Diseñador=
	      Programador="Elizabeth Vera
	      Ambiente Desarrollo="BD">
	      <Retorno>SO_direccion</Retorno>>
	      <Descripción>Obtiene informacion del vendedor/Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SO_vendedor" Tipo="estructura">estructura para vendedor/param>>
	         </Entrada>
	         <Salida>
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
   		LV_sSql := 'SELECT NOM_VENDEDOR FROM  VE_VENDEDORES WHERE COD_VENDEDOR='|| SO_vendedor.COD_VENDEDOR;


	    SELECT NOM_VENDEDOR
			   INTO SO_vendedor.NOM_VENDEDOR
        FROM VE_VENDEDORES
        WHERE COD_VENDEDOR = SO_vendedor.COD_VENDEDOR;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 4;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 've_obtener_vendedor_pr (); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'VE_VENDEDORES_SB_PG.ve_obtener_vendedor_pr ', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 5;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 've_obtener_vendedor_pr (); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'VE_VENDEDORES_SB_PG.ve_obtener_vendedor_pr ', LV_sSQL, SN_cod_retorno, LV_des_error );
	END ve_obtener_vendedor_pr ;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_obtener_usuario_vendedor_pr (
      SO_usuario    	        IN OUT NOCOPY    GE_SEG_USUARIO_QT,
	  SC_Cursor	              OUT NOCOPY  REFCURSOR,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento)

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "ve_obtener_usuario_vendedor_pr"
	      Lenguaje="PL/SQL"
	      Fecha="14-02-2008"
	      Versión="1.0"
	      Diseñador="Raúl Lozano''
	      Programador="Raúl Lozano''
	      Ambiente Desarrollo="BD">
	      <Retorno>GE_SEG_USUARIO_QT</Retorno>>
	      <Descripción>Obtiene informacion del  usuario a traves del codigo de vendedor/Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="GE_SEG_USUARIO_QT" Tipo="estructura">estructura para GE_SEG_USUARIO/param>>
	         </Entrada>
	         <Salida>
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
   		LV_sSql	:='  SELECT  NOM_USUARIO, NOM_OPERADOR, IND_ADM, COD_OFICINA , COD_TIPCOMIS, IND_EXCEP_ERIESGO'||
					  '  FROM GE_SEG_USUARIO U'||
					  '  WHERE U.COD_VENDEDOR = '||SO_usuario.COD_VENDEDOR;

		OPEN SC_Cursor FOR	LV_sSql	;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 4;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 've_obtener_usuario_vendedor_pr (); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'VE_VENDEDORES_SB_PG.ve_obtener_usuario_vendedor_pr ', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 5;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 've_obtener_usuario_vendedor_pr (); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'VE_VENDEDORES_SB_PG.ve_obtener_usuario_vendedor_pr ', LV_sSQL, SN_cod_retorno, LV_des_error );
	END ve_obtener_usuario_vendedor_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



END VE_VENDEDORES_SB_PG;
/
SHOW ERRORS
