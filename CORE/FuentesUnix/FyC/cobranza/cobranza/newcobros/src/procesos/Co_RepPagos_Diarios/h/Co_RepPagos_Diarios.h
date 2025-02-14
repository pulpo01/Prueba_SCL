/* ============================================================================= */
/*  Tipo        :  COLA DE PROCESO
    Nombre      :  Co_RepPagos_Diarios.h
    Descripcion :  Header para Co_RepPagos_Diarios.pc
    Autor       :  
    Fecha       :  12-Agosto-2009
*/ 
/* ============================================================================= */

#include <CO_deftypes.h>     /* Inclusion de tipos generales de cobranza         */
#include <CO_oracle.h>
#include <CO_libacciones.h>   /* Inclusion de nueva libreria general de procesos */
#include <CO_libgenerales.h>  /* Inclusion de nueva libreria general             */
#include <CO_libprocesos.h>   /* Inclusion de nueva libreria general de procesos */

/* Re-definicion LOCAL de sqlnotfound: Valor del modo Oracle */
#ifdef SQLNOTFOUND
#undef SQLNOTFOUND
#endif
#define SQLNOTFOUND 1403 /*  100:Ansi    1403:Oracle */

/*===========================================================================================
						Definiciones de Uso general
 ===========================================================================================*/	
/*#define      szVERSION			"1.0.0"	        * Version Inicial para TMG-TMS */
/*#define      szVERSION			"1.0.1"	        * Requerimiento MIX-09003 - 139811 - 07.07.2010 - MQG */
/*#define      szVERSION			"1.0.2"	        *//* Requerimiento MIX-09003 - 139811 - 14.07.2010 - MQG */
/*#define      szVERSION			"1.0.3"	        *//* Requerimiento MIX-09003 - 139811 - 20.07.2010 - HQR */
//#define      szVERSION			"1.0.4"	        /* Requerimiento MIX-09003 - 139811 - 20.07.2010 - HQR */
#define      szVERSION			"1.0.5"	        /* Requerimiento MIX-09003 - 140082 - 28.07.2010 - HQR */

#define 	 iLOGNIVEL_DEF      3       	    /* Define el nivel de Log por Defecto */
#define      MAX_ARRAY          40000 	
#define      RPAGD              "RPAGD"
#define      W                  "W"
#define      SIN_INFORMACION    "SIN INFORMACION" 
#define      MOVISTAR           "MOVISTAR" 

/* ============================================================================= */
/* declaracion de estructuras                                                    */
/* ============================================================================= */
/* Status Archivos  */
typedef struct tagSTATUSARCH
{
 char   NomArchPag[256];     /* Nombre del archivo de Pagos Diarios              */
 char   NomArchRev[256];     /* Nombre del archivo de Reversas Diarias           */
 char   NomArchNot[256];     /* Nombre del archivo de Notas de Creditos Diarias  */
}STATUSARCH;

access STATUSARCH stStatusArch;

/* Estructura Tipo Array para generacion de archivos de cobranza */
typedef struct ARCHIVOCOB
{
   /* Datos de los archivos                                                                              */
   long   lCodCliente   [MAX_ARRAY]     ; /* Número de Cuenta afectada  (Código Cliente)                  */  
   long   lNumFactura   [MAX_ARRAY]     ; /* Numero de folio de la factura                                */  
   int    iTipValor     [MAX_ARRAY]     ; /* Tipo de Transacción (efectivo, cheque, tarjeta de credito...)*/  
   char   sDesValor     [MAX_ARRAY] [41]; /* Descripcion del Tipo de Transaccion                          */     
   double dMontoDcto    [MAX_ARRAY]     ; /* Monto del documento pagado                                   */
   char   sFecCancela   [MAX_ARRAY] [11]; /* Fecha de aplicación del pago                                 */ 
   char   sFecEfectiv   [MAX_ARRAY] [11]; /* Fecha recepción del pago                                     */  
   char   sCodEntRece   [MAX_ARRAY] [41]; /* Código que identifica la entidad receptora de la transacción */  
   int    iCodSegment   [MAX_ARRAY]     ; /* Codigo de Segmento asignado a la cuenta                      */  
   char   sDesSegment   [MAX_ARRAY][101]; /* Descripcion de Segmento                                      */  
   int    iTotDiaMora   [MAX_ARRAY]     ; /* Días mora acumulados al momento de realizar el pago          */  
   char   sCodProducto  [MAX_ARRAY]  [6]; /* Codigo del Producto (Prestacion) mas antiguo del cliente     */  
   char   sDesProducto  [MAX_ARRAY] [51]; /* Descripcion del Producto                                     */     
   char   sCodAgente    [MAX_ARRAY]  [6]; /* Código de la empresa de cobro                                */  
   char   sCodUsuario   [MAX_ARRAY] [31]; /* Usuario que recibió el pago o realizo la reversa             */  
   long   lNumRegistr   [MAX_ARRAY]     ; /* Numero de registro por empresa de cobranza                   */     
   char   sDesAgente    [MAX_ARRAY] [31]; /* Descripcion de la empresa de cobro                           */  
      
} td_ArchiCob;

typedef struct ESTRUCOBEX
{
   long   lCodCliente       ;
   double dMontoDcto        ; 
   char   sFecCancela   [11]; 
   char   sFecCancela2   [9]; 
   char   sFecEfectiv   [11]; 
   char   sCodAgente     [6]; 
   char   sDesAgente    [31];
   char   sCodUsuario   [31]; 
   int    iCodTipdPag       ; 
   long   lNumSecuPag       ; 
   long   lNumSecDcto       ; 
   int    iCodTipDcto       ; 
   long   lNumCompago       ;
   long   lNumRegistr       ; 
   int    iTipValor         ;
   char   sDesValor     [41];
   char   sEmpRecauda   [41]; 
   int    iTotDiaMora       ;
   long   lNumFolio         ; 
   int    iCodSegmento      ;    
   char   sDesSegmento [101];   
   char   sCodProducto  [16]; 
   char   sDesProducto  [51];    
   double dNumCuota         ; 
   int    iSecCuota         ;
} td_EstCobex;

char szFiller     [] = " ";
char szPipe       [] = "|";
char szGuion      [] = "-";
FILE *ArchPag;
FILE *ArchNdC;
FILE *ArchRev;

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
int   ifnGeneraArchivos();
int   ifnLlenaEstructura(char *pCodEntidad, char *pDesEntidad, long pCodCliente);
int   ifnCargaEstructura(td_ArchiCob *stAr, long lIndAC, td_EstCobex *stAux, long pContador);
int   ifnDiasMoraFolio(td_EstCobex *st);
int   ifnBBuscaSegmento(td_EstCobex *st);
int   ifnBBuscaProducto(td_EstCobex *st);
char* szGetEnv(char * VarHost);
int   ifnBuscaClientes(char *pCodEntidad, char *pDesEntidad);
int   ifnBBuscaTipValorEntidad_MOVCAJA(td_EstCobex *st );
int   ifnBBuscaTipValorEntidadOnLine(td_EstCobex *st );
int   ifnBBuscaTipValorEntidadRecExt(td_EstCobex *st );
int   ifnBBuscaTipValorEntidadPAC(td_EstCobex *st );
int   ifnBBuscaTipValorEntidadREGNCI(td_EstCobex *st ); 
int   ifnGenArchivosPagos(char *pCodEntidad, char *pDesEntidad, char *vEmail);
int   ifnGenArchivosNC(char *pCodEntidad, char *pDesEntidad, char *vEmail);
int   ifnGenArchivosRev(char *pCodEntidad, char *pDesEntidad, char *vEmail);
int   ifnEnvioMail(char *vNomArchivo, char *vEMail, int vTipo);

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
