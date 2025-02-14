/* ============================================================================= */
/*
    Tipo        :  FUNCIONES ORACLE

    Nombre      :  CO_oracle.h

    Descripcion :  Header para CO_oracle.pc

    Autor       :  Roy Barrera Richards                 
    Fecha       :  09 - Agosto - 2000 

*/ 
/* ============================================================================= */

#ifndef _COORACLE_H_
#define _COORACLE_H_

#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <string.h>

#include <sqlca.h>
#include <sqlda.h>

/*----------------------------------------------------------------------------*/
/* Re-definicion LOCAL de sqlnotfound: Valor del modo Oracle */
#ifdef SQLNOTFOUND
#undef SQLNOTFOUND
#endif
#define SQLNOTFOUND 1403
/*#define SQLNOTFOUND 100 *//*Ansi*/
/*----------------------------------------------------------------------------*/

#define MAX_ITEMS      	100  /* Numero maximo de Elementos del Descriptor t    */
#define MAX_VNAME_LEN  	100
#define MAX_INAME_LEN  	100
#define MAX_BUFSIZE  	5001

#ifndef _BOOL_                  /* _BOOL_           */
#define _BOOL_
#define  FALSE  0
#define  TRUE   !FALSE 
typedef int BOOL;			/*	Tipo Booleano    */
/*typedef enum {FALSE,TRUE} BOOL;*/
#endif                          /* _BOOL_           */

typedef struct tagORACL {
	BOOL Connected;
} ORACLDB;

#undef access
#ifdef _COORACLE_PC_
static BOOL bfnOraActivaRoles(char *);
static char *strtoupper(char *);
static int decode(char *,char *);
#define access
#else
#define access extern
#endif  /* _COORACLE_PC_ */

access ORACLDB  OraDb;
access BOOL  bfnOraConnect( char *szUser, char *szPasw );
access BOOL  bfnOraDisconnect(int iOraErr);
access BOOL  bfnOraRollBackRelease(void);
access BOOL  bfnOraCommitRelease(void);
access BOOL  bfnOraRollBack(void);
access BOOL  bfnOraCommit(void);
access char  *szfnOraGetErrorMsg(void);
access BOOL  bfnOraSetSavepoint(char* szSP);
access BOOL  bfnOraRestoreSP(char *szSP);
access BOOL  bfnOraExecute(char *szStm);
access BOOL  bfnOraPrepareStm(char *szStm);
access BOOL  bfnOraDecCursorStm(void);
access BOOL  bfnOraOpenCursorStm(SQLDA *bind_dp);
access int   ifnOraFetchDesc(SQLDA* desc);
access BOOL  bfnOraCloseCursorStm(void);
access BOOL  bfnOraSetBindVars(SQLDA *bind_dp);
access BOOL  bfnOraDescSelect(SQLDA *select_dp);
access BOOL  bfnOraIniDescs(SQLDA**,SQLDA**);
access BOOL  bfnOraEndDescs(SQLDA *,SQLDA*);
access char* szfnOraGetFld(SQLDA* desc,int i);
access int   ifnOraGetNFlds(SQLDA* desc);
access BOOL  bfnOraAllocDesc(SQLDA** desc,int size,int max_vname_len,int max_iname_len);
access BOOL  bfnOraDeAllocDesc(SQLDA* desc);
#undef _COORACLE_H_
#endif /* _COORACLE_H_ */


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

