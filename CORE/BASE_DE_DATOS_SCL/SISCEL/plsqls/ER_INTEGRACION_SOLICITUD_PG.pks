CREATE OR REPLACE PACKAGE er_integracion_solicitud_pg
IS
-----------------------------
-- DECLARACION DE CONSTANTES
-----------------------------
   cn_producto               CONSTANT NUMBER        := 1;
   cv_modulo_ga              CONSTANT VARCHAR2 (2)  := 'GA';
   cv_modulo_ge              CONSTANT VARCHAR2 (2)  := 'GE';
   cv_ind_tipidentjuridico   CONSTANT VARCHAR2 (20) := 'IND_TIPIDENTJURIDICO';
   cv_formato_fecha          CONSTANT VARCHAR2 (8)  := 'yyyymmdd';
   cn_coduso_postpago        CONSTANT NUMBER        := 2;
   cn_coduso_hibrido         CONSTANT NUMBER        := 10;
   cn_plancomerviaweb        CONSTANT NUMBER        := 1;

------------------------
-- DECLARACION DE TIPOS
------------------------
   TYPE refcursor IS REF CURSOR;

--------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE er_actualiza_preevaluacion_pr (
      ev_num_solicitud   IN              ert_solicitud.num_solicitud%TYPE,
      ev_cod_plantarif   IN              ert_solicitud_planes.cod_plantarif%TYPE,
      sn_codretorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento       OUT NOCOPY      ge_errores_pg.evento
   );

------------------------------------------------------------------------------------------------------
   FUNCTION er_procesa_detcampos_fn (
      en_num_solicitud   IN              ert_solicitud.num_solicitud%TYPE,
      so_objeto          IN OUT          er_datosburo_ot,
      sn_codretorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento       OUT NOCOPY      ge_errores_pg.evento
   )  RETURN BOOLEAN;

------------------------------------------------------------------------------------------------------
   FUNCTION er_procesa_solicitudcampos_fn (
      en_num_solicitud    IN              ert_solicitud.num_solicitud%TYPE,
      so_objeto           IN OUT          er_datosburo_ot,
      ev_ind_personeria   IN              VARCHAR2,
      ev_cod_tipident     IN              ert_solicitud_campos.cod_tipident%TYPE,
      ev_num_ident        IN              ert_solicitud_campos.num_ident%TYPE,
      sn_codretorno       OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno       OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento        OUT NOCOPY      ge_errores_pg.evento
   )  RETURN BOOLEAN;

------------------------------------------------------------------------------------------------------
   FUNCTION er_procesa_solicitud_fn (
      en_num_solicitud            IN              ert_solicitud.num_solicitud%TYPE,
      so_objeto                   IN OUT          er_datosburo_ot,
      ev_ind_personeria           IN              VARCHAR2,
      ev_cod_tipident             IN              ert_solicitud.cod_tipident%TYPE,
      ev_num_ident                IN              ert_solicitud.num_ident_cliente%TYPE,
      ev_ind_tipo_cliente         IN              VARCHAR2,
      en_cod_esquema              IN              ert_solicitud.cod_esquema%TYPE,
      ev_cod_usuario_evaluacion   IN              ert_solicitud.cod_usuario_evaluacion%TYPE,
      en_cod_vendedor             IN              ert_solicitud.cod_vendedor%TYPE,
      en_cod_vendealer            IN              ve_vendealer.cod_vendealer%TYPE,
      ev_usuario_evaluacion       IN              ert_solicitud.nom_usuario_evaluacion%TYPE,
      en_monto_renta              IN OUT          ert_solicitud.mto_renta%TYPE,
      en_cod_acreditacion         IN              ert_solicitud.cod_acreditacion%TYPE,
      en_monto_garantia           IN              ert_solicitud.mto_garantia%TYPE,
      en_cod_respuesta_buro       IN              ert_datos_detalle_to.cod_respuesta_reg99%TYPE,
      sn_codretorno               OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno               OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento                OUT NOCOPY      ge_errores_pg.evento
   )  RETURN BOOLEAN;

------------------------------------------------------------------------------------------------------

   FUNCTION er_procesa_solicitud_planes_fn (
      en_num_solicitud            IN              ert_solicitud.num_solicitud%TYPE,
	  ec_planes                   IN              refcursor,
      sn_codretorno               OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno               OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento                OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;
------------------------------------------------------------------------------------------------------


END er_integracion_solicitud_pg;
/
SHOW ERRORS
