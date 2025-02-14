CREATE OR REPLACE PACKAGE PV_OOSS_PROMOCIONES_PG
IS
   TYPE refCursor IS REF CURSOR;
   CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
   CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'PV';
   CV_cod_modulo_GE        CONSTANT VARCHAR2 (2)  := 'GE';
   CV_sit_baa              CONSTANT VARCHAR2 (3)  := 'BAA';
   CV_sit_bap              CONSTANT VARCHAR2 (3)  := 'BAP';
   CV_version              CONSTANT VARCHAR2 (2)  := '1';
   CV_gsFormato2           CONSTANT VARCHAR2 (20) := 'FORMATO_SEL2';
   CV_gsFormato4           CONSTANT VARCHAR2 (20) := 'FORMATO_SEL4';
   CV_gsFormato7           CONSTANT VARCHAR2 (20) := 'FORMATO_SEL7';
   
   CV_estado_pd            CONSTANT VARCHAR2 (2)  := 'PD';
 
   CV_cod_aplic            CONSTANT VARCHAR2 (3)  := 'PVA';
   CN_producto             CONSTANT NUMBER        := 1;

 
   CN_0                    CONSTANT NUMBER (1)     :=  0;
   CV_0                    CONSTANT VARCHAR2 (1)   := '0';
   CV_1                    CONSTANT VARCHAR2 (1)   := '1';
   


PROCEDURE PV_DATOS_ABONADO_PR(EN_NUM_ABONADO           IN              ga_aboamist.num_abonado%TYPE,
                              SO_DATOS_ABONADO         IN  OUT NOCOPY  refCursor/*,
                              SN_COD_RETORNO           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                              SV_MENS_RETORNO          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                              SN_NUM_EVENTO            OUT NOCOPY      ge_errores_pg.evento */);


-------------------------------------------------------------------------------------------------------
PROCEDURE PV_REGISTRA_MOVIMIENTO_PR(EN_NUM_MOVIMIENTO       IN  ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE,
                                    EN_NUM_ABONADO          IN  ICC_MOVIMIENTO.NUM_ABONADO%TYPE,
                                    EN_COD_ESTADO           IN  ICC_MOVIMIENTO.COD_ESTADO%TYPE,
                                    EV_COD_ACTABO           IN  ICC_MOVIMIENTO.COD_ACTABO%TYPE,
                                    EV_COD_MODULO           IN  ICC_MOVIMIENTO.COD_MODULO%TYPE,
                                    EN_NUM_INTENTOS         IN  ICC_MOVIMIENTO.NUM_INTENTOS%TYPE,
                                    EV_DES_RESPUESTA        IN  ICC_MOVIMIENTO.DES_RESPUESTA%TYPE,
                                    EN_COD_ACTUACION        IN  ICC_MOVIMIENTO.COD_ACTUACION%TYPE,
                                    EV_NOM_USUARORA         IN  ICC_MOVIMIENTO.NOM_USUARORA%TYPE,
                                    EV_TIP_TERMINAL         IN  ICC_MOVIMIENTO.TIP_TERMINAL%TYPE,
                                    EN_COD_CENTRAL          IN  ICC_MOVIMIENTO.COD_CENTRAL%TYPE,
                                    EN_IND_BLOQUEO          IN  ICC_MOVIMIENTO.IND_BLOQUEO%TYPE,
                                    EN_NUM_CELULAR          IN  ICC_MOVIMIENTO.NUM_CELULAR%TYPE,
                                    EV_NUM_SERIE            IN  ICC_MOVIMIENTO.NUM_SERIE%TYPE,
                                    EV_COD_SERVICIOS        IN  ICC_MOVIMIENTO.COD_SERVICIOS%TYPE,
                                    EV_TIP_TECNOLOGIA       IN  ICC_MOVIMIENTO.TIP_TECNOLOGIA%TYPE,
                                    SN_cod_retorno  OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                    SV_mens_retorno OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                    SN_num_evento   OUT NOCOPY      ge_errores_pg.evento);
-------------------------------------------------------------------------------------------------------
PROCEDURE PV_REGISTRA_PROMO_ABON_PR(EN_IDE_PROMOCION  IN PV_ABON_BENEF_PREPAGOS_TD.IDE_PROMOCION%TYPE,
                                    EN_NUM_ABONADO    IN PV_ABON_BENEF_PREPAGOS_TD.NUM_ABONADO%TYPE,  
                                    EV_NUM_FFODUO_01  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_01%TYPE,
                                    EV_NUM_FFODUO_02  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_02%TYPE,
                                    EV_NUM_FFODUO_03  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_03%TYPE,
                                    EV_NUM_FFODUO_04  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_04%TYPE,
                                    EV_NUM_FFODUO_05  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_05%TYPE,
                                    EV_NUM_FFODUO_06  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_06%TYPE,
                                    EV_NUM_FFODUO_07  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_07%TYPE,
                                    EV_NUM_FFODUO_08  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_08%TYPE,
                                    EV_NUM_FFODUO_09  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_09%TYPE,
                                    EV_NUM_FFODUO_10  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_10%TYPE,
                                    SN_cod_retorno  OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                    SV_mens_retorno OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                    SN_num_evento   OUT NOCOPY      ge_errores_pg.evento);
                                    
PROCEDURE PV_DATOS_PROMO_ABONADO_PR(EN_IDE_PROMOCION         IN              pv_abon_benef_prepagos_td.ide_promocion%TYPE,
                                    EN_NUM_ABONADO           IN              pv_abon_benef_prepagos_td.num_abonado%TYPE,
                                    SO_DATOS_ABONADO         IN  OUT NOCOPY  refCursor);
-------------------------------------------------------------------------------------------------------  
PROCEDURE PV_ACTUALIZA_PROMO_ABON_PR(EN_IDE_PROMOCION  IN PV_ABON_BENEF_PREPAGOS_TD.IDE_PROMOCION%TYPE,
                                     EN_NUM_ABONADO    IN PV_ABON_BENEF_PREPAGOS_TD.NUM_ABONADO%TYPE,  
                                     EV_NUM_FFODUO_01  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_01%TYPE,
                                     EV_NUM_FFODUO_02  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_02%TYPE,
                                     EV_NUM_FFODUO_03  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_03%TYPE,
                                     EV_NUM_FFODUO_04  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_04%TYPE,
                                     EV_NUM_FFODUO_05  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_05%TYPE,
                                     EV_NUM_FFODUO_06  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_06%TYPE,
                                     EV_NUM_FFODUO_07  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_07%TYPE,
                                     EV_NUM_FFODUO_08  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_08%TYPE,
                                     EV_NUM_FFODUO_09  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_09%TYPE,
                                     EV_NUM_FFODUO_10  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_10%TYPE,
                                     EN_COD_ESTADO     IN PV_ABON_BENEF_PREPAGOS_TD.COD_ESTADO%TYPE,
                                     SN_cod_retorno  OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                     SV_mens_retorno OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                     SN_num_evento   OUT NOCOPY      ge_errores_pg.evento);
-------------------------------------------------------------------------------------------------------     
PROCEDURE PV_ELIMINA_PROMO_ABONADO_PR(EN_IDE_PROMOCION        IN      pv_abon_benef_prepagos_td.ide_promocion%TYPE,
                                      EN_NUM_ABONADO          IN      pv_abon_benef_prepagos_td.num_abonado%TYPE,
                                      EN_COD_ESTADO           IN      pv_abon_benef_prepagos_td.cod_estado%TYPE,
                                      SN_cod_retorno  OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                      SV_mens_retorno OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                      SN_num_evento   OUT NOCOPY      ge_errores_pg.evento);

-------------------------------------------------------------------------------------------------------   


PROCEDURE PV_REG_PROMO_MODIFICADA_PR(EN_IDE_PROMOCION   IN PV_BENEFICIOS_PREPAGOS_TD.IDE_PROMOCION%TYPE, 
                                     EV_NOM_PROMOCION   IN PV_BENEFICIOS_PREPAGOS_TD.NOM_PROMOCION%TYPE, 
                                     EV_DES_PROMOCION   IN PV_BENEFICIOS_PREPAGOS_TD.DES_PROMOCION%TYPE, 
                                     ED_FEC_INICIO	    IN PV_BENEFICIOS_PREPAGOS_TD.FEC_INICIO%TYPE,    
                                     ED_FEC_FIN	        IN PV_BENEFICIOS_PREPAGOS_TD.FEC_FIN%TYPE,       
                                     EN_CST_SUSCRIPCION IN PV_BENEFICIOS_PREPAGOS_TD.CST_SUSCRIPCION%TYPE,
                                     EN_CST_MENSUAL	    IN PV_BENEFICIOS_PREPAGOS_TD.CST_MENSUAL%TYPE,   
                                     EN_TEMPORALIDAD    IN PV_BENEFICIOS_PREPAGOS_TD.TEMPORALIDAD%TYPE,  
                                     EV_TIP_PROMOCION   IN PV_BENEFICIOS_PREPAGOS_TD.TIP_PROMOCION%TYPE, 
                                     EV_COD_TECNOLOGIA  IN PV_BENEFICIOS_PREPAGOS_TD.COD_TECNOLOGIA%TYPE,
                                     EV_SMS_BODY	    IN PV_BENEFICIOS_PREPAGOS_TD.SMS_BODY%TYPE,      
                                     EV_PLN_SOPORTA	    IN PV_BENEFICIOS_PREPAGOS_TD.PLN_SOPORTA%TYPE,   
                                     EV_TIP_MOVIMIEN    IN PV_BENEFICIOS_PREPAGOS_TD.TIP_MOVIMIEN%TYPE,  
                                     EV_LST_SUSCRIP	    IN PV_BENEFICIOS_PREPAGOS_TD.LST_SUSCRIP%TYPE,   
                                     EV_TIP_SUSCRIP	    IN PV_BENEFICIOS_PREPAGOS_TD.TIP_SUSCRIP%TYPE,   
                                     EV_FLG_RECORD	    IN PV_BENEFICIOS_PREPAGOS_TD.FLG_RECORD%TYPE,    
                                     EV_FRC_RECORD	    IN PV_BENEFICIOS_PREPAGOS_TD.FRC_RECORD%TYPE,    
                                     EV_FLG_CONFIRM	    IN PV_BENEFICIOS_PREPAGOS_TD.FLG_CONFIRM%TYPE,   
                                     EV_FLG_NORMALIZA   IN PV_BENEFICIOS_PREPAGOS_TD.FLG_NORMALIZA%TYPE, 
                                     EV_CNT_NUMEROS	    IN PV_BENEFICIOS_PREPAGOS_TD.CNT_NUMEROS%TYPE,   
                                     EV_FLG_ALTA	    IN PV_BENEFICIOS_PREPAGOS_TD.FLG_ALTA%TYPE, 
                                     SN_cod_retorno  OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                     SV_mens_retorno OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                     SN_num_evento   OUT NOCOPY      ge_errores_pg.evento);
-------------------------------------------------------------------------------------------------------
PROCEDURE PV_DEL_PROMO_MODIFICADA_PR(EN_IDE_PROMOCION   IN PV_BENEFICIOS_PREPAGOS_TD.IDE_PROMOCION%TYPE, 
                                     SN_cod_retorno  OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                     SV_mens_retorno OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                     SN_num_evento   OUT NOCOPY      ge_errores_pg.evento);            
-------------------------------------------------------------------------------------------------------                                                                                                                                                                                             
END PV_OOSS_PROMOCIONES_PG;
/
SHOW ERRORS