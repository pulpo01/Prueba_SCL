/*******************************************************************************

Fichero:      precar.h
Descripcion:  Declaracion de tipos y prototipos de precar.pc 

Fecha:        20-07-2007                                                  
Autor:        Jaime Espinoza Matamala                                     

*******************************************************************************/

#ifndef _PRECAR_H_
#define _PRECAR_H_

#include <GenFA.h>
#include <geora.h>

#define TAM_HOST       30000

/******************************************************************************/
/* Estructura para paso de parametros de rutinas de prorrateo                 */
/******************************************************************************/
typedef struct tagPasoProrrateo
{
char 	szFecInicio	[15];
char 	szFecTermino	[15];
double	dImpServicio;
short   sIndTipoCobro;
double	dImpConcepto;
short   sDiasAbono;
short	sIndAlta;
short 	sIndProrrateo;
}PASOPRORRATEO;


typedef struct tagCargoRecurrente_HOST
{
	char   szRowid         [TAM_HOST][19];
  	long   lhCodCliente    [TAM_HOST]    ;
    long   lhNumAbonado    [TAM_HOST]    ;
    long   lhCodProducto   [TAM_HOST]    ;
    long   lhCodCargoCont  [TAM_HOST]    ;
    char   szhCodTipServ   [TAM_HOST][4] ;
    char   szhCodServicio  [TAM_HOST][6] ;
    char   szhCodPlanServ  [TAM_HOST][6] ;
    short  shIndCargoPro   [TAM_HOST]    ;
    int    ihCodConcepto   [TAM_HOST]    ;
    char   szhFecAlta      [TAM_HOST][15];
    char   szhFecBaja      [TAM_HOST][15];
    char   szhIndBloqueo   [TAM_HOST][6] ;
    char   szhEstBloqueo   [TAM_HOST][6] ;
}CARGORECURRENTE_HOST;

typedef struct tagCargoRecurrente_HOST_NULL
{
	short  i_shCodTipServ  [TAM_HOST];
    short  i_shCodServicio [TAM_HOST];
    short  i_shCodPlanServ [TAM_HOST];
    short  i_shFecBaja     [TAM_HOST];
    short  i_shIndBloqueo  [TAM_HOST];
    short  i_shEstBloqueo  [TAM_HOST];
}CARGORECURRENTE_HOST_NULL;

#undef access
#ifdef _PRECAR_PC_
#define access 

static int  iOpenCargosRec (long lhCodCliente)                      ;
int  iFetchCargosRec(CARGORECURRENTE_HOST *pstHost, CARGORECURRENTE_HOST_NULL *pstHostNull, long *plNumFilas);
static int  iCloseCargosRec(void)                      ;


       BOOL bfnFindMontoCargo             (long lCodCargoCont, double *dhImpCargo);
static BOOL bfnObtieneCantDiasAProrratear (int , int *, int *);

static BOOL bfnProrrateoStandar(PASOPRORRATEO *);
static BOOL bUpdateCargosRecurrentes (char *szRowid);

#else
#define access extern
access BOOL bEMCargosRecurrentes (void);
#endif /*_PRECAR_PC_*/
#endif /*_PRECAR_H*/





/******************************************************************************************/
/** Informaci］ de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  %ARCHIVE% */
/** Identificador en PVCS                               : */
/**  %PID% */
/** Producto                                            : */
/**  %PP% */
/** Revisi］                                            : */
/**  %PR% */
/** Autor de la Revisi］                                : */
/**  %AUTHOR% */
/** Estado de la Revisi］ ($TO_BE_DEFINED es Check-Out) : */
/**  %PS% */
/** Fecha de Creaci］ de la Revisi］                    : */
/**  %DATE% */
/** Worksets ******************************************************************************/
/** %PIRW% */
/** Historia ******************************************************************************/
/** %PL% */
/******************************************************************************************/

