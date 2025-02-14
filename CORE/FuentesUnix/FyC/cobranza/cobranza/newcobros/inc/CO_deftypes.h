/* ============================================================================= */
/*
    Tipo        	:	DEFINICIONES GENERALES

    Nombre      	:	CO_deftypes.h

    Descripcion 	:	Inclusion de archivos y definiciones de tipos generales para 
                   		todo el proyecto.

    Autor       	:	Roy Barrera Richards                 
    Fecha       	:	09 - Agosto - 2000 
    
    Modificacion	:
    
    06-11-2002		:	Se agrega constante iLENNUMSERIE, para manejo de largo de string 
    					NUM_SERIE de GA_ABOCEL en las distintas rutinas en las cuales se 
    					considera su manejo.

*/
/* ============================================================================= */
/*******************************************************************************
Fichero:      CO_deftypes.h
Descripcion:  Declaracion de tipos de CObros
*******************************************************************************/

#ifndef _CODEFTYPES_H_
#define _CODEFTYPES_H_

#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <string.h>
#include <stdarg.h>
#include <stdlib.h>
#include <sys/times.h>
#include <sys/time.h>
#include <sys/wait.h>
#include <time.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <sys/fcntl.h>
#include <utmp.h>
#include <errno.h>
#include <malloc.h>
#include <ctype.h>

typedef unsigned char        BYTE;   /*  8-bit sin signo */
typedef unsigned short int   WORD;   /* 16-bit sin signo */
typedef unsigned long int    LONG;   /* 32-bit sin signo */

#define LOG00    0  /* Msg Oracle */
#define LOG01    1  /* Msg Errores graves y leves */
#define LOG02    2  /* Msg Avisos */
#define LOG03    3  /* Msg Trazas */
#define LOG04    4  /* Msg Trazas */
#define LOG05    5  /* Msg Trazas */
#define LOG06    6  /* Msg Trazas */
#define LOG07    7  /* Msg Trazas */
#define LOG08    8  /* Msg Trazas */
#define LOG09    9  /* Msg Trazas */
#define LOG10   10  /* Msg Trazas */ /* LOG010 */
#define EST00   11  /* Msg Estadistica */
#define INFALL  12  /* Msg Informativo para ALL FILES OPENED (LOG, ERR, EST) */

#define TAMBUFSIZ   5001            /* tamano de cadenas */

#define SQLOK          0
#define ORA_NULL      -1

#ifdef SQLNOTFOUND
#undef SQLNOTFOUND
#endif
/*#define SQLNOTFOUND 100*/
#define SQLNOTFOUND 1403    /* XC-51 14-07-2004 capc*/

#define SQLCODE     sqlca.sqlcode
#define SQLERRM     sqlca.sqlerrm.sqlerrmc
#define SQLROWS     sqlca.sqlerrd[2]

#ifndef _BOOL_				/* _BOOL_           */
#define _BOOL_
#define  FALSE  0
#define  TRUE   !FALSE 
typedef int BOOL;			/*	Tipo Booleano    */
#endif						/* _BOOL_           */

typedef struct tagSTATUS        /* Status de ejecucion */
{
    long   lPid                ;       /* Identificador proceso asignado al programa               */
    BOOL   bExitApp            ;       /* Salida de la aplicacion                                  */
    int    iLogNivel           ;       /* Nivel en el fichero de log                               */
    char   szLogPathGene[128]  ;       /* Path General donde estara el archivo de Log              */
    char   szLogPathHoy[9]     ;       /* Fecha actual yyyymmdd (parte del directorio)             */
    char   szFileName[32]      ;       /* Nombre del fichero gral (se diferencia por la extension) */
    FILE*  LogFile             ;       /* Fichero de log                                           */
    FILE*  ErrFile             ;       /* Fichero de Errores                                       */
    FILE*  EstFile             ;       /* Fichero de Estadisticas                                  */
}STATUS;

STATUS       stStatus;

/* para manejo de decimales */
#define szNUM_DECIMAL			"NUM_DECIMAL"           /* Numero de Decimales a considerar */
#define szSEP_MILES_MONTOS		"SEP_MILES_MONTOS"      /* Caracter separados de miles */
#define szSEP_DECIMALES_MONTOS	"SEP_DECIMALES_MONTOS"  /* Caracter separador de decimales */
#define szSEP_DECIMALES_ORACLE	"SEP_DECIMALES_ORACLE"  /* Caracter separador de decimales */

/* para manejo de servicios suplementarios en la tabla ga_servsuplabo*/
#define iSERVACTBD	1
#define iSERVACTCE	2
#define iSERVDESBD	3
#define iSERVDESCE	4

/* indicador de servicio activo y desactivo */
#define iSERVDESACT	0
#define iSERVACTIVO	1

/* declaracion de constantes para manejo de string dentro de las rutinas */
#define iLENNUMSERIE	26
#define iLENNUMIMEI		26
#define iLENNUMIMSI		51
#define iLENCODTECNO	9
#define iLENCODMODULO	3
#define iLENNUMIDENT	21	

/* declaracion de constantes para codigos de modulo */
#define szMODULOCOBRANZA	"CO"
#define szACCIONSUSP		"S"
#define szACCIONREHA		"R"

/* declaracion de constantes para Cobranza Externa */
#define szENTIDADCLIENTE	"C"
#define szENTIDADCUENTA		"R"

typedef struct TagGenParam
{
	int  iNumDecimal		;
	char szSepMilesMonto[2] ;
	char szSepDecMontos	[2]	;
	char szSepDecOracle	[2]	;
}GENPARAM;

typedef struct GenFieldZona
{
	char	szNomTabla[31];
	char	szNomCampo[31];
	char	szDesCampo[31];
	char	szCodCampoAlt[31];
	char	szDesCampoAlt[31];
}GENFIELDZONA;

typedef struct GenServicio
{
	char	szCodServicio[4];
	int		iCodServSupl;
}GENSERVICIO;

#endif /* _CODEFTYPES_H_ */

/* -------------------------------------------------------------------------- */
/*                  Variables de Globales Exportables                         */
/* -------------------------------------------------------------------------- */
typedef struct LineaComando
{
	char    szUsuarioOra [64];
	char    szOraAccount [32];
	char    szOraPasswd  [32];
	int		iLogLevel;
}LINEACOMANDO;

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
