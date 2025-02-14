/* ***********************************************
			  "QUEUEFACT.h"
		 26 de Noviembre de 1999
		  Roy Barrera Richards

			 "QUEUEADMIN.h"
		 13 de Diciembre de 1999 
			 	 				
*********************************************** */

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
#define SQLOK		    0

#define access 		   extern

#ifdef SQLNOTFOUND
#undef SQLNOTFOUND
#endif

#define SQLNOTFOUND   1403 	/* Ansi :100 ; Not ansi : 1403 */

char szUsage[]=
"\n\tUso : New_QueueAdmin Opciones \n"
"\n\tOpciones :"
"\n\t\t-e cod_Modgener"
"\n\t\t-p cod_Proceso"
"\n\t\t-t cod_Tipproc"
"\n\t\t-l nivel de Log de la cola(Opcional)"
"\n\t\t-u usuario/password o '/'(Opcional)"
"\n\t\t-c cod_Aplicacion"
"\n";


/* declaracion de funciones */
access  int ifnAcessoOracle     ();
access  int ifnAbreArchivosLog  ();

access int ifnValidaParametros ( 
			  int   , 
			  char *[],
			  int  *,
			  char *,
			  char *,
			  char *,
			  char *,
			  int  *,
			  char *);


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

