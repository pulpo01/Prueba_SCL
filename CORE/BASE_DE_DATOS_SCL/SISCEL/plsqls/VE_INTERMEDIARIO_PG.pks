CREATE OR REPLACE PACKAGE ve_intermediario_pg
IS
/*
<Documentación TipoDoc = "PACKAGE"
 <Elemento Nombre = "VE_intermediario_PG"
           Lenguaje="PL/SQL"
           Fecha="08-01-2007"
           Versión="1.0"
           Diseñador="wjrc"
           Programador="wjrc"
           Ambiente="DEIMOS_ECU">
  <Retorno>NA</Retorno>
   <Descripción> Encabezado de VE_intermediario_PG</Descripción>>
    <Parámetros>
    </Parámetros>
 </Elemento>
</Documentación>
*/      -- Nombre del package
   cv_nombre_package       CONSTANT VARCHAR2 (19) := 'VE_intermediario_PG';

   TYPE tipoarray IS VARRAY (1000) OF VARCHAR2 (30);

   -- Declaraciones globales a los packages ------------------------------------------------------------
   -- !!! no borrar por dependencia de otros packages
   cv_error_seqcliente     CONSTANT NUMBER        := 999;
   cv_error_no_clasif      CONSTANT VARCHAR2 (30) := 'Error no clasificado';
   cn_largoerrtec          CONSTANT NUMBER        := 4000;
   cn_largodesc            CONSTANT NUMBER        := 2000;
   cn_producto             CONSTANT NUMBER        := 1;
   cv_modulo_ga            CONSTANT VARCHAR2 (2)  := 'GA';    -- gestion abonados
   cv_modulo_ge            CONSTANT VARCHAR2 (2)  := 'GE';    -- generales
   cv_modulo_fa            CONSTANT VARCHAR2 (2)  := 'FA';    -- facturacion
   cv_modulo_ta            CONSTANT VARCHAR2 (2)  := 'TA';    -- tarificacion
   cv_cattribfactura       CONSTANT VARCHAR2 (1)  := 'F';     -- categoria tributaria factura
   cv_formatofecha         CONSTANT VARCHAR2 (10) := 'DD/MM/YYYY';
   cn_indicadorweb         CONSTANT NUMBER        := 1;    -- indicador planes web
   cn_tipodirfacturacion   CONSTANT NUMBER        := 1;    -- tipo direccion : facturacion
   cn_codciclo25           CONSTANT NUMBER        := 25;   -- codigo ciclo 25
   cn_tipplan_prepago      CONSTANT NUMBER        := 1;    -- tipo plan : prepago
   cn_tipplan_postpago     CONSTANT NUMBER        := 2;    -- tipo plan : postpago
   cn_tipplan_hibrido      CONSTANT NUMBER        := 3;    -- tipo plan : hibrido
   cn_usopostpago          CONSTANT NUMBER        := 2;    -- uso postpago
   cn_usoprepago           CONSTANT NUMBER        := 3;    -- uso prepago
   cn_usoahorro            CONSTANT NUMBER        := 10;   -- uso ahorro  o hibrido
   cn_tipprodpostpago      CONSTANT NUMBER        := 0;    -- tipo producto postpago
   cn_tipprodprepago       CONSTANT NUMBER        := 1;    -- tipo producto prepago
   cn_tipprodhibrido       CONSTANT NUMBER        := 2;    -- tipo producto hibrido
   cv_estventa_pd          CONSTANT VARCHAR2 (2)  := 'PD'; -- pendiente documentar
   cv_estventa_pc          CONSTANT VARCHAR2 (2)  := 'PC'; -- pendiente cumplimentar
   cv_estventa_pa          CONSTANT VARCHAR2 (2)  := 'PA'; -- pendiente aceptacion
   cv_estventa_ac          CONSTANT VARCHAR2 (2)  := 'AC'; -- aceptacion de la venta
   cv_actabo_av            CONSTANT VARCHAR2 (2)  := 'AV'; -- aceptacion de la venta
   CV_REPONE_CELULAR   CONSTANT VARCHAR(1)   := 'R';  --Indica reposición de numero celular
    TYPE refcursor                  IS REF CURSOR;
-----------------------------------------------------------------------------------------------
   ci_true                 CONSTANT PLS_INTEGER   := 1;
   ci_false                CONSTANT PLS_INTEGER   := 0;
   cv_formato_fecha        CONSTANT VARCHAR2 (12) := 'FORMATO_SEL2';
   cv_procnumero           CONSTANT VARCHAR2 (1)  := 'R';   -- Indicativo de Procedencia del número : (R)eutilizable
   ci_altamayorista        CONSTANT PLS_INTEGER   := 1;
-----------------------------------------------------------------------------------------------
   FUNCTION ve_obtieneformatofecha_fn (
      sn_cod_retorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento
   )
      RETURN VARCHAR2;
-----------------------------------------------------------------------------------------------
   FUNCTION ve_obtienenumdiasnum_fn (
      sn_cod_retorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento
   )
      RETURN NUMBER;
-----------------------------------------------------------------------------------------------
   FUNCTION ve_descompone_cadena_fn (
      ev_cadena           IN              VARCHAR2,
      en_largosubstring   IN              NUMBER,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN tipoarray;
-----------------------------------------------------------------------------------------------
   FUNCTION ve_descompone_cadena_fn (
      ev_cadena         IN              VARCHAR2,
      ev_separador      IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN tipoarray;
-----------------------------------------------------------------------------------------------
   PROCEDURE ve_obtiene_valor_parametro_pr (
      ev_nomparametro   IN              ged_parametros.nom_parametro%TYPE,
      ev_codmodulo      IN              ged_parametros.cod_modulo%TYPE,
      ev_codproducto    IN              ged_parametros.cod_producto%TYPE,
      sv_valparametro   OUT NOCOPY      ged_parametros.val_parametro%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------
   PROCEDURE ve_obtiene_secuencia_pr (
      ev_nomsecuencia   IN              VARCHAR2,
      sv_secuencia      OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------
   PROCEDURE ve_bloqdesbloq_vendedor_pr (
      ev_codvendedor    IN              ve_vendedores.cod_vendedor%TYPE,
      ec_accion         IN              CHAR,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------
   PROCEDURE ve_obtienenumerocelularaut_pr (
      ev_codsubalm       IN              VARCHAR2,
      ev_codcentral      IN              VARCHAR2,
      ev_coduso          IN              VARCHAR2,
      ev_codactabo       IN              VARCHAR2,
      sv_numerocelular   OUT NOCOPY      VARCHAR2,
      sv_tipocelular     OUT NOCOPY      VARCHAR2,
      sv_categoria       OUT NOCOPY      VARCHAR2,
      sv_fechabaja       OUT NOCOPY      VARCHAR2,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------
   PROCEDURE ve_reserva_numero_celular_pr (
      en_transaccion       IN              NUMBER,
      ev_numerolinea       IN              VARCHAR2,
      ev_numeroorden       IN              VARCHAR2,
      ev_numerocelular     IN              VARCHAR2,
      ev_codsubalmacen     IN              VARCHAR2,
      ev_codigocentral     IN              VARCHAR2,
      ev_codigocategoria   IN              VARCHAR2,
      ev_codigouso         IN              VARCHAR2,
      ev_indprocnumero     IN              VARCHAR2,
      ev_fecbajacelular    IN              VARCHAR2,
      sn_cod_retorno       OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------
   PROCEDURE ve_obtienegrupotecnologico_pr (
      ev_tecnologia     IN              VARCHAR2,
      sv_valor          OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------
   PROCEDURE ve_ejecuta_prebilling_pr (
      ev_sec_transacabo   IN              VARCHAR2,
      ev_actprebilling    IN              VARCHAR2,
      ev_productogral     IN              VARCHAR2,
      ev_cod_cliente      IN              VARCHAR2,
      ev_num_venta        IN              VARCHAR2,
      ev_num_transacvta   IN              VARCHAR2,
      ev_num_procfact     IN              VARCHAR2,
      ev_modgeneracion    IN              VARCHAR2,
      ev_cattributaria    IN              VARCHAR2,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------
   PROCEDURE ve_obtieneplaza_cliente_pr (
      scodcliente       IN              ga_ventas.cod_cliente%TYPE,
      codplazacliente   OUT NOCOPY      ga_ventas.cod_plaza%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------
   PROCEDURE ve_obtieneplaza_oficina_pr (
      scodoficina       IN              ga_ventas.cod_oficina%TYPE,
      codplazaoficina   OUT NOCOPY      ga_ventas.cod_plaza%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

 ----------------------------------------------------------------------------------------------

  PROCEDURE ve_obtienepresupuesto_pr (
      en_num_proceso    IN              ga_presupuesto.num_proceso%TYPE,
      sn_cargos         OUT NOCOPY      ga_presupuesto.imp_base%TYPE,
      sn_descuentos     OUT NOCOPY      ga_presupuesto.imp_dto%TYPE,
      sn_impuestos      OUT NOCOPY      ga_presupuesto.imp_impuesto%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------
    PROCEDURE VE_ObtienePresupuestoDesc_PR(EN_num_proceso    IN  ga_presupuesto.num_proceso%TYPE,
                                       SN_cargos         OUT NOCOPY ga_presupuesto.imp_base%TYPE,
                                       SN_descuentos     OUT NOCOPY ga_presupuesto.imp_dto%TYPE,
                                       SN_impuestos      OUT NOCOPY ga_presupuesto.imp_impuesto%TYPE,
                                       SC_cursordatos    OUT NOCOPY REFCURSOR,
                                       SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);
-----------------------------------------------------------------------------------------------
   PROCEDURE ve_obtieneoperadora_pr (
      sv_codoperadora   OUT NOCOPY   VARCHAR2,
      sn_cod_retorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------
   PROCEDURE ve_obtieneoperadora_pr (
      sv_codoperadora   OUT NOCOPY   VARCHAR2,
      sv_desoperadora   OUT NOCOPY   VARCHAR2,
      sn_cod_retorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------
   PROCEDURE ve_numeracion_manual_pr (
      ev_numcelular     IN              VARCHAR2,
      ev_tipocelular    IN              VARCHAR2,
      ev_codcatcel      IN              VARCHAR2,
      ev_coduso         IN              VARCHAR2,
      ev_codcentral     IN              VARCHAR2,
      ev_codsubalm      IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------
   PROCEDURE ve_obtiene_transaccion_pr (
      en_transaccion    IN              NUMBER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------
   PROCEDURE ve_obtiene_prefijo_num_pr (
      en_numcelular     IN              ga_abocel.num_celular%TYPE,
      sv_numprefijo     OUT NOCOPY      ga_celnum_subalm.num_min%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------
   PROCEDURE ve_valida_autentificacion_pr (
      ev_numserie       IN              al_series.num_serie%TYPE,
      ev_procedencia    IN              VARCHAR2,
      en_coduso         IN              al_usos.cod_uso%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------
   PROCEDURE ve_obtiene_imsi_simcard_pr (
      ev_num_serie      IN              gsm_det_simcard_to.num_simcard%TYPE,
      ev_cod_campo      IN              gsm_campos_to.cod_campo%TYPE,
      sv_imsi           OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------
   PROCEDURE ve_actualiza_stock_pr (
      ev_tipomovto       IN              VARCHAR2,
      ev_tipstock        IN              VARCHAR2,
      ev_codbodega       IN              VARCHAR2,
      ev_codarticulo     IN              VARCHAR2,
      ev_coduso          IN              VARCHAR2,
      ev_codestado       IN              VARCHAR2,
      ev_numventa        IN              VARCHAR2,
      ev_numserie        IN              VARCHAR2,
      ev_indtelef        IN              VARCHAR2,
      sv_nummovimiento   OUT NOCOPY      VARCHAR2,
      sv_indsercontel    OUT NOCOPY      VARCHAR2,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------
   PROCEDURE ve_getconsumefolio_pr (
      sv_valor          OUT NOCOPY   ged_parametros.val_parametro%TYPE,
      sn_cod_retorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------
   PROCEDURE ve_getdatosgener_pr (
      ev_columna        IN              VARCHAR2,
      sv_valor          OUT NOCOPY      ged_parametros.val_parametro%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------
    PROCEDURE VE_ValidarIdentificador_PR(EV_modulo         IN  VARCHAR2,
                                             EN_correlativo    IN  NUMBER,
                                             EV_numIdentif     IN  VARCHAR2,
                                             EV_tipoIdentif    IN  VARCHAR2,
                                             SV_num_ident      OUT NOCOPY GE_CLIENTES.NUM_IDENT%TYPE,
                                             SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                             SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);
-----------------------------------------------------------------------------------------------
   PROCEDURE ve_obtienecategoriacta_pr (
      ev_numidentif     IN              VARCHAR2,
      ev_codcategtrib   IN              VARCHAR2,
      ev_tipomodulo     IN              VARCHAR2,
      sv_codcategoria   OUT NOCOPY      VARCHAR2,
      sv_codsubcateg    OUT NOCOPY      VARCHAR2,
      sv_codmultuso     OUT NOCOPY      VARCHAR2,
      sv_codcliepot     OUT NOCOPY      VARCHAR2,
      sv_desrazon       OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------
   PROCEDURE ve_getminmdn_pr (
      ev_numcelular     IN              VARCHAR2,
      sv_minmdn         OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------
   PROCEDURE ve_obtieneplazacliente_pr (
      ev_codcliente     IN              VARCHAR2,
      sn_codplaza       OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------
   PROCEDURE ve_getorigenventa_pr (
      ev_numeroserie           IN              VARCHAR2,
      sv_codigouso             OUT NOCOPY      VARCHAR2,
      sv_descripcionuso        OUT NOCOPY      VARCHAR2,
      sv_codigoarticulo        OUT NOCOPY      VARCHAR2,
      sv_descripcionarticulo   OUT NOCOPY      VARCHAR2,
      sn_cod_retorno           OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno          OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento            OUT NOCOPY      ge_errores_pg.evento
   );

------------------------------------------------------------------------------------------------------------------------------------------
-- MANEJO DE ERRORES EN LOS PROCEDIMIENTOS : EXCEPTION
-- !!! no borrar por dependencia de otros packages
------------------------------------------------------
   PROCEDURE ve_nodatafoundcursor_pr (
      ev_nompackage     IN              VARCHAR2,
      ev_nomprocedure   IN              VARCHAR2,
      ev_sql            IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------
   PROCEDURE ve_others_pr (
      ev_nompackage     IN              VARCHAR2,
      ev_nomprocedure   IN              VARCHAR2,
      ev_sql            IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------
   PROCEDURE ve_errorsql_pr (
      ev_nompackage     IN              VARCHAR2,
      ev_nomprocedure   IN              VARCHAR2,
      ev_sql            IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------
   PROCEDURE ve_notdatafound_pr (
      ev_nompackage     IN              VARCHAR2,
      ev_nomprocedure   IN              VARCHAR2,
      ev_sql            IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------
   PROCEDURE ve_errorparametro_pr (
      ev_nompackage     IN              VARCHAR2,
      ev_nomprocedure   IN              VARCHAR2,
      ev_sql            IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------
   PROCEDURE ve_obtenerhomenonumerado_pr (
      ev_numicc         IN       al_series.num_serie%TYPE,
      ev_actabo         IN       ga_actabo.cod_actabo%TYPE,
      ev_uso            IN       al_usos.cod_uso%TYPE,
      ev_codvendedor    IN       ve_vendedores.cod_vendedor%TYPE,
      sn_numtelefono    OUT      al_series.num_telefono%TYPE,
      sn_codsubalm      OUT      al_series.cod_subalm%TYPE,
      sv_codcentral     OUT      al_series.cod_central%TYPE,
      sv_codhlr         OUT      al_series.cod_hlr%TYPE,
      sv_codcelda       OUT      ge_celdas.cod_celda%TYPE,
      sv_region         OUT      ge_direcciones.cod_region%TYPE,
      sv_provincia      OUT      ge_direcciones.cod_provincia%TYPE,
      sv_ciudad         OUT      ge_direcciones.cod_ciudad%TYPE,
      sn_cod_retorno    OUT      ge_errores_pg.coderror,
      sv_mens_retorno   OUT      ge_errores_pg.msgerror,
      sn_num_evento     OUT      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------
   PROCEDURE ve_valida_serie_gsm_pr (
      ev_numserie       IN       al_series.num_serie%TYPE,
      sn_cod_retorno    OUT      ge_errores_pg.coderror,
      sv_mens_retorno   OUT      ge_errores_pg.msgerror,
      sn_num_evento     OUT      ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------
   PROCEDURE ve_numeracion_automatica_pr (
      vp_transac   IN   VARCHAR2,
      vp_actabo    IN   VARCHAR2,
      vp_subalm    IN   VARCHAR2,
      vp_central   IN   VARCHAR2,
      vp_uso       IN   VARCHAR2
   );
   PROCEDURE VE_reponeNumeracion_PR (EN_num_celular   IN  ga_resnumcel.num_celular%TYPE,
                                      SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);
-----------------------------------------------------------------------------------------------
PROCEDURE VE_reponeNumeracion_PR (EN_num_celular   IN  ga_resnumcel.num_celular%TYPE,
                                      EV_tip_repos     IN  VARCHAR2,
                                      SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE VE_ActualizaLimAbo_PR (EN_num_abonado   IN  ga_Abocel.num_abonado%TYPE,
                                 EN_MontoLimCons  IN  GA_LCABO_TO.IMP_LIMCONS%TYPE,
                                    SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                 SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                 SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);
--Inicio P-CSR-11002 JLGN 18-10-2011    
PROCEDURE VE_desArticulo_PR (EN_cod_articulo IN  al_articulos.cod_articulo%TYPE,
                             SV_des_articulo OUT NOCOPY al_articulos.des_articulo%TYPE,
                             SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                             SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                             SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);     
--Inicio P-CSR-11002 JLGN 10-11-2011 
PROCEDURE ve_in_ruta_contrato_pg (en_num_venta IN ga_ventas.num_venta%TYPE,
                                  ev_ruta      IN ve_ruta_contrato_venta_td.ruta_contrato%TYPE,
                                  SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                  SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                  SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);   
--Inicio P-CSR-11002 JLGN 11-11-2011 
PROCEDURE ve_obt_ruta_contrato_pg (en_num_venta    IN ga_ventas.num_venta%TYPE,
                                   ev_ruta         OUT NOCOPY ve_ruta_contrato_venta_td.ruta_contrato%TYPE,
                                   SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE VE_obtiene_numero_movi_PR(EV_numserie      IN ga_equipaboser.NUM_SERIE%TYPE,
                                          SN_nummovimiento  OUT NOCOPY ga_equipaboser.NUM_MOVIMIENTO%TYPE,
                                          SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);                                   
END ve_intermediario_pg;
/
SHOW ERRORS