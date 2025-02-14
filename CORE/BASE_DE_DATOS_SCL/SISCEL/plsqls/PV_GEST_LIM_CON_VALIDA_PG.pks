CREATE OR REPLACE PACKAGE PV_GEST_LIM_CON_VALIDA_PG
IS

TYPE RefCursor          IS REF CURSOR;
ERROR_VALIDACION        EXCEPTION;
ERROR_GENERAL           EXCEPTION;
GV_PACKAGE              CONSTANT VARCHAR2(30)                   := 'PV_GEST_LIM_CON_VALIDA_PG';
gv_error_others         CONSTANT NUMBER                         := '156';
gv_error_no_clasif      CONSTANT VARCHAR2(100)                  := 'Error no Clasificado';
gn_largoerrtec          CONSTANT NUMBER(3)                      := 500;
gn_largodesc            CONSTANT NUMBER(3)                      := 100;
gv_cod_modulo           CONSTANT VARCHAR2(2)                    := 'GA';
gn_cod_producto         CONSTANT NUMBER                         := 1;

PROCEDURE PV_VALIDA_OS_PENDIENTE_PR(
    EN_NUM_ABONADO      IN GA_ABOCEL.NUM_ABONADO%TYPE,
    EV_COD_OS           IN VARCHAR2,
    SN_COD_RETORNO      OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO      OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO        OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_VALIDA_AVISO_SINIESTRO_PR(
    EN_NUM_ABONADO        IN GA_ABOCEL.NUM_ABONADO%TYPE,
    EV_TABLA              IN VARCHAR2,
    SN_COD_RETORNO        OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO        OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO          OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_VALIDA_RECAMBIO_PR(
                                    EN_NUM_ABONADO        IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                    EN_COD_CLIENTE        IN GA_ABOCEL.COD_CLIENTE%TYPE,
                                    EV_NOM_USUARIO        IN GE_SEG_USUARIO.NOM_USUARIO%TYPE,
                                    SN_cod_retorno        OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                    SV_mens_retorno       OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                    SN_num_evento         OUT NOCOPY ge_errores_pg.Evento
);


PROCEDURE PV_VAL_VENTA_SIN_FOLIO_PR(
                                SN_IND_VTASINFOLIO  OUT GE_OPERADORA_SCL.IND_VTASINFOLIO%TYPE,
                                SN_COD_RETORNO  OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                SV_MENS_RETORNO OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                SN_NUM_EVENTO   OUT NOCOPY GE_ERRORES_PG.EVENTO 
);

END PV_GEST_LIM_CON_VALIDA_PG;
/
SHOW ERRORS