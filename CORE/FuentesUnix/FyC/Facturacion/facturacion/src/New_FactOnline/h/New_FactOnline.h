/* **********************************************/
/*               "New_FactOnline.h"		*/
/*          13 de Diciembre de 1999 		*/
/*           Roy Barrera Richards		*/
/************************************************/


/* definiciones de constantes */
#define FALSE                    0
#define SQLOK		         0

#define access 		         extern

#define VENTA			 1
#define MISCELANEA	         18
#define NOTACRED	         25

#ifdef SQLNOTFOUND
#undef SQLNOTFOUND
#endif

#define SQLNOTFOUND              1403	/* Ansi :100 ; Not ansi : 1403 */


/*****************************************************************************/
/* Versionamiento                                                            */
/*****************************************************************************/
#define szVersionActual          "1.02"
#define szUltimaModificacion     "10.09.2009"
/*****************************************************************************/

char szUsage[]=
"\n\tUso : New_FactOnline Opciones \n"
"\n\tOpciones :"
"\n\t\t-e cod_Modgener"
"\n\t\t-l nivel de Log"
"\n\t\t-u usuario/password o '/'(Opcional)"
"\n";

#define SIZE_HOSTARRAY_INTERFACT 800
/*******************************************************************************/
/*Estructura para recoger los datos de la tabla FA_INTERFACT en un host array  */
/*******************************************************************************/

typedef struct ha_FA_INTERFACT
{
    long lNumProceso[SIZE_HOSTARRAY_INTERFACT];
}reg_FaInterFact;
                                
/*******************************************************************************/
/*******************************************************************************/
typedef struct regFAINTERFACT
{
    long    lNumProceso;
    struct 	regFAINTERFACT * sgte;
}regFAINTERFACT;

typedef struct regFAINTERFACT stFAINTERFACT;
stFAINTERFACT * lstFAINTERFACT = NULL;
/*******************************************************************************/

/* declaracion de funciones */
access int ifnValidaParametros    ( int  argc          ,
				    char *argv[]       ,
				    char *	       ,
				    char *szOraPasswd  ,
				    int  *iLogLevel    ,
				    char *szCodModGener );
 
access int ifnAcessoOracle        ();  
access int ifnFacturacionOnline   ( char * , char *, int, char *);
int ifnAbreArchivosLog            ( int iLogLevel, char *szCodModGener);
BOOL bfnEjeComando                ( char *pszUsuario,int ihCodNivLog,int iCodEstaDocSal);
BOOL bfnGetInterFactUpNoWait      ( INTERFACT *stpInterFact);
BOOL bfnCargaFaInterfac           ( INTQUEUEPROC);
int iBuscaProceso                 ( char *szComando);
BOOL bfnBuscaTipoMovimiento       ( int );
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

