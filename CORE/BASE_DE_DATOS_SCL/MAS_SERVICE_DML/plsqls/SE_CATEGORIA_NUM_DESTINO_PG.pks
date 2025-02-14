CREATE OR REPLACE PACKAGE SE_CATEGORIA_NUM_DESTINO_PG

IS

  TYPE refCursor IS REF CURSOR;
  CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
  CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'PF';
  CV_version              CONSTANT VARCHAR2 (2)  := '1';
  CN_LISTA_NULA 		  CONSTANT NUMBER	 := 156;
  CV_INTERNACIONAL		  CONSTANT VARCHAR2 (5)	 := 'I';
  CN_RED_FIJA			  CONSTANT NUMBER	 := 1;
  CV_NUMNACIONAL		  CONSTANT VARCHAR2(20)	 := 'NUMNACIONAL';
  CV_NUMINTERNACIONAL	  CONSTANT VARCHAR2(20)	 := 'NUMINTERNACIONAL';

  CV_REDFIJA			  CONSTANT VARCHAR2(5)	 := 'F';
  CV_PROPIA			  	  CONSTANT VARCHAR2(5)	 := 'P';
  CV_MOVIL			  	  CONSTANT VARCHAR2(5)	 := 'M';


   PROCEDURE SE_DETERMINA_CATEGORIA_PR(EO_CATEG_NUM IN OUT SE_CATEGORIAS_QT,
						  SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
						  SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
						  SN_num_evento       OUT NOCOPY	ge_errores_pg.evento);


END SE_CATEGORIA_NUM_DESTINO_PG;
/
SHOW ERRORS
