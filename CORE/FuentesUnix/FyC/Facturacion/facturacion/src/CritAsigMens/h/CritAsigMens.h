/***********************************************************/
/* CritAsigMens.h (13/01/2000) */
/***********************************************************/
#include <GenFA.h>
#include <trazafact.h>

#undef access
#ifdef _CRITMENS_PC_
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
    long    lCodCiclFact      ;	 /* Cod Ciclo de Facturacion */
    char    szCodCritAsig[4]  ;  /* Cod Criterio Asignacion Mensaje */
     int    iPriorizar    	  ;  /* Indicador de Priorizar mensajes */
}LINEACOMANDOGENERICA;

typedef struct RegistroDatos
{
	long	lCodCiclFact		;
	char	szCriterio       [4];	
 	 int 	iCodFormulario  	;
	 int 	iCodBloque	  		;
	long 	lCorrMensaje		;
	 int 	iNumLineas			;
	char 	szCodOrigen      [3];
	 int 	iCodPrioridad		;
	char 	szValParam      [21];
	char 	szValOper        [3];
	char 	szFecDesde       [9];
	char 	szFecHasta       [9];
	char 	szIndCiclo       [2];
	/*char 	szFecProceso     [9];*/
	 int    iCodCiclo			;
	char    szFecHastaCFijos [9];
	char    szFecEmision     [9];
 	
}REGISTRODATOS;

/************************************************************************/
/*   Definiendo Variables y Estructuras Globales                        */
/************************************************************************/

LINEACOMANDOGENERICA    stLineaComando      ;
REGISTRODATOS           stDatos          ;


/************************************************************************/
/*   Definiendo Constantes Enteras y de Caracter                        */
/************************************************************************/
#define iLOGNIVEL_DEF 	3

#define critINICIO			"INI"
#define critPLAN			"PLA"
#define critPRODUCTO		"TPR"
#define critTODOS			"GEN"
#define critCICLOFACT		"CIC"
#define critTIPOCLI			"TCL"
#define critPAGOAUTOM		"PAC"

static char szUsage[]=
"\n\t Uso: CritAsigMens opciones"
"\n\t opciones:"
"\n\t\t -u 'Usuario/Password' o '/' (Opcional)  Default : '-u /' "
"\n\t\t -l  Nivel Log               (Opcional)  Default : LOG03	 "
"\n\t - excluyentes -"
"\n\t\t -c  Cod_CiclFact            (Necesario)      ej : -c10100"
"\n\t\t -d  Cod_CritDesp            (Necesario)      ej : -dCIC"
"\n"
"\n\t\t -p  [Priorizar Criterios]   (Necesario)      ej : -p "
"\n"
"\n\t NOTAS: Las opciones -c y -d siempre van juntas. "
"\n\t        La opcion -p va sola ( no puede ir con -c y -d )"
"\n\t Criterios Validos :"
"\n\t\t (INI) INICIO,\t\t (PLA) PLAN,\t\t (TPR) TIPO PRODUCTO,"
"\n\t\t (GEN) TODOS,\t\t (CIC) CICLO, \t\t (TCL) TIPO CLIENTE,"
"\n\t\t (PAC) PAGO AUTOM CTAS." 
"\n";


/************************************************************************/
/*   Declarando funciones prototipo                                     */
/************************************************************************/

access  int ifnValidaParametros();
access  int ifnAbreArchivosLog();
access  int ifnAccesoBaseDatos();
access BOOL bfnValidaCriterio();
access BOOL bfnPriorizaMensajes();
access BOOL bfnDeleteMensCiclo();
access BOOL bfnPreparaCursorCriterios();
access BOOL bfnGetCriterios();
access BOOL bfnInitSqlDinamico();
access BOOL bfnPreparaCursorClientes();
access BOOL bfnInsertaClientes();
access BOOL bfnProcesaCriterio();
access char *cfnGetTime(); /* se va a una librería de objetos comunes */
access BOOL bfnCargaDefault();
access BOOL bfnCargaMensajesDefault();
access BOOL ifnValidaCiclo(REGISTRODATOS *);




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

