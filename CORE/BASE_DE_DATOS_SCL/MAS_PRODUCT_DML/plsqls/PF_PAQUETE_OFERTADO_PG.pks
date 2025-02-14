CREATE OR REPLACE PACKAGE PF_PAQUETE_OFERTADO_PG
IS

  TYPE refCursor IS REF CURSOR;
  CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
  CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'PF';
  CV_version              CONSTANT VARCHAR2 (2)  := '1';


  PROCEDURE PF_PAQUETE_S_PR(EO_prod_padre	  IN  			PF_PAQUETE_OFERTADO_TO_QT,
						  SO_Lista_Productos  OUT NOCOPY	refCursor,
						  SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
						  SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
						  SN_num_evento       OUT NOCOPY	ge_errores_pg.evento);
END PF_PAQUETE_OFERTADO_PG;
/
SHOW ERRORS
