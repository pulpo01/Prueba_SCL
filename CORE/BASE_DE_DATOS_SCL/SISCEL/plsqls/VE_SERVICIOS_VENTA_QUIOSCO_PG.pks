CREATE OR REPLACE PACKAGE VE_SERVICIOS_VENTA_QUIOSCO_PG IS

   cv_error_no_clasif     CONSTANT VARCHAR2 (30) := 'Error no clasificado';
   cn_largoerrtec         CONSTANT NUMBER        := 4000;
   cn_largodesc           CONSTANT NUMBER        := 2000;
   cv_cod_modulo          CONSTANT VARCHAR2 (2)  := 'VE';
   cv_producto            CONSTANT VARCHAR (1)   := '1';
   cv_tipodireccion       CONSTANT VARCHAR2 (1)  := '1';
   cv_modulo_ga           CONSTANT VARCHAR2 (2)  := 'GA';
   cv_modulo_ge           CONSTANT VARCHAR2 (2)  := 'GE';
   cv_modulo_al           CONSTANT VARCHAR2 (2)  := 'AL';
   cv_codact_ven          CONSTANT VARCHAR2 (2)  := 'VO';                                                                                                                                                                  -- codigo actuacion : venta oficina
   cv_formato_fecha       CONSTANT VARCHAR2 (12) := 'FORMATO_SEL2';
   cv_nompar_monedapeso   CONSTANT VARCHAR2 (15) := 'COD_MONEDA_PESO';
   cv_nompar_servhabili   CONSTANT VARCHAR2 (18) := 'COD_SERVICIO_HABIL';
   cv_nompar_indtelout    CONSTANT VARCHAR2 (11) := 'IND_TEL_OUT';
   cv_servocasional       CONSTANT VARCHAR (1)   := '1';
   cv_servsuplementario   CONSTANT VARCHAR2 (1)  := '2';
   cn_indbloqueo          CONSTANT NUMBER        := 1;
   cn_estado              CONSTANT NUMBER        := 0;
   ci_true                CONSTANT PLS_INTEGER   := 1;
   ci_false               CONSTANT PLS_INTEGER   := 0;
   cv_ind_venta_externa   CONSTANT NUMBER        := 1;
   cv_ind_tipo_venta      CONSTANT VARCHAR2 (1)  := 'V';
   cv_tip_venta_oficina   CONSTANT VARCHAR2 (1)  := 'O';
   cv_form_presu_vta      CONSTANT VARCHAR2 (15) := 'FrmPresuVenta';
   cv_baja_abonado        CONSTANT VARCHAR2 (3)  := 'BAA';
   cv_baja_abonadopdte    CONSTANT VARCHAR2 (3)  := 'BAP';
   cv_causa_elimin        CONSTANT VARCHAR2 (5)  := '00003';
   cn_estado_doc          CONSTANT NUMBER        := 900;
   cn_estado_proc         CONSTANT NUMBER        := 3;
   cv_repone_celular      CONSTANT VARCHAR (1)   := 'R';                                                                                                                                                                 --Indica reposición de numero celular
   cv_repone_cel_res      CONSTANT VARCHAR (1)   := 'S';                                                                                                                                                          --Indica reposición de num celular reservado
   cn_tipcontraro0meses   CONSTANT NUMBER        := 82;                                                                                                                                                                               -- tipo contrato 0 meses
   cn_kit  			      CONSTANT NUMBER        := 20;
   cv_cod_calificacion    CONSTANT VARCHAR (2)   := 'A';

   TYPE refcursor IS REF CURSOR;

   TYPE array_parametros_ IS TABLE OF VARCHAR2 (60)
      INDEX BY BINARY_INTEGER;

   PROCEDURE ve_obtiene_abonados_venta_pr (
      en_numventa       IN              NUMBER,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_obtiene_abonados_ventaam_pr (
      en_numventa       IN              NUMBER,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_inserta_cargo_pr (
      ev_num_cargo          IN              VARCHAR2,
      ev_cod_cliente        IN              VARCHAR2,
      ev_cod_producto       IN              VARCHAR2,
      ev_cod_concepto       IN              VARCHAR2,
      ev_imp_cargo          IN              VARCHAR2,
      ev_cod_moneda         IN              VARCHAR2,
      ev_cod_plancom        IN              VARCHAR2,
      ev_num_unidades       IN              VARCHAR2,
      ev_ind_factur         IN              VARCHAR2,
      ev_num_transaccion    IN              VARCHAR2,
      ev_num_venta          IN              VARCHAR2,
      ev_num_paquete        IN              VARCHAR2,
      ev_num_abonado        IN              VARCHAR2,
      ev_num_terminal       IN              VARCHAR2,
      ev_cod_ciclfact       IN              VARCHAR2,
      ev_num_serie          IN              VARCHAR2,
      ev_num_seriemec       IN              VARCHAR2,
      ev_cap_code           IN              VARCHAR2,
      ev_mes_garantia       IN              VARCHAR2,
      ev_num_preguia        IN              VARCHAR2,
      ev_num_guia           IN              VARCHAR2,
      ev_num_factura        IN              VARCHAR2,
      ev_cod_concepto_dto   IN              VARCHAR2,
      ev_val_dto            IN              VARCHAR2,
      ev_tip_dto            IN              VARCHAR2,
      ev_ind_cuota          IN              VARCHAR2,
      ev_ind_supertel       IN              VARCHAR2,
      ev_ind_manual         IN              VARCHAR2,
      ev_pref_plaza         IN              VARCHAR2,
      ev_cod_tecnologia     IN              VARCHAR2,
      ev_usuario            IN              VARCHAR2,
      sn_cod_retorno        OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno       OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento         OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_consulta_cliente_pr (
      ev_codcliente     IN              ge_clientes.cod_cliente%TYPE,
      sv_numident       OUT NOCOPY      ge_clientes.num_ident%TYPE,
      sv_tipident       OUT NOCOPY      ge_clientes.cod_tipident%TYPE,
      sv_nomcliente     OUT NOCOPY      ge_clientes.nom_cliente%TYPE,
      sn_codcuenta      OUT NOCOPY      ge_clientes.cod_cuenta%TYPE,
      sv_nomapellido1   OUT NOCOPY      ge_clientes.nom_apeclien1%TYPE,
      sv_nomapellido2   OUT NOCOPY      ge_clientes.nom_apeclien2%TYPE,
      sv_fecnaciomien   OUT NOCOPY      ge_clientes.fec_nacimien%TYPE,
      sv_indestcivil    OUT NOCOPY      ge_clientes.ind_estcivil%TYPE,
      sv_indsexo        OUT NOCOPY      ge_clientes.ind_sexo%TYPE,
      sn_codactividad   OUT NOCOPY      ge_clientes.cod_actividad%TYPE,
      sv_codregion      OUT NOCOPY      ge_direcciones.cod_region%TYPE,
      sv_codciudad      OUT NOCOPY      ge_direcciones.cod_ciudad%TYPE,
      sv_codprovincia   OUT NOCOPY      ge_direcciones.cod_provincia%TYPE,
      sv_codcelda       OUT NOCOPY      ge_ciudades.cod_celda%TYPE,
      sv_codcalclien    OUT NOCOPY      ge_clientes.cod_calclien%TYPE,
      sn_indfactur      OUT NOCOPY      ge_clientes.ind_factur%TYPE,
      sn_codciclo       OUT NOCOPY      ge_clientes.cod_ciclo%TYPE,
      sn_codempresa     OUT NOCOPY      ga_empresa.cod_empresa%TYPE,
      sv_coddireccion   OUT NOCOPY      VARCHAR2,
      sv_codplantarif   OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE VE_consulta_serieTerminal_PR (
      ev_serie          IN              al_series.num_serie%TYPE,
      sv_codbodega      OUT NOCOPY      al_series.cod_bodega%TYPE,
      sv_estadoserie    OUT NOCOPY      al_series.cod_estado%TYPE,
      sv_indtelefono    OUT NOCOPY      al_series.ind_telefono%TYPE,
      sv_numcelular     OUT NOCOPY      al_series.num_telefono%TYPE,
      sv_uso            OUT NOCOPY      al_series.cod_uso%TYPE,
      sv_tipostock      OUT NOCOPY      al_series.tip_stock%TYPE,
      sv_codcentral     OUT NOCOPY      al_series.cod_central%TYPE,
      sn_codarticulo    OUT NOCOPY      al_series.cod_articulo%TYPE,
      sn_capcode        OUT NOCOPY      al_series.cap_code%TYPE,
      sn_tiparticulo    OUT NOCOPY      al_articulos.tip_articulo%TYPE,
      sv_desarticulo    OUT NOCOPY      al_articulos.des_articulo%TYPE,
      sv_codsubalm      OUT NOCOPY      al_series.cod_subalm%TYPE,
      sn_indvalorar     OUT NOCOPY      al_tipos_stock.ind_valorar%TYPE,
      sv_carga          OUT NOCOPY      VARCHAR2,
      sn_cod_cat        OUT NOCOPY      al_series.cod_cat%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_consulta_plan_tarifario_pr (
      ev_plantarif           IN              ta_plantarif.cod_plantarif%TYPE,
      en_codproducto         IN              ga_modvent_aplic.cod_producto%TYPE,
      ev_tecnologia          IN              al_tecnologia.cod_tecnologia%TYPE,
      sv_desplantarif        OUT NOCOPY      ta_plantarif.des_plantarif%TYPE,
      sv_tipplantarif        OUT NOCOPY      ta_plantarif.tip_plantarif%TYPE,
      sv_codlimconsumo       OUT NOCOPY      tol_limite_td.cod_limcons%TYPE,
      sn_numdias             OUT NOCOPY      ta_plantarif.num_dias%TYPE,
      sv_codplanserv         OUT NOCOPY      ga_planserv.cod_planserv%TYPE,
      sn_ind_cargo_habil     OUT NOCOPY      ta_plantarif.ind_cargo_habil%TYPE,
      sv_codcargobasico      OUT NOCOPY      ta_plantarif.cod_cargobasico%TYPE,
      sv_descargobasico      OUT NOCOPY      ta_cargosbasico.des_cargobasico%TYPE,
      sn_importecargo        OUT NOCOPY      ta_cargosbasico.imp_cargobasico%TYPE,
      sv_monedacargobasico   OUT NOCOPY      ta_cargosbasico.cod_moneda%TYPE,
      sv_codtiplan           OUT NOCOPY      ta_plantarif.cod_tiplan%TYPE,
      sn_ind_familiar        OUT NOCOPY      ta_plantarif.ind_familiar%TYPE,
      sn_num_abonados        OUT NOCOPY      ta_plantarif.num_abonados%TYPE,
      sv_cod_plan_comverse   OUT NOCOPY      VARCHAR2,
      sn_cod_retorno         OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno        OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento          OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_precio_cargo_basico_pr (
      ev_codproducto    IN              VARCHAR2,
      ev_codcargo       IN              VARCHAR2,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_preccargosimcard_prelis_pr (
      en_codarticulo    IN              al_precios_venta.cod_articulo%TYPE,
      en_tipstock       IN              al_precios_venta.tip_stock%TYPE,
      en_codusoventa    IN              al_precios_venta.cod_uso%TYPE,
      en_codestado      IN              al_precios_venta.cod_estado%TYPE,
      en_indrecambio    IN              al_precios_venta.ind_recambio%TYPE,
      ev_codcategoria   IN              al_precios_venta.cod_categoria%TYPE,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_preccargoterminal_prelis_pr (
      en_codarticulo    IN              al_precios_venta.cod_articulo%TYPE,
      en_tipstock       IN              al_precios_venta.tip_stock%TYPE,
      en_codusoventa    IN              al_precios_venta.cod_uso%TYPE,
      en_codestado      IN              al_precios_venta.cod_estado%TYPE,
      en_indrecambio    IN              al_precios_venta.ind_recambio%TYPE,
      ev_codcategoria   IN              al_precios_venta.cod_categoria%TYPE,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_precarsimcard_noprelis_pr (
      en_codarticulo     IN              al_precios_venta.cod_articulo%TYPE,
      en_tipstock        IN              al_precios_venta.tip_stock%TYPE,
      en_codusoventa     IN              al_precios_venta.cod_uso%TYPE,
      en_codestado       IN              al_precios_venta.cod_estado%TYPE,
      en_modventa        IN              al_precios_venta.cod_modventa%TYPE,
      ev_tipocontrato    IN              ga_percontrato.cod_tipcontrato%TYPE,
      ev_plantarif       IN              ve_catplantarif.cod_plantarif%TYPE,
      en_indrecambio     IN              al_precios_venta.ind_recambio%TYPE,
      ev_codcategoria    IN              al_precios_venta.cod_categoria%TYPE,
      en_codusoprepago   IN              al_precios_venta.cod_uso%TYPE,
      ev_indequipo       IN              al_articulos.ind_equiacc%TYPE,
      sc_cursordatos     OUT NOCOPY      refcursor,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_precarterminal_noprelis_pr (
      en_codarticulo     IN              al_precios_venta.cod_articulo%TYPE,
      en_tipstock        IN              al_precios_venta.tip_stock%TYPE,
      en_codusoventa     IN              al_precios_venta.cod_uso%TYPE,
      en_codestado       IN              al_precios_venta.cod_estado%TYPE,
      en_modventa        IN              al_precios_venta.cod_modventa%TYPE,
      ev_tipocontrato    IN              ga_percontrato.cod_tipcontrato%TYPE,
      ev_plantarif       IN              ve_catplantarif.cod_plantarif%TYPE,
      en_indrecambio     IN              al_precios_venta.ind_recambio%TYPE,
      ev_codcategoria    IN              al_precios_venta.cod_categoria%TYPE,
      en_codusoprepago   IN              al_precios_venta.cod_uso%TYPE,
      ev_indequipo       IN              al_articulos.ind_equiacc%TYPE,
      sc_cursordatos     OUT NOCOPY      refcursor,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_precio_cargo_servsupl_pr (
      ev_codproducto    IN              VARCHAR2,
      ev_codservicio    IN              VARCHAR2,
      ev_codplanserv    IN              VARCHAR2,
      ev_codactuacion   IN              VARCHAR2,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_consulta_categ_ptarif_pr (
      ev_plantarif      IN              ta_plantarif.cod_plantarif%TYPE,
      sv_codcategoria   OUT NOCOPY      ve_catplantarif.cod_categoria%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_obtiene_parametro_fact_pr (
      ev_nomparametro   IN              ged_parametros.nom_parametro%TYPE,
      sv_valparametro   OUT NOCOPY      ged_parametros.val_parametro%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_obtiene_codpromedio_fact_pr (
      en_valpromfact    IN              al_promfact.fact_desde%TYPE,
      sn_codpromedio    OUT NOCOPY      al_promfact.cod_promedio%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_promfacturadocliente_pr (
      en_indciclo         IN              fa_tipdocumen.ind_ciclo%TYPE,
      en_numeromeses      IN              NUMBER,
      en_codcliente       IN              fa_histdocu.cod_cliente%TYPE,
      sn_totalfacturado   OUT NOCOPY      NUMBER,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_valida_codigo_vendedor_pr (
      en_cod_vendedor   IN              ve_vendedores.cod_vendedor%TYPE,
      sn_resultado      OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_consulta_ciclo_fact_pr (
      en_cod_ciclo      IN              ge_clientes.cod_ciclo%TYPE,
      sn_cod_ciclfact   OUT NOCOPY      fa_ciclfact.cod_ciclfact%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_obtiene_formas_pago_pr (
      ev_cod_orden        IN              ged_parametros.cod_producto%TYPE,
      ev_planfreedom      IN              VARCHAR,
      ev_cattribcliente   IN              VARCHAR,
      sc_cursordatos      OUT NOCOPY      refcursor,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_obtiene_descuento_art_pr (
      ev_cod_operacion      IN              gad_descuentos.cod_operacion%TYPE,
      ev_tip_contactual     IN              gad_descuentos.tip_contrato_actual%TYPE,
      en_num_mesesactual    IN              gad_descuentos.num_meses_actual%TYPE,
      ev_cod_antiguedad     IN              gad_descuentos.cod_antiguedad%TYPE,
      en_cod_promediofact   IN              gad_descuentos.cod_promfact%TYPE,
      ev_cod_estadodev      IN              gad_descuentos.cod_estado_dev%TYPE,
      ev_cod_tipcontnuevo   IN              gad_descuentos.cod_tipcontrato_nuevo%TYPE,
      en_num_mesesnuevo     IN              gad_descuentos.num_meses_nuevo%TYPE,
      en_cod_articulo       IN              gad_descuentos.cod_articulo%TYPE,
      ev_clase_descuento    IN              gad_descuentos.clase_descuento%TYPE,
      sc_cursordatos        OUT NOCOPY      refcursor,
      sn_cod_retorno        OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno       OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento         OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_obtiene_descuento_con_pr (
      ev_cod_operacion      IN              gad_descuentos.cod_operacion%TYPE,
      ev_cod_antiguedad     IN              gad_descuentos.cod_antiguedad%TYPE,
      ev_cod_tipcontnuevo   IN              gad_descuentos.cod_tipcontrato_nuevo%TYPE,
      en_num_mesesnuevo     IN              gad_descuentos.num_meses_nuevo%TYPE,
      en_ind_vtaexterna     IN              gad_descuentos.ind_vta_externa%TYPE,
      en_cod_vendealer      IN              gad_descuentos.cod_vendealer%TYPE,
      ev_cod_causadscto     IN              VARCHAR2,
      ev_cod_categoria      IN              VARCHAR2,
      en_cod_modventa       IN              VARCHAR2,
      en_tip_producto       IN              VARCHAR2,
      en_cod_concepto       IN              VARCHAR2,
      ev_clase_descuento    IN              gad_descuentos.clase_descuento%TYPE,
      sc_cursordatos        OUT NOCOPY      refcursor,
      sn_cod_retorno        OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno       OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento         OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_precio_cargo_servocac_pr (
      ev_codproducto    IN              VARCHAR2,
      ev_codarticulo    IN              VARCHAR2,
      ev_codplantarif   IN              VARCHAR2,
      ev_codusolinea    IN              VARCHAR2,
      ev_codmodventa    IN              VARCHAR2,
      ev_nummeses       IN              VARCHAR2,
      ev_tipstock       IN              VARCHAR2,
      ev_indcomodato    IN              VARCHAR2,
      ev_codactuacion   IN              VARCHAR2,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_obtiene_cat_trib_cliente_pr (
      en_cod_cliente        IN              ga_catributclie.cod_cliente%TYPE,
      sv_cat_trib_cliente   OUT NOCOPY      VARCHAR,
      sn_cod_retorno        OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno       OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento         OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_hay_pfreedom_en_venta_pr (
      ev_ind_proporvta   IN              VARCHAR,
      en_num_venta       IN              NUMBER,
      en_ind_proporc1    IN              NUMBER,
      en_ind_proporc2    IN              NUMBER,
      sn_resultado       OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_consulta_cod_desc_manual_pr (
      en_cod_conceptocargo   IN              fa_conceptos.cod_concorig%TYPE,
      en_cod_tipconce        IN              fa_conceptos.cod_tipconce%TYPE,
      sn_cod_conceptodcto    OUT NOCOPY      fa_conceptos.cod_concepto%TYPE,
      sn_cod_retorno         OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno        OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento          OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_es_vendedor_externo_pr (
      en_cod_vendedor   IN              ve_vendedores.cod_vendedor%TYPE,
      sn_resultado      OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_obtiene_modo_gener_fact_pr (
      ev_cod_oficina      IN              al_docum_sucursal.cod_oficina%TYPE,
      ev_cod_tip_docum    IN              al_docum_sucursal.cod_tipdocum%TYPE,
      ev_factura_global   IN              VARCHAR2,
      en_documento_guia   IN              ge_tipdocumen.cod_tipdocum%TYPE,
      ev_tip_foliacion    IN              ge_tipdocumen.tip_foliacion%TYPE,
      en_cod_tipmovimen   IN              fa_gencentremi.cod_tipmovimien%TYPE,
      ev_cod_cattribut    IN              fa_gencentremi.cod_catribut%TYPE,
      ev_flagcentremi     IN              VARCHAR2,
      en_cod_modventa     IN              fa_gencentremi.cod_modventa%TYPE,
      sv_cod_modgener     OUT NOCOPY      fa_gencentremi.cod_modgener%TYPE,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_in_ga_preliquidacion_pr (
      ev_numventa       IN              ga_preliquidacion.num_venta%TYPE,
      ev_codvendealer   IN              ga_preliquidacion.cod_dealer%TYPE,
      ev_codmaster      IN              ga_preliquidacion.cod_master_dealer%TYPE,
      ev_codcliente     IN              ga_preliquidacion.cod_cliente%TYPE,
      ev_codmodvta      IN              ga_preliquidacion.cod_modventa%TYPE,
      ev_cod_programa   IN              ge_programas.cod_programa%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_in_ga_det_preliq_pr (
      en_numventa        IN              ga_preliquidacion.num_venta%TYPE,
      en_numitem         IN              ga_det_preliq.num_item%TYPE,
      en_numabonado      IN              ga_det_preliq.num_abonado%TYPE,
      en_numcelular      IN              ga_det_preliq.num_celular%TYPE,
      ev_numserie        IN              ga_det_preliq.num_serie_orig%TYPE,
      en_impcargo        IN              ga_det_preliq.imp_cargo%TYPE,
      en_impcargofinal   IN              ga_det_preliq.imp_cargo_final%TYPE,
      en_codarticulo     IN              ga_det_preliq.cod_articulo%TYPE,
      en_tipdcto         IN              ga_det_preliq.tip_dto%TYPE,
      en_valdcto         IN              ga_det_preliq.val_dto%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_actualiza_facturacion_pr (
      ev_cod_estadoc       IN              VARCHAR2,
      ev_cod_estproc       IN              VARCHAR2,
      ev_cod_catribdoc     IN              VARCHAR2,
      ev_num_folio         IN              VARCHAR2,
      ev_pref_plaza        IN              VARCHAR2,
      ev_fec_vencimiento   IN              VARCHAR2,
      ev_nom_usuaelim      IN              VARCHAR2,
      ev_cod_causaelim     IN              VARCHAR2,
      ev_num_proceso       IN              VARCHAR2,
      ev_num_venta         IN              VARCHAR2,
      sn_cod_retorno       OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_obtiene_articulos_consig_pr (
      en_num_venta      IN              ga_abocel.num_venta%TYPE,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_crea_movimiento_central_pr (
      en_num_movimiento   IN              icc_movimiento.num_movimiento%TYPE,
      en_num_abonado      IN              icc_movimiento.num_abonado%TYPE,
      en_cod_estado       IN              icc_movimiento.cod_estado%TYPE,
      ev_cod_actabo       IN              icc_movimiento.cod_actabo%TYPE,
      ev_cod_modulo       IN              icc_movimiento.cod_modulo%TYPE,
      en_cod_actuacion    IN              icc_movimiento.cod_actuacion%TYPE,
      en_nom_usuarora     IN              icc_movimiento.nom_usuarora%TYPE,
      ev_fec_ingreso      IN              VARCHAR2,
      ev_tip_terminal     IN              icc_movimiento.tip_terminal%TYPE,
      en_cod_central      IN              icc_movimiento.cod_central%TYPE,
      en_num_celular      IN              icc_movimiento.num_celular%TYPE,
      ev_num_serie        IN              icc_movimiento.num_serie%TYPE,
      ev_cod_servicios    IN              icc_movimiento.cod_servicios%TYPE,
      ev_num_min          IN              icc_movimiento.num_min%TYPE,
      ev_tip_tecnologia   IN              icc_movimiento.tip_tecnologia%TYPE,
      ev_imsi             IN              icc_movimiento.imsi%TYPE,
      ev_imei             IN              icc_movimiento.imei%TYPE,
      ev_icc              IN              icc_movimiento.icc%TYPE,
      en_num_movtoant     IN              icc_movimiento.num_movimiento%TYPE,
      ev_plan             IN              VARCHAR2,
      ev_valorplan        IN              VARCHAR2,
      ev_carga            IN              VARCHAR2,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_obtiene_ind_telefono_pr (
      ev_serie          IN              al_series.num_serie%TYPE,
      ev_parametro      OUT NOCOPY      VARCHAR2,
      sn_indtelefono    OUT NOCOPY      al_series.ind_telefono%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_obtiene_actua_central_pr (
      ev_codactabo       IN              ga_actabo.cod_actabo%TYPE,
      en_codproducto     IN              ga_actabo.cod_producto%TYPE,
      ev_codtecnologia   IN              ga_actabo.cod_actabo%TYPE,
      sv_codactcen       OUT NOCOPY      ga_actabo.cod_actcen%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_obtiene_codigo_sistema_pr (
      en_codproducto    IN              icg_central.cod_producto%TYPE,
      en_codcentral     IN              icg_central.cod_central%TYPE,
      sn_codsistema     OUT NOCOPY      icg_central.cod_sistema%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_obtiene_central_pr (
      en_codproducto     IN              icg_central.cod_producto%TYPE,
      en_codcentral      IN              icg_central.cod_central%TYPE,
      sv_codtecnologia   OUT NOCOPY      icg_central.cod_tecnologia%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_up_ga_preliquidacion_pr (
      ev_numventa       IN              ga_preliquidacion.num_venta%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_actualiza_equipaboser_pr (
      ev_nummovimiento   IN              VARCHAR2,
      ev_tipstock        IN              VARCHAR2,
      ev_bodegaact       IN              VARCHAR2,
      ev_tipstockorig    IN              VARCHAR2,
      ev_codbodega       IN              VARCHAR2,
      ev_codarticulo     IN              VARCHAR2,
      ev_coduso          IN              VARCHAR2,
      ev_codestado       IN              VARCHAR2,
      ev_numserie        IN              VARCHAR2,
      ev_numabonado      IN              VARCHAR2,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_obtiene_equipos_seriados_pr (
      ev_numabonado       IN              VARCHAR2,
      ev_indprocedencia   IN              VARCHAR2,
      sc_cursordatos      OUT NOCOPY      refcursor,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_consulta_estant_serie_pr (
      ev_serie          IN              al_series.num_serie%TYPE,
      sn_codestado      OUT NOCOPY      al_series.cod_estado%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_ins_abo_garantia_pr (
      en_num_venta      IN              ga_abonado_garantia.num_venta%TYPE,
      en_cod_cliente    IN              ga_abonado_garantia.cod_cliente%TYPE,
      en_num_abonado    IN              ga_abonado_garantia.num_abonado%TYPE,
      en_mto_garantia   IN              ga_abonado_garantia.mto_garantia%TYPE,
      en_ind_pago       IN              ga_abonado_garantia.ind_pago%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_inserta_contrato_pr (
      en_cod_cuenta        IN              ga_contcta.cod_cuenta%TYPE,
      en_cod_producto      IN              ga_contcta.cod_producto%TYPE,
      ev_cod_tipcontrato   IN              ga_contcta.cod_tipcontrato%TYPE,
      ev_num_contrato      IN              ga_contcta.num_contrato%TYPE,
      ev_num_anexo         IN              ga_contcta.num_anexo%TYPE,
      en_num_meses         IN              ga_contcta.num_meses%TYPE,
      en_num_venta         IN              ga_contcta.num_venta%TYPE,
      en_num_abonados      IN              ga_contcta.num_abonados%TYPE,
      en_num_abonado       IN              ga_abocel.num_abonado%TYPE,
      sn_cod_retorno       OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_con_max_anexo_contrato_pr (
      en_cod_cuenta        IN              ga_contcta.cod_cuenta%TYPE,
      en_cod_producto      IN              ga_contcta.cod_producto%TYPE,
      ev_cod_tipcontrato   IN              ga_contcta.cod_tipcontrato%TYPE,
      ev_num_contrato      IN              ga_contcta.num_contrato%TYPE,
      sn_max_anexo         OUT             NUMBER,
      sn_cod_retorno       OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_con_rango_descto_vend_pr (
      en_cod_vendedor   IN              ve_vendperfil.cod_vendedor%TYPE,
      sn_pnt_dto_inf    OUT NOCOPY      ga_perfilcargos.pnt_dto_inf%TYPE,
      sn_pnt_dto_sup    OUT NOCOPY      ga_perfilcargos.pnt_dto_sup%TYPE,
      sn_prc_dto_inf    OUT NOCOPY      ga_perfilcargos.prc_dto_inf%TYPE,
      sn_prc_dto_sup    OUT NOCOPY      ga_perfilcargos.prc_dto_sup%TYPE,
      sn_ind_moddtos    OUT NOCOPY      ga_perfilcargos.ind_moddtos%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_ins_sol_autorizacion_pr (
      en_num_venta          IN              ga_autoriza.num_venta%TYPE,
      en_lin_autoriza       IN              ga_autoriza.lin_autoriza%TYPE,
      ev_cod_oficina        IN              ga_autoriza.cod_oficina%TYPE,
      ev_cod_estado         IN              ga_autoriza.cod_estado%TYPE,
      en_num_autoriza       IN              ga_autoriza.num_autoriza%TYPE,
      en_cod_vendedor       IN              ga_autoriza.cod_vendedor%TYPE,
      en_num_unidades       IN              ga_autoriza.num_unidades%TYPE,
      en_prc_origin         IN              ga_autoriza.prc_origin%TYPE,
      en_ind_tipventa       IN              ga_autoriza.ind_tipventa%TYPE,
      en_cod_cliente        IN              ga_autoriza.cod_cliente%TYPE,
      en_cod_modventa       IN              ga_autoriza.cod_modventa%TYPE,
      ev_nom_usuar_vta      IN              ga_autoriza.nom_usuar_vta%TYPE,
      en_cod_concepto       IN              ga_autoriza.cod_concepto%TYPE,
      en_imp_cargo          IN              ga_autoriza.imp_cargo%TYPE,
      ev_cod_moneda         IN              ga_autoriza.cod_moneda%TYPE,
      en_num_abonado        IN              ga_autoriza.num_abonado%TYPE,
      ev_num_serie          IN              ga_autoriza.num_serie%TYPE,
      en_cod_concepto_dto   IN              ga_autoriza.cod_concepto_dto%TYPE,
      en_val_dto            IN              ga_autoriza.val_dto%TYPE,
      en_tip_dto            IN              ga_autoriza.tip_dto%TYPE,
      en_ind_modifi         IN              ga_autoriza.ind_modifi%TYPE,
      ev_origen             IN              ga_autoriza.origen%TYPE,
      sn_cod_retorno        OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno       OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento         OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_con_sol_autorizacion_pr (
      en_num_autoriza   IN              ga_autoriza.num_autoriza%TYPE,
      sv_cod_estado     OUT NOCOPY      ga_autoriza.cod_estado%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_con_modalidadpago_pr (
      en_cod_modventa   IN              ge_modventa.cod_modventa%TYPE,
      sv_des_modventa   OUT             ge_modventa.des_modventa%TYPE,
      sn_indcuotas      OUT NOCOPY      ge_modventa.ind_cuotas%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_con_tipocontrato_pr (
      en_cod_producto      IN              NUMBER,
      ev_cod_tipcontrato   IN              ga_tipcontrato.cod_tipcontrato%TYPE,
      sv_des_tipcontrato   OUT NOCOPY      ga_tipcontrato.des_tipcontrato%TYPE,
      sn_ind_comodato      OUT NOCOPY      ga_tipcontrato.ind_comodato%TYPE,
      sn_cod_retorno       OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_con_producto_pr (
      en_cod_producto   IN              ge_productos.cod_producto%TYPE,
      sv_des_producto   OUT NOCOPY      ge_productos.des_producto%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_updabocelclaseserv_pr (
      en_numabonado     IN              ga_abocel.num_abonado%TYPE,
      ev_claseserv      IN              ga_abocel.clase_servicio%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_updequipaboser_pr (
      ev_numabonado     IN              VARCHAR2,
      ev_numserie       IN              VARCHAR2,
      ev_fecalta        IN              VARCHAR2,
      ev_nummovto       IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_insreservaarticulo_pr (
      ev_num_linea      IN              VARCHAR2,
      ev_num_orden      IN              VARCHAR2,
      ev_cod_articulo   IN              VARCHAR2,
      ev_cod_producto   IN              VARCHAR2,
      ev_cod_bodega     IN              VARCHAR2,
      ev_tip_stock      IN              VARCHAR2,
      ev_cod_uso        IN              VARCHAR2,
      ev_cod_estado     IN              VARCHAR2,
      ev_nom_usuario    IN              VARCHAR2,
      ev_num_serie      IN              VARCHAR2,
      ev_num_transacc   IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_actualizastock_pr (
      ev_tipmov         IN              VARCHAR2,
      ev_tipstock       IN              VARCHAR2,
      ev_codbodega      IN              VARCHAR2,
      ev_codarticulo    IN              VARCHAR2,
      ev_coduso         IN              VARCHAR2,
      ev_codestado      IN              VARCHAR2,
      ev_numventa       IN              VARCHAR2,
      ev_numserie       IN              VARCHAR2,
      sv_nummovto       OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_getlistplantarifario_pr (
      ev_indcomercial   IN              NUMBER,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_getempresacte_pr (
      ev_codcliente     IN              VARCHAR2,
      sv_numabonados    OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_updempresaabonados_pr (
      ev_codcliente     IN              VARCHAR2,
      ev_cantidad       IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_updabocelcodsituac_pr (
      en_numventa       IN              VARCHAR2,
      ev_codsituacion   IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_validahomevendcel_pr (
      en_codvendedor    IN              VARCHAR2,
      ev_numcelular     IN              VARCHAR2,
      sn_resultado      OUT NOCOPY      NUMBER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_num_abonados_cliente_pr (
      ev_cod_cliente     IN              VARCHAR2,
      ev_cod_plantarif   IN              VARCHAR2,
      sn_resultado       OUT NOCOPY      NUMBER,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_cambia_modalidad_pr (
      en_num_serie             IN              al_series.num_serie%TYPE,
      en_canal                 IN              VARCHAR2,
      en_cod_modventa_origen   IN              ge_modventa.cod_modventa%TYPE,
      sn_modventa              OUT             ge_modventa.cod_modventa%TYPE,
      sn_desmodventa           OUT             ge_modventa.des_modventa%TYPE,
      sn_cod_retorno           OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno          OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento            OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_datosvendedor_pr (
      en_codvendedor     IN              ve_vendedores.cod_vendedor%TYPE,
      en_coddealer       IN              ve_vendealer.cod_vendealer%TYPE,
      sv_nomvendedor     OUT NOCOPY      ve_vendedores.nom_vendedor%TYPE,
      sv_nomvendealer    OUT NOCOPY      ve_vendealer.nom_vendealer%TYPE,
      sn_codcliente      OUT NOCOPY      ve_vendedores.cod_cliente%TYPE,
      sn_codvende_raiz   OUT NOCOPY      ve_vendedores.cod_vende_raiz%TYPE,
      sv_codregion       OUT NOCOPY      ge_direcciones.cod_region%TYPE,
      sv_codprovincia    OUT NOCOPY      ge_direcciones.cod_provincia%TYPE,
      sv_codciudad       OUT NOCOPY      ge_direcciones.cod_ciudad%TYPE,
      sv_codoficina      OUT NOCOPY      ve_vendedores.cod_oficina%TYPE,
      sv_codtipcomis     OUT NOCOPY      ve_tipcomis.cod_tipcomis%TYPE,
      sv_destipcomis     OUT NOCOPY      ve_tipcomis.des_tipcomis%TYPE,
      sn_indtipventa     OUT NOCOPY      ve_vendedores.ind_tipventa%TYPE,
      sn_indbloqueo      OUT NOCOPY      ve_vendedores.ve_indbloqueo%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_getlistvendedores_pr (
      ev_cod_oficina    IN              VARCHAR2,
      ev_cod_tipcomis   IN              VARCHAR2,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_getlistvenddealer_pr (
      ev_cod_vendedor   IN              VARCHAR2,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_reversaventas_pr (
      en_num_venta      IN              ga_ventas.num_venta%TYPE,
      en_cod_vendedor   IN              ga_ventas.cod_vendedor%TYPE,
      ev_nom_usuario    IN              ga_ventas.nom_usuar_vta%TYPE,
      en_num_procfact   IN              fa_presupuesto.num_proceso%TYPE,
      en_num_transac    IN              ga_resnumcel.num_transaccion%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_eliminarescel_pr (
      en_num_venta      IN              ga_ventas.num_venta%TYPE,
      en_num_transac    IN              ga_resnumcel.num_transaccion%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_inserta_ga_docventa_pr (
      en_num_venta      IN              ga_docventa.num_venta%TYPE,
      en_cod_tipdocum   IN              ga_docventa.cod_tipdocum%TYPE,
      ev_num_folio      IN              ga_docventa.num_folio%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_inserta_al_petigiasabo_pr (
      en_cod_articulo   IN              al_petiguias_abo.cod_articulo%TYPE,
      en_cod_bodega     IN              al_petiguias_abo.cod_bodega%TYPE,
      en_cod_cliente    IN              al_petiguias_abo.cod_cliente%TYPE,
      en_cod_concepto   IN              al_petiguias_abo.cod_concepto%TYPE,
      ev_cod_moneda     IN              al_petiguias_abo.cod_moneda%TYPE,
      ev_cod_oficina    IN              al_petiguias_abo.cod_oficina%TYPE,
      en_num_abonado    IN              al_petiguias_abo.num_abonado%TYPE,
      en_num_cantidad   IN              al_petiguias_abo.num_cantidad%TYPE,
      en_num_cargo      IN              al_petiguias_abo.num_cargo%TYPE,
      en_num_orden      IN              al_petiguias_abo.num_orden%TYPE,
      en_num_peticion   IN              al_petiguias_abo.num_peticion%TYPE,
      ev_num_serie      IN              al_petiguias_abo.num_serie%TYPE,
      en_num_telefono   IN              al_petiguias_abo.num_telefono%TYPE,
      en_num_venta      IN              al_petiguias_abo.num_venta%TYPE,
      en_val_linea      IN              al_petiguias_abo.val_linea%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_inserta_ctecontrato_pr (
      en_codcliente       IN              VARCHAR2,
      ev_codplantarif     IN              VARCHAR2,
      en_coduso           IN              VARCHAR2,
      en_codproducto      IN              VARCHAR2,
      ev_codtipcontrato   IN              VARCHAR2,
      ev_nomusuario       IN              VARCHAR2,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_inserta_ctecontrato_web_pr (
      en_codcliente       IN              VARCHAR2,
      ev_codplantarif     IN              VARCHAR2,
      en_coduso           IN              VARCHAR2,
      en_codproducto      IN              VARCHAR2,
      ev_codtipcontrato   IN              VARCHAR2,
      ev_nomusuario       IN              VARCHAR2,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_elimina_ctecontrato_pr (
      en_codcliente     IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_obtiene_tipcontrato_pr (
      en_codcliente       IN              VARCHAR2,
      sv_codplantarif     OUT NOCOPY      VARCHAR2,
      sn_coduso           OUT NOCOPY      VARCHAR2,
      sn_codproducto      OUT NOCOPY      VARCHAR2,
      sv_codtipcontrato   OUT NOCOPY      VARCHAR2,
      sv_nomtipcontrato   OUT NOCOPY      ga_tipcontrato.des_tipcontrato%TYPE,
      sn_nummesestipcon   OUT NOCOPY      ga_tipcontrato.meses_minimo%TYPE,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_obtiene_tipcontrato_pr (
      en_codcliente       IN              VARCHAR2,
      sv_codplantarif     OUT NOCOPY      VARCHAR2,
      sn_coduso           OUT NOCOPY      VARCHAR2,
      sn_codproducto      OUT NOCOPY      VARCHAR2,
      sv_codtipcontrato   OUT NOCOPY      VARCHAR2,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_obtiene_vigplanserie_pr (
      ev_codplantarif      IN              ga_planuso.cod_plantarif%TYPE,
      ev_numserie          IN              al_series.num_serie%TYPE,
      sv_flgcontratofijo   OUT NOCOPY      ga_planuso.flg_contratofijo%TYPE,
      sn_cod_retorno       OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_obtiene_vigplanuso_pr (
      ev_codplantarif      IN              ga_planuso.cod_plantarif%TYPE,
      en_coduso            IN              ga_planuso.cod_uso%TYPE,
      sv_flgcontratofijo   OUT NOCOPY      ga_planuso.flg_contratofijo%TYPE,
      sn_cod_retorno       OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_obtiene_abosvigcliente_pr (
      ev_cod_cliente                 ga_abocel.cod_cliente%TYPE,
      sn_resultado      OUT NOCOPY   NUMBER,
      sn_cod_retorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento);

   PROCEDURE ve_obtiene_vtasvendedor_pr (
      en_codvendedor    IN              ga_ventas.cod_vendedor%TYPE,
      en_numventa       IN              ga_ventas.num_venta%TYPE,
      ev_codoficina     IN              ga_ventas.cod_oficina%TYPE,
      ev_fecdesde       IN              VARCHAR2,
      ev_fechasta       IN              VARCHAR2,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_getlistvendedores_pr (
      ev_cod_oficina    IN              VARCHAR2,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_obtiene_tipcontrato_fs_pr (
      en_nuntransaccion   IN   ga_transacabo.num_transaccion%TYPE,
      en_codcliente       IN   VARCHAR2);

   PROCEDURE ve_inserta_ctecontrato_fs_pr (
      en_nuntransaccion   IN   ga_transacabo.num_transaccion%TYPE,
      en_codcliente       IN   VARCHAR2,
      ev_codplantarif     IN   VARCHAR2,
      en_coduso           IN   VARCHAR2,
      en_codproducto      IN   VARCHAR2,
      ev_codtipcontrato   IN   VARCHAR2,
      ev_nomusuario       IN   VARCHAR2);

   PROCEDURE ve_elimina_ctecontrato_fs_pr (
      en_nuntransaccion   IN   ga_transacabo.num_transaccion%TYPE,
      en_codcliente       IN   VARCHAR2);

   PROCEDURE ve_obtiene_vigplanuso_fs_pr (
      en_nuntransaccion   IN   ga_transacabo.num_transaccion%TYPE,
      ev_codplantarif     IN   ga_planuso.cod_plantarif%TYPE,
      en_coduso           IN   ga_planuso.cod_uso%TYPE);

   PROCEDURE ve_obtiene_abosvigclie_fs_pr (
      en_nuntransaccion   IN   ga_transacabo.num_transaccion%TYPE,
      en_codcliente       IN   ga_abocel.cod_cliente%TYPE);

-- P-ECU-08019 fin ------------------------------------------------------------------------------
   PROCEDURE ga_insert_venta_pr (
      so_ventas         IN OUT NOCOPY   ve_tipos_pg.tip_ga_ventas,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_datosvendedor_pr (
      en_codvendedor     IN              ve_vendedores.cod_vendedor%TYPE,
      en_coddealer       IN              ve_vendealer.cod_vendealer%TYPE,
      sv_nomvendedor     OUT NOCOPY      ve_vendedores.nom_vendedor%TYPE,
      sv_nomvendealer    OUT NOCOPY      ve_vendealer.nom_vendealer%TYPE,
      sn_codcliente      OUT NOCOPY      ve_vendedores.cod_cliente%TYPE,
      sn_codvende_raiz   OUT NOCOPY      ve_vendedores.cod_vende_raiz%TYPE,
      sv_codregion       OUT NOCOPY      ge_direcciones.cod_region%TYPE,
      sv_codprovincia    OUT NOCOPY      ge_direcciones.cod_provincia%TYPE,
      sv_codciudad       OUT NOCOPY      ge_direcciones.cod_ciudad%TYPE,
      sv_codoficina      OUT NOCOPY      ve_vendedores.cod_oficina%TYPE,
      sv_codtipcomis     OUT NOCOPY      ve_tipcomis.cod_tipcomis%TYPE,
      sv_destipcomis     OUT NOCOPY      ve_tipcomis.des_tipcomis%TYPE,
      sn_indtipventa     OUT NOCOPY      ve_vendedores.ind_tipventa%TYPE,
      sn_indbloqueo      OUT NOCOPY      ve_vendedores.ve_indbloqueo%TYPE,
      sv_cod_cuenta      OUT NOCOPY      ve_vendedores.cod_cuenta%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_consulta_serie_pr (
      ev_serie          IN              al_series.num_serie%TYPE,
      sv_codbodega      OUT NOCOPY      al_series.cod_bodega%TYPE,
      sv_estadoserie    OUT NOCOPY      al_series.cod_estado%TYPE,
      sv_indtelefono    OUT NOCOPY      al_series.ind_telefono%TYPE,
      sv_numcelular     OUT NOCOPY      al_series.num_telefono%TYPE,
      sv_uso            OUT NOCOPY      al_series.cod_uso%TYPE,
      sv_tipostock      OUT NOCOPY      al_series.tip_stock%TYPE,
      sv_codcentral     OUT NOCOPY      al_series.cod_central%TYPE,
      sn_codarticulo    OUT NOCOPY      al_series.cod_articulo%TYPE,
      sn_capcode        OUT NOCOPY      al_series.cap_code%TYPE,
      sn_tiparticulo    OUT NOCOPY      al_articulos.tip_articulo%TYPE,
      sv_desarticulo    OUT NOCOPY      al_articulos.des_articulo%TYPE,
      sv_codsubalm      OUT NOCOPY      al_series.cod_subalm%TYPE,
      sn_indvalorar     OUT NOCOPY      al_tipos_stock.ind_valorar%TYPE,
      sv_carga          OUT NOCOPY      VARCHAR2,
      sv_cod_hlr        OUT NOCOPY      al_series.cod_hlr%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

/***********************************************************************************************************************************************************************/
   PROCEDURE ve_consulta_seriexcodarti_pr (
      en_codarticulo    IN              al_series.cod_articulo%TYPE,
      en_codbodega      IN              al_series.cod_bodega%TYPE,
      en_codvendedor    IN              ve_vendalmac.cod_vendedor%TYPE,
      en_coduso         IN              al_series.cod_uso%TYPE,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

/***********************************************************************************************************************************************************************/
   PROCEDURE ve_valida_coduso_pr (
      en_cod_uso        IN              al_usos.cod_uso%TYPE,
      sn_ind_restplan   OUT NOCOPY      al_usos.ind_restplan%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

/***********************************************************************************************************************************************************************/
   PROCEDURE ve_valida_codplantarif_pr (
      ev_cod_plantarif   IN              ta_plantarif.cod_plantarif%TYPE,
      en_cod_uso         IN              al_usos.cod_uso%TYPE,
      en_ind_restplan    IN              al_usos.ind_restplan%TYPE,
      sv_tip_plantarif   OUT NOCOPY      ta_plantarif.tip_plantarif%TYPE,
      sn_cod_tiplan      OUT NOCOPY      ta_plantarif.cod_tiplan%TYPE,
      sn_ind_familiar    OUT NOCOPY      ta_plantarif.ind_familiar%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento);

/***********************************************************************************************************************************************************************/
   PROCEDURE ve_valida_codplanserv_pr (
      ev_cod_planserv     IN              ga_planserv.cod_planserv%TYPE,
      ev_cod_tecnologia   IN              ga_plantecplserv.cod_tecnologia%TYPE,
      ev_cod_plantarif    IN              ga_plantecplserv.cod_plantarif%TYPE,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento);

/***********************************************************************************************************************************************************************/
   PROCEDURE ve_valida_usuario_pr (
      ev_nom_usuario    IN              ge_seg_usuario.nom_usuario%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

/***********************************************************************************************************************************************************************/
   PROCEDURE ve_consulta_ss_opc_pr (
      ev_cod_actabo                    ga_actabo.cod_actabo%TYPE,
      ev_cod_plantarif                 ta_plantarif.cod_plantarif%TYPE,
      en_cod_tiplan                    ta_plantarif.cod_tiplan%TYPE,
      ev_cod_tecnologia                al_tecnologia.cod_tecnologia%TYPE,
      ev_cod_planserv                  ga_planserv.cod_planserv%TYPE,
      sc_ssopc            OUT NOCOPY   refcursor,
      sn_cod_retorno      OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY   ge_errores_pg.evento);

/***********************************************************************************************************************************************************************/
   PROCEDURE ve_consulta_ss_defecto_pr (
      ev_cod_plantarif                ta_plantarif.cod_plantarif%TYPE,
      sc_ssdefecto       OUT NOCOPY   refcursor,
      sn_cod_retorno     OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY   ge_errores_pg.evento);

/***********************************************************************************************************************************************************************/
   PROCEDURE ve_consulta_ss_perfil_pr (
      en_cod_actuacion                 icg_actuaciontercen.cod_actuacion%TYPE,
      en_cod_sistema                   icg_actuaciontercen.cod_sistema%TYPE,
      ev_tip_tecnologia                icg_actuaciontercen.tip_tecnologia%TYPE,
      ev_tip_terminal                  icg_actuaciontercen.tip_terminal%TYPE,
      sc_servsupl         OUT NOCOPY   refcursor,
      sn_cod_retorno      OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY   ge_errores_pg.evento);

/***********************************************************************************************************************************************************************/
   PROCEDURE ve_valida_compatibilidad_ss_pr (
      ev_cod_servicio                ga_servsup_def.cod_servicio%TYPE,
      ev_cod_servdef                 ga_servsup_def.cod_servdef%TYPE,
      sn_ind_compatib   OUT NOCOPY   PLS_INTEGER,                                                                                                                                                                                --0:compatible,1:incompatible
      sn_cod_retorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento);

   PROCEDURE ve_consulta_ss_pp_pr (
      ev_cod_actabo                  ga_actabo.cod_actabo%TYPE,
      ev_cod_planserv                ga_planserv.cod_planserv%TYPE,
      ev_tip_terminal                ga_aboamist.tip_terminal%TYPE,
      en_cod_sistema                 icg_serviciotercen.cod_sistema%TYPE,
      en_cod_uso                     al_usos.cod_uso%TYPE,
      sc_sspp           OUT NOCOPY   refcursor,
      sn_cod_retorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento);

/***********************************************************************************************************************************************************************/
   PROCEDURE ve_consulta_ss_disp_pr (
      ev_cod_plantarif                 ta_plantarif.cod_plantarif%TYPE,
      en_cod_tiplan                    ta_plantarif.cod_tiplan%TYPE,
      ev_cod_planserv                  ga_planserv.cod_planserv%TYPE,
      ev_cod_tecnologia                al_tecnologia.cod_tecnologia%TYPE,
      ev_tip_terminal                  ga_aboamist.tip_terminal%TYPE,
      en_cod_uso                       al_usos.cod_uso%TYPE,
      en_cod_sistema                   icg_serviciotercen.cod_sistema%TYPE,
      sc_ss               OUT NOCOPY   refcursor,
      sn_cod_actcen       OUT NOCOPY   ga_actabo.cod_actcen%TYPE,
      sn_cod_retorno      OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY   ge_errores_pg.evento);

/***********************************************************************************************************************************************************************/
   PROCEDURE ve_consulta_ligados_pr (
      ev_cod_servicio                ga_servsup_def.cod_servicio%TYPE,
      sc_ss             OUT NOCOPY   refcursor,
      sn_cod_retorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento);

/****************************************************************************/
   PROCEDURE ve_obtener_fecha_sistema_pr (
      sd_fecha          OUT          VARCHAR2,
      sn_cod_retorno    OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento);

/******************************************************************************/
   PROCEDURE ve_valida_vendedor_pr (
      en_cod_vendedor   IN              ve_vendedores.cod_vendedor%TYPE,
      en_tipo           IN              NUMBER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

/******************************************************************************/
   PROCEDURE ve_obtener_datos_ss_pr (
      en_numerocelular   IN              ga_abocel.num_celular%TYPE,
      ev_cod_servicio    IN              ga_servsupl.cod_servicio%TYPE,
      sn_cod_grupo       OUT NOCOPY      ga_servsupl.cod_servsupl%TYPE,
      sn_cod_nivel       OUT NOCOPY      ga_servsupl.cod_nivel%TYPE,
      sv_cod_concfact    OUT NOCOPY      ga_actuaserv.cod_concepto%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento);

/******************************************************************************/
   PROCEDURE ve_consulta_ss_pp_pr2 (
      ev_cod_actabo                  ga_actabo.cod_actabo%TYPE,
      ev_cod_planserv                ga_planserv.cod_planserv%TYPE,
      ev_tip_terminal                ga_aboamist.tip_terminal%TYPE,
      en_cod_sistema                 icg_serviciotercen.cod_sistema%TYPE,
      en_cod_uso                     al_usos.cod_uso%TYPE,
      en_cod_servicio                ga_servsupl.cod_servicio%TYPE,
      sn_cod_concepto   OUT NOCOPY   fa_conceptos.cod_concepto%TYPE,
      sn_cod_servsupl   OUT NOCOPY   ga_servsupl.cod_servsupl%TYPE,
      sn_cod_nivel      OUT NOCOPY   ga_servsupl.cod_nivel%TYPE,
      sn_cod_retorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento);

/******************************************************************************/
   PROCEDURE ve_consulta_ss_opc_pr2 (
      ev_cod_actabo                    ga_actabo.cod_actabo%TYPE,
      ev_cod_plantarif                 ta_plantarif.cod_plantarif%TYPE,
      en_cod_tiplan                    ta_plantarif.cod_tiplan%TYPE,
      ev_cod_tecnologia                al_tecnologia.cod_tecnologia%TYPE,
      ev_cod_planserv                  ga_planserv.cod_planserv%TYPE,
      en_cod_servicio                  ga_servsupl.cod_servicio%TYPE,
      sn_cod_concepto     OUT NOCOPY   fa_conceptos.cod_concepto%TYPE,
      sn_cod_servsupl     OUT NOCOPY   ga_servsupl.cod_servsupl%TYPE,
      sn_cod_nivel        OUT NOCOPY   ga_servsupl.cod_nivel%TYPE,
      sn_cod_retorno      OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY   ge_errores_pg.evento);

/******************************************************************************/
   PROCEDURE ve_actualiza_claseserv_pr (
      ev_numeroabonado   IN              ga_abocel.num_abonado%TYPE,
      ev_claseservicio   IN              ga_abocel.clase_servicio%TYPE,
      ev_tipoplantarif   IN              ta_plantarif.cod_tiplan%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento);

/******************************************************************************/

     PROCEDURE ve_acep_venta_pr (
      so_ventas         IN OUT NOCOPY   ve_tipos_pg.tip_ga_ventas,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

/******************************************************************************/

   PROCEDURE ve_cons_plan_tarif_clie_emp_pr (
      ev_plantarif           IN              ta_plantarif.cod_plantarif%TYPE,
      en_codproducto         IN              ga_modvent_aplic.cod_producto%TYPE,
      sn_cod_retorno         OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno        OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento          OUT NOCOPY      ge_errores_pg.evento);

/******************************************************************************/

   PROCEDURE ve_list_tip_ident_pr (
      sc_tipos_ident         OUT NOCOPY      refcursor,
      sn_cod_retorno         OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno        OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento          OUT NOCOPY      ge_errores_pg.evento);

/******************************************************************************/

PROCEDURE VE_actualiza_abovendealer_PR (
      en_numabonado       IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

END VE_SERVICIOS_VENTA_QUIOSCO_PG;
/

SHOW ERRORS

