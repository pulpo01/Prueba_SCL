CREATE OR REPLACE PACKAGE Al_Pac_Kit IS
   CV_modulo CONSTANT VARCHAR2(3):='AL';
   CN_producto CONSTANT PLS_INTEGER:=1;
   CV_paramErrKit CONSTANT VARCHAR2(20):='ERR_KIT';
   CV_paramTer CONSTANT VARCHAR2(20):='COD_TERMINAL_GSM';
   CV_paramGen CONSTANT VARCHAR2(20):='GEN_KIT';
   CV_paramCierreGenKit CONSTANT VARCHAR2(20):='CIERRE_GENKIT';
   CV_paramSEL2 CONSTANT VARCHAR2(20):='FORMATO_SEL2';
   CV_paramSEL7 CONSTANT VARCHAR2(20):='FORMATO_SEL7';
   CV_paramENTMerc CONSTANT VARCHAR2(20):='ENTRADA MERCADERIA';
   CV_paramSALGenKit CONSTANT VARCHAR2(20):='SALIDA POR GEN KIT';
   CV_paramTransGenKit CONSTANT VARCHAR2(20):='TRANSACCION GEN KIT';
   CV_paramDesvinKit CONSTANT VARCHAR2(20):='DESVINCULACION KIT';
   CV_paramEntDesvKit CONSTANT VARCHAR2(20):='ENTRADA POR DESV KIT';
   CV_paramTransDesKit CONSTANT VARCHAR2(20):='TRANSACCION DES KIT';
   CV_estado_movSO  AL_MOVIMIENTOS.cod_estadomov%TYPE:='SO';
   CN_cero          PLS_INTEGER:=0;

Procedure P_AL_GENERACION_KIT(
v_cab_kit IN  AL_CAB_AGREDES_KIT%ROWTYPE);
--
Procedure P_AL_DESVINCULACION_KIT(
v_cab_kit IN  AL_CAB_AGREDES_KIT%ROWTYPE);

Procedure P_GET_PMP_ARTICULO(
  v_cod_articulo IN  AL_ARTICULOS.cod_articulo%TYPE,
  v_precio OUT  AL_PMP_ARTICULO.prec_pmp%TYPE);

Procedure P_AL_HISTORICO_KIT(
v_cab_kit IN  AL_CAB_AGREDES_KIT%ROWTYPE);

FUNCTION AL_SERIE_KIT_FN (
  SV_serie  OUT AL_SERIES.num_serie%TYPE)
  RETURN PLS_INTEGER;


Procedure AL_GENERACION_AUTOMATICA_PR (
  EN_num_gen_kit IN AL_CAB_AGREDES_KIT.num_gen_kit%TYPE,
  EN_bodega  IN AL_SERIES.cod_bodega%TYPE,
  EN_kit  IN AL_SERIES.cod_articulo%TYPE,
  EN_stock  IN AL_SERIES.tip_stock%TYPE,
  EN_uso  IN AL_SERIES.cod_uso%TYPE,
  EN_estado  IN AL_SERIES.cod_estado%TYPE,
  EN_actuacion  IN AL_SERIES.ind_telefono%TYPE,
  EN_cantidad  IN AL_CAB_AGREDES_KIT.can_soli%TYPE,
  EN_precio IN AL_CAB_AGREDES_KIT.prc_unidad%TYPE,
  EV_obs IN AL_CAB_AGREDES_KIT.des_observacion%TYPE,
  EV_ind_agredes IN AL_CAB_AGREDES_KIT.ind_agredes%TYPE);

Procedure AL_VALIDA_AUTOMATICO_PR (
  EN_proceso IN AL_PROCESOS_MASIVOS_TO.ind_proceso%TYPE,
  EN_num_gen_kit IN AL_CAB_AGREDES_KIT.num_gen_kit%TYPE,
  EN_bodega  IN AL_SERIES.cod_bodega%TYPE,
  EN_kit  IN AL_SERIES.cod_articulo%TYPE,
  EN_stock  IN AL_SERIES.tip_stock%TYPE,
  EN_uso  IN AL_SERIES.cod_uso%TYPE,
  EN_estado  IN AL_SERIES.cod_estado%TYPE,
  EN_actuacion  IN AL_SERIES.ind_telefono%TYPE,
  EN_cantidad  IN AL_CAB_AGREDES_KIT.can_soli%TYPE,
  EN_error  IN OUT AL_PROCESOS_MASIVOS_TO.ind_error%TYPE);

Procedure AL_GENKIT_DATA_PR(
  EN_proceso IN AL_PROCESOS_MASIVOS_TO.ind_proceso%TYPE,
  EN_num_gen_kit IN AL_CAB_AGREDES_KIT.num_gen_kit%TYPE,
  EN_bodega  IN AL_SERIES.cod_bodega%TYPE,
  EN_kit  IN AL_SERIES.cod_articulo%TYPE,
  EN_stock  IN AL_SERIES.tip_stock%TYPE,
  EN_uso  IN AL_SERIES.cod_uso%TYPE,
  EN_estado  IN AL_SERIES.cod_estado%TYPE);

FUNCTION AL_GENKIT_FORMATO_FN(
  EN_proceso IN AL_PROCESOS_MASIVOS_TO.ind_proceso%TYPE,
  EN_num_gen_kit IN AL_CAB_AGREDES_KIT.num_gen_kit%TYPE,
  EN_kit AL_PLANTILLAS_KIT.cod_kit%TYPE,
  EN_tipo PLS_INTEGER)
RETURN PLS_INTEGER;

Procedure AL_PROCESO_ERRORESKIT_PR(
  EN_proceso IN AL_PROCESOS_MASIVOS_TO.ind_proceso%TYPE,
  EN_num_gen_kit IN AL_CAB_AGREDES_KIT.num_gen_kit%TYPE,
  EN_kit  IN AL_SERIES.cod_articulo%TYPE,
  EN_cod_art IN AL_PROCESOS_MASIVOS_TO.cod_articulo%TYPE,
  EN_sec_reg IN AL_PROCESOS_MASIVOS_TO.sec_reg%TYPE,
  EN_error IN AL_PROCESOS_MASIVOS_TO.ind_error%TYPE,
  EN_Obs   IN AL_PROCESOS_MASIVOS_TO.observaciones%TYPE,
  EN_tipo PLS_INTEGER,
  EN_serie IN AL_PROCESOS_MASIVOS_TO.num_serie%TYPE DEFAULT NULL,
  EN_cantidad IN AL_PROCESOS_MASIVOS_TO.can_solicitada%TYPE DEFAULT NULL);

Procedure AL_GENERACION_KIT_PR(
  EN_proceso IN AL_PROCESOS_MASIVOS_TO.ind_proceso%TYPE,
  EN_num_gen_kit IN AL_CAB_AGREDES_KIT.num_gen_kit%TYPE,
  EN_bodega  IN AL_SERIES.cod_bodega%TYPE,
  EN_kit  IN AL_SERIES.cod_articulo%TYPE,
  EN_stock  IN AL_SERIES.tip_stock%TYPE,
  EN_uso  IN AL_SERIES.cod_uso%TYPE,
  EN_estado  IN AL_SERIES.cod_estado%TYPE,
  EN_actuacion  IN AL_SERIES.ind_telefono%TYPE,
  EN_cantidad  IN AL_CAB_AGREDES_KIT.can_soli%TYPE,
  EN_precio IN AL_CAB_AGREDES_KIT.prc_unidad%TYPE,
  EV_obs IN AL_CAB_AGREDES_KIT.des_observacion%TYPE,
  EV_ind_agredes IN AL_CAB_AGREDES_KIT.ind_agredes%TYPE);

Procedure AL_SIMULACIONYCARGA_KIT_PR(
  EN_proceso IN AL_PROCESOS_MASIVOS_TO.ind_proceso%TYPE,
  EN_num_gen_kit IN AL_CAB_AGREDES_KIT.num_gen_kit%TYPE,
  EN_bodega  IN AL_SERIES.cod_bodega%TYPE,
  EN_kit  IN AL_SERIES.cod_articulo%TYPE,
  EN_stock  IN AL_SERIES.tip_stock%TYPE,
  EN_uso  IN AL_SERIES.cod_uso%TYPE,
  EN_estado  IN AL_SERIES.cod_estado%TYPE,
  EN_actuacion  IN AL_SERIES.ind_telefono%TYPE,
  EN_cantidad  IN AL_CAB_AGREDES_KIT.can_soli%TYPE,
  EN_precio IN AL_CAB_AGREDES_KIT.prc_unidad%TYPE,
  EV_obs IN AL_CAB_AGREDES_KIT.des_observacion%TYPE,
  EV_ind_agredes IN AL_CAB_AGREDES_KIT.ind_agredes%TYPE,
  EN_num_ingpar IN AL_DETALLE_KIT_TO.num_ingpar%TYPE);

Procedure AL_DESVINCULACION_NEW_PR(
  EN_indproceso IN  AL_PROCESOS_MASIVOS_TO.IND_PROCESO%TYPE,
  EN_numproceso IN  AL_PROCESOS_MASIVOS_TO.NUM_PROCESO%TYPE,
  EN_uso     IN  AL_SERIES.COD_USO%TYPE,
  EN_estado     IN  AL_SERIES.COD_ESTADO%TYPE,
  EN_bodega     IN  AL_SERIES.COD_BODEGA%TYPE,
  EN_precio     IN AL_CAB_AGREDES_KIT.PRC_UNIDAD%TYPE);

Procedure AL_DESVINCULACION_PR(
  EN_indproceso IN  AL_PROCESOS_MASIVOS_TO.IND_PROCESO%TYPE,
  EN_numproceso  IN AL_PROCESOS_MASIVOS_TO.NUM_PROCESO%TYPE,
  EN_bodega      IN AL_SERIES.COD_BODEGA%TYPE);

FUNCTION AL_VALIDA_SERIE_FN(
  EN_articulo  IN AL_SERIES.cod_articulo%TYPE,
  EV_series IN AL_SERIES.num_serie%TYPE,
  EN_uso IN AL_SERIES.cod_uso%TYPE,
  EN_estado IN AL_SERIES.cod_estado%TYPE,
  EN_bodega  IN AL_SERIES.cod_bodega%TYPE)
  RETURN BOOLEAN;

Procedure AL_ERRORES_KIT_PR(
  EN_proceso IN AL_PROCESOS_MASIVOS_TO.ind_proceso%TYPE,
  EN_num_gen_kit IN AL_CAB_AGREDES_KIT.num_gen_kit%TYPE,
  EN_kit  IN AL_SERIES.cod_articulo%TYPE,
  EN_error IN PLS_INTEGER);


Procedure AL_VALIDA_CIERRE_GENKIT_PR(
  EN_num_gen_kit IN AL_CAB_AGREDES_KIT.num_gen_kit%TYPE,
  EN_kit  IN AL_SERIES.cod_articulo%TYPE);

Procedure AL_CIERRE_DESVINCULACION_PR(
  EN_num_gen_kit IN  AL_CAB_AGREDES_KIT.NUM_GEN_KIT%TYPE);


FUNCTION AL_DESKIT_COMPONENTES_FN(
  EN_serie_kit  AL_SERIES.num_serie%TYPE)
  RETURN PLS_INTEGER;

Procedure AL_CONSULTA_KIT_PR(
  EN_indproceso IN  AL_PROCESOS_MASIVOS_TO.IND_PROCESO%TYPE,
  EN_numproceso IN  AL_PROCESOS_MASIVOS_TO.NUM_PROCESO%TYPE,
  EN_bodega     IN AL_BODEGAS.cod_bodega%TYPE,
  EN_tipo PLS_INTEGER);


END  Al_Pac_Kit; 
/
SHOW ERRORS