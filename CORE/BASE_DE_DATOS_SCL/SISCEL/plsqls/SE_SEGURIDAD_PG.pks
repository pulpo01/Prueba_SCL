CREATE OR REPLACE PACKAGE SE_SEGURIDAD_PG
IS

  CV_error_no_clasif  CONSTANT VARCHAR2(30):='Error no clasificado';
  CV_codmodulo        CONSTANT VARCHAR2(2):='GA';
  TYPE refcursor                  IS REF CURSOR;

PROCEDURE SE_valida_version_sistema_PR ( EV_cod_programa  IN  VARCHAR2,
		  							   	 EN_num_version IN NUMBER,
										 EN_num_subversion IN NUMBER,
										 SN_resultado      OUT NOCOPY PLS_INTEGER,
				 				 	  	 SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                        		      	 SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                           		      	 SN_num_evento   OUT NOCOPY ge_errores_pg.Evento
									  	);

PROCEDURE VE_valida_usuario_PR ( 		 EV_nom_usuario IN  VARCHAR2,
									 	 SN_resultado    OUT NOCOPY PLS_INTEGER,
			 				 	  	 	 SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                       		      	 	 SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                          		      	 SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE VE_valida_usuario_PR (EV_nom_usuario     IN  VARCHAR2,
                                EV_cod_programa    IN  VARCHAR2,
                                EV_cod_proceso     IN  VARCHAR2,
                                EV_cod_opcion      IN  VARCHAR2,
								SN_resultado       OUT NOCOPY PLS_INTEGER,
			 				 	SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                       		    SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                          		SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE VE_valida_usuario_PR (  	 EV_nom_usuario IN  VARCHAR2,
								 	 SN_resultado    OUT NOCOPY PLS_INTEGER,
									 SN_codigo_vendedor OUT NOCOPY PLS_INTEGER,
									 SV_codigo_oficina OUT VARCHAR2,
									 SV_nombre_usuario OUT VARCHAR2,
		 				 	  	 	 SV_Codigo_Comisionista OUT GE_SEG_USUARIO.COD_TIPCOMIS%TYPE,
                                     SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                   		      	 	 SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                       		      	 SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);
	PROCEDURE VE_obtiene_menu_pr (  EV_cod_programa     IN GE_PROGRAMAS.COD_PROGRAMA%TYPE,
                                    EN_NUM_VERSION      IN GE_PROGRAMAS.NUM_VERSION%TYPE,
                                    EV_nom_usuario      IN GE_SEG_USUARIO.NOM_USUARIO%TYPE,
			 				 	  	SC_CURSORDATOS     OUT NOCOPY refcursor,
                                    SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                       		      	SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                          		    SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);



END SE_SEGURIDAD_PG;
/
SHOW ERRORS