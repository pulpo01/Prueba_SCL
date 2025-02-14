CREATE OR REPLACE PACKAGE BODY VE_parametros_comerciales_PG AS

--Inicio P-CSR-11002 JLGN 27-04-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 FUNCTION ve_crea_movimiento_fn(
 er_movim IN al_movimientos%rowtype,
 SN_cod_retorno OUT NOCOPY ge_errores_pg.CodError,
 SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
 SN_num_evento OUT NOCOPY ge_errores_pg.Evento
 )RETURN BOOLEAN
 IS
 LV_des_error VARCHAR2(300);
 LV_sql VARCHAR2(1000);

 BEGIN
 SN_cod_retorno :=0;
 SV_mens_retorno:=' ';
 SN_num_evento :=0;

 LV_sql:='AL_PAC_VALIDACIONES.P_INSERTA_MOVIM(er_movim)';
 AL_PAC_VALIDACIONES.P_INSERTA_MOVIM(er_movim);
 RETURN TRUE;

 EXCEPTION
 WHEN OTHERS THEN
 SN_cod_retorno:=156;
 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
 SV_mens_retorno:=CV_error_no_clasif;
 END IF;
 LV_des_error:='OTHERS:VE_parametros_comerciales_PG.ve_crea_movimiento_pr();- ' || SQLERRM;
 SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
 'SISCEL.VE_parametros_comerciales_PG.ve_crea_movimiento_pr()', LV_Sql, SQLCODE, LV_des_error );
 RETURN FALSE;
 END ve_crea_movimiento_fn;

 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ve_rec_info_serie_mov_fn (
      ev_num_serie        IN              al_series.num_serie%TYPE,
      rt_movim            OUT NOCOPY      al_movimientos%rowtype,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   )
   RETURN BOOLEAN
   IS
      LV_des_error       VARCHAR2(300);
      LV_sql             VARCHAR2(1000);
   BEGIN

      SN_cod_retorno := 0;
      SN_num_evento  := 0;
      SV_mens_retorno:= '';

      LV_sql := 'SELECT num_movimiento, tip_movimiento, fec_movimiento, tip_stock, cod_bodega, cod_articulo, cod_uso, cod_estado, num_cantidad, cod_estadomov, nom_usuarora, tip_stock_dest, cod_bodega_dest, cod_uso_dest, cod_estado_dest, num_serie, num_desde, num_hasta, num_guia, prc_unidad, cod_transaccion, num_transaccion, num_seriemec, num_telefono, cap_code, cod_producto, cod_central, cod_moneda, cod_subalm, cod_central_dest, cod_subalm_dest, num_telefono_dest, cod_cat, cod_cat_dest, ind_telefono, plan, carga, num_sec_loca, cod_hlr, cod_plaza'
             || ' FROM al_movimientos'
             || ' WHERE num_serie = '''||ev_num_serie||''' '
             || ' AND fec_movimiento = (SELECT MAX(fec_movimiento) FROM al_movimientos WHERE num_serie = '''||ev_num_serie ||'''AND ROWNUM < 2)';

      SELECT tip_stock         , cod_bodega         , cod_articulo         , cod_uso         , cod_estado         ,  num_serie         ,   cod_producto         , cod_central         , cod_subalm         , cod_cat         , ind_telefono         , plan               , carga              , num_sec_loca         , cod_hlr         , cod_plaza
        INTO rt_movim.tip_stock, rt_movim.cod_bodega, rt_movim.cod_articulo, rt_movim.cod_uso, rt_movim.cod_estado,  rt_movim.num_serie,   rt_movim.cod_producto, rt_movim.cod_central, rt_movim.cod_subalm, rt_movim.cod_cat, rt_movim.ind_telefono, rt_movim.plan      , rt_movim.carga     , rt_movim.num_sec_loca, rt_movim.cod_hlr, rt_movim.cod_plaza
        FROM al_series
       WHERE num_serie = ev_num_serie;

      RETURN TRUE;

      EXCEPTION
        WHEN NO_DATA_FOUND THEN
            SN_cod_retorno:=778;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.ve_rec_info_serie_mov_fn();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'VE_parametros_comerciales_PG.ve_rec_info_serie_mov_fn()', LV_Sql, SQLCODE, LV_des_error );
            RETURN FALSE;
        WHEN OTHERS THEN
            SN_cod_retorno:=156;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='OTHERS:VE_parametros_comerciales_PG.ve_rec_info_serie_mov_fn();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'VE_parametros_comerciales_PG.ve_rec_info_serie_mov_fn()', LV_Sql, SQLCODE, LV_des_error );
            RETURN FALSE;
   END ve_rec_info_serie_mov_fn;
--Fin P-CSR-11002 JLGN 27-04-2011

    PROCEDURE VE_planservicio_PR (EV_plantarif       IN ta_plantarif.cod_plantarif%TYPE,
                                  EV_codtecnologia   IN al_tecnologia.cod_tecnologia%TYPE,
                                  SC_cursordatos     OUT NOCOPY REFCURSOR,
                                  SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                  SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                  SN_num_evento      OUT NOCOPY ge_errores_pg.Evento)
    /*--
    <Documentaci¿n TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_planservicio_PR"
        Lenguaje="PL/SQL"
        Fecha="21-03-2007"
        Versi¿n="1.0.0"
        Dise±ador="Roberto PÚrez Varas"
        Programador="Roberto PÚrez Varas"
        Ambiente="BD"
    <Retorno>Planes de servicio</Retorno>
    <Descripci¿n>
        Retorna planes de servicio
    </Descripci¿n>
    <Parametros>
    <Entrada>
        <param nom="EV_plantarif" Tipo="VARCHAR2">plan tarifario</param>
        <param nom="EV_codtecnologia" Tipo="VARCHAR2">codigo tecnologia</param>
    </Entrada>
    <Salida>
        <param nom="SC_cursordatos "  Tipo="CURSOR">Cursor con planes de servicio</param>
        <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentaci¿n>
    */
    IS
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
        LN_count      NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
        BEGIN
            SN_cod_retorno  := 0;
            SV_mens_retorno := NULL;
            SN_num_evento   := 0;

            LV_Sql:= 'SELECT planservicio.cod_planserv, planservicio.des_planserv'
                     || ' FROM   ga_planserv planservicio'
                     || ' WHERE  SYSDATE BETWEEN planservicio.fec_desde AND NVL(planservicio.fec_hasta, SYSDATE)'
                     || ' AND planservicio.cod_producto = ' || CV_cod_producto
                     || ' AND planservicio.cod_planserv IN (SELECT relacion.cod_planserv'
                     || ' FROM  ga_plantecplserv relacion '
                     || ' WHERE relacion.cod_tecnologia = ' || EV_codtecnologia
                     || ' AND relacion.cod_plantarif = ' || EV_plantarif || ')';

            SELECT COUNT(1)
            INTO   LN_count
            FROM   ga_planserv planservicio
            WHERE  SYSDATE BETWEEN planservicio.fec_desde AND NVL(planservicio.fec_hasta, SYSDATE)
            AND    planservicio.cod_producto = CV_cod_producto
            AND    planservicio.cod_planserv IN (SELECT relacion.cod_planserv
                FROM  ga_plantecplserv relacion
                WHERE relacion.cod_tecnologia = EV_codtecnologia
                AND   relacion.cod_plantarif = EV_plantarif)
            AND ROWNUM <= 1;

            OPEN SC_cursordatos FOR
                SELECT planservicio.cod_planserv, planservicio.des_planserv
                FROM   ga_planserv planservicio
                WHERE  SYSDATE BETWEEN planservicio.fec_desde AND NVL(planservicio.fec_hasta, SYSDATE)
                AND    planservicio.cod_producto = CV_cod_producto
                AND    planservicio.cod_planserv IN (SELECT relacion.cod_planserv
                        FROM  ga_plantecplserv relacion
                        WHERE relacion.cod_tecnologia = EV_codtecnologia
                        AND   relacion.cod_plantarif = EV_plantarif);

            IF LN_count = 0 THEN
                RAISE LE_no_data_found_cursor;
            END IF;

            EXCEPTION
                WHEN LE_no_data_found_cursor THEN
                    SN_cod_retorno:=0;
                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                    END IF;
                    LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_planservicio_PR();- ' || SQLERRM;
                    SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                    'VE_parametros_comerciales_PG.VE_planservicio_PR()', LV_Sql, SQLCODE, LV_des_error );
                WHEN NO_DATA_FOUND THEN
                    SN_cod_retorno:=778;
                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                    END IF;
                    LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_planservicio_PR();- ' || SQLERRM;
                    SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                    'VE_parametros_comerciales_PG.VE_planservicio_PR()', LV_Sql, SQLCODE, LV_des_error );
                WHEN OTHERS THEN
                    SN_cod_retorno:=156;
                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                    END IF;
                    LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_planservicio_PR();- ' || SQLERRM;
                    SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                    'VE_parametros_comerciales_PG.VE_planservicio_PR()', LV_Sql, SQLCODE, LV_des_error );


    END VE_planservicio_PR;

    PROCEDURE VE_campanavigente_PR (SC_cursordatos    OUT NOCOPY REFCURSOR,
                                    SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)
    /*--
    <Documentaci¿n TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_campanavigente_PR"
        Lenguaje="PL/SQL"
        Fecha="21-03-2007"
        Versi¿n="1.0.0"
        Dise±ador="Roberto PÚrez Varas"
        Programador="Roberto PÚrez Varas"
        Ambiente="BD"
    <Retorno></Retorno>
    <Descripci¿n>
        Campa±a Vigente
    </Descripci¿n>
    <Parametros>
    <Entrada>  NA    </Entrada>
    <Salida>
        <param nom="SC_cursordatos "  Tipo="CURSOR">Cursor con campa±a vigente</param>
        <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentaci¿n>
    */
    IS
        LV_uso        al_usos.cod_uso%TYPE;
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
        LN_count      NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

        LV_Sql:= 'SELECT parametros.val_parametro'
                 || ' FROM   ged_parametros parametros'
                 || ' WHERE  parametros.nom_parametro = ' || '''USO_LINEA'''
                 || ' AND    parametros.cod_modulo = ' || '''GA'''
                 || ' AND    parametros.cod_producto = 1';

        SELECT parametros.val_parametro
        INTO   LV_uso
        FROM   ged_parametros parametros
        WHERE  parametros.nom_parametro = 'USO_LINEA'
        AND    parametros.cod_modulo = 'GA'
        AND    parametros.cod_producto = 1;

        LV_Sql:= 'SELECT campanasvigentes.cod_campana,campanasvigentes.des_campana,'
                 || ' DECODE(campanasvigentes.cod_tiplan,LV_uso,S,N)'
                 || ' FROM bp_campanas_td campanasvigentes'
                 || ' WHERE campanasvigentes.tip_entidad = A'
                 || ' AND TO_DATE(TO_CHAR(campanasvigentes.fec_termino,YYYYMMDD),YYYYMMDD) >= TO_DATE(TO_CHAR(SYSDATE,YYYYMMDD),YYYYMMDD)'
                 || ' AND campanasvigentes.cod_tiplan <> 1 '
                 || ' ORDER BY campanasvigentes.ind_default DESC';

        SELECT COUNT(1)
        INTO   LN_count
        FROM   bp_campanas_td campanasvigentes
        WHERE  campanasvigentes.tip_entidad = 'A'
        AND    TO_DATE(TO_CHAR(campanasvigentes.fec_termino,'YYYYMMDD'),'YYYYMMDD') >= TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD')
        AND    campanasvigentes.cod_tiplan <> '1'
        AND       ROWNUM <= 1;

        OPEN SC_cursordatos FOR
            SELECT campanasvigentes.cod_campana,campanasvigentes.des_campana,
                   DECODE(campanasvigentes.cod_tiplan, LV_uso,'S','N')
            FROM   bp_campanas_td campanasvigentes
            WHERE  campanasvigentes.tip_entidad = 'A'
            AND    TO_DATE(TO_CHAR(campanasvigentes.fec_termino,'YYYYMMDD'),'YYYYMMDD') >= TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD')
            AND    campanasvigentes.cod_tiplan <> '1'
            ORDER BY campanasvigentes.ind_default DESC;

        IF LN_count = 0 THEN
            RAISE LE_no_data_found_cursor;
        END IF;

        EXCEPTION
            WHEN LE_no_data_found_cursor THEN
                SN_cod_retorno:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_campanavigente_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_campanavigente_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_campanavigente_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_campanavigente_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_campanavigente_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_campanavigente_PR()', LV_Sql, SQLCODE, LV_des_error );

    END VE_campanavigente_PR;

    PROCEDURE VE_planindemnizacion_PR (SC_cursordatos    OUT NOCOPY REFCURSOR,
                                       SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)
    IS
    /*--
    <Documentaci¿n TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_planindemnizacion_PR"
        Lenguaje="PL/SQL"
        Fecha="21-03-2007"
        Versi¿n="1.0.0"
        Dise±ador="Roberto PÚrez Varas"
        Programador="Roberto PÚrez Varas"
        Ambiente="BD"
    <Retorno></Retorno>
    <Descripci¿n>
        Plabes de Indemnizacion vigentes
    </Descripci¿n>
    <Parametros>
    <Entrada>  NA    </Entrada>
    <Salida>
        <param nom="SC_cursordatos "  Tipo="CURSOR">Cursor con planes de indemnizacion vigentes</param>
        <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentaci¿n>
    */
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
        LN_count      NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

        LV_Sql:= 'SELECT planind.cod_plan_indemnizacion, planind.des_plan_indemnizacion'
                 || ' FROM pv_plan_indemnizacion_td  planind'
                 || ' WHERE SYSDATE BETWEEN planind.fec_desde AND NVL(planind.fec_hasta, SYSDATE)';

        SELECT COUNT(1)
        INTO   LN_count
        FROM   pv_plan_indemnizacion_td  planind
        WHERE  SYSDATE BETWEEN planind.fec_desde AND NVL(planind.fec_hasta, SYSDATE)
        AND       ROWNUM <= 1;

        OPEN SC_cursordatos FOR
            SELECT planind.cod_plan_indemnizacion, planind.des_plan_indemnizacion
            FROM   pv_plan_indemnizacion_td  planind
            WHERE  SYSDATE BETWEEN planind.fec_desde AND NVL(planind.fec_hasta, SYSDATE);

        IF LN_count = 0 THEN
            RAISE LE_no_data_found_cursor;
        END IF;

        EXCEPTION
            WHEN LE_no_data_found_cursor THEN
                SN_cod_retorno:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_planindemnizacion_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_planindemnizacion_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_planindemnizacion_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_planindemnizacion_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_planindemnizacion_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_planindemnizacion_PR()', LV_Sql, SQLCODE, LV_des_error );

    END VE_planindemnizacion_PR;

    PROCEDURE VE_causaldescuento_PR (EN_codUso       IN  AL_USOS.COD_USO%TYPE,
                                     SC_cursordatos  OUT NOCOPY REFCURSOR,
                                     SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
    /*--
    <Documentaci¿n TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_causaldescuento_PR"
        Lenguaje="PL/SQL"
        Fecha="21-03-2007"
        Versi¿n="1.0.0"
        Dise±ador="Roberto PÚrez Varas"
        Programador="Roberto PÚrez Varas"
        Ambiente="BD"
    <Retorno></Retorno>
    <Descripci¿n>
        Causales de descuento vigentes
    </Descripci¿n>
    <Parametros>
    <Entrada>  NA    </Entrada>
    <Salida>
        <param nom="SC_cursordatos "  Tipo="CURSOR">Cursor con causales de descuentos vigentes</param>
        <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentaci¿n>
    */
    IS
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
        LN_count      NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

        LV_Sql:= 'SELECT causalventa.cod_causa_venta, causaldesc.descripcion_valor'
                 || ' FROM ga_operaciones_causas_venta_td causalventa, ga_causas_descuentos_vw causaldesc'
                 || ' WHERE  causaldesc.valor = causalventa.cod_causa_venta'
                 || ' AND causal_descuento.ind_estado = ' || '''V'''
                 || ' AND causal_venta.cod_operacion = ' || '''VE''';

        SELECT COUNT(1)
        INTO   LN_count
        FROM   ga_operaciones_causas_venta_td causalventa, ga_causas_descuentos_vw causaldesc
        WHERE  causaldesc.valor = causalventa.cod_causa_venta
        AND    causaldesc.ind_estado = 'V'
        AND    causalventa.cod_operacion = 'VE'
        AND       ROWNUM <= 1;

        OPEN SC_cursordatos FOR
            SELECT causalventa.cod_causa_venta, causaldesc.descripcion_valor
            FROM   ga_operaciones_causas_venta_td causalventa, ga_causas_descuentos_vw causaldesc
            WHERE  causaldesc.valor = causalventa.cod_causa_venta
            AND    causaldesc.ind_estado = 'V'
            AND    causalventa.cod_operacion = 'VE';

        IF LN_count = 0 THEN
            RAISE LE_no_data_found_cursor;
        END IF;

        EXCEPTION
            WHEN LE_no_data_found_cursor THEN
                SN_cod_retorno:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_causaldescuento_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_causaldescuento_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_causaldescuento_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_causaldescuento_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_causaldescuento_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_causaldescuento_PR()', LV_Sql, SQLCODE, LV_des_error );

    END VE_causaldescuento_PR;

    PROCEDURE VE_creditomorosidad_PR (EN_codcliente   IN ge_clientes.COD_CLIENTE%TYPE,
                                      SC_cursordatos  OUT NOCOPY REFCURSOR,
                                      SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
    /*--
    <Documentaci¿n TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_creditomorosidad_PR"
        Lenguaje="PL/SQL"
        Fecha="21-03-2007"
        Versi¿n="1.0.0"
        Dise±ador="Roberto PÚrez Varas"
        Programador="Roberto PÚrez Varas"
        Ambiente="BD"
    <Retorno>Morosidad de credito de un cliente </Retorno>
    <Descripci¿n>
        Morosidad de credito de un cliente
    </Descripci¿n>
    <Parametros>
    <Entrada>
        <param nom="EN_codcliente"  Tipo="NUMBER">codigo de cliente</param>
    </Entrada>
    <Salida>
        <param nom="SC_cursordatos"  Tipo="CURSOR">Cursor con causales de descuentos vigentes</param>
        <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentaci¿n>
    */
    IS
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
        LN_count      NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

        LV_Sql:= 'SELECT credmor.cod_credmor, credmor.des_credmor, credmor.imp_morosidad'
                 || ' FROM co_limcreditos credmor'
                 || ' WHERE credmor.cod_producto = 1'
                 || ' AND credmor.cod_calclien IN (SELECT cli.cod_calclien'
                 || ' SELECT cli.cod_calclien'
                 || ' WHERE cli.cod_cliente = ' || EN_codcliente || ')';

        SELECT COUNT(1)
        INTO   LN_count
        FROM   co_limcreditos credmor
        WHERE  credmor.cod_producto = 1
        AND    credmor.cod_calclien IN (SELECT cli.cod_calclien
                FROM ge_clientes cli
                WHERE cli.cod_cliente = EN_codcliente)
        AND       ROWNUM <= 1;

        OPEN SC_cursordatos FOR
            SELECT credmor.cod_credmor, credmor.des_credmor, credmor.imp_morosidad
            FROM   co_limcreditos credmor
            WHERE  credmor.cod_producto = 1
            AND    credmor.cod_calclien IN (SELECT cli.cod_calclien
                                FROM ge_clientes cli
                                WHERE cli.cod_cliente = EN_codcliente);

        IF LN_count = 0 THEN
            RAISE LE_no_data_found_cursor;
        END IF;

        EXCEPTION
            WHEN LE_no_data_found_cursor THEN
                SN_cod_retorno:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_creditomorosidad_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_creditomorosidad_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_creditomorosidad_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_creditomorosidad_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_creditomorosidad_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_creditomorosidad_PR()', LV_Sql, SQLCODE, LV_des_error );

    END VE_creditomorosidad_PR;

    PROCEDURE VE_grupocobroservicio_PR (EN_codproducto  IN  NUMBER,
                                        SV_CodGrupo     OUT ga_grpserv.cod_grupo%TYPE,
                                        SV_DesGrupo     OUT ga_grpserv.des_grupo%TYPE,
                                        SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
    /*--
    <Documentaci¿n TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_grupocobroservicio_PR"
        Lenguaje="PL/SQL"
        Fecha="21-03-2007"
        Versi¿n="1.0.0"
        Dise±ador="Roberto PÚrez Varas"
        Programador="Roberto PÚrez Varas"
        Ambiente="BD"
    <Retorno>Grupo cobro servicio</Retorno>
    <Descripci¿n>
        Grupo cobro servicio
    </Descripci¿n>
    <Parametros>
    <Entrada>
        <param nom="EN_codcliente"  Tipo="NUMBER">codigo de cliente</param>
    </Entrada>
    <Salida>
        <param nom="SC_cursordatos"  Tipo="CURSOR">Cursor con causales de descuentos vigentes</param>
        <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentaci¿n>
    */
    IS
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
        LN_count      NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

        LV_Sql:= 'SELECT grupo.cod_grupo, grupo.des_grupo'
                 || ' FROM ga_grpserv grupo'
                 || ' WHERE grupo.cod_producto = 1';


            SELECT grupo.cod_grupo, grupo.des_grupo
            INTO   SV_CodGrupo,SV_DesGrupo
            FROM   ga_defventa datosdefault , ga_grpserv grupo
            WHERE  datosdefault.cod_producto = EN_codproducto
            AND    datosdefault.cod_grpserv = grupo.cod_grupo
            AND    datosdefault.cod_producto = grupo.cod_producto;

        EXCEPTION
            WHEN LE_no_data_found_cursor THEN
                SN_cod_retorno:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_grupocobroservicio_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_grupocobroservicio_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_grupocobroservicio_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_grupocobroservicio_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_grupocobroservicio_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_grupocobroservicio_PR()', LV_Sql, SQLCODE, LV_des_error );

    END VE_grupocobroservicio_PR;

    PROCEDURE VE_creditoconsumo_PR (EN_codcliente   IN ge_clientes.COD_CLIENTE%TYPE,
                                     EN_codproducto  IN  NUMBER,
                                    SC_cursordatos  OUT NOCOPY REFCURSOR,
                                    SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
    /*--
    <Documentaci¿n TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_creditoconsumo_PR"
        Lenguaje="PL/SQL"
        Fecha="21-03-2007"
        Versi¿n="1.0.0"
        Dise±ador="Roberto PÚrez Varas"
        Programador="Roberto PÚrez Varas"
        Ambiente="BD"
    <Retorno>credito consumo de un cliente </Retorno>
    <Descripci¿n>
        Credito Consumo de un cliente
    </Descripci¿n>
    <Parametros>
    <Entrada>
        <param nom="EN_codcliente"  Tipo="NUMBER">codigo de cliente</param>
        <param nom="EN_codproducto"  Tipo="NUMBER">codigo de producto</param>
    </Entrada>
    <Salida>
        <param nom="SC_cursordatos"  Tipo="CURSOR">Cursor con causales de descuentos vigentes</param>
        <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentaci¿n>
    */
    IS
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
        LN_count      NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

        LV_Sql:= 'SELECT limcon.cod_credcon, limcon.des_credcon, limcon.imp_consumo'
                 || ' FROM co_limconsumo limcon'
                 || ' WHERE limcon.cod_producto = 1'
                 || ' AND limcon.cod_calclien IN (SELECT cli.cod_calclien'
                 || ' FROM ge_clientes cli'
                 || ' WHERE cli.cod_cliente = ' || EN_codcliente || ')';

        SELECT COUNT(1)
        INTO   LN_count
        FROM   co_limconsumo limcon
        WHERE  limcon.cod_producto = EN_codproducto
        AND    limcon.cod_calclien IN (SELECT cli.cod_calclien
                    FROM ge_clientes cli
                    WHERE cli.cod_cliente = EN_codcliente)
        AND    ROWNUM <= 1;

        OPEN SC_cursordatos FOR
            SELECT limcon.cod_credcon, limcon.des_credcon, limcon.imp_consumo
            FROM   co_limconsumo limcon
            WHERE  limcon.cod_producto = EN_codproducto
            AND    limcon.cod_calclien IN (SELECT cli.cod_calclien
                                    FROM ge_clientes cli
                                    WHERE cli.cod_cliente = EN_codcliente);

        IF LN_count = 0 THEN
            RAISE LE_no_data_found_cursor;
        END IF;

        EXCEPTION
            WHEN LE_no_data_found_cursor THEN
                SN_cod_retorno:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_creditoconsumo_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_creditoconsumo_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_creditoconsumo_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_creditoconsumo_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_creditoconsumo_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_creditoconsumo_PR()', LV_Sql, SQLCODE, LV_des_error );

    END VE_creditoconsumo_PR;

    PROCEDURE VE_grupoafinidad_PR (EN_codcliente    IN ge_clientes.cod_cliente%TYPE,
                                   SC_cursordatos   OUT NOCOPY REFCURSOR,
                                   SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento    OUT NOCOPY ge_errores_pg.Evento)
    /*--
    <Documentaci¿n TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_grupoafinidad_PR"
        Lenguaje="PL/SQL"
        Fecha="21-03-2007"
        Versi¿n="1.0.0"
        Dise±ador="Roberto PÚrez Varas"
        Programador="Roberto PÚrez Varas"
        Ambiente="BD"
    <Retorno>Grupos de Afinidad por cliente </Retorno>
    <Descripci¿n>
        Grupos de Afinidad
    </Descripci¿n>
    <Parametros>
    <Entrada>
        <param nom="EN_codcliente"  Tipo="NUMBER">codigo de cliente</param>
    </Entrada>
    <Salida>
        <param nom="SC_cursordatos"  Tipo="CURSOR">Cursor con grupos de afinidad</param>
        <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentaci¿n>
    */
    IS
        LV_count      VARCHAR2(1);
        LV_origen     GA_afinidades.ori_afinidad%TYPE;
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
        LN_count      NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
    BEGIN
        BEGIN
            SN_cod_retorno  := 0;
            SV_mens_retorno := NULL;
            SN_num_evento   := 0;
            LV_origen := 'I';

            LV_Sql := 'SELECT ' || '''1'''
                   || ' FROM ga_empresa emp'
                   || ' WHERE emp.cod_cliente = ' || EN_codcliente;

            SELECT '1'
            INTO LV_count
            FROM ga_empresa emp
            WHERE emp.cod_cliente = EN_codcliente;

            IF LV_count = '1' THEN
                LV_origen := 'E';
            END IF;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    NULL;
                WHEN OTHERS THEN
                    SN_cod_retorno := 156;
                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                    END IF;
                    LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_grupoafinidad_PR();- ' || SQLERRM;
                    SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                    'VE_parametros_comerciales_PG.VE_grupoafinidad_PR()', LV_Sql, SQLCODE, LV_des_error );

        END;

        BEGIN
            LV_Sql := 'SELECT afi.cod_afinidad, afi.des_afinidad'
                      ||' FROM ga_afinidades afi'
                      ||' WHERE afi.ori_afinidad = ' || LV_origen;

            SELECT COUNT(1)
            INTO   LN_count
            FROM   ga_afinidades afi
            WHERE  afi.ori_afinidad = LV_origen
            AND       ROWNUM <= 1;

            OPEN SC_cursordatos FOR
                SELECT afi.cod_afinidad, afi.des_afinidad
                FROM   ga_afinidades afi
                WHERE  afi.ori_afinidad = LV_origen;

            IF LN_count = 0 THEN
                RAISE LE_no_data_found_cursor;
            END IF;

            EXCEPTION
                WHEN LE_no_data_found_cursor THEN
                    SN_cod_retorno:=0;
                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                    END IF;
                    LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_grupoafinidad_PR();- ' || SQLERRM;
                    SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                    'VE_parametros_comerciales_PG.VE_grupoafinidad_PR()', LV_Sql, SQLCODE, LV_des_error );
                WHEN NO_DATA_FOUND THEN
                    SN_cod_retorno := 1;
                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                    END IF;
                    LV_des_error := 'NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_grupoafinidad_PR();- ' || SQLERRM;
                    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                    'VE_parametros_comerciales_PG.VE_grupoafinidad_PR()', LV_Sql, SQLCODE, LV_des_error );
                WHEN OTHERS THEN
                    SN_cod_retorno := 156;
                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                    END IF;
                    LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_grupoafinidad_PR();- ' || SQLERRM;
                    SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                    'VE_parametros_comerciales_PG.VE_grupoafinidad_PR()', LV_Sql, SQLCODE, LV_des_error );
        END;

    END VE_grupoafinidad_PR;

    PROCEDURE VE_modalidadpago_PR (EV_codtipcontrato  IN  ga_tipcontrato.cod_tipcontrato%TYPE,
                                   EN_nromeses        IN  ga_percontrato.num_meses%TYPE,
                                   EN_codvendedor     IN  ve_vendedores.cod_vendedor%TYPE,
                                   EV_nomusuario      IN  ge_seg_usuario.nom_usuario%TYPE,
                                   EN_codproducto     IN  NUMBER,
                                   EV_codoperacion    IN  gad_modpago_catplan.cod_operacion%TYPE,
                                   EV_cod_programa    IN  ge_programas.cod_programa%TYPE,
                                   EV_Tipo_Cliente    IN  GE_CLIENTES.COD_TIPO%TYPE,
                                   SC_cursordatos     OUT NOCOPY REFCURSOR,
                                   SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento      OUT NOCOPY ge_errores_pg.Evento)
    /*--
    <Documentaci¿n TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_modalidadpago_PR"
        Lenguaje="PL/SQL"
        Fecha="21-03-2007"
        Versi¿n="1.0.0"
        Dise±ador="Roberto PÚrez Varas"
        Programador="Roberto PÚrez Varas"
        Ambiente="BD"
    <Retorno>Modalidad de Pago </Retorno>
    <Descripci¿n>
        Modalidad de Pago
    </Descripci¿n>
    <Parametros>
    <Entrada>
        <param nom="EV_codtipcontrato"  Tipo="VARCHAR2">codigo de tipo de contrato</param>
        <param nom="EN_nromeses"  Tipo="NUMBER">numero de meses</param>
        <param nom="EN_codvendedor"  Tipo="NUMBER">codigo de vendedor</param>
        <param nom="EV_nomusuario"  Tipo="VARCHAR2">nombre de usuario</param>
        <param nom="EN_codproducto"  Tipo="NUMBER">codigo del producto</param>
        <param nom="EV_codoperacion"  Tipo="VARCHAR2">codigo de operacion</param>
        <param nom="EV_cod_programa" Tipo="STRING">C¿digo del Programa</param>
    </Entrada>
    <Salida>
        <param nom="SC_cursordatos"  Tipo="CURSOR">Cursor con modalidad de pago</param>
        <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentaci¿n>
    */
    IS
        LV_uso            al_usos.cod_uso%TYPE;
        LV_usodos         al_usos.cod_uso%TYPE;
           LV_des_error      ge_errores_pg.desevent;
        LV_Sql              ge_errores_pg.vquery;
          LV_SqlEjecutar    ge_errores_pg.vquery;
        LV_SqlEjecutarc   ge_errores_pg.vquery;
          LV_SqlTipComis    VARCHAR2(1024);
        LN_cod_proceso    gad_procesos_perfiles.cod_proceso%TYPE;
        LV_res_validacion BOOLEAN;
          LN_cod_retorno    ge_errores_pg.CodError;
        LV_mens_retorno   ge_errores_pg.MsgError;
        LN_num_evento     ge_errores_pg.Evento;
        LN_count            NUMBER(1);
        LV_Count          ge_errores_pg.vquery;
        LE_no_data_found_cursor EXCEPTION;
    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

        LV_Sql := 'SELECT procesoperfil.cod_proceso'
               || ' FROM gad_procesos_perfiles procesoperfil'
               || ' WHERE nom_perfil_proceso = ' || CV_codmodventa;

        SELECT procesoperfil.cod_proceso
        INTO   LN_cod_proceso
        FROM   gad_procesos_perfiles procesoperfil
        WHERE  nom_perfil_proceso = CV_codmodventa;

        LV_Sql := 'SELECT parametros.val_parametro'
               || ' FROM ged_parametros parametros'
               || ' WHERE parametros.nom_parametro = ' || CV_parcausavta
               || ' AND parametros.cod_modulo = ' || CV_codmodulo
               || ' AND parametros.cod_producto = ' || EN_codproducto;


        SELECT parametros.val_parametro
        INTO   LV_uso
        FROM   ged_parametros parametros
        WHERE  parametros.nom_parametro =  CV_parcausavta
        AND    parametros.cod_modulo = CV_codmodulo
        AND    parametros.cod_producto = EN_codproducto;

        LV_Sql := 'SELECT parametros.val_parametro'
               || ' FROM ged_parametros parametros'
               || ' WHERE parametros.nom_parametro = ' ||CV_parametrov
               || ' AND parametros.cod_modulo = ' || CV_codmodulo
               || ' AND parametros.cod_producto = ' || EN_codproducto;


        SELECT parametros.val_parametro
        INTO   LV_usodos
        FROM   ged_parametros parametros
        WHERE  parametros.nom_parametro = CV_parametrov
        AND    parametros.cod_modulo = CV_codmodulo
        AND    parametros.cod_producto = EN_codproducto;

        LV_Sql := 'VE_parametros_comerciales_PG.VE_validausuariovendedor_FN('||EN_codvendedor||', '||LN_cod_retorno||', '||LV_mens_retorno||', '||LN_num_evento||')';
        LV_res_validacion:= VE_parametros_comerciales_PG.VE_validausuariovendedor_FN(EN_codvendedor,LN_cod_retorno,LV_mens_retorno,LN_num_evento);

        IF LV_res_validacion = TRUE THEN
            LV_Sql := 'VE_parametros_comerciales_PG.VE_validapermisovendedor_FN('||EN_codvendedor||', '||LN_cod_proceso||', '||LN_cod_retorno||', '||LV_mens_retorno||', '||LN_num_evento||')';
            LV_res_validacion := VE_parametros_comerciales_PG.VE_validapermisovendedor_FN(EN_codvendedor,LN_cod_proceso,LN_cod_retorno,LV_mens_retorno,LN_num_evento);
           ELSE
            LV_Sql := 'VE_parametros_comerciales_PG.VE_validapermisousuario_FN('||EV_nomusuario||', '||LN_cod_proceso||', '||LN_cod_retorno||', '||LV_mens_retorno||', '||LN_num_evento||')';
            LV_res_validacion := VE_parametros_comerciales_PG.VE_validapermisousuario_FN(EV_nomusuario,LN_cod_proceso,LN_cod_retorno,LV_mens_retorno,LN_num_evento);
        END IF;
        LV_SqlEjecutar := 'SELECT UNIQUE mod_venta.cod_modventa, mod_venta.des_modventa,mod_venta.ind_cuotas'
                         || ' FROM GE_MODVENTA mod_venta, GA_MODVENT_APLIC mod_ven_aplicacion,'
                         || ' GAD_MODPAGO_CATPLAN mod_pago'
                         || ' WHERE mod_venta.cod_modventa= mod_ven_aplicacion.COD_MODVENTA'
                         || ' AND mod_ven_aplicacion.cod_producto= ' || EN_codproducto
                         || ' AND mod_ven_aplicacion.cod_aplic LIKE ''' || '%' || EV_cod_programa || '%' || ''''
                         || ' AND mod_pago.cod_tipcontrato = ''' || EV_codtipcontrato || ''''
                         || ' AND mod_pago.num_meses =' || EN_nromeses
                         || ' AND mod_pago.cod_operacion =''' || EV_codoperacion || ''''
                         || ' AND mod_venta.cod_modventa = mod_pago.cod_modpago'
                         || ' AND mod_ven_aplicacion.cod_canal = mod_pago.cod_canal_vta'
                         || ' AND mod_pago.ind_causa =''' || LV_usodos || ''''
                         || ' AND mod_ven_aplicacion.cod_canal IN ('
                         || ' SELECT tipo_comisionista.ind_vta_externa'
                         || ' FROM ve_tipcomis tipo_comisionista '
                         || ' WHERE tipo_comisionista.cod_tipcomis IN ('
                         || ' SELECT vendedores.cod_tipcomis'
                         || ' FROM ve_vendedores vendedores'
                         || ' WHERE vendedores.cod_vendedor = ' || EN_codvendedor
                         || ' AND SYSDATE BETWEEN vendedores.fec_contrato AND NVL(vendedores.fec_fincontrato,SYSDATE)'
                         || ' UNION'
                         || ' SELECT vendedores.cod_tipcomis'
                         || ' FROM ve_vendedores vendedores, ve_vendealer dealer'
                         || ' WHERE vendedores.cod_vendedor = ' || EN_codvendedor
                         || ' AND dealer.cod_vendedor = vendedores.cod_vendedor'
                         || ' AND SYSDATE BETWEEN vendedores.fec_contrato AND NVL(vendedores.fec_fincontrato,SYSDATE)'
                         || ' AND SYSDATE BETWEEN dealer.fec_contrato AND NVL(dealer.fec_fincontrato,SYSDATE)))';


        IF  LV_res_validacion = TRUE THEN
            LV_SqlEjecutar:= LV_SqlEjecutar || ' AND mod_venta.ind_cuotas != -1';
            IF LV_usodos <> 0     AND LV_uso <> null AND LV_uso <> '' THEN
                LV_SqlEjecutar:= LV_SqlEjecutar || ' AND mod_pago.cod_causa = ' || LV_uso;
            END IF;
        ELSE
            IF LV_usodos <> 0     AND LV_uso <> null AND LV_uso <> '' THEN
                LV_SqlEjecutar:= LV_SqlEjecutar || ' AND mod_pago.cod_causa = ' || LV_uso;
            END IF;
        END IF;

        IF EV_Tipo_Cliente= CV_TIPO_PREPAGO THEN
           LV_SqlEjecutar:= LV_SqlEjecutar || ' AND mod_venta.COD_MODVENTA=1';
        END IF;

        LV_SqlEjecutar:= LV_SqlEjecutar || ' AND SYSDATE BETWEEN MOD_PAGO.FEC_DESDE AND MOD_PAGO.FEC_HASTA';


        LV_Sql := LV_SqlEjecutar;

        OPEN SC_cursordatos FOR LV_Sql;

        LV_count := 'SELECT COUNT(1) FROM (' || LV_SqlEjecutar || ' AND ROWNUM <= 1)';

        EXECUTE IMMEDIATE LV_count INTO LN_count;

        --IF LN_count = 0 THEN
        --    RAISE LE_no_data_found_cursor;
        --END IF;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_modalidadpago_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_modalidadpago_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_modalidadpago_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_modalidadpago_PR()', LV_Sql, SQLCODE, LV_des_error );

    END VE_modalidadpago_PR;

    PROCEDURE VE_datosvendedor_PR (EN_codvendedor   IN  ve_vendedores.cod_vendedor%TYPE,
                                   SV_nomvendedor   OUT NOCOPY ve_vendedores.nom_vendedor%TYPE,
                                   SN_codcliente    OUT NOCOPY ve_vendedores.cod_cliente%TYPE,
                                   SN_codvende_raiz    OUT NOCOPY ve_vendedores.cod_vende_raiz%TYPE,
                                   SN_codvendealer    OUT NOCOPY ve_vendealer.cod_vendealer%TYPE,
                                   SV_codregion     OUT NOCOPY ge_direcciones.cod_region%TYPE,
                                   SV_codprovincia  OUT NOCOPY ge_direcciones.cod_provincia%TYPE,
                                   SV_codciudad     OUT NOCOPY ge_direcciones.cod_ciudad%TYPE,
                                   SV_codoficina    OUT NOCOPY ve_vendedores.cod_oficina%TYPE,
                                   SV_codtipcomis   OUT NOCOPY ve_tipcomis.cod_tipcomis%TYPE,
                                   SV_destipcomis   OUT NOCOPY ve_tipcomis.des_tipcomis%TYPE,
                                   SN_indtipventa   OUT NOCOPY ve_vendedores.ind_tipventa%TYPE,
                                   SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento    OUT NOCOPY ge_errores_pg.Evento)
    /*--
    <Documentaci¿n TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_datosvendedor_PR"
        Lenguaje="PL/SQL"
        Fecha="21-03-2007"
        Versi¿n="1.0.0"
        Dise±ador="Roberto PÚrez Varas"
        Programador="Roberto PÚrez Varas"
        Ambiente="BD"
    <Retorno>Datos del vendedor</Retorno>
    <Descripci¿n>
        Datos del vendedor
    </Descripci¿n>
    <Parametros>
    <Entrada>
        <param nom="EN_codvendedor"  Tipo="NUMBER">codigo de vendedor</param>
    </Entrada>
    <Salida>
        <param nom="SV_nomvendedor"   Tipo="VARCHAR2">Nombre del vendedor</param>
        <param nom="SN_codcliente"    Tipo="NUMBER">Codigo del cliente</param>
        <param nom="SN_codvende_raiz" Tipo="NUMBER">Codigo vendedor raiz</param>
        <param nom="SN_codvendealer"  Tipo="NUMBER">Codigo vendealer</param>
        <param nom="SV_codregion"     Tipo="VARCHAR2">Codigo de region</param>
        <param nom="SV_codprovincia"  Tipo="VARCHAR2">Codigo de Provincia</param>
        <param nom="SV_codciudad"     Tipo="VARCHAR2">Codigo de ciudad</param>
        <param nom="SV_codoficina"    Tipo="VARCHAR2">Codigo oficina del vendedor</param>
        <param nom="SV_codtipcomis"   Tipo="VARCHAR2">Codigo tipo comisionista/param>
        <param nom="SV_destipcomis"   Tipo="VARCHAR2">descripcion tipo comisionista</param>
        <param nom="SN_indtipventa"  Tipo="NUMBER">Indicador tipo de venta</param>
        <param nom="SN_cod_retorno"   Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno"  Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"    Tipo="NUMBER">Nro de evento</param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentaci¿n>
    */
    IS
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
        LN_count      NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

        LV_Sql:= 'SELECT vend.nom_vendedor, vend.cod_cliente, vend.cod_vende_raiz'
                 || ' vendealer.cod_vendealer, direccion.cod_region, direccion.cod_provincia,'
                 || ' direccion.cod_ciudad, vend.cod_oficina, tipo_comisionista.cod_tipcomis,'
                 || ' tipo_comisionista.des_tipcomis, vend.ind_tipventa'
                 || ' FROM ve_vendedores vend, ve_vendealer vendealer'
                 || ' ge_direcciones direccion'
                 || ' WHERE vend.cod_vendedor = ' || EN_codvendedor
                 || ' AND   direccion.cod_direccion = vend.cod_direccion'
                 || ' AND vend.cod_vendedor= vendealer.cod_vendedor(+)';

        SELECT vend.nom_vendedor, vend.cod_cliente, vend.cod_vende_raiz,
               vendealer.cod_vendealer, direccion.cod_region, direccion.cod_provincia,
               direccion.cod_ciudad, vend.cod_oficina, tipo_comisionista.cod_tipcomis,
               tipo_comisionista.des_tipcomis, tipo_comisionista.ind_vta_externa  /* Se cambia a ind_vta_externa de ve_tipcomis*/
        INTO   SV_nomvendedor, SN_codcliente, SN_codvende_raiz,
               SN_codvendealer, SV_codregion, SV_codprovincia,
               SV_codciudad, SV_codoficina, SV_codtipcomis,
               SV_destipcomis, SN_indtipventa
        FROM   ve_vendedores vend, ve_vendealer vendealer,
               ge_direcciones direccion, ve_tipcomis tipo_comisionista
        WHERE  vend.cod_vendedor = EN_codvendedor
        /*AND    vend.ind_interno = 1 */
        AND    direccion.cod_direccion = vend.cod_direccion
        AND    vend.cod_tipcomis =  tipo_comisionista.cod_tipcomis
        AND    vend.cod_vendedor = vendealer.cod_vendedor(+)
        AND    rownum < 2;


        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno := 1984;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasif;
                END IF;
                LV_des_error := 'NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_datosvendedor_PR();- ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_datosvendedor_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasif;
                END IF;
                LV_des_error := 'OTHERS:VE_parametros_comerciales_PG.VE_datosvendedor_PR();- ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_datosvendedor_PR()', LV_Sql, SQLCODE, LV_des_error );


    END VE_datosvendedor_PR;


    PROCEDURE VE_tipocontrato_PR (EV_nomusuario    IN  ge_seg_usuario.nom_usuario%TYPE,
                                  EN_codproducto   IN  NUMBER,
                                  EV_indcontcel    IN  VARCHAR2,
                                  EV_indcontseg    IN  VARCHAR2,
                                  EV_cod_programa  IN  ge_programas.cod_programa%TYPE,
                                  EN_num_version   IN  ge_programas.num_version%TYPE,
                                  SC_cursordatos   OUT NOCOPY REFCURSOR,
                                  SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                  SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                  SN_num_evento    OUT NOCOPY ge_errores_pg.Evento)
    /*--
    <Documentaci¿n TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_tipocontrato_PR"
        Lenguaje="PL/SQL"
        Fecha="21-03-2007"
        Versi¿n="1.0.0"
        Dise±ador="Roberto PÚrez Varas"
        Programador="Roberto PÚrez Varas"
        Ambiente="BD"
    <Retorno>Tipo de contrato</Retorno>
    <Descripci¿n>
        Tipo de contrato
    </Descripci¿n>
    <Parametros>
    <Entrada>
        <param nom="EV_nomusuario"   Tipo="VARCHAR2">Nombre de usuario</param>
        <param nom="EN_codproducto"  Tipo="NUMBER">codigo de producto</param>
        <param nom="EV_indcontcel"   Tipo="VARCHAR2">indice contcel</param>
        <param nom="EV_indcontseg"   Tipo="VARCHAR2">indice contseg</param>
        <param nom="EV_cod_programa" Tipo="STRING">C¿digo del Programa</param>
        <param nom="EN_num_version"  Tipo="NUMBER">Versi¿n del programa</param>
    </Entrada>
    <Salida>
        <param nom="SC_cursordatos"  Tipo="CURSOR">Cursor con tipo de contrato</param>
        <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentaci¿n>
    */
    IS
        LV_des_error    ge_errores_pg.desevent;
        LV_Sql          ge_errores_pg.vquery;
        LN_codproceso   ge_seg_perfiles.cod_proceso%TYPE;
        LN_cod_retorno  ge_errores_pg.CodError;
        LV_mens_retorno ge_errores_pg.MsgError;
        LN_num_evento   ge_errores_pg.Evento;
        LN_count          NUMBER(1);
         LE_no_data_found_cursor EXCEPTION;
   BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

        ln_cod_retorno:=0;
        VE_permisousuario_PR  (EV_nomusuario,CV_codcomodato,EV_cod_programa, EN_num_version,
                               LN_codproceso,LN_cod_retorno,LV_mens_retorno,LN_num_evento);

        IF LN_cod_retorno = 0 THEN

            LV_Sql:= 'SELECT tipo_contrato.cod_tipcontrato, tipo_contrato.des_tipcontrato'
                     || ' FROM ga_tipcontrato tipo_contrato'
                     || ' WHERE SYSDATE BETWEEN tipo_contrato.fec_desde AND NVL(tipo_contrato.fec_hasta, SYSDATE)'
                     || ' AND tipo_contrato.cod_producto = ' || EN_codproducto
                     || ' AND tipo_contrato.ind_contcel = ' || EV_indcontcel
                     || ' AND tipo_contrato.ind_contseg = ' || EV_indcontseg;

            SELECT COUNT(1)
            INTO   LN_count
            FROM   ga_tipcontrato tipo_contrato
            WHERE  SYSDATE BETWEEN tipo_contrato.fec_desde AND NVL(tipo_contrato.fec_hasta, SYSDATE)
            AND    tipo_contrato.cod_producto = EN_codproducto
            AND    tipo_contrato.ind_contcel = EV_indcontcel
            AND    tipo_contrato.ind_contseg = EV_indcontseg
            AND       ROWNUM <= 1;

            OPEN SC_cursordatos FOR
                SELECT tipo_contrato.cod_tipcontrato, tipo_contrato.des_tipcontrato
                FROM   ga_tipcontrato tipo_contrato
                WHERE  SYSDATE BETWEEN tipo_contrato.fec_desde AND NVL(tipo_contrato.fec_hasta, SYSDATE)
                AND    tipo_contrato.cod_producto = EN_codproducto
                AND    tipo_contrato.ind_contcel = EV_indcontcel
                AND    tipo_contrato.ind_contseg = EV_indcontseg;

        ELSE
            LV_Sql:= 'SELECT tipo_contrato.cod_tipcontrato, tipo_contrato.des_tipcontrato'
                     || ' FROM ga_tipcontrato tipo_contrato'
                     || ' WHERE SYSDATE BETWEEN tipo_contrato.fec_desde AND NVL(tipo_contrato.fec_hasta, SYSDATE)'
                     || ' AND tipo_contrato.cod_producto = ' || EN_codproducto
                     || ' AND tipo_contrato.ind_contcel = ' || EV_indcontcel
                     || ' AND tipo_contrato.ind_contseg = ' || EV_indcontseg
                     || ' AND NVL(tipo_contrato.ind_comodato,0) != 1';

            SELECT COUNT(1)
            INTO   LN_count
            FROM   ga_tipcontrato tipo_contrato
            WHERE  SYSDATE BETWEEN tipo_contrato.fec_desde AND NVL(tipo_contrato.fec_hasta, SYSDATE)
            AND    tipo_contrato.cod_producto = EN_codproducto
            AND    tipo_contrato.ind_contcel = EV_indcontcel
            AND    tipo_contrato.ind_contseg = EV_indcontseg
            AND    NVL(tipo_contrato.ind_comodato,0) != 1
            AND    ROWNUM <= 1;

            OPEN SC_cursordatos FOR
                SELECT tipo_contrato.cod_tipcontrato, tipo_contrato.des_tipcontrato
                FROM   ga_tipcontrato tipo_contrato
                WHERE  SYSDATE BETWEEN tipo_contrato.fec_desde AND NVL(tipo_contrato.fec_hasta, SYSDATE)
                AND    tipo_contrato.cod_producto = EN_codproducto
                AND    tipo_contrato.ind_contcel = EV_indcontcel
                AND    tipo_contrato.ind_contseg = EV_indcontseg
                AND    NVL(tipo_contrato.ind_comodato,0) != 1;

        END IF;

        IF LN_count = 0 THEN
            RAISE LE_no_data_found_cursor;
        END IF;

        EXCEPTION
            WHEN LE_no_data_found_cursor THEN
                SN_cod_retorno:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_tipocontrato_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_tipocontrato_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno := 1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_tipocontrato_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_tipocontrato_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_tipocontrato_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_tipocontrato_PR()', LV_Sql, SQLCODE, LV_des_error );


    END VE_tipocontrato_PR;



    PROCEDURE VE_permisousuario_PR (EV_nom_usuario  IN  ge_seg_usuario.nom_usuario%TYPE,
                                    EV_nom_proceso  IN  gad_procesos_perfiles.cod_proceso%TYPE,
                                    EV_cod_programa IN  ge_programas.cod_programa%TYPE,
                                    EN_num_version  IN  ge_programas.num_version%TYPE,
                                    SN_codproceso   OUT NOCOPY ge_seg_perfiles.cod_proceso%TYPE,
                                    SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
    /*--
    <Documentaci¿n TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_permisousuario_PR"
        Lenguaje="PL/SQL"
        Fecha="21-03-2007"
        Versi¿n="1.0.0"
        Dise±ador="Roberto PÚrez Varas"
        Programador="Roberto PÚrez Varas"
        Ambiente="BD"
    <Retorno>Permiso Usuario</Retorno>
    <Descripci¿n>
        Permiso Usuario
    </Descripci¿n>
    <Parametros>
    <Entrada>
        <param nom="EV_nom_usuario"  Tipo="STRING">Nombre de usuario</param>
        <param nom="EV_nom_proceso"  Tipo="STRING">Nombre Proceso</param>
        <param nom="EV_cod_programa" Tipo="STRING">C¿digo del Programa</param>
        <param nom="EN_num_version"  Tipo="NUMBER">Versi¿n del programa</param>
    </Entrada>
    <Salida>
        <param nom="SC_cursordatos"  Tipo="CURSOR">Cursor con permiso usuario</param>
        <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno" Tipo="STRING">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentaci¿n>
    */
    IS
        LN_codproceso gad_procesos_perfiles.cod_proceso%TYPE;
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

        LV_Sql := 'SELECT perfiles.cod_proceso'
               || ' FROM gad_procesos_perfiles perfiles'
               || ' WHERE perfiles.nom_perfil_proceso = ' || EV_nom_proceso;

        SELECT perfiles.cod_proceso
        INTO   LN_codproceso
        FROM   gad_procesos_perfiles perfiles
        WHERE  perfiles.nom_perfil_proceso = EV_nom_proceso;

        LV_Sql := 'SELECT perfiles.cod_proceso'
               || ' FROM   ge_seg_perfiles perfiles, ge_seg_grpusuario grupo_usuario'
               || ' WHERE  perfiles.cod_grupo = grupo_usuario.cod_grupo'
               || ' AND    grupo_usuario.nom_usuario = ''' || EV_nom_usuario || ''''
               || ' AND    perfiles.cod_programa = ''' || EV_cod_programa || ''''
               || ' AND    perfiles.num_version = ' || EN_num_version
               || ' AND    perfiles.cod_proceso = ' || LN_codproceso
               || ' AND    ROWNUM = 1';

        SELECT perfiles.cod_proceso
        INTO   SN_codproceso
        FROM   ge_seg_perfiles perfiles, ge_seg_grpusuario grupo_usuario
        WHERE  perfiles.cod_grupo = grupo_usuario.cod_grupo
        AND    grupo_usuario.nom_usuario = EV_nom_usuario
        AND    perfiles.cod_programa = EV_cod_programa
        AND    perfiles.num_version = EN_num_version
        AND    perfiles.cod_proceso = LN_codproceso
        AND    ROWNUM = 1;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno := 1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error := 'NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_permisousuario_PR();- ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_permisousuario_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_permisousuario_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_permisousuario_PR()', LV_Sql, SQLCODE, LV_des_error );
    END VE_permisousuario_PR;


    PROCEDURE VE_nromesescontrato_PR (EV_codtipcontrato  IN  ga_tipcontrato.cod_tipcontrato%TYPE,
                                      EN_codproducto     IN  NUMBER,
                                       SC_cursordatos     OUT NOCOPY REFCURSOR,
                                      SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento      OUT NOCOPY ge_errores_pg.Evento)
    /*--
    <Documentaci¿n TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_nromesescontrato_PR"
        Lenguaje="PL/SQL"
        Fecha="21-03-2007"
        Versi¿n="1.0.0"
        Dise±ador="Roberto PÚrez Varas"
        Programador="Roberto PÚrez Varas"
        Ambiente="BD"
    <Retorno>Numero Meses Contrato/Retorno>
    <Descripci¿n>
        Numero Meses Contrato
    </Descripci¿n>
    <Parametros>
    <Entrada>
        <param nom="EV_codtipcontrato"  Tipo="VARCHAR2">Codigo tipo contrato</param>
        <param nom="EN_codproducto"  Tipo="NUMBER">codigo de producto</param>
    </Entrada>
    <Salida>
        <param nom="SC_cursordatos"  Tipo="CURSOR">Numero Meses Contrato</param>
        <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentaci¿n>
    */
    IS
        LV_des_error    ge_errores_pg.desevent;
        LV_Sql          ge_errores_pg.vquery;
        LN_count          NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

        LV_Sql:= 'SELECT duracion.cod_tipcontrato, duracion.num_meses'
                || ' FROM  ga_percontrato duracion'
                || ' WHERE duracion.cod_producto = ' || EN_codproducto
                || ' AND duracion.cod_tipcontrato = ' || EV_codtipcontrato;

        SELECT COUNT(1)
        INTO   LN_count
        FROM   ga_percontrato duracion
        WHERE  duracion.cod_producto = EN_codproducto
        AND    duracion.cod_tipcontrato = EV_codtipcontrato
        AND       ROWNUM <= 1;

        OPEN SC_cursordatos FOR
            SELECT duracion.cod_tipcontrato, duracion.num_meses
            FROM   ga_percontrato duracion
            WHERE  duracion.cod_producto = EN_codproducto
            AND    duracion.cod_tipcontrato = EV_codtipcontrato;

        --IF LN_count = 0 THEN
        --    RAISE LE_no_data_found_cursor;
        --END IF;

        EXCEPTION
            WHEN LE_no_data_found_cursor THEN
                SN_cod_retorno:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_nromesescontrato_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_nromesescontrato_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno := 1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasif;
                END IF;
                LV_des_error := 'NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_nromesescontrato_PR();- ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_nromesescontrato_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasif;
                END IF;
                LV_des_error := 'OTHERS:VE_parametros_comerciales_PG.VE_nromesescontrato_PR();- ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_nromesescontrato_PR()', LV_Sql, SQLCODE, LV_des_error );


    END VE_nromesescontrato_PR;


    PROCEDURE VE_nrocuotas_PR (EN_codmodventa     IN  ge_modventa.cod_modventa%TYPE,
                                 EN_codvendedor      IN  ve_vendedores.cod_vendedor%TYPE,
                               EV_nomusuario      IN  ge_seg_usuario.nom_usuario%TYPE,
                               EN_codproducto     IN  NUMBER,
                               SC_cursordatos     OUT NOCOPY REFCURSOR,
                               SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                               SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                               SN_num_evento      OUT NOCOPY ge_errores_pg.Evento)

    /*--
    <Documentaci¿n TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_nrocuotas_PR"
        Lenguaje="PL/SQL"
        Fecha="21-03-2007"
        Versi¿n="1.0.0"
        Dise±ador="Roberto PÚrez Varas"
        Programador="Roberto PÚrez Varas"
        Ambiente="BD"
    <Retorno>Numero cuotas</Retorno>
    <Descripci¿n>
        Numero cuotas
    </Descripci¿n>
    <Parametros>
    <Entrada>
        <param nom="EN_codmodventa"  Tipo="NUMBER">Codigo tipo contrato</param>
        <param nom="EN_codvendedor"  Tipo="NUMBER">codigo de vendedor</param>
        <param nom="EV_nomusuario"  Tipo="NUMBER">nombre de usuario</param>
        <param nom="EN_codproducto"  Tipo="NUMBER">codigo de producto</param>
    </Entrada>
    <Salida>
        <param nom="SC_cursordatos"  Tipo="CURSOR">cursor con Numero cuotas</param>
        <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentaci¿n>
    */
    IS
        LV_des_error      ge_errores_pg.desevent;
        LV_Sql            ge_errores_pg.vquery;
        LV_uso              al_usos.cod_uso%TYPE;
        LV_usodos          al_usos.cod_uso%TYPE;
        LV_usotres          al_usos.cod_uso%TYPE;
        LN_cod_retorno    ge_errores_pg.CodError;
        LV_mens_retorno   ge_errores_pg.MsgError;
        LN_num_evento     ge_errores_pg.Evento;
        LN_filas          NUMBER;
        LN_cod_proceso    gad_procesos_perfiles.cod_proceso%TYPE;
        LV_res_validacion BOOLEAN;
        LN_count            NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;

    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;


        LV_Sql := 'SELECT parametros.val_parametro'
               || ' FROM ged_parametros parametros'
               || ' WHERE parametros.nom_parametro = ' ||CV_codconcons
               || ' AND parametros.cod_modulo = ' || CV_codmodulo
               || ' AND parametros.cod_producto = ' || EN_codproducto;


        SELECT parametros.val_parametro
        INTO   LV_uso
        FROM   ged_parametros parametros
        WHERE  parametros.nom_parametro = CV_codconcons
        AND    parametros.cod_modulo = CV_codmodulo
        AND    parametros.cod_producto = EN_codproducto;


        LV_Sql := 'SELECT parametros.val_parametro'
               || ' FROM ged_parametros parametros'
               || ' WHERE parametros.nom_parametro = ' || CV_codmodpricta
               || ' AND parametros.cod_modulo = ' || CV_codmodulo
               || ' AND parametros.cod_producto = ' || EN_codproducto;


        SELECT parametros.val_parametro
        INTO   LV_usodos
        FROM   ged_parametros parametros
        WHERE  parametros.nom_parametro = CV_codmodpricta
        AND    parametros.cod_modulo = CV_codmodulo
        AND    parametros.cod_producto = EN_codproducto;


        LV_Sql := 'SELECT procesoperfil.cod_proceso'
               || ' FROM gad_procesos_perfiles procesoperfil'
               || ' WHERE nom_perfil_proceso = ' || CV_codcargocuenta;


        SELECT procesoperfil.cod_proceso
        INTO   LN_cod_proceso
        FROM   gad_procesos_perfiles procesoperfil
        WHERE  nom_perfil_proceso = CV_codcargocuenta;



        LV_Sql := 'VE_parametros_comerciales_PG.VE_validausuariovendedor_FN('||EN_codvendedor||', '||LN_cod_retorno||', '||LV_mens_retorno||', '||LN_num_evento||')';

        LV_res_validacion:= VE_parametros_comerciales_PG.VE_validausuariovendedor_FN(EN_codvendedor,LN_cod_retorno,LV_mens_retorno,LN_num_evento);


        IF LV_res_validacion = TRUE THEN
            LV_Sql := 'VE_parametros_comerciales_PG.VE_validapermisovendedor_FN('||EN_codvendedor||', '||LN_cod_proceso||', '||LN_cod_retorno||', '||LV_mens_retorno||', '||LN_num_evento||')';
              LV_res_validacion:= VE_parametros_comerciales_PG.VE_validapermisovendedor_FN(EN_codvendedor,LN_cod_proceso,LN_cod_retorno,LV_mens_retorno,LN_num_evento);
        ELSE
            LV_Sql := 'VE_parametros_comerciales_PG.VE_validapermisousuario_FN('||EV_nomusuario||', '||LN_cod_proceso||', '||LN_cod_retorno||', '||LV_mens_retorno||', '||LN_num_evento||')';
            LV_res_validacion:= VE_parametros_comerciales_PG.VE_validapermisousuario_FN(EV_nomusuario,LN_cod_proceso,LN_cod_retorno,LV_mens_retorno,LN_num_evento);
        END IF;

        IF  EN_codmodventa <> LV_usodos and LV_res_validacion = FALSE THEN

            LV_Sql := 'SELECT cuotas.cod_cuota, cuotas.des_cuota'
                     || ' FROM ge_tipcuotas cuotas'
                     || ' WHERE cuotas.cod_cuota != ' || LV_uso;


            SELECT COUNT(1)
            INTO   LN_count
            FROM   ge_tipcuotas cuotas
            WHERE  cuotas.cod_cuota != LV_uso
            AND    ROWNUM <= 1;

            OPEN SC_cursordatos FOR
            SELECT cuotas.cod_cuota, cuotas.des_cuota
            FROM   ge_tipcuotas cuotas
            WHERE  cuotas.cod_cuota != LV_uso;

        ELSIF EN_codmodventa = LV_usodos and LV_res_validacion = TRUE THEN
                LV_Sql := 'SELECT cuotas.cod_cuota, cuotas.des_cuota'
                         || ' FROM ge_tipcuotas cuotas'
                         || ' WHERE cuotas.cod_cuota = ' || LV_uso;

                SELECT COUNT(1)
                INTO   LN_count
                FROM   ge_tipcuotas cuotas
                WHERE  cuotas.cod_cuota = LV_uso
                AND       ROWNUM <= 1;

                OPEN SC_cursordatos FOR
                SELECT cuotas.cod_cuota, cuotas.des_cuota
                FROM   ge_tipcuotas cuotas
                WHERE  cuotas.cod_cuota = LV_uso;

        ELSE
                LV_Sql := 'SELECT cuotas.cod_cuota, cuotas.des_cuota'
                         || ' FROM ge_tipcuotas cuotas';

                SELECT COUNT(1)
                INTO   LN_count
                FROM   ge_tipcuotas cuotas
                WHERE  ROWNUM <= 1;

                OPEN SC_cursordatos FOR
                SELECT cuotas.cod_cuota, cuotas.des_cuota
                FROM   ge_tipcuotas cuotas;
        END IF;

        IF LN_count = 0 THEN
            RAISE LE_no_data_found_cursor;
        END IF;

        EXCEPTION
            WHEN LE_no_data_found_cursor THEN
                SN_cod_retorno:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_nrocuotas_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_nrocuotas_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno := 1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasif;
                END IF;
                LV_des_error := 'NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_nrocuotas_PR();- ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_nrocuotas_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasif;
                END IF;
                LV_des_error := 'OTHERS:VE_parametros_comerciales_PG.VE_nrocuotas_PR();- ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_nrocuotas_PR()', LV_Sql, SQLCODE, LV_des_error );


    END VE_nrocuotas_PR;



    PROCEDURE VE_tipodocumento_PR(EN_cod_cliente   IN  ge_clientes.cod_cliente%TYPE,
                                  EV_ind_agente    IN  ge_clientes.ind_agente%TYPE,
                                  EV_ind_situacion IN  ge_clientes.ind_situacion%TYPE,
                                  EN_cod_producto  IN  NUMBER,
                                  EV_cod_amiciclo  IN  ged_parametros.nom_parametro%TYPE,
                                  EV_cod_modulo    IN  VARCHAR2,
                                    SC_cursordatos   OUT NOCOPY REFCURSOR,
                                  SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                  SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento    OUT NOCOPY ge_errores_pg.Evento)

    /*--
    <Documentaci¿n TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_tipodocumento_PR"
        Lenguaje="PL/SQL"
        Fecha="21-03-2007"
        Versi¿n="1.0.0"
        Dise±ador="Roberto PÚrez Varas"
        Programador="Roberto PÚrez Varas"
        Ambiente="BD"
    <Retorno>Tipo de Documento</Retorno>
    <Descripci¿n>
        Tipo de Documento
    </Descripci¿n>
    <Parametros>
    <Entrada>
        <param nom="EN_cod_cliente"  Tipo="NUMBER">Codigo cliente</param>
        <param nom="EV_ind_agente"  Tipo="VARCHAR2">indicador agente</param>
        <param nom="EV_ind_situacion"  Tipo="VARCHAR2">indicador situacion</param>
        <param nom="EN_cod_producto"  Tipo="NUMBER">codigo de producto</param>
        <param nom="EV_cod_amiciclo"  Tipo="VARCHAR2">codigo amiciclo</param>
        <param nom="EV_cod_modulo  Tipo="VARCHAR2">codigo modulo</param>
    </Entrada>
    <Salida>
        <param nom="SC_cursordatos"  Tipo="CURSOR">cursor con Tipo de Documento</param>
        <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentaci¿n>
    */
    IS
        LV_des_error       ge_errores_pg.desevent;
        LV_Sql             ge_errores_pg.vquery;
        LV_uso             al_usos.cod_uso%TYPE;
        LV_cal_tributaria  ga_catributclie.cod_catribut%TYPE;
        LN_count             NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;

    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

        LV_Sql := 'SELECT parametros.val_parametro'
               || ' FROM ged_parametros parametros'
               || ' WHERE parametros.nom_parametro = ' || EV_cod_amiciclo
               || ' AND parametros.cod_modulo = ' || EV_cod_modulo
               || ' AND parametros.cod_producto = ' || EN_cod_producto;

          SELECT parametros.val_parametro
        INTO   LV_uso
        FROM   ged_parametros parametros
        WHERE  parametros.nom_parametro = EV_cod_amiciclo
        AND    parametros.cod_modulo = EV_cod_modulo
        AND    parametros.cod_producto = EN_cod_producto;

        LV_Sql := 'SELECT calidadtributaria.cod_catribut'
               || ' FROM   ge_clientes cliente, ga_catributclie calidadtributaria'
               || ' WHERE  cliente.cod_cliente = ' || EN_cod_cliente
               || ' AND    cliente.ind_agente = ' || EV_ind_agente
               || ' AND    cliente.ind_situacion <> ' || EV_ind_situacion
               || ' AND    cliente.cod_cliente = calidadtributaria.cod_cliente'
               || ' AND    SYSDATE BETWEEN calidadtributaria.fec_desde AND NVL(calidadtributaria.fec_hasta,SYSDATE)';

        SELECT calidadtributaria.cod_catribut
        INTO   LV_cal_tributaria
        FROM   ge_clientes cliente, ga_catributclie calidadtributaria
        WHERE  cliente.cod_cliente = EN_cod_cliente
        AND    cliente.ind_agente = EV_ind_agente
        AND    cliente.ind_situacion <> EV_ind_situacion
        AND    cliente.cod_cliente = calidadtributaria.cod_cliente
        AND    SYSDATE BETWEEN calidadtributaria.fec_desde AND NVL(calidadtributaria.fec_hasta,SYSDATE);


        LV_Sql := 'SELECT tipodoc.cod_tipdocum, tipodoc.des_tipdocum, caltribdoc.cod_catribut,tipodoc.tip_foliacion'
               || ' FROM   ge_catribdocum caltribdoc, ge_tipdocumen tipodoc'
               || ' WHERE  caltribdoc.cod_catribut = lv_cal_tributaria'
               || ' AND    SYSDATE BETWEEN caltribdoc.fec_desde AND caltribdoc.fec_hasta'
               || ' AND    caltribdoc.cod_tipdocum = tipodoc.cod_tipdocum';

        SELECT COUNT(1)
        INTO   LN_count
        FROM   ge_catribdocum caltribdoc, ge_tipdocumen tipodoc
        WHERE  caltribdoc.cod_catribut = lv_cal_tributaria
        AND    SYSDATE BETWEEN caltribdoc.fec_desde AND caltribdoc.fec_hasta
        AND    caltribdoc.cod_tipdocum = tipodoc.cod_tipdocum
        AND       ROWNUM <= 1;

        OPEN SC_cursordatos FOR
            SELECT tipodoc.cod_tipdocum, tipodoc.des_tipdocum, caltribdoc.cod_catribut,tipodoc.tip_foliacion
            FROM   ge_catribdocum caltribdoc, ge_tipdocumen tipodoc
            WHERE  caltribdoc.cod_catribut = lv_cal_tributaria
            AND    SYSDATE BETWEEN caltribdoc.fec_desde AND caltribdoc.fec_hasta
            AND    caltribdoc.cod_tipdocum = tipodoc.cod_tipdocum;

        IF LN_count = 0 THEN
            RAISE LE_no_data_found_cursor;
        END IF;

        EXCEPTION
            WHEN LE_no_data_found_cursor THEN
                SN_cod_retorno:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_tipodocumento_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_tipodocumento_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN NO_DATA_FOUND THEN

                IF (LV_uso = 25) THEN
                   OPEN SC_cursordatos FOR
                           SELECT 45, 'Boleta', 'B','A' from Dual;

                      SN_cod_retorno := 0;
                   SV_mens_retorno := 'No hay datos para ciclo 25';
                   SN_num_evento := 0;
                   ELSE
                    SN_cod_retorno := 1;
                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                    END IF;
                    LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_tipodocumento_PR();- ' || SQLERRM;
                    SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                    'VE_parametros_comerciales_PG.VE_tipodocumento_PR()', LV_Sql, SQLCODE, LV_des_error );
               END IF;

            WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_tipodocumento_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_tipodocumento_PR()', LV_Sql, SQLCODE, LV_des_error );

    END VE_tipodocumento_PR;



    PROCEDURE VE_contratocliente_PR(EN_codcliente     IN  ge_clientes.cod_cliente%TYPE,
                                     EV_codtipcontrato  IN  ga_tipcontrato.cod_tipcontrato%TYPE,
                                    SC_cursordatos   OUT NOCOPY REFCURSOR,
                                    SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento    OUT NOCOPY ge_errores_pg.Evento)
    /*--
    <Documentaci¿n TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_contratocliente_PR"
        Lenguaje="PL/SQL"
        Fecha="21-03-2007"
        Versi¿n="1.0.0"
        Dise±ador="Roberto PÚrez Varas"
        Programador="Roberto PÚrez Varas"
        Ambiente="BD"
    <Retorno>Contrato Cliente</Retorno>
    <Descripci¿n>
        Contrato Cliente
    </Descripci¿n>
    <Parametros>
    <Entrada>
        <param nom="EN_codcliente" Tipo="NUMBER">codigo cliente</param>
        <param nom="EV_codtipcontrato" Tipo="VARCHAR2">codigo tipo contrato</param>
    </Entrada>
    <Salida>
        <param nom="SC_cursordatos"  Tipo="CURSOR">cursor con contrato cliente</param>
        <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentaci¿n>
    */
    IS
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
        LN_count      NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

        LV_Sql:= 'SELECT DISTINCT contrato.cod_tipcontrato, contrato.num_contrato'
                 || ' FROM ga_contcta contrato'
                 || ' WHERE contrato.cod_cuenta IN'
                 || ' (SELECT cliente.cod_cuenta'
                 || ' FROM ge_clientes'
                 || ' WHERE cod_cliente = ' || EN_codcliente || ')';

        SELECT COUNT(1)
        INTO   LN_count
        FROM   ga_contcta contrato
        WHERE  contrato.cod_cuenta IN
                 (SELECT cliente.cod_cuenta
                    FROM ge_clientes cliente
                      WHERE cliente.cod_cliente = EN_codcliente)
                      AND    contrato.cod_tipcontrato = EV_codtipcontrato
        AND    ROWNUM <= 1;

        OPEN SC_cursordatos FOR
            SELECT DISTINCT contrato.cod_tipcontrato, contrato.num_contrato
            FROM   ga_contcta contrato
            WHERE  contrato.cod_cuenta IN
                   (SELECT cliente.cod_cuenta
                   FROM ge_clientes cliente
                   WHERE cliente.cod_cliente = EN_codcliente)
            AND    contrato.cod_tipcontrato = EV_codtipcontrato;

        IF LN_count = 0 THEN
            RAISE LE_no_data_found_cursor;
        END IF;

        EXCEPTION
            WHEN LE_no_data_found_cursor THEN
                SN_cod_retorno:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_contratocliente_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_contratocliente_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_contratocliente_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_contratocliente_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_contratocliente_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_contratocliente_PR()', LV_Sql, SQLCODE, LV_des_error );

    END VE_contratocliente_PR;



    PROCEDURE VE_obtienedatoscelda_PR (EV_codcelda        IN ge_celdas.cod_celda%TYPE,
                                       SV_codsubalm       OUT NOCOPY ge_celdas.cod_subalm%TYPE,
                                       SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento      OUT NOCOPY ge_errores_pg.Evento)
    /*--
    <Documentaci¿n TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_obtienedatoscelda_PR"
        Lenguaje="PL/SQL"
        Fecha="21-03-2007"
        Versi¿n="1.0.0"
        Dise±ador="Roberto PÚrez Varas"
        Programador="Roberto PÚrez Varas"
        Ambiente="BD"
    <Retorno>Obtiene Datos Celda</Retorno>
    <Descripci¿n>
        Obtiene Datos Celda
    </Descripci¿n>
    <Parametros>
    <Entrada>
        <param nom="EN_codcelda" Tipo="NUMBER">codigo celda</param>
    </Entrada>
    <Salida>
        <param nom="SN_codsubalm"  Tipo="NUMBER">codigo subalimentador</param>
        <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentaci¿n>
    */
    IS

           LV_des_error      ge_errores_pg.desevent;
        LV_Sql            ge_errores_pg.vquery;

    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

        LV_Sql := 'SELECT celda.cod_subalm'
                  || ' FROM ge_celdas celda'
                  || ' WHERE celda.cod_celda = ' || EV_codcelda
                  || ' AND ROWNUM < 2';


        SELECT celda.cod_subalm
        INTO SV_codsubalm
        FROM ge_celdas celda
        WHERE celda.cod_celda = EV_codcelda
        AND ROWNUM < 2;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_obtienedatoscelda_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_obtienedatoscelda_PR', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_obtienedatoscelda_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_obtienedatoscelda_PR()', LV_Sql, SQLCODE, LV_des_error );

    END VE_obtienedatoscelda_PR;


    PROCEDURE VE_listadoceldas_PR(EV_codregion      IN  ge_regiones.cod_region%TYPE,
                                  EV_codprovincia   IN  ge_provincias.cod_provincia%TYPE,
                                  EV_codciudad      IN  ge_ciudades.cod_provincia%TYPE,
                                  SC_cursordatos    OUT NOCOPY REFCURSOR,
                                  SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                  SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                  SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)
    /*--
    <Documentaci¿n TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_listadoceldas_PR"
        Lenguaje="PL/SQL"
        Fecha="21-03-2007"
        Versi¿n="1.0.0"
        Dise±ador="Roberto PÚrez Varas"
        Programador="Roberto PÚrez Varas"
        Ambiente="BD"
    <Retorno>Listado de celdas</Retorno>
    <Descripci¿n>
        Listado de celdas
    </Descripci¿n>
    <Parametros>
    <Entrada>
        <param nom="EV_codregion" Tipo="VARCHAR2">codigo region</param>
        <param nom="EV_codprovincia" Tipo="VARCHAR2">codigo provincia</param>
        <param nom="EV_codciudad" Tipo="VARCHAR2">codigo ciudad</param>
    </Entrada>
    <Salida>
        <param nom="SC_cursordatos"  Tipo="CURSOR">cursor con celdas</param>
        <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentaci¿n>
    */
    IS
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
        LN_count      NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

        LV_Sql:= 'SELECT celda.cod_celda, celda.des_celda, celda.cod_subalm, celda.cod_subalm2'
                 || ' FROM ge_celdas celda, ge_ciudades ciudades, ge_ciuceldas_td relciudadcelda'
                 || ' WHERE ciudades.cod_region = relciudadcelda.cod_region'
                 || ' AND ciudades.cod_provincia = relciudadcelda.cod_provincia'
                 || ' AND ciudades.cod_ciudad = relciudadcelda.cod_ciudad'
                 || ' AND ciudades.cod_region = ' || EV_codregion
                 || ' AND ciudades.cod_provincia = ' || EV_codprovincia
                 || ' AND ciudades.cod_ciudad = ' || EV_codciudad
                 || ' ORDER BY celda.des_celda';


        SELECT COUNT(1)
        INTO   LN_count
        FROM   ge_celdas celda, ge_ciudades ciudades, ge_ciuceldas_td relciudadcelda
        WHERE  ciudades.cod_region = relciudadcelda.cod_region
        AND    ciudades.cod_provincia = relciudadcelda.cod_provincia
        AND    ciudades.cod_ciudad = relciudadcelda.cod_ciudad
        AND    ciudades.cod_region = EV_codregion
        AND    ciudades.cod_provincia = EV_codprovincia
        AND    ciudades.cod_ciudad = EV_codciudad
        AND       ROWNUM <= 1;

        OPEN SC_cursordatos FOR
            SELECT celda.cod_celda, celda.des_celda, celda.cod_subalm, celda.cod_subalm2
            FROM   ge_celdas celda, ge_ciudades ciudades, ge_ciuceldas_td relciudadcelda
            WHERE  ciudades.cod_region = relciudadcelda.cod_region
            AND    ciudades.cod_provincia = relciudadcelda.cod_provincia
            AND    ciudades.cod_ciudad = relciudadcelda.cod_ciudad
            AND    ciudades.cod_region = EV_codregion
            AND    ciudades.cod_provincia = EV_codprovincia
            AND    ciudades.cod_ciudad = EV_codciudad
            ORDER BY celda.des_celda;

        IF LN_count = 0 THEN
            RAISE LE_no_data_found_cursor;
        END IF;

        EXCEPTION
            WHEN LE_no_data_found_cursor THEN
                SN_cod_retorno:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_listadoceldas_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_listadoceldas_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_listadoceldas_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_listadoceldas_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_listadoceldas_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_listadoceldas_PR()', LV_Sql, SQLCODE, LV_des_error );

    END VE_listadoceldas_PR;


    PROCEDURE VE_listadocentrales_PR(EV_codsubalm       IN  ta_subcentral.cod_subalm%TYPE,
                                     EN_codproducto     IN  NUMBER,
                                     EV_CodPrestacion   IN GE_PRESTACIONES_TD.COD_PRESTACION%TYPE,
                                     SC_cursordatos     OUT NOCOPY REFCURSOR,
                                     SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento      OUT NOCOPY ge_errores_pg.Evento)
    /*--
    <Documentaci¿n TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_listadocentrales_PR"
        Lenguaje="PL/SQL"
        Fecha="21-03-2007"
        Versi¿n="1.0.0"
        Dise±ador="Roberto PÚrez Varas"
        Programador="Roberto PÚrez Varas"
        Ambiente="BD"
    <Retorno>Listado de centrales</Retorno>
    <Descripci¿n>
        Listado de centrales
    </Descripci¿n>
    <Parametros>
    <Entrada>
        <param nom="EV_codregion" Tipo="VARCHAR2">codigo subalmimentador</param>
        <param nom="EN_codprovincia" Tipo="NUMBER">codigo producto</param>
    </Entrada>
    <Salida>
        <param nom="SC_cursordatos"  Tipo="CURSOR">cursor con centrales</param>
        <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentaci¿n>
    */
    IS
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
        LN_count      NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
        LV_centralDefault ge_prestaciones_td.cod_celda_defecto%TYPE;
    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

        BEGIN
            SELECT COD_CELDA_DEFECTO
            INTO LV_centralDefault
            FROM GE_PRESTACIONES_TD
            WHERE COD_PRESTACION=EV_CodPrestacion;

            EXCEPTION
               WHEN NO_DATA_FOUND THEN
                    LV_centralDefault:=NULL;
                    NULL;
        END;

        LV_Sql:= 'SELECT central.cod_central, central.nom_central, central.COD_TECNOLOGIA'
    || ' FROM   icg_central central '
        || ' WHERE    central.cod_producto ='|| EN_codproducto ;
    IF LV_centralDefault IS NOT NULL THEN
            LV_Sql:=  LV_Sql || ' AND central.cod_central IN (' || LV_centralDefault || ')';
    ELSE
            LV_Sql:=  LV_Sql || ' AND central.cod_central not in ( select COD_CENTRAL from icg_central where COD_CENTRAL in ( select COD_CENTRAL_DEFECTO from ge_prestaciones_td))';
    END IF;
        LV_Sql:=  LV_Sql || ' ORDER BY central.nom_central';

        OPEN SC_cursordatos FOR LV_Sql;

        EXCEPTION
            WHEN LE_no_data_found_cursor THEN
                SN_cod_retorno:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_listadocentrales_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_listadocentrales_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_listadocentrales_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_listadocentrales_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_listadocentrales_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_listadocentrales_PR()', LV_Sql, SQLCODE, LV_des_error );

    END VE_listadocentrales_PR;



    PROCEDURE VE_plan_comercial_cliente_PR(EN_cod_cliente   IN  ga_cliente_pcom.cod_cliente%TYPE,
                                           SN_cod_plancom   OUT NOCOPY ga_cliente_pcom.cod_plancom%TYPE,
                                           SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                           SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS


    /*--
        <Documentaci¿n TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_plan_comercial_cliente_PR
            Lenguaje="PL/SQL"
            Fecha="23-04-2007"
            Versi¿n="1.0.0"
            Dise±ador="HÚctor Hermosilla"
            Programador="HÚctor Hermosilla"
            Ambiente="BD"
        <Retorno> NA </Retorno>
        <Descripci¿n>
             Obtiene plan comercial asociado al cliente
        </Descripci¿n>
        <Parametros>
        <Entrada>
                <param nom="EN_cod_cliente"    Tipo="NUMBER"> codigo cliente </param>
        </Entrada>
        <Salida>
                   <param nom="SN_cod_plancom" Tipo="NUMBER"> codigo plan comercial</param>
                <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>

        </Salida>
        </Parametros>
        </Elemento>
        </Documentaci¿n>
        --*/

        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

        LV_Sql:= 'SELECT plancomcliente.cod_plancom'
                 || ' FROM ga_cliente_pcom plancomcliente'
                 || ' WHERE plancomcliente.cod_cliente =' || EN_cod_cliente
                 || ' AND SYSDATE BETWEEN fec_desde AND NVL(fec_hasta, SYSDATE)';


        SELECT plancomcliente.cod_plancom
        INTO   SN_cod_plancom
        FROM   ga_cliente_pcom plancomcliente
        WHERE  plancomcliente.cod_cliente = EN_cod_cliente
        AND    SYSDATE BETWEEN fec_desde AND NVL(fec_hasta, SYSDATE);

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_plan_comercial_cliente_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_plan_comercial_cliente_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_plan_comercial_cliente_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_plan_comercial_cliente_PR()', LV_Sql, SQLCODE, LV_des_error );

    END VE_plan_comercial_cliente_PR;




    FUNCTION VE_validausuariovendedor_FN (EN_codvendedor  IN  ve_vendedores.COD_VENDEDOR%TYPE,
                                          SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) RETURN BOOLEAN
    /*--
    <Documentaci¿n TipoDoc = "Function">
        Elemento Nombre = "VE_validausuariovendedor_FN"
        Lenguaje="PL/SQL"
        Fecha="21-03-2007"
        Versi¿n="1.0.0"
        Dise±ador="Roberto PÚrez Varas"
        Programador="Roberto PÚrez Varas"
        Ambiente="BD"
    <Retorno>Valida Usuario Vendedor</Retorno>
    <Descripci¿n>
        Valida Usuario Vendedor
    </Descripci¿n>
    <Parametros>
    <Entrada>
        <param nom="EN_codvendedor" Tipo="NUMBER">codigo vendedor</param>
    </Entrada>
    <Salida>
        <param nom="SALIDA"  Tipo="BOOLEAN">Validacion Usuario Vendedor</param>
        <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentaci¿n>
    */
    IS
           LV_des_error      ge_errores_pg.desevent;
        LV_Sql            ge_errores_pg.vquery;
        LV_count          VARCHAR2(1);
    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;


        LV_Sql := 'SELECT ' || '''1'''
               || ' FROM ge_seg_usuario usuarios'
               || ' WHERE usuarios.cod_vendedor = ' || EN_codvendedor
               || ' AND ROWNUM = 1';

        SELECT '1'
        INTO LV_count
        FROM ge_seg_usuario usuarios
        WHERE usuarios.cod_vendedor = EN_codvendedor
        AND ROWNUM = 1;

        IF LV_count = '1' THEN
           RETURN TRUE;
        ELSE
           RETURN FALSE;
        END IF;


        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_validausuariovendedor_FN();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_validausuariovendedor_FN()', LV_Sql, SQLCODE, LV_des_error );
                RETURN FALSE;
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_validausuariovendedor_FN();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_validausuariovendedor_FN()', LV_Sql, SQLCODE, LV_des_error );
                RETURN FALSE;


    END;

    FUNCTION VE_validapermisousuario_FN (EV_nomusuario   IN  ge_seg_usuario.nom_usuario%TYPE,
                                         EV_cod_proceso   IN  gad_procesos_perfiles.cod_proceso%TYPE,
                                         SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                         SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) RETURN  BOOLEAN
    /*--
    <Documentaci¿n TipoDoc = "Function">
        Elemento Nombre = "VE_validapermisousuario_FN"
        Lenguaje="PL/SQL"
        Fecha="21-03-2007"
        Versi¿n="1.0.0"
        Dise±ador="Roberto PÚrez Varas"
        Programador="Roberto PÚrez Varas"
        Ambiente="BD"
    <Retorno>Valida Permiso Usuario</Retorno>
    <Descripci¿n>
        Valida Permiso Usuario
    </Descripci¿n>
    <Parametros>
    <Entrada>
        <param nom="EV_nomusuario" Tipo="VARCHAR2">Nombre Usuario</param>
        <param nom="EV_cod_proceso" Tipo="VARCHAR2">codigo proceso</param>
    </Entrada>
    <Salida>
        <param nom="SALIDA"  Tipo="BOOLEAN">Validacion Permiso Usuario</param>
        <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentaci¿n>
    */
    IS
           LV_des_error      ge_errores_pg.desevent;
        LV_Sql            ge_errores_pg.vquery;
        LV_count          VARCHAR2(1);
    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

        LV_Sql := 'SELECT ' || '''1'''
               || ' FROM ge_seg_perfiles perfiles, ge_seg_grpusuario grupo_usuario'
               || ' WHERE perfiles.cod_grupo = grupo_usuario.cod_grupo'
               || ' AND grupo_usuario.nom_usuario = ' || EV_nomusuario
               || ' AND perfiles.cod_proceso = ' || EV_cod_proceso
               || ' AND ROWNUM = 1';

        SELECT '1'
        INTO LV_count
        FROM ge_seg_perfiles perfiles, ge_seg_grpusuario grupo_usuario
        WHERE perfiles.cod_grupo = grupo_usuario.cod_grupo
        AND grupo_usuario.nom_usuario = EV_nomusuario
        AND perfiles.cod_proceso = EV_cod_proceso
        AND ROWNUM = 1;

        IF LV_count = '1' THEN
           RETURN TRUE;
        ELSE
           RETURN FALSE;
        END IF;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_validapermisousuario_FN();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_validapermisousuario_FN()', LV_Sql, SQLCODE, LV_des_error );
                RETURN FALSE;
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_validapermisousuario_FN();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_validapermisousuario_FN()', LV_Sql, SQLCODE, LV_des_error );
                RETURN FALSE;


    END;

    FUNCTION VE_validapermisovendedor_FN (EN_codvendedor  IN  ve_vendedores.cod_vendedor%TYPE,
                                           EV_cod_proceso   IN  gad_procesos_perfiles.cod_proceso%TYPE,
                                          SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) RETURN BOOLEAN
    /*--
    <Documentaci¿n TipoDoc = "Function">
        Elemento Nombre = "VE_validapermisovendedor_FN"
        Lenguaje="PL/SQL"
        Fecha="21-03-2007"
        Versi¿n="1.0.0"
        Dise±ador="Roberto PÚrez Varas"
        Programador="Roberto PÚrez Varas"
        Ambiente="BD"
    <Retorno>Valida Permiso Vendedor</Retorno>
    <Descripci¿n>
        Valida Permiso Vendedor
    </Descripci¿n>
    <Parametros>
    <Entrada>
        <param nom="EN_codvendedor" Tipo="VARCHAR2">codigo vendedor</param>
        <param nom="EV_cod_proceso" Tipo="VARCHAR2">codigo proceso</param>
    </Entrada>
    <Salida>
        <param nom="SALIDA"  Tipo="BOOLEAN">Validacion Permiso Vendedor</param>
        <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentaci¿n>
    */
    IS
           LV_des_error      ge_errores_pg.desevent;
        LV_Sql            ge_errores_pg.vquery;
        LV_count          VARCHAR2(1);
    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

        LV_Sql := 'SELECT ' || '''1'''
               || ' FROM ge_seg_perfiles perfiles, ge_seg_grpusuario grupo_usuario,'
               || ' ge_seg_usuario usuario'
               || ' WHERE perfiles.cod_grupo = grupo_usuario.cod_grupo'
               || ' AND grupo_usuario.nom_usuario =usuario.nom_usuario'
               || ' AND usuario.cod_vendedor = ' || EN_codvendedor
               || ' AND perfiles.cod_proceso = ' || EV_cod_proceso
               || ' AND ROWNUM = 1';

        SELECT '1'
        INTO LV_count
        FROM ge_seg_perfiles perfiles, ge_seg_grpusuario grupo_usuario,
              ge_seg_usuario usuario
        WHERE perfiles.cod_grupo = grupo_usuario.cod_grupo
        AND grupo_usuario.nom_usuario =usuario.nom_usuario
        AND usuario.cod_vendedor = EN_codvendedor
        AND perfiles.cod_proceso = EV_cod_proceso
        AND ROWNUM = 1;

        IF LV_count = '1' THEN
           RETURN TRUE;
        ELSE
           RETURN FALSE;
        END IF;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_validapermisovendedor_FN();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_validapermisovendedor_FN()', LV_Sql, SQLCODE, LV_des_error );
                RETURN FALSE;
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_validapermisovendedor_FN();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_validapermisovendedor_FN()', LV_Sql, SQLCODE, LV_des_error );
                RETURN FALSE;

    END;

    PROCEDURE VE_consulta_datos_usuario_PR (EV_nom_usuario     IN  VARCHAR2,
                                             SV_codigo_oficina  OUT NOCOPY ge_seg_usuario.cod_oficina%TYPE,
                                                 SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                                  SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                                SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS
      /*

        <Documentaci¿n TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_consulta_datos_usuario_PR"
            Lenguaje="PL/SQL"
            Fecha="02-05-2007"
            Versi¿n="1.0.0"
            Dise±ador="HÚctor Hermosilla"
            Programador="HÚctor Hermosilla"
            Ambiente="BD"
        <Retorno> NA </Retorno>
        <Descripci¿n>
            Consulta los datos del usuario.
        </Descripci¿n>
        <Parametros>
        <Entrada>
                <param nom="EV_nom_usuario" Tipo="VARCHAR2"> nombre del usuario </param>

        </Entrada>
        <Salida>
                <param nom="SV_codigo_oficina" Tipo="VARCHAR2> c¿digo oficina del usuario</param>
                <param nom="SN_cod_retorno"    Tipo="NUMBER"> codigo retorno </param>
                <param nom="SV_mens_retorno"   Tipo="VARCHAR2"> glosa mensaje error </param>
                <param nom="SN_num_evento"     Tipo="NUMBER"> numero de evento </param>

        </Salida>
        </Parametros>
        </Elemento>
        </Documentaci¿n>
      */


    LV_resultado  VARCHAR2(1);
    LV_des_error  ge_errores_pg.desevent;
    LV_Sql        ge_errores_pg.vquery;
    LN_count      NUMBER(1);
    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

        LV_Sql := 'SELECT usuario.cod_oficina'
               || ' FROM ge_seg_usuario usuario'
               || ' WHERE usuario.nom_usuario = UPPER('||EV_nom_usuario||')';

        SELECT usuario.cod_oficina
        INTO   SV_codigo_oficina
        FROM   ge_seg_usuario usuario
        WHERE  usuario.NOM_USUARIO = UPPER(EV_nom_usuario);

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_consulta_datos_usuario_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_consulta_datos_usuario_PR', LV_Sql, SQLCODE, LV_des_error );
        WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_consulta_datos_usuario_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_consulta_datos_usuario_PR', LV_Sql, SQLCODE, LV_des_error );
    END VE_consulta_datos_usuario_PR;


    PROCEDURE VE_CampanaVigenteDefault_PR(EV_CodPlantarif IN TA_PLANTARIF.COD_PLANTARIF%TYPE,
                                       EV_TipEntidad   IN VARCHAR2,
                                       EV_IndDefault   IN VARCHAR2,
                                       EV_FormatoFecha IN VARCHAR2,
                                       EV_CodCampana   OUT BP_CAMPANAS_TD.COD_CAMPANA%TYPE,
                                       SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
    /*
    <Documentacion
      TipoDoc = "PROCEDURE">
       <Elemento
          Nombre = "VE_CampanaVigenteDefault_PR"
          Lenguaje="PL/SQL"
          Fecha="21-07-2007"
          Version="1.0"
          Dise?ador="NRCA"
          Programador="NRCA"
          Ambiente Desarrollo="BD">
          <Retorno>NA</Retorno>
          <Descripcion>
                         Obtiene Campa±a vigente por default
          </Descripcion>
          <Parametros>
             <Entrada>
                    <param nom="EV_CodPlantarif" Tipo="VARCHAR2" Descripcion = "Codigo de Plan tarifario" </param>
                    <param nom="EV_TipEntidad" Tipo="VARCHAR2" Descripcion = "TIPO DE ENTIDAD" </param>
                    <param nom="EV_IndDefault" Tipo="VARCHAR2" Descripcion = "INDICADOR DEFAULT" </param>
                    <param nom="EV_FormatoFecha" Tipo="VARCHAR2" Descripcion = "FORMATO FECHA DEFINIDO"</param>

             /Entrada>
             <Salida>
                 <param nom="EV_COD_CAMPANA"   Tipo="VARCHAR2" Descripcion= "Codigo Campa±a a devolver" </param>
                   <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                 <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                 <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
             </Salida>
          </Parametros>
       </Elemento>
    </Documentacion>
    */
          LV_des_error ge_errores_pg.DesEvent;
          LV_sSql      ge_errores_pg.vQuery;
        LV_CodTiplan ta_plantarif.cod_tiplan%TYPE;
    BEGIN
        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';

        LV_sSql := 'SELECT COD_TIPLAN ';
        LV_sSql := LV_sSql||' FROM TA_PLANTARIF ';
        LV_sSql := LV_sSql||' WHERE COD_PLANTARIF = ' || EV_codPlantarif;

        SELECT COD_TIPLAN
        INTO  LV_CodTiplan
        FROM TA_PLANTARIF
        WHERE COD_PLANTARIF = EV_codPlantarif;

        LV_sSql := 'SELECT COD_CAMPANA'
        || ' FROM BP_CAMPANAS_TD '
        || ' WHERE COD_TIPLAN = ' || LV_CodTiplan
        || ' AND IND_DEFAULT = '  || EV_IndDefault
        || ' AND TIP_ENTIDAD = '  || EV_TIPENTIDAD
        || 'AND TO_DATE(TO_CHAR(FEC_TERMINO,YYYYMMDD),YYYYMMDD) >='
        || 'TO_DATE(TO_CHAR( SYSDATE, YYYYMMDD) , YYYYMMDD)';

        SELECT COD_CAMPANA
        INTO EV_CodCampana
        FROM BP_CAMPANAS_TD
        WHERE COD_TIPLAN=  LV_CodTiplan
        AND IND_DEFAULT=EV_IndDefault
        AND TIP_ENTIDAD = EV_TipEntidad
        AND TO_DATE(TO_CHAR(FEC_TERMINO,EV_FormatoFecha),EV_FormatoFecha) >=
        TO_DATE(TO_CHAR( SYSDATE, EV_FormatoFecha) , EV_FormatoFecha);

        SN_cod_retorno := 0;

    EXCEPTION
          WHEN NO_DATA_FOUND THEN
               SN_cod_retorno:=4;
               IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                  SV_mens_retorno := CV_error_no_clasif;
               END IF;
               LV_des_error := SUBSTR('NO_DATA_FOUND:VE_PARAMETROS_COMERCIALES_PG.VE_CampanaVigenteDefault_PR; - '|| SQLERRM,1,CN_largoerrtec);
               SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
               SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
               'VE_PARAMETROS_COMERCIALES_PG.VE_CampanaVigenteDefault_PR', LV_sSql, SN_cod_retorno, LV_des_error );
          WHEN OTHERS THEN
               SN_cod_retorno:=4;
               IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                  SV_mens_retorno := CV_error_no_clasif;
               END IF;
               LV_des_error := SUBSTR('OTHERS:VE_PARAMETROS_COMERCIALES_PG.VE_CampanaVigenteDefault_PR; - '|| SQLERRM,1,CN_largoerrtec);
               SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
               SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
               'VE_PARAMETROS_COMERCIALES_PG.VE_CampanaVigenteDefault_PR', LV_sSql, SN_cod_retorno, LV_des_error );
    END VE_CampanaVigenteDefault_PR;

    PROCEDURE VE_grupocobroservicio_PR (EN_codproducto  IN  NUMBER,
                                        SC_cursordatos  OUT NOCOPY REFCURSOR,
                                        SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
    /*--
    <Documentaci¿n TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_grupocobroservicio_PR"
        Lenguaje="PL/SQL"
        Fecha="21-03-2007"
        Versi¿n="1.0.0"
        Dise±ador="Roberto PÚrez Varas"
        Programador="Roberto PÚrez Varas"
        Ambiente="BD"
    <Retorno>Grupo cobro servicio</Retorno>
    <Descripci¿n>
        Grupo cobro servicio
    </Descripci¿n>
    <Parametros>
    <Entrada>
        <param nom="EN_codcliente"  Tipo="NUMBER">codigo de cliente</param>
    </Entrada>
    <Salida>
        <param nom="SC_cursordatos"  Tipo="CURSOR">Cursor con causales de descuentos vigentes</param>
        <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentaci¿n>
    */
    IS
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
        LN_count      NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

        LV_Sql:= 'SELECT grupo.cod_grupo, grupo.des_grupo'
                 || ' FROM ga_grpserv grupo'
                 || ' WHERE grupo.cod_producto = 1';

        SELECT COUNT(1)
        INTO   LN_count
        FROM   ga_grpserv grupo
        WHERE  cod_producto = EN_codproducto
        AND       ROWNUM <= 1;

        OPEN SC_cursordatos FOR
            SELECT grupo.cod_grupo, grupo.des_grupo
            FROM   ga_grpserv grupo
            WHERE  cod_producto = EN_codproducto;

        IF LN_count = 0 THEN
            RAISE LE_no_data_found_cursor;
        END IF;

        EXCEPTION
            WHEN LE_no_data_found_cursor THEN
                SN_cod_retorno:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_grupocobroservicio_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_grupocobroservicio_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_grupocobroservicio_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_grupocobroservicio_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_grupocobroservicio_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_grupocobroservicio_PR()', LV_Sql, SQLCODE, LV_des_error );

    END VE_grupocobroservicio_PR;
        PROCEDURE VE_Obtiene_Bodegas_PR (EN_COD_VENDEDOR IN  VE_VENDEDORES.COD_VENDEDOR%TYPE,
                                         SC_cursordatos   OUT NOCOPY REFCURSOR,
                                         SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                         SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_num_evento    OUT NOCOPY ge_errores_pg.Evento)
        IS
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
        LN_count      NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
        v_cod_operadora    ge_parametros_sistema_vw.VALOR_TEXTO%TYPE;
    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;



       v_cod_operadora:=GE_OBTIENE_OPERADORA_LOCAL_FN(SN_cod_retorno,SV_mens_retorno,SN_num_evento);
       IF SN_cod_retorno <> 0 THEN
         raise LE_no_data_found_cursor;
       END IF;


        LV_Sql:='SELECT A.COD_BODEGA, B.DES_BODEGA'
                || ' FROM  VE_VENDALMAC A, AL_BODEGAS B'
                || ' WHERE A.COD_VENDEDOR =' || EN_COD_VENDEDOR
                || ' AND   SYSDATE BETWEEN A.FEC_ASIGNACION AND NVL(A.FEC_DESASIGNAC,SYSDATE)'
                || ' AND   A.COD_BODEGA = B.COD_BODEGA';

        OPEN SC_cursordatos FOR LV_sql;




        EXCEPTION
            WHEN LE_no_data_found_cursor THEN
                SN_cod_retorno:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_Obtiene_Bodegas_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_Obtiene_Bodegas_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_Obtiene_Bodegas_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_Obtiene_Bodegas_PR', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_Obtiene_Bodegas_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_Obtiene_Bodegas_PR', LV_Sql, SQLCODE, LV_des_error );

    END VE_Obtiene_Bodegas_PR;
PROCEDURE VE_Obtiene_Articulos_PR (EV_COD_TECNOLOGIA IN  AL_TECNOLOGIA.COD_TECNOLOGIA%TYPE,
                                   EV_TIP_TERMINAL   IN  AL_ARTICULOS.TIP_TERMINAL%TYPE,
                                   EV_IND_EQUIPO     IN  VARCHAR2,--S: Simcard E:Equipo
                                   EV_COD_USO        IN  AL_USOS.COD_USO%TYPE,
                                   EV_COD_BODEGA     IN  AL_BODEGAS.COD_BODEGA%TYPE,--P-CSR-11002 JLGN 27-10-2011
                                   SC_cursordatos    OUT NOCOPY REFCURSOR,
                                   SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)
        IS
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
        LN_count      NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
        TipArticulo   AL_ARTICULOS.TIP_TERMINAL%TYPE;
        LN_TipArticuloKit  al_articulos.TIP_ARTICULO%TYPE;
    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;



        BEGIN

        SELECT VAL_PARAMETRO
        INTO LN_TipArticuloKit
        FROM GED_PARAMETROS
        WHERE NOM_PARAMETRO ='TIP_ARTICULO_KIT';

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
        NULL;

        END;


        --1.-OBtener parametros de Simcard y Equipo GSM

        IF EV_IND_EQUIPO='S' THEN
           SELECT VAL_PARAMETRO
           INTO TipArticulo
           FROM GED_PARAMETROS
           WHERE NOM_PARAMETRO='COD_SIMCARD_GSM';
        ELSE
           SELECT VAL_PARAMETRO
           INTO TipArticulo
           FROM GED_PARAMETROS
           WHERE NOM_PARAMETRO='COD_TERMINAL_GSM';
        END IF;



        LV_Sql:='SELECT /*+index(a pk_al_articulos) index(b al_tecnoart_pk)*/ A.COD_ARTICULO, A.DES_ARTICULO, NVL(A.MES_GARANTIA,0),TIP_ARTICULO';

                IF EV_COD_BODEGA = 0 THEN
                    --Cuando el Articulo es Externo se debe mostrar todos los articulos
                    LV_sql := LV_Sql || ' FROM AL_ARTICULOS A, AL_TECNOARTICULO_TD B';--P-CSR-11002 JLGN 27-10-2011
                ELSE
                    --Cuando el Articulo es Interno se debe filtrar por Stock
                    LV_sql := LV_Sql || ' FROM AL_ARTICULOS A, AL_TECNOARTICULO_TD B, AL_STOCK C';--P-CSR-11002 JLGN 27-10-2011
                END IF;

                    LV_sql := LV_Sql || ' WHERE A.COD_PRODUCTO = 1 AND A.COD_ARTICULO = B.COD_ARTICULO';


                IF EV_COD_BODEGA <> 0 THEN
                    --Inicio P-CSR-11002 JLGN 27-10-2011
                    LV_sql := LV_Sql || ' AND A.COD_ARTICULO = C.COD_ARTICULO';
                    LV_sql := LV_Sql || ' AND C.COD_BODEGA = ' || EV_COD_BODEGA;
                    LV_sql := LV_Sql || ' AND C.COD_ESTADO = 1 ';
                    LV_sql := LV_Sql || ' AND C.CAN_STOCK  > 0 ';
                    --Fin P-CSR-11002 JLGN 27-10-2011
                END IF;

                LV_sql := LV_Sql || ' AND B.COD_TECNOLOGIA =''' || EV_COD_TECNOLOGIA  ||'''';
                --GSM : G:Simcard T: Terminal
                --D:Equipos CDMA
                IF  EV_COD_TECNOLOGIA='GSM' THEN
                    LV_sql := LV_Sql || ' AND A.TIP_TERMINAL = ''' || tipArticulo ||'''';
                ELSE
                    LV_sql := LV_Sql || ' AND A.TIP_TERMINAL = ''' || EV_TIP_TERMINAL ||'''';
                END IF;
                LV_Sql:= LV_Sql || ' AND A.IND_EQUIACC =''E''';


                --'Los KIT ya no tendrßn asociado tipo de terminal (ni tecnologYa), la carga de ellos se
                --debe realizar evaluando si sus componentes estßn asociados al tipo de
                --tecnologYa de la venta.
                --Solo cuando es TDMA O CDMA se cargan los kit acß ya que cuando se estß vendiendo
                --GSM los kit se obtienen al seleccionar la SIMCARD y no el equipo.

                   IF EV_COD_USO=3 AND EV_COD_TECNOLOGIA ='GSM' AND EV_IND_EQUIPO='S'  THEN --Prepago
                      LV_Sql:= LV_Sql || ' UNION'
                      || ' SELECT DISTINCT A.COD_ARTICULO, A.DES_ARTICULO, A.MES_GARANTIA,A.TIP_ARTICULO'
                      || ' FROM AL_ARTICULOS A, AL_SERIES B, AL_COMPONENTE_KIT C, AL_ARTICULOS D, AL_TIPOS_TERMINALES E, AL_TECNOARTICULO_TD F'
                      || ' WHERE A.COD_PRODUCTO =1'
                      || ' AND A.IND_EQUIACC = ''E'''
                      || ' AND A.TIP_ARTICULO ='  || LN_TipArticuloKit
                      || ' AND A.COD_ARTICULO = B.COD_ARTICULO'
                      || ' AND B.NUM_SERIE = C.NUM_KIT'
                      || ' AND C.COD_ARTICULO = D.COD_ARTICULO'
                      || ' AND D.COD_PRODUCTO =1'
                      || ' AND D.TIP_TERMINAL = E.TIP_TERMINAL'
                      || ' AND E.COD_PRODUCTO = 1'
                      || ' AND E.TIP_TERMINAL = ''' || EV_TIP_TERMINAL ||''''
                      || ' AND D.COD_ARTICULO = F.COD_ARTICULO'
                      || ' AND F.COD_TECNOLOGIA =''' || EV_COD_TECNOLOGIA  ||'''';
                  END IF;


                  IF EV_COD_USO=3 AND EV_COD_TECNOLOGIA <> 'GSM' AND EV_IND_EQUIPO='E'  THEN --Prepago
                      LV_Sql:= LV_Sql || ' UNION'
                      || ' SELECT DISTINCT A.COD_ARTICULO, A.DES_ARTICULO, A.MES_GARANTIA,A.TIP_ARTICULO'
                      || ' FROM AL_ARTICULOS A, AL_SERIES B, AL_COMPONENTE_KIT C, AL_ARTICULOS D, AL_TIPOS_TERMINALES E, AL_TECNOARTICULO_TD F'
                      || ' WHERE A.COD_PRODUCTO =1'
                      || ' AND A.IND_EQUIACC = ''E'''
                      || ' AND A.TIP_ARTICULO ='  || LN_TipArticuloKit
                      || ' AND A.COD_ARTICULO = B.COD_ARTICULO'
                      || ' AND B.NUM_SERIE = C.NUM_KIT'
                      || ' AND C.COD_ARTICULO = D.COD_ARTICULO'
                      || ' AND D.COD_PRODUCTO =1'
                      || ' AND D.TIP_TERMINAL = E.TIP_TERMINAL'
                      || ' AND E.COD_PRODUCTO = 1'
                      || ' AND E.TIP_TERMINAL = ''' || EV_TIP_TERMINAL ||''''
                      || ' AND D.COD_ARTICULO = F.COD_ARTICULO'
                      || ' AND F.COD_TECNOLOGIA =''' || EV_COD_TECNOLOGIA  ||'''';
                  END IF;
                  LV_Sql:= LV_Sql || ' ORDER BY DES_ARTICULO';




        OPEN SC_cursordatos FOR LV_sql;




        EXCEPTION
            WHEN LE_no_data_found_cursor THEN
                SN_cod_retorno:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_Obtiene_Articulos_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_Obtiene_Articulos_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_Obtiene_Articulos_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_Obtiene_Articulos_PR', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_Obtiene_Articulos_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_Obtiene_Articulos_PR', LV_Sql, SQLCODE, LV_des_error );

    END VE_Obtiene_Articulos_PR;
PROCEDURE VE_getListLimiteConsumo_PR(EV_codPlanTarif  IN  tol_limite_plan_td.cod_plantarif%TYPE,
                                         EV_formatoFecha1 IN  VARCHAR2,
                                         EV_formatoFecha2 IN  VARCHAR2,
                                         EN_COD_CLIENTE   IN GE_CLIENTES.COD_CLIENTE%TYPE,
                                         SC_cursorDatos   OUT NOCOPY REFCURSOR,
                                         SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                                             SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_numEvento     OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentaci¿n TipoDoc = "Procedimiento">
            Elemento Nombre = "TO_getListLimiteConsumo_PR"
            Lenguaje="PL/SQL"
            Fecha="22-05-2007"
            Versi¿n="1.0.0"
            Dise±ador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>
                  Retorna limites de consumo para el plan tarifario
        </Retorno>
        <Descripci¿n>
                  Retorna limites de consumo para el plan tarifario
        </Descripci¿n>
        <Parßmetros>
             <Entrada>
               <param nom="EV_codPlanTarif"  Tipo="STRING"> codigo plan tarifario </param>
               <param nom="EV_formatoFecha1" Tipo="STRING"> formato de fecha (fecha) </param>
               <param nom="EV_formatoFecha2" Tipo="STRING"> formato de fecha (hora) </param>
             </Entrada>
             <Salida>
               <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor cuentas </param>
               <param nom="SN_codRetorno"  Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"  Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"   Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parßmetros>
        </Elemento>
        </Documentaci¿n>
        */
        NO_DATA_FOUND_CURSOR EXCEPTION;
        LV_desError  ge_errores_pg.desevent;
        LV_sql         ge_errores_pg.vquery;
        LN_contador  NUMBER;
        LV_CodTiplan TA_PLANTARIF.COD_TIPLAN%TYPE;
        LV_COLOR     GE_CLIENTES.COD_COLOR%TYPE;
        LV_SEGMENTO  GE_CLIENTES.COD_SEGMENTO%TYPE;
    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;


        SELECT COD_COLOR,COD_SEGMENTO
        INTO LV_COLOR,LV_SEGMENTO
        FROM GE_CLIENTES
        WHERE COD_CLIENTE= EN_COD_CLIENTE ;

        SELECT COD_TIPLAN
        INTO LV_CodTiplan
        FROM TA_PLANTARIF
        WHERE COD_PLANTARIF=EV_codPlanTarif;



        IF LV_CODTIPLAN<>CN_COD_TIPLANPREP THEN


            LV_Sql:='SELECT a.cod_limcons, '
                || '        c.des_color || ''-'' || a.descripcion || '' '' || b.MTO_MIN  || ''-'' || b.MTO_MAX, '
                || '        a.imp_limite, '
                || '        a.ind_unidades, '
                || '        b.ind_default '
                || '        TO_CHAR(a.fec_desde,' || EV_formatoFecha1 || EV_formatoFecha2 || '),'
                || '        TO_CHAR(a.fec_hasta,' || EV_formatoFecha1 || EV_formatoFecha2 || '),'
                || 'FROM tol_limite_td a,tol_limite_plan_td b '
                || 'WHERE a.cod_limcons = b.cod_limcons '
                || '  AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta,SYSDATE)'
                || '  AND b.cod_plantarif = EV_codPlanTarif'
                || '  AND b.ID_SUBSEGMENTO= '|| LV_SEGMENTO
                || '  AND b.IND_PRIORIDAD>= TO_NUMBER('||LV_COLOR||')'
                || '  AND c.cod_color     =  b.IND_PRIORIDAD'
                || ' ORDER BY b.IND_PRIORIDAD';

            OPEN SC_cursorDatos FOR
            SELECT a.cod_limcons ||'-' ||rownum,
                   c.des_color || '-' || a.descripcion || ' ' || b.MTO_MIN  || '-' || b.MTO_MAX,
                   a.imp_limite,
                   a.ind_unidades,
                   b.ind_default,
                   TO_CHAR(a.fec_desde,EV_formatoFecha1||EV_formatoFecha2),
                   TO_CHAR(a.fec_hasta,EV_formatoFecha1||EV_formatoFecha2)
                   ,b.MTO_MIN
                   ,b.MTO_MAX
                   ,b.FLG_CORTE
                   ,b.MTO_CONS
            FROM tol_limite_td a,tol_limite_plan_td b, ge_color_td c
            WHERE a.cod_limcons = b.cod_limcons
            AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta,SYSDATE)
            AND b.cod_plantarif = EV_codPlanTarif
            AND b.ID_SUBSEGMENTO= LV_SEGMENTO
            AND b.IND_PRIORIDAD>= TO_NUMBER(LV_COLOR)
            AND c.cod_color     =  b.IND_PRIORIDAD
            --ORDER BY b.IND_PRIORIDAD; JLGN 04-10-2011
            ORDER BY b.IND_DEFAULT DESC, b.IND_PRIORIDAD ASC;

        ELSE
           --Limite Consumo Prepago
           LV_Sql:='SELECT COD_LIMCONSUMO, DES_LIMCONSUMO, IMP_LIMCONSUMO,1,S,SYSDATE,31-12-3000'
                  ||' FROM TA_LIMCONSUMO'
                  ||' WHERE COD_PRODUCTO =' || CV_cod_producto;

           OPEN SC_cursorDatos FOR
           SELECT COD_LIMCONSUMO, DES_LIMCONSUMO, IMP_LIMCONSUMO,'1','S',SYSDATE,'31-12-3000',0,0,0,0
           FROM TA_LIMCONSUMO
           WHERE COD_PRODUCTO =CV_cod_producto;
        END IF;



        --IF (LN_contador = 0) THEN
        --    RAISE NO_DATA_FOUND_CURSOR;
        --END IF;

    EXCEPTION
            WHEN NO_DATA_FOUND_CURSOR THEN
                 SN_codRetorno:=1;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                    SV_menRetorno := 'ERROR AL OBTENER LIMITES DE CONSUMO ASOCIADOS AL PLAN';
                 END IF;
                 LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:VE_SERVICIOS_VENTA_PG.VE_getListLimiteConsumo_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                 SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
                 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'TO_servicios_tol_PG.TO_getListLimiteConsumo_PR', LV_Sql, SN_codRetorno, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := 'ERROR AL OBTENER LIMITES DE CONSUMO ASOCIADOS AL PLAN';
                END IF;
                LV_desError  := 'OTHERS:VE_SERVICIOS_VENTA_PG.VE_getListLimiteConsumo_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_SERVICIOS_VENTA_PG.VE_getListLimiteConsumo_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_getListLimiteConsumo_PR;
PROCEDURE VE_obtiene_indSeguroMod_PR
                                  (EN_COD_MODVENTA   IN  GE_MODVENTA.COD_MODVENTA%TYPE,
                                   SN_IND_MODVENTA   OUT NOCOPY GE_MODVENTA.IND_SEGURO%TYPE,
                                   SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)
        IS
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
        LN_count      NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
        TipArticulo   AL_ARTICULOS.TIP_TERMINAL%TYPE;
    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

        SELECT IND_SEGURO
        INTO  SN_IND_MODVENTA
        FROM GE_MODVENTA
        WHERE COD_MODVENTA=EN_COD_MODVENTA;

        EXCEPTION
            WHEN LE_no_data_found_cursor THEN
                SN_cod_retorno:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_obtiene_indSeguroMod_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_obtiene_indSeguroMod_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_obtiene_indSeguroMod_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_obtiene_indSeguroMod_PR', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_obtiene_indSeguroMod_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_obtiene_indSeguroMod_PR', LV_Sql, SQLCODE, LV_des_error );

    END VE_obtiene_indSeguroMod_PR;


    PROCEDURE VE_Obtiene_Seguros_PR(SC_cursordatos    OUT NOCOPY REFCURSOR,
                                   SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)
        IS
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
        LN_count      NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
        TipArticulo   AL_ARTICULOS.TIP_TERMINAL%TYPE;
    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

        OPEN SC_cursordatos FOR
        SELECT COD_SEGURO,UPPER(DES_SEGUR)
        FROM GA_TIPOSEGURO_TD
        WHERE SYSDATE BETWEEN FEC_INICIO AND FEC_TERMINO;

    EXCEPTION
            WHEN LE_no_data_found_cursor THEN
                SN_cod_retorno:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_Obtiene_Seguros_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_Obtiene_Seguros_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_Obtiene_Seguros_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_Obtiene_Seguros_PR', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_Obtiene_Seguros_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_Obtiene_Seguros_PR', LV_Sql, SQLCODE, LV_des_error );

    END VE_Obtiene_Seguros_PR;
PROCEDURE VE_Obtiene_Usos_PR      (EV_TIP_RED        IN  TA_PLANTARIF.TIP_RED%TYPE,--Movil o Fija
                                   EV_COD_TIPO       IN  VARCHAR2, --Codigo de tipo de cliente
                                   SC_cursordatos    OUT NOCOPY REFCURSOR,
                                   SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)
        IS
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
        LN_count      NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
        TipArticulo   AL_ARTICULOS.TIP_TERMINAL%TYPE;
    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;





        LV_Sql:='SELECT COD_USO, DES_USO, IND_RESTPLAN FROM AL_USOS';

                --MA-184592 JLGN 13-06-2012
                --IF (EV_TIP_RED='M' AND (EV_COD_TIPO=1 or EV_COD_TIPO=2)) THEN
                IF (EV_TIP_RED='M' AND (EV_COD_TIPO=1 or EV_COD_TIPO=2 or EV_COD_TIPO=4)) THEN
                    LV_Sql:= LV_Sql || ' WHERE COD_USO not in (6,3,17)';
                END IF;

                IF (EV_TIP_RED='M' AND EV_COD_TIPO='3') THEN
                    LV_Sql:= LV_Sql || ' WHERE COD_USO in (3)';
                END IF;

                --MA-184592 JLGN 13-06-2012
                --IF (EV_TIP_RED='F' AND (EV_COD_TIPO=1 or EV_COD_TIPO=2)) THEN
                IF (EV_TIP_RED='F' AND (EV_COD_TIPO=1 or EV_COD_TIPO=2 or EV_COD_TIPO=4)) THEN
                    LV_Sql:= LV_Sql || ' WHERE COD_USO in (2)';
                END IF;

                IF (EV_TIP_RED='F' AND EV_COD_TIPO='3') THEN
                    LV_Sql:= LV_Sql || ' WHERE COD_USO in (3)';
                END IF;

               LV_Sql:= LV_Sql || 'AND COD_USO not in (SELECT VAL_PARAMETRO FROM GED_PARAMETROS WHERE NOM_PARAMETRO=''COD_USO''' || ' AND COD_PRODUCTO = 1 AND COD_MODULO=''AL'''||')';
               LV_Sql:= LV_Sql || 'AND IND_USOVENTA >= (SELECT B.VAL_PARAMETRO FROM GED_PARAMETROS B WHERE  B.NOM_PARAMETRO = ''USOS_VENTAS''' || 'AND B.COD_PRODUCTO = 1)';

        OPEN SC_cursordatos FOR LV_sql;




        EXCEPTION
            WHEN LE_no_data_found_cursor THEN
                SN_cod_retorno:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_Obtiene_Usos_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_Obtiene_Usos_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_Obtiene_Usos_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_Obtiene_Usos_PR', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_Obtiene_Usos_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_Obtiene_Usos_PR', LV_Sql, SQLCODE, LV_des_error );

    END VE_Obtiene_Usos_PR;
PROCEDURE VE_Obtiene_GruposPrest_PR(SC_cursordatos    OUT NOCOPY REFCURSOR,
                                   SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)
        IS
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
        LN_count      NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
        TipArticulo   AL_ARTICULOS.TIP_TERMINAL%TYPE;
    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

        OPEN SC_cursordatos FOR
        SELECT COD_VALOR,UPPER(DES_VALOR) AS DES_VALOR
        FROM GED_CODIGOS
        WHERE NOM_TABLA='GE_PRESTACIONES_TD'
        AND NOM_COLUMNA='GRP_PRESTACION';

    EXCEPTION
            WHEN LE_no_data_found_cursor THEN
                SN_cod_retorno:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_Obtiene_GruposPrest_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_Obtiene_GruposPrest_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_Obtiene_GruposPrest_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_Obtiene_GruposPrest_PR', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_Obtiene_GruposPrest_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_Obtiene_GruposPrest_PR', LV_Sql, SQLCODE, LV_des_error );

 END VE_Obtiene_GruposPrest_PR;
 PROCEDURE VE_Obtiene_TipoPrest_PR(EV_GRUPO_PREST    IN  GED_CODIGOS.COD_VALOR%TYPE,
                                   EV_TIPO_CLIENTE   IN  GED_CODIGOS.COD_VALOR%TYPE,
                                   SC_cursordatos    OUT NOCOPY REFCURSOR,
                                   SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)
        IS
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
        LN_count      NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
        TipArticulo   AL_ARTICULOS.TIP_TERMINAL%TYPE;
    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

        LV_Sql:='SELECT a.COD_PRESTACION,a.DES_PRESTACION,a.TIP_VENTA,a.IND_NUMERO,'
               || ' a.IND_DIR_INSTALACION,a.IND_INVENTARIO_FIJO,a.COD_PLANTARIF_DEFECTO,a.COD_CENTRAL_DEFECTO,'
               || ' a.COD_CELDA_DEFECTO,a.IND_SS_INTERNET, a.TIP_RED,a.grp_prestacion, a.IND_NUMPILOTO'
               || ' FROM GE_PRESTACIONES_TD a'
               --|| ' WHERE a.GRP_PRESTACION IN(' ||  EV_GRUPO_PREST || ')'
               || ' WHERE a.GRP_PRESTACION IN(''' ||  EV_GRUPO_PREST || ''')'
               || ' AND a.IND_ACTIVO=1';
        IF EV_TIPO_CLIENTE='3' THEN
           LV_Sql:= LV_Sql || ' AND a.TIP_VENTA=1';
        ELSE
           LV_Sql:= LV_Sql || ' AND a.TIP_VENTA=0';
        END IF;


        OPEN SC_cursordatos FOR LV_Sql;

--1 Prepago


    EXCEPTION
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_Obtiene_TipoPrest_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_Obtiene_TipoPrest_PR', LV_Sql, SQLCODE, LV_des_error );

 END VE_Obtiene_TipoPrest_PR;

PROCEDURE VE_Obtiene_DatosCentral_PR(EN_COD_CENTRAL  IN  ICG_CENTRAL.COD_CENTRAL%TYPE,
                                     SC_cursordatos  OUT NOCOPY REFCURSOR,
                                     SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
        IS
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
        LN_count      NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
        TipArticulo   AL_ARTICULOS.TIP_TERMINAL%TYPE;
    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

        OPEN SC_CURSORDATOS FOR
        select a.cod_central,a.nom_central,a.cod_hlr,b.cod_subalm ,a.cod_tecnologia
        from icg_central a, ge_subalms b
        where a.cod_alm=b.cod_alm
        and cod_central=EN_COD_CENTRAL;

    EXCEPTION
            WHEN LE_no_data_found_cursor THEN
                SN_cod_retorno:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_Obtiene_DatosCentral_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_Obtiene_DatosCentral_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_Obtiene_DatosCentral_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_Obtiene_DatosCentral_PR', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_Obtiene_DatosCentral_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_Obtiene_DatosCentral_PR', LV_Sql, SQLCODE, LV_des_error );
 END VE_Obtiene_DatosCentral_PR;
 PROCEDURE VE_Busca_Serie_PR(        EN_NUM_TELEFONO   IN  AL_SERIES.NUM_TELEFONO%TYPE,
                                     EN_NUM_SERIE      IN  AL_SERIES.NUM_SERIE%TYPE,
                                     EN_COD_CANAL      IN  GA_MODVENT_APLIC.COD_CANAL%TYPE,
                                     EN_COD_MODVENTA   IN  GE_MODVENTA.COD_MODVENTA%TYPE,
                                     EN_COD_VENDEDOR   IN  VE_VENDEDORES.COD_VENDEDOR%TYPE,
                                     EV_IND_EQUIPO     IN  VARCHAR2,--S: Simcard E:Equipo
                                     EV_COD_TECNOLOGIA IN  AL_TECNOLOGIA.COD_TECNOLOGIA%TYPE,
                                     EV_TIP_TERMINAL   IN  AL_ARTICULOS.TIP_TERMINAL%TYPE,
                                     EV_COD_USO        IN  AL_USOS.COD_USO%TYPE,
                                     EN_COD_CENTRAL  IN  ICG_CENTRAL.COD_CENTRAL%TYPE,
                                     EV_COD_HLR      IN  ICG_CENTRAL.COD_HLR%TYPE,
                                     SC_cursordatos    OUT NOCOPY REFCURSOR,
                                     SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)
        IS
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
        LN_count      NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
        TipArticulo   AL_ARTICULOS.TIP_TERMINAL%TYPE;
        LN_TipArticuloKit  al_articulos.TIP_ARTICULO%TYPE;
        LN_CodArticulo AL_ARTICULOS.COD_ARTICULO%TYPE;
        LN_TipArticulo AL_ARTICULOS.TIP_ARTICULO%TYPE;
        LN_Bodega AL_BODEGAS.COD_BODEGA%TYPE;
    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

        BEGIN

        SELECT VAL_PARAMETRO
        INTO LN_TipArticuloKit
        FROM GED_PARAMETROS
        WHERE NOM_PARAMETRO ='TIP_ARTICULO_KIT';

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
        NULL;

        END;

        --1.-OBtener parametros de Simcard y Equipo GSM


        BEGIN

            IF EV_IND_EQUIPO='S' THEN
               SELECT VAL_PARAMETRO
               INTO TipArticulo
               FROM GED_PARAMETROS
               WHERE NOM_PARAMETRO='COD_SIMCARD_GSM';
            ELSE
               SELECT VAL_PARAMETRO
               INTO TipArticulo
               FROM GED_PARAMETROS
               WHERE NOM_PARAMETRO='COD_TERMINAL_GSM';
            END IF;


            IF EN_NUM_SERIE IS NOT NULL THEN
               SELECT COD_ARTICULO,COD_BODEGA
               INTO LN_CodArticulo,LN_Bodega
               FROM AL_SERIES
               WHERE NUM_SERIE=EN_NUM_SERIE;
            ELSE
               SELECT COD_ARTICULO,COD_BODEGA
               INTO LN_CodArticulo,LN_Bodega
               FROM AL_SERIES
               WHERE NUM_TELEFONO=EN_NUM_TELEFONO;
            END IF;

            SELECT TIP_ARTICULO
            INTO LN_TipArticulo
            FROM AL_ARTICULOS
            WHERE COD_ARTICULO=LN_CodArticulo;

       EXCEPTION
        WHEN NO_DATA_FOUND THEN
             RAISE LE_no_data_found_cursor;
       END;

       IF LN_BODEGA IS NOT NULL THEN

          SELECT COD_BODEGA
          INTO LN_Bodega
          FROM VE_VENDALMAC
          WHERE COD_BODEGA=LN_BODEGA
          AND COD_VENDEDOR= EN_COD_VENDEDOR
          AND SYSDATE BETWEEN FEC_ASIGNACION AND NVL(FEC_DESASIGNAC,SYSDATE);

       END IF;

        LV_Sql:='SELECT a.num_serie,a.cod_bodega, a.cod_articulo, a.cod_estado,a.num_telefono,a.fec_entrada,c.des_stock, d.des_uso'
        || ' FROM al_series a, ve_vendalmac b, al_tipos_stock c, al_usos d';
        IF EN_NUM_TELEFONO IS NOT NULL THEN
           LV_Sql:= LV_Sql || ' WHERE num_telefono =' || EN_NUM_TELEFONO;
        ELSE
           LV_Sql:= LV_Sql || ' WHERE num_serie =''' || EN_NUM_SERIE || '''';
        END IF;
        LV_Sql:= LV_Sql || ' AND a.tip_stock IN (SELECT c.tip_stock FROM ga_modvent_aplic c WHERE c.cod_producto = 1 AND c.cod_modventa = '|| EN_COD_MODVENTA
        ||    ' AND c.cod_modventa IN (SELECT cod_modventa_nue  FROM ga_modvent_aplic d WHERE c.cod_modventa = d.cod_modventa)'
        ||    ' AND c.cod_canal =' || EN_COD_CANAL ; --0 es interno 1 externo
        --IF EN_NUM_SERIE IS NOT NULL THEN --JLGN 26-07-2011 P-CSR-11002
             LV_Sql:= LV_Sql ||  ' AND a.cod_uso = d.cod_uso ' ; -- JLGN 18/04/2011 P-CSR-11002
        --END IF;--JLGN 26-07-2011 P-CSR-11002
        LV_Sql:= LV_Sql ||     ' AND c.cod_aplic IS NULL)'
        ||    ' AND a.ind_telefono <>'
        ||    ' (SELECT val_parametro'
        ||    '  FROM ged_parametros'
        ||    '  WHERE cod_modulo = ''GE'''
        ||    '  AND cod_producto = 1'
        ||    '  AND nom_parametro = ''IND_TEL_OUT'')'
        ||    '  AND b.cod_vendedor=' || EN_COD_VENDEDOR
        ||'  AND B.cod_bodega=a.cod_bodega'
        ||'  AND a.tip_stock=c.tip_stock'
        ||'  AND SYSDATE BETWEEN B.FEC_ASIGNACION AND NVL(B.FEC_DESASIGNAC,SYSDATE)'
        ||'  AND a.cod_estado=1'
        ||'  AND ((a.num_telefono IS NULL';
        IF EV_COD_USO <> 3 AND EV_IND_EQUIPO = 'S' THEN -- P-CSR-11002 JLGN 20-04-2011
           --LV_Sql:= LV_Sql || '  AND a.cod_uso IN (1, 2, 8, 9, 13, 10, 14, 15, 16, 17, 55, 4))';
           LV_Sql:= LV_Sql || ' AND a.cod_uso IN (' || EV_COD_USO || '))'; --Incidencia 148144. Operadora solicita filtrar series por uso.
        ELSIF EV_IND_EQUIPO = 'S' THEN -- P-CSR-11002 JLGN 20-04-2011
           LV_Sql:= LV_Sql ||' AND a.cod_uso IN (3))';
        ELSE
           LV_Sql:= LV_Sql ||' )';-- P-CSR-11002 JLGN 20-04-2011
        END IF;

        IF EV_COD_USO =3 AND EV_IND_EQUIPO='S' AND LN_TipArticulo <> LN_TipArticuloKit THEN --Si es Simcard y no es KIT
           LV_Sql:= LV_Sql ||'  AND NUM_TELEFONO IS NOT NULL';
        END IF;


        IF EV_IND_EQUIPO='S' AND LN_TipArticulo <> LN_TipArticuloKit THEN --Si es Simcard y no es KIT
           LV_Sql:= LV_Sql || ' AND a.cod_hlr =''' || EV_COD_HLR || ''''; --Diferencia entre Simcard y equipo
        END IF;

        LV_Sql:= LV_Sql ||'  OR (a.num_telefono IS NOT NULL'
        ||'  AND a.cod_central =' || EN_COD_CENTRAL
        --||'  AND a.cod_uso =' || EV_COD_USO -- JLGN 18/04/2011 P-CSR-11002
        ||'  ))'
        || '  AND COD_ARTICULO IN('
        ||'  SELECT /*+index(a pk_al_articulos) index(b al_tecnoart_pk)*/ A.COD_ARTICULO'
                || ' FROM AL_ARTICULOS A, AL_TECNOARTICULO_TD B'
                || ' WHERE A.COD_PRODUCTO = 1 AND A.COD_ARTICULO = B.COD_ARTICULO'
                || ' AND B.COD_TECNOLOGIA =''' || EV_COD_TECNOLOGIA  ||'''';
                --GSM : G:Simcard T: Terminal
                --D:Equipos CDMA
                IF  EV_COD_TECNOLOGIA='GSM' THEN
                    LV_sql := LV_Sql || ' AND A.TIP_TERMINAL = ''' || tipArticulo ||'''';
                ELSE
                    LV_sql := LV_Sql || ' AND A.TIP_TERMINAL = ''' || EV_TIP_TERMINAL ||'''';
                END IF;
                LV_Sql:= LV_Sql || ' AND A.IND_EQUIACC =''E''';


                --'Los KIT ya no tendrßn asociado tipo de terminal (ni tecnologYa), la carga de ellos se
                --debe realizar evaluando si sus componentes estßn asociados al tipo de
                --tecnologYa de la venta.
                --Solo cuando es TDMA O CDMA se cargan los kit acß ya que cuando se estß vendiendo
                --GSM los kit se obtienen al seleccionar la SIMCARD y no el equipo.

                  -- IF EV_COD_USO=3 THEN --Prepago -- P-CSR-11002 JLGN 20-04-2011
                      LV_Sql:= LV_Sql || ' UNION'
                      || ' SELECT DISTINCT A.COD_ARTICULO'
                      || ' FROM AL_ARTICULOS A, AL_SERIES B, AL_COMPONENTE_KIT C, AL_ARTICULOS D, AL_TIPOS_TERMINALES E, AL_TECNOARTICULO_TD F'
                      || ' WHERE A.COD_PRODUCTO =1'
                      || ' AND A.IND_EQUIACC = ''E'''
                      || ' AND A.TIP_ARTICULO ='  || LN_TipArticuloKit
                      || ' AND A.COD_ARTICULO = B.COD_ARTICULO'
                      || ' AND B.NUM_SERIE = C.NUM_KIT'
                      || ' AND C.COD_ARTICULO = D.COD_ARTICULO'
                      || ' AND D.COD_PRODUCTO =1'
                      || ' AND D.TIP_TERMINAL = E.TIP_TERMINAL'
                      || ' AND E.COD_PRODUCTO = 1'
                      || ' AND E.TIP_TERMINAL = ''' || EV_TIP_TERMINAL ||''''
                      || ' AND D.COD_ARTICULO = F.COD_ARTICULO'
                      || ' AND F.COD_TECNOLOGIA =''' || EV_COD_TECNOLOGIA  ||''''
                      || ')';
                  -- P-CSR-11002 JLGN 20-04-2011
                  /*ELSE
                      LV_Sql:= LV_Sql || ')';
                  END IF;*/

        OPEN SC_CURSORDATOS FOR LV_Sql;



    EXCEPTION
            WHEN LE_no_data_found_cursor THEN
                SN_cod_retorno:=0;
                SV_mens_retorno:='SERIE INGRESADA NO EXISTE O NO CUMPLE CON LOS REQUISITOS COMERCIALES';
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_Busca_Serie_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_Busca_Serie_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                SV_mens_retorno:='Serie no existe o Vendedor no Tiene Acceso a la Bodega';
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_Busca_Serie_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_Obtiene_DatosCentral_PR', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_Busca_Serie_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_Busca_Serie_PR', LV_Sql, SQLCODE, LV_des_error );
 END VE_Busca_Serie_PR;

  PROCEDURE VE_getList_Series_PR(    EN_COD_BODEGA   IN  AL_SERIES.COD_BODEGA%TYPE,
                                     EN_COD_ARTICULO IN  AL_SERIES.COD_ARTICULO%TYPE,
                                     EV_COD_HLR      IN  ICG_CENTRAL.COD_HLR%TYPE,
                                     EN_COD_MODVENTA IN  GE_MODVENTA.COD_MODVENTA%TYPE,
                                     EN_COD_CANAL    IN  GA_MODVENT_APLIC.COD_CANAL%TYPE,
                                     EN_COD_VENDEDOR IN  VE_VENDEDORES.COD_VENDEDOR%TYPE,
                                     EN_COD_CENTRAL  IN  ICG_CENTRAL.COD_CENTRAL%TYPE,
                                     EN_COD_USO      IN  AL_USOS.COD_USO%TYPE,
                                     EN_TIP_ARTICULO IN  VARCHAR2, --S Simcard A:Articulo
                                     SC_cursordatos  OUT NOCOPY REFCURSOR,
                                     SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
        IS
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
        LN_count      NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
        TipArticulo   AL_ARTICULOS.TIP_TERMINAL%TYPE;
        LN_TipArticuloKit  al_articulos.TIP_ARTICULO%TYPE;
        LN_TIPArticulo AL_ARTICULOS.TIP_ARTICULO%TYPE;
        LN_IND_TELEFONO varchar2(10); -- IN SITU
        LN_cant_series  ged_parametros.val_parametro%TYPE; -- P-CSR-11002 JLGN 30-11-2011

    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;


        BEGIN

        SELECT VAL_PARAMETRO
        INTO LN_TipArticuloKit
        FROM GED_PARAMETROS
        WHERE NOM_PARAMETRO ='TIP_ARTICULO_KIT';


        SELECT TIP_ARTICULO
        INTO LN_TIPArticulo
        FROM AL_ARTICULOS
        WHERE COD_ARTICULO=EN_COD_ARTICULO;

    --INC. IN SITU
        SELECT VAL_PARAMETRO
        INTO LN_IND_TELEFONO
        FROM GED_PARAMETROS
        WHERE NOM_PARAMETRO ='TIP_IND_TELEFONO';
    --INC IN SITU

    --Inicio P-CSR-11002 JLGN 30-11-2011
        SELECT VAL_PARAMETRO
        INTO LN_cant_series
        FROM GED_PARAMETROS
        WHERE NOM_PARAMETRO ='CANT_SERIES';
    --Fin P-CSR-11002 JLGN 30-11-2011

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
           NULL;


        END;

        LV_Sql:= 'SELECT b.des_stock, a.num_serie, a.num_seriemec, a.num_telefono, '
            ||   ' a.cod_central, a.tip_stock, a.cod_uso, b.ind_valorar, a.fec_entrada, d.des_uso '
            ||   ' FROM al_series a, al_tipos_stock b, ve_vendalmac c, al_usos d'
            ||   ' WHERE a.cod_bodega = ' || EN_COD_BODEGA
            ||   ' AND a.cod_uso = d.cod_uso '
            ||   ' AND a.cod_articulo =' || EN_COD_ARTICULO
            ||   ' AND a.cod_estado = 1';
            IF EN_TIP_ARTICULO='S' AND LN_TIPArticulo <> LN_TipArticuloKit THEN --Si es Simcard y no es KIT
               LV_Sql:= LV_Sql || ' AND a.cod_hlr =''' || EV_COD_HLR || ''''; --Diferencia entre Simcard y equipo
            END IF;
        LV_Sql:= LV_Sql || ' AND a.cod_producto = 1'
            ||' AND a.tip_stock IN'
            ||' (SELECT c.tip_stock'
            ||' FROM ga_modvent_aplic c'
            ||' WHERE c.cod_producto = 1'
            ||' AND c.cod_modventa =' || EN_COD_MODVENTA
            ||' AND c.cod_modventa IN'
            ||' (SELECT cod_modventa_nue'
            ||'  FROM ga_modvent_aplic d'
            ||'  WHERE c.cod_modventa = d.cod_modventa)'
            ||'  AND c.cod_canal ='|| EN_COD_CANAL
            ||'  AND c.cod_aplic IS NULL)';
            IF EN_COD_USO<>3 AND  EN_TIP_ARTICULO='S' THEN
               LV_Sql:= LV_Sql ||  '  AND a.num_telefono IS NULL';
            END IF;
            IF LN_TIPArticulo = LN_TipArticuloKit THEN --Si es Simcard y no es KIT
               LV_Sql:= LV_Sql || ' AND a.ind_telefono=0'; --Diferencia entre Simcard y equipo
            ELSIF EN_COD_USO=3 AND EN_TIP_ARTICULO='S' THEN
               LV_Sql:= LV_Sql || ' AND a.ind_telefono in ( ' || LN_IND_TELEFONO || ' )'; --Diferencia entre Simcard y equipo
            END IF;
            LV_Sql:= LV_Sql ||'  AND b.tip_stock = a.tip_stock'
            || '  AND ((a.num_telefono IS NULL)';
            /*P-CSR-11002 JLGN 27-10-2011
            IF EN_COD_USO <> 3 AND EN_TIP_ARTICULO='S' THEN
                   --LV_Sql:= LV_Sql || ' AND a.cod_uso IN (1, 2, 8, 9, 13, 10, 14, 15, 16, 17, 55, 4))';
                LV_Sql:= LV_Sql || ' AND a.cod_uso IN (' || EN_COD_USO || '))'; --Incidencia 148144. Operadora solicita filtrar series por uso.
            ELSIF EN_TIP_ARTICULO='S' THEN  -- P-CSR-11002 JLGN 20-04-2011
               LV_Sql:= LV_Sql ||'  AND a.cod_uso IN (3))';
            ELSE
               LV_Sql:= LV_Sql ||'  )';   -- P-CSR-11002 JLGN 20-04-2011
            END IF;*/
            LV_Sql:= LV_Sql ||'  OR (a.num_telefono IS NOT NULL';
            IF EN_TIP_ARTICULO='S' AND LN_TIPArticulo <> LN_TipArticuloKit THEN --Si es Simcard y no es KIT
               LV_Sql:= LV_Sql ||'  AND a.cod_central =' || EN_COD_CENTRAL;
            END IF;
            --LV_Sql:= LV_Sql || '  AND a.cod_uso =' || EN_COD_USO -- JLGN 18/04/2011 P-CSR-11002
            LV_Sql:= LV_Sql ||'  ))'
            ||'  AND b.tip_stock = a.tip_stock'
            ||'  AND a.tip_stock <> 1'
            ||'  AND ind_telefono <>'
            ||' (SELECT val_parametro'
            ||' FROM ged_parametros'
            ||' WHERE cod_modulo = ''GE'''
            ||' AND cod_producto = 1'
            ||' AND nom_parametro = ''IND_TEL_OUT'')'
            ||'  AND c.cod_vendedor=' || EN_COD_VENDEDOR
            ||'  AND c.cod_bodega=a.cod_bodega'
            ||'  AND   SYSDATE BETWEEN C.FEC_ASIGNACION AND NVL(C.FEC_DESASIGNAC,SYSDATE)'
            --Inicio P-CSR-11002 JLGN 30-11-2011
            ||'  AND ROWNUM < '|| LN_cant_series ||' '
            --Fin P-CSR-11002 JLGN 30-11-2011
            ||'  ORDER BY FEC_ENTRADA ASC';

            OPEN SC_CURSORDATOS FOR LV_Sql;




    EXCEPTION
            WHEN LE_no_data_found_cursor THEN
                SN_cod_retorno:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_Busca_Serie_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_Busca_Serie_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_Busca_Serie_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_Obtiene_DatosCentral_PR', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_Busca_Serie_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_Busca_Serie_PR', LV_Sql, SQLCODE, LV_des_error );
 END VE_getList_Series_PR;

 PROCEDURE VE_ObtieneDatos_Seguro_PR(
                                   EV_COD_SEGURO     IN  GA_TIPOSEGURO_TD.COD_SEGURO%TYPE,
                                   EV_PERIODO        IN  GA_PERCONTRATO.NUM_MESES%TYPE,
                                   SN_COD_CONCEPTO   OUT NOCOPY FA_CONCEPTOS.COD_CONCEPTO%TYPE,
                                   SN_FECHA_FIN      OUT NOCOPY DATE,
                                   SN_COD_CARGO      OUT NOCOPY GA_TIPOSEGURO_TD.COD_CARGO%TYPE,
                                   SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)
        IS
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
        LN_count      NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
        LV_TIPCOBERT GA_TIPOSEGURO_TD.TIP_COBERT%TYPE;
    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;


        SELECT COD_CONCEPTO,TIP_COBERT,COD_CARGO
        INTO SN_COD_CONCEPTO,LV_TIPCOBERT,SN_COD_CARGO
        FROM GA_TIPOSEGURO_TD
        WHERE COD_SEGURO=EV_COD_SEGURO
        AND SYSDATE BETWEEN FEC_INICIO AND FEC_TERMINO;

        --1 a±o calendario
        --2 meses contrato
        --3 a±o desde la fecha de alta


        SELECT TO_DATE('31123000','DD-MM-YYYY')
        INTO SN_FECHA_FIN
        FROM dual;

        -- Se pide un nuevo cambio, siempre la fecha de termino es 31/12/3000 independiente del tipo de cobertura

       /* IF LV_TIPCOBERT='1' THEN
           --SELECT TO_DATE('3112'|| TO_CHAR(SYSDATE,'YYYY'),'DD-MM-YYYY')
           -- Se solicita para tipo cobertura 1 ampliar al 2030
           SELECT TO_DATE('31122030','DD-MM-YYYY')
           INTO SN_FECHA_FIN
           FROM DUAL;
        END IF;

        IF LV_TIPCOBERT='2' THEN
           SELECT ADD_MONTHS(SYSDATE,EV_PERIODO)
           INTO SN_FECHA_FIN
           FROM DUAL;
        END IF;

        IF LV_TIPCOBERT='3' THEN
           SELECT ADD_MONTHS(SYSDATE,12)
           INTO SN_FECHA_FIN
           FROM DUAL;
        END IF; */

    EXCEPTION
            WHEN LE_no_data_found_cursor THEN
                SN_cod_retorno:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_ObtieneDatos_Seguro_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_ObtConcepto_Seguro_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_ObtieneDatos_Seguro_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_ObtieneDatos_Seguro_PR', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_ObtieneDatos_Seguro_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_ObtieneDatos_Seguro_PR', LV_Sql, SQLCODE, LV_des_error );
    END VE_ObtieneDatos_Seguro_PR;
    PROCEDURE VE_GetList_TipoTerminal_PR(
                                   EV_COD_TECNOLOGIA IN  AL_TECNOLOGIA.COD_TECNOLOGIA%TYPE,
                                   SC_cursordatos  OUT NOCOPY REFCURSOR,
                                   SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)
        IS
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
        LN_count      NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
        tipArticulo AL_TIPOS_TERMINALES.TIP_TERMINAL%TYPE;
    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;


        --1.-OBtener parametros de Simcard y Equipo GSM

           SELECT VAL_PARAMETRO
           INTO TipArticulo
           FROM GED_PARAMETROS
           WHERE NOM_PARAMETRO='COD_TERMINAL_GSM';



           LV_Sql:='SELECT DISTINCT A.DES_TERMINAL, A.TIP_TERMINAL'
           || ' FROM AL_TIPOS_TERMINALES A, AL_TECNOARTICULO_TD B, AL_ARTICULOS C'
           || ' WHERE A.COD_PRODUCTO = 1 AND A.TIP_TERMINAL = C.TIP_TERMINAL'
           || ' AND C.COD_ARTICULO = B.COD_ARTICULO'
           || ' AND B.COD_TECNOLOGIA =''' || EV_COD_TECNOLOGIA || '''';
           IF EV_COD_TECNOLOGIA='GSM' THEN
              LV_Sql:= LV_Sql || 'AND C.TIP_TERMINAL=''' || TipArticulo || '''';
           END IF;

           OPEN SC_cursordatos for LV_Sql;

    EXCEPTION
            WHEN LE_no_data_found_cursor THEN
                SN_cod_retorno:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_GetList_TipoTerminal_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_GetList_TipoTerminal_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_GetList_TipoTerminal_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_GetList_TipoTerminal_PR', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_GetList_TipoTerminal_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_GetList_TipoTerminal_PR', LV_Sql, SQLCODE, LV_des_error );
    END VE_GetList_TipoTerminal_PR;
PROCEDURE VE_getList_Monedas_PR      (SC_cursordatos  OUT NOCOPY REFCURSOR,
                                     SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
        IS
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
        LN_count      NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
   BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

        OPEN SC_CURSORDATOS FOR
        select cod_moneda,des_moneda
        from ge_monedas;

    EXCEPTION
            WHEN LE_no_data_found_cursor THEN
                SN_cod_retorno:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_getList_Monedas_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_getList_Monedas_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_getList_Monedas_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_getList_Monedas_PR', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_getList_Monedas_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_getList_Monedas_PR', LV_Sql, SQLCODE, LV_des_error );
 END VE_getList_Monedas_PR;

 PROCEDURE VE_obtiene_serieEquipoKit_PR (
                                     EV_NumKit           IN AL_COMPONENTE_KIT.NUM_KIT%TYPE,
                                     EV_CodTecnologia    IN AL_TECNOLOGIA.COD_TECNOLOGIA%TYPE,
                                     EN_COD_ARTICULO_S   OUT NOCOPY AL_ARTICULOS.COD_ARTICULO%TYPE,
                                     EV_NUM_SERIE_S      OUT NOCOPY AL_SERIES.NUM_SERIE%TYPE,
                                     EV_COD_BODEGA_S     OUT NOCOPY AL_BODEGAS.COD_BODEGA%TYPE,
                                     EV_TIP_STOCK_S      OUT NOCOPY AL_TIPOS_STOCK.TIP_STOCK%TYPE,
                                     EN_IND_TELEFONO_S   OUT NOCOPY AL_SERIES.IND_TELEFONO%TYPE,
                                     EN_NUM_TELEFONO_S   OUT NOCOPY AL_SERIES.NUM_TELEFONO%TYPE,
                                     EV_NUM_SERIE_MEC_S  OUT NOCOPY AL_SERIES.NUM_SERIEMEC%TYPE,
                                     EV_TIP_TERMINAL_S   OUT NOCOPY AL_TIPOS_TERMINALES.TIP_TERMINAL%TYPE,
                                     EN_COD_ARTICULO_E   OUT NOCOPY AL_ARTICULOS.COD_ARTICULO%TYPE,
                                     EV_NUM_SERIE_E      OUT NOCOPY AL_SERIES.NUM_SERIE%TYPE,
                                     EV_COD_BODEGA_E     OUT NOCOPY AL_BODEGAS.COD_BODEGA%TYPE,
                                     EV_TIP_STOCK_E      OUT NOCOPY AL_TIPOS_STOCK.TIP_STOCK%TYPE,
                                     EN_IND_TELEFONO_E   OUT NOCOPY AL_SERIES.IND_TELEFONO%TYPE,
                                     EN_NUM_TELEFONO_E   OUT NOCOPY AL_SERIES.NUM_TELEFONO%TYPE,
                                     EV_NUM_SERIE_MEC_E  OUT NOCOPY AL_SERIES.NUM_SERIEMEC%TYPE,
                                     EV_TIP_TERMINAL_E   OUT NOCOPY AL_TIPOS_TERMINALES.TIP_TERMINAL%TYPE,
                                     SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
        IS
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
        LN_count      NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
   BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

        --Simcard

        IF EV_CodTecnologia='GSM' THEN
           SELECT A.COD_ARTICULO, A.NUM_SERIE, A.COD_BODEGA, A.TIP_STOCK,A.IND_TELEFONO, A.NUM_TELEFONO,A.NUM_SERIEMEC,B.TIP_TERMINAL
           INTO EN_COD_ARTICULO_S,EV_NUM_SERIE_S,EV_COD_BODEGA_S,EV_TIP_STOCK_S,EN_IND_TELEFONO_S,EN_NUM_TELEFONO_S,EV_NUM_SERIE_MEC_S,EV_TIP_TERMINAL_S
           FROM AL_COMPONENTE_KIT A, AL_ARTICULOS B
           WHERE A.NUM_KIT = EV_NumKit
           AND   A.COD_ARTICULO = B.COD_ARTICULO
           AND   B.IND_EQUIACC = 'E'
           AND   B.TIP_TERMINAL = 'G';
        END IF;

        --Equipo
        SELECT A.COD_ARTICULO, A.NUM_SERIE, A.COD_BODEGA, A.TIP_STOCK,A.IND_TELEFONO,A.NUM_TELEFONO,A.NUM_SERIEMEC,B.TIP_TERMINAL
        INTO EN_COD_ARTICULO_E,EV_NUM_SERIE_E,EV_COD_BODEGA_E,EV_TIP_STOCK_E,EN_IND_TELEFONO_E,EN_NUM_TELEFONO_E,EV_NUM_SERIE_MEC_E,EV_TIP_TERMINAL_E
        FROM AL_COMPONENTE_KIT A, AL_ARTICULOS B
        WHERE A.NUM_KIT = EV_NumKit
        AND   A.COD_ARTICULO = B.COD_ARTICULO
        AND   B.IND_EQUIACC = 'E'
        AND   B.TIP_TERMINAL <> 'G';


    EXCEPTION
            WHEN LE_no_data_found_cursor THEN
                SN_cod_retorno:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_getList_Monedas_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_getList_Monedas_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=156;
                SV_mens_retorno:='NO SE ENCUENTRA SIMCARD O EQUIPO PARA EL KIT SELECCIONADO';
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_getList_Monedas_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_getList_Monedas_PR', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_getList_Monedas_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_getList_Monedas_PR', LV_Sql, SQLCODE, LV_des_error );
 END VE_obtiene_serieEquipoKit_PR;
 PROCEDURE VE_Busca_Vendedor_PR (    EV_codVendedor      IN  VE_VENDEDORES.COD_VENDEDOR%TYPE, --Puede ser Dealer o Vendedor interno
                                     EV_filtro           IN  VARCHAR2,-- D-Directo I-Indirecto
                                     SN_codOficina       OUT NOCOPY GE_OFICINAS.COD_OFICINA%TYPE,
                                     SN_codTipcomis      OUT NOCOPY VE_TIPCOMIS.COD_TIPCOMIS%TYPE,
                                     SN_codVendedor      OUT NOCOPY VE_VENDEDORES.COD_VENDEDOR%TYPE,
                                     SN_codVendealer     OUT NOCOPY VE_VENDEALER.COD_VENDEALER%TYPE,
                                     SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
        IS
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
        LN_count      NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
        LV_indVtaExterna VE_TIPCOMIS.IND_VTA_EXTERNA%TYPE;
        LV_COUNT NUMBER(9);
   BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;


        IF EV_filtro ='D' THEN

           BEGIN
              SELECT COD_OFICINA, COD_TIPCOMIS, COD_VENDEDOR
              INTO SN_codOficina,SN_codTipcomis,SN_codVendedor
              FROM VE_VENDEDORES
              WHERE COD_VENDEDOR = EV_codVendedor;


              SELECT IND_VTA_EXTERNA
              INTO LV_indVtaExterna
              FROM VE_TIPCOMIS
              WHERE COD_TIPCOMIS =SN_codTipcomis;

              IF  LV_indVtaExterna = 1  THEN
                  SELECT  COUNT(1)  INTO LV_COUNT  FROM
                  VE_VENDEALER WHERE COD_VENDEDOR=EV_codVendedor AND FEC_FINCONTRATO
                  IS NULL;

                 IF LV_COUNT = 0 THEN
                     SN_cod_retorno:=4;
                     SV_mens_retorno:='Vendedor es Indirecto y No tiene Dealers vigentes';
                     RAISE LE_no_data_found_cursor;
                 ELSE
                     SN_cod_retorno:=4;
                     SV_mens_retorno:='Vendedor es Indirecto y No tiene Dealers vigentes';
                     RAISE LE_no_data_found_cursor;
                 END IF;

              ELSE
                     SELECT COUNT(1)
                     INTO LV_COUNT
                     FROM VE_VENDEDORES WHERE COD_VENDEDOR =EV_codVendedor
                     AND COD_ESTADO IN (1,2,3);

                     IF LV_COUNT >= 1 THEN
                     SN_cod_retorno:=4;
                     SV_mens_retorno:='Vendedor no esta vigente';
                     RAISE LE_no_data_found_cursor;
                     END IF;
              END IF;
           EXCEPTION
              WHEN NO_DATA_FOUND THEN
                   SN_cod_retorno:=4;
                   SV_mens_retorno:='C¿digo de vendedor No existe';
                   RAISE LE_no_data_found_cursor;
           END;
        ELSE
             BEGIN

             SELECT COD_OFICINA, COD_TIPCOMIS, COD_VENDEDOR, COD_VENDEALER
             INTO SN_codOficina,SN_codTipcomis,SN_codVendedor,SN_codVendealer
             FROM VE_VENDEALER
             --WHERE COD_VENDEALER = EV_codVendedor;
             WHERE COD_VENDEDOR = EV_codVendedor
             AND ROWNUM=1;

             SELECT COUNT(1)
             INTO LV_COUNT
             FROM VE_VENDEALER
             --WHERE COD_VENDEALER = EV_codVendedor
             WHERE COD_VENDEDOR = EV_codVendedor
             AND FEC_FINCONTRATO IS NULL;
             IF LV_COUNT = 0 THEN
                SN_cod_retorno:=4;
                SV_mens_retorno:='Vendedor Dealer No esta vigente';
                RAISE LE_no_data_found_cursor;
             END IF;

             EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                    SELECT COD_OFICINA, COD_TIPCOMIS, COD_VENDEDOR
                    INTO SN_codOficina,SN_codTipcomis,SN_codVendedor
                    FROM VE_VENDEALER
                    WHERE COD_VENDEDOR = EV_codVendedor
                    AND ROWNUM=1;


                    SELECT COUNT(1)
                    INTO LV_COUNT
                    FROM VE_VENDEALER
                    WHERE COD_VENDEDOR =EV_codVendedor
                    AND FEC_FINCONTRATO IS NULL;


                    IF LV_COUNT=0 THEN
                       SN_cod_retorno:=4;
                       SV_mens_retorno:='Vendedor No tiene Dealers vigentes';
                       RAISE LE_no_data_found_cursor;
                    END IF;
             END;

        END IF;


    EXCEPTION
            WHEN LE_no_data_found_cursor THEN
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_Busca_Vendedor_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_Busca_Vendedor_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=156;
                SV_mens_retorno:='C¿digo de vendedor No existe';
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_Busca_Vendedor_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_Busca_Vendedor_PR', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_Busca_Vendedor_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_Busca_Vendedor_PR', LV_Sql, SQLCODE, LV_des_error );
 END VE_Busca_Vendedor_PR;
 PROCEDURE VE_getList_TipSol_PR (    SC_cursordatos  OUT NOCOPY REFCURSOR,
                                     SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
        IS
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
        LN_count      NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
        LV_COUNT NUMBER(9);
   BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

        OPEN SC_cursordatos for
        SELECT COD_TIPO_SOLICITUD, DES_TIPO_SOLICITUD
        FROM   VE_TIPO_SOLICITUD_TD
        WHERE IND_VIGENCIA=1;


    EXCEPTION
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_getList_TipSol_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_getList_TipSol_PR', LV_Sql, SQLCODE, LV_des_error );
 END VE_getList_TipSol_PR;
 PROCEDURE VE_getList_EstFinSol_PR ( EV_EstadoInicio     IN  GA_VENTAS.IND_ESTVENTA%TYPE,
                                     SC_cursordatos      OUT NOCOPY REFCURSOR,
                                     SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
        IS
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
        LN_count      NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
        LV_COUNT NUMBER(9);
   BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

        OPEN SC_cursordatos for
        SELECT A.COD_ESTADODESTINO,B.DES_VALOR
        FROM VE_ESTADOSOLIC_TD A, GED_CODIGOS B
        WHERE A.COD_ESTADOORIGEN=EV_EstadoInicio
        AND B.NOM_TABLA='GA_VENTAS'
        AND B.NOM_COLUMNA='IND_ESTVENTA_EV'
        AND A.COD_ESTADODESTINO=B.COD_VALOR;


    EXCEPTION
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_getList_EstFinSol_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_getList_EstFinSol_PR', LV_Sql, SQLCODE, LV_des_error );
END VE_getList_EstFinSol_PR;

PROCEDURE VE_reglas_valid_vig_ss_pr( EN_cod_central      IN  icg_central.cod_central%TYPE,
                                     EV_tip_terminal     IN  icg_serviciotercen.tip_terminal%TYPE,
                                     EV_cod_tecnologia   IN  icg_central.cod_tecnologia%TYPE,
                                     so_cursor           OUT NOCOPY     refcursor,
                                     sn_cod_retorno      OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
                                     sv_mens_retorno     OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
                                     sn_num_evento       OUT NOCOPY     ge_errores_pg.evento)
    IS
    /*
    <Documentacion
      TipoDoc = "Procedure">>
       <Elemento
          Nombre = "VE_reglas_valid_vig_ss_PR
          Lenguaje="PL/SQL"
          Fecha="10-08-2006"
          Version="La del package"
          Dise?ador=""
          Programador=""
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
            lv_ssql := lv_ssql || ' a.cod_central = ' || EN_cod_central;

            SELECT a.cod_sistema
            INTO LN_codSistema
            FROM icg_central a
            WHERE a.cod_producto = 1 AND
                  a.cod_central = EN_cod_central;
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
        lv_ssql := lv_ssql || ' c.tip_terminal = ' ||  EV_tip_terminal || ' AND';
        lv_ssql := lv_ssql || ' c.tip_tecnologia = ' || EV_cod_tecnologia ;

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
                  c.tip_terminal =  EV_tip_terminal AND
                  c.tip_tecnologia = EV_cod_tecnologia AND
                  a.tip_relacion = 3;

    EXCEPTION
      WHEN error_exception THEN
          sn_cod_retorno := 904;
          IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,sv_mens_retorno) THEN
             sv_mens_retorno := cv_error_no_clasif;
          END IF;
          LV_des_error   := ' VE_reglas_valid_vig_ss_pr (obteniendo cod_sistema); - ' || SQLERRM;
          sn_num_evento  := Ge_Errores_Pg.grabarpl( sn_num_evento, CV_codmodulo, sv_mens_retorno,'1.0', USER, 'VE_parametros_comerciales_PG.VE_reglas_valid_vig_ss_pr', lv_ssql, sn_cod_retorno, LV_des_error );

      WHEN NO_DATA_FOUND THEN
          NULL;
      WHEN OTHERS THEN
          sn_cod_retorno := 904;
          IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,sv_mens_retorno) THEN
             sv_mens_retorno := cv_error_no_clasif;
          END IF;
          LV_des_error   := ' VE_reglas_valid_vig_ss_pr ('||'); - ' || SQLERRM;
          sn_num_evento  := Ge_Errores_Pg.grabarpl( sn_num_evento, CV_codmodulo, sv_mens_retorno, '1.0', USER, 'VE_parametros_comerciales_PG.VE_reglas_valid_vig_ss_pr', lv_ssql, sn_cod_retorno, LV_des_error );

END VE_reglas_valid_vig_ss_pr;


    PROCEDURE VE_list_campVigXCodTiplan_PR (
        EV_cod_tiplan        IN            bp_campanas_td.COD_TIPLAN%TYPE,
        SC_cursordatos           OUT NOCOPY     REFCURSOR,
        SN_cod_retorno         OUT NOCOPY     ge_errores_pg.CodError,
        SV_mens_retorno        OUT NOCOPY     ge_errores_pg.MsgError,
        SN_num_evento          OUT NOCOPY     ge_errores_pg.Evento
    ) IS

       LV_des_error              ge_errores_pg.desevent;
       LV_Sql                    ge_errores_pg.vquery;

       BEGIN
           SN_cod_retorno  := 0;
           SV_mens_retorno := NULL;
           SN_num_evento   := 0;

        OPEN SC_cursordatos FOR
            SELECT
                a.cod_campana, a.des_campana
            FROM
                bp_campanas_td a
            WHERE
                a.tip_entidad = 'A'
                AND TO_DATE(TO_CHAR(a.fec_termino,'YYYYMMDD'),'YYYYMMDD') >= TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD')
                AND a.COD_TIPLAN = EV_cod_tiplan
            ORDER BY
                a.ind_default DESC;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            SN_cod_retorno:=0;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
            LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_list_campVigXCodTiplan_PR();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'VE_parametros_comerciales_PG.VE_list_campVigXCodTiplan_PR', LV_Sql, SQLCODE, LV_des_error );
        WHEN OTHERS THEN
            SN_cod_retorno:=1;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_list_campVigXCodTiplan_PR();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'VE_parametros_comerciales_PG.VE_list_campVigXCodTiplan_PR', LV_Sql, SQLCODE, LV_des_error );

    END VE_list_campVigXCodTiplan_PR;

--Inicio P-CSR-11002 JLGN 27-04-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_cambio_uso_series_pr (
      ev_num_serie         IN              al_series.num_serie%TYPE,
      ev_nom_usuario       IN              VARCHAR2,
      en_cod_uso           IN              al_movimientos.cod_uso%TYPE,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   )
   AS
      LV_des_error       VARCHAR2(300);
      LV_sql             VARCHAR2(1000);
      rt_movim_info      al_movimientos%rowtype;
      rt_movim           al_movimientos%rowtype;
      error_ejecucion    EXCEPTION;

   BEGIN
      SN_cod_retorno := 0;
      SN_num_evento  := 0;
      SV_mens_retorno:= '';

      IF NOT (ve_rec_info_serie_mov_fn (ev_num_serie,rt_movim_info,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;

      LV_sql:=' SELECT  al_seq_mvto.NEXTVAL'
            ||' FROM dual';

      SELECT  al_seq_mvto.NEXTVAL
        INTO rt_movim.num_movimiento
        FROM dual;

      rt_movim.num_transaccion:= 3;
      rt_movim.fec_movimiento := SYSDATE;
      rt_movim.cod_bodega     := rt_movim_info.cod_bodega;
      rt_movim.tip_stock      := rt_movim_info.tip_Stock;
      rt_movim.cod_articulo   := rt_movim_info.cod_Articulo;
      rt_movim.cod_uso        := rt_movim_info.cod_Uso;
      rt_movim.cod_estado     := rt_movim_info.cod_Estado;
      rt_movim.num_serie      := rt_movim_info.num_Serie;
      rt_movim.num_cantidad   := 1;
      rt_movim.cod_estadomov  := 'SO';
      rt_movim.nom_usuarora   := USER;
      rt_movim.cod_producto   := 1;
      rt_movim.ind_telefono   := rt_movim_info.Ind_Telefono;
      rt_movim.num_telefono   := rt_movim_info.num_Telefono;
      rt_movim.cod_central    := rt_movim_info.cod_Central;
      rt_movim.tip_movimiento := 16;
      rt_movim.tip_stock_dest := rt_movim_info.tip_Stock;
      rt_movim.cod_transaccion:= 2;
      rt_movim.cod_bodega_dest:= rt_movim_info.cod_bodega;
      rt_movim.cod_central    := rt_movim_info.cod_central;
      rt_movim.cod_estado_dest:= 1;
      rt_movim.cod_subalm     := rt_movim_info.cod_subalm;
      rt_movim.cod_cat        := rt_movim_info.cod_Cat;
      rt_movim.PLAN           := rt_movim_info.Plan;
      rt_movim.carga          := rt_movim_info.Carga;
      rt_movim.num_sec_loca   := NULL;
      rt_movim.prc_unidad     := rt_movim_info.prc_unidad;
      rt_movim.cod_hlr        := rt_movim_info.cod_hlr;
      rt_movim.cod_plaza      := rt_movim_info.cod_plaza;
      rt_movim.cod_moneda     := rt_movim_info.cod_moneda;
      rt_movim.cod_uso_dest   := en_cod_uso;

      IF NOT (ve_crea_movimiento_fn(rt_movim,SN_cod_retorno,SV_mens_retorno,SN_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;


   EXCEPTION
      WHEN error_ejecucion THEN
         LV_des_error    := 'VE_parametros_comerciales_PG.ve_cambio_uso_series_pr(); - ' || SQLERRM;
         SN_num_evento   := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'VE_parametros_comerciales_PG.ve_cambio_uso_series_pr', LV_Sql, SQLCODE, LV_des_error );
      WHEN OTHERS THEN
            SN_cod_retorno:=1;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='OTHERS:VE_parametros_comerciales_PG.ve_cambio_uso_series_pr('||ev_num_serie||','||ev_nom_usuario||','||en_cod_uso||');- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'VE_parametros_comerciales_PG.VE_list_campVigXCodTiplan_PR', LV_Sql, SQLCODE, LV_des_error );

   END ve_cambio_uso_series_pr;
--Fin P-CSR-11002 JLGN 27-04-2011

--Inicio P-CSR-11002 JLGN 10-05-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_datos_direccion_pr (ev_cod_provincia  IN              ge_provincias.cod_provincia%TYPE,
                                   ev_cod_canton     IN              ge_regiones.cod_region%TYPE,
                                   ev_cod_distrito   IN              ge_ciudades.cod_ciudad%TYPE,
                                   sv_des_provincia  OUT NOCOPY      ge_provincias.des_provincia%TYPE,
                                   sv_des_canton     OUT NOCOPY      ge_regiones.des_region%TYPE,
                                   sv_des_distrito   OUT NOCOPY      ge_ciudades.des_ciudad%TYPE,
                                   sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                   sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                   sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) AS

  LV_des_error       VARCHAR2(300);
  LV_sql             VARCHAR2(1000);
  rt_movim_info      al_movimientos%rowtype;
  rt_movim           al_movimientos%rowtype;
  error_ejecucion    EXCEPTION;

  BEGIN
     SN_cod_retorno := 0;
     SN_num_evento  := 0;
     SV_mens_retorno:= '';

    LV_sql:=' SELECT a.des_region, b.des_provincia, c.des_ciudad '
          ||' FROM   ge_regiones a, ge_provincias b, ge_ciudades c '
          ||' WHERE  a.cod_region = b.cod_region '
          ||' AND    a.cod_region = c.cod_region '
          ||' AND    b.cod_provincia = c.cod_provincia '
          ||' AND    b.cod_provincia = '||ev_cod_canton||' '
          ||' AND    c.cod_ciudad = '||ev_cod_distrito||' '
          ||' AND    a.cod_region = '||ev_cod_provincia||' ';


    SELECT a.des_region, b.des_provincia, c.des_ciudad
    INTO   sv_des_provincia,sv_des_distrito, sv_des_canton
    FROM   ge_regiones a, ge_provincias b, ge_ciudades c
    WHERE  a.cod_region = b.cod_region
    AND    a.cod_region = c.cod_region
    AND    b.cod_provincia = c.cod_provincia
    AND    b.cod_provincia = ev_cod_canton
    AND    c.cod_ciudad = ev_cod_distrito
    AND    a.cod_region = ev_cod_provincia;

   EXCEPTION
      WHEN OTHERS THEN
            SN_cod_retorno:=1;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='OTHERS:VE_parametros_comerciales_PG.ve_datos_direccion_pr();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'VE_parametros_comerciales_PG.ve_datos_direccion_pr', LV_Sql, SQLCODE, LV_des_error );
   END ve_datos_direccion_pr;

--Fin P-CSR-11002 JLGN 10-05-2011

--Inicio P-CSR-11002 JLGN 16-05-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_valida_codigos_pr (ev_cod_valor     IN          ged_codigos.COD_VALOR%TYPE,
                                  sn_existe        OUT NOCOPY  NUMBER,
                                  sn_cod_retorno   OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                  sv_mens_retorno  OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                  sn_num_evento    OUT NOCOPY  ge_errores_pg.evento) AS

  LV_des_error       VARCHAR2(300);
  LV_sql             VARCHAR2(1000);
  rt_movim_info      al_movimientos%rowtype;
  rt_movim           al_movimientos%rowtype;
  error_ejecucion    EXCEPTION;

  BEGIN
     SN_cod_retorno := 0;
     SN_num_evento  := 0;
     SV_mens_retorno:= '';

     LV_sql:=' SELECT COUNT(0) '
           ||' FROM   ged_parametros '
           ||' WHERE  cod_modulo = ''VE'''
           ||' AND    nom_parametro = ''PASS_CALIFI_VT'''
           ||' AND    cod_producto = 1'
           ||' AND    val_parametro = '||ev_cod_valor;

     SELECT COUNT(0)
     INTO   sn_existe
     FROM   ged_parametros
     WHERE  cod_modulo = 'VE'
     AND    nom_parametro = 'PASS_CALIFI_VT'
     AND    cod_producto = 1
     AND    val_parametro = ev_cod_valor;

   EXCEPTION
      WHEN OTHERS THEN
            SN_cod_retorno:=1;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='OTHERS:VE_parametros_comerciales_PG.ve_valida_codigos_pr();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'VE_parametros_comerciales_PG.ve_valida_codigos_pr', LV_Sql, SQLCODE, LV_des_error );
   END ve_valida_codigos_pr;

--Fin P-CSR-11002 JLGN 16-05-2011

--Inicio P-CSR-11002 JLGN 15-06-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_obtiene_comuna_pr (ev_cod_provincia  IN ge_provincias.cod_provincia%TYPE,
                                  ev_cod_canton     IN ge_regiones.cod_region%TYPE,
                                  ev_cod_distrito   IN ge_ciudades.cod_ciudad%TYPE,
                                  sv_cod_comuna     OUT NOCOPY  ge_ciucom.COD_COMUNA%TYPE,
                                  sn_cod_retorno    OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                  sv_mens_retorno   OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                  sn_num_evento     OUT NOCOPY  ge_errores_pg.evento) AS

  LV_des_error       VARCHAR2(300);
  LV_sql             VARCHAR2(1000);
  rt_movim_info      al_movimientos%rowtype;
  rt_movim           al_movimientos%rowtype;
  error_ejecucion    EXCEPTION;

  BEGIN
     SN_cod_retorno := 0;
     SN_num_evento  := 0;
     SV_mens_retorno:= '';

     LV_sql:=' SELECT cod_comuna '
           ||' FROM   ge_ciucom '
           ||' WHERE  cod_region = '||ev_cod_provincia||' '
           ||' AND    cod_provincia = '||ev_cod_canton||' '
           ||' AND    cod_ciudad = '||ev_cod_distrito||' ';

     SELECT cod_comuna
     INTO   sv_cod_comuna
     FROM   ge_ciucom
     WHERE  cod_region = ev_cod_provincia
     AND    cod_provincia = ev_cod_canton
     AND    cod_ciudad = ev_cod_distrito
     AND    cod_comuna < 1000;

   EXCEPTION
      WHEN OTHERS THEN
            SN_cod_retorno:=1;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='OTHERS:VE_parametros_comerciales_PG.ve_obtiene_comuna_pr();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'VE_parametros_comerciales_PG.ve_obtiene_comuna_pr', LV_Sql, SQLCODE, LV_des_error );
   END ve_obtiene_comuna_pr;

--Fin P-CSR-11002 JLGN 15-06-2011

--Inicio P-CSR-11002 JLGN 26-05-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_datos_venta_pr (en_num_venta    IN ga_ventas.NUM_VENTA%TYPE,
                               sv_fec_venta    OUT NOCOPY VARCHAR2,
                               sv_cod_oficina  OUT NOCOPY ga_ventas.COD_OFICINA%TYPE,
                               sv_des_oficina  OUT NOCOPY ge_oficinas.DES_OFICINA%TYPE,
                               sv_bancocc      OUT NOCOPY ge_bancos.DES_BANCO%TYPE,
                               sv_cuentacorr   OUT NOCOPY ga_ventas.NUM_CTACORR%TYPE,
                               sv_bancotarjeta OUT NOCOPY ge_bancos.DES_BANCO%TYPE,
                               sv_tip_tarjeta  OUT NOCOPY ge_tiptarjetas.DES_TIPTARJETA%TYPE,
                               sv_num_tarjeta  OUT NOCOPY ga_ventas.NUM_TARJETA%TYPE,
                               sv_moneda       OUT NOCOPY ge_monedas.DES_MONEDA%TYPE,
                               sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                               sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                               sn_num_evento   OUT NOCOPY ge_errores_pg.evento) AS

  LV_des_error       VARCHAR2(300);
  LV_sql             VARCHAR2(1000);
  rt_movim_info      al_movimientos%rowtype;
  rt_movim           al_movimientos%rowtype;
  error_ejecucion    EXCEPTION;
  lv_cod_banco_cc    ga_ventas.COD_BANCO%TYPE;
  lv_cod_banco_tar   ga_ventas.COD_BANCOTARJ%TYPE;
  lv_tiptarjeta      ga_ventas.COD_TIPTARJETA%TYPE;
  lv_codMoneda       ge_monedas.COD_MONEDA%TYPE;

  BEGIN
     SN_cod_retorno := 0;
     SN_num_evento  := 0;
     SV_mens_retorno:= '';

     LV_sql:=' SELECT TO_CHAR(fec_venta,''DD-MM-YYYY''), cod_oficina '
           ||' FROM   ga_ventas '
           ||' WHERE  num_venta = '||en_num_venta;

     SELECT TO_CHAR(fec_venta,'DD-MM-YYYY'), cod_oficina, cod_banco, num_ctacorr, cod_bancotarj, cod_tiptarjeta, num_tarjeta, cod_moneda
     INTO   sv_fec_venta, sv_cod_oficina, lv_cod_banco_cc, sv_cuentacorr, lv_cod_banco_tar, lv_tiptarjeta, sv_num_tarjeta, lv_codMoneda
     FROM   ga_ventas
     WHERE  num_venta = en_num_venta;

     LV_sql:=' SELECT des_oficina '
           ||' FROM   ge_oficinas '
           ||' WHERE  cod_oficina = '||sv_cod_oficina;

     SELECT des_oficina
     INTO   sv_des_oficina
     FROM   ge_oficinas
     WHERE  cod_oficina = sv_cod_oficina;

     --Se valida si el lv_cod_banco_cc es distinto de vacio o nulo
     IF NOT lv_cod_banco_cc IS NULL THEN
        IF NOT TRIM(lv_cod_banco_cc) = '' THEN
             --Descripcion Banco CC
             LV_sql:=' SELECT des_banco'
                   ||' FROM   ge_bancos'
                   ||' WHERE  cod_banco = '||lv_cod_banco_cc;

             SELECT des_banco
             INTO   sv_bancocc
             FROM   ge_bancos
             WHERE  cod_banco = lv_cod_banco_cc;
        ELSE
            sv_bancocc :='';
        END IF;
     ELSE
        sv_bancocc :='';
     END IF;

     --Se valida si el lv_cod_banco_cc es distinto de vacio o nulo
     IF NOT lv_cod_banco_cc IS NULL THEN
        IF NOT TRIM(lv_cod_banco_cc) = '' THEN
             --Descripcion Banco Tarjeta
             LV_sql:=' SELECT des_banco'
                   ||' FROM   ge_bancos'
                   ||' WHERE  cod_banco = '||lv_cod_banco_tar;

             SELECT des_banco
             INTO   sv_bancotarjeta
             FROM   ge_bancos
             WHERE  cod_banco = lv_cod_banco_tar;

        ELSE
            sv_bancotarjeta :='';
        END IF;
     ELSE
        sv_bancotarjeta :='';
     END IF;

     IF NOT lv_cod_banco_cc IS NULL THEN
        IF NOT TRIM(lv_cod_banco_cc) = '' THEN
             --Descripcion  Tipo Tarjeta
             LV_sql:=' SELECT des_tiptarjeta'
                   ||' FROM   ge_tiptarjetas'
                   ||' WHERE  cod_tiptarjeta = '||lv_tiptarjeta;

             SELECT des_tiptarjeta
             INTO   sv_tip_tarjeta
             FROM   ge_tiptarjetas
             WHERE  cod_tiptarjeta = lv_tiptarjeta;

        ELSE
            sv_tip_tarjeta :='';
        END IF;
     ELSE
        sv_tip_tarjeta :='';
     END IF;

     SELECT des_moneda
     INTO   sv_moneda
     FROM   ge_monedas
     WHERE  cod_moneda = lv_codMoneda;

   EXCEPTION
      WHEN OTHERS THEN
            SN_cod_retorno:=1;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='OTHERS:VE_parametros_comerciales_PG.ve_datos_venta_pr();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'VE_parametros_comerciales_PG.ve_valida_codigos_pr', LV_Sql, SQLCODE, LV_des_error );
   END ve_datos_venta_pr;

--Fin P-CSR-11002 JLGN 26-05-2011
--Inicio P-CSR-11002 JLGN 27-05-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_datos_linea_pr (en_num_abonado  IN ga_abocel.NUM_ABONADO%TYPE,
                               sv_num_serie    OUT NOCOPY ga_equipaboser.NUM_SERIE%TYPE,
                               sv_num_imei     OUT NOCOPY ga_equipaboser.NUM_IMEI%TYPE,
                               sv_plan_tarif   OUT NOCOPY ta_plantarif.DES_PLANTARIF%TYPE,
                               --sv_cargo_pt     OUT NOCOPY ta_cargosbasico.IMP_CARGOBASICO%TYPE, P-CSR-11002 30-09-2011 JLGN
                               sv_cargo_pt     OUT NOCOPY VARCHAR2,
                               sv_des_terminal OUT NOCOPY al_articulos.DES_ARTICULO%TYPE,
                               sv_modventa     OUT NOCOPY ga_ventas.COD_MODVENTA%TYPE,
                               sn_num_meses    OUT NOCOPY ga_tipcontrato.MESES_MINIMO%TYPE,
                               sv_procequi     OUT NOCOPY ga_equipaboser.IND_PROCEQUI%TYPE,
                               sv_codPT        OUT NOCOPY ta_plantarif.COD_PLANTARIF%TYPE,
                               sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                               sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                               sn_num_evento   OUT NOCOPY ge_errores_pg.evento) AS

  LV_des_error       VARCHAR2(300);
  LV_sql             VARCHAR2(1000);
  rt_movim_info      al_movimientos%rowtype;
  rt_movim           al_movimientos%rowtype;
  error_ejecucion    EXCEPTION;
  lv_cod_articulo    al_articulos.COD_ARTICULO%TYPE;
  lv_tip_contrato    ga_abocel.COD_TIPCONTRATO%TYPE;
  lv_cod_cargobasico ta_plantarif.COD_CARGOBASICO%TYPE;
  ln_num_venta       ga_abocel.NUM_VENTA%TYPE;

  BEGIN
     SN_cod_retorno := 0;
     SN_num_evento  := 0;
     SV_mens_retorno:= '';

     --Se obtiene Plan Tarifario y tipo de contrato
     LV_sql:=' SELECT cod_plantarif, cod_tipcontrato, num_venta'
           ||' FROM   ga_abocel'
           ||' WHERE  num_abonado = '||en_num_abonado;

     SELECT cod_plantarif, cod_tipcontrato, num_venta
     INTO   sv_codPT, lv_tip_contrato, ln_num_venta
     FROM   ga_abocel
     WHERE  num_abonado = en_num_abonado;

     --Se obtiene Descripcion del Plan tarifario
     LV_sql:=' SELECT des_plantarif, cod_cargobasico'
           ||' FROM   ta_plantarif'
           ||' WHERE  cod_plantarif = '||sv_codPT;

     SELECT des_plantarif, cod_cargobasico
     INTO   sv_plan_tarif, lv_cod_cargobasico
     FROM   ta_plantarif
     WHERE  cod_plantarif = sv_codPT;

     --Se obtiene el cargo basico del PT
     LV_sql:=' SELECT imp_cargobasico'
           ||' FROM   ta_cargosbasico'
           ||' WHERE  cod_cargobasico ='|| lv_cod_cargobasico
           ||' AND    SYSDATE BETWEEN fec_desde AND fec_hasta'; --Incidencia 181211 JLGN 24-02-2012

     --P-CSR-11002 30-09-2011 JLGN
     /*SELECT imp_cargobasico
     INTO   sv_cargo_pt
     FROM   ta_cargosbasico
     WHERE  cod_cargobasico = lv_cod_cargobasico;*/

     SELECT TRIM(TO_CHAR(imp_cargobasico, '999,999,999,999' ))
     INTO   sv_cargo_pt
     FROM   ta_cargosbasico
     WHERE  cod_cargobasico = lv_cod_cargobasico
     AND    SYSDATE BETWEEN fec_desde AND fec_hasta; --Incidencia 181211 JLGN 24-02-2012

     --Se obtiene numero de serie de la linea
     LV_sql:=' SELECT num_serie'
           ||' FROM   ga_equipaboser'
           ||' WHERE  num_abonado = '||en_num_abonado
           ||' AND    tip_terminal = ''G'''
           ||' AND    fec_alta IN (SELECT MIN(fec_alta) '
           ||'                     FROM   ga_equipaboser '
           ||'                     WHERE  num_abonado = '||en_num_abonado||' '
           ||'                     AND    tip_terminal = ''G'''
           ||' )';

     SELECT num_serie
     INTO   sv_num_serie
     FROM   ga_equipaboser
     WHERE  num_abonado = en_num_abonado
     AND    tip_terminal = 'G'--SIMCARD
     AND    fec_alta IN (SELECT MIN(fec_alta)
                         FROM   ga_equipaboser
                         WHERE  num_abonado = en_num_abonado
                         AND    tip_terminal = 'G'--SIMCARD
     );

     --Se obtiene numero de imei y procedencia del terminal de la linea
     LV_sql:=' SELECT num_serie, cod_articulo, ind_procequi'
           ||' FROM   ga_equipaboser'
           ||' WHERE  num_abonado = '||en_num_abonado
           ||' AND    tip_terminal = ''T'''
           ||' AND    fec_alta IN (SELECT MIN(fec_alta) '
           ||'                     FROM   ga_equipaboser '
           ||'                     WHERE  num_abonado = '||en_num_abonado||' '
           ||'                     AND    tip_terminal = ''T'''
           ||' )';

     SELECT num_serie, cod_articulo, ind_procequi
     INTO   sv_num_imei, lv_cod_articulo, sv_procequi
     FROM   ga_equipaboser
     WHERE  num_abonado = en_num_abonado
     AND    tip_terminal = 'T'--TERMINAL
     AND    fec_alta IN (SELECT MIN(fec_alta)
                         FROM   ga_equipaboser
                         WHERE  num_abonado = en_num_abonado
                         AND    tip_terminal = 'T'--TERMINAL
     );

     --Se obtiene Descripcion del Terminal
     LV_sql:=' SELECT des_articulo'
           ||' FROM   al_articulos'
           ||' WHERE  cod_articulo = '||lv_cod_articulo;

     SELECT des_articulo
     INTO   sv_des_terminal
     FROM   al_articulos
     WHERE  cod_articulo = lv_cod_articulo;


     --Obtiene modalidad de venta
     LV_sql:=' SELECT cod_modventa '
           ||' FROM   ga_ventas '
           ||' WHERE  num_venta = '||ln_num_venta;

     SELECT cod_modventa
     INTO   sv_modventa
     FROM   ga_ventas
     WHERE  num_venta = ln_num_venta;

     --Obtiene Mese Contrato Minimo
     LV_sql:=' SELECT meses_minimo '
           ||' FROM   ga_tipcontrato '
           ||' WHERE  cod_tip_contrato = '||lv_tip_contrato;

     SELECT meses_minimo
     INTO   sn_num_meses
     FROM   ga_tipcontrato
     WHERE  cod_tipcontrato = lv_tip_contrato;

   EXCEPTION
      WHEN OTHERS THEN
            SN_cod_retorno:=1;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='OTHERS:VE_parametros_comerciales_PG.ve_datos_linea_pr();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'VE_parametros_comerciales_PG.ve_datos_linea_pr', LV_Sql, SQLCODE, LV_des_error );
   END ve_datos_linea_pr;

--Fin P-CSR-11002 JLGN 27-05-2011

--Inicio P-CSR-11002 JLGN 06-06-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_celular_cliente_pr (en_num_venta    IN ga_ventas.NUM_VENTA%TYPE,
                                   SC_cursordatos  OUT NOCOPY REFCURSOR,
                                   sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                   sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                   sn_num_evento   OUT NOCOPY ge_errores_pg.evento) AS

  LV_des_error       VARCHAR2(300);
  LV_sql             VARCHAR2(1000);
  rt_movim_info      al_movimientos%rowtype;
  rt_movim           al_movimientos%rowtype;
  error_ejecucion    EXCEPTION;
  ln_num_abonado     ga_abocel.NUM_ABONADO%TYPE;
  ln_cod_articulo    al_articulos.COD_ARTICULO%TYPE;
  lv_tip_contrato    ga_abocel.COD_TIPCONTRATO%TYPE;
  LN_count           NUMBER;

  BEGIN
     SN_cod_retorno := 0;
     SN_num_evento  := 0;
     SV_mens_retorno:= '';

     LV_sql:=' SELECT num_celular, num_abonado, cod_plantarif'
           ||' FROM   ga_abocel'
           ||' WHERE  num_venta = '||en_num_venta;

     SELECT COUNT(1)
     INTO   LN_count
     FROM   ga_abocel
     WHERE  num_venta = en_num_venta;


     OPEN SC_cursordatos FOR
         SELECT a.num_celular, a.num_abonado, a.cod_plantarif, b.tip_red
         FROM   ga_abocel a, ge_prestaciones_td b
         WHERE  a.num_venta = en_num_venta
         AND    a.cod_prestacion = b.cod_prestacion;

         /*SELECT num_celular, num_abonado, cod_plantarif
         FROM   ga_abocel
         WHERE  num_venta = en_num_venta;*/

     IF LN_count = 0 THEN
         RAISE error_ejecucion;
     END IF;

   EXCEPTION
      WHEN error_ejecucion THEN
            SN_cod_retorno:=0;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='OTHERS:VE_parametros_comerciales_PG.ve_datos_articulos_pr();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'VE_parametros_comerciales_PG.ve_celular_cliente_pr', LV_Sql, SQLCODE, LV_des_error );
      WHEN OTHERS THEN
            SN_cod_retorno:=1;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='OTHERS:VE_parametros_comerciales_PG.ve_datos_articulos_pr();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'VE_parametros_comerciales_PG.ve_celular_cliente_pr', LV_Sql, SQLCODE, LV_des_error );
   END ve_celular_cliente_pr;

--Fin P-CSR-11002 JLGN 06-06-2011

--Inicio P-CSR-11002 JLGN 06-06-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_pa_por_linea_pr (en_num_abonado  IN ga_abocel.NUM_ABONADO%TYPE,
                                ev_codPT        IN ta_plantarif.COD_PLANTARIF%TYPE,
                                SC_cursordatos  OUT NOCOPY REFCURSOR,
                                sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                sn_num_evento   OUT NOCOPY ge_errores_pg.evento) AS

  LV_des_error       VARCHAR2(300);
  LV_sql             VARCHAR2(1000);
  rt_movim_info      al_movimientos%rowtype;
  rt_movim           al_movimientos%rowtype;
  error_ejecucion    EXCEPTION;
  ln_num_abonado     ga_abocel.NUM_ABONADO%TYPE;
  ln_cod_articulo    al_articulos.COD_ARTICULO%TYPE;
  lv_tip_contrato    ga_abocel.COD_TIPCONTRATO%TYPE;
  LN_count           NUMBER(1);

  BEGIN
     SN_cod_retorno := 0;
     SN_num_evento  := 0;
     SV_mens_retorno:= '';

     LV_sql:=' SELECT a.des_prod_ofertado, d.monto_importe '
           ||' FROM   pf_productos_ofertados_td a,pr_productos_contratados_to b, pf_catalogo_ofertado_td c, pf_cargos_productos_td d, ps_plantarif_planadic_td e'
           ||' WHERE  b.num_abonado_beneficiario = '|| en_num_abonado
           ||' AND    a.cod_prod_ofertado = b.cod_prod_ofertado'
           ||' AND    a.cod_prod_ofertado = c.cod_prod_ofertado'
           ||' AND    b.cod_prod_ofertado = c.cod_prod_ofertado'
           ||' AND    a.cod_prod_ofertado = e.cod_prod_ofertado'
           ||' AND    b.cod_prod_ofertado = e.cod_prod_ofertado'
           ||' AND    c.cod_prod_ofertado = e.cod_prod_ofertado'
           ||' AND    e.tipo_relacion_pa = 3' --opcionales
           ||' AND    e.cod_plantarif = '||ev_codPT
           ||' AND    c.cod_cargo = d.cod_cargo'
           ||' AND    c.cod_canal = ''VT'''
           ||' AND    SYSDATE BETWEEN a.fec_inicio_vigencia AND a.fec_termino_vigencia';

     SELECT COUNT(1)
     INTO   LN_count
     FROM   pf_productos_ofertados_td a,pr_productos_contratados_to b, pf_catalogo_ofertado_td c, pf_cargos_productos_td d, ps_plantarif_planadic_td e,
            ge_monedas f --P-CSR-11002 JLGN 26-10-2011
     WHERE  b.num_abonado_beneficiario = en_num_abonado
     AND    a.cod_prod_ofertado = b.cod_prod_ofertado
     AND    a.cod_prod_ofertado = c.cod_prod_ofertado
     AND    b.cod_prod_ofertado = c.cod_prod_ofertado
     AND    a.cod_prod_ofertado = e.cod_prod_ofertado
     AND    b.cod_prod_ofertado = e.cod_prod_ofertado
     AND    c.cod_prod_ofertado = e.cod_prod_ofertado
     AND    e.tipo_relacion_pa = 3 --opcionales
     AND    e.cod_plantarif = ev_codPT
     AND    c.cod_cargo = d.cod_cargo
     AND    c.cod_canal = 'VT'
     AND    d.cod_moneda = f.cod_moneda --P-CSR-11002 JLGN 26-10-2011
     AND    SYSDATE BETWEEN a.fec_inicio_vigencia AND a.fec_termino_vigencia;

     OPEN SC_cursordatos FOR
         SELECT a.des_prod_ofertado, TRIM(TO_CHAR(d.monto_importe, '99,999,999,999,999' )), f.cod_moneda
         FROM   pf_productos_ofertados_td a,pr_productos_contratados_to b, pf_catalogo_ofertado_td c, pf_cargos_productos_td d, ps_plantarif_planadic_td e,
                ge_monedas f --P-CSR-11002 JLGN 26-10-2011
         WHERE  b.num_abonado_beneficiario = en_num_abonado
         AND    a.cod_prod_ofertado = b.cod_prod_ofertado
         AND    a.cod_prod_ofertado = c.cod_prod_ofertado
         AND    b.cod_prod_ofertado = c.cod_prod_ofertado
         AND    a.cod_prod_ofertado = e.cod_prod_ofertado
         AND    b.cod_prod_ofertado = e.cod_prod_ofertado
         AND    c.cod_prod_ofertado = e.cod_prod_ofertado
         AND    e.tipo_relacion_pa = 3 --opcionales
         AND    e.cod_plantarif = ev_codPT
         AND    c.cod_cargo = d.cod_cargo
         AND    c.cod_canal = 'VT'
         AND    d.cod_moneda = f.cod_moneda --P-CSR-11002 JLGN 26-10-2011
         AND    SYSDATE BETWEEN a.fec_inicio_vigencia AND a.fec_termino_vigencia;

     IF LN_count = 0 THEN
         RAISE error_ejecucion;
     END IF;

   EXCEPTION
      WHEN error_ejecucion THEN
            SN_cod_retorno:=0;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='OTHERS:VE_parametros_comerciales_PG.ve_pa_por_linea_pr();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'VE_parametros_comerciales_PG.ve_pa_por_linea_pr', LV_Sql, SQLCODE, LV_des_error );
      WHEN OTHERS THEN
            SN_cod_retorno:=1;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='OTHERS:VE_parametros_comerciales_PG.ve_pa_por_linea_pr();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'VE_parametros_comerciales_PG.ve_pa_por_linea_pr', LV_Sql, SQLCODE, LV_des_error );
   END ve_pa_por_linea_pr;

--Fin P-CSR-11002 JLGN 06-06-2011

--Inicio P-CSR-11002 JLGN 10-06-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_ss_por_linea_pr (en_num_abonado  IN ga_abocel.NUM_ABONADO%TYPE,
                                ev_codPT        IN ta_plantarif.COD_PLANTARIF%TYPE,
                                SC_cursordatos  OUT NOCOPY REFCURSOR,
                                sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                sn_num_evento   OUT NOCOPY ge_errores_pg.evento) AS

  LV_des_error       VARCHAR2(300);
  LV_sql             VARCHAR2(1000);
  rt_movim_info      al_movimientos%rowtype;
  rt_movim           al_movimientos%rowtype;
  error_ejecucion    EXCEPTION;
  ln_num_abonado     ga_abocel.NUM_ABONADO%TYPE;
  ln_cod_articulo    al_articulos.COD_ARTICULO%TYPE;
  lv_tip_contrato    ga_abocel.COD_TIPCONTRATO%TYPE;
  LN_count           NUMBER(1);

  BEGIN
     SN_cod_retorno := 0;
     SN_num_evento  := 0;
     SV_mens_retorno:= '';

     LV_sql:=' SELECT b.des_servicio, c.imp_tarifa'
           ||' FROM   ga_servsuplabo a, ga_servsupl b, ga_tarifas c, gad_servsup_plan d'
           ||' WHERE  num_abonado = '||en_num_abonado
           ||' AND    a.cod_servsupl = b.cod_servsupl'
           ||' AND    a.cod_servicio = b.cod_servicio'
           ||' AND    a.cod_servicio = c.cod_servicio'
           ||' AND    d.cod_servicio = a.cod_servicio'
           ||' AND    d.cod_plantarif = '||ev_codPT
           ||' AND    d.tip_relacion = 2 '--opcional
           ||' AND    c.cod_actabo = ''FA''';

     SELECT COUNT(1)
     INTO   LN_count
     FROM   ga_servsuplabo a, ga_servsupl b, ga_tarifas c, gad_servsup_plan d
     WHERE  num_abonado = en_num_abonado
     AND    a.cod_servsupl = b.cod_servsupl
     AND    a.cod_servicio = b.cod_servicio
     AND    a.cod_servicio = c.cod_servicio
     AND    d.cod_servicio = a.cod_servicio
     AND    d.cod_plantarif = ev_codPT
     AND    d.tip_relacion = 2 --opcional
     AND    c.cod_actabo = 'FA';

     OPEN SC_cursordatos FOR
         SELECT b.des_servicio, TRIM(TO_CHAR(c.imp_tarifa, '99,999,999,999,999' ))
         FROM   ga_servsuplabo a, ga_servsupl b, ga_tarifas c, gad_servsup_plan d
         WHERE  num_abonado = en_num_abonado
         AND    a.cod_servsupl = b.cod_servsupl
         AND    a.cod_servicio = b.cod_servicio
         AND    a.cod_servicio = c.cod_servicio
         AND    d.cod_servicio = a.cod_servicio
         AND    d.cod_plantarif = ev_codPT
         AND    d.tip_relacion = 2 --opcional
         AND    c.cod_actabo = 'FA';

     IF LN_count = 0 THEN
         RAISE error_ejecucion;
     END IF;

   EXCEPTION
      WHEN error_ejecucion THEN
            SN_cod_retorno:=0;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='OTHERS:VE_parametros_comerciales_PG.ve_ss_por_linea_pr();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'VE_parametros_comerciales_PG.ve_ss_por_linea_pr', LV_Sql, SQLCODE, LV_des_error );
      WHEN OTHERS THEN
            SN_cod_retorno:=1;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='OTHERS:VE_parametros_comerciales_PG.ve_ss_por_linea_pr();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'VE_parametros_comerciales_PG.ve_ss_por_linea_pr', LV_Sql, SQLCODE, LV_des_error );
   END ve_ss_por_linea_pr;

--Fin P-CSR-11002 JLGN 10-06-2011

--Inicio P-CSR-11002 JLGN 01-07-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_sum_cargos_pt_pr(ev_numident     IN ge_clientes.NUM_IDENT%TYPE,
                                ev_tipident     IN ge_clientes.cod_tipident%TYPE,
                                sn_sumacargos   OUT NOCOPY NUMBER,
                                sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                sn_num_evento   OUT NOCOPY ge_errores_pg.evento) AS

  LV_des_error       VARCHAR2(300);
  LV_sql             VARCHAR2(1000);
  error_ejecucion    EXCEPTION;

  BEGIN
     SN_cod_retorno := 0;
     SN_num_evento  := 0;
     SV_mens_retorno:= '';

     LV_sql:=' SELECT SUM(c.imp_cargobasico)'
           ||' FROM   ge_clientes a, ga_abocel b, ta_cargosbasico c, ta_plantarif d'
           ||' WHERE  a.cod_tipident = '||ev_tipident
           ||' AND    a.num_ident = '||ev_numident
           ||' AND    a.cod_cliente = b.cod_cliente'
           ||' AND    b.cod_situacion <> ''BAA'''
           ||' AND    d.cod_plantarif = b.cod_plantarif'
           ||' AND    c.cod_cargobasico = d.cod_cargobasico'
           ||' AND    SYSDATE BETWEEN c.fec_desde AND c.fec_hasta';

     SELECT SUM(c.imp_cargobasico)
     INTO   sn_sumacargos
     FROM   ge_clientes a, ga_abocel b, ta_cargosbasico c, ta_plantarif d
     WHERE  a.cod_tipident = ev_tipident
     AND    a.num_ident = ev_numident
     AND    a.cod_cliente = b.cod_cliente
     AND    b.cod_situacion <> 'BAA'
     AND    d.cod_plantarif = b.cod_plantarif
     AND    c.cod_cargobasico = d.cod_cargobasico
     AND    SYSDATE BETWEEN c.fec_desde AND c.fec_hasta;

   EXCEPTION
      WHEN OTHERS THEN
            SN_cod_retorno:=1;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='OTHERS:VE_parametros_comerciales_PG.ve_sum_cargos_pt_pr();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'VE_parametros_comerciales_PG.ve_sum_cargos_pt_pr', LV_Sql, SQLCODE, LV_des_error );
   END ve_sum_cargos_pt_pr;

--Fin P-CSR-11002 JLGN 01-07-2011

--Inicio P-CSR-11002 JLGN 04-07-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_cargos_pt_pr(ev_plantarif    IN ta_plantarif.COD_PLANTARIF%TYPE,
                            sn_cargo        OUT NOCOPY ta_cargosbasico.IMP_CARGOBASICO%TYPE,
                            sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                            sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                            sn_num_evento   OUT NOCOPY ge_errores_pg.evento) AS

  LV_des_error       VARCHAR2(300);
  LV_sql             VARCHAR2(1000);
  error_ejecucion    EXCEPTION;

  BEGIN
     SN_cod_retorno := 0;
     SN_num_evento  := 0;
     SV_mens_retorno:= '';

     LV_sql:=' SELECT b.imp_cargobasico'
           ||' FROM   ta_plantarif a, ta_cargosbasico b'
           ||' WHERE  a.cod_cargobasico = b.cod_cargobasico'
           ||' AND    a.cod_plantarif = '||ev_plantarif||' '
           ||' AND    SYSDATE BETWEEN b.fec_desde AND b.fec_hasta';

     SELECT b.imp_cargobasico
     INTO   sn_cargo
     FROM   ta_plantarif a, ta_cargosbasico b
     WHERE  a.cod_cargobasico = b.cod_cargobasico
     AND    a.cod_plantarif = ev_plantarif
     AND    SYSDATE BETWEEN b.fec_desde AND b.fec_hasta;

   EXCEPTION
      WHEN OTHERS THEN
            SN_cod_retorno:=1;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='OTHERS:VE_parametros_comerciales_PG.ve_cargos_pt_pr();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'VE_parametros_comerciales_PG.ve_cargos_pt_pr', LV_Sql, SQLCODE, LV_des_error );
   END ve_cargos_pt_pr;

--Fin P-CSR-11002 JLGN 04-07-2011

--Inicio P-CSR-11002 JLGN 26-07-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_precio_terminal_pr(en_num_abonado     IN ga_abocel.NUM_ABONADO%TYPE,
                                  sn_precio_terminal OUT NOCOPY VARCHAR2,
                                  sn_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  sv_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  sn_num_evento      OUT NOCOPY ge_errores_pg.evento) AS

  LV_des_error       VARCHAR2(300);
  LV_sql             VARCHAR2(1000);
  error_ejecucion    EXCEPTION;
  ln_cod_articulo    ga_equipaboser.COD_ARTICULO%TYPE;
  ln_tip_stock       ga_equipaboser.TIP_STOCK%TYPE;
  ln_cod_uso         ga_equipaboser.COD_USO%TYPE;
  lv_calificacion    ge_clientes.COD_CALIFICACION%TYPE;
  lv_plantarif       ga_abocel.COD_PLANTARIF%TYPE;
  ln_tipcontrato     ga_abocel.COD_TIPCONTRATO%TYPE;
  ln_num_meses       ga_tipcontrato.MESES_MINIMO%TYPE;
  ln_prc_lista       al_precios_venta.PRC_VENTA%TYPE;
  ln_prc_venta       al_precios_venta.PRC_VENTA%TYPE;
  ln_numventa        ga_ventas.NUM_VENTA%TYPE;
  ln_modventa        ga_ventas.COD_MODVENTA%TYPE;
  ln_precio_final    NUMBER;

  BEGIN
     SN_cod_retorno := 0;
     SN_num_evento  := 0;
     SV_mens_retorno:= '';

     --Se obtiene cod_articulo, tip_stock y cod_uso del terminal
     LV_sql:=' SELECT cod_articulo, tip_stock '
           ||' FROM   ga_equipaboser'
           ||' WHERE  num_abonado = '||en_num_abonado
           ||' AND    tip_terminal = ''T''';

     SELECT cod_articulo, tip_stock--, cod_uso
     INTO   ln_cod_articulo, ln_tip_stock--, ln_cod_uso
     FROM   ga_equipaboser
     WHERE  num_abonado = en_num_abonado
     AND    tip_terminal = 'T';

     --Se obtiene Calificacion del cliente
     LV_sql:=' SELECT cod_calificacion'
           ||' FROM   ge_clientes'
           ||' WHERE  cod_cliente IN (SELECT cod_cliente'
           ||'                        FROM   ga_abocel'
           ||'                        WHERE  num_abonado = '||en_num_abonado
           ||' )';

     SELECT cod_calificacion
     INTO   lv_calificacion
     FROM   ge_clientes
     WHERE  cod_cliente IN (SELECT cod_cliente
                            FROM   ga_abocel
                            WHERE  num_abonado = en_num_abonado
     );

     --Se obtiene Plan tarifario y tipo de contrato
     LV_sql:=' SELECT cod_plantarif, cod_tipcontrato, num_venta'
           ||' FROM   ga_abocel'
           ||' WHERE  num_abonado = '||en_num_abonado;

     SELECT cod_plantarif, cod_tipcontrato, num_venta, cod_uso
     INTO   lv_plantarif, ln_tipcontrato, ln_numventa, ln_cod_uso
     FROM   ga_abocel
     WHERE  num_abonado = en_num_abonado;

     --Obtengo la cantidad de meses segun el contrato
     LV_sql:=' SELECT meses_minimo'
           ||' FROM   ga_tipcontrato'
           ||' WHERE  cod_tipcontrato = '||ln_tipcontrato;

     SELECT meses_minimo
     INTO   ln_num_meses
     FROM   ga_tipcontrato
     WHERE  cod_tipcontrato = ln_tipcontrato;

     --Obtengo Modalidad de venta
     LV_sql:=' SELECT cod_modventa'
           ||' FROM   ga_ventas'
           ||' WHERE  num_venta = '||ln_numventa;

     SELECT decode(cod_modventa,7,7,1)
     INTO   ln_modventa
     FROM   ga_ventas
     WHERE  num_venta = ln_numventa;

     --Se obtiene el Precio Lista del Articulo
     LV_sql:=' SELECT prc_venta'
           ||' FROM   al_precios_venta'
           ||' WHERE  cod_uso = 3'
           ||' AND    cod_articulo = '||ln_cod_articulo
           ||' AND    tip_stock = '||ln_tip_stock
           ||' AND    cod_modventa = '||ln_modventa
           --Inicio Inc. 181422 JLGN 01-03-2012
           ||' AND    cod_promedio = 0 '
           ||' AND    cod_antiguedad = 0 '
           --Fin Inc. 181422 JLGN 01-03-2012
           ||' AND    ind_recambio = 9'
           ||' AND    cod_categoria = ZZZ'
           ||' AND    cod_calificacion = '||lv_calificacion
           ||' AND SYSDATE BETWEEN fec_desde AND fec_hasta';

     SELECT prc_venta
     INTO   ln_prc_lista
     FROM   al_precios_venta
     WHERE  cod_uso = 3 --SIEMPRE ES PREPAGO
     AND    cod_articulo = ln_cod_articulo
     AND    tip_stock = ln_tip_stock
     AND    cod_modventa = 1
     --Inicio Inc. 181422 JLGN 01-03-2012
     AND    cod_promedio = 0
     AND    cod_antiguedad = 0
     --Fin Inc. 181422 JLGN 01-03-2012
     AND    ind_recambio = 9
     AND    cod_categoria = 'ZZZ'
     AND    cod_calificacion = lv_calificacion
     AND SYSDATE BETWEEN fec_desde AND fec_hasta;

     --Se obtiene el Precio Venta del Articulo
     LV_sql:=' SELECT prc_venta'
           ||' FROM   al_precios_venta'
           ||' WHERE  cod_uso = '||ln_cod_uso
           ||' AND    cod_articulo = '||ln_cod_articulo
           ||' AND    tip_stock = '||ln_tip_stock
           ||' AND    cod_modventa = '||ln_modventa
           ||' AND    ind_recambio <> 1'
           ||' AND    num_meses = '||ln_num_meses
           ||' AND    cod_categoria IN (SELECT cod_categoria'
           ||'                          FROM   ve_catplantarif'
           ||'                          WHERE  cod_plantarif = '||lv_plantarif
           ||' )'
           ||' AND    cod_calificacion = '||lv_calificacion
           ||' AND SYSDATE BETWEEN fec_desde AND fec_hasta';

     SELECT prc_venta
     INTO   ln_prc_venta
     FROM   al_precios_venta
     WHERE  cod_uso = ln_cod_uso
     AND    cod_articulo = ln_cod_articulo
     AND    tip_stock = ln_tip_stock
     AND    cod_modventa = ln_modventa
     AND    ind_recambio <> 1
     AND    num_meses = ln_num_meses
     AND    cod_categoria IN (SELECT cod_categoria
                              FROM   ve_catplantarif
                              WHERE  cod_plantarif = lv_plantarif
     )
     AND    cod_calificacion = lv_calificacion
     AND SYSDATE BETWEEN fec_desde AND fec_hasta;

     --Precio Terminal =  precioLista - precioVenta
     ln_precio_final := ln_prc_lista - ln_prc_venta;


     SELECT TRIM(TO_CHAR(ln_precio_final, '999,999,999,999' ))INTO sn_precio_terminal FROM dual;

   EXCEPTION
      WHEN OTHERS THEN
            SN_cod_retorno:=1;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='OTHERS:VE_parametros_comerciales_PG.ve_precio_terminal_pr();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'VE_parametros_comerciales_PG.ve_precio_terminal_pr', LV_Sql, SQLCODE, LV_des_error );
   END ve_precio_terminal_pr;

--Fin P-CSR-11002 JLGN 26-07-2011

--Inicio P-CSR-11002 JLGN 26-07-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_mensaje_error_pr(ev_modulo       IN  ged_codigos.COD_MODULO%TYPE,
                                ev_tabla        IN  ged_codigos.NOM_TABLA%TYPE,
                                ev_columna      IN  ged_codigos.NOM_COLUMNA%TYPE,
                                ev_valor        IN  VARCHAR2,
                                sv_mensaje      OUT NOCOPY VARCHAR2,
                                sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                sn_num_evento   OUT NOCOPY ge_errores_pg.evento) AS

  LV_des_error       VARCHAR2(300);
  LV_sql             VARCHAR2(1000);
  error_ejecucion    EXCEPTION;
  LC_cursordatos     REFCURSOR;
  lv_mensaje         VARCHAR2(1000);
  lv_mensaje2        VARCHAR2(1000);
  lv_valor2          VARCHAR2(1000);

  BEGIN
     SN_cod_retorno := 0;
     SN_num_evento  := 0;
     SV_mens_retorno:= '';
     lv_mensaje     := '';
     lv_mensaje2    := 'OK';

     SELECT ''''||REPLACE (ev_valor,',',''',''')||'''' INTO lv_valor2 FROM dual;

     LV_sql:=' SELECT des_valor'
           ||' FROM   ged_codigos'
           ||' WHERE  cod_modulo = '''||ev_modulo||''''
           ||' AND    nom_tabla = '''||ev_tabla||''''
           ||' AND    nom_columna = '''||ev_columna||''''
           ||' AND    cod_valor IN ('||lv_valor2||')';

     OPEN LC_cursordatos FOR LV_sql;

     LOOP
        FETCH LC_cursordatos INTO lv_mensaje;
        EXIT WHEN LC_cursordatos%NOTFOUND;

        IF TRIM(lv_mensaje2) = 'OK'  THEN
            lv_mensaje2 := lv_mensaje;
        ELSE
            lv_mensaje2 := lv_mensaje2||', '||lv_mensaje;
        END IF;
     END LOOP;

     sv_mensaje := lv_mensaje2;

   EXCEPTION
      WHEN OTHERS THEN
            SN_cod_retorno:=1;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='OTHERS:VE_parametros_comerciales_PG.ve_mensaje_error_pr();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'VE_parametros_comerciales_PG.ve_mensaje_error_pr', LV_Sql, SQLCODE, LV_des_error );
   END ve_mensaje_error_pr;

--Fin P-CSR-11002 JLGN 26-07-2011
--Inicio P-CSR-11002 JLGN 30-09-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_datos_linea_fija_pr (en_num_abonado  IN ga_abocel.NUM_ABONADO%TYPE,
                                    sv_plan_tarif   OUT NOCOPY ta_plantarif.DES_PLANTARIF%TYPE,
                                    sv_cargo_pt     OUT NOCOPY VARCHAR2,
                                    sv_modventa     OUT NOCOPY ga_ventas.COD_MODVENTA%TYPE,
                                    sn_num_meses    OUT NOCOPY ga_tipcontrato.MESES_MINIMO%TYPE,
                                    sv_codPT        OUT NOCOPY ta_plantarif.COD_PLANTARIF%TYPE,
                                    sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                    sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                    sn_num_evento   OUT NOCOPY ge_errores_pg.evento) AS

  LV_des_error       VARCHAR2(300);
  LV_sql             VARCHAR2(1000);
  rt_movim_info      al_movimientos%rowtype;
  rt_movim           al_movimientos%rowtype;
  error_ejecucion    EXCEPTION;
  lv_cod_articulo    al_articulos.COD_ARTICULO%TYPE;
  lv_tip_contrato    ga_abocel.COD_TIPCONTRATO%TYPE;
  lv_cod_cargobasico ta_plantarif.COD_CARGOBASICO%TYPE;
  ln_num_venta       ga_abocel.NUM_VENTA%TYPE;

  BEGIN
     SN_cod_retorno := 0;
     SN_num_evento  := 0;
     SV_mens_retorno:= '';

     --Se obtiene Plan Tarifario y tipo de contrato
     LV_sql:=' SELECT cod_plantarif, cod_tipcontrato, num_venta'
           ||' FROM   ga_abocel'
           ||' WHERE  num_abonado = '||en_num_abonado;

     SELECT cod_plantarif, cod_tipcontrato, num_venta
     INTO   sv_codPT, lv_tip_contrato, ln_num_venta
     FROM   ga_abocel
     WHERE  num_abonado = en_num_abonado;

     --Se obtiene Descripcion del Plan tarifario
     LV_sql:=' SELECT des_plantarif, cod_cargobasico'
           ||' FROM   ta_plantarif'
           ||' WHERE  cod_plantarif = '||sv_codPT;

     SELECT des_plantarif, cod_cargobasico
     INTO   sv_plan_tarif, lv_cod_cargobasico
     FROM   ta_plantarif
     WHERE  cod_plantarif = sv_codPT;

     --Se obtiene el cargo basico del PT
     LV_sql:=' SELECT imp_cargobasico'
           ||' FROM   ta_cargosbasico'
           ||' WHERE  cod_cargobasico ='|| lv_cod_cargobasico;

     --P-CSR-11002 30-09-2011 JLGN
     /*SELECT imp_cargobasico
     INTO   sv_cargo_pt
     FROM   ta_cargosbasico
     WHERE  cod_cargobasico = lv_cod_cargobasico;*/

     SELECT TRIM(TO_CHAR(imp_cargobasico, '999,999,999,999' ))
     INTO   sv_cargo_pt
     FROM   ta_cargosbasico
     WHERE  cod_cargobasico = lv_cod_cargobasico;

     --Obtiene modalidad de venta
     LV_sql:=' SELECT cod_modventa '
           ||' FROM   ga_ventas '
           ||' WHERE  num_venta = '||ln_num_venta;

     SELECT cod_modventa
     INTO   sv_modventa
     FROM   ga_ventas
     WHERE  num_venta = ln_num_venta;

     --Obtiene Mese Contrato Minimo
     LV_sql:=' SELECT meses_minimo '
           ||' FROM   ga_tipcontrato '
           ||' WHERE  cod_tip_contrato = '||lv_tip_contrato;

     SELECT meses_minimo
     INTO   sn_num_meses
     FROM   ga_tipcontrato
     WHERE  cod_tipcontrato = lv_tip_contrato;

   EXCEPTION
      WHEN OTHERS THEN
            SN_cod_retorno:=1;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='OTHERS:VE_parametros_comerciales_PG.ve_datos_linea_fija_pr();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'VE_parametros_comerciales_PG.ve_datos_linea_fija_pr', LV_Sql, SQLCODE, LV_des_error );
   END ve_datos_linea_fija_pr;

--Inicio P-CSR-11002 JLGN 20-10-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_limite_consumo_linea_pr(en_num_abonado  IN ga_abocel.num_abonado%TYPE,
                                       sn_mto_limite   OUT NOCOPY VARCHAR2,
                                       sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                       sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                       sn_num_evento   OUT NOCOPY ge_errores_pg.evento) AS

  LV_des_error       VARCHAR2(300);
  LV_sql             VARCHAR2(1000);
  error_ejecucion    EXCEPTION;
  LN_count           NUMBER;

  BEGIN
     SN_cod_retorno := 0;
     SN_num_evento  := 0;
     SV_mens_retorno:= '';

     SELECT COUNT(0)
     INTO   LN_count
     FROM   ga_abocel
     WHERE  num_abonado = en_num_abonado
     AND    cod_uso = 10;--Hibrido

     IF LN_count > 0 THEN
        sn_mto_limite := 'SIN LC';
     ELSE
         --LV_sql:=' SELECT mto_max' --JVA 184799 se cambia por mto_cons
	  	LV_sql:=' SELECT MTO_CONS'
               ||' FROM   tol_limite_plan_td'
               ||' WHERE  (c.cod_limcons,c.cod_plantarif, c.ind_prioridad, c.id_subsegmento )IN('
               ||' SELECT a.cod_limconsumo,a.cod_plantarif, b.cod_color, b.cod_segmento'
               ||' WHERE  num_abonado = '||en_num_abonado||')'
               ||' AND    a.cod_cliente = b.cod_cliente)';

         --SELECT  mto_max --JVA 184799 se cambia por mto_cons
         --SELECT TRIM(TO_CHAR(mto_max, '999,999,999,999' ))

	 --SELECT  MTO_CONS
         SELECT TRIM(TO_CHAR(MTO_CONS, '999,999,999,999' ))
         INTO   sn_mto_limite
         FROM   tol_limite_plan_td c
         WHERE  (c.cod_limcons,c.cod_plantarif, c.ind_prioridad, c.id_subsegmento )IN(
                 SELECT a.cod_limconsumo,a.cod_plantarif, b.cod_color, b.cod_segmento
                 FROM   ga_abocel a, ge_clientes b
                 WHERE  a.num_abonado = en_num_abonado
                 AND    a.cod_cliente = b.cod_cliente);
     END IF;

   EXCEPTION
      WHEN OTHERS THEN
            SN_cod_retorno:=1;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='OTHERS:VE_parametros_comerciales_PG.ve_limite_consumo_linea_pr();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'VE_parametros_comerciales_PG.ve_limite_consumo_linea_pr', LV_Sql, SQLCODE, LV_des_error );
   END ve_limite_consumo_linea_pr;

--Fin P-CSR-11002 JLGN 20-10-2011
--Inicio P-CSR-11002 JLGN 29-10-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_nombre_factura_pr(en_num_venta    IN ga_ventas.num_venta%TYPE,
                                 sv_nom_fact     OUT NOCOPY fa_interimpresion_td.DIR_WEB%TYPE,
                                 sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                 sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                 sn_num_evento   OUT NOCOPY ge_errores_pg.evento) AS

  LV_des_error       VARCHAR2(300);
  LV_sql             VARCHAR2(1000);
  error_ejecucion    EXCEPTION;
  LN_count           NUMBER;

  BEGIN
     SN_cod_retorno := 0;
     SN_num_evento  := 0;
     SV_mens_retorno:= '';

     /* Obtener nombre pdf con número de venta*/

     LV_sql:=' SELECT dir_web '
           ||' FROM   fa_interimpresion_td '
           ||' WHERE  num_proceso IN (SELECT num_proceso '
           ||'                        FROM (SELECT num_proceso, cod_estadoc, cod_estproc '
           ||'                              FROM   fa_interfact '
           ||'                              WHERE  num_venta = '||en_num_venta
           ||'                              UNION '
           ||'                              SELECT num_proceso, cod_estadoc, cod_estproc '
           ||'                              FROM   fa_histinterfact '
           ||'                              WHERE  num_venta = '||en_num_venta||') '
           ||'                        WHERE cod_estadoc > 399 '
           ||'                        AND cod_estproc = 3)';

     SELECT dir_web
     INTO   sv_nom_fact
     FROM   fa_interimpresion_td
     WHERE  num_proceso IN (SELECT num_proceso
                            FROM (SELECT num_proceso, cod_estadoc, cod_estproc
                                  FROM   fa_interfact
                                  WHERE  num_venta = en_num_venta
                                  UNION
                                  SELECT num_proceso, cod_estadoc, cod_estproc
                                  FROM   fa_histinterfact
                                  WHERE  num_venta = en_num_venta)
                            WHERE cod_estadoc > 399 --Estado del Documento debe ser mayor o igual a 400
                            AND cod_estproc = 3);--El estado del Proceso debe ser siempre 3

   EXCEPTION
      WHEN OTHERS THEN
            SN_cod_retorno:=1;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='OTHERS:VE_parametros_comerciales_PG.ve_nombre_factura_pr();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'VE_parametros_comerciales_PG.ve_nombre_factura_pr', LV_Sql, SQLCODE, LV_des_error );
   END ve_nombre_factura_pr;

--Fin P-CSR-11002 JLGN 29-10-2011
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Fin P-CSR-11002 JLGN 30-09-2011

--Inicio Incidencia 179734 JLGN 01-01-2012
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_valida_error_pr(ev_modulo       IN  ged_codigos.COD_MODULO%TYPE,
                               ev_tabla        IN  ged_codigos.NOM_TABLA%TYPE,
                               ev_columna      IN  ged_codigos.NOM_COLUMNA%TYPE,
                               ev_valor        IN  VARCHAR2,
                               sv_contador     OUT NOCOPY NUMBER,
                               sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                               sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                               sn_num_evento   OUT NOCOPY ge_errores_pg.evento) AS

  LV_des_error       VARCHAR2(300);
  LV_sql             VARCHAR2(1000);
  lv_valor2          VARCHAR2(1000);

  BEGIN
     SN_cod_retorno := 0;
     SN_num_evento  := 0;
     SV_mens_retorno:= '';

     SELECT ''''||REPLACE (ev_valor,',',''',''')||'''' INTO lv_valor2 FROM dual;

     LV_sql:=' SELECT count(0)'
           ||' FROM   ged_codigos'
           ||' WHERE  cod_modulo = '''||ev_modulo||''''
           ||' AND    nom_tabla = '''||ev_tabla||''''
           ||' AND    nom_columna = '''||ev_columna||''''
           ||' AND    cod_valor IN ('||lv_valor2||')';

     EXECUTE IMMEDIATE lv_sql INTO sv_contador;

   EXCEPTION
      WHEN OTHERS THEN
            SN_cod_retorno:=1;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='OTHERS:VE_parametros_comerciales_PG.ve_valida_error_pr();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'VE_parametros_comerciales_PG.ve_valida_error_pr', LV_Sql, SQLCODE, LV_des_error );
   END ve_valida_error_pr;
--Fin Incidencia 179734 JLGN 01-01-2011
--Inicio Incidencia 179734 JLGN 04-01-2012
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_valida_cliente_dda_pr(en_cod_cliente  IN ge_clientes.cod_cliente%TYPE,
                                     sn_resultado    OUT NOCOPY NUMBER,
                                     sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                     sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                     sn_num_evento   OUT NOCOPY ge_errores_pg.evento) AS

  LV_des_error  VARCHAR2(300);
  LV_sql        VARCHAR2(1000);
  ln_sispago    ge_clientes.cod_sispago%TYPE;

  BEGIN
     SN_cod_retorno := 0;
     SN_num_evento  := 0;
     SV_mens_retorno:= '';

     LV_sql := 'SELECT cod_sispago '
             ||'FROM   ge_clientes '
             ||'WHERE  cod_cliente = '||en_cod_cliente;

     SELECT cod_sispago
     INTO   ln_sispago
     FROM   ge_clientes
     WHERE  cod_cliente = en_cod_cliente;

     IF ln_sispago IS NULL OR ln_sispago = '' THEN
        sn_resultado := 0; -- sistema de pago del cliente no existe
     ELSE
        IF ln_sispago = 3 OR ln_sispago = 4 THEN
            sn_resultado := 1;
        ELSE
            -- sistema de pago es distinto de DEBITO A CTA CTE/AHORROS y DEBITO AUTOMATICO TARJETA DE CREDITO
            sn_resultado := 0;
        END IF;
     END IF;

   EXCEPTION
      WHEN OTHERS THEN
            SN_cod_retorno:=1;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='OTHERS:VE_parametros_comerciales_PG.ve_valida_cliente_dda_pr();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'VE_parametros_comerciales_PG.ve_valida_error_pr', LV_Sql, SQLCODE, LV_des_error );
   END ve_valida_cliente_dda_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Fin Incidencia 179734 JLGN 04-01-2011

--Inicio Incidencia 179734 JLGN 05-01-2012
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_lineas_activas_dda_pr(en_tip_ident    IN ge_clientes.cod_tipident%TYPE,
                                     en_num_ident    IN ge_clientes.num_ident%TYPE,
                                     sn_resultado    OUT NOCOPY NUMBER,
                                     sn_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                     sv_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                     sn_num_evento   OUT NOCOPY ge_errores_pg.evento) AS

  LV_des_error  VARCHAR2(300);
  LV_sql        VARCHAR2(1000);
  ln_sispago    ge_clientes.cod_sispago%TYPE;

  BEGIN
     SN_cod_retorno := 0;
     SN_num_evento  := 0;
     SV_mens_retorno:= '';

     LV_sql := 'SELECT COUNT(0) '
             ||'FROM   ga_abocel '
             ||'WHERE  cod_cliente IN (SELECT cod_cliente '
             ||'                       FROM   ge_clientes '
             ||'                       WHERE  cod_tipident = '||en_tip_ident
             ||'                       AND    num_ident = '||en_num_ident||')'
             ||'AND    cod_situacion NOT IN (''BAA'', ''BAP'')';

     SELECT COUNT(0)
     INTO   sn_resultado
     FROM   ga_abocel
     WHERE  cod_cliente IN (SELECT cod_cliente
                            FROM   ge_clientes
                            WHERE  cod_tipident = en_tip_ident
                            AND    num_ident = en_num_ident)
     AND    cod_situacion NOT IN ('BAA', 'BAP');

   EXCEPTION
      WHEN OTHERS THEN
            SN_cod_retorno:=1;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='OTHERS:VE_parametros_comerciales_PG.ve_lineas_activas_dda_pr();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'VE_parametros_comerciales_PG.ve_lineas_activas_dda_pr', LV_Sql, SQLCODE, LV_des_error );
   END ve_lineas_activas_dda_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Fin Incidencia 179734 JLGN 04-01-2011
END VE_parametros_comerciales_PG;
/
