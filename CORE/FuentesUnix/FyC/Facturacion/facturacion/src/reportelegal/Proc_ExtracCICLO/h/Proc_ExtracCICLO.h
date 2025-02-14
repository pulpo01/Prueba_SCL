/* ****************************************************************************** */
/* *  Fichero : Proc_ExtracCICLO.h                                        	* */
/* *  Cabecera del proceso Extractor de data para genracion de reportes Legales * */
/* *  Autor : Patricio Gonzalez Gomez	                                 	* */
/* *  Modif : 								 	* */
/* ****************************************************************************	* */

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

#ifndef _PROC_EXTRACCICLO_H_
#define _PROC_EXTRACCICLO_H_

/* Definicion de contantes */
#define   iLOGNIVEL_DEF  3

#define	  iCOD_PROCESO	9200

/* Definicion de estructuras */
typedef struct TagLINEACOMANDO
{
    char    	szUser       	[50]	;
    char    	szUsuario    	[63]	;
    char    	szPass       	[50]	;
    long	lCodCiclFact    	;
    long    	lCodCliente		;
    long	lCodCiclo		;
    int     	iNivLog			;
}LINEACOMANDO;


/*--------------------------------------------------------------------------*/
typedef struct DATOSCICLO
{
	long	lCodCiclFact		;
}REG_DATOSCICLO;

typedef struct DATOSCICLO_HOST
{
	long	lCodCiclFact		[TAM_HOSTS_PEQ];
}REG_DATOSCICLO_HOST;

typedef struct TagDATOSCICLO
{
	int			iCantCiclos;
	REG_DATOSCICLO		*stDatosCiclos;

}REG_DATOSCICLO_S;

/*-----------------------------------------------------------------------------*/

typedef struct DATOSACUM
{
	long	lNum_Secuenci      		        ;
	long	lCod_Tipdocum      		        ;
	long	lCod_Vendedor_Agente		        ;
	char	szLetra         		[1  + 1];
	long	lCod_Centremi      		        ;
	double	dTot_Pagar         		        ;	
	char	szFec_Emision	     		[8  + 1];
	double	dAcum_Netograv    		        ;
	double	dAcum_Netonograv   		        ;
	long	lInd_Ordentotal	     		        ;
	long	lInd_Anulada          		        ;
	long	lNum_Folio	        	        ;
	char	szFec_Vencimie	       		[8  + 1];
	long	lCod_Ciclfact	      		        ;
	long	lCod_Concepto	        	        ;
	char	szFec_Efectividad		[8  + 1];
	double	dImp_Concepto	        	        ;
	char	szCod_Provincia	        	[3  + 1];
	char	szCod_Comuna	        	[5  + 1];
	long	lCod_Ciudad	        	        ;
	double	dImp_Montobase	        	        ;
	long	lInd_Factur			        ;
	double	dImp_Facturable	        	        ;
	char	szCod_Tipidtrib         	[2  + 1];
	char	szNum_Identtrib         	[20 + 1];
	char	szNom_Cliente           	[50 + 1];
	char	szNom_Apeclien1         	[20 + 1];
	char	szNom_Apeclien2         	[20 + 1];
	char	szDes_Tipident          	[20 + 1];
	long	lCod_Zonaimpo				;

}REG_DATOSACUM;

typedef struct DATOSACUM_HOST
{
	long	lNum_Secuenci      		[TAM_HOSTS_PEQ]        ;
	long	lCod_Tipdocum      		[TAM_HOSTS_PEQ]        ;
	long	lCod_Vendedor_Agente		[TAM_HOSTS_PEQ]        ;
	char	szLetra         		[TAM_HOSTS_PEQ][1  + 1];
	long	lCod_Centremi      		[TAM_HOSTS_PEQ]        ;
	double	dTot_Pagar         		[TAM_HOSTS_PEQ]        ;	
	char	szFec_Emision	     		[TAM_HOSTS_PEQ][8  + 1];
	double	dAcum_Netograv    		[TAM_HOSTS_PEQ]        ;
	double	dAcum_Netonograv   		[TAM_HOSTS_PEQ]        ;
	long	lInd_Ordentotal	     		[TAM_HOSTS_PEQ]        ;
	long	lInd_Anulada          		[TAM_HOSTS_PEQ]        ;
	long	lNum_Folio	        	[TAM_HOSTS_PEQ]        ;
	char	szFec_Vencimie	       		[TAM_HOSTS_PEQ][8  + 1];
	long	lCod_Ciclfact	      		[TAM_HOSTS_PEQ]        ;
	long	lCod_Concepto	        	[TAM_HOSTS_PEQ]        ;
	char	szFec_Efectividad		[TAM_HOSTS_PEQ][8  + 1];
	double	dImp_Concepto	        	[TAM_HOSTS_PEQ]        ;
	char	szCod_Provincia	        	[TAM_HOSTS_PEQ][3  + 1];
	char	szCod_Comuna	        	[TAM_HOSTS_PEQ][5  + 1];
	long	lCod_Ciudad	        	[TAM_HOSTS_PEQ]        ;
	double	dImp_Montobase	        	[TAM_HOSTS_PEQ]        ;
	long	lInd_Factur			[TAM_HOSTS_PEQ]        ;
	double	dImp_Facturable	        	[TAM_HOSTS_PEQ]        ;
	char	szCod_Tipidtrib         	[TAM_HOSTS_PEQ][2  + 1];
	char	szNum_Identtrib         	[TAM_HOSTS_PEQ][20 + 1];
	char	szNom_Cliente           	[TAM_HOSTS_PEQ][50 + 1];
	char	szNom_Apeclien1         	[TAM_HOSTS_PEQ][20 + 1];
	char	szNom_Apeclien2         	[TAM_HOSTS_PEQ][20 + 1];
	char	szDes_Tipident          	[TAM_HOSTS_PEQ][20 + 1];
	long	lCod_Zonaimpo			[TAM_HOSTS_PEQ]	       ;
}REG_DATOSACUM_HOST;

typedef struct TagDATOSACUM
{
	int			iCantDatosAcum;
	REG_DATOSACUM		*stDatosAcum;

}REG_DATOSACUM_S;



/*--------------------------------------------------------------------------*/


#undef access

#ifdef _PROC_EXTRACCICLO_PC_
#define access
#else
#define access extern
#endif  /* _PROC_EXTRACCICLO_PC_ */


/* Declaracion de variables y estructuras globales */
LINEACOMANDO		  	stLineaComando;

access REG_DATOSACUM_S  	pstDatosAcum	;
access REG_DATOSCICLO_S  	pstDatosCiclos	;





/* Definicion de prototipos de funciones */

BOOL bfnCargaEstructuras();

void vfnPrintDatosAcum (REG_DATOSACUM *pstDatosAcum, int iNumAcum);
static int ifnOpenDatosAcum (void);
static BOOL ifnFetchDatosAcum (REG_DATOSACUM_HOST *pstHost,long *plNumFilas);
int ifnCloseDatosAcum (void);
int iCargaDatosAcum(REG_DATOSACUM **pstDatosAcum, int *iNumAcum);


int ifnAbreArchivosLog	(void);



#undef access
#endif  /* _PROC_EXTRACCICLO_H_ */

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

