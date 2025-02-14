CREATE OR REPLACE PACKAGE ve_validacion_linea_quiosco_pg IS
   cv_cod_modulo        CONSTANT VARCHAR2 (2)  := 'VE';
   cn_largoerrtec       CONSTANT NUMBER        := 4000;
   cn_largodesc         CONSTANT NUMBER        := 2000;
   cv_codproducto       CONSTANT VARCHAR (1)   := '1';
   cv_error_no_clasif   CONSTANT VARCHAR2 (30) := 'Error no clasificado';
   cv_codmodulo         CONSTANT VARCHAR2 (2)  := 'GA';
   ci_true              CONSTANT PLS_INTEGER   := 1;
   ci_false             CONSTANT PLS_INTEGER   := 0;
   cv_baja_abonado      CONSTANT VARCHAR2 (3)  := 'BAA';
   cv_tipodireccion     CONSTANT VARCHAR2 (1)  := '1';
   cv_venta_rechazada   CONSTANT VARCHAR2 (5)  := 'RE';

   TYPE array_parametros_ IS TABLE OF VARCHAR2 (5)
      INDEX BY BINARY_INTEGER;

   FUNCTION ve_convertir_fn (
      eb_valor   IN   BOOLEAN)
      RETURN PLS_INTEGER;

   PROCEDURE ve_existeserieabonado_pr (
      ev_seriesimcard   IN              ga_abocel.num_serie%TYPE,
      sb_resultado      OUT NOCOPY      BOOLEAN,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_existeserieabonado_pr (
      ev_seriesimcard   IN              ga_abocel.num_serie%TYPE,
      sn_resultado      OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_serieterminalenabonado_pr (
      ev_serieterminal   IN              ga_abocel.num_serie%TYPE,
      sb_resultado       OUT NOCOPY      BOOLEAN,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_serieterminalenabonado_pr (
      ev_serieterminal   IN              ga_abocel.num_serie%TYPE,
      sn_resultado       OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_existeseriebodega_pr (
      ev_serie          IN              al_series.num_serie%TYPE,
      sb_resultado      OUT NOCOPY      BOOLEAN,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_existeseriebodega_pr (
      ev_serie          IN              al_series.num_serie%TYPE,
      sn_resultado      OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_vendedorbodega_pr (
      ev_codvendedor    IN              ve_vendedores.cod_vendedor%TYPE,
      ev_codbodega      IN              al_series.cod_bodega%TYPE,
      sb_resultado      OUT NOCOPY      BOOLEAN,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_vendedorbodega_pr (
      ev_codvendedor    IN              ve_vendedores.cod_vendedor%TYPE,
      ev_codbodega      IN              al_series.cod_bodega%TYPE,
      sn_resultado      OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_terminallistanegra_pr (
      ev_serieterminal   IN              ga_abocel.num_serie%TYPE,
      sb_resultado       OUT NOCOPY      BOOLEAN,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_terminallistanegra_pr (
      ev_serieterminal   IN              ga_abocel.num_serie%TYPE,
      sn_resultado       OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_existe_plan_tarifario_pr (
      ev_plantarif      IN              ta_plantarif.cod_plantarif%TYPE,
      en_codproducto    IN              ga_modvent_aplic.cod_producto%TYPE,
      ev_tecnologia     IN              al_tecnologia.cod_tecnologia%TYPE,
      sb_resultado      OUT NOCOPY      BOOLEAN,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_existe_plan_tarifario_pr (
      ev_plantarif      IN              ta_plantarif.cod_plantarif%TYPE,
      en_codproducto    IN              ga_modvent_aplic.cod_producto%TYPE,
      ev_tecnologia     IN              al_tecnologia.cod_tecnologia%TYPE,
      sn_resultado      OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_vendedor_numero_pr (
      ev_numcelular     IN              ga_abocel.num_celular%TYPE,
      ev_codcliente     IN              ge_clientes.cod_cliente%TYPE,
      sv_codvendedor    OUT NOCOPY      ve_vendedores.cod_vendedor%TYPE,
      sv_coduso         OUT NOCOPY      al_usos.cod_uso%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   FUNCTION ve_existe_vendedor_fn (
      ev_cod_vendedor   IN              ve_vendedores.cod_vendedor%TYPE,
      ev_ind_interno    OUT NOCOPY      ve_vendedores.ind_interno%TYPE,
      sv_cod_cliente    OUT NOCOPY      ve_vendedores.cod_cliente%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
      RETURN BOOLEAN;

   PROCEDURE ve_existe_cliente_pr (
      ev_codcliente     IN              ge_clientes.cod_cliente%TYPE,
      sb_resultado      OUT NOCOPY      BOOLEAN,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_existe_cliente_pr (
      ev_codcliente     IN              ge_clientes.cod_cliente%TYPE,
      sn_resultado      OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_existe_cliente_empresa_pr (
      ev_codcliente     IN              ge_clientes.cod_cliente%TYPE,
      sb_resultado      OUT NOCOPY      BOOLEAN,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_existe_cliente_empresa_pr (
      ev_codcliente     IN              ge_clientes.cod_cliente%TYPE,
      sn_resultado      OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_agente_comercial_pr (
      ev_codcliente     IN              ge_clientes.cod_cliente%TYPE,
      sb_resultado      OUT NOCOPY      BOOLEAN,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_agente_comercial_pr (
      ev_codcliente     IN              ge_clientes.cod_cliente%TYPE,
      sn_resultado      OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_existe_evaluacion_riesgo_pr (
      ev_numident         IN              ge_clientes.num_ident%TYPE,
      ev_tipident         IN              ge_clientes.cod_tipident%TYPE,
      en_tipo_solicitud   IN              ert_solicitud.ind_tipo_solicitud%TYPE,
      en_ind_evento       IN              ert_solicitud.ind_evento%TYPE,
      ev_cod_estado       IN              VARCHAR2,
      ev_tipocliente      IN              VARCHAR2,
      sb_resultado        OUT NOCOPY      BOOLEAN,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_existe_evaluacion_riesgo_pr (
      ev_numident         IN              ge_clientes.num_ident%TYPE,
      ev_tipident         IN              ge_clientes.cod_tipident%TYPE,
      en_tipo_solicitud   IN              ert_solicitud.ind_tipo_solicitud%TYPE,
      en_ind_evento       IN              ert_solicitud.ind_evento%TYPE,
      ev_cod_estado       IN              VARCHAR2,
      ev_tipocliente      IN              VARCHAR2,
      sn_resultado        OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_existe_eriesgo_ptarif_pr (
      ev_numident         IN              ge_clientes.num_ident%TYPE,
      ev_tipident         IN              ge_clientes.cod_tipident%TYPE,
      en_tipo_solicitud   IN              ert_solicitud.ind_tipo_solicitud%TYPE,
      en_ind_evento       IN              ert_solicitud.ind_evento%TYPE,
      ev_cod_estado       IN              VARCHAR2,
      ev_plantarif        IN              ert_solicitud_planes.cod_plantarif%TYPE,
      sb_resultado        OUT NOCOPY      BOOLEAN,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_existe_eriesgo_ptarif_pr (
      ev_numident         IN              ge_clientes.num_ident%TYPE,
      ev_tipident         IN              ge_clientes.cod_tipident%TYPE,
      en_tipo_solicitud   IN              ert_solicitud.ind_tipo_solicitud%TYPE,
      en_ind_evento       IN              ert_solicitud.ind_evento%TYPE,
      ev_cod_estado       IN              VARCHAR2,
      ev_plantarif        IN              ert_solicitud_planes.cod_plantarif%TYPE,
      sn_resultado        OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_existe_contrato_pr (
      ev_numcontrato    IN              ga_contcta.num_contrato%TYPE,
      sb_resultado      OUT NOCOPY      BOOLEAN,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_existe_contrato_pr (
      ev_numcontrato    IN              ga_contcta.num_contrato%TYPE,
      sn_resultado      OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_actualiza_eriesgo_pr (
      ev_numsolicitud   IN              ert_solicitud.num_solicitud%TYPE,
      ev_cod_estado     IN              ert_solicitud.cod_estado%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_tipostock_valido_pr (
      ev_tipstock       IN              al_series.tip_stock%TYPE,
      ev_modventa       IN              ga_modvent_aplic.cod_modventa%TYPE,
      ev_codproducto    IN              ga_modvent_aplic.cod_producto%TYPE,
      sb_resultado      OUT NOCOPY      BOOLEAN,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_tipostock_valido_pr (
      ev_tipstock       IN              al_series.tip_stock%TYPE,
      ev_modventa       IN              ga_modvent_aplic.cod_modventa%TYPE,
      ev_codproducto    IN              ga_modvent_aplic.cod_producto%TYPE,
      sn_resultado      OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_existe_cuenta_pr (
      ev_codcuenta      IN              ga_cuentas.cod_cuenta%TYPE,
      sb_resultado      OUT NOCOPY      BOOLEAN,
      sv_descuenta      OUT NOCOPY      ga_cuentas.des_cuenta%TYPE,
      sv_codcategoria   OUT NOCOPY      ga_cuentas.cod_categoria%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_existe_cuenta_pr (
      ev_codcuenta      IN              ga_cuentas.cod_cuenta%TYPE,
      sn_resultado      OUT NOCOPY      PLS_INTEGER,
      sv_descuenta      OUT NOCOPY      ga_cuentas.des_cuenta%TYPE,
      sv_codcategoria   OUT NOCOPY      ga_cuentas.cod_categoria%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_verifica_rechazo_serie_pr (
      ev_num_serie_equipo   IN              ga_det_preliq.num_serie_orig%TYPE,
      sn_resultado          OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno        OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno       OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento         OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_numeroreservadook_pr (
      en_numcelular     IN              ga_reserva.num_celular%TYPE,
      en_codcliente     IN              ga_reserva.cod_cliente%TYPE,
      en_codvendedor    IN              ga_reserva.cod_vendedor%TYPE,
      sb_resultado      OUT NOCOPY      BOOLEAN,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_numeroreservadook_pr (
      en_numcelular     IN              ga_reserva.num_celular%TYPE,
      en_codcliente     IN              ga_reserva.cod_cliente%TYPE,
      en_codvendedor    IN              ga_reserva.cod_vendedor%TYPE,
      sn_resultado      OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_existeusuario_pr (
      ev_nomusuario     IN              ga_usuarios.nom_usuario%TYPE,
      ev_apeusuario     IN              ga_usuarios.nom_apellido1%TYPE,
      sn_codusuario     OUT NOCOPY      ga_usuarios.cod_usuario%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);


   PROCEDURE ve_rec_central_pr (
      ev_cod_central     IN              icg_central.cod_central%TYPE,
      ev_cod_celda       IN              ge_celdas.cod_celda%TYPE,
	  sv_cod_central     OUT NOCOPY      VARCHAR2,
	  sv_cod_producto    OUT NOCOPY      VARCHAR2,
	  sv_nom_central     OUT NOCOPY      VARCHAR2,
	  sv_cod_nemotec     OUT NOCOPY      VARCHAR2,
	  sv_cod_alm         OUT NOCOPY      VARCHAR2,
	  sv_num_maxintentos OUT NOCOPY      VARCHAR2,
	  sv_cod_sistema     OUT NOCOPY      VARCHAR2,
	  sv_cod_cobertura   OUT NOCOPY      VARCHAR2,
	  sv_tie_respuesta   OUT NOCOPY      VARCHAR2,
	  sv_nodocom         OUT NOCOPY      VARCHAR2,
	  sv_cod_tecnologia  OUT NOCOPY      VARCHAR2,
	  sv_cod_hlr	  	 OUT NOCOPY      VARCHAR2,
	  sv_cod_grupo_tec   OUT NOCOPY      VARCHAR2,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento);

END ve_validacion_linea_quiosco_pg;
/
SHOW ERRORS