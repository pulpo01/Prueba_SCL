/*=============================================================================
   Nombre      : Traductor.h
   Programa    : Libreria del proceso Traductor.pc
  ============================================================================= */
#define  SQLERRM          sqlca.sqlerrm.sqlerrmc

/*#define szVERSION         "v.2.0.0"	    * MIX-09003 16.02.2010  MQG*/
#define szVERSION         "v.2.0.1"	    /* Incidencia 129515 - 09.04.2010  MQG*/

#define   MAX_ENT     100
#define   MAX_CAM     1000
#define   LARGOREG    1020
#define   CAMPO1      1
#define   CAMPO2      2
#define   CAMPO3      3
#define   CAMPO4      4  
#define   CAMPO5      5  
#define   CAMPO6      6 
#define   CAMPO7      7 
#define   CAMPO8      8 
#define   CAMPO9      9
#define   CAMPO10     10
#define   CAMPO11     11
#define   CAMPO12     12 
#define   CAMPO13     13
#define   CAMPO14     14
#define   CAMPO15     15
#define   CAMPO16     16
#define   CAMPO17     17 
#define   CAMPO18     18 
#define   CAMPO19     19 /* MIX-09003 16.02.2010  MQG*/
#define   CAMPO20     20 /* MIX-09003 16.02.2010  MQG*/

#define   FEC_EFE     500
#define   COD_CLI     501
#define   NUM_CEL     502
#define   IMP_PAG     503
#define   RUT_CLI     504
#define   COD_BAN     505
#define   REVERSA     506

#define   REGISTRO_11   "11"
#define   REGISTRO_22   "22"
#define   REGISTRO_88   "88"
#define   NULO          "NULO"
#define   INS_PAGO      "P"
#define   INS_REVERSA   "R" 
#define   CAMPO_PAGO    "2"
#define   CAMPO_REVERSA "1" 
#define   INICIO_ENTIDAD 3
#define   LARGO_ENTIDAD  15

typedef struct traductor_teca
{
  char szUsuario       [31];
  char szPassWord      [31];
  int  iNivelLog           ;
  char szFile        [1024];
  char szEmpresa       [16];
  BOOL bOptUsuario         ; 
  BOOL bOptPassWord        ;
  BOOL bOptNivelLog        ;
  BOOL bOptFile            ; 
  BOOL bOptEmpresa        ; 
}TRADUCTOR;

typedef struct stPAGOS
{
  char szCliente[12+1];
  char szImporte[14+1];
  int iPos;
}PAGOS;

int ifnInicio ( TRADUCTOR *stTraductor, STATUS *pstStatus );
int ifnAbreArchivosLog();
int ifnCarga_Interfaz_Pago();
int ifnValidaEmpresaProcesar();
int ifnValidaArchivoProcesado();
int ifnOpenFileDat ();
int ifnCargaEntidad();
int ifnCargaRegistros();
int ifnCargaCampos();
int ifnDatos_Interfaz();
int ifnExitTraductor (void);
int ifnCarga_RegCampos();
int ifnCargaGlosa_Defecto(int iCampo);
int ifnReadFileDat ();
int ifnValida_Fecha(char *szFecha, char *szFormato, int iInd_Fecha);
int ifnValida_Cliente( long lCod_cliente);
int ifnValida_NumCelular( long lNum_celular );
int ifnValida_RutCliente( char *szNum_ident, long lCod_cliente);
int ifnValida_Cod_Banco( char *szCod_banco);
int ifnInserta_InterfazPagos();
int ifnAbreArchivosLog();
int ifnCarga_RegAnomalias(char *szReg_Leido, long lCon_Rech);
int ifnGrabaArchivoProcesado();
int RighTrim (char *szVar);
void vfnMemset_Var();
BOOL bfnIsFileNorma43();
BOOL bfnEntidadNorma43();
BOOL bfnValidaEntidad();
BOOL bfnIsValidFormat();
BOOL bfnValidaClaveBanco();
BOOL fnValidaReversa( FILE*, PAGOS*, int, int );
char* fnParser( char*, int, BOOL );
void *SubStr();
void mid(char*, int, int, char*);
int  LeftTrim (char *szVar);

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

