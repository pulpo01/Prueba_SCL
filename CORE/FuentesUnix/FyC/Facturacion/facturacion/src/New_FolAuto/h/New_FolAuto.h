/* *********************************************************************** */
/* *  Fichero  : foliacion.h                                             * */
/* *  Autor    : Roy Barrera R.											 * */
/* *  Complice : Mauricio Villagra V.                                    * */
/* *********************************************************************** */

#include <deftypes.h>
#include <New_Interfact.h>
#include <GenFA.h>

/************************************************************************/
/*  Nivel de Log por Default                                            */
/************************************************************************/

#define     iLOGNIVEL_DEF               3

#define     iPROCESO_INT_FOLIACION_AUTO 320

#define     iINDANULACION_CONSUMO       0
#define     iINDANULACION_ANULA         1


/*********************************************
Estructura para recoger los datos por 
la linea de comandos.     
**********************************************/
typedef struct LineaComandoFoliacion
{
    char    szUsuarioOra    [64]    ;
    char    szOraAccount    [32]    ;
    char    szOraPasswd     [32]    ;

    char    szCodModGener   [4]     ;	/* Cod_ModGener de la Cola */
     int    iNivLog                 ;

    char    szDirLogs       [1024]  ;   /*  Directorio de Archivos Log's y Err      */
    char    szDirDats       [1024]  ;   /*  Directorio de Archivos de Datos Dat     */
    char    szDataName      [1024]  ;   /*  Nombre del Archivo de Datos de Folios   */
    FILE    *DataFile               ;   /*  Puntero de Archivo de Datos (Folios)    */
 
}FOLIACIONLINEACOMANDO;

/*****************************************************
Estructura para almacenar datos de facturas a Foliar
*****************************************************/
typedef struct RegistroFacturFolio
{                            
    long  lNumFolio      ;
	long  lNumProceso    ;
}FOLIACIONREGINTERFAZ;    

/***********************************************************
Estructura para almacenar datos de AL_CONSUMO_DOCUMENTOS 
***********************************************************/
typedef struct RegistroAlConDocum
{   
    char    szCodOficina  [2]   ;
    long    lCodTipDocum        ;
    long    lNumFolio           ;
    char    szUsuario     [30]  ;
    char    szFecConsumo  [20]  ;
    char    szIndConsumo  [1]   ;
    short   i_sIndConsumo       ;
    int     iIndAnulacion       ;
}FOLIACIONALCONSUDOCUM;    

/************************************************************************/
/*   Definiendo Variables y Estructuras Globales                        */
/************************************************************************/

FOLIACIONLINEACOMANDO     stLineaComando      ;

FOLIACIONREGINTERFAZ      stRegDocumFoli      ;
 
FOLIACIONALCONSUDOCUM     stRegAlConDoc       ;

/************************************************************************/

#undef access

#ifdef _FOLIACION_PC_
#define access
access BOOL bfnValidaParametros		( int argc, char *argv[]
									, FOLIACIONLINEACOMANDO *pstLineaCom );
access BOOL bfnAbreArchivos			( FOLIACIONLINEACOMANDO *pstLineaCom
									, char *szDate);
access BOOL bfnFoliacionOnline 		( FOLIACIONLINEACOMANDO *pstLineaCom );
access BOOL bfnOpenInterfaz			( INTQUEUEPROC stIntQueueProc
									, int iCodEstProc);
access int ifnFetchInterfaz			( FOLIACIONREGINTERFAZ *pstRegDocumFoli);
access BOOL bfnUpdateFolios			( FOLIACIONREGINTERFAZ *pstRegDocumFoli
									, char *szCodOficina
									, int *iFol);
access BOOL bfnUpdateFactDocuNoCiclo( long lNumProceso
									, char *szCodOficina);
access BOOL bfnCloseInterfaz		( void );
access BOOL bfnGetOficinaCentral	( char *szCodOficina);

#else
#define access extern
#endif


#undef access
#undef _FOLIACION_PC_

/* RBR here */

static char szUsage[]=
"\n\tUso: New_FolAuto Opciones"
"\n											 "
"\n\tOpciones:								 "
"\n											 "
"\n\t\t-e  Cod_ModGener				 		 "
"\n\t\t-u 'Usuario/Password' o '/' (Opcional)"
"\n\t\t-l  Nivel Log (Opcional)				 "
"\n";



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

