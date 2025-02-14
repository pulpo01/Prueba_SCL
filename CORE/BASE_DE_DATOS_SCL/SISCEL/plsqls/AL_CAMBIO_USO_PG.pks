CREATE OR REPLACE PACKAGE AL_CAMBIO_USO_PG IS

        TYPE refcursor IS REF CURSOR;

        PROCEDURE AL_OBTIENE_USO_DESTINO_PR(EV_parametro IN VARCHAR2,
                                        EN_parametro_padre IN NUMBER,
                                                                                SV_mens_retorno OUT NOCOPY VARCHAR2,
                                            SN_uso_final OUT NOCOPY refcursor);

        PROCEDURE AL_OBTIENE_TIPMOV_PROCESO_PR(EN_proceso IN al_procesos_tipmovim.cod_proceso%TYPE,
                                                                                   EN_ind_entsal IN al_tipos_movimientos.ind_entsal%TYPE,
                                                                                   SV_mens_retorno OUT NOCOPY VARCHAR2,
                                               SN_tip_movim OUT NOCOPY refcursor);


        PROCEDURE AL_OBTIENE_DETALLE_SERIE_PR(EN_num_serie IN al_series.num_serie%TYPE,
                                                                                  SV_mens_retorno OUT NOCOPY VARCHAR2,
                                              SN_detalle_serie OUT NOCOPY refcursor);


        PROCEDURE AL_CAMBIO_USO_PUNTUAL_PR(EN_serie_inicial IN al_series.num_serie%TYPE,
                                   EN_tip_movim     IN al_movimientos.tip_movimiento%TYPE,
                                                                   EN_uso           IN al_movimientos.cod_uso%TYPE,
                                                                   EN_uso_destino   IN al_movimientos.cod_uso_dest%TYPE,
                                                                   EN_cod_bodega     IN al_movimientos.cod_bodega%TYPE,
                                                           EN_tip_stock      IN al_movimientos.tip_stock%TYPE,
                                   EN_cod_articulo   IN al_movimientos.cod_articulo%TYPE,
                                   EN_cod_estado     IN al_movimientos.cod_estado%TYPE,
                                   EN_cod_producto   IN al_movimientos.cod_producto%TYPE,
                                                                   SV_mens_retorno  OUT NOCOPY VARCHAR2);

    PROCEDURE AL_PARAMETROS_PR (EN_modulo IN ge_modulos.cod_modulo%type,
                                EV_nom_parametro IN VARCHAR2,
                                                        EN_padre IN NUMBER,
                                                                EN_tipocol IN NUMBER,
                                                        SV_mens_retorno OUT NOCOPY VARCHAR2,
                                    SN_parametros OUT NOCOPY refcursor);

END AL_CAMBIO_USO_PG;
/
SHOW ERRORS
