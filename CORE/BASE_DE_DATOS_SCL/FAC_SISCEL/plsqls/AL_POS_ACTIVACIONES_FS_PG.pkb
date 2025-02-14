CREATE OR REPLACE PACKAGE BODY AL_POS_ACTIVACIONES_FS_PG
IS
-- Servicio de posactivación  - Logística - Guatemala.
-- Junio 2010 - Ulises Uribe.

SN_cod_retornoau   ge_errores_pg.CodError;
SV_mens_retornoau  ge_errores_pg.MsgError;
SN_num_eventoau    ge_errores_pg.Evento;
SN_num_transaccion ge_auditoria_to.num_ticket%TYPE;
ERR_MOAUDITORIA    EXCEPTION;
ERR_AGAUDITORIA    EXCEPTION;
-----------------------------------------------------------------------------------------------------------------
PROCEDURE P_ACTIVACION_PUNTUAL_FS_PR(EV_serie    IN   VARCHAR2,
                                     EN_cliente  IN   NUMBER,
                                     SN_numero   OUT  NOCOPY   NUMBER,
                                     SN_cod_retorno   OUT  NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                     SV_mens_retorno  OUT  NOCOPY ge_errores_td.det_msgerror%TYPE) 
AS
    nsNEvento          ge_errores_pg.Evento;
    SN_cod_retornoau   ge_errores_pg.coderror;
    SV_mens_retornoau  ge_errores_pg.msgerror;
    SN_num_eventoau    ge_errores_pg.Evento;
    SN_num_transaccion ge_auditoria_to.num_ticket%TYPE;
BEGIN

    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL,'ICC =' || EV_serie ||' cliente = '||EN_cliente , 'POS', 'POS', NULL,
SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
       --ve_desbloqueaprepago_sms_pg.ve_existe_plantarif_pr(EV_codplantarif,SN_cod_retorno, SV_mens_retorno, nsNEvento);
       AL_POS_ACTIVACIONES_PG.P_ACTIVACION_PUNTUAL_PR(EV_serie, EN_cliente, SN_numero,SN_cod_retorno, SV_mens_retorno, nsNEvento);
       ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', nsNEvento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau,SN_num_eventoau);
       IF SN_cod_retornoau IS NOT NULL THEN
          RAISE ERR_MOAUDITORIA;
       END IF;

    ELSE
       RAISE ERR_AGAUDITORIA;
    END IF;

    EXCEPTION

    WHEN ERR_AGAUDITORIA THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

    WHEN ERR_MOAUDITORIA  THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

END P_ACTIVACION_PUNTUAL_FS_PR;
-----------------------------------------------------------------------------------------------------------------
END; 
/
SHOW ERRORS
