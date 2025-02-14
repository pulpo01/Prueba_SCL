/* ***********************************************
               "IMPREONLINE.h"
          13 de Diciembre de 1999 
           Roy Barrera Richards
*********************************************** */

/* inclusion de archivos */

/* definiciones de constantes */
#define FALSE           0
/*#define TRUE            1*/
#define SQLOK		    0

#define access 		   extern

#define VENTA			1
#define MISCELANEA	   18
#define NOTACRED	   25

#ifdef SQLNOTFOUND
#undef SQLNOTFOUND
#endif

#define SQLNOTFOUND   100 	/* Ansi :100 ; Not ansi : 1403 */

char szUsage[]=
"\n\tUso : ImpreOnline Opciones \n"
"\n\tOpciones :"
"\n\t\t-e cod_Modgener"
"\n\t\t-l nivel de Log"
"\n\t\t-u usuario/password o '/'(Opcional)"
"\n";


/* declaracion de funciones */
access int ifnValidaParametros(int argc, char *argv[], char *szOraAccount, char *szOraPasswd,
						  int *iLogLevel, char *szCodModGener  ); 
access int ifnAcessoOracle();
access int ifnImpresionOnline();
int ifnAbreArchivosLog(int iLogLevel);


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

