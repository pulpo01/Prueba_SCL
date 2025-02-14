CREATE OR REPLACE PACKAGE BODY pv_grabar_simcard_sb_pg
IS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    PROCEDURE grabaError(
        EV_NombrePL              IN               VARCHAR2,
        LV_sSql                  IN               ge_errores_pg.vQuery,
        SN_cod_retorno           IN OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
        SV_mens_retorno          IN OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
        SN_num_evento            IN OUT NOCOPY    ge_errores_pg.evento)
    IS
        LV_des_error             ge_errores_pg.DesEvent;
    BEGIN
        SN_cod_retorno := cn_def_retorno;
        SV_mens_retorno := cv_def_error;

        LV_des_error   := EV_NombrePL || '(); - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, EV_NombrePL, LV_sSQL, SN_cod_retorno, LV_des_error );
                /*IF(SN_num_evento = 0) THEN
           dbms_output.put_line('-->' || EV_NombrePL || ' :' || SQLERRM || '(' || SN_num_evento  || ')');
        END IF;*/
        RAISE_APPLICATION_ERROR(SV_mens_retorno, cn_def_retorno);

    END grabaError;
    
---------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------

  FUNCTION repite (str IN varchar, cantidad IN number)
        RETURN VARCHAR2
  IS
        ret                      VARCHAR2(10) := NULL;
        i                        number := 0;
  BEGIN
    WHILE i < cantidad
    LOOP
        ret := ret || str;
                i := i+1;
    END LOOP;

        return ret;
  END repite;
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------

  FUNCTION cadena_servicio (
    servicio           IN ga_servsuplabo.cod_servsupl%TYPE,
    nivel              IN ga_servsuplabo.cod_nivel%TYPE,
    SN_cod_retorno           OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            OUT NOCOPY     ge_errores_pg.evento)
        RETURN VARCHAR2
  IS
        ret                      VARCHAR2(300) := NULL;
        LV_sSql                  ge_errores_pg.vQuery;
        SV_NombrePL              VARCHAR2(100) := 'pv_grabar_simcard_sb_pg.cadena_servicio';
        ilargo                   number;
        l_servicios              VARCHAR2(4);
        l_nivel                  VARCHAR2(2);
  BEGIN
    SN_num_evento := 0;

        LV_sSql := 'Analizando servicio...';
        ilargo := length(servicio);

        If length(Trim(servicio)) = 1 Then
       l_servicios := '0' || servicio || repite('0',3-ilargo);
    Else
       l_servicios := servicio || repite('0',4-ilargo);
    End If;

        If length(Trim( nivel)) = 1 Then
       l_nivel := '0' || nivel;
    Else
       l_nivel := nivel;
    End If;

        ret  := l_servicios || l_nivel;

    RETURN ret;

    EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  END cadena_servicio;
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
  FUNCTION pv_rec_num_servicios_pr (
    EV_cambioserie           IN OUT NOCOPY  PV_CAM_SIMCARD_OT,
    SN_cod_retorno           OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            OUT NOCOPY     ge_errores_pg.evento)
        RETURN VARCHAR2
  IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              VARCHAR2(100) := 'pv_grabar_simcard_sb_pg.pv_rec_num_servicios_pr';
        ret                      VARCHAR2(1000) := NULL;

    CURSOR servicios IS
        SELECT cod_servsupl, cod_nivel
            FROM ga_servsuplabo
            WHERE num_abonado = EV_cambioserie.NumAbonado
            AND ind_estado < 3;
                serv_record servicios%ROWTYPE;
  BEGIN
    SN_num_evento := 0;

    LV_sSql:= 'SELECT cod_servsupl, cod_nivel ';
    LV_sSql:= LV_sSql || 'FROM ga_servsuplabo  ';
    LV_sSql:= LV_sSql || 'num_abonado = ' || EV_cambioserie.NumAbonado;
    LV_sSql:= LV_sSql || 'AND ind_estado < 3';


   OPEN servicios;
   LOOP
      FETCH servicios INTO serv_record;
      EXIT WHEN servicios%NOTFOUND;
      -- ret := ret || cadena_servicio(serv_record.cod_servsupl, serv_record.cod_nivel, SN_cod_retorno, SV_mens_retorno, SN_num_evento); -- COL 78629|14-02-2009|SAQL
          RET := RET || LPAD(serv_record.cod_servsupl,2,'0') || LPAD(serv_record.cod_nivel,4,'0'); -- COL 78629|14-02-2009|SAQL
   END LOOP;
   CLOSE servicios;


        RETURN ret;

    EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  END pv_rec_num_servicios_pr;
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------

    PROCEDURE pv_registra_nueva_simcard_pr (
      ev_cambioserie           IN OUT NOCOPY    PV_CAM_SIMCARD_OT,
      SN_cod_retorno           IN OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          IN OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            IN OUT NOCOPY        ge_errores_pg.evento)

    IS


    LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql               ge_errores_pg.vQuery;
    LV_NombrePL      varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_registra_nueva_simcard_pr';
        I NUMBER;
    BEGIN

        sn_cod_retorno     := 0;
        sv_mens_retorno := NULL;
        sn_num_evento     := 0;

                LV_sSql := EV_cambioserie.to_debug() ||
        'INSERT INTO GA_EQUIPABOSER ' ||
        '(/*1*/ NUM_ABONADO,    NUM_SERIE,      COD_PRODUCTO,   ' ||
                ' /*2*/ IND_PROCEQUI,   FEC_ALTA,       IND_PROPIEDAD,  ' ||
                ' /*3*/ COD_BODEGA,     TIP_STOCK,      COD_ARTICULO,   ' ||
                ' /*4*/ IND_EQUIACC,    COD_MODVENTA,   TIP_TERMINAL,   ' ||
                ' /*5*/ COD_USO,        COD_CUOTA,      COD_ESTADO,     ' ||
                ' /*6*/ DES_EQUIPO,     NUM_MOVIMIENTO, COD_CAUSA,      ' ||
                ' /*7*/ IND_EQPRESTADO, NUM_IMEI,       COD_TECNOLOGIA  ' ||
        ')VALUES(' ||
        '/*1*/ ev_cambioserie.NumAbonado,        ev_cambioserie.Numserie,       ev_cambioserie.CodProducto, ' ||
                '/*2*/ ev_cambioserie.IndProcEqui,       SYSDATE,                       ev_cambioserie.IndPropiedad,' ||
                '/*3*/ ev_cambioserie.CodBodega,         ev_cambioserie.CodStock,       ev_cambioserie.CodArticulo, ' ||
                '/*4*/ ''E'',                            ev_cambioserie.CodModVenta,    ev_cambioserie.tip_terminal,' ||
        '/*5*/ ev_cambioserie.CodUsoLinea,       ev_cambioserie.CodCuota,       ev_cambioserie.CodEstado,   ' ||
        '/*6*/ ev_cambioserie.DesEquipo,         ev_cambioserie.NumMovimiento,  NULL,' ||
                '/*7*/ 0,                                ev_cambioserie.NumImei,        ev_cambioserie.CodTecnologia);';

                ev_cambioserie.fec_alta := SYSDATE;

        INSERT INTO GA_EQUIPABOSER
        (/*1*/ NUM_ABONADO,    NUM_SERIE,      COD_PRODUCTO,
                 /*2*/ IND_PROCEQUI,   FEC_ALTA,       IND_PROPIEDAD,
                 /*3*/ COD_BODEGA,     TIP_STOCK,      COD_ARTICULO,
                 /*4*/ IND_EQUIACC,    COD_MODVENTA,   TIP_TERMINAL,
                 /*5*/ COD_USO,        COD_CUOTA,      COD_ESTADO,
                 /*6*/ DES_EQUIPO,     NUM_MOVIMIENTO, COD_CAUSA,
                 /*7*/ IND_EQPRESTADO, NUM_IMEI,       COD_TECNOLOGIA
        )VALUES(
        /*1*/ ev_cambioserie.NumAbonado,        ev_cambioserie.Numserie,       ev_cambioserie.CodProducto,
                /*2*/ ev_cambioserie.IndProcEqui,       ev_cambioserie.fec_alta,       ev_cambioserie.IndPropiedad,
                /*3*/ ev_cambioserie.CodBodega,         ev_cambioserie.CodStock,       ev_cambioserie.CodArticulo,
                /*4*/ 'E',                              ev_cambioserie.CodModVenta,    ev_cambioserie.tip_terminal,
        /*5*/ ev_cambioserie.CodUsoLinea,       ev_cambioserie.CodCuota,       1,
        /*6*/ ev_cambioserie.DesEquipo,         ev_cambioserie.NumMovimiento,  NULL,
                /*7*/ 0,                                ev_cambioserie.NumImei,        ev_cambioserie.CodTecnologia);

    EXCEPTION
    WHEN OTHERS THEN
          grabaError(LV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
    END pv_registra_nueva_simcard_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE pv_ins_serie_prom_pre_pr (
      ev_cambioserie           IN OUT NOCOPY    PV_CAM_SIMCARD_OT,
      SN_cod_retorno           IN OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          IN OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            IN OUT NOCOPY    ge_errores_pg.evento)

    IS


    LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql               ge_errores_pg.vQuery;
    LV_NombrePL      varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_ins_serie_prom_pre_pr';

    BEGIN
        SN_num_evento := 0;

        If (EV_cambioserie.IndProcEqui = 'E') Then
            EV_cambioserie.Ind_Comodato := 2;
        ElsIf EV_cambioserie.IndProcEqui<> '1' Then
            EV_cambioserie.Ind_Comodato := 3;
        Else
            EV_cambioserie.Ind_Comodato := 0;
        End If;

       LV_sSql:= 'INSERT INTO GAT_SERIES_PROMOC ';
       LV_sSql:= LV_sSql || '(num_serie, cod_promocion, cod_moneda, carga_total,carga_periodo, ';
       LV_sSql:= LV_sSql || 'fec_alta, fec_promocion, num_abonado_ant, origen)';
       LV_sSql:= LV_sSql || 'VALUES (';
       LV_sSql:= LV_sSql || EV_cambioserie.Numserie;
       LV_sSql:= LV_sSql || ',' || EV_cambioserie.CodProm;
       LV_sSql:= LV_sSql || ', null';-- || EV_cambioserie.CodMon;                --??
       LV_sSql:= LV_sSql || ',' || EV_cambioserie.CargaTot;
       LV_sSql:= LV_sSql || ',' || EV_cambioserie.CargaPer;
       LV_sSql:= LV_sSql || ',Sysdate';
       LV_sSql:= LV_sSql || ',Sysdate';
       LV_sSql:= LV_sSql || ',' || EV_cambioserie.NumAbonado;
       LV_sSql:= LV_sSql || ',' || EV_cambioserie.Ind_Comodato;


       INSERT INTO GAT_SERIES_PROMOC
       (num_serie, cod_promocion, cod_moneda, carga_total,carga_periodo,
       fec_alta, fec_promocion, num_abonado_ant, origen)
       VALUES (
       EV_cambioserie.Numserie
       ,EV_cambioserie.CodProm
       ,null
       ,EV_cambioserie.CargaTot
       ,EV_cambioserie.CargaPer
       ,Sysdate
       ,Sysdate
       ,EV_cambioserie.NumAbonado
       ,EV_cambioserie.Ind_Comodato);

    EXCEPTION
    WHEN OTHERS THEN
          grabaError(LV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
    END pv_ins_serie_prom_pre_pr;

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
    FUNCTION pv_rec_fecha_alta_equi_fn (
      ev_cambioserie       IN OUT NOCOPY   PV_CAM_SIMCARD_OT,
      sn_cod_retorno       IN OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      IN OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        IN OUT NOCOPY   ge_errores_pg.evento
    )

    RETURN BOOLEAN
    IS
        LV_des_error     ge_errores_pg.DesEvent;
        LV_sSql          ge_errores_pg.vQuery;
        LV_NombrePL      varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_rec_fecha_alta_equi_fn';
    BEGIN
        SN_num_evento := 0;

        LV_sSql:='SELECT max(fec_alta) FROM ga_equipaboser ';
        LV_sSql:=LV_sSql||' WHERE NUM_ABONADO = '''||ev_cambioserie.numabonado||'''';
        LV_sSql:=LV_sSql||' AND tip_terminal = ''T''';

        SELECT max(fec_alta)
        INTO ev_cambioserie.fec_alta
        FROM ga_equipaboser
        WHERE num_abonado = ev_cambioserie.numabonado
        AND tip_terminal = 'T';

        RETURN TRUE;

    EXCEPTION
    WHEN OTHERS THEN
       grabaError(LV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
       RETURN FALSE;

    END pv_rec_fecha_alta_equi_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION pv_rec_cod_actuacion_fn (
      ev_cambioserie       IN OUT NOCOPY   PV_CAM_SIMCARD_OT,
      sn_cod_retorno       IN OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      IN OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        IN OUT NOCOPY   ge_errores_pg.evento
    )
    RETURN BOOLEAN
    IS
        LV_des_error     ge_errores_pg.DesEvent;
        LV_sSql          ge_errores_pg.vQuery;
        LV_NombrePL      varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_rec_cod_actuacion_fn';
    BEGIN
        SN_num_evento := 0;

        LV_sSql:='SELECT cod_actabo  FROM pv_actabo_tiplan ';
        LV_sSql:=LV_sSql||' WHERE cod_tipmodi = '''||ev_cambioserie.codactabo||'''';
        LV_sSql:=LV_sSql||' AND   cod_tiplan  = '''||ev_cambioserie.codtiplan||'''';

        SELECT cod_actabo
        INTO ev_cambioserie.CodActaboAux
        FROM pv_actabo_tiplan
        WHERE cod_tipmodi = ev_cambioserie.codactabo
        AND   cod_tiplan  = ev_cambioserie.codtiplan;

        RETURN TRUE;

    EXCEPTION
    WHEN OTHERS THEN
       grabaError(LV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
       RETURN FALSE;

    END pv_rec_cod_actuacion_fn;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION pv_rec_tipo_plan_fn (
      ev_cambioserie       IN OUT NOCOPY   PV_CAM_SIMCARD_OT,
      sn_cod_retorno       IN OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      IN OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        IN OUT NOCOPY   ge_errores_pg.evento
    )
    RETURN BOOLEAN
    IS
        LV_des_error     ge_errores_pg.DesEvent;
        LV_sSql          ge_errores_pg.vQuery;
        LV_NombrePL      varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_rec_tipo_plan_fn';
    BEGIN
        SN_num_evento := 0;

        LV_sSql:='SELECT cod_tiplan FROM ta_plantarif ';
        LV_sSql:=LV_sSql||' WHERE cod_plantarif = '''||ev_cambioserie.scodplantarif||'''';

        SELECT cod_tiplan
        INTO ev_cambioserie.CodTiplan
        FROM ta_plantarif
        WHERE cod_plantarif = ev_cambioserie.scodplantarif;

        RETURN TRUE;

    EXCEPTION
    WHEN OTHERS THEN
       grabaError(LV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
       RETURN FALSE;

    END pv_rec_tipo_plan_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE pv_autentificacion_pr (
      ev_cambioserie           IN               PV_CAM_SIMCARD_OT,
      SN_cod_retorno           IN OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          IN OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            IN OUT NOCOPY    ge_errores_pg.evento)

    IS

    LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql               ge_errores_pg.vQuery;
    LV_NombrePL        varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_autentificacion_pr';

    BEGIN

        sn_cod_retorno     := 0;
        sv_mens_retorno := NULL;
        sn_num_evento     := 0;

        IF ev_cambioserie.en_autentificacion = 2 THEN
            LV_sSql:= 'INSERT INTO ICT_AKEYS';
            LV_sSql:= LV_sSql||' (NUM_ESN, FEC_ACTUALIZACION, ID_CARGA, COD_ESTADO)';
            LV_sSql:= LV_sSql||' VALUES ('''||ev_cambioserie.numserie||''', SYSDATE, -1, -1)';
            INSERT INTO ICT_AKEYS
            (NUM_ESN, FEC_ACTUALIZACION, ID_CARGA, COD_ESTADO)
             VALUES (ev_cambioserie.numserie, SYSDATE, -1, -1);
        ELSIF ev_cambioserie.en_autentificacion = 3 THEN
            LV_sSql:= 'UPDATE ict_akeys ';
            LV_sSql:= LV_sSql||' SET fec_actualizacion = SYSDATE, cod_estado = 1';
            LV_sSql:= LV_sSql||' WHERE num_esn = '''||ev_cambioserie.numserie||'''';
            UPDATE ict_akeys
            SET fec_actualizacion = SYSDATE
            ,cod_estado = 1
            WHERE num_esn = ev_cambioserie.numserie;
        END IF;

    EXCEPTION
    WHEN OTHERS THEN
          grabaError(LV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
    END pv_autentificacion_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE pv_actualiza_caucambio_sim_pr (
      ev_cambioserie           IN               PV_CAM_SIMCARD_OT,
      SN_cod_retorno           IN OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          IN OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            IN OUT NOCOPY    ge_errores_pg.evento)

    IS

    LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql               ge_errores_pg.vQuery;
    LV_NombrePL        varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_actualiza_caucambio_sim_pr';

    BEGIN

        sn_cod_retorno     := 0;
        sv_mens_retorno := NULL;
        sn_num_evento     := 0;

        LV_sSql:= 'UPDATE ga_equipaboser';
        LV_sSql:= LV_sSql||' SET cod_causa = '''||ev_cambioserie.caucambio||'''';
        LV_sSql:= LV_sSql||' WHERE NUM_ABONADO = '||ev_cambioserie.numabonado;
        LV_sSql:= LV_sSql||' AND NUM_SERIE = '''||ev_cambioserie.NumSerie||'''';

                IF(NOT ev_cambioserie.fec_alta IS NULL) THEN
                LV_sSql:= LV_sSql||' AND fec_alta = '''||ev_cambioserie.fec_alta||'''';
                END IF;

                IF(NOT ev_cambioserie.fec_alta IS NULL) THEN
                UPDATE ga_equipaboser
                SET cod_causa = ev_cambioserie.caucambio
                WHERE NUM_ABONADO = ev_cambioserie.numabonado
                AND NUM_SERIE = ev_cambioserie.NumSerie
                AND fec_alta = ev_cambioserie.fec_alta;
                ELSE
                UPDATE ga_equipaboser
                SET cod_causa = ev_cambioserie.caucambio
                WHERE NUM_ABONADO = ev_cambioserie.numabonado
                AND NUM_SERIE = ev_cambioserie.NumSerie;
                END IF;

    EXCEPTION
    WHEN OTHERS THEN
          grabaError(LV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
    END pv_actualiza_caucambio_sim_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE pv_registra_equip_seriados_pr (
      ev_cambioserie           IN               PV_CAM_SIMCARD_OT,
      SN_cod_retorno           IN OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          IN OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            IN OUT NOCOPY    ge_errores_pg.evento)

    IS

    LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql               ge_errores_pg.vQuery;
    LV_NombrePL        varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_registra_equip_seriados_pr';

    BEGIN

        sn_cod_retorno     := 0;
        sv_mens_retorno := NULL;
        sn_num_evento     := 0;

        LV_sSql:= 'INSERT INTO GA_EQUIPABOSER';
        LV_sSql:= LV_sSql || ' (NUM_ABONADO,NUM_SERIE,COD_PRODUCTO,IND_PROCEQUI,FEC_ALTA,';
        LV_sSql:= LV_sSql || ' IND_PROPIEDAD,COD_BODEGA,TIP_STOCK,COD_ARTICULO,IND_EQUIACC,';
        LV_sSql:= LV_sSql || ' COD_MODVENTA,TIP_TERMINAL,COD_USO,COD_CUOTA,COD_ESTADO,';
        LV_sSql:= LV_sSql || ' NUM_SERIEMEC,DES_EQUIPO,NUM_MOVIMIENTO,COD_CAUSA,IND_EQPRESTADO,';
        LV_sSql:= LV_sSql || ' NUM_IMEI, COD_TECNOLOGIA,IMP_CARGO,TIP_DTO,VAL_DTO)';
        LV_sSql:= LV_sSql || ' SELECT NUM_ABONADO,NUM_SERIE,COD_PRODUCTO,IND_PROCEQUI, SYSDATE,';
        LV_sSql:= LV_sSql || ' IND_PROPIEDAD,COD_BODEGA,TIP_STOCK,COD_ARTICULO,IND_EQUIACC,';
        LV_sSql:= LV_sSql || ' COD_MODVENTA,TIP_TERMINAL,COD_USO,COD_CUOTA,COD_ESTADO,NUM_SERIEMEC,';
        LV_sSql:= LV_sSql || ' DES_EQUIPO,NUM_MOVIMIENTO,COD_CAUSA,IND_EQPRESTADO,NUM_IMEI, ';
        LV_sSql:= LV_sSql || ' COD_TECNOLOGIA,IMP_CARGO,TIP_DTO,VAL_DTO';
        LV_sSql:= LV_sSql || ' FROM GA_EQUIPABOSER';
        LV_sSql:= LV_sSql || ' WHERE NUM_ABONADO = '||ev_cambioserie.numabonado;
        LV_sSql:= LV_sSql || ' AND NUM_SERIE = '''||ev_cambioserie.NumSerieAnt||'''';
        LV_sSql:= LV_sSql || ' AND FEC_ALTA = '''||ev_cambioserie.fec_alta||'''';


                INSERT INTO GA_EQUIPABOSER
        (NUM_ABONADO,NUM_SERIE,COD_PRODUCTO,IND_PROCEQUI,FEC_ALTA,
        IND_PROPIEDAD,COD_BODEGA,TIP_STOCK,COD_ARTICULO,IND_EQUIACC,
        COD_MODVENTA,TIP_TERMINAL,COD_USO,COD_CUOTA,COD_ESTADO,
        NUM_SERIEMEC,DES_EQUIPO,NUM_MOVIMIENTO,COD_CAUSA,IND_EQPRESTADO,
        NUM_IMEI, COD_TECNOLOGIA,IMP_CARGO,TIP_DTO,VAL_DTO)
        SELECT NUM_ABONADO,NUM_SERIE,COD_PRODUCTO,IND_PROCEQUI, SYSDATE,
        IND_PROPIEDAD,COD_BODEGA,TIP_STOCK,COD_ARTICULO,IND_EQUIACC,
        COD_MODVENTA,TIP_TERMINAL,COD_USO,COD_CUOTA,COD_ESTADO,NUM_SERIEMEC,
        DES_EQUIPO,NUM_MOVIMIENTO,COD_CAUSA,IND_EQPRESTADO,NUM_IMEI,
        COD_TECNOLOGIA,IMP_CARGO,TIP_DTO,VAL_DTO
        FROM GA_EQUIPABOSER
        WHERE NUM_ABONADO = ev_cambioserie.numabonado
        AND NUM_SERIE = ev_cambioserie.NumImei
        AND FEC_ALTA = ev_cambioserie.fec_alta;


    EXCEPTION
    WHEN OTHERS THEN
         grabaError(LV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
    END pv_registra_equip_seriados_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE pv_actualiza_dat_abonados_pr (
      ev_cambioserie           IN               PV_CAM_SIMCARD_OT,
      SN_cod_retorno           IN OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          IN OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            IN OUT NOCOPY    ge_errores_pg.evento)

    IS

    LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql               ge_errores_pg.vQuery;
    LV_NombrePL        varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_actualiza_dat_abonados_pr';
    error_uso          EXCEPTION;
    BEGIN

        sn_cod_retorno     := 0;
        sv_mens_retorno := NULL;
        sn_num_evento     := 0;



                IF (ev_cambioserie.CodUsoLinea = 2 OR ev_cambioserie.CodUsoLinea = 10) THEN

            LV_sSql:= 'UPDATE GA_ABOCEL';
            LV_sSql:= LV_sSql||' SET cod_situacion = ''CSP''';
            LV_sSql:= LV_sSql||' , num_serie = '''||ev_cambioserie.numserie||'''';
            LV_sSql:= LV_sSql||' , fec_ultmod = SYSDATE ';
            LV_sSql:= LV_sSql||' WHERE NUM_ABONADO = '||ev_cambioserie.numabonado;
            UPDATE ga_abocel
               SET cod_situacion = 'CSP',
                               num_serie = ev_cambioserie.numserie,
                                   fec_ultmod = SYSDATE
             WHERE num_abonado = ev_cambioserie.numabonado;

                ELSIF (ev_cambioserie.CodUsoLinea = 3) THEN

            LV_sSql:= 'UPDATE GA_ABOCEL';
            LV_sSql:= LV_sSql||' SET cod_situacion = ''CSP''';
            LV_sSql:= LV_sSql||' , num_serie = '''||ev_cambioserie.numserie||'''';
            LV_sSql:= LV_sSql||' , fec_ultmod = SYSDATE ';
            LV_sSql:= LV_sSql||' WHERE NUM_ABONADO = '||ev_cambioserie.numabonado;
            UPDATE ga_aboamist
               SET cod_situacion = 'CSP',
                               num_serie = ev_cambioserie.numserie,
                                   fec_ultmod = SYSDATE
             WHERE num_abonado = ev_cambioserie.numabonado;

                ELSE
                    RAISE error_uso;
                END IF;



    EXCEPTION
        WHEN error_uso THEN
            SV_mens_retorno := 'Error en el código de uso de la serie';
                LV_des_error    := LV_NombrePL ||'(); - ' || SQLERRM;
            SN_num_evento   := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, LV_NombrePL, LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN OTHERS THEN
          grabaError(LV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
    END pv_actualiza_dat_abonados_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE pv_actualiza_promociones_pr (
      ev_cambioserie           IN               PV_CAM_SIMCARD_OT,
      SN_cod_retorno           IN OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          IN OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            IN OUT NOCOPY    ge_errores_pg.evento)

    IS

    LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql               ge_errores_pg.vQuery;
    LV_NombrePL        varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_actualiza_promociones_pr';

    BEGIN

        sn_cod_retorno     := 0;
        sv_mens_retorno := NULL;
        sn_num_evento     := 0;

        LV_sSql:= 'UPDATE ci_promocion_analogos';
        LV_sSql:= LV_sSql||' SET fec_cambio_dh = SYSDATE';
        LV_sSql:= LV_sSql||' , num_serien = '''||ev_cambioserie.numserie||'''';
        LV_sSql:= LV_sSql||' WHERE num_celular = '||ev_cambioserie.numcelular;
        UPDATE ci_promocion_analogos
        SET fec_cambio_dh = SYSDATE
        ,num_serien = ev_cambioserie.numserie
        WHERE num_celular = ev_cambioserie.numcelular;


    EXCEPTION
    WHEN OTHERS THEN
          grabaError(LV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
    END pv_actualiza_promociones_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE pv_elimina_reserva_pr (
      ev_cambioserie           IN               PV_CAM_SIMCARD_OT,
      SN_cod_retorno           IN OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          IN OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
      SN_num_evento          IN OUT NOCOPY     ge_errores_pg.evento)

    IS

    LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql               ge_errores_pg.vQuery;
    LV_NombrePL        varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_elimina_reserva_pr';

    BEGIN

        sn_cod_retorno     := 0;
        sv_mens_retorno := NULL;
        sn_num_evento     := 0;

        LV_sSql:= 'DELETE GA_RESERVART';
        LV_sSql:= LV_sSql||' WHERE NUM_TRANSACCION = '||ev_cambioserie.num_reserva;
        LV_sSql:= LV_sSql||' AND NUM_LINEA = 1 ';
        LV_sSql:= LV_sSql||' AND NUM_ORDEN = 1 ';
        DELETE GA_RESERVART
         WHERE NUM_TRANSACCION = ev_cambioserie.num_reserva
         AND NUM_LINEA = 1
         AND NUM_ORDEN = 1;


    EXCEPTION
    WHEN OTHERS THEN
          grabaError(LV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
    END pv_elimina_reserva_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE pv_actualiza_pass_pr (
      ev_cambioserie           IN               PV_CAM_SIMCARD_OT,
      SN_cod_retorno           IN OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          IN OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            IN OUT NOCOPY     ge_errores_pg.evento)

    IS

    LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql            ge_errores_pg.vQuery;
    LV_NombrePL        varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_actualiza_pass_pr';
        error_uso          EXCEPTION;

    BEGIN

        sn_cod_retorno     := 0;
        sv_mens_retorno := NULL;
        sn_num_evento     := 0;

                IF (ev_cambioserie.CodUsoLinea = 2 OR ev_cambioserie.CodUsoLinea = 10) THEN

            LV_sSql:= 'UPDATE GA_ABOCEL';
            LV_sSql:= LV_sSql||' SET cod_password = '''|| SUBSTR(ev_cambioserie.Numserie, 16, 4) ||'''';
            LV_sSql:= LV_sSql||' WHERE NUM_ABONADO = '||ev_cambioserie.numabonado;

            UPDATE GA_ABOCEL
               SET cod_password = SUBSTR(ev_cambioserie.Numserie,16,4)
             WHERE num_abonado = ev_cambioserie.numabonado;
                ELSIF (ev_cambioserie.CodUsoLinea = 3) THEN

            LV_sSql:= 'UPDATE GA_ABOAMIST';
            LV_sSql:= LV_sSql||' SET cod_password = '''|| SUBSTR(ev_cambioserie.Numserie, 16, 4) ||'''';
            LV_sSql:= LV_sSql||' WHERE NUM_ABONADO = '||ev_cambioserie.numabonado;

            UPDATE GA_ABOAMIST
               SET cod_password = SUBSTR(ev_cambioserie.Numserie,16,4)
             WHERE num_abonado = ev_cambioserie.numabonado;
                ELSE
                    RAISE error_uso;
                END IF;



    EXCEPTION
        WHEN error_uso THEN
            SV_mens_retorno := 'Error en el código de uso de la serie';
                LV_des_error    := LV_NombrePL ||'(); - ' || SQLERRM;
            SN_num_evento   := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, LV_NombrePL, LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN OTHERS THEN
          grabaError(LV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
    END pv_actualiza_pass_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  FUNCTION pv_recupera_transacabo_pr (
    secuencia                IN             NUMBER,
    mensaje                  IN OUT NOCOPY  VARCHAR2,
    SN_cod_retorno           IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY  ge_errores_pg.evento)
  RETURN VARCHAR2
  IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_recupera_transacabo_pr';
    valor                    number;
  BEGIN

        valor := -1;

        LV_sSql := 'SELECT cod_retorno, des_cadena FROM ga_transacabo WHERE num_transaccion = ' || secuencia;

    SELECT cod_retorno, des_cadena INTO valor, mensaje
    FROM ga_transacabo
    WHERE num_transaccion = secuencia;

    RETURN valor;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN valor;

    WHEN OTHERS THEN
         grabaError(SV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  END pv_recupera_transacabo_pr;

---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
function pv_autenticacionServSuplabo_pr (
    EV_cambioserie           IN             PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY  ge_errores_pg.evento)
  RETURN VARCHAR2
  IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_autenticacionServSuplabo_pr';
    valor                    number;
  BEGIN

     LV_sSql := 'SELECT COUNT(1) FROM ga_servsuplabo ';
     LV_sSql := LV_sSql || ' WHERE num_abonado = ' || EV_cambioserie.NumAbonado;
     LV_sSql := LV_sSql || ' AND  cod_servicio = ' || EV_cambioserie.CodServicio;
     LV_sSql := LV_sSql || ' AND  TRUNC(fec_altabd) <= TRUNC(SYSDATE)';
         LV_sSql := LV_sSql || ' AND (fec_bajabd IS NULL OR (ind_estado = 5 AND fec_bajabd IS NOT NULL))';


     SELECT COUNT(1) INTO valor FROM ga_servsuplabo
     WHERE num_abonado =  EV_cambioserie.NumAbonado
     AND  cod_servicio = EV_cambioserie.CodServicio
     AND  TRUNC(fec_altabd) <= TRUNC(SYSDATE)
     AND (fec_bajabd IS NULL OR (ind_estado = 5 AND fec_bajabd IS NOT NULL));

    RETURN valor;

    EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  END pv_autenticacionServSuplabo_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_procesa_documento_pr (
    EV_cambioserie           IN               PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY     ge_errores_pg.evento)

IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_procesa_documento_pr';
BEGIN
    SN_num_evento := 0;

    LV_sSql:= 'UPDATE fa_interfact ';
    LV_sSql:= LV_sSql || 'SET cod_estadoc = [100], ';
    LV_sSql:= LV_sSql || 'cod_estproc = [3]  ';
    LV_sSql:= LV_sSql || 'WHERE num_venta =  ' || EV_cambioserie.numventa;
    LV_sSql:= LV_sSql || 'AND cod_estadoc = [0]  ';
    LV_sSql:= LV_sSql || 'AND cod_estproc = [0] ';

    UPDATE fa_interfact
    SET cod_estadoc = 100,
    cod_estproc = 3
    WHERE num_venta = EV_cambioserie.numventa
    AND cod_estadoc = 0
    AND cod_estproc = 0;

    EXCEPTION
    WHEN OTHERS THEN
        grabaError(SV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

END pv_procesa_documento_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_registra_mod_abonado_pr (
    EV_cambioserie           IN               PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY     ge_errores_pg.evento)

  IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_registra_mod_abonado_pr';
  BEGIN

    LV_sSql:= 'INSERT INTO GA_MODABOCEL ';
    LV_sSql:= LV_sSql || '(NUM_ABONADO, COD_TIPMODI, FEC_MODIFICA, NOM_USUARORA,COD_CAUSA,NUM_SERIE) ';
    LV_sSql:= LV_sSql || 'VALUES (  ';
    LV_sSql:= LV_sSql || EV_cambioserie.NumAbonado || ', ';
    LV_sSql:= LV_sSql || EV_cambioserie.CodActabo || ', ';
    LV_sSql:= LV_sSql || sysdate || ', ';
    LV_sSql:= LV_sSql || EV_cambioserie.usuario || ', ';
    LV_sSql:= LV_sSql || EV_cambioserie.CauCambio || ', ';
    LV_sSql:= LV_sSql || EV_cambioserie.NumSerieAnt || ', ';
    LV_sSql:= LV_sSql || ')';


    INSERT INTO GA_MODABOCEL
    (NUM_ABONADO, COD_TIPMODI, FEC_MODIFICA, NOM_USUARORA,COD_CAUSA,NUM_SERIE)
    VALUES (
    EV_cambioserie.NumAbonado,
    EV_cambioserie.CodActabo,
    sysdate,
    EV_cambioserie.usuario,
    EV_cambioserie.CauCambio,
    EV_cambioserie.NumSerieAnt);

    EXCEPTION
    WHEN OTHERS THEN
        grabaError(SV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

END pv_registra_mod_abonado_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION pv_valida_seguro_abonado_pr (
    EV_cambioserie           IN               PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY    ge_errores_pg.evento)
    RETURN BOOLEAN
  IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    total                    number;
    SV_NombrePL              varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_valida_seguro_abonado_pr';
  BEGIN

    LV_sSql:= 'SELECT count(1) INTO total  ';
    LV_sSql:= LV_sSql || 'FROM ga_segurabo  ';
    LV_sSql:= LV_sSql || 'WHERE num_abonado = sNumAbonado  ';


    SELECT COUNT(1) INTO total
    FROM ga_segurabo
    WHERE num_abonado = EV_cambioserie.NumAbonado ;

    return (total > 0);

    EXCEPTION
    WHEN OTHERS THEN
          grabaError(SV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

END pv_valida_seguro_abonado_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_resp_seguro_hist_pr (
    EV_cambioserie           IN               PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY     ge_errores_pg.evento)

  IS
        LV_des_error         ge_errores_pg.DesEvent;
        LV_sSql              ge_errores_pg.vQuery;
        SV_NombrePL          varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_resp_seguro_hist_pr';
  BEGIN

    LV_sSql:= 'INSERT INTO GA_HSEGURABO ';
    LV_sSql:= LV_sSql || '( num_abonado, fec_alta, cod_producto, num_terminal, num_serie, cod_tipsegu,';
    LV_sSql:= LV_sSql || 'num_contrato, num_periodo, fec_fincontrato, nom_usuarora, num_anexo, ';
    LV_sSql:= LV_sSql || 'num_periodo_reemp , fec_historico, num_reemplazos ) ';
    LV_sSql:= LV_sSql || 'SELECT Num_abonado, fec_alta, cod_producto, num_terminal, num_serie, cod_tipsegu, num_contrato, ';
    LV_sSql:= LV_sSql || 'num_periodo, fec_fincontrato, nom_usuarora, num_anexo , num_periodo_reemp, ';
    LV_sSql:= LV_sSql || 'sysdate , -1 ';
    LV_sSql:= LV_sSql || 'FROM ga_segurabo ';
    LV_sSql:= LV_sSql || 'WHERE num_abonado = ' || EV_cambioserie.NumAbonado;
    --LV_sSql:= LV_sSql || 'AND fec_alta =  ' || EV_cambioserie.fec_alta;


    INSERT INTO GA_HSEGURABO
    ( num_abonado, fec_alta, cod_producto, num_terminal, num_serie, cod_tipsegu,
    num_contrato, num_periodo, fec_fincontrato, nom_usuarora, num_anexo ,
    num_periodo_reemp , fec_historico, num_reemplazos )
    SELECT Num_abonado, fec_alta, cod_producto, num_terminal, num_serie, cod_tipsegu, num_contrato,
    num_periodo, fec_fincontrato, nom_usuarora, num_anexo , num_periodo_reemp, sysdate , -1
    FROM ga_segurabo
    WHERE num_abonado = EV_cambioserie.NumAbonado;
    --AND fec_alta =  EV_cambioserie.fec_alta;


    EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  END pv_resp_seguro_hist_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_act_serie_seguro_pr (
    EV_cambioserie           IN             PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY     ge_errores_pg.evento)

  IS
        LV_des_error       ge_errores_pg.DesEvent;
        LV_sSql            ge_errores_pg.vQuery;
        SV_NombrePL        varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_resp_seguro_hist_pr';
  BEGIN


    LV_sSql:= 'UPDATE ga_segurabo ';
    LV_sSql:= LV_sSql || 'SET num_serie = EV_cambioserie.Numserie ';
    LV_sSql:= LV_sSql || 'WHERE num_serie = ' || EV_cambioserie.NumSerieAnt;
    LV_sSql:= LV_sSql || 'AND num_abonado = ' || EV_cambioserie.NumAbonado;

    UPDATE ga_segurabo
       SET num_serie = EV_cambioserie.Numserie
     WHERE num_serie = EV_cambioserie.NumSerieAnt
       AND num_abonado = EV_cambioserie.NumAbonado;


    EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  END pv_act_serie_seguro_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE pv_consulta_grupo_pr (
    EV_cambioserie           IN OUT NOCOPY  PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY  ge_errores_pg.evento)

  IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_consulta_grupo_pr';
  BEGIN

    LV_sSql:= 'SELECT grupo into PV_CAM_SIMCARD_OT.grupo FROM ci_tiporserv ';
    LV_sSql:= LV_sSql || 'WHERE cod_os = ' || EV_cambioserie.lCod_OOSS;

    SELECT grupo into EV_cambioserie.inte FROM ci_tiporserv
    WHERE cod_os = EV_cambioserie.lCod_OOSS;

    EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  END pv_consulta_grupo_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  function pv_consulta_secuencia_pr (
    EV_nombre                IN             VARCHAR2,
    SN_cod_retorno           IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY  ge_errores_pg.evento)
  RETURN number
  IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_consulta_secuencia_pr';
    valor                    number;
  BEGIN

    LV_sSql:= 'SELECT ' || EV_nombre || '.NEXTVAL FROM DUAL';

    EXECUTE IMMEDIATE LV_sSql into valor;
    return valor;

    EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  END pv_consulta_secuencia_pr;
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------


  PROCEDURE pv_rec_canal_venta_pr (
    EV_cambioserie           IN out NOCOPY  PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY  ge_errores_pg.evento)

  IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_rec_canal_venta_pr';
  BEGIN

    LV_sSql:= 'SELECT IND_VTA_EXTERNA ';
    LV_sSql:= LV_sSql || 'FROM VE_TIPCOMIS ';
    LV_sSql:= LV_sSql || 'WHERE COD_TIPCOMIS = ' || EV_cambioserie.cod_tipcomis;

    SELECT IND_VTA_EXTERNA into EV_cambioserie.ind_vta_externa
    FROM VE_TIPCOMIS
    WHERE COD_TIPCOMIS = EV_cambioserie.cod_tipcomis;


    EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  END pv_rec_canal_venta_pr;



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_ins_movimiento_central_pr (
    EV_cambioserie           IN OUT NOCOPY PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY  ge_errores_pg.evento)

  IS
   LV_des_error              ge_errores_pg.DesEvent;
   LV_sSql                   ge_errores_pg.vQuery;
   SV_NombrePL               varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_ins_movimiento_central_pr';
   servicios                 varchar(1000);
  BEGIN

          LV_sSql := 'pv_rec_num_servicios_pr';
      EV_cambioserie.CodServicio := pv_rec_num_servicios_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

      LV_sSql := 'INSERT INTO ICC_MOVIMIENTO' || chr(13)
          || '(COD_ESTADO,    NUM_MOVIMIENTO, NUM_ABONADO,   COD_MODULO,' || chr(13)
          || 'COD_ACTUACION,  NOM_USUARORA,   FEC_INGRESO,   COD_CENTRAL,' || chr(13)
          || 'NUM_CELULAR,    NUM_SERIE,      NUM_SERIE_NUE, TIP_TERMINAL,' || chr(13)
          || 'COD_ACTABO,     COD_SERVICIOS,  NUM_MIN,       TIP_TERMINAL_NUE,' || chr(13)
          || 'TIP_TECNOLOGIA, IMSI,           IMSI_NUE,       IMEI,' || chr(13)
          || 'IMEI_NUE,       ICC,            ICC_NUE' || chr(13)
          || ')VALUES (' || chr(13)
          || '1,                           EV_cambioserie.MoviCentral1,   EV_cambioserie.NumAbonado,  ''GA'',' || chr(13)
      || 'EV_cambioserie.CodActuacion, EV_cambioserie.usuario,        SYSDATE,                     EV_cambioserie.CodCentral,' || chr(13)
      || 'EV_cambioserie.NumCelular,   EV_cambioserie.NumSerieAnt,    EV_cambioserie.Numserie,     EV_cambioserie.tip_terminal,' || chr(13)
      || 'EV_cambioserie.CodActabo,    EV_cambioserie.CodServicio,    EV_cambioserie.NumMin,       EV_cambioserie.tip_terminal,' || chr(13)
      || 'EV_cambioserie.CodTecnologia,EV_cambioserie.NUM_IMSI_OLD,   EV_cambioserie.NUM_IMSI_NEW, EV_cambioserie.NumImei,'  || chr(13)
      || 'EV_cambioserie.NumImei,      EV_cambioserie.NumSerieAnt,    EV_cambioserie.Numserie);' || chr(13);



      INSERT INTO ICC_MOVIMIENTO
      (COD_ESTADO,    NUM_MOVIMIENTO, NUM_ABONADO,   COD_MODULO,
      COD_ACTUACION,  NOM_USUARORA,   FEC_INGRESO,   COD_CENTRAL,
      NUM_CELULAR,    NUM_SERIE,      NUM_SERIE_NUE, TIP_TERMINAL,
      COD_ACTABO,     COD_SERVICIOS,  NUM_MIN,       TIP_TERMINAL_NUE,
      TIP_TECNOLOGIA, IMSI,           IMSI_NUE,       IMEI,
          IMEI_NUE,       ICC,            ICC_NUE
          )VALUES (
          1,                           EV_cambioserie.MoviCentral1,   EV_cambioserie.NumAbonado,  'GA',
      EV_cambioserie.CodActuacion, EV_cambioserie.usuario,        SYSDATE,                     EV_cambioserie.CodCentral,
      EV_cambioserie.NumCelular,   EV_cambioserie.NumSerieAnt,    EV_cambioserie.Numserie,     EV_cambioserie.tip_terminal,
      EV_cambioserie.CodActabo,    EV_cambioserie.CodServicio,    EV_cambioserie.NumMin,       EV_cambioserie.tip_terminal,
      EV_cambioserie.CodTecnologia,EV_cambioserie.NUM_IMSI_OLD,   EV_cambioserie.NUM_IMSI_NEW, EV_cambioserie.NumImei,
      EV_cambioserie.NumImei,      EV_cambioserie.NumSerieAnt,    EV_cambioserie.Numserie);


  EXCEPTION
    WHEN OTHERS THEN
                 grabaError(SV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  END pv_ins_movimiento_central_pr;
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
 PROCEDURE pv_rec_parametros_iniciales_pr (
    EV_cambioserie           IN OUT NOCOPY  PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY  ge_errores_pg.evento)

  IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_rec_parametros_iniciales_pr';
  BEGIN

  SN_num_evento := 0;
  -- EV_cambioserie.IndProcEqui := '1';  RRG COL 15-07-2009 98203


  LV_sSql := 'SELECT VAL_PARAMETRO into EV_cambioserie.GRUPO_TEC_GSM FROM GED_PARAMETROS WHERE NOM_PARAMETRO = ''GRUPO_TEC_GSM''';
  SELECT VAL_PARAMETRO into EV_cambioserie.tip_terminal FROM GED_PARAMETROS
  WHERE NOM_PARAMETRO = 'COD_SIMCARD_GSM';


  LV_sSql :=
  'SELECT a.cod_articulo, b.des_articulo'                      ||
  ' INTO EV_cambioserie.CodArticulo, EV_cambioserie.DesEquipo' ||
  ' FROM al_series a ,al_articulos  b'                         ||
  ' where num_serie = ' || EV_cambioserie.Numserie             ||
  ' AND a.cod_articulo = b.cod_articulo(+);';


  SELECT a.cod_articulo, b.des_articulo
  INTO EV_cambioserie.CodArticulo, EV_cambioserie.DesEquipo
  FROM al_series a ,al_articulos  b
  where num_serie = EV_cambioserie.Numserie
  AND a.cod_articulo = b.cod_articulo(+);


  IF(EV_cambioserie.CodCuota = '0' OR EV_cambioserie.CodCuota = '' OR EV_cambioserie.CodCuota is null) then
     EV_cambioserie.IndPropiedad := 'C';
  ELSE
     EV_cambioserie.IndPropiedad := 'E';
  END IF;


  LV_sSql := 'SELECT cod_central INTO EV_cambioserie.codcentral FROM ga_abocel '
  || 'WHERE num_abonado = ' || EV_cambioserie.NumAbonado
  || 'AND cod_cliente = ' || EV_cambioserie.CodCliente;


  LV_sSql := 'SELECT cod_central'
  || ' FROM ga_abocel'
  || ' WHERE num_abonado = '||EV_cambioserie.NumAbonado
  || ' AND cod_cliente = '||EV_cambioserie.CodCliente
  || ' UNION'
  || ' SELECT cod_central'
  || ' FROM ga_aboamist'
  || ' WHERE num_abonado = '||EV_cambioserie.NumAbonado
  || ' AND cod_cliente = '||EV_cambioserie.CodCliente;

  SELECT cod_central
  INTO EV_cambioserie.codcentral
  FROM ga_abocel
  WHERE num_abonado = EV_cambioserie.NumAbonado
  AND cod_cliente = EV_cambioserie.CodCliente
  UNION
  SELECT cod_central
  FROM ga_aboamist
  WHERE num_abonado = EV_cambioserie.NumAbonado
  AND cod_cliente = EV_cambioserie.CodCliente;


  LV_sSql := 'SELECT TIP_STOCK, COD_ESTADO FROM AL_SERIES '
  || ' WHERE NUM_SERIE = ' || EV_cambioserie.Numserie;

  SELECT TIP_STOCK, COD_ESTADO
  INTO EV_cambioserie.CodStock, EV_cambioserie.CodEstado
  FROM AL_SERIES
  WHERE NUM_SERIE = EV_cambioserie.Numserie;

  EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  END pv_rec_parametros_iniciales_pr;
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------

    PROCEDURE pv_actualiza_almovimiento_pr (
      EV_cambioserie           IN OUT NOCOPY    PV_CAM_SIMCARD_OT,
      SN_cod_retorno           IN OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          IN OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            IN OUT NOCOPY    ge_errores_pg.evento)

    IS

    LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql            ge_errores_pg.vQuery;
    LV_NombrePL        varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_actualiza_almovimiento_pr';

    BEGIN
        SN_num_evento := 0;


       LV_sSql:= 'UPDATE al_movimientos a ';
       LV_sSql:= LV_sSql || 'SET num_transaccion = '|| EV_cambioserie.numventa;
       LV_sSql:= LV_sSql || 'WHERE num_movimiento = ' || EV_cambioserie.numMovimientoBloqDesb;

           UPDATE al_movimientos a
           SET num_transaccion = EV_cambioserie.numventa
           WHERE num_movimiento = EV_cambioserie.numMovimientoBloqDesb;

    EXCEPTION
    WHEN OTHERS THEN
          grabaError(LV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
    END pv_actualiza_almovimiento_pr;
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------

 PROCEDURE pv_graba_cambio_simcard_pr (
    EV_cambioserie           IN OUT NOCOPY  PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY  ge_errores_pg.evento)

  IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_graba_cambio_simcard_pr';
  BEGIN

  SN_num_evento := 0;

  LV_sSql := 'pv_rec_parametros_iniciales_pr()';
  pv_rec_parametros_iniciales_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento);



  LV_sSql := 'pv_procesa_documento_pr()';
  pv_procesa_documento_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  LV_sSql := 'pv_registra_mod_abonado_pr()';
  pv_registra_mod_abonado_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  LV_sSql := 'pv_actualiza_seguro_pr()';
  pv_actualiza_seguro_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  LV_sSql := 'pv_aceptarEqInterno_pr()';
  pv_aceptarEqInterno_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  LV_sSql := 'pv_actualiza_almovimiento_pr()';
  pv_actualiza_almovimiento_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  EXCEPTION
    WHEN OTHERS THEN
         null; --grabaError(SV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);



  END pv_graba_cambio_simcard_pr;
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
 PROCEDURE pv_actualiza_seguro_pr (
    EV_cambioserie           IN             PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY  ge_errores_pg.evento)

  IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_actualiza_seguro_pr';
  BEGIN

  LV_sSql := 'pv_valida_seguro_abonado_pr()';
  IF(pv_valida_seguro_abonado_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento) = true) then

     LV_sSql := 'pv_resp_seguro_hist_pr()';
     pv_resp_seguro_hist_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

         LV_sSql := 'pv_act_serie_seguro_pr()';
     pv_act_serie_seguro_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
  END IF;


  EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  END pv_actualiza_seguro_pr;
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
 PROCEDURE pv_aceptarEqInterno_pr (
    EV_cambioserie           IN OUT NOCOPY  PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY  ge_errores_pg.evento)

  IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_aceptarEqInterno_pr';
  BEGIN

  SV_NombrePL := 'pv_autenticacion2_pr()';
  pv_autenticacion2_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  SV_NombrePL := 'pv_insertEquiAbo_pr()';
  pv_insertEquiAbo_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  SV_NombrePL := 'pv_actualiza_dat_abonados_pr()';
  pv_actualiza_dat_abonados_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  IF(EV_cambioserie.promocelular = 1) THEN
       SV_NombrePL := 'pv_actualiza_promociones_pr()';
       pv_actualiza_promociones_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
  END IF;

  IF(EV_cambioserie.CodStock <> 1) THEN
       SV_NombrePL := 'pv_actualiza_stock_pr()';
       pv_actualiza_stock_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

           SV_NombrePL := 'pv_elimina_reserva_pr()';
       pv_elimina_reserva_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
  END IF;

  SV_NombrePL := 'pv_bInsertMovim_pr()';
  pv_bInsertMovim_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  SV_NombrePL := 'pv_EjecutaInsertaCel_pr()';
  pv_EjecutaInsertaCel_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  SV_NombrePL := 'pv_actualiza_pass_pr()';
  pv_actualiza_pass_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento);


  EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  END pv_aceptarEqInterno_pr;
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
 PROCEDURE pv_bInsertMovim_pr (
    EV_cambioserie           IN OUT NOCOPY  PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY  ge_errores_pg.evento)

  IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_bInsertMovim_pr';
    ret                      boolean;
    pvCodValor                          VARCHAR2(100);
    pvErrorAplic                        VARCHAR2(100);
    pvErrorGlosa                        VARCHAR2(100);
    pvErrorOra                          VARCHAR2(100);
    pvErrorOraGlosa             VARCHAR2(100);
    pvTrace                             VARCHAR2(100);

  BEGIN


    LV_sSql := 'pv_rec_tipo_plan_fn()';
    ret := pv_rec_tipo_plan_fn(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

        LV_sSql := 'AL_FN_PREFIJO_NUMERO(' || EV_cambioserie.NumCelular || ')';
    EV_cambioserie.NumMin := AL_FN_PREFIJO_NUMERO(EV_cambioserie.NumCelular);

    IF(EV_cambioserie.NumMin is null) then
        raise_application_error('No existe Prefijo asociado al Abonado', cn_def_retorno);
    END IF;


    LV_sSql := 'AL_FN_PREFIJO_NUMERO(' || EV_cambioserie.Numserie || ')';
    EV_cambioserie.NUM_IMSI_NEW :=  FN_RECUPERA_IMSI(EV_cambioserie.Numserie);

    LV_sSql := 'pv_rec_cod_actuacion_fn()';
    ret := pv_rec_cod_actuacion_fn(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

    LV_sSql := 'FN_CODACTCEN(' || EV_cambioserie.CodProducto   || ','
                               || EV_cambioserie.CodActaboAux    || ','
                               || EV_cambioserie.CodModulo     || ','
                               || EV_cambioserie.CodTecnologia || ');';


    EV_cambioserie.CodActuacion:= FN_CODACTCEN(EV_cambioserie.CodProducto,
                                  EV_cambioserie.CodActaboAux,
                                  EV_cambioserie.CodModulo,
                                  EV_cambioserie.CodTecnologia);

    IF(EV_cambioserie.CodActuacion is null) then
        raise_application_error('No se puede consultar numero de actuación', cn_def_retorno);
    END IF;

    LV_sSql := 'MoviCentral1 := pv_consulta_secuencia_pr(ICC_SEQ_NUMMOV)';
    EV_cambioserie.MoviCentral1 := pv_consulta_secuencia_pr('ICC_SEQ_NUMMOV', SN_cod_retorno, SV_mens_retorno, SN_num_evento);

        LV_sSql := 'pv_ins_movimiento_central_pr()';
    pv_ins_movimiento_central_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento);


        LV_sSql := 'PV_INS_MOV_IDGESTOR_TO_PR(0, '
                                            || EV_cambioserie.CodActAboaux     || ','
                                                                                        || EV_cambioserie.MoviCentral1     || ','
                                                                                        || EV_cambioserie.NumAbonado       || ','
                                                                                        || EV_cambioserie.CodModulo        || ','
                                                                                        || EV_cambioserie.tarea            || ', '''', '''', pvCodValor, pvErrorAplic, pvErrorGlosa, pvErrorOra, pvErrorOraGlosa, pvTrace)';

    PV_INS_MOV_IDGESTOR_TO_PR(0,   EV_cambioserie.CodActAboaux,
                                   EV_cambioserie.MoviCentral1,
                                   EV_cambioserie.NumAbonado,
                                   EV_cambioserie.CodModulo,
                                                                   EV_cambioserie.tarea,
                                                                   '', '',
                                                                   pvCodValor, pvErrorAplic, pvErrorGlosa, pvErrorOra, pvErrorOraGlosa, pvTrace);


  EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  END pv_bInsertMovim_pr;
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
 PROCEDURE pv_EjecutaInsertaCel_pr (
    EV_cambioserie           IN             PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY  ge_errores_pg.evento)

  IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_EjecutaInsertaCel_pr';
    secuencia                number;
    respuesta                varchar2(10);
    mensaje                  varchar2(4000);
  BEGIN

  LV_sSql := 'pv_consulta_secuencia_pr(''GA_SEQ_TRANSACABO''';

  secuencia := pv_consulta_secuencia_pr('GA_SEQ_TRANSACABO', SN_cod_retorno, SV_mens_retorno, SN_num_evento);
  p_actza_imsi_intarcel(secuencia,
                        EV_cambioserie.CodCliente,
                        EV_cambioserie.NumAbonado,
                        EV_cambioserie.NUM_IMSI_NEW,
                        'SA');

  respuesta := pv_recupera_transacabo_pr(secuencia, mensaje, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  --SI ES 0 OK
  IF (respuesta = -1) then
    LV_sSql := 'No existen parametros suficientes para ejecutar el procedimiento';
    raise_application_error(-20100,LV_sSql);
  ELSIF (respuesta = 1) then
    LV_sSql := 'No se encontró registro para este abonado en la tabla GA_INTARCEL';
    raise_application_error(-20101,LV_sSql);
  ELSIF (respuesta = 2) then
    LV_sSql := 'Error ejecutando el proceso: p_actza_imsi_intarcel [Falló actualización de vigencia en intarcel.]'; 
    raise_application_error(-20102,LV_sSql);
  ELSIF (respuesta = 3) then
    LV_sSql := 'Error ejecutando el proceso: p_actza_imsi_intarcel [Falló inserción de registro nuevo en intarcel.]';  
       raise_application_error(-20103,LV_sSql);
  ELSIF (respuesta = 4) then
        LV_sSql := 'Error ejecutando el proceso: p_actza_imsi_intarcel [Falló inserción de registro nuevo en intarcel acciones TOL.]';
       raise_application_error(-20104,LV_sSql);
  ELSIF (respuesta = 5) then
        LV_sSql :=  'Error ejecutando el proceso: p_actza_imsi_intarcel';
       raise_application_error(-20104, LV_sSql);
  END IF;



  EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  END pv_EjecutaInsertaCel_pr;
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
 PROCEDURE pv_actualiza_stock_pr (
    EV_cambioserie           IN OUT NOCOPY  PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY  ge_errores_pg.evento)

  IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
        LV_sSqlAux               ge_errores_pg.vQuery;
    SV_NombrePL              varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_actualiza_stock_pr';
    secuencia                number;
    respuesta                varchar2(10);
    mensaje                  varchar2(4000);
  BEGIN

  LV_sSql := 'pv_consulta_secuencia_pr(''GA_SEQ_TRANSACABO'')';
  secuencia := pv_consulta_secuencia_pr('GA_SEQ_TRANSACABO', SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  LV_sSql := 'p_ga_interal('
                           || secuencia                  || ','
                           || '1 ,'
                           || EV_cambioserie.CodStock    || ','
                           || EV_cambioserie.CodBodega   || ','
                           || EV_cambioserie.CodArticulo || ','
                           || EV_cambioserie.CodUsoLinea || ','
                           || EV_cambioserie.CodEstado   || ','
                           || EV_cambioserie.numventa    || ','
                           || '1 ,'
                           || EV_cambioserie.Numserie    || ','
                           || '1);';


-- salida definitiva de serie.
  p_ga_interal(secuencia,
               1,--Salida definitiva
               EV_cambioserie.CodStock,
               EV_cambioserie.CodBodega,
               EV_cambioserie.CodArticulo,
               EV_cambioserie.CodUsoLinea,
               EV_cambioserie.CodEstado,
               EV_cambioserie.numventa,
               1,
               EV_cambioserie.Numserie,
               1 --iIndTelef
               );

  LV_sSqlAux := LV_sSql;
  LV_sSql := 'pv_recupera_transacabo_pr(' || secuencia || ')';
  respuesta := pv_recupera_transacabo_pr(secuencia, mensaje, SN_cod_retorno, SV_mens_retorno, SN_num_evento);


  --SI ES 0 OK
  IF (respuesta = '1') then
     LV_sSql := 'El Pl pv_recupera_transacabo_pr ha respondido := ' || respuesta || '(' || mensaje || ') QRY : ' || LV_sSqlAux;
     raise_application_error('Error ejecutando actualización de stock', cn_def_retorno);
  ELSE
      SELECT substr(mensaje, 2, instr(mensaje,'/',2)-2)
            INTO EV_cambioserie.NumMovimiento
                FROM DUAL;

        UPDATE ga_equipaboser
               SET num_movimiento = EV_cambioserie.NumMovimiento
             WHERE NUM_ABONADO = ev_cambioserie.numabonado
               AND NUM_SERIE = ev_cambioserie.NumSerie
               AND fec_alta = (SELECT MAX(fec_alta)
                             FROM ga_equipaboser
                                WHERE NUM_ABONADO = ev_cambioserie.numabonado
                                  AND NUM_SERIE = ev_cambioserie.NumSerie) ;

  END IF;


  EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  END pv_actualiza_stock_pr;
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
 PROCEDURE pv_insertEquiAbo_pr (
    EV_cambioserie           IN OUT NOCOPY  PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY  ge_errores_pg.evento)

  IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              VARCHAR2(100) := 'pv_grabar_simcard_sb_pg.pv_insertEquiAbo_pr';
    Grupo_tecnologico        VARCHAR(20);
    ret                      boolean;
    LN_COUNT                 NUMBER(9);
  BEGIN

  LV_sSql := 'pv_registra_nueva_simcard_pr(..)';
  pv_registra_nueva_simcard_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  --Este procedure se repite mas abajo, la diferencia es que en el proximo va X fec_alta
  ev_cambioserie.fec_alta := NULL;
  LV_sSql := 'pv_actualiza_caucambio_sim_pr(..)';
  pv_actualiza_caucambio_sim_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  LV_sSql := 'pv_rec_fecha_alta_equi_fn(..)';
  ret := pv_rec_fecha_alta_equi_fn(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  IF(NOT EV_cambioserie.FEC_ALTA IS NULL) THEN
      LV_sSql := 'GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(' || EV_cambioserie.CodTecnologia || ')';
      Grupo_tecnologico :=  GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(EV_cambioserie.CodTecnologia);


          LV_sSql := 'SELECT VAL_PARAMETRO into EV_cambioserie.GRUPO_TEC_GSM FROM GED_PARAMETROS WHERE NOM_PARAMETRO = ''GRUPO_TEC_GSM'' AND COD_MODULO = ' || EV_cambioserie.CodModulo || ' AND COD_PRODUCTO = 1;';
      SELECT VAL_PARAMETRO into EV_cambioserie.GRUPO_TEC_GSM FROM GED_PARAMETROS
      WHERE NOM_PARAMETRO = 'GRUPO_TEC_GSM'
      AND COD_MODULO = EV_cambioserie.CodModulo
      AND COD_PRODUCTO = 1;

      IF(Grupo_tecnologico = EV_cambioserie.GRUPO_TEC_GSM) THEN
             LV_sSql := 'pv_registra_equip_seriados_pr()';
             
         SELECT COUNT(1) 
         INTO LN_COUNT
         FROM GA_EQUIPABOSER
         WHERE NUM_ABONADO=EV_cambioserie.NumAbonado
         AND NUM_SERIE= ev_cambioserie.NumImei;   
         
         IF LN_COUNT =0 THEN     
            pv_registra_equip_seriados_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

             LV_sSql := 'pv_actualiza_caucambio_sim_pr()';
             pv_actualiza_caucambio_sim_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
         END IF;    
      END IF;
  END IF;

  EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  END pv_insertEquiAbo_pr;
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
 PROCEDURE pv_autenticacion2_pr (
    EV_cambioserie           IN OUT NOCOPY   PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY  ge_errores_pg.evento)

  IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_autenticacion2_pr';
    secuencia                number;
    respuesta                number;
    mensaje                  varchar2(4000);
  BEGIN

  LV_sSql := 'pv_consulta_secuencia_pr(''GA_SEQ_TRANSACABO'')';
  secuencia := pv_consulta_secuencia_pr('GA_SEQ_TRANSACABO', SN_cod_retorno, SV_mens_retorno, SN_num_evento);


  LV_sSql := 'GA_VALIDA_AUTENTICACION_PR()';

  GA_VALIDA_AUTENTICACION_PR(secuencia,
                             'PV',
                             EV_cambioserie.Numserie,
                             EV_cambioserie.IndProcEqui,
                             '',
                             EV_cambioserie.CodUsoLinea);

  LV_sSql := 'pv_recupera_transacabo_pr('|| secuencia ||')';
  respuesta := pv_recupera_transacabo_pr(secuencia, mensaje, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
  EV_cambioserie.EN_autentificacion := respuesta;

  IF(respuesta = 0) then
    null; --La aplicacion continua
  ELSIF (respuesta = 1 or respuesta = 4) then
     LV_sSql := 'Se arroja excepción, ya que el procedimiento pv_recupera_transacabo_pr retornó :' || respuesta;
     raise_application_error(mensaje, cn_def_retorno);
  ELSIF (respuesta = 2) then
     LV_sSql := 'pv_autentificacion_pr()';
     pv_autentificacion_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

         LV_sSql := 'pv_autenticacionServSuplabo_pr()';
     IF(pv_autenticacionServSuplabo_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento) > 0) THEN
             LV_sSql := 'pv_desActivaAutenticacion_pr()';
         pv_desActivaAutenticacion_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
     END IF;
  ELSIF (respuesta = 3) then
     LV_sSql := 'pv_autentificacion_pr()';
     pv_autentificacion_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

         LV_sSql := 'pv_autenticacionServSuplabo_pr()';
     IF(pv_autenticacionServSuplabo_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento) > 0) THEN
            LV_sSql := 'pv_activaAutenticacion_pr()';
        pv_activaAutenticacion_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
     END IF;
  ELSIF (respuesta = 5) then

     LV_sSql := 'pv_autenticacionServSuplabo_pr()';
     IF(pv_autenticacionServSuplabo_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento) > 0) THEN
            LV_sSql := 'pv_activaAutenticacion_pr()';
        pv_activaAutenticacion_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
     END IF;
  END IF;

  EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  END pv_autenticacion2_pr;

---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
 PROCEDURE pv_desActivaAutenticacion_pr (
    EV_cambioserie           IN             PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY  ge_errores_pg.evento)

  IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_desActivaAutenticacion_pr';
  BEGIN

    LV_sSql := 'UPDATE GA_SERVSUPLABO SET';
    LV_sSql := LV_sSql || ' IND_ESTADO = 3';
    LV_sSql := LV_sSql || ',NOM_USUARORA = ' ||  EV_cambioserie.usuario;
    LV_sSql := LV_sSql || ',FEC_BAJABD =  SYSDATE ';
    LV_sSql := LV_sSql || ',COD_NIVEL = 0';
    LV_sSql := LV_sSql || ' WHERE NUM_ABONADO = ' || EV_cambioserie.NumAbonado;
    LV_sSql := LV_sSql || ' AND COD_SERVICIO = ' || EV_cambioserie.CodServicio;
    LV_sSql := LV_sSql || ' AND cod_servSupl = ' || EV_cambioserie.cod_servSupl;
    LV_sSql := LV_sSql || ' AND FEC_BAJABD IS NULL ';


    UPDATE GA_SERVSUPLABO SET
     IND_ESTADO = 3
    ,NOM_USUARORA =  EV_cambioserie.usuario
    ,FEC_BAJABD =  SYSDATE
    ,COD_NIVEL = 0
    WHERE NUM_ABONADO =  EV_cambioserie.NumAbonado
    AND COD_SERVICIO =  EV_cambioserie.CodServicio
    AND cod_servSupl =  EV_cambioserie.cod_servSupl   --sCod_Autenti
    AND FEC_BAJABD IS NULL;


    LV_sSql := 'UPDATE GA_ABOCEL SET ' ;
    LV_sSql := LV_sSql || ' CLASE_SERVICIO = replace(CLASE_SERVICIO, ''460001'', '''')';
    LV_sSql := LV_sSql || ' ,FEC_ULTMOD = SYSDATE';
    LV_sSql := LV_sSql || ' ,NOM_USUARORA = ' || EV_cambioserie.usuario;
    LV_sSql := LV_sSql || ' WHERE NUM_ABONADO = ' || EV_cambioserie.NumAbonado;


     UPDATE GA_ABOCEL SET
      CLASE_SERVICIO = replace(CLASE_SERVICIO, '460001', '')
     ,FEC_ULTMOD = SYSDATE
     ,NOM_USUARORA = EV_cambioserie.usuario
     WHERE NUM_ABONADO = EV_cambioserie.NumAbonado;


  EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  END pv_desActivaAutenticacion_pr;
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
 PROCEDURE pv_activaAutenticacion_pr (
    EV_cambioserie           IN             PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY  ge_errores_pg.evento)

  IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_activaAutenticacion_pr';
  BEGIN


    LV_sSql := 'INSERT INTO GA_SERVSUPLABO';
    LV_sSql := LV_sSql || ' (NUM_ABONADO,COD_SERVICIO,FEC_ALTABD,COD_SERVSUPL,';
    LV_sSql := LV_sSql || '  COD_NIVEL,COD_PRODUCTO,NUM_TERMINAL,NOM_USUARORA,IND_ESTADO)';
    LV_sSql := LV_sSql || ' VALUES (';
    LV_sSql := LV_sSql || '   ' || EV_cambioserie.NumAbonado;
    LV_sSql := LV_sSql || '  ,' || EV_cambioserie.CodServicio;
    LV_sSql := LV_sSql || '  ,SYSDATE';
    LV_sSql := LV_sSql || '  ,' || EV_cambioserie.cod_servSupl;  --sCod_Autenti
    LV_sSql := LV_sSql || '  ,1';
    LV_sSql := LV_sSql || '  ,' || EV_cambioserie.CodProducto;
    LV_sSql := LV_sSql || '  ,' || EV_cambioserie.NumCelular;
    LV_sSql := LV_sSql || '  ,' || EV_cambioserie.usuario;
    LV_sSql := LV_sSql || '  ,1);';


    INSERT INTO GA_SERVSUPLABO
    (NUM_ABONADO,COD_SERVICIO,FEC_ALTABD,COD_SERVSUPL,
     COD_NIVEL,COD_PRODUCTO,NUM_TERMINAL,NOM_USUARORA,IND_ESTADO)
    VALUES (
      EV_cambioserie.NumAbonado
     ,EV_cambioserie.CodServicio
     ,SYSDATE
     ,EV_cambioserie.cod_servSupl  --sCod_Autenti
     ,1
     ,EV_cambioserie.CodProducto
     ,EV_cambioserie.NumCelular
     ,EV_cambioserie.usuario
     ,1
    );


     LV_sSql := 'UPDATE GA_ABOCEL SET ' ;
     LV_sSql := LV_sSql || ' CLASE_SERVICIO = CLASE_SERVICIO || ''460001''';
     LV_sSql := LV_sSql || ' ,FEC_ULTMOD = SYSDATE';
     LV_sSql := LV_sSql || ' ,NOM_USUARORA = ' || EV_cambioserie.usuario;
     LV_sSql := LV_sSql || ' WHERE NUM_ABONADO = ' || EV_cambioserie.NumAbonado;


     UPDATE GA_ABOCEL SET
      CLASE_SERVICIO = CLASE_SERVICIO || '460001'
     ,FEC_ULTMOD = SYSDATE
     ,NOM_USUARORA = EV_cambioserie.usuario
     WHERE NUM_ABONADO = EV_cambioserie.NumAbonado;



  EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  END pv_activaAutenticacion_pr;

---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE pv_rec_num_periodo_prom_pr (
    EV_cambioserie           IN OUT NOCOPY  PV_CAM_SIMCARD_OT,
    SN_cod_retorno           OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            OUT NOCOPY     ge_errores_pg.evento)
  IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              varchar2(100) := 'pv_grabar_simcard_sb_pg.pv_rec_num_periodo_prom_pr';
  BEGIN

    LV_sSql:= 'SELECT cod_promocion, num_periodos ';
    LV_sSql:= LV_sSql || 'FROM ga_promoc_amistar ';
    LV_sSql:= LV_sSql || 'WHERE sysdate BETWEEN fec_desde AND fec_hasta ';
    LV_sSql:= LV_sSql || 'AND ind_procequi IN(''A'',' || EV_cambioserie.IndProcEqui || ')';
    LV_sSql:= LV_sSql || 'AND cod_canal IN(''3'', '   ||EV_cambioserie.ind_vta_externa   || ')';
    LV_sSql:= LV_sSql || 'AND cod_uniprom = 2;';

    SELECT cod_promocion, num_periodos
    INTO EV_cambioserie.CodProm, EV_cambioserie.NumPeriodo
    FROM ga_promoc_amistar
    WHERE sysdate BETWEEN fec_desde AND fec_hasta
    AND ind_procequi IN('A',EV_cambioserie.IndProcEqui)
    AND cod_canal IN('3', EV_cambioserie.ind_vta_externa )
    AND cod_uniprom = 2;

    IF EV_cambioserie.NumPeriodo > 0 Then
       EV_cambioserie.CargaPer := (EV_cambioserie.CargaTot / EV_cambioserie.NumPeriodo + 1);
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  END pv_rec_num_periodo_prom_pr;
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------

END pv_grabar_simcard_sb_pg;
/
SHOW ERRORS