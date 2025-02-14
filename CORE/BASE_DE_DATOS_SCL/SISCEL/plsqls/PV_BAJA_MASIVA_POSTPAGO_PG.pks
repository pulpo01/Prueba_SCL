CREATE OR REPLACE PACKAGE PV_BAJA_MASIVA_POSTPAGO_PG  IS

--PV_BAJA_MASIVA_POSTPAGO_PG V1.0 COL-63261(MA)|11-06-2008|GEZ creacion de package por MA

	PROCEDURE PV_INICIALIZA_PROCESO_PR( LSEstado	  	  OUT	number,
									  	LSDescProceso	  OUT	pv_baja_masiva_to.desc_err%TYPE,
								  	  	LSTabla	  	  	  OUT	pv_baja_masiva_to.nom_tabla%TYPE,
								  	  	LSAccion	  	  OUT	pv_baja_masiva_to.cod_act%TYPE,
									  	LSCodOra		  OUT	pv_baja_masiva_to.cod_sqlcode%TYPE,
								  	  	LSErrOra		  OUT	pv_baja_masiva_to.cod_sqlerrm%TYPE);

	PROCEDURE PV_HISTORICO_PR(  LSEstado	  	  OUT	number,
								LSDescProceso	  OUT	pv_baja_masiva_to.desc_err%TYPE,
								LSCodOra		  OUT	pv_baja_masiva_to.cod_sqlcode%TYPE,
								LSErrOra		  OUT	pv_baja_masiva_to.cod_sqlerrm%TYPE);

	PROCEDURE PV_ACTUALIZA_ESTADO_PR( LENumCelular 	  IN	pv_baja_masiva_to.num_celular%TYPE,
			  					  	  LEIdProseso	  IN	pv_baja_masiva_to.id_proceso%TYPE,
   			 					  	  LEEstadoIni	  IN	pv_baja_masiva_to.cod_estado%TYPE,
									  LEEstadoFin	  IN	pv_baja_masiva_to.cod_estado%TYPE,
									  LSEstado	  	  OUT	number,
									  LSDescProceso	  OUT	pv_baja_masiva_to.desc_err%TYPE,
								  	  LSTabla	  	  OUT	pv_baja_masiva_to.nom_tabla%TYPE,
								  	  LSAccion	  	  OUT	pv_baja_masiva_to.cod_act%TYPE,
									  LSCodOra		  OUT	pv_baja_masiva_to.cod_sqlcode%TYPE,
								  	  LSErrOra		  OUT	pv_baja_masiva_to.cod_sqlerrm%TYPE);

	PROCEDURE PV_ACTUALIZA_PROCESO_PR( LENumCelular   IN	pv_baja_masiva_to.num_celular%TYPE,
			  					  	   LEIdProseso	  IN	pv_baja_masiva_to.id_proceso%TYPE,
   			 					  	   LEEstadoIni	  IN	pv_baja_masiva_to.cod_estado%TYPE,
									   LEEstadoFin	  IN	pv_baja_masiva_to.cod_estado%TYPE,
									   LENumOS		  IN	pv_iorserv.num_os%TYPE,
									   LEDescProceso  IN	pv_baja_masiva_to.desc_err%TYPE,
								  	   LETabla	  	  IN	pv_baja_masiva_to.nom_tabla%TYPE,
								  	   LEAccion	  	  IN	pv_baja_masiva_to.cod_act%TYPE,
									   LECodOra		  IN	pv_baja_masiva_to.cod_sqlcode%TYPE,
								  	   LEErrOra		  IN	pv_baja_masiva_to.cod_sqlerrm%TYPE);

	PROCEDURE PV_VALIDA_LINEA_PR( LENumCelular 	  IN	pv_baja_masiva_to.num_celular%TYPE,
			  					  LEIdProseso	  IN	pv_baja_masiva_to.id_proceso%TYPE,
   			 					  LSEstado	  	  OUT	number,
								  LSNumOs		  OUT	pv_baja_masiva_to.num_os%TYPE,
								  LSDescProceso	  OUT	pv_baja_masiva_to.desc_err%TYPE,
								  LSTabla	  	  OUT	pv_baja_masiva_to.nom_tabla%TYPE,
								  LSAccion	  	  OUT	pv_baja_masiva_to.cod_act%TYPE,
								  LSCodOra		  OUT	pv_baja_masiva_to.cod_sqlcode%TYPE,
								  LSErrOra		  OUT	pv_baja_masiva_to.cod_sqlerrm%TYPE);

END PV_BAJA_MASIVA_POSTPAGO_PG;
/
SHOW ERRORS
