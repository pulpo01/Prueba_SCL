/* ============================================================================= */
/*  Tipo        :  COLA DE PROCESO
    Nombre      :  Co_GenArchCobex.h
    Descripcion :  Header para Co_GenArchCobex.pc
    Autor       :  
    Fecha       :  01-Septiembre-2009
*/ 
/* ============================================================================= */

#include <CO_deftypes.h>     /* Inclusion de tipos generales de cobranza         */
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
/*#define      szVERSION			"1.0.0"	        * Version Inicial para TMG-TMS */
/*#define      szVERSION			"1.0.1"	        * Requerimiento MIX-09003 - 135020 - 12.07.2010 - MQG*/
/*#define      szVERSION			"1.0.2"	        * Requerimiento MIX-09003 - 140082 - 15.07.2010 - MQG*/
/*#define      szVERSION			"1.0.3"	        * Requerimiento MIX-09003 - 140082 - 22.07.2010 - MQG*/
#define      szVERSION			"1.0.4"	        /* Requerimiento MIX-09003 - 140082 - 28.07.2010 - MQG*/

#define 	 iLOGNIVEL_DEF      3       	    /* Define el nivel de Log por Defecto */
#define      MAX_ARRAY          90000 	
#define      GACOB              "GACOB"
#define      W                  "W"
#define      MORA               "M"             /* Tipo de gestion [M] MORA           */
#define      PREMORA            "P"             /* Tipo de gestion [P] PRE-MORA       */
#define      VIS                "VIS"           /* Estado de Gestion VISADO           */
#define      REA                "REA"           /* Estado de Gestion REASIGNADO       */
#define      TERMINADO          "TER"           /* Estado de Gestion TERMINADO        */
#define      ERROR              "ERR"           /* Estado de Gestion ERROR            */ 
#define      CO_MOROSOS         "CO_MOROSOS"
#define      GE_CLIENTES        "GE_CLIENTES"
#define      GE_CATEGORIAS      "GE_CATEGORIAS"
#define      GE_PRESTACIONES_TD "GE_PRESTACIONES_TD"
#define      COD_CATEGORIA      "COD_CATEGORIA" 
#define      COD_SEGMENTO       "COD_SEGMENTO" 
#define      GRP_PRESTACION     "GRP_PRESTACION"
#define      SIN_INFORMACION    "SIN INFORMACION" 
#define      GA                 "GA"
#define      TM                 "TM"
#define      BAA                "BAA"
#define      BAP                "BAP"
#define      ACTIVO             "ACTIVO"
#define      BAJA               "BAJA"
#define      SI                 "S-I"
#define      UNO                1
#define      DOS                2 
#define      SEIS               6 
#define      NULO               " " 
#define      CARNULL            "-1" 

/* ============================================================================= */
/* declaracion de estructuras                                                    */
/* ============================================================================= */
/* Status Archivos  */
typedef struct tagSTATUSARCH
{
char   NomArchDetafac[256];     /* Nombre del archivo Detafac                    */
char   NomArchFactura[256];     /* Nombre del archivo Facturas                   */
char   NomArchCuentas[256];     /* Nombre del archivo Cuentas                    */
char   NomArchTelefon[256];     /* Nombre del archivo Telefonos                  */
char   NomArchTeleCta[256];     /* Nombre del archivo TelesCuenta                */
}STATUSARCH;

access STATUSARCH stStatusArch;

/* Estructuras Tipo Array para generacion de archivos de cobranza */
/* DETAFAC */
typedef struct DETAFAC
{
   char   sCodAgente    [MAX_ARRAY] [6]; /* Codigo de Empresa Recaudadora                                */
   long   lNumSecuencia [MAX_ARRAY]    ; /* Número de Secuencia                                          */  
   long   lCodCliente   [MAX_ARRAY]    ; /* Número de Cuenta afectada  (Código Cliente)                  */  
   char   sClasificac   [MAX_ARRAY] [6]; /* Codigo de clasificacion de cobros                            */  
   double dMontoMora    [MAX_ARRAY]    ; /* Monto en Mora                                                */  
   int    iTotFactMor   [MAX_ARRAY]    ; /* Numero de facturas en mora                                   */     
   int    iDiasenMora   [MAX_ARRAY]    ; /* Cantidad de dias en mora                                     */
   char   sCodProducto  [MAX_ARRAY] [6]; /* Codigo del Producto (Prestacion) mas antiguo del cliente     */  
   char   sDesProducto  [MAX_ARRAY][51]; /* Descripcion del Producto                                     */     
   int    iTotLinMovil  [MAX_ARRAY]    ; /* Cantidad de Lineas moviles activas                           */     
   int    iTotNotMovil  [MAX_ARRAY]    ; /* Cantidad de No Lineas moviles activas                        */   
   long   lNumRegistr   [MAX_ARRAY]    ; /* Numero de registros                                          */   
   int    lEstRegistro  [MAX_ARRAY]    ; /* Estado del registro 0=Valido / 1=Invalido                    *//* Requerimiento MIX-09003 - 140082 - 15.07.2010 - MQG*/     
} td_Detafac;

typedef struct FACTURAS
{
   char   sCodAgente    [MAX_ARRAY] [6]; /* Codigo de Empresa Recaudadora                                */
   long   lNumSecuencia [MAX_ARRAY]    ; /* Número de Secuencia                                          */  
   long   lCodCliente   [MAX_ARRAY]    ; /* Número de Cuenta afectada  (Código Cliente)                  */  
   long   lNumFolio     [MAX_ARRAY]    ; /* Número de Folio                                              */   
   double dSaldoMora    [MAX_ARRAY]    ; /* Saldo en Mora de la factura                                  */  
   char   sFecVencim    [MAX_ARRAY][11]; /* Fecha de vencimiento                                         */  
   long   lNumRegistr   [MAX_ARRAY]    ; /* Numero de registros                                          */     
   int    lEstRegistro  [MAX_ARRAY]    ; /* Estado del registro 0=Valido / 1=Invalido                    *//* Requerimiento MIX-09003 - 140082 - 15.07.2010 - MQG*/     
} td_Facturas;

typedef struct CUENTAS
{
   char   sCodAgente    [MAX_ARRAY] [6] ; /* Codigo de Empresa Recaudadora                                */
   long   lNumSecuencia [MAX_ARRAY]     ; /* Número de Secuencia                                          */  
   long   lCodCliente   [MAX_ARRAY]     ; /* Número de Cuenta afectada  (Código Cliente)                  */  
   char   sEstado       [MAX_ARRAY] [7] ; /* Estado de la cuenta                                          */
   char   sApellidos    [MAX_ARRAY][42] ; /* Apellidos del cliente, si es empresa, este campo va nulo     */
   char   sNombreClie   [MAX_ARRAY][51] ; /* Nombre del cliente, si es empresa, este campo va nulo        */
   char   sNombreEmpr   [MAX_ARRAY][51] ; /* Nombre de la empresa, si es cliente, este campo va nulo      */
   char   sNIT          [MAX_ARRAY][21] ; /* Numero de Identificacion                                     */ 
   char   sDireccion1   [MAX_ARRAY][81] ; /* Direccion                                                    */ 
   char   sDireccion2   [MAX_ARRAY][81] ; /* Direccion                                                    */ 
   char   sZona         [MAX_ARRAY][31] ; /* Ciudad                                                       */ 
   char   sDepartamen   [MAX_ARRAY][31] ; /* Region                                                       */ 
   char   sMunicipio    [MAX_ARRAY][31] ; /* Provincia                                                    */ 
   char   sTipDocumento [MAX_ARRAY][21] ; /* Tipo de documento: Pasaporte, tarjeta de identidad, etc      */ 
   char   sNumDocumento [MAX_ARRAY][21] ; /* Numero del documento                                         */ 
   char   sEdad         [MAX_ARRAY] [3] ;
   char   sOcupacion    [MAX_ARRAY][31] ;
   char   sTelTitular   [MAX_ARRAY][16] ; /* Telefono del titular                                         */
   char   sNomRefere1   [MAX_ARRAY][51] ; /* Nombre de Referencia                                         */ 
   char   sTelRefere1   [MAX_ARRAY][16] ; /* Telefono de Referencia                                       */ 
   char   sTelRefere2   [MAX_ARRAY][16] ; /* Telefono de Referencia                                       */ 
   int    iCodSegment   [MAX_ARRAY]     ; /* Codigo de Segmento asignado a la cuenta                      */  
   char   sDesSegment   [MAX_ARRAY][101]; /* Descripcion de Segmento                                      */  
   char   sClasificacion[MAX_ARRAY][513]; /* Clasificacion                                                */  
   char   sEstatus      [MAX_ARRAY]  [7]; /* Estado de la cuenta                                          */  
   char   sColor        [MAX_ARRAY]  [6]; /* Codigo Color                                                 *//* Requerimiento MIX-09003 - 140082 - 19.07.2010 - MQG*/       
   char   sDesColor     [MAX_ARRAY] [31]; /* Descripcion del Color                                        *//* Requerimiento MIX-09003 - 140082 - 19.07.2010 - MQG*/       
   long   lNumRegistr   [MAX_ARRAY]    ;  /* Numero de registros                                          */         
   int    lEstRegistro  [MAX_ARRAY]    ;  /* Estado del registro 0=Valido / 1=Invalido                    *//* Requerimiento MIX-09003 - 140082 - 15.07.2010 - MQG*/     
} td_Cuentas;

typedef struct TELEFONOS 
{
   char   sCodAgente    [MAX_ARRAY]  [6]; /* Codigo de Empresa Recaudadora                                */
   long   lNumSecuencia [MAX_ARRAY]     ; /* Número de Secuencia                                          */  
   long   lCodCliente   [MAX_ARRAY]     ; /* Número de Cuenta afectada  (Código Cliente)                  */  
   long   lNumCelular   [MAX_ARRAY]     ; /* Número de celular                                            */  
   int    iCodSegment   [MAX_ARRAY]     ; /* Codigo de Segmento asignado a la cuenta                      */  
   char   sDesSegment   [MAX_ARRAY][101]; /* Descripcion de Segmento                                      */  
   char   sCodProducto  [MAX_ARRAY]  [6]; /* Codigo del Producto (Prestacion) mas antiguo del cliente     */  
   char   sDesProducto  [MAX_ARRAY] [51]; /* Descripcion del Producto                                     */     
   /*char   sClasificacion[MAX_ARRAY][513]; * Clasificacion                                                   Requerimiento MIX-09003 - 140082 - 19.07.2010 - MQG*/     
   char   sCalificacion [MAX_ARRAY] [6];  /* Calificacion                                                 *//* Requerimiento MIX-09003 - 140082 - 19.07.2010 - MQG*/     
   long   lNumRegistr   [MAX_ARRAY]    ;  /* Numero de registros                                          */           	
   int    lEstRegistro  [MAX_ARRAY]    ;  /* Estado del registro 0=Valido / 1=Invalido                    *//* Requerimiento MIX-09003 - 140082 - 19.07.2010 - MQG*/     
} td_Telefonos; 

typedef struct TELESCUENTA
{
   char   sCodAgente    [MAX_ARRAY]  [6]; /* Codigo de Empresa Recaudadora                                */
   long   lNumSecuencia [MAX_ARRAY]     ; /* Número de Secuencia                                          */  
   long   lCodCliente   [MAX_ARRAY]     ; /* Número de Cuenta afectada  (Código Cliente)                  */  
   char   sCodProducto  [MAX_ARRAY]  [6]; /* Codigo del Producto (Prestacion) mas antiguo del cliente     */  
   char   sDesProducto  [MAX_ARRAY][513]; /* Descripcion del Producto                                     */     	
   long   lNumRegistr   [MAX_ARRAY]     ; /* Numero de registros                                          */           	
   int    lEstRegistro  [MAX_ARRAY]     ;  /* Estado del registro 0=Valido / 1=Invalido                   *//* Requerimiento MIX-09003 - 140082 - 19.07.2010 - MQG*/     
} td_TelesCuenta;

/*--char szFiller     [] = " ";*/
char szPipe       [] = "|";
/*--char szGuion      [] = "-";*/
FILE *ArchDetafac;
FILE *ArchFactura;
FILE *ArchCuentas;
FILE *ArchTelefono;
FILE *ArchTelesCta;

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
char* szGetEnv(char * VarHost);
int   ifnGeneraDetalle(char *phCodEntidad);
int   ifnDetalleDETAFAC(long lhCodCliente);
int   ifnDetalleFACTURA(long lhCodCliente, char *sCodEntidad, long lSecuencia);
int   ifnDetalleCUENTAS(long lhCodCliente);
int   ifnDetalleTELEFONOS(long lhCodCliente, char *sCodEntidad, long lSecuencia);
int   ifnBuscaClasificacion(long lhCodCliente);
int   ifnBuscaMontoDocMora(long lhCodCliente);
int   ifnBuscaProducto(long lhCodCliente);
int   ifnBuscaDatosCliente(long lhCodCliente, long j);
int   ifnVerificaEmpresa(long lhCodCliente, long j);
int   ifnBuscaDirecciones(long lhCodCliente, long j);
/*int   ifnBBuscaClasificacion(int iCodCategoria, long j);                                      Requerimiento MIX-09003 - 140082 - 19.07.2010 - MQG*/
int   ifnBBuscaOcupacion(char *sCodOcupacion, long j);
int   ifnBBuscaProducto(char *sCodProducto, long j);
int   ifnGenArchivosDetafac(char *pCodEntidad, long lNumSecuencia, char *sTipGestion);       /* Requerimiento MIX-09003 - 140082 - 15.07.2010 - MQG*/
int   ifnDetalleTELESCUENTA(long lhCodCliente, char *sCodEntidad, long lSecuencia);
int   ifnGeneraArchCob(char *sCodEntidad, long lNumSecuencia, char *sTipGestion);
int   ifnGeneraUnivArchCob();
int   ifnActualizaEstado(long lNumSecuencia, char *sEstado);
int   ifnActualizaEntidadMorosos(long lNumSecuencia);
int   ifnGeneraArchivosEntidad(long lNumSecuencia, char *sTipGestion);                       /* Requerimiento MIX-09003 - 140082 - 15.07.2010 - MQG*/
int   ifnGenArchivosFacturas(char *pCodEntidad, long lNumSecuencia, char *sTipGestion);      /* Requerimiento MIX-09003 - 140082 - 15.07.2010 - MQG*/
int   ifnGenArchivosCuentas(char *pCodEntidad, long lNumSecuencia, char *sTipGestion);       /* Requerimiento MIX-09003 - 140082 - 15.07.2010 - MQG*/
int   ifnGenArchivosTelefonos(char *pCodEntidad, long lNumSecuencia, char *sTipGestion);     /* Requerimiento MIX-09003 - 140082 - 15.07.2010 - MQG*/
int   ifnGenArchivosTelesCuenta(char *pCodEntidad, long lNumSecuencia, char *sTipGestion);   /* Requerimiento MIX-09003 - 140082 - 15.07.2010 - MQG*/
int   ifnBBuscaColor(char *sCodColor, long j);                                               /* Requerimiento MIX-09003 - 140082 - 19.07.2010 - MQG*/
char* sfnBuscaSegmentoTelefono(long lCodCliente);                                            /* Requerimiento MIX-09003 - 140082 - 19.07.2010 - MQG*/
char* sfnBuscaCalificacionTelefono(long lCodCliente);                                        /* Requerimiento MIX-09003 - 140082 - 19.07.2010 - MQG*/
int   ifnBBuscaSegmento(long lCodCliente, long j);                                           /* Requerimiento MIX-09003 - 140082 - 19.07.2010 - MQG*/
char* szRango(long pSecuencia);                                                              /* Requerimiento MIX-09003 - 140082 - 19.07.2010 - MQG*/
int   ifnBBuscaNumDocumento(long lhCodCliente, long j);                                      /* Requerimiento MIX-09003 - 140082 - 19.07.2010 - MQG*/
int   ifnRevisaEstadoCliente();                                                              /* Requerimiento MIX-09003 - 140082 - 21.07.2010 - MQG*/
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
