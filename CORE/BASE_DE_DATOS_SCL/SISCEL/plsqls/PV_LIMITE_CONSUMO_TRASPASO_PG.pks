CREATE OR REPLACE PACKAGE PV_LIMITE_CONSUMO_TRASPASO_PG IS


PROCEDURE PV_MODIFICA_LC_PR(pnSujeto IN NUMBER,
                            pvTipSujeto IN VARCHAR2,
                                                        pvLcNuevo IN VARCHAR2,
                                                        pvCausaHist IN VARCHAR2,
                                                        pvFecDesde      IN VARCHAR2,
                                                        pvFecHasta  IN VARCHAR2,
                                                        pvimp_limcons IN NUMBER,
                                                        pvCodValor OUT NOCOPY VARCHAR2,
                                                        pvErrorAplic OUT NOCOPY VARCHAR2,
                                                        pvErrorGlosa OUT NOCOPY VARCHAR2,
                                                        pvErrorOra OUT NOCOPY VARCHAR2,
                                                        pvErrorOraGlosa OUT NOCOPY VARCHAR2,
                                                        pvTrace OUT NOCOPY VARCHAR2, -- AHOTT 30-01-2006 - RA-633
                                                        EVCodplantarif  IN VARCHAR2:=NULL -- AHOTT 30-01-2006 - RA-633
                                                        ,EVTipoMovimiento IN VARCHAR2:=NULL ); -- Ahott 14-02-2006 RA-759


PROCEDURE PV_MODIFICA_LCCICLO_PR(pnSujeto        IN NUMBER,     
                            pvTipSujeto     IN VARCHAR2,        
                            pvLcNuevo       IN VARCHAR2,        
                            pvCausaHist     IN VARCHAR2,        
                            pvFecDesde      IN VARCHAR2,        
                            pvFecHasta      IN VARCHAR2,  
                            EVCodplantarif  IN VARCHAR2:=NULL,   
                            EVTipoMovimiento IN VARCHAR2:=NULL,      
                            pvimp_limcons   IN NUMBER,          
                            pvCodValor      OUT NOCOPY VARCHAR2,
                            pvErrorAplic    OUT NOCOPY VARCHAR2,
                            pvErrorGlosa    OUT NOCOPY VARCHAR2,
                            pvErrorOra      OUT NOCOPY VARCHAR2,
                            pvErrorOraGlosa OUT NOCOPY VARCHAR2,
                            pvTrace         OUT NOCOPY VARCHAR2
                            );


PROCEDURE PV_OPERA_LIMITE_PR(pnSujeto        IN  NUMBER,
                             pvTipSujeto     IN  VARCHAR2,
                                                         pvFecDesde      IN  VARCHAR2,
                                                         pvFecHasta      IN  VARCHAR2,
                                                         pvCodActabo     IN  VARCHAR2,
                                                         pvCodPlantarif  IN  VARCHAR2,
                                                         pvTipMovimiento IN  VARCHAR2,
                                                         pvcod_limcons   IN  VARCHAR2,
                                                         pvimp_limcons   IN  NUMBER,
                                                         pvCodValor      OUT NOCOPY VARCHAR2,
                                                         pvErrorAplic    OUT NOCOPY VARCHAR2,
                                                         pvErrorGlosa    OUT NOCOPY VARCHAR2,
                                                         pvErrorOra      OUT NOCOPY VARCHAR2,
                                                         pvErrorOraGlosa OUT NOCOPY VARCHAR2,
                                                         pvTrace         OUT NOCOPY VARCHAR2);

/*
PROCEDURE PV_CLI_ABO_ORIGINAL_PR(pnSujeto        IN  NUMBER,
                                 pvabonado       OUT  NUMBER,
                                                         pv_cliente      OUT NOCOPY  NUMBER,
                                                         pvCodValor      OUT NOCOPY VARCHAR2,
                                                         pvErrorAplic    OUT NOCOPY VARCHAR2,
                                                         pvErrorGlosa    OUT NOCOPY VARCHAR2,
                                                         pvErrorOra      OUT NOCOPY VARCHAR2,
                                                         pvErrorOraGlosa OUT NOCOPY VARCHAR2,
                                                         pvTrace         OUT NOCOPY VARCHAR2);



FUNCTION PV_VALIDA_PWD_FN(pnSujeto    IN NUMBER,
                          pvTipSujeto IN VARCHAR2,
                                                  pvPasswd    IN VARCHAR2) RETURN VARCHAR2;

--INI COL-72899|09-12-2008|GEZ
PROCEDURE pv_cerrarlim_aciclo_ind_pr(         EN_NumAbonado        IN                                    ga_limite_cliabo_to.num_abonado%TYPE,
                                                             EN_CodCliente             IN                                     ga_limite_cliabo_to.cod_cliente%TYPE,
                                                             EV_CodPlanAct            IN                                   ga_limite_cliabo_to.cod_plantarif%TYPE,
                                                             SV_Estado                   OUT NOCOPY                  VARCHAR2,
                                                             SV_Proc                      OUT NOCOPY                   VARCHAR2,
                                                             SN_CodMsg                 OUT NOCOPY                NUMBER,
                                                             SN_Evento                   OUT NOCOPY                  NUMBER,
                                                             SV_Tabla                   OUT NOCOPY                  VARCHAR2,
                                                             SV_Act                         OUT NOCOPY                VARCHAR2,
                                                             SV_Code                   OUT NOCOPY                  VARCHAR2,
                                                             SV_Errm                   OUT NOCOPY                  VARCHAR2   );

PROCEDURE pv_eliminarlim_aciclo_ind_pr(EN_NumAbonado        IN ga_limite_cliabo_to.num_abonado%TYPE,
                                                               EN_CodCliente              IN ga_limite_cliabo_to.cod_cliente%TYPE,
                                                               EV_CodPlanFut             IN ga_limite_cliabo_to.cod_plantarif%TYPE,
                                                               SV_Estado                   OUT NOCOPY                  VARCHAR2,
                                                            SV_Proc                          OUT NOCOPY                   VARCHAR2,
                                                            SN_CodMsg                 OUT NOCOPY                NUMBER,
                                                            SN_Evento                   OUT NOCOPY                  NUMBER,
                                                            SV_Tabla                    OUT NOCOPY                  VARCHAR2,
                                                            SV_Act                         OUT NOCOPY                VARCHAR2,
                                                            SV_Code                       OUT NOCOPY                  VARCHAR2,
                                                            SV_Errm                       OUT NOCOPY                  VARCHAR2   );

PROCEDURE pv_crealim_aciclo_ind_pr(EN_NumAbonado       IN ga_limite_cliabo_to.num_abonado%TYPE,
                                                         EN_CodCliente            IN ga_limite_cliabo_to.cod_cliente%TYPE,
                                                         EV_CodPlanFut           IN  ga_limite_cliabo_to.cod_plantarif%TYPE,
                                                            SV_Estado                 OUT NOCOPY            VARCHAR2,
                                                         SV_Proc                    OUT NOCOPY             VARCHAR2,
                                                         SN_CodMsg               OUT NOCOPY              NUMBER,
                                                         SN_Evento                 OUT NOCOPY            NUMBER,
                                                         SV_Tabla                  OUT NOCOPY            VARCHAR2,
                                                         SV_Act                        OUT NOCOPY              VARCHAR2,
                                                         SV_Code                  OUT NOCOPY            VARCHAR2,
                                                         SV_Errm                  OUT NOCOPY            VARCHAR2   );

PROCEDURE pv_cerrarlim_linea_ind_pr(  EN_NumAbonado       IN                         ga_limite_cliabo_to.num_abonado%TYPE,
                                                            EN_CodCliente        IN                         ga_limite_cliabo_to.cod_cliente%TYPE,
                                                            EV_CodPlanAct       IN                         ga_limite_cliabo_to.cod_plantarif%TYPE,
                                                            ED_FecHasta         IN                            DATE,
                                                            SV_Estado             OUT NOCOPY            VARCHAR2,
                                                            SV_Proc                    OUT NOCOPY             VARCHAR2,
                                                            SN_CodMsg           OUT NOCOPY              NUMBER,
                                                            SN_Evento             OUT NOCOPY            NUMBER,
                                                            SV_Tabla             OUT NOCOPY            VARCHAR2,
                                                            SV_Act                   OUT NOCOPY              VARCHAR2,
                                                            SV_Code                 OUT NOCOPY            VARCHAR2,
                                                            SV_Errm                 OUT NOCOPY            VARCHAR2   ) ;

PROCEDURE pv_crealim_linea_ind_pr(EN_NumAbonado         IN                          ga_limite_cliabo_to.num_abonado%TYPE,
                                                       EN_CodCliente         IN                          ga_limite_cliabo_to.cod_cliente%TYPE,
                                                       EV_CodPlanFut        IN                          ga_limite_cliabo_to.cod_plantarif%TYPE,
                                                       ED_FecDesde          IN                           DATE,
                                                       SV_Estado             OUT NOCOPY            VARCHAR2,
                                                       SV_Proc                    OUT NOCOPY             VARCHAR2,
                                                       SN_CodMsg           OUT NOCOPY              NUMBER,
                                                       SN_Evento             OUT NOCOPY            NUMBER,
                                                       SV_Tabla                 OUT NOCOPY            VARCHAR2,
                                                       SV_Act                   OUT NOCOPY              VARCHAR2,
                                                       SV_Code                 OUT NOCOPY            VARCHAR2,
                                                       SV_Errm                 OUT NOCOPY            VARCHAR2   ) ;

PROCEDURE pv_cerrarlim_linea_emp_pr( EN_NumAbonado     IN                         ga_limite_cliabo_to.num_abonado%TYPE,
                                                            EN_CodCliente        IN                         ga_limite_cliabo_to.cod_cliente%TYPE,
                                                            EV_CodPlanAct       IN                         ga_limite_cliabo_to.cod_plantarif%TYPE,
                                                            ED_FecHasta         IN                            DATE,
                                                            SV_Estado             OUT NOCOPY            VARCHAR2,
                                                            SV_Proc                    OUT NOCOPY             VARCHAR2,
                                                            SN_CodMsg           OUT NOCOPY              NUMBER,
                                                            SN_Evento             OUT NOCOPY            NUMBER,
                                                            SV_Tabla             OUT NOCOPY            VARCHAR2,
                                                            SV_Act                   OUT NOCOPY              VARCHAR2,
                                                            SV_Code                 OUT NOCOPY            VARCHAR2,
                                                            SV_Errm                 OUT NOCOPY            VARCHAR2   );

PROCEDURE pv_cerrarlim_aciclo_emp_pr( EN_NumAbonado          IN                                    ga_limite_cliabo_to.num_abonado%TYPE,
                                                             EN_CodCliente             IN                                     ga_limite_cliabo_to.cod_cliente%TYPE,
                                                             EV_CodPlanAct            IN                                   ga_limite_cliabo_to.cod_plantarif%TYPE,
                                                             SV_Estado                   OUT NOCOPY                  VARCHAR2,
                                                             SV_Proc                      OUT NOCOPY                   VARCHAR2,
                                                             SN_CodMsg                 OUT NOCOPY                NUMBER,
                                                             SN_Evento                   OUT NOCOPY                  NUMBER,
                                                             SV_Tabla                   OUT NOCOPY                  VARCHAR2,
                                                             SV_Act                         OUT NOCOPY                VARCHAR2,
                                                             SV_Code                   OUT NOCOPY                  VARCHAR2,
                                                             SV_Errm                   OUT NOCOPY                  VARCHAR2   );

PROCEDURE pv_eliminarlim_aciclo_emp_pr(EN_NumAbonado      IN                               ga_limite_cliabo_to.num_abonado%TYPE,
                                                               EN_CodCliente              IN                               ga_limite_cliabo_to.cod_cliente%TYPE,
                                                               EV_CodPlanFut             IN                               ga_limite_cliabo_to.cod_plantarif%TYPE,
                                                               SV_Estado                   OUT NOCOPY                  VARCHAR2,
                                                            SV_Proc                          OUT NOCOPY                   VARCHAR2,
                                                            SN_CodMsg                 OUT NOCOPY                NUMBER,
                                                            SN_Evento                   OUT NOCOPY                  NUMBER,
                                                            SV_Tabla                    OUT NOCOPY                  VARCHAR2,
                                                            SV_Act                         OUT NOCOPY                VARCHAR2,
                                                            SV_Code                       OUT NOCOPY                  VARCHAR2,
                                                            SV_Errm                       OUT NOCOPY                  VARCHAR2   );

PROCEDURE pv_crealim_linea_emp_pr(EN_NumAbonado       IN                          ga_limite_cliabo_to.num_abonado%TYPE,
                                                       EN_CodCliente         IN                          ga_limite_cliabo_to.cod_cliente%TYPE,
                                                       EV_CodPlanFut        IN                          ga_limite_cliabo_to.cod_plantarif%TYPE,
                                                       SV_Estado             OUT NOCOPY            VARCHAR2,
                                                       SV_Proc                    OUT NOCOPY             VARCHAR2,
                                                       SN_CodMsg           OUT NOCOPY              NUMBER,
                                                       SN_Evento             OUT NOCOPY            NUMBER,
                                                       SV_Tabla                 OUT NOCOPY            VARCHAR2,
                                                       SV_Act                   OUT NOCOPY              VARCHAR2,
                                                       SV_Code                 OUT NOCOPY            VARCHAR2,
                                                       SV_Errm                 OUT NOCOPY            VARCHAR2   );

PROCEDURE pv_crealim_aciclo_emp_pr(EN_NumAbonado      IN                          ga_limite_cliabo_to.num_abonado%TYPE,
                                                         EN_CodCliente            IN                            ga_limite_cliabo_to.cod_cliente%TYPE,
                                                         EV_CodPlanFut           IN                            ga_limite_cliabo_to.cod_plantarif%TYPE,
                                                            SV_Estado                 OUT NOCOPY            VARCHAR2,
                                                         SV_Proc                    OUT NOCOPY             VARCHAR2,
                                                         SN_CodMsg               OUT NOCOPY              NUMBER,
                                                         SN_Evento                 OUT NOCOPY            NUMBER,
                                                         SV_Tabla                 OUT NOCOPY            VARCHAR2,
                                                         SV_Act                       OUT NOCOPY              VARCHAR2,
                                                         SV_Code                 OUT NOCOPY            VARCHAR2,
                                                         SV_Errm                  OUT NOCOPY            VARCHAR2   );

--FIN COL-72899|09-12-2008|GEZ

--INI COL-77228|03-02-2009|AVC
PROCEDURE Pv_Del_Reglimcons_Vigente_Pr(EN_Sujeto      IN                NUMBER,
                                         EV_TipSujeto  IN                VARCHAR2,
                                         SVEstado         OUT NOCOPY     VARCHAR2,
                                       SVProc         OUT NOCOPY     VARCHAR2,
                                       SNCodMsg         OUT NOCOPY     NUMBER,
                                       SNEvento         OUT NOCOPY     NUMBER,
                                       SVTabla         OUT NOCOPY     VARCHAR2,
                                       SVAct         OUT NOCOPY     VARCHAR2,
                                       SVCode         OUT NOCOPY     VARCHAR2,
                                       SVErrm         OUT NOCOPY     VARCHAR2);

PROCEDURE pv_del_reglimcons_doble_pr(
                                              EN_Sujeto      IN                NUMBER,
                                         EV_TipSujeto  IN                VARCHAR2,
                                       EV_Plan         IN                VARCHAR2,
                                         SVEstado         OUT NOCOPY     VARCHAR2,
                                       SVProc         OUT NOCOPY     VARCHAR2,
                                       SNCodMsg         OUT NOCOPY     NUMBER,
                                       SNEvento         OUT NOCOPY     NUMBER,
                                       SVTabla         OUT NOCOPY     VARCHAR2,
                                       SVAct         OUT NOCOPY     VARCHAR2,
                                       SVCode         OUT NOCOPY     VARCHAR2,
                                       SVErrm         OUT NOCOPY     VARCHAR2);

PROCEDURE pv_pasohist_aciclo_limcons_pr(EN_Cliente          IN  GA_ABOCEL.cod_cliente%TYPE,
                                           EN_Abonado         IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                                        EV_CausaHist     IN  VARCHAR2,
                                        SVEstado         OUT NOCOPY VARCHAR2,
                                          SVProc             OUT NOCOPY VARCHAR2,
                                        SNCodMsg         OUT NOCOPY NUMBER,
                                        SNEvento         OUT NOCOPY NUMBER,
                                        SVTabla             OUT NOCOPY VARCHAR2,
                                        SVAct             OUT NOCOPY VARCHAR2,
                                        SVCode             OUT NOCOPY VARCHAR2,
                                        SVErrm             OUT NOCOPY VARCHAR2);

--FIN COL-77228|03-02-2009|AVC
*/
END PV_LIMITE_CONSUMO_TRASPASO_PG; 
/
SHOW ERROR