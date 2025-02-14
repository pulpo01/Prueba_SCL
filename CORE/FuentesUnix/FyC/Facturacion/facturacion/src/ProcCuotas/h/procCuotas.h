/* ***********************************************
  "procCuotas.h"

15 de Mayo de 2000 :    Mauricio Villagra V.
                        Creacion de Proceso
*********************************************** */
#ifndef __PROCCUOTAS_H__
#define __PROCCUOTAS_H__ 

/* inclusion de archivos                        */
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


#ifdef SQLNOTFOUND
#undef SQLNOTFOUND
#endif

#define SQLNOTFOUND   1403   /* Ansi :100 ; Not ansi : 1403 */


#define     MIN_CUOTASCREDITOCLIENTE      0
/*#define     MAX_CUOTASCREDITOCLIENTE   4500 */ /* PGG - 1-07-2018 - INC. 212127 */
/*#define     MAX_CUOTASCREDITOCLIENTE   10000 */    /* PGG - 1-07-2018 - INC. 212127 */
#define     MAX_CUOTASCREDITOCLIENTE   20000     /* PGG - 1-11-2019 - INC. 213093 */


#define     MODO_PROCESO_GENERACION      1
#define     MODO_PROCESO_HISTORICOS      2

#define     RET_ERROR_GENERACION        -1
#define     RET_ERROR_HISTORICO         -2
#define     RET_ERROR_PARAMETROS        -3
#define     RET_ERROR_ARCHIVOSLOG       -4
#define     RET_ERROR_ACCESSORA         -5


#define     IND_IMPRESO_NO              0
#define     IND_IMPRESO_OK              1


char szUsage[]=
"\n\tUso : procCuotas Opciones \n"
"\n\tOpciones :"
"\n\t\t-u usuario/password o '/'(Opcional)"
"\n\t\t-c Cod_CiclFact (Codigo de Ciclo de Facturacion)"
"\n\t\t-G (Generacion de Cuotas Para Facturacion)"
"\n\t\t-H (Paso a Historico y Cuenta Corriente de Cuotas)"
"\n\t\t-l nivel de Log de la cola(Opcional)"
"\n\t\t-i Rango inicial de clientes a procesar (Opcional)"
"\n\t\t-f Rango final de clientes a procesar (Opcional)"
"\n";

#define CONSOLA  1
#define TRAZASLOG 2

/* ******************************************************************************** */
/*  Registro de Cuotas                                                              */
/* ******************************************************************************** */

typedef struct tagCUOTCREDITO
{   char    szRowId         [20];
    long    lCodCliente         ;
    long    lNumSecuenci        ;
    int     iCodTipDocum        ;
    long    lCodVendedorAgente  ;
    char    szLetra          [2];
    int     iCodCentremi        ;
    int     iCodConcepto        ;
    int     iColumna            ;
    int     iNumCuota           ;
    int     iSecCuota           ;
    long    lCodCiclFact        ;
    int     iIndFacturado       ;
    char    szFecVencimie   [20];
    char    szNumFolioCTC   [12];
    double  dMtoCuota           ;
    char    szFecCompra     [20];
    int     iIndImpreso         ;
    long    lNum_Folio          ;
    /* char    szPrefPlaza     [11]; */ /*PHB:agregue pref_plaza*/ /*PGG - inc 215022 - 01-07-2022 */
    char    szPrefPlaza     [26];/*PGG - inc 215022 - 01-07-2022 */
    long    lNumAbonado         ;/* 20051123 */
}CUOTCREDITO;

/* ******************************************************************************** */
/*  Estructura de Cuotas por Cliente                                                */
/* ******************************************************************************** */

typedef struct tagCUOTCREDITOCLIENTE
{
    int         iNumCuotasCliente ;
    CUOTCREDITO stRegCuota[MAX_CUOTASCREDITOCLIENTE];
}CUOTCREDITOCLIENTE;


typedef struct tagArgsEntrada
{
    int     iModProceso       ;
    long    lCodCiclFact      ;
    char    szOraAccount[32]  ;
    char    szOraPasswd [32]  ;
    int     iLogLevel         ;
    long    lClienteIni       ;
    long    lClienteFin       ;
    BOOL    bIngRngClientes   ;
    char    szHoraInicProc[20];
    int     iCodCiclo         ;
}ARGSENTRADA; 

typedef struct tagEstadisticas
{
    time_t  tmTiempoProcIni;
    time_t  tmTiempoProcFin;
    clock_t clTiempoCPUIni;
    clock_t clTiempoCPUFin;
}ESTADISTICAS;
                                  

/* declaracion de funciones */
BOOL    ifnAcessoOracle	(char    *szOraAccount	, char    *szOraPasswd	);
BOOL bfnAbreArchivosLog (    int     iModProceso ,long lCodCiclFact ,int iLogLevel);

BOOL     bprocGenCuota(ARGSENTRADA stArgsEntrada);

int     ifnOpenClientesFaCicloCli(ARGSENTRADA stArgsEnt);
int     ifnFetchClienteFaCicloCli(long *lCodCliente);
BOOL    bfnCloseClienteFaCicloCli(void);
BOOL    bfnDeleteFaCuotCredito (ARGSENTRADA stArgsEnt);
BOOL    bCargaCuotasClienteCartera(long lCodCiclFact, long lCodCliente, CUOTCREDITOCLIENTE *pstCuotasCliente);
BOOL 	bfnClienteDeBajaInter(long lCodCiclFact, long lCodCliente, CUOTCREDITOCLIENTE *pstCuotasCliente);
BOOL    bfnInsertCuotasFaCuotCredito(CUOTCREDITOCLIENTE pstCuotasCliente);

BOOL bprocHisCuota(ARGSENTRADA stArgsEnt);


int ifnOpenCuotasFaCuotCredito(ARGSENTRADA stArgsEnt);
int     ifnFetchCuotaFaCuotCredito (CUOTCREDITO *pstCuotas);
BOOL    bfnUpdateCuotaCartera       (CUOTCREDITO pstCuotas);
BOOL    bfnInsertHistCuotasCiclo    (CUOTCREDITO pstCuotas);
BOOL    bfnDeleteHistCuotasCiclo    (CUOTCREDITO pstCuotas);
BOOL    bfnCloseCuotasFaCuotCredito (void);
BOOL    bfnValidaParametros (   int     argc         ,
                                char    *argv[]         ,
                                ARGSENTRADA *pstArgsEntrada);

BOOL    bfnAbreArchivosLog  (  int , long   , int  );  
BOOL    bprocCargaUltimoPago(ARGSENTRADA stArgsEntrada );
char    *ltrim(char *);
char    *rtrim(char *);
char    *alltrim(char *);
void    vfnImprimirArgsEntrada( int iDestino, ARGSENTRADA stArgsEntrada);
void    vfnIniciarEstProc( ESTADISTICAS *pstEstad);
void    vfnImprimirEstProc( ESTADISTICAS *pstEstad);

/* Funciones "wrapper" */
BOOL bfnWrapperValidaTrazaProc(long lCodCiclFact,int iCodProceso, int iIndFacturacion);
BOOL bfnWrapperSelectTrazaProc (long lCicloFac,int iCodProc, TRAZAPROC * pstTraza);
BOOL bfnWrapperUpdateTrazaProc (TRAZAPROC pstTraza);

#endif  /* __PROCCUOTAS_H__ */

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

