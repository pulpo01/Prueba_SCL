/******************************************************************************
 * Programa: Biblioteca de rutinas de trazas.
 * Autor   : Richard Troncoso C.
 * Fecha   : 14-11-01
 ******************************************************************************
 * Incorporacion de Estructura de manejo de periodos
 *    PGonzaleg 
 *    26-12-2002
 ******************************************************************************/
 

#ifdef _Bibliotecas_
#define acceso
#else 
#define acceso extern
#endif

#define STR_SHORT 32
#define STR_LONG  256
#define STR_HUGE  8192   
#define PYME            "PYME" 
#define INDIVIDUAL      "INDIVIDUAL" 
#define CINCUENTA_MILLONES      50000000       /* Condicion de corte del rut */
#define MAXFETCH                500
#define NOTECNOLOGIA            "NOTECNO"

/*---------------------------------------------------------------------------*/
/* CONSTANTES DE ESPECIFICACION DE TIPO DE CALCULO DE CONCEPTOS              */
/*---------------------------------------------------------------------------*/
#define TIPCALDIRECTO	"D"
#define TIPCALVOLUMEN	"V"
#define TIPCALMETA		"M"
/*---------------------------------------------------------------------------*/
/* CONSTANTES DE ESPECIFICACION DE TIPO DE CICLO EN EJECUCION                */
/*---------------------------------------------------------------------------*/
#define	PERIODICO		'P'
#define ESPORADICO		'E'
/*---------------------------------------------------------------------------*/
/* CONSTANTES DE ESPECIFICACION DE PROCEDENCIA DE EQUIPOS                    */
/*---------------------------------------------------------------------------*/
#define	PROCEQ_INTERNA		"I"
#define PROCEQ_EXTERNA		"E"
#define PROCEQ_TODAS		"T"
/*---------------------------------------------------------------------------*/
/* VARIABLE GLOBAL PARA LA ESPECIFICACION DEL TIPO DE PERIODO.               */
/*---------------------------------------------------------------------------*/
#define TIPPERIODO_M		"M"
#define TIPPERIODO_S		"S"
#define TIPPERIODO_Q		"Q"	    
/*---------------------------------------------------------------------------*/
/* VARIABLE GLOBAL PARA LA ESPECIFICACION DEL INDICADOR DE COMISION PARCIAL. */
/*---------------------------------------------------------------------------*/
#define INDPARCIAL_S		"S"
#define INDPARCIAL_N		"N"
/*---------------------------------------------------------------------------*/
/* VARIABLE GLOBAL PARA LA ESPECIFICACION DE */
/*---------------------------------------------------------------------------*/
#define	INDAFIRMACION		"S"
#define	INDNEGACION			"N"
/*---------------------------------------------------------------------------*/
/* Definicion de estados de ejecución extractores                            */
/*---------------------------------------------------------------------------*/
#define extIniciado    'I'       /*  Proceso iniciado                      */
#define extTermOk      'T'       /*  Proceso Terminado OK                  */
#define extTermError   'F'       /*  Proceso terminado con error ... Falla */
#define extNoIniciado  'N'       /*  Proceso NO iniciado                   */
/*---------------------------------------------------------------------------*/
/* VARIABLE GLOBAL PARA BUFFER						     */
/*---------------------------------------------------------------------------*/
#define FLUSH                   "flush_archivo"
#define MAX_BYTE_REGISTRO       1024
#define NUMREG				    100
#define MAX_BYTES_BUFFER        ( MAX_BYTE_REGISTRO + 1 ) * NUMREG
/*---------------------------------------------------------------------------*/
/* CONSTANTE DE CAMPO EN BLANCO PARA FORMATEO DE ARCHIVOS				     */
/*---------------------------------------------------------------------------*/
#define CAMPOBLANCO				"BLANCO"
#define CARACBLANCO				" "
/*---------------------------------------------------------------------------*/
/* VARIABLE GLOBAL PARA LA ESPECIFICACION DEL TIPO DE CICLO EN EJECUCION.    */
/*---------------------------------------------------------------------------*/
char	szTipoPeriodo;
/*---------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------*/
typedef struct bloque {
        char    cod_bloque[16];        /* codigo del bloque */
        long    sec_bloque;            /* secuencia del bloque */
        char    id_periodo[11];        /* identificador de periodo */
        char    ind_estado;            /* estado de la traza */
        char    nom_usuario[31];       /* nombre de usuario */
} Bloque;
acceso Bloque bloque;
/*---------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------*/
typedef struct proceso {
        char    cod_bloque[16]; 	/* codigo de bloque 							*/
        long    sec_bloque;         /* secuencia del bloque 						*/
        char    cod_proceso[16];    /* codigo de proceso 							*/
        long    sec_proceso;        /* secuencia de proceso 						*/
        char    ind_estado;         /* estado de la traza 							*/
        char    nom_usuario[31];    /* nombre de usuario 							*/
        short   cod_error;          /* codigo de error 								*/
        char    des_error[101];     /* descripcion de error 						*/
        long    num_registros;      /* numero de registros procesados 				*/
        long    num_segundos;       /* numero de segundos trascurridos de proceso 	*/
} Proceso;
acceso Proceso proceso;
/*---------------------------------------------------------------------------*/
/* Definicion de estructura para almacenar fechas del Ciclo.                 */
/*---------------------------------------------------------------------------*/ 
typedef  struct reg_ciclo
{
        long    lCodCiclComis;          
        long    lCodCiclo;
        char    szIdCiclComis[11];
        char	cTipCiclComis;
        char	szDesCiclcomis[61];
        char    szFecDesdeNormal[11];
        char    szFecHastaNormal[11];
        char    szFecDesdePrepago[11];
        char    szFecHastaPrepago[11];
        char    szFecDesdeAceptacion[11];
        char    szFecHastaAceptacion[11];
        char    szFecDesdeRecepcion[11];
        char    szFecHastaRecepcion[11];
        char    szCodEstado[4];
        char	szTipPeriodo[2];
}reg_ciclo;
reg_ciclo       stCiclo;
/*---------------------------------------------------------------------------*/
/* Definicion de estructura para almacenar argumentos externos.              */
/*---------------------------------------------------------------------------*/
typedef  struct reg_argumentos
{
   int   bFlagUser;
   int   bFlagPeriodo;
   int   bFlagProceso;
   int   bFlagBloque;
   int   bFlagSecuencia;
   int   bFlagTipCiclComis;

   char  szUser[30];
   char  szPass[30];
   char  szIdPeriodo[11];
   char  szProceso[16];
   char  szBloque[16];
   int   izSecuencia;
   char  szTipCiclComis;

}rg_argumentos;
rg_argumentos  stArgs;
/*---------------------------------------------------------------------------*/
/* Definicion de estructura para almacenar argumentos externos.              */
/* ESPECIFICA PARA EXTRACTORES                                               */
/*---------------------------------------------------------------------------*/
typedef  struct reg_argextractores
{
   int   bFlagUser;
   int   bFlagFecDesde;
   int   bFlagFecHasta;
   int   bFlagSecuencia;
   
   char  szUser[30];
   char  szPass[30];
   char  szFecDesde[9];
   char  szFecHasta[9];
   long  lNumSecuencia;
}rg_argextractores;
rg_argextractores  stArgsExt;
/*---------------------------------------------------------------------------*/
/* Definicion de estructura para datos de la direccion (EXTRACTORES).        */
/*---------------------------------------------------------------------------*/
typedef  struct REG_DIRECCION
{
	char	szDireccion[801];
	char	szCodProvincia[6];
	char	szDesProvincia[31];
	char	szCodRegion[4];
	char	szDesRegion[31];
	char	szCodCiudad[6];
	char	szDesCiudad[31];
	char	szCodFranquicia[6];
	char	szDesFranquicia[31];

}rg_direccion;
rg_direccion stDireccion;
/*---------------------------------------------------------------------------*/
/* Definicion de Estructura de Tipos de Comisionista Para VALORACION         */
/*---------------------------------------------------------------------------*/
typedef struct REG_conceptos
{
	int		iCodTipoRed;		/* Tipo de Red al que pertenece el concepto     */
	char	szCodTipComis[3];	/* Se comisiona al nivel de aplicacion dela Red */
	char	szCodPlanComis[7];	/* Plan de Comisiones, Sólo Informativo         */
	int		iCodConcepto;		/* Código del Concepto de Comisiones            */
	char	szFecDesde[11]; 	/* Fecha desde la aplicación del concepto       */
	char	szFecHasta[11]; 	/* Fecha hasta de la aplicación del concepto    */
	char	cCodTipCalculo[2];  /* Tipo de Calculo (Directo / Volumen / Meta)   */
	char	szCodTecnologia[8];	/* Tecnología sobre la que aplica el concepto.  */
	char	szCodUniverso[7];	/* Universo sobre el que aplica el concepto     */
	char	szCodForma[11];		/* Forma comisional asociada al concepto.       */
	double	dFecDesde; 			/* Fecha desde en formato numérico              */
	double	dFecHasta; 			/* Fecha hasta en formato numérico              */
    struct REG_conceptos * sgte;
}REG_conceptos;
typedef struct REG_conceptos stConceptosProc;
/*---------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------*/
typedef  struct reg_redventas
{
	int 	iCodTipoRed     ;
	long 	lCodVendedor	;
	long 	lCodVendePadre	;
	int 	iNumNivel	    ;
	struct reg_redventas * sgte;
}reg_redventas;
typedef struct reg_redventas stRedVentas;

/*---------------------------------------------------------------------------*/
/* Definicion de Estructura de Tipos de Comisionista Para SELECCION          */
/*---------------------------------------------------------------------------*/
typedef struct reg_tiposcomis
{
	int		iCodTipoRed;
	char	szDesTipoRed[31];
	char	szCodTipComis[5];
	char	szDesTipComis[31];
	char	szCodTipVendedor[5];
	char	szDesTipVendedor[31];	
    struct reg_tiposcomis * sgte;
}reg_tiposcomis;
typedef struct reg_tiposcomis stTiposComis;
/*---------------------------------------------------------------------------*/
/* Definicion de estructura para almacenar datos para archivo de log         */
/*---------------------------------------------------------------------------*/
typedef  struct reg_datos_log
{
   char szProceso[100];
   char szPath[200];
   char szSysDate[15];
   char szExtension[10];
   
}rg_datos_log;
rg_datos_log  stArgsLog;

/*---------------------------------------------------------------------------*/
/* Definicion de estructura para almacenar Archivos de Extractores */
/*---------------------------------------------------------------------------*/
typedef  struct reg_archivos_Ext
{   
   char szCodArchivo[9];
   char szNomFisico[21];
   char szCarSeparador[2];
   char szFechaCreacion[16];
   char szNomUsuario[31];
   char szIndEjecucion[2];
   char szUsuUltGeneracion[31];
   char szFecUltGeneracion[16];
   int  iNumRegistros;
   char szUbicacion[61];
   struct reg_archivos_Ext * sgte;
   struct reg_detalle_Ext  * sgte_detalle;
   
   
}reg_archivos_Ext;
typedef struct reg_archivos_Ext stArchivo;


/*---------------------------------------------------------------------------*/
/* Definicion de estructura para almacenar detalle de archivo extractores    */
/*---------------------------------------------------------------------------*/
typedef  struct reg_detalle_Ext
{   
   char szNomCampo[31];
   char szNomEtiqueta[31];
   int  iNumOrden;
   int  iLargoCampo;   
   char szIndJustificado[2];   
   char szCarRelleno[2];
   char szTipoDato[21];  
   char	szFormato[81];
   struct reg_detalle_Ext  * sgte;
}reg_detalle_Ext;
typedef struct  reg_detalle_Ext  stDetArchivo; 
/*---------------------------------------------------------------------------*/
/* FUNCIONES COMPARTIDAS EN LIBRERIA DE COMISIONES                           */
/*---------------------------------------------------------------------------*/
acceso int iModifica_Traza_Bloque();
acceso int iModifica_Traza_Proceso();
acceso int iAccesa_Traza_Procesos(char, short, char *, long, long);
acceso void vInicia_Estructura_Procesos(char *, char *, char *, int);
acceso void vSqlError();
acceso void vSqlError_EXT();
acceso short iCodError;
acceso int vCargaCiclo(char *,reg_ciclo *);
acceso void  vManejaArgs (int argc, char * const argv[]);
acceso long   lDBGetSequenceNextVal ();
acceso FILE * fAbreArchivoLog();
acceso char * szfnTrim(char *);
acceso char * szfnObtieneFecYYYYMMDD();
acceso long lfnGetIntRut(char *);
acceso char * szfnGetCategCliente(char , char *);
acceso stTiposComis * stGetTipComisSelecPer(char * , reg_ciclo );
acceso stTiposComis * stGetTipComisSelecProm(char *, reg_ciclo );
acceso stConceptosProc * stGetConceptosPer(char *, reg_ciclo );
acceso stConceptosProc * stGetConceptosProm(char *, reg_ciclo );
acceso char * szfnGetTiposComisConc(int , reg_ciclo );
acceso void vLiberaTiposComis(stTiposComis * );
acceso long lGetVendedorPadre(int ,long );
acceso long lGetVendedorRaiz(int ,long );
acceso int iGetNivelVendedor(int ,long );
acceso char * szGetTipComisRed(int );
acceso char * sysGetUserName();
acceso char * sysGetDBName();
acceso void vLiberaConceptosVal(stConceptosProc *);
acceso int iBuscaTablaFisica(char *, char * ,char *);
acceso char * szNewCiclComis(long );
acceso long lNewCiclComis(long , int );
acceso stRedVentas * stCreaRedVentas(int , long );
acceso int vMarcaSecuencia(int , char * , char, int , char *  );
acceso int vGetEstadoSecuencia(int , char * );
acceso void vCierraEnlace(char *, char *, char *);
acceso void vLiberaRedVentas(stRedVentas * );
acceso int bValidaFechaEvento(char * , char * , char * );
acceso long lObtieneVendedorPadre(long  , int , char * ); 
acceso int ifnValidaGestorRetenciones() ;
acceso stArchivo * stCargaDefArchivo(char * pszUniverso);
acceso void bGeneraArchivoExtractores(FILE **,char * ,char * ,char * ,char * ,char * ); 
acceso int bEscribeEnArchivo(FILE *, char * , char * );
acceso void  vManejaArgsExt (int argc, char * const argv[]);
acceso char * szfnGetFormatoCampo(int , char *, char *, char * );
acceso int ifnActualizaTrazasExtractores(int , char * , int , char * , int );
acceso int ifnActualizaTrazasArchivos(char * , char * ,int , char * , int , char * );
acceso void vMuestraDetArchivo(stDetArchivo * );
acceso void vMuestraArchivo(stArchivo * );
acceso char *szRescataFormatoCampo(stDetArchivo  *);
acceso char *szFormatEtiqueta(stDetArchivo  *);
acceso int ifnCargaDireccion(long , int , rg_direccion * );
#undef acceso


static char szRaya[] = "----------------------------------------------------------------";


static char szUso[] =
  "\nUso: "
  "<PROGRAMA> -uUser/Pass -pPeriodo[<YYYYMM><A><1>] -cProceso -bBloque -sSecuencia -tTipoPeriodo[P|E]";
static char szUsoExt[] =
  "\nUso: "
  "<PROGRAMA> -uUser/Pass -sSecuencia -dDesde[<YYYYMMDD>] -hHasta[<YYYYMMDD>]";
#define LOG                "log"
#define DAT                "txt"
#define LST                "lst"
#define ARCH_LOG            1
#define ARCH_DAT            2
#define ARCH_LST            3
/*---------------------------------------------------------------------------*/
/* Acciones de la traza de extractores */
/*---------------------------------------------------------------------------*/
#define iCREATRAZA			1
#define iCIERRATRAZAOK		2
#define iCIERRATRAZAERROR	3

/*---------------------------------------------------------------------------*/
#define EXIT_0              0      /* TERMINO DE PROCESO SIN ERROR */ 

#define EXIT_100          100      /* ERROR EN PARAMETROS DE PROCESO */ 
#define EXIT_101          101      /* ERROR EN PARAMETRO DE CODIGO DE PERIODO */ 
#define EXIT_102          102      /* ERROR EN PARAMETRO DE SALIDA DE PROCESO */ 
#define EXIT_103          103      /* ERROR EN PARAMETRO DE TRAZAS */
#define EXIT_104          104      /* ERROR EN PARAMETRO DE USUARIO/PASSWORD */
#define EXIT_105          105      /* ERROR EN PARAMETRO DE CODIGO DE PROCESO */
#define EXIT_106          106      /* ERROR EN PARAMETRO DE CODIGO DE BLOQUE */
#define EXIT_107          107      /* ERROR EN PARAMETRO DE SECUENCIA DE BLOQUE */

#define EXIT_110          110      /* ERROR EN OBTENCION DE PARAMETROS DE DECIMALES */
#define EXIT_111          111      /* ERROR */

 
#define EXIT_200          200      /* ERROR ORACLE */ 
#define EXIT_201          201      /* ERROR AL SELECCIONAR DATOS DESDE SISCEL */ 
#define EXIT_202          202      /* ERROR AL GRABAR DATOS EN SISCEL */ 
#define EXIT_203          203      /* ERROR AL MODIFICAR DATOS EN SISCEL */ 
#define EXIT_204          204      /* ERROR AL ELIMINAR DATOS DESDE SISCEL */ 
#define EXIT_205          205      /* ERROR AL CONECTARSE A ORACLE */ 
#define EXIT_206          206      /* ERROR AL ABRIR CURSOR DE DATOS */ 
#define EXIT_207          207      /* ERROR AL DECLARAR CURSOR DE DATOS */


#define EXIT_300          300      /* ERROR EN MANEJO DE ARCHIVOS */ 
#define EXIT_301          301      /* ERROR AL ABRIR ARCHIVO */ 
#define EXIT_302          302      /* ERROR AL INTENTAR ESCRIBIR SOBRE ARCHIVO */ 
#define EXIT_303          303      /* ERROR AL CERRAR ARCHIVO */ 

#define EXIT_400          400      /* ERRORES GENERALES */ 
#define EXIT_401          401      /* ERROR AL RECUPERAR VARIABLE DE AMBIENTE */ 

#define EXIT__500  -500 /* Error de Proceso (ORACLE-S.OPERATIVO-NETWORK) Generico */
#define EXIT__501  -501 /* Error insertando sobre trazas de procesos */
#define EXIT__502  -502 /* Error actualizando sobre trazas de procesos */
#define EXIT__503  -503 /* Error recuperando secuencia de bloques */
#define EXIT__504  -504 /* Error insertando sobre trazas de bloques */
#define EXIT__505  -505 /* Error actualizando sobre trazas de bloques */
#define EXIT__506  -506 /* Fallo de comunicaciones (*) */
#define EXIT__507  -507 /* No tiene privilegios para insertar traza de bloques */
#define EXIT__508  -508 /* No tiene privilegios para actualizar traza de bloques */
#define EXIT__509  -509 /* No tiene privilegios para consultar traza de bloques */
#define EXIT__510  -510 /* No tiene privilegios para insertar traza de procesos */
#define EXIT__511  -511 /* No tiene privilegios para actualizar traza de procesos */
#define EXIT__512  -512 /* No tiene privilegios para consultar traza de procesos */
#define EXIT__513  -513 /* No encontro trazas de bloques */
#define EXIT__514  -514 /* No encontro trazas de procesos */
#define EXIT__515  -515 /* Secuencia de bloques duplicada */
#define EXIT__516  -516 /* Secuencia de procesos duplicada */

#define EXIT_500    500 /* Error de validacisn genirico */
#define EXIT_501    501 /* Bloque en ejecucisn */
#define EXIT_502    502 /* Proceso en ejecucisn */
#define EXIT_503    503 /* Glosa de error demasiado grande */
#define EXIT_504    504 /* Codigo de proceso no existe */
#define EXIT_505    505 /* Codigo de bloque no existe */
#define EXIT_506    506 /* Bloque ya se encuentra terminado ok. */
#define EXIT_507    507 /* Bloque anterior no ejecutado */
#define EXIT_508    508 /* Bloque anterior en ejecucion */
#define EXIT_509    509 /* Bloque anterior terminado con error */
#define EXIT_510    510 /* Proceso ya se encuentra terminado ok. */
#define EXIT_511    511 /* Proceso anterior en ejcucion */
#define EXIT_512    512 /* Proceso anterior terminado con error */
#define EXIT_513    513 /* Proceso anterior no ejecutado */
#define EXIT_514    514 /* Periodo no se encontro */
#define EXIT_515    515 /* Periodo esta cerrado */
#define EXIT_516    516 /* Periodo esta con estado diferente al que se esperaba */
#define EXIT_517    517 /* Estado no valido para procesar */
#define EXIT_518    518 /* Bloque ya se encuentra terminado con error */
#define EXIT_519    519 /* Bloque no esta en ejecucion */
#define EXIT_520    520 /* Proceso no esta en ejecucion */

#define SQLOK          0
#define SQLNOTFOUND    100


/****************************************************************************
   Estados de Traza de Procesos.
 ****************************************************************************/

#define ABRIR_TRAZA        		'I'  /* se abre traza de procesos */
#define CERRAR_TRAZA_OK         'T'  /* se cierra traza ok */
#define CERRAR_TRAZA_NOK        'F'  /* se cierra traza con fracaso */

#define TRUE            1
#define FALSE           0

/*****************************************************************************/
/*                                      Declaracion de funciones             */ 
/*****************************************************************************/
#undef access
/******************* Declaracion de Prototipos ******************/
#define access  




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

