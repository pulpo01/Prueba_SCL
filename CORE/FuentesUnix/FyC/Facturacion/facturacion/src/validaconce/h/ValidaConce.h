/* ********************************************************************** */
/* *  Fichero : ValidaConce.h                                        	* */
/* *  Cabecera del generador de reportes de validacion de conceptos	* */
/* *  Autor : Patricio Gonzalez Gomez	                                * */
/* *  Modif : 								* */
/* ********************************************************************** */


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

#ifndef _VALIDACONCE_H_
#define _VALIDACONCE_H_

/* Definicion de contantes */
#define   	iLOGNIVEL_DEF  3
#define		iCODPROCVALIDACONCE 2999

/* Definicion de estructuras */
typedef struct LINEACOMANDO
{
    char    	szUser       [50]	;
    char    	szUsuario    [63]	;
    char    	szPass       [50]	;
    long	lMes			;
    long	lAno			;
    long    	lCodCliente		;
    long	lCodCiclo		;
    char	szFecInicio  	[9]	;
    char	szFecFin  	[9]	;
    int     	iNivLog			;
}LINEACOMANDOPRELIMINAR;


/*----------------------------------------------------*/

typedef struct ARCH_STRUCT
{
	long	lCod_Cliente	;
	long	lNum_Abonado	;
	long	lCod_Carg	;
	long	lCantidad	;
}REG_ARCH_STRUCT;

typedef struct ARCH_STRUCT_HOST
{
	long	lCod_Cliente	[TAM_HOSTS_PEQ];
	long	lNum_Abonado	[TAM_HOSTS_PEQ];
	long	lCod_Carg	[TAM_HOSTS_PEQ];
	long	lCantidad	[TAM_HOSTS_PEQ];
}REG_ARCH_STRUCT_HOST;

typedef struct TagARCH_STRUCT
{
	int			iCantRegStruct;
	REG_ARCH_STRUCT		*stRegStruct;

}REG_ARCH_STRUCT_S;

/*----------------------------------------------------*/



#undef access

#ifdef _VALIDACONCE_PC_
#define access
#else
#define access extern
#endif  /* _VALIDACONCE_PC_ */


/* Declaracion de variables y estructuras globales */
LINEACOMANDOPRELIMINAR  	stLineaComando	;
access REG_ARCH_STRUCT_S	pstRegStruct	;



/* Definicion de prototipos de funciones */
void trim (const char *c, char *result);
int iCargaEstructura(REG_ARCH_STRUCT **pstRegStruct, int *iNumRegStruct);
static int ifnOpenSTRUCT (void);
static BOOL ifnFetchSTRUCT (REG_ARCH_STRUCT_HOST *pstHost,long *plNumFilas);
int ifnCloseSTRUCT (void);
void vfnPrintSTRUCT (REG_ARCH_STRUCT *pstRegStruct, int iNumRegStruct);
BOOL bfnCargaEstructuras();
BOOL bfnGeneraReporte();
int ifnAbreArchivosLog(void);


#undef access
#endif  /* _VALIDACONCE_H_ */
