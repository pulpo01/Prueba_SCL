/* ********************************************************************** */
/* *  Fichero : facinffac01.h                                              * */
/* *  Autor : Ignacio Fuentealba S.                                     * */
/* *  Comentarios :                                                     * */
/* ********************************************************************** */

#ifndef _FACINFFAC01_H_
    #define _FACINFFAC01_H_
    #include <memory.h>  
    #include <GenFA.h>
#endif /* _FACINFFAC01_H_ */

#define iLOGNIVEL_DEF 3


char szExeFacinffac01[1024];

/*********************************************
Estructura para recoger los datos por
la linea de comandos.     
**********************************************/
typedef struct LineaComando
{ 
     char szUser   [50];    
     char szPass   [50];        
     char lQueDato [1] ;
     long lTipoDocumen ;
     long lCodCiclFact ;
     long lFechaFact1;
     int  iNivLog      ;
}LINEACOMANDO;


/**************************************************
Estructura para Guardar la incosistencia de Datos
**************************************************/
typedef struct  ReporteFacinffac01
{ 
	char  ReporteName[128]	;
	FILE* ReporteFile	;
}REPORTEFACINFFAC01;

REPORTEFACINFFAC01  stReporteFacinffac01;    /*  Guarda la REPORTEFACINFFAC01 de Datos para Reporte de Regularizacion */

#undef access

#ifdef _FACINFFAC01_PC_
    #define access
#else
    #define access extern
#endif

access BOOL cuerpo(char*, long ,long ,long );
access char* cfnGetTime( void );

#undef access

#ifdef _FACINFFAC01C_C_
    #define access
#else
    #define access extern
#endif

#undef _FACINFFAC01_PC_
#undef _FACINFFAC01C_C_



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

