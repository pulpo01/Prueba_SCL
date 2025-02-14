/***********************************************************/
/*      Generico.h                                         */
/***********************************************************/
#include <GenFA.h>
#include <trazafact.h>

#undef access
#ifdef _CRITASIGDESP_PC_
#define access
#else
#define access extern
#endif

/********************************************************************/
/*   Estructura para recoger los datos por la linea de comandos.    */  
/********************************************************************/
typedef struct LineaComandoGenerica
{
    char    szUsuarioOra [64] ;
    char    szOraAccount [32] ;
    char    szOraPasswd  [32] ;
     int    iLogLevel         ;
    long    lCodCiclFact	  ;  /* Cod Ciclo de Facturacion */
    char    szCodCritAsig[6]  ;  /* Cod Criterio Asignacion  */
     int    iTraspasar        ;  /* Indicador de Traspasar Criterios */
}LINEACOMANDOGENERICA;

typedef struct RegistroDatos
{
    	char  szCodCritDesp   [4] ; 
		char  szFecDesde      [9] ;
		char  szValParam     [21] ;
		char  szValOper       [3] ;
		char  szCodDesp       [6] ;
		char  szFecHasta      [9] ;
		char  szIndPreProc    [2] ;
		char  szCodTipParam   [2] ;
		 int  iCodPrioridad       ;
		 int  iCodCiclo		  ;
		long  lCodCiclFact        ;
		char  szFecHastaCFijos[9] ;
		char  szFecEmision    [9] ;
}REGISTRODATOS;

/************************************************************************/
/*   Definiendo Variables y Estructuras Globales                        */
/************************************************************************/

LINEACOMANDOGENERICA    stLineaComando   ;

REGISTRODATOS           stDatos          ;


/************************************************************************/
/*   Definiendo Constantes Enteras y de Caracter                        */
/************************************************************************/
#define iLOGNIVEL_DEF 	3

#define critMONTO			"MTO"
#define critCLIENTE			"MCL"
#define critCUENTA   		"MCA"
#define critTIPOCLI			"TCL"
#define critCANTABON		"ABO"
#define critPLAN			"PLA"
#define critPRODUCTO		"PRO"
#define critINICIO  		"INI"
#define PREFACT             "1"

static char szUsage[]=
"\n\t Uso: CritAsigDesp opciones"
"\n"
"\n\t opciones:"
"\n"
"\n\t\t -u 'Usuario/Password' o '/' (Opcional)  Default : '-u /' "
"\n\t\t -l  Nivel Log               (Opcional)  Default : LOG03	 "
"\n\t\t -c  Cod_CiclFact            (Necesario)      ej : -c10100"
"\n\t\t -d  Cod_CritDesp            (Necesario)      ej : -dMTO"
"\n\t\t -t  [Traspaso Cod Despacho] (Necesario)      ej : -t\n"
"\n\t\t NOTAS : Las opciones '-d' y '-t' son mutuamente excluyentes" 
"\n\t\t Criterios Validos :"
"\n\t\t (MTO) MONTO      \t\t (PLA) PLAN"
"\n\t\t (MCL) CLIENTE    \t\t (MCA) CUENTA"
"\n\t\t (INI) INICIO     \t\t (PRO) PRODUCTO"
"\n\t\t (ABO) N.ABONADOS \t\t (TCL) TIPO CLIENTE"
"\n";


/************************************************************************/
/*   Declarando funciones prototipo                                     */
/************************************************************************/

access  int ifnValidaParametros();
access  int ifnAbreArchivosLog();
access  int ifnAccesoBaseDatos();
access BOOL bfnValidaCriterio();
access BOOL bfnPreparaCursorCriterios();
access BOOL bfnGetCriterios();
access  int ifnValidaCiclo();
access BOOL bfnPreparaCursorFACICLOCLI();
access BOOL bfnRecorreFaCicloCli();
access BOOL bfnInitSqlDinamico();
access BOOL bfnPreparaCursorClientes();
access BOOL bfnProcesaCriterio();
access BOOL bfnCargaDefault();
access BOOL bfnCargaSecDespDefault();
access BOOL bfnTraspasaCriterios();
access  int ifnGetCiclo();
access BOOL bfnPreparaCursorClie2();
access BOOL bfnProcesoTraspaso();
/*access char *cfnGetTime(); se va a una librería de objetos comunes rutinasgen.o */








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

