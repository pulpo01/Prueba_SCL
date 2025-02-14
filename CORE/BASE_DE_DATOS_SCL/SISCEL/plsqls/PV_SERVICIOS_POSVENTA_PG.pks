CREATE OR REPLACE PACKAGE PV_SERVICIOS_POSVENTA_PG IS


    CV_error_no_clasif   CONSTANT VARCHAR2(30) := 'Error no clasificado';
    cn_largoerrtec       CONSTANT NUMBER        := 4000;
    cn_largodesc         CONSTANT NUMBER        := 2000;
    cv_cod_modulo        CONSTANT VARCHAR2 (2)  := 'VE';
    CV_PRODUCTO          CONSTANT VARCHAR(1)   := '1';
    CV_tipodireccion     CONSTANT VARCHAR2(1)  := '1';
    CV_MODULO_GA         CONSTANT VARCHAR2(2)  := 'GA';
    CV_MODULO_GE         CONSTANT VARCHAR2(2)  := 'GE';
    CV_MODULO_AL         CONSTANT VARCHAR2(2)  := 'AL';
    CV_CODACT_VEN         CONSTANT VARCHAR2(2)  := 'VO';               -- codigo actuacion : venta oficina
    CV_FORMATO_FECHA     CONSTANT VARCHAR2(12) := 'FORMATO_SEL2';

    CV_NOMPAR_MONEDAPESO CONSTANT VARCHAR2(15) := 'COD_MONEDA_PESO';
    CV_NOMPAR_SERVHABILI CONSTANT VARCHAR2(18) := 'COD_SERVICIO_HABIL';
    CV_NOMPAR_INDTELOUT  CONSTANT VARCHAR2(11) := 'IND_TEL_OUT';

    CV_SERVOCASIONAL     CONSTANT VARCHAR(1)   := '1';
    CV_SERVSUPLEMENTARIO CONSTANT VARCHAR2(1)  := '2';
    CN_INDBLOQUEO         CONSTANT NUMBER       := 1;
    CN_ESTADO              CONSTANT NUMBER       := 0;
    CI_TRUE              CONSTANT PLS_INTEGER  := 1;
    CI_FALSE             CONSTANT PLS_INTEGER  := 0;
    CV_IND_VENTA_EXTERNA CONSTANT NUMBER       := 1;
    CV_IND_TIPO_VENTA    CONSTANT VARCHAR2(1)  := 'V' ;
    CV_TIP_VENTA_OFICINA CONSTANT VARCHAR2(1)  := 'O' ;
    CV_FORM_PRESU_VTA      CONSTANT VARCHAR2(15)  := 'FrmPresuVenta';
    CV_BAJA_ABONADO      CONSTANT VARCHAR2(3)  := 'BAA';
    CV_BAJA_ABONADOPDTE  CONSTANT VARCHAR2(3)  := 'BAP';
    CV_RECHAZADA         CONSTANT VARCHAR2(2)  := 'RE';
    CV_INDALTA           CONSTANT VARCHAR2(1)  := 'M';  --INC 45391
    CN_ESTADO_DOC         CONSTANT NUMBER       := 900;
    CN_ESTADO_PROC         CONSTANT NUMBER       := 3;
    CV_REPONE_CELULAR    CONSTANT VARCHAR(1)   := 'R';  --Indica reposición de numero celular
    CV_REPONE_CEL_RES    CONSTANT VARCHAR(1)   := 'S';  --Indica reposición de num celular reservado
    CV_CAUSA_ELIMIN      CONSTANT VARCHAR2(5)  := '00003';
    CN_CERO              CONSTANT NUMBER(1)    := 0;

    TYPE refcursor                  IS REF CURSOR;
    TYPE ARRAY_PARAMETROS_    IS TABLE OF VARCHAR2(60) INDEX BY BINARY_INTEGER;

    PROCEDURE VE_obtiene_abonados_venta_PR(EN_numventa        IN NUMBER,
                                           SC_cursordatos      OUT NOCOPY REFCURSOR,
                                            SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                             SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_inserta_cargo_PR( EV_num_cargo         IN VARCHAR2
                                   ,EV_cod_cliente         IN VARCHAR2
                                  ,EV_cod_producto         IN VARCHAR2
                                   ,EV_cod_concepto         IN VARCHAR2
                                   ,EV_imp_cargo             IN VARCHAR2
                                   ,EV_cod_moneda             IN VARCHAR2
                                   ,EV_cod_plancom         IN VARCHAR2
                                   ,EV_num_unidades         IN VARCHAR2
                                   ,EV_ind_factur             IN VARCHAR2
                                   ,EV_num_transaccion    IN VARCHAR2
                                   ,EV_num_venta            IN VARCHAR2
                                   ,EV_num_paquete        IN VARCHAR2
                                   ,EV_num_abonado        IN VARCHAR2
                                   ,EV_num_terminal        IN VARCHAR2
                                   ,EV_cod_ciclfact        IN VARCHAR2
                                   ,EV_num_serie            IN VARCHAR2
                                   ,EV_num_seriemec        IN VARCHAR2
                                   ,EV_cap_code            IN VARCHAR2
                                   ,EV_mes_garantia        IN VARCHAR2
                                   ,EV_num_preguia        IN VARCHAR2
                                   ,EV_num_guia            IN VARCHAR2
                                   ,EV_num_factura        IN VARCHAR2
                                   ,EV_cod_concepto_dto    IN VARCHAR2
                                   ,EV_val_dto            IN VARCHAR2
                                   ,EV_tip_dto            IN VARCHAR2
                                   ,EV_ind_cuota            IN VARCHAR2
                                   ,EV_ind_supertel        IN VARCHAR2
                                   ,EV_ind_manual            IN VARCHAR2
                                   ,EV_pref_plaza            IN VARCHAR2
                                   ,EV_cod_tecnologia        IN VARCHAR2
                                   ,EV_usuario              IN VARCHAR2
                                   ,SN_cod_retorno         OUT NOCOPY ge_errores_pg.CodError
                                   ,SV_mens_retorno        OUT NOCOPY ge_errores_pg.MsgError
                                  ,SN_num_evento          OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_consulta_cliente_PR(EV_codcliente    IN ge_clientes.cod_cliente%TYPE,
                                       SV_numident      OUT NOCOPY ge_clientes.num_ident%TYPE,
                                     SV_tipident      OUT NOCOPY ge_clientes.cod_tipident%TYPE,
                                     SV_nomcliente      OUT NOCOPY ge_clientes.nom_cliente%TYPE,
                                     SN_codcuenta     OUT NOCOPY ge_clientes.cod_cuenta%TYPE,
                                     SV_nomapellido1  OUT NOCOPY ge_clientes.nom_apeclien1%TYPE,
                                     SV_nomapellido2  OUT NOCOPY ge_clientes.nom_apeclien2%TYPE,
                                     SV_fecnaciomien  OUT NOCOPY ge_clientes.fec_nacimien%TYPE,
                                     SV_indestcivil   OUT NOCOPY ge_clientes.ind_estcivil%TYPE,
                                     SV_indsexo          OUT NOCOPY ge_clientes.ind_sexo%TYPE,
                                     SN_codactividad  OUT NOCOPY ge_clientes.cod_actividad%TYPE,
                                     SV_codregion      OUT NOCOPY ge_direcciones.cod_region%TYPE,
                                     SV_codciudad      OUT NOCOPY ge_direcciones.cod_ciudad%TYPE,
                                     SV_codprovincia  OUT NOCOPY ge_direcciones.cod_provincia%TYPE,
                                     SV_codcelda      OUT NOCOPY ge_ciudades.cod_celda%TYPE,
                                     SV_codcalclien   OUT NOCOPY ge_clientes.cod_calclien%TYPE,
                                     SN_indfactur      OUT NOCOPY ge_clientes.ind_factur%TYPE,
                                     SN_codciclo      OUT NOCOPY ge_clientes.cod_ciclo%TYPE,
                                     SN_codempresa    OUT NOCOPY ga_empresa.cod_empresa%TYPE,
                                     SV_coddireccion  OUT NOCOPY VARCHAR2,
                                     SV_codplantarif  OUT NOCOPY VARCHAR2,
                                     SV_CodOperadora  OUT NOCOPY VARCHAR2,
                                      SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);



    /*PROCEDURE VE_busca_evaluacion_riesgo_PR(EV_numident        IN ge_clientes.num_ident%TYPE,
                                             EV_tipident           IN ge_clientes.cod_tipident%TYPE,
                                            EN_tipo_solicitud  IN ert_solicitud.ind_tipo_solicitud%TYPE,
                                            EN_ind_evento       IN ert_solicitud.ind_evento%TYPE,
                                            EV_cod_estado       IN VARCHAR2,
                                            EV_tipocliente     IN VARCHAR2,
                                            SN_lim_credito     OUT NOCOPY ert_datos_consulta_to.lim_credito%TYPE,
                                            SN_monto_garantia  OUT NOCOPY ert_solicitud.mto_garantia%TYPE,
                                            SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);*/

    PROCEDURE VE_busca_eriesgo_ptarif_PR(EV_numident         IN ge_clientes.num_ident%TYPE,
                                          EV_tipident        IN ge_clientes.cod_tipident%TYPE,
                                         EN_tipo_solicitud    IN ERT_SOLICITUD.ind_tipo_solicitud%TYPE,
                                         EN_ind_evento        IN ERT_SOLICITUD.ind_evento%TYPE,
                                         EV_cod_estado        IN VARCHAR2,
                                         EV_plantarif        IN ert_solicitud_planes.cod_plantarif%TYPE,
                                         SN_num_solicitud   OUT NOCOPY ert_solicitud_planes.num_solicitud%TYPE,
                                         SN_cant_terminales    OUT NOCOPY ert_solicitud_planes.val_cant_terminales%TYPE,
                                         SN_cant_vendidos     OUT NOCOPY ert_solicitud_planes.val_cant_vendidos%TYPE,
                                         SN_cod_estado        OUT NOCOPY ERT_SOLICITUD.cod_estado%TYPE,
                                         SN_cod_retorno        OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_consulta_serie_PR(EV_serie           IN  al_series.num_serie%TYPE,
                                    SV_codbodega       OUT NOCOPY al_series.cod_bodega%TYPE,
                                   SV_estadoserie  OUT NOCOPY al_series.cod_estado%TYPE,
                                   SV_indtelefono  OUT NOCOPY al_series.ind_telefono%TYPE,
                                   SV_numcelular   OUT NOCOPY al_series.num_telefono%TYPE,
                                   SV_uso           OUT NOCOPY al_series.cod_uso%TYPE,
                                   SV_tipostock       OUT NOCOPY al_series.tip_stock%TYPE,
                                   SV_codcentral   OUT NOCOPY al_series.cod_central%TYPE,
                                   SN_codarticulo  OUT NOCOPY al_series.cod_articulo%TYPE,
                                   SN_capcode      OUT NOCOPY al_series.cap_code%TYPE,
                                   SN_tiparticulo  OUT NOCOPY al_articulos.tip_articulo%TYPE,
                                   SV_desarticulo  OUT NOCOPY al_articulos.des_articulo%TYPE,
                                      SV_codsubalm    OUT NOCOPY al_series.cod_subalm%TYPE,
                                      SN_indvalorar   OUT NOCOPY al_tipos_stock.ind_valorar%TYPE,
                                   SV_carga        OUT NOCOPY VARCHAR2,
                                   SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE VE_consulta_plan_tarifario_PR(EV_plantarif           IN ta_plantarif.cod_plantarif%TYPE,
                                                EN_codproducto           IN ga_modvent_aplic.cod_producto%TYPE,
                                                EV_tecnologia          IN al_tecnologia.cod_tecnologia%TYPE,
                                                 SV_desplantarif        OUT NOCOPY ta_plantarif.des_plantarif%TYPE,
                                                 SV_tipplantarif        OUT NOCOPY ta_plantarif.tip_plantarif%TYPE,
                                                 SV_codlimconsumo       OUT NOCOPY tol_limite_td.cod_limcons%TYPE,
                                                  SN_numdias             OUT NOCOPY ta_plantarif.num_dias%TYPE,
                                                SV_codplanserv         OUT NOCOPY ga_planserv.cod_planserv%TYPE,
                                                  SN_ind_cargo_habil      OUT NOCOPY ta_plantarif.ind_cargo_habil%TYPE,
                                                 SV_codcargobasico      OUT NOCOPY ta_plantarif.cod_cargobasico%TYPE,
                                                 SV_descargobasico      OUT NOCOPY ta_cargosbasico.des_cargobasico%TYPE,
                                                 SN_importecargo        OUT NOCOPY ta_cargosbasico.imp_cargobasico%TYPE,
                                                 SV_monedacargobasico OUT NOCOPY ta_cargosbasico.cod_moneda%TYPE,
                                                SV_codtiplan            OUT NOCOPY ta_plantarif.cod_tiplan%TYPE,
                                                SN_ind_familiar      OUT NOCOPY ta_plantarif.ind_familiar%TYPE,
                                                SN_num_abonados      OUT NOCOPY ta_plantarif.num_abonados%TYPE,
                                                SV_cod_plan_comverse OUT NOCOPY VARCHAR2,
                                                 SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                                   SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                                   SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_precio_cargo_basico_PR(EV_codproducto     IN VARCHAR2,
                                        EV_codcargo        IN VARCHAR2,
                                        SC_cursordatos       OUT NOCOPY REFCURSOR,
                                        SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_PrecCargoSimcard_PreLis_PR(EN_codarticulo  IN al_precios_venta.cod_articulo%TYPE,
                                            EN_tipstock     IN al_precios_venta.tip_stock%TYPE,
                                            EN_codusoventa  IN al_precios_venta.cod_uso%TYPE,
                                            EN_codestado    IN al_precios_venta.cod_estado%TYPE,
                                            EN_indrecambio  IN al_precios_venta.ind_recambio%TYPE,
                                            EV_codcategoria IN al_precios_venta.cod_categoria%TYPE,
                                            SC_cursordatos    OUT NOCOPY REFCURSOR,
                                             SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                              SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_PrecCargoTerminal_PreLis_PR(EN_codarticulo  IN al_precios_venta.cod_articulo%TYPE,
                                             EN_tipstock     IN al_precios_venta.tip_stock%TYPE,
                                             EN_codusoventa  IN al_precios_venta.cod_uso%TYPE,
                                             EN_codestado    IN al_precios_venta.cod_estado%TYPE,
                                             EN_indrecambio  IN al_precios_venta.ind_recambio%TYPE,
                                             EV_codcategoria IN al_precios_venta.cod_categoria%TYPE,
                                             SC_cursordatos     OUT NOCOPY REFCURSOR,
                                              SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                               SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                              SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);
    PROCEDURE VE_PreCarTerminal_NoPreLis_PR(EN_codarticulo   IN al_precios_venta.cod_articulo%TYPE,
                                                EN_tipstock      IN al_precios_venta.tip_stock%TYPE,
                                                  EN_codusoventa   IN al_precios_venta.cod_uso%TYPE,
                                                EN_codestado     IN al_precios_venta.cod_estado%TYPE,
                                                EN_modventa      IN al_precios_venta.cod_modventa%TYPE,
                                                EV_tipocontrato  IN ga_percontrato.cod_tipcontrato%TYPE,
                                                EV_plantarif     IN ve_catplantarif.cod_plantarif%TYPE,
                                                EN_indrecambio   IN al_precios_venta.ind_recambio%TYPE,
                                                EV_codcategoria  IN al_precios_venta.cod_categoria%TYPE,
                                                  EN_codusoprepago IN al_precios_venta.cod_uso%TYPE,
                                                EV_indequipo     IN al_articulos.ind_equiacc%TYPE,
                                                SC_cursordatos   OUT NOCOPY REFCURSOR,
                                                 SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                                  SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                                 SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_precio_cargo_servsupl_PR(EV_codproducto     IN VARCHAR2,
                                          EV_codservicio     IN VARCHAR2,
                                          EV_codplanserv     IN VARCHAR2,
                                          EV_codactuacion     IN VARCHAR2,
                                          SC_cursordatos     OUT NOCOPY REFCURSOR,
                                           SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                           SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_consulta_categ_ptarif_PR(EV_plantarif       IN ta_plantarif.cod_plantarif%TYPE,
                                          SV_codcategoria    OUT NOCOPY ve_catplantarif.cod_categoria%TYPE,
                                          SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                             SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_obtiene_parametro_fact_PR(EV_nomparametro   IN ged_parametros.nom_parametro%TYPE,
                                           SV_valparametro   OUT NOCOPY ged_parametros.val_parametro%TYPE,
                                            SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                              SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                              SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_obtiene_codpromedio_fact_PR(EN_valpromfact   IN al_promfact.fact_desde%TYPE,
                                             SN_codpromedio   OUT NOCOPY al_promfact.cod_promedio%TYPE,
                                              SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                                SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                                SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_promfacturadocliente_PR(EN_indciclo       IN fa_tipdocumen.ind_ciclo%TYPE,
                                         EN_numeromeses    IN NUMBER,
                                         EN_codcliente     IN fa_histdocu.cod_cliente%TYPE,
                                         SN_totalfacturado OUT NOCOPY NUMBER,
                                          SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);


    PROCEDURE VE_valida_codigo_vendedor_PR ( EN_cod_vendedor IN  ve_vendedores.cod_vendedor%TYPE,
                                              SN_resultado    OUT NOCOPY PLS_INTEGER,
                                                  SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                   SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_consulta_ciclo_fact_PR(EN_cod_ciclo    IN  ge_clientes.cod_ciclo%TYPE,
                                        SN_cod_ciclfact OUT NOCOPY fa_ciclfact.cod_ciclfact%TYPE,
                                            SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);



											 

    PROCEDURE VE_obtiene_formas_pago_PR ( EV_cod_orden    IN  ged_parametros.cod_producto%TYPE,
                                            EV_planfreedom      IN VARCHAR,
                                          EV_cattribcliente      IN VARCHAR,
                                          SC_cursordatos  OUT NOCOPY REFCURSOR,
                                             SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);



    PROCEDURE VE_obtiene_descuento_art_PR(EV_cod_operacion     IN  gad_descuentos.cod_operacion%TYPE,
                                             EV_tip_contactual    IN  gad_descuentos.tip_contrato_actual%TYPE,
                                          EN_num_mesesactual   IN  gad_descuentos.num_meses_actual%TYPE,
                                          EV_cod_antiguedad    IN  gad_descuentos.cod_antiguedad%TYPE,
                                          EN_cod_promediofact  IN  gad_descuentos.cod_promfact%TYPE,
                                          EV_cod_estadodev       IN  gad_descuentos.cod_estado_dev%TYPE,
                                          EV_cod_tipcontnuevo  IN  gad_descuentos.cod_tipcontrato_nuevo%TYPE,
                                          EN_num_mesesnuevo       IN  gad_descuentos.num_meses_nuevo%TYPE,
                                          EN_cod_articulo      IN  gad_descuentos.cod_articulo%TYPE,
                                          EV_clase_descuento   IN  gad_descuentos.clase_descuento%TYPE,
                                          SC_cursordatos       OUT NOCOPY REFCURSOR,
                                           SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);




    PROCEDURE VE_obtiene_descuento_con_PR(EV_cod_operacion     IN  gad_descuentos.cod_operacion%TYPE,
                                                    EV_cod_antiguedad      IN  gad_descuentos.cod_antiguedad%TYPE,
                                                 EV_cod_tipcontnuevo  IN  gad_descuentos.cod_tipcontrato_nuevo%TYPE,
                                                 EN_num_mesesnuevo      IN  gad_descuentos.num_meses_nuevo%TYPE,
                                                 EN_ind_vtaexterna      IN  gad_descuentos.ind_vta_externa%TYPE,
                                                 EN_cod_vendealer      IN  gad_descuentos.cod_vendealer%TYPE,
                                                 EV_cod_causadscto      IN  gad_descuentos.cod_causa_dscto%TYPE,
                                                 EV_cod_categoria      IN  gad_descuentos.cod_categoria%TYPE,
                                                 EN_cod_modventa      IN  gad_descuentos.cod_modventa%TYPE,
                                                 EN_tip_producto      IN  gad_descuentos.tip_producto%TYPE,
                                                 EN_cod_concepto      IN  gad_descuentos.cod_concepto%TYPE,
                                                 EV_clase_descuento   IN  gad_descuentos.clase_descuento%TYPE,
                                                 EN_IND_RENOVA        IN  gad_descuentos.IND_RENOVA%TYPE,
                                                 EV_NUMABONADO        IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                                 SC_cursordatos          OUT NOCOPY REFCURSOR,
                                                  SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                                   SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                                  SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_precio_cargo_servocac_PR(EV_codproducto     IN VARCHAR2,
                                            EV_codarticulo     IN VARCHAR2,
                                            EV_codplantarif     IN VARCHAR2,
                                            EV_codusolinea     IN VARCHAR2,
                                            EV_codmodventa     IN VARCHAR2,
                                            EV_nummeses         IN VARCHAR2,
                                            EV_tipstock        IN VARCHAR2,
                                          EV_indcomodato     IN VARCHAR2,
                                          EV_codactuacion     IN VARCHAR2,
                                          SC_cursordatos     OUT NOCOPY REFCURSOR,
                                           SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);



    PROCEDURE VE_obtiene_cat_trib_cliente_PR ( EN_cod_cliente  IN ga_catributclie.cod_cliente%TYPE,
                                                 SV_cat_trib_cliente OUT NOCOPY VARCHAR,
                                               SN_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                                                SV_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                                               SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);



    PROCEDURE VE_hay_pfreedom_en_venta_PR (  EV_ind_proporvta IN VARCHAR,
                                                 EN_num_venta IN  NUMBER,
                                                  EN_ind_proporc1 IN NUMBER,
                                              EN_ind_proporc2 IN NUMBER,
                                               SN_resultado    OUT NOCOPY PLS_INTEGER,
                                                   SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                    SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                  SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_consulta_cod_desc_manual_PR(EN_cod_conceptocargo    IN  fa_conceptos.cod_concorig%TYPE,
                                             EN_cod_tipconce         IN  fa_conceptos.cod_tipconce%TYPE,
                                              SN_cod_conceptodcto     OUT NOCOPY fa_conceptos.cod_concepto%TYPE,
                                                 SN_cod_retorno          OUT NOCOPY ge_errores_pg.CodError,
                                              SV_mens_retorno         OUT NOCOPY ge_errores_pg.MsgError,
                                                SN_num_evento           OUT NOCOPY ge_errores_pg.Evento);



    PROCEDURE VE_es_vendedor_externo_PR (    EN_cod_vendedor IN ve_vendedores.cod_vendedor%TYPE,
                                             SN_resultado    OUT NOCOPY PLS_INTEGER,
                                                 SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                               SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                  SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_obtiene_modo_gener_fact_PR(EV_cod_oficina    IN  al_docum_sucursal.cod_oficina%TYPE,
                                            EV_cod_tip_docum  IN  al_docum_sucursal.cod_tipdocum%TYPE,
                                            EV_factura_global IN  VARCHAR2,
                                            EN_documento_guia IN  ge_tipdocumen.cod_tipdocum%TYPE,
                                            EV_tip_foliacion  IN  ge_tipdocumen.tip_foliacion%TYPE,
                                            EN_cod_tipmovimen IN  fa_gencentremi.cod_tipmovimien%TYPE,
                                            EV_cod_cattribut  IN  fa_gencentremi.cod_catribut%TYPE,
                                            EV_flagcentremi   IN  VARCHAR2,
                                            EN_cod_modventa   IN  fa_gencentremi.cod_modventa%TYPE,
                                            SV_cod_modgener   OUT NOCOPY fa_gencentremi.cod_modgener%TYPE,
                                            SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);


    PROCEDURE VE_in_ga_preliquidacion_PR(EV_numventa       IN ga_preliquidacion.num_venta%TYPE,
                                         EV_codvendealer   IN ga_preliquidacion.cod_dealer%TYPE,
                                         EV_codmaster      IN ga_preliquidacion.cod_master_dealer%TYPE,
                                         EV_codcliente     IN ga_preliquidacion.cod_cliente%TYPE,
                                         EV_codmodvta      IN ga_preliquidacion.cod_modventa%TYPE,
                                         EV_cod_programa   IN ge_programas.cod_programa%TYPE,
                                         SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento     OUT NOCOPY ge_errores_pg.Evento );


    PROCEDURE VE_in_ga_det_preliq_PR(EN_numventa             IN ga_preliquidacion.num_venta%TYPE,
                                       EN_numitem              IN ga_det_preliq.num_item%TYPE,
                                       EN_numabonado          IN ga_det_preliq.num_abonado%TYPE,
                                     EN_numcelular          IN ga_det_preliq.num_celular%TYPE,
                                     EV_numserie          IN ga_det_preliq.num_serie_orig%TYPE,
                                     EN_impcargo          IN ga_det_preliq.imp_cargo%TYPE,
                                     EN_impcargofinal      IN ga_det_preliq.imp_cargo_final%TYPE,
                                     EN_codarticulo          IN ga_det_preliq.cod_articulo%TYPE,
                                     EN_tipdcto              IN ga_det_preliq.tip_dto%TYPE,
                                     EN_valdcto              IN ga_det_preliq.val_dto%TYPE,
                                     SN_cod_retorno          OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno         OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento           OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_actualiza_facturacion_PR( EV_cod_estadoc         IN VARCHAR2
                                            ,EV_cod_estproc           IN VARCHAR2
                                          ,EV_cod_catribdoc       IN VARCHAR2
                                           ,EV_num_folio               IN VARCHAR2
                                            ,EV_pref_plaza           IN VARCHAR2
                                            ,EV_fec_vencimiento      IN VARCHAR2
                                            ,EV_nom_usuaelim           IN VARCHAR2
                                            ,EV_cod_causaelim           IN VARCHAR2
                                            ,EV_num_proceso           IN VARCHAR2
                                            ,EV_num_venta               IN VARCHAR2
                                            ,SN_cod_retorno           OUT NOCOPY ge_errores_pg.CodError
                                            ,SV_mens_retorno          OUT NOCOPY ge_errores_pg.MsgError
                                           ,SN_num_evento            OUT NOCOPY ge_errores_pg.Evento);


    PROCEDURE VE_obtiene_articulos_consig_PR ( EN_num_venta IN  ga_abocel.num_venta%TYPE,
                                                 SC_cursordatos  OUT NOCOPY REFCURSOR,
                                                    SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                   SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                      SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_crea_movimiento_central_PR(EN_num_movimiento    IN icc_movimiento.num_movimiento%TYPE,
                                                 EN_num_abonado         IN icc_movimiento.num_abonado%TYPE,
                                               EN_cod_estado        IN icc_movimiento.cod_estado%TYPE,
                                               EV_cod_actabo        IN icc_movimiento.cod_actabo%TYPE,
                                               EV_cod_modulo        IN icc_movimiento.cod_modulo%TYPE,
                                                EN_cod_actuacion         IN icc_movimiento.cod_actuacion%TYPE,
                                               EN_nom_usuarora      IN icc_movimiento.nom_usuarora%TYPE,
                                               ED_fec_ingreso       IN icc_movimiento.fec_ingreso%TYPE,
                                                 EV_tip_terminal      IN icc_movimiento.tip_terminal%TYPE,
                                               EN_cod_central       IN icc_movimiento.cod_central%TYPE,
                                               EN_num_celular       IN icc_movimiento.num_celular%TYPE,
                                                 EV_num_serie           IN icc_movimiento.num_serie%TYPE,
                                                 EV_cod_servicios         IN icc_movimiento.cod_servicios%TYPE,
                                                 EV_num_min           IN icc_movimiento.num_min%TYPE,
                                                 EV_tip_tecnologia    IN icc_movimiento.tip_tecnologia%TYPE,
                                               EV_imsi              IN icc_movimiento.imsi%TYPE,
                                               EV_imei              IN icc_movimiento.imei%TYPE,
                                               EV_icc               IN icc_movimiento.icc%TYPE,
                                               EN_num_movtoant      IN icc_movimiento.num_movimiento%TYPE,
                                               EV_plan              IN VARCHAR2,
                                               EV_valorPlan         IN VARCHAR2,
                                               EV_carga             IN VARCHAR2,
                                               SN_cod_retorno         OUT NOCOPY ge_errores_pg.CodError,
                                                 SV_mens_retorno        OUT NOCOPY ge_errores_pg.MsgError,
                                                SN_num_evento          OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_obtiene_ind_telefono_PR(EV_serie         IN  al_series.num_serie%TYPE,
                                          EV_parametro     OUT NOCOPY VARCHAR2,
                                         SN_indtelefono  OUT NOCOPY al_series.ind_telefono%TYPE,
                                         SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_obtiene_actua_central_PR(EV_codactabo     IN ga_actabo.cod_actabo%TYPE,
                                          EN_codproducto   IN ga_actabo.cod_producto%TYPE,
                                          EV_codtecnologia IN ga_actabo.cod_actabo%TYPE,
                                          SV_codactcen     OUT NOCOPY ga_actabo.cod_actcen%TYPE,
                                          SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                             SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_obtiene_codigo_sistema_PR(EN_codproducto   IN icg_central.cod_producto%TYPE,
                                           EN_codcentral    IN icg_central.cod_central%TYPE,
                                           SN_codsistema    OUT NOCOPY icg_central.cod_sistema%TYPE,
                                           SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                              SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                              SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_obtiene_central_PR(EN_codproducto   IN icg_central.cod_producto%TYPE,
                                    EN_codcentral    IN icg_central.cod_central%TYPE,
                                    SV_codtecnologia OUT NOCOPY icg_central.cod_tecnologia%TYPE,
                                    SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_up_ga_preliquidacion_PR(EV_numventa             IN ga_preliquidacion.num_venta%TYPE,
                                         SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento     OUT NOCOPY ge_errores_pg.Evento );

    PROCEDURE VE_actualiza_equipaboser_PR(EV_NumMovimiento IN VARCHAR2,
                                          EV_TipStock       IN VARCHAR2,
                                          EV_BodegaAct       IN VARCHAR2,
                                          EV_TipStockOrig  IN VARCHAR2,
                                          EV_CodBodega       IN VARCHAR2,
                                          EV_CodArticulo   IN VARCHAR2,
                                          EV_CodUso           IN VARCHAR2,
                                          EV_CodEstado       IN VARCHAR2,
                                          EV_Numserie       IN VARCHAR2,
                                          EV_NumAbonado       IN VARCHAR2,
                                          SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_obtiene_equipos_seriados_PR(EV_numAbonado     IN  VARCHAR2,
                                               EV_indProcedencia IN  VARCHAR2,
                                               SC_cursordatos    OUT NOCOPY REFCURSOR,
                                                SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);

     PROCEDURE VE_consulta_estant_serie_PR(EV_serie          IN  al_series.num_serie%TYPE,
                                             SN_codestado    OUT NOCOPY al_series.cod_estado%TYPE,
                                          SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                             SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_ins_abo_garantia_PR(EN_num_venta      IN ga_abonado_garantia.num_venta%TYPE,
                                       EN_cod_cliente       IN ga_abonado_garantia.cod_cliente%TYPE,
                                      EN_num_abonado    IN ga_abonado_garantia.num_abonado%TYPE,
                                     EN_mto_garantia   IN ga_abonado_garantia.mto_garantia%TYPE,
                                       EN_ind_pago       IN ga_abonado_garantia.ind_pago%TYPE,
                                       SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_inserta_contrato_PR(EN_cod_cuenta      IN ga_contcta.cod_cuenta%TYPE,
                                     EN_cod_producto    IN ga_contcta.cod_producto%TYPE,
                                     EV_cod_tipcontrato IN ga_contcta.cod_tipcontrato%TYPE,
                                     EV_num_contrato    IN ga_contcta.num_contrato%TYPE,
                                     EV_num_anexo       IN ga_contcta.num_anexo%TYPE,
                                     EN_num_meses       IN ga_contcta.num_meses%TYPE,
                                     EN_num_venta       IN ga_contcta.num_venta%TYPE,
                                     EN_num_abonados    IN ga_contcta.num_abonados%TYPE,
                                       SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_con_max_anexo_contrato_PR(EN_cod_cuenta      IN  ga_contcta.cod_cuenta%TYPE,
                                           EN_cod_producto    IN  ga_contcta.cod_producto%TYPE,
                                           EV_cod_tipcontrato IN  ga_contcta.cod_tipcontrato%TYPE,
                                           EV_num_contrato    IN  ga_contcta.num_contrato%TYPE,
                                           SN_max_anexo       OUT NUMBER,
                                           SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                           SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_con_rango_descto_vend_PR(EN_cod_vendedor    IN  ve_vendperfil.cod_vendedor%TYPE,
                                          SN_pnt_dto_inf     OUT NOCOPY ga_perfilcargos.pnt_dto_inf%TYPE,
                                          SN_pnt_dto_sup     OUT NOCOPY ga_perfilcargos.pnt_dto_sup%TYPE,
                                          SN_prc_dto_inf     OUT NOCOPY ga_perfilcargos.prc_dto_inf%TYPE,
                                          SN_prc_dto_sup     OUT NOCOPY ga_perfilcargos.prc_dto_sup%TYPE,
                                          SN_ind_moddtos     OUT NOCOPY ga_perfilcargos.ind_moddtos%TYPE,
                                          SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_ins_sol_autorizacion_PR(EN_num_venta        IN  ga_autoriza.num_venta%TYPE,
                                         EN_lin_autoriza     IN  ga_autoriza.lin_autoriza%TYPE,
                                         EV_cod_oficina      IN  ga_autoriza.cod_oficina%TYPE,
                                          EV_cod_estado       IN  ga_autoriza.cod_estado%TYPE,
                                         EN_num_autoriza     IN  ga_autoriza.num_autoriza%TYPE,
                                         EN_cod_vendedor     IN  ga_autoriza.cod_vendedor%TYPE,
                                         EN_num_unidades     IN  ga_autoriza.num_unidades%TYPE,
                                         EN_prc_origin       IN  ga_autoriza.prc_origin%TYPE,
                                         EN_ind_tipventa     IN  ga_autoriza.ind_tipventa%TYPE,
                                         EN_cod_cliente      IN  ga_autoriza.cod_cliente%TYPE,
                                         EN_cod_modventa     IN  ga_autoriza.cod_modventa%TYPE,
                                         EV_nom_usuar_vta    IN  ga_autoriza.nom_usuar_vta%TYPE,
                                         EN_cod_concepto     IN  ga_autoriza.cod_concepto%TYPE,
                                         EN_imp_cargo        IN  ga_autoriza.imp_cargo%TYPE,
                                         EV_cod_moneda       IN  ga_autoriza.cod_moneda%TYPE,
                                         EN_num_abonado      IN  ga_autoriza.num_abonado%TYPE,
                                         EV_num_serie        IN  ga_autoriza.num_serie%TYPE,
                                         EN_cod_concepto_dto IN  ga_autoriza.cod_concepto_dto%TYPE,
                                         EN_val_dto          IN  ga_autoriza.val_dto%TYPE,
                                         EN_tip_dto          IN  ga_autoriza.tip_dto%TYPE,
                                         EN_ind_modifi       IN  ga_autoriza.ind_modifi%TYPE,
                                         EV_origen           IN  ga_autoriza.origen%TYPE,
                                         SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                         SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_con_sol_autorizacion_PR(EN_num_autoriza     IN  ga_autoriza.num_autoriza%TYPE,
                                         SV_cod_estado       OUT NOCOPY ga_autoriza.cod_estado%TYPE,
                                         SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                         SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_con_modalidadpago_PR (EN_cod_modventa  IN  ge_modventa.cod_modventa%TYPE,
                                       SV_des_modventa  OUT ge_modventa.des_modventa%TYPE,
                                       SN_indcuotas     OUT NOCOPY ge_modventa.ind_cuotas%TYPE,
                                       SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_con_tipocontrato_PR (EN_cod_producto    IN  NUMBER,
                                      EV_cod_tipcontrato IN  ga_tipcontrato.cod_tipcontrato%TYPE,
                                      SV_des_tipcontrato OUT NOCOPY ga_tipcontrato.des_tipcontrato%TYPE,
                                      SN_ind_comodato    OUT NOCOPY ga_tipcontrato.ind_comodato%TYPE,
                                      SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_con_producto_PR (EN_cod_producto  IN  ge_productos.cod_producto%TYPE,
                                  SV_des_producto  OUT NOCOPY ge_productos.des_producto%TYPE,
                                  SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                  SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                  SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_updAbocelClaseServ_PR(EN_numAbonado    IN ga_abocel.num_abonado%TYPE,
                                       EV_claseServ     IN ga_abocel.clase_servicio%TYPE,
                                       SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_updEquipAboser_PR(EV_numAbonado    IN VARCHAR2,
                                   EV_numSerie      IN VARCHAR2,
                                   EV_fecAlta       IN VARCHAR2,
                                   EV_numMOvto      IN VARCHAR2,
                                   SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_insReservaArticulo_PR(EV_num_linea     IN VARCHAR2,
                                       EV_num_orden     IN VARCHAR2,
                                       EV_cod_articulo  IN VARCHAR2,
                                       EV_cod_producto  IN VARCHAR2,
                                       EV_cod_bodega    IN VARCHAR2,
                                       EV_tip_stock     IN VARCHAR2,
                                       EV_cod_uso       IN VARCHAR2,
                                       EV_cod_estado    IN VARCHAR2,
                                       EV_nom_usuario   IN VARCHAR2,
                                       EV_num_serie     IN VARCHAR2,
                                       SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_ActualizaStock_PR (EV_TipMov        IN VARCHAR2,
                                    EV_TipStock         IN VARCHAR2,
                                    EV_CodBodega     IN VARCHAR2,
                                    EV_CodArticulo     IN VARCHAR2,
                                    EV_CodUso         IN VARCHAR2,
                                    EV_CodEstado     IN VARCHAR2,
                                    EV_NumVenta         IN VARCHAR2,
                                    EV_Numserie         IN VARCHAR2,
                                    SV_numMovto      OUT NOCOPY VARCHAR2,
                                    SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_getListPlanTarifario_PR(EV_indComercial  IN NUMBER,
                                          SC_cursorDatos   OUT NOCOPY REFCURSOR,
                                          SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_getEmpresaCte_PR(EV_codCliente    IN VARCHAR2,
                                  SV_numAbonados   OUT NOCOPY VARCHAR2,
                                  SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                  SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                  SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_updEmpresaAbonados_PR(EV_codCliente    IN VARCHAR2,
                                       EV_cantidad      IN VARCHAR2,
                                       SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_updAbocelCodSituac_PR(EN_numVenta      IN VARCHAR2,
                                       EV_codSituacion  IN VARCHAR2,
                                       SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_validaHomeVendCel_PR (EN_codVendedor  IN  VARCHAR2,
                                       EV_numCelular   IN  VARCHAR2,
                                       SN_resultado    OUT NOCOPY NUMBER,
                                         SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_num_abonados_cliente_PR(EV_cod_cliente   IN  VARCHAR2,
                                           EV_cod_plantarif IN  VARCHAR2,
                                         SN_resultado     OUT NOCOPY NUMBER,
                                           SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                         SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_Cambia_modalidad_PR(EN_NUM_SERIE            IN  AL_SERIES.NUM_SERIE%TYPE,
                                       EN_CANAL                IN  VARCHAR2,
                                     EN_COD_MODVENTA_ORIGEN  IN  GE_MODVENTA.COD_MODVENTA%TYPE,
                                     SN_MODVENTA             OUT GE_MODVENTA.COD_MODVENTA%TYPE,
                                     SN_DESMODVENTA          OUT GE_MODVENTA.DES_MODVENTA%TYPE,
                                     SN_cod_retorno          OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno         OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento           OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_ObtieneComisPorCodVendedor(SO_TipComis IN OUT VE_TIPOS_PG.TIP_VE_TIPCOMIS,
                                         EN_cod_vendedor IN  ve_vendedores.cod_vendedor%TYPE,
                                         SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);



    PROCEDURE VE_datosvendedor_PR (EN_codvendedor   IN  ve_vendedores.cod_vendedor%TYPE,
                                   EN_coddealer     IN  ve_vendealer.cod_vendealer%TYPE,
                                   SV_nomvendedor   OUT NOCOPY ve_vendedores.nom_vendedor%TYPE,
                                   SV_nomvendealer  OUT NOCOPY ve_vendealer.nom_vendealer%TYPE,
                                   SN_codcliente    OUT NOCOPY ve_vendedores.cod_cliente%TYPE,
                                   SN_codvende_raiz OUT NOCOPY ve_vendedores.cod_vende_raiz%TYPE,
                                   SV_codregion     OUT NOCOPY ge_direcciones.cod_region%TYPE,
                                   SV_codprovincia  OUT NOCOPY ge_direcciones.cod_provincia%TYPE,
                                   SV_codciudad     OUT NOCOPY ge_direcciones.cod_ciudad%TYPE,
                                   SV_codoficina    OUT NOCOPY ve_vendedores.cod_oficina%TYPE,
                                   SV_codtipcomis   OUT NOCOPY ve_tipcomis.cod_tipcomis%TYPE,
                                   SV_destipcomis   OUT NOCOPY ve_tipcomis.des_tipcomis%TYPE,
                                   SN_indtipventa   OUT NOCOPY ve_vendedores.ind_tipventa%TYPE,
                                   SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_inserta_ga_docventa_PR(EN_NUM_VENTA    IN GA_DOCVENTA.NUM_VENTA%TYPE,
                                        EN_COD_TIPDOCUM IN GA_DOCVENTA.COD_TIPDOCUM%TYPE,
                                        EV_NUM_FOLIO    IN GA_DOCVENTA.NUM_FOLIO%TYPE,
                                          SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_inserta_al_PetiGiasAbo_PR( EN_cod_articulo IN al_petiguias_abo.cod_articulo%TYPE,
                                            EN_cod_bodega   IN al_petiguias_abo.cod_bodega%TYPE,
                                            EN_cod_cliente  IN al_petiguias_abo.cod_cliente%TYPE,
                                            EN_cod_concepto IN al_petiguias_abo.cod_concepto%TYPE,
                                            EV_cod_moneda   IN al_petiguias_abo.cod_moneda%TYPE,
                                            EV_cod_oficina  IN al_petiguias_abo.cod_oficina%TYPE,
                                            EN_num_abonado  IN al_petiguias_abo.num_abonado%TYPE,
                                            EN_num_cantidad IN al_petiguias_abo.num_cantidad%TYPE,
                                            EN_num_cargo    IN al_petiguias_abo.num_cargo%TYPE,
                                            EN_num_orden    IN al_petiguias_abo.num_orden%TYPE,
                                            EN_num_peticion IN al_petiguias_abo.num_peticion%TYPE,
                                            EV_num_serie    IN al_petiguias_abo.num_serie%TYPE,
                                            EN_num_telefono IN al_petiguias_abo.num_telefono%TYPE,
                                            EN_num_venta    IN al_petiguias_abo.num_venta%TYPE,
                                            EN_val_linea    IN al_petiguias_abo.val_linea%TYPE,
                                              SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                              SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
    PROCEDURE VE_eliminarescel_PR (EN_num_venta     IN  ga_ventas.num_venta%TYPE,
                                   EN_num_transac   IN  ga_resnumcel.num_transaccion%TYPE,
                                     SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE VE_PreCarSimcard_NoPreLis_PR(EN_codarticulo   IN al_precios_venta.cod_articulo%TYPE,
                                                EN_tipstock      IN al_precios_venta.tip_stock%TYPE,
                                                  EN_codusoventa   IN al_precios_venta.cod_uso%TYPE,
                                                EN_codestado     IN al_precios_venta.cod_estado%TYPE,
                                                EN_modventa      IN al_precios_venta.cod_modventa%TYPE,
                                                EV_tipocontrato  IN ga_percontrato.cod_tipcontrato%TYPE,
                                                EV_plantarif     IN ve_catplantarif.cod_plantarif%TYPE,
                                                EN_indrecambio   IN al_precios_venta.ind_recambio%TYPE,
                                                EV_codcategoria  IN al_precios_venta.cod_categoria%TYPE,
                                                  EN_codusoprepago IN al_precios_venta.cod_uso%TYPE,
                                                EV_indequipo     IN al_articulos.ind_equiacc%TYPE,
                                                SC_cursordatos   OUT NOCOPY REFCURSOR,
                                                 SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                                  SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                                 SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE PV_PreCarTerminal_NoPreLis_PR(EN_numabonado    IN ga_abocel.num_abonado%TYPE,
                                          EN_codarticulo   IN al_precios_venta.cod_articulo%TYPE,
                                        EN_tipstock      IN al_precios_venta.tip_stock%TYPE,
                                        EN_codusoventa   IN al_precios_venta.cod_uso%TYPE,
                                        EN_codestado     IN al_precios_venta.cod_estado%TYPE,
                                        EN_modventa      IN al_precios_venta.cod_modventa%TYPE,
                                        EV_tipocontrato  IN ga_percontrato.cod_tipcontrato%TYPE,
                                        EV_plantarif     IN ve_catplantarif.cod_plantarif%TYPE,
                                        SC_cursordatos   OUT NOCOPY REFCURSOR,
                                        SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                         SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

/*------------------------------------------------------------------------------------------------------------------------------------------------------*/

PROCEDURE PV_PrecCargTermren_NoPreLis_PR(EN_codarticulo   IN al_precios_venta.cod_articulo%TYPE,
                                            EN_tipstock      IN al_precios_venta.tip_stock%TYPE,
                                              EN_codusoventa   IN al_precios_venta.cod_uso%TYPE,
                                            EN_codestado     IN al_precios_venta.cod_estado%TYPE,
                                            EN_modventa      IN al_precios_venta.cod_modventa%TYPE,
                                            EV_tipocontrato  IN ga_percontrato.cod_tipcontrato%TYPE,
                                            EV_plantarif     IN ve_catplantarif.cod_plantarif%TYPE,
                                            EN_indrecambio   IN al_precios_venta.ind_recambio%TYPE,
                                            EV_codcategoria  IN al_precios_venta.cod_categoria%TYPE,
                                              EN_codusoprepago IN al_precios_venta.cod_uso%TYPE,
                                            EV_indequipo     IN al_articulos.ind_equiacc%TYPE,
                                            EV_numabonado    IN ga_Abocel.num_abonado%TYPE,
                                            SC_cursordatos   OUT NOCOPY REFCURSOR,
                                             SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                              SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE VE_obtiene_VtasVendedor_PR (EN_codVendedor  IN GA_VENTAS.COD_VENDEDOR%TYPE,
                                          EN_numVenta     IN GA_VENTAS.NUM_VENTA%TYPE,
                                          EV_codOficina   IN GA_VENTAS.COD_OFICINA%TYPE,
                                          EV_fecDesde     IN VARCHAR2,
                                          EV_fecHasta     IN VARCHAR2,
                                          SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                            SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE VE_getListVendedores_PR (EV_cod_oficina   IN  VARCHAR2,
                                       SC_cursorDatos   OUT NOCOPY REFCURSOR,
                                       SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE VE_getListVendedores_PR (EV_cod_oficina   IN  VARCHAR2,
                                       EV_cod_tipcomis  IN  VARCHAR2,
                                       SC_cursorDatos   OUT NOCOPY REFCURSOR,
                                       SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);



PROCEDURE VE_getListVendDealer_PR (EV_cod_vendedor  IN  VARCHAR2,
                                   SC_cursorDatos   OUT NOCOPY REFCURSOR,
                                   SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE VE_insSeguroAbonado_PR  (EN_NUM_ABONADO   IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                       EV_COD_SEGURO    IN GA_TIPOSEGURO_TD.COD_SEGURO%TYPE,
                                       EV_NUM_EVENTOS   IN GA_SEGUROABONADO_TO.NUM_EVENTOS%TYPE,
                                       EN_IMPORTE_EQUPO IN GA_SEGUROABONADO_TO.IMPORTE_EQUIPO%TYPE,
                                       EV_NOM_USUARORA  IN GA_SEGUROABONADO_TO.NOM_USUARORA%TYPE,
                                       ED_FEC_FINCONTRATO  IN GA_SEGUROABONADO_TO.FEC_FINCONTRATO%TYPE,
                                       SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE VE_ValidaPlanCompartido_PR (EN_COD_CLIENTE   IN GE_CLIENTES.COD_CLIENTE%TYPE,
                                      EV_COD_PLANTARIF IN TA_PLANTARIF.COD_PLANTARIF%TYPE,
                                      SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE VE_ObtieneDatosPrestacion_PR (EV_COD_PRESTACION   IN         GE_PRESTACIONES_TD.COD_PRESTACION%TYPE,
                                        SV_DES_PRESTACION   OUT NOCOPY GE_PRESTACIONES_TD.COD_PRESTACION%TYPE,
                                        SV_GRP_PRESTACION   OUT NOCOPY GE_PRESTACIONES_TD.GRP_PRESTACION%TYPE,
                                        SN_IND_ACTIVO       OUT NOCOPY GE_PRESTACIONES_TD.IND_ACTIVO%TYPE,
                                        SN_TIP_VENTA        OUT NOCOPY GE_PRESTACIONES_TD.TIP_VENTA%TYPE,
                                        SV_TIP_RED          OUT NOCOPY GE_PRESTACIONES_TD.TIP_RED%TYPE,
                                        SN_IND_NUMERO       OUT NOCOPY GE_PRESTACIONES_TD.IND_NUMERO%TYPE,
                                        SN_DIR_INTALACION   OUT NOCOPY GE_PRESTACIONES_TD.IND_DIR_INSTALACION%TYPE,
                                        SN_IND_INVENTARIO   OUT NOCOPY GE_PRESTACIONES_TD.IND_INVENTARIO_FIJO%TYPE,
                                        SN_IND_SS_INTERNET  OUT NOCOPY GE_PRESTACIONES_TD.IND_SS_INTERNET%TYPE,
                                        SV_COD_PLANTARIF    OUT NOCOPY GE_PRESTACIONES_TD.COD_PLANTARIF_DEFECTO%TYPE,
                                        SN_COD_CENTRAL      OUT NOCOPY GE_PRESTACIONES_TD.COD_CENTRAL_DEFECTO%TYPE,
                                        SN_COD_CELDA        OUT NOCOPY GE_PRESTACIONES_TD.COD_CELDA_DEFECTO%TYPE,
                                        SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE VE_ObtieneDirOficina_PR    (EV_COD_OFICINA      IN         GE_OFICINAS.COD_OFICINA%TYPE,
                                      SV_COD_REGION       OUT NOCOPY GE_REGIONES.COD_REGION%TYPE,
                                      SV_COD_PROVINCIA    OUT NOCOPY GE_PROVINCIAS.COD_PROVINCIA%TYPE,
                                      SV_COD_CIUDAD       OUT NOCOPY GE_CIUDADES.COD_CIUDAD%TYPE,
                                      SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                         SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);


PROCEDURE PV_PreCarSimcard_NoPreLis_PR(EN_numabonado    IN ga_abocel.num_abonado%TYPE,
                                         EN_codarticulo   IN al_precios_venta.cod_articulo%TYPE,
                                       EN_tipstock      IN al_precios_venta.tip_stock%TYPE,
                                       EN_codusoventa   IN al_precios_venta.cod_uso%TYPE,
                                       EN_codestado     IN al_precios_venta.cod_estado%TYPE,
                                       EN_modventa      IN al_precios_venta.cod_modventa%TYPE,
                                       EV_tipocontrato  IN ga_percontrato.cod_tipcontrato%TYPE,
                                       EV_plantarif     IN ve_catplantarif.cod_plantarif%TYPE,
                                       EN_indrecambio   IN al_precios_venta.ind_recambio%TYPE,
                                       EV_codcategoria  IN al_precios_venta.cod_categoria%TYPE,
                                       EN_codusoprepago IN al_precios_venta.cod_uso%TYPE,
                                       EV_indequipo     IN al_articulos.ind_equiacc%TYPE,
                                       EN_IND_RENOVA    IN al_precios_venta.IND_RENOVA%TYPE,
                                       SC_cursordatos   OUT NOCOPY REFCURSOR,
                                       SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE PV_DETALLE_DOC_PR(       EN_codVendedor  IN GA_VENTAS.COD_VENDEDOR%TYPE,
                                       EN_numVenta     IN GA_VENTAS.NUM_VENTA%TYPE,
                                       EV_codOficina   IN GA_VENTAS.COD_OFICINA%TYPE,
                                       EV_fecDesde     IN VARCHAR2,
                                       EV_fecHasta     IN VARCHAR2,
                                       EN_COD_CLIENTE  IN GE_CLIENTES.COD_CLIENTE%TYPE,
                                       EV_IND_ESTVENTA IN GA_VENTAS.IND_ESTVENTA%TYPE,
                                       EV_ORIGEN       IN VARCHAR2,
                                       SC_cursorDatos  OUT NOCOPY REFCURSOR
                                       );
PROCEDURE PV_actualizaLimcons_PR           (EN_NUM_ABONADO      IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                            EN_COD_CLIENTE      IN GE_CLIENTES.COD_CLIENTE%TYPE,
                                            EN_COD_LIMCONS      IN GA_LIMITE_CLIABO_TO.COD_LIMCONS%TYPE,
                                            ED_FEC_DESDE        IN GA_LIMITE_CLIABO_TO.FEC_DESDE%TYPE,
                                            SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE PV_obtieneDatosPlanTarif_PR (EV_COD_PLANTARIF    IN TA_PLANTARIF.COD_PLANTARIF%TYPE,
                                           EN_IND_COMPARTIDO   OUT NOCOPY TA_PLANTARIF.IND_COMPARTIDO%TYPE,
                                           SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                           SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE PV_insertaDatosCorreo_PR (EN_COD_CLIENTE          IN GA_DATOS_ADICIONALES_CORREO_TO.COD_CLIENTE%TYPE,
                                        EN_NUM_ABONADO          IN GA_DATOS_ADICIONALES_CORREO_TO.NUM_ABONADO%TYPE,
                                        EN_COD_PROD_CONTRATADO  IN GA_DATOS_ADICIONALES_CORREO_TO.COD_PROD_CONTRATADO%TYPE,
                                        EN_NOMBRE_USUARIO       IN GA_DATOS_ADICIONALES_CORREO_TO.NOMBRE_USUARIO_CORREO%TYPE,
                                        EV_EMAIL_PERSONAL       IN GA_DATOS_ADICIONALES_CORREO_TO.EMAIL_PERSONAL%TYPE,
                                        EV_EMAIL_CORPORATIVO    IN GA_DATOS_ADICIONALES_CORREO_TO.EMAIL_CORPORATIVO%TYPE,
                                        EN_COD_DIRECCION        IN GA_DATOS_ADICIONALES_CORREO_TO.COD_DIRECCION%TYPE,
                                        EN_NUM_TELEFONO         IN GA_DATOS_ADICIONALES_CORREO_TO.NUM_TELEFONO%TYPE,
                                        EV_USUARIO              IN GA_DATOS_ADICIONALES_CORREO_TO.NOM_USUARORA%TYPE,
                                        SN_cod_retorno          OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno         OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento           OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE PV_listaTiposComportamiento_PR(  SC_cursorDatos   OUT NOCOPY REFCURSOR,
                                            SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

 PROCEDURE PV_getList_Series_PR(    EN_COD_BODEGA   IN  AL_SERIES.COD_BODEGA%TYPE,
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
                                    SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);
                                    
--INICIO 177697 PAH 
 PROCEDURE PV_getList_Series_SinUso_PR(    EN_COD_BODEGA   IN  AL_SERIES.COD_BODEGA%TYPE,
                                    EN_COD_ARTICULO IN  AL_SERIES.COD_ARTICULO%TYPE,
                                    EV_COD_HLR      IN  ICG_CENTRAL.COD_HLR%TYPE,
                                    EN_COD_MODVENTA IN  GE_MODVENTA.COD_MODVENTA%TYPE,
                                    EN_COD_CANAL    IN  GA_MODVENT_APLIC.COD_CANAL%TYPE,
                                    EN_COD_VENDEDOR IN  VE_VENDEDORES.COD_VENDEDOR%TYPE,
                                    EN_COD_CENTRAL  IN  ICG_CENTRAL.COD_CENTRAL%TYPE,
                                    EN_TIP_ARTICULO IN  VARCHAR2, --S Simcard A:Articulo
                                    SC_cursordatos  OUT NOCOPY REFCURSOR,
                                    SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);
                                    
--FIN 177697 PAH 

END PV_SERVICIOS_POSVENTA_PG;
/
SHOW ERRORS