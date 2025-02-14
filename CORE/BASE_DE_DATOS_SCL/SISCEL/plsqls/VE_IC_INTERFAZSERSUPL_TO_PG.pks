CREATE OR REPLACE PACKAGE VE_IC_INTERFAZSERSUPL_TO_PG
AS
PROCEDURE VE_AGREGAR_PR (EN_num_abonado      IN ic_interfazsersupl_to.num_abonado%TYPE,
                         EN_num_trx          IN ic_interfazsersupl_to.num_trx%TYPE,
                         EV_cod_periocidad   IN ic_interfazsersupl_to.cod_periocidad%TYPE,
                         EV_cod_servicios    IN ic_interfazsersupl_to.cod_servicios%TYPE, --Inc. 76664 RAB 04-04-2009
                         SN_cod_retorno      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                         SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                         SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE VE_ELIMINAR_PR (EN_num_abonado      IN ic_interfazsersupl_to.num_abonado%TYPE,
                          EV_cod_periocidad   IN ic_interfazsersupl_to.cod_periocidad%TYPE,
                          EV_cod_servicios    IN ic_interfazsersupl_to.cod_servicios%TYPE, --Inc. 76664 RAB 04-04-2009
                          SN_cod_retorno      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                          SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE);

PROCEDURE VE_BUSCAR_PR (EN_num_abonado      IN ic_interfazsersupl_to.num_abonado%TYPE,
                        EV_cod_periocidad   IN ic_interfazsersupl_to.cod_periocidad%TYPE,
                        SN_num_trx          OUT NOCOPY NUMBER,
                        SN_cod_retorno      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                        SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                        SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);

PROCEDURE VE_MODIFICAR_PR (EN_num_abonado      IN ic_interfazsersupl_to.num_abonado%TYPE,
                           EN_num_trx          IN ic_interfazsersupl_to.num_trx%TYPE,
                           EV_cod_periocidad   IN ic_interfazsersupl_to.cod_periocidad%TYPE,
                           EV_cod_servicios    IN ic_interfazsersupl_to.cod_servicios%TYPE, --Inc. 76664 RAB 04-04-2009
                           SN_cod_retorno      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                           SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                           SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);
END VE_IC_INTERFAZSERSUPL_TO_PG;
/
SHOW ERRORS
