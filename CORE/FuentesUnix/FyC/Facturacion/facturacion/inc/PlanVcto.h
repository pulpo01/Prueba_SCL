/* ***********************************************
Nombre : PlanDcto.h
Autor  : Guido Antio Cares
*********************************************** */
#ifndef _PLANVCTO_H_
#define _PLANVCTO_H_

/* Librerias                        */
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>
#include <strings.h>
#include <math.h>
#include <time.h>
#include <unistd.h>
#include "GenFA.h"
#include "trazafact.h"


/****************************************************************/
/* declaracion de funciones 					*/
#undef access
#ifdef _PLANVCTO_PC_
/******************* Declaracion de Prototipos ******************/
#ifdef SQLNOTFOUND
#undef SQLNOTFOUND
#endif
#define SQLNOTFOUND   1403   /* Ansi :100 ; Not ansi : 1403 */
#define access  
BOOL 	bfnDiasVencimiento (long , long ,int , char *, char *, char *);
BOOL  	bBuscaDiaHabil (char *, char *);
BOOL  	bDiaFeriado (char *, int *);
BOOL  	bGetTipoDia (char *, int *);
#else
#define access extern
access BOOL 	bGetNumDiasPlanVcto (long , long , int , char *, int *);
access BOOL    bfnDiasVencimiento (long , long ,int , char *, char *, char *);
#endif /* _PLANVCTO_PC_ */
#endif /* _PLANVCTO_H_  */








/******************************************************************************************/
/** Información de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  CORE/FUENTES_UNIX/FyC/Facturacion/facturacion/inc/PlanVcto.h */
/** Identificador en PVCS                               : */
/**  SCL:A35.A-UNIX;des#2.2 */
/** Producto                                            : */
/**  SCL */
/** Revisión                                            : */
/**  des#2.2 */
/** Autor de la Revisión                                : */
/**  MWN70294 */
/** Estado de la Revisión ($TO_BE_DEFINED es Check-Out) : */
/**  CERTIFICADO */
/** Fecha de Creación de la Revisión                    : */
/**  12-NOV-2003 17:10:33 */
/** Worksets ******************************************************************************/
/** 1:																	*/
/** 	Workset:     "SCL:WS/D"                                                                                                         */
/** 	Description: Workset de Desarrollo                                                                                              */
/**                                                                                                                                     */
/** 2:                                                                                                                                  */
/** 	Workset:     "SCL:WS/D-TMC"                                                                                                     */
/** 	Description: Workset desarrollo TMC                                                                                             */
/**                                                                                                                                     */
/** 3:                                                                                                                                  */
/** 	Workset:     "SCL:WS/LIB-TMM-TEMP"                                                                                              */
/** 	Description: LIBERACION TMM TEMPORAL                                                                                            */
/**                                                                                                                                     */
/** 4:                                                                                                                                  */
/** 	Workset:     "SCL:WS/D-P-TMM-03075"                                                                                             */
/** 	Description: P-TMM-03075 Evolución de Factura miscelánea (Facturación en Dólares e incorporación de unidad en los conceptos)    */
/**                                                                                                                                     */
/** 5:                                                                                                                                  */
/** 	Workset:     "$GENERIC:$GLOBAL"                                                                                                 */
/** 	Description: Global workset for database                                                                                        */
/**                                                                                                                                     */
/** 6:                                                                                                                                  */
/** 	Workset:     "SCL:WS/ADEC-TMM-OLD"                                                                                              */
/** 	Description: (10M)Proyecto  Mejoras al proceso de Interfaz con Centrales                                                        */
/**                                                                                                                                     */
/** 7:                                                                                                                                  */
/** 	Workset:     "SCL:WS/ADEC-TMM"                                                                                                  */
/** 	Description: Work Set WS/ADEC-TMM1.AAAA                                                                                         */
/**                                                                                                                                     */
/** Historia ******************************************************************************/ 
/** Revision lib_tmc#3 (CERTIFICADO)                                                                                                    */
/**   Created:  18-nov-2004 18:16:50      MWN70400                                                                                      */
/**     Paso de fuentes de incidencias XC 18/11/2004                                                                                    */
/**                                                                                                                                     */
/** Revision lib_tmc#2 (CERTIFICADO)                                                                                                    */
/**   Created:  18-nov-2004 14:16:36      MWN70400                                                                                      */
/**     Paso de fuentes de incidencias XC 18/11/2004                                                                                    */
/**                                                                                                                                     */
/** Revision des_tmc#1 (CERTIFICADO)                                                                                                    */
/**   Created:  16-nov-2004 18:53:04      MWN70334                                                                                      */
/**     Homologacion XC-200411080391.                                                                                                   */
/**                                                                                                                                     */
/** Revision lib_tmc#1 (CERTIFICADO)                                                                                                    */
/**   Created:  09-nov-2004 20:15:01      MWN70401                                                                                      */
/**     POST BUCERIAS XC                                                                                                                */
/**                                                                                                                                     */
/** Revision sop_tmm#3 (CERTIFICADO)                                                                                                    */
/**   Created:  29-oct-2004 12:18:53      MWN70334                                                                                      */
/**     Modo Oracle. TM-200410281037.                                                                                                   */
/**                                                                                                                                     */
/** Revision sop_tmm#2 (CERTIFICADO)                                                                                                    */
/**   Created:  23-oct-2004 14:50:52      MWN70401                                                                                      */
/**                                                                                                                                     */
/** Revision sop_tmm#1 (CERTIFICADO)                                                                                                    */
/**   Created:  23-oct-2004 11:34:11      MWN70400                                                                                      */
/**     Se Pasan piezas proyecto memoria compartida                                                                                     */
/**                                                                                                                                     */
/** Revision des_buc#1 (CERTIFICADO)                                                                                                    */
/**   Created:  22-jul-2004 18:03:54      MWN70375                                                                                      */
/**     PH-200407070262, Se elimina SQLNOTFOUND                                                                                         */
/**                                                                                                                                     */
/** Revision sop_tmc#1 (CERTIFICADO)                                                                                                    */
/**   Created:  13-jul-2004 20:45:57      MWN70334                                                                                      */
/**     Actualizacion de SQLNOTFOUND Oracle CH-200404061800                                                                             */
/**                                                                                                                                     */
/** Revision lib#2 (CERTIFICADO)                                                                                                        */
/**   Created:  29-oct-2003 11:09:16      MWN70294                                                                                      */
/**     Sellado con Version Stamping                                                                                                    */
/**                                                                                                                                     */
/** Revision lib#1 (CERTIFICADO)                                                                                                        */
/**   Created:  29-oct-2003 10:13:01      MWN70294                                                                                      */
/**     Sellado con Version Stamping                                                                                                    */
/**                                                                                                                                     */
/** Revision des#2.2 (CERTIFICADO)                                                                                                      */
/**   Created:  29-oct-2003 09:20:49      MWN70294                                                                                      */
/**     Sellado con Version Stamping                                                                                                    */
/**                                                                                                                                     */
/** Revision des#2.1 (CERTIFICADO)                                                                                                      */
/**   Created:  27-jun-2003 18:28:05      MWN70252                                                                                      */
/**                                                                                                                                     */
/** Revision des#2.0 (CERTIFICADO)                                                                                                      */
/**   Created:  13-feb-2003 11:15:26      MWN70252                                                                                      */
/**     Initial Revision                                                                                                                */
/******************************************************************************************/

