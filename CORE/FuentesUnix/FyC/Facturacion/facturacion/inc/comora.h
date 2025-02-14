/*******************************************************************************
Fichero    :  comora.h
Descripcion:  Declaracion de tipos y prototipos de comora.c
Fecha      :  23-02-1997
Autor      :  Javier Garcia Paredes 
*******************************************************************************/

#ifndef _COMORA_H_
#define _COMORA_H_

#include <GenFA.h>
#include <predefs.h>
#include <geora.h>
#include <prebilling.h>

/* rao20030807: definicion del tamaño del hosts array */
#define MAXPRESU 4


#undef access
#ifdef _COMORA_PC_
#define access
#else
#define access extern
/* access BOOL bPasoHistorico        (FACTURA*,int); */
access BOOL bfnDBCargaPresupuesto (long, long)  ;



#endif /*_COMORA_PC_*/
#undef access
#endif /*_COMORA_H_*/


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

