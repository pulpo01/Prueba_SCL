CREATE OR REPLACE PACKAGE FA_LOADTRAFICO_PG AS

FUNCTION FA_TIPOLLAMADAUNIDAD_FN ( EN_Cod_Carg        IN NUMBER,
                                   EN_cod_ciclfact    IN FA_CICLFACT.COD_CICLFACT%TYPE,
                                   EN_digito          IN NUMBER)
RETURN VARCHAR2;

FUNCTION FA_GETFACTOR_FN ( EV_Tip_Unidad IN VARCHAR2 )
RETURN NUMBER;

FUNCTION FA_CALCPULSO_FN ( EN_Dur_Real IN NUMBER,
                           EN_factor   IN NUMBER)
RETURN NUMBER;

FUNCTION FA_CALCVALORUNIDAD_FN ( EN_mto_real  IN NUMBER,
                                 EN_num_pulso IN NUMBER)
RETURN NUMBER;

--====================================================================================================

FUNCTION FA_LOADTRAFICO_FN ( vp_Cod_Ciclfact IN NUMBER,
                             vp_Digito IN NUMBER)
RETURN NUMBER;

END FA_LOADTRAFICO_PG;
/
SHOW ERRORS