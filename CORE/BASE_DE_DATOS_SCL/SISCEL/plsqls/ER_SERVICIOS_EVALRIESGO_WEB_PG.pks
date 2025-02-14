CREATE OR REPLACE PACKAGE er_servicios_evalriesgo_web_pg
IS
-----------------------------
-- DECLARACION DE CONSTANTES
-----------------------------
   CN_PRODUCTO               CONSTANT NUMBER         := 1;
   CV_MODULO_GA              CONSTANT VARCHAR2 (2)   := 'GA';
   CV_MODULO_GE              CONSTANT VARCHAR2 (2)   := 'GE';
   CV_FORMATO_FECHA          CONSTANT VARCHAR2 (8)   := 'DDMMYYYY';
   CV_FORMATO_FECHOR         CONSTANT VARCHAR2 (17)  := 'DDMMYYYY HH24MISS';
   CV_TIPLAN_DIS             CONSTANT VARCHAR2 (3)  :=  'DIS';
   CV_TIPPLANTARIF_IND       CONSTANT VARCHAR2 (1)   := 'I'; -- plan tarifario individual
   CV_TIPPLANTARIF_EMP       CONSTANT VARCHAR2 (1)   := 'E'; -- plan tarifario empresa

   CV_TIPPROCOL_PREPAGO      CONSTANT VARCHAR2 (1)   := '1'; -- Tipo producto prepago Colombia
   CV_TIPPROCOL_POSTPAGO     CONSTANT VARCHAR2 (1)   := '0'; -- Tipo producto postpago Colombia
   CV_TIPPROCOL_HIBRIDO      CONSTANT VARCHAR2 (1)   := '2'; -- Tipo producto hibrido Colombia
   CV_TIPPROSCL_PREPAGO      CONSTANT VARCHAR2 (1)   := '1'; -- Tipo producto prepago SCL
   CV_TIPPROSCL_POSTPAGO     CONSTANT VARCHAR2 (1)   := '2'; -- Tipo producto postpago SCL
   CV_TIPPROSCL_HIBRIDO      CONSTANT VARCHAR2 (1)   := '3'; -- Tipo producto hibrido SCL

   CN_CODUSO_PREPAGO         CONSTANT NUMBER         := 3;  -- Codigo uso prepago
   CN_CODUSO_POSTPAGO        CONSTANT NUMBER         := 2;  -- Codigo uso postpago
   CN_CODUSO_HIBRIDO         CONSTANT NUMBER         := 10; -- Codigo uso hibrido

   CN_PLANCOMERVIAWEB        CONSTANT NUMBER         := 1;   -- Plan comercializable via WEB

   CN_NOHAYEXCEPCION         CONSTANT NUMBER         := -1;  -- No se encontro excecion parta el cliente
   CN_ESTADOSOL_APROB1       CONSTANT NUMBER         := 1;   -- Estado solicitud aprobada
   CN_ESTADOSOL_APROB2       CONSTANT NUMBER         := 2;   -- Estado solicitud aprobada
   CN_ESTADOSOL_VENDIDO      CONSTANT NUMBER         := 4;   -- Estado solicitud vendida
   CN_EVENTO_POSTVTA         CONSTANT NUMBER         := 1;   -- Evento de la solicitud es ppostventa
   CN_TIPSOL_PRECHEQ         CONSTANT NUMBER         := 0;   -- Tipo de solicitud es pre-chequeo
   CN_ESTSOL_RECHAZADA       CONSTANT NUMBER         := 0;   -- Solicitud rechazada
   CN_ESTSOL_ENPROCVTA       CONSTANT NUMBER         := 3;   -- Solicitud en proceso de venta
   CN_PLANES_SINRESTRIC      CONSTANT NUMBER         := 0;   -- Planes sin restricciones
   CN_PLANES_COMERCIALI      CONSTANT NUMBER         := 1;   -- Planes comercializables
   CN_PLANES_NOCOMERCIA      CONSTANT NUMBER         := 2;   -- Planes no comercializables

   CN_PLAN_NOASIGVENTA       CONSTANT NUMBER         := 0;   -- Plan no asignado a una venta
   CN_PLAN_ASIGVENTA         CONSTANT NUMBER         := 1;   -- Plan asignado a una venta

   -- ERRORES --

   CN_NOERRORSQL             CONSTANT NUMBER         := 0;    -- No hay error
   CN_ERROR_OTHERS           CONSTANT NUMBER         := 156;  -- No es posible ejecutar el servicio
   CN_ERROR_EJECUCION        CONSTANT NUMBER         := 237;  -- No es posible ejecutar el procedimiento
   CV_ERROR_NOCLASIF         CONSTANT VARCHAR2 (30)  := 'Error no clasificado';

   CN_ERROR_TIPEMPNOENSCL    CONSTANT NUMBER         := 29;
   CV_ERROR_TIPEMPNOENSCL    CONSTANT VARCHAR2 (100) := 'No se encontraron planes Empresa para solicitud';
   CN_ERROR_TIPINDNOENSCL    CONSTANT NUMBER         := 30;
   CV_ERROR_TIPINDNOENSCL    CONSTANT VARCHAR2 (100) := 'No se encontraron planes Individales para solicitud';


   CN_ERROR_TIPPRONOENSCL    CONSTANT NUMBER         := 409;
   CV_ERROR_TIPPRONOENSCL    CONSTANT VARCHAR2 (100) := 'Tipo de producto no definido en SCL';
   CN_ERROR_TIPPLANOENSCL    CONSTANT NUMBER         := 410;
   CV_ERROR_TIPPLANOENSCL    CONSTANT VARCHAR2 (100) := 'Tipo de plan no definido en SCL';
   CN_ERROR_TIPIDENOENSCL    CONSTANT NUMBER         := 411;
   CV_ERROR_TIPIDENOENSCL    CONSTANT VARCHAR2 (100) := 'Tipo de identificacion no definido en SCL';
   CN_ERROR_NOEXSOLEVRIES    CONSTANT NUMBER         := 412;
   CV_ERROR_NOEXSOLEVRIES    CONSTANT VARCHAR2 (100) := 'No existe solicitud de evaluacion de riesgo';
   CN_ERROR_ESTSOLRECHAZA    CONSTANT NUMBER         := 413;
   CV_ERROR_ESTSOLRECHAZA    CONSTANT VARCHAR2 (100) := 'Solicitud de evaluacion de riesgo se encuentra rechazada';
   CN_ERROR_ESTSOLPROCVTA    CONSTANT NUMBER         := 414;
   CV_ERROR_ESTSOLPROCVTA    CONSTANT VARCHAR2 (100) := 'Solicitud de evaluacion de riesgo se encuentra en proceso de venta';
   CN_ERROR_SOLEVAPRECHEQ    CONSTANT NUMBER         := 415;
   CV_ERROR_SOLEVAPRECHEQ    CONSTANT VARCHAR2 (100) := 'Solicitud de evaluacion de riesgo corresponde a prechequeo';
   CN_ERROR_SOLEVAPOSTVTA    CONSTANT NUMBER         := 416;
   CV_ERROR_SOLEVAPOSTVTA    CONSTANT VARCHAR2 (100) := 'Solicitud de evaluacion de riesgo para postventa';
   CN_ERROR_NUMIDEINVALID    CONSTANT NUMBER         := 417;
   CV_ERROR_NUMIDEINVALID    CONSTANT VARCHAR2 (100) := 'Numero de identificacion invalida';
   CN_ERROR_NODATAFOUNDEXC   CONSTANT NUMBER         := 418;
   CV_ERROR_NODATAFOUNDEXC   CONSTANT VARCHAR2 (100) := 'No se encontraron planes para cliente excepcionado';
   CN_ERROR_NODATAFOUNDSOL   CONSTANT NUMBER         := 419;
   CV_ERROR_NODATAFOUNDSOL   CONSTANT VARCHAR2 (100) := 'No se encontraron planes para solicitud';
   CN_ERROR_NODATAPREPAGO    CONSTANT NUMBER         := 420;
   CV_ERROR_NODATAPREPAGO    CONSTANT VARCHAR2 (100) := 'No se encontraron planes prepago para solicitud';
   CN_ERROR_NODATAPOSTPAGO   CONSTANT NUMBER         := 421;
   CV_ERROR_NODATAPOSTPAGO   CONSTANT VARCHAR2 (100) := 'No se encontraron planes postpago para solicitud';
   CN_ERROR_NODATAHIBRIDO    CONSTANT NUMBER         := 422;
   CV_ERROR_NODATAHIBRIDO    CONSTANT VARCHAR2 (100) := 'No se encontraron planes hibridos para solicitud';
   CN_ERROR_NODATAFOUND      CONSTANT NUMBER         := 423; -- No se encontraron datos
   CV_ERROR_NODATAFOUND      CONSTANT VARCHAR2 (100) := 'No se encontraron datos para la consulta';

------------------------
-- DECLARACION DE TIPOS
------------------------
   TYPE REFCURSOR IS REF CURSOR;

----------------------------
-- DECLARACION DE VARIABLES
----------------------------

   ----------------------------
-- DECLARACION DE FUNCIONES
--------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ve_valida_existe_en_scl_fn (
      ev_tabla        IN              VARCHAR2,
      ev_columna      IN              VARCHAR2,
      ev_valor_str    IN              VARCHAR2,
      ev_valor_num    IN              LONG,
      sn_codretorno   OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento    OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;
--------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ve_valida_en_gedcodigos_fn (
      ev_nomtabla       IN              ged_codigos.nom_tabla%TYPE,
      ev_nomcolumna     IN              ged_codigos.nom_columna%TYPE,
      ev_modulo         IN              ged_codigos.cod_modulo%TYPE,
      ev_valor          IN              ged_codigos.cod_valor%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;
--------------------------------------------------------------------------------------------------------------------------------------------
        FUNCTION VE_relaciona_solvta_FN(EN_numSolicitud IN  ert_solicitud_venta.num_solicitud%TYPE,
                                        EN_numVenta     IN  ert_solicitud_venta.num_venta%TYPE,
                                        SN_codRetorno   OUT NOCOPY ge_errores_pg.CODERROR,
                                        SV_menRetorno   OUT NOCOPY ge_errores_pg.MSGERROR,
                                        SN_numEvento    OUT NOCOPY ge_errores_pg.EVENTO)
                                        RETURN BOOLEAN;
--------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE er_getexcepcion_pr (
      ev_codtipident   IN              erd_excepcion.cod_tipident%TYPE,
      ev_numident      IN              erd_excepcion.num_ident%TYPE,
      sn_codrestricc   OUT NOCOPY      erd_excepcion.cod_restric%TYPE,
      sn_codretorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY      ge_errores_pg.evento
   );
--------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE er_getultimasolicitud_pr (
      ev_codtipidentif      IN              ert_solicitud.cod_tipident%TYPE,
      ev_numidentif         IN              ert_solicitud.num_ident_cliente%TYPE,
      sn_numsolicitud       OUT NOCOPY      ert_solicitud.num_solicitud%TYPE,
      sn_estsolicitud       OUT NOCOPY      ert_solicitud.cod_estado%TYPE,
      sn_indtiposolicitud   OUT NOCOPY      ert_solicitud.ind_tipo_solicitud%TYPE,
      sn_indevento          OUT NOCOPY      ert_solicitud.ind_evento%TYPE,
      sn_codretorno         OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno         OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento          OUT NOCOPY      ge_errores_pg.evento
   );
--------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE er_getsolicitud_pr (
      en_numsolicitud       IN              ert_solicitud.num_solicitud%TYPE,
      sv_codtipidentif      OUT NOCOPY      ert_solicitud.cod_tipident%TYPE,
      sv_numidentif         OUT NOCOPY      ert_solicitud.num_ident_cliente%TYPE,
      sn_estsolicitud       OUT NOCOPY      ert_solicitud.cod_estado%TYPE,
      sn_indtiposolicitud   OUT NOCOPY      ert_solicitud.ind_tipo_solicitud%TYPE,
      sn_indevento          OUT NOCOPY      ert_solicitud.ind_evento%TYPE,
      sn_codretorno         OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno         OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento          OUT NOCOPY      ge_errores_pg.evento
   );
--------------------------------------------------------------------------------------------------------------------------------------------
        PROCEDURE ER_getlistPlanTarifSolic_PR(
          EN_numSolicitud IN ert_solicitud.NUM_SOLICITUD%TYPE,
          EV_tipProducto  IN ta_plantarif.COD_TIPLAN%TYPE,
          EV_tipPlanTarif IN ta_plantarif.TIP_PLANTARIF%TYPE,
          SC_cursorDatos  OUT NOCOPY REFCURSOR,
          SN_codRetorno   OUT NOCOPY ge_errores_pg.CODERROR,
          SV_menRetorno   OUT NOCOPY ge_errores_pg.MSGERROR,
          SN_numEvento    OUT NOCOPY ge_errores_pg.EVENTO
        );
--------------------------------------------------------------------------------------------------------------------------------------------
        PROCEDURE PV_getlistPlanTarifSolic_PR(
          EN_numSolicitud IN ert_solicitud.NUM_SOLICITUD%TYPE,
          EV_tipProducto  IN ta_plantarif.COD_TIPLAN%TYPE,
          EV_tipPlanTarif IN ta_plantarif.TIP_PLANTARIF%TYPE,
          SC_cursorDatos  OUT NOCOPY REFCURSOR,
          SN_codRetorno   OUT NOCOPY ge_errores_pg.CODERROR,
          SV_menRetorno   OUT NOCOPY ge_errores_pg.MSGERROR,
          SN_numEvento    OUT NOCOPY ge_errores_pg.EVENTO
        );
--------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE er_getlistplantarifsolapro_pr (
      ev_codtipidentif      IN              ert_solicitud.cod_tipident%TYPE,
      ev_numidentif         IN              ert_solicitud.num_ident_cliente%TYPE,
      en_indevento          IN              ert_solicitud.ind_evento%TYPE,
      en_indtiposolicitud   IN              ert_solicitud.ind_tipo_solicitud%TYPE,
      ev_tipproducto        IN              ta_plantarif.cod_tiplan%TYPE,
      ev_tipplantarif       IN              ta_plantarif.tip_plantarif%TYPE,
      sc_cursordatos        OUT NOCOPY      refcursor,
      sn_codretorno         OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno         OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento          OUT NOCOPY      ge_errores_pg.evento
   );
--------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ER_getlistPlanTarifCteExc_PR(EV_tipProducto     IN ta_plantarif.COD_TIPLAN%TYPE,
                                       EV_tipPlanTarif    IN ta_plantarif.TIP_PLANTARIF%TYPE,
                                       EN_codRestriccion  IN erd_excepcion.COD_RESTRIC%TYPE,
                                       EV_TipRed          IN TA_PLANTARIF.TIP_RED%TYPE,
                                       EV_codPrestacion   IN GE_PRESTACIONES_TD.COD_PRESTACION%TYPE,
                                       EV_ORIGEN          IN VARCHAR2,
                                       EN_indRenova       IN NUMBER,
                                       EV_codCalificacion IN ve_calificacion_tarifario_td.COD_CALIFICACION%TYPE, --P-CSR-11002 JLGN 13-05-2011
                                       SC_cursorDatos     OUT NOCOPY REFCURSOR,
                                       SN_codRetorno      OUT NOCOPY ge_errores_pg.CODERROR,
                                       SV_menRetorno      OUT NOCOPY ge_errores_pg.MSGERROR,
                                       SN_numEvento       OUT NOCOPY ge_errores_pg.EVENTO);
--------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE PV_getlistplantarifcteexc_pr (
      ev_tipproducto      IN              ta_plantarif.cod_tiplan%TYPE,
      ev_tipplantarif     IN              ta_plantarif.tip_plantarif%TYPE,
      en_codrestriccion   IN              erd_excepcion.cod_restric%TYPE,
      sc_cursordatos      OUT NOCOPY      refcursor,
      sn_codretorno       OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno       OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento        OUT NOCOPY      ge_errores_pg.evento
   );
--------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ER_getListaPlanesTarif_PR(EV_tipoProducto    IN           ta_plantarif.COD_TIPLAN%TYPE,
                                    EV_tipPlanTarif    IN           ta_plantarif.TIP_PLANTARIF%TYPE,
                                    EV_codPrestacion   IN           ge_prestaciones_td.COD_PRESTACION%TYPE,
                                    EV_ORIGEN          IN           VARCHAR2,
                                    EN_indRenova       IN           NUMBER,
                                    EV_codCalificacion IN           ve_calificacion_tarifario_td.COD_CALIFICACION%TYPE, --P-CSR-11002 JLGN 13-05-2011
                                    SC_cursorDatos     OUT NOCOPY   REFCURSOR,
                                    SN_codRetorno      OUT NOCOPY   ge_errores_pg.CODERROR,
                                    SV_menRetorno      OUT NOCOPY   ge_errores_pg.MSGERROR,
                                    SN_numEvento       OUT NOCOPY   ge_errores_pg.EVENTO);
--------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE PV_getlistaplanestarif_pr (
      ev_tipoproducto    IN              ta_plantarif.cod_tiplan%TYPE,
      ev_tipplantarif    IN              ta_plantarif.tip_plantarif%TYPE,
      ev_codtipidentif   IN              ert_solicitud.cod_tipident%TYPE,
      ev_numidentif      IN              ert_solicitud.num_ident_cliente%TYPE,
      sn_numsolicitud    OUT NOCOPY      ert_solicitud.num_solicitud%TYPE,
      sc_cursordatos     OUT NOCOPY      refcursor,
      sn_codretorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento       OUT NOCOPY      ge_errores_pg.evento
   );
--------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION VE_cierre_solicitud_FN  (EN_numSolicitud              IN         ert_solicitud_planes.num_solicitud%TYPE,
                                  SN_codRetorno                OUT NOCOPY ge_errores_pg.CODERROR,
                                  SV_menRetorno                OUT NOCOPY ge_errores_pg.MSGERROR,
                                  SN_numEvento                 OUT NOCOPY ge_errores_pg.EVENTO)
                                                                      RETURN BOOLEAN;

PROCEDURE ER_cambia_estado_solicitud_PR(EN_numSolicitud   IN         ert_solicitud.num_solicitud%TYPE,
                                        EN_codEstado      IN         ert_solicitud.cod_estado%TYPE,
                                        SN_codRetorno     OUT NOCOPY ge_errores_pg.CODERROR,
                                        SV_menRetorno     OUT NOCOPY ge_errores_pg.MSGERROR,
                                        SN_numEvento      OUT NOCOPY ge_errores_pg.EVENTO);


PROCEDURE ER_upd_solicplanes_PR(EN_numSolicitud   IN ert_solicitud_planes.num_solicitud%TYPE,
                                EV_planTarif      IN ert_solicitud_planes.cod_plantarif%TYPE,
                                EN_numVenta       IN ert_solicitud_venta.NUM_VENTA%TYPE,
                                SN_codRetorno     OUT NOCOPY ge_errores_pg.CODERROR,
                                SV_menRetorno     OUT NOCOPY ge_errores_pg.MSGERROR,
                                SN_numEvento      OUT NOCOPY ge_errores_pg.EVENTO);

PROCEDURE PV_upd_solicplanes_PR(EN_numSolicitud   IN ert_solicitud_planes.num_solicitud%TYPE,
                                EV_planTarif      IN ert_solicitud_planes.cod_plantarif%TYPE,
                                EN_numVenta       IN ert_solicitud_venta.NUM_VENTA%TYPE,
                                EN_numlineas      IN ert_solicitud_planes.VAL_CANT_VENDIDOS%TYPE,
                                SN_codRetorno     OUT NOCOPY ge_errores_pg.CODERROR,
                                SV_menRetorno     OUT NOCOPY ge_errores_pg.MSGERROR,
                                SN_numEvento      OUT NOCOPY ge_errores_pg.EVENTO);

PROCEDURE ER_val_planTarif_solic_PR    (EN_numSolicitud              IN         ert_solicitud_planes.num_solicitud%TYPE,
                                        EV_planTarif                 IN         ert_solicitud_planes.cod_plantarif%TYPE,
                                        SN_codRetorno                OUT NOCOPY ge_errores_pg.CODERROR,
                                        SV_menRetorno                OUT NOCOPY ge_errores_pg.MSGERROR,
                                        SN_numEvento                 OUT NOCOPY ge_errores_pg.EVENTO);


PROCEDURE ER_getNombreCliente_PR     (EN_numSolicitud IN ert_solicitud.NUM_SOLICITUD%TYPE,
                                      SV_NOMBRE       OUT NOCOPY ERT_SOLICITUD_CAMPOS.NOMBRE_CLIENTE%TYPE,
                                      SV_APELLIDO     OUT NOCOPY ERT_SOLICITUD_CAMPOS.PRIMER_APELLIDO%TYPE,
                                      SV_APELLIDO2    OUT NOCOPY ERT_SOLICITUD_CAMPOS.SEGUNDO_APELLIDO%TYPE,
                                      SN_codRetorno   OUT NOCOPY ge_errores_pg.CODERROR,
                                      SV_menRetorno   OUT NOCOPY ge_errores_pg.MSGERROR,
                                      SN_numEvento    OUT NOCOPY ge_errores_pg.EVENTO);


PROCEDURE ER_getdatosSolicitud_PR    (EN_numSolicitud       IN ERT_SOLICITUD.NUM_SOLICITUD%TYPE,
                                      SV_NOM_USUARIO        OUT NOCOPY ERT_SOLICITUD.NOM_USUARIO_EVALUACION%TYPE,
                                      SV_fecha_creacion     OUT NOCOPY ERT_SOLICITUD.FEC_INGRESO_H%TYPE,
                                      SN_codRetorno         OUT NOCOPY ge_errores_pg.CODERROR,
                                      SV_menRetorno         OUT NOCOPY ge_errores_pg.MSGERROR,
                                      SN_numEvento          OUT NOCOPY ge_errores_pg.EVENTO);

END er_servicios_evalriesgo_web_pg;
/
