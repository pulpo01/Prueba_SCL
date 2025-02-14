CREATE OR REPLACE PACKAGE AL_TRASPASO_WS_PG IS

cv_error_no_clasif    CONSTANT VARCHAR2(50):= 'No es posible clasificar el error';
cv_moduloal           CONSTANT VARCHAR(2):= 'AL';
cv_cod_moduloal       CONSTANT  ged_parametros.cod_modulo%TYPE:='AL';
cn_pedido_despachador CONSTANT npt_estado_pedido.COD_ESTADO_FLUJO%TYPE:= 8;
cv_nom_tabla          CONSTANT ged_codigos.nom_tabla%TYPE := 'AL_LOCALIZA';
cv_nom_columna1       CONSTANT ged_codigos.nom_columna%TYPE := 'COD_RACK';
cv_nom_columna2       CONSTANT ged_codigos.nom_columna%TYPE := 'COD_ZONA';
cv_proc_invo_aut      CONSTANT al_series_temp_to.proc_invocador%TYPE := 'AUT_WS';
cv_proc_invo_tra      CONSTANT al_series_temp_to.proc_invocador%TYPE := 'TRA';
cv_cod_modulo         CONSTANT ged_codigos.cod_modulo%TYPE := 'AL';
cv_tras_erroneso      CONSTANT al_estado_traspaso_to.estado_traspaso%TYPE := 'ERRONEO';
cv_mens_error         CONSTANT al_estado_traspaso_to.mensaje_error%TYPE := 'SERIES ERRONEAS.';

TYPE REFCURSOR      IS REF CURSOR;
------------------------------------------------------------------------------------------------------
PROCEDURE al_total_cantidad_traspaso_pr(en_num_traspaso  IN al_lin_traspaso.num_traspaso%TYPE,
                                        sn_cantidad      OUT NOCOPY NUMBER,
                                        sn_cod_retorno   OUT NOCOPY ge_errores_pg.coderror,
                                        sv_mens_retorno  OUT NOCOPY ge_errores_pg.msgerror,
                                        sn_num_evento    OUT NOCOPY ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_elimi_traspaso_temporal_pr(en_num_traspaso  IN al_series_temp_to.num_traspaso%TYPE,
                                        ev_modulo        IN al_series_temp_to.cod_modulo%TYPE,
                                        sn_cod_retorno   OUT NOCOPY ge_errores_pg.coderror,
                                        sv_mens_retorno  OUT NOCOPY ge_errores_pg.msgerror,
                                        sn_num_evento    OUT NOCOPY ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_actualiza_peticion_pr(ev_estado       IN al_cab_peticion.cod_estado%TYPE,
                                   en_num_peticion IN al_cab_peticion.num_peticion%TYPE,
                                   sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                                   sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                                   sn_num_evento   OUT NOCOPY ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_tip_movimiento_pr(ev_cod_proceso  IN al_procesos_tipmovim.cod_proceso%TYPE,
                               sn_tip_movim    OUT NOCOPY al_procesos_tipmovim.tip_movimiento%TYPE,
                               sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                               sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                               sn_num_evento   OUT NOCOPY ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_bodega_ori_traspaso_pr(en_num_traspaso   IN al_traspasos.num_traspaso%TYPE,
                                       sn_cod_bodega_ori OUT NOCOPY al_traspasos.cod_bodega_ori%TYPE,
                                    sn_cod_retorno    OUT NOCOPY ge_errores_pg.coderror,
                                    sv_mens_retorno   OUT NOCOPY ge_errores_pg.msgerror,
                                    sn_num_evento     OUT NOCOPY ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_upd_estad_traspaso_pr(ev_estado       IN al_traspasos.cod_estado%TYPE,
                                   en_num_traspaso IN al_traspasos.num_traspaso%TYPE,
                                   sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                                   sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                                   sn_num_evento   OUT NOCOPY ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_actualiza_traspaso_pr(ev_cod_estado   IN al_traspasos.cod_estado%TYPE,
                                   en_movim_env    IN al_traspasos.tip_movim_env%TYPE,
                                   en_num_traspaso IN al_traspasos.num_traspaso%TYPE,
                                   sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                                   sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                                   sn_num_evento   OUT NOCOPY ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_upd_guia_traspaso_pr(ev_guia         IN al_traspasos.num_guia%TYPE,
                                  en_num_traspaso IN al_traspasos.num_traspaso%TYPE,
                                  sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                                  sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                                  sn_num_evento   OUT NOCOPY ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_seleccion_masiva_pr(en_num_traspaso IN al_traspasos.num_traspaso%TYPE,
                                 en_estado       IN al_estados.cod_estado%TYPE,
                                 en_tipstock     IN al_tipos_stock.tip_stock%TYPE,
                                 sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                                 sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                                 sn_num_evento   OUT NOCOPY ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_graba_error_traspaso_pr (en_articulo      IN al_articulos.cod_articulo%TYPE,
                                          ev_num_serie    IN al_series.num_serie%TYPE,
                                          en_num_traspaso IN al_traspasos.num_traspaso%TYPE,
                                      en_lin_traspaso IN al_lin_traspaso.lin_traspaso%TYPE,
                                      en_cod_error    IN PLS_INTEGER,
                                      en_opcion          IN PLS_INTEGER,
                                      en_bodega_ori      IN al_traspasos_masivo.cod_bodega_ori%TYPE DEFAULT NULL,
                                      en_bodega_dest  IN al_traspasos_masivo.cod_bodega_dest%TYPE DEFAULT NULL);
------------------------------------------------------------------------------------------------------
PROCEDURE al_graba_error_validacion_pr (en_articulo      IN al_articulos.cod_articulo%TYPE,
                                        en_num_traspaso  IN al_traspasos.num_traspaso%TYPE,
                                        en_cod_error     IN PLS_INTEGER);                                      
------------------------------------------------------------------------------------------------------
PROCEDURE al_cons_series_error_pr(en_num_traspaso IN al_traspasos.num_traspaso%TYPE,
                                  ev_invocador    IN al_series_temp_to.proc_invocador%TYPE,
                                  ev_modulo       IN al_errores_temp_to.cod_modulo%TYPE,
                                  sn_cantidad     OUT NOCOPY NUMBER,
                                  sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                                  sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                                  sn_num_evento   OUT NOCOPY ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_obt_series_error_pr(en_num_traspaso IN al_traspasos.num_traspaso%TYPE,
                                 ev_invocador    IN al_series_temp_to.proc_invocador%TYPE,
                                 ev_modulo       IN al_errores_temp_to.cod_modulo%TYPE,
                                 sc_cursordatos  OUT NOCOPY refcursor,
                                 sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                                 sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                                 sn_num_evento   OUT NOCOPY ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_obt_lineas_error_pr(en_num_traspaso IN al_traspasos.num_traspaso%TYPE,
                                 ev_invocador    IN al_series_temp_to.proc_invocador%TYPE,
                                 ev_modulo       IN al_errores_temp_to.cod_modulo%TYPE,
                                 sc_cursordatos  OUT NOCOPY refcursor,
                                 sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                                 sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                                 sn_num_evento   OUT NOCOPY ge_errores_pg.evento);                                 
------------------------------------------------------------------------------------------------------
PROCEDURE al_valida_traspaso_pr(en_num_traspaso IN al_traspasos.num_traspaso%TYPE,
                                ev_cod_estado   IN al_traspasos.cod_estado%TYPE,
                                sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                                sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                                sn_num_evento   OUT NOCOPY ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_obt_operadora_pr(sv_operadora    OUT NOCOPY ge_parametros_sistema_vw.valor_texto%TYPE,
                              sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                              sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                              sn_num_evento   OUT NOCOPY ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_obt_stock_traspaso_pr(en_num_traspaso IN al_lin_traspaso.num_traspaso%TYPE,
                                   sc_cursordatos  OUT NOCOPY refcursor,
                                   sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                                   sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                                   sn_num_evento   OUT NOCOPY ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_obtiene_peticion_pr(en_num_traspaso IN al_traspasos.num_traspaso%TYPE,
                                 sn_num_peticion OUT NOCOPY al_traspasos.num_peticion%TYPE,
                                 sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                                 sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                                 sn_num_evento   OUT NOCOPY ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_obt_cant_stock_pr(en_cod_articulo   IN al_stock.cod_articulo%TYPE,
                               en_cod_bodega     IN al_stock.cod_bodega%TYPE,
                               en_disponibilidad IN al_estados.ind_disponibilidad%TYPE,
                               ev_estados        IN VARCHAR2,
                               en_cod_uso        IN al_stock.cod_uso%TYPE,
                               sv_cant_stock     OUT NOCOPY al_stock.can_stock%TYPE,
                               sn_cod_retorno    OUT NOCOPY ge_errores_pg.coderror,
                               sv_mens_retorno   OUT NOCOPY ge_errores_pg.msgerror,
                               sn_num_evento     OUT NOCOPY ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_obt_parametro_pr(ev_nom_parametro IN ged_parametros.nom_parametro%TYPE,
                              ev_cod_modulo    IN ged_parametros.cod_modulo%TYPE,
                              sv_val_parametro OUT NOCOPY ged_parametros.val_parametro%TYPE,
                              sn_cod_retorno   OUT NOCOPY ge_errores_pg.coderror,
                              sv_mens_retorno  OUT NOCOPY ge_errores_pg.msgerror,
                              sn_num_evento    OUT NOCOPY ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_valida_autoriza_pr(en_num_traspaso  IN al_traspasos.num_traspaso%TYPE,
                                sn_cod_retorno   OUT NOCOPY ge_errores_pg.coderror,
                                sv_mens_retorno  OUT NOCOPY ge_errores_pg.msgerror,
                                sn_num_evento    OUT NOCOPY ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_elim_lin_traspaso_pr(en_num_traspaso  IN al_traspasos.num_traspaso%TYPE,
                                  sn_cod_retorno   OUT NOCOPY ge_errores_pg.coderror,
                                  sv_mens_retorno  OUT NOCOPY ge_errores_pg.msgerror,
                                  sn_num_evento    OUT NOCOPY ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_ins_esta_traspaso_pr(en_num_traspaso    IN al_traspasos.num_traspaso%TYPE,
                                  ev_estado_traspaso IN al_estado_traspaso_to.estado_traspaso%TYPE,
                                  sn_cod_retorno     OUT NOCOPY ge_errores_pg.coderror,
                                  sv_mens_retorno    OUT NOCOPY ge_errores_pg.msgerror,
                                  sn_num_evento      OUT NOCOPY ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_upd_esta_traspaso_pr(en_num_traspaso    IN al_traspasos.num_traspaso%TYPE,
                                  ev_estado_traspaso IN al_estado_traspaso_to.estado_traspaso%TYPE,
                                  ev_mens_error      IN al_estado_traspaso_to.mensaje_error%TYPE,
                                  sn_cod_retorno     OUT NOCOPY ge_errores_pg.coderror,
                                  sv_mens_retorno    OUT NOCOPY ge_errores_pg.msgerror,
                                  sn_num_evento      OUT NOCOPY ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_cons_esta_traspaso_pr(en_num_traspaso    IN al_traspasos.num_traspaso%TYPE,
                                   ev_estado_traspaso OUT NOCOPY al_estado_traspaso_to.estado_traspaso%TYPE,
                                   ev_mens_error      OUT NOCOPY al_estado_traspaso_to.mensaje_error%TYPE,
                                   sn_cod_retorno     OUT NOCOPY ge_errores_pg.coderror,
                                   sv_mens_retorno    OUT NOCOPY ge_errores_pg.msgerror,
                                   sn_num_evento      OUT NOCOPY ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_obt_cant_traspaso_pr(en_num_traspaso    IN al_traspasos.num_traspaso%TYPE,
                                  en_cod_articulo    IN al_articulos.cod_articulo%TYPE,
                                  sn_cantidad        OUT NOCOPY al_lin_peticion.can_traspaso%TYPE,
                                  sn_cod_retorno     OUT NOCOPY ge_errores_pg.coderror,
                                  sv_mens_retorno    OUT NOCOPY ge_errores_pg.msgerror,
                                  sn_num_evento      OUT NOCOPY ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_elimi_ser_tras_pr(en_num_traspaso    IN al_traspasos.num_traspaso%TYPE,
                               sn_cod_retorno     OUT NOCOPY ge_errores_pg.coderror,
                               sv_mens_retorno    OUT NOCOPY ge_errores_pg.msgerror,
                               sn_num_evento      OUT NOCOPY ge_errores_pg.evento);   
------------------------------------------------------------------------------------------------------
PROCEDURE al_elimi_lin_tras_pr(en_num_traspaso    IN al_traspasos.num_traspaso%TYPE,
                               sn_cod_retorno     OUT NOCOPY ge_errores_pg.coderror,
                               sv_mens_retorno    OUT NOCOPY ge_errores_pg.msgerror,
                               sn_num_evento      OUT NOCOPY ge_errores_pg.evento);                                                                                                 
------------------------------------------------------------------------------------------------------
END AL_TRASPASO_WS_PG;
/
SHOW ERRORS