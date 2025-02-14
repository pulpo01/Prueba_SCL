/************************************************************************/
/*  Definicion de ABOFACT                                               */
/************************************************************************/
#ifndef _ABOFACT_H_
#define _ABOFACT_H_
#include <memory.h>  
#include "GenFA.h"
#include "FaORA.h"
#include "trazafact.h"
#include "rutinasgen.h"
#endif /* _ABOFACT_H_ */


/************************************************************************/
/*  Nivel de Log por Default                                            */
/************************************************************************/
#define iLOGNIVEL_DEF             3

#define MAX_DIASREPLICA         100
/************************************************************************/
/*  Indicadores de Actuacion                                            */
/************************************************************************/
#define iINDACTUAC_NORMAL         1
#define iINDACTUAC_BAJA           2
#define iINDACTUAC_TRASPASO       3


/************************************************************************/
/*    Definicion de Errores de Inconsistencias                          */
/*   INCONS001 ..  INCONS020    STB                                     */
/*   INCONS021 ..  INCONS030    CUENTACONTROLADA-CARGOPROD              */
/************************************************************************/
#define  INCONS001 "Abonado STB     en Ciclo STB    No Tiene Telefono de Red Fija   \0"        
#define  INCONS002 "Abonado STB     en Ciclo STB    No Tiene Operador de Red Fija   \0"        
#define  INCONS003 "Abonado No STB  en Ciclo STB    Tiene Telefono de Red Fija      \0"
#define  INCONS004 "Abonado No STB  en Ciclo STB    Tiene Operador de Red Fija      \0"
#define  INCONS005 "Abonado STB     en Ciclo No STB                                 \0"        
#define  INCONS006 "Abonado STB     en Ciclo No STB Tiene Telefono de Red Fija      \0"
#define  INCONS007 "Abonado STB     en Ciclo No STB Tiene Operador de Red Fija      \0"
#define  INCONS008 "Abonado No STB  en Ciclo No STB Tiene Operador de Red Fija      \0"
#define  INCONS009 "Abonado No STB  en Ciclo No STB Tiene Operador de Red Fija      \0"

#define  INCONS021 "Abonado Sin Cuenta Controlada y Sin CargoProd                   \0"
#define  INCONS022 "Abonado Con Cuenta Controlada y Con CargoProd                   \0"

#define  INCONS031 "Abonado Sin Registro en Tabla FA_CICLOCLI                       \0"
#define  INCONS032 "Abonado con Cambio de Ciclo Ya Procesado                        \0"
#define  INCONS033 "Abonado con Indicador de Actuacion No Replicable                \0"


/************************************************************************/
/*  Estructura para recoger los datos desde las Interfaz de Abonados .  */
/************************************************************************/
typedef struct stGaInterfazFact
{ 
    long lCodCliente        ;
    long lNumAbonado        ;
    int  iCodProducto       ;
    int  iCodCiclo          ;
    int  iCodCicloNew       ;    
    int  iIndCambio         ;
    long lCodCiclFact       ;
    long lCodCiclFactNew    ;
    char szFecAlta      [15];
    char szFecBaja      [15];
    long lNumTerminal       ;  /* Numero Celular o Beeper */
    long lIndActuac         ;
    char szFecFinContra [15];
    long lIndAlta           ;
    long lIndDetalle        ;
    long lIndFactur         ;
    long lIndCuotas         ;
    long lIndArriendo       ;
    long lIndCargos         ;
    long lIndPenaliza       ;
    long lIndSupertel       ;
    char szNumTeleFija  [16]; 
    long lCodSupertel       ;
    long lIndCargoPro      ;
    long lIndCuenControlada ;
    long lIndBloqueo        ;
    char szFecActual    [15];
    BOOL bOptExiste         ;
}GAINTERFACT;


/************************************************************************/
/*  Estructura para almacenar las estadisticas                          */
/************************************************************************/
typedef struct stEstInterfaz
{ 
    long lTotales           ;
    long lCorrectos         ;
    long lIncorrectos       ;
    long lTotCambCiclo      ;
    long lTotBajas          ;
    long lTotSTBCorrecto    ;
    long lTotSTBIncorrectos ;
}GAINFACESTADIS;


/************************************************************************/
/*  Estructura para recoger los datos por la linea de comandos.         */
/************************************************************************/
typedef struct LineaComando
{ 
     char   szUser   [50]   ;   /*  Usuario Unix                        */    
     char   szPass   [50]   ;   /*  Password Oracle de Usuario Unix     */
     char   szUsuaOra[50]   ;   /*  Usuario Oracle                      */
     char   szDirLogs[1024] ;   /*  Directorio de Archivos Log's y Err  */
     long   lCodCiclFact    ;   /*  Codigo de Ciclo a Procesar          */
     int    iDigitoCli      ;   /*  Ultimo Digito del Codigo de Cliente */
     int    iNivLog         ;   /*  Nivel de Log para Proceso           */
     char   InconsName[128] ;   /*  Archivo de Inconsistencias          */
     FILE*  InconsFile      ;   /*  Descriptor de Archivo de Inconsis   */
}LINEACOMANDO;


/************************************************************************/
/*   Definiendo Variables y Estructuras Globales                        */
/************************************************************************/

LINEACOMANDO    stLineaComando      ;

GAINFACESTADIS  stEstadisCelu       ;

GAINFACESTADIS  stEstadisBeep       ;

char            szExeAboFact[1024]  ;

long            lhCodCicloSTM       ; /* Ciclo abonados supertelefono */

/************************************************************************/
#undef access

#ifdef _ABOFACT_PC_
    #define access
#else
#define access extern
#endif

#undef access

#undef _ABOFACT_PC_



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

