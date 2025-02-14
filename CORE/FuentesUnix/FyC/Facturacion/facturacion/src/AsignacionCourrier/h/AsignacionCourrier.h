#ifndef __ASIGNACIONCOURRIER_H__ 
#define __ASIGNACIONCOURRIER_H__

/*** Include de Librerias ***/
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include <fcntl.h>
#include <math.h>
#include <time.h>
#include <unistd.h>

#include <sys/timeb.h>
#include <sys/stat.h>

#include <GenFA.h>
#include <trazafact.h>

#ifdef SQLNOTFOUND
#undef SQLNOTFOUND
#endif

#ifndef strnull
    #define strnull(name) (name==(char *)NULL || name[0]==(char)NULL)
#endif

#define     SQLNOTFOUND             1403   /* Ansi :100 ; Not ansi : 1403 */

#define     ERROR_PARAMETROS        -2
#define     ERROR_ARCHIVOSLOG       -3
#define     ERROR_ACCESSORA         -4
#define     ERROR_SQLCODE           -5

#define	    MAX_RECORDS		    500000

/*** Define valores inicialies para los indices y contadores ***/
#define	    iINI_INDICE		    0
#define	    iINI_COUNTCLIENTES	    -1

/*** Define valor inicial para Tipo Direccion ***/
#define     iTIPODIRECCION          3

/****************************************************************************/

#ifdef _ASIGNACIONCOURRIER_C_

char szUsage[]=
"\n\tUso : AsignacionCourrier Opciones \n"
"\n\tOpciones :"
"\n\t\t-u usuario/password o '/'"
"\n\t\t-c Ciclo"
"\n\t\t-l Nivel de Log"
"\n\t\t-i Cliente Inicial"
"\n\t\t-f Cliente Final"
"\n";

#endif /***_ASIGNACOURRIER_C_ ***/
/****************************************************************************/

/*** Declaracion de Estructuras ***/
typedef struct tagPARAMETROSENTRADA
{
	long	lCodCicloFact;
	int	iCodCiclo;
	char    szFecEmision [10+1];
	long    lCodClienteIni;
	long    lCodClienteFin;	
        BOOL    bRngClientes;	
}PARAMETROSENTRADA;

typedef struct tagCLIENTESIND
{
	long	lCodCliente         ;
	char	szCodCiudad    [5+1];
	char	szCodProvincia [5+1];
	char	szCodRegion    [3+1];	
	int     iIndFin             ;
}CLIENTESIND;

typedef struct tagCLIENTESESPIND
{
	long	lCodCliente         ;
	char	szCodCourrier [10+1];
	int     iIndFin             ;
}CLIENTESESPIND;

typedef struct tagFECHASPROCESO
{
	long    lNumProceso;
	char    szFecVencimie [15];
	char    szFecEmision  [15];
	char    szFecCaducida [15];
	char    szFecProxVenc [15];
}FECHASPROCESO;


CLIENTESIND	 stClientesInd[MAX_RECORDS];
CLIENTESESPIND	 stClientesEspInd[MAX_RECORDS];
FECHASPROCESO	 stFecProceso;
char             szFecSysDate[15];

/*********************** ****************************/
/*** Funciones Asigna Courrier ***/

BOOL bfnValidaParametrosIn         ( int               argc,
                                     char              *argv[],
                                     char              *szOraAccount,
                                     char              *szOraPasswd,
			             PARAMETROSENTRADA *stParametrosIn,
                                     int               *iLogLevel);

BOOL bfnAbreArchivosLog            ( int);
BOOL ifnAcessoOracle               ( char              *szOraAccount, 
                                     char              *szOraPasswd);
BOOL bfnAsignacionCourrier         ( PARAMETROSENTRADA *stParametrosIn);

/*********************** ****************************/
/*** Funciones Asigna Courrier Fnc ***/

BOOL bfnGetCicloFact               ( PARAMETROSENTRADA *stParametrosIn);
int ifnOpenClientesCourrier        ( PARAMETROSENTRADA *stParametrosIn);
int ifnFetchClientesCourrier       ( int *iInd, int *iCountClientes);
BOOL bfnCloseClientesCourrier      ();
BOOL bfnBuscaCodCourrier           ( char *szCodCiudad, char *szCodProvincia, 
                                     char *szCodRegion,char *szCodCourrier);
BOOL bfnUpdateClientesCourrier     ( long lCodCliente, char *szCodCourrier);                                    
BOOL bfnUpdateCodZonaCourrier      ( long lCodCliente, char *szCodCourrier);
BOOL bfnProcesaClientesCourrier    ( int iInd, int iCountClientes);
BOOL bfnProcesoUpdateClientes      ( long lCodCliente, char *szCodCourrier);

int ifnOpenClientesEspeciales      ( PARAMETROSENTRADA *stParametrosIn);
int ifnFetchClientesEspeciales     ( int *iInd, int *iCountClientesEsp);
BOOL bfnCloseClientesEspeciales    ();
BOOL bfnProcesaClientesEspeciales  ( int iIndEsp, int iCountClientesEsp);
BOOL bfnBuscaClienteCourrier       ( long lCodCliente);

/*** Manejo de Strings ***/
char    *ltrim(char *);
char    *rtrim(char *);
char    *alltrim(char *);


#endif
