/* ***********************************************
Nombre : MontoMinimoFact.h
Autor  : Jorge H. Toro Omar
*********************************************** */
#ifndef _MONTOMINIMOFACT_H_
#define _MONTOMINIMOFACT_H_

/* Librerias                        */
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>
#include <strings.h>
#include <math.h>
#include <time.h>
#include <unistd.h>
#include <GenFA.h>
#include <trazafact.h>

#define     iLOGNIVEL_DEF               3
#define     iCODTIPDOCUM                90     /* Definido en Tabla GE_TIPDOCUMEN 'FACTURA MENOR MONTO MINIMO'*/
#define     MONTOMIN                    "P"

int         iCodProducto    = 1;
int         iNumFactura     = 0;
char        szCodMoneda     []= "001";
int         iCodPlanCom     = 1;
int         iNumUnidades    = 1;
int         iIndFactur      = 1;
int         iNumTransaccion = 0;
int         iNumVenta       = 0;
int         iNumPaquete     = 0;
int         iIndCuota       = 0;
/***********************************************************/
/* Estructura para recoger los datos por linea de comandos */
/***********************************************************/
typedef struct LineaComandoMtoMinimo
{
    char    szUser           [50];
    char    szUsuario        [63];
    char    szPass           [50];
    char    szDirLogs      [1024]; /*  Directorio de Archivos Log's y Err    */
    char    szDirDats      [1024]; /*  Directorio de Archivos de Datos Dat   */
    char    szDataName     [1024]; /*  Nombre del Archivo de Datos de Folios */
    FILE    *DataFile            ; /*  Puntero de Archivo de Datos (Folios)  */
    char    szOpcion          [1]; /*  Anular, Consumir o Reporte  [A/C/R]   */
     int    iOpcion              ;
    BOOL    bOptUsuario          ;
    BOOL    bOptCiclo            ;
    BOOL    bOptHelp             ;
    long    lTipoDocumen         ;
    long    lCodCiclFact         ;
    long    lClienteIni          ;
    long    lFolioIni            ;
    long    lCantidad            ;
    char    szFecFoli         [9];
     int    iNivLog              ;
    char    szCodModGener     [4];
    char    szCodigoOperadora [6];
    char    szPrefijoFolio   [11];
    long    lCodClienteIni       ;
    long    lCodClienteFin       ;    
    BOOL    bRngClientes         ;
    char    szHostId[25]         ;
}MTOMINIMOLINEACOMANDO;
 
typedef struct regMMF
{
    long    lNumAbonado     ;
    double  dImpCargoBasico ;
    double  dImpTrafico     ;
    char    szPlantarif  [4];
    int     iIndMMF         ;
    int     iPosCargoBasico ;

}REGMMF;


/****************************************************************/
/* declaracion de funciones */
/****************************************************************/

#undef access
#ifdef _MONTOMINIMOFACT_PC_

/************************************************************************/
/*   Definiendo Variables y Estructuras Globales                        */
/************************************************************************/

MTOMINIMOLINEACOMANDO stLineaComando    ;

/****************************** Declaracion de Prototipos ********************/
#define access  

#ifdef SQLNOTFOUND
#undef SQLNOTFOUND
#endif

#define SQLNOTFOUND   1403   /* Ansi :100 ; Not ansi : 1403 */

BOOL bfnProcMontoMinimoFact        ( long lCiclFact, long lMontoMinimo);
BOOL bGetParamMontoMinimo          ( char *szValor);
BOOL bGetParamCodConcepto          ( char *szValor);
BOOL bGetParamTipoDocumento        ( char *szValor);
BOOL bGetParamAplicaAcumNetoGrav   ( char *szValor);
BOOL bfnGetProxCiclFact            ( long lCodCiclFact, long *lNextCiclFact, char *szNextFecEmision);
BOOL bfnSelectFactDocu             ( long lCodCiclFact, long lMontoMinimo);
BOOL bfnUpdateFactDocuCicloAnt     ( long lCodCiclFact);
BOOL bfnDBInsertCargo              ( long lCodConcepto, long lCodCliente,long lNumAbonado,
                                     double dAcumNetoGrav,  long lNextCodCiclFact,  char *szNextFecEmision);
BOOL bfnUpdateFactDocu             ( long  lCodCiclFact, long lCodCliente, long lCodTipoDocumento);                                                       

#else

#define access extern

#endif /* _MONTOMINIMOFACT_PC_ */
#endif /* _MONTOMINIMOFACT_H_  */

/* Definicion de los mensajes de la Ayuda */

static char szUsage[] =     "\n\t Uso: MontoMinimoFact Opciones"
                            "\n\n\t OPCIONES :"
                            "\n\t\t       -u Usuario/password  - Opcional -  Default: -u / "
                            "\n\t\t       -l Nivel de Log      - Opcional -  Default: -l 3 " 
                            "\n\t\t       -c Ciclo Facturacion            -  Ej. : -c 10109"
                            "\n\t\t       -i Cliente Inicial   - Opcional -  Ej. : -i 4000000"
                            "\n\t\t       -f Cliente Final     - Opcional -  Ej. : -f 5600000"
                            "\n" ;

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

