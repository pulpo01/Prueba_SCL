CREATE OR REPLACE PACKAGE al_notapedidoweb_pg IS 

CV_error_no_clasif  CONSTANT VARCHAR2(50):= 'No es posible clasificar el error';
CV_moduloAL         CONSTANT VARCHAR(2):= 'AL';
CV_cod_moduloAL     CONSTANT  ged_parametros.cod_modulo%TYPE:='AL';
CN_PEDIDO_DESPACHADOR         CONSTANT npt_estado_pedido.COD_ESTADO_FLUJO%TYPE:= 8;
TYPE REFCURSOR      IS REF CURSOR;
        
------------------------------------------------------------------------------------------------------
PROCEDURE al_estado_pedido_pr(EN_cod_pedido   IN npt_estado_pedido.cod_pedido%TYPE,    
                              EN_cod_funcion  IN npt_fun_estado_flujo_lee.COD_FUNCION%TYPE,                                                         
                              SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                              SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                              SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);    
------------------------------------------------------------------------------------------------------
PROCEDURE al_existe_pedido_pr(EN_cod_pedido   IN npt_estado_pedido.cod_pedido%TYPE,                                                            
                              SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                              SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                              SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_val_serie_pedido_pr(EN_cod_pedido   IN npt_estado_pedido.cod_pedido%TYPE,                                                            
                                 SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                 SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                 SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_elimina_pedido_pr(EN_cod_pedido   IN npt_estado_pedido.cod_pedido%TYPE,                                                            
                               SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                               SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                               SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_cantidad_pedido_pr(EN_cod_pedido   IN npt_pedido.cod_pedido%TYPE,  
                                SN_cant_pedido  OUT NOCOPY npt_pedido.CAN_TOTAL_PEDIDO%TYPE,
                                SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);      
------------------------------------------------------------------------------------------------------
PROCEDURE al_cantidad_pedido_x_linea_pr(EN_cod_pedido   IN npt_pedido.cod_pedido%TYPE,  
                                        SC_cursordatos  OUT NOCOPY REFCURSOR,
                                        SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);  
------------------------------------------------------------------------------------------------------
PROCEDURE al_datos_pedido_pr(EN_cod_pedido   IN npt_pedido.cod_pedido%TYPE,  
                             SN_cod_user_cre OUT NOCOPY npt_pedido.COD_USUARIO_CRE%TYPE,
                             SN_cod_user_ing OUT NOCOPY npt_pedido.COD_USUARIO_ING%TYPE,
                             SV_sysdate      OUT NOCOPY VARCHAR2,
                             SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                             SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                             SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);   
------------------------------------------------------------------------------------------------------
PROCEDURE al_pedido_control_pr(EN_cod_pedido   IN npt_pedido.cod_pedido%TYPE, 
                               SN_existe       OUT NOCOPY NUMBER,                              
                               SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                               SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                               SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_pedido_baja_pr(EN_cod_pedido   IN npt_pedido.cod_pedido%TYPE, 
                            SN_ped_baja     OUT NOCOPY NUMBER,                              
                            SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                            SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                            SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_insert_control_serie_pr(EN_cod_pedido   IN np_control_ing_series_to.COD_PEDIDO%TYPE, 
                                     EV_nom_user     IN np_control_ing_series_to.USUARIO_WEB%TYPE,
                                     EN_cantidad     IN np_control_ing_series_to.CANTIDAD_SERIES%TYPE,
                                     SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);    
------------------------------------------------------------------------------------------------------
PROCEDURE al_parametro_npw_pr(EN_alias         IN npt_parametro.ALIAS_PARAMETRO%TYPE, 
                              SN_val_parametro OUT NOCOPY npt_parametro.VALOR_PARAMETRO%TYPE,            
                              SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                              SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                              SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);      
------------------------------------------------------------------------------------------------------
PROCEDURE al_estado_flujo_esc_pr(EN_cod_funcion  IN npt_fun_estado_flujo_esc.COD_FUNCION%TYPE,
                                 SN_val_estado   OUT NOCOPY npt_fun_estado_flujo_esc.COD_ESTADO_FLUJO%TYPE,            
                                 SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                 SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                 SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);    
------------------------------------------------------------------------------------------------------
PROCEDURE al_val_deta_valida_serie_pr(EN_cod_pedido   IN npt_detalle_pedido.COD_PEDIDO%TYPE,        
                                      SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento   OUT NOCOPY ge_errores_pg.Evento); 
------------------------------------------------------------------------------------------------------
PROCEDURE al_val_serie_pedido_pr(EN_cod_pedido   IN npt_pedido.cod_pedido%TYPE, 
                                 SN_ped_serie    OUT NOCOPY NUMBER,                              
                                 SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                 SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                 SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_val_estado_control_pr(EN_cod_pedido     IN npt_pedido.cod_pedido%TYPE, 
                                   EN_estado_proceso IN np_control_ing_series_to.estado_proceso%TYPE,  
                                   SN_est_serie      OUT NOCOPY NUMBER,                              
                                   SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);  
------------------------------------------------------------------------------------------------------
PROCEDURE al_upd_estado_control_pr(EN_cod_pedido     IN npt_pedido.cod_pedido%TYPE,   
                                   EN_estado_actual  IN np_control_ing_series_to.estado_proceso%TYPE,
                                   EN_estado_nuevo   IN np_control_ing_series_to.estado_proceso%TYPE,                 
                                   SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);  
------------------------------------------------------------------------------------------------------
PROCEDURE al_ins_serie_pedido_pr(EN_cod_pedido     IN npt_pedido.cod_pedido%TYPE,                    
                                 SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                 SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                 SN_num_evento     OUT NOCOPY ge_errores_pg.Evento); 
------------------------------------------------------------------------------------------------------
PROCEDURE al_bodega_pedido_pr(EN_cod_pedido   IN npt_pedido.cod_pedido%TYPE,                    
                              SN_cod_bodega   OUT NOCOPY npt_pedido.COD_BODEGA%TYPE,
                              SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                              SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                              SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);   
------------------------------------------------------------------------------------------------------
PROCEDURE al_upd_pedido_pr(EN_cod_pedido   IN npt_pedido.cod_pedido%TYPE,
                           EN_num_guia     IN npt_pedido.NUM_GUIA%TYPE,
                           SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                           SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                           SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);  
------------------------------------------------------------------------------------------------------
PROCEDURE al_series_erroneas_pr(EN_cod_pedido   IN npt_pedido.cod_pedido%TYPE,  
                                SC_cursordatos  OUT NOCOPY REFCURSOR,
                                SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);       
------------------------------------------------------------------------------------------------------
PROCEDURE al_upd_control_reproceso_pr(EN_cod_pedido      IN npt_pedido.cod_pedido%TYPE,   
                                      EV_estado_registro IN np_control_ing_series_to.ESTADO_REGISTRO%TYPE,                 
                                      SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);    
------------------------------------------------------------------------------------------------------
PROCEDURE al_des_articulo_pr(EN_cod_articulo IN al_articulos.COD_ARTICULO%TYPE,
                             SV_des_articulo OUT NOCOPY al_articulos.DES_ARTICULO%TYPE,                 
                             SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                             SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                             SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);     
------------------------------------------------------------------------------------------------------
PROCEDURE al_des_estado_pedido_pr(EN_cod_pedido   IN npt_estado_pedido.COD_PEDIDO%TYPE,
                                  SN_cod_estado   OUT NOCOPY npd_estado_flujo.COD_ESTADO_FLUJO%TYPE,
                                  SV_des_estado   OUT NOCOPY npd_estado_flujo.DES_ESTADO_FLUJO%TYPE, 
                                  SV_esok         OUT NOCOPY VARCHAR,
                                  SC_errores      OUT NOCOPY REFCURSOR,      
                                  SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                  SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                  SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);  
------------------------------------------------------------------------------------------------------
PROCEDURE al_elimina_pedido_temp_pr (en_cod_pedido   IN np_val_series_temp_to.cod_pedido%TYPE,
                                     sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                                     sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                                     sn_num_evento   OUT NOCOPY ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_inserta_pedido_temp_pr (en_cod_pedido   IN np_validacion_series_to.cod_pedido%TYPE,
                                     sn_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                                     sv_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                                     sn_num_evento   OUT NOCOPY ge_errores_pg.evento);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
------------------------------------------------------------------------------------------------------                      
END al_notapedidoweb_pg;
/
SHOW ERRORS