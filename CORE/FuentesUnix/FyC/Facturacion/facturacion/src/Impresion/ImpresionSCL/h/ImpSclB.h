#ifndef _ImpSclB_
#define _ImpSclB_

/*  Version  FAC_DES_MAS ImpSclB.h  6.000   */
/*#include <ImpSclSt.h>*/
#include <ImpSclFnc.h>
#include <shared_memory.h>

extern int  CargaAbonadosdelCliente   ( ST_FACTCLIE * ,ST_ABONADO * ,LINEACOMANDO *  );
extern int  CargaConceptosDelCliente  ( ST_FACTCLIE    *, LINEACOMANDO   *, ST_INFGENERAL  *, DETALLEOPER    *);
extern int  CargaFolioCtc             ( ST_FACTCLIE * , ST_CUOTAS * ,  STSALDO_ANTERIOR *);
extern int  CloseConceptos            ( void);
extern int  CloseConceptosDescuento   ( void);  /*RPL 19-05-2020 PROYECTO CSR */
extern int  FetchConceptos            ( ST_DETCONSUMO_HOST *pstConcTrafico, long *plNumFilas);
extern int  FetchConceptosDescuentos  ( ST_CONCDESC_HOST *pstConcDescuentos, long *plNumFilasDesc); /*RPL 19-05-2020 PROYECTO CSR */
extern int  GetCiclFact               ( ST_CICLOFACT * ,long );
extern int  GetCuotas                 ( ST_CUOTAS * pstFaCuotas,long lCicloFact,long lCodCliente, char *szFec_Vencimi);/*RA-134*/
extern int  GetNumProcesoCiclo        ( LINEACOMANDO *);
extern int  hay_b2000_b3000           ( FILE *,int ,int ,int, int,int *,int *,char *);
extern int  InsertHeaderInfCtl        ( ST_CICLOFACT *,LINEACOMANDO *);
extern int  OpenConceptos             ( long ,long ,char *, int ,DETALLEOPER *, int);
extern int  OpenConceptosDescuentos   ( long ,long ,char *, int ,DETALLEOPER *, int );       /*RPL 19-05-2020 PROYECTO CSR */                                                                                                                           
extern int  put_b1000                 ( ST_ABONADO *,FILE *,int , int , long,char *);
extern int  put_b1200                 ( FILE *Fd_ArchImp,int iRegConcep, ST_FACTCLIE *pst_Cliente, char * buffer);
extern int  put_b2000_b3000           ( FILE *,int ,int , int *,int *,char *);
extern int  put_b4001                 ( FILE *,PLAN_TARIFARIO *,int,char *);
extern int  put_b4002                 ( FILE *,int,char * );
extern int  put_b4003                 ( FILE *,int,char * );
extern int  put_b4004                 ( FILE *,int,char * );
extern int  put_b4005                 ( FILE *,int,char * );
extern int  put_b4006                 ( FILE *,STSALDO_ANTERIOR *,int,char *  );
extern int  put_b4007                 ( FILE *,rg_cuotas *,int ,int , int, long, char * );
extern int  put_b4008                 ( FILE *,int,char * );
extern int  put_b5000                 ( FILE *,int ,char *);
extern int  PutDetConsu               ( ST_ABONADO *, FILE *, ST_CUOTAS *, STSALDO_ANTERIOR *,
                                        ST_FACTCLIE *, char *, DETALLEOPER *,PLAN_TARIFARIO *,
                                        int,long lCodCiclFact, BOOL Flag_ExisCarrier ); /* P-MIX-09003 */                                                                                                                                                                                                                                                                                                                                                                                                                                            
extern int  Update_CuotaCredito       ( ST_FACTCLIE * ,ST_CUOTAS *);
extern BOOL bfnTrataFactTrafico       ( ST_ABONADO *pst_Abonados,ST_FACTCLIE *pst_Cliente,FILE *fArchImp, 
                                        int iCont, char *szBuffer,DETALLEOPER *pstMascaraOper,
                                        int iTasador,long, BOOL Flag_ExisCarrier); /* P-MIX-09003 */
extern int  CargaCodigoServicio       ( ST_FACTCLIE *pstFactDocuClie,
                                        ST_INFGENERAL * pstInfGeneral,
                                        char * pstCodServicio);
extern BOOL bfnBuscaCategImpto        ( int iCodConcepto, int *iCodCategoria, double dPrcImpto);
extern int  put_b1300                 ( FILE *Fd_ArchImp,int iRegConcep,char * buffer);
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

