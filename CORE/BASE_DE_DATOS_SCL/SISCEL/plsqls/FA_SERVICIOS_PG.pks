CREATE OR REPLACE PACKAGE FA_SERVICIOS_PG AS

TYPE refCursor IS REF CURSOR;		   

-------------- 
-- FUNTIONS --
-------------- 

 FUNCTION FA_OBTENER_SECUENCIA_FN (EV_ID_SECUENCIA IN  VARCHAR2,
 			   					   SN_COD_RETORNO  OUT NOCOPY NUMBER, 
			   					   SV_MENS_RETORNO OUT NOCOPY VARCHAR2, 
			   					   SN_NUM_EVENTO   OUT NOCOPY NUMBER) 
 RETURN VARCHAR2;

 FUNCTION FA_OBTENERCANTIDADCUOTAS_FN (EN_NUMCUOTAS    IN  NUMBER,
                                       SN_COD_RETORNO  OUT NOCOPY NUMBER, 
                                       SV_MENS_RETORNO OUT NOCOPY VARCHAR2, 
                                       SN_NUM_EVENTO   OUT NOCOPY NUMBER)
 RETURN NUMBER;			   

 FUNCTION FA_VALIDA_CONCEPTO_AFECTO_FN (EN_CODCONCEPTO  IN  NUMBER,
                                        EN_CODCATIMPOS  IN  GE_IMPUESTOS.COD_CATIMPOS%type,
			                            EN_CODZONAIMPO  IN  GE_IMPUESTOS.COD_ZONAIMPO%type,
									    EV_FECHASISTEMA IN  VARCHAR2,
 			                            SN_COD_RETORNO  OUT NOCOPY NUMBER, 
			                            SV_MENS_RETORNO OUT NOCOPY VARCHAR2, 
			                            SN_NUM_EVENTO   OUT NOCOPY NUMBER) 
 RETURN NUMBER;
 
 FUNCTION FA_VALIDAR_MENSAJE_FN (EN_CORRMENSAJE  IN  NUMBER,
                                 SN_COD_RETORNO  OUT NOCOPY NUMBER, 
                                 SV_MENS_RETORNO OUT NOCOPY VARCHAR2, 
			                     SN_NUM_EVENTO   OUT NOCOPY NUMBER)
 RETURN NUMBER; 
 
 FUNCTION FA_VERIFCARGOS_DESCUENTOS_FN (EN_CODCONCEPTOCARGO     IN  NUMBER,
                                        EN_CODCONCEPTODESCUENTO IN  NUMBER,
                                        SN_COD_RETORNO          OUT NOCOPY NUMBER, 
			                            SV_MENS_RETORNO         OUT NOCOPY VARCHAR2, 
			                            SN_NUM_EVENTO           OUT NOCOPY NUMBER)
 RETURN NUMBER; 
 
 FUNCTION FA_VALIDA_CONCEPTO_FN (EN_CODCONCEPTO  IN  NUMBER,
			                     EV_CODTIPCONCE  IN  VARCHAR2,
                                 SN_COD_RETORNO  OUT NOCOPY NUMBER, 
                                 SV_MENS_RETORNO OUT NOCOPY VARCHAR2, 
                                 SN_NUM_EVENTO   OUT NOCOPY NUMBER) 
 RETURN NUMBER;
 
---------------- 
-- PROCEDURES -- 
----------------			
 PROCEDURE FA_REGISTRAR_PROCESO_PR (EN_NUM_PROCESO 		   	  IN  FA_PROCESOS.NUM_PROCESO%type,
 								    EN_COD_TIPDOCUM 		  IN  FA_PROCESOS.COD_TIPDOCUM%type,
  								    EN_COD_VENDEDOR_AGENTE    IN  FA_PROCESOS.COD_VENDEDOR_AGENTE%type,
  								    EN_COD_CENTREMI 		  IN  FA_PROCESOS.COD_CENTREMI%type,
  								    ED_FEC_EFECTIVIDAD 	   	  IN  VARCHAR2,
  								    EV_NOM_USUARORA 		  IN  FA_PROCESOS.NOM_USUARORA%type,
  								    EV_LETRAAG  			  IN  FA_PROCESOS.LETRAAG%type,  
  								    EN_NUM_SECUAG 		   	  IN  FA_PROCESOS.NUM_SECUAG%type,
  								    EN_COD_TIPDOCNOT 	   	  IN  FA_PROCESOS.COD_TIPDOCNOT%type,
  								    EN_COD_VENDEDOR_AGENTENOT IN  FA_PROCESOS.COD_VENDEDOR_AGENTENOT%type,
  								    EV_LETRANOT  			  IN  FA_PROCESOS.LETRANOT%type,
								    EV_COD_CENTRNOT 		  IN  FA_PROCESOS.COD_CENTRNOT%type,
  								    EN_NUM_SECUNOT  		  IN  FA_PROCESOS.NUM_SECUNOT%type,
  								    EN_IND_ESTADO 			  IN  FA_PROCESOS.IND_ESTADO%type,
  								    EN_COD_CICLFACT 		  IN  FA_PROCESOS.COD_CICLFACT%type,
  								    EN_IND_NOTACREDC 		  IN  FA_PROCESOS.IND_NOTACREDC%type,
                                    SN_COD_RETORNO  		  OUT NOCOPY NUMBER, 
                                    SV_MENS_RETORNO 		  OUT NOCOPY VARCHAR2, 
                                    SN_NUM_EVENTO   		  OUT NOCOPY NUMBER);

 PROCEDURE FA_REGISTRAR_MENSAJE_PR (EN_CORRMENSAJE  IN  NUMBER,
                                    EV_DESCMENSAJE  IN  VARCHAR2,
									EN_NUMLINEA     IN  NUMBER,
									EV_CODIDIOMA    IN  VARCHAR2,
									EV_DESCMENSLIN  IN  VARCHAR2,
                                    SN_COD_RETORNO  OUT NOCOPY NUMBER, 
			                        SV_MENS_RETORNO OUT NOCOPY VARCHAR2, 
			                        SN_NUM_EVENTO   OUT NOCOPY NUMBER);

PROCEDURE   FA_OBTPARMENSAJE_PR (EN_COD_FORMULARIO  IN  NUMBER,
 								 EN_COD_BLOQUE      IN  NUMBER,
								 SN_CANT_LINEASMEN  OUT NUMBER,
 								 SN_CANT_CARACTLIN  OUT NUMBER, 								 
                                 SN_COD_RETORNO     OUT NOCOPY NUMBER, 
                                 SV_MENS_RETORNO    OUT NOCOPY VARCHAR2, 
			                     SN_NUM_EVENTO      OUT NOCOPY NUMBER);
																	
 PROCEDURE FA_REGISTRAR_MENSPROCESO_PR (EN_NUMPROCESO    IN  NUMBER,  
                                        EN_CODFORMULARIO IN  NUMBER,
                                        EN_CODBLOQUE     IN  NUMBER,   
										EN_CORRMENSAJE   IN  NUMBER,
                                        EN_NUMLINEAS     IN  NUMBER,   
										EV_CODORIGEN     IN  VARCHAR2,
                                        EV_DESCMENSAJE   IN  VARCHAR2, 
										EV_INDFACTURADO  IN  VARCHAR2,
                                        EV_NOMUSUARIO    IN  VARCHAR2,  
										EV_FECHASISTEMA  IN  VARCHAR2,
                                        SN_COD_RETORNO   OUT NOCOPY NUMBER, 
			                            SV_MENS_RETORNO  OUT NOCOPY VARCHAR2, 
			                            SN_NUM_EVENTO    OUT NOCOPY NUMBER);									   


 PROCEDURE FA_REGISTRAR_CARGOS_PR (EN_NUM_PROCESO      IN  NUMBER,
 		   						   EN_COD_CLIENTE      IN  NUMBER,
  								   EN_COD_CONCEPTO     IN  NUMBER,
  								   EN_COLUMNA          IN  NUMBER,
  								   EN_COD_PRODUCTO     IN  NUMBER,
  								   EV_COD_MONEDA       IN  VARCHAR2,
  								   EV_FEC_VALOR        IN  VARCHAR2,
  								   EV_FEC_EFECTIVIDAD  IN  VARCHAR2,
  								   EN_IMP_CONCEPTO     IN  NUMBER,
  								   EN_IMP_FACTURABLE   IN  NUMBER,
  								   EN_IMP_MONTOBASE    IN  NUMBER,
  								   EV_COD_REGION       IN  VARCHAR2,
  								   EV_COD_PROVINCIA    IN  VARCHAR2,
  								   EV_COD_CIUDAD       IN  VARCHAR2,
  								   EV_COD_MODULO       IN  VARCHAR2,
  								   EN_COD_PLANCOM      IN  NUMBER,
  								   EN_IND_FACTUR       IN  NUMBER,
  								   EN_NUM_UNIDADES     IN  NUMBER,
  								   EN_COD_CATIMPOS     IN  NUMBER,
  								   EN_IND_ESTADO       IN  NUMBER,
  								   EN_COD_PORTADOR     IN  NUMBER,
  								   EN_COD_TIPCONCE     IN  NUMBER,
  								   EN_COD_CICLFACT     IN  NUMBER,
  								   EN_COD_CONCEREL     IN  NUMBER,
  								   EN_COLUMNA_REL      IN  NUMBER,
  								   EN_NUM_ABONADO      IN  NUMBER,
  								   EV_NUM_TERMINAL     IN  VARCHAR2,
  								   EN_CAP_CODE         IN  NUMBER,
  								   EV_NUM_SERIEMEC     IN  VARCHAR2,
  								   EV_NUM_SERIELE      IN  VARCHAR2,
  								   EN_FLAG_IMPUES      IN  NUMBER,
  								   EN_FLAG_DTO         IN  NUMBER,
  								   EN_PRC_IMPUESTO     IN  NUMBER,
  								   EN_VAL_DTO          IN  NUMBER,
  								   EN_TIP_DTO          IN  NUMBER,
  								   EN_NUM_VENTA        IN  NUMBER,
  								   EN_MES_GARANTIA     IN  NUMBER,
  								   EN_IND_ALTA         IN  NUMBER,
  								   EN_IND_SUPERTEL     IN  NUMBER,
  								   EN_NUM_PAQUETE      IN  NUMBER,
  								   EN_NUM_TRANSACCION  IN  NUMBER,
  								   EN_IND_CUOTA        IN  NUMBER,
  								   EN_NUM_GUIA         IN  NUMBER,
  								   EN_NUM_CUOTAS       IN  NUMBER,
  								   EN_ORD_CUOTA        IN  NUMBER,
  								   EV_DES_NOTACREDC    IN  VARCHAR2,
  								   EN_IND_MODVENTA     IN  NUMBER,
  								   EV_IND_RECUPIVA     IN  CHAR,
  								   EN_COD_TIPDOCUM     IN  NUMBER,
  								   EV_COD_TECNOLOGIA   IN  VARCHAR2,
  								   EV_COD_MONEDAIMP    IN  VARCHAR2,
  								   EN_IMP_CONVERSION   IN  NUMBER,
  								   EN_IMP_VALUNITARIO  IN  NUMBER,
  								   EV_GLS_DESCRIP      IN  VARCHAR2,							
								   SN_COD_RETORNO      OUT NOCOPY NUMBER, 
			                       SV_MENS_RETORNO     OUT NOCOPY VARCHAR2, 
			                       SN_NUM_EVENTO       OUT NOCOPY NUMBER);

							   
								   
PROCEDURE FA_EJECUTAR_FACTURA_PR (EV_num_proceso     IN  VARCHAR2,
 								  EV_num_venta       IN  VARCHAR2,
 								  EV_cod_modgener    IN  VARCHAR2,
 								  EV_cod_tipmovimien IN  VARCHAR2,
 								  EV_cod_catribut    IN  VARCHAR2,
 								  EV_num_folio       IN  VARCHAR2,
 								  EV_cod_estadoc     IN  VARCHAR2,
 								  EV_cod_estproc     IN  VARCHAR2,
 								  EV_fec_vencimiento IN  VARCHAR2,
								  EV_fec_ingreso     IN  VARCHAR2,
 								  EV_cod_modventa    IN  VARCHAR2,
 								  EV_num_cuotas      IN  VARCHAR2,
 								  EV_pref_plaza      IN  VARCHAR2,
 								  EV_tip_foliacion   IN  VARCHAR2,
 								  EV_cod_tipdocum	 IN  VARCHAR2,
								  SN_COD_RETORNO     OUT NOCOPY NUMBER, 
			                      SV_MENS_RETORNO    OUT NOCOPY VARCHAR2, 
			                      SN_NUM_EVENTO      OUT NOCOPY NUMBER);								   
END;
/
SHOW ERRORS