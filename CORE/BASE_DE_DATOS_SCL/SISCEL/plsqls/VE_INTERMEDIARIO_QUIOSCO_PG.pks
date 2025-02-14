CREATE OR REPLACE PACKAGE ve_intermediario_quiosco_pg IS
/*
<Documentación TipoDoc = "PACKAGE"
 <Elemento Nombre = "ve_intermediario_quiosco_pg"
           Lenguaje="PL/SQL"
           Fecha="08-01-2007"
           Versión="1.0"
           Diseñador="wjrc"
           Programador="wjrc"
           Ambiente="DEIMOS_ECU">
  <Retorno>NA</Retorno>
   <Descripción> Encabezado de ve_intermediario_quiosco_pg</Descripción>>
    <Parámetros>
    </Parámetros>
 </Elemento>Documentación>
*/
   TYPE tipoarray IS VARRAY (20) OF VARCHAR2 (30);

   cv_producto          CONSTANT VARCHAR (1)   := '1';
   cv_modulo_ga         CONSTANT VARCHAR2 (2)  := 'GA';
   cv_modulo_ge         CONSTANT VARCHAR2 (2)  := 'GE';
   ci_true              CONSTANT PLS_INTEGER   := 1;
   ci_false             CONSTANT PLS_INTEGER   := 0;
   cv_formato_fecha     CONSTANT VARCHAR2 (12) := 'FORMATO_SEL2';
   cv_procnumero        CONSTANT VARCHAR2 (1)  := 'R';                                                                                                                                                -- Indicativo de Procedencia del número : (R)eutilizable
   cv_error_no_clasif   CONSTANT VARCHAR2 (30) := 'Error no clasificado';
   cv_repone_celular    CONSTANT VARCHAR (1)   := 'R';
   cv_imei_dummy        CONSTANT VARCHAR (20)  := '000000000000010';      -- GDO INC 147741 30-09-2010                                                                                                                                                --Indica reposición de numero celular

   FUNCTION ve_obtieneformatofecha_fn (
      sn_cod_retorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento)
      RETURN VARCHAR2;

   FUNCTION ve_obtienenumdiasnum_fn (
      sn_cod_retorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento)
      RETURN NUMBER;

   FUNCTION ve_descompone_cadena_fn (
      ev_cadena           IN              VARCHAR2,
      en_largosubstring   IN              NUMBER,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento)
      RETURN tipoarray;

   FUNCTION ve_descompone_cadena_fn (
      ev_cadena         IN              VARCHAR2,
      ev_separador      IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
      RETURN tipoarray;

   PROCEDURE ve_obtiene_valor_parametro_pr (
      ev_nomparametro   IN              ged_parametros.nom_parametro%TYPE,
      ev_codmodulo      IN              ged_parametros.cod_modulo%TYPE,
      ev_codproducto    IN              ged_parametros.cod_producto%TYPE,
      sv_valparametro   OUT NOCOPY      ged_parametros.val_parametro%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_obtiene_secuencia_pr (
      ev_nomsecuencia   IN              VARCHAR2,
      sv_secuencia      OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_bloqdesbloq_vendedor_pr (
      ev_codvendedor    IN              ve_vendedores.cod_vendedor%TYPE,
      ec_accion         IN              CHAR,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);
/*procedimiento comentado debido a que la llamada al método  ve_numeracion_pg.p_numeracion_automatica_pr no existe.*/
/*método ve_obtienenumerocelularaut_pr habilitado nuevamente*/
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
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento);


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
	  ev_usuarioora        IN              VARCHAR2,
      sn_cod_retorno       OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_obtienegrupotecnologico_pr (
      ev_tecnologia     IN              VARCHAR2,
      sv_valor          OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

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
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento);

-----------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_obtieneplaza_cliente_pr (
      scodcliente       IN              ga_ventas.cod_cliente%TYPE,
      codplazacliente   OUT NOCOPY      ga_ventas.cod_plaza%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

-----------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_obtieneplaza_oficina_pr (
      scodoficina       IN              ga_ventas.cod_oficina%TYPE,
      codplazaoficina   OUT NOCOPY      ga_ventas.cod_plaza%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

-----------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_obtienepresupuesto_pr (
      en_num_proceso    IN              NUMBER,
      sn_cargos         OUT NOCOPY      NUMBER,
      sn_descuentos     OUT NOCOPY      NUMBER,
      sn_impuestos      OUT NOCOPY      NUMBER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

-----------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_obtieneoperadora_pr (
      sv_codoperadora   OUT NOCOPY   VARCHAR2,
      sn_cod_retorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento);

   PROCEDURE ve_obtieneoperadora_pr (
      sv_codoperadora   OUT NOCOPY   VARCHAR2,
      sv_desoperadora   OUT NOCOPY   VARCHAR2,
      sn_cod_retorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento);

-----------------------------------------------------------------------------------------------------------------
/*Se comenta debido a que el método invocado ve_numeracion_pg.p_numeracion_manual_pr  no existe */
/*
 PROCEDURE ve_numeracion_manual_pr (
      ev_num_celular      IN              VARCHAR2,
      ev_tip_numeracion   IN              VARCHAR2,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento);
*/
-----------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_obtiene_transaccion_pr (
      en_transaccion    IN              NUMBER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_obtiene_prefijo_num_pr (
      en_numcelular     IN              ga_abocel.num_celular%TYPE,
      sv_numprefijo     OUT NOCOPY      ga_celnum_subalm.num_min%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_valida_autentificacion_pr (
      ev_numserie       IN              al_series.num_serie%TYPE,
      ev_procedencia    IN              VARCHAR2,
      en_coduso         IN              al_usos.cod_uso%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_obtiene_imsi_simcard_pr (
      ev_num_serie      IN              gsm_det_simcard_to.num_simcard%TYPE,
      ev_cod_campo      IN              gsm_campos_to.cod_campo%TYPE,
      sv_imsi           OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

------------------------------------------------------------------------------------------------------------------------------------------
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
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento);

------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_getconsumefolio_pr (
      sv_valor          OUT NOCOPY   ged_parametros.val_parametro%TYPE,
      sn_cod_retorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento);

------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_getdatosgener_pr (
      ev_columna        IN              VARCHAR2,
      sv_valor          OUT NOCOPY      ged_parametros.val_parametro%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_validaridentificador_pr (
      ev_modulo         IN              VARCHAR2,
      en_correlativo    IN              NUMBER,
      ev_numidentif     IN              VARCHAR2,
      ev_tipoidentif    IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_obtienecategoriacta_pr (
      ev_numidentif     IN              VARCHAR2,
      ev_codcategtrib   IN              VARCHAR2,
      ev_tipomodulo     IN              VARCHAR2,
      ev_tipidentif     IN              VARCHAR2,
      sv_codcategoria   OUT NOCOPY      VARCHAR2,
      sv_codsubcateg    OUT NOCOPY      VARCHAR2,
      sv_codmultuso     OUT NOCOPY      VARCHAR2,
      sv_codcliepot     OUT NOCOPY      VARCHAR2,
      sv_desrazon       OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_getminmdn_pr (
      ev_numcelular     IN              VARCHAR2,
      sv_minmdn         OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_obtieneplazacliente_pr (
      ev_codcliente     IN              VARCHAR2,
      sn_codplaza       OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_validarepeticiongsm_pr (
      ev_numserie       IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_validaformatogsm_pr (
      ev_numserie       IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_reponenumeracion_pr (
      en_num_celular    IN              ga_resnumcel.num_celular%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_reponenumeracion_pr (
      en_num_celular    IN              ga_resnumcel.num_celular%TYPE,
      ev_tip_repos      IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_validatarjeta_pr (
      ev_cod_tarjeta    IN              VARCHAR2,
      ev_num_tarjeta    IN              VARCHAR2,
      sv_resultado      OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);
--inc. 94818 22-06-2009
END ve_intermediario_quiosco_pg;
/

SHOW ERRORS