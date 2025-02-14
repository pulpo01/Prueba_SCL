/* **********************************************/
/*			  "Scheduler.h"		*/
/*		 30 de Noviembre de 1999	*/
/*		  Roy Barrera Richards		*/
/*			 			*/			
/************************************************ */

/* inclusion de archivos */
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>
#include <strings.h>
#include <math.h>
#include <time.h>
#include <GenFA.h>
#include <predefs.h>
#include <New_Interfact.h>
#include <unistd.h>

/* definiciones de constantes */
#define FALSE           0
/*#define TRUE            1*/
#define SQLOK	      0

#define access 		

#define VENTA			1
#define MISCELANEA	   18
#define NOTACRED	   25

#define SEGUNDOS	    1
#define HORAESPEC	    2 
#define DIAHORAESPEC       3


#ifdef SQLNOTFOUND
#undef SQLNOTFOUND 
#endif	    

#define SQLNOTFOUND   1403 	/* Ansi :100 ; Not ansi : 1403 */


#define LOGDEFAULT    3

char szUsage[]=
"\n\tUso : FaSched Opciones \n"
"\n\tOpciones :"
"\n\t\t -l nivel de Log     - Opcional -  Default : -l3 "
"\n\t\t -u usuario/password - Opcional -  Default : -u/ "
"\n\t\t -h help             - Opcional -  Muestra esta ayuda SIN EJECUTAR la aplicacion"
"\n";

#ifdef SIZE_HOSTARRAY
#undef SIZE_HOSTARRAY
#endif
#define SIZE_HOSTARRAY	100

typedef struct REG_FA_INTQUEUEPROC
{
	char    szCodModGener		[SIZE_HOSTARRAY][4]	;
	int     iCodProceso			[SIZE_HOSTARRAY]	;
	char    szCodTipProc		[SIZE_HOSTARRAY][2]	;
	char    szCodActivacion	    [SIZE_HOSTARRAY][2]	;
	int     iCodPrioridad		[SIZE_HOSTARRAY]	;
	int     iCodEstado			[SIZE_HOSTARRAY]	;
	char    szFecEstado			[SIZE_HOSTARRAY][15];
	long    lPidProceso			[SIZE_HOSTARRAY]	;
	char    szNomUsuarOra		[SIZE_HOSTARRAY][31];
	char    szPasUsuarOra		[SIZE_HOSTARRAY][31];
	int     iCodNivLog			[SIZE_HOSTARRAY]	;
	int     iCodTipIntervalo	[SIZE_HOSTARRAY]	;
	int     lNumSegundos		[SIZE_HOSTARRAY]	;
	char    szCodHoraDia		[SIZE_HOSTARRAY][9]	;
	char    szCodHoraFech		[SIZE_HOSTARRAY][15];
	char    szCodHoraVigIni	    [SIZE_HOSTARRAY][9]	;
	char    szCodHoraVigFin	    [SIZE_HOSTARRAY][9]	;
	int     iNumDeltaHoras      [SIZE_HOSTARRAY]	;
	int     iCodTipUnInter  	[SIZE_HOSTARRAY]	;
	int     iCodEstaDocEnt  	[SIZE_HOSTARRAY]	;
	int     iCodEstaDocSal  	[SIZE_HOSTARRAY]	;
	char    szCodAplic			[SIZE_HOSTARRAY][4]	;

}rg_fa_intqueueproc ;



/* declaracion de funciones */
int ifnValidaParametros ( int argc, char *argv[], char *szOraAccount, char *szOraPasswd);
access  int ifnCicloColasProc           ();
access  int ifnAbreArchivosLog          ();
access  int ifnCargaHostArray           ();
access  int ifnRecorreHostArray         ();
access  int ifnVerificaEstadoScheduler  ();
access  BOOL bfnRegistraEjecucionActual  ();


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

