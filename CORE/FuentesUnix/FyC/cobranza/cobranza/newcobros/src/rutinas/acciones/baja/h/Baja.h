/* ============================================================================= 
    Tipo        :  ACCION
    Nombre      :  Baja.h
    Descripcion :  Header de Baja.pc
    Autor       :  Roy Barrera Richards           
    Fecha       :  10 - Agosto - 2000 
    Modificado  :  Proyecto MPR_04008 - Flexibilidad de Enrutamiento - GAC.
    Fecha       :  06-08-2004
 ============================================================================= */
#include <CO_deftypes.h>       /* Inclusion de tipos generales de cobranza       */
#include <CO_libgenerales.h> /* Agregado por PGonzalez 20-10-2004 MAS-04037 */
#include "CO_libacciones.h"  /* Agregado por PGonzalez 20-10-2004 MAS-04037 */
/* ============================================================================= */

#define		INDEMESCAL			"E"
#define		INDEMESTAN			"S"
#define     COMODATO			"1"
#define     NOCOMODATO			"0"
#define     CAUSABAJA			"90"
#define     ACTUACIONBAJAPLS	"BA"
#define     ACTUACIONBAJAPOST	"BF" 
#define     ACTUACIONBAJAPREP	"BP"
#define     ACCIONBAJA        	"BAJA"                                                                  
#define     BAJAENPROCESO     	"BAP"                       /*CH-200408232102  Homologado por PGonzalez 22-11-2004 */
#define     BAJAABONADO       	"BAA"                       /*CH-200408232102  Homologado por PGonzalez 22-11-2004 */
#define     CAUSABAJA_CO      	"'90','43','44'"            /*CH-200408232102  Homologado por PGonzalez 22-11-2004 */
#define     szCODRUTINA	      	"BAJA"

#define     szVersion			"3.0.0"	/* Nueva version por TMG-TMS */


BOOL bfnTipoIndemnizacion(FILE **ptArchLog, char *szTipoIndem, char *szFecProrroga, char *szFecAlta, char *szFecIndemEscal , sql_context ctxCont);
BOOL bAplicarIndemEscalonada(FILE **ptArchLog, long lCodCliente, long lNumAbonado, int iCodProducto, int iNumMeses, int iDiffMeses , sql_context ctxCont);
BOOL bfnAplicarIndemEstandar(FILE **ptArchLog, long lCodCliente, long lNumAbonado, int iCodProducto, long lCodCuenta, char *szNumContrato, char *szNumAnexo, int iDifFecFinContSys, int iComodato, sql_context ctxCont);
BOOL bfnBorraDtosTarif(FILE **ptArchLog, long lNumAbonado, long iCodCiclo , sql_context ctxCont);
BOOL bfnDesactivarServSuplAbo(FILE **ptArchLog, long lNumAbonado, sql_context ctxCont);
BOOL bfnActualizaAbonadoGarantia(FILE **ptArchLog, long lCodCliente, sql_context ctxCont );
int ifnVerificaExisteFyF(FILE **ptArchLog, long lCodCliente, long lNumAbonado, long lNumCelular, sql_context ctxCont);
char *szGetCadenaServNivel(FILE **ptArchLog, long lNumAbonado, char *szCadena, sql_context ctxCont );
char *szGetCadenaServNivelAbo(FILE **ptArchLog, long lNumAbonado, char *szCadena, sql_context ctxCont);
BOOL bfnDesactivarServSuplFriendsAbo(FILE **ptArchLog, long lCodCliente, long lNumAbonado, long lNumCelular, int iCodCentral,char *szNumSerie, char *szTipTerminal, int iProducto, char *szNumMin, sql_context ctxCont);
BOOL bfnCancelaGarantiaPago(FILE **ptArchLog, long lCodCliente, sql_context ctxCont);
BOOL bfnEjecutaPLCoBajasAbo(FILE **ptArchLog, long lNumAbonado, char *szAccion, sql_context ctxCont);
BOOL bfnHibernacionEquipo(FILE **ptArchLog, long lNumEquipo, int iCodCentral, int iCodUso, sql_context ctxCont);
BOOL bfnObtServSuplAboAct(FILE **ptArchLog, long lNumAbonado, char *szCadena, sql_context ctxCont);
int ifnCiclFactVigenteAbonado(FILE **ptArchLog, long lCodCliente, long lNumAbonado, int iCodCiclFact, sql_context ctxCont);
int ifnGetCodCiclFact(FILE **ptArchLog, int iCodCiclo, sql_context ctxCont);
int ifnGetCodCiclFactCliente(FILE **ptArchLog, long lCodCliente, sql_context ctxCont);
int ifnTrazaHilos (char* szExeNameApp, FILE **fArch, char* szTxt, int iNivel,...);


/******************************************************************************************/
/** Informaciún de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  %ARCHIVE% */
/** Identificador en PVCS                               : */
/**  %PID% */
/** Producto                                            : */
/**  %PP% */
/** Revisiún                                            : */
/**  %PR% */
/** Autor de la Revisiún                                : */
/**  %AUTHOR% */
/** Estado de la Revisiún ($TO_BE_DEFINED es Check-Out) : */
/**  %PS% */
/** Fecha de Creaciún de la Revisiún                    : */
/**  %DATE% */
/** Worksets ******************************************************************************/
/** %PIRW% */
/** Historia ******************************************************************************/
/** %PL% */
/******************************************************************************************/

