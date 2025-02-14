CREATE OR REPLACE PACKAGE VE_VALIDAEQUIPO_PG
 IS

PROCEDURE ve_valida_icc_pr(EV_icc           IN  ga_aboamist.num_serie%TYPE,
                           EN_codvendealer  IN  ve_vendealer.cod_vendealer%TYPE,
                           EV_canalvendedor IN  VARCHAR2,
                           SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                           SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                           SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE ve_valida_imei_pr(EV_num_imei         IN ga_aboamist.num_serie%TYPE,
                            EN_cod_vendedor     IN ve_vendealer.cod_vendealer%TYPE,
                            EV_cod_canal        IN CHAR,
                            EV_cod_procediencia IN CHAR,
                            SN_cod_retorno      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                            SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                            SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE ve_valida_articulo_pr(EV_CODARTICULO   IN AL_ARTICULOS.COD_ARTICULO%TYPE,
                                SN_COD_RETORNO   OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                SV_MENS_RETORNO  OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                SN_NUM_EVENTO    OUT NOCOPY GE_ERRORES_PG.EVENTO);

PROCEDURE ve_valida_imei2_pr(EV_num_imei         IN ga_aboamist.num_serie%TYPE,
                            EN_cod_vendedor     IN ve_vendealer.cod_vendealer%TYPE,
                            EV_cod_canal        IN CHAR,
                            EV_cod_procediencia IN CHAR,
                            SN_cod_retorno      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                            SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                            SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);

END VE_VALIDAEQUIPO_PG;
/
SHOW ERRORS
