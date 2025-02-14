CREATE OR REPLACE package PV_FACHADA_ACTRESPUESTA_PG
as

-- *************************************************************
-- * Paquete            : PV_FACHADA_ACTRESPUESTA_PG
-- * Descripción        : Procedimiento de traspaso de información
-- * Función            : Packarge para traspaso de información de la tabla ICC_MOVIMIENTO
-- * Fecha de creación  : Julio 2006
-- * F. de Homologacion :
-- * Actualizacion      : Postventa SCL - Oscar Jorquera P.
-- *************************************************************

-- Declaracion de Variables Globales

-- Inicio especificacion PL/SQL

GN_EVENTO           NUMBER;
CV_APAGADO_HIBRIDO  CONSTANT VARCHAR2 (19)    := 'IND_ERR_NO_HAY_CONF';
CV_MODULO           CONSTANT VARCHAR2 (2)     := 'GA';



    procedure PV_CARGA_MOVI_PR(V_PARAM_ENTRADA IN ICC_MOVIMIENTO%ROWTYPE,
                                                             V_CODERROR OUT NOCOPY VARCHAR2,
                                                                 V_DESERROR OUT NOCOPY VARCHAR2);


procedure PV_FACHADA_UNIX_PR    (EN_num_os                IN pv_iorserv.num_os%TYPE,
                                                                 EN_COD_ACTABO    IN PV_CAMCOM.COD_ACTABO%TYPE,
                                                                 EN_NUM_ABONADO   IN PV_CAMCOM.NUM_ABONADO%TYPE,
                                                                 EN_COD_SERVICIOS IN ICC_MOVIMIENTO.COD_SERVICIOS%TYPE,
                                                                 EN_PLAN          IN ICC_MOVIMIENTO.PLAN%TYPE,
                                                                 EN_TIP_TECNO     IN ICC_MOVIMIENTO.TIP_TECNOLOGIA%TYPE,
                                                                 EN_NOM_USUA      IN ICC_MOVIMIENTO.NOM_USUARORA%TYPE,
                                                             SV_CODERROR OUT NOCOPY VARCHAR2,
                                                                 SV_DESERROR OUT NOCOPY VARCHAR2);

        procedure PV_FACHADA_VB_PR(EN_NUM_MOVIMIENTO              IN  ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE,
                                                           EN_NUM_ABONADO                 IN  ICC_MOVIMIENTO.NUM_ABONADO%TYPE,
                                                           EN_COD_ESTADO                  IN  ICC_MOVIMIENTO.COD_ESTADO%TYPE,
                                                           EV_COD_ACTABO                  IN  ICC_MOVIMIENTO.COD_ACTABO%TYPE,
                                                           EV_COD_MODULO                  IN  ICC_MOVIMIENTO.COD_MODULO%TYPE,
                                                           EN_NUM_INTENTOS                IN  ICC_MOVIMIENTO.NUM_INTENTOS%TYPE,
                                                           EN_COD_CENTRAL_NUE             IN  ICC_MOVIMIENTO.COD_CENTRAL_NUE%TYPE,
                                                           EV_DES_RESPUESTA           IN  ICC_MOVIMIENTO.DES_RESPUESTA%TYPE,
                                                           EN_COD_ACTUACION           IN  ICC_MOVIMIENTO.COD_ACTUACION%TYPE,
                                                           EV_NOM_USUARORA            IN  ICC_MOVIMIENTO.NOM_USUARORA%TYPE,
                                                           EV_FEC_INGRESO                         IN  ICC_MOVIMIENTO.FEC_INGRESO%TYPE,
                                                           EV_TIP_TERMINAL                        IN  ICC_MOVIMIENTO.TIP_TERMINAL%TYPE,
                                                           EN_COD_CENTRAL                         IN  ICC_MOVIMIENTO.COD_CENTRAL%TYPE,
                                                           EV_FEC_LECTURA                         IN  ICC_MOVIMIENTO.FEC_LECTURA%TYPE,
                                                           EN_IND_BLOQUEO                         IN  ICC_MOVIMIENTO.IND_BLOQUEO%TYPE,
                                                           EV_FEC_EJECUCION               IN  ICC_MOVIMIENTO.FEC_EJECUCION%TYPE,
                                                           EV_TIP_TERMINAL_NUE            IN  ICC_MOVIMIENTO.TIP_TERMINAL_NUE%TYPE,
                                                           EN_NUM_MOVANT                          IN  ICC_MOVIMIENTO.NUM_MOVANT%TYPE,
                                                           EN_NUM_CELULAR                         IN  ICC_MOVIMIENTO.NUM_CELULAR%TYPE,
                                                           EN_NUM_MOVPOS                          IN  ICC_MOVIMIENTO.NUM_MOVPOS%TYPE,
                                                           EV_NUM_SERIE                           IN  ICC_MOVIMIENTO.NUM_SERIE%TYPE,
                                                           EV_NUM_PERSONAL                        IN  ICC_MOVIMIENTO.NUM_PERSONAL%TYPE,
                                                           EN_NUM_CELULAR_NUE             IN  ICC_MOVIMIENTO.NUM_CELULAR_NUE%TYPE,
                                                           EV_NUM_SERIE_NUE                       IN  ICC_MOVIMIENTO.NUM_SERIE_NUE%TYPE,
                                                           EV_NUM_PERSONAL_NUE            IN  ICC_MOVIMIENTO.NUM_PERSONAL_NUE%TYPE,
                                                           EV_NUM_MSNB                            IN  ICC_MOVIMIENTO.NUM_MSNB%TYPE,
                                                           EV_NUM_MSNB_NUE                        IN  ICC_MOVIMIENTO.NUM_MSNB_NUE%TYPE,
                                                           EV_COD_SUSPREHA                        IN  ICC_MOVIMIENTO.COD_SUSPREHA%TYPE,
                                                           EV_COD_SERVICIOS                       IN  ICC_MOVIMIENTO.COD_SERVICIOS%TYPE,
                                                           EV_NUM_MIN                             IN  ICC_MOVIMIENTO.NUM_MIN%TYPE,
                                                           EV_NUM_MIN_NUE                         IN  ICC_MOVIMIENTO.NUM_MIN%TYPE,
                                                           EV_STA                                         IN  ICC_MOVIMIENTO.STA%TYPE,
                                                           EN_COD_MENSAJE                         IN  ICC_MOVIMIENTO.COD_MENSAJE%TYPE,
                                                           EV_PARAM1_MENS                         IN  ICC_MOVIMIENTO.PARAM1_MENS%TYPE,
                                                           EV_PARAM2_MENS                         IN  ICC_MOVIMIENTO.PARAM2_MENS%TYPE,
                                                           EV_PARAM3_MENS                         IN  ICC_MOVIMIENTO.PARAM3_MENS%TYPE,
                                                           EV_PLAN                                        IN  ICC_MOVIMIENTO.PLAN%TYPE,
                                                           EN_CARGA                                       IN  ICC_MOVIMIENTO.CARGA%TYPE,
                                                           EN_VALOR_PLAN                          IN  ICC_MOVIMIENTO.VALOR_PLAN%TYPE,
                                                           EV_PIN                                         IN  ICC_MOVIMIENTO.PIN%TYPE,
                                                           EV_FEC_EXPIRA                          IN  ICC_MOVIMIENTO.FEC_EXPIRA%TYPE,
                                                           EV_DES_MENSAJE                         IN  ICC_MOVIMIENTO.DES_MENSAJE%TYPE,
                                                           EV_COD_PIN                             IN  ICC_MOVIMIENTO.COD_PIN%TYPE,
                                                           EV_COD_IDIOMA                          IN  ICC_MOVIMIENTO.COD_IDIOMA%TYPE,
                                                           EN_COD_ENRUTAMIENTO            IN  ICC_MOVIMIENTO.COD_ENRUTAMIENTO%TYPE,
                                                           EN_TIP_ENRUTAMIENTO            IN  ICC_MOVIMIENTO.TIP_ENRUTAMIENTO%TYPE,
                                                           EV_DES_ORIGEN_PIN              IN  ICC_MOVIMIENTO.DES_ORIGEN_PIN%TYPE,
                                                           EN_NUM_LOTE_PIN                        IN  ICC_MOVIMIENTO.NUM_LOTE_PIN%TYPE,
                                                           EV_NUM_SERIE_PIN                       IN  ICC_MOVIMIENTO.NUM_SERIE_PIN%TYPE,
                                                           EV_TIP_TECNOLOGIA              IN  ICC_MOVIMIENTO.TIP_TECNOLOGIA%TYPE,
                                                           EV_IMSI                                        IN  ICC_MOVIMIENTO.IMSI%TYPE,
                                                           EV_IMSI_NUE                            IN  ICC_MOVIMIENTO.IMSI_NUE%TYPE,
                                                           EV_IMEI                                        IN  ICC_MOVIMIENTO.IMEI%TYPE,
                                                           EV_IMEI_NUE                            IN  ICC_MOVIMIENTO.IMEI_NUE%TYPE,
                                                           EV_ICC                                         IN  ICC_MOVIMIENTO.ICC%TYPE,
                                                           EV_ICC_NUE                             IN  ICC_MOVIMIENTO.ICC_NUE%TYPE
                                                           );


END PV_FACHADA_ACTRESPUESTA_PG;
/
SHOW ERRORS
