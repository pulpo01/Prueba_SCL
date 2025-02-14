#ifndef _ImpSclA_
#define _ImpSclA_

/*  Version  FAC_DES_MAS ImpSclA.h  6.000   */
#include <ImpSclFnc.h>
#include <shared_memory.h>
#define DEF_VAL_CONVERSION  1.0

extern int  Put_A1000                  ( FILE *Fd_ArchImp, ST_FACTCLIE *,ST_CICLOFACT *, char *, long );
extern int  Put_A1010                  ( FILE *Fd_ArchImp, ST_FACTCLIE *, char *, long);
extern int  Put_A1100                  ( FILE *Fd_ArchImp, ST_FACTCLIE *, STSALDO_ANTERIOR *, ST_CUOTAS *, char *, 
                                         ST_BALANCE *);
extern int  Put_A1120                  ( FILE *Fd_ArchImp, ST_FACTCLIE *FactDocuClie, ST_CICLOFACT *sthFa_CicloFact, 
                                         char *zsBufferImpresionArchivo, long);
extern int  Put_A1130                  ( FILE *Fd_ArchImp, ST_FACTCLIE *FactDocuClie, char *zsBufferImpresionArchivo);
extern int  Put_A1150                  ( FILE *Fd_ArchImp, ST_FACTCLIE *FactDocuClie, char *zsBufferImpresionArchivo, 
                                         long) ;
/*extern int Put_A1200(FILE *Fd_ArchImp, ST_FACTCLIE *, STSALDO_ANTERIOR *, ST_CUOTAS *, char *, ST_BALANCE *);*/ /* P-MIX-09003 77*/
extern int  Put_A1200                  ( FILE *Fd_ArchImp, ST_FACTCLIE *, STSALDO_ANTERIOR *, ST_CUOTAS *, char *, 
                                         ST_BALANCE *, TIPOSIMPUESTOS *, long lCodCiclFact);
extern int  Put_A1250                  ( FILE *Fd_ArchImp, ST_CUOTAS *pstFaCuotas, char *zsBufferImpresionArchivo);
extern int  Put_A1300                  ( FILE *Fd_ArchImp, ST_FACTCLIE *, char *,  long lCodigoCicloFacturacion);
extern int  Put_A1400                  ( FILE *Fd_ArchImp, ST_FACTCLIE *, char *);
extern int  Put_A1500                  ( FILE *Fd_ArchImp, ST_FACTCLIE *, char *,  long lCodigoCicloFacturacion);
extern int  Put_A1700                  ( FILE *Fd_ArchImp, long , ST_CICLOFACT *, char *);
extern int  Put_A1710                  ( FILE *Fd_ArchImp, ST_FACTCLIE *FactDocuClie, char *zsBufferImpresionArchivo, 
                                         long lCodCicloFact);
extern int  Put_A1800                  ( FILE *Fd_ArchImp, ST_TABLA_ACUM *, STSALDO_ANTERIOR *, ST_CUOTAS *, char *, 
                                         double dFact_Conversion);
extern int  Put_A1900                  ( FILE *Fd_ArchImp, ST_TABLA_ACUM *sthTablaAcum, STSALDO_ANTERIOR *SaldoTot, 
                                         ST_CUOTAS *pstFaCuotas,  char *zsBufferImpresionArchivo, 
                                         DETALLEOPER *pst_MascaraOper,double dFact_Conversion, int iCodTipDocum, 
                                         int iCodCiclo);
extern int  Put_A2000                  ( FILE *Fd_ArchImp, ST_MENSAJES *, char *);
extern int  Put_A2100                  ( FILE *Fd_ArchImp, ST_TABLA_ACUM , char *, double dFact_Conversion);
extern int  Put_A2200                  ( FILE *Fd_ArchImp, STSALDO_ANTERIOR *SaldoTot, ST_CUOTAS *pstFaCuotas, 
                                         char *zsBufferImpresionArchivo, double dFact_Conversion);
extern int  Put_A2400                  ( FILE *Fd_ArchImp, ST_FACTCLIE *, STSALDO_ANTERIOR *, ST_CUOTAS *, char *, 
                                         ST_BALANCE *);
extern int  Put_A2500                  ( FILE *Fd_ArchImp, ST_FACTCLIE *FactDocuClie, int iFlagMascaraA2600,
                                         int iFlagMascaraA2700, char *zsBufferImpresionArchivo);
extern int  Put_A2600                  ( FILE *Fd_ArchImp, ST_FACTCLIE *FactDocuClie, long lNumVenta,int iCodConcepto,
                                         long lNumAbonado, char *pszDesConcepto, long lColumna,
                                         char *zsBufferImpresionArchivo);
extern int  Put_A2700                  ( FILE *Fd_ArchImp, int iCodConcepto, int iColumna, 
                                         char *zsBufferImpresionArchivo);
extern int  Put_A2800                  ( FILE *Fd_ArchImp, ST_FACTCLIE *FactDocuClie, long lCodCiclFact, 
                                         char *zsBufferImpresionArchivo);
extern int  PutCaratula                ( ST_FACTCLIE *,FILE *,ST_MENSAJES *,ST_MENSAJES_NOCICLO *,STSALDO_ANTERIOR *,
                                         ST_CUOTAS *, ST_CICLOFACT *,  DETALLEOPER *,char *, ST_BALANCE *, 
                                         TIPOSIMPUESTOS *, long);
extern int  iGetMensajesCliente        ( long , char *, ST_MENSAJES * , int *, int , char * );
extern int  iUpdateFactDocu            ( long , ST_FACTCLIE *, STSALDO_ANTERIOR *, ST_CUOTAS *, ST_BALANCE * ,
                                         ST_ACUMMTO *);
                                         /* RPL 07-04-2020 SE CAMBIA FUNCION */
/* extern int  iUpdateFactDocu_MC         ( long lCodCiclFact, ST_FACTCLIE *FactDocuClie, STSALDO_ANTERIOR *SaldoTot, 
                                         ST_CUOTAS *pstFaCuotas, ST_BALANCE *stBalance ,char * szArchivoFinal,int sema,
                                         int indicador); */
extern int  iUpdateFactDocu_MC         ( long lCodCiclFact, ST_FACTCLIE *FactDocuClie, STSALDO_ANTERIOR *SaldoTot, 
                                         ST_CUOTAS *pstFaCuotas, ST_BALANCE *stBalance ,char * szArchivoFinal,
                                         int indicador);                                                                                 
extern int  UnloadMensajes             ( char * , char * , int  , LINEACOMANDO * );
extern int  GetDireccion               ( ST_FACTCLIE *);
extern int  SaldoAntConcepto           ( STSALDO_ANTERIOR  * , long , ST_CICLOFACT *);
extern int  iCargarDatosUltimoPago     ( long , char *, char *, char *);
extern int  iCargaFechaSuspension      ( long lCodCliente, char *sFVencim, char *sFecSuspen);
extern BOOL bfnCargaCodImptoFact       ( CODIMPTOSFACT *);
extern BOOL bfnCargaCodImptoFact_MC    ( CODIMPTOSFACT *);
extern BOOL bfnCargaCodImptoCateg      ( CATIMPUESTOS *);
extern BOOL bfnCargaCodImptoCateg_MC   ( CATIMPUESTOS *);

int ifnCmpTipDocum                     ( const void *cad1,const void *cad2);
int ifnOpenTipDocums                   ( void);
int ifnCloseTipDocums                  ( void);
int ifnCmpOficinas2                    ( const void *cad1,const void *cad2);
int ifnOpenOficinas2                   ( void);
int ifnCloseOficinas2                  ( void);
int ifnCmpVendedores                   ( const void *cad1,const void *cad2);
int ifnOpenVendedores                  ( void);
int ifnCloseVendedores                 ( void);
int ifnCmpOperadoras                   ( const void *cad1,const void *cad2);
int ifnOpenOperadoras                  ( void);
int ifnCloseOperadoras                 ( void);
BOOL bfnCargaTipDocum                  ( TIPDOC **pstTipDoc, int *iNumTipDocum);
BOOL bfnFetchTipDocums                 ( TIPDOC_HOSTS *pstHost, int *piNumFilas);
BOOL bfnFindTipDocum                   ( int iCodTipDocum, TIPDOC *pstTipDoc );
BOOL bfnCargaOficinas2                 ( OFICINA2 **pstOficinas2, int *iNumOficinas);
BOOL bfnFetchOficinas2                 ( OFICINA_HOSTS2 *pstHost, int *piNumFilas);
BOOL bfnFindOficina2                   ( char *szCodOficina, OFICINA2 *pstOficina );
BOOL bfnFindCodCliente                 ( long lCodigoCliente, CODCLI *pstCodClie, long lCodCiclFact, char *szFecEmision);
BOOL bfnCargaVendedores                ( VENDEDOR **pstVendedor, int *iNumVendedores);
BOOL bfnFetchVendedores                ( VENDEDOR_HOSTS *pstHost, int *piNumFilas);
BOOL bfnFindVendedores                 ( long lCodigoVendedor, VENDEDOR *pstCodVende, long lCodCiclFact);
BOOL bfnFindOperadora                  ( char *szCodOper, OPERADORA *pstOper );
BOOL bfnCargaOperadora                 ( OPERADORA **pstOper, int *iNumOperadoras);
BOOL bfnFetchOperadoras                ( OPERADORA_HOSTS *pstHost, int *piNumFilas);
void vfnPrintTipDocums                 ( TIPDOC *pstTipDoc, int iNumTipDocs);
void vfnPrintOficinas2                 ( OFICINA2 *pstOficina, int iNumOficinas);
void vfnPrintVendedores                ( VENDEDOR *pstCodVend, int iNumVendedores);
void vfnPrintOperadoras                ( OPERADORA *pstOper, int iNumOper);

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

