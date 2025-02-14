CREATE OR REPLACE PACKAGE PV_IMPORTE_CAUSAGARANTIA_PG
 IS

PROCEDURE PV_IMPORTE_CAUSAGARANTIA_PR (TN_NumAbonado           IN       GA_ABOCEL.num_abonado%TYPE,
                                                                                                          TV_NumSerie                     IN    GA_ABOCEL.num_serie%TYPE,
                                                                                                          TN_NumCargo                     IN    GE_CARGOS.num_cargo%TYPE,
                                                                                                          TN_IMPORTE                      OUT   NOCOPY VARCHAR2,
                                                                                                          TN_TIPDTO                               OUT   NOCOPY VARCHAR2,
                                                                                                          TN_VALDTO                               OUT   NOCOPY VARCHAR2,
                                                                                                          SV_CODERROR                     OUT   NOCOPY VARCHAR2,
                                                                                                          SV_MESERROR                     OUT   NOCOPY VARCHAR2
                                                                                                   );
END PV_IMPORTE_CAUSAGARANTIA_PG;
/
SHOW ERRORS
