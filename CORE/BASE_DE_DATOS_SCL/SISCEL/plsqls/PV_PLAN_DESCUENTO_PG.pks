CREATE OR REPLACE PACKAGE PV_PLAN_DESCUENTO_PG
IS

   TYPE refCursor IS REF CURSOR;
   CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
   CV_cod_modulo           CONSTANT VARCHAR2 (02) := 'GA';
   CV_programa			   CONSTANT VARCHAR2 (03) := 'GPA';
   CV_version              CONSTANT VARCHAR2 (02) := '1';
   CN_cero				   CONSTANT NUMBER        := 0;
   CN_uno				   CONSTANT NUMBER        := 1;
   CN_producto			   CONSTANT NUMBER        := 1;
   CN_tip_relacion		   CONSTANT NUMBER   (01) := 3;
   CN_ind_estado		   CONSTANT NUMBER   (01) := 3;
   CN_hibrido			   CONSTANT NUMBER   (01) := 3;
   CN_pospago			   CONSTANT NUMBER   (01) := 2;
   CN_cod_nivel			   CONSTANT NUMBER   (01) := 0;

----------------------------------------------------------------------------------------------------------
--1.- Metodo : crearSolicitud
	PROCEDURE PV_CREAR_SOLICITUD_PR (EO_SOLICITUD	    IN 	 		 PV_SOLICITUD_QT,
									SN_cod_retorno   	OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
									SV_mens_retorno  	OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
									SN_num_evento       OUT NOCOPY	 ge_errores_pg.evento);

----------------------------------------------------------------------------------------------------------
--2.- Metodo : consultarEstadoSolicitud
	PROCEDURE PV_CONSULTAR_EST_SOLICITUD_PR (EO_SOLICITUD	    IN OUT	 		 PV_SOLICITUD_QT,
											SN_cod_retorno   	OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
											SV_mens_retorno  	OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
											SN_num_evento       OUT NOCOPY	 ge_errores_pg.evento);

----------------------------------------------------------------------------------------------------------
--1.- Metodo : eliminarSolicitud
PROCEDURE PV_ELIMINAR_SOLICITUD_PR (EO_SOLICITUD	    IN 		     PV_SOLICITUD_QT,
										SN_cod_retorno   	OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
										SV_mens_retorno  	OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
										SN_num_evento       OUT NOCOPY	 ge_errores_pg.evento);

----------------------------------------------------------------------------------------------------------
END PV_PLAN_DESCUENTO_PG;
/
SHOW ERRORS
