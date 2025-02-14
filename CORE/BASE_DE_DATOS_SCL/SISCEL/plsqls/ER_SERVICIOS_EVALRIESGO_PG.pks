CREATE OR REPLACE PACKAGE ER_servicios_evalriesgo_PG IS

	--------------------------------------------------------------------------------------------
	-- DECLARACION DE CONSTANTES
	--------------------------------------------------------------------------------------------

	CV_ERRORNOCLASIF  CONSTANT VARCHAR2(30) := 'Error no clasificado';
	CN_LARGOERRTEC    CONSTANT NUMBER       := 4000;
	CN_LARGODESC      CONSTANT NUMBER       := 2000;
	CV_MODULO_GA      CONSTANT VARCHAR2(2)  := 'GA';
	CV_PLANINDIVIDUAL CONSTANT VARCHAR2(1)  := 'I';
	CV_PLANEMPRESA    CONSTANT VARCHAR2(1)  := 'E';
	CV_PLANFAMILIA    CONSTANT VARCHAR2(1)  := 'F';
	CN_INDFAMILIA     CONSTANT NUMBER       := 1;
	CN_SINEXCEPCION   CONSTANT NUMBER       := -1; -- sin excepcion
	CN_TODOSPLANES	  CONSTANT NUMBER       := 0;  -- todos los planes
	CN_PLANESCOMER	  CONSTANT NUMBER       := 1;  -- planes comercializables
	CN_TODOSNOCOMER	  CONSTANT NUMBER       := 2;  -- planes no comercializables
	CN_PRODUCTO		  CONSTANT NUMBER       := 1;  -- producto

	CV_ESTSOLAPROBPORSIST CONSTANT NUMBER := 1; -- solicitud aprobada por sistema
	CV_ESTSOLAPROBPORUSUA CONSTANT NUMBER := 2; -- solicitud aprobada por usuario
	CV_ESTSOLENVENTA      CONSTANT NUMBER := 3; -- solicitud en venta

	--------------------------------------------------------------------------------------------
	-- DECLARACION DE TIPOS
	--------------------------------------------------------------------------------------------
	TYPE refcursor IS REF CURSOR;

	--------------------------------------------------------------------------------------------
	-- DECLARACION DE VARIABLES
	--------------------------------------------------------------------------------------------

	--------------------------------------------------------------------------------------------
	-- DECLARACION DE FUNCIONES
	--------------------------------------------------------------------------------------------

	--------------------------------------------------------------------------------------------
	-- DECLARACION DE PROCEDIMIENTOS
	--------------------------------------------------------------------------------------------

	PROCEDURE ER_getRegEvaluacionRiesgo_PR(
	                               EV_numIdent     IN  ert_solicitud_campos.num_ident%TYPE,
									       SV_nomCliente   OUT NOCOPY ert_solicitud_campos.nombre_cliente%TYPE,
									       SV_desNombre    OUT NOCOPY ert_solicitud_campos.des_nombre%TYPE,
									       SV_priApellido  OUT NOCOPY ert_solicitud_campos.primer_apellido%TYPE,
									       SV_segApellido  OUT NOCOPY ert_solicitud_campos.segundo_apellido%TYPE,
									       SV_codTipIdent  OUT NOCOPY ert_solicitud_campos.cod_tipident%TYPE,
										    SN_numSolicitud OUT NOCOPY ert_solicitud_campos.num_solicitud%TYPE,
								 	       SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
	                               SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
	                               SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

	PROCEDURE ER_getListPlanTarifAutoriz_PR(
	                                        EN_numSolicitud IN  ert_solicitud_planes.num_solicitud%TYPE,
	                                        SC_cursorDatos  OUT NOCOPY REFCURSOR,
								 	                SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
	                                        SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
	                                        SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

	PROCEDURE ER_getExcepcion_PR(
	                      EV_numIdent     IN  erd_excepcion.num_ident%TYPE,
							    EV_codTipIdent  IN  erd_excepcion.cod_tipident%TYPE,
								 SN_codRestricc  OUT NOCOPY erd_excepcion.cod_restric%TYPE,
								 SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
	                      SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
	                      SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);


	PROCEDURE ER_getListPlanTarif_PR(EV_codTipIdentif IN VARCHAR2,
	                                 EV_numIdentif    IN VARCHAR2,
												EV_indTipoSolicitud IN ert_solicitud.ind_tipo_solicitud%TYPE, -- DEBE SER 1
									         SC_cursorDatos   OUT NOCOPY REFCURSOR,
								 	         SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
	                       		      SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
	                       		      SN_numEvento     OUT NOCOPY ge_errores_pg.Evento);

  ---------------------------------------------------------------------------------------------------
--  PL duplicado por PosVenta MIX-06003_G2PV
	PROCEDURE ER_getListPlanTarifTipo_PR(EV_codTipIdentif IN VARCHAR2,
	                                     EV_numIdentif    IN VARCHAR2,
									     EV_tipoPlan      IN VARCHAR2,
										 EV_SelTipo		  IN VARCHAR2,
									     SC_cursorDatos   OUT NOCOPY REFCURSOR,
								 	     SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
	                       		         SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
	                       		         SN_numEvento     OUT NOCOPY ge_errores_pg.Evento);
  ---------------------------------------------------------------------------------------------------

	PROCEDURE ER_getEvRiesgoVigente_PR(
	                                   EV_codTipIdentif IN VARCHAR2,
	                                   EV_numIdentif    IN VARCHAR2,
												  EV_indTipoSolicitud IN ert_solicitud.ind_tipo_solicitud%TYPE, -- DEBE SER 1
	                                   SN_numSolicitud  OUT NOCOPY ert_solicitud.num_solicitud%TYPE,
												  SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
	                       		        SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
	                       		        SN_numEvento     OUT NOCOPY ge_errores_pg.Evento
												 );

	PROCEDURE ER_getListPlanTarifTipo_PR(EV_codTipIdentif IN VARCHAR2,
	                                     EV_numIdentif    IN VARCHAR2,
									     EV_tipoPlan      IN VARCHAR2,
									     SC_cursorDatos   OUT NOCOPY REFCURSOR,
								 	     SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
	                       		         SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
	                       		         SN_numEvento     OUT NOCOPY ge_errores_pg.Evento);

	--------------------------------------------------------------------------------------------
	--* INSERTS y UPDATES
	--------------------------------------------------------------------------------------------

	PROCEDURE VE_insSolicitudVenta_PR(EV_numSolicitud  IN  VARCHAR2,
			  						  EV_numVenta      IN  VARCHAR2,
							          SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
	                       	          SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
	                                  SN_numEvento     OUT NOCOPY ge_errores_pg.Evento);

	PROCEDURE VE_updSolicPlanes_TermVend_PR(EV_numSolicitud  IN  VARCHAR2,
 			  							    EV_cod_plantarif IN  VARCHAR2,
								            EV_cantidad      IN  VARCHAR2,
							                SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
	                       	                SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
	                                        SN_numEvento     OUT NOCOPY ge_errores_pg.Evento);



	PROCEDURE VE_insExcepcion_PR           (EV_CODCLIENTE  IN  GE_CLIENTES.COD_CLIENTE%TYPE,
											EV_INSERT    OUT VARCHAR2,
							                SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
	                       	                SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
	                                        SN_numEvento     OUT NOCOPY ge_errores_pg.Evento);

   PROCEDURE VE_delExcepcion_PR            (EV_CODCLIENTE  IN  GE_CLIENTES.COD_CLIENTE%TYPE,
											EV_INSERT    IN VARCHAR2,
											SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
	                       	                SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
	                                        SN_numEvento     OUT NOCOPY ge_errores_pg.Evento);

END ER_servicios_evalriesgo_PG;
/
SHOW ERRORS
