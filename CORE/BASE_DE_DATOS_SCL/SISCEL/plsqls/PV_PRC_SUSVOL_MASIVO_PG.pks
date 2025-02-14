CREATE OR REPLACE PACKAGE PV_PRC_SUSVOL_MASIVO_PG IS

TYPE refCursor 	IS REF CURSOR;
   CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
   CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'PV';
   CV_version              CONSTANT VARCHAR2 (2)  := '1';
   CV_cod_aplic            CONSTANT VARCHAR2 (3)  := 'PVA';
   CN_producto             CONSTANT NUMBER        := 1;
   CN_0                    CONSTANT NUMBER (1)     :=  0;
   CV_0                    CONSTANT VARCHAR2 (1)   := '0';
   CV_1                    CONSTANT VARCHAR2 (1)   := '1';



PROCEDURE PV_PRC_SUSVOL_MASIVO_PR( 
                                   VP_COD_OS        IN VARCHAR2,
                                   VP_RESULTADO     IN OUT NOCOPY INTEGER,
                                   VP_SQLCODE       IN OUT NOCOPY VARCHAR2,
                                   VP_SQLERRM       IN OUT NOCOPY VARCHAR2);





PROCEDURE PV_PRC_PROCSUSVOL_PR( 
                              VP_NUM_ABONADO     IN    ICC_MOVIMIENTO.NUM_ABONADO%TYPE,
                              VP_FEC_EJECUCION     IN    PV_INTERFAZ_SUSVOL_TO.FEC_EJECUCION%TYPE,  
                              VP_COD_ESTADO        IN    PV_INTERFAZ_SUSVOL_TO.COD_ESTADO%TYPE,
                              VP_COD_ACTABO        IN    ICC_MOVIMIENTO.COD_ACTABO%TYPE,
                              VP_FEC_PROCESO       IN    PV_INTERFAZ_SUSVOL_TO.FEC_PROCESO%TYPE,
                              VP_NOM_USUARIO       IN    ICC_MOVIMIENTO.NOM_USUARORA%TYPE,
                              VP_NUM_OS            IN    CI_ORSERV.NUM_OS%TYPE,
                              VP_COD_CAUSA         IN    PV_INTERFAZ_SUSVOL_TO.COD_CAUSA%TYPE,  
                              VP_COD_FRAUDE        IN    PV_INTERFAZ_SUSVOL_TO.COD_FRAUDE%TYPE,
                              VP_COD_SERVICIOS     IN    PV_INTERFAZ_SUSVOL_TO.COD_SERVICIOS%TYPE,  
                              VP_IND_CENTRAL       IN    PV_INTERFAZ_SUSVOL_TO.IND_CENTRAL%TYPE,  
                              VP_COMENTARIO        IN    PV_INTERFAZ_SUSVOL_TO.COMENTARIO%TYPE, 
                              VP_BDATOS            IN    PV_INTERFAZ_SUSVOL_TO.BDATOS%TYPE,
                              VP_FEC_REHABILITA    IN    PV_INTERFAZ_SUSVOL_TO.FEC_REHABILITA%TYPE,
                              VP_TIP_SUSP          IN    PV_INTERFAZ_SUSVOL_TO.TIP_SUSP%TYPE,
                              VP_COD_OS            IN    PV_INTERFAZ_SUSVOL_TO.COD_OS%TYPE,
                              VP_RESULTADO         IN OUT NOCOPY INTEGER, 
                              VP_SQLCODE           IN OUT NOCOPY VARCHAR2,   
                              VP_SQLERRM           IN OUT NOCOPY VARCHAR2);

PROCEDURE PV_PRC_VALIDADATOS_PR(
                              VP_NUM_ABONADO     IN    ICC_MOVIMIENTO.NUM_ABONADO%TYPE,
                              VP_FEC_EJECUCION     IN    PV_INTERFAZ_SUSVOL_TO.FEC_EJECUCION%TYPE,  
                              VP_COD_CAUSA         IN    PV_INTERFAZ_SUSVOL_TO.COD_CAUSA%TYPE,  
                              VP_COD_FRAUDE        IN    PV_INTERFAZ_SUSVOL_TO.COD_FRAUDE%TYPE,
                              VP_COD_SERVICIOS     IN    PV_INTERFAZ_SUSVOL_TO.COD_SERVICIOS%TYPE,  
                              VP_FEC_REHABILITA    IN    PV_INTERFAZ_SUSVOL_TO.FEC_REHABILITA%TYPE,
                              VP_TIP_SUSP          IN    PV_INTERFAZ_SUSVOL_TO.TIP_SUSP%TYPE,
                              VP_RESULTADO         IN OUT NOCOPY INTEGER, 
                              VP_SQLCODE           IN OUT NOCOPY VARCHAR2,   
                              VP_SQLERRM           IN OUT NOCOPY VARCHAR2);
                            
PROCEDURE PV_VALIDA_SUSPENSIONES_PARCIAL(
                              VP_NUM_ABONADO       IN    ICC_MOVIMIENTO.NUM_ABONADO%TYPE,
                              VP_RESULTADO         IN OUT NOCOPY INTEGER, 
                              VP_SQLCODE           IN OUT NOCOPY VARCHAR2,   
                              VP_SQLERRM           IN OUT NOCOPY VARCHAR2);



END PV_PRC_SUSVOL_MASIVO_PG;
/
SHOW ERRORS