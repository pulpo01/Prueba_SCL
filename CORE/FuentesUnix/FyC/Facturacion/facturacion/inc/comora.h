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

/* rao20030807: definicion del tama�o del hosts array */
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
/** Informaci�n de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  %ARCHIVE% */
/** Identificador en PVCS                               : */
/**  %PID% */
/** Producto                                            : */
/**  %PP% */
/** Revisi�n                                            : */
/**  %PR% */
/** Autor de la Revisi�n                                : */
/**  %AUTHOR% */
/** Estado de la Revisi�n ($TO_BE_DEFINED es Check-Out) : */
/**  %PS% */
/** Fecha de Creaci�n de la Revisi�n                    : */
/**  %DATE% */
/** Worksets ******************************************************************************/
/** %PIRW% */
/** Historia ******************************************************************************/
/** %PL% */
/******************************************************************************************/

