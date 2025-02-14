CREATE OR REPLACE PACKAGE BODY           GE_OVERRIDE_PG IS


FUNCTION  GE_INS_OVERRIDE_FN   (EN_COD_CLIENTE                IN    ge_cargos_sobrescritos_to.cod_cliente%type,
                                EN_NUM_ABONADO              IN  ge_cargos_sobrescritos_to.num_abonado%type,
                                EV_COD_ORIGEN_TRANSACCION   IN  ge_cargos_sobrescritos_to.cod_origen_transaccion%type,
                                EN_TIPO_SERVICIO            IN  ge_cargos_sobrescritos_to.tipo_servicio%type,
                                EN_COD_PROD_CONTRATADO      IN  ge_cargos_sobrescritos_to.cod_prod_contratado%type,
                                EN_COD_CARGO_CONTRATADO     IN  ge_cargos_sobrescritos_to.cod_cargo_contratado%type,
                                EV_COD_PLANTARIF            IN  ge_cargos_sobrescritos_to.cod_plantarif%type,
                                EV_COD_CARGOBASICO          IN  ge_cargos_sobrescritos_to.cod_cargobasico%type,
                                EV_COD_SERVICIO             IN  ge_cargos_sobrescritos_to.cod_servicio%type,
                                EN_IMPORTE_ORIGEN           IN  ge_cargos_sobrescritos_to.importe_origen%type,
                                EN_IMPORTE_SOBRESCRITO      IN  ge_cargos_sobrescritos_to.importe_sobrescrito%type,
                                EV_COD_MONEDA               IN  ge_cargos_sobrescritos_to.cod_moneda%type,
                                EN_COD_CONCEPTO             IN  ge_cargos_sobrescritos_to.cod_concepto%type,
                                EN_NUM_VENTA                IN  ge_cargos_sobrescritos_to.num_venta%type,
                                EV_NOM_USUARORA             IN  ge_cargos_sobrescritos_to.nom_usuarora%type,
                                SV_SSQL             OUT NOCOPY  ge_errores_pg.vQuery,
                                SN_COD_RETORNO      OUT NOCOPY  ge_errores_pg.CodError,
                                SV_MENS_RETORNO     OUT NOCOPY  ge_errores_pg.MsgError
) RETURN BOOLEAN
IS
    LV_des_error    ge_errores_pg.DesEvent;
BEGIN
    sn_cod_retorno  := 0;

    SV_sSql := 'insert into ge_cargos_sobrescritos_to (cod_cliente,num_abonado,cod_origen_transaccion,tipo_servicio,cod_prod_contratado,';
    SV_sSql := SV_sSql || ' cod_cargo_contratado,cod_plantarif,cod_cargobasico,cod_servicio,importe_origen,';
    SV_sSql := SV_sSql || ' importe_sobrescrito,cod_moneda,cod_concepto,num_venta,fec_registro,nom_usuarora)';
    SV_sSql := SV_sSql || ' values ('|| en_cod_cliente||','||en_num_abonado||','''||ev_cod_origen_transaccion||''','||en_tipo_servicio||','||en_cod_prod_contratado||',';
    SV_sSql := SV_sSql || '' ||en_cod_cargo_contratado||','''||ev_cod_plantarif||''','''||ev_cod_cargobasico||''','''||ev_cod_servicio||''','||en_importe_origen||',';
    SV_sSql := SV_sSql || '' ||en_importe_sobrescrito||','''||ev_cod_moneda||''','||en_cod_concepto||','||en_num_venta||',sysdate,'''||ev_nom_usuarora||''')';

    insert into ge_cargos_sobrescritos_to (cod_cliente,num_abonado,cod_origen_transaccion,tipo_servicio,cod_prod_contratado,
           cod_cargo_contratado,cod_plantarif,cod_cargobasico,cod_servicio,importe_origen,
           importe_sobrescrito,cod_moneda,cod_concepto,num_venta,fec_registro,nom_usuarora)
    values (en_cod_cliente,en_num_abonado,ev_cod_origen_transaccion,en_tipo_servicio,en_cod_prod_contratado,
            en_cod_cargo_contratado,ev_cod_plantarif,ev_cod_cargobasico,ev_cod_servicio,en_importe_origen,
            en_importe_sobrescrito,ev_cod_moneda,en_cod_concepto,en_num_venta,sysdate,ev_nom_usuarora);

    RETURN TRUE;
    EXCEPTION
        WHEN OTHERS THEN
            SN_cod_retorno := 890065;
            SV_MENS_RETORNO   := 'GE_OVERRIDE_PG.GE_INS_OVERRIDE_FN' || SQLERRM;
            RETURN FALSE;
END GE_INS_OVERRIDE_FN;
----------------------------------------------------------------------------------
PROCEDURE GE_INS_OVERRIDE_PR   (EN_COD_CLIENTE                IN    ge_cargos_sobrescritos_to.cod_cliente%type,
                                EN_NUM_ABONADO              IN  ge_cargos_sobrescritos_to.num_abonado%type,
                                EV_COD_ORIGEN_TRANSACCION   IN  ge_cargos_sobrescritos_to.cod_origen_transaccion%type,
                                EN_TIPO_SERVICIO            IN  ge_cargos_sobrescritos_to.tipo_servicio%type,
                                EN_COD_PROD_CONTRATADO      IN  ge_cargos_sobrescritos_to.cod_prod_contratado%type,
                                EN_COD_CARGO_CONTRATADO     IN  ge_cargos_sobrescritos_to.cod_cargo_contratado%type,
                                EV_COD_PLANTARIF            IN  ge_cargos_sobrescritos_to.cod_plantarif%type,
                                EV_COD_CARGOBASICO          IN  ge_cargos_sobrescritos_to.cod_cargobasico%type,
                                EV_COD_SERVICIO             IN  ge_cargos_sobrescritos_to.cod_servicio%type,
                                EN_IMPORTE_ORIGEN           IN  ge_cargos_sobrescritos_to.importe_origen%type,
                                EN_IMPORTE_SOBRESCRITO      IN  ge_cargos_sobrescritos_to.importe_sobrescrito%type,
                                EV_COD_MONEDA               IN  ge_cargos_sobrescritos_to.cod_moneda%type,
                                EN_COD_CONCEPTO             IN  ge_cargos_sobrescritos_to.cod_concepto%type,
                                EN_NUM_VENTA                IN  ge_cargos_sobrescritos_to.num_venta%type,
                                EV_NOM_USUARORA             IN  ge_cargos_sobrescritos_to.nom_usuarora%type,
                                SN_COD_RETORNO           OUT NOCOPY   ge_errores_pg.CodError,
                                SV_MENS_RETORNO          OUT NOCOPY   ge_errores_pg.MsgError,
                                SN_NUM_EVENTO            OUT NOCOPY   ge_errores_pg.evento )

IS
    LV_des_error    ge_errores_pg.DesEvent;
    LV_sSql         ge_errores_pg.vQuery;
    ERROR_FUNCION   EXCEPTION;
BEGIN
    sn_cod_retorno  := 0;
    sn_num_evento  := 0;

    IF NOT  GE_INS_OVERRIDE_FN(EN_COD_CLIENTE,EN_NUM_ABONADO,EV_COD_ORIGEN_TRANSACCION,EN_TIPO_SERVICIO,EN_COD_PROD_CONTRATADO,EN_COD_CARGO_CONTRATADO,EV_COD_PLANTARIF,EV_COD_CARGOBASICO,EV_COD_SERVICIO,EN_IMPORTE_ORIGEN,EN_IMPORTE_SOBRESCRITO,EV_COD_MONEDA,EN_COD_CONCEPTO,EN_NUM_VENTA,EV_NOM_USUARORA,LV_sSql,sn_cod_retorno,sv_mens_retorno) THEN
        RAISE ERROR_FUNCION;
    END IF;


    EXCEPTION
        WHEN ERROR_FUNCION THEN
             LV_des_error   := SV_MENS_RETORNO;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
                    sv_mens_retorno := CV_error_no_clasif;
             END IF;
             sn_num_evento  :=  Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'GE_OVERRIDE_PG.GE_INS_OVERRIDE_PR', LV_sSQL, sn_cod_retorno, LV_des_error );
             SV_MENS_RETORNO := LV_des_error ;

END GE_INS_OVERRIDE_PR;
----------------------------------------------------------------------------------

PROCEDURE GE_REC_OVERRIDE_PR(EN_NUM_VENTA              IN ga_abocel.num_venta%TYPE,
                             EV_COD_ORIGEN_TRANSACCION IN ge_cargos_sobrescritos_to.cod_origen_transaccion%TYPE,
                             SC_REG_CRG               OUT NOCOPY      refcursor,
                             SN_COD_RETORNO           OUT NOCOPY   ge_errores_pg.CodError,
                             SV_MENS_RETORNO          OUT NOCOPY   ge_errores_pg.MsgError,
                             SN_NUM_EVENTO            OUT NOCOPY   ge_errores_pg.evento)
IS
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
    error_exception EXCEPTION;

BEGIN
    sn_cod_retorno := 0;
    sn_num_evento  := 0;

    LV_sSql := 'SELECT  crg.cod_cliente, ';
    LV_sSql := LV_sSql || ' crg.num_abonado,';
    LV_sSql := LV_sSql || ' crg.cod_origen_transaccion,';
    LV_sSql := LV_sSql || ' crg.tipo_servicio,';
    LV_sSql := LV_sSql || ' crg.cod_prod_contratado,';
    LV_sSql := LV_sSql || ' crg.cod_cargo_contratado,';
    LV_sSql := LV_sSql || ' crg.cod_plantarif,';
    LV_sSql := LV_sSql || ' crg.cod_cargobasico,';
    LV_sSql := LV_sSql || ' crg.cod_plantarif,';
    LV_sSql := LV_sSql || ' crg.cod_cargobasico,';
    LV_sSql := LV_sSql || ' crg.cod_servicio,';
    LV_sSql := LV_sSql || ' crg.importe_origen,';
    LV_sSql := LV_sSql || ' crg.importe_sobrescrito,';
    LV_sSql := LV_sSql || ' crg.cod_moneda,';
    LV_sSql := LV_sSql || ' crg.cod_concepto,';
    LV_sSql := LV_sSql || ' crg.num_venta,';
    LV_sSql := LV_sSql || ' crg.nom_usuarora,';
    LV_sSql := LV_sSql || ' from ge_cargos_sobrescritos_to crg ';
    LV_sSql := LV_sSql || ' WHERE crg.num_venta  = ' || en_num_venta;
    LV_sSql := LV_sSql || '  and   crg.cod_origen_transaccion =''' ||ev_cod_origen_transaccion ||'''';


    OPEN SC_REG_CRG FOR
    select  crg.cod_cliente,
            crg.num_abonado,
            crg.cod_origen_transaccion,
            crg.tipo_servicio,
            crg.cod_prod_contratado,
            crg.cod_cargo_contratado,
            crg.cod_plantarif,
            crg.cod_cargobasico,
            crg.cod_servicio,
            crg.importe_origen,
            crg.importe_sobrescrito,
            crg.cod_moneda,
            crg.cod_concepto,
            crg.num_venta,
            crg.fec_registro,
            crg.nom_usuarora
    from ge_cargos_sobrescritos_to crg
    where crg.num_venta = en_num_venta
    and   crg.cod_origen_transaccion = ev_cod_origen_transaccion;

    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := 890066;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
                    sv_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := 'GA_OVERRIDE_PG.GA_REC_OVERRIDE_PR ' || SQLERRM;
             sn_num_evento  := Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'GE_OVERRIDE_PG.GE_REC_OVERRIDE_PR', LV_sSQL, sn_cod_retorno, LV_des_error );

END GE_REC_OVERRIDE_PR;

----------------------------------------------------------------------------------
FUNCTION  GE_VAL_DATOS_CLIE_FN (EN_COD_CLIENTE  IN ge_clientes.cod_cliente%TYPE
) RETURN NUMBER
IS
    LV_des_error    ge_errores_pg.DesEvent;
    LV_sSql         ge_errores_pg.vQuery;
    SN_COD_RETORNO  ge_errores_pg.CodError;
    SV_MENS_RETORNO ge_errores_pg.MsgError;
    LN_Valor        number;
BEGIN
    sn_cod_retorno  := 0;


    LV_sSql := 'SELECT   count(0) ';
    LV_sSql := LV_sSql || ' INTO     ln_valor';
    LV_sSql := LV_sSql || ' FROM ge_cliente a ';
    LV_sSql := LV_sSql || ' WHERE    a.cod_cliente = ' || en_cod_cliente;

    SELECT   count(0)
    INTO     ln_valor
    FROM     ge_clientes a
    WHERE    a.cod_cliente = en_cod_cliente;


    RETURN ln_valor;
    EXCEPTION
        WHEN OTHERS THEN
            SN_cod_retorno := 890067;
            SV_MENS_RETORNO  := 'GE_OVERRIDE_PG.GE_VAL_DATOS_CLIE_FN' || SQLERRM;
            RETURN -1;
END GE_VAL_DATOS_CLIE_FN;
----------------------------------------------------------------------------------


FUNCTION  GE_IMPORTE_GRAVADO_FN (EN_COD_CLIENTE  IN ge_clientes.cod_cliente%TYPE,
                                 EV_COD_OFICINA  IN ge_clientes.cod_oficina%TYPE,
                                 EN_COD_CONCEPTO IN NUMBER,
                                 EN_IMPORTE      IN NUMBER
) RETURN NUMBER
IS
    LV_des_error    ge_errores_pg.DesEvent;
    LV_sSql         ge_errores_pg.vQuery;
    SN_cod_retorno  ge_errores_pg.CodError;
    SV_mens_retorno ge_errores_pg.MsgError;
    SN_numEvento    ge_errores_pg.Evento;
    LN_Valor        number;
BEGIN
    sn_cod_retorno  := 0;

    fa_servicios_facturacion_pg.fa_getimpuesto_pr(en_cod_cliente,ev_cod_oficina,en_importe,en_cod_concepto,ln_valor,sn_cod_retorno,sv_mens_retorno,sn_numevento);

    RETURN ln_valor;
    EXCEPTION
        WHEN OTHERS THEN
            SN_cod_retorno := 890068;
            SV_MENS_RETORNO  := 'GE_OVERRIDE_PG.GE_IMPORTE_GRAVADO_FN' || SQLERRM;
            RETURN -1;
END GE_IMPORTE_GRAVADO_FN;
----------------------------------------------------------------------------------
FUNCTION  GE_REC_PARAMETROS_FN (EV_COD_MODULO    IN ged_parametros.cod_modulo%TYPE,
                                EN_COD_PRODUCTO  IN ged_parametros.cod_producto%TYPE,
                                EV_NOM_PARAMETRO IN ged_parametros.nom_parametro%TYPE
) RETURN VARCHAR2
IS
    SN_cod_retorno  ge_errores_pg.CodError;
    SV_mens_retorno ge_errores_pg.MsgError;
    SN_numEvento    ge_errores_pg.Evento;
    LV_Valor        VARCHAR2(20);
BEGIN
    sn_cod_retorno  := 0;

    LV_Valor := ge_fn_devvalparam(EV_COD_MODULO,EN_COD_PRODUCTO,EV_NOM_PARAMETRO);


    RETURN lv_valor;
    EXCEPTION
        WHEN OTHERS THEN
            SN_cod_retorno := 890069;
            SV_MENS_RETORNO  := 'GE_OVERRIDE_PG.GE_REC_PARAMETROS_FN' || SQLERRM;
            RETURN -1;
END  GE_REC_PARAMETROS_FN;
----------------------------------------------------------------------------------
PROCEDURE GE_REC_TIP_IDENT_PR(EN_VALOR         IN  NUMBER,
                              SC_REG_IDENT     OUT NOCOPY      refcursor)
IS
    SN_COD_RETORNO      ge_errores_pg.CodError;
    SV_MENS_RETORNO     ge_errores_pg.MsgError;
    SN_NUM_EVENTO       ge_errores_pg.evento;
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
    error_exception EXCEPTION;

BEGIN
    sn_cod_retorno := 0;
    sn_num_evento  := 0;


    LV_sSql := 'SELECT  a.cod_tipident, ';
    LV_sSql := LV_sSql || '  a.des_tipident';
    LV_sSql := LV_sSql || ' FROM   ge_tipident a ';
    LV_sSql := LV_sSql || ' ORDER BY a.cod_tipident';

    OPEN SC_REG_IDENT FOR
    SELECT a.cod_tipident,
           a.des_tipident
    FROM   ge_tipident a
    ORDER BY a.cod_tipident;


    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := 890070;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
                    sv_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := 'GE_OVERRIDE_PG.GE_REC_TIP_IDENT_PR ' || SQLERRM;
             sn_num_evento  := Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'GE_OVERRIDE_PG.GE_REC_TIP_IDENT_PR', LV_sSQL, sn_cod_retorno, LV_des_error );

END GE_REC_TIP_IDENT_PR;
----------------------------------------------------------------------------------
PROCEDURE GE_REC_DATOS_CLIE_PR(EN_COD_CLIENTE  IN ge_clientes.cod_cliente%TYPE,
                               SC_REG_CLIE     OUT NOCOPY      refcursor)
IS
    SN_COD_RETORNO      ge_errores_pg.CodError;
    SV_MENS_RETORNO     ge_errores_pg.MsgError;
    SN_NUM_EVENTO       ge_errores_pg.evento;
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
    error_exception EXCEPTION;

BEGIN
    sn_cod_retorno := 0;
    sn_num_evento  := 0;


    LV_sSql := 'SELECT  a.cod_cliente, ';
    LV_sSql := LV_sSql || ' ,a.nom_cliente || '''' || a.nom_apeclien1 || '''' ||a.nom_apeclien2';
    LV_sSql := LV_sSql || ' ,a.cod_tipident';
    LV_sSql := LV_sSql || ' ,a.num_ident';
    LV_sSql := LV_sSql || ' ,a.cod_oficina';
    LV_sSql := LV_sSql || ' FROM ge_cliente a ';
    LV_sSql := LV_sSql || ' WHERE    a.cod_cliente = ' || en_cod_cliente;

    OPEN SC_REG_CLIE FOR
    SELECT   a.cod_cliente
            ,a.nom_cliente || ' ' || a.nom_apeclien1 || ' ' ||a.nom_apeclien2
            ,a.cod_tipident
            ,a.num_ident
            ,a.cod_oficina
    FROM     ge_clientes a
    WHERE    a.cod_cliente = en_cod_cliente;


    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := 890071;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
                    sv_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := 'GE_OVERRIDE_PG.GE_REC_DATOS_CLIE_PR ' || SQLERRM;
             sn_num_evento  := Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'GE_OVERRIDE_PG.GE_REC_DATOS_CLIE_PR', LV_sSQL, sn_cod_retorno, LV_des_error );

END GE_REC_DATOS_CLIE_PR;
----------------------------------------------------------------------------------

PROCEDURE GE_REC_CLIE_PR(EV_COD_TIPIDENT  IN ge_clientes.cod_tipident%TYPE,
                         EV_NUM_IDENT     IN ge_clientes.num_ident%TYPE,
                         SC_REG_CLIE     OUT NOCOPY      refcursor)
IS
    SN_COD_RETORNO      ge_errores_pg.CodError;
    SV_MENS_RETORNO     ge_errores_pg.MsgError;
    SN_NUM_EVENTO       ge_errores_pg.evento;
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
    error_exception EXCEPTION;

BEGIN
    sn_cod_retorno := 0;
    sn_num_evento  := 0;


    LV_sSql := 'SELECT  a.cod_cliente, ';
    LV_sSql := LV_sSql || ' ,a.nom_cliente || '''' || a.nom_apeclien1 || '''' ||a.nom_apeclien2';
    LV_sSql := LV_sSql || ' FROM ge_cliente a ';
    LV_sSql := LV_sSql || ' WHERE    a.cod_tipident = ' || ev_cod_tipident;
    LV_sSql := LV_sSql || ' AND      a.num_ident    = ' || ev_num_ident;

    OPEN SC_REG_CLIE FOR
    SELECT   a.cod_cliente
            ,a.nom_cliente || ' ' || a.nom_apeclien1 || ' ' ||a.nom_apeclien2
    FROM     ge_clientes a
    WHERE    a.cod_tipident = ev_cod_tipident
    AND      a.num_ident    = ev_num_ident;


    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := 890071;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
                    sv_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := 'GE_OVERRIDE_PG.GE_REC_CLIE_PR ' || SQLERRM;
             sn_num_evento  := Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'GE_OVERRIDE_PG.GE_REC_CLIE_PR', LV_sSQL, sn_cod_retorno, LV_des_error );

END GE_REC_CLIE_PR;
----------------------------------------------------------------------------------
PROCEDURE GE_REC_ABNCLIE_PR(EN_COD_CLIENTE  IN ge_clientes.cod_cliente%TYPE,
                            SC_REG_ABON     OUT NOCOPY      refcursor)
IS
    SN_COD_RETORNO      ge_errores_pg.CodError;
    SV_MENS_RETORNO     ge_errores_pg.MsgError;
    SN_NUM_EVENTO       ge_errores_pg.evento;
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
    error_exception EXCEPTION;

BEGIN
    sn_cod_retorno := 0;
    sn_num_evento  := 0;


---    01/12/2010, LMV, Se reversa la solucion para la incidencia 143390 (No debe mostrar todos los abonados asociados al numero PILOTO)
---  a pedido de la operadora 
-----------------------------------------------------------------------------------------------------------------
--    LV_sSql := 'SELECT a.num_abonado, ';
--    LV_sSql := LV_sSql || ' a.cod_plantarif,';
--    LV_sSql := LV_sSql || ' b.des_plantarif,';
--    LV_sSql := LV_sSql || ' a.num_venta,';
--    LV_sSql := LV_sSql || ' b.cod_cargobasico,';
--    LV_sSql := LV_sSql || ' b.cod_servicio';
--    LV_sSql := LV_sSql || ' FROM ga_abocel a , ta_plantarif b ';
--    LV_sSql := LV_sSql || ' WHERE a.cod_cliente   = ' || en_cod_cliente;
--    LV_sSql := LV_sSql || ' AND   a.cod_situacion = ''' || cv_situacion_aaa || '''';
--    LV_sSql := LV_sSql || ' AND   a.cod_plantarif = b.cod_plantarif';
--    LV_sSql := LV_sSql || ' AND   b.ind_compartido = 1';
--    LV_sSql := LV_sSql || ' AND   a.IND_SUPERTEL <> 7';    
--    LV_sSql := LV_sSql || ' AND   a.NUM_ABONADO in (select min(a1.num_abonado)';
--    LV_sSql := LV_sSql || '                            from ga_abocel a1';
--    LV_sSql := LV_sSql || '                            WHERE a1.cod_cliente   = ' || en_cod_cliente;
--    LV_sSql := LV_sSql || '                             and  a1.cod_situacion = ''' || cv_situacion_aaa || '''';
--    LV_sSql := LV_sSql || '                             and  a1.IND_SUPERTEL  <> 7 ';    
--    LV_sSql := LV_sSql || '                             and  a1.cod_plantarif = a.cod_plantarif) ';
--    LV_sSql := LV_sSql || ' UNION ';     
--    LV_sSql := LV_sSql ||  'SELECT a.num_abonado, ';
--    LV_sSql := LV_sSql || ' a.cod_plantarif,';
--    LV_sSql := LV_sSql || ' b.des_plantarif,';
--    LV_sSql := LV_sSql || ' a.num_venta,';
--    LV_sSql := LV_sSql || ' b.cod_cargobasico,';
--    LV_sSql := LV_sSql || ' b.cod_servicio';
--    LV_sSql := LV_sSql || ' FROM ga_abocel a , ta_plantarif b ';
--    LV_sSql := LV_sSql || ' WHERE a.cod_cliente   = ' || en_cod_cliente;
--    LV_sSql := LV_sSql || ' AND   a.cod_situacion = ''' || cv_situacion_aaa || '''';
--    LV_sSql := LV_sSql || ' AND   a.cod_plantarif = b.cod_plantarif';
--    LV_sSql := LV_sSql || ' AND   b.ind_compartido = 0';
--    LV_sSql := LV_sSql || ' AND   a.IND_SUPERTEL <> 7'; 
--    LV_sSql := LV_sSql || ' AND   a.NUM_ABONADO in (select min(a1.num_abonado)';
--    LV_sSql := LV_sSql || '                            from ga_abocel a1';
--    LV_sSql := LV_sSql || '                            WHERE a1.cod_cliente   = ' || en_cod_cliente;
--    LV_sSql := LV_sSql || '                             and  a1.cod_situacion = ''' || cv_situacion_aaa || '''';
--    LV_sSql := LV_sSql || '                             and  a1.IND_SUPERTEL  <> 7 ';     
--    LV_sSql := LV_sSql || '                             and a1.cod_plantarif = a.cod_plantarif) ';


--    OPEN SC_REG_ABON FOR        
--    select a.num_abonado, a.cod_plantarif, b.des_plantarif,a.num_venta,b.cod_cargobasico,b.cod_servicio
--    from ga_abocel a, ta_plantarif b
--    where  a.cod_cliente    = en_cod_cliente
--       and a.cod_situacion  = cv_situacion_aaa
--       and b.cod_producto   = 1
--       and a.cod_plantarif  = b.cod_plantarif
--       and b.ind_compartido = 1
--       and a.IND_SUPERTEL <> 7
--       and a.NUM_ABONADO in (select min(a1.num_abonado)
--                            from ga_abocel a1
--                            where a1.cod_cliente   = en_cod_cliente
--                              and a1.cod_situacion = cv_situacion_aaa
--                              and a1.IND_SUPERTEL <> 7
--                              and a1.cod_plantarif = a.cod_plantarif)                            
--    union                           
--    select a.num_abonado, a.cod_plantarif, b.des_plantarif,a.num_venta,b.cod_cargobasico,b.cod_servicio
--    from ga_abocel a, ta_plantarif b
--    where  a.cod_cliente    = en_cod_cliente
--       and a.cod_situacion  = cv_situacion_aaa
--       and b.cod_producto   = 1       
--       and a.cod_plantarif  = b.cod_plantarif
--       and b.ind_compartido = 0
--       and a.IND_SUPERTEL <> 7
--       and a.NUM_ABONADO in (select min(a1.num_abonado)
--                            from ga_abocel a1
--                            where a1.cod_cliente   = en_cod_cliente
--                              and a1.cod_situacion = cv_situacion_aaa
--                              and a1.IND_SUPERTEL <> 7
--                              and a1.cod_plantarif = a.cod_plantarif); 
                            
                              


    --- 01/12/20101, LMV Solucion incidencia 156632 GUATEMALA
    LV_sSql := 'SELECT abn.num_abonado, ';
    LV_sSql := LV_sSql || ' abn.cod_plantarif,';
    LV_sSql := LV_sSql || ' pln.des_plantarif,';
    LV_sSql := LV_sSql || ' abn.num_venta,';
    LV_sSql := LV_sSql || ' pln.cod_cargobasico,';
    LV_sSql := LV_sSql || ' pln.cod_servicio';
    LV_sSql := LV_sSql || ' FROM ga_abocel abn , ta_plantarif pln ';
    LV_sSql := LV_sSql || ' WHERE abn.cod_cliente   = ' || en_cod_cliente;
    LV_sSql := LV_sSql || ' AND   abn.cod_situacion = ''' || cv_situacion_aaa || '''';
    LV_sSql := LV_sSql || ' AND   pln.cod_plantarif = abn.cod_plantarif;';

    OPEN SC_REG_ABON FOR
    SELECT abn.num_abonado, 
           abn.cod_plantarif,  
           pln.des_plantarif,
           abn.num_venta,
           pln.cod_cargobasico,
           pln.cod_servicio
    FROM ga_abocel abn , ta_plantarif pln 
    WHERE abn.cod_cliente   = en_cod_cliente
    AND   abn.cod_situacion = cv_situacion_aaa
    AND   pln.cod_plantarif = abn.cod_plantarif
    ORDER BY abn.num_abonado;
    

    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := 890072;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
                    sv_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := 'GE_OVERRIDE_PG.GE_REC_ABNCLIE_PR ' || SQLERRM;
             sn_num_evento  := Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'GE_OVERRIDE_PG.GE_REC_ABNCLIE_PR', LV_sSQL, sn_cod_retorno, LV_des_error );

END GE_REC_ABNCLIE_PR;

----------------------------------------------------------------------------------
PROCEDURE GE_REC_CRGBSC_CLIE_PR(EN_COD_CLIENTE  IN ga_abocel.cod_cliente%TYPE,
                                EN_NUM_ABONADO  IN ga_abocel.num_abonado%TYPE,
                                EN_NUM_DIAS     IN number,
                                SC_REG_CRG      OUT NOCOPY      refcursor)
IS
    SN_COD_RETORNO      ge_errores_pg.CodError;
    SV_MENS_RETORNO     ge_errores_pg.MsgError;
    SN_NUM_EVENTO       ge_errores_pg.evento;
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
    error_exception EXCEPTION;

BEGIN
    sn_cod_retorno := 0;
    sn_num_evento  := 0;


    LV_sSql := 'SELECT  crg.cod_cargobasico, ';
    LV_sSql := LV_sSql || ' crg.des_cargobasico,';
    LV_sSql := LV_sSql || ' crg.imp_cargobasico,';
    LV_sSql := LV_sSql || ' crg.cod_moneda';
    LV_sSql := LV_sSql || ' mnd.des_moneda';
    LV_sSql := LV_sSql || ' FROM   ga_intarcel  gic,ta_plantarif trf, ta_cargosbasico crg, ge_monedas mnd ';
    LV_sSql := LV_sSql || ' WHERE  gic.cod_cliente = ' || en_cod_cliente;
    LV_sSql := LV_sSql || ' AND    gic.num_abonado = ' || en_num_abonado;
    LV_sSql := LV_sSql || ' AND    sysdate between gic.fec_desde and gic.fec_hasta ';
    LV_sSql := LV_sSql || ' AND    gic.fec_desde   >= (sysdate - ' || en_num_dias ||')';
    LV_sSql := LV_sSql || ' AND    trf.cod_plantarif = gic.cod_plantarif';
    LV_sSql := LV_sSql || ' AND    crg.cod_cargobasico = trf.cod_cargobasico ';
    LV_sSql := LV_sSql || ' AND    sysdate between crg.fec_desde and crg.fec_hasta; ';

    
    OPEN SC_REG_CRG  FOR
    SELECT  crg.cod_cargobasico,
            crg.des_cargobasico,
            crg.imp_cargobasico,
            crg.cod_moneda,
            mnd.des_moneda,
            nvl(car.IMPORTE_SOBRESCRITO,999999)
    FROM    ga_intarcel  gic, ta_plantarif trf, ta_cargosbasico crg, ge_monedas mnd,ge_cargos_sobrescritos_to car
    WHERE  gic.cod_cliente     = en_cod_cliente
    AND    gic.num_abonado     = en_num_abonado
    and    car.cod_cliente(+)  = en_cod_cliente
    AND    car.num_abonado(+)  = en_num_abonado
    AND    sysdate between gic.fec_desde and gic.fec_hasta
    AND    gic.fec_desde    >= (sysdate - en_num_dias)
    AND    trf.cod_plantarif   = gic.cod_plantarif
    AND    crg.cod_cargobasico = trf.cod_cargobasico
    and    crg.cod_CARGOBASICO=car.COD_CARGOBASICO(+)
    and    crg.cod_producto=1
    AND    SYSDATE BETWEEN crg.fec_desde AND crg.fec_hasta
    AND    mnd.cod_moneda      = crg.cod_moneda
    and    sysdate between gic.fec_desde and gic.fec_hasta
    AND NVL(CAR.FEC_REGISTRO,sysdate) 
    IN (SELECT  MAX(NVL(CAR.FEC_REGISTRO,sysdate))
    FROM    ga_intarcel  gic, ta_plantarif trf, ta_cargosbasico crg, ge_monedas mnd,ge_cargos_sobrescritos_to car
    WHERE  gic.cod_cliente     = en_cod_cliente
    AND    gic.num_abonado     = en_num_abonado
    and    car.cod_cliente(+)  = en_cod_cliente
    AND    car.num_abonado(+)  = en_num_abonado
    AND    sysdate between gic.fec_desde and gic.fec_hasta
    AND    gic.fec_desde    >= (sysdate - en_num_dias)
    AND    trf.cod_plantarif   = gic.cod_plantarif
    AND    crg.cod_cargobasico = trf.cod_cargobasico
    and    crg.cod_CARGOBASICO=car.COD_CARGOBASICO(+)
    and    crg.cod_producto=1
    AND    SYSDATE BETWEEN crg.fec_desde AND crg.fec_hasta
    and    sysdate between gic.fec_desde and gic.fec_hasta
    AND    mnd.cod_moneda      = crg.cod_moneda);
    
    
    --AND    not exists (select 1 from ge_cargos_sobrescritos_to ovr
    --                   where ovr.cod_cliente = gic.cod_cliente
    --                   and   ovr.num_abonado = gic.num_abonado
    --                  and   ovr.cod_plantarif = gic.cod_plantarif
    --                   and   ovr.cod_origen_transaccion = CV_modulo_pv
    --                   and   ovr.tipo_servicio = CV_tip_serv_cb);

    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := 890073;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
                    sv_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := 'GE_OVERRIDE_PG.GE_REC_CRGBSC_CLIE_PR' || SQLERRM;
             sn_num_evento  := Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'GE_OVERRIDE_PG.GE_REC_CRGBSC_CLIE_PR', LV_sSQL, sn_cod_retorno, LV_des_error );

END GE_REC_CRGBSC_CLIE_PR;
---------------------------------------------------------------------------------
PROCEDURE GE_REC_SS_CLIE_PR(EN_COD_CLIENTE  IN ga_abocel.cod_cliente%TYPE,
                            EN_NUM_ABONADO  IN ga_abocel.num_abonado%TYPE,
                            EN_NUM_DIAS     IN number,
                            SC_REG_SS       OUT NOCOPY      refcursor)
IS
    SN_COD_RETORNO      ge_errores_pg.CodError;
    SV_MENS_RETORNO     ge_errores_pg.MsgError;
    SN_NUM_EVENTO       ge_errores_pg.evento;
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
    error_exception EXCEPTION;

BEGIN
    sn_cod_retorno := 0;
    sn_num_evento  := 0;


    LV_sSql := 'SELECT ss.cod_servsupl, ';
    LV_sSql := LV_sSql || ' ss.cod_servicio,';
    LV_sSql := LV_sSql || ' ss.des_servicio,';
    LV_sSql := LV_sSql || ' trf.imp_tarifa,';
    LV_sSql := LV_sSql || ' trf.cod_moneda,';
    LV_sSql := LV_sSql || ' mnd.des_moneda,';
    LV_sSql := LV_sSql || ' sab.cod_concepto,';
    LV_sSql := LV_sSql || ' FROM   ga_intarcel  gic, ';
    LV_sSql := LV_sSql || ' ga_servsuplabo sab, ';
    LV_sSql := LV_sSql || ' ga_servsupl ss, ';
    LV_sSql := LV_sSql || ' ga_tarifas trf, ';
    LV_sSql := LV_sSql || ' ge_monedas mnd ';
    LV_sSql := LV_sSql || ' WHERE  gic.cod_cliente = ' || en_cod_cliente;
    LV_sSql := LV_sSql || ' AND    gic.num_abonado = ' || en_num_abonado;
    LV_sSql := LV_sSql || ' AND    sysdate between gic.fec_desde and gic.fec_hasta ';
    LV_sSql := LV_sSql || ' AND    sab.num_abonado  = gic.num_abonado ';
    LV_sSql := LV_sSql || ' AND    sab.cod_concepto is not null ';
    LV_sSql := LV_sSql || ' AND    sab.ind_estado   <> ' || cn_estado_seis ;
    LV_sSql := LV_sSql || ' AND    sab.fec_altabd   >= (sysdate - ' || en_num_dias ||')';
    LV_sSql := LV_sSql || ' AND    ss.cod_producto  = cn_cod_producto ';
    LV_sSql := LV_sSql || ' AND    ss.cod_servicio  = sab.cod_servicio ';
    LV_sSql := LV_sSql || ' AND    ss.cod_servsupl  = sab.cod_servsupl ';
    LV_sSql := LV_sSql || ' AND    trf.cod_actabo   = '''|| cv_actabo_fa || '''';
    LV_sSql := LV_sSql || ' AND    trf.cod_producto = ss.cod_producto ';
    LV_sSql := LV_sSql || ' AND    trf.cod_servicio = sab.cod_servicio ';
    LV_sSql := LV_sSql || ' AND    trf.cod_tipserv  = ' || cn_cod_tipserv;
    LV_sSql := LV_sSql || ' AND    trf.cod_planserv = gic.cod_planserv ';
    LV_sSql := LV_sSql || ' AND    mnd.cod_moneda   = trf.cod_moneda ';

    OPEN SC_REG_SS  FOR
    SELECT ss.cod_servsupl,
           ss.cod_servicio,
           ss.des_servicio,
           trf.imp_tarifa,
           trf.cod_moneda,
           mnd.des_moneda,
           sab.cod_concepto,
           nvl(car.IMPORTE_SOBRESCRITO,9999)
    FROM   ga_intarcel  gic,
           ga_servsuplabo sab,
           ga_servsupl ss,
           ga_tarifas trf,
           ge_monedas mnd,
           ge_cargos_sobrescritos_to car
    WHERE  gic.cod_cliente = en_cod_cliente
    AND    gic.num_abonado = en_num_abonado
    AND    car.cod_cliente(+) = en_cod_cliente
    AND    car.num_abonado(+) = en_num_abonado
    AND    sysdate between gic.fec_desde and gic.fec_hasta
    AND    sab.num_abonado  = gic.num_abonado
    AND    sab.cod_concepto is not null
    AND    sab.ind_estado   in (1,2)
    AND    sab.fec_altabd   >= (sysdate - en_num_dias)
    AND    ss.cod_producto  = cn_cod_producto
    AND    ss.cod_servicio  = sab.cod_servicio
    AND    ss.cod_servsupl  = sab.cod_servsupl
    AND    trf.cod_actabo   = cv_actabo_fa
    AND    trf.cod_producto = ss.cod_producto
    AND    trf.cod_servicio = sab.cod_servicio
    AND    trf.cod_tipserv  = cn_cod_tipserv
    AND    trf.cod_planserv = gic.cod_planserv
    AND    mnd.cod_moneda   = trf.cod_moneda
    and    car.cod_servicio(+) = sab.cod_servicio  
    and nvl(car.fec_REGISTRO,sysdate) IN 
    (
    SELECT MAX(NVL(car.FEC_REGISTRO,sysdate))
    FROM   ga_intarcel  gic,
           ga_servsuplabo sab,
           ga_servsupl ss,
           ga_tarifas trf,
           ge_monedas mnd,
           ge_cargos_sobrescritos_to car
    WHERE  gic.cod_cliente = en_cod_cliente
    AND    gic.num_abonado = en_num_abonado
    AND    car.cod_cliente(+) = en_cod_cliente
    AND    car.num_abonado(+) = en_num_abonado
    AND    sysdate between gic.fec_desde and gic.fec_hasta
    AND    sab.num_abonado  = gic.num_abonado
    AND    sab.cod_concepto is not null
    AND    sab.ind_estado   in (1,2)
    AND    sab.fec_altabd   >= (sysdate - en_num_dias)
    AND    ss.cod_producto  = cn_cod_producto
    AND    ss.cod_servicio  = sab.cod_servicio
    AND    ss.cod_servsupl  = sab.cod_servsupl
    AND    trf.cod_actabo   = cv_actabo_fa
    AND    trf.cod_producto = ss.cod_producto
    AND    trf.cod_servicio = sab.cod_servicio
    AND    trf.cod_tipserv  = cn_cod_tipserv
    AND    trf.cod_planserv = gic.cod_planserv
    AND    mnd.cod_moneda   = trf.cod_moneda
    and    car.cod_servicio(+) = sab.cod_servicio 
    group by car.cod_servicio);
    
    
    
    --AND    not exists (select 1 from ge_cargos_sobrescritos_to ovr
    --                   where ovr.cod_cliente = gic.cod_cliente
    --                  and   ovr.num_abonado = gic.num_abonado
    --                   and   ovr.cod_servicio = ss.cod_servicio
    --                  and   ovr.cod_origen_transaccion = CV_modulo_pv
    --                   and   ovr.tipo_servicio = CV_tip_serv_ss);

    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := 890074;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
                    sv_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := 'GE_OVERRIDE_PG.GE_REC_SS_CLIE_PR' || SQLERRM;
             sn_num_evento  := Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'GE_OVERRIDE_PG.GE_REC_SS_CLIE_PR', LV_sSQL, sn_cod_retorno, LV_des_error );

END GE_REC_SS_CLIE_PR;
---------------------------------------------------------------------------------
PROCEDURE GE_REC_PA_CLIE_PR(EN_COD_CLIENTE  IN ga_abocel.cod_cliente%TYPE,
                            EN_NUM_ABONADO  IN ga_abocel.num_abonado%TYPE,
                            EN_NUM_DIAS     IN number,
                            SC_REG_PA       OUT NOCOPY      refcursor)
IS
    SN_COD_RETORNO      ge_errores_pg.CodError;
    SV_MENS_RETORNO     ge_errores_pg.MsgError;
    SN_NUM_EVENTO       ge_errores_pg.evento;
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
    error_exception EXCEPTION;

BEGIN
    sn_cod_retorno := 0;
    sn_num_evento  := 0;


    LV_sSql := 'SELECT prc.cod_prod_contratado, ';
    LV_sSql := LV_sSql || ' prc.cod_prod_ofertado,';
    LV_sSql := LV_sSql || ' pro.des_prod_ofertado,';
    LV_sSql := LV_sSql || ' pcp.cod_moneda,';
    LV_sSql := LV_sSql || ' mnd.des_moneda,';
    LV_sSql := LV_sSql || ' fcr.cod_concepto';
    LV_sSql := LV_sSql || ' fcr.cod_cargo_contratado';
    LV_sSql := LV_sSql || ' FROM   pr_productos_contratados_to prc, ';
    LV_sSql := LV_sSql || ' fa_cargos_rec_to fcr, ';
    LV_sSql := LV_sSql || ' pf_productos_ofertados_td pro, ';
    LV_sSql := LV_sSql || ' pf_cargos_productos_td pcp, ';
    LV_sSql := LV_sSql || ' ge_monedas mnd ';
    LV_sSql := LV_sSql || ' and  prc.cod_cliente_beneficiario = ' || en_cod_cliente;
    LV_sSql := LV_sSql || ' and  prc.num_abonado_beneficiario = '||en_num_abonado;
    LV_sSql := LV_sSql || ' and  fcr.cod_prod_contratado      = prc.cod_prod_contratado ';
    LV_sSql := LV_sSql || ' and  fcr.fec_alta   >= (sysdate - ' || en_num_dias ||')';
    LV_sSql := LV_sSql || ' and  sysdate between fcr.fec_alta and fcr.fec_baja ';
    LV_sSql := LV_sSql || ' and  pro.cod_prod_ofertado        = prc.cod_prod_ofertado ';
    LV_sSql := LV_sSql || ' and  pcp.cod_cargo                = fcr.cod_cargo_contratado ';
    LV_sSql := LV_sSql || ' and  mnd.cod_moneda               = pcp.cod_moneda;';

    OPEN SC_REG_PA  FOR
    select  prc.cod_prod_contratado,
            prc.cod_prod_ofertado,
            pro.des_prod_ofertado,
            pcp.monto_importe,
            pcp.cod_moneda,
            mnd.des_moneda,
            fcr.cod_concepto,
            fcr.cod_cargo_contratado,
            nvl(car.IMPORTE_SOBRESCRITO,9999)
    from    pr_productos_contratados_to prc,
            fa_cargos_rec_to fcr,
            pf_productos_ofertados_td pro,
            pf_cargos_productos_td pcp,
            ge_monedas mnd,
            ge_cargos_sobrescritos_to car
    where prc.cod_cliente_beneficiario = en_cod_cliente
    and   prc.num_abonado_beneficiario = en_num_abonado
    and   car.cod_cliente(+)              = en_cod_cliente
    and   car.num_abonado(+)              = en_num_abonado
    and   fcr.cod_prod_contratado      = prc.cod_prod_contratado
    and   fcr.fec_alta                >= (sysdate - en_num_dias)
    and   sysdate between fcr.fec_alta and fcr.fec_baja
    and   pro.cod_prod_ofertado        = prc.cod_prod_ofertado
    and   pcp.cod_cargo                = fcr.cod_cargo_contratado
    and   mnd.cod_moneda               = pcp.cod_moneda
    and   car.cod_prod_contratado(+)      = prc.cod_prod_contratado
    and nvl(car.fec_REGISTRO,sysdate) 
    in 
    (select MAX(nvl(FEC_REGISTRO,sysdate))
    from    pr_productos_contratados_to prc,
            fa_cargos_rec_to fcr,
            pf_productos_ofertados_td pro,
            pf_cargos_productos_td pcp,
            ge_monedas mnd,
            ge_cargos_sobrescritos_to car
    where prc.cod_cliente_beneficiario = en_cod_cliente
    and   prc.num_abonado_beneficiario = en_num_abonado
    and   car.cod_cliente(+)              = en_cod_cliente
    and   car.num_abonado(+)              = en_num_abonado
    and   fcr.cod_prod_contratado      = prc.cod_prod_contratado
    and   fcr.fec_alta                >= (sysdate - en_num_dias)
    and   sysdate between fcr.fec_alta and fcr.fec_baja
    and   pro.cod_prod_ofertado        = prc.cod_prod_ofertado
    and   pcp.cod_cargo                = fcr.cod_cargo_contratado
    and   mnd.cod_moneda               = pcp.cod_moneda
    and   car.cod_prod_contratado(+)      = prc.cod_prod_contratado
    group by car.cod_prod_contratado);
    --AND   not exists (select 1 from ge_cargos_sobrescritos_to ovr
    --                   where ovr.cod_cliente = prc.cod_cliente_beneficiario
    --                   and   ovr.num_abonado = prc.num_abonado_beneficiario
    --                   and   ovr.cod_prod_contratado = prc.cod_prod_contratado
    --                   and   ovr.cod_origen_transaccion = CV_modulo_pv
    --                  and   ovr.tipo_servicio = CV_tip_serv_pa);

    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := 890075;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
                    sv_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := 'GE_OVERRIDE_PG.GE_REC_PA_CLIE_PR' || SQLERRM;
             sn_num_evento  := Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'GE_OVERRIDE_PG.GE_REC_PA_CLIE_PR', LV_sSQL, sn_cod_retorno, LV_des_error );

END GE_REC_PA_CLIE_PR;

END GE_OVERRIDE_PG;
/


