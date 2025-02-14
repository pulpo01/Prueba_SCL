CREATE OR REPLACE PACKAGE PF_CATALOGO_PG

IS

  TYPE refCursor IS REF CURSOR;
  CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
  CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'PF';
  CV_version              CONSTANT VARCHAR2 (2)  := '1';
  CN_LISTA_NULA           CONSTANT NUMBER        := 1;
  --inicio JMO 15-11-2010 INC-155400
  CN_COD_PRODUCTO         CONSTANT NUMBER        := 1;  
  CV_GE                   CONSTANT VARCHAR2 (2)  := 'GE';
  CV_APLICA_PLAN_ADIC_OO  CONSTANT VARCHAR2 (25) := 'APLICA_PLAN_ADIC_OO';
  --fin JMO 15-11-2010 INC-155400

  PROCEDURE PF_CANAL_S_PR(EO_Catalogos        IN          PF_CATALOGO_OFER_TD_QT,
                          SO_Lista_Catalogos  OUT NOCOPY  refCursor,
                          SN_cod_retorno      OUT NOCOPY  ge_errores_pg.coderror,
                          SV_mens_retorno     OUT NOCOPY  ge_errores_pg.msgerror,
                          SN_num_evento       OUT NOCOPY  ge_errores_pg.evento);

  PROCEDURE PF_CANAL_S_PA_PR(EO_Catalogos	     IN  PF_CATALOGO_OFER_PA_TD_QT,
						     SO_Lista_Catalogos  OUT NOCOPY	refCursor,
						     SN_cod_retorno      OUT NOCOPY ge_errores_pg.coderror,
						     SV_mens_retorno     OUT NOCOPY ge_errores_pg.msgerror,
						     SN_num_evento       OUT NOCOPY	ge_errores_pg.evento);

  PROCEDURE PF_PRODUCTO_S_PR(EO_Catalogos       IN          PF_CATAL_OFER_TD_LISTA_QT,
                             SO_Lista_Catalogos OUT NOCOPY  refCursor,
                             SN_cod_retorno     OUT NOCOPY  ge_errores_pg.coderror,
                             SV_mens_retorno    OUT NOCOPY  ge_errores_pg.msgerror,
                             SN_num_evento      OUT NOCOPY  ge_errores_pg.evento);

  PROCEDURE PF_DETALLE_S_PR(EO_Catalogos       IN          PF_CATALOGO_OFER_TD_QT,
                            SO_Lista_Catalogos OUT NOCOPY  refCursor,
                            SN_cod_retorno     OUT NOCOPY  ge_errores_pg.coderror,
                            SV_mens_retorno    OUT NOCOPY  ge_errores_pg.msgerror,
                            SN_num_evento      OUT NOCOPY  ge_errores_pg.evento);

  PROCEDURE PF_CANAL_PRESTACION_S_PR (EO_Catalogos        IN          PF_CATALOGO_OFER_TD_QT,
                                      EN_Num_Abonado      IN          GA_ABOCEL.num_abonado%type,
                                      SO_Lista_Catalogos  OUT NOCOPY  refCursor,
                                      SN_cod_retorno      OUT NOCOPY  ge_errores_pg.coderror,
                                      SV_mens_retorno     OUT NOCOPY  ge_errores_pg.msgerror,
                                      SN_num_evento       OUT NOCOPY  ge_errores_pg.evento);
                                             
  PROCEDURE PF_ABONADOS_CLIENTE_S_PR (EN_Cod_Cliente      IN         GA_ABOCEL.cod_cliente%type,
                                      SO_Lista_Abonados   OUT NOCOPY refCursor,
                                      SN_cod_retorno      OUT NOCOPY ge_errores_pg.coderror,
                                      SV_mens_retorno     OUT NOCOPY ge_errores_pg.msgerror,
                                      SN_num_evento       OUT NOCOPY ge_errores_pg.evento);
                                                                                  
END PF_CATALOGO_PG;
/
SHOW ERRORS