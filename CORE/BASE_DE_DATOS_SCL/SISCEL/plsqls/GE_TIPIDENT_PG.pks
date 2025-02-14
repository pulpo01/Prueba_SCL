CREATE OR REPLACE PACKAGE GE_TIPIDENT_PG
IS

TYPE refCursor IS REF CURSOR;
  CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
  CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'GE';
  CV_version              CONSTANT VARCHAR2 (2)  := '1';
  CN_LISTA_NULA constant number:=1;

	PROCEDURE GE_OBTENER_S_PR(SO_GE_TIPIDENT_CUR  OUT NOCOPY	refCursor,
									    		   SN_cod_retorno      OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
											       SV_mens_retorno     OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
												   SN_num_evento       OUT NOCOPY	ge_errores_pg.evento);
end GE_TIPIDENT_PG;
/
SHOW ERRORS
