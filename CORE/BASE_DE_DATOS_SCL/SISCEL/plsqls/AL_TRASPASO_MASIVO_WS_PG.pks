CREATE OR REPLACE PACKAGE AL_TRASPASO_MASIVO_WS_PG IS 

cv_error_no_clasif    CONSTANT VARCHAR2(50):= 'No es posible clasificar el error';
cv_moduloal           CONSTANT VARCHAR(2):= 'AL';
cv_param_ipsmtp       CONSTANT npt_parametro.alias_parametro%TYPE:='IPSMTP';
cv_par_mov_dts        CONSTANT ged_parametros.nom_parametro%TYPE:= 'VAL_MOV_DTS';
cv_cod_producto       CONSTANT NUMBER := 1;

TYPE REFCURSOR      IS REF CURSOR;                                       
------------------------------------------------------------------------------------------------------
PROCEDURE al_obtiene_numero_secuencia(ev_nombre_secuencia IN VARCHAR2,
                                      sn_num_secuencia    OUT NOCOPY NUMBER, 
                                      sn_cod_retorno      OUT NOCOPY ge_errores_pg.coderror,
                                      sv_mens_retorno     OUT NOCOPY ge_errores_pg.msgerror,
                                      sn_num_evento       OUT NOCOPY ge_errores_pg.evento
                                      );
------------------------------------------------------------------------------------------------------
PROCEDURE al_obtiene_parametro(ev_nombre_parametro IN ged_parametros.nom_parametro%TYPE,
                               ev_cod_modulo       IN ged_parametros.cod_modulo%TYPE,
                               ev_cod_producto     IN ged_parametros.cod_producto%TYPE,
                               sv_val_parametro    OUT NOCOPY ged_parametros.val_parametro%TYPE, 
                               sn_cod_retorno      OUT NOCOPY ge_errores_pg.coderror,
                               sv_mens_retorno     OUT NOCOPY ge_errores_pg.msgerror,
                               sn_num_evento       OUT NOCOPY ge_errores_pg.evento
                               );                                      
------------------------------------------------------------------------------------------------------
PROCEDURE al_obtiene_datos_serie(ev_num_serie    IN al_series.num_serie%TYPE,
                                 sn_tip_stock    OUT NOCOPY al_series.tip_stock%TYPE,
                                 sn_cod_estado   OUT NOCOPY al_series.cod_estado%TYPE,
                                 sn_cod_uso      OUT NOCOPY al_series.cod_uso%TYPE,
                                 sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                                 sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                                 sn_num_evento   OUT NOCOPY ge_errores_pg.evento
                                 );    
------------------------------------------------------------------------------------------------------
PROCEDURE al_consulta_series_error(ev_num_tras_masiv IN al_series_temp_to.num_traspaso%TYPE,
                                   ev_tip_busqueda   IN VARCHAR2,   
                                   sn_cantidad       OUT NOCOPY NUMBER,
                                   sn_cod_retorno    OUT NOCOPY ge_errores_pg.coderror,
                                   sv_mens_retorno   OUT NOCOPY ge_errores_pg.msgerror,
                                   sn_num_evento     OUT NOCOPY ge_errores_pg.evento
                                   );  
------------------------------------------------------------------------------------------------------
PROCEDURE al_get_datos_correo_pr(ev_parametro      IN npt_parametro.alias_parametro%TYPE,  
                                 sv_ip_smtp        OUT NOCOPY npt_parametro.valor_parametro%TYPE,
                                 sv_remitente      OUT NOCOPY npt_parametro.valor_parametro%TYPE,
                                 sc_cursor_correos OUT NOCOPY refcursor,
                                 sn_cod_retorno    OUT NOCOPY ge_errores_pg.coderror,
                                 sv_mens_retorno   OUT NOCOPY ge_errores_pg.msgerror,
                                 sn_num_evento     OUT NOCOPY ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_ingreso_traspaso_op_pr(en_num_traspaso    IN al_traspasos_op_to.num_traspaso%TYPE,
                                    en_num_traspaso_op IN al_traspasos_op_to.num_trasp_op%TYPE,
                                    en_estado          IN al_traspasos_op_to.des_estado%TYPE,
                                    sn_cod_retorno     OUT NOCOPY ge_errores_pg.coderror,
                                    sv_mens_retorno    OUT NOCOPY ge_errores_pg.msgerror,
                                    sn_num_evento      OUT NOCOPY ge_errores_pg.evento);  
-----------------------------------------------------------------------------------------------------
PROCEDURE al_actualiza_traspaso_op_pr(en_num_traspaso    IN al_traspasos_op_to.num_traspaso%TYPE,
                                      en_num_traspaso_op IN al_traspasos_op_to.num_trasp_op%TYPE,
                                      en_estado          IN al_traspasos_op_to.des_estado%TYPE,
                                      sn_cod_retorno     OUT NOCOPY ge_errores_pg.coderror,
                                      sv_mens_retorno    OUT NOCOPY ge_errores_pg.msgerror,
                                      sn_num_evento      OUT NOCOPY ge_errores_pg.evento);                                                                   
------------------------------------------------------------------------------------------------------
PROCEDURE al_tratamiento_masivo(ev_num_traspaso_mas IN VARCHAR2,
                                ev_obs_traspaso_mas IN al_traspasos.des_observacion%TYPE, 
                                sn_cod_retorno      OUT NOCOPY ge_errores_pg.coderror,
                                sv_mens_retorno     OUT NOCOPY ge_errores_pg.msgerror,
                                sn_num_evento       OUT NOCOPY ge_errores_pg.evento);   
------------------------------------------------------------------------------------------------------
PROCEDURE al_hist_traspasos_mas (en_num_trasp    IN al_traspasos_masivo.num_traspaso_masivo%type,
                                 sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                                 sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                                 sn_num_evento   OUT NOCOPY ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_vali_traspaso_op(en_num_secuencia    IN al_traspasos_op_to.num_trasp_op%TYPE,
                              sn_cantidad         OUT NOCOPY NUMBER, 
                              sn_cod_retorno      OUT NOCOPY ge_errores_pg.coderror,
                              sv_mens_retorno     OUT NOCOPY ge_errores_pg.msgerror,
                              sn_num_evento       OUT NOCOPY ge_errores_pg.evento);    
------------------------------------------------------------------------------------------------------
PROCEDURE al_consu_estad_tras_op(en_num_secuencia    IN al_traspasos_op_to.num_trasp_op%TYPE,
                                 sn_num_traspaso     OUT NOCOPY al_traspasos_op_to.num_traspaso%TYPE,
                                 sv_des_estado       OUT NOCOPY al_traspasos_op_to.des_estado%TYPE,
                                 sv_esok             OUT NOCOPY VARCHAR,
                                 sc_errores          OUT NOCOPY refcursor,
                                 sn_cod_retorno      OUT NOCOPY ge_errores_pg.coderror,
                                 sv_mens_retorno     OUT NOCOPY ge_errores_pg.msgerror,
                                 sn_num_evento       OUT NOCOPY ge_errores_pg.evento); 
------------------------------------------------------------------------------------------------------
PROCEDURE al_valida_bodega_dts(en_cod_cliente  IN npt_usuario_cliente.cod_cliente%TYPE,
                               en_cod_bodega   IN npt_usuario_bodega.cod_bodega%TYPE, 
                               sn_cantidad     OUT NOCOPY NUMBER, 
                               sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                               sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                               sn_num_evento   OUT NOCOPY ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_ins_movimiento_descarga(en_num_serie    IN al_series.num_serie%TYPE,
                                     en_secuencia    IN NUMBER,
                                     en_cod_bodega   IN al_series.cod_bodega%TYPE,
                                     en_cod_cliente  IN npt_usuario_cliente.cod_cliente%TYPE,
                                     sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                                     sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                                     sn_num_evento   OUT NOCOPY ge_errores_pg.evento);  
------------------------------------------------------------------------------------------------------
PROCEDURE al_series_error_dts(en_secuencia    IN NUMBER,
                              ev_cod_modulo   IN al_series_temp_to.cod_modulo%TYPE,
                              ev_proceso      IN al_series_temp_to.proc_invocador%TYPE,
                              ev_num_linea    IN al_series_temp_to.lin_traspaso%TYPE,                              
                              sc_errores      OUT NOCOPY refcursor, 
                              sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                              sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                              sn_num_evento   OUT NOCOPY ge_errores_pg.evento);  
------------------------------------------------------------------------------------------------------
PROCEDURE al_obtiene_series_error(ev_num_tras_masiv IN al_series_temp_to.num_traspaso%TYPE,
                                  ev_tip_busqueda   IN VARCHAR2,   
                                  sc_errores        OUT NOCOPY refcursor,
                                  sn_cod_retorno    OUT NOCOPY ge_errores_pg.coderror,
                                  sv_mens_retorno   OUT NOCOPY ge_errores_pg.msgerror,
                                  sn_num_evento     OUT NOCOPY ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_elimina_tras_mas(en_num_traspaso IN al_traspasos_op_to.num_traspaso%TYPE,
                              sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                              sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                              sn_num_evento   OUT NOCOPY ge_errores_pg.evento);    
------------------------------------------------------------------------------------------------------
PROCEDURE al_valida_bode_tras(en_num_traspaso IN al_traspasos_op_to.num_traspaso%TYPE,                              
                              sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                              sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                              sn_num_evento   OUT NOCOPY ge_errores_pg.evento);     
------------------------------------------------------------------------------------------------------
PROCEDURE al_elimina_des_in_mas(en_num_secuencia IN al_series_temp_to.num_traspaso%TYPE,
                                ev_cod_modulo    IN al_series_temp_to.cod_modulo%TYPE,
                                ev_proceso       IN al_series_temp_to.proc_invocador%TYPE,
                                ev_num_linea     IN al_series_temp_to.lin_traspaso%TYPE,
                                sn_cod_retorno   OUT NOCOPY ge_errores_pg.coderror,
                                sv_mens_retorno  OUT NOCOPY ge_errores_pg.msgerror,
                                sn_num_evento    OUT NOCOPY ge_errores_pg.evento);                                                                                                                                                                                                                                                                                                                                                                                                                                 
------------------------------------------------------------------------------------------------------                                                                                                                                                                           
END AL_TRASPASO_MASIVO_WS_PG;
/
SHOW ERROR