CREATE OR REPLACE PACKAGE PV_CAMBIOPLAN_BATCH_PG IS

--pv_cambioplan_batch_pg v1.0 -- COL-37481|15-02-2007|GEZ
--pv_cambioplan_batch_pg v1.1 -- COL 73515|12-12-2008|GEZ

-- CN_Version_Header VARCHAR2(10):='01.01.00';  --COL-73376|21-01-2008|GEZ
CN_Version_Header VARCHAR2(10):='01.02.00';     --COL 77090|02-02-2009|SAQL

CV_error_no_clasif    VARCHAR2(30) := 'Error no Clasificado';
CV_codmodulo CONSTANT VARCHAR2(2)  := 'GA';

--INI COL 73515|12-12-2008|GEZ
PROCEDURE pv_cambio_plan_abo_pr(EN_NumOS 		IN		   			   pv_iorserv.num_os%TYPE,
		  											  SV_Estado			out NOCOPY 	    VARCHAR2,
													  SV_Proc			 out NOCOPY VARCHAR2,
													  SN_CodMsg		  out NOCOPY NUMBER,
													  SN_Evento		    out NOCOPY NUMBER,
													  SV_Tabla			out NOCOPY vARCHAR2,
													  SV_Act			  out NOCOPY VARCHAR2,
													  SV_Code			out NOCOPY VARCHAR2,
													  SV_Errm			out NOCOPY VARCHAR2);
--FIN COL 73515|12-12-2008|GEZ

FUNCTION pv_version_body_fn RETURN VARCHAR2;		  --COL-73376|21-01-2008|GEZ

FUNCTION pv_version_header_fn RETURN VARCHAR2;		 --COL-73376|21-01-2008|GEZ

PROCEDURE PV_ABOPLAN_EMP_BATCH_PR(EN_PRODUCTO     IN GA_ABOCEL.COD_PRODUCTO%TYPE,
                                        EN_NUM_ABONADO  IN ga_abocel.NUM_ABONADO%type,
                                        EN_EMPRESA      IN GA_ABOCEL.COD_EMPRESA%TYPE,
                                        EV_PLANTARIF    IN GA_ABOCEL.COD_PLANTARIF%TYPE,
                                        EV_FECSYS       IN DATE,
                                        SV_PROC         IN OUT NOCOPY VARCHAR2 ,
                                        SV_TABLA        IN OUT NOCOPY VARCHAR2 ,
                                        SV_ACT          IN OUT NOCOPY VARCHAR2 ,
                                        SV_SQLCODE      IN OUT NOCOPY VARCHAR2 ,
                                        SV_SQLERRM      IN OUT NOCOPY VARCHAR2 ,
                                        SV_ERROR        OUT NOCOPY VARCHAR2,
                                        SN_cod_retorno  OUT NOCOPY GE_ERRORES_PG.CodError,
                                        SV_mens_retorno OUT NOCOPY GE_ERRORES_PG.MsgError,
                                        SN_num_evento   OUT NOCOPY GE_ERRORES_PG.Evento);

PROCEDURE PV_ELIM_GA_FINCICLO_PEND_PR(EV_MOVIMIENTO   IN VARCHAR2,
                                        EN_NUM_OS       IN NUMBER ,
                                        EV_COD_OS       IN VARCHAR2,
                                        EV_FECSYS       IN OUT NOCOPY VARCHAR2 ,
                                        EN_CLIENTE      IN NUMBER ,
                                        EN_NUM_ABONADO  IN NUMBER ,
                                        SV_SQLCODE      IN OUT NOCOPY VARCHAR2 ,
                                        SV_SQLERRM      IN OUT NOCOPY VARCHAR2 ,
                                        SV_ERROR        IN OUT NOCOPY VARCHAR2,
                                        SN_cod_retorno  OUT NOCOPY GE_ERRORES_PG.CodError,
                                        SV_mens_retorno OUT NOCOPY GE_ERRORES_PG.MsgError,
                                        SN_num_evento   OUT NOCOPY GE_ERRORES_PG.Evento );


PROCEDURE PV_MODIFICA_EMPRESA_BATCH_PR(EN_PRODUCTO     IN NUMBER ,
                                        EN_EMPRESA      IN NUMBER ,
                                        EV_PLANTARIF    IN VARCHAR2 ,
                                        EN_CICLO        IN NUMBER ,
                                        EN_NUM_ABONADO  IN NUMBER ,
                                        EN_NUM_OS       IN NUMBER ,
                                        --SV_FECSYS       IN OUT NOCOPY varchar2 ,
                                        SV_PROC         IN OUT NOCOPY VARCHAR2 ,
                                        SV_TABLA        IN OUT NOCOPY VARCHAR2 ,
                                        SV_ACT          IN OUT NOCOPY VARCHAR2 ,
                                        SV_SQLCODE      IN OUT NOCOPY VARCHAR2 ,
                                        SV_SQLERRM      IN OUT NOCOPY VARCHAR2 ,
                                        SV_ERROR        IN OUT NOCOPY VARCHAR2 ,
                                        SN_cod_retorno  OUT NOCOPY GE_ERRORES_PG.CodError,
                                        SV_mens_retorno OUT NOCOPY GE_ERRORES_PG.MsgError,
                                        SN_num_evento   OUT NOCOPY GE_ERRORES_PG.Evento);



procedure PV_PLAN_TARIFARIO_BATCH_PR(EN_PRODUCTO       IN NUMBER ,
                                        EN_CLIENTE        IN NUMBER ,
                                        EN_ABONADO        IN NUMBER ,
                                        EV_TIPPLAN        IN VARCHAR2 ,
                                        EV_PLANTARIF      IN VARCHAR2 ,
                                        EN_CICLO          IN NUMBER ,
                                        --EV_FECSYS         IN DATE ,
                                        EN_NUM_OS       IN NUMBER ,
                                        EN_EMPRESA        IN NUMBER ,
                                        EN_HOLDING        IN NUMBER ,
                                        EV_TIPPLANTANT    IN VARCHAR2,
                                        EN_GRUPO          IN NUMBER ,
                                        SV_PROC           IN OUT NOCOPY VARCHAR2 ,
                                        SV_TABLA          IN OUT NOCOPY VARCHAR2 ,
                                        SV_ACT            IN OUT NOCOPY VARCHAR2 ,
                                        SV_SQLCODE        IN OUT NOCOPY VARCHAR2,
                                        SV_SQLERRM        IN OUT NOCOPY VARCHAR2,
                                        SV_ERROR          IN OUT NOCOPY VARCHAR2,
                                        SN_cod_retorno    OUT NOCOPY GE_ERRORES_PG.CodError,
                                        SV_mens_retorno   OUT NOCOPY GE_ERRORES_PG.MsgError,
                                        SN_num_evento     OUT NOCOPY GE_ERRORES_PG.Evento );


PROCEDURE PV_VALIDA_OOSS_BATCH_PEND_PR(EV_MOVIMIENTO   IN VARCHAR2,
                                        EN_NUM_OS       IN NUMBER ,
                                        EV_COD_OS       IN VARCHAR2,
                                        -- SV_FECSYS       IN OUT NOCOPY varchar2 ,
                                        SV_SQLCODE      IN OUT NOCOPY VARCHAR2 ,
                                        SV_SQLERRM      IN OUT NOCOPY VARCHAR2 ,
                                        SV_ERROR        IN OUT NOCOPY VARCHAR2 ,
                                        SN_cod_retorno  OUT NOCOPY GE_ERRORES_PG.CodError,
                                        SV_mens_retorno OUT NOCOPY GE_ERRORES_PG.MsgError,
                                        SN_num_evento   OUT NOCOPY GE_ERRORES_PG.Evento);

--INI COL-37481|15-02-2007|GEZ
PROCEDURE PV_ICC_CAMBIOPLAN_HIB_PR(ENNumAbonado         IN                                   NUMBER   ,
                                                                   EVPlanNue            IN                                       VARCHAR2 ,
                                   SV_SQLCODE              OUT NOCOPY            VARCHAR2 ,
                                   SV_SQLERRM              OUT NOCOPY            VARCHAR2 ,
                                   SV_ERROR                OUT NOCOPY            VARCHAR2 ,
                                   SV_mens_retorno         OUT NOCOPY            GE_ERRORES_PG.MsgError,
                                                                   SV_TABLA            OUT NOCOPY                VARCHAR2 ,
                                   SV_ACT              OUT NOCOPY                VARCHAR2 ,
                                                           SN_num_evento           OUT NOCOPY            GE_ERRORES_PG.Evento );
--FIN COL-37481|15-02-2007|GEZ

END  PV_CAMBIOPLAN_BATCH_PG;
/
SHOW ERRORS
