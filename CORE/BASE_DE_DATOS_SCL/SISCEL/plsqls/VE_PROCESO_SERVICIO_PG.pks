CREATE OR REPLACE PACKAGE VE_PROCESO_SERVICIO_PG
AS

PROCEDURE ve_bajaabonados_pr (EV_actabo         IN icc_movimiento.cod_actabo%TYPE,
                              EN_producto       IN NUMBER,
                              EN_num_abonado    IN icc_movimiento.num_abonado%TYPE,
                              EV_perfil         IN ga_abocel.perfil_abonado%TYPE,
                              EN_rent           IN NUMBER,
                              ED_fecsys         IN DATE,
                              EN_indsusp        IN NUMBER,
                              EV_modulo         IN icc_movimiento.cod_modulo%TYPE,
                              EN_num_movimiento IN icc_movimiento.num_movimiento%TYPE,
                              EV_cod_servicios  IN icc_movimiento.cod_servicios%TYPE,
                              EV_cod_actuacion  IN icc_movimiento.cod_actuacion%TYPE,
                              EV_num_serie      IN icc_movimiento.num_serie_nue%TYPE,
                              EV_num_serie_old  IN icc_movimiento.num_serie%TYPE,
                              EV_nom_usuarora   IN icc_movimiento.nom_usuarora%TYPE);

PROCEDURE ve_bloqueaabonado_pr (EV_actabo         IN icc_movimiento.cod_actabo%TYPE,
                                EN_producto       IN NUMBER,
                                EN_num_abonado    IN icc_movimiento.num_abonado%TYPE,
                                EV_modulo         IN icc_movimiento.cod_modulo%TYPE);

PROCEDURE ve_actualiza_akeys1_pr (EN_num_movimiento IN icc_movimiento.num_movimiento%TYPE,
                                  EV_actabo         IN icc_movimiento.cod_actabo%TYPE,
                                  EV_cod_servicios  IN icc_movimiento.cod_servicios%TYPE,
                                  EV_num_serie      IN icc_movimiento.num_serie_nue%TYPE,
                                  EV_num_serie_old  IN icc_movimiento.num_serie%TYPE);

PROCEDURE ve_actualiza_akeys0_pr (EN_num_movimiento IN icc_movimiento.num_movimiento%TYPE,
                                  EV_actabo         IN icc_movimiento.cod_actabo%TYPE,
                                  EV_cod_servicios  IN icc_movimiento.cod_servicios%TYPE,
                                  EV_num_serie      IN icc_movimiento.num_serie_nue%TYPE,
                                  EV_num_serie_old  IN icc_movimiento.num_serie%TYPE);

PROCEDURE ve_cambionumero_pr (EN_producto        IN NUMBER,
                              EN_num_abonado     IN icc_movimiento.num_abonado%TYPE,
                              EV_cod_servicios   IN icc_movimiento.cod_servicios%TYPE,
                              SV_perfil          IN OUT NOCOPY ga_abocel.perfil_abonado%TYPE,
                              EN_rent            IN NUMBER,
                              ED_fecsys          IN DATE,
                              SV_clase_servicio  IN OUT NOCOPY ga_abocel.clase_servicio%TYPE);

PROCEDURE ve_fact_hibridos_pr (EN_num_abonado    IN icc_movimiento.num_abonado%TYPE);

END VE_PROCESO_SERVICIO_PG;
/
SHOW ERRORS
