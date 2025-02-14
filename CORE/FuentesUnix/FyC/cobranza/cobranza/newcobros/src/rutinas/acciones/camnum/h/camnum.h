/* ============================================================================= 
   Tipo        :  ACCION
   Nombre      :  camnum.h 
   Descripcion :  Header de camnum.pc
   Autor       :  G.A.C.
   Fecha       :  13-Agosto-2004 
 ============================================================================= */
#include <CO_deftypes.h>       /* Inclusion de tipos generales de cobranza       */
#include <CO_libgenerales.h> /* Agregado por PGonzalez 20-10-2004 MAS-04037 */
#include "CO_libacciones.h"  /* Agregado por PGonzalez 20-10-2004 MAS-04037 */
/* ============================================================================= */
#define szCODRUTINA	"CANUM"

#define szVersion "3.0.0"   /* Nueva version por TMG-TMS */

int ifnTrazaHilos (char* szExeNameApp, FILE **fArch, char* szTxt, int iNivel,...);
