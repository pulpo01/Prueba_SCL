CREATE OR REPLACE PACKAGE er_integracion_eriesgo_pg
IS
-----------------------------
-- DECLARACION DE CONSTANTES
-----------------------------
   cn_no_data_found_cliente CONSTANT NUMBER       := 899872;
   cn_producto              CONSTANT NUMBER       := 1;
   cv_modulo_ga             CONSTANT VARCHAR2 (2) := 'GA';
   cv_modulo_ge             CONSTANT VARCHAR2 (2) := 'GE';
   cv_ind_tipidentjuridico  CONSTANT VARCHAR2 (20) := 'IND_TIPIDENTJURIDICO';
   cod_codigo_1             CONSTANT NUMBER       := 1;
   cod_subcodigo_21         CONSTANT NUMBER       := 21;
   cod_subcodigo_20         CONSTANT NUMBER       := 20;
   cod_subcodigo_19         CONSTANT NUMBER       := 19;
   cn_erd_producto2         CONSTANT NUMBER       := 2;
   cn_erd_fuente2           CONSTANT NUMBER       := 2;
   cn_coduso_postpago       CONSTANT NUMBER        := 2;
   cn_coduso_hibrido        CONSTANT NUMBER        := 10;
   cn_plancomerviaweb       CONSTANT NUMBER        := 1;
   CV_TIPPROCOL_PREPAGO      CONSTANT VARCHAR2 (1)   := '1'; -- Tipo producto prepago Colombia
   CV_TIPPROCOL_POSTPAGO     CONSTANT VARCHAR2 (1)   := '0'; -- Tipo producto postpago Colombia
   CV_TIPPROCOL_HIBRIDO      CONSTANT VARCHAR2 (1)   := '2'; -- Tipo producto hibrido Colombia
   CV_TIPPROSCL_PREPAGO      CONSTANT VARCHAR2 (1)   := '1'; -- Tipo producto prepago SCL
   CV_TIPPROSCL_POSTPAGO     CONSTANT VARCHAR2 (1)   := '2'; -- Tipo producto postpago SCL
   CV_TIPPROSCL_HIBRIDO      CONSTANT VARCHAR2 (1)   := '3'; -- Tipo producto hibrido SCL
   CV_PARAMETRO_DECIMAL      CONSTANT VARCHAR2 (30)   := 'NUM_DECIMAL'; --Nombre Parametro Decimal



------------------------
-- DECLARACION DE TIPOS
------------------------
   TYPE refcursor IS REF CURSOR;

--------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE er_listar_planes_pr (
      ev_num_ident          IN              ERT_SOLICITUD.NUM_IDENT_CLIENTE%TYPE,
      ev_cod_tipident       IN              GE_TIPIDENT.COD_TIPIDENT%TYPE,
      en_ingresos           IN              NUMBER,
      ev_cod_usuario        IN              ERT_SOLICITUD.COD_USUARIO_EVALUACION%TYPE,
      en_cod_vendedor       IN              VE_VENDEDORES.COD_VENDEDOR%TYPE,
      en_cod_vendealer      IN              VE_VENDEALER.COD_VENDEALER%TYPE,
      ev_tipo_producto      IN              VARCHAR2,
      ev_tipo_plan          IN              TA_PLANTARIF.TIP_PLANTARIF%TYPE,
      sn_solic              OUT NOCOPY      ERT_SOLICITUD.NUM_SOLICITUD%TYPE,
      sv_nombre             OUT NOCOPY      ert_solicitud_campos.nombre_cliente%TYPE,
      sv_apellido           OUT NOCOPY      ert_solicitud_campos.primer_apellido%TYPE,
      sv_apellido2          OUT NOCOPY      ert_solicitud_campos.segundo_apellido%TYPE,
      sv_usuario            OUT NOCOPY      ERT_SOLICITUD.NOM_USUARIO_EVALUACION%TYPE,
      sv_gcc                OUT NOCOPY      NUMBER,
      sv_fecha_creacion     OUT NOCOPY      ert_solicitud.fec_ingreso_h%TYPE,
      sc_cursordatos        OUT NOCOPY      refcursor,
      sn_cod_retorno        OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno       OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento         OUT NOCOPY      ge_errores_pg.evento
   );
--------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ER_ACTUALIZA_PREEVALUACION_PR (
      ev_num_solicitud      IN              ert_solicitud.num_solicitud%TYPE,
      ev_cod_plantarif      IN              ert_solicitud_planes.cod_plantarif%TYPE,
      sn_codretorno         OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno         OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento          OUT NOCOPY      ge_errores_pg.evento
   );
END er_integracion_eriesgo_pg;
/
SHOW ERRORS
