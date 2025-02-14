CREATE OR REPLACE PACKAGE al_integracion_sicsa_pg IS 

CV_error_no_clasif  CONSTANT VARCHAR2(50):= 'No es posible clasificar el error';
CV_cod_moduloAL     CONSTANT  ged_parametros.cod_modulo%TYPE:='AL';
CV_EST_VALIDANDO    CONSTANT  NP_VENTAS_OL_TO.ESTADO%TYPE:='VALIDANDO';
CV_PARAM_IPSMTP     CONSTANT  NPT_PARAMETRO.ALIAS_PARAMETRO%TYPE:='IPSMTP';
CV_PARAM_REMAIL     CONSTANT  NPT_PARAMETRO.ALIAS_PARAMETRO%TYPE:='REM_EMAIL';
TYPE refcursor IS REF CURSOR;
------------------------------------------------------------------------------------------------------
PROCEDURE al_ins_encabezado_venta_pr(EN_num_proceso_ol IN NP_VENTAS_OL_TO.NUM_PROCESO_OL%TYPE,  
                                     EN_NUM_OPERACION IN NP_VENTAS_OL_TO.NUM_OPERACION%TYPE,                                    
                                     EN_cod_cliente IN NP_VENTAS_OL_TO.COD_CLIENTE %TYPE,
                                     EV_nom_cliente IN NP_VENTAS_OL_TO.NOM_CLIENTE%TYPE,
                                     EN_total_venta IN NP_VENTAS_OL_TO.TOTAL_VENTA%TYPE,
                                     EV_ind_accion IN NP_VENTAS_OL_TO.IND_ACCION%TYPE,
                                     ED_fec_operacion IN VARCHAR,                                                       
                                     SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------------------------------------    
PROCEDURE al_ins_encabezado_devol_pr(EN_num_proceso_ol IN NP_VENTAS_OL_TO.NUM_PROCESO_OL%TYPE,  
                                     EN_NUM_OPERACION IN NP_VENTAS_OL_TO.NUM_OPERACION%TYPE,                                    
                                     EV_ind_accion IN NP_VENTAS_OL_TO.IND_ACCION%TYPE,                                                            
                                     SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------------------------------------     
PROCEDURE al_ins_linea_venta_pr(EN_num_operacion IN NP_DET_VENTAS_OL_TO.NUM_OPERACION%TYPE,
                                     EN_lin_proceso IN NP_DET_VENTAS_OL_TO.LIN_PROCESO%TYPE,
                                     EN_cod_articulo IN NP_DET_VENTAS_OL_TO.COD_ARTICULO%TYPE,
                                     EV_des_articulo IN NP_DET_VENTAS_OL_TO.DES_ARTICULO%TYPE,
                                     EN_can_articulo IN NP_DET_VENTAS_OL_TO.CAN_ARTICULO %TYPE,
                                     EN_prc_venta    IN NP_DET_VENTAS_OL_TO.PRC_VENTA%TYPE,                                                          
                                     SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------------------------------------ 

PROCEDURE al_ins_serie_venta_pr(EN_num_operacion IN NP_SER_VENTAS_OL_TO.NUM_OPERACION%TYPE,
                                     EN_lin_proceso IN NP_SER_VENTAS_OL_TO.LIN_PROCESO%TYPE,
                                     EV_num_serie IN NP_SER_VENTAS_OL_TO.NUM_SERIE%TYPE,                                                       
                                     SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------------------------------------    
PROCEDURE al_get_seq_proceso_pr(SN_NUM_OPERACION OUT NOCOPY NP_VENTAS_OL_TO.NUM_OPERACION%TYPE,                                                            
                                     SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------------------------------------             
------------------------------------------------------------------------------------------------------    
PROCEDURE al_act_estado_proceso_pr(EN_NUM_OPERACION IN NP_VENTAS_OL_TO.NUM_OPERACION%TYPE,  
                                    EV_ESTADO     IN NP_VENTAS_OL_TO.ESTADO%TYPE,                                                     
                                     SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------------------------------------      
PROCEDURE al_val_num_proceso_pr(EN_num_proceso_ol IN NP_VENTAS_OL_TO.NUM_PROCESO_OL%TYPE,                                                  
                                     SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------------------------------------
PROCEDURE al_cons_est_proceso_pr(EN_num_proceso_ol IN NP_VENTAS_OL_TO.NUM_PROCESO_OL%TYPE,  
                                    SN_cod_cliente OUT NOCOPY NP_VENTAS_OL_TO.COD_CLIENTE %TYPE,
                                     SV_nom_cliente OUT NOCOPY NP_VENTAS_OL_TO.NOM_CLIENTE%TYPE,
                                     SN_total_venta OUT NOCOPY NP_VENTAS_OL_TO.TOTAL_VENTA%TYPE,
                                     SD_fec_operacion OUT NOCOPY NP_VENTAS_OL_TO.FEC_OPERACION%TYPE,
                                     SV_estado OUT NOCOPY NP_VENTAS_OL_TO.ESTADO%TYPE,                                                
                                     SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------------------------------------  
 
PROCEDURE al_get_datos_correo_pr(EV_PARAMTERO IN NPT_PARAMETRO.ALIAS_PARAMETRO%TYPE,  
                                    SV_IP_SMTP OUT NOCOPY NPT_PARAMETRO.VALOR_PARAMETRO%TYPE,
                                    SV_REMITENTE OUT NOCOPY NPT_PARAMETRO.VALOR_PARAMETRO%TYPE,
                                    SC_cursor_correos  OUT NOCOPY REFCURSOR,
                                     SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------------------------------------     
PROCEDURE al_get_datos_usuario_pr(EN_COD_USUARIO IN PSD_USUARIO.COD_USUARIO%TYPE,
                                     SV_NOM_USUARIO OUT NOCOPY PSD_USUARIO.NOM_USUARIO%TYPE,
                                     SV_APP_USUARIO OUT NOCOPY PSD_USUARIO.APP_USUARIO%TYPE,
                                     SV_UID_USUARIO OUT NOCOPY PSD_USUARIO.UID_USUARIO%TYPE,
                                     SV_EMAIL_USUARIO OUT NOCOPY PSD_USUARIO.EMAIL_USUARIO%TYPE,                                        
                                     SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------------------------------------  

PROCEDURE al_get_pedido_usuario_pr(EN_COD_USUARIO IN PSD_USUARIO.COD_USUARIO%TYPE,
                                   EV_COD_PEDIDO IN VARCHAR,
                                   EV_FEC_DESDE IN VARCHAR,
                                   EV_FEC_HASTA IN VARCHAR,         
                                   SC_PEDIDOS  OUT NOCOPY REFCURSOR,                                                                
                                   SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);
----------------------------------------------------------------------------------------------   
PROCEDURE al_get_det_pedido_pr(EV_COD_PEDIDO IN VARCHAR,      
                                   SC_DET_PEDIDOS  OUT NOCOPY REFCURSOR,                                                                                                                           
                                   SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);
                                   
PROCEDURE al_get_ser_pedido_pr(EV_COD_PEDIDO IN VARCHAR,     
                               EV_LIN_PROCESO IN VARCHAR,  
                                   SC_SER_PEDIDOS  OUT NOCOPY REFCURSOR,                                                                                                                                
                                   SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);  
PROCEDURE al_get_grupos_correos(   SC_GRUPOS_CORR  OUT NOCOPY REFCURSOR,                                                                                                                                
                                   SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);           
PROCEDURE al_get_correos(   EN_COD_GRUPO IN npt_grupo_mail.COD_GRUPO%TYPE,
                                   SC_CORREOS  OUT NOCOPY REFCURSOR,                                                                                                                                
                                   SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento   OUT NOCOPY ge_errores_pg.Evento); 
                                   
PROCEDURE al_borrar_correo(   EN_COD_GRUPO IN npt_grupo_mail.COD_GRUPO%TYPE,
                              EV_MAIL IN npt_grupo_mail.MAIL_USUARIO%TYPE,                                                                                                                     
                              SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                              SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                              SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);  
PROCEDURE al_modif_correo(   EN_COD_GRUPO IN npt_grupo_mail.COD_GRUPO%TYPE,
                              EV_MAIL_ANT IN npt_grupo_mail.MAIL_USUARIO%TYPE,  
                              EV_MAIL_NUE IN npt_grupo_mail.MAIL_USUARIO%TYPE,
                              EV_USUARIO IN npt_grupo_mail.NOMBRE_USUARIO%TYPE,                                                                                                                   
                              SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                              SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                              SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);      
PROCEDURE al_ins_correo(   EN_COD_GRUPO IN npt_grupo_mail.COD_GRUPO%TYPE,
                              EV_MAIL IN npt_grupo_mail.MAIL_USUARIO%TYPE,  
                              EV_USUARIO IN npt_grupo_mail.NOMBRE_USUARIO%TYPE,                                                                                                                   
                              SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                              SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                              SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);  
PROCEDURE al_limpia_pedido(   EN_COD_PEDIDO IN npt_pedido.COD_PEDIDO%TYPE,                                                                                                                 
                              SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                              SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                              SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE al_get_devolu_usuario_pr(EN_COD_USUARIO IN PSD_USUARIO.COD_USUARIO%TYPE,
                                   EV_COD_DEVOLU IN VARCHAR,
                                   EV_FEC_DESDE IN VARCHAR,
                                   EV_FEC_HASTA IN VARCHAR,         
                                   SC_DEVOLUCIONES  OUT NOCOPY REFCURSOR,                                                                
                                   SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);         
PROCEDURE al_get_det_devolu_pr(EV_COD_DEVOLU IN VARCHAR,      
                                   SC_DET_DEVOLU  OUT NOCOPY REFCURSOR,                                                                                                                           
                                   SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);                                                                                                                                                                                                                                                                                                                         
END al_integracion_sicsa_pg;
/
SHOW ERRORS