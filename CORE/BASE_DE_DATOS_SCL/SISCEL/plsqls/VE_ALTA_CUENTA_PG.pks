CREATE OR REPLACE PACKAGE VE_alta_cuenta_PG IS

	-----------------------------
	-- DECLARACION DE CONSTANTES
	-----------------------------

	-- RECOMPILACION

	CV_PRODUCTO      CONSTANT VARCHAR2(1)  := '1';
	CV_MODULO_GA     CONSTANT VARCHAR2(2)  := 'GA';
	CV_MODULO_GE     CONSTANT VARCHAR2(2)  := 'GE';
	CV_ERRORNOCLASIF CONSTANT VARCHAR2(30) := 'Error no clasificado';

	CN_LARGOERRTEC   CONSTANT NUMBER := 4000;
	CN_LARGODESC     CONSTANT NUMBER := 2000;
	CV_FORMATOFECHA  CONSTANT VARCHAR2(10) := 'DD/MM/YYYY';

	-- nombre de parametros
	CV_NOMPAR_FORMATOSEL2 CONSTANT VARCHAR2(12) := 'FORMATO_SEL2';
	CV_NOMPAR_FORMATOSEL7 CONSTANT VARCHAR2(12) := 'FORMATO_SEL7';

	------------------------
	-- DECLARACION DE TIPOS
	------------------------
	TYPE refcursor IS REF CURSOR;

	----------------------------
	-- DECLARACION DE VARIABLES
	----------------------------

	----------------------------
	-- DECLARACION DE FUNCIONES
	----------------------------

	---------------------------------
	-- DECLARACION DE PROCEDIMIENTOS
	---------------------------------
	PROCEDURE VE_getCuenta_PR(EV_codCuenta    IN  VARCHAR2,
	                          SV_desCuenta    OUT NOCOPY VARCHAR2,
				              SV_tipCuenta    OUT NOCOPY VARCHAR2,
				   			  SV_responsable  OUT NOCOPY VARCHAR2,
				   			  SV_codTipident  OUT NOCOPY VARCHAR2,
				   			  SV_numIdent     OUT NOCOPY VARCHAR2,
				   			  SV_codDirec     OUT NOCOPY VARCHAR2,
				   			  SV_fecAlta      OUT NOCOPY VARCHAR2,
				   			  SV_indEstado    OUT NOCOPY VARCHAR2,
				   			  SV_TelContacto  OUT NOCOPY VARCHAR2,
				   			  SV_indSector    OUT NOCOPY VARCHAR2,
				   			  SV_clasCta      OUT NOCOPY VARCHAR2,
				   			  SV_codCatribut  OUT NOCOPY VARCHAR2,
				   			  SV_codCategoria OUT NOCOPY VARCHAR2,
				   			  SV_codSector    OUT NOCOPY VARCHAR2,
				   			  SV_codSubCat    OUT NOCOPY VARCHAR2,
				   			  SV_indMultuso   OUT NOCOPY VARCHAR2,
				   			  SV_cliPotencial OUT NOCOPY VARCHAR2,
				   			  SV_razonSocial  OUT NOCOPY VARCHAR2,
				   			  SV_fecInVPac    OUT NOCOPY VARCHAR2,
				   			  SV_tipComis     OUT NOCOPY VARCHAR2,
				   			  SV_usuarAsesor  OUT NOCOPY VARCHAR2,
				   			  SV_fecNac       OUT NOCOPY VARCHAR2,
				   			  SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
	                       	  SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
	                          SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

	PROCEDURE VE_getCuentaIdentif_PR(EV_codTipident  IN  VARCHAR2,
				   			  		 EV_numIdent     IN  VARCHAR2,
									 SV_codCuenta    OUT NOCOPY VARCHAR2,
	                                 SV_desCuenta    OUT NOCOPY VARCHAR2,
				              		 SV_tipCuenta    OUT NOCOPY VARCHAR2,
				   			  		 SV_responsable  OUT NOCOPY VARCHAR2,
				   			  		 SV_codDirec     OUT NOCOPY VARCHAR2,
				   			  		 SV_fecAlta      OUT NOCOPY VARCHAR2,
				   			  		 SV_indEstado    OUT NOCOPY VARCHAR2,
				   			  		 SV_TelContacto  OUT NOCOPY VARCHAR2,
				   			  		 SV_indSector    OUT NOCOPY VARCHAR2,
				   			  		 SV_clasCta      OUT NOCOPY VARCHAR2,
				   			  		 SV_codCatribut  OUT NOCOPY VARCHAR2,
				   			  		 SV_codCategoria OUT NOCOPY VARCHAR2,
				   			  		 SV_codSector    OUT NOCOPY VARCHAR2,
				   			  		 SV_codSubCat    OUT NOCOPY VARCHAR2,
				   			  		 SV_indMultuso   OUT NOCOPY VARCHAR2,
				   			  		 SV_cliPotencial OUT NOCOPY VARCHAR2,
				   			  		 SV_razonSocial  OUT NOCOPY VARCHAR2,
				   			  		 SV_fecInVPac    OUT NOCOPY VARCHAR2,
				   			  		 SV_tipComis     OUT NOCOPY VARCHAR2,
				   			  		 SV_usuarAsesor  OUT NOCOPY VARCHAR2,
				   			  		 SV_fecNac       OUT NOCOPY VARCHAR2,
				   			  		 SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
	                       	  		 SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
	                          		 SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);
	--------------------------------------------------------------------------------------------
	--* CURSORES - LISTAS
	--------------------------------------------------------------------------------------------

	PROCEDURE VE_getListClasifCuenta_PR(SC_cursorDatos  OUT NOCOPY REFCURSOR,
								        SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
	                       		        SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
	                       		        SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

	PROCEDURE VE_getListCuentas_PR(EV_criterioBusq IN VARCHAR2,
	                               EV_filtro       IN VARCHAR2,
								   EV_valorBusq    IN VARCHAR2,
								   EV_tipoIdentif  IN VARCHAR2,
	                               SC_cursorDatos  OUT NOCOPY REFCURSOR,
								   SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
	                       		   SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
	                       		   SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

	--------------------------------------------------------------------------------------------
	--* INSERTS y UPDATES
	--------------------------------------------------------------------------------------------

	PROCEDURE VE_insCuenta_PR(EV_codCuenta    IN  VARCHAR2,
	                          EV_desCuenta    IN  VARCHAR2,
				              EV_tipCuenta    IN  VARCHAR2,
				   			  EV_responsable  IN  VARCHAR2,
				   			  EV_codTipident  IN  VARCHAR2,
				   			  EV_numIdent     IN  VARCHAR2,
				   			  EV_codDirec     IN  VARCHAR2,
				   			  EV_indEstado    IN  VARCHAR2,
				   			  EV_TelContacto  IN  VARCHAR2,
				   			  EV_indSector    IN  VARCHAR2,
				   			  EV_clasCta      IN  VARCHAR2,
				   			  EV_codCatribut  IN  VARCHAR2,
				   			  EV_codCategoria IN  VARCHAR2,
				   			  EV_codSector    IN  VARCHAR2,
				   			  EV_codSubCat    IN  VARCHAR2,
				   			  EV_indMultuso   IN  VARCHAR2,
				   			  EV_cliPotencial IN  VARCHAR2,
				   			  EV_razonSocial  IN  VARCHAR2,
				   			  EV_fecInVPac    IN  VARCHAR2,
				   			  EV_tipComis     IN  VARCHAR2,
				   			  EV_usuarAsesor  IN  VARCHAR2,
				   			  EV_fecNac       IN  VARCHAR2,
				   			  SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
	                       	  SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
	                          SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

	PROCEDURE VE_insSubCuenta_PR(EV_codCuenta    IN  VARCHAR2,
	                             EV_codSubCuenta IN  VARCHAR2,
	                             EV_desSubCuenta IN  VARCHAR2,
				   			     EV_codDirec     IN  VARCHAR2,
				   			     SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
	                       	     SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
	                             SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

	PROCEDURE VE_updCategCuenta_PR(EV_codCuenta     IN  VARCHAR2,
								   EV_codCategoria  IN  VARCHAR2,
								   EV_codSubCateg   IN  VARCHAR2,
								   EV_codMultUso    IN  VARCHAR2,
								   EV_codCliePot    IN  VARCHAR2,
							  	   EV_desRazon      IN  VARCHAR2,
							       SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
	                       	       SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
	                               SN_numEvento     OUT NOCOPY ge_errores_pg.Evento);
	--------------------------------------------------------------------------------------------
	--* DELETEs
	--------------------------------------------------------------------------------------------

	PROCEDURE VE_delCategCtasPotenciales_PR(EV_numIdentif    IN  VARCHAR2,
							                SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
	                       	                SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
	                                        SN_numEvento     OUT NOCOPY ge_errores_pg.Evento);

	-- INC.  : 71895
        -- Fecha : 10/11/2008
        -- Prog  : JMC
	PROCEDURE VE_valida_identificacion_PR( EV_NUM_IDENT VARCHAR2,  -- Inc. 72181 27/11/2008 JMC
                                               EV_TIP_IDENT VARCHAR2,  -- Inc. 72181 27/11/2008 JMC
                                               SN_resultado  OUT NOCOPY NUMBER,  -- Inc. 72181 27/11/2008 JMC
                                               SN_codRetorno OUT NOCOPY ge_errores_pg.CodError,
                                               SV_menRetorno OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_numEvento  OUT NOCOPY ge_errores_pg.Evento);
END VE_alta_cuenta_PG; 
/
SHOW ERRORS
