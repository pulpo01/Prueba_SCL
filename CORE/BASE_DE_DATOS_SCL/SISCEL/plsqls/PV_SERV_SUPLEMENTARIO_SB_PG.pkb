CREATE OR REPLACE PACKAGE BODY Pv_Serv_Suplementario_Sb_Pg
IS

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_reg_coment_pv_iorserv_fn (
      ev_comentario       IN              pv_iorserv.comentario%TYPE,
      en_num_os              IN              pv_iorserv.num_os%TYPE,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN
    /*
    <Documentación
      TipoDoc = "Función">>
       <Elemento
          Nombre = "pv_reg_coment_pv_iorserv_fn"
          Lenguaje="PL/SQL"
          Fecha="13-03-2008"
          Versión="1.0"
          Diseñador="Marcelo Godoy"
          Programador=""
          Ambiente Desarrollo="BD">
          <Retorno></Retorno>>
          <Descripción>Registra el comentario en la tabla PV_IORSERV para un aviso de siniestro WEB</Descripción>>
          <Parámetros>
             <Entrada>
                <param nom="ev_comentario Tipo="CARACTER">Comentario a registrar</param>>
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
IS

    LV_des_error      ge_errores_pg.DesEvent;
    LV_sSql           ge_errores_pg.vQuery;
    LN_cod_estado     number;
    LN_tip_estado       number;

    BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';

    LV_sSql:= 'UPDATE pv_iorserv a'
              || ' SET a.comentario = ' || ev_comentario
              || ' WHERE a.num_os = ' || en_num_os;

    UPDATE pv_iorserv a
    SET a.comentario = ev_comentario
    WHERE a.num_os = en_num_os;

    RETURN TRUE;

    EXCEPTION
    WHEN OTHERS THEN
          SN_cod_retorno := 156;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'Pv_Serv_Suplementario_Sb_Pg.pv_reg_coment_pv_iorserv_fn'||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'Pv_Serv_Suplementario_Sb_Pg.pv_reg_coment_pv_iorserv_fn', LV_sSQL, SN_cod_retorno, LV_des_error );
          RETURN FALSE;

   END pv_reg_coment_pv_iorserv_fn;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    FUNCTION pv_obtiene_ged_codigos_fn (
      ev_cod_modulo     IN                GED_CODIGOS.cod_modulo%TYPE,
      ev_nom_tabla        IN                 GED_CODIGOS.nom_tabla%TYPE,
      ev_nom_columna    IN                 GED_CODIGOS.nom_columna%TYPE,
      ev_des_valor        IN                 GED_CODIGOS.des_valor%TYPE,
      sv_cod_valor         OUT             GED_CODIGOS.cod_valor%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      Ge_Errores_Pg.evento
    )
    /*
    <Documentacion TipoDoc = "Function">
       <Elemento
          Nombre = "pv_obtiene_ged_codigos_fn"
          Fecha modificacion=" "
          Fecha creacion="03-04-2006"
          Programador="Marcelo Godoy S. - Carlos Navarro"
          Diseñador=""
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>
          <Descripcion></Descripcion>
          <Parametros>
             <Entrada>
                <param nom="ev_cod_modulo" Tipo="CARACTER">código modulo</param>
                <param nom="ev_nom_tabla" Tipo="CARACTER">Nombre de tabla</param>
                <param nom="ev_nom_columna" Tipo="CARACTER">Nombre de columna</param>
                <param nom="ev_des_valor" Tipo="CARACTER">Nombre valor</param>
             </Entrada>
             <Salida>
                <param nom="sv_cod_valor" Tipo="CARACTER">código valor</param>
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
        LV_des_error      Ge_Errores_Pg.DesEvent;
        LV_sSql           Ge_Errores_Pg.vQuery;
        error_ejecucion   EXCEPTION;
    BEGIN

        SN_cod_retorno := 0;
        SN_num_evento  := 0;
        SV_mens_retorno:= '';

        LV_sSql:='SELECT cod_valor FROM ged_codigos WHERE nom_tabla ='''||ev_nom_tabla||'''';
        LV_sSql:=LV_sSql||' AND nom_columna = '''||ev_nom_columna||'''';
        LV_sSql:=LV_sSql||' AND des_valor = '''||ev_des_valor||'''';

        SELECT cod_valor
          INTO sv_cod_valor
          FROM GED_CODIGOS
         WHERE cod_modulo = ev_cod_modulo
           AND nom_tabla = ev_nom_tabla
           AND nom_columna = ev_nom_columna
           AND des_valor = ev_des_valor;

        RETURN TRUE;

    EXCEPTION
    WHEN OTHERS THEN
       SN_cod_retorno := '156';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error := 'pv_obtiene_ged_codigos_fn(); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, cv_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_obtiene_ged_codigos_fn', LV_sSql, SQLCODE, LV_des_error );
       RETURN FALSE;

    END pv_obtiene_ged_codigos_fn;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE pv_rec_serv_supl_abonado_pr (
      eo_dat_abo        IN OUT NOCOPY   pv_datos_abo_qt,
      tip_servicio      IN              NUMBER,
      sc_servsupl        OUT             refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      Ge_Errores_Pg.evento
    )
    /*
    <Documentacion TipoDoc = "Function">
       <Elemento
          Nombre = "pv_rec_serv_suplemetario_pr"
          Fecha modificacion=" "
          Fecha creacion="03-04-2006"
          Programador="Marcelo Godoy S. - Carlos Navarro"
          Diseñador=""
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>
          <Descripcion></Descripcion>
          <Parametros>
             <Entrada>
                <param nom="eo_dat_abo Tipo="OBJETO ">Datos abonado</param>>
             </Entrada>
             <Salida>
                <param nom="sc_servsupl" Tipo="CURSOR">Lista de servicios suplementarios</param>>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
             </Salida>
          </Parametros>
       </Elemento>
    </Documentacion>
    */
    IS
        LV_des_error           Ge_Errores_Pg.DesEvent;
        LV_sSql                Ge_Errores_Pg.vQuery;
        LV_tip_servicio           GA_SERVSUPL.tip_servicio%TYPE;
        error_ejecucion         EXCEPTION;

    BEGIN

        SN_cod_retorno := 0;
        SN_num_evento  := 0;
        SV_mens_retorno:= '';

        Pv_Cambio_Serie_Sb_Pg.pv_rec_info_abonado_pr(eo_dat_abo,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        IF (SN_cod_retorno <> 0) THEN
            RAISE error_ejecucion;
        END IF;

        IF NOT pv_obtiene_ged_codigos_fn('GA', 'GA_SERVSUPL', 'TIP_SERVICIO', 'NORMAL',LV_tip_servicio,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
            RAISE error_ejecucion;
        END IF;

        IF tip_servicio = 1 THEN

            LV_sSql := ' SELECT a.cod_servicio, a.des_servicio, a.cod_servsupl, a.cod_nivel, c.imp_tarifa AS imp_tarifa_ss, d.des_moneda AS des_moneda_ss,';
            LV_sSql :=LV_sSql || ' b.cod_concepto AS cod_concepto_ss, f.imp_tarifa AS imp_tarifa_fa, g.des_moneda AS des_moneda_fa, e.cod_concepto AS cod_concepto_ss, ''N'', a.ind_tuxedo';
            LV_sSql :=LV_sSql || ' FROM ga_servsupl a, ga_actuaserv b, ga_tarifas c, ge_monedas d,';
            LV_sSql :=LV_sSql || ' ga_actuaserv e, ga_tarifas f, ge_monedas g';
            LV_sSql :=LV_sSql || ' WHERE A.COD_PRODUCTO = '''|| cv_prod_celular||'''';
            LV_sSql :=LV_sSql || ' AND A.COD_SERVICIO IN ';
            LV_sSql :=LV_sSql || ' (SELECT cod_servicio FROM ga_servsuplabo ';
            LV_sSql :=LV_sSql || ' WHERE num_abonado = '||eo_dat_abo.NUM_ABONADO;
            LV_sSql :=LV_sSql || ' AND ind_estado < 3 AND fec_bajabd IS NULL';
            LV_sSql :=LV_sSql || ' AND cod_servicio IN (SELECT cod_servicio';
            LV_sSql :=LV_sSql || ' FROM gad_servsup_plan a';
            LV_sSql :=LV_sSql || ' WHERE a.cod_plantarif = '''||eo_dat_abo.cod_plantarif||''' and a.tip_relacion=3 and a.fec_hasta >= sysdate)';
            LV_sSql :=LV_sSql || ' AND A.COD_SERVICIO not in (SELECT COD_VALOR FROM GED_CODIGOS WHERE COD_MODULO = ''GA'' AND NOM_TABLA = ''GA_SERVSUPL'' AND NOM_COLUMNA = ''COD_SERVICIO''))';
            LV_sSql :=LV_sSql || ' AND A.TIP_SERVICIO = '''||LV_tip_servicio||'''';
            LV_sSql :=LV_sSql || ' AND A.COD_PRODUCTO = B.COD_PRODUCTO(+)';
            LV_sSql :=LV_sSql || ' AND A.COD_SERVICIO = B.COD_SERVICIO(+)';
            LV_sSql :=LV_sSql || ' AND B.COD_ACTABO(+) = '''||cv_serv_suplabo||'''';
            LV_sSql :=LV_sSql || ' AND B.COD_TIPSERV(+) = '''||cv_serv_suplementario||'''';
            LV_sSql :=LV_sSql || ' AND B.COD_PRODUCTO = C.COD_PRODUCTO(+)';
            LV_sSql :=LV_sSql || ' AND B.COD_ACTABO = C.COD_ACTABO(+)';
            LV_sSql :=LV_sSql || ' AND B.COD_TIPSERV = C.COD_TIPSERV(+)';
            LV_sSql :=LV_sSql || ' AND B.COD_SERVICIO = C.COD_SERVICIO(+)';
            LV_sSql :=LV_sSql || ' AND C.COD_PLANSERV(+) = '''||eo_dat_abo.cod_planserv||'''';
            LV_sSql :=LV_sSql || ' AND SYSDATE BETWEEN C.FEC_DESDE(+) AND NVL(C.FEC_HASTA(+), SYSDATE)';
            LV_sSql :=LV_sSql || ' AND C.COD_MONEDA = D.COD_MONEDA(+)';
            LV_sSql :=LV_sSql || ' AND A.COD_PRODUCTO = E.COD_PRODUCTO(+)';
            LV_sSql :=LV_sSql || ' AND A.COD_SERVICIO = E.COD_SERVICIO(+)';
            LV_sSql :=LV_sSql || ' AND E.COD_ACTABO(+) = '''||cv_facturacion||'''';
            LV_sSql :=LV_sSql || ' AND E.COD_TIPSERV(+) = '''||cv_serv_suplementario||'''';
            LV_sSql :=LV_sSql || ' AND E.COD_PRODUCTO = F.COD_PRODUCTO(+)';
            LV_sSql :=LV_sSql || ' AND E.COD_ACTABO = F.COD_ACTABO(+)';
            LV_sSql :=LV_sSql || ' AND E.COD_TIPSERV = F.COD_TIPSERV(+)';
            LV_sSql :=LV_sSql || ' AND E.COD_SERVICIO = F.COD_SERVICIO(+)';
            LV_sSql :=LV_sSql || ' AND F.COD_PLANSERV(+) = '''||eo_dat_abo.cod_planserv||'''';
            LV_sSql :=LV_sSql || ' AND SYSDATE BETWEEN F.FEC_DESDE(+) AND NVL(F.FEC_HASTA(+), SYSDATE) ';
            LV_sSql :=LV_sSql || ' AND F.COD_MONEDA = G.COD_MONEDA(+)';

        ELSE

            LV_sSql := ' SELECT a.cod_servicio, a.des_servicio, a.cod_servsupl, a.cod_nivel, c.imp_tarifa AS imp_tarifa_ss, d.des_moneda AS des_moneda_ss,';
            LV_sSql :=LV_sSql || ' b.cod_concepto AS cod_concepto_ss, f.imp_tarifa AS imp_tarifa_fa, g.des_moneda AS des_moneda_fa, e.cod_concepto AS cod_concepto_ss, ''N'', a.ind_tuxedo';
            LV_sSql :=LV_sSql || ' FROM ga_servsupl a, ga_actuaserv b, ga_tarifas c, ge_monedas d,';
            LV_sSql :=LV_sSql || ' ga_actuaserv e, ga_tarifas f, ge_monedas g';
            LV_sSql :=LV_sSql || ' WHERE A.COD_PRODUCTO = '''|| cv_prod_celular||'''';
            LV_sSql :=LV_sSql || ' AND A.COD_SERVICIO IN ';
            LV_sSql :=LV_sSql || ' (SELECT cod_servicio FROM ga_servsuplabo ';
            LV_sSql :=LV_sSql || ' WHERE num_abonado = '||eo_dat_abo.NUM_ABONADO;
            LV_sSql :=LV_sSql || ' AND ind_estado < 3 AND fec_bajabd IS NULL' ;
            LV_sSql :=LV_sSql || ' AND cod_servicio NOT IN (SELECT cod_servicio';
            LV_sSql :=LV_sSql || ' FROM gad_servsup_plan a';
            LV_sSql :=LV_sSql || ' WHERE a.cod_plantarif = '''||eo_dat_abo.cod_plantarif||''' and a.tip_relacion=3 and a.fec_hasta >= sysdate)';
            LV_sSql :=LV_sSql || ' AND A.COD_SERVICIO not in (SELECT COD_VALOR FROM GED_CODIGOS WHERE COD_MODULO = ''GA'' AND NOM_TABLA = ''GA_SERVSUPL'' AND NOM_COLUMNA = ''COD_SERVICIO''))';
            LV_sSql :=LV_sSql || ' AND A.TIP_SERVICIO = '''||LV_tip_servicio||'''';
            LV_sSql :=LV_sSql || ' AND A.COD_PRODUCTO = B.COD_PRODUCTO(+)';
            LV_sSql :=LV_sSql || ' AND A.COD_SERVICIO = B.COD_SERVICIO(+)';
            LV_sSql :=LV_sSql || ' AND B.COD_ACTABO(+) = '''||cv_serv_suplabo||'''';
            LV_sSql :=LV_sSql || ' AND B.COD_TIPSERV(+) = '''||cv_serv_suplementario||'''';
            LV_sSql :=LV_sSql || ' AND B.COD_PRODUCTO = C.COD_PRODUCTO(+)';
            LV_sSql :=LV_sSql || ' AND B.COD_ACTABO = C.COD_ACTABO(+)';
            LV_sSql :=LV_sSql || ' AND B.COD_TIPSERV = C.COD_TIPSERV(+)';
            LV_sSql :=LV_sSql || ' AND B.COD_SERVICIO = C.COD_SERVICIO(+)';
            LV_sSql :=LV_sSql || ' AND C.COD_PLANSERV(+) = '''||eo_dat_abo.cod_planserv||'''';
            LV_sSql :=LV_sSql || ' AND SYSDATE BETWEEN C.FEC_DESDE(+) AND NVL(C.FEC_HASTA(+), SYSDATE)';
            LV_sSql :=LV_sSql || ' AND C.COD_MONEDA = D.COD_MONEDA(+)';
            LV_sSql :=LV_sSql || ' AND A.COD_PRODUCTO = E.COD_PRODUCTO(+)';
            LV_sSql :=LV_sSql || ' AND A.COD_SERVICIO = E.COD_SERVICIO(+)';
            LV_sSql :=LV_sSql || ' AND E.COD_ACTABO(+) = '''||cv_facturacion||'''';
            LV_sSql :=LV_sSql || ' AND E.COD_TIPSERV(+) = '''||cv_serv_suplementario||'''';
            LV_sSql :=LV_sSql || ' AND E.COD_PRODUCTO = F.COD_PRODUCTO(+)';
            LV_sSql :=LV_sSql || ' AND E.COD_ACTABO = F.COD_ACTABO(+)';
            LV_sSql :=LV_sSql || ' AND E.COD_TIPSERV = F.COD_TIPSERV(+)';
            LV_sSql :=LV_sSql || ' AND E.COD_SERVICIO = F.COD_SERVICIO(+)';
            LV_sSql :=LV_sSql || ' AND F.COD_PLANSERV(+) = '''||eo_dat_abo.cod_planserv||'''';
            LV_sSql :=LV_sSql || ' AND SYSDATE BETWEEN F.FEC_DESDE(+) AND NVL(F.FEC_HASTA(+), SYSDATE) ';
            LV_sSql :=LV_sSql || ' AND F.COD_MONEDA = G.COD_MONEDA(+)';

        END IF;

        OPEN sc_servsupl FOR LV_sSql;

    EXCEPTION
    WHEN error_ejecucion THEN
       SN_cod_retorno:=1;
       SV_mens_retorno := 'No se encuentra código asignado al tipo de servicio normal';
       LV_des_error := 'pv_rec_serv_supl_abonado_pr(); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, cv_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_rec_serv_suplemetario_pr', LV_sSql, SQLCODE, Lv_des_error );

    WHEN OTHERS THEN
       SN_cod_retorno := '156';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error := 'pv_rec_serv_supl_abonado_pr(); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, cv_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_rec_serv_supl_abonado_pr', LV_sSql, SQLCODE, Lv_des_error );

    END pv_rec_serv_supl_abonado_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION pv_rec_info_central_abo_fn (
      eo_dat_abo        IN              pv_datos_abo_qt,
      so_icg_central    OUT NOCOPY      icg_central_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      Ge_Errores_Pg.evento
    )
    /*
    <Documentacion TipoDoc = "Function">
       <Elemento
          Nombre = "pv_rec_info_central_abo_fn"
          Fecha modificacion=" "
          Fecha creacion="03-04-2006"
          Programador="Marcelo Godoy S. - Carlos Navarro"
          Diseñador=""
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>
          <Descripcion></Descripcion>
          <Parametros>
             <Entrada>
                <param nom="eo_dat_abo Tipo="OBJETO ">Datos abonado</param>>
             </Entrada>
             <Salida>
                <param nom="so_icg_central Tipo="OBJETO ">Datos Central</param>>
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
        LV_des_error     Ge_Errores_Pg.DesEvent;
        LV_sSql          VARCHAR2(4000);
        error_ejecucion  EXCEPTION;
    BEGIN

        SN_cod_retorno := 0;
        SN_num_evento  := 0;
        SV_mens_retorno:= '';


        LV_sSql:='SELECT cod_central, cod_producto, nom_central, cod_nemotec, cod_alm, ';
        LV_sSql:=LV_sSql||' num_maxintentos, cod_sistema, cod_cobertura, ';
        LV_sSql:=LV_sSql||' tie_respuesta, nodocom,cod_tecnologia, cod_hlr ';
        LV_sSql:=LV_sSql||' FROM icg_central ';
        LV_sSql:=LV_sSql||' WHERE cod_producto = '||cv_prod_celular;
        LV_sSql:=LV_sSql||' AND cod_central = '||eo_dat_abo.cod_central;

        SELECT icg_central_qt( cod_central, cod_producto, nom_central, cod_nemotec, cod_alm,
               num_maxintentos, cod_sistema, cod_cobertura, tie_respuesta, nodocom,
               cod_tecnologia, cod_hlr)
          INTO so_icg_central
--           .cod_central, so_icg_central.cod_producto, so_icg_central.nom_central, so_icg_central.cod_nemotec, so_icg_central.cod_alm,
--                so_icg_central.num_maxintentos, so_icg_central.cod_sistema, so_icg_central.cod_cobertura, so_icg_central.tie_respuesta, so_icg_central.nodocom,
--                so_icg_central.cod_tecnologia, so_icg_central.cod_hlr
          FROM ICG_CENTRAL
         WHERE cod_producto = cv_prod_celular
           AND cod_central = eo_dat_abo.cod_central;

        RETURN TRUE;

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := '1';
       SV_mens_retorno := 'No se encontró información central.';
       LV_des_error := 'pv_rec_info_central_abo_fn(); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, cv_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_rec_info_central_abo_fn', LV_sSql, SQLCODE, LV_des_error );
       RETURN FALSE;
    WHEN OTHERS THEN
       SN_cod_retorno := '156';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error := 'pv_rec_info_central_abo_fn(); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento,  cv_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_rec_info_central_abo_fn', LV_sSql, SQLCODE, LV_des_error );
       RETURN FALSE;

    END pv_rec_info_central_abo_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION PV_REC_GRUP_PRESTACION_ABO_FN (
      lv_abonado        IN              GA_ABOCEL.NUM_ABONADO%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      Ge_Errores_Pg.evento
    )
    /*
    <Documentacion TipoDoc = "Function">
       <Elemento
          Nombre = "PV_REC_GRUP_PRESTACION_ABO_FN"
          Fecha modificacion=" "
          Fecha creacion="08-10-2009"
          Programador=""
          Diseñador=""
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>
          <Descripcion></Descripcion>
          <Parametros>
             <Entrada>
                <param nom="lv_abonado" Tipo="BUMBER">Datos abonado</param>>
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
    RETURN VARCHAR2
    IS
        LV_des_error     Ge_Errores_Pg.DesEvent;
        LV_sSql          VARCHAR2(4000);
        Ln_grgrupo        varchar2(5);
        error_ejecucion  EXCEPTION;
    BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';
    Ln_grgrupo    := '';

    LV_sSql:='select a.grp_prestacion';    
    LV_sSql:=LV_sSql || 'from ge_prestaciones_td a';
    LV_sSql:=LV_sSql || 'where a.cod_prestacion in (select b.cod_prestacion';
    LV_sSql:=LV_sSql || 'from ga_abocel b';
    LV_sSql:=LV_sSql || 'where b.num_abonado =  ' || lv_abonado ;
    LV_sSql:=LV_sSql || 'union';
    LV_sSql:=LV_sSql || 'select b.cod_prestacion';
    LV_sSql:=LV_sSql || 'from ga_aboamist b';
    LV_sSql:=LV_sSql || 'where b.num_abonado =  '|| lv_abonado || ')';
        

    select a.grp_prestacion
    into Ln_grgrupo
    from ge_prestaciones_td a
    where a.cod_prestacion in (select b.cod_prestacion
    from ga_abocel b
    where b.num_abonado =  lv_abonado
    union
    select b.cod_prestacion
    from ga_aboamist b
    where b.num_abonado =  lv_abonado);
    
    RETURN Ln_grgrupo;

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := '1';
       SV_mens_retorno := 'No tiene grupo asociado.';
       LV_des_error := 'PV_REC_GRUP_PRESTACION_ABO_FN(); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, cv_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'PV_REC_GRUP_PRESTACION_ABO_FN', LV_sSql, SQLCODE, LV_des_error );
       RETURN Ln_grgrupo;
    WHEN OTHERS THEN
       SN_cod_retorno := '156';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error := 'PV_REC_GRUP_PRESTACION_ABO_FN(); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento,  cv_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'PV_REC_GRUP_PRESTACION_ABO_FN', LV_sSql, SQLCODE, LV_des_error );
       RETURN Ln_grgrupo;

    END PV_REC_GRUP_PRESTACION_ABO_FN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------    
    FUNCTION pv_rec_info_equipo_abo_fn (
      en_num_abonado    IN              GA_ABOCEL.NUM_ABONADO%TYPE,
      ev_num_serie      IN              GA_EQUIPABOSER.NUM_SERIE%TYPE,
      so_ga_equipaboser OUT NOCOPY      ga_equipaboser_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      Ge_Errores_Pg.evento
    )
    /*
    <Documentacion TipoDoc = "Function">
       <Elemento
          Nombre = "pv_rec_info_equipo_abo_fn"
          Fecha modificacion=" "
          Fecha creacion="03-04-2006"
          Programador="Marcelo Godoy S. - Carlos Navarro"
          Diseñador=""
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>
          <Descripcion></Descripcion>
          <Parametros>
             <Entrada>
                <param nom="en_num_aboando" Tipo="NUMERICO">numero Abonado</param>
                <param nom="ev_num_serie" Tipo="CARACTER">numero serie</param>
             </Entrada>
             <Salida>
                <param nom="so_ga_equipaboser Tipo="OBJETO ">Datos equipo abonado </param>>
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
        LV_des_error     Ge_Errores_Pg.DesEvent;
        LV_sSql          VARCHAR2(4000);
        error_ejecucion  EXCEPTION;
    BEGIN
        so_ga_equipaboser := NEW ga_equipaboser_qt;
        SN_cod_retorno := 0;
        SN_num_evento  := 0;
        SV_mens_retorno:= '';

        LV_sSql:='SELECT num_abonado, num_serie, cod_producto, ind_procequi, fec_alta, ';
        LV_sSql:=LV_sSql||' ind_propiedad, cod_bodega, tip_stock, cod_articulo, ind_equiacc,';
        LV_sSql:=LV_sSql||' cod_modventa, tip_terminal, cod_uso, cod_cuota, cod_estado, cap_code,';
        LV_sSql:=LV_sSql||' cod_protocolo, num_velocidad, cod_frecuencia, cod_version,';
        LV_sSql:=LV_sSql||' num_seriemec, des_equipo, cod_paquete, num_movimiento, cod_causa,';
        LV_sSql:=LV_sSql||' ind_eqprestado, num_imei, cod_tecnologia, imp_cargo, tip_dto, val_dto';
        LV_sSql:=LV_sSql||' FROM ga_equipaboser ';
        LV_sSql:=LV_sSql||' WHERE num_abonado = '||en_num_abonado;
        LV_sSql:=LV_sSql||' AND num_serie = '''||ev_num_serie||'''';
        LV_sSql:=LV_sSql||' AND fec_alta = (SELECT MAX (fec_alta) ';
        LV_sSql:=LV_sSql||' FROM ga_equipaboser ';
        LV_sSql:=LV_sSql||' WHERE num_abonado = '||en_num_abonado;
        LV_sSql:=LV_sSql||'    AND num_serie = '''||ev_num_serie||''')';


        SELECT NUM_ABONADO, num_serie, cod_producto, ind_procequi, fec_alta,
               ind_propiedad, cod_bodega, tip_stock, cod_articulo, ind_equiacc,
               cod_modventa, tip_terminal, cod_uso, cod_cuota, cod_estado, cap_code,
               cod_protocolo, num_velocidad, cod_frecuencia, cod_version,
               num_seriemec, des_equipo, cod_paquete, num_movimiento, cod_causa,
               ind_eqprestado, num_imei, cod_tecnologia, imp_cargo, tip_dto, val_dto
          INTO so_ga_equipaboser.NUM_ABONADO, so_ga_equipaboser.num_serie, so_ga_equipaboser.cod_producto, so_ga_equipaboser.ind_procequi, so_ga_equipaboser.fec_alta,
               so_ga_equipaboser.ind_propiedad, so_ga_equipaboser.cod_bodega, so_ga_equipaboser.tip_stock, so_ga_equipaboser.cod_articulo, so_ga_equipaboser.ind_equiacc,
               so_ga_equipaboser.cod_modventa, so_ga_equipaboser.tip_terminal, so_ga_equipaboser.cod_uso, so_ga_equipaboser.cod_cuota, so_ga_equipaboser.cod_estado, so_ga_equipaboser.cap_code,
               so_ga_equipaboser.cod_protocolo, so_ga_equipaboser.num_velocidad, so_ga_equipaboser.cod_frecuencia, so_ga_equipaboser.cod_version,
               so_ga_equipaboser.num_seriemec, so_ga_equipaboser.des_equipo, so_ga_equipaboser.cod_paquete, so_ga_equipaboser.num_movimiento, so_ga_equipaboser.cod_causa,
               so_ga_equipaboser.ind_eqprestado, so_ga_equipaboser.num_imei, so_ga_equipaboser.cod_tecnologia, so_ga_equipaboser.imp_cargo, so_ga_equipaboser.tip_dto, so_ga_equipaboser.val_dto
          FROM GA_EQUIPABOSER
         WHERE NUM_ABONADO = en_num_abonado
           AND num_serie = ev_num_serie
           AND fec_alta = (SELECT MAX (fec_alta)
                             FROM GA_EQUIPABOSER
                            WHERE NUM_ABONADO = en_num_abonado AND num_serie = ev_num_serie);

        RETURN TRUE;

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := 1;
       SV_mens_retorno := 'No se encontró información equipo abonado.';
       LV_des_error := 'pv_rec_info_equipo_abo_fn(); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, cv_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_rec_info_equipo_abo_fn', LV_sSql, SQLCODE, LV_des_error );
       RETURN FALSE;

    WHEN OTHERS THEN
       SN_cod_retorno := '156';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error := 'pv_rec_info_equipo_abo_fn(); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, cv_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_rec_info_equipo_abo_fn', LV_sSql, SQLCODE, LV_des_error );
       RETURN FALSE;

    END pv_rec_info_equipo_abo_fn;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    FUNCTION pv_val_abon_metro_movil_fn (
      eo_dat_abo        IN              pv_datos_abo_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      Ge_Errores_Pg.evento
    )
    /*
    <Documentacion TipoDoc = "Function">
       <Elemento
          Nombre = "pv_val_abon_metro_movil_fn"
          Fecha modificacion=" "
          Fecha creacion="03-04-2006"
          Programador="Marcelo Godoy S. - Carlos Navarro"
          Diseñador=""
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>
          <Descripcion></Descripcion>
          <Parametros>
             <Entrada>
                <param nom="eo_dat_abo Tipo="OBJETO ">Datos abonado</param>>
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
        LV_des_error      Ge_Errores_Pg.DesEvent;
        LV_sSql           VARCHAR2(4000);
        error_ejecucion   EXCEPTION;
        LD_fec_alta       GA_EQUIPABOSER.fec_alta%TYPE;
        LV_ind_procequi   GA_EQUIPABOSER.ind_procequi%TYPE;
    BEGIN

        SN_cod_retorno := 0;
        SN_num_evento  := 0;
        SV_mens_retorno:= '';

        LV_sSql:= 'SELECT ADD_MONTHS (fec_alta, 6), ind_procequi';
        LV_sSql:=LV_sSql||' FROM ga_equipaboser';
        LV_sSql:=LV_sSql||' WHERE num_abonado = '||eo_dat_abo.NUM_ABONADO;
        LV_sSql:=LV_sSql||' AND fec_alta = (SELECT MIN (fec_alta) ';
        LV_sSql:=LV_sSql||' FROM ga_equipaboser ';
        LV_sSql:=LV_sSql||' WHERE num_abonado = '||eo_dat_abo.NUM_ABONADO||')';
        LV_sSql:=LV_sSql||' AND AND ROWNUM=1';

        SELECT ADD_MONTHS (fec_alta, 6), ind_procequi
        INTO LD_fec_alta, LV_ind_procequi
        FROM GA_EQUIPABOSER
        WHERE NUM_ABONADO = eo_dat_abo.NUM_ABONADO
        AND fec_alta = (SELECT MIN (fec_alta)
                        FROM GA_EQUIPABOSER
                        WHERE NUM_ABONADO = eo_dat_abo.NUM_ABONADO)
        AND ROWNUM=1;

        IF LV_ind_procequi = 'I' THEN
           RETURN TRUE;
        END IF;

        IF (LD_fec_alta > SYSDATE) THEN
           RETURN FALSE;
        ELSE
           RETURN TRUE;
        END IF;

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := '1';
       SV_mens_retorno := 'Error al obtener fecha de alta';
       LV_des_error := 'pv_val_abon_metro_movil_fn(); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, cv_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_val_abon_metro_movil_fn', LV_sSql, SQLCODE, LV_des_error );
       RETURN FALSE;

    WHEN OTHERS THEN
       SN_cod_retorno := '156';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error := 'pv_val_abon_metro_movil_fn(); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, cv_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_val_abon_metro_movil_fn', LV_sSql, SQLCODE, LV_des_error );
       RETURN FALSE;

    END pv_val_abon_metro_movil_fn;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    FUNCTION pv_rec_cant_serv_disp_fn (
      eo_dat_abo        IN              pv_datos_abo_qt,
       eo_sesion         IN              GE_SESION_QT,
      sn_can_servicios  OUT NOCOPY      NUMBER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      Ge_Errores_Pg.evento
    )
    /*
    <Documentacion TipoDoc = "Function">
       <Elemento
          Nombre = "pv_rec_cant_serv_disp_fn"
          Fecha modificacion=" "
          Fecha creacion="03-04-2006"
          Programador="Marcelo Godoy S. - Carlos Navarro"
          Diseñador=""
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>
          <Descripcion></Descripcion>
          <Parametros>
             <Entrada>
                <param nom="eo_dat_abo Tipo="OBJETO ">Datos abonado</param>>
                <param nom="eo_sesion Tipo="OBJETO ">Datos inicio sesion</param>>
             </Entrada>
             <Salida>
                <param nom="sn_can_servicios" Tipo="NUMERICO">cantidad de servicios disponibles</param>
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
        LV_des_error           Ge_Errores_Pg.DesEvent;
        LV_sSql                VARCHAR2(4000);
        LV_tip_relacion        GED_PARAMETROS.val_parametro%TYPE;
        LV_des_parametro       GED_PARAMETROS.des_parametro%TYPE;
        LV_serv_sup_metromovil GED_PARAMETROS.val_parametro%TYPE;
        LV_tip_servicio        GED_CODIGOS.cod_valor%TYPE;
        so_icg_central         icg_central_qt;
        o_ga_equipaboser       ga_equipaboser_qt := NEW ga_equipaboser_qt;
        error_ejecucion        EXCEPTION;
        lnGrupo                 VARCHAR2(5);
    BEGIN

        SN_cod_retorno := 0;
        SN_num_evento  := 0;
        SV_mens_retorno:= '';
        lnGrupo := '';

        IF NOT (Pv_Cambio_Serie_Sb_Pg.pv_obtiene_ged_parametros_fn('TIP_RELACION2', 'GA', LV_tip_relacion, LV_des_parametro, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
            RAISE error_ejecucion;
        END IF;

        IF NOT (Pv_Cambio_Serie_Sb_Pg.pv_obtiene_ged_parametros_fn('SERV_SUP_METROMOVIL', 'GA', LV_serv_sup_metromovil, LV_des_parametro, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
            RAISE error_ejecucion;
        END IF;

        IF NOT (pv_rec_info_central_abo_fn (eo_dat_abo,so_icg_central,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
            RAISE error_ejecucion;
        END IF;
        
        lnGrupo := PV_REC_GRUP_PRESTACION_ABO_FN(eo_dat_abo.NUM_ABONADO, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
        IF lnGrupo = 'TM' THEN
            IF NOT (pv_rec_info_equipo_abo_fn (eo_dat_abo.NUM_ABONADO, eo_dat_abo.num_serie, o_ga_equipaboser, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
                RAISE error_ejecucion;
            END IF;
        END IF;

        IF NOT pv_obtiene_ged_codigos_fn('GA', 'GA_SERVSUPL', 'TIP_SERVICIO', 'NORMAL',LV_tip_servicio,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
            RAISE error_ejecucion;
        END IF;

        LV_sSql  :=' SELECT COUNT (1)';
           LV_sSql  :=LV_sSql || ' FROM ga_servsupl a,';
           LV_sSql  :=LV_sSql || '  ga_actuaserv b,';
           LV_sSql  :=LV_sSql || '  ga_tarifas c,';
           LV_sSql  :=LV_sSql || '  ge_monedas d,';
           LV_sSql  :=LV_sSql || '  ga_actuaserv e,';
           LV_sSql  :=LV_sSql || '  ga_tarifas f,';
           LV_sSql  :=LV_sSql || '  ge_monedas g,';
           --LV_sSql  :=LV_sSql || '  icg_serviciotercen h,';
           LV_sSql  :=LV_sSql || '  ga_servuso i,';
           LV_sSql  :=LV_sSql || '  gad_servsup_plan j';
           LV_sSql  :=LV_sSql || '  WHERE a.cod_producto = 1';
           LV_sSql  :=LV_sSql || '  AND a.cod_producto = b.cod_producto(+)';
           LV_sSql  :=LV_sSql || '  AND a.cod_servicio = b.cod_servicio(+)';
           LV_sSql  :=LV_sSql || '  AND a.cod_nivel > 0';
           LV_sSql  :=LV_sSql || '  AND a.tip_servicio = '''||LV_tip_servicio||'''';
           LV_sSql  :=LV_sSql || '  AND b.cod_actabo(+) = '''||cv_serv_suplabo||'''';
           LV_sSql  :=LV_sSql || '  AND b.cod_tipserv(+) = '''||cv_serv_suplementario||'''';
           LV_sSql  :=LV_sSql || '  AND b.cod_producto = c.cod_producto(+)';
           LV_sSql  :=LV_sSql || '  AND b.cod_actabo = c.cod_actabo(+)';
           LV_sSql  :=LV_sSql || '  AND b.cod_tipserv = c.cod_tipserv(+)';
           LV_sSql  :=LV_sSql || '  AND b.cod_servicio = c.cod_servicio(+)';
           LV_sSql  :=LV_sSql || '  AND c.cod_planserv(+) = '''||eo_dat_abo.cod_planserv||'''';
           LV_sSql  :=LV_sSql || '  AND SYSDATE BETWEEN c.fec_desde(+) AND NVL (c.fec_hasta(+), SYSDATE)';
           LV_sSql  :=LV_sSql || '  AND c.cod_moneda = d.cod_moneda(+)';
           LV_sSql  :=LV_sSql || '  AND a.cod_producto = e.cod_producto(+)';
           LV_sSql  :=LV_sSql || '  AND a.cod_servicio = e.cod_servicio(+)';
           LV_sSql  :=LV_sSql || '  AND e.cod_actabo(+) = '''||cv_facturacion||'''';
           LV_sSql  :=LV_sSql || '  AND e.cod_tipserv(+) = '''||cv_serv_suplementario||'''';
          LV_sSql  :=LV_sSql || '  AND e.cod_producto = f.cod_producto(+)';
        LV_sSql  :=LV_sSql || '  AND e.cod_actabo = f.cod_actabo(+)';
           LV_sSql  :=LV_sSql || '  AND e.cod_tipserv = f.cod_tipserv(+)';
           LV_sSql  :=LV_sSql || '  AND e.cod_servicio = f.cod_servicio(+)';
           LV_sSql  :=LV_sSql || '  AND f.cod_planserv(+) = '''||eo_dat_abo.cod_planserv||'''';
           LV_sSql  :=LV_sSql || '  AND SYSDATE BETWEEN f.fec_desde(+) AND NVL (f.fec_hasta(+), SYSDATE)';
           LV_sSql  :=LV_sSql || '  AND f.cod_moneda = g.cod_moneda(+)';
           --LV_sSql  :=LV_sSql || '  AND h.cod_producto = a.cod_producto';
           --LV_sSql  :=LV_sSql || '  AND h.tip_terminal = '''||eo_dat_abo.tip_terminal||'''';
           --LV_sSql  :=LV_sSql || '  AND h.cod_sistema = '||so_icg_central.cod_sistema;
           --LV_sSql  :=LV_sSql || '  AND h.cod_servicio = a.cod_servsupl';
           --LV_sSql  :=LV_sSql || '  AND h.tip_tecnologia = '''||eo_dat_abo.cod_tecnologia||'''';
           LV_sSql  :=LV_sSql || '  AND i.cod_producto = a.cod_producto';
           LV_sSql  :=LV_sSql || '  AND i.cod_servicio = a.cod_servicio';
           LV_sSql  :=LV_sSql || '  AND i.cod_uso = '||eo_dat_abo.cod_uso;
           LV_sSql  :=LV_sSql || '  AND j.cod_producto = a.cod_producto';
           LV_sSql  :=LV_sSql || '  AND j.cod_servicio = a.cod_servicio';
           LV_sSql  :=LV_sSql || '  AND j.cod_plantarif = '''||eo_dat_abo.cod_plantarif||'''';
           LV_sSql  :=LV_sSql || '  AND SYSDATE BETWEEN j.fec_desde AND NVL (j.fec_hasta, SYSDATE)';
           LV_sSql  :=LV_sSql || '  AND j.tip_relacion = '''||LV_tip_relacion||'''';
           LV_sSql  :=LV_sSql || '  AND NVL (a.cod_servicio, '' '') NOT IN (SELECT NVL (cod_servicio, '' '')';
           LV_sSql  :=LV_sSql || '  FROM ga_tiposeguro';
           LV_sSql  :=LV_sSql || '  WHERE cod_producto = a.cod_producto)';
           LV_sSql  :=LV_sSql || '  AND NVL (a.cod_servicio, '' '') NOT IN (SELECT NVL (cod_serviciodes, '' '')';
           LV_sSql  :=LV_sSql || '  FROM ga_tiposeguro';
           LV_sSql  :=LV_sSql || '  WHERE cod_producto = a.cod_producto)';
           LV_sSql  :=LV_sSql || '  AND a.cod_servicio NOT IN (';
           LV_sSql  :=LV_sSql || '  SELECT cod_servicio';
           LV_sSql  :=LV_sSql || '  FROM ga_servsuplabo';
           LV_sSql  :=LV_sSql || '  WHERE num_abonado = '||eo_dat_abo.NUM_ABONADO;
           LV_sSql  :=LV_sSql || '  AND ind_estado < 3)';
        
        IF lnGrupo = 'TM' THEN
            IF o_ga_equipaboser.cod_articulo IS NOT NULL THEN
               LV_sSql  :=LV_sSql || '  AND a.cod_servicio NOT IN (SELECT DISTINCT(cod_servicio)';
               LV_sSql  :=LV_sSql || '  FROM ga_serv_atributos a, al_atributos_articulos b';
               LV_sSql  :=LV_sSql || '  WHERE a.cod_atributo = b.cod_atributo';
               LV_sSql  :=LV_sSql || '  AND b.cod_articulo <> '||o_ga_equipaboser.cod_articulo;
               LV_sSql  :=LV_sSql || '  AND b.tip_articulo = '||cv_prod_celular;
               LV_sSql  :=LV_sSql || '  AND cod_servicio NOT IN (SELECT DISTINCT(cod_servicio)';
               LV_sSql  :=LV_sSql || '  FROM ga_serv_atributos a, al_atributos_articulos b';
               LV_sSql  :=LV_sSql || '  WHERE a.cod_atributo = b.cod_atributo';
               LV_sSql  :=LV_sSql || '  AND b.cod_articulo = '||o_ga_equipaboser.cod_articulo;
               LV_sSql  :=LV_sSql || '  AND b.tip_articulo = '||cv_prod_celular||'))';
            END IF;
        END IF;

        IF NOT (Pv_Cambio_Serie_Sb_Pg.pv_valida_permisos_fn (eo_sesion.nom_usuario,eo_sesion.cod_programa,eo_sesion.num_version,'COD_PROC_SERVSUP',sn_cod_retorno,sv_mens_retorno, sn_num_evento)) THEN
           LV_sSql  :=LV_sSql || '  AND A.IND_COMERC = 1';
        END IF;

        IF (eo_dat_abo.cod_uso = cv_uso_amistar) THEN
               LV_sSql  :=LV_sSql || '  AND A.COD_APLIC LIKE ''%P%''';

            IF NOT (pv_val_abon_metro_movil_fn(eo_dat_abo, sn_cod_retorno,sv_mens_retorno, sn_num_evento)) THEN
               LV_sSql  :=LV_sSql || '  AND A.COD_SERVSUPL <> '''||LV_serv_sup_metromovil||'''';
            END IF;

        ELSE
            LV_sSql  :=LV_sSql || ' AND (( A.COD_APLIC IS NULL) OR (COD_APLIC LIKE ''%C%''))';
        END IF;

        EXECUTE IMMEDIATE LV_sSql INTO sn_can_servicios;

        RETURN TRUE;

    EXCEPTION
    WHEN error_ejecucion THEN
       SN_cod_retorno := '1';
       SV_mens_retorno := 'No encontró ....';
       LV_des_error := 'pv_rec_cant_serv_disp_fn(); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, cv_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_rec_cant_serv_disp_fn', LV_sSql, SQLCODE, LV_des_error );
       RETURN FALSE;

    WHEN OTHERS THEN
       SN_cod_retorno := '156';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error := 'pv_rec_cant_serv_disp_fn(); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, cv_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_rec_cant_serv_disp_fn', LV_sSql, SQLCODE, LV_des_error );
       RETURN FALSE;

    END pv_rec_cant_serv_disp_fn;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    PROCEDURE pv_rec_serv_disp_pr (
      eo_dat_abo        IN OUT NOCOPY   pv_datos_abo_qt,
       eo_sesion         IN              GE_SESION_QT,
      sc_servicios      OUT             refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      Ge_Errores_Pg.evento
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
                <param nom="eo_dat_abo Tipo="OBJETO ">Datos abonado</param>>
                <param nom="eo_sesion Tipo="OBJETO ">Datos inicio sesion</param>>
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
        LV_des_error           Ge_Errores_Pg.DesEvent;
        LV_sSql                VARCHAR2(4000);
        LV_tip_relacion        GED_PARAMETROS.val_parametro%TYPE;
        LV_des_parametro       GED_PARAMETROS.des_parametro%TYPE;
        LV_serv_sup_metromovil GED_PARAMETROS.val_parametro%TYPE;
        LN_can_servicios       NUMBER;
        LV_tip_servicio        GED_CODIGOS.cod_valor%TYPE;
        so_icg_central         icg_central_qt    := NEW icg_central_qt;
        o_ga_equipaboser       ga_equipaboser_qt := NEW ga_equipaboser_qt;
        lnGrupo                 VARCHAR2(5);
        error_ejecucion        EXCEPTION;

    BEGIN

        SN_cod_retorno := 0;
        SN_num_evento  := 0;
        SV_mens_retorno:= '';
        lnGrupo        :='';
        Pv_Cambio_Serie_Sb_Pg.pv_rec_info_abonado_pr(eo_dat_abo,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        IF (SN_cod_retorno <> 0) THEN
            RAISE error_ejecucion;
        END IF;

        IF NOT (pv_rec_cant_serv_disp_fn (eo_dat_abo,eo_sesion,LN_can_servicios,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
           RAISE error_ejecucion;
        END IF;

        IF NOT (Pv_Cambio_Serie_Sb_Pg.pv_obtiene_ged_parametros_fn('TIP_RELACION2', 'GA', LV_tip_relacion, LV_des_parametro, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
            RAISE error_ejecucion;
        END IF;

        IF NOT (Pv_Cambio_Serie_Sb_Pg.pv_obtiene_ged_parametros_fn('SERV_SUP_METROMOVIL', 'GA', LV_serv_sup_metromovil, LV_des_parametro, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
            RAISE error_ejecucion;
        END IF;

        IF NOT (pv_rec_info_central_abo_fn (eo_dat_abo,so_icg_central,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
            RAISE error_ejecucion;
        END IF;
        lnGrupo := PV_REC_GRUP_PRESTACION_ABO_FN(eo_dat_abo.NUM_ABONADO, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
        IF lnGrupo = 'TM' THEN
            IF NOT (pv_rec_info_equipo_abo_fn (eo_dat_abo.NUM_ABONADO, eo_dat_abo.num_serie, o_ga_equipaboser, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
                RAISE error_ejecucion;
            END IF;
        END IF;
        IF NOT pv_obtiene_ged_codigos_fn('GA', 'GA_SERVSUPL', 'TIP_SERVICIO', 'NORMAL',LV_tip_servicio,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
            RAISE error_ejecucion;
        END IF;

       LV_sSql  :=LV_sSql || ' SELECT A.COD_SERVICIO, A.DES_SERVICIO, A.COD_SERVSUPL, A.COD_NIVEL, C.IMP_TARIFA, D.DES_MONEDA, B.COD_CONCEPTO, F.IMP_TARIFA, G.DES_MONEDA, E.COD_CONCEPTO, ''S'',A.IND_TUXEDO';
       LV_sSql  :=LV_sSql || ' FROM GA_SERVSUPL A, GA_ACTUASERV B, GA_TARIFAS C,';
       LV_sSql  :=LV_sSql || ' GE_MONEDAS D, GA_ACTUASERV E, GA_TARIFAS F,';
       LV_sSql  :=LV_sSql || ' GE_MONEDAS G,  GA_SERVUSO I';

        IF LN_can_servicios = 0 THEN
           LV_sSql  :=LV_sSql || ' , ICG_SERVICIOTERCEN H ';
        else
           LV_sSql  :=LV_sSql || ' , GAD_SERVSUP_PLAN J  ';
           
        END IF;

       LV_sSql  :=LV_sSql || ' WHERE A.COD_PRODUCTO = '||cv_prod_celular;
   
       --LV_sSql  :=LV_sSql || ' AND (A.COD_SERVSUPL,A.COD_NIVEL) not in (SELECT NOM_COLUMNA,COD_VALOR FROM GED_CODIGOS WHERE COD_MODULO =''IC'' AND NOM_TABLA = ''SRV_CORREO_MOV'' OR  NOM_TABLA  = ''SRV_BLACKBERRY'' group by NOM_COLUMNA,COD_VALOR)';
       --LV_sSql  :=LV_sSql || ' AND A.COD_SERVICIO not in (SELECT COD_VALOR FROM GED_CODIGOS WHERE COD_MODULO = ''GA'' AND NOM_TABLA = ''GA_SERVSUPL'' AND NOM_COLUMNA = ''COD_SERVICIO'')';
       
       LV_sSql  :=LV_sSql || ' AND A.COD_PRODUCTO = B.COD_PRODUCTO(+)';
       LV_sSql  :=LV_sSql || ' AND A.COD_SERVICIO = B.COD_SERVICIO(+)';
       LV_sSql  :=LV_sSql || ' AND A.COD_NIVEL > 0';
       LV_sSql  :=LV_sSql || ' AND a.tip_servicio = '''||LV_tip_servicio||'''';
       LV_sSql  :=LV_sSql || ' AND b.cod_actabo(+) = '''||cv_serv_suplabo||'''';
       LV_sSql  :=LV_sSql || ' AND b.cod_tipserv(+) = '''||cv_serv_suplementario||'''';
       LV_sSql  :=LV_sSql || ' AND B.COD_PRODUCTO = C.COD_PRODUCTO(+)';
       LV_sSql  :=LV_sSql || ' AND B.COD_ACTABO = C.COD_ACTABO(+)';
       LV_sSql  :=LV_sSql || ' AND B.COD_TIPSERV = C.COD_TIPSERV(+)';
       LV_sSql  :=LV_sSql || ' AND B.COD_SERVICIO = C.COD_SERVICIO(+)';
       LV_sSql  :=LV_sSql || ' AND C.COD_PLANSERV(+) = '''||eo_dat_abo.cod_planserv||'''';
       LV_sSql  :=LV_sSql || ' AND SYSDATE BETWEEN C.FEC_DESDE(+) AND NVL(C.FEC_HASTA(+), SYSDATE)';
       LV_sSql  :=LV_sSql || ' AND C.COD_MONEDA = D.COD_MONEDA(+)';
       LV_sSql  :=LV_sSql || ' AND A.COD_PRODUCTO = E.COD_PRODUCTO(+)';
       LV_sSql  :=LV_sSql || ' AND A.COD_SERVICIO = E.COD_SERVICIO(+)';
       LV_sSql  :=LV_sSql || ' AND E.COD_ACTABO(+) = '''||cv_facturacion||'''';
       LV_sSql  :=LV_sSql || ' AND E.COD_TIPSERV(+) = '''||cv_serv_suplementario||'''';
       LV_sSql  :=LV_sSql || ' AND E.COD_PRODUCTO = F.COD_PRODUCTO(+)';
       LV_sSql  :=LV_sSql || ' AND E.COD_ACTABO = F.COD_ACTABO(+)';
       LV_sSql  :=LV_sSql || ' AND E.COD_TIPSERV = F.COD_TIPSERV(+)';
       LV_sSql  :=LV_sSql || ' AND E.COD_SERVICIO = F.COD_SERVICIO(+)';
       LV_sSql  :=LV_sSql || ' AND F.COD_PLANSERV(+) = '''||eo_dat_abo.cod_planserv||'''';
       LV_sSql  :=LV_sSql || ' AND SYSDATE BETWEEN F.FEC_DESDE(+) AND NVL(F.FEC_HASTA(+), SYSDATE)';
       LV_sSql  :=LV_sSql || ' AND F.COD_MONEDA = G.COD_MONEDA(+)';
       
       IF LN_can_servicios = 0 THEN 
       
                   LV_sSql  :=LV_sSql || ' AND H.COD_PRODUCTO = A.COD_PRODUCTO';
                   LV_sSql  :=LV_sSql || ' AND H.TIP_TERMINAL = '''||eo_dat_abo.tip_terminal||'''';
                   LV_sSql  :=LV_sSql || ' AND H.COD_SISTEMA = '||so_icg_central.cod_sistema;
                   LV_sSql  :=LV_sSql || ' AND H.COD_SERVICIO = A.COD_SERVSUPL';
                   LV_sSql  :=LV_sSql || ' AND H.TIP_TECNOLOGIA= '''||eo_dat_abo.cod_tecnologia||'''';
                   
                   
       END IF;
       
       LV_sSql  :=LV_sSql || ' AND I.COD_PRODUCTO = A.COD_PRODUCTO';
       LV_sSql  :=LV_sSql || ' AND I.COD_SERVICIO = A.COD_SERVICIO';
       LV_sSql  :=LV_sSql || ' AND I.COD_USO = '''||eo_dat_abo.cod_uso||'''';
       LV_sSql  :=LV_sSql || ' AND NVL(A.COD_SERVICIO, '' '') NOT IN (SELECT NVL(COD_SERVICIO, '' '')';
       LV_sSql  :=LV_sSql || ' FROM GA_TIPOSEGURO';
       LV_sSql  :=LV_sSql || ' WHERE COD_PRODUCTO = A.COD_PRODUCTO)';
       LV_sSql  :=LV_sSql || ' AND NVL(A.COD_SERVICIO, '' '') NOT IN (SELECT NVL(COD_SERVICIODES, '' '')';
       LV_sSql  :=LV_sSql || ' FROM GA_TIPOSEGURO WHERE COD_PRODUCTO = A.COD_PRODUCTO)';
       LV_sSql  :=LV_sSql || ' AND A.COD_SERVICIO NOT IN (SELECT COD_SERVICIO FROM GA_SERVSUPLABO WHERE NUM_ABONADO = '||eo_dat_abo.NUM_ABONADO||' AND IND_ESTADO < 3 )';


       IF LN_can_servicios > 0 THEN
           LV_sSql  :=LV_sSql || ' AND J.COD_PRODUCTO = A.COD_PRODUCTO';
           LV_sSql  :=LV_sSql || ' AND J.COD_SERVICIO = A.COD_SERVICIO';
           LV_sSql  :=LV_sSql || ' AND J.COD_PLANTARIF = '''||eo_dat_abo.cod_plantarif||'''';
           LV_sSql  :=LV_sSql || ' AND SYSDATE BETWEEN J.FEC_DESDE AND NVL(J.FEC_HASTA, SYSDATE)';
           LV_sSql  :=LV_sSql || ' AND J.TIP_RELACION = '''||LV_tip_relacion||'''';
       END IF;
       
       
      IF lnGrupo = 'TM' THEN  
           IF o_ga_equipaboser.cod_articulo IS NOT NULL THEN
               LV_sSql  :=LV_sSql || ' AND A.COD_SERVICIO NOT IN (SELECT DISTINCT(COD_SERVICIO)';
               LV_sSql  :=LV_sSql || ' FROM GA_SERV_ATRIBUTOS A, AL_ATRIBUTOS_ARTICULOS B';
               LV_sSql  :=LV_sSql || ' WHERE a.COD_ATRIBUTO = B.COD_ATRIBUTO AND B.Cod_Articulo <> '||o_ga_equipaboser.cod_articulo||' AND B.TIP_ARTICULO = '||cv_prod_celular;
               LV_sSql  :=LV_sSql || ' AND COD_SERVICIO NOT IN (SELECT DISTINCT(COD_SERVICIO)';
               LV_sSql  :=LV_sSql || ' FROM GA_SERV_ATRIBUTOS A, AL_ATRIBUTOS_ARTICULOS B';
               LV_sSql  :=LV_sSql || ' WHERE A.COD_ATRIBUTO = B.COD_ATRIBUTO  AND B.COD_ARTICULO = '||o_ga_equipaboser.cod_articulo||' AND B.TIP_ARTICULO = '||cv_prod_celular||'))';
           END IF;
       END IF;

       IF NOT (Pv_Cambio_Serie_Sb_Pg.pv_valida_permisos_fn (eo_sesion.nom_usuario,eo_sesion.cod_programa,eo_sesion.num_version,'COD_PROC_SERVSUP',sn_cod_retorno,sv_mens_retorno, sn_num_evento)) THEN
          LV_sSql  :=LV_sSql || ' AND A.IND_COMERC = 1';
       END IF;

       IF (eo_dat_abo.cod_uso = cv_uso_amistar) THEN
              LV_sSql  :=LV_sSql || '  AND A.COD_APLIC LIKE ''%P%''';

           IF NOT (pv_val_abon_metro_movil_fn(eo_dat_abo, sn_cod_retorno,sv_mens_retorno, sn_num_evento)) THEN
              LV_sSql  :=LV_sSql || '  AND A.COD_SERVSUPL <> '''||LV_serv_sup_metromovil||'''';
           END IF;

       ELSE
           LV_sSql  :=LV_sSql || ' AND (( A.COD_APLIC IS NULL) OR (COD_APLIC LIKE ''%C%''))';
       END IF;

       LV_sSql  :=LV_sSql || ' ORDER BY A.IND_PRIORIDAD,A.DES_SERVICIO';

       OPEN sc_servicios FOR LV_sSql;

    EXCEPTION
    WHEN error_ejecucion THEN
       SN_cod_retorno := '1';
       SV_mens_retorno := 'No se encontró ....';
       LV_des_error := 'pv_rec_serv_disp_pr(); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, cv_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_rec_serv_disp_pr', LV_sSql, SQLCODE, LV_des_error );

    WHEN OTHERS THEN
       SN_cod_retorno := '156';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error := 'pv_rec_serv_disp_pr(); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, cv_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_rec_serv_disp_pr', LV_sSql, SQLCODE, LV_des_error );

    END pv_rec_serv_disp_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE pv_reglas_valid_vig_ss_pr(
                                    eo_dat_abo                 IN OUT NOCOPY  pv_datos_abo_qt,
                                    so_cursor                 OUT NOCOPY        refcursor,
                                       sn_cod_retorno           OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
                                       sv_mens_retorno          OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
                                       sn_num_evento            OUT NOCOPY        Ge_Errores_Pg.evento)
    IS
    /*
    <Documentacion
      TipoDoc = "Procedure">>
       <Elemento
          Nombre = "GA_reglas_valid_vig_ss_PR
          Lenguaje="PL/SQL"
          Fecha="10-08-2006"
          Version="La del package"
          Dise?ador="Andres Osorio"
          Programador="Oscar Jorquera"
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>>
          <Descripcion></Descripcion>>
          <Parametros>
             <Entrada>
                <param nom="so_servsupl" Tipo="estructura">estructura de cliente</param>>
             </Entrada>
             <Salida>
                <param nom="" Tipo=""></param>>
                <param nom="sn_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                <param nom="sv_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                <param nom="sn_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
             </Salida>
          </Parametros>
       </Elemento>
    </Documentacion>
    */

    LV_des_error       Ge_Errores_Pg.DesEvent;
    lv_ssql               Ge_Errores_Pg.vQuery;
    LN_codSistema       icg_central.cod_sistema%TYPE;
    error_exception       exception;

    BEGIN
        sn_cod_retorno     := 0;
        sv_mens_retorno := NULL;
        sn_num_evento     := 0;

        BEGIN
            lv_ssql := 'SELECT a.cod_sistema';
            lv_ssql := lv_ssql || ' FROM icg_central a';
            lv_ssql := lv_ssql || ' WHERE a.cod_producto = 1 AND';
            lv_ssql := lv_ssql || ' a.cod_central = ' || eo_dat_abo.cod_central;

            SELECT a.cod_sistema
            INTO LN_codSistema
            FROM icg_central a
            WHERE a.cod_producto = 1 AND
                  a.cod_central = eo_dat_abo.cod_central;
        EXCEPTION
            WHEN OTHERS THEN
                 raise error_exception;
        END;

        lv_ssql := 'SELECT a.cod_producto,';
        lv_ssql := lv_ssql || ' a.cod_servicio,';
        lv_ssql := lv_ssql || ' a.cod_servdef,';
        lv_ssql := lv_ssql || ' a.nom_usuario,';
        lv_ssql := lv_ssql || ' a.cod_servorig,';
        lv_ssql := lv_ssql || ' a.tip_relacion,';
        lv_ssql := lv_ssql || ' a.cod_actabo';
        lv_ssql := lv_ssql || ' FROM ga_servsup_def a, ga_servsupl b, icg_serviciotercen c';
        lv_ssql := lv_ssql || ' WHERE a.cod_producto = 1 AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, ' || SYSDATE || ') AND';
        lv_ssql := lv_ssql || ' a.cod_servdef = b.cod_servicio AND';
        lv_ssql := lv_ssql || ' b.cod_producto = 1 AND';
        lv_ssql := lv_ssql || ' a.cod_producto = b.cod_producto AND';
        lv_ssql := lv_ssql || ' b.cod_producto = c.cod_producto AND';
        lv_ssql := lv_ssql || ' b.cod_servsupl = c.cod_servicio AND';
        lv_ssql := lv_ssql || ' c.cod_sistema = ' || LN_codSistema || ' AND';
        lv_ssql := lv_ssql || ' c.tip_terminal = ' || eo_dat_abo.tip_terminal || ' AND';
        lv_ssql := lv_ssql || ' c.tip_tecnologia = ' || eo_dat_abo.cod_tecnologia;

        OPEN so_cursor FOR
            SELECT a.cod_producto,
                   a.cod_servicio,
                   a.cod_servdef,
                   a.nom_usuario,
                   a.cod_servorig,
                   a.tip_relacion,
                   a.cod_actabo
            FROM ga_servsup_def a, ga_servsupl b, icg_serviciotercen c
            WHERE a.cod_producto = 1 AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE) AND
                  a.cod_servdef = b.cod_servicio AND
                  b.cod_producto = 1 AND
                  a.cod_producto = b.cod_producto AND
                  b.cod_producto = c.cod_producto AND
                  b.cod_servsupl = c.cod_servicio AND
                  c.cod_sistema = LN_codSistema AND
                  c.tip_terminal = eo_dat_abo.tip_terminal AND
                  c.tip_tecnologia = eo_dat_abo.cod_tecnologia;

    EXCEPTION
      WHEN error_exception THEN
          sn_cod_retorno := 904;
          IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,sv_mens_retorno) THEN
             sv_mens_retorno := cv_error_no_clasif;
          END IF;
          LV_des_error   := ' pv_reglas_valid_vig_ss_pr (obteniendo cod_sistema); - ' || SQLERRM;
          sn_num_evento  := Ge_Errores_Pg.grabarpl( sn_num_evento, cv_cod_modulo, sv_mens_retorno, cv_version, USER, 'PV_SERVSUPL_SB_PG.pv_reglas_valid_vig_ss_pr', lv_ssql, sn_cod_retorno, LV_des_error );

      WHEN NO_DATA_FOUND THEN
          NULL;
      WHEN OTHERS THEN
          sn_cod_retorno := 904;
          IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,sv_mens_retorno) THEN
             sv_mens_retorno := cv_error_no_clasif;
          END IF;
          LV_des_error   := ' pv_reglas_valid_vig_ss_pr ('||'); - ' || SQLERRM;
          sn_num_evento  := Ge_Errores_Pg.grabarpl( sn_num_evento, cv_cod_modulo, sv_mens_retorno, cv_version, USER, 'PV_SERVSUPL_SB_PG.pv_reglas_valid_vig_ss_pr', lv_ssql, sn_cod_retorno, LV_des_error );

END pv_reglas_valid_vig_ss_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION pv_obtener_codtecnico_fn (EV_ss_comercial   IN  VARCHAR2,
                                  EV_separador         IN  VARCHAR2,
                                  SV_ss_tecnico      OUT NOCOPY   VARCHAR2,
                                  SN_cod_retorno     OUT NOCOPY   Ge_Errores_Pg.CodError,
                                  SV_mens_retorno    OUT NOCOPY   Ge_Errores_Pg.MsgError,
                                  SN_num_evento      OUT NOCOPY   Ge_Errores_Pg.Evento)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "pv_obtener_codtecnico_fn"
      Lenguaje="PL/SQL"
      Fecha="02-05-2005"
      Versión="1.0"
      Diseñador="Fernando Garcia"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Obtener codigos tecnicos a partir de codigos comerciales de serv.supl.</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_ss_comercial" Tipo="CARACTER">Cadena con códigos comerciales</param>
            <param nom="EV_separador" Tipo="CARACTER">Separador de codigos</param>
         </Entrada>
         <Salida>
            <param nom="SV_ss_tecnico" Tipo="CARACTER">Cadena con códigos tecnicos </param>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
AS
    error_ejecucion   EXCEPTION;
    V_des_error          Ge_Errores_Pg.DesEvent;
    sSql              Ge_Errores_Pg.vQuery;
    SN_numooss          CI_ORSERV.NUM_OS%TYPE;
    SV_deserror       Ge_Errores_Pg.DesEvent;
    vn_Pos                 NUMBER;
    vn_MaxParam       NUMBER;
    vv_Caracter       VARCHAR2(1);
    vv_CodServicio      GA_SERVSUPL.cod_servicio%TYPE;
    LV_cod_tecnico      VARCHAR2(6);
    LV_cod_servsupl   GA_SERVSUPL.cod_servsupl%TYPE;
    LN_cod_nivel       GA_SERVSUPL.cod_nivel%TYPE;
    CN_largoquery      CONSTANT   NUMBER:=3000;
    CN_largoerrtec      CONSTANT   NUMBER:=500;

    BEGIN
       --Inicializar variables.....
       SN_cod_retorno:= '0';
          SN_num_evento:= 0;
       SV_ss_tecnico:=EV_separador;

       sSql:='vn_MaxParam:=LENGTH('||EV_ss_comercial||')';
       vn_MaxParam:=LENGTH(EV_ss_comercial);
       sSql:='Largo de servicios ingresados menor que 3...vn_MaxParam<3';
       IF  vn_MaxParam<3 THEN
              RAISE error_ejecucion;
       END IF;

       IF SUBSTR(EV_ss_comercial,1,1)<>EV_separador THEN
           sSql:='Validar primer caracter sea igual al separador..'||SUBSTR(EV_ss_comercial,1,1)||'<>'||EV_separador;
              RAISE error_ejecucion;
       ELSE
          IF SUBSTR(EV_ss_comercial,vn_MaxParam,1)<>EV_separador THEN
             sSql:='Validar ultimo caracter sea igual al separador...'||SUBSTR(EV_ss_comercial,1,vn_MaxParam)||'<>'||EV_separador;
                RAISE error_ejecucion;
          END IF;
       END IF;
       vv_CodServicio:='';
       sSql:=SUBSTR('Recorriendo lista de servicios..'||EV_ss_comercial,1,CN_largoquery);
       FOR vn_Pos IN 2..vn_MaxParam LOOP
            vv_Caracter:=SUBSTR(EV_ss_comercial,vn_Pos,1);
            IF LENGTH(vv_Caracter)<>0  THEN
               IF vv_Caracter<>EV_separador THEN
                  vv_CodServicio:=vv_CodServicio||vv_Caracter;
                 ELSE
                    IF LENGTH(vv_CodServicio)<>0 THEN
                       sSql:='SELECT  COD_SERVSUPL, COD_NIVEL '||
                                ' FROM GA_SERVSUPL '||
                             ' WHERE COD_SERVICIO='||vv_CodServicio;
                       SELECT  COD_SERVSUPL, COD_NIVEL
                         INTO LV_cod_servsupl,LN_cod_nivel
                         FROM GA_SERVSUPL
                        WHERE COD_SERVICIO=vv_CodServicio;
                        sSql:='SV_ss_tecnico:='||SV_ss_tecnico||LV_cod_servsupl||EV_separador||trim(TO_CHAR(LN_cod_nivel,'0009'))||EV_separador;
                        SV_ss_tecnico:=SV_ss_tecnico||LV_cod_servsupl||EV_separador||trim(TO_CHAR(LN_cod_nivel,'0009'))||EV_separador;
                        vv_CodServicio:=NULL;
                     ELSE
                       sSql:='Largo del servicio leido es cero';
                        RAISE error_ejecucion;
                    END IF;
               END IF;
            ELSE
               sSql:='Caracter leido es nulo.';
               RAISE error_ejecucion;
            END IF;
        END LOOP;
          RETURN TRUE;

   EXCEPTION
   WHEN error_ejecucion THEN
                SN_cod_retorno := '302'; -- Nuevo Error
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error := SUBSTR('error_ejecucion: PV_obtener_codtecnico_fn('||EV_ss_comercial||'); - ' || SQLERRM,1,CN_largoerrtec);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'SS', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'Pv_Serv_Suplementario_Sb_Pg.pv_obtener_codtecnico_fn', sSql, SQLCODE, V_des_error );
                RETURN FALSE;

   WHEN NO_DATA_FOUND THEN
                SN_cod_retorno := '302'; -- Nuevo Error
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error := 'no_data_found: pv_obtener_codtecnico_fn('||EV_ss_comercial||'); - ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'SS', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'Pv_Serv_Suplementario_Sb_Pg.pv_obtener_codtecnico_fn', sSql, SQLCODE, V_des_error );
                RETURN FALSE;

   WHEN OTHERS THEN
                SN_cod_retorno := '302'; -- Nuevo Error
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error := 'Others: pv_obtener_codtecnico_fn('||EV_ss_comercial||'); - ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'SS', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'Pv_Serv_Suplementario_Sb_Pg.pv_obtener_codtecnico_fn', sSql, SQLCODE, V_des_error );
                RETURN FALSE;

END pv_obtener_codtecnico_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION pv_obtieneCadenaSSTecn_fn(EV_ss_comercial IN VARCHAR2,
                                    SV_CadenaSSTecn OUT NOCOPY VARCHAR2,
                                   SN_cod_retorno  OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                   SV_mens_retorno OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                   SN_num_evento   OUT NOCOPY      Ge_Errores_Pg.evento)
RETURN BOOLEAN
    /*
    <Documentacion TipoDoc = "Function">
       <Elemento
          Nombre = "pv_act_ss_fn"
          Fecha modificacion=" "
          Fecha creacion="25-03-2008"
          Programador=""
          Diseñador=""
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>
          <Descripcion>Inscribe orden de servicio para la activación de servicios suplementarios</Descripcion>
          <Parametros>
             <Entrada>
                <param nom="EN_num_abonado" Tipo="NUMERICO">Número abonado</param>
                <param nom="EN_num_celular" Tipo="NUMERICO">Número de celular del abonado</param>
                <param nom="EV_ss_comercial" Tipo="CARACTER">Servivios comerciales a activar</param>
                <param nom="EN_secuencia" Tipo="NUMERICO">Número de secuencia de la OOSS</param>
                <param nom="EN_cod_ooss_ss" Tipo="NUMERICO">Código de la orden de servicio</param>
                <param nom="EN_imp_total" Tipo="NUMERICO">Importe de rebaja de saldo por concepto de SS para prepagos</param>
             </Entrada>
             <Salida>
                <param>N/A</param>
             </Salida>
          </Parametros>
       </Elemento>
    </Documentacion>
    */
IS
        LV_cadena_servicio_tecnico   VARCHAR2(4000);
        LV_des_error                  Ge_Errores_Pg.DesEvent;
        LV_sSql                       VARCHAR2(4000);
        ERROR_PROCESO                    EXCEPTION;
        LV_arr_servicio               SISCEL.GE_TABTYPE_VCH2ARRAY:= SISCEL.GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
        LV_arr_Grupo                 SISCEL.GE_TABTYPE_VCH2ARRAY:= SISCEL.GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
        LV_arr_Nivel                 SISCEL.GE_TABTYPE_VCH2ARRAY:= SISCEL.GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
        LN_total_serv                   NUMBER;
        LV_proc                         VARCHAR2(50);
        LV_tabla                     VARCHAR2(50);
        LV_act                         VARCHAR2(2);
        LV_sqlcode                     VARCHAR2(50);
        LV_sqlerrm                     VARCHAR2(250);
        LV_error                     ge_errores_td.cod_msgerror%TYPE;

BEGIN
        LV_sSql:= 'PV_OBTENER_CODTECNICO_FN (' || EV_ss_comercial
                  || ', ' || CV_separador
                  || ', ' || LV_cadena_servicio_tecnico
                  || ', ' || SN_cod_retorno
                  || ', ' || SV_mens_retorno
                  || ', ' || SN_num_evento || ')';

        IF PV_OBTENER_CODTECNICO_FN (EV_ss_comercial,CV_separador, LV_cadena_servicio_tecnico, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN

            LV_sSql:= 'PV_GENERAL_OOSS_PG.PV_REC_SERV_FN';

            IF Pv_General_Ooss_Pg.PV_REC_SERV_FN(ev_ss_comercial, LV_arr_servicio, LN_total_serv, LV_error, LV_proc, LV_tabla, LV_act, LV_sqlcode, LV_sqlerrm) THEN
                IF LV_error = 4 THEN
                   RAISE ERROR_PROCESO;
                END IF;

                LV_sSql:= 'PV_GENERAL_OOSS_PG.PV_CLASE_SERV_FN';

                SV_CadenaSSTecn := Pv_General_Ooss_Pg.PV_CLASE_SERV_FN(LV_cadena_servicio_tecnico, LV_arr_Grupo, LV_arr_Nivel, LV_proc, LV_tabla, LV_act, LV_sqlcode, LV_sqlerrm, LV_error);
                IF LV_error = 4 THEN
                   RAISE ERROR_PROCESO;
                END IF;
                FOR LN_ciclo IN 1..LN_total_serv LOOP
                    LV_sSql:= 'PV_GENERAL_OOSS_PG.PV_VALIDA_SERVICIO_FN(' || LV_arr_servicio(LN_ciclo)
                              || ', ' || LV_arr_Grupo(LN_ciclo)
                              || ', ' || LV_arr_Nivel(LN_ciclo)
                              || ', ' || LV_error
                              || ', ' || LV_proc
                              || ', ' || LV_tabla
                              || ', ' || LV_act
                              || ', ' || LV_sqlcode
                              || ', ' || LV_sqlerrm || ')';

                    IF NOT Pv_General_Ooss_Pg.PV_VALIDA_SERVICIO_FN(LV_arr_servicio(LN_ciclo), LV_arr_grupo(LN_ciclo), LV_arr_nivel(LN_ciclo), LV_error,LV_proc, LV_tabla, LV_act, LV_sqlcode, LV_sqlerrm ) THEN
                          RAISE ERROR_PROCESO;
                    END IF;
                END LOOP;
            END IF;
        END IF;

        RETURN TRUE;

    EXCEPTION
    WHEN ERROR_PROCESO THEN
       SN_cod_retorno := 217;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error := 'pv_act_ss_fn; - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, cv_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_act_ss_fn', LV_sSql, SQLCODE, LV_des_error );
       RETURN FALSE;

    WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := 214;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error := 'pv_act_ss_fn; - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, cv_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_act_ss_fn', LV_sSql, SQLCODE, LV_des_error );
       RETURN FALSE;

    WHEN OTHERS THEN
       SN_cod_retorno := '217';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error := 'pv_act_ss_fn; - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, cv_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_act_ss_fn', LV_sSql, SQLCODE, LV_des_error );
       RETURN FALSE;

END pv_obtieneCadenaSSTecn_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE pv_act_desact_ss_pr (
      EN_num_abonado             IN              GA_ABOCEL.NUM_ABONADO%TYPE,
      EN_num_celular             IN              GA_ABOCEL.num_celular%TYPE,
      EV_ss_comercial_act         IN              VARCHAR2 DEFAULT NULL,
      EV_ss_comercial_desact     IN              VARCHAR2 DEFAULT NULL,
      EN_secuencia                 IN              NUMBER,
      EN_cod_ooss_ss             IN              NUMBER,
      EN_imp_total                 IN                 PV_MOVIMIENTOS.carga%TYPE,
      EV_usuario                 IN              VARCHAR2,
       ev_comentario     IN              pv_iorserv.comentario%TYPE,
      SN_cod_retorno             OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno            OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      SN_num_evento              OUT NOCOPY      Ge_Errores_Pg.evento
    )

    /*
    <Documentacion TipoDoc = "PROCEDURE">
       <Elemento
          Nombre = "pv_act_desact_ss_pr"
          Fecha modificacion=" "
          Fecha creacion="25-03-2008"
          Programador=""
          Diseñador=""
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>
          <Descripcion>Inscribe orden de servicio para la activación de servicios suplementarios</Descripcion>
          <Parametros>
             <Entrada>
                <param nom="EN_num_abonado" Tipo="NUMERICO">Número abonado</param>
                <param nom="EN_num_celular" Tipo="NUMERICO">Número de celular del abonado</param>
                <param nom="EV_ss_comercial" Tipo="CARACTER">Servivios comerciales a activar</param>
                <param nom="EN_secuencia" Tipo="NUMERICO">Número de secuencia de la OOSS</param>
                <param nom="EN_cod_ooss_ss" Tipo="NUMERICO">Código de la orden de servicio</param>
                <param nom="EN_imp_total" Tipo="NUMERICO">Importe de rebaja de saldo por concepto de SS para prepagos</param>
             </Entrada>
             <Salida>
                <param>N/A</param>
             </Salida>
          </Parametros>
       </Elemento>
    </Documentacion>
    */

    IS
        LV_des_error                  Ge_Errores_Pg.DesEvent;
        LV_sSql                       VARCHAR2(4000);
        LV_cadena_servicio_tecnico   VARCHAR2(4000);
        LV_val_autenticacion         GED_PARAMETROS.val_parametro%TYPE;
        LV_proc                         VARCHAR2(50);
        LV_tabla                     VARCHAR2(50);
        LV_act                         VARCHAR2(2);
        LV_sqlcode                     VARCHAR2(50);
        LV_sqlerrm                     VARCHAR2(250);
        LV_error                     ge_errores_td.cod_msgerror%TYPE;
        ERROR_PROCESO                 EXCEPTION;
        LV_servsupl_activar             VARCHAR2(250);
        LV_servsupl_desactivar         VARCHAR2(250);
        LV_descripcion                   CI_TIPORSERV.DESCRIPCION%TYPE;
        LN_tip_procesa                   CI_TIPORSERV.TIP_PROCESA%TYPE;
        LN_modgener                       CI_TIPORSERV.COD_MODGENER%TYPE;
        LV_des_estadoc                   FA_INTESTADOC.DES_ESTADOC%TYPE;
        LV_usuario                      GED_PARAMETROS.val_parametro%TYPE;
        so_abonado                   ga_abonado2_qt := NEW ga_abonado2_qt;
        error_ejecucion      EXCEPTION;

    BEGIN
        SN_cod_retorno := 0;
        SN_num_evento  := 0;
        SV_mens_retorno:= '';

        so_abonado.num_abonado := EN_num_abonado;
        pv_cambio_serie_sb_pg.pv_obtiene_datos_abonado_pr (so_abonado, sn_cod_retorno, sv_mens_retorno, sn_num_evento );
        IF (sn_cod_retorno <> 0) THEN
           RAISE ERROR_PROCESO;
        END IF;

        IF EV_ss_comercial_act IS NULL AND EV_ss_comercial_desact IS NULL THEN
           RAISE ERROR_PROCESO;
        ELSE
            IF EV_ss_comercial_act IS NOT NULL THEN
                IF NOT pv_obtieneCadenaSSTecn_fn(EV_ss_comercial_act, LV_servsupl_activar, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
                   RAISE ERROR_PROCESO;
                END IF;
            END IF;

            IF EV_ss_comercial_desact IS NOT NULL THEN
                IF NOT pv_obtieneCadenaSSTecn_fn(EV_ss_comercial_desact, LV_servsupl_desactivar, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
                   RAISE ERROR_PROCESO;
                END IF;
            END IF;
        END IF;

        LV_sSql:= 'PV_GENERAL_OOSS_PG.PV_PARAMETROS_OOSS_PR(' || EN_cod_ooss_ss
                  || ', ' || LV_descripcion
                  || ', ' || LN_tip_procesa
                  || ', ' || LN_modgener
                  || ', ' || LV_des_estadoc
                  || ', ' || LV_error
                  || ', ' || LV_proc
                  || ', ' || LV_tabla
                  || ', ' || LV_act
                  || ', ' || LV_sqlcode
                  || ', ' || LV_sqlerrm || ')';

        Pv_General_Ooss_Pg.PV_PARAMETROS_OOSS_PR(EN_cod_ooss_ss, LV_descripcion, LN_tip_procesa, LN_modgener, LV_des_estadoc, LV_error, LV_proc, LV_tabla, LV_act, LV_sqlcode, LV_sqlerrm);
        IF LV_error = 4 THEN
           RAISE ERROR_PROCESO;
        END IF;

        LV_sSql:='PV_GENERAL_OOSS_PG.PV_INSCRIBE_OOSS_PR';

        -- Inscribir OOSS --
        Pv_General_Ooss_Pg.PV_INSCRIBE_OOSS_PR(EN_num_celular
                                                , EN_cod_ooss_ss
                                                , EV_usuario
                                                , EN_secuencia
                                                , LN_modgener
                                                , CV_cod_actabo_ss
                                                , EN_num_abonado
                                                , Pv_General_Ooss_Pg.CN_cod_producto
                                                , NULL--GN_ind_central_ss
                                                , NULL
                                                , NULL--GV_tip_susp_avsinie
                                                , NULL
                                                , NULL
                                                , NULL
                                                , NULL
                                                , NULL
                                                , 0
                                                , NULL
                                                , NULL
                                                , 0
                                                , NULL
                                                , NULL
                                                , LV_servsupl_activar
                                                , LV_servsupl_desactivar
                                                , 0
                                                , NULL
                                                , so_abonado.cod_cuenta
                                                , LV_descripcion
                                                , LN_tip_procesa
                                                , LN_modgener
                                                , LV_des_estadoc
                                                , 1
                                                , EN_imp_total
                                                , LV_error
                                                , LV_proc
                                                , LV_tabla
                                                , LV_act
                                                , LV_sqlcode
                                                , LV_sqlerrm
                                                );

         IF LV_error = 4 THEN
              RAISE ERROR_PROCESO;
         END IF;

     IF NOT (pv_reg_coment_pv_iorserv_fn (ev_comentario,EN_secuencia,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
              RAISE error_ejecucion;
          END IF;

    EXCEPTION
    WHEN error_ejecucion THEN
       LV_des_error := 'pv_act_desact_ss_pr; - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, cv_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'Pv_Serv_Suplementario_Sb_Pg.pv_act_desact_ss_pr', LV_sSql, SQLCODE, LV_des_error );
    WHEN ERROR_PROCESO THEN
       SN_cod_retorno := 217;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error := 'pv_act_desact_ss_pr; - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, cv_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'Pv_Serv_Suplementario_Sb_Pg.pv_act_desact_ss_pr', LV_sSql, SQLCODE, LV_des_error );

    WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := 214;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error := 'pv_act_desact_ss_pr; - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, cv_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'Pv_Serv_Suplementario_Sb_Pg.pv_act_desact_ss_pr', LV_sSql, SQLCODE, LV_des_error );

    WHEN OTHERS THEN
       SN_cod_retorno := '217';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error := 'pv_act_desact_ss_pr; - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, cv_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'Pv_Serv_Suplementario_Sb_Pg.pv_act_desact_ss_pr', LV_sSql, SQLCODE, LV_des_error );

    END pv_act_desact_ss_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE pv_rec_ss_black_berry_abo_pr(
                                    eo_dat_abo                 IN OUT NOCOPY  pv_datos_abo_qt,
                                    so_cursor                 OUT NOCOPY        refcursor,
                                       sn_cod_retorno           OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
                                       sv_mens_retorno          OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
                                       sn_num_evento            OUT NOCOPY        Ge_Errores_Pg.evento)
    IS
    /*
    <Documentacion
      TipoDoc = "Procedure">>
       <Elemento
          Nombre = "pv_rec_ss_black_berry_abo_pr"
          Lenguaje="PL/SQL"
          Fecha="24-06-2008"
          Version="La del package"
          Dise?ador="Joan Zamorano"
          Programador="Joan Zamorano"
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>>
          <Descripcion></Descripcion>>
          <Parametros>
             <Entrada>
                <param nom="eo_dat_abo" Tipo="estructura">estructura de abonado</param>>
             </Entrada>
             <Salida>
                <param nom="so_cursor" Tipo="ESTRUCTURA">Servicios Black Berry contratados por el abonado</param>>
                <param nom="sn_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                <param nom="sv_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                <param nom="sn_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
             </Salida>
          </Parametros>
       </Elemento>
    </Documentacion>
    */

    LV_des_error       Ge_Errores_Pg.DesEvent;
    lv_ssql               Ge_Errores_Pg.vQuery;
    LN_codSistema       icg_central.cod_sistema%TYPE;
    error_exception       exception;

    BEGIN
        sn_cod_retorno     := 0;
        sv_mens_retorno := NULL;
        sn_num_evento     := 0;

        lv_ssql := 'SELECT a.cod_servicio';
        lv_ssql := lv_ssql || ' FROM ga_servsuplabo a, ged_codigos b';
        lv_ssql := lv_ssql || ' WHERE a.cod_servicio = b.cod_valor AND';
        lv_ssql := lv_ssql || ' a.num_abonado = ' || eo_dat_abo.num_abonado;
        lv_ssql := lv_ssql || ' a.ind_estado < 3 AND';
        lv_ssql := lv_ssql || ' b.cod_modulo = ''GA'' AND';
        lv_ssql := lv_ssql || ' b.nom_tabla = ''GA_SERVSUPL'' AND';
        lv_ssql := lv_ssql || ' b.nom_columna = ''COD_SERVICIO''';

        OPEN so_cursor FOR
            SELECT a.cod_servicio
            FROM ga_servsuplabo a, ged_codigos b
            WHERE a.cod_servicio = b.cod_valor AND
                  a.num_abonado = eo_dat_abo.num_abonado AND
                  a.ind_estado < 3 AND
                  b.cod_modulo = 'GA' AND
                  b.nom_tabla = 'GA_SERVSUPL' AND
                  b.nom_columna = 'COD_SERVICIO';


    EXCEPTION
      WHEN NO_DATA_FOUND THEN
          NULL;
      WHEN OTHERS THEN
          sn_cod_retorno := 156;
          IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,sv_mens_retorno) THEN
             sv_mens_retorno := cv_error_no_clasif;
          END IF;
          LV_des_error   := ' pv_rec_ss_black_berry_abo_pr ('||'); - ' || SQLERRM;
          sn_num_evento  := Ge_Errores_Pg.grabarpl( sn_num_evento, cv_cod_modulo, sv_mens_retorno, cv_version, USER, 'PV_SERVSUPL_SB_PG.pv_rec_ss_black_berry_abo_pr', lv_ssql, sn_cod_retorno, LV_des_error );

END pv_rec_ss_black_berry_abo_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END Pv_Serv_Suplementario_Sb_Pg;
/
SHOW ERRORS