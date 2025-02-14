CREATE OR REPLACE PACKAGE er_integracion_buro_pg
IS
-----------------------------
-- DECLARACION DE CONSTANTES
-----------------------------
   cn_producto          CONSTANT NUMBER       := 1;
   cn_tipo_soliciutd_1  CONSTANT NUMBER       := 1;
   cv_modulo_ga         CONSTANT VARCHAR2 (2) := 'GA';
   cv_modulo_ge         CONSTANT VARCHAR2 (2) := 'GE';

------------------------
-- DECLARACION DE TIPOS
------------------------
   TYPE refcursor IS REF CURSOR;

--------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_parse_reg_00_fn(
      EC_TRAMA          IN  CLOB,
      so_objeto         IN OUT NOCOPY  ER_DATOSBURO_OT,
      sn_codretorno     OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY  ge_errores_pg.evento)
      RETURN BOOLEAN;
  FUNCTION er_parse_reg_01_fn (
      LV_TRAZA80        IN  VARCHAR2,
      LN_INDICE_REG01   IN  NUMBER,
      so_objeto         OUT NOCOPY  ER_DATOSBURO_OT,
      sn_codretorno     OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY  ge_errores_pg.evento)
      RETURN BOOLEAN;
      FUNCTION er_parse_reg_02_fn (
      ev_reg02          IN  VARCHAR2,
      sn_codretorno     OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY  ge_errores_pg.evento)
      RETURN BOOLEAN;    FUNCTION er_parse_reg_03_fn (
      LV_TRAZA80             IN              VARCHAR2,
      LN_INDICE_REG03        IN              NUMBER,
      so_objeto              IN OUT NOCOPY      ER_DATOSBURO_OT,
      sn_codretorno          OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno          OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento           OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN;

      FUNCTION er_parse_reg_04_fn (
      ev_reg04          IN          VARCHAR2,
      sn_codretorno     OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN;

      FUNCTION er_parse_reg_05_fn (
      ev_reg05          IN          VARCHAR2,
      sn_codretorno     OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN;

      FUNCTION er_parse_reg_06_fn (
      ev_reg06          IN          VARCHAR2,
      sn_codretorno     OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN;

      FUNCTION er_parse_reg_07_fn (
      ev_reg07          IN          VARCHAR2,
      sn_codretorno     OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN;

      FUNCTION er_parse_reg_08_fn (
       LV_TRAZA80                IN          VARCHAR2,
       LN_INDICE_REG08           IN          NUMBER,
       so_objeto                 IN OUT NOCOPY  ER_DATOSBURO_OT,
       sn_codretorno             OUT NOCOPY  ge_errores_pg.coderror,
       sv_menretorno             OUT NOCOPY  ge_errores_pg.msgerror,
       sn_numevento              OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN;


      FUNCTION er_parse_reg_10_fn (
      ev_reg10          IN          VARCHAR2,
      sn_codretorno     OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN;

      FUNCTION er_parse_reg_16_fn (
      ev_reg16          IN          VARCHAR2,
      sn_codretorno     OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN;

      FUNCTION er_parse_reg_20_fn (
      LV_TRAZA80        IN          VARCHAR2,
      so_objeto         IN OUT NOCOPY  ER_DATOSBURO_OT,
      sn_codretorno     OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN;


      FUNCTION er_parse_reg_99_fn (
      LV_TRAZA80        IN          VARCHAR2,
      so_objeto         IN OUT NOCOPY  ER_DATOSBURO_OT,
      sn_codretorno     OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN;


      FUNCTION er_hist_trama_buro_fn (
      ev_num_ident            IN          ert_datos_detalle_to.num_ident%TYPE,
          ev_cod_tipident         IN          ert_datos_detalle_to.cod_tipident%TYPE,
          en_ind_tipo_solicitud   IN          ert_datos_detalle_to.ind_tipo_solicitud%TYPE,
      sn_codretorno           OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno           OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento            OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN;


      FUNCTION er_recuperar_trama_fn (
      ev_num_ident          IN          ert_datos_consulta_to.num_ident%TYPE ,
      ev_cod_tipident       IN          ert_datos_consulta_to.cod_tipident%TYPE,
          sv_trama              OUT NOCOPY  CLOB,
      sn_codretorno         OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno         OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento          OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN;

      FUNCTION er_rec_registros_trama_fn (
          ec_trama              IN          CLOB,
          sv_tip_reg            OUT NOCOPY  VARCHAR2,
          sc_reg                OUT NOCOPY  VARCHAR2,
      sn_codretorno         OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno         OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento          OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN;

      FUNCTION er_corta_registro_trama_fn (
          ec_trama              IN          CLOB,
          sv_tip_reg            IN          VARCHAR2,
          sc_trama              OUT NOCOPY  CLOB,
      sn_codretorno         OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno         OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento          OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN;

      FUNCTION er_inst_det_trama_buro_fn (
      ev_num_ident            IN          ert_datos_detalle_to.num_ident%TYPE,
          ev_cod_tipident         IN          ert_datos_detalle_to.cod_tipident%TYPE,
          en_ind_tipo_solicitud   IN          ert_datos_detalle_to.ind_tipo_solicitud%TYPE,
          ev_apellido             IN          ert_datos_detalle_to.apellido%TYPE,
          en_ingresos             IN          ert_datos_detalle_to.ingresos%TYPE,
          ev_cod_respuesta_reg99  IN          ert_datos_detalle_to.cod_respuesta_reg99%TYPE,
          ev_calificacion_reg20   IN          ert_datos_detalle_to.calificacion_reg20%TYPE,
          ev_clasificacion_reg20  IN          ert_datos_detalle_to.clasificacion_reg20%TYPE,
          ev_gcc_reg20            IN          ert_datos_detalle_to.gcc_reg20%TYPE,
          ev_gama_reg20           IN          ert_datos_detalle_to.gama_reg20%TYPE,
      sn_codretorno           OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno           OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento            OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN;


      FUNCTION er_inserta_trama_buro_fn (
      ev_num_ident          IN VARCHAR2,
      ev_cod_tipident       IN VARCHAR2,
      ev_cadena_sal         IN CLOB,
      sn_codretorno         OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno         OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento          OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN;





   FUNCTION er_arma_objeto_trama_fn (
          ec_trama              IN          CLOB,
          so_objeto             IN OUT NOCOPY  ER_DATOSBURO_OT,
      sn_codretorno         OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno         OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento          OUT NOCOPY  ge_errores_pg.evento)
      RETURN BOOLEAN;


   FUNCTION er_arma_objeto_trama2099_fn (
          ec_trama              IN          CLOB,
          so_objeto             IN OUT NOCOPY  ER_DATOSBURO_OT,
      sn_codretorno         OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno         OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento          OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN;

--------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE er_registra_trama_buro_pr (
      ev_num_ident          IN              VARCHAR2,
      ev_cod_tipident       IN              VARCHAR2,
      ev_apellido           IN              VARCHAR2,
      ev_ingresos           IN              VARCHAR2,
      ev_cod_respta_dc      IN              VARCHAR2,
      ev_cadena_sal         IN              CLOB,
      ev_clasificacion_dc   IN              VARCHAR2,
      ev_calificacion_dc    IN              VARCHAR2,
      ev_gasto_cc_dc        IN              VARCHAR2,
      ev_gama_dc            IN              VARCHAR2,
      sn_codretorno         OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno         OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento          OUT NOCOPY      ge_errores_pg.evento
   );

END er_integracion_buro_pg;
/
SHOW ERRORS
