#ifndef _CODEFTYPES_H_
#define _CODEFTYPES_H_

#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <string.h>
#include <stdarg.h>
#include <stdlib.h>
#include <sys/times.h>
#include <sys/time.h>
#include <time.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <sys/fcntl.h>
#include <utmp.h>
#include <errno.h>
#include <malloc.h>
#include <ctype.h>

#ifdef _BPDEFTYPES_H_
typedef unsigned char        BYTE;   /*  8-bit sin signo */
typedef unsigned short int   WORD;   /* 16-bit sin signo */
typedef unsigned long int    LONG;   /* 32-bit sin signo */
#endif

#define LOG00    0  /* Msg Oracle */
#define LOG01    1  /* Msg Errores graves y leves */
#define LOG02    2  /* Msg Avisos */
#define LOG03    3  /* Msg Trazas */
#define LOG04    4  /* Msg Trazas */
#define LOG05    5  /* Msg Trazas */
#define LOG06    6  /* Msg Trazas */
#define LOG07    7  /* Msg Trazas */
#define LOG08    8  /* Msg Trazas */
#define LOG09    9  /* Msg Trazas */
#define LOG10   10  /* Msg Trazas */ /* LOG010 */
#define EST00   11  /* Msg Estadistica */
#define INFALL  12  /* Msg Informativo para ALL FILES OPENED (LOG, ERR, EST) */

#define MAX_ABONADOS            5000
#define MAXABONAD                               1000
#define MAXSERVIC                               50

#define TAMBUFSIZ   5001            /* tamano de cadenas */
#define TAMCADSIZ   1025
#define TAMCADWORK  4001                        /* tamano de cadenas */
#define SQLOK           0
#define ORA_NULL    -1

#ifdef SQLNOTFOUND
#undef SQLNOTFOUND
#endif
#define SQLNOTFOUND 1043
#define SQLCODE     sqlca.sqlcode
#define SQLERRM     sqlca.sqlerrm.sqlerrmc
#define SQLROWS     sqlca.sqlerrd[2]
#define SQLNULL         -1405
#define IVA                     1.18

#ifndef _BOOL_                  /* _BOOL_           */
#define _BOOL_
#define  FALSE  0
#define  TRUE   !FALSE 
typedef int BOOL;               /* Tipo Booleano    */
#endif                          /* _BOOL_           */
#define SQLOK           0
/* para manejo de decimales */
#define szNUM_DECIMAL                   "NUM_DECIMAL"           /* Numero de Decimales a considerar */
#define szSEP_MILES_MONTOS              "SEP_MILES_MONTOS"      /* Caracter separados de miles */
#define szSEP_DECIMALES_MONTOS  "SEP_DECIMALES_MONTOS"  /* Caracter separador de decimales */
#define szSEP_DECIMALES_ORACLE  "SEP_DECIMALES_ORACLE"  /* Caracter separador de decimales */
#define iLOGNIVEL_DEF           3               /* Define el nivel de Log por Defecto */

typedef struct LineaComando{
        char    szUsuarioOra [64];
        char    szOraAccount [32];
        char    szOraPasswd  [32];
        char    sFechaProceso[21];
        char    sFechaDesde  [10];
        char    sFechaHasta  [10];
        char    sTipoRpt     [1] ;
        int    iLogLevel         ;
}LINEACOMANDO;

#
/* ========================================================================== */
/* Definicion de Variables Globales del modulo                                */
/* ========================================================================== */
int iCod_Concepto ;

/*typedef struct TagGenParam
{
        int  iNumDecimal                ;
        char szSepMilesMonto[2] ;
        char szSepDecMontos     [2]     ;
        char szSepDecOracle     [2]     ;
}GENPARAM;*/

/* ========================================================================== */
/* Definicion de Estructuras Globales del modulo                              */
/* ========================================================================== */
typedef struct tagSTATUB        /* Status de ejecucion */
{
    long   lPid                ;       /* Identificador proceso asignado al programa               */
    BOOL   bExitApp            ;       /* Salida de la aplicacion                                  */
    int    iLogNivel           ;       /* Nivel en el fichero de log                               */
    char   szLogPathGene[128]  ;       /* Path General donde estara el archivo de Log              */
    char   szLogPathHoy[9]     ;       /* Fecha actual yyyymmdd (parte del directorio)             */
    char   szFileName[32]      ;       /* Nombre del fichero gral (se diferencia por la extension) */
    FILE*  LogFile             ;       /* Fichero de log                                           */
    FILE*  ErrFile             ;       /* Fichero de Errores                                       */
    FILE*  EstFile             ;       /* Fichero de Estadisticas                                  */
}STATUSB;

STATUSB    stStatusB;
/* -------------------------------------------------------------------------- */
/*                  Variables de Globales Exportables                         */
/* -------------------------------------------------------------------------- */

/* Ga_abocel */
typedef struct stGabocel
{
    long lNumCelular         ;
    int  iCodCentral         ; 
    char szNumSerieHex    [9];
    long lCodCliente         ;
    char szTipTerminal    [2]; 
    char szNumMin         [4]; 
    char szClaseServicio[257]; 
    long lNumAbonado         ;
}GABOCEL; 

/* GA_DATOSGENER */
typedef struct stDatosGen
{
    char szCodDiasEspCel [4];
    char szCodFyfcel     [4];
    char szCodTipDiaCel  [3];
    char szCodSerConexCel[4];
    char szCodDetCel     [4];
    int  iNumDiasEsp        ;
    int  iNumTelEsp         ;
} DATOSGEN;

/* ============================================================================= */
/* Estructura para cargar abonados por 1 cliente especifico                      */
/* ============================================================================= */
typedef struct stRegAbonado
{
    long lNum_Abonado ;
} REGABONADO;

typedef struct ABONADO
{
        long    lNumAbonado;
} ABONADOS;

typedef struct SERVICIOS
{
        char    szCodServicio[3];
        long    lNumSecuencia;
} reg_Servicios;

#endif /* _CODEFTYPES_H_ */

int ifnCargaParametros( int argc, char *argv[], LINEACOMANDO *pstLC );
int ifnValidaParametros( int argc, char *argv[], LINEACOMANDO *pstLC );
int ifnOraConnect( char *szUser, char *szPasw );
void ifnGeneraCabecera(int argc, char *argv[], LINEACOMANDO *pstLC );
void ifnGeneraPie(int argc, char *argv[], LINEACOMANDO *pstLC );
int ifnGeneraDetalle( int argc, char *argv[], LINEACOMANDO *pstLC );
void ifnDetalleReporte(long index);
int ifnAbreArchivoLog(int iCrearDir);
char *szSysDateBen (char *szFmto);
int ifnTrazasLog (char* szExeNameApp, char* szTxt, int iNivel,...);
void ini_Arreglo();

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