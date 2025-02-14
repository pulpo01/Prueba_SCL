/* ============================================================================= 
 Tipo          :  FUNCIONES GENERALES 
 Nombre        :  CO_libacciones.h
 Descripcion   :  Header para CO_libacciones.pc
 Creada 14-10-2004 por Proyecto P-MAS-04037 Mejoras Ejecutor y Excluidor
 Version 4.0.0 
 ============================================================================= */
#ifndef _COLIBACCIONES_H_
#define _COLIBACCIONES_H_

#ifdef _COLIBACCIONES_PC_
#endif /* _COLIBACCIONES_PC_ */

#undef access
#ifdef _COLIBACCIONES_PC_
#define access 
#else
#define access extern
#endif /* _COLIBACCIONES_PC_ */

/* --------------------------------------------------------------------------------------------- */
/* Prototipos de funciones         																					 */
/* --------------------------------------------------------------------------------------------- */
access int ifnRecuperaGedParametro(FILE **ptArchLog, char *szNomParametro, char *szCodModulo , char *szValParametro, sql_context ctxCont );
access BOOL bfnGetSaldoPorRutAcc(FILE **ptArchLog, char *szNumIdent, char *szCodTipIdent,double *dMtoSaldoRut, sql_context ctxCont );
access BOOL bfnGetSaldoClienteAcc (FILE **ptArchLog, long lCliente, double *pdSaldoVenc, double *pdSaldoNoVenc, char *szFecVencimiento, sql_context ctxCont );
access int ifnGetRutCliente(FILE **ptArchLog, long lCliente, char *szNumIdent , char *szTipIdent, sql_context ctxCont );
access BOOL bfnActualizaCoGestionClienteAcc(FILE **ptArchLog, long lCodCliente  , long lCodCuenta, char *szNumIdent , char *szCodTipIdent,
								           char *szCodEntidad, char *pszRutina, char *pszCodMovimiento, sql_context ctxCont );
access int ifnRutMetropolitano (FILE **ptArchLog, long lCliente, int *iRetorno, sql_context ctxCont );
access int ifnAsigEjecCliente(FILE **ptArchLog, long lCodCliente, char *szpTipEntidad, sql_context ctxCont );
access int ifnAsigEjecRut (FILE **ptArchLog,long lCliente, sql_context ctxCont );
access int ifnVerifEjecRut(FILE **ptArchLog, long lCliente, char *szAgente, sql_context ctxCont );
BOOL bfnExtraerCadenaPerfilAbo( FILE **ptArchLog, long lNumAbonado, int iCodServicio, int iNivel, sql_context ctxCont );
access int ifnAbonadosSituacionTemporal(FILE **ptArchLog,long lCodCliente, sql_context ctxCont );
access BOOL bfnGetActAbodeAccion(FILE **ptArchLog, char *szCodRutina, char *szCodTiPlan, int iCodProducto, char *szActuacionOut, sql_context ctxCont );
access int ifnGetActuacionCentralCelularAcc(FILE **ptArchLog, char *szActAbo, int iCodProducto, char *szCodModulo, char *szCodTecnologia, sql_context ctxCont );
access BOOL bfnBorrarCoParamAcc(FILE **ptArchLog, long lNumSecuencia, sql_context ctxCont );
access BOOL bfnGetCodSuspReha(FILE **ptArchLog, int iCodActuacion, char *szCodAccion, int iCodProducto, char *szCodModulo, char *szCodSuspReha, sql_context ctxCont );
access BOOL bfnGetCodCausaSusp(FILE **ptArchLog, char *szCodSuspReha, char *szCausaSuspension, sql_context ctxCont );
access int ifnValidaOtrasSuspensiones(FILE **ptArchLog, long lNumAbonado, int iNivelSusp, char *szCodSuspReha, char *szCodTecnologia, sql_context ctxCont );
access int ifnSuspende( FILE **ptArchLog, long lAbonado,  char *szCodSituacionAbo, long lNumCelular, int iPlexsys, int iCentral, char *szNumSerieHex,  int iNumMin, char *szCauSusp, int iCodActCen, char *szTipTerm, 
				 char *szCodSuspReha, char *szCodActAbo, char *szCodTecnologia, char *szNumSerie, char *szNumImei, char *szNumImsi, int iFlagCentral, char *szCodTiPlan, char *szCodPlanTarif,
				 char *szCod_Enrut, sql_context ctxCont );
access int ifnGeneraCargo(FILE **ptArchLog, long lCliente, long lAbonado, int iProducto, char* szCodActabo, sql_context ctxCont);
access BOOL bfnSimulaReposicionCentral(FILE **ptArchLog, long lNumAbonado, char *szCodRepos, char *szCodModulo, sql_context ctxCont );
access BOOL bfnBorraIccPenalizacion(FILE **ptArchLog, long lNumAbonado, char *szCodRepos, char *szCodModulo, sql_context ctxCont );
access BOOL bfnGenInteresesBaja(FILE **ptArchLog, long lCodCliente, sql_context ctxCont );
access BOOL bfnCalculaIntereses(FILE **ptArchLog, long lCodCliente, long lNumSecuenci, int iCodTipDocum, long lCodVendedorAgente, char *szLetra  , int  iCodCentremi, int iSecCuota, sql_context ctxCont );
access BOOL bfnSelectDescripcionMensaje(FILE **ptArchLog, char *szCodMensaje, char *szCodIdioma, char *szpDescMensaje, sql_context ctxCont  );
access BOOL bfnSelectIdiomaCliente(FILE **ptArchLog, long lCodCliente, char *szCodIdioma, sql_context ctxCont );
access char *szfnRecuperaOperadora(FILE **ptArchLog, sql_context ctxCont);
access BOOL bfnAutenticacion(FILE **ptArchLog, long lNumAbonado, long lNumCelular, int iCodProducto, char *szNumSerie, char *szIndProc, GENSERVICIO *stServicios, char *szCadenaServOut, sql_context ctxCont );
access int	ifnVerifServicioActivo(FILE **ptArchLog, long lNumAbonado, char *szCodServicio, sql_context ctxCont );
access BOOL bfnUpdateServicioSupl(FILE **ptArchLog, long lNumAbonado, int iCodEstado, int iCodNivel, GENSERVICIO *stServicios, sql_context ctxCont );
access BOOL bfnExtraerCadenaClaseServicio(FILE **ptArchLog, long lNumAbonado, int iCodServicio, int iNivel, sql_context ctxCont );
access BOOL bfnInsertaServSupl(FILE **ptArchLog, long lNumAbonado, long lNumCelular, GENSERVICIO *stServicios, int iCodProducto, int iCodEstado, int iCodNivel, sql_context ctxCont );
access BOOL bfnConcatenaClaseServicio(FILE **ptArchLog, long lNumAbonado, int iCodServicio, int iNivel, sql_context ctxCont );
access int ifnAplicarAutenticacion(FILE **ptArchLog, sql_context ctxCont);
access int ifnObtieneUsoVenta(FILE **ptArchLog, int iCodUso, char *szCodTecnologia, sql_context ctxCont );
access BOOL bfnEjecutaPLInterfasesAbonados(FILE **ptArchLog, long lNumAbonado, int iCodProducto, char *szAccion, sql_context ctxCont );
access BOOL bfnEjecutaPLAlInterfazClub(FILE **ptArchLog, long lNumAbonado, char *szCodCausaBaja, char *szAccion, sql_context ctxCont );
access int ifnGetSaldoVencidoAcc(FILE **ptArchLog, long lCodCliente, double *pdSaldoVenc, sql_context ctxCont );
access int ifnSysDateYYYYMMDD( char *pszFecha, sql_context pctxCTX );
access BOOL ifnValidaCambioPlanTarifario(FILE **ptArchLog, long lCodCliente, long lNumAbonado, char *szCodPlanTarifario, sql_context ctxCont );

int ifnTrazaHilos (char* szExeNameApp, FILE **fArch, char* szTxt, int iNivel,...);

#endif /* _COLIBACCIONES_H_ */
