/*******************************************************************************
Fichero:      FaORA.h
Descripcion:  Declaracion de tipos y prototipos de FaORA.pc

Fecha:          
Autor:   Facturacion Boy's    
*******************************************************************************/

#ifndef _FAORA_H_
#define _FAORA_H_

#include <deftypes.h>

#undef access

#define SQLOK          0
#define ORA_NULL      -1
#define SQLNOTFOUND 1403
#define SQLCODE     sqlca.sqlcode
#define SQLERRM     sqlca.sqlerrm.sqlerrmc
#define SQLROWS     sqlca.sqlerrd[2]

/* ----- Datos Fa_Procesos ----- */

typedef struct tagFaProcesos {
    long  lNumProceso          ;
    int   iCodTipDocum         ;
    long  lCodVendedorAgente   ;
    int   iCodCentrEmi         ;
    char  szFecEfectividad [15];
    char  szNomUsuarOra    [31];
    char  szLetraAg         [2];
    long  lNumSecuAg           ;
    int   iCodTipDocNot        ;
    long  lCodVendedorAgenteNot;
    char  szLetraNot        [2];
    int   iCodCentrNot         ;
    long  lNumSecuNot          ;
    short iIndEstado           ;
    int   iIndNotaCredC        ;
    long  lCodCiclFact         ;
    char  szCodOficina      [3];
} PROCESO                      ;

#ifndef _FAORA_PC_
#define access extern
#else 
#define access 
#endif /* _FAORA_PC_  */

access char szExeName [3072];
access char szSysDate [15]  ;

access PROCESO stProceso    ;

/****************************************/
/* Incorporado por PGonzaleg 20-05-2002 */
/*	-Eliminacion de Warnings-       */
/*		Desde aqui		*/
/****************************************/

access BOOL   fnOraConnect( char *, char *);
access BOOL   fnOraDisconnect(int );
access BOOL   fnOraRollBackRelease(void);
access BOOL   fnOraCommitRelease(void)  ;
access BOOL   fnOraRollBack(void);
access BOOL   fnOraCommit(void)  ;
access BOOL   sqlglm(char*,int*,int*);
/****************************************/
/* Incorporado por PGonzaleg 20-05-2002 */
/*	-Eliminacion de Warnings-       */
/*		Hasta aqui		*/
/****************************************/

access BOOL   bfnConnectORA(char*,char*) ;
access BOOL   fnOraActivaRoles (char*)   ;
access BOOL   bfnDisconnectORA(int)      ;
access BOOL   bfnOraRollBackRelease(void);
access BOOL   bfnOraCommitRelease(void)  ;

access BOOL   bfnOraRollBack(void);
access BOOL   bfnOraCommit(void)  ;
access char*  szfnORAerror(void)  ;
access char*  strtoupper (char* ) ;
#endif /* _FAORA_H_ */


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

