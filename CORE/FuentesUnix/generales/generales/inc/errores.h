/*******************************************************************************

Fichero:      errores.h
Descripcion:  Declaracion de tipos y prototipos del modulo de 
			  control de errores.

Fecha:        14/11/95
Autor:        Facturacion Boy's 

*******************************************************************************/

#ifndef _ERRORES_H_
#define _ERRORES_H_

/* #include <stdio.h>
#include <stdarg.h> */
#include <FaORA.h>

#define GRV0  0  /* Error Oracle: Fin proceso */
#define GRV1  1  /* Error Grave: Fin proceso  */
#define GRV2  2  /* Error Leve: Continua      */
#define GRV3  3  /* Aviso: Mensaje aviso      */

#define LOG00  0  /* Msg Oracle */
#define LOG01  1  /* Msg Errores graves y leves */
#define LOG02  2  /* Msg Avisos */
#define LOG03  3  /* Msg Trazas */
#define LOG04  4  /* Msg Trazas */
#define LOG05  5  /* Msg Trazas */
#define LOG06  6  /* Msg Trazas */
#define LOG07  7  /* Msg Trazas */
#define LOG08  8  /* Msg Trazas */
#define LOG09  9  /* Msg Trazas */
#define LOG010 10 /* Msg Trazas */

enum {ERR000,  
      ERR001, 
      ERR002, 
      ERR003,  
      ERR004, 
      ERR005,
      ERR006,
      ERR007,
      ERR008,
      ERR009,
      ERR010,
      ERR011,
      ERR012,
      ERR013,
      ERR014,
      ERR015,
      ERR016,
      ERR017,
      ERR018,
      ERR019,
      ERR020,
      ERR021,
      ERR022,
      ERR023,
      ERR024,
      ERR025,
      ERR026,
      ERR027,
      ERR028,
      ERR029,
      ERR030,
      ERR031,
      ERR032,
      ERR033,
      ERR034,
      ERR035,
      ERR036,
      ERR037,
      ERR038,
      ERR039,
      ERR040,
      ERR041,
      ERR042,
      ERR043,
      ERR044,
      ERR045,
      ERR046,
      ERR047,
      ERR048,
      ERR049,
      ERR050,
      ERR051,
      ERR052,
      ERR053,
      ERR054,
      ERR055,
      ERR056,
      ERR057,
      ERR058,
      ERR059,
      ERR060,
      ERR061,
      ERR062
};

typedef struct tagAnomalias
{
  char  szRowid      [19];
  int   iCodAnomalia     ;
  char  szDesAnomalia[101];
  int   iIndGravedad     ;
}ANOMALIAS;

typedef struct TagAnomProceso 
{
  long  lNumProceso       ;
  long  lCodCliente       ;
  long  lNumAbonado       ;
  int   iCodConcepto      ;
  short iCodProducto      ;
  long  lCodCiclFact      ;
  char  szDesProceso  [41];
  int   iCodAnomalia      ;
  char  szObsAnomalia [101];
} ANOMPROCESO;


#define MAX_ANOMALIAS 100

#define FLUSH "flush_archivo"
#define MAX_BYTES_BUFFER                    10000

#undef access
#ifdef _ERRORES_PC_
#define access 
/* -------------------------------------------------------------------------- */
/*                      Variables Globales                                    */
/* -------------------------------------------------------------------------- */

int iTrErr = 0;
int iTrLog = 0;
#else
#define access extern
#endif

/* -------------------------------------------------------------------------- */
/*                  Prototipos de Funciones Exportables                       */
/* -------------------------------------------------------------------------- */
access int  iDError (char*,int,void(*fnInserAnom)(void),...);
access void vDTrazasLog   (char*,char*,int,...);
access void vDTrazasError (char*,char*,int,...);
access BOOL bOpenError (char*);
access BOOL bCloseError(void) ;
access BOOL bOpenLog (char*)  ;
access BOOL bCloseLog(void)   ; 

access BOOL bFindAnomalias (int iCodAnomalia, ANOMALIAS *pAnomalias);
access void vPrintAnomalias(ANOMALIAS *pAnom, int iNumAnomalias    );
access int  iCmpAnomalias (const void *cad1, const void *cad2)      ;

access void vInsertarIncidencia (void);

access BOOL   bInsertaAnomProceso (ANOMPROCESO *)     ;
BOOL bfnEscribeArchivoLog(FILE *, char * );
/* -------------------------------------------------------------------------- */
/*                  Variables de Globales Exportables                         */
/* -------------------------------------------------------------------------- */
access STATUS      stStatus     ;
access ANOMPROCESO stAnomProceso;
#endif /*_ERRORES_H_*/
#undef _ERRORES_PC_


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

