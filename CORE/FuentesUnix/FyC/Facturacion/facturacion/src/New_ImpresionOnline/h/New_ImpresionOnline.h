/* **********************************************/
/*               "New_ImpresionOnline.h"		*/
/*          20 de Septiembre de 2005 		*/
/*                                      		*/
/************************************************/


/* definiciones de constantes */
#define FALSE           0
/*#define TRUE            1*/
#define SQLOK		    0
#define access 		   extern
#define iPROCESO_INT_IMPRESION_ONLINE   330
#ifdef SQLNOTFOUND
#undef SQLNOTFOUND
#endif

#define SQLNOTFOUND   1403	/* Ansi :100 ; Not ansi : 1403 */

#define MAXCANTPROCESOS 15 /*AFGS - 62056*/
/*****************************************************************************/
/* Versionamiento                                                            */
/*****************************************************************************/
/*                                                             */
#define szVersionActual          "2.005"
#define szUltimaModificacion "20.05.2005"
/*****************************************************************************/

char szUsage[]=
"\n\tUso : New_ImpresionOnline Opciones \n"
"\n\tOpciones :"
"\n\t\t-e cod_Modgener"
"\n\t\t-l nivel de Log"
"\n\t\t-u usuario/password o '/'(Opcional)"
"\n";

#define SIZE_HOSTARRAY_INTERFACT 1000
/*******************************************************************************/
/*Estructura para recoger los datos de la tabla FA_INTERFACT en un host array  */
/*******************************************************************************/

typedef struct ha_FA_INTERFACT
{
    long    lNumProceso         [SIZE_HOSTARRAY_INTERFACT]    ;
    int     iCodTipMovimien     [SIZE_HOSTARRAY_INTERFACT]    ;
    int     iCodTipDocumento    [SIZE_HOSTARRAY_INTERFACT]    ;
}reg_FaInterFact;
                                 
/*******************************************************************************/

/* declaracion de funciones */
access int ifnValidaParametros(	int     argc            ,
				char    *argv[]         ,
				char    *	,
				char    *szOraPasswd    ,
				int     *iLogLevel      ,
				char    *szCodModGener  );
 
access int ifnAcessoOracle();  
access int ifnImpresionOnline(char * , char *, int, char *);
int ifnAbreArchivosLog(int iLogLevel, char *szCodModGener);

BOOL bfnEjeComando  (int num_rows
                    ,char *pszUsuario
                    ,int ihCodNivLog
                    ,reg_FaInterFact ha_FaInterFact
                    ,int iCodEstaDocSal);
                             
int iBuscaProceso(char *szComando); /*CJG - 63998*/
