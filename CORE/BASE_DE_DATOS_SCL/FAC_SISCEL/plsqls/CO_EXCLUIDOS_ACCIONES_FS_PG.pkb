CREATE OR REPLACE PACKAGE BODY CO_EXCLUIDOS_ACCIONES_FS_PG AS
SN_cod_retornoau   ge_errores_td.cod_msgerror%TYPE;
SV_mens_retornoau  ge_errores_td.det_msgerror%TYPE;
SN_num_eventoau    ge_errores_pg.Evento;
SN_num_transaccion ge_auditoria_to.num_ticket%TYPE;
ERR_MOAUDITORIA    EXCEPTION;
ERR_AGAUDITORIA    EXCEPTION;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE CO_AGREGA_CLIENTE_PR (
      EN_cod_cliente     IN NUMBER,
      SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
      SV_msg_retorno   OUT NOCOPY ge_errores_pg.MsgError,
      SN_cod_evento     OUT NOCOPY ge_errores_pg.Evento)
      IS
sSQL VARCHAR2(100);
BEGIN
    SN_cod_retorno := 0;
    SN_cod_evento  := 0  ;
    SV_msg_retorno:= NULL;

    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL,  'EN_cod_cliente='||EN_cod_cliente, 'CLI_EXC', 'CLI_EXC_01', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
       sSQL := 'co_excluidos_acciones_sn_pg.co_agrega_pr()';

       co_excluidos_acciones_sn_pg.
	   co_agrega_pr(1 ,EN_cod_cliente, NULL, NULL, sn_cod_retorno, SV_msg_retorno, SN_cod_evento);
       ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', SN_cod_evento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);

       IF SN_cod_retornoau IS NOT NULL THEN
            RAISE ERR_MOAUDITORIA;
       END IF;
    ELSE
        RAISE ERR_AGAUDITORIA;
    END IF;

EXCEPTION

    WHEN ERR_AGAUDITORIA THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_msg_retorno := SV_mens_retornoau;

    WHEN ERR_MOAUDITORIA  THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_msg_retorno := SV_mens_retornoau;
END;

PROCEDURE CO_ELIMINA_CLIENTE_PR (
      EN_cod_cliente     IN NUMBER,
      SN_cant_eliminados  OUT NOCOPY NUMBER,
      SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
      SV_msg_retorno   OUT NOCOPY ge_errores_pg.MsgError,
      SN_cod_evento     OUT NOCOPY ge_errores_pg.Evento) AS

sSQL VARCHAR2(100);
BEGIN
    SN_cod_retorno := 0;
    SN_cod_evento  := 0  ;
    SV_msg_retorno:= NULL;

    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL,  'EN_cod_cliente='||EN_cod_cliente, 'CLI_EXC', 'CLI_EXC_02', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN

       sSQL := 'co_excluidos_acciones_sn_pg.co_elimina_pr';

       co_excluidos_acciones_sn_pg.co_elimina_pr(1, EN_cod_cliente, SN_cant_eliminados, SN_cod_retorno, SV_msg_retorno, SN_cod_evento);

       ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', SN_cod_evento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);

       IF SN_cod_retornoau IS NOT NULL THEN
            RAISE ERR_MOAUDITORIA;
       END IF;
    ELSE
        RAISE ERR_AGAUDITORIA;
    END IF;

EXCEPTION

    WHEN ERR_AGAUDITORIA THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_msg_retorno := SV_mens_retornoau;

    WHEN ERR_MOAUDITORIA  THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_msg_retorno := SV_mens_retornoau;
END;

PROCEDURE CO_CONSULTA_CLIENTE_PR (
      EN_cod_cliente     IN NUMBER,
      SD_fec_ingreso     OUT NOCOPY DATE,
      SD_fec_ini_exclusion        OUT NOCOPY   DATE,
      SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
      SV_msg_retorno   OUT NOCOPY ge_errores_pg.MsgError,
      SN_cod_evento     OUT NOCOPY ge_errores_pg.Evento) AS
sSQL VARCHAR2(100);
BEGIN
    SN_cod_retorno := 0;
    SN_cod_evento  := 0  ;
    SV_msg_retorno:= NULL;

    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL,  'EN_cod_cliente='||EN_cod_cliente, 'CLI_EXC', 'CLI_EXC_03', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
    IF SN_cod_retornoau IS NULL THEN
       sSQL := 'co_excluidos_acciones_sn_pg.co_consulta_pr';

       co_excluidos_acciones_sn_pg.co_consulta_pr(1, en_cod_cliente, sd_fec_ingreso, sd_fec_ini_exclusion, SN_cod_retorno, SV_msg_retorno, SN_cod_evento);


       ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', SN_cod_evento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);

       IF SN_cod_retornoau IS NOT NULL THEN
            RAISE ERR_MOAUDITORIA;
       END IF;
    ELSE
        RAISE ERR_AGAUDITORIA;
    END IF;

EXCEPTION

    WHEN ERR_AGAUDITORIA THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_msg_retorno := SV_mens_retornoau;

    WHEN ERR_MOAUDITORIA  THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_msg_retorno := SV_mens_retornoau;
END;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
END CO_EXCLUIDOS_ACCIONES_FS_PG;
/
SHOW ERRORS
