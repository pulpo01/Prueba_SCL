/****************************************************************************/
/* Fichero    : compos.h                                                    */
/* Descripcio : funciones para el paso a Historicos de los datos facturados */
/* Autor      : Javier Garcia Paredes                                       */
/* Fecha      : 09-05-1997                                                  */
/****************************************************************************/

#ifndef _COMPOSICION_H_
#define _COMPOSICION_H_

#include <FaORA.h>
#include <GenFA.h>
#include <ORAcarga.h>
#include <stdlib.h>
#include <PlanVcto.h>
#include <geora.h>
#include <imptoiva.h>

/* En una Nota Debito la FecVecimiento = FecEmision + iDIAS_VENCIMIENTO */
#define iDIAS_VENCIMIENTO     15

#define szCODCATRIBUT_AFECTO  "A"
#define szCODCATRIBUT_EXENTO  "E"

#define iCODCATRIBUT_EXENTO   0
#define iCODCATRIBUT_AFECTO   1

#define MAXFETCH              2000
#define ERR62		      62
#define STR_LONG              256
#define STR_HUGE              8192

#define  FALSE                0
#define  TRUE                 !FALSE

#define NOTECNO               "NOTECNO"

#undef access
#ifdef _COMPOSICION_PC_
#define ACCESS


typedef struct reg_acumulador
{
	long 	lAbonado;
	long	lCod_ConCobr;
	double	dMonto;
	struct	reg_acumulador 	* sgte;
}reg_acumulador;

typedef struct reg_acumulador stAcumulador;
stAcumulador * lstAcumulador = NULL;

typedef struct reg_prctecno
{
        char    szCodTecno       [8];
        char    szCodOficinaPpal [3]; 
        double  dImpFacturable      ; 
        int     iCantTecno          ;
        double  dPrcTecno           ;
        double  dPrcMonto           ; 
        struct  reg_prctecno * sgte ;
}reg_prctecno;

typedef struct reg_prctecno stPrcTecno; 
stPrcTecno * lstTecno = NULL;

static BOOL bfnPasoHistDocu             ( int );
static BOOL bfnPasoHistClie             ( );
static BOOL bfnPasoHistAbo              ( );
static BOOL bfnPasoHistConc             ( );
static BOOL bfnDBUpdateVenta            ( HISTDOCU * );
static BOOL bfnGetTotDocu               ( HISTDOCU * );
static BOOL bfnValCatImpDocu            ( long, BOOL*, BOOL* );
static BOOL bfnGetSaldoAnt              ( long,double * );
static BOOL bfnFindActividad            ( int,char *,int );
static BOOL bfnGetTotCargosMeAbo        ( HISTABO  * );
static BOOL bfnGetLimCredito            ( int,int,double *,int );
static BOOL bfnInsertHistAbo            ( HISTABOP *,int Produc );
static BOOL bfnInsertHistDocu           ( HISTDOCU * );
static BOOL bfnInsertHistClie           ( void );
static BOOL bfnAddHistAboCero 	        ( void );
static BOOL bfnCargosNivCliente         ( int *ipIndiceAbon );
static BOOL bfnEsPrePago                ( long, int * );
static BOOL bfnGetCodZonaAbon           ( long ,int * );
BOOL   bfnFindDatosAuditoria            ( HISTDOCU *, char *, char *, char *);
BOOL   bfnCargaValUnit                  ( void );
static void vfnInitCadenaInsertHistConc ( char *,char * );
static void vfnInitCadenaInsertHistDocu ( char *,char * );
static void vfnInitCadenaInsertHistClie ( char *,char * );
static void vfnInitCadenaInsertHistAbo  ( char *,char * );
static void vfnComposicionNumCTC        ( char * );
static void vfnPrintHistDocu            ( HISTDOCU *,char *szTable , int iCodTipDocum);
static void vfnPrintHistAbo             ( HISTABO *,int,BOOL );
static void vfnPrintHistClie            ( HISTCLIE *,char *szTable );
void   vfnFreeHistAbo                   ( void );

extern BOOL  bfnEncriptaContTec         ( char *, char *, long, char *, char *, 
                                          double, double, char *, char *, char *, char * );

#else
#define access extern
access BOOL bfnPasoHistoricos (void);
access void vfnFreeHistAbo    (void);

#endif
#endif
