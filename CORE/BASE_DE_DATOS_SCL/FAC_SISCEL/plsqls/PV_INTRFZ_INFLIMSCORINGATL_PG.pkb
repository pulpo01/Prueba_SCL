CREATE OR REPLACE PACKAGE BODY Pv_Intrfz_Inflimscoringatl_Pg IS

-- *************************************************************
-- * Paquete            : PV_INTRFZ_INFLIMSCORINGATL_PG.
-- * Descripci¢n        :
-- * Fecha de creaci¢n  : Marzo 2007.
-- * Responsable        : Yury Alvarez T.
-- *************************************************************

        ERR_AGAUDITORIA EXCEPTION;
        ERR_MOAUDITORIA EXCEPTION;

PROCEDURE PV_INTRFZ_INFLIMSCORINGATL_PR (EN_num_celular     IN GA_ABOCEL.num_celular%TYPE,
                                                                         SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
                                                                         SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
                                                                         SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento)
IS

    ParamIn VARCHAR2(512);

    SN_cod_retornoau   ge_errores_pg.CodError;
    SV_mens_retornoau  ge_errores_pg.MsgError;
    SN_num_eventoau    ge_errores_pg.Evento;
    SN_num_transaccion ge_auditoria_to.num_ticket%TYPE;

BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0  ;
    SV_mens_retorno:= NULL;


        ParamIn := 'EN_num_celular= '||EN_num_celular ;

        GE_Auditoria_PG.GE_AGREGAAUDITORIA_PR(SN_num_transaccion, 'INICI', USER, NULL, ParamIn, 'SAI', 'COL_I_001', NULL,SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
        IF SN_cod_retornoau  IS NULL THEN
                PV_INFORMA_LIMSCORING_ATL_PG.PV_INFORMA_LIMSCORING_ATL_PR(EN_num_celular,SN_cod_retorno, SV_mens_retorno,SN_num_evento);
        GE_Auditoria_PG.GE_MODIFICAAUDITORIA_PR( 'TERMI', SN_num_evento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);
                IF SN_cod_retornoau  IS NOT NULL THEN
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

END PV_INTRFZ_INFLIMSCORINGATL_PR;

END Pv_Intrfz_Inflimscoringatl_Pg;
/
SHOW ERRORS
