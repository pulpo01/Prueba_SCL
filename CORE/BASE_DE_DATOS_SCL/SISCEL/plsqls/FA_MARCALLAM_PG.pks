CREATE OR REPLACE PACKAGE Fa_Marcallam_Pg AS

FUNCTION  FA_UPDATEMARCADET_FN ( EV_Cod_Marca       IN VARCHAR2,
                                 EV_Ind_Impresion   IN VARCHAR2,
                                                                 EN_Num_pulso       IN NUMBER,
                                                                 EN_Valor_Unidad    IN NUMBER,
                                                                 EN_cod_ciclfact    IN FA_CICLFACT.COD_CICLFACT%TYPE,
                                                                 EN_digito          IN NUMBER,
                                 EN_ROWID           IN ROWID)
                                                                RETURN BOOLEAN;

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

PROCEDURE FA_MARCADET_PR ( EN_cod_ciclfact    IN FA_CICLFACT.COD_CICLFACT%TYPE,
                           EN_digito          IN NUMBER,
                           SN_cod_CodMegError OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                           SV_msg_DetMsgError OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                           SN_num_Evento      OUT NOCOPY GE_EVENTO_DETALLE_TO.EVENTO%TYPE);

END Fa_Marcallam_Pg;
/
SHOW ERRORS
