/* ============================================================================= */
/*  Tipo        :  COLA DE PROCESO
    Nombre      :  Co_GestionCobex.h
    Descripcion :  Header para Co_GestionCobex.pc
    Autor       :  
    Fecha       :  02-Septiembre-2009
*/ 
/* ============================================================================= */

#include <CO_deftypes.h>      /* Inclusion de tipos generales de cobranza              */
#include <CO_oracle.h>
#include <CO_libacciones.h>   /* Inclusion de nueva libreria general de procesos       */
#include <CO_libgenerales.h>  /* Inclusion de nueva libreria general                   */
#include <CO_libprocesos.h>   /* Inclusion de nueva libreria general de procesos       */

/* Re-definicion LOCAL de sqlnotfound: Valor del modo Oracle */
#ifdef SQLNOTFOUND
#undef SQLNOTFOUND
#endif
#define SQLNOTFOUND 1403 /*  100:Ansi    1403:Oracle */

/*===========================================================================================
						Definiciones de Uso general
 ===========================================================================================*/	
/*#define      szVERSION			"1.0.0"	        *//* Version Inicial para TMG-TMS       */
/*#define      szVERSION			"1.0.1"	        *//* Incidencia 121721 - 18.01.2010 - MQG     */
/*#define      szVERSION			"1.0.2"	        *//* Incidencia 133925 - 15.06.2010 - HQR     */
/*#define      szVERSION			"1.0.3"	         Incidencia 133925 - 07.07.2010 - HQR     */
#define      szVERSION			"1.0.4"	        /* Incidencia 156981 - 18.11.2010 - VHG     */
#define 	 iLOGNIVEL_DEF      3       	    /* Define el nivel de Log por Defecto */
#define      MAX_ARRAY          10000 	
#define      GECOB              "GECOB"
#define      W                  "W"
#define      PND                "PEN"           /* Estado de Gestion PENDIENTE        */
#define      REA                "REA"           /* Estado de Gestion REASIGNADO       */
#define      MORA               "M"             /* Tipo de gestion [M] MORA           */
#define      PREMORA            "P"             /* Tipo de gestion [P] PRE-MORA       */
#define      HABILITADO         0
#define      DESHABILITADO      1
#define      CARNULL            "-1"            /* Indica registro nulo para char     */
#define      NOASIGNADO         "NO ASIGNADO"   
#define      PROCESADO          "PRO"
#define      ERROR              "ERR"
#define      NULO               " "
#define      GE_CLIENTES        "GE_CLIENTES"   /* Incidencia 121721 - 18.01.2010 - MQG  */
#define      COD_CATEGORIA      "COD_CATEGORIA" /* Incidencia 121721 - 18.01.2010 - MQG  */
/* ============================================================================= */
/* declaracion de estructuras                                                    */
/* ============================================================================= */
/* Estructuras Tipo Array para gestion de cobranza */
typedef struct PARAMETROS
{
   long   lNumSecuencia  [MAX_ARRAY]   ; /* Numero de secuencia de gestion                               */
   char   sTipGestion    [MAX_ARRAY][2]; /* Tipo de Gestion [P]Premora - [M] Mora                        */
   char   sCodAgente     [MAX_ARRAY][6]; /* Codigo de Empresa Recaudadora                                */
   long   lCicloFact     [MAX_ARRAY]   ; /* Ciclo de facturacion                                         */
   char   sCodSegmento   [MAX_ARRAY][6]; /* Codigo de segmentacion                                       */  
   int    iCodCategoria  [MAX_ARRAY]   ; /* Codigo de categoria                                          */
   char   sCodCalifica   [MAX_ARRAY][6]; /* Codigo de calificacion                                       */
   char   sCodRango      [MAX_ARRAY][6]; /* Codigo de rangos de morosidad                                */  
   double dMontoDesde    [MAX_ARRAY]   ; /* Rango de Monto inicial                                       */  
   double dMontoHasta    [MAX_ARRAY]   ; /* Rango de Monto final                                         */  
   int    iVecesMora     [MAX_ARRAY]   ; /* Numero de veces en mora del cliente                          */     
   int    iHistorico     [MAX_ARRAY]   ; /* Con historico = 1 / Sin historico = 0                        */
   int    iCantMeses     [MAX_ARRAY]   ; /* Cantidad de meses a considerar para universo de pre-mora     */  
   char   sCodCategoria  [MAX_ARRAY][6]; /* Codigo de categoria COBRANZA                                 *//* Incidencia 121721 - 18.01.2010 - MQG       */
} td_Parametros;

typedef struct ENTIDAD
{
   char   sCodAgente                [6]; /* Codigo de Empresa Recaudadora                                */
   double dPrcAsignado	               ; /* Porcentaje de morosidad asignado a la entidad                */
   double dMtoAsignado                 ; /* Monto utilizado de morosidad por la entidad                  */
   double dMtoUtilizado                ; /* Monto utilizado de morosidad por la entidad                  */
   double dMtoPorAsignar               ; /* Monto de morosidad faltante por asignar                      */
   int    iDiasDesde                   ; /* Inicio del numero de dias del rango                          */
   int    iDiasHasta                   ; /* Fin del numero de dias del rango                             */
} td_Entidad;

typedef struct ENTIDAD_RANGO
{
   char   sCodAgente     [MAX_ARRAY][6]; /* Codigo de Empresa Recaudadora                                */
   double dPrcAsignado	 [MAX_ARRAY]   ; /* Porcentaje de morosidad asignado a la entidad                */
   double dMtoAsignado   [MAX_ARRAY]   ; /* Monto utilizado de morosidad por la entidad                  */
   double dMtoUtilizado  [MAX_ARRAY]   ; /* Monto utilizado de morosidad por la entidad                  */
   double dMtoPorAsignar [MAX_ARRAY]   ; /* Monto de morosidad faltante por asignar                      */
   char   sCodRango      [MAX_ARRAY][6]; /* Codigo de rango asignado                                     */
   long   lNumSecuencia  [MAX_ARRAY]   ; /* Numero de secuencia de gestion                               */
   int    iDiasDesde     [MAX_ARRAY]   ; /* Inicio del numero de dias del rango                          */
   int    iDiasHasta     [MAX_ARRAY]   ; /* Fin del numero de dias del rango                             */
   long   lCicloFact     [MAX_ARRAY]   ; /* Ciclo de facturacion                                         */
   char   sCodSegmento   [MAX_ARRAY][6]; /* Codigo de segmentacion                                       */  
   char   sCodCalifica   [MAX_ARRAY][6]; /* Codigo de calificacion                                       */
   double dMontoDesde    [MAX_ARRAY]   ; /* Rango de Monto inicial                                       */  
   double dMontoHasta    [MAX_ARRAY]   ; /* Rango de Monto final                                         */  
   int    iVecesMora     [MAX_ARRAY]   ; /* Numero de veces en mora del cliente                          */     
   int    iHistorico     [MAX_ARRAY]   ; /* Con historico = 1 / Sin historico = 0                        */
   char   sCodCategoria  [MAX_ARRAY][6]; /* Codigo de categoria COBRANZA                                 */   
} td_Entidad_Rango;

typedef struct CLIENTES_REASIGNAR
{
   long   lCodCliente    [MAX_ARRAY]   ; /* Codigo del cliente a reasignar                               */
   double dDeudaCliente  [MAX_ARRAY]   ; /* Monto de morosidad del cliente                               */
   int    iDiasMorosidad [MAX_ARRAY]   ; /* Dias de morosidad del cliente                                */
   int    iProcesado     [MAX_ARRAY]   ; /* Indicador de procesado                                       */
} td_Cliente;

/* Inicio Incidencia 121721 - 18.01.2010 - MQG       */
typedef struct CATEGORIAS
{
   int    iCodCategoria  [MAX_ARRAY]   ; /* Codigo de categoria GE_CLIENTES                              */
   char   sCodCategoria  [MAX_ARRAY][6]; /* Codigo de categoria COBRANZA                                 */
} td_Categorias;
/* Fin Incidencia 121721 - 18.01.2010 - MQG       */

/* ============================================================================= */
/* declaracion de prototipos de funciones                                        */
/* ============================================================================= */
int   ifnValidaParametros( int argc, char *argv[], LINEACOMANDO *pstLC );
int   ifnConexionDB(LINEACOMANDO *pstLC);
void  vfnInicializacionParametros(void);
int   ifnAbreArchivoLog();
void  vfnCierraArchivoLog(void);
int   ifnEjecutaCola(void);
int   ifnGeneraUniverso();
char* szGetEnv(char * VarHost);
int   ifnGestionPreMora(long i);
int   ifnGestionMora(long i);
int   ifnUpdateGestion(long lNumSecuencia, int iEstado);
int   ifnLlenaEstructuraCOBEX();
int   ifnCierraRegistro(long lNumSecuencia, long lCodCliente, char *sEntidad);
int   ifnRegistraGestion(long pCodCliente, char *cTipoGestion, long lNumSecuencia, char *cRango, char *cAgente);
int   ifnActualizaAgente(long pCodCliente, char *cAgente);
int   ifnVerificaSaldo(long pCodCliente);
int   ifnDeudaCliente(long pCodCliente, double *dDeuda);
int   ifnDiasMorosidad(long lCodCliente, int *iDiasMora);
int   ifnConAgenteNA(td_Entidad st, int j, char *sCodRango);
int   ifnReasignar(long i);
int   ifnAsignar(long i);
int   ifnVerificaEmpresaAnterior(long pCodCliente, char *sEntidadAntigua);
int   ifnClientesPendientes(int iIndice);
int   ifnVerificaClienteArray(long pCodCliente);
int   ifnExisteClienteArray(long pCodCliente);
int   ifnReasignacion(char *sCodAgente, char *sRango, int j, int i);
int   ifnReaAsignaCliente(long pCodCliente, double dDeudaCliente);
int   ifnLlenaCategoria();
int   ifnBuscaCategoria(long lIndice);
int   ifnAsignaEntidad(int iIndiceAgen, int iIndiceParam, char *sCodRango, int iIndNoAsignado);
int   ifnValidaCliente(long pCodCliente, int iIndAgen, double *dDeudaCliente);
int   ifnAsignaCliente(long pCodCliente, int iAgente, int iNoAsignado, double dDeudaCliente, int iHistorico, long lNumSecuencia);
/*int   ifnMorosidadActual(char *sCodRango, double *dMorosidadTotal);*/
int   ifnMorosidadActual(char *sCodRango, long lCiclo, char *sCodSegmento, char *sCodCategoria, char *sCodCalificacion, double dMtoDesde, double dMtoHasta, int iNumVecesMora, double *dMorosidadTotal);
int   ifnMorosidadEntidad(double dPorcentaje, double *dAsignado, double *dUtilizado, double *dPorAsignar, char *cEntidad, char *sCodRango, double dzMorosidadTotal);

/******************************************************************************************/
/** Información de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  %ARCHIVE% */
/** Identificador en PVCS                               : */
/**  %PID% */
/** Producto                                            : */
/**  %PP% */
/** Revisión                                            : */
/**  %PR% */
/** Autor de la Revisión                                : */
/**  %AUTHOR% */
/** Estado de la Revisión ($TO_BE_DEFINED es Check-Out) : */
/**  %PS% */
/** Fecha de Creación de la Revisión                    : */
/**  %DATE% */
/** Worksets ******************************************************************************/
/** %PIRW% */
/** Historia ******************************************************************************/
/** %PL% */
/******************************************************************************************/
