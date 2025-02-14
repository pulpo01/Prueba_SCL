CREATE OR REPLACE PACKAGE PV_ANULA_SINIESTRO_PG IS



-- Declaracion de Variables Globales
   TYPE vCursor IS REF CURSOR;
-- Inicio especificacion PL/SQL
   
   	  CV_Cod_Actuacion CONSTANT VARCHAR2(2) := 'FS' ;
	  CV_Cod_Modulo    CONSTANT VARCHAR2(2) := 'GA' ;
	  CV_Suspendido    CONSTANT VARCHAR2(3) := 'SAA';
	  CV_Comentario	   CONSTANT VARCHAR(255):= 'Anula Siniestro por Plataforma Externa';
  	  CN_Cod_Producto  CONSTANT NUMBER(1)   :=     1;
  	  CN_Cod_OOSS  	   CONSTANT NUMBER(5)   := 10231;
	  CV_Evento 	   CONSTANT VARCHAR2(20) := 'FORMLOAD'; --VALIDA RESTRICCION


    -- Inicio Modificacion - Rodrigo Munoz E. - TM-200411151097 - 30/11/2004
	--FUNCTION PV_RETORNA_VERSION_ANULA_FN RETURN VARCHAR2;
	FUNCTION RETORNA_VERSION RETURN VARCHAR2;
    -- Fin Modificacion - Rodrigo Munoz E. - TM-200411151097 - 30/11/2004
		  
	PROCEDURE PV_CARGA_ANULA_PR		 		  (EN_NUM_CELULAR     IN GA_ABOCEL.NUM_CELULAR%TYPE,
						        			   EV_USUARIO	      IN GE_SEG_USUARIO.NOM_USUARIO%TYPE,
											   SV_CURSOR 	     OUT vCursor,
											   SV_MENS_ERROR	 OUT VARCHAR2,							
											   SV_ERROR        	 OUT VARCHAR2);
	
	FUNCTION PV_REC_DATOS_SINIESTROS_FN	  	  (EN_NUM_ABONADO     IN GA_ABOCEL.NUM_ABONADO%TYPE,
		  							 	   	   EN_COD_PRODUCTO    IN GA_ABOCEL.COD_PRODUCTO%TYPE,
			 							   	   SV_CURSOR 	     OUT vCursor,															
						              	   	   SV_PROC           OUT VARCHAR2,
						           		   	   SV_TABLA          OUT VARCHAR2,
						           		   	   SV_ACT     	     OUT VARCHAR2,
						           		   	   SV_SQLCODE        OUT VARCHAR2,
						           		   	   SV_SQLERRM        OUT VARCHAR2,
						           		   	   SV_ERROR          OUT VARCHAR2)  RETURN BOOLEAN;		
    
	PROCEDURE PV_PROCESA_ANULACION_PR		  (EN_NUM_CELULAR     IN GA_ABOCEL.NUM_CELULAR%TYPE,
   			   	  		    				   EV_USUARIO	   	  IN GE_SEG_USUARIO.NOM_USUARIO%TYPE,
								  			   EN_NUM_SINIESTRO   IN GA_SINIESTROS.NUM_SINIESTRO%TYPE,
								  			   SN_NUM_OS	     OUT CI_ORSERV.NUM_OS%TYPE,
						          			   SV_MENS_ERROR	 OUT VARCHAR2,
								  			   SV_ERROR          OUT VARCHAR2);

	FUNCTION  PV_VALIDA_SINIESTRO_FN          (EN_NUM_SINIESTRO   IN GA_SINIESTROS.NUM_SINIESTRO%TYPE,
						           	  		   SV_PROC           OUT VARCHAR2,
						          	  		   SV_TABLA          OUT VARCHAR2,
						           	  		   SV_ACT     	   	 OUT VARCHAR2,
						           	  		   SV_SQLCODE        OUT VARCHAR2,
						           	  		   SV_SQLERRM        OUT VARCHAR2,
						           	  		   SV_ERROR          OUT VARCHAR2) RETURN BOOLEAN;											   
	
	FUNCTION PV_UPD_ANULACION_SINIESTRO_FN    (EN_NUM_SINIESTRO   IN GA_SINIESTROS.NUM_SINIESTRO%TYPE,
						           	  		   SV_PROC           OUT VARCHAR2,
						          	  		   SV_TABLA          OUT VARCHAR2,
						           	  		   SV_ACT     	   	 OUT VARCHAR2,
						           	  		   SV_SQLCODE        OUT VARCHAR2,
						           	  		   SV_SQLERRM        OUT VARCHAR2,
						           	  		   SV_ERROR          OUT VARCHAR2) RETURN BOOLEAN;	
	
	FUNCTION  PV_INS_DET_ANUL_SINIESTRO_FN    (EN_NUM_SINIESTRO   IN GA_SINIESTROS.NUM_SINIESTRO%TYPE,
  			   	  		    				   EV_USUARIO	   	  IN GE_SEG_USUARIO.NOM_USUARIO%TYPE,		  							  
						           	  		   SV_PROC           OUT VARCHAR2,
						          	  		   SV_TABLA          OUT VARCHAR2,
						           	  		   SV_ACT     	   	 OUT VARCHAR2,
						           	  		   SV_SQLCODE        OUT VARCHAR2,
						           	  		   SV_SQLERRM        OUT VARCHAR2,
						           	  		   SV_ERROR          OUT VARCHAR2) RETURN BOOLEAN;
	
	FUNCTION  PV_CHEQUEA_TERMINAL_FN 	      (EN_NUM_SINIESTRO   IN GA_SINIESTROS.NUM_SINIESTRO%TYPE,
						           	  		   EN_NUM_ABONADO 	  IN GA_ABOCEL.NUM_ABONADO%TYPE,
											   EV_COD_TECNOLOGIA  IN GA_ABOCEL.COD_TECNOLOGIA%TYPE,
											   EV_COD_SITUACION   IN GA_ABOCEL.COD_SITUACION%TYPE,
											   EV_COD_MODULO      IN GA_SUSPREHABO.COD_MODULO%TYPE,
											   EV_COD_SUSP		  IN GA_ABOCEL.COD_SITUACION%TYPE,
											   SV_PROC           OUT VARCHAR2,
						          	  		   SV_TABLA          OUT VARCHAR2,
						           	  		   SV_ACT     	   	 OUT VARCHAR2,
						           	  		   SV_SQLCODE        OUT VARCHAR2,
						           	  		   SV_SQLERRM        OUT VARCHAR2,
						           	  		   SV_ERROR          OUT VARCHAR2) RETURN BOOLEAN;		
	
	FUNCTION  PV_REHABILITA_SUSPENSION_FN     (SV_PROC           OUT VARCHAR2,
						          	  		   SV_TABLA          OUT VARCHAR2,
						           	  		   SV_ACT     	   	 OUT VARCHAR2,
						           	  		   SV_SQLCODE        OUT VARCHAR2,
						           	  		   SV_SQLERRM        OUT VARCHAR2,
						           	  		   SV_ERROR          OUT VARCHAR2) RETURN BOOLEAN;
    
	FUNCTION  PV_ACTUALIZA_SITUACION_FN       (EN_NUM_ABONADO     IN GA_ABOCEL.NUM_ABONADO%TYPE,
			  							  	   SV_PROC           OUT VARCHAR2,
					          	  		  	   SV_TABLA          OUT VARCHAR2,
					           	  		  	   SV_ACT     	   	 OUT VARCHAR2,
					           	  		  	   SV_SQLCODE        OUT VARCHAR2,
					           	  		  	   SV_SQLERRM        OUT VARCHAR2,
					           	  		  	   SV_ERROR          OUT VARCHAR2) RETURN BOOLEAN;
    
	FUNCTION  PV_CONSULTA_SUSPENSION_FN  	  (EN_NUM_ABONADO     IN GA_ABOCEL.NUM_ABONADO%TYPE,
			  							  	   SN_COD_SERVICIO	 OUT GA_SUSPREHABO.COD_SERVICIO%TYPE,
		  							      	   SD_FEC_SUSPCEN	 OUT GA_SUSPREHABO.FEC_SUSPCEN%TYPE,
					           	  		  	   SV_PROC           OUT VARCHAR2,
					          	  		  	   SV_TABLA          OUT VARCHAR2,
					           	  		  	   SV_ACT     	   	 OUT VARCHAR2,
					           	  		  	   SV_SQLCODE        OUT VARCHAR2,
					           	  		  	   SV_SQLERRM        OUT VARCHAR2,
					           	  		  	   SV_ERROR          OUT VARCHAR2) RETURN BOOLEAN;								   			
    
	FUNCTION  PV_MODIFICA_SUSPENSION_FN  	  (EN_NUM_ABONADO     IN GA_ABOCEL.NUM_ABONADO%TYPE,
		  							   	  	   EN_COD_SERVICIO	  IN GA_SUSPREHABO.COD_SERVICIO%TYPE,
		  							      	   ED_FEC_SUSPCEN	  IN GA_SUSPREHABO.FEC_SUSPCEN%TYPE,
					           	  		  	   SV_PROC           OUT VARCHAR2,
					          	  		  	   SV_TABLA          OUT VARCHAR2,
					           	  		  	   SV_ACT     	   	 OUT VARCHAR2,
					           	  		  	   SV_SQLCODE        OUT VARCHAR2,
					           	  		  	   SV_SQLERRM        OUT VARCHAR2,
					           	  		  	   SV_ERROR          OUT VARCHAR2) RETURN BOOLEAN;										  
	
	PROCEDURE  PV_MOV_ANULSINIES_PR  	      (EN_NUM_CELULAR     IN GA_ABOCEL.NUM_CELULAR%TYPE,
   			   	  		    				   EV_USUARIO	   	  IN GE_SEG_USUARIO.NOM_USUARIO%TYPE,
											   EN_NUM_OS		  IN CI_ORSERV.NUM_OS%TYPE,
						           	  		   SV_PROC           OUT VARCHAR2,
						          	  		   SV_TABLA          OUT VARCHAR2,
						           	  		   SV_ACT     	   	 OUT VARCHAR2,
						           	  		   SV_SQLCODE        OUT VARCHAR2,
						           	  		   SV_SQLERRM        OUT VARCHAR2,
						           	  		   SV_ERROR          OUT VARCHAR2);
    
	FUNCTION  PV_RECUPERA_DTOS_MOV_FN         (EV_COD_PLANTARIF   IN GA_ABOCEL.COD_PLANTARIF%TYPE,
		  						   		       EN_COD_TIPMODI	  IN PV_ACTABO_TIPLAN.COD_TIPMODI%TYPE,
					           	  			   SV_PROC           OUT VARCHAR2,
					          	  			   SV_TABLA          OUT VARCHAR2,
					           	  			   SV_ACT     	   	 OUT VARCHAR2,
					           	  			   SV_SQLCODE        OUT VARCHAR2,
					           	  			   SV_SQLERRM        OUT VARCHAR2,
					           	  			   SV_ERROR          OUT VARCHAR2) RETURN PV_ACTABO_TIPLAN.COD_ACTABO%TYPE;		
	
	FUNCTION PV_RESTITUIR_CARGO_BSCO_FN       (EN_NUM_SINIESTRO   IN GA_SINIESTROS.NUM_SINIESTRO%TYPE,
						           	  	       SV_PROC           OUT VARCHAR2,
						          	  	 	   SV_TABLA          OUT VARCHAR2,
						           	  	 	   SV_ACT     	  	 OUT VARCHAR2,
						           	  	 	   SV_SQLCODE        OUT VARCHAR2,
						           	  	 	   SV_SQLERRM        OUT VARCHAR2,
						           	  	 	   SV_ERROR          OUT VARCHAR2) RETURN BOOLEAN;
	
	FUNCTION PV_RECUPERA_CARGO_BSCO_FN        (EN_NUM_SINIESTRO   IN GA_SINIESTROS.NUM_SINIESTRO%TYPE,
						           	  	 	   SV_PROC           OUT VARCHAR2,
						          	  	 	   SV_TABLA          OUT VARCHAR2,
						           	  	 	   SV_ACT     	     OUT VARCHAR2,
						           	  	 	   SV_SQLCODE        OUT VARCHAR2,
						           	  	 	   SV_SQLERRM        OUT VARCHAR2,
						           	  	 	   SV_ERROR          OUT VARCHAR2) RETURN VARCHAR2;	
	
	FUNCTION PV_DEL_LISTAS_NEGRAS_FN          (EN_NUM_ABONADO     IN GA_ABOCEL.NUM_ABONADO%TYPE,
		 						  	  	 	   EV_NUM_ICC		  IN GA_ABOCEL.NUM_SERIE%TYPE,
			 						  	 	   SV_PROC           OUT VARCHAR2,
						          	  	 	   SV_TABLA          OUT VARCHAR2,
						           	  	 	   SV_ACT     	     OUT VARCHAR2,
						           	  	 	   SV_SQLCODE        OUT VARCHAR2,
						           	  	 	   SV_SQLERRM        OUT VARCHAR2,
						           	  	 	   SV_ERROR          OUT VARCHAR2) RETURN BOOLEAN;										 									  																		   																																  								 					   
	
	FUNCTION  PV_HIST_SINIESTRO_FN     		  (EN_NUM_SINIESTRO   IN GA_SINIESTROS.NUM_SINIESTRO%TYPE,
						           	  	 	   SV_PROC           OUT VARCHAR2,
						          	  	 	   SV_TABLA          OUT VARCHAR2,
						           	  	 	   SV_ACT     	     OUT VARCHAR2,
						           	  	 	   SV_SQLCODE        OUT VARCHAR2,
						           	  	 	   SV_SQLERRM        OUT VARCHAR2,
						           	  	 	   SV_ERROR          OUT VARCHAR2) RETURN BOOLEAN;

	FUNCTION PV_HIST_DET_SINIESTRO_FN         (EN_NUM_SINIESTRO   IN GA_SINIESTROS.NUM_SINIESTRO%TYPE,
						           	  	 	   SV_PROC           OUT VARCHAR2,
						          	  	 	   SV_TABLA          OUT VARCHAR2,
						           	  	 	   SV_ACT     	     OUT VARCHAR2,
						           	  	 	   SV_SQLCODE        OUT VARCHAR2,
						           	  	 	   SV_SQLERRM        OUT VARCHAR2,
						           	  	 	   SV_ERROR          OUT VARCHAR2) RETURN BOOLEAN;

	FUNCTION PV_DEL_DET_SINIESTRO_FN  		  (EN_NUM_SINIESTRO   IN GA_SINIESTROS.NUM_SINIESTRO%TYPE,
						           	  	 	   SV_PROC           OUT VARCHAR2,
						          	  	 	   SV_TABLA          OUT VARCHAR2,
						           	  	 	   SV_ACT     	     OUT VARCHAR2,
						           	  	 	   SV_SQLCODE        OUT VARCHAR2,
						           	  	 	   SV_SQLERRM        OUT VARCHAR2,
						           	  	 	   SV_ERROR          OUT VARCHAR2) RETURN BOOLEAN;	

	FUNCTION PV_PASO_HIST_SINIESTRO_FN        (EN_NUM_SINIESTRO   IN GA_SINIESTROS.NUM_SINIESTRO%TYPE,
						           	  	 	   SV_PROC           OUT VARCHAR2,
						          	  	 	   SV_TABLA          OUT VARCHAR2,
						           	  	 	   SV_ACT     	     OUT VARCHAR2,
						           	  	 	   SV_SQLCODE        OUT VARCHAR2,
						           	  	 	   SV_SQLERRM        OUT VARCHAR2,
						           	  	 	   SV_ERROR          OUT VARCHAR2) RETURN BOOLEAN;

	FUNCTION PV_DEL_SINIESTRO_FN              (EN_NUM_SINIESTRO   IN GA_SINIESTROS.NUM_SINIESTRO%TYPE,
						           	  	 	   SV_PROC           OUT VARCHAR2,
						          	  	 	   SV_TABLA          OUT VARCHAR2,
						           	  	 	   SV_ACT     	     OUT VARCHAR2,
						           	  	 	   SV_SQLCODE        OUT VARCHAR2,
						           	  	 	   SV_SQLERRM        OUT VARCHAR2,
						           	  	 	   SV_ERROR          OUT VARCHAR2) RETURN BOOLEAN;	

	FUNCTION PV_ASIGNA_CARGOS_FN  	   		  (EN_COD_CLIENTE	  IN GA_ABOCEL.COD_CLIENTE%TYPE,
		 						   	 		   EN_COD_PRODUCTO	  IN GA_ABOCEL.COD_PRODUCTO%TYPE,
									 		   EV_COD_PLANSERV	  IN GA_ABOCEL.COD_PLANSERV%TYPE,
   									 		   EN_NUM_ABONADO     IN GA_ABOCEL.NUM_ABONADO%TYPE,
									 		   EN_NUM_TERMINAL    IN GA_ABOCEL.NUM_CELULAR%TYPE,
									 		   ED_FEC_ALTA        IN GA_ABOCEL.FEC_ALTA%TYPE,
   			   	  		    				   EV_USUARIO	   	  IN GE_SEG_USUARIO.NOM_USUARIO%TYPE,
											   SV_PROC           OUT VARCHAR2,
						          	  	 	   SV_TABLA          OUT VARCHAR2,
						           	  	 	   SV_ACT     	     OUT VARCHAR2,
						           	  	 	   SV_SQLCODE        OUT VARCHAR2,
						           	  	 	   SV_SQLERRM        OUT VARCHAR2,
						           	  	 	   SV_ERROR          OUT VARCHAR2) RETURN BOOLEAN;


	PROCEDURE PV_EJEC_OOSS_PR   	          (EV_USUARIO	      IN GE_SEG_USUARIO.NOM_USUARIO%TYPE,
		  						   	   	 	   EN_NUM_CELULAR	  IN GA_ABOCEL.NUM_CELULAR%TYPE,
			  						   	 	   SN_NUM_OS		 OUT CI_ORSERV.NUM_OS%TYPE,
			  						   	 	   SV_PROC           OUT VARCHAR2,
						          	  	 	   SV_TABLA          OUT VARCHAR2,
						           	  	 	   SV_ACT     	     OUT VARCHAR2,
						           	  	 	   SV_SQLCODE        OUT VARCHAR2,
						           	  	 	   SV_SQLERRM        OUT VARCHAR2,
						           	  	 	   SV_ERROR          OUT VARCHAR2);

	FUNCTION PV_REG_AUDITORIA_FN	          (EN_NUM_OS		  IN CI_ORSERV.NUM_OS%TYPE,
			 								   EN_NUM_CELULAR	  IN GA_ABOCEL.NUM_CELULAR%TYPE,
											   EN_NUM_ABONADO	  IN GA_ABOCEL.NUM_ABONADO%TYPE,
											   EV_COD_CARGOBASICO IN GA_INTARCEL.COD_CARGOBASICO%TYPE,
			 								   SV_PROC            OUT VARCHAR2,
						          	  	 	   SV_TABLA           OUT VARCHAR2,
						           	  	 	   SV_ACT     	      OUT VARCHAR2,
						           	  	 	   SV_SQLCODE         OUT VARCHAR2,
						           	  	 	   SV_SQLERRM         OUT VARCHAR2,
						           	  	 	   SV_ERROR           OUT VARCHAR2) RETURN BOOLEAN;											 										 

	FUNCTION PV_RECUPERA_CARGO_BSCO_ORIG_FN   (EN_COD_CLIENTE      IN GA_ABOCEL.COD_CLIENTE%TYPE,
	 								 	       EN_NUM_ABONADO	   IN GA_ABOCEL.NUM_ABONADO%TYPE,
										       SV_PROC            OUT VARCHAR2,
				          	  	 	 	       SV_TABLA           OUT VARCHAR2,
				           	  	 	 	       SV_ACT     	      OUT VARCHAR2,
				           	  	 	 	       SV_SQLCODE         OUT VARCHAR2,
				           	  	 	 	       SV_SQLERRM         OUT VARCHAR2,
				           	  	 	 	       SV_ERROR           OUT VARCHAR2) RETURN GA_INTARCEL.COD_CARGOBASICO%TYPE;

	FUNCTION PV_RECUPERA_CARGO_BSCO_ANT_FN    (EN_COD_CLIENTE      IN GA_ABOCEL.COD_CLIENTE%TYPE,
	 								 	       EN_NUM_ABONADO	   IN GA_ABOCEL.NUM_ABONADO%TYPE,
										       SV_PROC            OUT VARCHAR2,
				          	  	 	 	       SV_TABLA           OUT VARCHAR2,
				           	  	 	 	       SV_ACT     	      OUT VARCHAR2,
				           	  	 	 	       SV_SQLCODE         OUT VARCHAR2,
				           	  	 	 	       SV_SQLERRM         OUT VARCHAR2,
				           	  	 	 	       SV_ERROR           OUT VARCHAR2) RETURN GA_INTARCEL.COD_CARGOBASICO%TYPE;											 

    FUNCTION PV_RECUPERA_CARGO_BSCO_ACT_FN    (EN_COD_CLIENTE      IN GA_ABOCEL.COD_CLIENTE%TYPE,
	 								 	       EN_NUM_ABONADO	   IN GA_ABOCEL.NUM_ABONADO%TYPE,
										       SV_PROC            OUT VARCHAR2,
				          	  	 	 	       SV_TABLA           OUT VARCHAR2,
				           	  	 	 	       SV_ACT     	      OUT VARCHAR2,
				           	  	 	 	       SV_SQLCODE         OUT VARCHAR2,
				           	  	 	 	       SV_SQLERRM         OUT VARCHAR2,
				           	  	 	 	       SV_ERROR           OUT VARCHAR2) RETURN GA_INTARCEL.COD_CARGOBASICO%TYPE;			

	PROCEDURE PV_ESTADO_ANUL_PR               (EN_NUM_CELULAR      IN GA_ABOCEL.NUM_CELULAR%TYPE,
	  							   			   EN_NUM_OS	       IN CI_ORSERV.NUM_OS%TYPE,
   			   	  		    				   EV_USUARIO	   	  IN GE_SEG_USUARIO.NOM_USUARIO%TYPE,
						           			   SV_ESTADO 	      OUT VARCHAR2,
											   SV_MENS_ERROR	  OUT VARCHAR2,							
											   SV_ERROR        	  OUT VARCHAR2);


	FUNCTION PV_VALIDA_ANUL_SINIE_FN          (EN_NUM_CELULAR      IN  GA_ABOCEL.NUM_CELULAR%TYPE,
			 								   EN_NUM_OS	       IN  CI_ORSERV.NUM_OS%TYPE, 
			 								   SV_PROC            OUT VARCHAR2,
						          	  	 	   SV_TABLA           OUT VARCHAR2,
						           	  	 	   SV_ACT     	      OUT VARCHAR2,
						           	  	 	   SV_SQLCODE         OUT VARCHAR2,
						           	  	 	   SV_SQLERRM         OUT VARCHAR2,
						           	  	 	   SV_ERROR           OUT VARCHAR2) RETURN BOOLEAN;

	FUNCTION PV_RECUPERA_FECHA_ANUL_FN        (EN_NUM_ABONADO      IN  GA_ABOCEL.NUM_ABONADO%TYPE,
			 								   EN_NUM_OS	       IN  CI_ORSERV.NUM_OS%TYPE, 
			 								   SV_PROC            OUT VARCHAR2,
						          	  	 	   SV_TABLA           OUT VARCHAR2,
						           	  	 	   SV_ACT     	      OUT VARCHAR2,
						           	  	 	   SV_SQLCODE         OUT VARCHAR2,
						           	  	 	   SV_SQLERRM         OUT VARCHAR2,
						           	  	 	   SV_ERROR           OUT VARCHAR2) RETURN DATE;
								 								   										 									 								 								 										 										 							 										 								 										 										 
-- Fin especificacion PL/SQL
END PV_ANULA_SINIESTRO_PG;
/
SHOW ERRORS
