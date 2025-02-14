CREATE OR REPLACE PACKAGE SE_DET_ESPEC_PROD_PG

IS

  TYPE refCursor IS REF CURSOR;
  CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
  CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'SE';
  CV_version              CONSTANT VARCHAR2 (2)  := '1';
  CN_LISTA_NULA constant number:=1;


 PROCEDURE SE_ESPEC_S_PR(EO_Det_Espec_productos   IN    SE_DETALLE_ESPEC_TO_QT,
        SO_Lista_Det_Espec_Productos  OUT NOCOPY refCursor,
        SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
        SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
        SN_num_evento       OUT NOCOPY ge_errores_pg.evento);


END SE_DET_ESPEC_PROD_PG;
/
SHOW ERRORS
