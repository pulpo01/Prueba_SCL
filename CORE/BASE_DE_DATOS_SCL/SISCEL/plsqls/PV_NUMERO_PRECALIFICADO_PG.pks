CREATE OR REPLACE PACKAGE PV_NUMERO_PRECALIFICADO_PG AS

   CNProcCarga       CONSTANT PLS_INTEGER :=0 ;
   CNProcValidacion  CONSTANT PLS_INTEGER :=1 ;
   CNProcValidaOK    CONSTANT PLS_INTEGER :=2 ;
   CNProcCierreVig   CONSTANT PLS_INTEGER :=3 ;
   CNProcNoCargar    CONSTANT PLS_INTEGER :=4 ;
   CNProcErrCal      CONSTANT PLS_INTEGER :=5 ;
   CNProcErrAbo      CONSTANT PLS_INTEGER :=6 ;
   CNProc   CONSTANT PLS_INTEGER :=2 ;
   CN_cero           CONSTANT PLS_INTEGER := 0;
   CN_uno            CONSTANT PLS_INTEGER := 1;
   CV_ErrorNoCla     CONSTANT VARCHAR2(20) := 'Error no clasificado';
   
   CN_Vigente       CONSTANT PLS_INTEGER := 1;
   CN_NoVigente       CONSTANT PLS_INTEGER := 0;
   
   ERROR_CONTROLADO    EXCEPTION;
   
   TYPE TCargaCalificados IS TABLE OF PV_CARGA_CALICELU_TO%ROWTYPE INDEX BY BINARY_INTEGER;
   TYPE TCalificaciones   IS TABLE OF PV_CALIFICACION_TD%ROWTYPE  INDEX BY BINARY_INTEGER ; 
   TYPE TCargaCalifOK     IS TABLE OF PV_CALIFICA_CELULAR_TO%ROWTYPE INDEX BY BINARY_INTEGER;
   TYPE TCargaCalifCV     IS TABLE OF PV_CALIFICA_CELULAR_TH%ROWTYPE INDEX BY BINARY_INTEGER;
   TYPE TAbonados         IS TABLE OF GA_ABOAMIST%ROWTYPE INDEX BY BINARY_INTEGER;
   TYPE TCelularCalif     IS TABLE OF PV_CALIFICA_CELULAR_TO%ROWTYPE INDEX BY BINARY_INTEGER;
   
   TYPE TCelular IS TABLE OF PV_CALIFICA_CELULAR_TO.num_celular%TYPE INDEX BY BINARY_INTEGER;
   TYPE TAbonado IS TABLE OF PV_CALIFICA_CELULAR_TO.num_abonado%TYPE INDEX BY BINARY_INTEGER;
   TYPE TCalifica IS TABLE OF PV_CALIFICA_CELULAR_TO.cod_califica%TYPE INDEX BY BINARY_INTEGER;
   TYPE TProceso IS TABLE OF PV_CARGA_CALICELU_TO.cod_proceso%TYPE INDEX BY BINARY_INTEGER;
   
   
   
   
   RCargaCalific   TCargaCalificados;
   
 
  PROCEDURE PV_PROCESA_NRO_CALIFICADO_PR(EVNombreArchivo IN PV_CARGA_CALICELU_TO.NOM_ARCHIVO%type,
                                      ENCarga         IN PV_CARGA_CALICELU_TO.NRO_CARGA%type,
                                      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento);

END PV_NUMERO_PRECALIFICADO_PG;
/
SHOW ERROR