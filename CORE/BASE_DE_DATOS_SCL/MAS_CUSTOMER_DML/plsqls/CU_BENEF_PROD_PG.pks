CREATE OR REPLACE PACKAGE CU_BENEF_PROD_PG


IS

  TYPE refCursor IS REF CURSOR;
  CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
  CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'CU';
  CV_version              CONSTANT VARCHAR2 (2)  := '1';
  CV_SituaBaja			  CONSTANT VARCHAR2 (4)  := 'BAA';
  CV_SituaBajaPendiente   CONSTANT VARCHAR2 (4)  := 'BAP';
  CN_LISTA_NULA constant number:=1;


  PROCEDURE CU_ABOCONTRA_S_PR( EO_ABONADO_BENEF IN 		   CU_BENEF_PROD_QT,
  							   SO_ABONADOS_PROD	OUT NOCOPY refCursor,
						  	   SN_cod_retorno	OUT NOCOPY ge_errores_pg.coderror,
						  	   SV_mens_retorno	OUT NOCOPY ge_errores_pg.msgerror,
						  	   SN_num_evento	OUT NOCOPY ge_errores_pg.evento);

  PROCEDURE CU_BENEFICIA_S_PR( EN_NUMCELULAR    IN 		   NUMBER,
  							   SO_ABONADOS_PROD	OUT NOCOPY refCursor,
						  	   SN_cod_retorno	OUT NOCOPY ge_errores_pg.coderror,
						  	   SV_mens_retorno	OUT NOCOPY ge_errores_pg.msgerror,
						  	   SN_num_evento	OUT NOCOPY ge_errores_pg.evento);

  PROCEDURE CU_BENEFICIA_I_PR( EO_ABONADOS_BENEF IN		   CU_BENEF_PROD_QT_LISTA_QT,
						  	   SN_cod_retorno	 OUT NOCOPY ge_errores_pg.coderror,
						  	   SV_mens_retorno	 OUT NOCOPY ge_errores_pg.msgerror,
						  	   SN_num_evento	 OUT NOCOPY ge_errores_pg.evento);

  PROCEDURE CU_BENEFICIA_U_PR( EO_ABONADO_BENEF  IN		    CU_BENEF_PROD_QT,
						  	   SN_cod_retorno	 OUT NOCOPY ge_errores_pg.coderror,
						  	   SV_mens_retorno	 OUT NOCOPY ge_errores_pg.msgerror,
						  	   SN_num_evento	 OUT NOCOPY ge_errores_pg.evento);

  PROCEDURE CU_CADUCA_U_PR( EO_ABONADO_BENEF  IN		    CU_BENEF_PROD_QT,
						  	   SN_cod_retorno	 OUT NOCOPY ge_errores_pg.coderror,
						  	   SV_mens_retorno	 OUT NOCOPY ge_errores_pg.msgerror,
						  	   SN_num_evento	 OUT NOCOPY ge_errores_pg.evento);

  PROCEDURE CU_ELIMINA_U_PR( EO_ABONADO_BENEF  IN		    CU_BENEF_PROD_QT,
						  	   SN_cod_retorno	 OUT NOCOPY ge_errores_pg.coderror,
						  	   SV_mens_retorno	 OUT NOCOPY ge_errores_pg.msgerror,
						  	   SN_num_evento	 OUT NOCOPY ge_errores_pg.evento);

END CU_BENEF_PROD_PG;
/
SHOW ERRORS
