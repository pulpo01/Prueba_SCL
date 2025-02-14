/* ============================================================================= 
 Tipo          :  FUNCIONES GENERALES 
 Nombre        :  CO_libgenerales.h
 Descripcion   :  Header para CO_libgenerales.pc
 Creada 14-10-2004 por Proyecto P-MAS-04037 Mejoras Ejecutor y Excluidor
 Version 4.0.0 
 ============================================================================= */
#ifndef _COLIBGENERALES_H_
#define _COLIBGENERALES_H_

#ifdef _COLIBGENERALES_PC_
#endif /* _COLIBGENERALES_PC_ */

#undef access
#ifdef _COLIBGENERALES_PC_
#define access 
#else
#define access extern
#endif /* _COLIBGENERALES_PC_ */

/* --------------------------------------------------------------------------------------------- */
/* Define las Variables Globales 																					 */
/* --------------------------------------------------------------------------------------------- */
int  iFec_Saldo;
access GENPARAM 	pstParamGener;
access long  		iNumSeqGlobal;   /*HM-200505160045 18-05-2005 Soporte RyC PRM. Homologación de incidencia CH-200412272562  03-01-2005 Soporte RyC PRM*/
access int  		iAboCeluGlobal;
access int  		iAboBeepGlobal;
access int  		iMRAboCeluGlobal;
access int  		iMRAboBeepGlobal;
access BOOL 		bGeneraCargos;
access BOOL 		gbExclusionTotal;
access char       szParamExclu[16];

/* --------------------------------------------------------------------------------------------- */
/* Prototipos de funciones        																					 */
/* --------------------------------------------------------------------------------------------- */
char *szGetTime(int fmto);
char *szDate(int iNDias,char *szFmto);
char *szSysDate (char *szFmto);
int ifnTrazasLog (char* szExeNameApp, char* szTxt, int iNivel,...);
void rtrim( char *szCadena );
BOOL bfnActualizaCoGestionCliente( long lCodCliente  , long lCodCuenta, char *szNumIdent , char *szCodTipIdent,char *szCodEntidad, char *pszRutina, char *pszCodMovimiento );
BOOL bfnActualizaCoGestionRut( char *szNumIdent, char *szCodTipIdent, char *szCodMov, char *szCodEntidad, long lSecProceso );
BOOL bfnGetSaldoCliente (long lCliente, double *pdSaldoVenc, double *pdSaldoNoVenc, char *szFecVencimiento  );
BOOL bfnGetSaldoPorRut( char *szNumIdent, char *szCodTipIdent,double *dMtoSaldoRut );
BOOL bfnGetSaldoVencido( long lCodCliente, double *pdSaldoVenc );
double fnCnvDouble( double d, int uso );
int ifnGetActuacionCentralCelular( char *szActAbo, int iCodProducto, char *szCodModulo, char *szCodTecnologia );
char *szfnRecuperaGedParametro( char *szNomParametro, char *szCodModulo );				 

#endif /* _COLIBGENERALES_H_ */
