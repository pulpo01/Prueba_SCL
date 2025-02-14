CREATE OR REPLACE PACKAGE PS_ESPEC_PRODUCTO_PG

IS

  TYPE refCursor IS REF CURSOR;
  CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
  CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'PS';
  CV_version              CONSTANT VARCHAR2 (2)  := '1';
  CN_LISTA_NULA constant number:=1;


  PROCEDURE PS_PRODUCTO_S_PR(EO_Espe_productos	  IN  		PF_ESPEC_PRODUCTO_QT,
						  SO_Lista_Espe_Productos  OUT NOCOPY	refCursor,
						  SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
						  SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
						  SN_num_evento       OUT NOCOPY	ge_errores_pg.evento);


END PS_ESPEC_PRODUCTO_PG;
/
SHOW ERRORS
