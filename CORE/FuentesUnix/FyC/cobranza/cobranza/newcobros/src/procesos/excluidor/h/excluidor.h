/* =================================================================================================
Tipo        :  COLA DE PROCESO
Nombre      :  excluidor.h
Descripcion :  Header para excluidor.pc
Autor       :  Cobranza
Fecha       :  09 - Agosto - 2000
======================================================================*/

#include <CO_deftypes.h>      /* Inclusion de tipos generales de cobranza              */
#include <CO_oracle.h>        /* Incluye funciones, codigos y punteros de Base de datos*/
#include <CO_stPtoRut.h>
#include <Acciones.h>         /* Incluye definiciones de funciones, codigos y punteros */
#include <CO_libacciones.h>   /* Inclusion de nueva libreria general de procesos       */
#include <CO_libgenerales.h>  /* Inclusion de nueva libreria general                   */
#include <CO_libprocesos.h>   /* Inclusion de nueva libreria general de procesos       */

#define HOSTARRAY_CLIENTE_EXCLU     30000    /* maximo de Clientes a considerar */
#define HOSTARRAY_ACCION_INVERSA    50       /* Maxima de Acciones Inversas */
#define MAX_REV                     1000

/* Re-definicion LOCAL de sqlnotfound: Valor del modo Oracle */
#ifdef SQLNOTFOUND
	#undef SQLNOTFOUND
#endif
#define SQLNOTFOUND 1403

/*#define szVERSION		"6.0.0"  * Nueva version para TMG-TMS */
/*#define szVERSION		"6.0.1" * Incidencia 116004 - 02.12.2009 - TMG-TMS */
#define szVERSION		"6.0.2" /* Incidencia 125767 - 12.03.2010 - TMG-TMS */

#define szCODPROCESO	  "EXCLU"		/* Define codigo por defecto de la cola */
#define VIGENTE         "V"
#define STATUS_ERR  -1

/**************************/
/**************************/
/* SOLO PRUEBA...ELIMINAR Y ACTIVAR ACCIONES.H */                                                                             
/* #define MAXACC 28                                                                                                          */
/* typedef struct func_acc                                                                                                    */
/* {                                                                                                                          */
/* 	char szCodigo[6];                                                                                                     */
/* 	char *(*szNombre) (long);                                                                                             */
/* } PUNT_FUNCION_ACC;                                                                                                        */
/* PUNT_FUNCION_ACC stAccion[] =   {"ACEXT\0",0,"ACJUD\0",0,"AEPER\0",0,"AEPLA\0",0,"AEJCS\0",0,"BAJA\0" ,0,"BLOQU\0",0       */
/* ,"CTAFN\0",0,"DACEX\0",0,"DESBL\0",0,"MENSJ\0",0,"NMENS\0",0,"MFACT\0",0,"AVENC\0",0,"PREBJ\0",0,"REPOS\0",0,"REPBI\0",0   */
/* ,"SUSBI\0",0,"SUSUN\0",0,"RBAJA\0",0,"ASDIC\0",0,"DADIC\0",0,"CARTA\0",0,"OUTBD\0",0,"ENRUT\0",0,"DENRT\0",0,"CANUM\0",0}; */
/**************************/
/**************************/
#define  MAX_INSTANCIAS		11

typedef struct PARAMETERS
{ 
	BOOL bDisponibilidad;
	sql_context *CtxInsBas;
	int  idThread;	
	char szUserOracle[32];
	char szPassOracle[32];
	long lIdInstancia;
	long lCorrInstancia;
} PARAMETROS;

typedef struct CLIENTE_EXCLU
{
	long	lCodCliente   [HOSTARRAY_CLIENTE_EXCLU];
	char	szNumIdent    [HOSTARRAY_CLIENTE_EXCLU][iLENNUMIDENT];
	char	szCodTipIdent [HOSTARRAY_CLIENTE_EXCLU][3];
	char	szCodTipClie  [HOSTARRAY_CLIENTE_EXCLU][2];
	double	dImportePago  [HOSTARRAY_CLIENTE_EXCLU];
    int	    iProcedencia  [HOSTARRAY_CLIENTE_EXCLU];

}td_Cliente_Exclu ;

typedef struct ACCION_INVERSA
{
    long	 lNumSecuencia  [HOSTARRAY_ACCION_INVERSA];
    char	 szCodRutinaInv [HOSTARRAY_ACCION_INVERSA] [6];
    int	     iOrdAplicacion [HOSTARRAY_ACCION_INVERSA];	 
}td_Accion_Inversa ;

typedef struct PARAMETROS
{
	char   szCodReversaBaja[6];
	double dSaldo;
	int	   iDiasBaja;
} td_Parametros;	

typedef struct ACCIONREV
{
	char szCod_accion  [6];
	char szDes_accion  [51];	
	struct ACCIONREV *sgte;
}ACCIONREV;

typedef struct ACCIONREV *Lista_Rev;
Lista_Rev list_inicio;
Lista_Rev Lista_aux;
Lista_Rev pRevaux;

/* ============================================================================= */
/* declaracion de prototipos de funciones                                        */
/* ============================================================================= */
int   ifnValInstancias();
int   ifnUsuarioParam();
int   ifnMemoriaUsada();
int   ifnInsertaParamUnix();
int   ifnValidaParametros();
int   ifnConexionDB();
int   ifnPreparaArchivoLog();
int   ifnAbreArchivoLog();
void  vfnCierraArchivoLog(); 
int   ifnExcluidor();
int   ifnExcluyeClientes();
long  lfnExcluyeAcciones( int iExclTotal, long lCodCli, char *szFecDeudVenc, int *iNumeroDias );
int   ifnProcesaPago(FILE **ptArchLog ,int iPos, long lCliente, char *szIdent, char *szTipIdent, char *szTipClie, double dPago, int *iSqlAuxStatus, long *lCont, char *szDescError, int iProcedencia, sql_context ctxCont);
int	  ifnCargaParametrosRBaja( td_Parametros *stParam );
BOOL  bfnVerifExclRBaja(FILE **ptArchLog, long lCodCliente, td_Accion_Inversa *sthAccionInversa, int *iTotAcciones, td_Parametros *stParam, sql_context ctxCont);
int   ifnExcluyeAcciones( FILE **ptArchLog, int iExclTotal, long lCodCli, char *szFecDeudVenc, int *iNumeroDias, sql_context ctxCont );
BOOL  bfnBorraCoRutinasDia(FILE **ptArchLog, long lCodCliente, char *szCodCategoria, int iNumDias, char *szAccion, sql_context ctxCont );
int   ifnIniListCrit(lista_Crit *list);
int   ifnInsertaCrit(lista_Crit *ant);
void  vfnBorraListaCrit(lista_Crit *list);
int   ifnExclusionParcial 	(FILE **ptArchLog, td_Accion_Inversa *sthAccionInversa, char *szFecDeudVenc, long lCodCliente, int *iNumero_Dias, char *szCodCateg, sql_context ctxCont);
int   ifnExclusionTotal 	(FILE **ptArchLog, td_Accion_Inversa *sthAccionInversa, long lCodCliente, int *iNumero_Dias, int *iTotAcciones, sql_context ctxCont);
int   ifnIniListRev(Lista_Rev *list);
int   ifnBorraRev(Lista_Rev *ant);
int   ifnCargaReversa();
int   ifnReversasValidas (FILE **ptArchLog, int iFilaAnt , int  iFilaPos);
int   ifnMenorPtoGestion (FILE **ptArchLog, int *iFilas, long lCodCliente, char *szCodCategoria, int *iNumDiasAux, sql_context ctxCont);
int   ifnMayorPtoGestion (FILE **ptArchLog, int *iFilas, long lCodCliente, char *szCodCategoria, int *iNumDiasAux, sql_context ctxCont);
int   ifnCargaLista (int iFilas);
int   Inicializar_lista(stLista *list);
void  Muestra_Lista(stLista lstListaCli);
BOOL  bfnBuscaFadParametros( long lCodParam, char *szTipCampo, char *szCodModulo, char *szRetorno );
int   Insertar_pos (stLista ant, struct stCliente e, long pos);
int   ifnCargaPtosGestion( td_PtoGestion *sthPtoGestion );
int   ifnCargaCriteriosPtos( td_PtoRutina *sthPtoGestion );
void  Destruir_lista(stLista *list);
void  *vfnExcluidor (void *x);
int   ifnSeccionaLista(long lTotalReg);
int   ifnEjecutaHilos();
int   ifnAbreArchivoLogHil(char *szNomArch, FILE **fsArchLog);
int   Leer_element (stLista list, long pos, struct stCliente *e);


/******************************************************************************************/
/** Información de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  CORE/FuentesUnix/FyC/cobranza/cobranza/newcobros/src/procesos/excluidor/h/excluidor.h */
/** Identificador en PVCS                               : */
/**  SCL:A852.A-UNIX;lib_randina#1 */
/** Producto                                            : */
/**  SCL */
/** Revisión                                            : */
/**  lib_randina#1 */
/** Autor de la Revisión                                : */
/**  MWN70401 */
/** Estado de la Revisión ($TO_BE_DEFINED es Check-Out) : */
/**  CERTIFICADO */
/** Fecha de Creación de la Revisión                    : */
/**  19-JUL-2005 21:38:10 */
/** Worksets ******************************************************************************/
/******************************************************************************************/

