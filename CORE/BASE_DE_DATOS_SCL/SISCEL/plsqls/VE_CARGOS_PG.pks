CREATE OR REPLACE PACKAGE ve_cargos_pg
AS
   cv_modulove           CONSTANT VARCHAR2 (5) := 'VE';
   cv_categoria          CONSTANT VARCHAR2 (5) := 'ZZZ';
   cn_kit                CONSTANT NUMBER       := 20;
   cn_ind_recambio       CONSTANT NUMBER       := 9;
   cn_largodesc          CONSTANT NUMBER       := 2000;
   cv_cod_modulo         CONSTANT VARCHAR2 (2) := 'VE';
   cn_largoerrtec        CONSTANT NUMBER       := 4000;
   cv_cod_calificacion   CONSTANT VARCHAR (2)  := 'A';            --CSR-11002

   TYPE refcursor IS REF CURSOR;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_obtiene_venta_kit_pr (
      en_numventa       IN              NUMBER,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_consulta_kit_pr (
      ev_serie          IN              al_series.num_serie%TYPE,
      sv_tipostock      OUT NOCOPY      al_series.tip_stock%TYPE,
      sn_codarticulo    OUT NOCOPY      al_series.cod_articulo%TYPE,
      sn_indvalorar     OUT NOCOPY      al_tipos_stock.ind_valorar%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_preccargokit_prelis_pr (
      en_codarticulo    IN              al_precios_venta.cod_articulo%TYPE,
      en_tipstock       IN              al_precios_venta.tip_stock%TYPE,
      en_codusoventa    IN              al_precios_venta.cod_uso%TYPE,
      en_codestado      IN              al_precios_venta.cod_estado%TYPE,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_precarkit_noprelis_pr (
      en_codarticulo     IN              al_precios_venta.cod_articulo%TYPE,
      en_tipstock        IN              al_precios_venta.tip_stock%TYPE,
      en_codusoventa     IN              al_precios_venta.cod_uso%TYPE,
      en_codestado       IN              al_precios_venta.cod_estado%TYPE,
      en_modventa        IN              al_precios_venta.cod_modventa%TYPE,
      ev_tipocontrato    IN              ga_percontrato.cod_tipcontrato%TYPE,
      ev_plantarif       IN              ve_catplantarif.cod_plantarif%TYPE,
      en_codusoprepago   IN              al_precios_venta.cod_uso%TYPE,
      ev_indequipo       IN              al_articulos.ind_equiacc%TYPE,
      sc_cursordatos     OUT NOCOPY      refcursor,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_obtiene_abo_ven_nokit_pr (
      en_numventa       IN              NUMBER,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_obtiene_info_cargos_pr (
      en_numventa       IN              NUMBER,
      en_num_proceso    IN              NUMBER,
      sn_total_cargos   OUT NOCOPY      NUMBER,
      sn_total_itmb     OUT NOCOPY      NUMBER,
      sn_total_ics      OUT NOCOPY      NUMBER,
      sn_total_apagar   OUT NOCOPY      NUMBER,
      sn_num_folio      OUT NOCOPY      NUMBER,
      sv_pref_plaza     OUT NOCOPY      VARCHAR2,
      sc_cargosseries   OUT NOCOPY      refcursor,
      sn_imp_cruzroja   OUT NOCOPY      NUMBER,
      sn_imp_911        OUT NOCOPY      NUMBER,
      sn_imp_venta      OUT NOCOPY      NUMBER,
      sn_descuento      OUT NOCOPY      NUMBER,
      sv_serie          OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_ins_quios_vent_pr (
      en_num_venta      IN              NUMBER,
      en_cod_cliente    IN              NUMBER,
      ev_nomusuarioad   IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ce_aplica_pago_pr (
      prevempresa         IN       VARCHAR2,
      prevcaja            IN       VARCHAR2,
      prevcodser          IN       VARCHAR2,
      prevfechaefectiva   IN       VARCHAR2,
      prevnum_oper        IN       VARCHAR2,
      prevoperador        IN       VARCHAR2,
      prevtipo            IN       VARCHAR2,
      prevsubtipo         IN       VARCHAR2,
      prevcod_servicio    IN       VARCHAR2,
      prevci_fecontab     IN       VARCHAR2,
      prevcliente         IN       VARCHAR2,
      prevcelular         IN       VARCHAR2,
      prevmonto           IN       VARCHAR2,
      prevfolio           IN       VARCHAR2,
      prevrut             IN       VARCHAR2,
      prevmodpago         IN       VARCHAR2,
      prevnumdocum        IN       VARCHAR2,
      prevbcodocum        IN       VARCHAR2,
      prevctacte          IN       VARCHAR2,
      prevcodauto         IN       VARCHAR2,
      pnumtarjeta         IN       VARCHAR2,
      presul              OUT      VARCHAR2,
      pdescripcion        OUT      VARCHAR2,
      pcodoperacion       IN       VARCHAR2 DEFAULT '1',
      pnumventa           IN       NUMBER DEFAULT NULL,
      pnumfolio           IN       NUMBER DEFAULT NULL,
      pcodplansrv         IN       VARCHAR2 DEFAULT NULL
   );
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END ve_cargos_pg;
/
SHOW ERRORS