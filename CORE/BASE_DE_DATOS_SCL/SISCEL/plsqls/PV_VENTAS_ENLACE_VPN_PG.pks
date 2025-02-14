CREATE OR REPLACE PACKAGE Pv_ventas_enlace_vpn_Pg
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_NUMERACION_PG"
      Lenguaje="PL/SQL"
      Fecha="15-09-2008"
      Versión="1.0"
      Diseñador="**"
      Programador="**"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>  Contiene todas las operaciones de numeración automatica y manual </Descripción>
      <Parámetros>
         <Entrada>
            <>
         </Entrada>
         <Salida>

         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS

   gv_error_others        CONSTANT NUMBER                            := '156';
   gv_error_no_clasif     CONSTANT VARCHAR2 (100)                    := 'Error no Clasificado';
   gn_largoerrtec         CONSTANT NUMBER (3)                        := 500;
   gn_largodesc           CONSTANT NUMBER (3)                        := 100;
   GV_COD_MODULO          CONSTANT VARCHAR2 (2)                      := 'GA';
   GV_COD_MODULO_GE       CONSTANT VARCHAR2 (2)                      := 'GE';
   GN_COD_PRODUCTO        CONSTANT NUMBER                            := 1;

   TYPE refcursor IS REF CURSOR;

PROCEDURE PV_ACTUALIZA_RANGOSFIJOS_PR(
  EN_NUM_ABONADO        IN NUMBER,      -- Numero de Abonado
  EV_ACTUACION          IN VARCHAR2,     -- Codigo de Actuacion
  EV_USUARORA           IN VARCHAR2     -- Nombre de usuario
  );
PROCEDURE PV_ACT_TRANSACABO_PR (
        nNUM_TRANSACCION     IN   GA_TRANSACABO.NUM_TRANSACCION%TYPE,   --Numero de transaccion
        nCOD_RETORNO         IN   GA_TRANSACABO.COD_RETORNO%TYPE,       --Codigo de retorno
        sDES_CADENA          IN   GA_TRANSACABO.DES_CADENA%TYPE, --Descripcion del retorno
        SN_cod_retorno    	 OUT NOCOPY ge_errores_pg.CodError,
        SV_mens_retorno   	 OUT NOCOPY ge_errores_pg.MsgError,
        SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE PV_VALTEL_FIJA_MOVIL_PR (
   v_param_entrada IN  VARCHAR2,
    bRESULTADO      OUT VARCHAR2,
   -- vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
    vMENSAJE        OUT  VARCHAR2
        );

PROCEDURE PV_INS_HISTASOCIA_RANGO_PR(
    EN_NUM_PILOTO       IN GA_NRO_PILOTO_RANGO_TH.NUM_PILOTO%TYPE,
    EN_NUM_DESDE        IN GA_NRO_PILOTO_RANGO_TH.NUM_DESDE%TYPE,
    ED_FECHA_HISTORICO  IN GA_NRO_PILOTO_RANGO_TH.FECHA_HISTORICO%TYPE,
    EV_NOM_USUARORA     IN GA_NRO_PILOTO_RANGO_TH.NOM_USUARORA%TYPE,
    SN_COD_RETORNO      OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO     OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO       OUT NOCOPY GE_ERRORES_PG.EVENTO);

PROCEDURE PV_IN_NUM_PILOTO_PR(
          EV_NUM_PILOTO         IN GA_NRO_PILOTO_RANGO_TO.NUM_PILOTO%TYPE,
          EV_FECHA              IN GA_NRO_PILOTO_RANGO_TO.NUM_DESDE%TYPE,
          EV_USUARIO            IN GA_NRO_PILOTO_RANGO_TO.NOM_USUARORA%TYPE,
          SN_COD_RETORNO    OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
          SV_MENS_RETORNO   OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
          SN_NUM_EVENTO     OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_OBT_RANGOS_DISPONIBLES_PR(
    EN_COD_CENTRAL  IN ICG_CENTRAL.COD_CENTRAL%TYPE,
    SC_RANGOS_DISP  OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO        OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO       OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO         OUT NOCOPY GE_ERRORES_PG.EVENTO);

PROCEDURE PV_ACTUALIZA_ESTADO_RANGO_PR(
    EN_NUM_DESDE        IN GA_RANGOS_FIJOS_TO.NUM_DESDE%TYPE,
	EN_ESTADO			IN GA_RANGOS_FIJOS_TO.ESTADO%TYPE,
    SN_COD_RETORNO        OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO       OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO         OUT NOCOPY GE_ERRORES_PG.EVENTO);

PROCEDURE PV_OBTS_DATOS_RANGO_PR(
    EN_NUM_ABONADO  in GA_ABOCEl.NUM_ABONADO%TYPE,
    SC_DATOS_RANGOS  OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO        OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO       OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO         OUT NOCOPY GE_ERRORES_PG.EVENTO);

PROCEDURE PV_DEL_RANGOS_PILOTO_PR(
    EN_NUM_DESDE          IN         GA_RANGOS_FIJOS_TO.NUM_DESDE%TYPE ,
    SN_COD_RETORNO        OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO       OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO         OUT NOCOPY GE_ERRORES_PG.EVENTO);
    
FUNCTION IC_CONS_RANGOS_E1_FN (V_Num_Movimiento  IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN VARCHAR2;

PROCEDURE PV_insta_movimiento_PR(num_movimiento             icc_movimiento.num_movimiento%TYPE,
							EN_num_abonado                icc_movimiento.num_abonado%TYPE,
							EN_cod_estado                 icc_movimiento.cod_estado%TYPE,
							EV_cod_actabo                 icc_movimiento.cod_actabo%TYPE,
							EV_cod_modulo                 icc_movimiento.cod_modulo%TYPE,
							EN_num_intentos               icc_movimiento.num_intentos%TYPE,
							EN_cod_central_nue            icc_movimiento.cod_central_nue%TYPE,
							EV_des_respuesta              icc_movimiento.des_respuesta%TYPE,
							EN_cod_actuacion              icc_movimiento.cod_actuacion%TYPE,
							EV_nom_usuarora               icc_movimiento.nom_usuarora%TYPE,
							ED_fec_ingreso                icc_movimiento.fec_ingreso%TYPE,
							EV_tip_terminal               icc_movimiento.tip_terminal%TYPE,
							EN_cod_central                icc_movimiento.cod_central%TYPE,
							ED_fec_lectura                icc_movimiento.fec_lectura%TYPE,
							EN_ind_bloqueo                icc_movimiento.ind_bloqueo%TYPE,
							ED_fec_ejecucion              icc_movimiento.fec_ejecucion%TYPE,
							EV_tip_terminal_nue           icc_movimiento.tip_terminal_nue%TYPE,
							EN_num_movant                 icc_movimiento.num_movant%TYPE,
							EN_num_celular                icc_movimiento.num_celular%TYPE,
							EN_num_movpos                 icc_movimiento.num_movpos%TYPE,
							EV_num_serie                  icc_movimiento.num_serie%TYPE,
							EV_num_personal               icc_movimiento.num_personal%TYPE,
							EN_num_celular_nue            icc_movimiento.num_celular_nue%TYPE,
							EV_num_serie_nue              icc_movimiento.num_serie_nue%TYPE,
							EV_num_personal_nue           icc_movimiento.num_personal_nue%TYPE,
							EV_num_msnb                   icc_movimiento.num_msnb%TYPE,
							EV_num_msnb_nue               icc_movimiento.num_msnb_nue%TYPE,
							EV_cod_suspreha               icc_movimiento.cod_suspreha%TYPE,
							EV_cod_servicios              icc_movimiento.cod_servicios%TYPE,
							EV_num_min                    icc_movimiento.num_min%TYPE,
							EV_num_min_nue                icc_movimiento.num_min_nue%TYPE,
							EV_sta                        icc_movimiento.sta%TYPE,
							EN_cod_mensaje                icc_movimiento.cod_mensaje%TYPE,
							EV_param1_mens                icc_movimiento.param1_mens%TYPE,
							EV_param2_mens                icc_movimiento.param2_mens%TYPE,
							EV_param3_mens                icc_movimiento.param3_mens%TYPE,
							EV_plan                       icc_movimiento.PLAN%TYPE,
							EN_carga                      icc_movimiento.carga%TYPE,
							EN_valor_plan                 icc_movimiento.valor_plan%TYPE,
							EV_pin                        icc_movimiento.pin%TYPE,
							ED_fec_expira                 icc_movimiento.fec_expira%TYPE,
							EV_des_mensaje                icc_movimiento.des_mensaje%TYPE,
							EV_cod_pin                    icc_movimiento.cod_pin%TYPE,
							EV_cod_idioma                 icc_movimiento.cod_idioma%TYPE,
							EN_cod_enrutamiento           icc_movimiento.cod_enrutamiento%TYPE,
							EN_tip_enrutamiento           icc_movimiento.tip_enrutamiento%TYPE,
							EV_des_origen_pin             icc_movimiento.des_origen_pin%TYPE,
							EN_num_lote_pin               icc_movimiento.num_lote_pin%TYPE,
							EV_num_serie_pin              icc_movimiento.num_serie_pin%TYPE,
							EV_tip_tecnologia             icc_movimiento.tip_tecnologia%TYPE,
							EV_imsi                       icc_movimiento.imsi%TYPE,
							EV_imsi_nue                   icc_movimiento.imsi_nue%TYPE,
							EV_imei                       icc_movimiento.imei%TYPE,
							EV_imei_nue                   icc_movimiento.imei_nue%TYPE,
							EV_icc                        icc_movimiento.icc%TYPE,
							EV_icc_nue 		   			  icc_movimiento.icc_nue%TYPE,
							SN_cod_retorno    	   	 OUT NOCOPY ge_errores_pg.CodError,
	                       	SV_mens_retorno   	   	 OUT NOCOPY ge_errores_pg.MsgError,
	                       	SN_num_evento     	   	 OUT NOCOPY ge_errores_pg.Evento
							);
      PROCEDURE PV_insertar_os_PR ( EV_num_os IN NUMBER,
                                    EV_cod_os IN VARCHAR2,
                                    EV_producto IN NUMBER,
                                    EV_tip_inter IN NUMBER,
                                    EV_cod_inter IN NUMBER,
                                    EV_usuario IN VARCHAR2,
                                    EV_fecha IN DATE,
                                    EV_comentario IN VARCHAR2,
                                    SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                           		    SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                           		    SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE PV_CON_DATOS_OOSS_PR (EV_cod_os IN OUT NOCOPY VARCHAR2,
                                    SV_cod_tipmodi OUT VARCHAR2,
                                    SV_grupo OUT VARCHAR2,
                                    SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                           		    SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                           		    SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);
     PROCEDURE PV_REC_SECUENCIA_PR ( EV_NOM_SECUENCIA   IN VARCHAR2,
                                    SN_secuencia       OUT NOCOPY NUMBER,
                                    SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                           		    SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                           		    SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE pv_cnslta_dat_basicosclt_pr(
    EN_COD_CLIENTE				IN GE_CLIENTES.COD_CLIENTE%TYPE,
	SV_NOM_CLIENTE              OUT GE_CLIENTES.NOM_CLIENTE%TYPE,
	SV_NOM_APECLIEN1            OUT GE_CLIENTES.NOM_APECLIEN1%TYPE,
	SV_NOM_APECLIEN2            OUT GE_CLIENTES.NOM_APECLIEN2%TYPE,
	SV_COD_TIPIDENT             OUT GE_TIPIDENT.COD_TIPIDENT%TYPE,
	SV_DES_TIPIDENT             OUT GE_TIPIDENT.DES_TIPIDENT%TYPE,
	SV_NUM_IDENT                OUT GE_CLIENTES.NUM_IDENT%TYPE,
	SN_COD_CUENTA               OUT GA_CUENTAS.COD_CUENTA%TYPE,
	SV_DES_CUENTA               OUT GA_CUENTAS.DES_CUENTA%TYPE,
    SN_COD_RETORNO   				OUT NOCOPY   GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO  				OUT NOCOPY   GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO    				 OUT NOCOPY    GE_ERRORES_PG.EVENTO
  );
PROCEDURE PV_cnslta_parametro_PR(	EN_cod_producto      IN ged_parametros.cod_producto%TYPE,
		   							EV_cod_modulo		 IN ged_parametros.cod_modulo%TYPE,
									EV_nom_parametro 	 IN ged_parametros.nom_parametro%TYPE,
                                    SV_val_parametro     OUT NOCOPY ged_parametros.val_parametro%TYPE,
									SV_des_parametro     OUT NOCOPY ged_parametros.des_parametro%TYPE,
									SV_nom_usuario     	 OUT NOCOPY ged_parametros.nom_usuario%TYPE,
									SD_fec_alta     	 OUT NOCOPY ged_parametros.fec_alta%TYPE,
							      	SN_cod_retorno    	 OUT NOCOPY ge_errores_pg.CodError,
                        		    SV_mens_retorno   	 OUT NOCOPY ge_errores_pg.MsgError,
                        		    SN_num_evento     	 OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE PV_cnslta_parametro_LK_PR(EN_cod_producto      IN ged_parametros.cod_producto%TYPE,
		   							EV_cod_modulo		 IN ged_parametros.cod_modulo%TYPE,
									EV_nom_parametro 	 IN ged_parametros.nom_parametro%TYPE,
                                    SC_PARAMETROS        OUT NOCOPY REFCURSOR,
							      	SN_cod_retorno    	 OUT NOCOPY ge_errores_pg.CodError,
                        		    SV_mens_retorno   	 OUT NOCOPY ge_errores_pg.MsgError,
                        		    SN_num_evento     	 OUT NOCOPY ge_errores_pg.Evento);                                  
PROCEDURE PV_EJEC_PV_GRUPO_TEC_FN_PR( EV_CODTECNOLOGIA       IN VARCHAR2,
			  						      SV_GRUPOTECNOLOGIA     OUT NOCOPY VARCHAR2,
									      SN_cod_retorno         OUT NOCOPY ge_errores_pg.CodError,
                           		          SV_mens_retorno        OUT NOCOPY ge_errores_pg.MsgError,
                           		          SN_num_evento          OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE PV_CONS_CICLO_FACT_HIB_PR(
	EN_COD_CICLO         IN   FA_CICLFACT.COD_CICLO%TYPE,
    EN_COD_CLIENTE       IN  GA_INFACCEL.COD_CLIENTE %TYPE,
	EN_NUM_ABONADO  IN GA_INFACCEL.NUM_ABONADO%TYPE,
    SN_EXISTE                  OUT NOCOPY NUMBER,
    SN_COD_RETORNO    OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO    OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO       OUT NOCOPY GE_ERRORES_PG.EVENTO
  );
  PROCEDURE PV_cons_deuda_cliente_PR(     en_num_abonado		IN co_cartera.NUM_ABONADO%TYPE,
 		  						  sn_count    		           OUT NOCOPY NUMBER,
							      SN_cod_retorno    		OUT NOCOPY ge_errores_pg.CodError,
                        		  SV_mens_retorno   		OUT NOCOPY ge_errores_pg.MsgError,
                        		  SN_num_evento     		OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE PV_cnslta_categoria_plan_PR(	EN_cod_producto        IN ve_catplantarif.cod_producto%TYPE,
		   								EV_cod_plantarif	  IN ve_catplantarif.cod_plantarif%TYPE,
                                        SV_cod_categoria     OUT NOCOPY ve_catplantarif.cod_categoria%TYPE,
							      	 	SN_cod_retorno    	  OUT NOCOPY ge_errores_pg.CodError,
                        		        SV_mens_retorno   	  OUT NOCOPY ge_errores_pg.MsgError,
                        		        SN_num_evento     	  OUT NOCOPY ge_errores_pg.Evento);
    PROCEDURE PV_con_cliente_empresa_PR (EV_cod_cliente     IN NUMBER,
                                         EV_cod_producto    IN NUMBER,
                                         SV_tip_plantarif   OUT NOCOPY VARCHAR2,
                                         SV_cod_plantarif   OUT NOCOPY VARCHAR2,
                                         SV_des_plantarif   OUT NOCOPY VARCHAR2,
                                         SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                           		         SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                           		         SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);
    PROCEDURE PV_con_abonado_pospago_PR (EV_num_abonado     IN OUT NOCOPY NUMBER,
                                         SC_abonados        OUT NOCOPY RefCursor,
                                         SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                           		         SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                           		         SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE pv_cnslta_vende_usuario_pr (
    EV_nom_usuario   			   IN   GE_SEG_USUARIO.NOM_USUARIO%type,
	SN_cod_vendedor               OUT GE_SEG_USUARIO.COD_VENDEDOR%type,
	SN_cod_tipcomis                 OUT GE_SEG_USUARIO.COD_TIPCOMIS%type,
	SN_cod_oficina                   OUT GE_SEG_USUARIO.COD_OFICINA%type,
    SN_cod_retorno   				OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno  				OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
    SN_num_evento    		        OUT NOCOPY    ge_errores_pg.Evento
   );
PROCEDURE GA_ELIMINA_RANGOS_PR (
    EV_num_celular  			   IN   GA_ABOCEL.NUM_CELULAR%TYPE,
	SN_cod_retorno       		   OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno  			   OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
    SN_num_evento    		       OUT NOCOPY    ge_errores_pg.Evento
   );                                                                                                                             
                                                                                                                                                                                              
                                                                                                                
END Pv_ventas_enlace_vpn_Pg;
/
SHOW ERRORS