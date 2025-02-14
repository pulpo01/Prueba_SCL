/* ============================================================================= 
 Tipo          :  FUNCIONES GENERALES 
 Nombre        :  CO_libacciones.h
 Descripcion   :  Header para CO_libacciones.pc
 Creada 14-10-2004 por Proyecto P-MAS-04037 Mejoras Ejecutor y Excluidor
 Version 4.0.0 
 ============================================================================= */
#include <lstEvalua.h>
#ifndef _COLIBPROCESOS_H_
#define _COLIBPROCESOS_H_

#ifdef _COLIBPROCESOS_PC_
#endif /* _COLIBPROCESOS_PC_ */

#undef access
#ifdef _COLIBPROCESOS_PC_
#define access 
#else
#define access extern
#endif /* _COLIBPROCESOS_PC_ */

#define  BUFFER_SIZE	10000

static int          iCumpleCriterio= 0;  /* XO-200508090319 09-08. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */

/* --------------------------------------------------------------------------------------------- */
/* Prototipos de funciones        																					 */
/* --------------------------------------------------------------------------------------------- */
int ifnAbreArchivoLogHil(char *szNomArch, FILE **fsArchLog);
int ifnAbreArchivoLogHiloEjecEx(char *szNomArch, FILE **fsArchLog, char *szSysdate);
void vfnCierraArchivoLogHil(FILE **fstArch);
int ifnTrazaHilos (char* szExeNameApp, FILE **fArch, char* szTxt, int iNivel,...);
BOOL bfnCambiaCodActivacionCola( char *szCodProceso, char *szCodActivacion );
BOOL bfnCambiaEstadoCola( char *CodProceso, char *Desde, char *Hasta );
BOOL bfnRecuperaEstadoCola( char *szCodProceso, char *szCodEstado );
BOOL bfnValidaColaActiva (char *szCodProceso, int *iFlgActiva);
int  ifnVerFinColaAnterior(int iProc);
BOOL bfnObtieneDatosGenerales( void );
int  bGetParamDecimales( void );
int  ifnRestaHoras( char *h1, char *h2, char *hh);
int  HoraToSegs(char *HoraFmto);
void Strcpysub(char *str1, int Largo, char *str2);
void rtrim( char *szCadena );
int  ifnMailAlert (char* szFrom, char* szMailTo, char* szTxt, ...);
BOOL bfnActualizaIndiceSec( char *szValParametro, char *szNomParametro );

BOOL bfnGenArchCobExterna( char *szCodProceso,     long lProceso,       char *szEntidad,     char *szEnvio, 
                           char *szIdent,          char *szTipIdent,     int iRutStgo,
                           long *lRegsEscritos,  double *dMontoEscrito, char *szNombreArchivo );
BOOL bfnGetPerfil( long lCli, char *szPerfil );
void yield2(void);
void *vfnEvaluaMO( void *x);
void *vfnEvaluaCM (void *x);
int  ifnClienteEvaluar(FILE **ptArchLog , lista_Pto lsPtoGest, int igGenMoroso, stLista *lstCli);
int  ifnEjecutaCriteriosEv ( FILE **ptArchLog, lista_Crit pRutina, struct stCliente stMR, int *iMaxDiasPro , int iFlagLog);
int  ifnGeneraMorosos( FILE **ptArchLog,  lista_Pto lsPtoG, stLista *lstCli);
int  ifnActualizaMorosos( FILE **ptArchLog, stLista *lstCli );
int  ifnAccionACliente(FILE **ptArchLog , lista_Acc list, stLista *lstCli , char *szpFecAccion , char *szpFecHoy, lista_Pto lsPtoG);
BOOL bfnGetSaldoClienteEv( FILE **ptArchLog, long lCliente, double *pdSaldoNoVenc);
int  ifnBuscaPtoCategClte(lista_Categ pCategorias, lista_Pto *pPtogest, lista_SecPtos *pSecPtos,char *szCateg);
BOOL bfnFindNewCodGestionEv( FILE **ptArchLog,long lCodCliente, int iIndExcluye, char *szCod_Gestion );
int  ifnDetFechaEjecucionEv( FILE **ptArchLog , char *szCodAccion, char *szFecEjecucion)  ;
int  ifnValidaMaxAccionesDiaEv( FILE **ptArchLog , char *szCodAccion, char *szFecEjecucion, long lMaxAccDia, struct ACCIONES *stNodoAcc ) /* fmto: YYYYMMDD */;
int  ifnDetFeriadosEv( FILE **ptArchLog , char *szFecha ) ;
int  ifnPtoProrr( lista_Pto pPtoGest, char *szFecVencClte);
BOOL bfnUpdateEstadoGaABO( long lCliente, int iIndExcluye, long lNumSecuAccion );
BOOL bfnUpdateGedParametro( char *szNomParametro, char *szCodModulo, char *szValParametro );
int  ifnBuscaSecAnt( lista_SecPtos pSecCateg, int iSecClte, int iSecPto);
int  ifnCargaPtosGest( lista_Pto *pPtoGestion, char *szCodCategoria  );
int  ifnCargaAcciones( lista_Acc  *pAcciones, char *PtoGest, char *Categoria, int Proceso);
int  ifnCargaCriterios( lista_Crit  *pCriterios, char *PtoGest, char *Categoria, int Proceso, int TipProc);
int  ifnCargaSecPtos( lista_SecPtos  *pSecPtos, char *Categoria);
int  ifnEsDiaHabil(char *szDia, char *szFecha) ;
int  ifnPtosCateg( lista_Categ *pCategoria );
int  ifnUpdateEstadoAccion(long lCli, long lNSeq, char *szEst, int iAboCelu, int iAboBeep, int iMRAboCelu, int iMRAboBeep);
int  ifnInsertaEstadisticas(int piSecuencia , char *pszProceso ); 
int  ifnUpdateEstadisticas( char *pszProceso , int iTpoTotal , long lTotalReg, int iSecuencia);

int ifnDetFechaEjecucion( char *szCodAccion, char *szFecEjecucion);
int ifnDetFeriados( char *szFecha );

int  ifnDetFechaEjecucionContex(FILE **ptArchLog, char *szCodAccion, char *szFecEjecucion, sql_context ctxCont) ;
int  ifnDetFeriadosContex(FILE **ptArchLog, char *szFecha , sql_context ctxCont) ;
BOOL bfnValidaColaActivaContex (FILE **ptArchLog, char *szCodProceso, int *iFlgActiva, sql_context ctxCont);
int  ifnCargaCriteriosAcc(FILE **ptArchLog,  lista_Crit  *pCriterios, char *PtoGest, char *Categoria, int Proceso, int TipProc, sql_context ctxCont );
int  ifnUpdateEstadoAccionH(FILE **ptArchLog, long lCli, long lNSeq, char *szEst, int iAboCelu, int iAboBeep, int iMRAboCelu, int iMRAboBeep, sql_context ctxCont);
BOOL bfnPasoHistoricoGeneralContex( FILE **ptArchLog, long lCodCliente, int iExclusionTotal, sql_context ctxCont );
BOOL bfnPasoHistoricoAccionesContex (FILE **ptArchLog, long lCliente, sql_context ctxCont );
BOOL bfnPasoHistoricoMorososContex (FILE **ptArchLog, long lCliente, sql_context ctxCont );
BOOL bfnPasoHistoricoGestionContex (FILE **ptArchLog, long lCliente, sql_context ctxCont );
BOOL bfnFindNewCodGestionContex( FILE **ptArchLog, long lCodCliente, int iIndExcluye, sql_context ctxCont );
int  ifnInsertaEstadisticasContex( FILE **ptArchLog, int piSecuencia , char *pszProceso, sql_context ctxCont );
int  ifnEjecutaCriteriosEvContex ( FILE **ptArchLog, lista_Crit pRutina, struct stCliente stMR, int *iMaxDiasPro , sql_context ctxCont );
BOOL bfnClasificacionCrediticia( FILE **ptArchLog, long lCodCliente, int iIndExcluye, sql_context ctxCont ); /* Incidencia #116617 - 18.12.2009 */

#endif /* _COLIBPROCESOS_H_ */

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
