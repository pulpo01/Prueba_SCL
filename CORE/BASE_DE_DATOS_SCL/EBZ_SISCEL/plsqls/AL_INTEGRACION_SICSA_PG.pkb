CREATE OR REPLACE PACKAGE BODY al_integracion_sicsa_pg  IS
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
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
IS
 
 LV_sSql ge_errores_pg.vQuery;
 LV_des_error     ge_errores_pg.DesEvent;
 
BEGIN
     SN_num_evento :=0;
     SN_cod_retorno :=0;
     
     LV_sSql :='INSERT INTO NP_VENTAS_OL_TO(NUM_PROCESO_OL, NUM_OPERACION,COD_CLIENTE,NOM_CLIENTE,TOTAL_VENTA,IND_ACCION,FEC_OPERACION, ESTADO)';
     LV_sSql := LV_sSql||'VALUES ('||EN_NUM_PROCESO_OL||','||EN_NUM_OPERACION||','||EN_COD_CLIENTE||','''||EV_NOM_CLIENTE||''','||EN_TOTAL_VENTA||','''||EV_IND_ACCION||''','''||ED_FEC_OPERACION||''', '''||CV_EST_VALIDANDO||''')'; 
        
     INSERT INTO NP_VENTAS_OL_TO(NUM_PROCESO_OL,NUM_OPERACION,COD_CLIENTE,NOM_CLIENTE,TOTAL_VENTA,IND_ACCION,FEC_OPERACION,ESTADO)
     VALUES (EN_NUM_PROCESO_OL,EN_NUM_OPERACION,EN_COD_CLIENTE,EV_NOM_CLIENTE,EN_TOTAL_VENTA,EV_IND_ACCION,TO_DATE(ED_FEC_OPERACION,'dd/MM/yyyy'),CV_EST_VALIDANDO);

EXCEPTION
WHEN OTHERS THEN
        SN_cod_retorno := 900000; 
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error := 'al_integracion_sicsa_pg.al_ins_encabezado_venta_pr; - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'al_integracion_sicsa_pg.al_ins_encabezado_venta_pr', LV_sSql, SQLCODE, LV_des_error );

END al_ins_encabezado_venta_pr;


PROCEDURE al_ins_encabezado_devol_pr(EN_num_proceso_ol IN NP_VENTAS_OL_TO.NUM_PROCESO_OL%TYPE,  
                                     EN_NUM_OPERACION IN NP_VENTAS_OL_TO.NUM_OPERACION%TYPE,                                    
                                     EV_ind_accion IN NP_VENTAS_OL_TO.IND_ACCION%TYPE,                                                            
                                     SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
IS
 
 LV_sSql ge_errores_pg.vQuery;
 LV_des_error     ge_errores_pg.DesEvent;
 
BEGIN
     SN_num_evento :=0;
     SN_cod_retorno :=0;
         

     LV_sSql :='INSERT INTO NP_VENTAS_OL_TO(NUM_PROCESO_OL, NUM_OPERACION,IND_ACCION, ESTADO)';
     LV_sSql := LV_sSql||'VALUES ('||EN_NUM_PROCESO_OL||','||EN_NUM_OPERACION||','''||EV_IND_ACCION||''','''||CV_EST_VALIDANDO||''')'; 
        
     INSERT INTO NP_VENTAS_OL_TO(NUM_PROCESO_OL,NUM_OPERACION,IND_ACCION,ESTADO)
     VALUES (EN_NUM_PROCESO_OL,EN_NUM_OPERACION,EV_IND_ACCION,CV_EST_VALIDANDO);

EXCEPTION
WHEN OTHERS THEN
        SN_cod_retorno := 900007; 
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error := 'al_integracion_sicsa_pg.al_ins_encabezado_devol_pr; - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'al_integracion_sicsa_pg.al_ins_encabezado_devol_pr', LV_sSql, SQLCODE, LV_des_error );

END al_ins_encabezado_devol_pr;

PROCEDURE al_ins_linea_venta_pr(EN_num_operacion IN NP_DET_VENTAS_OL_TO.NUM_OPERACION%TYPE,
                                     EN_lin_proceso IN NP_DET_VENTAS_OL_TO.LIN_PROCESO%TYPE,
                                     EN_cod_articulo IN NP_DET_VENTAS_OL_TO.COD_ARTICULO%TYPE,
                                     EV_des_articulo IN NP_DET_VENTAS_OL_TO.DES_ARTICULO%TYPE,
                                     EN_can_articulo IN NP_DET_VENTAS_OL_TO.CAN_ARTICULO %TYPE,
                                     EN_prc_venta    IN NP_DET_VENTAS_OL_TO.PRC_VENTA%TYPE,                                                          
                                     SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
IS
 
 LV_sSql ge_errores_pg.vQuery;
 LV_des_error     ge_errores_pg.DesEvent;
 
BEGIN
     SN_num_evento :=0;
     SN_cod_retorno :=0;

     LV_sSql :='INSERT INTO NP_DET_VENTAS_OL_TO(NUM_OPERACION,LIN_PROCESO,COD_ARTICULO ,DES_ARTICULO,CAN_ARTICULO,PRC_VENTA)';
     LV_sSql := LV_sSql||'VALUES ('||EN_NUM_OPERACION||','||EN_LIN_PROCESO||','||EN_COD_ARTICULO||','''||EV_DES_ARTICULO||''','||EN_CAN_ARTICULO||','||EN_PRC_VENTA||')'; 
        
     INSERT INTO NP_DET_VENTAS_OL_TO(NUM_OPERACION,LIN_PROCESO,COD_ARTICULO ,DES_ARTICULO,CAN_ARTICULO,PRC_VENTA)
     VALUES (EN_NUM_OPERACION,EN_LIN_PROCESO,EN_COD_ARTICULO ,EV_DES_ARTICULO,EN_CAN_ARTICULO,EN_PRC_VENTA);

EXCEPTION
WHEN OTHERS THEN
        SN_cod_retorno := 900001; -- CAMBIAR POR CODIGO DE ERROR ADECUADO
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error := 'al_integracion_sicsa_pg.al_ins_linea_venta_pr; - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'al_integracion_sicsa_pg.al_ins_linea_venta_pr', LV_sSql, SQLCODE, LV_des_error );

END al_ins_linea_venta_pr;


PROCEDURE al_ins_serie_venta_pr(EN_num_operacion IN NP_SER_VENTAS_OL_TO.NUM_OPERACION%TYPE,
                                     EN_lin_proceso IN NP_SER_VENTAS_OL_TO.LIN_PROCESO%TYPE,
                                     EV_num_serie IN NP_SER_VENTAS_OL_TO.NUM_SERIE%TYPE,                                                       
                                     SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
IS
 
 LV_sSql ge_errores_pg.vQuery;
 LV_des_error     ge_errores_pg.DesEvent;
 
BEGIN
     SN_num_evento :=0;
     SN_cod_retorno :=0;

     LV_sSql :='INSERT INTO NP_SER_VENTAS_OL_TO(NUM_OPERACION,LIN_PROCESO,NUM_SERIE)';
     LV_sSql := LV_sSql||'VALUES ('||EN_NUM_OPERACION||','||EN_LIN_PROCESO||','||EV_NUM_SERIE||')'; 
        
     INSERT INTO NP_SER_VENTAS_OL_TO(NUM_OPERACION,LIN_PROCESO,NUM_SERIE)
     VALUES (EN_NUM_OPERACION,EN_LIN_PROCESO,EV_NUM_SERIE);

EXCEPTION
WHEN OTHERS THEN
        SN_cod_retorno := 900002; 
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error := 'al_integracion_sicsa_pg.al_ins_serie_venta_pr; - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'al_integracion_sicsa_pg.al_ins_serie_venta_pr', LV_sSql, SQLCODE, LV_des_error );

END al_ins_serie_venta_pr;

PROCEDURE al_get_seq_proceso_pr(SN_NUM_OPERACION OUT NOCOPY NP_VENTAS_OL_TO.NUM_OPERACION%TYPE,                                                            
                                     SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
IS
 
 LV_sSql ge_errores_pg.vQuery;
 LV_des_error     ge_errores_pg.DesEvent;
 
BEGIN
     SN_num_evento :=0;
     SN_cod_retorno :=0;

     SELECT  NP_VENTA_OL_SQ.NEXTVAL INTO SN_NUM_OPERACION FROM DUAL;

EXCEPTION
WHEN OTHERS THEN
        SN_cod_retorno := 900003; -- CAMBIAR POR CODIGO DE ERROR ADECUADO
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error := 'al_integracion_sicsa_pg.al_get_seq_proceso_pr; - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'al_integracion_sicsa_pg.al_get_seq_proceso_pr', LV_sSql, SQLCODE, LV_des_error );

END al_get_seq_proceso_pr;

PROCEDURE al_act_estado_proceso_pr(EN_NUM_OPERACION IN NP_VENTAS_OL_TO.NUM_OPERACION%TYPE,  
                                    EV_ESTADO     IN NP_VENTAS_OL_TO.ESTADO%TYPE,                                                     
                                     SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
IS
 pragma autonomous_transaction;
 
 LV_sSql ge_errores_pg.vQuery;
 LV_des_error     ge_errores_pg.DesEvent;
 
BEGIN
     SN_num_evento :=0;
     SN_cod_retorno :=0;

     UPDATE NP_VENTAS_OL_TO SET ESTADO = EV_ESTADO WHERE NUM_OPERACION=EN_NUM_OPERACION;

    COMMIT;
   
EXCEPTION
WHEN OTHERS THEN
        SN_cod_retorno := 900004; -- CAMBIAR POR CODIGO DE ERROR ADECUADO
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error := 'al_integracion_sicsa_pg.al_act_estado_proceso_pr; - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'al_integracion_sicsa_pg.al_act_estado_proceso_pr', LV_sSql, SQLCODE, LV_des_error );

END al_act_estado_proceso_pr;

PROCEDURE al_val_num_proceso_pr(EN_num_proceso_ol IN NP_VENTAS_OL_TO.NUM_PROCESO_OL%TYPE,                                                  
                                     SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
IS 
 LV_sSql ge_errores_pg.vQuery;
 LV_des_error     ge_errores_pg.DesEvent;
 LN_COUNT NUMBER;
 EXISTE_OPERACION EXCEPTION;
 
BEGIN
     SN_num_evento :=0;
     SN_cod_retorno :=0;

     SELECT COUNT(1) INTO LN_COUNT FROM NP_VENTAS_OL_TO
     WHERE NUM_PROCESO_OL=EN_NUM_PROCESO_OL
     AND ESTADO <> 'ERRONEO'
     AND IND_ACCION='V';
     
     IF LN_COUNT > 0 THEN
        RAISE EXISTE_OPERACION;
     END IF;

   
EXCEPTION
WHEN EXISTE_OPERACION THEN
        SN_cod_retorno := 900005; -- CAMBIAR POR CODIGO DE ERROR ADECUADO
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error := 'al_integracion_sicsa_pg.al_val_num_proceso_pr; - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'al_integracion_sicsa_pg.al_val_num_proceso_pr', LV_sSql, SQLCODE, LV_des_error );
WHEN OTHERS THEN
        SN_cod_retorno := 900006; -- CAMBIAR POR CODIGO DE ERROR ADECUADO
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error := 'al_integracion_sicsa_pg.al_val_num_proceso_pr; - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'al_integracion_sicsa_pg.al_val_num_proceso_pr', LV_sSql, SQLCODE, LV_des_error );

END al_val_num_proceso_pr;

PROCEDURE al_cons_est_proceso_pr(EN_num_proceso_ol IN NP_VENTAS_OL_TO.NUM_PROCESO_OL%TYPE,  
                                    SN_cod_cliente OUT NOCOPY NP_VENTAS_OL_TO.COD_CLIENTE %TYPE,
                                     SV_nom_cliente OUT NOCOPY NP_VENTAS_OL_TO.NOM_CLIENTE%TYPE,
                                     SN_total_venta OUT NOCOPY NP_VENTAS_OL_TO.TOTAL_VENTA%TYPE,
                                     SD_fec_operacion OUT NOCOPY NP_VENTAS_OL_TO.FEC_OPERACION%TYPE,
                                     SV_estado OUT NOCOPY NP_VENTAS_OL_TO.ESTADO%TYPE,                                                
                                     SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
IS 
 LV_sSql ge_errores_pg.vQuery;
 LV_des_error     ge_errores_pg.DesEvent;
 
BEGIN
     SN_num_evento :=0;
     SN_cod_retorno :=0;
     
     LV_sSql :='SELECT COD_CLIENTE, NOM_CLIENTE, TOTAL_VENTA, FEC_OPERACION, ESTADO FROM NP_VENTAS_OL_TO A';
     LV_sSql := LV_sSql||' WHERE A.NUM_PROCESO_OL='||EN_NUM_PROCESO_OL;
     LV_sSql := LV_sSql||' AND A.IND_ACCION=''V''';
     LV_sSql := LV_sSql||' AND A.NUM_OPERACION IN (SELECT MAX(NUM_OPERACION) FROM NP_VENTAS_OL_TO B';
     LV_sSql := LV_sSql||' WHERE B.NUM_PROCESO_OL='||EN_NUM_PROCESO_OL;
     LV_sSql := LV_sSql||' AND B.IND_ACCION=''V'');'; 
     

     SELECT COD_CLIENTE, NOM_CLIENTE, TOTAL_VENTA, FEC_OPERACION, ESTADO 
     INTO SN_COD_CLIENTE, SV_NOM_CLIENTE, SN_TOTAL_VENTA, SD_FEC_OPERACION, SV_ESTADO FROM NP_VENTAS_OL_TO A
     WHERE A.NUM_PROCESO_OL=EN_NUM_PROCESO_OL
     AND A.IND_ACCION='V'
     AND A.NUM_OPERACION IN (SELECT MAX(NUM_OPERACION) FROM NP_VENTAS_OL_TO B
     WHERE B.NUM_PROCESO_OL=EN_NUM_PROCESO_OL
     AND B.IND_ACCION='V');

EXCEPTION
WHEN NO_DATA_FOUND THEN
        SN_cod_retorno := 900021;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error := 'al_integracion_sicsa_pg.al_val_num_proceso_pr; - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'al_integracion_sicsa_pg.al_val_num_proceso_pr', LV_sSql, SQLCODE, LV_des_error );
WHEN OTHERS THEN
        SN_cod_retorno := 900022; 
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error := 'al_integracion_sicsa_pg.al_cons_est_proceso_pr; - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'al_integracion_sicsa_pg.al_cons_est_proceso_pr', LV_sSql, SQLCODE, LV_des_error );

END al_cons_est_proceso_pr;

PROCEDURE al_get_datos_correo_pr(EV_PARAMTERO IN NPT_PARAMETRO.ALIAS_PARAMETRO%TYPE,  
                                    SV_IP_SMTP OUT NOCOPY NPT_PARAMETRO.VALOR_PARAMETRO%TYPE,
                                    SV_REMITENTE OUT NOCOPY NPT_PARAMETRO.VALOR_PARAMETRO%TYPE,
                                    SC_cursor_correos  OUT NOCOPY REFCURSOR,
                                     SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
IS 
 LV_sSql ge_errores_pg.vQuery;
 LV_des_error     ge_errores_pg.DesEvent;
 
BEGIN
     SN_num_evento :=0;
     SN_cod_retorno :=0;
     
     LV_sSql :='select VALOR_PARAMETRO FROM NPT_PARAMETRO WHERE ALIAS_PARAMETRO='''||CV_PARAM_IPSMTP||'''';
     select VALOR_PARAMETRO INTO SV_IP_SMTP FROM NPT_PARAMETRO WHERE ALIAS_PARAMETRO=CV_PARAM_IPSMTP;
     
     /*LV_sSql :='select VALOR_PARAMETRO FROM NPT_PARAMETRO WHERE ALIAS_PARAMETRO='''||CV_PARAM_REMAIL||'''';
     select VALOR_PARAMETRO INTO SV_REMITENTE FROM NPT_PARAMETRO WHERE ALIAS_PARAMETRO=CV_PARAM_REMAIL;*/
     
     LV_sSql :='select VALOR_PARAMETRO FROM NPT_PARAMETRO WHERE ALIAS_PARAMETRO= ''REM_'||EV_PARAMTERO||'';
     select VALOR_PARAMETRO INTO SV_REMITENTE FROM NPT_PARAMETRO WHERE ALIAS_PARAMETRO='REM_'||EV_PARAMTERO;
     
     LV_sSql :='select MAIL_USUARIO, NOMBRE_USUARIO from NPT_GRUPO_MAIL WHERE COD_GRUPO IN(';
     LV_sSql :=LV_sSql||'select VALOR_PARAMETRO FROM NPT_PARAMETRO WHERE ALIAS_PARAMETRO='''||EV_PARAMTERO||''');';
     
     OPEN SC_cursor_correos FOR
        select MAIL_USUARIO, NOMBRE_USUARIO from NPT_GRUPO_MAIL WHERE COD_GRUPO IN(
            select VALOR_PARAMETRO FROM NPT_PARAMETRO WHERE ALIAS_PARAMETRO=EV_PARAMTERO);

EXCEPTION
WHEN OTHERS THEN
        SN_cod_retorno := 900023; 
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error := 'al_integracion_sicsa_pg.al_get_datos_correo_pr; - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'al_integracion_sicsa_pg.al_get_datos_correo_pr', LV_sSql, SQLCODE, LV_des_error );

END al_get_datos_correo_pr;     

PROCEDURE al_get_datos_usuario_pr(EN_COD_USUARIO IN PSD_USUARIO.COD_USUARIO%TYPE,
                                     SV_NOM_USUARIO OUT NOCOPY PSD_USUARIO.NOM_USUARIO%TYPE,
                                     SV_APP_USUARIO OUT NOCOPY PSD_USUARIO.APP_USUARIO%TYPE,
                                     SV_UID_USUARIO OUT NOCOPY PSD_USUARIO.UID_USUARIO%TYPE,
                                     SV_EMAIL_USUARIO OUT NOCOPY PSD_USUARIO.EMAIL_USUARIO%TYPE,                                        
                                     SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
IS 
 LV_sSql ge_errores_pg.vQuery;
 LV_des_error     ge_errores_pg.DesEvent;
 
BEGIN
     SN_num_evento :=0;
     SN_cod_retorno :=0;
     
     SELECT NOM_USUARIO, APP_USUARIO, UID_USUARIO, EMAIL_USUARIO 
     INTO   SV_NOM_USUARIO, SV_APP_USUARIO, SV_UID_USUARIO, SV_EMAIL_USUARIO
     FROM PSD_USUARIO where cod_usuario=EN_COD_USUARIO;
     

EXCEPTION
WHEN NO_DATA_FOUND THEN
        SN_cod_retorno := 900028; 
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error := 'al_integracion_sicsa_pg.al_get_datos_usuario_pr; - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'al_integracion_sicsa_pg.al_get_datos_usuario_pr', LV_sSql, SQLCODE, LV_des_error );

WHEN OTHERS THEN
        SN_cod_retorno := 900027; 
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error := 'al_integracion_sicsa_pg.al_get_datos_usuario_pr; - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'al_integracion_sicsa_pg.al_get_datos_usuario_pr', LV_sSql, SQLCODE, LV_des_error );

END al_get_datos_usuario_pr;     
                                
PROCEDURE al_get_pedido_usuario_pr(EN_COD_USUARIO IN PSD_USUARIO.COD_USUARIO%TYPE,
                                   EV_COD_PEDIDO IN VARCHAR,
                                   EV_FEC_DESDE IN VARCHAR,
                                   EV_FEC_HASTA IN VARCHAR,         
                                   SC_PEDIDOS  OUT NOCOPY REFCURSOR,                                                              
                                   SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
IS 
 LV_sSql ge_errores_pg.vQuery;
 LV_des_error     ge_errores_pg.DesEvent;
 
BEGIN
     SN_num_evento :=0;
     SN_cod_retorno :=0;
     
     IF EV_COD_PEDIDO IS NOT NULL THEN
     
         OPEN SC_PEDIDOS FOR
             SELECT a.COD_PEDIDO, c.DES_ESTADO_FLUJO, to_char(a.FEC_CRE_PEDIDO,'dd/MM/yyyy hh:mm:ss')
             FROM NPT_PEDIDO a, NPT_ESTADO_PEDIDO b, npd_estado_flujo c where a.cod_usuario_cre=EN_COD_USUARIO
             AND a.COD_PEDIDO = TO_NUMBER(EV_COD_PEDIDO)
             AND a.COD_PEDIDO = b.COD_PEDIDO
             AND b.COD_ESTADO_FLUJO= (SELECT MAX (d.cod_estado_flujo)
                                     FROM npt_estado_pedido d
                                    WHERE d.cod_pedido = b.cod_pedido)
             AND b.COD_ESTADO_FLUJO=c.COD_ESTADO_FLUJO;
     
     ELSIF EV_FEC_DESDE IS NOT NULL THEN
     
         OPEN SC_PEDIDOS FOR
             SELECT a.COD_PEDIDO, c.DES_ESTADO_FLUJO, to_char(a.FEC_CRE_PEDIDO,'dd/MM/yyyy hh:mm:ss')
             FROM NPT_PEDIDO a, NPT_ESTADO_PEDIDO b, npd_estado_flujo c where a.cod_usuario_cre=EN_COD_USUARIO
             AND TRUNC(a.fec_cre_pedido)
             between to_date(EV_FEC_DESDE,'dd/MM/yyyy') 
             and to_date(EV_FEC_HASTA,'dd/MM/yyyy')
             AND a.COD_PEDIDO = b.COD_PEDIDO
             AND b.COD_ESTADO_FLUJO= (SELECT MAX (d.cod_estado_flujo)
                                     FROM npt_estado_pedido d
                                    WHERE d.cod_pedido = b.cod_pedido)
             AND b.COD_ESTADO_FLUJO=c.COD_ESTADO_FLUJO;
         
     ELSE
         OPEN SC_PEDIDOS FOR
             SELECT a.COD_PEDIDO, c.DES_ESTADO_FLUJO, to_char(a.FEC_CRE_PEDIDO,'dd/MM/yyyy hh:mm:ss')
             FROM NPT_PEDIDO a, NPT_ESTADO_PEDIDO b, npd_estado_flujo c where a.cod_usuario_cre=EN_COD_USUARIO
             AND a.COD_PEDIDO = b.COD_PEDIDO
             AND b.COD_ESTADO_FLUJO= (SELECT MAX (d.cod_estado_flujo)
                                     FROM npt_estado_pedido d
                                    WHERE d.cod_pedido = b.cod_pedido)
             AND b.COD_ESTADO_FLUJO=c.COD_ESTADO_FLUJO;
     END IF;
     
     

EXCEPTION

WHEN OTHERS THEN
        SN_cod_retorno := 900061; 
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error := 'al_integracion_sicsa_pg.al_get_pedido_usuario_pr; - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'al_integracion_sicsa_pg.al_get_pedido_usuario_pr', LV_sSql, SQLCODE, LV_des_error );

END al_get_pedido_usuario_pr;

PROCEDURE al_get_det_pedido_pr(EV_COD_PEDIDO IN VARCHAR,      
                                   SC_DET_PEDIDOS  OUT NOCOPY REFCURSOR,                                                                                                                               
                                   SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
IS 
 LV_sSql ge_errores_pg.vQuery;
 LV_des_error     ge_errores_pg.DesEvent;
 
BEGIN
     SN_num_evento :=0;
     SN_cod_retorno :=0;
     
     
        
     OPEN SC_DET_PEDIDOS FOR
        select dp.lin_det_pedido, ts.des_stock, a.des_articulo, decode(tec.cod_tecnologia, 'NOTECNO', 'Ninguna', tec.des_tecnologia) des_tecnologia,
        dp.can_detalle_pedido, dp.can_asig_detalle_pedido,TO_CHAR(dp.mto_uni_det_pedido,'99999999999999999990.99'), 
        TO_CHAR(dp.mto_des_det_pedido,'99999999999999999990.99'), to_char(dp.ptj_des_det_pedido) ptj_des_det_pedido, 
        TO_CHAR(dp.mto_net_det_pedido,'99999999999999999990.99')
        from npt_detalle_pedido dp, al_usos u, al_tipos_stock ts, al_articulos a, al_tecnologia tec, 
        al_estados e, al_bodegas b 
        where dp.cod_pedido = TO_NUMBER(EV_COD_PEDIDO)
          and u.cod_uso = dp.cod_uso 
          and ts.tip_stock = dp.tip_stock 
          and a.cod_articulo = dp.cod_articulo 
          and e.cod_estado(+) = dp.cod_estado 
          and b.cod_bodega(+) = dp.cod_bodega 
          and ( b.tip_bodega in ( 1,16 ) or b.tip_bodega is null)
         and dp.cod_tecnologia = tec.cod_tecnologia
         order by dp.lin_det_pedido;     

EXCEPTION

WHEN OTHERS THEN
        SN_cod_retorno := 900062; 
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error := 'al_integracion_sicsa_pg.al_get_det_pedido_pr; - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'al_integracion_sicsa_pg.al_get_det_pedido_pr', LV_sSql, SQLCODE, LV_des_error );

END al_get_det_pedido_pr;

PROCEDURE al_get_ser_pedido_pr(EV_COD_PEDIDO IN VARCHAR,     
                               EV_LIN_PROCESO IN VARCHAR,  
                                   SC_SER_PEDIDOS  OUT NOCOPY REFCURSOR,                                                                                                                                
                                   SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
IS 
 LV_sSql ge_errores_pg.vQuery;
 LV_des_error     ge_errores_pg.DesEvent;
 
BEGIN
     SN_num_evento :=0;
     SN_cod_retorno :=0;
               
       
      OPEN SC_SER_PEDIDOS FOR
        select COD_SERIE_PEDIDO 
        from npt_serie_pedido where cod_pedido = TO_NUMBER(EV_COD_PEDIDO)
        AND LIN_DET_PEDIDO= TO_NUMBER(EV_LIN_PROCESO);
     

EXCEPTION

WHEN OTHERS THEN
        SN_cod_retorno := 900063; 
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error := 'al_integracion_sicsa_pg.al_get_ser_pedido_pr; - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'al_integracion_sicsa_pg.al_get_ser_pedido_pr', LV_sSql, SQLCODE, LV_des_error );

END al_get_ser_pedido_pr;


PROCEDURE al_get_grupos_correos(   SC_GRUPOS_CORR  OUT NOCOPY REFCURSOR,                                                                                                                                
                                   SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
IS 
 LV_sSql ge_errores_pg.vQuery;
 LV_des_error     ge_errores_pg.DesEvent;
 
BEGIN
     SN_num_evento :=0;
     SN_cod_retorno :=0;
               
       
        OPEN SC_GRUPOS_CORR FOR
        select COD_GRUPO, DES_GRUPO, FEC_CREACION
        from npt_grupo_correos_td 
        ORDER BY DES_GRUPO;
     

EXCEPTION

WHEN OTHERS THEN
        SN_cod_retorno := 900064; 
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error := 'al_integracion_sicsa_pg.al_get_grupos_correos; - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'al_integracion_sicsa_pg.al_get_grupos_correos', LV_sSql, SQLCODE, LV_des_error );

END al_get_grupos_correos;


PROCEDURE al_get_correos(   EN_COD_GRUPO IN npt_grupo_mail.COD_GRUPO%TYPE,
                                   SC_CORREOS  OUT NOCOPY REFCURSOR,                                                                                                                                
                                   SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
IS 
 LV_sSql ge_errores_pg.vQuery;
 LV_des_error     ge_errores_pg.DesEvent;
 
BEGIN
     SN_num_evento :=0;
     SN_cod_retorno :=0;
               
       
        OPEN SC_CORREOS  FOR
        select mail_usuario, nombre_usuario
        from npt_grupo_mail where cod_grupo=EN_COD_GRUPO
        ORDER BY mail_usuario;
     

EXCEPTION

WHEN OTHERS THEN
        SN_cod_retorno := 900065; 
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error := 'al_integracion_sicsa_pg.al_get_grupos_correos; - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'al_integracion_sicsa_pg.al_get_grupos_correos', LV_sSql, SQLCODE, LV_des_error );

END al_get_correos;

PROCEDURE al_borrar_correo(   EN_COD_GRUPO IN npt_grupo_mail.COD_GRUPO%TYPE,
                              EV_MAIL IN npt_grupo_mail.MAIL_USUARIO%TYPE,                                                                                                                     
                              SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                              SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                              SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
IS 
 LV_sSql ge_errores_pg.vQuery;
 LV_des_error     ge_errores_pg.DesEvent;
 
BEGIN
     SN_num_evento :=0;
     SN_cod_retorno :=0;
               
       
        delete npt_grupo_mail where cod_grupo=EN_COD_GRUPO
        AND mail_usuario = EV_MAIL;
     

EXCEPTION

WHEN OTHERS THEN
        SN_cod_retorno := 900066; 
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error := 'al_integracion_sicsa_pg.al_borrar_correo; - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'al_integracion_sicsa_pg.al_borrar_correo', LV_sSql, SQLCODE, LV_des_error );

END al_borrar_correo;


PROCEDURE al_modif_correo(   EN_COD_GRUPO IN npt_grupo_mail.COD_GRUPO%TYPE,
                              EV_MAIL_ANT IN npt_grupo_mail.MAIL_USUARIO%TYPE,  
                              EV_MAIL_NUE IN npt_grupo_mail.MAIL_USUARIO%TYPE,
                              EV_USUARIO IN npt_grupo_mail.NOMBRE_USUARIO%TYPE,                                                                                                                   
                              SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                              SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                              SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
IS 
 LV_sSql ge_errores_pg.vQuery;
 LV_des_error     ge_errores_pg.DesEvent;
 
BEGIN
     SN_num_evento :=0;
     SN_cod_retorno :=0;
               
       
        update npt_grupo_mail 
        set mail_usuario=ev_mail_nue,
        nombre_usuario=ev_usuario
        where cod_grupo=EN_COD_GRUPO
        AND mail_usuario = EV_MAIL_ant;
     

EXCEPTION

WHEN OTHERS THEN
        SN_cod_retorno := 900067; 
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error := 'al_integracion_sicsa_pg.al_modif_correo; - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'al_integracion_sicsa_pg.al_modif_correo', LV_sSql, SQLCODE, LV_des_error );

END al_modif_correo;


PROCEDURE al_ins_correo(   EN_COD_GRUPO IN npt_grupo_mail.COD_GRUPO%TYPE,
                              EV_MAIL IN npt_grupo_mail.MAIL_USUARIO%TYPE,  
                              EV_USUARIO IN npt_grupo_mail.NOMBRE_USUARIO%TYPE,                                                                                                                   
                              SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                              SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                              SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
IS 
 LV_sSql ge_errores_pg.vQuery;
 LV_des_error     ge_errores_pg.DesEvent;
 
BEGIN
     SN_num_evento :=0;
     SN_cod_retorno :=0;
               
       
        insert into npt_grupo_mail 
        (cod_grupo, mail_usuario, nombre_usuario) 
        values
        (en_cod_grupo, ev_mail, ev_usuario);

EXCEPTION

WHEN OTHERS THEN
        SN_cod_retorno := 900068; 
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error := 'al_integracion_sicsa_pg.al_ins_correo; - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'al_integracion_sicsa_pg.al_ins_correo', LV_sSql, SQLCODE, LV_des_error );

END al_ins_correo;


PROCEDURE al_limpia_pedido(   EN_COD_PEDIDO IN npt_pedido.COD_PEDIDO%TYPE,                                                                                                                 
                              SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                              SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                              SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
IS 
 LV_sSql ge_errores_pg.vQuery;
 LV_des_error     ge_errores_pg.DesEvent;
 ln_estado_pedido NUMBER;
 ESTADO_INVALIDO EXCEPTION;
 NO_SERIES       EXCEPTION;
 ln_cant_val_series NUMBER;
 ln_cant_series_pedido NUMBER;
 ln_count NUMBER;
BEGIN
     SN_num_evento :=0;
     SN_cod_retorno :=0;   
     
      LV_sSql:= 'select count(cod_pedido) into ln_count from  npt_estado_pedido where cod_pedido='||EN_COD_PEDIDO;
     select count(cod_pedido) into ln_count from  npt_estado_pedido where cod_pedido=EN_COD_PEDIDO;
     
     IF ln_count = 0 THEN
        RAISE NO_DATA_FOUND;
     END IF;
     
     LV_sSql:= 'select max(cod_estado_flujo) into ln_estado_pedido from  npt_estado_pedido where cod_pedido='||EN_COD_PEDIDO;
       select max(cod_estado_flujo) into ln_estado_pedido from  npt_estado_pedido where cod_pedido=EN_COD_PEDIDO;       
       
       IF ln_estado_pedido <> 8 THEN     
          
        RAISE ESTADO_INVALIDO;
       
       END IF;
       
       LV_sSql:= 'select count(1) into ln_cant_val_series from  Np_validacion_Series_to where cod_pedido='||EN_COD_PEDIDO;
       select count(1) into ln_cant_val_series from  Np_validacion_Series_to where cod_pedido=EN_COD_PEDIDO;

       LV_sSql:= 'select count(1) into ln_cant_series_pedido from npt_Serie_pedido where cod_pedido='||EN_COD_PEDIDO;
       select count(1) into ln_cant_series_pedido from npt_Serie_pedido where cod_pedido=EN_COD_PEDIDO;
       
       LV_sSql:= ' IF '||ln_cant_val_series||' = 0 AND '||ln_cant_series_pedido||' = 0 THEN';
       
       IF ln_cant_val_series = 0 AND ln_cant_series_pedido = 0 THEN
            RAISE NO_SERIES;
       
       END IF;
      
     LV_sSql:= 'Delete Np_validacion_Series_to where cod_pedido ='||EN_COD_PEDIDO;
      Delete Np_validacion_Series_to where cod_pedido = EN_COD_PEDIDO;
     LV_sSql:= 'Delete NP_CONTROL_ING_SERIES_TO where cod_pedido ='||EN_COD_PEDIDO;
      Delete NP_CONTROL_ING_SERIES_TO where cod_pedido = EN_COD_PEDIDO;
     LV_sSql:= 'Delete Npt_Serie_pedido where cod_pedido ='||EN_COD_PEDIDO;
      Delete Npt_Serie_pedido where cod_pedido = EN_COD_PEDIDO;

EXCEPTION
WHEN NO_SERIES THEN
        SN_cod_retorno := 900069; --cambiar por el configurado
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error := 'al_integracion_sicsa_pg.al_limpia_pedido; - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'al_integracion_sicsa_pg.al_limpia_pedido', LV_sSql, SQLCODE, LV_des_error );

WHEN ESTADO_INVALIDO THEN
        SN_cod_retorno := 900008; --cambiar por el configurado
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error := 'al_integracion_sicsa_pg.al_limpia_pedido; - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'al_integracion_sicsa_pg.al_limpia_pedido', LV_sSql, SQLCODE, LV_des_error );
WHEN NO_DATA_FOUND THEN
        SN_cod_retorno := 900026; 
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error := 'al_integracion_sicsa_pg.al_limpia_pedido; - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'al_integracion_sicsa_pg.al_limpia_pedido', LV_sSql, SQLCODE, LV_des_error );

WHEN OTHERS THEN
        SN_cod_retorno := 900070; 
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error := 'al_integracion_sicsa_pg.al_limpia_pedido; - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'al_integracion_sicsa_pg.al_limpia_pedido', LV_sSql, SQLCODE, LV_des_error );

END al_limpia_pedido;

PROCEDURE al_get_devolu_usuario_pr(EN_COD_USUARIO IN PSD_USUARIO.COD_USUARIO%TYPE,
                                   EV_COD_DEVOLU IN VARCHAR,
                                   EV_FEC_DESDE IN VARCHAR,
                                   EV_FEC_HASTA IN VARCHAR,         
                                   SC_DEVOLUCIONES  OUT NOCOPY REFCURSOR,                                                                
                                   SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
IS 
 LV_sSql ge_errores_pg.vQuery;
 LV_des_error     ge_errores_pg.DesEvent;
 
BEGIN
     SN_num_evento :=0;
     SN_cod_retorno :=0;
     
     IF EV_COD_DEVOLU IS NOT NULL THEN
     
         OPEN SC_DEVOLUCIONES FOR
             SELECT a.COD_DEVOLUCION, c.DES_ESTADO_FLUJO, to_char(a.FEC_CRE_DEVOLUCION,'dd/MM/yyyy hh:mm:ss')
             FROM npt_devolucion a, NPT_ESTADO_DEVOLUCION b, npd_estado_flujo c where a.cod_usuario_cre=EN_COD_USUARIO
             AND a.COD_DEVOLUCION = TO_NUMBER(EV_COD_DEVOLU)
             AND a.COD_DEVOLUCION = b.COD_DEVOLUCION
             AND b.COD_ESTADO_FLUJO= (SELECT MAX (d.cod_estado_flujo)
                                     FROM npt_estado_devolucion d
                                    WHERE d.cod_devolucion = b.cod_devolucion)
             AND b.COD_ESTADO_FLUJO=c.COD_ESTADO_FLUJO;
     
     ELSIF EV_FEC_DESDE IS NOT NULL THEN
     
         OPEN SC_DEVOLUCIONES FOR
             SELECT a.COD_DEVOLUCION, c.DES_ESTADO_FLUJO, to_char(a.FEC_CRE_DEVOLUCION,'dd/MM/yyyy hh:mm:ss')
             FROM NPT_DEVOLUCION a, NPT_ESTADO_DEVOLUCION b, npd_estado_flujo c where a.cod_usuario_cre=EN_COD_USUARIO
             AND TRUNC(a.fec_cre_devolucion)
             between to_date(EV_FEC_DESDE,'dd/MM/yyyy') 
             and to_date(EV_FEC_HASTA,'dd/MM/yyyy')
             AND a.COD_DEVOLUCION = b.COD_DEVOLUCION
             AND b.COD_ESTADO_FLUJO= (SELECT MAX (d.cod_estado_flujo)
                                     FROM npt_estado_DEVOLUCION d
                                    WHERE d.cod_DEVOLUCION = b.cod_DEVOLUCION)
             AND b.COD_ESTADO_FLUJO=c.COD_ESTADO_FLUJO;
         
     ELSE
         OPEN SC_DEVOLUCIONES FOR
             SELECT a.COD_DEVOLUCION, c.DES_ESTADO_FLUJO, to_char(a.FEC_CRE_DEVOLUCION,'dd/MM/yyyy hh:mm:ss')
             FROM NPT_DEVOLUCION a, NPT_ESTADO_DEVOLUCION b, npd_estado_flujo c where a.cod_usuario_cre=EN_COD_USUARIO
             AND a.COD_DEVOLUCION = b.COD_DEVOLUCION
             AND b.COD_ESTADO_FLUJO= (SELECT MAX (d.cod_estado_flujo)
                                     FROM npt_estado_DEVOLUCION d
                                    WHERE d.cod_DEVOLUCION = b.cod_DEVOLUCION)
             AND b.COD_ESTADO_FLUJO=c.COD_ESTADO_FLUJO;
     END IF;
     
     

EXCEPTION

WHEN OTHERS THEN
        SN_cod_retorno := 900061; 
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error := 'al_integracion_sicsa_pg.al_get_devolu_usuario_pr; - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'al_integracion_sicsa_pg.al_get_devolu_usuario_pr', LV_sSql, SQLCODE, LV_des_error );

END al_get_devolu_usuario_pr;

PROCEDURE al_get_det_devolu_pr(EV_COD_DEVOLU IN VARCHAR,      
                                   SC_DET_DEVOLU  OUT NOCOPY REFCURSOR,                                                                                                                           
                                   SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
IS 
 LV_sSql ge_errores_pg.vQuery;
 LV_des_error     ge_errores_pg.DesEvent;
 
BEGIN
     SN_num_evento :=0;
     SN_cod_retorno :=0;
     
     
        
     OPEN SC_DET_DEVOLU FOR
        select a.LIN_DET_DEVOLUCION, a.COD_PEDIDO, c.DES_ARTICULO, a.COD_SERIE_PEDIDO, d.DES_TIPO_DEVOLUCION
         from npt_detalle_devolucion a, npt_detalle_pedido b, al_articulos c, npd_tipo_devolucion d where
         a.COD_DEVOLUCION= EV_COD_DEVOLU and
         a.COD_PEDIDO=b.COD_PEDIDO and
         a.LIN_DET_PEDIDO = b.LIN_DET_PEDIDO and
         b.COD_ARTICULO=c.COD_ARTICULO and
         a.COD_TIPO_DEVOLUCION = d.COD_TIPO_DEVOLUCION
         order by a.LIN_DET_DEVOLUCION;     

EXCEPTION

WHEN OTHERS THEN
        SN_cod_retorno := 900062; 
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error := 'al_integracion_sicsa_pg.al_get_det_devolu_pr; - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'al_integracion_sicsa_pg.al_get_det_devolu_pr', LV_sSql, SQLCODE, LV_des_error );

END al_get_det_devolu_pr;

END al_integracion_sicsa_pg;
/
SHOW ERRORS