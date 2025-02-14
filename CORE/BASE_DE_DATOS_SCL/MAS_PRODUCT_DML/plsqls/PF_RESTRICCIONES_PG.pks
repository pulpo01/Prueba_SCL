CREATE OR REPLACE PACKAGE PF_RESTRICCIONES_PG

IS

  TYPE refCursor IS REF CURSOR;
  CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
  CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'PS';
  CV_version              CONSTANT VARCHAR2 (2)  := '1';
  CN_LISTA_NULA constant number:=1;


    PROCEDURE PF_GENERAL_S_PR(EO_Restricciones  IN  		PF_RESTR_CONTRATA_TD_QT,
						  SO_Lista_Restricciones  OUT NOCOPY	refCursor,
						  SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
						  SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
						  SN_num_evento       OUT NOCOPY	ge_errores_pg.evento);



END PF_RESTRICCIONES_PG;
/
SHOW ERRORS
