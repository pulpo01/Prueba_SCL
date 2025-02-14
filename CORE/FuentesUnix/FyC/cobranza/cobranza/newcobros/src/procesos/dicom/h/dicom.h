/* ============================================================================= */
/*
    Tipo        :  COLA DE PROCESO

    Nombre      :  dicom.h

    Descripcion :  Header para dicom.pc
    
    Autor       :  Manuel Garcia G.
    Fecha       :  17 - Mayo - 2001
*/ 
/* ============================================================================= */

#include <CO_deftypes.h>     /* Inclusion de tipos generales de cobranza         */
#include <CO_oracle.h>
#include <CO_libacciones.h>   /* Inclusion de nueva libreria general de procesos       */
#include <CO_libgenerales.h>  /* Inclusion de nueva libreria general                   */
#include <CO_libprocesos.h>   /* Inclusion de nueva libreria general de procesos       */

/* Re-definicion LOCAL de sqlnotfound: Valor del modo Oracle */
#ifdef SQLNOTFOUND
#undef SQLNOTFOUND
#endif
#define SQLNOTFOUND 1403 /*  100:Ansi    1403:Oracle */


#define ARRAY_DOCS       	10000
#define ARRAY_AUX        	10000
#define HOSTARRAY_MOVTOS 	30000
#define ARRAY_RZODICOM	 	30000
#define MAXARCHIVOS 		100
#define HOSTARRAY_DETALLES  5000

/*===========================================================================================
						Definiciones de Uso general
===========================================================================================*/	

#define     szVERSION			"5.0.0"	/* Nueva version para RAN*/

#define		CTGOCONTABLE 	39
 	
typedef struct MOVTOS_CLIENTES
{
    char szNumIdent    [HOSTARRAY_MOVTOS][iLENNUMIDENT];
    char szCodTipIdent [HOSTARRAY_MOVTOS][3];
}td_Movtos_Clientes ;   

typedef struct REC_DICOM
{
    char	szNumIdent[iLENNUMIDENT];
	char	szNomMaest[61];
	char	szCodCertif[6];                 
	long	lNumFolio;
	double	dMontoDocto;    
	char	szCodRechazo[6];                 
	char	szRegistro[177]; 
}td_DatRzoDicom;       

typedef struct ARCHIVOS
{
    char	szNomArchivo[51];
}td_Archivos;    

typedef	struct RG_CODETARCH
{
	char	szCodEntidad[HOSTARRAY_DETALLES][6];	/* N VARCHAR2	6	*/
	char	szTxtReg[HOSTARRAY_DETALLES][1025];	/* N VARCHAR2	1024 */
}rg_codetarch;   

/* ============================================================================= */
/* declaracion de prototipos de funciones                                        */
/* ============================================================================= */
int ifnValidaParametros( int argc, char *argv[], LINEACOMANDO *pstLC );
int ifnConexionDB(LINEACOMANDO *pstLC);
int ifnPreparaArchivoLog();
int ifnAbreArchivoLog(int iCrearDir);
void vfnCierraArchivoLog(void);
int ifnEjecutaCola(void);
int ifnRechazosDicom( char* szDescError, long lSeqProceso );
int ifnDicom(char* szDescError, long lSeqProceso );
/*int ifnProcesaClienteSM( long Secuencia, char *szNumIdent, char *szCodTipIdent, char *szMovimiento, int iDiasVenc, double dDeudaMin, char* szDescError );*/
int ifnProcesaClienteSM( long Secuencia, char *szNumIdent, char *szCodTipIdent, char *szMovimiento, int iDiasVenc, double dDeudaMin, int *iCntClientes, char* szDescError );
BOOL bfnBorraCastigosContables( char *szNumIdent, char *szCodTipIdent );
int ifnDicom( char* szDescError, long lSeqProceso );


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

