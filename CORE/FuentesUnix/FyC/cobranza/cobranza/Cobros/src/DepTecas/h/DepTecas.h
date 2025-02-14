/****************************************************************************
Fichero         : DepTecas.h
Modulo          : cobros
Fecha           : 02-10-2000
Programador     :
Descripcion     : Carga de archivo de deposito de entidades externas 

****************************************************************************/
#include <GenTypes.h>
#include <coerr.h>
#include <genco.h>

#define szVERSION	"1.00"

#define Tam_Reg 101

#define ABOCLI           0
#define PRODGEN          5

/******************************************************************************/
/* CONSTANTES */
/******************************************************************************/

/******************************************************************************/
/* ESTRUCTURAS */
/******************************************************************************/

typedef struct DATGEN
{
   FILE *pFile;
   FILE *pLog;
   char szPathLog[384];
   char szPathTec[384];
   char szUsuario[31];
   char szFecActual[9];
   char iCodCredito;
   int  iSisPago;
   int  iOriPago;
   int  iCauPago;
   int  iProdGener; 
   int  iProdGeneral; 
   int  iDocPago;
	long lCodRecExt;
	char szNomFich[81];
	char szValor[100];
} DATGEN;

typedef struct DATREG
{
   char szZona[2];		/* Zona en que se ingreso */            
   char szNivel[3];		/* Nivel que lo ingreso */              
   char szEmpCtc[2];		/* Empresa CTC */                       
   char szTipDoc[2];		/* Tipo de Documento */                 
   char szLocal[4];		/* Local */                             
   char szUsuario[4];		/* Usuario */                           
   char szRecaudad[4];		/* Recaudador */                        
   char szLote[4];		/* lote */                              
   char szFechaPag[8];		/* Fecha de Pago */                     
   char szFechaCob[8];		/* Fecha de Cobranza */                 
   char szBanco[3];		/* Banco */                             
   char szNoCuenta[12];		/* Número Cuenta del Dpto. */           
   char szNumBolet[12];		/* Número de Boleta */                  
   char szNumDocum[9];		/* Número del Documento */              
   char szMonto[14];		/* Monto del Dpto. */                   
   char szCuenta[9];		/* Cuenta Contable */                   
} DATREG;


typedef struct DATREGC
{
   char szZona[3];		/* Zona en que se ingreso */            
   char szNivel[4];		/* Nivel que lo ingreso */              
   char szEmpCtc[3];		/* Empresa CTC */                       
   char szTipDoc[3];		/* Tipo de Documento */                 
   char szLocal[5];		/* Local */                             
   char szUsuario[5];		/* Usuario */                           
   char szRecaudad[5];		/* Recaudador */                        
   char szLote[5];		/* lote */                              
   char szFechaPag[9];		/* Fecha de Pago */                     
   char szFechaCob[9];		/* Fecha de Cobranza */                 
   char szBanco[4];		/* Banco */                             
   char szNoCuenta[13];		/* Número Cuenta del Dpto. */           
   char szNumBolet[13];		/* Número de Boleta */                  
   char szNumDocum[10];		/* Número del Documento */              
   char szMonto[15];		/* Monto del Dpto. */                   
   char szCuenta[10];		/* Cuenta Contable */                   
} DATREGC;


typedef struct tagDATANOM
{
    int  iCodAnom;
    char szDesAnom[61];
    int  iIndGravedad;
}DATANOM;

typedef struct DATCONT
{
	long lContErr;
	long lContReg;
	double dImpPagado;
    long lContFallos;
} DATCONT;


typedef struct tagARRANOM
{
      DATANOM  *stDatAnom;
      int      iCont;
}ARRANOM;

void vfnLiberarAnom(ARRANOM *stArrAnom);

/* victor reveco  */
/* Fecha Actualizacion : 20-11-2000 */
BOOL  fnOraConnect( char *szUser, char *szPasw );
BOOL bfnDBInsDepAnomalia(char sCodigoErrorAnomalia[4]);
BOOL bfnDBCodBanco();
BOOL bfnDBNumCtaCte(); 
BOOL bfnDBInconsistencia(char sCodError[4]);
BOOL bfnDBObtDatGen(char *NomFich);
/* fin */

/* Marcelo Quiroz  */
/* Fecha Actualizacion : 30-12-2002 */
BOOL bfnDBObtDatGen(char *NomFich);
int  ibfnGetNextVal();
int  ifnExitInstance(void);
BOOL bfnInsCabAnomalias();
int ifnLeerFich(DATANOM *stDatAnom,ARRANOM *stArrAnom);
int ifnGetAnom(DATANOM *stDatAnom,ARRANOM *stArrAnom);
int ifnConnectORA( char *szusr, char *szpsw );
/* fin */



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

