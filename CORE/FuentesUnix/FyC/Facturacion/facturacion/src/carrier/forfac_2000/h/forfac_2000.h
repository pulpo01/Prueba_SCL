/* forfac_new.h */

#ifndef _FORFAC_H_
    #define _FORFAC_H_

    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>
    #include <unistd.h>
    #include <memory.h>
    #include <malloc.h>
    #include <stdarg.h>
    #include <GenFA.h>
    #include <predefs.h>

    #define INUMTICKETS  12
    #define DETALLE     100
#endif

#undef access

#ifdef _FORFACC_C_
    #define access
#else
    #define access extern
#endif

#define PROG_VERSION    "4.00"

#define SQLOK		0
#define PATH	 	512
#define PROC_OK		3
#define PROC_ERR	2
#define PROC_EJ		1

#define ESTADO_DEV	"DEV"
#define ESTADO_FAC	"FAC"
#define ESTADO_ASG	"ASG"
#define ESTADO_REP	"REP"

#define MODO_NORMAL	"NORMAL"
#define MODO_REPRO	"REPROCESO"

typedef	struct REG_ARGUMENTOS	/* Registro para argumentos externos */
{
	int	bFlagUser;
	int	bFlagIndOrden;
	int	bFlagReproceso;
	char	szUsername[30];
	char	szPassword[30];
	int	iIndOrden;
}rg_argumentos;

typedef	struct REG_ACUM_FORLIQ
{
	long	lCodCliente;
	long	lNumAbonado;
	int		iIndAlquiler;
	int		iCodPeriodo;
	int		iCodOperador;
	double	dAcumNetoLLam;
	double	dAcumIva;
	int		iSegTasados;
}rg_acum_forliq;

struct FORADI
{
    char   szROWID          [19];
    char   szIND_ORDEN      [13];
    char   szNUM_TERMINAL   [11];
    char   szNUM_DESTINO    [11];
    double dIMP_NETO            ;
    double dIMP_IVA             ;
    double dIMP_APAGAR          ;
    char   szFEC_MOVIM       [9]; /* [7] */
    char   szDES_MOVIM      [31];
    long   lCOD_MOVIM           ;
    char   szIND_REFACTURA   [2];
    short  sTIP_REG             ;
    short  sIND_ALQUILER        ;
    long   lCOD_PERIODO         ;
    long   lNUM_ABONADO         ;
    long   lCOD_CLIENTE         ;
    short  ishNUM_ABONADO       ;
    short  ishCOD_CLIENTE       ;
} access stForAdi;

struct FORTAS
{
    char   szROWID           [19];
    char   szIND_ORDEN       [13];
    char   szCOD_PERIODO      [9];
    char   szNUM_TERMINAL    [11];
    char   szFEC_CALL         [9]; /* [7] */
    char   szHORA_CALL        [7];
    char   szTIP_REG          [2];
    char   szIND_ALQUILER     [2];
    char   szIND_SALIDA      [11];
    char   szIND_ENTRADA     [21];
    char   szDES_ENTRADA     [21];
    char   szMOD_CALL         [2];
    char   szCLAVE_CALL       [3];
    long   lMINUTOS_TASADO       ;
    long   lDUR_CALL             ;
    char   szCOD_SERVICIO     [2];
    double dACUM_NETOLLAM        ;
    double dACUM_IVA             ;
    double dTOT_PAGAR            ;
    char   szCOD_TRAFICO      [3];
    char   szIND_REFACTURA    [2];
    char   szCOD_LOTE         [7];
    char   szNUM_ABONADO      [9];
    char   szCOD_CLIENTE      [9];
    short  ishIND_SALIDA         ;
    short  ishIND_ENTRADA        ;
    short  ishDES_ENTRADA        ;
    short  ishMOD_CALL           ;
    short  ishCLAVE_CALL         ;
    short  ishMINUTOS_TASADO     ;
    short  ishDUR_CALL           ;
    short  ishCOD_SERVICIO       ;
    short  ishACUM_NETOLLAM      ;
    short  ishACUM_IVA           ;
    short  ishTOT_PAGAR          ;
    short  ishCOD_TRAFICO        ;
    short  ishIND_REFACTURA      ;
    short  ishLOTE               ;
    short  ishCOD_ERROR          ;
    short  ishNUM_ABONADO        ;
    short  ishCOD_CLIENTE        ;
} access stForTas;


/*********Estructura para detalle de anomalos******** CH-200503232763*/ 

struct ANOMALOS
{
    char   szROWID           [19];
    char   szIND_ORDEN       [13];
    char   szCOD_PERIODO      [9];
    char   szNUM_TERMINAL    [11];
    char   szFEC_CALL         [9]; /* [7]*/ 
    char   szHORA_CALL        [7];
    char   szTIP_REG          [2];
    char   szIND_ALQUILER     [2];
    char   szIND_SALIDA      [11];
    char   szIND_ENTRADA     [21];
    char   szDES_ENTRADA     [21];
    char   szMOD_CALL         [2];
    char   szCLAVE_CALL       [3];
    long   lMINUTOS_TASADO       ;
    long   lDUR_CALL             ;
    char   szCOD_SERVICIO     [2];
    double dACUM_NETOLLAM        ;
    double dACUM_IVA             ;
    double dTOT_PAGAR            ;
    char   szCOD_TRAFICO      [3];
    char   szIND_REFACTURA    [2];
    char   szCOD_LOTE         [7];
    char   szNUM_ABONADO      [9];
    char   szCOD_CLIENTE      [9];
    short  ishIND_SALIDA         ;
    short  ishIND_ENTRADA        ;
    short  ishDES_ENTRADA        ;
    short  ishMOD_CALL           ;
    short  ishCLAVE_CALL         ;
    short  ishMINUTOS_TASADO     ;
    short  ishDUR_CALL           ;
    short  ishCOD_SERVICIO       ;
    short  ishACUM_NETOLLAM      ;
    short  ishACUM_IVA           ;
    short  ishTOT_PAGAR          ;
    short  ishCOD_TRAFICO        ;
    short  ishIND_REFACTURA      ;
    short  ishLOTE               ;
    short  ishCOD_ERROR          ;
    short  ishNUM_ABONADO        ;
    short  ishCOD_CLIENTE        ;
} access stAnomalos;

struct HISTCLIE
{
    char szNOM_CLIENTE  [51];
    char szNOM_CALLE    [51];
    char szDES_CIUDAD   [31];
    char szNUM_IDENTTRIB[21];
    long lNumCelular        ;
} access *pstHistClie;

typedef struct tagREPORTE
{
    long  lLlam ;
    float  fNeto   ;
}REPORTE;

access REPORTE *Reporte;

access char szFecEnv[9];    /* [7] */
access char szFecEmi[9];    /* [7] */
access char szFecVen[9];    /* [7] */
access char szFecRangod[9]; /* [7] */
access char szFecRangoh[9]; /* [7] */

access char szCli[6]; 

access FILE *pFFac;
access FILE *pFRep;

access double dTotNet;
access double dTotIva;
access double dTotTot;
access double dTotCliTot;

access int  Reproflag = FALSE;	
access int  iEmpresa;
access int  iCOD_CICLO;
access int  iIND_ORDEN;
access int  iCOD_CICLFACT; /* Ciclo de Facturacion para Baja y Ciclo */

access long lTotReg;
access long lTotSeg;
access long lTotMin;
access long lClientes;  /* cuantos clientes se han procesado de este tipo */
access long lSeq;

access char szAst[]="********************************************************************";
access char szTime  [26] = "";    /* YYYYMMDD_HHMMSS [15]*/
access char szArchivo[128]="";
access char szArchDatos[32]="";
access char szModoProc[16]="";

#define FAC 1
#define DEV 2
#define ASG 3

access STATUS stStatus;

access void vfnClienteForAdi();
access void vfnClienteForTas();
access void vfnResetCounters();
/* Declaracion de funcion de escritura de Anomalos*/
access void vfnClienteAnm();

access void vfnCabeceraEmp();
access void vfnCabeceraCli();
access char *cfnGetTime();
access void vfnReporteFinal();
access BOOL bfnOraUpdateEstadoTraza();
access BOOL bfnOraUpdateTraza();
access BOOL bfnOraValidaTraza();
access BOOL bfnOraLeeFechasTraza();
access void vFechaHora();
access char *pszEnviron(char *,char *);
access int  iMakeDir(char *);
access BOOL bfnOraSacaSec();
access BOOL bfnOraCargaBaja();
access BOOL bfnOraCargaCiclo();
access BOOL bfnOraCargaCiclo2(int opcion);
access BOOL	bfnOraInsertDetForLiq (int * iCantidad);
access BOOL	bfnOraInsertAcumForLiq ();
access BOOL	bfnOraCalcAcumForLiq ();
access BOOL	bfnOraDeleteDetFortas ();
access BOOL bfnOraCargaClieFact2();
access BOOL bfnOraCargaForTas2(int iAlquiler,int opcion);
access BOOL bfnOraCargaForAdi2(int iAlquiler,int opcion);
access BOOL bfnOraCargaDupTas2(int iAlquiler,int opcion);
/* Declaracion de Funcion nueva, llamadas no registradas por FORFAC_2000*/
access BOOL     bfnOraSelectAnomalos();

/* 20031229  Incidencia CH-241120031523   Declaraciones set de funciones nuevas clones */
access BOOL	bfnOraInsertDetForLiq2(int * iCantidad);
access BOOL	bfnOraInsertAcumForLiq2();
access BOOL	bfnOraCalcAcumForLiq2();

#undef access

#ifdef _FORFAC_PC_
    #define access
#else
    #define access extern
#endif

access BOOL bfnOraCargaForAdi();
access BOOL bfnOraCargaForTas();
access BOOL bfnOraCargaClieFact();

#undef _FORFAC_PC_
#undef _FORFACC_C_


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

