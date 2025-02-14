CREATE OR REPLACE PACKAGE PV_PLAN_INDEMNIZACION_PG
IS

CN_codproducto    CONSTANT GA_ABOCEL.COD_PRODUCTO%TYPE:=1;
CV_nomparamcobr   CONSTANT ga_parametros_sistema_vw.nom_parametro%TYPE:='COBRO_INDEM';
CV_nomparamactu   CONSTANT ga_parametros_sistema_vw.nom_parametro%TYPE:='ACTUACION_BAJA';
CV_nomparamsero   CONSTANT ga_parametros_sistema_vw.nom_parametro%TYPE:='SERV_OCASIONAL';

GV_codactuacion   ga_actabo.cod_actabo%TYPE;
GV_evento                 ga_parametros_sistema_vw.valor_texto%TYPE;
GV_Parametro      VARCHAR2(255);
GV_Descripcion    VARCHAR2(255);
GV_Secuencia      NUMBER;
GN_codretorno     NUMBER;
GV_codtipserv     ga_actuaserv.cod_tipserv%TYPE;
GV_aplicacobro    VARCHAR2(20);
GV_operlocal            GE_OPERADORA_SCL_LOCAL.COD_OPERADORA_SCL%TYPE;


FUNCTION PV_RETORNA_VERSION_GENERAL_FN RETURN VARCHAR2;

PROCEDURE PV_STANDARD_PR(  EN_numabonado            IN  ga_abocel.num_abonado%TYPE,
                                                   EV_modulo                            IN      ge_modulos.cod_modulo%TYPE,
                                                   SN_Monto                                 OUT NOCOPY NUMBER,
                                                   SV_IndAut                        OUT NOCOPY VARCHAR2,
                                                   SV_Cod_error             OUT NOCOPY VARCHAR2,--NUMBER,
                                                   SV_Des_error             OUT NOCOPY VARCHAR2);

PROCEDURE PV_ESCALONADA_PR (EN_numabonado            IN  ga_abocel.num_abonado%TYPE,
                                                   EV_modulo                            IN      ge_modulos.cod_modulo%TYPE,
                                                   SN_Monto                                 OUT NOCOPY NUMBER,
                                                   SV_IndAut                        OUT NOCOPY VARCHAR2,
                                                   SV_Cod_error             OUT NOCOPY VARCHAR2,--NUMBER,
                                                   SV_Des_error             OUT NOCOPY VARCHAR2);
PROCEDURE PV_POREQUIPO_PR (EN_numabonado            IN  ga_abocel.num_abonado%TYPE,
                                                   EV_modulo                            IN      ge_modulos.cod_modulo%TYPE,
                                                   SN_Monto                                 OUT NOCOPY NUMBER,
                                                   SV_IndAut                        OUT NOCOPY VARCHAR2,
                                                   SV_Cod_error             OUT NOCOPY VARCHAR2,--NUMBER,
                                                   SV_Des_error             OUT NOCOPY VARCHAR2);

PROCEDURE PV_INDEMNIZACION_PR (EN_numabonado            IN  ga_abocel.num_abonado%TYPE,
                                                          EV_modulo                             IN      ge_modulos.cod_modulo%TYPE,
                                                          SV_IndAut                             OUT NOCOPY VARCHAR2,
                                                      SV_Monto                          OUT NOCOPY VARCHAR2,
                                                          SV_CodConcepto                OUT NOCOPY VARCHAR2,
                                                          SV_Cod_error          OUT NOCOPY VARCHAR2,
                                                          SV_Des_error          OUT NOCOPY VARCHAR2);

PROCEDURE PV_RETORNA_PARAM_PR (EV_modulo       IN ge_modulos.cod_modulo%TYPE
                                                           ,EV_nomparam    IN ga_parametros_sistema_vw.nom_parametro%TYPE
                                                           ,SN_valornum    OUT nocopy ga_parametros_sistema_vw.valor_numerico%TYPE
                                                           ,SV_valortext   OUT nocopy ga_parametros_sistema_vw.valor_texto%TYPE
                                                           ,SV_valordom    OUT nocopy ga_parametros_sistema_vw.valor_dominio%TYPE
                                                           ,SV_cod_error   OUT NOCOPY VARCHAR2
                                                           ,SV_des_error   OUT NOCOPY VARCHAR2);


END PV_PLAN_INDEMNIZACION_PG;
/
SHOW ERRORS
