CREATE OR REPLACE PACKAGE CU_VETADOS_PROD_PG


IS

  TYPE refCursor IS REF CURSOR;
  CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
  CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'CU';
  CV_version              CONSTANT VARCHAR2 (2)  := '1';
  CV_SituaBaja			  CONSTANT VARCHAR2 (4)  := 'BAA';
  CV_SituaBajaPendiente   CONSTANT VARCHAR2 (4)  := 'BAP';
  CN_LISTA_NULA constant number:=1;


  PROCEDURE CU_VETADOS_S_PR( EO_ABONADO_VETADO IN 		   CU_VETADOS_PROD_QT,
  							   SO_VETADOS_PROD	OUT NOCOPY refCursor,
						  	   SN_cod_retorno	OUT NOCOPY ge_errores_pg.coderror,
						  	   SV_mens_retorno	OUT NOCOPY ge_errores_pg.msgerror,
						  	   SN_num_evento	OUT NOCOPY ge_errores_pg.evento);

  PROCEDURE CU_VETADOS_I_PR( EO_ABONADOS_VETADOS IN		   CU_VETADOS_PROD_LST_QT,
						  	   SN_cod_retorno	 OUT NOCOPY ge_errores_pg.coderror,
						  	   SV_mens_retorno	 OUT NOCOPY ge_errores_pg.msgerror,
						  	   SN_num_evento	 OUT NOCOPY ge_errores_pg.evento);

  PROCEDURE CU_VETADOS_U_PR( EO_ABONADO_VETADO IN 		   CU_VETADOS_PROD_QT,
						  	   SN_cod_retorno	 OUT NOCOPY ge_errores_pg.coderror,
						  	   SV_mens_retorno	 OUT NOCOPY ge_errores_pg.msgerror,
						  	   SN_num_evento	 OUT NOCOPY ge_errores_pg.evento);

END CU_VETADOS_PROD_PG;
/
SHOW ERRORS
