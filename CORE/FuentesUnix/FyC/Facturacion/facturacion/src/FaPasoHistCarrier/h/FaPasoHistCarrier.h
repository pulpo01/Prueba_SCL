/* *********************************************************************** */
/* *  Fichero : FaPasoHistCarrier.h                         	         * */
/* *  Cabecera del proceso FaPasoHistCarrier		                 * */
/* *  Autor : Patricio Gonzalez Gomez	                                 * */
/* *  Modif : 								 * */
/* *********************************************************************** */

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

#ifndef _FA_PASOHISTCARRIER_H_
#define _FA_PASOHISTCARRIER_H_

/* Definicion de contantes */
#define   iLOGNIVEL_DEF  3


/* Definicion de estructuras */
typedef struct LINEACOMANDO
{
    char    	szUser       [50]	;
    char    	szUsuario    [63]	;
    char    	szPass       [50]	;        
    long    	lCodCarrier		;
    long	lCodCiclo		;
    int     	iNivLog			;
}LINEACOMANDOCARRIER;


typedef struct FA_ACUMFORTAS
{
	long	lCodCliente	;
	long	lNumAbonado	;
	long	lCodPeriodo	;
	long	lCodOperador	;
}REG_FA_ACUMFORTAS;

typedef struct FA_ACUMFORTAS_HOST
{
	long	lCodCliente	[TAM_HOSTS_PEQ];
	long	lNumAbonado	[TAM_HOSTS_PEQ];
	long	lCodPeriodo	[TAM_HOSTS_PEQ];
	long	lCodOperador	[TAM_HOSTS_PEQ];
}REG_FA_ACUMFORTAS_HOST;

typedef struct TagFA_ACUMFORTAS
{
	int			iCantRegs;
	REG_FA_ACUMFORTAS	*stAcumFortas;

}REG_FA_ACUMFORTAS_S;

/*--------------------------------------------------------------------------*/

#undef access

#ifdef _FA_PASOHISTCARRIER_PC_
#define access
#else
#define access extern
#endif  /* _FA_PASOHISTCARRIER_PC_ */


/* Declaracion de variables y estructuras globales */
LINEACOMANDOCARRIER  		stLineaComando;
access REG_FA_ACUMFORTAS_S  	pstAcumFortas	;


/* Definicion de prototipos de funciones */
int ifnAbreArchivosLog	(void);
BOOL bfnBorraInfCarrier();
BOOL bfnCopiaAHistoricos();
BOOL bfnCargaEstructuras();


int iCargaFaAcumFortas(REG_FA_ACUMFORTAS **pstAcumFortas, int *iNumAcumFortas);
void vfnPrintFaAcumFortas (REG_FA_ACUMFORTAS *pstAcumFortas, int iNumAcumFortas);
int ifnCloseFaAcumFortas (void);
static BOOL ifnFetchFaAcumFortas (REG_FA_ACUMFORTAS_HOST *pstHost,long *plNumFilas);
static int ifnOpenFaAcumFortas (void);



#undef access
#endif  /* _FA_PASOHISTCARRIER_H_ */

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

