CREATE OR REPLACE PACKAGE BODY pv_cambio_serie_sb_pg
IS

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	FUNCTION pv_val_grupo_usuario_fn (
      ESO_seg_usuario    IN OUT NOCOPY   GE_SEG_USUARIO_QT,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
    )
    /*
    <Documentacion TipoDoc = "Function">
       <Elemento
          Nombre = "GA_CONSUL_PROMEDIO_FACTURAC_FN"
          Fecha modificacion=" "
          Fecha creacion="03-04-2006"
          Programador="Marcelo Godoy S. - Carlos Navarro"
          Diseñador=""
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>
          <Descripcion></Descripcion>
          <Parametros>
             <Entrada>
                <param nom="ev_nom_tabla" Tipo="NUMERICO">Nombre de tabla</param>
             </Entrada>
             <Salida>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
             </Salida>
          </Parametros>
       </Elemento>
    </Documentacion>
    */
	RETURN BOOLEAN
	IS
	    V_des_error      ge_errores_pg.DesEvent;
	    sSql             ge_errores_pg.vQuery;
	    v_table_name     VARCHAR2(45);
		cant_grupo       NUMBER;
	BEGIN

	    SN_cod_retorno := 0;
	    SN_num_evento  := 0;
	    SV_mens_retorno:= '';


		sSql := ' SELECT COUNT (1)'
		     || ' FROM ge_seg_usuario a, ge_seg_grpusuario b, ge_seg_grupo c'
		     || ' WHERE b.nom_usuario = a.nom_usuario'
		     || ' AND c.cod_grupo = b.cod_grupo'
		     || ' AND a.nom_usuario = ''CERSAC'''
		     || ' AND c.cod_grupo IN ('
		     || ' SELECT cod_valor'
		     || ' FROM ged_codigos'
		     || ' WHERE nom_tabla = ''GRUPO_COMISION_OOSS'''
		     || ' AND nom_columna = ''COD_GRUPO'')''';


		SELECT COUNT (1)
		  INTO cant_grupo
		  FROM ge_seg_usuario a, ge_seg_grpusuario b, ge_seg_grupo c
		 WHERE b.nom_usuario = a.nom_usuario
		   AND c.cod_grupo = b.cod_grupo
		   AND a.nom_usuario = ESO_seg_usuario.nom_usuario
		   AND c.cod_grupo IN (
		                       SELECT cod_valor
		                         FROM ged_codigos
		                        WHERE nom_tabla = 'GRUPO_COMISION_OOSS'
		                          AND nom_columna = 'COD_GRUPO');

		IF cant_grupo > 0 THEN
		   ESO_seg_usuario.grup_callcenter := 'S';
		ELSE
		   ESO_seg_usuario.grup_callcenter := 'N';
		END IF;

        RETURN TRUE;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := '1';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       V_des_error := 'pv_cambio_serie_sb_pg.pv_val_grupo_usuario_fn; - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_cambio_serie_sb_pg.pv_val_grupo_usuario_fn', sSql, SQLCODE, v_des_error );
       RETURN FALSE;

    WHEN OTHERS THEN
       SN_cod_retorno := '2';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       V_des_error := 'pv_cambio_serie_sb_pg.pv_val_grupo_usuario_fn; - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_cambio_serie_sb_pg.pv_val_grupo_usuario_fn', sSql, SQLCODE, v_des_error );
       RETURN FALSE;

    END pv_val_grupo_usuario_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	FUNCTION pv_rec_ge_seg_usuario_fn (
      ESO_seg_usuario    IN OUT NOCOPY   GE_SEG_USUARIO_QT,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
    )
    /*
    <Documentacion TipoDoc = "Function">
       <Elemento
          Nombre = "GA_CONSUL_PROMEDIO_FACTURAC_FN"
          Fecha modificacion=" "
          Fecha creacion="03-04-2006"
          Programador="Marcelo Godoy S. - Carlos Navarro"
          Diseñador=""
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>
          <Descripcion></Descripcion>
          <Parametros>
             <Entrada>
                <param nom="ev_nom_tabla" Tipo="NUMERICO">Nombre de tabla</param>
             </Entrada>
             <Salida>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
             </Salida>
          </Parametros>
       </Elemento>
    </Documentacion>
    */
	RETURN BOOLEAN
	IS
	    V_des_error      ge_errores_pg.DesEvent;
	    sSql             ge_errores_pg.vQuery;
	    v_table_name     VARCHAR2(45);
		error_ejecucion  EXCEPTION;
	BEGIN

	    SN_cod_retorno := 0;
	    SN_num_evento  := 0;
	    SV_mens_retorno:= '';


		sSql := ' SELECT a.nom_usuario, a.nom_operador,'
             || 'a.ind_adm, a.cod_oficina, b.des_oficina, '
             || 'a.cod_tipcomis, a.cod_vendedor, '
             || 'a.ind_excep_eriesgo, b.cod_comuna, c.des_comuna '
             || 'FROM ge_seg_usuario a, ge_oficinas b, ge_comunas c '
             || 'WHERE a.nom_usuario = '||eso_seg_usuario.nom_usuario||' '
	         || 'AND b.cod_oficina = a.cod_oficina '
		     || 'AND c.cod_region = b.cod_region '
		     || 'AND c.cod_provincia = b.cod_provincia '
		     || 'AND c.cod_comuna = b.cod_comuna ';


      SELECT a.nom_usuario, a.nom_operador,
             a.ind_adm, a.cod_oficina, b.des_oficina,
             a.cod_tipcomis, a.cod_vendedor,
             a.ind_excep_eriesgo, b.cod_comuna, c.des_comuna
        INTO eso_seg_usuario.nom_usuario, eso_seg_usuario.nom_operador,
             eso_seg_usuario.ind_adm, eso_seg_usuario.cod_oficina, eso_seg_usuario.des_oficina,
             eso_seg_usuario.cod_tipcomis, eso_seg_usuario.cod_vendedor,
             eso_seg_usuario.ind_excep_eriesgo, eso_seg_usuario.cod_comuna, eso_seg_usuario.des_comuna
        FROM ge_seg_usuario a, ge_oficinas b, ge_comunas c
       WHERE a.nom_usuario = eso_seg_usuario.nom_usuario
	     AND b.cod_oficina = a.cod_oficina
		 AND c.cod_region = b.cod_region
		 AND c.cod_provincia = b.cod_provincia
		 AND c.cod_comuna = b.cod_comuna;


        IF NOT pv_val_grupo_usuario_fn (ESO_seg_usuario, sn_cod_retorno, sv_mens_retorno,sn_num_evento) THEN
		    RAISE error_ejecucion;
		END IF;

        RETURN TRUE;

	EXCEPTION
	WHEN error_ejecucion THEN
       V_des_error := 'pv_cambio_serie_sb_pg.pv_rec_ge_seg_usuario_fn; - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_cambio_serie_sb_pg.pv_rec_ge_seg_usuario_fn', sSql, SQLCODE, v_des_error );
       RETURN FALSE;

	WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := '1';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       V_des_error := 'pv_cambio_serie_sb_pg.pv_rec_ge_seg_usuario_fn; - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_cambio_serie_sb_pg.pv_rec_ge_seg_usuario_fn', sSql, SQLCODE, v_des_error );
       RETURN FALSE;

    WHEN OTHERS THEN
       SN_cod_retorno := '2';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       V_des_error := 'pv_cambio_serie_sb_pg.pv_rec_ge_seg_usuario_fn; - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_cambio_serie_sb_pg.pv_rec_ge_seg_usuario_fn', sSql, SQLCODE, v_des_error );
       RETURN FALSE;

    END pv_rec_ge_seg_usuario_fn;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	FUNCTION pv_rec_cat_plan_tarif_fn (
      eso_catplantarif   IN OUT NOCOPY   VE_CATPLANTARIF_QT,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
    )
    /*
    <Documentacion TipoDoc = "Function">
       <Elemento
          Nombre = "GA_CONSUL_PROMEDIO_FACTURAC_FN"
          Fecha modificacion=" "
          Fecha creacion="03-04-2006"
          Programador="Marcelo Godoy S. - Carlos Navarro"
          Diseñador=""
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>
          <Descripcion></Descripcion>
          <Parametros>
             <Entrada>
                <param nom="ev_nom_tabla" Tipo="NUMERICO">Nombre de tabla</param>
             </Entrada>
             <Salida>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
             </Salida>
          </Parametros>
       </Elemento>
    </Documentacion>
    */
	RETURN BOOLEAN
	IS
	    V_des_error      ge_errores_pg.DesEvent;
	    sSql             ge_errores_pg.vQuery;
	    v_table_name     VARCHAR2(45);
	BEGIN

	    SN_cod_retorno := 0;
	    SN_num_evento  := 0;
	    SV_mens_retorno:= '';

        SELECT cod_categoria, cod_producto,
               cod_plantarif, nom_usuario,
               fec_efectividad, fec_finefectividad
          INTO eso_catplantarif.cod_categoria, eso_catplantarif.cod_producto,
               eso_catplantarif.cod_plantarif, eso_catplantarif.nom_usuario,
               eso_catplantarif.fec_efectividad, eso_catplantarif.fec_finefectividad
          FROM ve_catplantarif
         WHERE cod_plantarif = eso_catplantarif.cod_plantarif
		   AND fec_efectividad <= SYSDATE
		   AND NVL(fec_finefectividad,SYSDATE) >= SYSDATE;

        RETURN TRUE;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := '3';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       V_des_error := 'pv_cambio_serie_sb_pg.pv_rec_cat_plan_tarif_fn; - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_cambio_serie_sb_pg.pv_rec_cat_plan_tarif_fn', sSql, SQLCODE, v_des_error );
       RETURN FALSE;

    WHEN OTHERS THEN
       SN_cod_retorno := '4';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       V_des_error := 'pv_cambio_serie_sb_pg.pv_rec_cat_plan_tarif_fn; - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_cambio_serie_sb_pg.pv_rec_cat_plan_tarif_fn', sSql, SQLCODE, v_des_error );
       RETURN FALSE;

    END pv_rec_cat_plan_tarif_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	FUNCTION pv_rec_cod_tiplan_fn (
      en_num_abonado     IN              ga_abocel.num_abonado%TYPE,
	  sv_cod_tiplan      OUT NOCOPY      ta_plantarif.cod_tiplan%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
    )
    /*
    <Documentacion TipoDoc = "Function">
       <Elemento
          Nombre = "GA_CONSUL_PROMEDIO_FACTURAC_FN"
          Fecha modificacion=" "
          Fecha creacion="03-04-2006"
          Programador="Marcelo Godoy S. - Carlos Navarro"
          Diseñador=""
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>
          <Descripcion></Descripcion>
          <Parametros>
             <Entrada>
                <param nom="ev_nom_tabla" Tipo="NUMERICO">Nombre de tabla</param>
             </Entrada>
             <Salida>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
             </Salida>
          </Parametros>
       </Elemento>
    </Documentacion>
    */
	RETURN BOOLEAN
	IS
	    V_des_error      ge_errores_pg.DesEvent;
	    sSql             ge_errores_pg.vQuery;
	    v_table_name     VARCHAR2(45);
	BEGIN

	    SN_cod_retorno := 0;
	    SN_num_evento  := 0;
	    SV_mens_retorno:= '';

        SELECT b.cod_tiplan
		  INTO sv_cod_tiplan
          FROM ga_abocel a, ta_plantarif b
         WHERE b.cod_plantarif = a.cod_plantarif
		   AND b.cod_producto = cv_prod_celular
		   AND a.num_abonado = en_num_abonado
         UNION
        SELECT b.cod_tiplan
          FROM ga_aboamist a, ta_plantarif b
         WHERE b.cod_plantarif = a.cod_plantarif
		   AND b.cod_producto = cv_prod_celular
		   AND a.num_abonado = en_num_abonado;

        RETURN TRUE;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := '5';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       V_des_error := 'pv_cambio_serie_sb_pg.pv_rec_cod_tiplan_fn; - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_cambio_serie_sb_pg.pv_rec_cod_tiplan_fn', sSql, SQLCODE, v_des_error );
       RETURN FALSE;

    WHEN OTHERS THEN
       SN_cod_retorno := '6';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       V_des_error := 'pv_cambio_serie_sb_pg.pv_rec_cod_tiplan_fn; - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_cambio_serie_sb_pg.pv_rec_cod_tiplan_fn', sSql, SQLCODE, v_des_error );
       RETURN FALSE;

    END pv_rec_cod_tiplan_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	FUNCTION pv_obtiene_ged_parametros_fn (
      EV_nom_parametro      IN              ged_parametros.nom_parametro%TYPE,
	  EV_cod_modulo         IN              ged_parametros.cod_modulo%TYPE,
	  sv_val_parametro      OUT    NOCOPY   ged_parametros.val_parametro%TYPE,
	  sv_des_parametro      OUT    NOCOPY   ged_parametros.des_parametro%TYPE,
      SN_cod_retorno    	OUT    NOCOPY   ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno   	OUT    NOCOPY   ge_errores_td.det_msgerror%TYPE,
      SN_num_evento     	OUT    NOCOPY	ge_errores_pg.evento
    )
    /*
    <Documentacion TipoDoc = "Function">
       <Elemento
          Nombre = "GA_CONSUL_PROMEDIO_FACTURAC_FN"
          Fecha modificacion=" "
          Fecha creacion="03-04-2006"
          Programador="Marcelo Godoy S. - Carlos Navarro"
          Diseñador=""
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>
          <Descripcion></Descripcion>
          <Parametros>
             <Entrada>
                <param nom="ev_nom_tabla" Tipo="NUMERICO">Nombre de tabla</param>
             </Entrada>
             <Salida>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
             </Salida>
          </Parametros>
       </Elemento>
    </Documentacion>
    */
	RETURN BOOLEAN
	IS
	    V_des_error      ge_errores_pg.DesEvent;
	    sSql             ge_errores_pg.vQuery;
	    v_table_name     VARCHAR2(45);
		n_cantidad       NUMBER;
	BEGIN



        SN_cod_retorno := 0;
	    SN_num_evento  := 0;
	    SV_mens_retorno:= '';

		sSql:='SELECT VAL_PARAMETRO,DES_PARAMETRO FROM  GED_PARAMETROS  ';
		sSql:= sSql || ' WHERE NOM_PARAMETRO = ' || ev_nom_parametro || ' ';
		sSql:= sSql || ' AND	 COD_MODULO    = ' || ev_cod_modulo    || ' ';


        SELECT val_parametro, des_parametro
          INTO sv_val_parametro, sv_des_parametro
          FROM ged_parametros
         WHERE nom_parametro = ev_nom_parametro
           AND cod_modulo = ev_cod_modulo
           AND cod_producto = cv_prod_celular;

       RETURN TRUE;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := '7';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       V_des_error := 'pv_cambio_serie_sb_pg.pv_obtiene_ged_parametros_fn(); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_cambio_serie_sb_pg.pv_obtiene_ged_parametros_fn', sSql, SQLCODE, v_des_error );
       RETURN FALSE;

    WHEN OTHERS THEN
       SN_cod_retorno := '8';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       V_des_error := 'pv_cambio_serie_sb_pg.pv_obtiene_ged_parametros_fn(); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_cambio_serie_sb_pg.pv_obtiene_ged_parametros_fn', sSql, SQLCODE, v_des_error );
       RETURN FALSE;

    END pv_obtiene_ged_parametros_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	FUNCTION pv_valida_plan_prepago_fn (
      ev_nom_usuario     IN              ged_codigos.nom_tabla%TYPE,
	  ev_cod_programa    IN              ged_codigos.nom_columna%TYPE,
	  en_num_version     IN              ged_codigos.cod_valor%TYPE,
	  en_num_abonado     IN              ga_abocel.num_abonado%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
    )
    /*
    <Documentacion TipoDoc = "Function">
       <Elemento
          Nombre = "GA_CONSUL_PROMEDIO_FACTURAC_FN"
          Fecha modificacion=" "
          Fecha creacion="03-04-2006"
          Programador="Marcelo Godoy S. - Carlos Navarro"
          Diseñador=""
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>
          <Descripcion></Descripcion>
          <Parametros>
             <Entrada>
                <param nom="ev_nom_tabla" Tipo="NUMERICO">Nombre de tabla</param>
             </Entrada>
             <Salida>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
             </Salida>
          </Parametros>
       </Elemento>
    </Documentacion>
    */
	RETURN BOOLEAN
	IS
	    V_des_error          ge_errores_pg.DesEvent;
	    sSql                 ge_errores_pg.vQuery;
	    v_table_name         VARCHAR2(45);
		n_cantidad           NUMBER;
		v_cod_tiplan         ta_plantarif.cod_tiplan%TYPE;
		v_cod_tiplanprepago  ged_parametros.val_parametro%TYPE;
		error_aplicacion     EXCEPTION;
		v_des_parametro        ged_parametros.des_parametro%TYPE;
	BEGIN

	    SN_cod_retorno := 0;
	    SN_num_evento  := 0;
	    SV_mens_retorno:= '';

        IF NOT(pv_rec_cod_tiplan_fn(en_num_abonado, v_cod_tiplan, sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
            RAISE error_aplicacion;
		END IF;

		IF NOT (pv_obtiene_ged_parametros_fn('TIP_PLAN_PREPAGO', 'GA', v_cod_tiplanprepago, v_des_parametro, sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
		    RAISE error_aplicacion;
		END IF;

		IF  (v_cod_tiplan = v_cod_tiplanprepago) THEN
			RETURN TRUE;
		ELSE
		    RETURN FALSE;
		END IF;

       RETURN TRUE;

	EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000,'Error de aplicacion pv_valida_permisos_fn');

    END pv_valida_plan_prepago_fn ;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	FUNCTION pv_valida_permisos_fn (
      ev_nom_usuario     IN              ged_codigos.nom_tabla%TYPE,
	  ev_cod_programa    IN              ged_codigos.nom_columna%TYPE,
	  en_num_version     IN              ged_codigos.cod_valor%TYPE,
	  ev_nom_perfil_proceso IN              gad_procesos_perfiles.nom_perfil_proceso%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
    )
    /*
    <Documentacion TipoDoc = "Function">
       <Elemento
          Nombre = "GA_CONSUL_PROMEDIO_FACTURAC_FN"
          Fecha modificacion=" "
          Fecha creacion="03-04-2006"
          Programador="Marcelo Godoy S. - Carlos Navarro"
          Diseñador=""
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>
          <Descripcion></Descripcion>
          <Parametros>
             <Entrada>
                <param nom="ev_nom_tabla" Tipo="NUMERICO">Nombre de tabla</param>
             </Entrada>
             <Salida>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
             </Salida>
          </Parametros>
       </Elemento>
    </Documentacion>
    */
	RETURN BOOLEAN
	IS
	    V_des_error      ge_errores_pg.DesEvent;
	    sSql             ge_errores_pg.vQuery;
	    v_table_name     VARCHAR2(45);
		n_cantidad       NUMBER;
		v_cod_proceso    VARCHAR2(7);
	BEGIN

	    SN_cod_retorno := 0;
	    SN_num_evento  := 0;
	    SV_mens_retorno:= '';


		sSql := ' SELECT count(1)'
		     || ' FROM ge_seg_perfiles a, ge_seg_grpusuario b'
             || ' WHERE a.cod_grupo = b.cod_grupo'
             || ' AND b.nom_usuario = '||ev_nom_usuario
             || ' AND a.cod_programa = '||ev_cod_programa
             || ' AND a.num_version = '||en_num_version
             || ' AND a.cod_proceso = '||v_cod_proceso;

        SELECT count(1)
		  INTO n_cantidad
          FROM ge_seg_perfiles a, ge_seg_grpusuario b
         WHERE a.cod_grupo = b.cod_grupo
           AND b.nom_usuario = ev_nom_usuario
/*           AND a.cod_programa = ev_cod_programa
           AND a.num_version = en_num_version*/
           AND a.cod_proceso = (SELECT cod_proceso
                        		  FROM GAD_PROCESOS_PERFILES
                                 WHERE nom_perfil_proceso = ev_nom_perfil_proceso);

		IF n_cantidad > 0 THEN
		    RETURN TRUE;
		ELSE
			RETURN FALSE;
		END IF;

	EXCEPTION
    WHEN OTHERS THEN
       SN_cod_retorno := '10';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       V_des_error := 'pv_cambio_serie_sb_pg.pv_valida_permisos_fn(); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_cambio_serie_sb_pg.pv_valida_permisos_fn', sSql, SQLCODE, v_des_error );
       RETURN FALSE;

    END pv_valida_permisos_fn ;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	FUNCTION pv_rec_ged_codigo_fn (
      ev_nom_tabla       IN              ged_codigos.nom_tabla%TYPE,
	  ev_nom_columna     IN              ged_codigos.nom_columna%TYPE,
	  ev_cod_valor       IN              ged_codigos.cod_valor%TYPE,
	  sv_des_valor       OUT NOCOPY      ged_codigos.des_valor%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
    )
    /*
    <Documentacion TipoDoc = "Function">
       <Elemento
          Nombre = "GA_CONSUL_PROMEDIO_FACTURAC_FN"
          Fecha modificacion=" "
          Fecha creacion="03-04-2006"
          Programador="Marcelo Godoy S. - Carlos Navarro"
          Diseñador=""
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>
          <Descripcion></Descripcion>
          <Parametros>
             <Entrada>
                <param nom="ev_nom_tabla" Tipo="NUMERICO">Nombre de tabla</param>
             </Entrada>
             <Salida>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
             </Salida>
          </Parametros>
       </Elemento>
    </Documentacion>
    */
	RETURN BOOLEAN
	IS
	    V_des_error      ge_errores_pg.DesEvent;
	    sSql             ge_errores_pg.vQuery;
	    v_table_name     VARCHAR2(45);
	BEGIN

	    SN_cod_retorno := 0;
	    SN_num_evento  := 0;
	    SV_mens_retorno:= '';

        SELECT des_valor
		  INTO sv_des_valor
          FROM ged_codigos
         WHERE nom_tabla = ev_nom_tabla
           AND nom_columna = ev_nom_columna
           AND cod_valor = ev_cod_valor;

       RETURN TRUE;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := '9';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       V_des_error := 'pv_cambio_serie_sb_pg.pv_rec_ged_codigo_fn(' || ev_nom_tabla || '); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_cambio_serie_sb_pg.pv_rec_ged_codigo_fn', sSql, SQLCODE, v_des_error );
       RETURN FALSE;

    WHEN OTHERS THEN
       SN_cod_retorno := '10';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       V_des_error := 'pv_cambio_serie_sb_pg.pv_rec_ged_codigo_fn(' || ev_nom_tabla || '); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_cambio_serie_sb_pg.pv_rec_ged_codigo_fn', sSql, SQLCODE, v_des_error );
       RETURN FALSE;

    END pv_rec_ged_codigo_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	FUNCTION pv_rec_tip_contrato_fn (
      en_num_abonado      IN              ga_abocel.num_abonado%TYPE,
	  sv_des_tip_contrato OUT NOCOPY      ged_codigos.des_valor%TYPE,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
    )
    /*
    <Documentacion TipoDoc = "Function">
       <Elemento
          Nombre = "GA_CONSUL_PROMEDIO_FACTURAC_FN"
          Fecha modificacion=" "
          Fecha creacion="03-04-2006"
          Programador="Marcelo Godoy S. - Carlos Navarro"
          Diseñador=""
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>
          <Descripcion></Descripcion>
          <Parametros>
             <Entrada>
                <param nom="ev_nom_tabla" Tipo="NUMERICO">Nombre de tabla</param>
             </Entrada>
             <Salida>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
             </Salida>
          </Parametros>
       </Elemento>
    </Documentacion>
    */
	RETURN BOOLEAN
	IS
	    V_des_error        ge_errores_pg.DesEvent;
	    sSql               ge_errores_pg.vQuery;
		v_des_tip_plan     ged_codigos.des_valor%TYPE;
		error_ejecucion    EXCEPTION;
		v_cod_tiplan       ta_plantarif.cod_tiplan%TYPE;
	BEGIN

	    SN_cod_retorno := 0;
	    SN_num_evento  := 0;
	    SV_mens_retorno:= '';

        IF NOT (pv_rec_cod_tiplan_fn (en_num_abonado,v_cod_tiplan,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
		    raise error_ejecucion;
		END IF;

        IF NOT(pv_rec_ged_codigo_fn ('TA_PLANTARIF','COD_TIPLAN',v_cod_tiplan,v_des_tip_plan,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
	        raise error_ejecucion;
		END IF;

        SELECT DECODE (cod_valor, 'H', 'P', cod_valor)
		  INTO sv_des_tip_contrato
          FROM ged_codigos
         WHERE nom_tabla = 'GA_TIPCONTRATO'
           AND nom_columna = 'IND_CONTSEG'
           AND des_valor = v_des_tip_plan;

       RETURN TRUE;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := '11';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       V_des_error := 'pv_cambio_serie_sb_pg.pv_rec_tip_contrato_fn(); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_cambio_serie_sb_pg.pv_rec_tip_contrato_fn', sSql, SQLCODE, v_des_error );
       RETURN FALSE;

    WHEN OTHERS THEN
       SN_cod_retorno := '12';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       V_des_error := 'pv_cambio_serie_sb_pg.pv_rec_tip_contrato_fn(); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_cambio_serie_sb_pg.pv_rec_tip_contrato_fn', sSql, SQLCODE, v_des_error );
       RETURN FALSE;

END pv_rec_tip_contrato_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	PROCEDURE pv_rec_info_abonado_pr (
      SEO_dat_abo              IN OUT NOCOPY	PV_DATOS_ABO_QT,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento)

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "pv_rec_info_abonado_pr"
	      Lenguaje="PL/SQL"
	      Fecha="18-07-2007"
	      Versión="1.0"
	      Diseñador="Marcelo Godoy'
	      Programador="Marcelo Godoy"
	      Ambiente Desarrollo="BD">
	      <Retorno>SEO_dat_abo</Retorno>>
	      <Descripción>Retorna información del cargo básico</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SEO_dat_abo" Tipo="estructura"></param>>
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
    eso_catplantarif   VE_CATPLANTARIF_QT := NEW VE_CATPLANTARIF_QT;
    CN_cod_prestacion  VARCHAR2(5);
    CN_ind_inventario_fijo NUMBER;
    CV_cod_plantarif    VARCHAR2(5);
    CN_contAbon         NUMBER;

	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;
        CN_cod_prestacion:= NULL;
        CN_ind_inventario_fijo:=0 ;
        CV_cod_plantarif:= NULL;
        CN_contAbon :=0;


        select count(1)
        into CN_contAbon
        from ga_abocel
        where num_abonado=SEO_dat_abo.num_abonado;

        IF (CN_contAbon =0)THEN

            select cod_plantarif
            into CV_cod_plantarif
            from ga_aboamist
            where num_abonado=SEO_dat_abo.num_abonado;
        ELSE
            select cod_plantarif
            into CV_cod_plantarif
            from ga_abocel
            where num_abonado=SEO_dat_abo.num_abonado;

        END IF ;


       LV_sSql := ' select cod_prestacion '||
                  ' from ta_plantarif   '||
                  ' where cod_plantarif ='||CV_cod_plantarif;

        select cod_prestacion
        into CN_cod_prestacion
        from ta_plantarif
        where cod_plantarif =CV_cod_plantarif;


        LV_sSql := ' select ind_inventario_fijo '||
                   ' from GE_PRESTACIONES_TD '||
                   ' where cod_prestacion = '||CN_cod_prestacion;

        select ind_inventario_fijo
        into CN_ind_inventario_fijo
        from GE_PRESTACIONES_TD
        where cod_prestacion = CN_cod_prestacion;




		LV_sSql := ' SELECT b.nom_usuario,b.nom_apellido1,b.nom_apellido2,c.des_equipo,c.num_serie,'
                || ' DECODE (c.ind_procequi,''I'',''INTERNO'',''E'',''EXTERNO'',''S'',''SUBSIDIADO'') AS des_procequi,'
                || ' f.des_terminal,d.des_modventa,c.num_seriemec,DECODE (c.ind_propiedad,''C'',''CLIENTE'','
                || ' ''E'', ''EMPRESA'') AS ind_propiedad,e.des_uso,c.ind_procequi,d.ind_cuotas,d.cod_modventa,'
                || ' g.des_tipcontrato,h.cod_tiplan,a.num_imei,g.cod_tipcontrato,a.cod_plantarif,a.num_contrato,'
                || ' a.num_anexo,a.cod_region,a.cod_provincia,a.cod_ciudad,a.cod_cliente,'
                || ' a.num_celular,a.cod_tecnologia,a.fec_alta,a.tip_plantarif,a.tip_terminal,a.cod_situacion,'
                || ' i.des_situacion,a.cod_central,a.cod_ciclo,a.cod_planserv,''C'',a.cod_uso,'
                || ' a.num_seriehex,a.num_min,a.cod_cargobasico,a.cod_producto,c.cod_articulo'
                || ' FROM ga_abocel a, ga_usuarios b, ga_equipaboser c, ge_modventa d, al_usos e, al_tipos_terminales f,'
                || ' ga_tipcontrato g, ta_plantarif h'
                || ' WHERE a.num_abonado = '|| SEO_dat_abo.num_abonado
                || ' AND b.cod_usuario = a.cod_usuario'
                || ' AND c.num_abonado = a.num_abonado'
                || ' AND (c.ind_equiacc = ''E'' OR c.ind_equiacc IS NULL)'
                || ' AND c.fec_alta = (SELECT MAX (fec_alta)'
                || ' FROM ga_equipaboser'
                || ' WHERE num_abonado = '|| SEO_dat_abo.num_abonado ||' AND '
                || ' (ind_equiacc = ''E'' OR ind_equiacc IS NULL) AND'
                || ' tip_terminal <> ''G'')'
                || ' AND c.tip_terminal <> ''G'''
                || ' AND d.cod_modventa(+) = c.cod_modventa'
                || ' AND e.cod_uso = c.cod_uso'
                || ' AND f.cod_producto = '|| CV_prod_celular
                || ' AND f.tip_terminal = c.tip_terminal'
                || ' AND g.cod_producto = '|| CV_prod_celular
                || ' AND g.cod_tipcontrato = a.cod_tipcontrato'
                || ' AND h.cod_plantarif = a.cod_plantarif'
                || ' AND i.cod_situacion = a.cod_situacion'
                || ' UNION'
				|| ' SELECT b.nom_usuario,b.nom_apellido1,b.nom_apellido2,c.des_equipo,c.num_serie,'
                || ' DECODE (c.ind_procequi,''I'',''INTERNO'',''E'',''EXTERNO'',''S'',''SUBSIDIADO'') AS des_procequi,'
                || ' f.des_terminal,d.des_modventa,c.num_seriemec,DECODE (c.ind_propiedad,''C'',''CLIENTE'','
                || ' ''E'', ''EMPRESA'') AS ind_propiedad, e.des_uso, c.ind_procequi, d.ind_cuotas, d.cod_modventa,'
                || ' g.des_tipcontrato,h.cod_tiplan,a.num_imei,g.cod_tipcontrato,a.cod_plantarif,a.num_contrato,'
                || ' a.num_anexo,a.cod_region,a.cod_provincia,a.cod_ciudad,a.cod_cliente,'
                || ' a.num_celular,a.cod_tecnologia,a.fec_alta,a.tip_plantarif,a.tip_terminal,a.cod_situacion,'
                || ' i.des_situacion,a.cod_central,a.cod_ciclo,a.cod_planserv,''C'',a.cod_uso,'
                || ' a.num_seriehex,a.num_min,a.cod_cargobasico,a.cod_producto,c.cod_articulo'
                || ' FROM ga_aboamist a, ga_usuarios b, ga_equipaboser c, ge_modventa d, al_usos e, al_tipos_terminales f,'
                || ' ga_tipcontrato g, ta_plantarif h'
                || ' WHERE a.num_abonado = '|| SEO_dat_abo.num_abonado
                || ' AND b.cod_usuario = a.cod_usuario'
                || ' AND c.num_abonado = a.num_abonado'
                || ' AND (c.ind_equiacc = ''E'' OR c.ind_equiacc IS NULL)'
                || ' AND c.fec_alta = (SELECT MAX (fec_alta)'
                || ' FROM ga_equipaboser'
                || ' WHERE num_abonado = '|| SEO_dat_abo.num_abonado ||' AND '
                || ' (ind_equiacc = ''E'' OR ind_equiacc IS NULL) AND'
                || ' tip_terminal <> ''G'')'
                || ' AND c.tip_terminal <> ''G'''
                || ' AND d.cod_modventa(+) = c.cod_modventa'
                || ' AND e.cod_uso = c.cod_uso'
                || ' AND f.cod_producto = '|| CV_prod_celular
                || ' AND f.tip_terminal = c.tip_terminal'
                || ' AND g.cod_producto = '|| CV_prod_celular
                || ' AND g.cod_tipcontrato = a.cod_tipcontrato'
                || ' AND h.cod_plantarif = a.cod_plantarif'
                || ' AND i.cod_situacion = a.cod_situacion';

            IF  (CN_ind_inventario_fijo=0) THEN
                 SELECT b.nom_usuario, b.nom_apellido1, b.nom_apellido2, 'EQUIPO DUMMY', a.num_serie,
                       DECODE (a.ind_procequi,'I', 'INTERNO','E', 'EXTERNO','S', 'SUBSIDIADO') AS des_procequi,
                       f.des_terminal, d.des_modventa, a.num_seriemec, 'C', e.des_uso, a.ind_procequi, d.ind_cuotas, d.cod_modventa,
                       g.des_tipcontrato, h.cod_tiplan, a.num_imei, g.cod_tipcontrato, a.cod_plantarif, a.num_contrato, a.num_anexo, a.cod_region, a.cod_provincia, a.cod_ciudad, a.cod_cliente,
                       a.num_celular, a.cod_tecnologia, a.fec_alta, a.tip_plantarif, a.tip_terminal, a.cod_situacion, i.des_situacion, a.cod_central, a.cod_ciclo, a.cod_planserv, 'C', a.cod_uso,
                       a.num_seriehex, a.num_min, a.cod_cargobasico, a.cod_producto, 0

                     INTO SEO_dat_abo.nom_usuario,
                                           SEO_dat_abo.nom_apellido1,
                                           SEO_dat_abo.nom_apellido2,
                                           SEO_dat_abo.des_equipo,
                                           SEO_dat_abo.num_serie,
                                           SEO_dat_abo.des_procequi,
                                           SEO_dat_abo.des_terminal,
                                           SEO_dat_abo.des_modventa,
                                           SEO_dat_abo.num_seriemec,
                                           SEO_dat_abo.ind_propiedad,
                                           SEO_dat_abo.des_uso,
                                           SEO_dat_abo.ind_procequi,
                                           SEO_dat_abo.ind_cuotas,
                                           SEO_dat_abo.cod_modventa,
                                           SEO_dat_abo.des_tipcontrato,
                                           SEO_dat_abo.cod_tiplan,
                                           SEO_dat_abo.num_imei,
                                           SEO_dat_abo.cod_tipcontrato,
                                           SEO_dat_abo.cod_plantarif,
                                           SEO_dat_abo.num_contrato,
                                           SEO_dat_abo.num_anexo,
                                           SEO_dat_abo.cod_region,
                                           SEO_dat_abo.cod_provincia,
                                           SEO_dat_abo.cod_ciudad,
                                           SEO_dat_abo.cod_cliente,
                                           SEO_dat_abo.num_celular,
                                           SEO_dat_abo.cod_tecnologia,
                                           SEO_dat_abo.fec_alta,
                                           SEO_dat_abo.tip_plantarif,
                                           SEO_dat_abo.tip_terminal,
                                           SEO_dat_abo.cod_situacion,
                                           SEO_dat_abo.des_situacion,
                                           SEO_dat_abo.cod_central,
                                           SEO_dat_abo.cod_ciclo,
                                           SEO_dat_abo.cod_planserv,
                                           SEO_dat_abo.des_origen,
                                           SEO_dat_abo.cod_uso,
                                           SEO_dat_abo.num_seriehex,
                                           SEO_dat_abo.num_min,
                                           SEO_dat_abo.cod_cargobasico,
                                           SEO_dat_abo.cod_producto,
                                           SEO_dat_abo.cod_articulo
                      FROM ga_abocel a, ga_usuarios b, ge_modventa d, al_usos e, al_tipos_terminales f,
                                           ga_tipcontrato g, ta_plantarif h, ga_situabo i,ga_ventas c
                                     WHERE a.num_abonado =  SEO_dat_abo.num_abonado
                                       AND b.cod_usuario = a.cod_usuario
                                       --AND c.cod_cliente = a.cod_cliente
                                       AND d.cod_modventa = c.cod_modventa
                                       AND e.cod_uso = a.cod_uso
                                       AND f.cod_producto = 1
                                       AND f.tip_terminal = a.tip_terminal
                                       AND g.cod_producto = 1
                                       AND g.cod_tipcontrato = a.cod_tipcontrato
                                       AND h.cod_plantarif = a.cod_plantarif
                                       AND i.cod_situacion = a.cod_situacion
                                       AND a.num_venta = c.num_venta
                     UNION

                     SELECT b.nom_usuario, b.nom_apellido1, b.nom_apellido2, 'EQUIPO DUMMY', a.num_serie,
                                           DECODE (a.ind_procequi,'I', 'INTERNO','E', 'EXTERNO','S', 'SUBSIDIADO') AS des_procequi,
                                           f.des_terminal, d.des_modventa, a.num_seriemec, 'C', e.des_uso, a.ind_procequi, d.ind_cuotas, d.cod_modventa,
                                           g.des_tipcontrato, h.cod_tiplan, a.num_imei, g.cod_tipcontrato, a.cod_plantarif, a.num_contrato, a.num_anexo, a.cod_region, a.cod_provincia, a.cod_ciudad, a.cod_cliente,
                                           a.num_celular, a.cod_tecnologia, a.fec_alta, a.tip_plantarif, a.tip_terminal, a.cod_situacion, i.des_situacion, a.cod_central, a.cod_ciclo, a.cod_planserv, 'C', a.cod_uso,
                                           a.num_seriehex, a.num_min, a.cod_cargobasico, a.cod_producto, 0
                      FROM ga_aboamist a, ga_usuarios b, ge_modventa d, al_usos e, al_tipos_terminales f,
                                           ga_tipcontrato g, ta_plantarif h, ga_situabo i,ga_ventas c
                                     WHERE a.num_abonado =  SEO_dat_abo.num_abonado
                                       AND b.cod_usuario = a.cod_usuario
                                     --  AND c.cod_cliente = a.cod_cliente
                                       AND d.cod_modventa = c.cod_modventa
                                       AND e.cod_uso = a.cod_uso
                                       AND f.cod_producto = 1
                                       AND f.tip_terminal = a.tip_terminal
                                       AND g.cod_producto = 1
                                       AND g.cod_tipcontrato = a.cod_tipcontrato
                                       AND h.cod_plantarif = a.cod_plantarif
                                       AND i.cod_situacion = a.cod_situacion
                                        AND a.num_venta = c.num_venta;

            ELSE

                SELECT b.nom_usuario, b.nom_apellido1, b.nom_apellido2, c.des_equipo, a.num_serie,
                       DECODE (c.ind_procequi,'I', 'INTERNO','E', 'EXTERNO','S', 'SUBSIDIADO') AS des_procequi,
                       f.des_terminal, d.des_modventa, c.num_seriemec, DECODE (c.ind_propiedad,'C', 'CLIENTE',
                       'E', 'EMPRESA') AS ind_propiedad, e.des_uso, c.ind_procequi, d.ind_cuotas, d.cod_modventa,
                       g.des_tipcontrato, h.cod_tiplan, a.num_imei, g.cod_tipcontrato, a.cod_plantarif, a.num_contrato, a.num_anexo, a.cod_region, a.cod_provincia, a.cod_ciudad, a.cod_cliente,
                       a.num_celular, a.cod_tecnologia, a.fec_alta, a.tip_plantarif, a.tip_terminal, a.cod_situacion, i.des_situacion, a.cod_central, a.cod_ciclo, a.cod_planserv, 'C', a.cod_uso,
                       a.num_seriehex, a.num_min, a.cod_cargobasico, a.cod_producto, c.cod_articulo
                  INTO SEO_dat_abo.nom_usuario,
                       SEO_dat_abo.nom_apellido1,
                       SEO_dat_abo.nom_apellido2,
                       SEO_dat_abo.des_equipo,
                       SEO_dat_abo.num_serie,
                       SEO_dat_abo.des_procequi,
                       SEO_dat_abo.des_terminal,
                       SEO_dat_abo.des_modventa,
                       SEO_dat_abo.num_seriemec,
                       SEO_dat_abo.ind_propiedad,
                       SEO_dat_abo.des_uso,
                       SEO_dat_abo.ind_procequi,
                       SEO_dat_abo.ind_cuotas,
                       SEO_dat_abo.cod_modventa,
                       SEO_dat_abo.des_tipcontrato,
                       SEO_dat_abo.cod_tiplan,
                       SEO_dat_abo.num_imei,
                       SEO_dat_abo.cod_tipcontrato,
                       SEO_dat_abo.cod_plantarif,
                       SEO_dat_abo.num_contrato,
                       SEO_dat_abo.num_anexo,
                       SEO_dat_abo.cod_region,
                       SEO_dat_abo.cod_provincia,
                       SEO_dat_abo.cod_ciudad,
                       SEO_dat_abo.cod_cliente,
                       SEO_dat_abo.num_celular,
                       SEO_dat_abo.cod_tecnologia,
                       SEO_dat_abo.fec_alta,
                       SEO_dat_abo.tip_plantarif,
                       SEO_dat_abo.tip_terminal,
                       SEO_dat_abo.cod_situacion,
                       SEO_dat_abo.des_situacion,
                       SEO_dat_abo.cod_central,
                       SEO_dat_abo.cod_ciclo,
                       SEO_dat_abo.cod_planserv,
                       SEO_dat_abo.des_origen,
                       SEO_dat_abo.cod_uso,
                       SEO_dat_abo.num_seriehex,
                       SEO_dat_abo.num_min,
                       SEO_dat_abo.cod_cargobasico,
                       SEO_dat_abo.cod_producto,
                       SEO_dat_abo.cod_articulo
                       FROM ga_abocel a, ga_usuarios b, ga_equipaboser c, ge_modventa d, al_usos e, al_tipos_terminales f,
                       ga_tipcontrato g, ta_plantarif h, ga_situabo i
                 WHERE a.num_abonado = SEO_dat_abo.num_abonado
                   AND b.cod_usuario = a.cod_usuario
                   AND c.num_abonado = a.num_abonado
                   AND (c.ind_equiacc = 'E' OR c.ind_equiacc IS NULL)
                   AND c.fec_alta = (SELECT MAX (fec_alta)
                                       FROM ga_equipaboser
                                       WHERE num_abonado = SEO_dat_abo.num_abonado
                                       AND (ind_equiacc = 'E' OR ind_equiacc IS NULL)
                                       AND tip_terminal <> 'G')
                   AND c.tip_terminal <> 'G'
                   AND d.cod_modventa(+) = c.cod_modventa
                   AND e.cod_uso = a.cod_uso
                   AND f.cod_producto = CV_prod_celular
                   AND f.tip_terminal = c.tip_terminal
                   AND g.cod_producto = CV_prod_celular
                   AND g.cod_tipcontrato = a.cod_tipcontrato
                   AND h.cod_plantarif = a.cod_plantarif
                   AND i.cod_situacion = a.cod_situacion
                UNION
                SELECT b.nom_usuario, b.nom_apellido1, b.nom_apellido2, c.des_equipo, a.num_serie,
                       DECODE (c.ind_procequi,'I', 'INTERNO','E', 'EXTERNO','S', 'SUBSIDIADO') AS des_procequi,
                       f.des_terminal, d.des_modventa, c.num_seriemec, DECODE (c.ind_propiedad,'C', 'CLIENTE',
                       'E', 'EMPRESA') AS ind_propiedad, e.des_uso, c.ind_procequi, d.ind_cuotas, d.cod_modventa,
                       g.des_tipcontrato, h.cod_tiplan, a.num_imei, g.cod_tipcontrato, a.cod_plantarif, a.num_contrato, a.num_anexo, a.cod_region, a.cod_provincia, a.cod_ciudad, a.cod_cliente,
                       a.num_celular, a.cod_tecnologia, a.fec_alta, a.tip_plantarif, a.tip_terminal, a.cod_situacion, i.des_situacion, a.cod_central, a.cod_ciclo, a.cod_planserv, 'P', a.cod_uso,
                       a.num_seriehex, a.num_min, a.cod_cargobasico, a.cod_producto, c.cod_articulo
                  FROM ga_aboamist a, ga_usuamist b, ga_equipaboser c, ge_modventa d, al_usos e, al_tipos_terminales f,
                       ga_tipcontrato g, ta_plantarif h, ga_situabo i
                 WHERE a.num_abonado = SEO_dat_abo.num_abonado
                   AND b.cod_usuario = a.cod_usuario
                   AND c.num_abonado = a.num_abonado
                   AND (c.ind_equiacc = 'E' OR c.ind_equiacc IS NULL)
                   AND c.fec_alta = (SELECT MAX (fec_alta)
                                       FROM ga_equipaboser
                                       WHERE num_abonado = SEO_dat_abo.num_abonado
                                       AND (ind_equiacc = 'E' OR ind_equiacc IS NULL)
                                       AND tip_terminal <> 'G')
                   AND c.tip_terminal <> 'G'
                   AND d.cod_modventa(+) = c.cod_modventa
                   AND e.cod_uso = a.cod_uso
                   AND f.cod_producto = CV_prod_celular
                   AND f.tip_terminal = c.tip_terminal
                   AND g.cod_producto = CV_prod_celular
                   AND g.cod_tipcontrato = a.cod_tipcontrato
                   AND h.cod_plantarif = a.cod_plantarif
                   AND i.cod_situacion = a.cod_situacion;
           END IF;


		   eso_catplantarif.cod_plantarif := SEO_dat_abo.cod_plantarif;
	       IF NOT (pv_rec_cat_plan_tarif_fn(eso_catplantarif,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
	          sn_cod_retorno 	:= 0;
	          sv_mens_retorno := NULL;
    	      sn_num_evento 	:= 0;
		   ELSE
		      eso_catplantarif.cod_categoria := eso_catplantarif.cod_categoria;
		   END IF;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 218;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'pv_cambio_serie_sb_pg.pv_rec_info_abonado_pr('||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CAMBIO_SERIE_SB_PG.pv_rec_info_abonado_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 203;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'pv_cambio_serie_sb_pg.pv_rec_info_abonado_pr('||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CAMBIO_SERIE_SB_PG.pv_rec_info_abonado_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	END pv_rec_info_abonado_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	PROCEDURE pv_rec_cau_cambio_serie_pr (
      SC_Cau_Cam_Serie         OUT NOCOPY	    refcursor,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento)

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "pv_rec_info_abonado_pr"
	      Lenguaje="PL/SQL"
	      Fecha="18-07-2007"
	      Versión="1.0"
	      Diseñador="Marcelo Godoy'
	      Programador="Marcelo Godoy"
	      Ambiente Desarrollo="BD">
	      <Retorno>SEO_dat_abo</Retorno>>
	      <Descripción>Retorna información del cargo básico</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SEO_dat_abo" Tipo="estructura"></param>>
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

		LV_sSql := 'SELECT a.cod_caucaser, a.des_caucaser, a.ind_cargo, a.ind_antiguedad,a.ind_seguro'
                || ' FROM ga_caucaser a'
                || ' WHERE a.cod_producto = '||CV_prod_celular
                || ' AND NOT EXISTS ('
                || ' SELECT 1'
                || ' FROM ga_parametros_sistema_vw b'
                || ' WHERE b.cod_modulo = '||CV_cod_modulo_GA
                || ' AND b.cod_operadora = '||GE_FN_OPERADORA_SCL
                || ' AND b.nom_parametro = ''CAUSA_NO_DESPLEGABLE'''
                || ' AND b.valor_dominio = a.cod_caucaser);';

        OPEN SC_Cau_Cam_Serie FOR
        SELECT a.cod_caucaser, a.des_caucaser, a.ind_antiguedad, a.ind_cargo, a.ind_dev_almacen, a.cod_estado_dev,a.IND_SEGURO
          FROM ga_caucaser a
         WHERE a.cod_producto = CV_prod_celular
           AND NOT EXISTS (
                  SELECT 1
                    FROM ga_parametros_sistema_vw b
                   WHERE b.cod_modulo = CV_cod_modulo_GA
                     AND b.cod_operadora = GE_FN_OPERADORA_SCL
                     AND b.nom_parametro = 'CAUSA_NO_DESPLEGABLE'
                     AND b.valor_dominio = a.cod_caucaser);

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 999;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'pv_cambio_serie_sb_pg.pv_rec_cau_cambio_serie_pr('||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CAMBIO_SERIE_SB_PG.pv_rec_cau_cambio_serie_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 999;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'pv_cambio_serie_sb_pg.pv_rec_cau_cambio_serie_pr('||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CAMBIO_SERIE_SB_PG.pv_rec_cau_cambio_serie_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	END pv_rec_cau_cambio_serie_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	PROCEDURE pv_rec_tipos_contrato_pr (
	  OE_sesion                IN               GE_SESION_QT,
      SC_tip_contrato          OUT NOCOPY	    refcursor,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento)

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "pv_rec_info_abonado_pr"
	      Lenguaje="PL/SQL"
	      Fecha="18-07-2007"
	      Versión="1.0"
	      Diseñador="Marcelo Godoy'
	      Programador="Marcelo Godoy"
	      Ambiente Desarrollo="BD">
	      <Retorno>SEO_dat_abo</Retorno>>
	      <Descripción>Retorna información del cargo básico</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SEO_dat_abo" Tipo="estructura"></param>>
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
    v_des_tip_contrato ged_codigos.des_valor%TYPE;
	error_ejecucion    EXCEPTION;
	ssql	           ge_errores_pg.vQuery;
	O_dat_abo          PV_DATOS_ABO_QT := NEW PV_DATOS_ABO_QT;
	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;

		O_dat_abo.num_abonado := OE_sesion.num_abonado;

        pv_rec_info_abonado_pr (O_dat_abo,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
		IF (SN_cod_retorno <> 0 )THEN
		    RAISE error_ejecucion;
		END IF;

	    IF NOT (pv_rec_tip_contrato_fn (OE_sesion.num_abonado,v_des_tip_contrato,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
		    raise error_ejecucion;
		END IF;

        ssql := 'SELECT a.cod_tipcontrato, a.des_tipcontrato, a.fec_desde, a.fec_hasta,'
             || ' a.ind_contseg, a.ind_contcel, a.ind_comodato, a.canal_vta, a.meses_minimo,'
             || ' a.ind_procequi, a.ind_preciolista, a.ind_gmc,b.num_meses'
             || ' FROM ga_tipcontrato a, ga_percontrato b'
             || ' WHERE a.fec_desde <= SYSDATE'
             || ' AND NVL (a.fec_hasta, SYSDATE) >= SYSDATE'
             || ' AND a.cod_producto = '||CV_prod_celular
			 || ' AND a.cod_producto =b.cod_producto'
             || ' AND a.IND_CONTCEL = ''V'''
			 || ' AND a.cod_tipcontrato=b.cod_tipcontrato'
             || ' AND a.IND_CONTSEG = '''||v_des_tip_contrato||'''';

    	IF NOT (pv_valida_permisos_fn (OE_sesion.nom_usuario,OE_sesion.cod_programa,OE_sesion.num_version,'COD_PROC_COMODATO',sn_cod_retorno,sv_mens_retorno, sn_num_evento)) THEN
	        ssql := ssql || ' AND NVL(a.IND_COMODATO,0) <> 1';
        END IF;

		IF NOT (pv_valida_permisos_fn (OE_sesion.nom_usuario,OE_sesion.cod_programa,OE_sesion.num_version,'COD_PROC_INDGMC',sn_cod_retorno,sv_mens_retorno, sn_num_evento)) THEN
	        ssql := ssql || ' AND a.IND_GMC = ''0''';
        END IF;

		IF (pv_valida_plan_prepago_fn (OE_sesion.nom_usuario,OE_sesion.cod_programa,OE_sesion.num_version,OE_sesion.num_abonado,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
	        ssql := ssql || ' AND a.COD_TIPCONTRATO = '||to_char(O_dat_abo.cod_tipcontrato);
	    END IF;
	        ssql := ssql || ' ORDER BY a.DES_TIPCONTRATO';

		OPEN SC_tip_contrato FOR sSql;


	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 999;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'pv_cambio_serie_sb_pg.pv_rec_tipos_contrato_pr('||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CAMBIO_SERIE_SB_PG.pv_rec_tipos_contrato_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 999;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'pv_cambio_serie_sb_pg.pv_rec_tipos_contrato_pr('||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CAMBIO_SERIE_SB_PG.pv_rec_tipos_contrato_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	END pv_rec_tipos_contrato_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


	FUNCTION pv_rec_tipo_contrato_fn (
	  seo_tipcontrato          IN OUT NOCOPY    GA_TIPCONTRATO_QT,
      sn_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      sn_num_evento            OUT NOCOPY		ge_errores_pg.evento)

	RETURN BOOLEAN
	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "pv_rec_info_abonado_pr"
	      Lenguaje="PL/SQL"
	      Fecha="18-07-2007"
	      Versión="1.0"
	      Diseñador="Marcelo Godoy'
	      Programador="Marcelo Godoy"
	      Ambiente Desarrollo="BD">
	      <Retorno>SEO_dat_abo</Retorno>>
	      <Descripción>Retorna información del cargo básico</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SEO_dat_abo" Tipo="estructura"></param>>
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
    v_des_tip_contrato ged_codigos.des_valor%TYPE;
	error_ejecucion    EXCEPTION;
	ssql	           VARCHAR2(400);
	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;


        SELECT cod_producto, cod_tipcontrato,
               des_tipcontrato, fec_desde,
               fec_hasta, ind_contseg,
               ind_contcel, ind_comodato,
               canal_vta, meses_minimo,
               ind_procequi, ind_preciolista,
               ind_gmc
          INTO seo_tipcontrato.cod_producto, seo_tipcontrato.cod_tipcontrato,
               seo_tipcontrato.des_tipcontrato, seo_tipcontrato.fec_desde,
               seo_tipcontrato.fec_hasta, seo_tipcontrato.ind_contseg,
               seo_tipcontrato.ind_contcel, seo_tipcontrato.ind_comodato,
               seo_tipcontrato.canal_vta, seo_tipcontrato.meses_minimo,
               seo_tipcontrato.ind_procequi, seo_tipcontrato.ind_preciolista,
               seo_tipcontrato.ind_gmc
          FROM ga_tipcontrato
         WHERE cod_tipcontrato = seo_tipcontrato.cod_tipcontrato;

        RETURN TRUE;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := '1';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error := 'pv_cambio_serie_sb_pg.pv_rec_tipo_contrato_fn(); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_cambio_serie_sb_pg.pv_rec_tipo_contrato_fn', sSql, SQLCODE, LV_des_error );
       RETURN FALSE;

    WHEN OTHERS THEN
       SN_cod_retorno := '156';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error := 'pv_cambio_serie_sb_pg.pv_rec_tipo_contrato_fn(); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_cambio_serie_sb_pg.pv_rec_tipo_contrato_fn', sSql, SQLCODE, LV_des_error );
       RETURN FALSE;
	END pv_rec_tipo_contrato_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	PROCEDURE pv_recuperar_bodegas_pr (
	  EO_sesion                IN               GE_SESION_QT,
      SC_bodegas               OUT NOCOPY	    refcursor,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento)

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "pv_rec_info_abonado_pr"
	      Lenguaje="PL/SQL"
	      Fecha="18-07-2007"
	      Versión="1.0"
	      Diseñador="Marcelo Godoy'
	      Programador="Marcelo Godoy"
	      Ambiente Desarrollo="BD">
	      <Retorno>SEO_dat_abo</Retorno>>
	      <Descripción>Retorna información del cargo básico</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SEO_dat_abo" Tipo="estructura"></param>>
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

		LV_sSql := 'SELECT cod_bodega, des_bodega, tip_bodega, cod_direccion, ind_asignada,'
                || ' cod_bodega_padre, num_telefono1, num_telefono2, num_fax,'
                || ' nom_responsable, cod_grpconcepto'
                || ' FROM ve_vendalmac a, al_bodegas b, al_bodeganodo c, ge_operadora_scl d'
                || ' WHERE a.cod_vendedor = 1'
                || ' AND SYSDATE BETWEEN a.fec_asignacion AND NVL (a.fec_desasignac, SYSDATE)'
                || ' AND a.cod_bodega = b.cod_bodega'
                || ' AND b.cod_bodega = c.cod_bodega'
                || ' AND c.cod_bodeganodo = d.cod_bodeganodo'
                || ' AND d.cod_operadora_scl = 1'
                || ' ORDER BY b.des_bodega;';

            OPEN SC_bodegas FOR
          SELECT b.cod_bodega, b.des_bodega, b.tip_bodega, b.cod_direccion, b.ind_asignada,
                 b.cod_bodega_padre, b.num_telefono1, b.num_telefono2, b.num_fax,
                 b.nom_responsable, b.cod_grpconcepto
            FROM ve_vendalmac a, al_bodegas b, al_bodeganodo c, ge_operadora_scl d, ge_seg_usuario e, ge_clientes f
           WHERE a.cod_vendedor = e.cod_vendedor
		     AND e.nom_usuario = EO_sesion.nom_usuario
             AND SYSDATE BETWEEN a.fec_asignacion AND NVL (a.fec_desasignac, SYSDATE)
             AND a.cod_bodega = b.cod_bodega
             AND b.cod_bodega = c.cod_bodega
             AND c.cod_bodeganodo = d.cod_bodeganodo
			 AND f.cod_cliente = EO_sesion.cod_cliente
             AND d.cod_operadora_scl = f.cod_operadora
        ORDER BY b.des_bodega;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 999;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'pv_cambio_serie_sb_pg.pv_recuperar_bodegas_pr('||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CAMBIO_SERIE_SB_PG.pv_recuperar_bodegas_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 999;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'pv_cambio_serie_sb_pg.pv_recuperar_bodegas_pr('||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CAMBIO_SERIE_SB_PG.pv_recuperar_bodegas_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	END pv_recuperar_bodegas_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	PROCEDURE pv_recuperar_tecnologias_pr (
      SC_tecnologia            OUT NOCOPY	    refcursor,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento)

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "pv_rec_info_abonado_pr"
	      Lenguaje="PL/SQL"
	      Fecha="18-07-2007"
	      Versión="1.0"
	      Diseñador="Marcelo Godoy'
	      Programador="Marcelo Godoy"
	      Ambiente Desarrollo="BD">
	      <Retorno>SEO_dat_abo</Retorno>>
	      <Descripción>Retorna información del cargo básico</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SEO_dat_abo" Tipo="estructura"></param>>
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

		LV_sSql := 'SELECT cod_tecnologia, des_tecnologia'
                || ' FROM al_tecnologia'
                || ' WHERE cod_tecnologia NOT IN (SELECT val_parametro'
                || ' FROM ged_parametros'
                || ' WHERE nom_parametro = ''NO_TECNOLOGIA'')';

            OPEN SC_tecnologia FOR
            SELECT cod_tecnologia, des_tecnologia
              FROM al_tecnologia
             WHERE cod_tecnologia NOT IN (SELECT val_parametro
                                            FROM ged_parametros
                                           WHERE nom_parametro = 'NO_TECNOLOGIA');

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 999;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'pv_cambio_serie_sb_pg.pv_recuperar_tecnologias_pr('||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CAMBIO_SERIE_SB_PG.pv_recuperar_tecnologias_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 999;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'pv_cambio_serie_sb_pg.pv_recuperar_tecnologias_pr('||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CAMBIO_SERIE_SB_PG.pv_recuperar_tecnologias_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	END pv_recuperar_tecnologias_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	PROCEDURE pv_recuperar_usos_pr (
      SC_usos                  OUT NOCOPY	    refcursor,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento)

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "pv_rec_info_abonado_pr"
	      Lenguaje="PL/SQL"
	      Fecha="18-07-2007"
	      Versión="1.0"
	      Diseñador="Marcelo Godoy'
	      Programador="Marcelo Godoy"
	      Ambiente Desarrollo="BD">
	      <Retorno>SEO_dat_abo</Retorno>>
	      <Descripción>Retorna información del cargo básico</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SEO_dat_abo" Tipo="estructura"></param>>
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

		LV_sSql := 'SELECT a.cod_uso, a.des_uso'
                || ' FROM al_usos a;';

          OPEN SC_usos FOR
        SELECT a.cod_uso, a.des_uso
          FROM al_usos a
         WHERE a.ind_usoventa >= (SELECT b.val_parametro
                                    FROM ged_parametros b
                                   WHERE b.nom_parametro = 'USOS_VENTAS' AND b.cod_producto = 1)
      ORDER BY a.des_uso;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 999;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'pv_cambio_serie_sb_pg.pv_recuperar_usos_pr('||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CAMBIO_SERIE_SB_PG.pv_recuperar_usos_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 999;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'pv_cambio_serie_sb_pg.pv_recuperar_usos_pr('||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CAMBIO_SERIE_SB_PG.pv_recuperar_usos_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	END pv_recuperar_usos_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	PROCEDURE pv_rec_meses_prorroga_pr (
      sc_prorroga              OUT NOCOPY       refcursor,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento)

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "pv_rec_info_abonado_pr"
	      Lenguaje="PL/SQL"
	      Fecha="18-07-2007"
	      Versión="1.0"
	      Diseñador="Marcelo Godoy'
	      Programador="Marcelo Godoy"
	      Ambiente Desarrollo="BD">
	      <Retorno>SEO_dat_abo</Retorno>>
	      <Descripción>Retorna información del cargo básico</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SEO_dat_abo" Tipo="estructura"></param>>
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

		LV_sSql := 'SELECT a.cod_uso, a.des_uso'
                || ' FROM al_usos a;';

          OPEN sc_prorroga FOR
        SELECT num_meses, des_prorroga
          FROM ga_meses_prorroga
         WHERE SYSDATE BETWEEN fec_desde AND fec_hasta
         ORDER BY num_meses;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 999;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'pv_cambio_serie_sb_pg.pv_rec_meses_prorroga_pr('||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CAMBIO_SERIE_SB_PG.pv_rec_meses_prorroga_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 999;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'pv_cambio_serie_sb_pg.pv_rec_meses_prorroga_pr('||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CAMBIO_SERIE_SB_PG.pv_rec_meses_prorroga_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	END pv_rec_meses_prorroga_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	PROCEDURE pv_rec_modalidad_pago_pr (
	  ESO_caucaser             IN OUT NOCOPY    GA_CAUCASER_QT,
	  ESO_sesion               IN OUT NOCOPY    GE_SESION_QT,
	  SC_mod_pago              OUT NOCOPY       refcursor,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento)

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "pv_rec_info_abonado_pr"
	      Lenguaje="PL/SQL"
	      Fecha="18-07-2007"
	      Versión="1.0"
	      Diseñador="Marcelo Godoy'
	      Programador="Marcelo Godoy"
	      Ambiente Desarrollo="BD">
	      <Retorno>SEO_dat_abo</Retorno>>
	      <Descripción>Retorna información del cargo básico</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SEO_dat_abo" Tipo="estructura"></param>>
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

	LV_des_error    ge_errores_pg.DesEvent;
	LV_sSql		    ge_errores_pg.vQuery;
	v_indcausa      ged_parametros.val_parametro%TYPE;
    o_ve_tipcomis   VE_TIPCOMIS_QT     := NEW VE_TIPCOMIS_QT;
    o_tipcontrato   GA_TIPCONTRATO_QT  := NEW GA_TIPCONTRATO_QT;
	o_catplantarif  VE_CATPLANTARIF_QT := NEW VE_CATPLANTARIF_QT;
	O_seg_usuario   GE_SEG_USUARIO_QT    := NEW GE_SEG_USUARIO_QT;
    O_dat_abo       PV_DATOS_ABO_QT      := NEW PV_DATOS_ABO_QT;
	error_ejecucion EXCEPTION;
	v_des_parametro ged_parametros.des_parametro%TYPE;
	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;

		O_seg_usuario.nom_usuario := ESO_sesion.nom_usuario;
	    IF NOT (pv_rec_ge_seg_usuario_fn (O_seg_usuario,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
		    RAISE error_ejecucion;
		END IF;

		O_dat_abo.num_abonado := ESO_sesion.num_abonado;
	    pv_rec_info_abonado_pr (O_dat_abo ,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
		IF SN_cod_retorno <> 0 THEN
		    RAISE error_ejecucion;
		END IF;

		o_ve_tipcomis.cod_tipcomis := O_seg_usuario.cod_tipcomis;
        IF NOT (ve_general_servicios_pg.pv_rec_canal_venta_fn (o_ve_tipcomis,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
		    RAISE error_ejecucion;
		END IF;

		o_tipcontrato.cod_tipcontrato  := O_dat_abo.cod_tipcontrato;
        IF NOT (pv_rec_tipo_contrato_fn (o_tipcontrato,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
		    RAISE error_ejecucion;
		END IF;

		IF NOT (pv_obtiene_ged_parametros_fn ('CE','GA',v_indcausa,v_des_parametro,SN_cod_retorno,SV_mens_retorno,SN_num_evento)) THEN
		    RAISE error_ejecucion;
		END IF;

		o_catplantarif.cod_plantarif := O_dat_abo.cod_plantarif;
		IF NOT (pv_rec_cat_plan_tarif_fn (o_catplantarif,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
		    RAISE error_ejecucion;
		END IF;


		LV_sSql := 'SELECT UNIQUE a.cod_modventa, a.des_modventa, a.ind_cuotas, a.ind_pagado, a.cod_caupago, a.ind_abono'
                || ' FROM ge_modventa a, ga_modvent_aplic b'
                || ' WHERE a.cod_modventa = b.cod_modventa'
                || ' AND b.cod_producto = '||cv_prod_celular
                || ' AND b.cod_aplic LIKE ''%GPA%'''
                || ' AND b.cod_canal = '||o_ve_tipcomis.ind_vta_externa
                || ' AND a.cod_modventa IN ('
                || ' SELECT cod_modpago'
                || ' FROM gad_modpago_catplan c'
                || ' WHERE c.cod_tipcontrato = '||O_dat_abo.cod_tipcontrato
                || ' AND c.num_meses = '||o_tipcontrato.meses_minimo
                || ' AND c.cod_operacion = ''CE'''
                || ' AND c.ind_causa = '||v_indcausa
                || ' AND c.cod_causa = '''||ESO_caucaser.cod_caucaser||''''
                || ' AND c.cod_categoria = '''||o_catplantarif.cod_categoria||''''
                || ' AND c.cod_canal_vta = '||o_ve_tipcomis.ind_vta_externa
                || ' AND SYSDATE BETWEEN c.fec_desde AND c.fec_hasta'
                || ' AND c.cod_modpago = a.cod_modventa)';

        IF NOT (pv_valida_permisos_fn (ESO_sesion.nom_usuario,ESO_sesion.cod_programa,ESO_sesion.num_version,'COD_PROC_MODVENTA',sn_cod_retorno,sv_mens_retorno, sn_num_evento)) THEN
	        LV_sSql := LV_sSql || ' AND IND_CUOTAS <> -1';
        END IF;

        OPEN SC_mod_pago FOR LV_sSql;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 999;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'pv_cambio_serie_sb_pg.pv_rec_modalidad_pago_pr('||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CAMBIO_SERIE_SB_PG.pv_rec_modalidad_pago_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 999;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'pv_cambio_serie_sb_pg.pv_rec_modalidad_pago_pr('||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CAMBIO_SERIE_SB_PG.pv_rec_modalidad_pago_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	END pv_rec_modalidad_pago_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	PROCEDURE pv_rec_tipo_terminal_pr (
	  EV_cod_tecnologia        IN               al_tecnologia.cod_tecnologia%TYPE,
	  SC_tip_terminal          OUT NOCOPY       refcursor,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento)

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "pv_rec_info_abonado_pr"
	      Lenguaje="PL/SQL"
	      Fecha="18-07-2007"
	      Versión="1.0"
	      Diseñador="Marcelo Godoy'
	      Programador="Marcelo Godoy"
	      Ambiente Desarrollo="BD">
	      <Retorno>SEO_dat_abo</Retorno>>
	      <Descripción>Retorna información del cargo básico</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SEO_dat_abo" Tipo="estructura"></param>>
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

	LV_des_error    ge_errores_pg.DesEvent;
	LV_sSql		    ge_errores_pg.vQuery;
	error_ejecucion EXCEPTION;
	sIndApertura    ged_parametros.val_parametro%TYPE;
	v_des_parametro ged_parametros.des_parametro%TYPE;
	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;


		IF EV_cod_tecnologia IS NOT NULL THEN


            IF NOT (pv_obtiene_ged_parametros_fn ('IND_APLICA_APERTURA', 'PV', sIndApertura, v_des_parametro, SN_cod_retorno, SV_mens_retorno, SN_num_evento)) THEN
    		    RAISE error_ejecucion;
    		END IF;


            LV_sSql	:= 'SELECT DISTINCT a.tip_terminal, a.des_terminal'
                    || ' FROM al_tipos_terminales a, al_tecnoarticulo_td b, al_articulos c'
                    || ' WHERE a.cod_producto = 1'
                    || ' AND a.tip_terminal = c.tip_terminal'
                    || ' AND c.cod_articulo = b.cod_articulo';

            IF sIndApertura = 'TRUE'  THEN
                LV_sSql := LV_sSql || ' AND b.cod_tecnologia = '''|| EV_cod_tecnologia ||'''';
            END IF;

            LV_sSql	:= LV_sSql || ' AND a.tip_terminal NOT IN (SELECT val_parametro FROM ged_parametros'
                               || ' WHERE  nom_parametro = ''COD_SIMCARD_GSM'''
                               || ' AND cod_modulo = ''AL'''
                               || ' AND cod_producto  = 1)';

            OPEN SC_tip_terminal FOR LV_sSql;
		ELSE

		LV_sSql	:= 'SELECT a.tip_terminal, a.des_terminal'
                || ' FROM al_tipos_terminales a'
                || ' WHERE a.cod_producto = '||cv_prod_celular
                || ' AND tip_terminal IN ('
                || ' SELECT val_parametro'
                || ' FROM ged_parametros'
                || ' WHERE nom_parametro = ''COD_SIMCARD_GSM'''
                || ' AND cod_modulo = ''AL'''
                || ' AND cod_producto = '||cv_prod_celular||')';

              OPEN SC_tip_terminal FOR
            SELECT a.tip_terminal, a.des_terminal
              FROM al_tipos_terminales a
             WHERE a.cod_producto = cv_prod_celular
               AND tip_terminal IN (
                      SELECT val_parametro
                        FROM ged_parametros
                       WHERE nom_parametro = 'COD_SIMCARD_GSM'
                         AND cod_modulo = 'AL'
                         AND cod_producto = cv_prod_celular);
		END IF;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 999;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'pv_cambio_serie_sb_pg.pv_rec_tipo_terminal_pr('||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CAMBIO_SERIE_SB_PG.pv_rec_tipo_terminal_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 999;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'pv_cambio_serie_sb_pg.pv_rec_tipo_terminal_pr('||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CAMBIO_SERIE_SB_PG.pv_rec_tipo_terminal_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	END pv_rec_tipo_terminal_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	PROCEDURE pv_recuperar_cuotas_pr (
	  eo_sesion                IN               GE_SESION_QT,
 	  eo_modventa              IN               GE_MODVENTA_QT,
	  SC_cuotas                OUT NOCOPY       refcursor,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento)

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "pv_rec_info_abonado_pr"
	      Lenguaje="PL/SQL"
	      Fecha="18-07-2007"
	      Versión="1.0"
	      Diseñador="Marcelo Godoy'
	      Programador="Marcelo Godoy"
	      Ambiente Desarrollo="BD">
	      <Retorno>SEO_dat_abo</Retorno>>
	      <Descripción>Retorna información del cargo básico</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SEO_dat_abo" Tipo="estructura"></param>>
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

	LV_des_error    ge_errores_pg.DesEvent;
	LV_sSql		    ge_errores_pg.vQuery;
	error_ejecucion EXCEPTION;
	sIndApertura    ged_parametros.val_parametro%TYPE;
	v_cod_modpricta ged_parametros.val_parametro%TYPE;
	v_cod_cuota     ged_parametros.val_parametro%TYPE;
	v_des_parametro ged_parametros.des_parametro%TYPE;
	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;


        IF NOT (pv_obtiene_ged_parametros_fn ('COD_MODPRICTA', 'GA', v_cod_modpricta, v_des_parametro, SN_cod_retorno, SV_mens_retorno, SN_num_evento)) THEN
		    RAISE error_ejecucion;
		END IF;

        IF NOT (pv_obtiene_ged_parametros_fn ('COD_CONCONS', 'GA', v_cod_cuota, v_des_parametro, SN_cod_retorno, SV_mens_retorno, SN_num_evento)) THEN
		    RAISE error_ejecucion;
		END IF;

        LV_sSql := 'SELECT cod_cuota, des_cuota, num_cuotas, por_interes, num_dias, ind_forminteres FROM ge_tipcuotas';

        IF (eo_modventa.cod_modventa <> v_cod_modpricta AND NOT pv_valida_permisos_fn (eo_sesion.nom_usuario, eo_sesion.cod_programa, eo_sesion.num_version,'COD_PROC_CARGOACUENTA',sn_cod_retorno,sv_mens_retorno, sn_num_evento)) Then

            LV_sSql := LV_sSql || ' WHERE cod_cuota <> '||v_cod_cuota;

        ELSIF (eo_modventa.cod_modventa = v_cod_modpricta ) Then

           LV_sSql := LV_sSql || ' WHERE cod_cuota = '||v_cod_cuota;

        END IF;

        OPEN SC_cuotas FOR LV_sSql;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 999;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'pv_cambio_serie_sb_pg.pv_recuperar_cuotas_pr('||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CAMBIO_SERIE_SB_PG.pv_recuperar_cuotas_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 999;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'pv_cambio_serie_sb_pg.pv_recuperar_cuotas_pr('||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CAMBIO_SERIE_SB_PG.pv_recuperar_cuotas_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	END pv_recuperar_cuotas_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	PROCEDURE pv_rec_cat_tributaria_pr (
	  eo_sesion                IN               GE_SESION_QT,
	  SC_cat_tributaria        OUT NOCOPY       refcursor,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento)

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "pv_rec_info_abonado_pr"
	      Lenguaje="PL/SQL"
	      Fecha="18-07-2007"
	      Versión="1.0"
	      Diseñador="Marcelo Godoy'
	      Programador="Marcelo Godoy"
	      Ambiente Desarrollo="BD">
	      <Retorno>SEO_dat_abo</Retorno>>
	      <Descripción>Retorna información del cargo básico</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SEO_dat_abo" Tipo="estructura"></param>>
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

	LV_des_error    ge_errores_pg.DesEvent;
	LV_sSql		    ge_errores_pg.vQuery;
	error_ejecucion EXCEPTION;

	v_uso_fac_global     ged_parametros.val_parametro%TYPE;
	v_cod_docguia        ged_parametros.val_parametro%TYPE;
	v_cod_factura_global ged_parametros.val_parametro%TYPE;
	v_des_parametro      ged_parametros.des_parametro%TYPE;
	v_des_factura_global ged_parametros.des_parametro%TYPE;
	v_cod_cat_tribu_clie ga_catributclie.cod_catribut%TYPE;
	v_tip_foliacion      ge_tipdocumen.tip_foliacion%TYPE;
	sSql                 ge_errores_pg.vQuery;

	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;


        IF NOT (pv_obtiene_ged_parametros_fn ('USO_FAC_GLOBAL', 'GA', v_uso_fac_global, v_des_parametro, SN_cod_retorno, SV_mens_retorno, SN_num_evento)) THEN
		    RAISE error_ejecucion;
		END IF;

        IF NOT (pv_obtiene_ged_parametros_fn ('COD_DOCGUIA', 'GA', v_cod_docguia, v_des_parametro, SN_cod_retorno, SV_mens_retorno, SN_num_evento)) THEN
		    RAISE error_ejecucion;
		END IF;

        IF NOT (pv_obtiene_ged_parametros_fn ('FACTURA_GLOBAL', 'GA', v_cod_factura_global, v_des_factura_global, SN_cod_retorno, SV_mens_retorno, SN_num_evento)) THEN
		    RAISE error_ejecucion;
		END IF;

		sSql := ' SELECT b.cod_tipdocum, b.des_tipdocum, b.tip_foliacion, a.cod_catribut'
             || ' FROM ge_catribdocum a, ge_tipdocumen b, ga_catributclie c'
             || ' WHERE c.cod_cliente = '||eo_sesion.cod_cliente
             || ' AND a.cod_catribut = c.cod_catribut'
             || ' AND a.cod_tipdocum = b.cod_tipdocum'
             || ' AND SYSDATE BETWEEN c.fec_desde AND c.fec_hasta';

		IF UPPER(v_uso_fac_global) = 'TRUE' THEN

		   LV_sSql := 'SELECT cod_catribut'
		           || ' FROM ga_catributclie'
			       || ' WHERE cod_cliente = '||eo_sesion.cod_cliente;

		   SELECT cod_catribut
		     INTO v_cod_cat_tribu_clie
		     FROM ga_catributclie
			WHERE cod_cliente = eo_sesion.cod_cliente;

			IF v_cod_cat_tribu_clie = 'F' THEN

		   LV_sSql := 'SELECT tip_foliacion'
		           || ' FROM ge_tipdocumen'
			       || ' WHERE cod_tipdocum = '||v_cod_docguia;

			   SELECT tip_foliacion
			     INTO v_tip_foliacion
			     FROM ge_tipdocumen
                WHERE cod_tipdocum = v_cod_docguia;

				sSql := sSql ||' UNION SELECT '||v_cod_factura_global||', '''||v_des_factura_global||''' ,'''||v_tip_foliacion||''' ,'''||v_cod_cat_tribu_clie||''' FROM DUAL';
			END IF;

		END IF;

		LV_sSql := sSql;
        OPEN SC_cat_tributaria FOR LV_sSql;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 999;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'pv_cambio_serie_sb_pg.pv_rec_cat_tributaria_pr('||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CAMBIO_SERIE_SB_PG.pv_rec_cat_tributaria_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 999;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'pv_cambio_serie_sb_pg.pv_rec_cat_tributaria_pr('||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CAMBIO_SERIE_SB_PG.pv_rec_cat_tributaria_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	END pv_rec_cat_tributaria_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	PROCEDURE pv_rec_usos_ventas_pr (
	  SC_usos_venta            OUT NOCOPY       refcursor,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento)

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "pv_rec_info_abonado_pr"
	      Lenguaje="PL/SQL"
	      Fecha="18-07-2007"
	      Versión="1.0"
	      Diseñador="Marcelo Godoy'
	      Programador="Marcelo Godoy"
	      Ambiente Desarrollo="BD">
	      <Retorno>SEO_dat_abo</Retorno>>
	      <Descripción>Retorna información del cargo básico</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SEO_dat_abo" Tipo="estructura"></param>>
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

	LV_des_error    ge_errores_pg.DesEvent;
	LV_sSql		    ge_errores_pg.vQuery;
	error_ejecucion EXCEPTION;

	v_uso_venta          ged_parametros.val_parametro%TYPE;
	v_des_parametro      ged_parametros.des_parametro%TYPE;
	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;

        IF NOT (pv_obtiene_ged_parametros_fn ('USOS_VENTAS', 'GA', v_uso_venta, v_des_parametro, SN_cod_retorno, SV_mens_retorno, SN_num_evento)) THEN
		    RAISE error_ejecucion;
		END IF;

        LV_sSql := 'SELECT cod_uso, des_uso, ind_restplan, ind_cargopro, ind_usoventa, num_dias_hibernacion'
	            || ' FROM al_usos a'
			    || ' WHERE a.ind_usoventa >= '''||v_uso_venta||''''
			    || ' ORDER BY a.des_uso';

        OPEN SC_usos_venta FOR LV_sSql;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 999;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'pv_cambio_serie_sb_pg.pv_rec_usos_ventas_pr('||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CAMBIO_SERIE_SB_PG.pv_rec_usos_ventas_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 999;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'pv_cambio_serie_sb_pg.pv_rec_usos_ventas_pr('||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CAMBIO_SERIE_SB_PG.pv_rec_usos_ventas_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	END pv_rec_usos_ventas_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	PROCEDURE pv_rec_central_hlr_pr (
	  eo_icg_central           IN               ICG_CENTRAL_QT,
	  eo_al_serie              IN               AL_SERIE_QT,
	  SC_icg_central           OUT NOCOPY       refcursor,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento)

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "pv_rec_info_abonado_pr"
	      Lenguaje="PL/SQL"
	      Fecha="18-07-2007"
	      Versión="1.0"
	      Diseñador="Marcelo Godoy'
	      Programador="Marcelo Godoy"
	      Ambiente Desarrollo="BD">
	      <Retorno>SEO_dat_abo</Retorno>>
	      <Descripción>Retorna información del cargo básico</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SEO_dat_abo" Tipo="estructura"></param>>
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

	LV_des_error    ge_errores_pg.DesEvent;
	LV_sSql		    ge_errores_pg.vQuery;
	error_ejecucion EXCEPTION;

	v_uso_venta          ged_parametros.val_parametro%TYPE;
	v_des_parametro      ged_parametros.des_parametro%TYPE;
	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;


          OPEN SC_icg_central  FOR
        SELECT a.cod_central, a.cod_producto, a.nom_central, a.cod_nemotec, a.cod_alm, a.num_maxintentos, a.cod_sistema, a.cod_cobertura, a.tie_respuesta, a.nodocom, a.cod_tecnologia, a.cod_hlr
          FROM icg_central a, ta_subcentral b, al_series c
         WHERE a.cod_producto = cv_prod_celular
		   AND c.num_serie = eo_al_serie.num_serie
           AND b.cod_central = a.cod_central
           AND a.cod_tecnologia = eo_icg_central.cod_tecnologia
           AND a.cod_hlr = c.cod_hlr;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 999;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'pv_cambio_serie_sb_pg.pv_rec_central_hlr_pr('||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CAMBIO_SERIE_SB_PG.pv_rec_central_hlr_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 999;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'pv_cambio_serie_sb_pg.pv_rec_central_hlr_pr('||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CAMBIO_SERIE_SB_PG.pv_rec_central_hlr_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	END pv_rec_central_hlr_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_obtiene_datos_abonado_pr (
      so_abonado        IN OUT NOCOPY   ga_abonado2_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_OBTIENE_DATOS_ABONADO_PR
	      Lenguaje="PL/SQL"
	      Fecha="04-06-2007"
	      Versión="La del package"
	      Diseñador="Matías Guajardo"
	      Programador="Matías Guajardo"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción></Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SO_Abonado" Tipo="estructura">estructura de los datos de un abonado</param>>
	         </Entrada>
	         <Salida>
	            <param nom="SO_Abonado" Tipo="estructura">estructura de los datos de un abonado</param>>
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

        LV_sSql:= LV_sSql||'SELECT a.cod_cliente,b.num_abonado,b.num_celular,b.num_serie,b.num_imei,b.cod_tecnologia,b.cod_situacion,';
        LV_sSql:= LV_sSql||'   d.des_situacion, b.tip_plantarif, DECODE(b.tip_plantarif,''E'',''EMPRESA'', ''I'', ''INDIVIDUAL'') AS des_tipplantarif,';
        LV_sSql:= LV_sSql||'   b.cod_plantarif, c.des_plantarif, b.cod_ciclo, c.cod_limconsumo, e.des_limconsumo, b.cod_planserv, b.cod_uso, c.cod_tiplan,';
        LV_sSql:= LV_sSql||'   DECODE(c.cod_tiplan,''1'',''PREPAGO'', ''2'', ''POSPAGO'', ''3'', ''HIBRIDO'') AS des_tiplan, b.cod_tipcontrato,b.fec_alta,b.fec_fincontra,b.ind_eqprestado,b.fec_prorroga,c.flg_rango,f.imp_cargobasico,';
        LV_sSql:= LV_sSql||'   b.num_anexo, b.cod_usuario, b.tip_terminal, g.des_terminal, b.num_venta';
        LV_sSql:= LV_sSql||' FROM ge_clientes a, ga_abocel b, ta_plantarif c, ga_situabo d, ta_limconsumo e, ta_cargosbasico f al_tipos_terminales g';
        LV_sSql:= LV_sSql||' WHERE b.num_abonado = '||SO_Abonado.num_abonado;
        LV_sSql:= LV_sSql||'   AND a.cod_cliente   = b.cod_cliente';
        LV_sSql:= LV_sSql||'   AND b.cod_plantarif = c.cod_plantarif';
        LV_sSql:= LV_sSql||'   AND b.cod_situacion = d.cod_situacion';
        LV_sSql:= LV_sSql||'   AND e.cod_limconsumo = c.cod_limconsumo';
        LV_sSql:= LV_sSql||'   AND c.cod_cargobasico = f.cod_cargobasico';
        LV_sSql:= LV_sSql||'   AND b.cod_situacion NOT IN (''BAA'',''BAP'')';
        LV_sSql:= LV_sSql||'   AND SYSDATE BETWEEN f.fec_desde AND f.fec_hasta';
        LV_sSql:= LV_sSql||'   AND rownum=1';
        LV_sSql:= LV_sSql||' UNION';
        LV_sSql:= LV_sSql||' SELECT a.cod_cliente, b.num_abonado, b.num_celular, b.num_serie, b.num_imei, b.cod_tecnologia, b.cod_situacion, d.des_situacion,';
        LV_sSql:= LV_sSql||'   b.tip_plantarif, DECODE(b.tip_plantarif,''E'',''EMPRESA'', ''I'', ''INDIVIDUAL'') AS des_tipplantarif, b.cod_plantarif, c.des_plantarif,';
        LV_sSql:= LV_sSql||'   b.cod_ciclo, c.cod_limconsumo, e.des_limconsumo, b.cod_planserv, b.cod_uso, c.cod_tiplan,';
        LV_sSql:= LV_sSql||'   DECODE(c.cod_tiplan,''1'',''PREPAGO'', ''2'', ''POSPAGO'', ''3'', ''HIBRIDO'') AS des_tiplan,';
        LV_sSql:= LV_sSql||'   b.cod_tipcontrato, b.fec_alta, b.fec_fincontra,  null ind_eqprestado, null fec_prorroga, c.flg_rango,';
        LV_sSql:= LV_sSql||'   f.imp_cargobasico, b.num_anexo, b.cod_usuario, b.tip_terminal, g.des_terminal, b.num_venta';
        LV_sSql:= LV_sSql||' FROM ge_clientes a, ga_aboamist b, ta_plantarif c, ga_situabo d, ta_limconsumo e, ta_cargosbasico f, al_tipos_terminales g';
        LV_sSql:= LV_sSql||' WHERE b.num_abonado = '||SO_Abonado.num_abonado;
        LV_sSql:= LV_sSql||'  AND a.cod_cliente   = b.cod_cliente';
        LV_sSql:= LV_sSql||'  AND b.cod_plantarif = c.cod_plantarif';
        LV_sSql:= LV_sSql||'  AND b.cod_situacion = d.cod_situacion';
        LV_sSql:= LV_sSql||'  AND e.cod_limconsumo = c.cod_limconsumo';
        LV_sSql:= LV_sSql||'  AND c.cod_cargobasico = f.cod_cargobasico';
        LV_sSql:= LV_sSql||'  AND b.cod_situacion NOT IN (''BAA'',''BAP'')';
        LV_sSql:= LV_sSql||'  AND SYSDATE BETWEEN f.fec_desde AND f.fec_hasta';
        LV_sSql:= LV_sSql||'  AND rownum=1';


        SELECT a.cod_cliente, b.num_abonado, b.num_celular, b.num_serie, b.num_imei, b.cod_tecnologia, b.cod_situacion,
               d.des_situacion, b.tip_plantarif, DECODE (b.tip_plantarif, 'E', 'EMPRESA', 'I', 'INDIVIDUAL') AS des_tipplantarif,
               b.cod_plantarif, c.des_plantarif, b.cod_ciclo, c.cod_limconsumo, e.des_limconsumo, b.cod_planserv, b.cod_uso, c.cod_tiplan,
               DECODE (c.cod_tiplan, '1', 'PREPAGO', '2', 'POSPAGO', '3', 'HIBRIDO') AS des_tiplan, b.cod_tipcontrato, b.fec_alta,
               b.fec_fincontra, b.ind_eqprestado, b.fec_prorroga, c.flg_rango, f.imp_cargobasico, b.num_anexo, b.cod_usuario, b.tip_terminal,
               g.des_terminal, b.num_venta, b.cod_cuenta, b.cod_subcuenta, b.cod_vendedor, b.cod_causa_venta, b.fec_baja, b.fec_bajacen, b.fec_ultmod,
               b.cod_empresa, b.fec_acepventa, b.num_contrato, b.cod_modventa, b.cod_cargobasico, b.cod_central
          INTO so_abonado.cod_cliente, so_abonado.num_abonado, so_abonado.num_celular, so_abonado.num_serie, so_abonado.num_simcard,
               so_abonado.cod_tecnologia, so_abonado.cod_situacion, so_abonado.des_situacion, so_abonado.tip_plantarif, so_abonado.des_tipplantarif,
               so_abonado.cod_plantarif, so_abonado.des_plantarif, so_abonado.cod_ciclo, so_abonado.cod_limconsumo, so_abonado.des_limconsumo, so_abonado.cod_planserv,
               so_abonado.cod_uso, so_abonado.cod_tiplan, so_abonado.des_tiplan, so_abonado.cod_tipcontrato, so_abonado.fecha_alta, so_abonado.fec_fincontra, so_abonado.ind_eqprestado,
               so_abonado.fecha_prorroga, so_abonado.flg_rango, so_abonado.imp_cargobasico, so_abonado.num_anexo, so_abonado.cod_usuario, so_abonado.tip_terminal, so_abonado.des_terminal, so_abonado.num_venta, so_abonado.cod_cuenta,
               so_abonado.cod_subcuenta, so_abonado.cod_vendedor, so_abonado.cod_causa_venta, so_abonado.fecha_baja, so_abonado.fecha_bajacen, so_abonado.fecha_ultmod, so_abonado.cod_empresa, so_abonado.fecha_acepventa, so_abonado.num_contrato, so_abonado.modalidad_de_pago,
               so_abonado.cod_cargobasico, so_abonado.cod_central
          FROM ge_clientes a, ga_abocel b, ta_plantarif c, ga_situabo d, ta_limconsumo e, ta_cargosbasico f, al_tipos_terminales g
         WHERE b.num_abonado = so_abonado.num_abonado
           AND a.cod_cliente = b.cod_cliente
           AND b.cod_plantarif = c.cod_plantarif
           AND b.cod_situacion = d.cod_situacion
           AND b.tip_terminal = g.tip_terminal
           AND e.cod_limconsumo = c.cod_limconsumo
           AND c.cod_cargobasico = f.cod_cargobasico
           AND b.cod_situacion NOT IN ('BAA', 'BAP')
           AND SYSDATE BETWEEN f.fec_desde AND f.fec_hasta
           AND ROWNUM = 1
        UNION
        SELECT a.cod_cliente, b.num_abonado, b.num_celular, b.num_serie, b.num_imei, b.cod_tecnologia, b.cod_situacion, d.des_situacion, b.tip_plantarif,
               DECODE (b.tip_plantarif, 'E', 'EMPRESA','I', 'INDIVIDUAL') AS des_tipplantarif, b.cod_plantarif, c.des_plantarif, b.cod_ciclo, c.cod_limconsumo,
               e.des_limconsumo, b.cod_planserv, b.cod_uso, c.cod_tiplan, DECODE (c.cod_tiplan,'1', 'PREPAGO','2', 'POSPAGO','3', 'HIBRIDO') AS des_tiplan,
               b.cod_tipcontrato, b.fec_alta, b.fec_fincontra, NULL ind_eqprestado, NULL fec_prorroga, c.flg_rango, f.imp_cargobasico, b.num_anexo, b.cod_usuario, b.tip_terminal, g.des_terminal, b.num_venta,
               b.cod_cuenta, b.cod_subcuenta, b.cod_vendedor, b.cod_causa_venta, b.fec_baja, b.fec_bajacen, b.fec_ultmod, b.cod_empresa, b.fec_acepventa, b.num_contrato, b.cod_modventa, b.cod_cargobasico, b.cod_central
          FROM ge_clientes a, ga_aboamist b, ta_plantarif c, ga_situabo d, ta_limconsumo e, ta_cargosbasico f, al_tipos_terminales g
         WHERE b.num_abonado = so_abonado.num_abonado
           AND a.cod_cliente = b.cod_cliente
           AND b.cod_plantarif = c.cod_plantarif
           AND b.cod_situacion = d.cod_situacion
           AND b.tip_terminal = g.tip_terminal
           AND e.cod_limconsumo = c.cod_limconsumo
           AND c.cod_cargobasico = f.cod_cargobasico
           AND b.cod_situacion NOT IN ('BAA', 'BAP')
           AND SYSDATE BETWEEN f.fec_desde AND f.fec_hasta
           AND ROWNUM = 1;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 203;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := ' PV_OBTIENE_DATOS_ABONADO_PR('||SO_Abonado.num_abonado||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBTIENE_DATOS_ABONADO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	  WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := ' PV_OBTIENE_DATOS_ABONADO_PR('||SO_Abonado.num_abonado||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBTIENE_DATOS_ABONADO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END pv_obtiene_datos_abonado_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION pv_rec_param_val_cuasa_fn (
      eo_ga_caucaser     IN              GA_CAUCASER_QT,
      sn_ind_dev_almacen OUT NOCOPY      ga_caucaser.ind_dev_almacen%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
    )
    /*
    <Documentacion TipoDoc = "Function">
       <Elemento
          Nombre = "pv_rec_param_val_cuasa_fn"
          Fecha modificacion=" "
          Fecha creacion="03-04-2006"
          Programador="Marcelo Godoy S. - Carlos Navarro"
          Diseñador=""
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>
          <Descripcion></Descripcion>
          <Parametros>
             <Entrada>
                <param nom="eo_ga_caucaser" Tipo="NUMERICO">Nombre de tabla</param>
             </Entrada>
             <Salida>
                            <param nom="SN_ind_dev_almacen" Tipo="NUMERICO">Indicador Devolución Almacén</param>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
             </Salida>
          </Parametros>
       </Elemento>
    </Documentacion>
    */
        RETURN BOOLEAN
        IS
            LV_des_error     ge_errores_pg.DesEvent;
            LV_sSql          ge_errores_pg.vQuery;
        BEGIN

            SN_cod_retorno := 0;
            SN_num_evento  := 0;
            SV_mens_retorno:= '';

                LV_sSql:='SELECT ind_dev_almacen FROM ga_caucaser';
                LV_sSql:=LV_sSql||' WHERE cod_producto = '''||cv_prod_celular||'''';
                LV_sSql:=LV_sSql||' AND cod_caucaser = '''||eo_ga_caucaser.cod_caucaser||'''';

        SELECT ind_dev_almacen
                  INTO sn_ind_dev_almacen
                  FROM ga_caucaser
                 WHERE cod_producto = cv_prod_celular
                   AND cod_caucaser = eo_ga_caucaser.cod_caucaser;

        RETURN TRUE;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := '5';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error:= 'pv_cambio_simcard_sb_pg.pv_rec_param_val_cuasa_fn; - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_cambio_simcard_sb_pg.pv_rec_param_val_cuasa_fn', LV_sSql, SQLCODE, LV_des_error);
       RETURN FALSE;

    WHEN OTHERS THEN
       SN_cod_retorno := '6';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error:= 'pv_cambio_simcard_sb_pg.pv_rec_param_val_cuasa_fn; - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento,CV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_cambio_simcard_sb_pg.pv_rec_param_val_cuasa_fn', LV_sSql, SQLCODE, LV_des_error);
       RETURN FALSE;

    END pv_rec_param_val_cuasa_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION pv_rec_cod_antiguedad_fn (
      ed_fec_alta        IN              ga_equipaboser.fec_alta%TYPE,
      sn_cod_antiguedad  OUT NOCOPY      gat_opciones_equipos.cod_antiguedad%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
    )
    /*
    <Documentacion TipoDoc = "Function">
       <Elemento
          Nombre = "pv_rec_cod_antiguedad_fn"
          Fecha modificacion=" "
          Fecha creacion="03-04-2006"
          Programador="Marcelo Godoy S. - Carlos Navarro"
          Diseñador=""
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>
          <Descripcion></Descripcion>
          <Parametros>
             <Entrada>
                <param nom="ed_fec_alta" Tipo="DATE">Fecha Alta</param>
             </Entrada>
             <Salida>
                            <param nom="sn_cod_antiguedad" Tipo="NUMERICO">Antiguedad</param>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
             </Salida>
          </Parametros>
       </Elemento>
    </Documentacion>
    */
        RETURN BOOLEAN
        IS
            LV_des_error       ge_errores_pg.DesEvent;
            LV_sSql            ge_errores_pg.vQuery;
                LN_cod_antiguedad  gat_opciones_equipos.cod_antiguedad%TYPE;
                lv_ind_politica    ged_parametros.val_parametro%TYPE;
                lv_descripcion     ged_parametros.des_parametro%TYPE;
        BEGIN

            SN_cod_retorno := 0;
            SN_num_evento  := 0;
            SV_mens_retorno:= '';

                IF pv_cambio_serie_sb_pg.pv_obtiene_ged_parametros_fn ('SW_POLITICA_SIMCARD',cv_cod_modulo_ga,lv_ind_politica,lv_descripcion,sn_cod_retorno,sv_mens_retorno, sn_num_evento) THEN
                        IF lv_ind_politica = '1' THEN
                LN_cod_antiguedad := TRUNC(MONTHS_BETWEEN(TRUNC(SYSDATE),ed_fec_alta));
                SELECT cod_rango
                                INTO sn_cod_antiguedad
                                FROM gad_rangos_antiguedad
                                WHERE cod_tiprango = 'M'
                                AND LN_cod_antiguedad BETWEEN ran_desde AND ran_hasta;
            ELSE
                LN_cod_antiguedad := 0;
                SELECT cod_rango
                                INTO sn_cod_antiguedad
                                FROM gad_rangos_antiguedad
                                WHERE cod_tiprango = 'M'
                                AND LN_cod_antiguedad BETWEEN ran_desde AND ran_hasta;
            END IF;
                END IF;

        RETURN TRUE;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := '5';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error:= 'pv_cambio_simcard_sb_pg.pv_rec_cod_antiguedad_fn; - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_cambio_simcard_sb_pg.pv_rec_cod_antiguedad_fn', LV_sSql, SQLCODE, LV_des_error);
       RETURN FALSE;

    WHEN OTHERS THEN
       SN_cod_retorno := '6';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error:= 'pv_cambio_simcard_sb_pg.pv_rec_cod_antiguedad_fn; - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento,CV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_cambio_simcard_sb_pg.pv_rec_cod_antiguedad_fn', LV_sSql, SQLCODE, LV_des_error);
       RETURN FALSE;

    END pv_rec_cod_antiguedad_fn;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION pv_verifica_plan_comercial_fn (
      eo_sesion          IN              GE_SESION_QT,
      eo_caucaser        IN              GA_CAUCASER_QT,
      eo_modventa        IN              GE_MODVENTA_QT,
      eo_uso             IN              AL_USO_QT,
      eo_tip_terminal    IN				 AL_TIPOS_TERMINALES_QT,
      eo_al_serie        IN              AL_SERIE_QT,
	  eo_dat_abo         IN 			 PV_DATOS_ABO_QT,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
    )
    /*
    <Documentacion TipoDoc = "Function">
       <Elemento
          Nombre = "pv_verifica_plan_comercial_fn"
          Fecha modificacion=" "
          Fecha creacion="07-11-2007"
          Programador=CAGV
          Diseñador=""
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>
          <Descripcion></Descripcion>
          <Parametros>
             <Entrada>

             </Entrada>
             <Salida>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
             </Salida>
          </Parametros>
       </Elemento>
    </Documentacion>
    */
        RETURN BOOLEAN
        IS
            LV_des_error       ge_errores_pg.DesEvent;
            LV_sSql            ge_errores_pg.vQuery;
                LN_contador                NUMBER;
                Ln_ind_dev_almacen NUMBER;
                LN_Ind_Recambio    NUMBER;
                lc_plan_comercial  refcursor;
                lv_cod_operacion   ga_actabo.cod_actabo%TYPE:='CE';
                lv_Ind_Causa       ged_parametros.val_parametro%TYPE;
                LV_descripcion     ged_parametros.des_parametro%TYPE;
                LN_cod_antiguedad  gat_opciones_equipos.cod_antiguedad%TYPE;
				O_dat_abo          PV_DATOS_ABO_QT := NEW PV_DATOS_ABO_QT;
                o_tipcontrato      GA_TIPCONTRATO_QT  := NEW GA_TIPCONTRATO_QT;
                error_ejecucion    EXCEPTION ;
                o_catplantarif     VE_CATPLANTARIF_QT := NEW VE_CATPLANTARIF_QT;
				lvCodArticulo	   al_series.cod_articulo%TYPE;
        BEGIN

            SN_cod_retorno := 0;
            SN_num_evento  := 0;
            SV_mens_retorno:= '';

                O_dat_abo.num_abonado := eo_sesion.num_abonado;

	            pv_cambio_serie_sb_pg.pv_rec_info_abonado_pr (O_dat_abo ,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                IF SN_cod_retorno <> 0 THEN
                    RAISE error_ejecucion;
                END IF;

                o_tipcontrato.cod_tipcontrato  := eo_dat_abo.cod_tipcontrato;
        		IF NOT (pv_cambio_serie_sb_pg.pv_rec_tipo_contrato_fn (o_tipcontrato,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
                    RAISE error_ejecucion;
                END IF;

                IF NOT pv_cambio_serie_sb_pg.pv_obtiene_ged_parametros_fn (lv_cod_operacion,cv_cod_modulo_ga,lv_Ind_Causa,LV_descripcion,sn_cod_retorno,sv_mens_retorno, sn_num_evento) THEN
                     RAISE error_ejecucion;
                END IF;

                IF NOT (pv_rec_param_val_cuasa_fn (eo_caucaser, ln_ind_dev_almacen, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
                   RAISE error_ejecucion;
                END IF;

                IF ln_ind_dev_almacen = 1 THEN
                    LN_Ind_Recambio:=1;
                ELSE
                        LN_Ind_Recambio:=0;
                END IF;

                IF NOT (pv_rec_cod_antiguedad_fn (O_dat_abo.fec_alta, ln_cod_antiguedad, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
                   RAISE error_ejecucion;
                END IF;

                o_catplantarif.cod_plantarif := O_dat_abo.cod_plantarif;
                IF NOT (pv_cambio_serie_sb_pg.pv_rec_cat_plan_tarif_fn (o_catplantarif,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
                    RAISE error_ejecucion;
                END IF;

                LV_sSql:= 'SELECT cod_articulo';
                LV_sSql:= LV_sSql || ' FROM al_series ';
                LV_sSql:= LV_sSql || ' WHERE num_serie = ' || eo_al_serie.num_serie;

				SELECT cod_articulo
				INTO lvCodArticulo
				FROM al_series
				WHERE num_serie = eo_al_serie.num_serie;
                
                IF eo_uso.cod_uso=3 THEN 
                   o_catplantarif.cod_categoria:=cv_categoria_lista;
                END IF;   

                LV_sSql:= 'SELECT COUNT(1)';
                LV_sSql:= LV_sSql || 'FROM AL_TIPOS_STOCK B, AL_ARTICULOS C, AL_SERIES A, AL_TECNOARTICULO_TD D';
                LV_sSql:= LV_sSql || ' WHERE A.COD_USO = ' || eo_uso.cod_uso;
                LV_sSql:= LV_sSql || ' AND C.TIP_TERMINAL =''' || eo_tip_terminal.Tip_Terminal || '''';
                LV_sSql:= LV_sSql || ' AND A.COD_PRODUCTO =' || cv_prod_celular;
                If Trim(O_dat_abo.num_serie) IS NOT NULL Then
                   LV_sSql:= LV_sSql || ' AND A.NUM_SERIE= ''' || eo_al_serie.num_serie || '''';
                End If;
                LV_sSql:= LV_sSql || ' AND A.NUM_TELEFONO IS NULL';
                LV_sSql:= LV_sSql || ' AND A.COD_ARTICULO = C.COD_ARTICULO';
                LV_sSql:= LV_sSql || ' AND B.TIP_STOCK = A.TIP_STOCK ';
                LV_sSql:= LV_sSql || ' AND A.COD_ARTICULO = D.COD_ARTICULO';
                LV_sSql:= LV_sSql || ' AND D.COD_TECNOLOGIA = ''GSM''';
                LV_sSql:= LV_sSql || ' AND A.COD_ARTICULO IN(SELECT D.COD_ARTICULO FROM GAT_OPCIONES_EQUIPOS D ';
                LV_sSql:= LV_sSql || ' WHERE D.COD_TIPCONTRATO = ''' || eo_dat_abo.cod_tipcontrato || '''';
                LV_sSql:= LV_sSql || ' AND D.NUM_MESES = ' || o_tipcontrato.meses_minimo;
                LV_sSql:= LV_sSql || ' AND D.COD_OPERACION = ''' || lv_cod_operacion || '''';
                LV_sSql:= LV_sSql || ' AND D.IND_CAUSA = ' || lv_Ind_Causa;
                If lv_Ind_Causa <> '0' And Trim(eo_caucaser.cod_caucaser) <> '' Then
                   LV_sSql:= LV_sSql || ' AND D.COD_CAUSA = ' || eo_caucaser.cod_caucaser;
                End If;
                LV_sSql:= LV_sSql || ' AND D.COD_CATEGORIA = ''' || o_catplantarif.cod_categoria || '''';
                LV_sSql:= LV_sSql || ' AND D.COD_MODPAGO = ' || eo_modventa.cod_modventa;
                If (LN_Ind_Recambio <> 1 ) Then
	                IF NOT pv_cambio_serie_sb_pg.pv_valida_permisos_fn(eo_sesion.nom_usuario,eo_sesion.cod_programa,eo_sesion.num_version,'COD_PROC_INDGMC',sn_cod_retorno,sv_mens_retorno, sn_num_evento) THEN
	                   LV_sSql:= LV_sSql || ' AND D.COD_ANTIGUEDAD = ' || ln_cod_antiguedad;
	                END IF;
                End If;
                LV_sSql:= LV_sSql || ' AND SYSDATE BETWEEN D.FEC_DESDE AND D.FEC_HASTA ';
                LV_sSql:= LV_sSql || ' AND A.COD_ARTICULO = D.COD_ARTICULO)';

                OPEN lc_plan_comercial for LV_sSql;
            FETCH lc_plan_comercial INTO LN_contador;

                IF LN_contador <> 0 THEN
                        RETURN TRUE;
                ELSE
                     SN_cod_retorno  := 358;
                         SV_mens_retorno := 'Serie no es aplicable al plan comercial (Opciones de Equipo)';
                         SV_mens_retorno := SV_mens_retorno || ' |Producto:1';
                         SV_mens_retorno := SV_mens_retorno || ' |Artículo:' || lvCodArticulo;
                         SV_mens_retorno := SV_mens_retorno || ' |Cod. Uso:' || eo_uso.cod_uso;
                         SV_mens_retorno := SV_mens_retorno || ' |Tipo Terminal:' || eo_tip_terminal.Tip_Terminal;
                         SV_mens_retorno := SV_mens_retorno || ' |Tipo Contrato:' || eo_dat_abo.cod_tipcontrato;
                         SV_mens_retorno := SV_mens_retorno || ' |Meses:' || o_tipcontrato.meses_minimo;
                         SV_mens_retorno := SV_mens_retorno || ' |Cod. Operación:' || lv_cod_operacion;
                         SV_mens_retorno := SV_mens_retorno || ' |Ind. Causa:' || lv_Ind_Causa;
                         SV_mens_retorno := SV_mens_retorno || ' |Cod. Causa:' || eo_caucaser.cod_caucaser;
                         SV_mens_retorno := SV_mens_retorno || ' |Categoría:' || o_catplantarif.cod_categoria;
                         SV_mens_retorno := SV_mens_retorno || ' |Mod. Venta:' || eo_modventa.cod_modventa;
                         SV_mens_retorno := SV_mens_retorno || ' |Cod. Antiguedad:' || ln_cod_antiguedad;
                         SV_mens_retorno := SV_mens_retorno || ' |FAVOR CONFIRMAR OPERACIÓN A REALIZAR';
                         SV_mens_retorno := SV_mens_retorno || ' |CON POLÍTICA DE RECAMBIO ACTUAL.';
                        RAISE error_ejecucion;
                END IF;

        EXCEPTION
        WHEN error_ejecucion THEN
           LV_des_error  := 'pv_cambio_simcard_sb_pg.pv_verifica_plan_comercial_fn('||'); - ' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'pv_cambio_simcard_sb_pg.pv_verifica_plan_comercial_fn', LV_sSql, SN_cod_retorno, LV_des_error);
           RETURN FALSE;

        WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := '5';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error:= 'pv_cambio_simcard_sb_pg.pv_verifica_plan_comercial_fn; - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_cambio_simcard_sb_pg.pv_verifica_plan_comercial_fn', LV_sSql, SQLCODE, LV_des_error);
       RETURN FALSE;

    WHEN OTHERS THEN
       SN_cod_retorno := '6';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error:= 'pv_cambio_simcard_sb_pg.pv_verifica_plan_comercial_fn; - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_cambio_simcard_sb_pg.pv_verifica_plan_comercial_fn', LV_sSql, SQLCODE, LV_des_error);
       RETURN FALSE;

    END pv_verifica_plan_comercial_fn;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_cnslta_centrls_pr(EN_cod_producto        IN icg_central.cod_producto%TYPE,
		  					   EV_cod_tecnologia	  IN icg_central.cod_tecnologia%TYPE,
							   EV_cod_hlr			  IN icg_central.cod_hlr%TYPE,
							   SC_central        	  OUT NOCOPY RefCursor,
						       SN_cod_retorno    	  OUT NOCOPY ge_errores_pg.CodError,
               		           SV_mens_retorno   	  OUT NOCOPY ge_errores_pg.MsgError,
               		           SN_num_evento     	  OUT NOCOPY ge_errores_pg.Evento)

/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "pv_cnslta_centrls_pr"
Lenguaje="PL/SQL"
Fecha="07-05-2008"
Versión="1.0.0"
Diseñador="Patricio Gallegos"
Programador="Patricio Gallegos"
Ambiente="BD">
<Retorno> </Retorno>
<Descripción> Consulta lista de centrales disponibles para un determinado HLR </Descripción>
<Parámetros>
	<Entrada>
		<param nom="EN_cod_producto"  Tipo="NUMBER"> </param>
		<param nom="EV_cod_tecnologia"  Tipo="VARCHAR2"> </param>
		<param nom="EV_cod_hlr"  Tipo="VARCHAR2"> </param>
	</Entrada>
	<Salida>
		<param nom="SC_central"  Tipo="RefCursor"> </param>
		<param nom="SN_cod_retorno"    Tipo="NUMBER"> codigo retorno </param>
		<param nom="SV_mens_retorno"   Tipo="STRING"> glosa mensaje error </param>
		<param nom="SN_num_evento"     Tipo="NUMBER"> numero de evento </param>
	</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
 IS

LV_des_error         	  GE_ERRORES_PG.DesEvent;
sSql                 	  GE_ERRORES_PG.vQuery;

BEGIN

	sSql := 'SELECT a.cod_central, a.nom_central  		a.cod_hlr  , a.cod_sistema';
	sSql := sSql || ' FROM icg_central a, ta_subcentral b';
	sSql := sSql || ' WHERE a.cod_producto = ' || EN_cod_producto;
	sSql := sSql || ' AND b.cod_central = a.cod_central';
	sSql := sSql || ' AND a.cod_tecnologia = ' || EV_cod_tecnologia;
	sSql := sSql || ' AND a.cod_hlr = ' || EV_cod_hlr;

	  OPEN SC_central FOR
	  SELECT a.cod_central, a.nom_central ||'       '|| a.cod_hlr  , a.cod_sistema
	  FROM icg_central a, ta_subcentral b
      WHERE a.cod_producto = EN_cod_producto
      AND b.cod_central = a.cod_central
      AND a.cod_tecnologia = EV_cod_tecnologia
      AND a.cod_hlr = EV_cod_hlr;

	SN_cod_retorno := 0;
	SV_mens_retorno := 'OK';
	SN_num_evento := 0;

EXCEPTION
WHEN OTHERS THEN
	 	SN_cod_retorno := 4;
	 	SV_mens_retorno := 'pv_cnslta_centrls_pr.';
		LV_des_error := SQLERRM;
		SN_num_evento:= Ge_Errores_Pg.Grabarpl( 0, 'PV', SV_mens_retorno, '1.0', USER,
		'pv_cnslta_centrls_pr', sSql, SQLCODE, LV_des_error );
END pv_cnslta_centrls_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_valida_serie_externa_PR(EN_cod_producto        IN ged_parametros.cod_producto%TYPE,
		  				    EV_num_serie	 IN al_series.num_serie%TYPE,
		  					EV_tip_terminal	 	 	 IN ga_abocel.tip_terminal%TYPE,
							SN_cod_retorno    	   	 OUT NOCOPY ge_errores_pg.CodError,
	                       	SV_mens_retorno   	   	 OUT NOCOPY ge_errores_pg.MsgError,
	                       	SN_num_evento     	   	 OUT NOCOPY ge_errores_pg.Evento)
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "PV_valida_serie_externa_PR"
Lenguaje="PL/SQL"
Fecha="07-05-2008"
Versión="1.0.0"
Diseñador="Patricio Gallegos"
Programador="Patricio Gallegos"
Ambiente="BD">
<Retorno> </Retorno>
<Descripción> Valida una serie externa </Descripción>
<Parámetros>
	<Entrada>
		<param nom="EV_num_serie"  Tipo="VARCHAR2"> </param>
		<param nom="EV_tip_terminal"  Tipo="VARCHAR2"> </param>
	</Entrada>
	<Salida>
		<param nom="SC_central"  Tipo="RefCursor"> </param>
		<param nom="SN_cod_retorno"    Tipo="NUMBER"> codigo retorno </param>
		<param nom="SV_mens_retorno"   Tipo="STRING"> glosa mensaje error </param>
		<param nom="SN_num_evento"     Tipo="NUMBER"> numero de evento </param>
	</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
									 IS

LV_des_error         	  GE_ERRORES_PG.DesEvent;
sSql                 	  GE_ERRORES_PG.vQuery;
fin_ejecucion			  EXCEPTION;
LV_num_extra			  al_ser_es_extras.num_extra%TYPE;
LV_TermEqGsm			  ged_parametros.val_parametro%TYPE;

BEGIN

	SELECT b.val_parametro
	INTO LV_TermEqGsm
	FROM ged_parametros b
	WHERE b.nom_parametro = 'COD_TERMINAL_GSM'
	AND b.cod_producto = EN_cod_producto
	AND b.cod_modulo='AL';

	BEGIN

		sSql := 'SELECT 1 INTO SN_cod_retorno';
		sSql := sSql || ' FROM al_series';
		sSql := sSql || ' WHERE num_serie = ' || EV_num_serie;

		SELECT 1 INTO SN_cod_retorno
		FROM al_series
		WHERE num_serie = EV_num_serie;

		SV_mens_retorno := 'La serie ' || EV_num_serie || ' existe en bodega.';
		RAISE fin_ejecucion;

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			 NULL;
	END;

	BEGIN

		sSql := 'SELECT 2 INTO SN_cod_retorno';
		sSql := sSql || ' FROM al_fic_series';
		sSql := sSql || ' WHERE num_serie = ' || EV_num_serie;

		SELECT 2 INTO SN_cod_retorno
		FROM al_fic_series
		WHERE num_serie = EV_num_serie;

		SV_mens_retorno := 'La serie ' || EV_num_serie || ' está en proceso de aceptación de bodega.';
		RAISE fin_ejecucion;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			 NULL;
	END;

	BEGIN

        sSql := 'SELECT 3 INTO SN_cod_retorno';
		sSql := sSql || ' FROM al_series_ordenes2 a,al_cabecera_ordenes2 b';
        sSql := sSql || ' WHERE a.num_serie = EV_num_serie';
        sSql := sSql || ' AND a.num_orden = b.num_orden AND b.cod_estado = ''NU''';

        SELECT 3 INTO SN_cod_retorno
		FROM al_series_ordenes2 a,al_cabecera_ordenes2 b
        WHERE a.num_serie = EV_num_serie
        AND a.num_orden = b.num_orden AND b.cod_estado = 'NU';

		SV_mens_retorno := 'La serie ' || EV_num_serie || ' está en proceso de ingreso (2).';
		RAISE fin_ejecucion;

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			 NULL;
	END;

	BEGIN

        sSql := 'SELECT 5 INTO SN_cod_retorno';
		sSql := sSql || ' FROM al_series_ordenes3 a,al_cabecera_ordenes3 b';
        sSql := sSql || ' WHERE a.num_serie = ' || EV_num_serie;
        sSql := sSql || ' AND a.num_orden = b.num_orden AND b.cod_estado = ''NU''';

        SELECT 5 INTO SN_cod_retorno
		FROM al_series_ordenes3 a,al_cabecera_ordenes3 b
        WHERE a.num_serie = EV_num_serie
        AND a.num_orden = b.num_orden AND b.cod_estado = 'NU';

		SV_mens_retorno := 'La serie ' || EV_num_serie || ' está en proceso de ingreso (3).';
		RAISE fin_ejecucion;

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			 NULL;
	END;

	BEGIN

		sSql := 'SELECT num_extra INTO LV_num_extra';
		sSql := sSql || ' FROM al_ser_es_extras';
		sSql := sSql || ' WHERE num_serie = ' || EV_num_serie;

		SELECT num_extra INTO LV_num_extra
		FROM al_ser_es_extras
		WHERE num_serie = EV_num_serie;

		sSql := 'SELECT 6 INTO SN_cod_retorno';
		sSql := sSql || ' FROM al_cab_es_extras';
		sSql := sSql || ' WHERE num_extra = ' || LV_num_extra;

		SELECT 6 INTO SN_cod_retorno
		FROM al_cab_es_extras
		WHERE num_extra = LV_num_extra;

		SV_mens_retorno := 'La serie ' || EV_num_serie || ' está en proceso de entrada/salida extra.';
		RAISE fin_ejecucion;

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			 NULL;
	END;

	BEGIN

		sSql := 'SELECT 7 INTO SN_cod_retorno';
		sSql := sSql || ' FROM al_series_anomalias';
		sSql := sSql || ' WHERE num_serie = ' || EV_num_serie;

		SELECT 7 INTO SN_cod_retorno
		FROM al_series_anomalias
		WHERE num_serie = EV_num_serie;

		SV_mens_retorno := 'La serie ' || EV_num_serie || ' está en anomalía de ingreso.';
		RAISE fin_ejecucion;

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			 NULL;
	END;

	BEGIN

		 IF EV_tip_terminal = LV_TermEqGsm THEN

			sSql := 'SELECT 8 INTO SN_cod_retorno';
			sSql := sSql || ' FROM ga_abocel';
			sSql := sSql || ' WHERE num_imei = ' || EV_num_serie;
			sSql := sSql || ' AND cod_situacion NOT IN (''BAA'',''BAP'') AND ROWNUM=1';

			SELECT 8 INTO SN_cod_retorno
			FROM ga_abocel
			WHERE num_imei = EV_num_serie
			AND cod_situacion NOT IN ('BAA','BAP')
            AND ROWNUM=1;

		 ELSE

		 	sSql := 'SELECT 8 INTO SN_cod_retorno';
			sSql := sSql || ' FROM ga_abocel';
			sSql := sSql || ' WHERE num_serie = ' || EV_num_serie;
			sSql := sSql || ' AND cod_situacion NOT IN (''BAA'',''BAP'') AND ROWNUM=1';

		 	SELECT 8 INTO SN_cod_retorno
			FROM ga_abocel
			WHERE num_serie = EV_num_serie
			AND cod_situacion NOT IN ('BAA','BAP')
            AND ROWNUM=1;

		 END IF;

		SV_mens_retorno := 'La serie ' || EV_num_serie || ' está ocupada por otro abonado (postpago).';
		RAISE fin_ejecucion;

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			 NULL;
	END;

	BEGIN

		 IF EV_tip_terminal = LV_TermEqGsm THEN

			sSql := 'SELECT 9 INTO SN_cod_retorno';
			sSql := sSql || ' FROM ga_aboamist';
			sSql := sSql || ' WHERE num_imei = ' || EV_num_serie;
			sSql := sSql || ' AND cod_situacion NOT IN (''BAA'',''BAP'') AND ROWNUM=1';

			SELECT 9 INTO SN_cod_retorno
			FROM ga_aboamist
			WHERE num_imei = EV_num_serie
			AND cod_situacion NOT IN ('BAA','BAP')
            AND ROWNUM=1;

		 ELSE

		 	sSql := 'SELECT 9 INTO SN_cod_retorno';
			sSql := sSql || ' FROM ga_aboamist';
			sSql := sSql || ' WHERE num_serie = ' || EV_num_serie;
			sSql := sSql || ' AND cod_situacion NOT IN (''BAA'',''BAP'') AND ROWNUM=1';

		 	SELECT 9 INTO SN_cod_retorno
			FROM ga_aboamist
			WHERE num_serie = EV_num_serie
			AND cod_situacion NOT IN ('BAA','BAP')
            AND ROWNUM=1;

		 END IF;

		SV_mens_retorno := 'La serie ' || EV_num_serie || ' está ocupada por otro abonado (prepago).';
		RAISE fin_ejecucion;

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			 NULL;
	END;

	BEGIN

		 sSql := 'SELECT 10 INTO SN_cod_retorno';
		 sSql := sSql || ' FROM ga_reservfol';
		 sSql := sSql || ' WHERE num_serie = ' || EV_num_serie;

		 SELECT 10 INTO SN_cod_retorno
		 FROM ga_reservfol
		 WHERE num_serie = EV_num_serie;

		 SV_mens_retorno := 'La serie ' || EV_num_serie || ' corresponde a venta con un equipo interno.';
		RAISE fin_ejecucion;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			 NULL;
	END;

	SN_cod_retorno := 0;
	SV_mens_retorno := 'OK';
	SN_num_evento := 0;

EXCEPTION
WHEN fin_ejecucion THEN
	 NULL;
WHEN OTHERS THEN
	 	SN_cod_retorno := 4;
	 	SV_mens_retorno := 'Error en ejecución PL-SQL PV_valida_serie_externa_PR.';
		LV_des_error := SQLERRM;
		SN_num_evento:= Ge_Errores_Pg.Grabarpl( 0, 'PV', SV_mens_retorno, '1.0', USER,
		'PV_valida_serie_externa_PR', sSql, SQLCODE, LV_des_error );
END PV_valida_serie_externa_PR;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_cnslta_usos_PR(EN_cod_producto			 IN ga_caucaser.cod_producto%TYPE,
		  					SC_usos				 	 OUT NOCOPY RefCursor,
							SN_cod_retorno    	   	 OUT NOCOPY ge_errores_pg.CodError,
	                       	SV_mens_retorno   	   	 OUT NOCOPY ge_errores_pg.MsgError,
	                       	SN_num_evento     	   	 OUT NOCOPY ge_errores_pg.Evento
									 ) IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "PV_cnslta_usos_PR"
Lenguaje="PL/SQL"
Fecha="07-05-2008"
Versión="1.0.0"
Diseñador="Patricio Gallegos"
Programador="Patricio Gallegos"
Ambiente="BD">
<Retorno> </Retorno>
<Descripción> Consulta lista de usos disponibles </Descripción>
<Parámetros>
	<Entrada>
		<param nom="EN_cod_producto"  Tipo="NUMBER"> </param>
	</Entrada>
	<Salida>
		<param nom="SC_usos"  Tipo="RefCursor"> </param>
		<param nom="SN_cod_retorno"    Tipo="NUMBER"> codigo retorno </param>
		<param nom="SV_mens_retorno"   Tipo="STRING"> glosa mensaje error </param>
		<param nom="SN_num_evento"     Tipo="NUMBER"> numero de evento </param>
	</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
LV_des_error         	  GE_ERRORES_PG.DesEvent;
sSql                 	  GE_ERRORES_PG.vQuery;

BEGIN

	 sSql := 'SELECT cod_uso,des_uso,ind_restplan,ind_cargopro,ind_usoventa,num_dias_hibernacion';
	 sSql := sSql || ' FROM al_usos a ';
	 sSql := sSql || ' WHERE a.ind_usoventa >= (SELECT b.val_parametro';
	 sSql := sSql || ' 	   				  	  FROM ged_parametros b ';
	 sSql := sSql || ' 						  WHERE b.nom_parametro = ''USOS_VENTAS''';
	 sSql := sSql || ' 						  AND b.cod_producto = ' || EN_cod_producto;
	 sSql := sSql || ' 						  AND b.cod_modulo=''GA'')';
	 sSql := sSql || ' ORDER BY a.des_uso';


	 OPEN SC_usos FOR
	 SELECT cod_uso,des_uso,ind_restplan,ind_cargopro,ind_usoventa,num_dias_hibernacion
	 FROM al_usos a
	 WHERE a.ind_usoventa >= (SELECT b.val_parametro
	 	   				  	  FROM ged_parametros b
							  WHERE b.nom_parametro = 'USOS_VENTAS'
							  AND b.cod_producto = EN_cod_producto
							  AND b.cod_modulo='GA')
	 ORDER BY a.des_uso;

	SN_cod_retorno := 0;
	SV_mens_retorno := 'OK';
	SN_num_evento := 0;

EXCEPTION
WHEN OTHERS THEN
	 	SN_cod_retorno := 4;
	 	SV_mens_retorno := 'Error en ejecución PL-SQL PV_cnslta_usos_PR.';
		LV_des_error := SQLERRM;
		SN_num_evento:= Ge_Errores_Pg.Grabarpl( 0, 'PV', SV_mens_retorno, '1.0', USER,
		'PV_cnslta_usos_PR', sSql, SQLCODE, LV_des_error );
END PV_cnslta_usos_PR;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_cnslta_articulos_PR(EN_cod_producto	 IN al_articulos.cod_producto%TYPE,
		  					EV_tip_terminal			 IN al_articulos.tip_terminal%TYPE,
		  					SC_articulos		 	 OUT NOCOPY RefCursor,
							SN_cod_retorno    	   	 OUT NOCOPY ge_errores_pg.CodError,
	                       	SV_mens_retorno   	   	 OUT NOCOPY ge_errores_pg.MsgError,
	                       	SN_num_evento     	   	 OUT NOCOPY ge_errores_pg.Evento
									 ) IS

LV_des_error         	  GE_ERRORES_PG.DesEvent;
sSql                 	  GE_ERRORES_PG.vQuery;

BEGIN

	sSql := ' SELECT a.cod_articulo, a.des_articulo, a.mes_garantia, a.cod_modelo, b.cod_fabricante, b.des_fabricante';
	sSql := sSql || ' al_articulos a, al_fabricantes b';
	sSql := sSql || ' WHERE AND a.cod_fabricante = b.cod_fabricante';
	sSql := sSql || ' cod_producto = ' || EN_cod_producto;
	sSql := sSql || ' AND ind_equiacc = ''E''';
	sSql := sSql || ' AND tip_terminal = ' || EV_tip_terminal;

	OPEN SC_articulos FOR
	SELECT a.cod_articulo, a.des_articulo, a.mes_garantia, a.cod_modelo, b.cod_fabricante, b.des_fabricante
	FROM al_articulos a, al_fabricantes b
	WHERE a.cod_fabricante = b.cod_fabricante
	AND a.cod_producto = EN_cod_producto
	AND a.ind_equiacc = 'E'
	AND a.tip_terminal = EV_tip_terminal;

	SN_cod_retorno := 0;
	SV_mens_retorno := 'OK';
	SN_num_evento := 0;

EXCEPTION
WHEN OTHERS THEN
	 	SN_cod_retorno := 4;
	 	SV_mens_retorno := 'Error en ejecución PL-SQL PV_cnslta_articulos_PR.';
		LV_des_error := SQLERRM;
		SN_num_evento:= Ge_Errores_Pg.Grabarpl( 0, 'PV', SV_mens_retorno, '1.0', USER,
		'PV_cnslta_articulos_PR', sSql, SQLCODE, LV_des_error );
END PV_cnslta_articulos_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION pv_valida_promocion_fn (
      en_num_abonado     IN              ga_equipaboser.num_abonado%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
    )
    /*
    <Documentacion TipoDoc = "Function">
       <Elemento
          Nombre = "pv_valida_plazo_garantia_fn"
          Fecha modificacion=" "
          Fecha creacion="07-11-2007"
          Programador=CAGV
          Diseñador=""
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>
          <Descripcion></Descripcion>
          <Parametros>
             <Entrada>
                <param nom="EN_num_abonado" Tipo="NUMERICO">Número Abonado</param>
             </Entrada>
             <Salida>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
             </Salida>
          </Parametros>
       </Elemento>
    </Documentacion>
    */
        RETURN BOOLEAN
        IS
            LV_des_error     ge_errores_pg.DesEvent;
            LV_sSql          ge_errores_pg.vQuery;
                ln_contador              NUMBER;
                lv_Tip_Terminal  ga_abocel.Tip_Terminal%TYPE;
                ln_num_celular   ga_abocel.num_celular%TYPE;
                ln_Ind_Supertel  ga_abocel.Ind_Supertel%TYPE;
        BEGIN

            SN_cod_retorno := 0;
            SN_num_evento  := 0;
            SV_mens_retorno:= '';

                SELECT Tip_Terminal, num_celular,Ind_Supertel
                INTO lv_Tip_Terminal,ln_num_celular,ln_Ind_Supertel
                FROM ga_abocel
                WHERE NUM_ABONADO = en_num_abonado;

                IF lv_Tip_Terminal = 'A' THEN
                        SELECT COUNT(1)
                        INTO ln_contador
                        FROM CI_PROMOCION_ANALOGOS
                        WHERE NUM_CELULAR = ln_num_celular
                        AND   IND_PROMOCION = 'A';

                        IF ln_contador <> 0 THEN
                           IF ln_Ind_Supertel = '1' THEN
                                  RETURN FALSE;
                           ELSE
                                   RETURN TRUE;
                           END IF;
                        ELSE
                                RETURN FALSE;
                        END IF;
                ELSE
                        RETURN FALSE;
                END IF;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
       RETURN FALSE;

    WHEN OTHERS THEN
       SN_cod_retorno := '6';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error:= 'pv_cambio_simcard_sb_pg.pv_valida_promocion_fn; - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_cambio_simcard_sb_pg.pv_valida_promocion_fn', LV_sSql, SQLCODE, LV_des_error);
       RETURN FALSE;

    END pv_valida_promocion_fn;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_rec_prec_equipo_actual_PR(EN_numSerie	        IN al_series.num_serie%TYPE,
		  							   SN_impCargo			OUT NOCOPY ge_cargos.imp_cargo%TYPE,
		  							   SN_valDTO			OUT NOCOPY ge_cargos.val_dto%TYPE,
		  							   SN_tipDTO			OUT NOCOPY ge_cargos.tip_dto%TYPE,
									   SN_cod_retorno		OUT NOCOPY ge_errores_pg.CodError,
				                       SV_mens_retorno   	OUT NOCOPY ge_errores_pg.MsgError,
				                       SN_num_evento     	OUT NOCOPY ge_errores_pg.Evento)
    /*
    <Documentacion TipoDoc = "Función">
       <Elemento
          Nombre = "PV_rec_prec_equipo_actual_PR"
          Fecha modificacion=" "
          Fecha creacion="07/07/2008"
          Programador="Joan Zamorano"
          Diseñador="Joan Zamorano"
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>
          <Descripcion>Permite recuperar el precio del equipo actual del abonado</Descripcion>
          <Parametros>
             <Entrada>
				<param nom="EN_numSerie" Tipo="NUMERICO">Número de serie del equipo del abonado</param>
             </Entrada>
             <Salida>
                <param nom="SN_impCargo" Tipo="NUMERICO">Importe del cargo</param>
                <param nom="SN_valDTO" Tipo="NUMERICO">Valor del descuento</param>
                <param nom="SN_tipDTO" Tipo="NUMERICO">Tipo de descuento (valor, porcentaje)</param>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
             </Salida>
          </Parametros>
       </Elemento>
    </Documentacion>
    */
IS

	LV_des_error	   ge_errores_pg.DesEvent;
	LV_sSql			   ge_errores_pg.vQuery;

BEGIN
	SN_cod_retorno := 0;
	SV_mens_retorno := '';
	SN_num_evento := 0;

	LV_sSql := 'SELECT imp_cargo, val_dto, tip_dto';
	LV_sSql := LV_sSql || ' FROM fa_histcargos a';
	LV_sSql := LV_sSql || ' WHERE a.num_serie = ' || EN_numSerie;
	LV_sSql := LV_sSql || ' UNION';
	LV_sSql := LV_sSql || ' SELECT imp_cargo, val_dto, tip_dto';
	LV_sSql := LV_sSql || ' FROM ge_cargos a';
	LV_sSql := LV_sSql || ' WHERE a.num_serie = ' || EN_numSerie;

	SELECT imp_cargo, val_dto, tip_dto
	INTO SN_impCargo, SN_valDTO, SN_tipDTO
	FROM fa_histcargos a
	WHERE a.num_serie = EN_numSerie
	UNION
	SELECT imp_cargo, val_dto, tip_dto
	FROM ge_cargos a
	WHERE a.num_serie = EN_numSerie;

EXCEPTION
	WHEN OTHERS THEN
		 SN_cod_retorno := 1;
	     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	        SV_mens_retorno := CV_error_no_clasif;
	     END IF;
		 LV_des_error := 'Error en ejecución PL-SQL PV_rec_prec_equipo_actual_PR.' || SQLERRM;
		 SN_num_evento:= Ge_Errores_Pg.Grabarpl( 0, 'PV', SV_mens_retorno, '1.0', USER, 'PV_val_seleccion_causas_PR.PV_rec_prec_equipo_actual_PR', LV_sSql, SQLCODE, LV_des_error );

END PV_rec_prec_equipo_actual_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION PV_val_concep_fact_gtia_PR(SN_cod_retorno	OUT NOCOPY ge_errores_pg.CodError,
				                    SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
				                    SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
RETURN BOOLEAN

    /*
    <Documentacion TipoDoc = "Función">
       <Elemento
          Nombre = "PV_rec_cargo_dif_garantia_PR"
          Fecha modificacion=" "
          Fecha creacion="07/07/2008"
          Programador="Joan Zamorano"
          Diseñador="Joan Zamorano"
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>
          <Descripcion>Permite recuperar el código del concepto de facturación por garantía</Descripcion>
          <Parametros>
             <Entrada>
				<param nom="" Tipo="">N/A</param>
             </Entrada>
             <Salida>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
             </Salida>
          </Parametros>
       </Elemento>
    </Documentacion>
    */

IS

	LV_des_error	   ge_errores_pg.DesEvent;
	LV_sSql			   ge_errores_pg.vQuery;
	LN_valor		   NUMBER;
	ret				   BOOLEAN;
	LV_valParametro	   ged_parametros.val_parametro%TYPE;
	LV_desParam		   ged_parametros.des_parametro%TYPE;
	LN_cod_retorno	   ge_errores_pg.CodError;
	LV_mens_retorno    ge_errores_pg.MsgError;
	LN_num_evento      ge_errores_pg.Evento;
	error_proceso	   		EXCEPTION;

BEGIN
	SN_cod_retorno := 0;
	SV_mens_retorno := '';
	SN_num_evento := 0;

	ret:= pv_obtiene_ged_parametros_fn('CONCEPTO_DIF_GARANTI','GA',LV_valParametro,LV_desParam,LN_cod_retorno,LV_mens_retorno,LN_num_evento);

	IF ret = TRUE THEN
		LV_sSql := 'SELECT 1';
		LV_sSql := LV_sSql || ' FROM fa_conceptos a, ge_monedas b';
		LV_sSql := LV_sSql || ' WHERE a.cod_concepto = ' || LV_valParametro || ' AND';
		LV_sSql := LV_sSql || ' b.cod_moneda IN (SELECT cod_monefact FROM fa_datosgener)';

		SELECT 1
		INTO LN_valor
		FROM fa_conceptos a, ge_monedas b
		WHERE a.cod_concepto = LV_valParametro AND
			  b.cod_moneda IN (SELECT cod_monefact FROM fa_datosgener);

		IF LN_valor = 1 THEN
		   RETURN TRUE;
		ELSE
		   RAISE error_proceso;
		END IF;
	ELSE
		RAISE error_proceso;
	END IF;
EXCEPTION
	WHEN error_proceso THEN
		 SN_cod_retorno := 618;
	     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	        SV_mens_retorno := CV_error_no_clasif;
	     END IF;
		 LV_des_error := 'Error en ejecución PL-SQL PV_val_concep_fact_gtia_PR.' || SQLERRM;
		 SN_num_evento:= Ge_Errores_Pg.Grabarpl( 0, 'PV', SV_mens_retorno, '1.0', USER, 'PV_val_seleccion_causas_PR.PV_val_concep_fact_gtia_PR', LV_sSql, SQLCODE, LV_des_error );
		 RETURN FALSE;

	WHEN OTHERS THEN
		 RETURN FALSE;
		 SN_cod_retorno := 618;
	     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	        SV_mens_retorno := CV_error_no_clasif;
	     END IF;
		 LV_des_error := 'Error en ejecución PL-SQL PV_val_concep_fact_gtia_PR.' || SQLERRM;
		 SN_num_evento:= Ge_Errores_Pg.Grabarpl( 0, 'PV', SV_mens_retorno, '1.0', USER, 'PV_val_seleccion_causas_PR.PV_val_concep_fact_gtia_PR', LV_sSql, SQLCODE, LV_des_error );

END PV_val_concep_fact_gtia_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_rec_cargo_dif_garantia_PR(EN_valdiferencia     IN NUMBER,
		  							   SC_cursor			OUT NOCOPY refcursor,
									   SN_cod_retorno		OUT NOCOPY ge_errores_pg.CodError,
				                       SV_mens_retorno   	OUT NOCOPY ge_errores_pg.MsgError,
				                       SN_num_evento     	OUT NOCOPY ge_errores_pg.Evento)
    /*
    <Documentacion TipoDoc = "Procedure">
       <Elemento
          Nombre = "PV_rec_cargo_dif_garantia_PR"
          Fecha modificacion=" "
          Fecha creacion="07/07/2008"
          Programador="Joan Zamorano"
          Diseñador="Joan Zamorano"
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>
          <Descripcion>Permite obtener el (los) cargo(s) por la diferencia de la garantía</Descripcion>
          <Parametros>
             <Entrada>
				<param nom="EN_valdiferencia" Tipo="NUMERICO">Valor de la diferencia de la garantía</param>
             </Entrada>
             <Salida>
				<param nom="SC_cursor" Tipo="CURSOR">Retorna el (los) cargo(s) por la diferencia de la garantía</param>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
             </Salida>
          </Parametros>
       </Elemento>
    </Documentacion>
    */

IS

	LV_des_error	   		ge_errores_pg.DesEvent;
	LV_sSql			 		ge_errores_pg.vQuery;
	ret				   		BOOLEAN;
	LV_valParametroGarantia ged_parametros.val_parametro%TYPE;
	LV_desParamGarantia	   	ged_parametros.des_parametro%TYPE;
	LV_valParametroMoneda	ged_parametros.val_parametro%TYPE;
	LV_desParamMoneda		ged_parametros.des_parametro%TYPE;
	LN_cod_retorno	   		ge_errores_pg.CodError;
	LV_mens_retorno    		ge_errores_pg.MsgError;
	LN_num_evento      		ge_errores_pg.Evento;
	error_proceso	   		EXCEPTION;

BEGIN
	SN_cod_retorno := 0;
	SV_mens_retorno := '';
	SN_num_evento := 0;

	ret:= pv_obtiene_ged_parametros_fn('CONCEPTO_DIF_GARANTI','GA',LV_valParametroGarantia,LV_desParamGarantia,LN_cod_retorno,LV_mens_retorno,LN_num_evento);
	IF ret = TRUE THEN
	   ret:= pv_obtiene_ged_parametros_fn('COD_MONEDA_PESO','GA',LV_valParametroMoneda,LV_desParamMoneda,LN_cod_retorno,LV_mens_retorno,LN_num_evento);

	   IF ret = TRUE THEN
	   	  LV_sSql := 'SELECT ''A'', a.des_concepto, ''1'', en_valdiferencia, d.des_moneda, a.cod_concepto, d.cod_moneda';
		  LV_sSql := LV_sSql || ' FROM fa_conceptos a, ge_monedas d';
		  LV_sSql := LV_sSql || ' WHERE a.cod_concepto = ' || LV_valParametroGarantia;
		  LV_sSql := LV_sSql || ' AND d.cod_moneda = ' || LV_valParametroMoneda;

		  OPEN SC_cursor FOR
			  SELECT 'A', a.des_concepto, '1', EN_valdiferencia, d.des_moneda, a.cod_concepto, d.cod_moneda
			  FROM fa_conceptos a, ge_monedas d
			  WHERE a.cod_concepto = LV_valParametroGarantia AND
			  		d.cod_moneda = LV_valParametroMoneda;
	   ELSE
	   	   RAISE error_proceso;
	   END IF;
	ELSE
		RAISE error_proceso;
	END IF;

EXCEPTION
	WHEN error_proceso THEN
		 SN_cod_retorno := 1;
	     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	        SV_mens_retorno := CV_error_no_clasif;
	     END IF;
		 LV_des_error := 'Error en ejecución PL-SQL PV_rec_cargo_dif_garantia_PR.' || SQLERRM;
		 SN_num_evento:= Ge_Errores_Pg.Grabarpl( 0, 'PV', SV_mens_retorno, '1.0', USER, 'PV_val_seleccion_causas_PR.PV_rec_cargo_dif_garantia_PR', LV_sSql, SQLCODE, LV_des_error );

	WHEN OTHERS THEN
		 SN_cod_retorno := 1;
	     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	        SV_mens_retorno := CV_error_no_clasif;
	     END IF;
		 LV_des_error := 'Error en ejecución PL-SQL PV_rec_cargo_dif_garantia_PR.' || SQLERRM;
		 SN_num_evento:= Ge_Errores_Pg.Grabarpl( 0, 'PV', SV_mens_retorno, '1.0', USER, 'PV_val_seleccion_causas_PR.PV_rec_cargo_dif_garantia_PR', LV_sSql, SQLCODE, LV_des_error );

END PV_rec_cargo_dif_garantia_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_garantia_ini_PR(EV_abonado     	IN VARCHAR,
							EV_codCausa   	IN VARCHAR,
							EV_numSerie   	IN VARCHAR,
							EV_nomTabla   	IN VARCHAR,
							SN_cod_retorno	OUT NOCOPY ge_errores_pg.CodError,
							SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
							SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
    /*
    <Documentacion TipoDoc = "Procedure">
       <Elemento
          Nombre = "PV_garantia_ini_PR"
          Fecha modificacion=" "
          Fecha creacion="29/07/2008"
          Programador="Joan Zamorano"
          Diseñador="Joan Zamorano"
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>
          <Descripcion>Reemplaza llamada a PL PV_GARANTIA_DOASWAP_PG.PV_GARANTIA_INI que se ca{ia en JAVA por tener un COMMIT</Descripcion>
          <Parametros>
             <Entrada>
				<param nom="EV_abonado" Tipo="CARACTER">Número de abonado</param>
				<param nom="EV_codCausa" Tipo="CARACTER">Código de causa cambio de serie</param>
				<param nom="EV_numSerie" Tipo="CARACTER">Número de serie de equipo del abonado (serie actual)</param>
				<param nom="EV_nomTabla" Tipo="CARACTER">Nombre de la tabla de abonado (GA_ABOCEL - GA_ABOAMIST)</param>
             </Entrada>
             <Salida>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
             </Salida>
          </Parametros>
       </Elemento>
    </Documentacion>
    */

IS

	LV_des_error	   		ge_errores_pg.DesEvent;
	LV_sSql			 		ge_errores_pg.vQuery;
	error_proceso	   		EXCEPTION;
	V_Error      Varchar2(1) := '0';
	V_Cadena     Varchar2(255);

BEGIN
	SN_cod_retorno := 0;
	SV_mens_retorno := '';
	SN_num_evento := 0;
	V_Error       := '0';
	V_Cadena      := 'OK';

	if EV_nomTabla = 'GA_ABOAMIST' then
	   if EV_codCausa = 'GD' then
	   	  PV_GARANTIA_DOASWAP_PG.PV_GARANTIA_DOA(EV_abonado, EV_numSerie, EV_nomTabla, V_Error, V_Cadena);
	   else
	   	   PV_GARANTIA_DOASWAP_PG.PV_GARANTIA_SWAP(EV_abonado, EV_codCausa, EV_numSerie, EV_nomTabla, V_Error, V_Cadena);
	   end IF;
	else
		V_Error  := '4';
		V_Cadena := 'ERROR: ESTA CAUSA ES SOLO PARA ABONADOS PREPAGO.';
	end if;

	SN_cod_retorno := V_Error;
	SV_mens_retorno := V_Cadena;

EXCEPTION
	WHEN OTHERS THEN
		 SN_cod_retorno := 1;
	     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	        SV_mens_retorno := CV_error_no_clasif;
	     END IF;
		 LV_des_error := 'Error en ejecución PL-SQL PV_garantia_ini_PR.' || SQLERRM;
		 SN_num_evento:= Ge_Errores_Pg.Grabarpl( 0, 'PV', SV_mens_retorno, '1.0', USER, 'PV_val_seleccion_causas_PR.PV_garantia_ini_PR', LV_sSql, SQLCODE, LV_des_error );

END PV_garantia_ini_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_val_seleccion_causas_PR(EV_ind_procequi         IN ga_equipaboser.ind_procequi%TYPE,
		  							 EV_cod_caucaser	  	 IN ga_caucaser.cod_caucaser%TYPE,
									 EV_num_serie		  	 IN al_series.num_serie%TYPE,
									 EN_num_abonado		  	 IN ga_abocel.num_abonado%TYPE,
									 EV_nom_tabla		  	 IN VARCHAR2,
									 EV_nom_usuario		  	 IN ge_seg_grpusuario.nom_usuario%TYPE,
		  							 SV_des_combo_contrato 	 OUT NOCOPY VARCHAR2,
									 SN_cod_retorno		  	 OUT NOCOPY ge_errores_pg.CodError,
				                     SV_mens_retorno   	  	 OUT NOCOPY ge_errores_pg.MsgError,
				                     SN_num_evento     	  	 OUT NOCOPY ge_errores_pg.Evento)
    /*
    <Documentacion TipoDoc = "Procedure">
       <Elemento
          Nombre = "PV_val_seleccion_causas_PR"
          Fecha modificacion=" "
          Fecha creacion="07/07/2008"
          Programador="Joan Zamorano"
          Diseñador="Joan Zamorano"
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>
          <Descripcion>Permite realizar las validaciones asociadas a la selección de una causa para el cambio de serie</Descripcion>
          <Parametros>
             <Entrada>
				<param nom="EV_ind_procequi" Tipo="CARACTER">El parámetro de entrada EV_ind_procequi corresponde a la procedencia del equipo nuevo (I: para los internos, E: para los externos)</param>
				<param nom="EV_cod_caucaser" Tipo="CARACTER">El parámetro de entrada EV_cod_caucaser corresponde al código de la causa seleccionada</param>
				<param nom="EV_num_serie" Tipo="CARACTER">El parámetro de entrada EV_num_serie corresponde al número de serie actual del abonado (num_serie para el caso de los abonados CDMA o TDMA y num_imei en el caso de los abonados GSM)</param>
				<param nom="EN_num_abonado" Tipo="NUMERICO">El parámetro de entrada EN_num_abonado corresponde al número de abonado</param>
				<param nom="EV_nom_tabla Tipo="CARACTER">El parámetro de entrada EV_nom_tabla corresponde a la tabla ga_abocel o ga_aboamist dependiendo si se trata de un abonado pospago o prepago respectivamente</param>
				<param nom="EV_nom_usuario" Tipo="CARACTER">El parámetro de entrada EV_nom_usuario corresponde al nombre del usuario de la orden</param>
             </Entrada>
             <Salida>
				<param nom="SV_des_combo_contrato" Tipo="CARACTER">El parámetro de salida SV_des_combo_contrato indica si debe o no deshabilitar la combo de tipos de contrato, ("SI": Deshabilita la combo, "NO": no deshabilita la combo)</param>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
             </Salida>
          </Parametros>
       </Elemento>
    </Documentacion>
    */

IS

	LV_des_error	   		ge_errores_pg.DesEvent;
	LV_sSql			 		ge_errores_pg.vQuery;
	ret				   		BOOLEAN;
	LV_valParametroGarantia ged_parametros.val_parametro%TYPE;
	LV_desParamGarantia	   	ged_parametros.des_parametro%TYPE;
	LN_cod_retorno	   		ge_errores_pg.CodError;
	LV_mens_retorno    		ge_errores_pg.MsgError;
	LN_num_evento      		ge_errores_pg.Evento;
	LV_cod_proceso			VARCHAR2(255);
	LV_des_cadena			VARCHAR2(255);
	LV_cod_proc_csergar		gad_procesos_perfiles.cod_proceso%TYPE;
	LV_ind_procequi_actual	ga_equipaboser.ind_procequi%TYPE;
	LV_dias_contrato_rest	NUMBER;
	error_proceso	   		EXCEPTION;
	errorException			EXCEPTION;
	LB_SWITCH				BOOLEAN;

BEGIN
	SN_cod_retorno := 0;
	SV_mens_retorno := '';
	SN_num_evento := 0;
	SV_des_combo_contrato:='NO';
	LB_SWITCH := FALSE;

	IF EV_ind_procequi = 'I' AND EV_cod_caucaser = 'SP' THEN
	   LV_sSql := 'La causa ** SP POR EQUIPO DE SU PROPIEDAD **  no es válida para equipos de procedencia Interna';
	   RAISE error_proceso;
	END IF;

	IF EV_cod_caucaser IN ('GD', 'GI', 'GR', 'GE') THEN
	   IF EV_ind_procequi = 'E' OR EV_ind_procequi IS NULL THEN
	   	  LV_sSql := 'La causa **' || EV_cod_caucaser || '**  no es válida para equipos de procedencia Externa';
		  RAISE error_proceso;
	   ELSE
		   LV_sSql := 'pv_cambio_serie_sb_pg.PV_garantia_ini_PR(' || EN_num_abonado || ', ' || EV_cod_caucaser || ', ' || EV_num_serie || ', ' || EV_nom_tabla || ', ' || SN_cod_retorno || ', ' || SV_mens_retorno || ', ' || SN_num_evento || ')';

		   pv_cambio_serie_sb_pg.PV_garantia_ini_PR(EN_num_abonado, EV_cod_caucaser, EV_num_serie, EV_nom_tabla, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

		   IF SN_cod_retorno<>0 THEN
		   	  LV_sSql := SV_mens_retorno;
			  SN_cod_retorno:=0;
		   	  RAISE error_proceso;
		   END IF;
	   END IF;
	END IF;

	LV_sSql := 'pv_obtiene_ged_parametros_fn(''CAUSA_GARANTIA'',''GA'',LV_valParametroGarantia,LV_desParamGarantia,LN_cod_retorno,LV_mens_retorno,LN_num_evento)';

	ret:= pv_obtiene_ged_parametros_fn('CAUSA_GARANTIA','GA',LV_valParametroGarantia,LV_desParamGarantia,LN_cod_retorno,LV_mens_retorno,LN_num_evento);
	IF ret = TRUE THEN
	   IF EV_cod_caucaser = LV_valParametroGarantia THEN

		  SV_des_combo_contrato:='SI';

		  LV_sSql := 'SELECT cod_proceso';
		  LV_sSql := LV_sSql || ' FROM gad_procesos_perfiles';
		  LV_sSql := LV_sSql || ' WHERE nom_perfil_proceso = ''COD_PROC_CSERGAR''';

	   	  --obtiene el código de proceso asociado a la causa de cambio
	   	  SELECT cod_proceso
		  INTO LV_cod_proc_csergar
		  FROM gad_procesos_perfiles
		  WHERE nom_perfil_proceso = 'COD_PROC_CSERGAR';


	   	  LB_SWITCH := TRUE;

	   	  LV_sSql := 'No tiene permisos para seleccionar causa de cambio de serie ' || EV_cod_caucaser;

		  --revisa si el ususraio posee el perfil necesario para el proceso
		  SELECT a.cod_proceso
		  INTO LV_cod_proceso
		  FROM ge_seg_perfiles a,
			   ge_seg_grpusuario b
		  WHERE a.cod_grupo = b.cod_grupo AND
				b.nom_usuario = EV_nom_usuario AND
				a.cod_programa = 'GCS' AND
				a.cod_proceso = LV_cod_proc_csergar AND
				ROWNUM = 1;

		  LB_SWITCH := FALSE;

		  LV_sSql := 'SELECT ind_procequi, trunc(sysdate - add_months(fec_alta, 12))';
		  LV_sSql := LV_sSql || ' FROM ga_equipaboser a';
		  LV_sSql := LV_sSql || ' WHERE a.num_abonado = ' || EN_num_abonado || ' AND';
		  LV_sSql := LV_sSql || ' a.num_serie = ' || EV_num_serie || ' AND';
		  LV_sSql := LV_sSql || ' a.fec_alta IN (SELECT max(fec_alta)';
		  LV_sSql := LV_sSql || ' FROM ga_equipaboser b';
		  LV_sSql := LV_sSql || ' WHERE a.num_abonado=b.num_abonado AND';
		  LV_sSql := LV_sSql || ' a.num_serie=b.num_serie)';

		  --obtiene la procedencia del equipo actual
		  SELECT ind_procequi, trunc(sysdate - add_months(fec_alta, 12))
		  INTO LV_ind_procequi_actual, LV_dias_contrato_rest
		  FROM ga_equipaboser a
		  WHERE a.num_abonado = EN_num_abonado AND
		  		a.num_serie = EV_num_serie AND
		  		a.fec_alta IN (SELECT max(fec_alta)
						   	  FROM ga_equipaboser b
							  WHERE a.num_abonado=b.num_abonado AND
		  					  		a.num_serie=b.num_serie);

		  IF LV_ind_procequi_actual = 'I' AND LV_dias_contrato_rest>0 THEN
		  	 LV_sSql := 'Abonado Esta Fuera de Plazo de Garantia....';
			 RAISE error_proceso;
		  ELSIF LV_ind_procequi_actual <> 'I' THEN
		  	 LV_sSql := 'Abonado con procedencia EXTERNA, sin derecho a GARANTIA, escoja otra causa.';
			 RAISE error_proceso;
		  END IF;
	   END IF;
	ELSE
		RAISE errorException;
	END IF;

EXCEPTION
	WHEN error_proceso THEN
         SV_mens_retorno := LV_sSql;

	WHEN errorException THEN
		 SN_cod_retorno := 1;
	     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	        SV_mens_retorno := CV_error_no_clasif;
	     END IF;
		 LV_des_error := 'Error en ejecución PL-SQL PV_val_seleccion_causas_PR.' || SQLERRM;
		 SN_num_evento:= Ge_Errores_Pg.Grabarpl( 0, 'PV', SV_mens_retorno, '1.0', USER, 'PV_val_seleccion_causas_PR.PV_val_seleccion_causas_PR', LV_sSql, SQLCODE, LV_des_error );

	WHEN NO_DATA_FOUND THEN
		 IF LB_SWITCH = TRUE THEN
         	SV_mens_retorno := LV_sSql;
		 ELSE
			 SN_cod_retorno := 1;
		     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
		        SV_mens_retorno := CV_error_no_clasif;
		     END IF;
			 LV_des_error := 'Error en ejecución PL-SQL PV_val_seleccion_causas_PR.' || SQLERRM;
			 SN_num_evento:= Ge_Errores_Pg.Grabarpl( 0, 'PV', SV_mens_retorno, '1.0', USER, 'PV_val_seleccion_causas_PR.PV_val_seleccion_causas_PR', LV_sSql, SQLCODE, LV_des_error );
		 END IF;

	WHEN OTHERS THEN
		 SN_cod_retorno := 1;
	     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	        SV_mens_retorno := CV_error_no_clasif;
	     END IF;
		 LV_des_error := 'Error en ejecución PL-SQL PV_val_seleccion_causas_PR.' || SQLERRM;
		 SN_num_evento:= Ge_Errores_Pg.Grabarpl( 0, 'PV', SV_mens_retorno, '1.0', USER, 'PV_val_seleccion_causas_PR.PV_val_seleccion_causas_PR', LV_sSql, SQLCODE, LV_des_error );

END PV_val_seleccion_causas_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- inicio rrg 78629  COL 78629

/**********************************************************************************/

	FUNCTION pv_rec_contratos_fn_oossweb (

      sn_num_meses		 IN OUT NOCOPY   number,
	  SC_tip_contrato    OUT NOCOPY	     refcursor,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
    )

	RETURN BOOLEAN
	IS
	    V_des_error      ge_errores_pg.DesEvent;
	    sSql             ge_errores_pg.vQuery;
	    v_table_name     VARCHAR2(45);
		cant_grupo       NUMBER;
	BEGIN


	SN_cod_retorno := 0;
	SV_mens_retorno := '';
	SN_num_evento := 0;

	dbms_output.put_line('sn_num_meses:' || sn_num_meses);



	--sSql := 'SELECT COD_TIPCONTRATO, DES_TIPCONTRATO,NVL(IND_COMODATO,0),MESES_MINIMO,IND_PRECIOLISTA,IND_PROCEQUI ';

	sSql := 'SELECT distinct a.cod_tipcontrato, a.des_tipcontrato, a.fec_desde, a.fec_hasta, ';
    sSql := sSql || 'a.ind_contseg, a.ind_contcel, a.ind_comodato, a.canal_vta, a.meses_minimo, ';
    sSql := sSql || 'a.ind_procequi, a.ind_preciolista, a.ind_gmc,b.num_meses ';
    sSql := sSql || 'FROM GA_TIPCONTRATO a , ga_percontrato b ';
	--If sn_num_meses <> '' or  sn_num_meses is not null Then
    --    sSql := sSql || ' where ind_contseg = ''P'' and meses_minimo = ' ||  sn_num_meses || '';
    --Else
        --sSql := sSql || ' where ind_contseg = ''P'' and meses_minimo in (0,12)';
        sSql := sSql || ' where ind_contseg = ''P'' ';
        --sSql := sSql || ' where ind_contseg = ''P'' ';
    --End If;
	sSql := sSql || ' AND a.cod_producto =b.cod_producto ';
	sSql := sSql || '  AND a.cod_tipcontrato=b.cod_tipcontrato ';


    /*DBMS_OUTPUT.PUT_LINE('sSql:' || substr(sSql,1,200));
    DBMS_OUTPUT.PUT_LINE(substr(sSql,201,200));
    DBMS_OUTPUT.PUT_LINE(substr(sSql,401,200));
    DBMS_OUTPUT.PUT_LINE(substr(sSql,601,200));*/

    OPEN SC_tip_contrato FOR sSql;

	return true;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := '1';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       V_des_error := 'pv_cambio_serie_sb_pg.pv_rec_contratos_fn_oossweb; - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_cambio_serie_sb_pg.pv_rec_contratos_fn_oossweb', sSql, SQLCODE, v_des_error );
       RETURN FALSE;

    WHEN OTHERS THEN
       SN_cod_retorno := '2';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       V_des_error := 'pv_cambio_serie_sb_pg.pv_rec_contratos_fn_oossweb; - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_cambio_serie_sb_pg.pv_rec_contratos_fn_oossweb', sSql, SQLCODE, v_des_error );
       RETURN FALSE;

	END pv_rec_contratos_fn_oossweb;

	/**********************************************************************************/
     FUNCTION pv_rec_contratos_fn_oossweb_pp(

                                          sn_num_meses    IN OUT NOCOPY number,
                                          SC_tip_contrato OUT NOCOPY refcursor,
                                          sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                          sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                          sn_num_evento   OUT NOCOPY ge_errores_pg.evento)

   RETURN BOOLEAN IS
    V_des_error  ge_errores_pg.DesEvent;
    sSql         ge_errores_pg.vQuery;
    v_table_name VARCHAR2(45);
    cant_grupo   NUMBER;
  BEGIN

    SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento   := 0;

    --dbms_output.put_line('sn_num_meses:' || sn_num_meses);

    --sSql := 'SELECT COD_TIPCONTRATO, DES_TIPCONTRATO,NVL(IND_COMODATO,0),MESES_MINIMO,IND_PRECIOLISTA,IND_PROCEQUI ';

    sSql := 'SELECT distinct a.cod_tipcontrato, a.des_tipcontrato, a.fec_desde, a.fec_hasta, ';
    sSql := sSql ||
            'a.ind_contseg, a.ind_contcel, a.ind_comodato, a.canal_vta, a.meses_minimo, ';
    sSql := sSql ||
            'a.ind_procequi, a.ind_preciolista, a.ind_gmc,b.num_meses ';
    sSql := sSql || 'FROM GA_TIPCONTRATO a , ga_percontrato b ';
    sSql := sSql || ' where ind_contseg = ''PP'' and b.num_meses in (0,12)';
    sSql := sSql || ' AND a.cod_producto =b.cod_producto ';
    sSql := sSql || '  AND a.cod_tipcontrato=b.cod_tipcontrato ';

    /*DBMS_OUTPUT.PUT_LINE('sSql:' || substr(sSql,1,200));
    DBMS_OUTPUT.PUT_LINE(substr(sSql,201,200));
    DBMS_OUTPUT.PUT_LINE(substr(sSql,401,200));
    DBMS_OUTPUT.PUT_LINE(substr(sSql,601,200));*/

    OPEN SC_tip_contrato FOR sSql;

    return true;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := '1';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno, SV_mens_retorno) THEN
        SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error   := 'pv_cambio_serie_sb_pg.pv_rec_contratos_fn_oossweb_pp; - ' ||
                       SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,
                                              'GA',
                                              SN_cod_retorno || ' -- ' ||
                                              SV_mens_retorno,
                                              '1.0',
                                              USER,
                                              'pv_cambio_serie_sb_pg.pv_rec_contratos_fn_oossweb',
                                              sSql,
                                              SQLCODE,
                                              v_des_error);
      RETURN FALSE;

    WHEN OTHERS THEN
      SN_cod_retorno := '2';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno, SV_mens_retorno) THEN
        SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error   := 'pv_cambio_serie_sb_pg.pv_rec_contratos_fn_oossweb_pp; - ' ||
                       SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,
                                              'GA',
                                              SN_cod_retorno || ' -- ' ||
                                              SV_mens_retorno,
                                              '1.0',
                                              USER,
                                              'pv_cambio_serie_sb_pg.pv_rec_contratos_fn_oossweb',
                                              sSql,
                                              SQLCODE,
                                              v_des_error);
      RETURN FALSE;

  END pv_rec_contratos_fn_oossweb_pp;
    
    

	Function pv_set_contratos_fn_oossweb(

	prmAbonado						   IN OUT NOCOPY number,
    prmMeses 								   OUT NOCOPY varchar2,
    prmTipContrato 							   OUT NOCOPY varchar2,
    prmAltaAboser 							   OUT NOCOPY date,
    prmFinContratoAboser 					   OUT NOCOPY date,
    prmIndprocequi 							   OUT NOCOPY varchar2,
    sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
    sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
    sn_num_evento      OUT NOCOPY      ge_errores_pg.evento

    )


	RETURN BOOLEAN

	is



	sqlDatosAboser varchar2(1000);
	V_des_error	   varchar2(1000);

begin


			SN_cod_retorno := 0;
			SV_mens_retorno := '';
			SN_num_evento := 0;

-- a.fec_alta

sqlDatosAboser := ' select num_abonado, fec_fincontra,   c.fec_alta_aboser, a.cod_tipcontrato, b.NUM_MESES, c.Ind_procequi ';
sqlDatosAboser := sqlDatosAboser || ' from ga_abocel a , ga_percontrato b, ( select max(fec_alta) fec_alta_aboser, num_serie, Ind_procequi ';
sqlDatosAboser := sqlDatosAboser || ' from ga_equipaboser where num_abonado = ' || prmAbonado || ' group by num_serie,Ind_procequi) c ';
sqlDatosAboser := sqlDatosAboser || ' Where num_abonado = ' || prmAbonado;
sqlDatosAboser := sqlDatosAboser || ' and a.cod_tipcontrato = b.cod_tipcontrato ';
sqlDatosAboser := sqlDatosAboser || ' and c.num_serie = a.num_imei ';
sqlDatosAboser := sqlDatosAboser || ' UNION ';
sqlDatosAboser := sqlDatosAboser || ' select num_abonado, fec_fincontra,   c.fec_alta_aboser, a.cod_tipcontrato, b.NUM_MESES, c.Ind_procequi ';
sqlDatosAboser := sqlDatosAboser || ' from ga_aboamist a , ga_percontrato b, ( select max(fec_alta) fec_alta_aboser, num_serie, Ind_procequi ';
sqlDatosAboser := sqlDatosAboser || ' from ga_equipaboser where num_abonado = ' || prmAbonado || ' group by num_serie,Ind_procequi) c ';
sqlDatosAboser := sqlDatosAboser || ' Where num_abonado = ' || prmAbonado;
sqlDatosAboser := sqlDatosAboser || ' and a.cod_tipcontrato = b.cod_tipcontrato ';
sqlDatosAboser := sqlDatosAboser || ' and c.num_serie = a.num_imei ';

/*DBMS_OUTPUT.PUT_LINE('sqlDatosAboser:' || substr(sqlDatosAboser,1,200));
DBMS_OUTPUT.PUT_LINE(substr(sqlDatosAboser,201,200));
DBMS_OUTPUT.PUT_LINE(substr(sqlDatosAboser,401,200));
DBMS_OUTPUT.PUT_LINE(substr(sqlDatosAboser,601,200));*/

EXECUTE IMMEDIATE sqlDatosAboser
INTO prmAbonado,prmFinContratoAboser,prmAltaAboser,prmTipContrato,prmMeses,prmIndprocequi;

return true;


EXCEPTION
	WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := '1';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       V_des_error := 'pv_cambio_serie_sb_pg.pv_set_contratos_fn_oossweb; - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_cambio_serie_sb_pg.pv_set_contratos_fn_oossweb', sqlDatosAboser, SQLCODE, v_des_error );
       RETURN FALSE;

    WHEN OTHERS THEN
       SN_cod_retorno := '2';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       V_des_error := 'pv_cambio_serie_sb_pg.pv_set_contratos_fn_oossweb; - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_cambio_serie_sb_pg.pv_set_contratos_fn_oossweb', sqlDatosAboser, SQLCODE, v_des_error );
       RETURN FALSE;


End pv_set_contratos_fn_oossweb;

/**********************************************************************************/



	PROCEDURE pv_rec_tip_contrato_pr_oossweb (
	  OE_sesion                IN               GE_SESION_QT,
      SC_tip_contrato          OUT NOCOPY	    refcursor,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento)


	IS

	  		V_Fechas 		   VARCHAR2(20);
            V_Fec_fincontra   date;
            V_Fec_alta 	   	  date;
            V_Fec_alta_aboser date;
            V_COD_TIPCONTRATO VARCHAR2(20);
            V_NUM_MESES 	  VARCHAR2(20);
            V_AboserMasMeses  date;
            V_ProcEqui 	      VARCHAR2(20);
            V_TipoCaso 		  VARCHAR2(20);
			B_Flag			  BOOLEAN;


			V_EquipoInterno   VARCHAR2(20);

			V_TipCel		  VARCHAR2(20);

			V_TipSimCard	  VARCHAR2(20);

			V_Meses12		  VARCHAR2(2);
			V_Meses0		  VARCHAR2(2);
			V_MesesVacio	  VARCHAR2(2);
			V_numAbonado	  number(20);

			LV_des_error 	   VARCHAR2(1000);
			LV_sSQL			   VARCHAR2(1000);

			Error_Ejecucion       			 EXCEPTION;
            N_cod_uso AL_USOS.COD_USO%TYPE;


	BEGIN

		 	V_numAbonado			:= OE_sesion.num_abonado;

			SN_cod_retorno := 0;
			SV_mens_retorno := '';
			SN_num_evento := 0;

			V_TipCel := OE_sesion.COD_PROGRAMA;        -- se debe reemplaxar por el de la sesion
			V_TipSimCard := 'G';

			V_EquipoInterno := 'E'; -- se debe reemplaxar por el de la sesion

			B_Flag := false;

			V_Meses12:=12;
			V_Meses0:=0;
			V_MesesVacio:=null;

			--DBMS_OUTPUT.PUT_LINE('SnumAbonado:' || SnumAbonado);
     LV_sSQL := 'pv_set_contratos_fn_oossweb';
                IF NOT pv_set_contratos_fn_oossweb(V_numAbonado, V_NUM_MESES, V_COD_TIPCONTRATO, V_Fec_alta_aboser, V_Fec_fincontra, V_ProcEqui,SN_cod_retorno ,SV_mens_retorno,SN_num_evento) then
					   RAISE error_ejecucion;
				end if;  
            
     SELECT COD_USO
     INTO  N_cod_uso
     FROM GA_ABOCEL 
     WHERE NUM_ABONADO= V_numAbonado
     UNION
     SELECT COD_USO 
     FROM GA_ABOAMIST
     WHERE NUM_ABONADO= V_numAbonado;
     
     
     
     IF N_cod_uso = 3 then
         IF NOT pv_rec_contratos_fn_oossweb_pp(V_NUM_MESES,
                                            SC_tip_contrato,
                                            SN_cod_retorno,
                                            SV_mens_retorno,
                                            SN_num_evento) then
         RAISE error_ejecucion;
         end if;
     ELSE       
            If V_TipCel <> V_TipSimCard Then


                If V_EquipoInterno = 'I' And V_ProcEqui = 'I' Then

					select add_months( V_Fec_alta_aboser,V_NUM_MESES) into V_AboserMasMeses from dual;

                    --If to_date(V_Fec_fincontra,'dd-mm-yyyy') > to_date(V_AboserMasMeses,'dd-mm-yyyy') Then
					If V_Fec_fincontra > V_AboserMasMeses Then
                        B_Flag := True;
                        V_TipoCaso := '1';
                    End If;
				end if;

                If V_EquipoInterno <> 'I' And V_ProcEqui = 'I' Then
					select add_months(V_Fec_alta_aboser,V_NUM_MESES) into V_AboserMasMeses from dual;
                    --If to_date(V_Fec_fincontra,'dd-mm-yyyy') > to_Date(V_AboserMasMeses,'dd-mm-yyyy') Then
					If V_Fec_fincontra > V_AboserMasMeses Then
					    LV_sSQL := 'pv_set_contratos_fn_oossweb';
                        IF NOT pv_rec_contratos_fn_oossweb(V_Meses12,SC_tip_contrato,SN_cod_retorno ,SV_mens_retorno,SN_num_evento) then
						   RAISE error_ejecucion;
						end if;
                        B_Flag := True;
                    End If;
                end if;

				If V_EquipoInterno <> 'I' And V_ProcEqui = 'E' Then

				   DBMS_OUTPUT.PUT_LINE('externo-externo');

					select add_months(V_Fec_alta_aboser,V_NUM_MESES) into V_AboserMasMeses from dual;

                    --If to_date(V_Fec_fincontra,'dd-mm-yyyy') > to_date(V_AboserMasMeses,'dd-mm-yyyy') Then
					If V_Fec_fincontra > V_AboserMasMeses Then
					    LV_sSQL := 'pv_set_contratos_fn_oossweb';
                        IF NOT pv_rec_contratos_fn_oossweb(V_Meses0,SC_tip_contrato,SN_cod_retorno ,SV_mens_retorno,SN_num_evento) then
						   RAISE error_ejecucion;
						end if;
                        B_Flag := True;
                    End If;

                End If;

            end if;

			If V_TipCel = V_TipSimCard Then

                If V_ProcEqui = 'I' Then
				   		LV_sSQL := 'pv_set_contratos_fn_oossweb';
                        IF NOT pv_rec_contratos_fn_oossweb(V_Meses0,SC_tip_contrato,SN_cod_retorno ,SV_mens_retorno,SN_num_evento) then
						   RAISE error_ejecucion;
						end if;
                        B_Flag := True;
                Else
					    LV_sSQL := 'pv_set_contratos_fn_oossweb';
                        IF NOT pv_rec_contratos_fn_oossweb(V_Meses12,SC_tip_contrato,SN_cod_retorno ,SV_mens_retorno,SN_num_evento) then
						   RAISE error_ejecucion;
						end if;
                        B_Flag := True;
                End If;
            End If;


            If Not B_Flag Then

			    --DBMS_OUTPUT.PUT_LINE('NOT FLAG');
				LV_sSQL := 'pv_set_contratos_fn_oossweb';
                IF NOT pv_rec_contratos_fn_oossweb (V_MesesVacio,SC_tip_contrato,SN_cod_retorno ,SV_mens_retorno,SN_num_evento) then
				   RAISE error_ejecucion;
				end if;
            End If;
     END IF;  

	---dbms_output.put_line('V_AboserMasMeses:' || V_AboserMasMeses);

	EXCEPTION
	WHEN error_ejecucion THEN
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_error_no_clasIF;
           END IF;
		   LV_des_error := SUBSTR('pv_cambio_serie_sb_pg.pv_rec_tip_contrato_pr_oossweb' || SQLERRM,1,100);
		   SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,100);
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER,
		   				 		 					'Pv_Actcambios_Ofvirtual_Pg.PV_registra_orden_servicio_FN', LV_sSql, SQLCODE, SV_mens_retorno );

	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 218;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'pv_cambio_serie_sb_pg.pv_rec_tip_contrato_pr_oossweb('||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CAMBIO_SERIE_SB_PG.pv_rec_info_abonado_pr', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 203;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'pv_cambio_serie_sb_pg.pv_rec_tip_contrato_pr_oossweb('||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CAMBIO_SERIE_SB_PG.pv_rec_info_abonado_pr', LV_sSQL, SN_cod_retorno, LV_des_error );



	END pv_rec_tip_contrato_pr_oossweb;


-- fin rrg 78629 COL 78629
END pv_cambio_serie_sb_pg;
/
SHOW ERRORS