/* *********************************************************************** */
/* *  Fichero : fortas.h                                                 * */
/* *  Proceso de "Trafico Internacional"                                 * */
/* *  Autor : Marcos Martinez Garcia                                     * */
/* *  Ultimas modificaciones : Roy Barrera R.  10-Nov-1999               * */
/* *********************************************************************** */

#ifndef _FORTAS_H_
    #define _FORTAS_H_

    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>
    #include <unistd.h>
    #include <memory.h>
    #include <malloc.h>
    #include <stdarg.h>

	#include <strings.h>
	#include <fcntl.h>
	#include <math.h>
	#include <time.h>

    #include "GenFA.h"
    #include "predefs.h"

    #include "imptoiva.h"
    #include "ORAcarga.h"


    #define INUMTICKETS 12
    #define LONGITUD /*151*/   157
    #define LONCAB   /*151*/   157
    #define POSERROR 153  /* posicion error en archivo de salida */ /* Falta cambiarlo :Revisar  RA-679 DE 141 A 153*/

	#define SQLOK 0         /* Termino OK */
	#undef  SQLNOTFOUND
	#define SQLNOTFOUND 1403 /* no encontro el dato  (modo Ansi = 100 ; modo SQL = 1403) */
	#define SQLDUPLIC -1     /* la clave primaria esta duplicada */
	#define TIPDIRECCION_PARTICULAR 2
#endif

#undef access

#ifdef _FORTASC_C_
    #define access
#else
    #define access extern
#endif

typedef struct tagPERIODOS
{
    long  lCodPeriodo ;
    int   iCantidad   ;
	long  lMinutos ;
	float fNeto    ;
	float fIva     ;
	float fTotal   ;

}PERIODOS;

typedef struct tagCICLOS
{
    int   iCodCiclo          ;
    int   iCodCicloFact      ;
    int   indFacturacion     ;
    char  szFecDesde     [15];
    char  szFecHasta     [15];
    char  szFecEmision   [15];
}CICLOS;

typedef struct tagCabecera
{
    char szCOD_OPERADOR     [6];
    char szIND_ORDEN       [13];
    char szNUM_REGISTRO    [12];
    char szACUM_NETOLLAM   [17];
    char szACUM_IVA        [17];
    char szACUM_TOTAL      [17];
    char szACUM_SEGUNDO    [14];
    char szACUM_MINUTOS    [14];
    char szFEC_ENVIO       [15];
    char szFEC_DESDE       [15];
    char szFEC_HASTA       [15];
    char szREG_TOTALIZADOR  [3];
    char szTIP_REG          [2];
}CABECERA;

typedef struct tagDetalle
{
    char szCOD_OPERADOR    [6];
    char szIND_ORDEN      [13];
    char szCOD_PERIODO     [9];
    char szNUM_TERMINAL   [11];
    char szFEC_CALL       [15]; /* char szFEC_CALL  [7]  YYYYMMDD */
    char szHORA_CALL       [7];
    char szTIP_REG         [2];
    char szIND_ALQUILER    [2];
    char szIND_SALIDA     [11];
    char szIND_ENTRADA    [21];
    char szDES_ENTRADA    [21];
    char szMOD_CALL        [2];
    char szCLAVE_CALL      [3];
    char szMINUTOS_TASADO  [6];
    char szDUR_CALL       [10];
    char szCOD_SERVICIO    [3];
    char szACUM_NETOLLAM  [13];
    char szACUM_IVA       [13];
    char szTOT_PAGAR      [13];
    char szCOD_TRAFICO     [3];
    char szIND_REFACTURA   [2];
    char szLOTE            [7];
    char szCOD_ERROR       [3];
    char szNUM_ABONADO     [9];
    char szCOD_CLIENTE     [9];
    char iIND_ALQUILER        ;
/* OPTMC-00188 (IVA) */
	int  iCodCatImpos		  ;
	int  iCodZonaImpo		  ;
	int  iGrpServicio		  ;
	float fPrcImpuesto		  ;
	double fAcumImptoCalc	  ;
/* OPTMC-00188 (IVA) */
}DETALLE;

/* 20050425: Estrctura acumuladora de valores neto, IVA y Total */
typedef struct tagAcumuladores
{
    double dAcumNeto;
    double dAcumIVA;
    double dAcumTotal;
}ACUMULADORES;

access CABECERA         stCabecera;
access DETALLE          stDetalle ;
access ACUMULADORES     stAcum;

access BOOL bExitApp;
access BOOL bFinFichero;
access BOOL bErrorFichero;

access char *InLlams;
access char szRegSal[LONGITUD + 1];
access char szRegCab[LONCAB   + 1];
access char szFichero[255];
access char szfec[9]; /* YYYYMMDD [7] */
access char szfecproceso[9];  /* YYYYMMDD [7] */
access char szclistar[9];
access char szAst[]="******************************************************************************";
access char szArchivo [128] = "";
access char szTime  [26] = "";
access char szModoProc[16]="";

access CICLOS *Ciclos;
access PERIODOS *Periodos;


access double dtotiva99;
access double dtotnet99;
access double dtottot99;

access FILE *pFRec;
access FILE *pFEnt;
access FILE *pFRep;


access 	int Reproflag=FALSE;
access 	int Insertflag=FALSE;

access int nCiclos;
access long iErrores[10];
access int iAux;            /* guardara el máximo de ciclos donde hay llamadas de este ind_orden */
access long lTotalAceptadas;
access long lTotalRechazos;


access long iNumProcesados=0;
access long iNumFallos=0;
access long iNumBuenos=0;
access long iNumLlamadasOk=0;
access long iNumLlamadasNOk=0;
access long ltotmin99;
access long ltotseg99;
access long ltotmal99;
access long lCodCiclFact;



/*access long lIndOrden;*/
access int  iTotalAceptadas;
access int  iTotalRechazos;


access BOOL bfnLeeLlamadas();
access BOOL bfnCopiaLlamadas(int iCont);
access BOOL bfnCopiaCabecera();
access BOOL bfnProccesaRegistro();
access char* cfnGetTime();
access void vfnCabeceraEmp();
access BOOL bfnGeneraReporte();
access BOOL bfnGetDirAbonadoZonaImpo(long , char *, char *, char *);
access BOOL bfnGetGrpServi  ( int iCodOperador ,char *szFecLlam, int *iCodGrpServ);
#undef access

#ifdef _FORTAS_PC_
    #define access
#else
    #define access extern
#endif

access BOOL bfnOraSacaIndOrden();
access BOOL bfnOraInsertaCabecera();
access BOOL bfnOraInsertaLlamada();
access BOOL bfnOraInsertaConsumos();
access BOOL bfnOraInsertaLlamadaDup();
access BOOL bfnOraSacaFec();
access BOOL bfnOraCargaCiclos();
/*access BOOL bfnOraSacaIntarcel();*/
access BOOL bfnOraSacaAbocel();/*RA-769*/
access int  ifnDBUpdateAcumFortas (DETALLE, int);
access BOOL bfnDBInsertAcumFortas (DETALLE, int);
access BOOL bfnOraSacaAceptados();
access BOOL bfnOraSacaRechazados();
access BOOL bfnOraSacaTotales();
access BOOL bfnOraInsertTraza();
access BOOL bfnOraUpdateTraza();
access BOOL bfnOraInsertTrazaDet();
access BOOL bfnOraValidaTraza();
access BOOL bfnLeeCabecera();
access BOOL bfnOraVerificaCabecera();
access BOOL bfnProccessRecordLlamadas();
access int ifnLeeLlamadas();
/*access BOOL bfnOraSacaIntarRent();*/
access BOOL bfnOraSacaAboamist();/*RA-679*/
access void vRestaFechas(char *,char *,int *);
access BOOL bfnOraSacaIntarRoaVis();
access BOOL bfnOraActualizaCabecera(void);
access BOOL bfnOraInsertaSubFortas(void);

#undef _FORTASC_C_
#undef _FORTAS_PC_

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


