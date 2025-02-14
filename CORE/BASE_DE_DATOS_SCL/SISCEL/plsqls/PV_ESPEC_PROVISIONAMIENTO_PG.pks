CREATE OR REPLACE PACKAGE PV_ESPEC_PROVISIONAMIENTO_PG
IS

   TYPE refCursor IS REF CURSOR;
   CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
   CV_IndConsaldoPp	   	   CONSTANT VARCHAR2 (20) := 'IND_CONSALDO_PP';
   CV_ConsSaldoGsm	   	   CONSTANT VARCHAR2 (20) := 'CONS_SALDO_GSM';
   CV_ConsSaldoTdma        CONSTANT VARCHAR2 (20) := 'CONS_SALDO_TDMA';
   CV_ConsPlanGsm		   CONSTANT VARCHAR2 (13) := 'CONS_PLAN_GSM';
   CV_ConsPlanTdma		   CONSTANT VARCHAR2 (14) := 'CONS_PLAN_TDMA';
   CV_GrupoTecGsm	   	   CONSTANT VARCHAR2 (20) := 'GRUPO_TEC_GSM';
   CV_GrupoTecDma     	   CONSTANT VARCHAR2 (20) := 'GRUPO_TEC_DMA';
   CV_TipPlanPrepago       CONSTANT VARCHAR  (20) := 'TIP_PLAN_PREPAGO';
--   CV_TipoPrepago		   CONSTANT VARCHAR  (20) := 'TIPO_PREPAGO';
   CV_TipoPrepago		   CONSTANT VARCHAR  (20) := 'TIPOPREPAGO';
   CV_Homologar		       CONSTANT VARCHAR2 (20) := 'HOMOLOGAR';
   CV_PlatGsm		       CONSTANT VARCHAR2 (20) := 'PLAT_GSM';
   CV_PlatCdma		   	   CONSTANT VARCHAR2 (20) := 'PLAT_CDMA';
   CV_TipCodigo 	       CONSTANT VARCHAR2 (20) := 'TIP_CODIGO';
   CV_AplicaimptoGsm       CONSTANT VARCHAR2 (20) := 'APLICAIMPTO_GSM';
   CV_AplicaimptoTdma      CONSTANT VARCHAR2 (20) := 'APLICAIMPTO_TDMA';
   CV_Icc_Seq_Nummov	   CONSTANT VARCHAR2 (20) := 'ICC_SEQ_NUMMOV';
   CV_gsm				   CONSTANT VARCHAR2 (20) := 'GSM';
   CV_cdma			   	   CONSTANT VARCHAR2 (20) := 'CDMA';
   CN_Ind_Comerc		   CONSTANT NUMBER   (01) :=  1;
   CV_tip_relacion		   CONSTANT VARCHAR2 (01) := '3';
   CV_tip_servicio_1	   CONSTANT VARCHAR2 (01) := '1';

   CV_cod_actabo_F	   	   CONSTANT VARCHAR2 (01) := 'F';
   CV_cod_tipserv		   CONSTANT	VARCHAR2 (01) := '2';
   CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'GA';
   CV_version              CONSTANT VARCHAR2 (2)  := '1';
   CV_codEstado			   CONSTANT VARCHAR2 (1)  := '1';
   CV_codTipServ		   CONSTANT VARCHAR2 (01) := '1';
   CV_IndBloqueo		   CONSTANT VARCHAR2 (1)  := '0';

   CN_producto			   CONSTANT NUMBER        := 1;

   CV_PARAM_SS911          CONSTANT VARCHAR2 (20) := 'SS_ASISTENCIA_911';
   CV_PARAM_SSFAX          CONSTANT VARCHAR2 (20) := 'SS_FAX';

   -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTIENE_BODEGAS_PR(EO_Param_Venta	IN			   GA_VENTA_QT,
									                      SO_Lista_Bodegas  OUT NOCOPY	 refCursor,
								   						  SN_cod_retorno	OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
														  SV_mens_retorno   OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
														  SN_num_evento    OUT NOCOPY	ge_errores_pg.evento);
	------------------------------------------------------------------------------------------------------
--(1).- PV_GESTOR_CORP_PG.PV_BCORPORATIVO del metodo validaGestorCorp
	PROCEDURE PV_VALIDA_GESTOR_CORP_PR(EO_GESTOR_BCORP	 			IN			   PV_GESTOR_BCORP_QT,
									   SV_genera_comand_out			OUT NOCOPY     VARCHAR2,
									   SV_abonado_gestor_out		OUT NOCOPY     VARCHAR2,
									   SV_abonado_gestor_def_out	OUT NOCOPY     VARCHAR2,
								       SN_cod_retorno		 		OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
								       SV_mens_retorno    	 		OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
								       SN_num_evento      	 		OUT NOCOPY	   ge_errores_pg.evento);

--------------------------------------------------------------------------------------------------------------------------------------------
--2.- Metodo :Aprovisionamiento
	PROCEDURE PV_APROVISIONAR_CENTRAL_PR(EO_APROVISIONAR	 IN				GA_APROVISIONAR_QT,
									     SN_cod_retorno      OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
									     SV_mens_retorno     OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
									     SN_num_evento       OUT NOCOPY		ge_errores_pg.evento);

	--------------------------------------------------------------------------------------------------------
--(3).- Metodo :  ActualizarLimiteConsumo
	PROCEDURE PV_ACTUALIZA_LIMITE_CONSUMO_PR(
	  EO_LIMITE_CONSUMO	   	   IN   	  		PV_LIMITE_CONSUMO_QT,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento);

	-----------------------------------------------------------------------------------------------------
--4.- Metodo obtieneAtlantida
	PROCEDURE PV_OBTIENE_ATLANTIDA_PR(EO_GE_CLIENTES       	   IN 				GE_CLIENTES_QT,
								      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
								      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
								      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento);

------------------------------------------------------------------------------------------------------
--5.- Metodo validaBajaAtlantida
	PROCEDURE PV_VALIDA_BAJA_ATLANTIDA_PR(EO_VAL_BAJA_ATLANTIDA	   IN OUT NOCOPY	PV_VAL_BAJA_ATLANTIDA_QT,
									      SN_cod_retorno           	  OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
									      SV_mens_retorno          	  OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
									      SN_num_evento            	  OUT NOCOPY	ge_errores_pg.evento);

-----------------------------------------------------------------------------------------------------------------------------------
--7  CONSULTA PREPAGO  PLANTARIFARIO
	PROCEDURE PV_CONSULTA_PREPAGOS_PR (EO_CONS_PREPAGOS   	IN OUT  NOCOPY   PV_CONS_PREPAGOS_QT,
									   SN_cod_retorno          OUT  NOCOPY   ge_errores_td.cod_msgerror%TYPE,
								       SV_mens_retorno         OUT  NOCOPY   ge_errores_td.det_msgerror%TYPE,
								       SN_num_evento           OUT  NOCOPY	 ge_errores_pg.evento);

------------------------------------------------------------------------------------------------------------------------------------------
--8  Metodo Consulta_Prepagos_Celular_Serie
	PROCEDURE PV_CONSULTA_PREPAGOS_CelSer_PR (EO_CONS_PREPAGOS 	IN OUT  NOCOPY   PV_CONS_PREPAGOS_QT,
									   		  SN_cod_retorno       OUT  NOCOPY   ge_errores_td.cod_msgerror%TYPE,
								       		  SV_mens_retorno      OUT  NOCOPY   ge_errores_td.det_msgerror%TYPE,
								       		  SN_num_evento        OUT  NOCOPY	 ge_errores_pg.evento);

-----------------------------------------------------------------------------------------------------------------------------------
-- 10  Metodo Consulta Listas Activas       PV_ESPEC_PROVISIONAMIENTO_PG.PV_CONSULTA_LISTAACTIVAS_PR
	PROCEDURE PV_CONSULTA_LISTAACTIVAS_PR(EO_CONSALDO_ABONADO IN             	PV_CONSALDO_ABONADO_QT,
	  		  							  Cursor_GedCodigos		 OUT NOCOPY     refCursor,
										  SN_cod_retorno         OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
										  SV_mens_retorno        OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
										  SN_num_evento          OUT NOCOPY		ge_errores_pg.evento);

-----------------------------------------------------------------------------------------------------------------------------------------
-- 11  Metodo  :  	 PV_INSERTA_MOVATL_PR    (Invocar PL existente PV_OBTIENEINFO_ATLANTIDA_PG.PV_INSERTAMOV_ATL_PR )
	PROCEDURE PV_INSERTA_MOVATL_PR (SO_ABONADO 	     IN OUT NOCOPY   GA_ABONADO_QT,
							    SN_cod_retorno      OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
							    SV_mens_retorno     OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
							    SN_num_evento       OUT NOCOPY   ge_errores_pg.evento);

-----------------------------------------------------------------------------------------------------------------------------------------
-- 12 FUNCION   :  	 PV_OBTENER_PLANATLANTIDA_FN   (Llama PL existente PV_OBTIENEINFO_ATLANTIDA_PG.PV_OBTIENESERVICIO_ATL_PR(cod_plantarif, Servicio, SN_cod_retorno, SV_mens_retorno, SN_num_evento)
    FUNCTION PV_OBTENER_PLANATLANTIDA_FN (SO_ABONADO 	IN OUT NOCOPY  GA_ABONADO_QT,
									  SN_cod_retorno   OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
									  SV_mens_retorno  OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
									  SN_num_evento    OUT NOCOPY  ge_errores_pg.evento)
	RETURN VARCHAR2;

-----------------------------------------------------------------------------------------------------------------------------------------
--13  Metodo  :  	 registrarServContrato				PL   PV_REGISTRAR_SERV_CONTRATO_PR   				 PV_ESPEC_PROVISIONAMIENTO
PROCEDURE PV_REGISTRAR_SERV_CONTRATO_PR (SO_GA_ABOCEL 	IN OUT NOCOPY 	PV_GA_ABOCEL_QT,
							    SN_cod_retorno         OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
							    SV_mens_retorno        OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
							    SN_num_evento          OUT NOCOPY   ge_errores_pg.evento);

-----------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTENER_SERV_CONTRATO_PR (SO_ABONADO 	     IN OUT NOCOPY   GA_ABONADO_QT,
									   SN_cod_retorno       OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
									   SV_mens_retorno      OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
									   SN_num_evento        OUT NOCOPY   ge_errores_pg.evento);

-----------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTENER_PLANACTUAL_PR (EO_APROVISIONAR	    IN             GA_APROVISIONAR_QT,
		  						   	SO_ABONADO 	        OUT NOCOPY     GA_ABONADO_QT,
								    SN_cod_retorno      OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
								    SV_mens_retorno     OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
								    SN_num_evento       OUT NOCOPY     ge_errores_pg.evento);

-----------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_VALIDA_ELIM_CONTACTOS911_PR(EN_NUM_ABONADO      IN  ga_abocel.NUM_ABONADO%TYPE,
                                    EV_USER             IN  VARCHAR2,
                                    SN_cod_retorno      OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                    SV_mens_retorno     OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                    SN_num_evento       OUT NOCOPY   ge_errores_pg.evento);
                                    
-----------------------------------------------------------------------------------------------------------------------------------------

END PV_ESPEC_PROVISIONAMIENTO_PG;
/
SHOW ERRORS