CREATE OR REPLACE PACKAGE PV_GESTOR_CORP_PG IS
PROCEDURE pv_bvalCorporativo	(splan_tarifario_act 	    IN  	VARCHAR2,
                                 splan_tarifario_nue 		IN  	VARCHAR2,
								 scod_actabo_gestor  		IN  	VARCHAR2,
                                 snum_abonado        		IN  	VARCHAR2,
				 				 sactabo_ooss           	IN  	VARCHAR2,
				 				 var_abonado_gestor     	IN  	VARCHAR2,
				 				 var_abonado_gestor_def 	IN  	VARCHAR2,
								 var_abonado_gestor_OUT     OUT     VARCHAR2,
				 			     var_abonado_gestor_def_OUT OUT     VARCHAR2,
				 			 	 scod_servicio				OUT     VARCHAR2,
				 				 scod_servsupl 				OUT	    VARCHAR2,
				 				 scod_nivel 				OUT     VARCHAR2,
								 pvCodValor          		OUT     VARCHAR2,
                                 pvErrorAplic        		OUT     VARCHAR2,
                                 pvErrorGlosa        		OUT     VARCHAR2,
                                 pvErrorOra          		OUT     VARCHAR2,
                                 pvErrorOraGlosa     		OUT     VARCHAR2,
                                 pvTrace             		OUT     VARCHAR2);


PROCEDURE  pv_bActDesSS_CORP(    snum_abonado        	IN  	VARCHAR2,
		   		 				 stip_movimiento        IN  	VARCHAR2,
				 				 scod_servicio			IN      VARCHAR2,
				 				 scod_servsupl 			IN 	    VARCHAR2,
				 				 scod_nivel 			IN      VARCHAR2,
				 				 sCadCambios_CORP       OUT	    VARCHAR2,
				 				 pvCodValor				OUT	    VARCHAR2,
				 				 pvErrorAplic			OUT	    VARCHAR2,
				 				 pvErrorGlosa			OUT	    VARCHAR2  ,
				 				 pvErrorOra				OUT	    VARCHAR2,
				 				 pvErrorOraGlosa		OUT	    VARCHAR2,
				 				 pvTrace				OUT	    VARCHAR2);

PROCEDURE pv_bCorporativo(        snum_abonado          	IN  	VARCHAR2,
                                 scod_actabo_gestor  		IN  	VARCHAR2,
                                 snom_usuarora       		IN  	VARCHAR2,
                                 splan_tarifario_act 		IN  	VARCHAR2,
                                 splan_tarifario_nue 		IN  	VARCHAR2,
                                 stip_movimiento        	IN  	VARCHAR2,
				                 sactabo_ooss           	IN  	VARCHAR2,
				                 var_abonado_gestor     	IN      VARCHAR2,
				                 var_abonado_gestor_def 	IN      VARCHAR2,
				                 sNum_SeqTransacabo			IN 		VARCHAR2,
				                 bgenera_comando	    	OUT     VARCHAR2,
								 var_abonado_gestor_OUT     OUT     VARCHAR2,
				 			     var_abonado_gestor_def_OUT OUT     VARCHAR2,
				                 pvCodValor          		OUT     VARCHAR2,
                                 pvErrorAplic        		OUT     VARCHAR2,
                                 pvErrorGlosa        		OUT     VARCHAR2,
                                 pvErrorOra          		OUT     VARCHAR2,
                                 pvErrorOraGlosa     		OUT     VARCHAR2,
                                 pvTrace             		OUT     VARCHAR2);

FUNCTION pv_bValidaNormalTotal      (plantarnortot          IN      VARCHAR2) RETURN VARCHAR2;

END PV_GESTOR_CORP_PG;
/
SHOW ERRORS
