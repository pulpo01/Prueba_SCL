CREATE OR REPLACE PACKAGE PV_CamNum_PG IS

PROCEDURE PV_CNUM_CABECERA_ODBC (
                                 sNumTransaccion IN VARCHAR2,
                                 sNomTablaAbo    IN VARCHAR2,
                                 sNumAbonado     IN VARCHAR2,
                                 sNumCelular     IN VARCHAR2,
                                 sRegNue         IN VARCHAR2,
                                 sProvNUe        IN VARCHAR2,
                                 sCiudNue        IN VARCHAR2,
                                 sCeldNue        IN VARCHAR2,
                                 sCentNue        IN VARCHAR2,
                                 sUsoNue         IN VARCHAR2,
                                 sNumMinMdnNue   IN VARCHAR2,
                                 sIdUser         IN VARCHAR2,
                                 sCodProducto    IN VARCHAR2,
                                 sInsertaMov     IN VARCHAR2,
                                 sActualiAbo     IN VARCHAR2,
                                 sCod_Actabo	 IN VARCHAR2
                                );



PROCEDURE PV_CNUM_CABECERA_ADO (
                                sNomTablaAbo    IN VARCHAR2,
                                sNumAbonado     IN VARCHAR2,
                                sNumCelular     IN VARCHAR2,
                                sRegNue         IN VARCHAR2,
                                sProvNUe        IN VARCHAR2,
                                sCiudNue        IN VARCHAR2,
                                sCeldNue        IN VARCHAR2,
                                sCentNue        IN VARCHAR2,
                                sUsoNue         IN VARCHAR2,
                                sNumMinMdnNue   IN VARCHAR2,
                                sIdUser         IN VARCHAR2,
                                sCodProducto    IN VARCHAR2,
                                sInsertaMov     IN VARCHAR2,
                                sActualiAbo     IN VARCHAR2,
                                sCod_Actabo	IN VARCHAR2,
                                sNumMov        OUT NOCOPY VARCHAR2,
                                sError         OUT NOCOPY VARCHAR2,
                                sGlosa         OUT NOCOPY VARCHAR2,
                                sOraGlosa      OUT NOCOPY VARCHAR2
                               );



PROCEDURE PV_CNUM_CELNUM_AUTO_ODBC (
                                    sNumTransaccion IN VARCHAR2,
                                    sCeldNue        IN VARCHAR2,
                                    sCentNue        IN VARCHAR2,
                                    sCodUsoNue      IN VARCHAR2,
                                    sCod_Actabo     IN VARCHAR2
                                   );



PROCEDURE PV_CNUM_CELNUM_AUTO_ADO (
                                   sCeldNue       IN VARCHAR2,
                                   sCentNue       IN VARCHAR2,
                                   sCodUsoNue     IN VARCHAR2,
                                   sCod_Actabo	  IN VARCHAR2,
                                   sCodSubalmNue OUT NOCOPY VARCHAR2,
                                   sNumCelular   OUT NOCOPY VARCHAR2,
                                   sTabla        OUT NOCOPY VARCHAR2,
                                   sCodCatNue    OUT NOCOPY VARCHAR2,
                                   sFecBaja      OUT NOCOPY VARCHAR2,
                                   sError        OUT NOCOPY VARCHAR2,
                                   sGlosa        OUT NOCOPY VARCHAR2,
                                   sOraGlosa     OUT NOCOPY VARCHAR2
                                  );



PROCEDURE PV_CNUM_CARGA_INICIAL (
                                 sNumAbonado       IN NUMBER,
                                 sNomTablaAbo      IN VARCHAR2,
                                 sNumCelular       IN NUMBER,
                                 nNumCelOrig      OUT NOCOPY NUMBER,
                                 sRegOrig         OUT NOCOPY VARCHAR2,
                                 sProvOrig        OUT NOCOPY VARCHAR2,
                                 sCiudOrig        OUT NOCOPY VARCHAR2,
                                 sCeldOrig        OUT NOCOPY VARCHAR2,
                                 sCentOrig        OUT NOCOPY VARCHAR2,
                                 nCodUsoOrig      OUT NOCOPY NUMBER,
                                 sNumMinOrig      OUT NOCOPY VARCHAR2,
                                 sNumMinMdnOrig   OUT NOCOPY VARCHAR2,
                                 sNumMinNue       OUT NOCOPY VARCHAR2,
                                 sCodSubalmOrig   OUT NOCOPY VARCHAR2,
                                 nCodCatOrig      OUT NOCOPY NUMBER,
                                 nCodUsoOrig2     OUT NOCOPY NUMBER,
                                 sTipTermOrig     OUT NOCOPY VARCHAR2,
                                 sCodTiplan       OUT NOCOPY VARCHAR2,
                                 sTecnologia      OUT NOCOPY VARCHAR2,
                                 sNumImei         OUT NOCOPY VARCHAR2,
                                 sNumSerieHexOrig OUT NOCOPY VARCHAR2,
                                 sNumSerieOrig    OUT NOCOPY VARCHAR2,
                                 nNumAbonado      OUT NOCOPY NUMBER,
                                 nNumCelular      OUT NOCOPY NUMBER,
                                 sNumCelOrig      OUT NOCOPY VARCHAR2,
                                 sCodActabo       OUT NOCOPY VARCHAR2,
                                 sProcequiOrig    OUT NOCOPY VARCHAR2,
				 sClaseServicio   OUT NOCOPY VARCHAR2,
                                 sError        IN OUT NOCOPY VARCHAR2,
                                 sGlosa        IN OUT NOCOPY VARCHAR2,
                                 sOraGlosa     IN OUT NOCOPY VARCHAR2
                                );



PROCEDURE PV_CNUM_ACT_ABONADO (
                               sRegNue         IN VARCHAR2,
                               sProvnue        IN VARCHAR2,
                               sCiudNue        IN VARCHAR2,
                               sCeldNue        IN VARCHAR2,
                               sCenNue         IN VARCHAR2,
                               nNumCelular     IN NUMBER,
                               nNumCelOrig     IN NUMBER,
                               sCodUsoNue      IN VARCHAR2,
                               sNumMinNue      IN VARCHAR2,
                               sNumMinMdnNvo   IN VARCHAR2,
                               nNumAbonado     IN NUMBER,
                               sNomTablaAbo    IN VARCHAR2,
                               sActualiAbo     IN VARCHAR2,
                               sError      IN OUT NOCOPY VARCHAR2,
                               sGlosa      IN OUT NOCOPY VARCHAR2,
                               sOraGlosa   IN OUT NOCOPY VARCHAR2
                              );



PROCEDURE PV_CNUM_INS_MODABOCEL (
                                 sNumAbonado    IN VARCHAR2,
                                 sRegOrig       IN VARCHAR2,
                                 sRegNue        IN VARCHAR2,
                                 sProvOrig      IN VARCHAR2,
                                 sProvNue       IN VARCHAR2,
                                 sCiudOrig      IN VARCHAR2,
                                 sCiudNue       IN VARCHAR2,
                                 sCeldOrig      IN VARCHAR2,
                                 sCeldNue       IN VARCHAR2,
                                 sCentOrig      IN VARCHAR2,
                                 sCentNue       IN VARCHAR2,
                                 nNumCelOrig    IN NUMBER,
                                 nNumCelular    IN NUMBER,
                                 nCodUsoOrig    IN NUMBER,
                                 nCodUsoNue     IN NUMBER,
                                 sNumMinOrig    IN VARCHAR2,
                                 sNumMinNue     IN VARCHAR2,
                                 sNumMinMdnOrig IN VARCHAR2,
                                 sNumMinMdnNue  IN VARCHAR2,
                                 sIdUser        IN VARCHAR2,
                                 sError     IN OUT NOCOPY VARCHAR2,
                                 sGlosa     IN OUT NOCOPY VARCHAR2,
                                 sOraGlosa  IN OUT NOCOPY VARCHAR2
                                );



PROCEDURE PV_CNUM_INS_REUTIL (
                              nNumCelOrig     IN NUMBER,
                              sCodSubalmOrig  IN VARCHAR2,
                              sCentOrig       IN VARCHAR2,
                              nCodCatOrig     IN NUMBER,
                              nCodUsoOrig     IN NUMBER,
                              nCodUsoOrig2    IN NUMBER,
                              sError      IN OUT NOCOPY VARCHAR2,
                              sGlosa      IN OUT NOCOPY VARCHAR2,
                              sOraGlosa   IN OUT NOCOPY VARCHAR2
                             );



PROCEDURE PV_CNUM_EJEC_CAMBCEN (
                                sNumAbonado     IN NUMBER,
                                sTipTermOrig    IN VARCHAR2,
                                sCodCentNue     IN VARCHAR2,
                                sClaseServicio OUT NOCOPY VARCHAR2,
                                sError      IN OUT NOCOPY VARCHAR2,
                                sGlosa      IN OUT NOCOPY VARCHAR2,
                                sOraGlosa   IN OUT NOCOPY VARCHAR2
                               );



PROCEDURE PV_CNUM_INS_MOVIMIENTO (
                                  sCodTiplan        IN VARCHAR2,
                                  nNumAbonado       IN NUMBER,
                                  sIdUser           IN VARCHAR2,
                                  sCentOrig         IN VARCHAR2,
                                  sCentNue          IN VARCHAR2,
                                  nNumCelOrig       IN NUMBER,
                                  nNumCelular       IN NUMBER,
                                  sNumSerieHexOrig  IN VARCHAR2,
                                  sNumSerieOrig     IN VARCHAR2,
                                  sClaseServicio    IN VARCHAR2,
                                  sTipTermOrig      IN VARCHAR2,
                                  sNumMinOrig       IN VARCHAR2,
                                  sNumMinNue        IN VARCHAR2,
                                  sTecnologia       IN VARCHAR2,
                                  sNumImei          IN VARCHAR2,
                                  sCodActabo        IN VARCHAR2,
                                  sNumMov          OUT NOCOPY VARCHAR2,
                                  sError        IN OUT NOCOPY VARCHAR2,
                                  sGlosa        IN OUT NOCOPY VARCHAR2,
                                  sOraGlosa     IN OUT NOCOPY VARCHAR2
                                 );



PROCEDURE PV_CNUM_EJEC_CAMBIO_NUMERO (
                                      sCodActabo     IN VARCHAR2,
                                      sNumAbonado    IN VARCHAR2,
                                      sNumCelular    IN VARCHAR2,
                                      sNomTablaAbo   IN VARCHAR2,
                                      sError     IN OUT NOCOPY VARCHAR2,
                                      sGlosa     IN OUT NOCOPY VARCHAR2,
                                      sOraGlosa  IN OUT NOCOPY VARCHAR2
                                     );



PROCEDURE PV_CNUM_AUTENTICACION (
                                 sNumSerieOrig   IN VARCHAR2,
                                 sProcequiOrig   IN VARCHAR2,
                                 nCodUsoOrig     IN NUMBER,
                                 sError      IN OUT NOCOPY VARCHAR2,
                                 sGlosa      IN OUT NOCOPY VARCHAR2,
                                 sOraGlosa   IN OUT NOCOPY VARCHAR2
                                );



PROCEDURE PV_CNUM_VALAUTENT (
                             v_secuencia      IN  ga_transacabo.NUM_TRANSACCION%type,
                             v_numserie       IN  VARCHAR2,
                             v_procedencia    IN  VARCHAR2,
                             v_coduso         IN  ga_abocel.COD_USO%TYPE
                            );



PROCEDURE PV_CNUM_RESCATA_CADENA (
                                  sCadena in varchar2,
                                  sSeparador in varchar2,
                                  s1 out NOCOPY varchar2,
                                  s2 out NOCOPY varchar2,
                                  s3 out NOCOPY varchar2,
                                  s4 out NOCOPY varchar2,
                                  s5 out NOCOPY varchar2,
                                  s6 out NOCOPY varchar2,
                                  s7 out NOCOPY varchar2,
                                  s8 out NOCOPY varchar2,
                                  s9 out NOCOPY varchar2
                                 );

END PV_CamNum_PG;
/
SHOW ERRORS
