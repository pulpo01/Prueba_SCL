/* ============================================================================= */
/*
    Tipo        :  ACCION

    Nombre      :  AsigCobExt.h

    Descripcion :  Header de AsigCobExt.pc

    Autor       :  Roy Barrera Richards           
    Fecha       :  10 - Agosto - 2000 
*/ 
/* ============================================================================= */
#include <CO_deftypes.h>       /* Inclusion de tipos generales de cobranza       */
#include <CO_libgenerales.h> /* Agregado por PGonzalez 20-10-2004 MAS-04037 */
#include "CO_libacciones.h"  /* Agregado por PGonzalez 20-10-2004 MAS-04037 */
/* ============================================================================= */
#define szVersion "3.0.0"   /* Nueva version por TMG-TMS */

typedef struct TCOBEXTERNA
{
	char szNumIdent[iLENNUMIDENT];
	char szCodTipIdent[3];
	long lCodCliente;
	long lCodCuenta;
	char szCodEntidad[6];
	char szTipCobranza[2];
	char szCodMovimiento[6];
	char szFecMovimiento[15];
	double dMtoDeuda;
	double dMtoVencido;
	int iCntCliente;
	char szCodEnvio[2];
	char szRutSantiago[2];
} TDATOSCOB;	

BOOL bfnInsertaCobExterna(FILE **ptArchLog,  TDATOSCOB *stDatosCobros, char *szpEntGestCob, sql_context ctxCont );
BOOL bfnGetSaldoVencidoACEXT(FILE **ptArchLog, long lCodCliente, double *pdSaldoVenc, sql_context ctxCont );
int ifnTrazaHilos (char* szExeNameApp, FILE **fArch, char* szTxt, int iNivel,...);

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

