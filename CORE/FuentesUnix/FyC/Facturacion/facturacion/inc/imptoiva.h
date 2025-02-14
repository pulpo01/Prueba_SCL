/*****************************************************************************/
/*  Fichero    : imptoiva.h                                                  */
/*  Descripcion: Declaracion de tipos y prototipos de imptoiva.pc            */
/*  Fecha      : 20-Nov-96                                                   */
/*  Autor      : Javier Garcia Paredes                                       */
/*****************************************************************************/

#ifndef _IMPTOIVA_H_
#define _IMPTOIVA_H_
#include <predefs.h>
#include <ORAcarga.h>
#include <geora.h>

#define ZICXOFICLIE 2 /* ZONA IMPOSITIVA CICLO X DIREC. OFICINA CLIENTE */
#define PORCENTUAL 0 /* ZONA IMPOSITIVA CICLO X DIREC. OFICINA CLIENTE */

typedef struct tagImptos
{
  int        iNumImpuestos;
  IMPUESTOS* pImpuestos   ;
}IMPTOS                   ;

/********************************************************/
/* Estructura para acumular los totales por abonado		*/
/********************************************************/
typedef struct tagTAbon
{
  	long      lNumAbonado;
  	double	dTotFactur;
}TABON                  ;


typedef struct tagTotAbon
{
  int       iNumAbonados;
  TABON 	stAbon [NUM_ABONADOS_CLIENTE];
}TOTABON                   ;
/********************************************************/
/* Estructura para acumular los totales por impuesto 	*/
/********************************************************/
typedef struct tagTotImpto
{
	int		iCodImpto;
  	float   fPorcent;
  	double	dTotImpto;
  	double  dTotMBase;
  	int     iTipMonto;
}TOTIMPTO;
 
typedef struct tagTotImptos
{
  int       iNumTotImptos;
  TOTIMPTO*	stTotImptos;
}TOTIMPTOS;

/* P-CSR-12019 */
typedef struct tagDetImptosTipo 
{  long lNumAbonado;
   long lCodCliente;
   long lNumfolio;
   char sPrefPlaza[26];
   int  iCodTipImpues;
   double dAcumImpuestoOrig;
   double dAcumNetoOrigen;
   double dAcumNetoAfectoOrigen;
   double dAcumImpuestoNCred;
   double dAcumNetoNCred;
   double dAcumNetoAfectoNCred;
} DETIMPTOSTIPO;

typedef struct tagAcumDetImptosTipo 
{
   int          iNumRegs;
   DETIMPTOSTIPO*  stDetImptosTipo;
} ACUMDETIMPTOSTIPO;


typedef struct tagAcumImpto 
{  long lNumAbonado;
   int iCodConcepto;
   double dImpTotal;
} ACUMIMPUESTO;

typedef struct tagAcumImpuestoAbonados
{
   int          iNumAbonados;
   ACUMIMPUESTO*  stAcumImpto;
} ACUMIMPUESTOABONADOS;

typedef struct tabAcumAbonado
{ long lNumAbonado;
   double dImpTotal;
} ACUMABONADO;

typedef struct tagAcumAbonados
{  int          iNumAbonados;
   ACUMABONADO*  stAcumAbonado;
} ACUMABONADOS;
/* FIN P-CSR-12019 */
/********************************************************/


#undef access
#ifdef _IMPTOIVA_PC_
#define access 

/* Definiciones de constantes para validaciones de cargo en Impuesto al documento */
const int giCodZonaImpDir =  0;
const int giCodProvincia  =  1;
const int giCodRegion     =  2;
const int giCodCiudad     =  3;
const int giCodComuna     =  4;
                              
const int giEvalClieAbon  =  0;
const int giEvalCliente   =  1;
const int giEvalAbonado   =  2;
const int giNoEvaluar     =  3;

/*****************************************************************************/
/*                         Declaracion de Funciones Locales                  */
/*****************************************************************************/
	   BOOL bGetZonaImpositiva	(char*
								,char*
								,char*
								,int *	piCodZonaImpo
								,char* 	szFecZonaImpo
								,int )					;
static BOOL bAddZonaCiudad 		(ZONACIUDAD* )          ;
static BOOL bGetGrupoServicios 	(int 	iCodConcepto
								,int* 	piCodGrpServi
								,char 	*szFecGrp,int)	;
static BOOL bAddGrpSerConc 		(GRPSERCONC*)           ;
static BOOL bCalculaImptos 		(int iInd
								,IMPUESTOS *pImpuesto
                                , int iNumRegs)	;

	   BOOL bGetImpuestos 		(int 	iCodCatImpos
								,int 	iCodZonaImpo
								,int 	iCodZonaAbon
								,int 	iCodGrpServi
								,char 	*szFecVenc
								,IMPTOS* pImpto
								,int 	iTipFa)			;
       void vPrintImpuestos 	(IMPTOS*)               ;
       void vFreeImpuestos 		(IMPTOS*)               ;
static BOOL bGeneraCuotas 		(long 	lNumCargo
								,char 	*szCodCuota
								,float 	fPrcImpues
								,int 	iCodConcepto)	;
static BOOL bfnAcumTotImptos (	TOTIMPTOS *pstTotImptos ,
								int 	iCodConcBase	,
								int 	iCodConcepto	,
								double 	dImpMontoBase	,
                				double 	dImpConcepto	,
                				float	fPrcImpuesto,
								int 	iTipMonto	);
static BOOL bfnRegZonaAbon  (int NumRegIni);
                				
static BOOL bfnAjusteImptos 	( TOTIMPTOS *pstTotImptos);
	   BOOL bfnEvalZonasImpos 	( char *pszFecZonaImpo
	   							, int  piTipoFact
	   							, int  *iCodZonaImpo
	   							, int piIndZonaImpCic);
	   BOOL bfnGetDirOficina 	( char  *pszCodOficina
	   							, char *szCodRegion
	   							, char *szCodProvincia
	   							, char *szCodCiudad);
	   BOOL bfnGetDirAbonado 	( long  plNumAbonado
	   							, char *szCodRegion
	   							, char *szCodProvincia
	   							, char *szCodCiudad
	   							, char *szCodComuna
	   							, long *lCodUsuario
	   							, int *iCodZonaImpAbon);
	   BOOL bfnGetDirOfiVend    ( long lCodVendedor
	   							, char *szCodOficina );
BOOL bfnAplicaImpto (int iIdxOri, IMPUESTOS* pImpto,int iTipoFact);


/* Impuestos Maicao */
BOOL bfnProcImptoMaicao(int iTipoFact, char *pszFecZonaImp);
BOOL bfnValidarZonaDeCargo(IMPTODCTO pstImptoDcto, COD_IMPTODCTOS stCodZonas);
BOOL bfnGenerarImptoAlDcto(int iTipoFact, IMPTODCTO stImptoDcto, COD_IMPTODCTOS stCodZonas, double dSumConcNetos);
BOOL bfnCargarCodigosZona(COD_IMPTODCTOS *pstCodZonas, char *pszFecZonaImpo, long lNumAbonado, int iTipoFact);
double dfnSumarConceptosNetos(void);
int ifnBuscarSgteConceptoImpto(int iPosRegImptoDctos);
BOOL bfnValidarRebImptosDctos(IMPTODCTO stImptoDcto, char *pszFecZonaImp);
BOOL bfnValidarZonaDeCargo(IMPTODCTO stImptoDcto, COD_IMPTODCTOS stCodZonas);
BOOL bfnExisteConcRev(long lCodConcepto, long *plConceptos, int iNumConc);
BOOL bfnVerificarVigConc(IMPTODCTO stImptoDcto, char *pszFecZonaImp);

// Impuesto Docto
BOOL bCalculaMtoImptoDocto (int iInd,             // concepto sobre el que aplico Impto
                            IMPUESTOS pImpuesto,  // info. impuesto 
                            double *dMtoImpuesto, // monto acumulado de impuesto
                            double *dMtoBase);

/* GCASTRO - se agrega psnIndOrdenTotal  como parametro - 200069 - 24-10-2013 */
BOOL bEsNotaCreditoTotal (long plNumProceso,
                          long plNumFolio,
                          char *psPrefPlaza,
                          char *psnIndOrdenTotal,
                          int *iEsNotaTotal,
						  BOOL *bDocOrigenCiclo);


BOOL bfnAplicaImptoUmbralNotaCredParcial(int iIndxConcepto,
                                          double dpMontoImpto, char *cpCodMonedaImpto, 
                                         long lNumAbonado,
										 int iTipoFact,
										 ACUMIMPUESTOABONADOS *pAcumImptoAbonado,
										 ACUMABONADO *pAcumAbonado,
										  IMPUESTOS *pImpuesto, ACUMDETIMPTOSTIPO *pAcumImptoTipo);


BOOL bGetImpuestosAll (int iCodCatImpos, int  iCodZonaImpo, char *szFecVenc ,int iCodZonaAbon, int iCodGrpServi,
                         IMPTOS* pImpto  , int  iTipoFact);
BOOL bCalculaMtoImptoDoctoUmbral (int iInd,             // concepto sobre el que aplico Impto
                            double dpImpConcepto,
							char *cpCodMonedaImp,
                            IMPUESTOS pImpuesto,  // info. impuesto 
							long lNumAbonado,   //P-CSR-12019
							ACUMIMPUESTOABONADOS *pAcumImptoAbonado, /*P-CSR-12019*/
							ACUMABONADO *pAcumAbonado, /*P-CSR-12019*/
                            double *dMtoImpuesto, // monto acumulado de impuesto
                            double *dMtoBase,     // monto acumulado base
							double *dMtoFacturable) ;
BOOL bCalculaMtoImptoNotaCredUmbral (int iInd,             // concepto sobre el que aplico Impto
                            double dpImpConcepto,
							char *cpCodMonedaImp,
                            IMPUESTOS pImpuesto,  // info. impuesto 
							DETIMPTOSTIPO*  pAcumImptoTipo,
							long lNumAbonado,   //P-CSR-12019
                            double *dMtoImpuesto, // monto acumulado de impuesto
                            double *dMtoBase,     // monto acumulado base
							double *dMtoFacturable);
BOOL bfnAplicaImptoDocto2 (IMPUESTOS* pImpto, long iIdxOri, int iTipoFact, double pdMtoImpto, double pdMtoBase, double pdMtoFacturable);
							
BOOL bGetImpuestosDocto     (int   iCodCatImpos, 
                             int   iCodZonaImpo, 
                             char *szFecVenc ,
                             IMPTOS* pImpto  , 
                             int  iTipoFact);
void vFreeTotImpuestos (TOTIMPTOS*);

BOOL bfnAplicaImptoDocto (IMPUESTOS* pImpto, long iIdxOri,int iTipoFact
                         , double pdMtoImpto, double pdMtoBase);
BOOL bfnValidaImptoDocto(long lCondConcepto, double *dMtoImpuesto,  double *dMtoBase);

BOOL bImptosDoctoNotas (int iTipoFact);
BOOL bImptosDoctoUmbral (int iTipoFact, char *szFecZonaImpo, int iCodZonaImpos, ACUMABONADOS *pAcumAbonados);
BOOL bImptosDocto (int iTipoFact, char *szFecZonaImpo, int iCodZonaImpos);
BOOL bAcumulaImporteXAbonado(FAPFACTURA *pFactura, ACUMABONADOS *stAcumFactAbonado);
void vFreeAcumImpuestoAbonado (ACUMIMPUESTOABONADOS* pEstructura);
void vFreeAcumImpuestoTipos (ACUMDETIMPTOSTIPO* pAcumImptoTipo);
void vFreeAcumAbonado (ACUMABONADOS* pEstructura);
#else
#define access extern
access void vFreeAcumImpuestoTipos (ACUMDETIMPTOSTIPO* pAcumImptoTipo);
access BOOL bActualizAcumImptosNCredito (  ACUMDETIMPTOSTIPO *pAcumImptoTipo);
access BOOL bImptosNotasCredParcial (int iTipoFact,ACUMDETIMPTOSTIPO  *pAcumImptoTipo);
access BOOL bfnGetGedParam(char * pszNomParam, char *pszCodModulo, char *pszValParam);
/* GCASTRO - se agrega psnIndOrdenTotal como parametro - 200069 - 24-10-2013 */ 
access BOOL bEsNotaCreditoTotal (long plNumProceso, long plNumFolio, char *psPrefPlaza, char *psnIndOrdenTotal, int *iEsNotaTotal, BOOL *bDocOrigenCiclo);
access BOOL bImptosNotasTotal (int iTipoFact , BOOL bDocOrigenCiclo,  ACUMDETIMPTOSTIPO *pAcumImptoTipo );
access BOOL bCargaAcumImptosNCredito (long lpNumFolio, char *spPrefPlaza, ACUMDETIMPTOSTIPO *pAcumImptoTipo);
access BOOL bGetZonaImpositiva	(char*
								,char*
								,char*
								,int *	piCodZonaImpo
								,char* 	szFecZonaImpo
								,int )					;
access BOOL bfnEvalZonasImpos 	( char *pszFecZonaImpo
	   							, int  piTipoFact
	   							, int  *iCodZonaImpo
	   							, int piIndZonaImpCic);
access BOOL bfnGetDirOficina 	( char  *pszCodOficina
	   							, char *szCodRegion
	   							, char *szCodProvincia
	   							, char *szCodCiudad);
access BOOL bfnGetDirAbonado 	( long  plNumAbonado
	   							, char *szCodRegion
	   							, char *szCodProvincia
	   							, char *szCodCiudad
	   							, char *szCodComuna
	   							, long *lCodUsuario
	   							, int *iCodZonaImpAbon);
access BOOL bfnGetDirOfiVend    ( long lCodVendedor
	   							, char *szCodOficina );

access BOOL bGetImpuestos		(int 	iCodCatImpos
								,int 	iCodZonaImpo
								,int 	iCodZonaAbon
								,int 	iCodGrpServi
								,char 	*szFecVenc
								,IMPTOS* pImpto
								,int 	iTipFa)			;
								
#endif /* _IMPTOIVA_PC_ */
access BOOL bImptosIvaClienteGeneral (int iTipoFact);
access BOOL bImptosIvaNotas (int iTipoFact);
#endif /* _IMPTOIVA_H_  */


/******************************************************************************************/
/** Informaci� de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  %ARCHIVE% */
/** Identificador en PVCS                               : */
/**  %PID% */
/** Producto                                            : */
/**  %PP% */
/** Revisi�                                            : */
/**  %PR% */
/** Autor de la Revisi�                                : */
/**  %AUTHOR% */
/** Estado de la Revisi� ($TO_BE_DEFINED es Check-Out) : */
/**  %PS% */
/** Fecha de Creaci� de la Revisi�                    : */
/**  %DATE% */
/** Worksets ******************************************************************************/
/** %PIRW% */
/** Historia ******************************************************************************/
/** %PL% */
/******************************************************************************************/

