#ifndef _ImpSclD_
#define _ImpSclD_


/*  Version  FAC_DES_MAS ImpSclD.h  6.000   */
/*#include <ImpSclSt.h>*/
#include <ImpSclFnc.h>
#include <shared_memory.h>

/* Funciones de Manejo de strings    */
extern int      _strlen                         ( char *);
extern char     *_ltrim                         ( char *);
extern char     *_rtrim                         ( char *) ;

extern int      bfnCloseDetCelular              ( int iTasador );
extern int      ifnOraLeerTolTarifica           ( DETLLAMADAS_HOSTS  * pstLlamadasHost, int * piNumFilas);
extern int      ifnOraLeerLlamCarrier           ( DETLLAMADAS_HOSTS  * pstLlamadasHost, long * piNumFilas);
extern int      ifnOraDeclaraTraficoTolTarifica ( long lCodCliente, long lNumAbonado, long lCodCiclFact);
extern int      ifnOraDeclaraLlamCarrier        ( long lCodCliente, long lNumAbonado, long lCodCiclFact);
extern int      ifnFetchDetCarrier              ( DETCARRIER * stDetCarrier );
extern int      ifnFetchDetCelular              ( DETLLAMADAS_HOSTS  *pstLlamadasHost, int * piNumFilas,int iTasador);
extern int      ifnFetchDetRoaming              ( DETROAMING *stDetRoaming, int iTasador);
extern int      put_D1000                       ( ST_ABONADO *,FILE *, int, char *);
extern int      ifnOpenDetCarrier               ( long lCodCliente, long lNumAbonado,long lNumProceso);
extern int      ifnOpenDetCelular               ( long lCodCliente, long lNumAbonado,int  iTipLlam, 
                                                  int  iTasador, DETALLEOPER *st_Mascara); /* P-MIX-09003 */
extern int      ifnOpenDetRoaming               ( long lCodCliente, long lNumAbonado,long lNumProceso,
                                                  int,long lCodCiclFact);
extern int      ManejoArchImp                   ( LINEACOMANDO *, ST_INFGENERAL *, DETALLEOPER *, FILE **, ST_ACUMMTO *, char *);

extern BOOL     bfnCargaLlamadas                ( long  lCodCliente, long lNumAbonado);
extern BOOL     bfnFetchTAS                     ( DETLLAMADAS_HOSTS  *pstLlamadasHost, int * piNumFilas);
extern BOOL     bfnDeclaraTAS                   ( long  lCodCliente, long lNumAbonado, char *szWhere);
extern BOOL     bCargaConceptosTar              ( CONCEPTOS_TAR *stConceptosTar);
extern BOOL     bCargaMascaraOperadora          ( DETALLEOPER *pst_MascaraOper ,int);
extern BOOL     bEscribeBuffer                  ( char *szBuffer,char *szRegistro,int iTipoLlamada,FILE *);
extern BOOL     bfnCloseDetRoaming              ( int iTasador );
extern BOOL     bfnDetLlamCarrier               ( ST_ABONADO *pst_Abonados,ST_FACTCLIE *pst_Cliente, int iIndice, 
                                                  int iTipoLlamada, FILE *fArchImp, char *szBuffer, 
                                                  int *, long lCodCiclFact, char *szhCodRegistro);
extern BOOL     bfnDetLlamCelularTOL            ( ST_ABONADO *pst_Abonados,ST_FACTCLIE *pst_Cliente,int iIndice, FILE *fArchImp, 
                                                  char *szBuffer, int *bImprimioD1000, 
                                                  DETALLEOPER *pst_MascaraOper, long lCodCiclFact);
extern BOOL     PF_TARIFICADAS                  ( char *szBuffer,char *szRegistro,int iTipoLlamada,FILE *fArchImp);   
extern BOOL     bfnTrataFactTrafico             ( ST_ABONADO *pst_Abonados,ST_FACTCLIE *pst_Cliente,
                                                  FILE *fArchImp, int iCont, char *szBuffer,DETALLEOPER *pstMascaraOper,
                                                  int iTasador,long lCodCiclFact,BOOL Flag_ExisCarrier); /* P-MIX-09003*/
extern BOOL     bObtieneMascara                 ( ST_ABONADO *pst_Abonados, CONCEPTOS_TAR *stConceptosTar,
                                                  DETALLEOPER    *pst_MascaraOper);
extern BOOL     ifnFindOperadores               ( OPERADORES *pbstOper);                                               
extern BOOL     bfnDetLlamCelular               ( ST_ABONADO *pst_Abonados, ST_FACTCLIE *pst_Cliente, 
                                                  int iIndice, int iTipoLlamada, FILE *fArchImp, 
                                                  char *szBuffer, DETALLEOPER *pstMascara, 
                                                  int *bImprimioD1000, int iTasador, 
                                                  long lCodCiclFact, char *szCodRegistro);
extern BOOL     bfnDetLlamRoaming               ( ST_ABONADO *, ST_FACTCLIE *, int , int , FILE *, 
                                                  char *, int *, int, long, char *);
extern BOOL     bfnDeterminaGrupo               ( int iCodCargoHost,  DETCELULAR * pstDetCelular, long *lPosicion, 
                                                  NUMORDEN *pstNumOrden) ;                                                  
extern long     lfnDaSegundos                   ( char []);

/* P-MIX-09003 */ /*extern BOOL     bfnDetLlamCelular_old           ( ST_ABONADO *pst_Abonados, 
                                                  ST_FACTCLIE *pst_Cliente, 
                                                  int iIndice, 
                                                  int iTipoLlamada, 
                                                  FILE *fArchImp, 
                                                  char *szBuffer, 
                                                  DETALLEOPER *pstMascara, 
                                                  int *bImprimioD1000, 
                                                  int iTasador); */ 
/* P-MIX-09003 */ /*extern BOOL     bfnDetLlamRoaming               ( ST_ABONADO *pst_Abonados, 
                                                  ST_FACTCLIE *pst_Cliente, 
                                                  int iIndice, 
                                                  int iTipoLlamada, 
                                                  FILE *fArchImp, 
                                                  char *szBuffer, 
                                                  int *bImprimioD1000, 
                                                  int iTasador,
                                                  long lCodCiclFact);*/ 

char            *szfnBuscaDescPortadora         ( int iCodOperador);
char            *szfnBuscaTipoTraficoLD         ( char *s);
int             ifnOraCerrarTraficoTolTarifica  ();
int             ifnOraCerrarTraficoLlamCarrier  ();
int             bfnCloseDetCarrier();
int             iNumOperadores_Imp  ;
int             ifnCompareszSec_Empa            ( const void* cad1, const void* cad2);
int             ifnCompareszSec_Cdr             ( const void* cad1, const void* cad2);
int             ifnCompareszTieIniLlam          ( const void* cad1, const void* cad2);
int             ifnCompareszNumMovil1           ( const void* cad1, const void* cad2);
int             ifnCompareszNumMovil2           ( const void* cad1, const void* cad2);
int             ifnComparedImpLocal1            ( const void* cad1, const void* cad2);
int             ifnComparedImpLarga2            ( const void* cad1, const void* cad2);
int             ifnCompareszCodFranHoraSoc      ( const void* cad1, const void* cad2);
int             ifnCompareszCodAlm              ( const void* cad1, const void* cad2);
int             ifnCompareszDesMovil2           ( const void* cad1, const void* cad2);
int             ifnCompareszDurLocal1           ( const void* cad1, const void* cad2);
int             ifnCompareszDurLarga2           ( const void* cad1, const void* cad2);
int             ifnCompareszIndEntSal1          ( const void* cad1, const void* cad2);
int             ifnComparedMto_Real             ( const void* cad1, const void* cad2);
int             ifnComparedMto_Dcto             ( const void* cad1, const void* cad2);
int             ifnCompareiDur_Real             ( const void* cad1, const void* cad2);
int             ifnCompareiDur_Dcto             ( const void* cad1, const void* cad2);
int             ifnCompareiCod_Carg             ( const void* cad1, const void* cad2);
int             ifnCompareDefault               ( const void* cad1, const void* cad2);
int             ifnCompareGrupoSubGrupo         ( const void* cad1, const void* cad2);
void            vFreeEstructuras                ( DETCELULAR * pstDetCelular);
void            vFreeEstructurasTAS             ( DETCELULAR_AGRUP * pstDetLlamadasTAS);
BOOL            bfnImprimeEstruc                ( DETCELULAR * pstDetCelular);
BOOL            bfnOrdenaEstructuras            ( DETCELULAR * pstDetCelular);
BOOL            bfnObtieneTotalporTipoTrafico   ( long lCodCliente,long lNumAbonado,long lCodCiclFact,
                                                  int iCodOperCarr,char *szCodTrafico,long *lSegundosTotal,
                                                  double *dNetoTotal);

#endif

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


