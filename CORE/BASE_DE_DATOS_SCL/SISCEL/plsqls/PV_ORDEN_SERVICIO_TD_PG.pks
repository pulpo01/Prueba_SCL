CREATE OR REPLACE PACKAGE PV_ORDEN_SERVICIO_TD_PG IS

	CV_error_no_clasif   CONSTANT VARCHAR2(30) := 'Error no clasificado';
	cn_largoerrtec       CONSTANT NUMBER        := 4000;
	cn_largodesc         CONSTANT NUMBER        := 2000;
	cv_cod_modulo        CONSTANT VARCHAR2 (2)  := 'PV';
	TYPE refcursor 	  	 IS REF CURSOR;

	PROCEDURE PV_INS_ENC_PROC_OOSS_PR( EO_PV_ORDEN_SERVICIO IN PV_ORDEN_DE_SERVICIO_QT,
                                       EO_PARAMETRO_DTO     IN BLOB,
									   SN_NUM_PROC_OS		OUT NOCOPY PV_ORDEN_DE_SERVICIO_TD.NUM_PROCESO%TYPE,
 						               SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
	                  		           SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
	                         	       SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE PV_INS_DET_PROC_OOSS_PR( EO_PV_DETALLE_OS     IN PV_DETALLE_OS_QT,
 						               SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
	                  		           SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
	                         	       SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);


    PROCEDURE PV_ACT_ESTADO_PROC_OOSS_PR(EO_PV_ORDEN_SERVICIO IN PV_ORDEN_DE_SERVICIO_QT,
 						                 SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
	                  		             SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
	                         	         SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE PV_ACT_OBJETO_PROC_OOSS_PR(EO_PV_ORDEN_SERVICIO IN  PV_ORDEN_DE_SERVICIO_QT,
			  						 	 EO_PARAMETRO_DTO     IN BLOB,
	                                     SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
	                  		             SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
	                         	         SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);


    PROCEDURE PV_CON_ESTADO_PROC_OOSS_PR(EO_PV_ORDEN_SERVICIO IN  PV_ORDEN_DE_SERVICIO_QT,
	                                     SV_estado            OUT NOCOPY pv_orden_de_servicio_td.estado%TYPE,
			  						 	 SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
	                  		             SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
	                         	         SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE PV_ACT_ESTADO_DET_OOSS_PR( EO_PV_DETALLE_OS IN  PV_DETALLE_OS_QT,
			  						 	 SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
	                  		             SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
	                         	         SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE PV_CON_ESTADO_DET_OOSS_PR( EO_PV_DETALLE_OS IN  PV_DETALLE_OS_QT,
			  							 SO_ESTADO			  OUT NOCOPY refcursor,
			  						 	 SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
	                  		             SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
	                         	         SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);

END PV_ORDEN_SERVICIO_TD_PG;
/
SHOW ERRORS
