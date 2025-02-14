CREATE OR REPLACE PACKAGE VE_INTERFAZSERVPERIODICOS_PG
AS
PROCEDURE ve_servperiodico_pr (EN_num_movimiento IN icc_movimiento.num_movimiento%TYPE,
                               EN_num_abonado    IN icc_movimiento.num_abonado%TYPE);

PROCEDURE ve_actualizacargo_pr(EN_num_movimiento IN icc_movimiento.num_movimiento%TYPE,
                               EN_num_abonado    IN icc_movimiento.num_abonado%TYPE,
                               EV_actabo         IN icc_movimiento.cod_actabo%TYPE);
END VE_INTERFAZSERVPERIODICOS_PG;
/
SHOW ERRORS
