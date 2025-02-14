CREATE OR REPLACE PACKAGE ve_parametros_comer_quiosco_pg IS
/*
<Documentación TipoDoc = "package"
 <Elemento Nombre = "ve_parametros_comer_quiosco_pg"
           Lenguaje="PL/SQL"
           Fecha="17-01-2007"
           Versión="1.0"
           Diseñador="Roberto Pérez Varas"
           Programador="Roberto Pérez Varas"
           Ambiente="DEIMOS_ECU">
  <Retorno>NA</Retorno>
   <Descripción> Encabezado de ve_parametros_comer_quiosco_pg</Descripción>>
    <Parámetros>
    </Parámetros>
 </Elemento>
</Documentación>
*/
   cv_cod_producto      CONSTANT VARCHAR2 (1)  := '1';
   cv_error_no_clasif   CONSTANT VARCHAR2 (30) := 'Error no clasificado';
   cv_codamiciclo       CONSTANT VARCHAR2 (30) := 'COD_AMI_CICLO';
   cv_codmodulo         CONSTANT VARCHAR2 (2)  := 'GA';
   cv_codcomodato       CONSTANT VARCHAR2 (30) := 'COD_PROC_COMODATO';
   cv_codconcons        CONSTANT VARCHAR2 (30) := 'COD_CONCONS';
   cv_codmodpricta      CONSTANT VARCHAR2 (30) := 'COD_MODPRICTA';
   cv_codmodventa       CONSTANT VARCHAR2 (30) := 'COD_PROC_MODVENTA';
   cv_codcargocuenta    CONSTANT VARCHAR2 (30) := 'COD_PROC_CARGOACUENTA';
   cv_parcausavta       CONSTANT VARCHAR2 (30) := 'COD_CAUSA_VENTA';
   cv_parametrov        CONSTANT VARCHAR2 (30) := 'V';

   TYPE refcursor IS REF CURSOR;

   PROCEDURE ve_planservicio_pr (
      ev_plantarif       IN              ta_plantarif.cod_plantarif%TYPE,
      ev_codtecnologia   IN              al_tecnologia.cod_tecnologia%TYPE,
      sc_cursordatos     OUT NOCOPY      refcursor,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_campanavigente_pr (
      sc_cursordatos    OUT NOCOPY   refcursor,
      sn_cod_retorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento);

   PROCEDURE ve_planindemnizacion_pr (
      sc_cursordatos    OUT NOCOPY   refcursor,
      sn_cod_retorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento);

   PROCEDURE ve_creditomorosidad_pr (
      en_codcliente     IN              ge_clientes.cod_cliente%TYPE,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_grupocobroservicio_pr (
      en_codproducto    IN              NUMBER,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_creditoconsumo_pr (
      en_codcliente     IN              ge_clientes.cod_cliente%TYPE,
      en_codproducto    IN              NUMBER,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_grupoafinidad_pr (
      en_codcliente     IN              ge_clientes.cod_cliente%TYPE,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_modalidadpago_pr (
      ev_codtipcontrato   IN              ga_tipcontrato.cod_tipcontrato%TYPE,
      en_nromeses         IN              ga_percontrato.num_meses%TYPE,
      en_codvendedor      IN              ve_vendedores.cod_vendedor%TYPE,
      ev_nomusuario       IN              ge_seg_usuario.nom_usuario%TYPE,
      en_codproducto      IN              NUMBER,
      ev_codoperacion     IN              gad_modpago_catplan.cod_operacion%TYPE,
      ev_cod_programa     IN              ge_programas.cod_programa%TYPE,
      sc_cursordatos      OUT NOCOPY      refcursor,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_tipocontrato_pr (
      ev_nomusuario     IN              ge_seg_usuario.nom_usuario%TYPE,
      en_codproducto    IN              NUMBER,
      ev_indcontcel     IN              VARCHAR2,
      ev_indcontseg     IN              VARCHAR2,
      ev_cod_programa   IN              ge_programas.cod_programa%TYPE,
      en_num_version    IN              ge_programas.num_version%TYPE,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_permisousuario_pr (
      ev_nom_usuario    IN              ge_seg_usuario.nom_usuario%TYPE,
      ev_nom_proceso    IN              gad_procesos_perfiles.cod_proceso%TYPE,
      ev_cod_programa   IN              ge_programas.cod_programa%TYPE,
      en_num_version    IN              ge_programas.num_version%TYPE,
      sn_codproceso     OUT NOCOPY      ge_seg_perfiles.cod_proceso%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_nromesescontrato_pr (
      ev_codtipcontrato   IN              ga_tipcontrato.cod_tipcontrato%TYPE,
      en_codproducto      IN              NUMBER,
      sc_cursordatos      OUT NOCOPY      refcursor,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_nrocuotas_pr (
      en_codmodventa    IN              ge_modventa.cod_modventa%TYPE,
      en_codvendedor    IN              ve_vendedores.cod_vendedor%TYPE,
      ev_nomusuario     IN              ge_seg_usuario.nom_usuario%TYPE,
      en_codproducto    IN              NUMBER,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_tipodocumento_pr (
      en_cod_cliente     IN              ge_clientes.cod_cliente%TYPE,
      ev_ind_agente      IN              ge_clientes.ind_agente%TYPE,
      ev_ind_situacion   IN              ge_clientes.ind_situacion%TYPE,
      en_cod_producto    IN              NUMBER,
      ev_cod_amiciclo    IN              ged_parametros.nom_parametro%TYPE,
      ev_cod_modulo      IN              VARCHAR2,
      sc_cursordatos     OUT NOCOPY      refcursor,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_contratocliente_pr (
      en_codcliente       IN              ge_clientes.cod_cliente%TYPE,
      ev_codtipcontrato   IN              ga_tipcontrato.cod_tipcontrato%TYPE,
      sc_cursordatos      OUT NOCOPY      refcursor,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_obtienedatoscelda_pr (
      ev_codcelda       IN              ge_celdas.cod_celda%TYPE,
      sv_codsubalm      OUT NOCOPY      ge_celdas.cod_subalm%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_listadoceldas_pr (
      ev_codregion      IN              ge_regiones.cod_region%TYPE,
      ev_codprovincia   IN              ge_provincias.cod_provincia%TYPE,
      ev_codciudad      IN              ge_ciudades.cod_provincia%TYPE,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_listadocentrales_pr (
      ev_codsubalm      IN              ta_subcentral.cod_subalm%TYPE,
      en_codproducto    IN              NUMBER,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_plan_comercial_cliente_pr (
      en_cod_cliente    IN              ga_cliente_pcom.cod_cliente%TYPE,
      sn_cod_plancom    OUT NOCOPY      ga_cliente_pcom.cod_plancom%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   FUNCTION ve_validausuariovendedor_fn (
      en_codvendedor    IN              ve_vendedores.cod_vendedor%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
      RETURN BOOLEAN;

   FUNCTION ve_validapermisousuario_fn (
      ev_nomusuario     IN              ge_seg_usuario.nom_usuario%TYPE,
      ev_cod_proceso    IN              gad_procesos_perfiles.cod_proceso%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
      RETURN BOOLEAN;

   FUNCTION ve_validapermisovendedor_fn (
      en_codvendedor    IN              ve_vendedores.cod_vendedor%TYPE,
      ev_cod_proceso    IN              gad_procesos_perfiles.cod_proceso%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
      RETURN BOOLEAN;

   PROCEDURE ve_consulta_datos_usuario_pr (
      ev_nom_usuario      IN              VARCHAR2,
      sv_codigo_oficina   OUT NOCOPY      ge_seg_usuario.cod_oficina%TYPE,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_con_oficina_pr (
      ev_cod_oficina     IN              VARCHAR2,
      sv_des_oficina     OUT NOCOPY      VARCHAR2,
      sv_cod_direccion   OUT NOCOPY      VARCHAR2,
      sv_des_region      OUT NOCOPY      VARCHAR2,
      sv_des_provincia   OUT NOCOPY      VARCHAR2,
      sv_des_ciudad      OUT NOCOPY      VARCHAR2,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_con_oficina_pr (
      ev_cod_oficina     IN              VARCHAR2,
      sv_des_oficina     OUT NOCOPY      VARCHAR2,
      sv_cod_direccion   OUT NOCOPY      VARCHAR2,
      sv_des_region      OUT NOCOPY      VARCHAR2,
      sv_des_provincia   OUT NOCOPY      VARCHAR2,
      sv_des_ciudad      OUT NOCOPY      VARCHAR2,
      sv_cod_region      OUT NOCOPY      VARCHAR2,
      sv_cod_provincia   OUT NOCOPY      VARCHAR2,
      sv_cod_ciudad      OUT NOCOPY      VARCHAR2,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE ve_celdaciudad_pr (
      ev_cod_region      IN              ge_regiones.cod_region%TYPE,
      ev_cod_provincia   IN              ge_provincias.cod_provincia%TYPE,
      ev_cod_ciudad      IN              ge_ciudades.cod_provincia%TYPE,
      sv_cod_celda       OUT NOCOPY      ge_ciudades.cod_celda%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento);
END ve_parametros_comer_quiosco_pg;
/

SHOW ERRORS