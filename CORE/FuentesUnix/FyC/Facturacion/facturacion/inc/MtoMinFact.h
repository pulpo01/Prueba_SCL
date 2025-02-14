/* ***********************************************
Nombre : MotoMinFact.h
Autor  : Guido Antio Cares
*********************************************** */
#ifndef _MOTOMINFACT_H_
#define _MOTOMINFACT_H_

/* Librerias                        */
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>
#include <strings.h>
#include <math.h>
#include <time.h>
#include <unistd.h>
#include <GenFA.h>
#include <trazafact.h>

#define  MONTOMIN       "P"
 
typedef struct regMMF
{
    long    lNumAbonado     ;
    double  dImpCargoBasico ;
    double  dImpTrafico     ;
    char    szPlantarif  [4];
    int     iIndMMF         ;
    int     iPosCargoBasico ;

}REGMMF;


/****************************************************************/
/* declaracion de funciones */
/****************************************************************/

/* BOOL bfnVerificaPlan(char *szPlanTarif, double *dImpFacturable); */

#undef access
#ifdef _MTOMINFACT_PC_

char modulo[]   = "bfnMontoMin_Fact";

/****************************** Declaracion de Prototipos ********************/
#define access  

#ifdef SQLNOTFOUND
#undef SQLNOTFOUND
#endif

#define SQLNOTFOUND   1403   /* Ansi :100 ; Not ansi : 1403  HOMOLOGACION TM-200409210949_221004 JJFigueroa*/

BOOL bfnGeneraCptoMMF    ( long lNroConcCB
                         , double dImpCragoBasico, double dImpTrafico);
BOOL bfnRebajaCargoBasico( int iNroCpto);
BOOL bBuscaCodTraficoLocal (int iCodConcepto);
int  ifnCmpCodConcep      ( const void *cad1,const void *cad2);
BOOL bfnRebajaCargoBasico();
BOOL bfnValidaPlanTarifMFF (char  *szPlanTarif);
BOOL bfnGetConcParam     ( long    lCodParametro
                         , int    *iCodConcep
                         , char   *szDesConcep);

#else

#define access extern

access BOOL bfnMontoMin_Fact (long lCliente);

#endif /* _MTOMINFACT_PC_ */
#endif /* _MTOMINFACT_H_  */



/******************************************************************************************/
/** Información de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  CORE/FUENTES_UNIX/FyC/Facturacion/facturacion/inc/MtoMinFact.h */
/** Identificador en PVCS                               : */
/**  SCL:A32.A-UNIX;des#2.2 */
/** Producto                                            : */
/**  SCL */
/** Revisión                                            : */
/**  des#2.2 */
/** Autor de la Revisión                                : */
/**  MWN70294 */
/** Estado de la Revisión ($TO_BE_DEFINED es Check-Out) : */
/**  CERTIFICADO */
/** Fecha de Creación de la Revisión                    : */
/**  12-NOV-2003 17:10:29 */
/** Worksets ******************************************************************************/
/** 1:																		*/
/** 	Workset:     "SCL:WS/D"                                                                                                                 */
/** 	Description: Workset de Desarrollo                                                                                                      */
/**                                                                                                                                             */
/** 2:                                                                                                                                          */
/** 	Workset:     "SCL:WS/D-TMC"                                                                                                             */
/** 	Description: Workset desarrollo TMC                                                                                                     */
/**                                                                                                                                             */
/** 3:                                                                                                                                          */
/** 	Workset:     "SCL:WS/LIB-TMM-TEMP"                                                                                                      */
/** 	Description: LIBERACION TMM TEMPORAL                                                                                                    */
/**                                                                                                                                             */
/** 4:                                                                                                                                          */
/** 	Workset:     "SCL:WS/D-P-TMM-03075"                                                                                                     */
/** 	Description: P-TMM-03075 Evolución de Factura miscelánea (Facturación en Dólares e incorporación de unidad en los conceptos)            */
/**                                                                                                                                             */
/** 5:                                                                                                                                          */
/** 	Workset:     "$GENERIC:$GLOBAL"                                                                                                         */
/** 	Description: Global workset for database                                                                                                */
/**                                                                                                                                             */
/** 6:                                                                                                                                          */
/** 	Workset:     "SCL:WS/ADEC-TMM-OLD"                                                                                                      */
/** 	Description: (10M)Proyecto  Mejoras al proceso de Interfaz con Centrales                                                                */
/**                                                                                                                                             */
/** 7:                                                                                                                                          */
/** 	Workset:     "SCL:WS/ADEC-TMM"                                                                                                          */
/** 	Description: Work Set WS/ADEC-TMM1.AAAA                                                                                                 */
/**                                                                                                                                             */
/** Historia ******************************************************************************/ 
/** Revision lib_tmc#3 (CERTIFICADO)                                                                                                            */
/**   Created:  18-nov-2004 18:16:48      MWN70400                                                                                              */
/**     Paso de fuentes de incidencias XC 18/11/2004                                                                                            */
/**                                                                                                                                             */
/** Revision lib_tmc#2 (CERTIFICADO)                                                                                                            */
/**   Created:  18-nov-2004 14:16:33      MWN70400                                                                                              */
/**     Paso de fuentes de incidencias XC 18/11/2004                                                                                            */
/**                                                                                                                                             */
/** Revision des_tmc#1 (CERTIFICADO)                                                                                                            */
/**   Created:  16-nov-2004 18:53:53      MWN70334                                                                                              */
/**     Homologacion XC-200411080391.                                                                                                           */
/**                                                                                                                                             */
/** Revision lib_tmc#1 (CERTIFICADO)                                                                                                            */
/**   Created:  09-nov-2004 20:14:59      MWN70401                                                                                              */
/**     POST BUCERIAS XC                                                                                                                        */
/**                                                                                                                                             */
/** Revision sop_tmm#4 (CERTIFICADO)                                                                                                            */
/**   Created:  29-oct-2004 12:13:56      MWN70334                                                                                              */
/**     Modo Oracle. TM-200410281037.                                                                                                           */
/**                                                                                                                                             */
/** Revision sop_tmm#3 (CERTIFICADO)                                                                                                            */
/**   Created:  23-oct-2004 14:50:50      MWN70401                                                                                              */
/**                                                                                                                                             */
/** Revision sop_tmm#2 (CERTIFICADO)                                                                                                            */
/**   Created:  23-oct-2004 11:34:08      MWN70400                                                                                              */
/**     Se Pasan piezas proyecto memoria compartida                                                                                             */
/**                                                                                                                                             */
/** Revision sop_tmm#1 (CERTIFICADO)                                                                                                            */
/**   Created:  20-oct-2004 13:39:18      MWN70334                                                                                              */
/**     SQLNOTFOUND modo Oracle. TM-200409210949_S1.                                                                                            */
/**                                                                                                                                             */
/** Revision des_buc#1 (CERTIFICADO)                                                                                                            */
/**   Created:  22-jul-2004 17:59:47      MWN70375                                                                                              */
/**     PH-200407070262    Se elimina SQLNOTFOUND                                                                                               */
/**                                                                                                                                             */
/** Revision sop_tmc#1 (CERTIFICADO)                                                                                                            */
/**   Created:  13-jul-2004 20:43:03      MWN70334                                                                                              */
/**     Actualizacion de SQLNOTFOUND Oracle CH-200404061800                                                                                     */
/**                                                                                                                                             */
/** Revision lib#2 (CERTIFICADO)                                                                                                                */
/**   Created:  29-oct-2003 11:08:50      MWN70294                                                                                              */
/**     Sellado con Version Stamping                                                                                                            */
/**                                                                                                                                             */
/** Revision lib#1 (CERTIFICADO)                                                                                                                */
/**   Created:  29-oct-2003 10:12:36      MWN70294                                                                                              */
/**     Sellado con Version Stamping                                                                                                            */
/**                                                                                                                                             */
/** Revision des#2.2 (CERTIFICADO)                                                                                                              */
/**   Created:  29-oct-2003 09:20:26      MWN70294                                                                                              */
/**     Sellado con Version Stamping                                                                                                            */
/**                                                                                                                                             */
/** Revision des#2.1 (CERTIFICADO)                                                                                                              */
/**   Created:  27-jun-2003 18:27:15      MWN70252                                                                                              */
/**                                                                                                                                             */
/** Revision des#2.0 (CERTIFICADO)                                                                                                              */
/**   Created:  13-feb-2003 11:14:05      MWN70252                                                                                              */
/**     Initial Revision                                                                                                                        */
/******************************************************************************************/

