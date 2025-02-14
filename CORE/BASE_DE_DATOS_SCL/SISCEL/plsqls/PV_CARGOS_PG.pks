CREATE OR REPLACE PACKAGE PV_CARGOS_PG
IS

   TYPE refCursor IS REF CURSOR;
   CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
   CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'GA';
   CV_version              CONSTANT VARCHAR2 (2)  := '1';
   cn_largodesc            CONSTANT NUMBER        := 2000;
   cn_largoerrtec          CONSTANT NUMBER        := 4000;
   CN_producto			   CONSTANT NUMBER        := 1;
   CN_vta_ingresada	   	   CONSTANT NUMBER        := 100;
   CN_cod_proc		       CONSTANT NUMBER        := 3;
   CN_cod_estado_doc       CONSTANT NUMBER        := 300;

   -----------------------------------------------------------------------------------------------------------------
--(1).- Metodo  :  ActualizarCargoBolsaDinamica
	PROCEDURE PV_ACTUA_CARGO_BOLSA_DINA_PR (EO_BOLSAS_DINAMICAS  IN   	  	     PV_BOLSAS_DINAMICAS_QT,
										    SN_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
										    SV_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
										    SN_num_evento        OUT NOCOPY		 ge_errores_pg.evento
	);

  -----------------------------------------------------------------------------------------------------------------
	PROCEDURE PV_OBTENER_IMPUESTOS_PR(
	  SO_PRESUPUESTO   		   IN OUT   		GA_PRESUPUESTO_QT,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento
    );

	-----------------------------------------------------------------------------------------------------------------
	PROCEDURE PV_ACEPTAR_PRESUPUESTO_PR(
	  EO_PRESUPUESTO   		   IN    			GA_PRESUPUESTO_QT,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento
    );
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
     PROCEDURE PV_OBTIENE_CUOTAS_PR(
	  CURSOR_CUOTA             OUT NOCOPY       REFCURSOR,
	  SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento);

	-----------------------------------------------------------------------------------------------------------------
	PROCEDURE PV_OBTIENEMODALIDAD_PAGOS_PR(
	  SO_CARGOS IN OUT PV_CARGOS_QT,
	  CURSOR_MODPAGOS OUT  NOCOPY REFCURSOR,
	  SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento);

	-----------------------------------------------------------------------------------------------------------------
	PROCEDURE PV_VALIDA_FREEDOM_VENTA_PR(
	  SO_VAL_FREEDOM  		   IN OUT 			PV_VAL_FREEDOM_QT,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento
    );

	-----------------------------------------------------------------------------------------------------------------
	PROCEDURE PV_OBTENER_FORMAS_PAGO_PR(
	  EO_BUSQ_FORMA_PAGO	   IN 				PV_BUSQ_FORMA_PAGO_QT,
	  CURSOR_FORMAS_PAGO	   OUT NOCOPY 		REFCURSOR,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento
    );

	-----------------------------------------------------------------------------------------------------------------
	PROCEDURE PV_OBTENER_TIPOS_DOC_PR(
	  EO_BUSQ_TIPO_DOC		   IN 				PV_BUSQ_TIPO_DOC_QT,
	  CURSOR_TIPOS_DOC		   OUT NOCOPY 		REFCURSOR,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento
	);
------------------------------------------------------------------------------------------------------------------
	PROCEDURE PV_LISTA_SEGM_CARGOS_PR(
	  SO_CargosSegmentacion	   IN OUT NOCOPY    PV_TIPOS_PG.TIP_GA_SEGMENTACION_CARGOS,
	  SC_Cursor	               OUT NOCOPY		REFCURSOR,
	  SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento
	);
------------------------------------------------------------------------------------------------------------------
   PROCEDURE PV_Obtener_CodValor_PR( SN_cod_cliente	IN          ga_valor_cli.cod_cliente%TYPE,
		  						  SN_cod_valor      OUT NOCOPY  ga_valor_cli.cod_valor%TYPE,
								  SN_cod_retorno    OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
								  SV_mens_retorno   OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
								  SN_num_evento     OUT NOCOPY	ge_errores_pg.evento);
-----------------------------------------------------------------------------------------------------------------
   PROCEDURE VE_List_cargos_Ocasionales_PR ( EV_cod_producto    IN      ga_actuaserv.cod_producto%TYPE,
 		   								  EV_cod_actabo     IN          ga_actuaserv.cod_actabo%TYPE,
										  EV_cod_tipserv    IN          ga_actuaserv.cod_tipserv%TYPE,
										  EV_cod_concepto   IN          ga_actuaserv.cod_concepto%TYPE,
										  EV_cod_planserv   IN 			ga_tarifas.cod_planserv%TYPE,
					                      SC_cursordatos    OUT NOCOPY  REFCURSOR,
 					                      SN_cod_retorno    OUT NOCOPY  ge_errores_pg.CodError,
                 		                  SV_mens_retorno   OUT NOCOPY  ge_errores_pg.MsgError,
                        	              SN_num_evento     OUT NOCOPY  ge_errores_pg.Evento);
-----------------------------------------------------------------------------------------------------------------
    PROCEDURE PV_Obtiene_CodConceptoArt_PR( SO_ARTICULO    IN OUT NOCOPY PV_TIPOS_PG.TIP_AL_ARTICULOS,
		  						  		SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
								  		SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
								  		SN_num_evento      OUT NOCOPY	 ge_errores_pg.evento);

-----------------------------------------------------------------------------------------------------------------
	PROCEDURE PV_CargosEstDevlEqup_PR( EO_GAT_DEVLEQUIP    IN OUT NOCOPY  PV_GAT_DEVLEQUIP_QT,
			  						   	  SC_cursordatos   OUT NOCOPY     REFCURSOR,
			  							  SN_cod_retorno   OUT NOCOPY     ge_errores_pg.CodError,
              							  SV_mens_retorno  OUT NOCOPY     ge_errores_pg.MsgError,
										  SN_num_evento    OUT NOCOPY     ge_errores_pg.Evento);
----------------------------------------------------------------------------------------------------------
   PROCEDURE PV_CargosBajaPenaliz_PR (    EO_GA_IMPPLZ     IN OUT NOCOPY  PV_GA_IMPPENALIZA_QT,
   			 						 	  SC_cursordatos   OUT NOCOPY 	  REFCURSOR,
			  							  SN_cod_retorno   OUT NOCOPY     ge_errores_pg.CodError,
              							  SV_mens_retorno  OUT NOCOPY     ge_errores_pg.MsgError,
										  SN_num_evento    OUT NOCOPY     ge_errores_pg.Evento);
----------------------------------------------------------------------------------------------------------
   PROCEDURE PV_CargosBajaIndemniz_PR (   EO_GA_CARGINDEMZ IN OUT NOCOPY  PV_GA_CARGOSBINDEMNIZ_QT,
   			 						  	  SC_cursordatos   OUT NOCOPY 	  REFCURSOR,
			  							  SN_cod_retorno   OUT NOCOPY     ge_errores_pg.CodError,
              							  SV_mens_retorno  OUT NOCOPY     ge_errores_pg.MsgError,
										  SN_num_evento    OUT NOCOPY     ge_errores_pg.Evento);
----------------------------------------------------------------------------------------------------------
	PROCEDURE PV_ObtieneDescPorConcepto_PR( SO_Descuentos IN OUT NOCOPY PV_TIPOS_PG.TIP_GAD_DESCUENTOS,
			  							 SC_cursordatos	 OUT NOCOPY REFCURSOR,
			  			 				 SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
              							 SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
										 SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

----------------------------------------------------------------------------------------------------------
	PROCEDURE PV_ObtieneDescPorArticulo_PR( SO_Descuentos IN OUT NOCOPY PV_TIPOS_PG.TIP_GAD_DESCUENTOS,
			  							 SC_cursordatos	 OUT NOCOPY REFCURSOR,
			  			 				 SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
              							 SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
										 SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------------------
    PROCEDURE PV_ObtieneParamBajIndemz_PR(EO_GA_PINDEMNIZ_QT IN OUT  PV_GA_PARAMBAJAINDEMNIZ_QT,
			  							  SC_cursordatos  OUT NOCOPY REFCURSOR,
								          SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
								          SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
								          SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

------------------------------------------------------------------------------------
    PROCEDURE PV_ObtieneCodConcepto_PR(SN_COD_CONCEPTO 		IN  GA_TRANSACABO.NUM_TRANSACCION%TYPE,
			  							  SV_CONCEPTO_DESC  OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE,
								          SN_cod_retorno  	OUT NOCOPY ge_errores_pg.CodError,
								          SV_mens_retorno 	OUT NOCOPY ge_errores_pg.MsgError,
								          SN_num_evento   	OUT NOCOPY ge_errores_pg.Evento);


------------------------------------------------------------------------------------
    PROCEDURE PV_EliminaCodConcepto_PR(SN_COD_CONCEPTO 		IN  GA_TRANSACABO.NUM_TRANSACCION%TYPE,
								          SN_cod_retorno  	OUT NOCOPY ge_errores_pg.CodError,
								          SV_mens_retorno 	OUT NOCOPY ge_errores_pg.MsgError,
								          SN_num_evento   	OUT NOCOPY ge_errores_pg.Evento);

----------------------------------------------------------------------------------------------------------

    FUNCTION PV_ConsultarEstadoFact_FN (EN_num_proceso	IN 		   FA_INTERFACT.num_proceso%TYPE,
									  SN_cod_retorno   OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
									  SV_mens_retorno  OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
									  SN_num_evento    OUT NOCOPY  ge_errores_pg.evento)
	RETURN  VARCHAR2 ;

----------------------------------------------------------------------------------------------------------
  PROCEDURE PV_ObtenerDetallePresup_PR(EN_num_proceso	IN 		   FA_INTERFACT.num_proceso%TYPE,
			  						  SC_cursordatos   OUT NOCOPY REFCURSOR,
									  SN_cod_retorno   OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
									  SV_mens_retorno  OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
									  SN_num_evento    OUT NOCOPY  ge_errores_pg.evento);
----------------------------------------------------------------------------------------------------------
  PROCEDURE PV_CargosAbonadoCero_PR ( EV_cod_concepto   IN         fa_conceptos.COD_CONCEPTO%type,
		  						  	  EN_cod_producto   IN         fa_conceptos.COD_PRODUCTO%type,
		  						   	  SC_cursordatos   OUT NOCOPY  REFCURSOR,
									  SN_cod_retorno   OUT NOCOPY  ge_errores_pg.CodError,
              						  SV_mens_retorno  OUT NOCOPY  ge_errores_pg.MsgError,
									  SN_num_evento    OUT NOCOPY  ge_errores_pg.Evento);
----------------------------------------------------------------------------------------------------------
PROCEDURE PV_REC_PREC_EQUIPO_NUEVO_PR (   EN_NUM_ABONADO   IN            GA_ABOCEL.NUM_ABONADO%TYPE,
		  						  	      EV_COD_PLANTARIF IN            GA_ABOCEL.COD_PLANTARIF%TYPE,
		  						   	      EN_COD_ARTICULO  IN            AL_PRECIOS_VENTA.COD_ARTICULO%TYPE,
                                          EV_IND_COMODATO  IN            GA_ABOCEL.IND_EQPRESTADO%TYPE,
                                          EN_COD_PRODUCTO  IN            GA_CARGOS_HABILITACION.COD_PRODUCTO%TYPE,
                                          EN_COD_MODVENTA  IN            AL_PRECIOS_VENTA.COD_MODVENTA%TYPE,
                                          EN_COD_USO       IN            AL_PRECIOS_VENTA.COD_USO%TYPE,
                                          EN_TIP_STOCK     IN            AL_PRECIOS_VENTA.TIP_STOCK%TYPE,
                                          EN_COD_ESTADO    IN            AL_PRECIOS_VENTA.COD_ESTADO%TYPE, 
                                          EN_NUM_MESES     IN            AL_PRECIOS_VENTA.NUM_MESES%TYPE,
                                          EN_IND_RECAMBIO  IN            GA_CARGOS_HABILITACION.IND_VENTA%TYPE,
                                          SN_PRECIO        OUT NOCOPY 	 AL_PRECIOS_VENTA.PRC_VENTA%TYPE,
									      SN_cod_retorno   OUT NOCOPY    ge_errores_pg.CodError,
              						      SV_mens_retorno  OUT NOCOPY    ge_errores_pg.MsgError,
									      SN_num_evento    OUT NOCOPY    ge_errores_pg.Evento);
----------------------------------------------------------------------------------------------------------
PROCEDURE PV_List_cargos_Habilitacion_PR (EV_IND_COMODATO    IN GA_ABOCEL.IND_EQPRESTADO%TYPE,
                                          EN_COD_PRODUCTO    IN GA_ACTUASERV.COD_PRODUCTO%TYPE,
 		   								  EN_COD_MODVENTA    IN GA_CARGOS_HABILITACION.COD_MODVENTA%TYPE,
										  EN_TIP_STOCK       IN GA_CARGOS_HABILITACION.TIP_STOCK%TYPE,
										  EN_COD_ARTICULO    IN GA_CARGOS_HABILITACION.COD_ARTICULO%TYPE,
										  EN_COD_USO         IN GA_CARGOS_HABILITACION.COD_USO%TYPE,
                                          EN_NUM_MESES       IN GA_CARGOS_HABILITACION.NUM_MESES%TYPE,
                                          EV_COD_PLANTARIF   IN VE_CATPLANTARIF.COD_PLANTARIF%TYPE,
                                          EV_COD_ANTIGUEDAD  IN GA_CARGOS_HABILITACION.COD_ANTIGUEDAD%TYPE,
					                      SC_cursordatos	 OUT NOCOPY REFCURSOR,
 					                      SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                 		                  SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                        	              SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);
----------------------------------------------------------------------------------------------------------
PROCEDURE PV_List_cargos_Deducible_PR (EN_COD_ARTICULO    IN AL_PRECIOS_DEDUCIBLE_TO.COD_ARTICULO%TYPE,
                                       EN_NUM_ABONADO     IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                       EV_NUM_SERIE_NUEVA IN AL_SERIES.NUM_SERIE%TYPE, 
                                       EV_NOMBRE_USUARIO  IN VARCHAR2,
					                   SC_cursordatos	  OUT NOCOPY REFCURSOR,
 					                   SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                 		               SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                        	           SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);
----------------------------------------------------------------------------------------------------------
PROCEDURE PV_List_cargos_Seguros_PR (EN_NUM_ABONADO          IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                     EV_NUM_SERIE_NUEVA      IN AL_SERIES.NUM_SERIE%TYPE,
 		   							 EV_COD_MONEDA           IN AL_PRECIOS_DEDUCIBLE_TO.COD_MONEDA%TYPE,
                                     EV_NOMBRE_USUARIO       IN VARCHAR2,
                                     EN_IMPORTE              IN NUMBER,
					                 SN_CARGO    	         OUT NOCOPY NUMBER,
 					                 SN_cod_retorno          OUT NOCOPY ge_errores_pg.CodError,
                 		             SV_mens_retorno         OUT NOCOPY ge_errores_pg.MsgError,
                        	         SN_num_evento           OUT NOCOPY ge_errores_pg.Evento);

----------------------------------------------------------------------------------------------------------
PROCEDURE PV_List_Prec_List_Rest_PR (EN_TIP_STOCK         IN AL_PRECIOS_VENTA.TIP_STOCK%TYPE,
                                     EN_COD_ARTICULO      IN AL_PRECIOS_VENTA.COD_ARTICULO%TYPE,
                                     EV_NUM_SERIE         IN AL_SERIES.NUM_SERIE%TYPE,
                                     EN_COD_USO           IN AL_PRECIOS_VENTA.COD_USO%TYPE, 
                                     EN_COD_ESTADO        IN AL_PRECIOS_VENTA.COD_ESTADO%TYPE,
                                     EN_NUM_ABONADO       IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                     EN_COD_ANTIGUEDAD    IN AL_ANTIGUEDAD.COD_ANTIGUEDAD%TYPE,   
                                     EN_COD_MODVENTA      IN AL_PRECIOS_VENTA.COD_MODVENTA%TYPE,
                                     EN_NUM_MESES         IN AL_PRECIOS_VENTA.NUM_MESES%TYPE,
                                     EV_NOMBRE_USUARIO    IN VARCHAR2,
					                 SC_cursordatos	      OUT NOCOPY REFCURSOR,
 					                 SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                 		             SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                        	         SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);
----------------------------------------------------------------------------------------------------------

PROCEDURE PV_PrecTerRen_NoPreLis_Rest_PR (EN_TIP_STOCK         IN AL_PRECIOS_VENTA.TIP_STOCK%TYPE,
                                          EN_COD_ARTICULO      IN AL_PRECIOS_VENTA.COD_ARTICULO%TYPE,
                                          EV_NUM_SERIE         IN AL_SERIES.NUM_SERIE%TYPE,
                                          EN_COD_USO           IN AL_PRECIOS_VENTA.COD_USO%TYPE, 
                                          EN_COD_ESTADO        IN AL_PRECIOS_VENTA.COD_ESTADO%TYPE,
                                          EN_NUM_ABONADO       IN GA_ABOCEL.NUM_ABONADO%TYPE,    
                                          EN_COD_ANTIGUEDAD    IN AL_ANTIGUEDAD.COD_ANTIGUEDAD%TYPE,   
                                          EN_COD_MODVENTA      IN AL_PRECIOS_VENTA.COD_MODVENTA%TYPE,
                                          EN_NUM_MESES         IN AL_PRECIOS_VENTA.NUM_MESES%TYPE,
                                          EN_PROMO_CELULAR     IN NUMBER, --0 CON PROMO, 1 SIN PROMO
                                          EV_NOMBRE_USUARIO    IN VARCHAR2,
					                      SC_cursordatos	      OUT NOCOPY REFCURSOR,
 					                      SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                 		                  SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                        	              SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);
----------------------------------------------------------------------------------------------------------

PROCEDURE pv_precarterm_noprelis_Rest_PR (EN_TIP_STOCK         IN AL_PRECIOS_VENTA.TIP_STOCK%TYPE,
                                          EN_COD_ARTICULO      IN AL_PRECIOS_VENTA.COD_ARTICULO%TYPE,
                                          EV_NUM_SERIE         IN AL_SERIES.NUM_SERIE%TYPE,
                                          EN_COD_USO           IN AL_PRECIOS_VENTA.COD_USO%TYPE, 
                                          EN_COD_ESTADO        IN AL_PRECIOS_VENTA.COD_ESTADO%TYPE,
                                          EN_NUM_ABONADO       IN GA_ABOCEL.NUM_ABONADO%TYPE,    
                                          EN_COD_ANTIGUEDAD    IN AL_ANTIGUEDAD.COD_ANTIGUEDAD%TYPE,   
                                          EN_COD_MODVENTA      IN AL_PRECIOS_VENTA.COD_MODVENTA%TYPE,
                                          EN_NUM_MESES         IN AL_PRECIOS_VENTA.NUM_MESES%TYPE,
                                          EV_NOMBRE_USUARIO    IN VARCHAR2,
					                      SC_cursordatos	      OUT NOCOPY REFCURSOR,
 					                      SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                 		                  SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                        	              SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);
                                      
----------------------------------------------------------------------------------------------------------

PROCEDURE VE_PrecCargoSim_PreLis_Rest_PR ( EN_NUM_ABONADO     IN GE_CARGOS.NUM_ABONADO%TYPE,
                                           --EN_COD_PRODUCTO    IN GA_ACTUASERV.COD_PRODUCTO%TYPE,
                                           --EN_COD_ACTABO      IN GA_ACTABO.COD_ACTABO%TYPE, 
                                           --EN_COD_PLANSERV    IN GA_TARIFAS.COD_PLANSERV%TYPE,
                                           --EN_COD_PLANCOM     IN GE_CARGOS.COD_PLANCOM%TYPE,
                                           --EV_NUM_SERIE       IN AL_SERIES.NUM_SERIE%TYPE,
                                           EN_TIP_STOCK       IN AL_SERIES.TIP_STOCK%TYPE,  
                                           EN_COD_USO         IN AL_SERIES.COD_USO%TYPE,
                                           EN_COD_ESTADO      IN AL_SERIES.COD_ESTADO%TYPE, 
                                           EN_COD_ARTICULO    IN AL_PRECIOS_VENTA.COD_ARTICULO%TYPE,
                                           EN_COD_MODVENTA    IN AL_PRECIOS_VENTA.COD_MODVENTA%TYPE,
                                           SC_cursordatos     OUT NOCOPY REFCURSOR,
                                           SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                           SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);
    
----------------------------------------------------------------------------------------------------------                                          

PROCEDURE PV_PreCarSim_NoPreLis_Rest_PR ( EN_NUM_ABONADO     IN GE_CARGOS.NUM_ABONADO%TYPE,
                                          --EN_COD_PRODUCTO    IN GA_ACTUASERV.COD_PRODUCTO%TYPE,
                                          --EN_COD_ACTABO      IN GA_ACTABO.COD_ACTABO%TYPE, 
                                          --EN_COD_PLANSERV    IN GA_TARIFAS.COD_PLANSERV%TYPE,
                                          --EN_COD_PLANCOM     IN GE_CARGOS.COD_PLANCOM%TYPE,
                                          --EV_NUM_SERIE       IN AL_SERIES.NUM_SERIE%TYPE,
                                          EN_TIP_STOCK       IN AL_SERIES.TIP_STOCK%TYPE,  
                                          EN_COD_USO         IN AL_SERIES.COD_USO%TYPE,
                                          EN_COD_ESTADO      IN AL_SERIES.COD_ESTADO%TYPE, 
                                          EN_COD_ARTICULO    IN AL_PRECIOS_VENTA.COD_ARTICULO%TYPE,
                                          EN_COD_MODVENTA    IN AL_PRECIOS_VENTA.COD_MODVENTA%TYPE,
                                          SC_cursordatos     OUT NOCOPY REFCURSOR,
                                          SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento      OUT NOCOPY ge_errores_pg.Evento); 

----------------------------------------------------------------------------------------------------------
                                                            
PROCEDURE PV_List_cargos_Dif_Garantia_PR (EN_VAL_DIFERENCIA  IN NUMBER,
					                      SC_cursordatos	 OUT NOCOPY REFCURSOR,
 					                      SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                 		                  SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                        	              SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);

----------------------------------------------------------------------------------------------------------
                                                                                                                                                                                                                                                                                                             
END PV_CARGOS_PG;
/
SHOW ERRORS