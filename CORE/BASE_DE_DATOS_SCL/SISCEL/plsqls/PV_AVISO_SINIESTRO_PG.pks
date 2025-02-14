CREATE OR REPLACE PACKAGE PV_AVISO_SINIESTRO_PG
 IS
 TYPE refCursor IS REF CURSOR;

 CV_evento		  CONSTANT VARCHAR2(10) := 'FORMLOAD';
 CN_cod_ooss	  CONSTANT VARCHAR2(5)	:= '10060';

-- Inicio Modificacion - Rodrigo Munoz E. - TM-200411151097 - 30/11/2004
--FUNCTION PV_RETORNA_VERSION_AVISO_FN RETURN VARCHAR2;
FUNCTION RETORNA_VERSION RETURN VARCHAR2;
-- Fin Modificacion - Rodrigo Munoz E. - TM-200411151097 - 30/11/2004

PROCEDURE PV_TIPOS_SINIESTRO_PR(EN_num_celular  IN NUMBER,
		  						EV_usuario		IN VARCHAR2,
								tTip_Siniestro  OUT refCursor,
								SV_mensaje		OUT VARCHAR2,
								SV_error 	  	OUT VARCHAR2
);

PROCEDURE PV_TIPO_SUSPENSION_PR(EV_tipo_siniestro  IN VARCHAR2,
		  						EV_usuario		   IN VARCHAR2,
								tTip_Suspension    OUT refCursor,
								SV_mensaje		   OUT VARCHAR2,
								SV_error 		   OUT VARCHAR2
);

PROCEDURE PV_CAUSA_SINIESTRO_PR(EN_num_celular     IN NUMBER,
		  						EV_usuario		   IN VARCHAR2,
								tCausa_Siniestro   OUT refCursor,
								SV_mensaje         OUT VARCHAR2,
								SV_error 		   OUT VARCHAR2
);

PROCEDURE PV_ESTADO_TRANSACCION_PR(EN_num_celular  	  IN GA_ABOCEL.NUM_CELULAR%TYPE,
		  						   EN_num_ooss        IN PV_CAMCOM.NUM_OS%TYPE,
								   EV_usuario		  IN VARCHAR2,
								   SV_mensaje	  	  OUT VARCHAR2,
								   SV_resp_estado     OUT VARCHAR2,
								   SN_num_siniestro   OUT GA_SINIESTROS.NUM_SINIESTRO%TYPE,
								   SV_det_siniestro	  OUT GA_DETSINIE.OBS_DETALLE%TYPE,
								   SV_error 		  OUT VARCHAR2
);


FUNCTION PV_ASIGNA_CARGOS_FN  	   ( EN_cod_cliente		 IN GA_ABOCEL.COD_CLIENTE%TYPE,
									 EV_cod_planserv	 IN GA_ABOCEL.COD_PLANSERV%TYPE,
   									 EN_num_abonado    	 IN GA_ABOCEL.NUM_ABONADO%TYPE,
									 EN_num_terminal   	 IN GA_ABOCEL.NUM_CELULAR%TYPE,
									 ED_fec_alta       	 IN GA_ABOCEL.FEC_ALTA%TYPE,
									 EV_usuario        	 IN GE_CARGOS.NOM_USUARORA%TYPE,
									 SV_error           OUT VARCHAR2,
									 SV_proc            OUT VARCHAR2,
					          	  	 SV_tabla           OUT VARCHAR2,
					           	  	 SV_act     	    OUT VARCHAR2,
					           	  	 SV_sqlcode         OUT VARCHAR2,
					           	  	 SV_sqlerrm         OUT VARCHAR2
) RETURN BOOLEAN;

FUNCTION PV_RECUPERA_TIPO_ESTADO_FN(EN_num_ooss  IN NUMBER,
		  							EN_cod_estado      IN NUMBER,
									SV_tipo_estado     OUT VARCHAR2,
									SV_error 		   OUT VARCHAR2,
									SV_proc  		   OUT VARCHAR2,
									SV_tabla 		   OUT VARCHAR2,
									SV_act	  		   OUT VARCHAR2,
									SV_sqlcode 		   OUT VARCHAR2,
									SV_sqlerrm 		   OUT VARCHAR2
)RETURN BOOLEAN;


FUNCTION PV_RECUPERA_ESTADO_OOSS_FN(EN_num_ooss  IN NUMBER,
									SV_estado_ooss     OUT VARCHAR2,
									SV_error 		   OUT VARCHAR2,
									SV_proc  		   OUT VARCHAR2,
									SV_tabla 		   OUT VARCHAR2,
									SV_act	  		   OUT VARCHAR2,
									SV_sqlcode 		   OUT VARCHAR2,
									SV_sqlerrm 		   OUT VARCHAR2
)RETURN BOOLEAN;

PROCEDURE PV_ACEPTA_AS_PR(EN_num_celular 	IN NUMBER,
						  EV_tipo_sinie  	IN VARCHAR,
						  EN_tipo_susp      IN NUMBER,
						  EN_causa_sinie    IN NUMBER,
						  EV_usuario		IN VARCHAR2,
						  SV_mensaje		OUT VARCHAR2,
						  SN_num_solEqu     OUT NUMBER,
						  SN_num_solSim     OUT NUMBER,
						  SV_error 		    OUT VARCHAR2
);

FUNCTION PV_VALIDA_OOSS_FN(EN_num_celular    IN GA_ABOCEL.NUM_CELULAR%TYPE,
		  	               EN_num_ooss       IN PV_CAMCOM.NUM_OS%TYPE,
						   SV_error 		   OUT VARCHAR2,
						   SV_proc  		   OUT VARCHAR2,
						   SV_tabla 		   OUT VARCHAR2,
						   SV_act	  		   OUT VARCHAR2,
						   SV_sqlcode 		   OUT VARCHAR2,
						   SV_sqlerrm 		   OUT VARCHAR2
)RETURN BOOLEAN;

FUNCTION PV_DETT_SINIESTRO_FN(EN_num_siniestro  IN NUMBER,
		 					  SV_det_siniestro	OUT VARCHAR2,
							  SV_error 		   	OUT VARCHAR2,
							  SV_proc  		    OUT VARCHAR2,
							  SV_tabla 		    OUT VARCHAR2,
							  SV_act	  		OUT VARCHAR2,
							  SV_sqlcode 		OUT VARCHAR2,
							  SV_sqlerrm 		OUT VARCHAR2
)RETURN BOOLEAN;


FUNCTION PV_RECUPERA_NUM_SINIES_FN(EN_num_celular  	  IN NUMBER,
		  						   SN_num_siniestro   OUT NUMBER,
								   SV_error 		  OUT VARCHAR2,
								   SV_proc  		  OUT VARCHAR2,
								   SV_tabla 		  OUT VARCHAR2,
								   SV_act	  		  OUT VARCHAR2,
								   SV_sqlcode 		  OUT VARCHAR2,
								   SV_sqlerrm 		  OUT VARCHAR2
)RETURN BOOLEAN;

FUNCTION PV_VAL_TIPO_SINIESTRO_FN(EN_num_abonado  IN NUMBER,
		  	                       EN_tipo_terminal   IN NUMBER,
								   SV_respuesta       OUT BOOLEAN,
								   SV_error 		   OUT VARCHAR2,
								   SV_proc  		   OUT VARCHAR2,
								   SV_tabla 		   OUT VARCHAR2,
								   SV_act	  		   OUT VARCHAR2,
								   SV_sqlcode 		   OUT VARCHAR2,
								   SV_sqlerrm 		   OUT VARCHAR2
)RETURN BOOLEAN;

FUNCTION PV_RECUPERA_TERMINAL_FN(EN_tip_siniestro  IN NUMBER,
		 					     SV_tipo_terminal	OUT VARCHAR2,
								 SV_error 		   OUT VARCHAR2,
								 SV_proc  		   OUT VARCHAR2,
								 SV_tabla 		   OUT VARCHAR2,
								 SV_act	  		   OUT VARCHAR2,
								 SV_sqlcode 		   OUT VARCHAR2,
								 SV_sqlerrm 		   OUT VARCHAR2
)RETURN BOOLEAN;

END PV_AVISO_SINIESTRO_PG;
/
SHOW ERRORS
