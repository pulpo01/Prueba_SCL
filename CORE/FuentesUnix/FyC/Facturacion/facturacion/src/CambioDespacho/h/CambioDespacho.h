/* ***********************************************
		  "CambioDespacho.h"
		  28-08-2008
		  Jaime Espinoza Matamala
			 					
*********************************************** */

/* inclusion de archivos */
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>
#include <strings.h>
#include <math.h>
#include <time.h>
#include <GenFA.h>
#include <unistd.h>


/* Definicion de contantes */
#define   iLOGNIVEL_DEF  3


/* Definicion de estructuras */
typedef struct LINEACOMANDO
{
    char    szUser       [50];
    char    szUsuario    [63];
    char    szPass       [50];
    char    szDirLogs  [1024];       /*  Directorio de Archivos Log's y Err      */
    int     iNivLog;
    char    szNomArchivo [50+1];
}LINEACOMANDOCARGADES;

typedef struct FORMATO
{
	long lCodCliente          ;
	char szMail           [71];
	int  iTipDistribucion     ;
	char szFecModif       [15];
	int  iCodCausa            ;
	char UserResp         [31];
}FORMATO_ARCH;

/* Declaracion de variables y estructuras globales */


LINEACOMANDOCARGADES  stLineaComando;

/* Definicion de prototipos de funciones */

int ifnAbreArchivosLog	(void);
int bCambiodespacho (char *szhNomArchivo ) ;
int bAbrirArchivoDespacho( char *szNomArchivo, FILE **fpent);
int bProcesarArchivoDespacho(char *szNomArchivo, FILE *fpent);
int bCerrarArchivoDespacho( char *szNomArchivo, FILE **fpent);
char **split ( char *string, const char sep, int *iCantReg);
int bValidacionLinea(char **listSplit, long lLineaArchivo, char *szBufferIn, FORMATO_ARCH *stFormatoLinea);
int bActualizaClientes(FORMATO_ARCH *stFormatoLinea,long lLineaArchivo,char *szBufferIn);
int isNumber(char *szVarAux);

extern char * ltrim(char *s);
extern char * rtrim(char *s);
extern char * alltrim(char *s);

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

