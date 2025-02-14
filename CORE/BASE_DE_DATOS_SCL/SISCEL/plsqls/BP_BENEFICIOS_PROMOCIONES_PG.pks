CREATE OR REPLACE PACKAGE BP_BENEFICIOS_PROMOCIONES_PG
IS
 -- Version
 	CV_version     CONSTANT VARCHAR(10):= '1';
	CV_subversion  CONSTANT VARCHAR(10):= '1';
	CV_Fecha	   CONSTANT VARCHAR(20):= '12-04-2010';
	CV_programador CONSTANT VARCHAR(20):= 'Jorge Marín';
 -- Declaración de estructuras tipo tablas dinamicas.
   TYPE TIP_ENLACE_HIST 		 	  IS RECORD    (FA_DETCELULAR   FA_ENLACEHIST.FA_DETCELULAR%TYPE);
   TYPE TIP_ENLACE_HIST_LIST	      IS TABLE OF  TIP_ENLACE_HIST  INDEX BY PLS_INTEGER;


   TYPE TIP_BP_CABECERA_BENEFICIOS_TD IS TABLE OF  BP_CABECERA_BENEFICIOS_TD%ROWTYPE 	  	 INDEX BY PLS_INTEGER;
   TYPE TIP_BP_BENEFICIOS_APLICAR_TO  IS TABLE OF  BP_BENEFICIOS_APLICAR_TO%ROWTYPE 		 INDEX BY PLS_INTEGER;
   TYPE TIP_BPT_BENEFICIOS	 		  IS TABLE OF  BPT_BENEFICIOS%ROWTYPE 	 				 INDEX BY PLS_INTEGER;
   TYPE TIP_GAT_PLANDESCABO	 		  IS TABLE OF  GAT_PLANDESCABO%ROWTYPE 	 				 INDEX BY PLS_INTEGER;
   TYPE TIP_TOL_CLIEDCTO_TO           IS TABLE OF  TOL_CLIEDCTO_TO%ROWTYPE 	 			     INDEX BY PLS_INTEGER;
   TYPE TIP_TOL_DETABONDCTO_TD        IS TABLE OF  TOL_DETABONDCTO_TD%ROWTYPE 	 		     INDEX BY PLS_INTEGER;

-- Declaración de constantes.
   CV_benef_apli 		   CONSTANT VARCHAR2 (50) := 'BP_BENEFICIOS_APLICAR_TO';
   CV_exclu_s 	  		   CONSTANT VARCHAR  (1)  := 'S';
   CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
   CV_cod_modulo 	   	   CONSTANT VARCHAR2 (2)  := 'BP';
   CV_cod_producto    	   CONSTANT VARCHAR2 (1)  := '1';
   CV_cod_estadoOK    	   CONSTANT VARCHAR2 (2)  := 'OK';
	CV_vigente			   CONSTANT	VARCHAR  (1)  := 'V';   -- Estado Vigente del beneficiario
	CV_terminado		   CONSTANT	VARCHAR  (1)  := 'T';   -- Estado Terminado del beneficiario
    CV_epr				   CONSTANT VARCHAR2 (3)  := 'EPR'; -- Tipo de estado En proceso BPT_BENEFICIOS
    CV_eje				   CONSTANT VARCHAR2 (3)  := 'EJE'; -- Tipo de estado Ejecutado BPT_BENEFICIOS
    CV_exc				   CONSTANT VARCHAR2 (3)  := 'EXC'; -- Tipo de estado Excluido BPT_BENEFICIOS
	CV_err				   CONSTANT VARCHAR2 (3)  := 'ERR';	-- Tipo de estado Error BPT_BENEFICIOS
	CV_tip_nml		   	   CONSTANT VARCHAR2 (3)  := 'N';   -- Tipo de Proceso Normal
	CV_tip_sim			   CONSTANT VARCHAR2 (3)  := 'P';   -- Tipo de Proceso  Simulación de Facturación
    CN_uno				   CONSTANT	NUMBER	 	  :=  1;    -- Valor 1
	CN_cero				   CONSTANT	NUMBER	 	  :=  0;    -- Valor 0
	CN_abo_sexist		   CONSTANT	NUMBER	 	  :=  0;    -- Cliente/Abonado con Beneficios Aplicados
	CN_abo_nexist		   CONSTANT	NUMBER	 	  :=  1;    -- Cliente/Abonado sin Beneficios Aplicados
	CN_cli_sexist		   CONSTANT	NUMBER	 	  :=  2;    -- Cliente con Beneficios Aplicados
	CN_cli_nexist		   CONSTANT	NUMBER	 	  :=  3;    -- Cliente sin Beneficios Aplicados
	CN_cod_producto		   CONSTANT	NUMBER	 	  :=  1;    -- Tipo de producto celular
	CN_num_proceso		   CONSTANT	NUMBER	 	  :=  0;    -- número proceso fa_ciclocl1
	CN_ind_mascara		   CONSTANT	NUMBER	 	  :=  1;    -- indicador de mascara fa_ciclocl1
	CV_beneficio_ML	       CONSTANT VARCHAR2 (2)  := 'ML';  -- Tipo de Beneficio DF
	CN_numabonado		   CONSTANT NUMBER	 	  :=  -1;	-- Número de abonado generico cuando el plan de ByP es orientado al Cliente
	CV_tip_clie			   CONSTANT VARCHAR2 (1)  := 'C';	-- Tipo de entidad del plan Cliente
	CV_tip_bols			   CONSTANT VARCHAR2 (1)  := 'B';	-- Tipo de entidad del plan Bolsa
	CV_batch_habilitado    CONSTANT VARCHAR2 (1)  := 'H';   -- Proceso habilitado en la cola de procesos de  cobranza co_colasproc
	CV_proceso_wait    	   CONSTANT VARCHAR2 (1)  := 'W';   -- Proceso en espera de ejecución (co_colasproc)
	CV_proceso_running 	   CONSTANT VARCHAR2 (1)  := 'R';   -- Proceso en ejecución (co_colasproc)

/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION  BP_VERSION_FN RETURN VARCHAR2;
/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION BP_VALIDA_COLA_CO_PG (EV_NOM_PROCESO IN VARCHAR2,
                               SN_COD_ERROR     OUT NOCOPY NUMBER,
                               SV_MENS_RETORNO  OUT NOCOPY VARCHAR2
) RETURN NUMBER;
/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION BP_ACTUALIZA_COLA_CO_FN (EV_NOM_PROCESO     IN VARCHAR2,
		 						  EV_COD_ESTADO_INI	 IN VARCHAR2,
								  EV_COD_ESTADO_FIN	 IN VARCHAR2,
	                              SN_COD_ERROR 	     OUT NOCOPY NUMBER,
                               	  SV_MENS_RETORNO    OUT NOCOPY VARCHAR2)

 RETURN BOOLEAN;
 /*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION BP_REC_SECUENCIA_FN (EV_NOM_SECUENCIA IN     VARCHAR2) RETURN NUMBER;
/*---------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE BP_GENERAR_CABECERA_PR (EM_CABECERA             IN TIP_BP_CABECERA_BENEFICIOS_TD,
                                  SV_MENS_RETORNO 		 OUT NOCOPY VARCHAR2,
                                  SN_NUM_EVENTO 		 OUT NOCOPY NUMBER );
/*---------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE BP_ACT_ESTADO_CABECERA_PR (EM_CABECERA          IN TIP_BP_CABECERA_BENEFICIOS_TD,
                                  	 SV_MENS_RETORNO 	 OUT NOCOPY VARCHAR2,
                                  	 SN_NUM_EVENTO 		 OUT NOCOPY NUMBER );
/*---------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE BP_SEGMENTACION_ML_PR (EN_IDE_PROCESO	  IN  NUMBER,
								 SN_TOTAL_SEG	  OUT NUMBER,
                             	 SV_MENS_RETORNO  OUT NOCOPY VARCHAR2,
							 	 SN_NUM_EVENTO 		 OUT NOCOPY NUMBER);
/*---------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE BP_REG_BENEFICIOS_PR (EN_IDE_PROCESO	  IN NUMBER,
                                SV_MENS_RETORNO  OUT NOCOPY VARCHAR2,
                                SN_NUM_EVENTO 	 OUT NOCOPY NUMBER );
/*---------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE BP_VALIDA_EXCLUCION_PR (EN_IDE_PROCESO          IN NUMBER,
		  						  SN_TOT_EXC			 OUT NUMBER,
                                  SV_MENS_RETORNO 		 OUT NOCOPY VARCHAR2,
                                  SN_NUM_EVENTO 		 OUT NOCOPY NUMBER );
/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION BP_REC_CABECERA_FN (EM_TABLA         IN OUT  TIP_BP_CABECERA_BENEFICIOS_TD,
                             SN_COD_ERROR 	  OUT NOCOPY NUMBER,
                             SV_MENS_RETORNO  OUT NOCOPY VARCHAR2,
							 SV_SQL		   	  OUT NOCOPY VARCHAR2
) RETURN BOOLEAN;
/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION BP_REG_TOL_DETABONDCTO_FN (EM_TABLA         IN  TIP_TOL_DETABONDCTO_TD,
                                    EN_INDICE        IN  NUMBER,
                                    SN_COD_ERROR 	 OUT NOCOPY NUMBER,
                                    SV_MENS_RETORNO  OUT NOCOPY VARCHAR2,
							        SV_SQL		   	 OUT NOCOPY VARCHAR2
) RETURN BOOLEAN;
/*---------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE BP_SEGMENTA_FRNHH_ML_PR (EN_IDE_PROCESO	 IN NUMBER,
								   SN_TOTAL_SEG	    OUT NUMBER,
                             	   SV_MENS_RETORNO  OUT NOCOPY VARCHAR2,
							 	   SN_NUM_EVENTO    OUT NOCOPY NUMBER);
/*---------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE BP_REG_BENEFICIOS_FRNHH_PR (EN_IDE_PROCESO	IN NUMBER,
                                      SV_MENS_RETORNO  OUT NOCOPY VARCHAR2,
                                      SN_NUM_EVENTO    OUT NOCOPY NUMBER );
/*---------------------------------------------------------------------------------------------------------------------------------*/                                   
END BP_BENEFICIOS_PROMOCIONES_PG;
/
SHOW ERRORS