/*----------------------------------------------------------------------------*/
/* Fichero geora.h							      */
/*----------------------------------------------------------------------------*/

#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <string.h>
/* #include <stdarg.h> */
/* #include <varargs.h> */
#include <stdlib.h>
#include <sys/times.h>
#include <sys/time.h>
#include <time.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <sys/fcntl.h>
#include <utmp.h>
#include <errno.h>

#ifndef _GEORA_H_
#define _GEORA_H_

#include <sqlca.h>
#include <sqlda.h>

#define NOTFOUND 	   1403
#define MAX_ITEMS      100  /* Numero maximo de Elementos del Descriptor t    */
#define MAX_VNAME_LEN  100
#define MAX_INAME_LEN  100

#define szNUM_DECIMAL			"NUM_DECIMAL"           /* Numero de Decimales a considerar */
#define szSEP_MILES_MONTOS		"SEP_MILES_MONTOS"      /* Caracter separados de miles */
#define szSEP_DECIMALES_MONTOS	"SEP_DECIMALES_MONTOS"  /* Caracter separador de decimales */
#define szSEP_DECIMALES_ORACLE	"SEP_DECIMALES_ORACLE"  /* Caracter separador de decimales */
#define szNUM_DECIMAL_FACT		"NUM_DECIMAL_FACT"      /* Numero de Decimales a considerar */
#define szCOD_TIP_FOLIACION		"TIPO FOLIACION"     	/* Tipo de foliacion */
#define szCOD_PAR_TRAFICO_0		"3"     				/* Parametro de inclusión de los conceptos importe 0*/
#define szIND_ZOMAIMPOCIC		"IND_ZONAIMPOCIC"     	/* Determina si la zona impositiva es por cliente */
#define szMTO_MIN_AJUSTE		"4"     				/* Monto minimo para ajuste */
#define szZONA_IMPO_DEFECTO		"5"     				/* Zona impositiva por defecto */
#define  szDOCUMENTO_CERO	"DOCUMENTOS_CERO" /* Indica como serán tratados los documentos en cero */

#define USO0					0
#define USOFACT					1


#ifndef _BOOL_
#define _BOOL_
typedef enum {FALSE,TRUE} BOOL;
#endif

typedef struct tagORACLE {
  BOOL Connected;
} ORADB;

typedef struct TagGenParam
{
	int  iNumDecimal		;
	char szSepMilesMonto[2] ;
	char szSepDecMontos	[2]	;
	char szSepDecOracle	[2]	;
	int  iNumDecimalFact	;
	int	 iTipoFoliacion		;
	char szCodIdioma  	[6]	;
	int  iConsConcTrafico	;
	int  iIndZonaImpCic		;
	int  iMtoMinAjuste		;
	int  iZonaImpoDefec		;
	
/* 2005/04/25 Indra
	Modificacion proyecto P-COL-05001-SCL (Colombia) para documentos en 0 (cero):
   Se agrega campo tipo char sDocumentoCero de largo 1 para obetener el campo de la tabla
   GED_PARAMETROS Val_Documento; en este campo viene 'S' o 'N' para los casos en que se desea
   que el documento en cero sea facturado en forma normal o no.*/
      	char sDocumentoCero;	/* acepta 'S' o 'N'*/
}GENPARAM;


#undef access
#ifndef __GEORA__
#define access extern
#else 
static BOOL fnOraActivaRoles(char *);
static char *strtoupper(char *);
static int decode(char *,char *);
#define access 
#endif /* __GEORA__ */

access ORADB  	Ora;
access GENPARAM pstParamGener;
access BOOL 	fnOraConnect		( char *szUser, char *szPasw );
access BOOL 	fnOraDisconnect		(int iOraErr);
access BOOL 	fnOraRollBackRelease(void);
access BOOL 	fnOraCommitRelease	(void);
access BOOL 	fnOraRollBack		(void);
access BOOL 	fnOraCommit			(void);
access char 	*fnOraGetErrorMsg	(void);
access BOOL 	fnOraSetSavepoint	(char* szSP);
access BOOL 	fnOraRestoreSP		(char *szSP);
access BOOL 	fnOraExecute		(char *szStm);
access BOOL 	fnOraPrepareStm		(char *szStm);
access BOOL 	fnOraDecCursorStm	(void);
access BOOL 	fnOraOpenCursorStm	(SQLDA *bind_dp);
access int  	fnOraFetchDesc		(SQLDA* desc);
access BOOL 	fnOraCloseCursorStm	(void);
access BOOL 	fnOraSetBindVars	(SQLDA *bind_dp);
/* access BOOL 	fnOraDescSelect		(SQLDA *select_dp); */
access BOOL 	fnOraIniDescs		(SQLDA**,SQLDA**);
access BOOL 	fnOraAllocDesc		(SQLDA** ,int ,int ,int );
access BOOL 	fnOraEndDescs		(SQLDA *,SQLDA*);
access BOOL 	fnOraDeAllocDesc	(SQLDA* desc);
access char* 	fnOraGetFld			(SQLDA* desc,int i);
access int   	fnOraGetNFlds		(SQLDA* desc);
access int  	bGetParamDecimales 	(void);
access double 	fnCnvDouble			(double d,int uso);

#undef access

#endif /* _GEORA_H_ */
