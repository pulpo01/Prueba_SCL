CREATE OR REPLACE PACKAGE PF_PRODUCTO_OFERTADO_PG
IS

  TYPE refCursor IS REF CURSOR;
  CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
  CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'PF';
  CV_version              CONSTANT VARCHAR2 (2)  := '1';
  CN_LISTA_NULA           CONSTANT NUMBER        := 1;
  --**inicio INC-155400 JMO/05-11-2010
  CN_pa_obligatorio       CONSTANT NUMBER        := 2;
  CN_pa_opcional          CONSTANT NUMBER        := 3;
  --**fin INC-155400 JMO/05-11-2010


  PROCEDURE PF_PRODUCTO_S_PR(EO_Lista_productos     IN  PF_PROD_OFERT_LISTA_QT,
                             SO_Lista_Productos  OUT NOCOPY    refCursor,
                             SN_cod_retorno      OUT NOCOPY ge_errores_pg.coderror,
                             SV_mens_retorno     OUT NOCOPY ge_errores_pg.msgerror,
                             SN_num_evento       OUT NOCOPY    ge_errores_pg.evento);

  PROCEDURE PF_PA_OBLIGATORIO_PT_PR(EV_COD_PLANTARIF        IN  ta_plantarif.cod_plantarif%type,
                                    EV_COD_CANAL            IN  pf_catalogo_ofertado_td.cod_canal%type,
                                    EV_NIVEL                IN  pf_productos_ofertados_td.ind_nivel_aplica%type,
                                    EV_COD_PRESTACION       IN  ps_especprod_prestacion_td.cod_prestacion%type,
                                    SO_Lista_Producto       OUT NOCOPY    refCursor,
                                    SN_cod_retorno          OUT NOCOPY  ge_errores_pg.coderror,
                                    SV_mens_retorno         OUT NOCOPY  ge_errores_pg.msgerror,
                                    SN_num_evento           OUT NOCOPY    ge_errores_pg.evento);

  PROCEDURE PF_CATEGORIA_S_PR(EO_Lista_Categoria  IN  PF_PROD_OFERT_LISTA_QT,
                              SO_Lista_Categoria  OUT NOCOPY    refCursor,
                              SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
                              SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
                              SN_num_evento       OUT NOCOPY    ge_errores_pg.evento);

  PROCEDURE PF_PRODUCTO_FILTRADO_S_PR(EV_COD_PLANTARIF         IN      ta_plantarif.cod_plantarif%type,
                                      EV_COD_CANAL             IN      pf_catalogo_ofertado_td.cod_canal%type,
                                      EV_NIVEL                 IN      pf_productos_ofertados_td.ind_nivel_aplica%type,
                                      EV_COD_PRESTACION        IN     ps_especprod_prestacion_td.cod_prestacion%type,
                                      EV_TIPOS_COMPORTAMIENTO  IN     VARCHAR2,
                                      SO_Lista_Producto        OUT NOCOPY   refCursor,
                                      SN_cod_retorno           OUT NOCOPY   ge_errores_pg.coderror,
                                      SV_mens_retorno          OUT NOCOPY   ge_errores_pg.msgerror,
                                      SN_num_evento            OUT NOCOPY    ge_errores_pg.evento);

  PROCEDURE PF_PRODUCTO_SCORING_S_PR(EN_NUM_ABONADO     IN  ga_abocel.num_abonado%type,
                                     SO_Lista_Producto  OUT NOCOPY  refCursor,
                                     SN_cod_retorno     OUT NOCOPY  ge_errores_pg.coderror,
                                     SV_mens_retorno    OUT NOCOPY  ge_errores_pg.msgerror,
                                     SN_num_evento      OUT NOCOPY  ge_errores_pg.evento);

END PF_PRODUCTO_OFERTADO_PG;
/
