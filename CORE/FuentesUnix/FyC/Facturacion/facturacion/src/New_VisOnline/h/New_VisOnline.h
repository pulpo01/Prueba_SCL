/* ******************************************************************** */
/* *  Fichero : foliacion.h                                           * */
/* *  Autor    : Roy Barrera R.									      * */
/* *  Complice : Mauricio Villagra V.                                 * */
/* ******************************************************************** */

/************************************************************************/
/*  Nivel de Log por Default                                            */
/************************************************************************/

#define     iLOGNIVEL_DEF               3

#define     IND_VISACION_ERR           -1
#define     IND_VISACION_NOT            0
#define     IND_VISACION_OK             1


/************************************************************************/
/*  Define tipos de Movimientos de Facturacion                          */
/************************************************************************/
#define     iTIPMOV_VENTA           1
#define     iTIPMOV_CICLO           2
#define     iTIPMOV_MISCELANEO      18
#define     iTIPMOV_NOTACREDITO     25


/************************************************************************/
/*  Define tipos de Dpcumentos de Almacen                               */
/************************************************************************/
#define     iCODTIPDOCALMAC_CONSIGNACION        52
#define     iCODTIPDOCALMAC_NOTCREDCONSIG       66

/************************************************************************/
/*  Estados de la Venta                                                 */
/************************************************************************/
#define COD_ESTVENTA_RECHAZADA                  "RE"
#define COD_ESTVENTA_ACEPTADA                   "AC"     
#define COD_ESTVENTA_PORTABILIDAD_EN_PROCESO    "PP"  /*INC 200923 GCASTRO 12-12-2013 */
#define COD_ESTVENTA_PENDIENTE_DOCUMENTAR       "PD"  /*INC 200923 GCASTRO 12-12-2013 */

/*********************************************
Estructura para recoger los datos por
la linea de comandos.
**********************************************/
typedef struct LineaComandoVisacion
{
    char    szUsuarioOra [64] ;
    char    szOraAccount [32] ;
    char    szOraPasswd  [32] ;

    char    szCodModGener[4];		/* Cod_ModGener de la Cola */
     int    iNivLog         ;

    char    szDirLogs[1024] ;       /*  Directorio de Archivos Log's y Err      */
}VISONLINELINEACOMANDO;

/*****************************************************
Estructura para almacenar datos de facturas a Foliar
*****************************************************/
typedef struct RegistroFacturFolio
{
    long    lNumVenta       ;
    long    lNumProceso     ;
    int     iCodTipMovimien ;
    int     iCodTipDocum    ;
    int     iCodTipDocumAlma;
    int     iIndVisacion    ;
}VISONLINEREGINTERFAZ;


/************************************************************************/
/*   Definiendo Variables y Estructuras Globales                        */
/************************************************************************/

VISONLINELINEACOMANDO     stLineaComando      ;

/************************************************************************/

#undef access

#ifdef _VISONLINE_PC_
#define access
#else
#define access extern
#endif

int     ifnFetchInterfaz    (   VISONLINEREGINTERFAZ    *pstRegDocumVis);

BOOL    bfnValidaParametros (   int                     argc,
                                char                    *argv[],
                                VISONLINELINEACOMANDO   *pstLineaCom);

BOOL    bfnAbreArchivos     (   VISONLINELINEACOMANDO   *pstLineaCom,
                                char                    *szDate);

BOOL    bfnVisOnlineOnline  (   VISONLINELINEACOMANDO   *pstLineaCom);

BOOL    bfnOpenInterfaz     (   INTQUEUEPROC            stIntQueueProc,
                                int                     iCodEstProc);

BOOL    bfnUpdateDocumento  (   VISONLINEREGINTERFAZ    *pstRegDocumVis,
                                char                    *szOraUser);

BOOL    bfnValEstadoVenta   (   VISONLINEREGINTERFAZ    *pstRegDocumVis);

BOOL    bfnValNotaCredito   (   VISONLINEREGINTERFAZ *pstRegDocumVis );

BOOL    bfnCloseInterfaz    (   void);


#undef access
#undef _VISONLINE_PC_

/* RBR here */

static char szUsage[]=
"\n\tUso: New_VisOnline Opciones"
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

