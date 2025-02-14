#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <errno.h>
#include <geora.h>
#include <utils.h>
#include <libgen.h>
#include "GEN_biblioteca.h" 

#define GLOSA_PROG     "EXTRACCION DE VENTAS PARA COMISIONES EXTERNAS BETA 20051026-020300"
#define PROG_VERSION   "1.10"
/*#define LAST_REVIEW    "20-04-2005 (mwt00100)."                                             */
/*#define LAST_REVIEW    "24-08-2005 (mwn70351)."  XO-200508230442 Soporte RyC 24-08-2005 capc*/
/*#define LAST_REVIEW    "26-08-2005 (mwn70351)."  XO-200508260483 Soporte RyC 26-08-2005 capc*/
/*#define LAST_REVIEW    "13-09-2005 (mwt00100)."  XO-200508270496 Amplicación Funcional Columnas en Blanco, y header de columnas*/
/*#define LAST_REVIEW    "03-10-2005 (mwt00100)."  XO-200509230721 Modificar obtención de Dirección*/
/*#define LAST_REVIEW    "07-10-2005 (mwt00100)."  XO-200510070817 Modificar construcción de archivos de datos*/
/*#define LAST_REVIEW    "21-10-2005 (mwt00100)."  XO-200510120857 Corregir glosa de articulos de la venta. Mostraba sólo Simcard*/
#define LAST_REVIEW    "21-12-2005 (mwn80006)."  /*RA-322 Se controla los tab y pipes en los archivos de datos*/

#define LOGNAME        "Ext_Ventas"

#define PATHLEN         250
#define UNIVERSO       "VENTAS"
/*---------------------------------------------------------------------------*/
/* Definicion de codigos de retorno del programa ejecutable (exit's code)    */
/*---------------------------------------------------------------------------*/
#define EXIT_01         1               /* Error en argumentos externos */
#define EXIT_03         3               /* Error en apertura de archivo de log */
#define EXIT_04         4               /* Error en apertura de archivo de datos de entrada */
#define EXIT_06         6               /* Usuario/Password Oracle son incorrectos */
#define TIPOCONTRATO   "CONTRATO"
#define TIPOPREPAGO    "PREPAGO"
/*---------------------------------------------------------------------------*/
/* Definicion de dia habil.                                                  */
/*---------------------------------------------------------------------------*/
#define HABIL           1
/*---------------------------------------------------------------------------*/
/* Definicion de variables globales.                                         */
/*---------------------------------------------------------------------------*/
FILE  * pfLog;
FILE  * pfLst;
FILE  * pfDat;
char *pszEnvLog           = "";
char *pszEnvDat           = "";

char szLogName [250]      = "";
char szDatName [250]      = "";
long lCantTotalAbonados = 0;
/*---------------------------------------------------------------------------*/
/* Definicion de estructura para manejar estadisticas del proceso.           */
/*---------------------------------------------------------------------------*/
typedef  struct REG_ESTADIST
{
	long         lSegProceso ;
	long         lCantArchivos;
}rg_estadistica;
rg_estadistica stStatusProc;
/*---------------------------------------------------------------------------*/
/* ESTRUCTURA DE VENTAS SELECCIONADAS                                        */
/*---------------------------------------------------------------------------*/
typedef struct reg_universo{

	long	lNumVenta			;
	long	lCodCliente			;
	char    cContrato[22]			;
	char    cNombre[51]			;
	char    cApellidos[51]			;
	char	num_cCedula[21]          	;
	char	num_cRut[21]             	;
	char	cFec_Aceptacion_venta[31]	;
	char	cFec_ultimo_cambio[31]   	;
	int	Codigo_servicio          	;
	char	usuario[31]              	;
	long	Vendedor                 	;
	int	Ciclo                    	;
	char	Indicador_venta[50]      	;
	char    szCodTipVendedor[3]		;
	char    szCodOficina[3]			;
	char	szDesOficina[41]		;
	char    cIndConsidera			;  

/*	char	szDireccion[801]		;
	char	szCodCiudad[6]			;
	char	szDesCiudad[31]			;
	char	szDesProvincia[31]		;
	char    szCodRegion[4]			;
	char	szCodFranquicia[4]		;
	char	szDesFranquicia[31] 		;*/
	char	szIndEstVenta[3]		;
 	char	szIndTipoVenta[20]      ;   /*marca el origen de la venta CONTRATO/PREPAGO */
	
	struct  reg_universo * sgte;
	struct  reg_abonado  * abonado_sgte;
}reg_universo;

typedef struct reg_universo stUniverso;
stUniverso * lstUniverso = NULL;
/*---------------------------------------------------------------------------*/
/* ESTRUCTURA DE ABONADOS DE LA VENTA.                                       */
/*---------------------------------------------------------------------------*/
struct reg_abonado{
    char	szNumCelular[16];
    char	szCodPlanTarif[4];
    char	szDesPlanTarif[31];             
    long	lNumAbonado;
    char	szCodTecnologia[8]; 
    char	szDesSituacionAbonado[31];      
    char	szcDescripcionEmpresa[51];      
    char	szcFecActivaTelefono[30];       
    char	szcFecBajaTelefono[30];                 
	
    long	lzTipTerminal;
    char	szDesTerminal[41];
    int		iCodFabricante;
    char	szDesFabricante[21];
    int		iCodAfinidad;
    char	cIndProcequi;
    long	lCodArticulo;
    char	szTipPlanTarif[21];

    char	szNumSerie[26];		/* Serie de la SIMCARD  */
    char	szNumImei [26];		/* Serie de la Terminal */

    char	cIndConsidera;
/* Inicio Incidencia RA-200511050068 Mauricio Moya */  
    long	lzCodVendedor;

    char	szDireccion[801];
    char	szCodProvincia[6];
    char	szDesProvincia[31];
    char	szCodRegion[4];
    char	szDesRegion[31];
    char	szCodCiudad[6];
    char	szDesCiudad[31];
    char	szCodFranquicia[6];
    char	szDesFranquicia[31];

    struct  reg_abonado * sgte;
    
};
typedef struct reg_abonado stAbonado;
/*------------------------------------------------------------------------------*/
void vSeleccionarUniverso(char * , char * );
int ifnGetAbonados_pospago(stUniverso * );
int ifnGetAbonados_prepago(stUniverso *, char * , char * );
void vLiberaUniverso();
char *szBuscaDetalleCampoi(stUniverso *,stAbonado *,stDetArchivo *);
char szBuscaArchivo();
void vGetEquipos();


