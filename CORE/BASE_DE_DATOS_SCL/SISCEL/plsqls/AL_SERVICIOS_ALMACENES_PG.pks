CREATE OR REPLACE PACKAGE AL_Servicios_Almacenes_PG IS

        -- Nombre del package
        CV_NOMBRE_PACKAGE     CONSTANT VARCHAR2(25) := 'AL_Servicios_Almacenes_PG';

        CV_error_no_clasif   CONSTANT VARCHAR2(30) := 'Error no clasificado';
        CV_MODULO_GA         CONSTANT VARCHAR2(2)  := 'GA';

    PROCEDURE AL_consulta_articulo_PR(EN_cod_articulo    IN  al_articulos.cod_articulo%TYPE,
                                                                      SN_tip_articulo    OUT NOCOPY al_articulos.tip_articulo%TYPE,
                                                                      SV_des_articulo    OUT NOCOPY al_articulos.des_articulo%TYPE,
                                                                          SN_cod_conceptoart OUT NOCOPY al_articulos.cod_conceptoart%TYPE,
                                                                      SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                              SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                              SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE AL_indicador_valorar_PR(EN_num_serie    IN  VARCHAR2,
                                                          SN_ind_valorar  OUT NOCOPY NUMBER,
                                                          SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                  SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                  SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE AL_venta_mayorista_PR(EN_numSerie            IN VARCHAR2,
                                        SV_codigoUso           OUT NOCOPY VARCHAR2,
                                                            SV_descripcionUso      OUT NOCOPY VARCHAR2,
                                                                        SV_codigoArticulo      OUT NOCOPY VARCHAR2,
                                                                        SV_descripcionArticulo OUT NOCOPY VARCHAR2,
                                                                        SN_cod_retorno         OUT NOCOPY ge_errores_pg.CodError,
                                                                        SV_mens_retorno            OUT NOCOPY ge_errores_pg.MsgError,
                                                                        SN_num_evento              OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE AL_obtener_homenumerado_pr (EV_NumSerie        IN  al_series.num_serie%TYPE,
                                                                          EV_CodVendedor     IN  ve_vendedores.cod_vendedor%TYPE,
                                                                                  SN_Codsubalm       OUT al_series.cod_subalm%TYPE,
                                                                          SV_CodCentral      OUT al_series.COD_CENTRAL%TYPE,
                                                                              SV_CodHlr          OUT al_series.COD_HLR%TYPE,
                                                                          SV_CodCelda        OUT ge_celdas.COD_CELDA%TYPE,
                                                                                  SV_Region          OUT ge_direcciones.COD_REGION%TYPE,
                                                                                  SV_Provincia       OUT ge_direcciones.COD_PROVINCIA%TYPE,
                                                                                  SV_Ciudad          OUT ge_direcciones.COD_CIUDAD%TYPE,
                                                                                  SN_cod_retorno     OUT ge_errores_pg.CodError,
                                                  SV_mens_retorno    OUT ge_errores_pg.MsgError,
                                                  SN_num_evento      OUT ge_errores_pg.Evento);

END AL_Servicios_Almacenes_PG;


/
SHOW ERRORS
