/* ********************************************************************** */
/* *  Fichero : infctlpreciclo.h                                        * */
/* *  Autor : Mauricio Villagra                                         * */
/* *  Comentarios :                                                     * */
/* *  14-08-2000:   Informe de Pre-Facturación de Ciclo/Periodo         * */
/* *                                                                    * */
/* ********************************************************************** */

#ifndef _INFCTLPRECICLO_H_
    #define _INFCTLPRECICLO_H_
    #include <memory.h>  
    #include <GenFA.h>
    #include <rutinasgen.h>
    #include <trazafact.h>
#endif /* _INFCTLPRECICLO_H_ */



/************************************************************************/
/*  Nivel de Log por Default                                            */
/************************************************************************/

#define     iLOGNIVEL_DEF                   3
#define     COD_INFORME_FAD_CTL_PRE_CICLO   3
#define     COD_INFORME_FAD_CTL_PST_CICLO   5



/************************************************************************/
/*  Estados de Informes                                                 */
/************************************************************************/

#define     COD_INFORME_CONTROL_ACTIVO      1
#define     COD_INFORME_CONTROL_INACTIVO    0

/************************************************************************/
/*  Indicadores de Actuacion de Abonados                                */
/************************************************************************/
#define     IND_SUPERTELEFONO_ACTIVO        1
#define     IND_ASIGNADO_ACTIVO             0
#define     IND_CUENTACONTROLADA_ACTIVO     1
#define     IND_CAMBIOCICLO_ACTIVO          1

#define     IND_ACTUAC_NORMAL               1
#define     IND_ACTUAC_BAJA                 2
#define     IND_ACTUAC_TRASPASO             3
#define     IND_ACTUAC_LIQUIDACION          4
#define     IND_ACTUAC_RECHAZO              5
#define     IND_ACTUAC_ANULACION_BAJA       6


#define     IND_BLOQUEO_NORMAL              0
#define     IND_BLOQUEADO                   1
#define     IND_DESBLOQUEADO                2
#define     IND_BLOQUEADO_FACTURADO         3

/************************************************************************/
/*  Tipos de Clientes                                                   */
/************************************************************************/
#define     COD_TIPCLIENTE_INDIVIDUAL       "I" 
#define     COD_TIPCLIENTE_EMPRESA          "E" 
#define     COD_TIPCLIENTE_FAMILIAR         "F" 

/************************************************************************/
/*  Clasificacion de Clientes                                           */
/************************************************************************/
#define     COD_CLASSCLIENTE_INDIVIDUAL         1 
#define     COD_CLASSCLIENTE_EMPRESA            2 
#define     COD_CLASSCLIENTE_FAMILIAR           3 
#define     COD_CLASSCLIENTE_STB                4     
#define     COD_CLASSCLIENTE_ASIGNADO           5     


/************************************************************************/
/*  Clasificacion de Abonados                                           */
/************************************************************************/
#define     COD_CLASSABONADO_ANTIGUOS           1 
#define     COD_CLASSABONADO_NUEVOS             2
#define     COD_CLASSABONADO_BAJAS              3
#define     COD_CLASSABONADO_BLOQUEADOS         4
#define     COD_CLASSABONADO_CTA_CONT           5
#define     COD_CLASSABONADO_CAMBIO_CICLO       6
#define     COD_CLASSABONADO_TRASPASO           7
#define     COD_CLASSABONADO_BAJAS_ANTIGUA      8
#define     COD_CLASSABONADO_ANULACION_BAJA     9
#define     COD_CLASSABONADO_TRASPASO_ANTIGUO  10
#define     COD_CLASSABONADO_LIQUIDACION       11
#define     COD_CLASSABONADO_RECHAZO           12


/************************************************************************/
/*  Indicadores de Estados de Facturacion de Abonados                   */
/************************************************************************/
#define     IND_ESTADO_FACTURACION_ABONADO_NO     0
#define     IND_ESTADO_FACTURACION_ABONADO_SI     1 

/************************************************************************/
/*  VALORES MAXIMOS DE ESTRUCTURAS DE MEMORIA                           */
/************************************************************************/

#define     MAX_INTERFAZ_CONTROL_FETCH    1000
#define     MAX_STATISTIC_CONTROL          100
#define     MAX_REGPLAN_FAMILIAR          1000	/* CH-021020031369 : Aumento de 100 a 1000 registros */
#define     MAX_REG_CARGOBASICO           3000
#define     MAX_CARGOS_VARIOS_FETCH       1000
#define     MAX_CARGOS_TRAFICO_FETCH      1000
#define     MAX_CARGOS_SERVSUPL_FETCH     1000


/*********************************************
Estructura para recoger los datos por
la linea de comandos.     
**********************************************/
typedef struct PosConcFacLineaComando
{ 
    char    szUser   [50]   ;
    char    szPass   [50]   ;
    char    szDirLogs[256]  ;
    int     iCodCiclFact    ;
    int     iCodCiclo       ;
    int     iIndFacturacion ;
    char    szFecEmision[15];
    char    szFecDesdeCFijos[15];
    char    szFecHastaCFijos[15];
    int     iNivLog         ;
    BOOL    bTrazas         ; 
    int     iTipoTasacion  ; /* SAAM-20030106 */    
}PCF_LINEACOMANDO;


/*************************************************************
Estructura para Guardar Informacion de Un Documento 
**************************************************************/
typedef struct stInterfazAbonados
{ 
    char    szRowId         [19];
    long    lCodCliente         ;   
    long    lNumAbonado         ;
    int     iCodProducto        ;
    int     iIndCambio          ;
    int     iCodCiclFact        ;
    char    szFecAlta       [15];
    char    szFecBaja       [15];
    int     iIndActuac          ;
    int     iIndSupertel        ;
    int     iIndFactur          ;
    int     iIndBloqueo         ;
    int     iIndEstado          ;
    int     iCtaControlada      ;
    long    lCodEmpresa         ;
    char    szTipClie        [2];
    char    szCodPlanTarif   [4];
    char    szCodCargoBasico [4];
    int     iCodClassCliente    ;
    int     iCodClassAbonado    ;
}INTERFAZABONADOS;



/***********************************************
Estructura de Estadisticas a Nivel de Concepto
************************************************/
typedef struct stEstatInterAbon
{   
    int     iCodProducto    ;
    int     iCodCiclFact    ;
    int     iCodClassCliente;
    int     iCodClassAbonado;
    int     iNumAbonados    ;
}STATCTLINTERABO;

/***************************************************************************
Estructura para Guardar Informacion de Estadisticas de Conceptos
***************************************************************************/
typedef struct stStatConceptos
{ 
    int             iNumStadisticas;
    STATCTLINTERABO stUnivStatInterAbo [MAX_STATISTIC_CONTROL];
}FACTLINTERABO;



/***************************************************
Estructura de Estadisticas a Nivel de Cargo Basico 
****************************************************/
typedef struct stEstaCargoBasicoAbo
{   
    int     iCodProducto        ;
    char    szCodCargoBasico [4];
    int     iNumCargosBasicos   ;
    int     iNumAbonados        ;
}STATCTLCARGOBAS;


/***************************************************************************
Estructura para Guardar Informacion de Estadisticas de Conceptos
***************************************************************************/
typedef struct stStatCargoBas
{ 
    int            iNumStadisticas;
    STATCTLCARGOBAS stUnivStatCBas[MAX_REG_CARGOBASICO];
}FACTLCARGOBASICO;


/***************************************************
Estructura de TA_CARGOSBASICO
****************************************************/
typedef struct stTACARGOBASICO
{   
    int     iCodProducto        ;
    char    szCodCargoBasico [4];
    double  dImpCarboBasico     ;
    char    szCodMoneda      [4];
}STATTACARGOSBASICO;


/***************************************************************************
Estructura para Guardar Informacion de Estadisticas de Conceptos
***************************************************************************/
typedef struct stStatTaCargoBasicos
{ 
    int                 iNumStadisticas;
    STATTACARGOSBASICO  stCBasico[MAX_REG_CARGOBASICO];
}TACARGOSBASICO;

typedef struct stCodigosCargosBasicos
{
    long lCodAbonoCel;
    long lCodAbonoBeep;
}TACODIGOSCBASICOS;    
/************************************************************************/
/*   Definiendo Variables y Estructuras Globales                        */
/************************************************************************/

PCF_LINEACOMANDO        stLineaComando          ;
INTERFAZABONADOS        stCtlInterAbo           ;
FACTLINTERABO           stStatInterAbon         ;
FACTLCARGOBASICO        stStatCargoBasico       ;
TACARGOSBASICO          stTaCargosBasico        ;
TACODIGOSCBASICOS       stCodCargosBasicos      ;

char                    szExeInfCtlPreCiclo[1024];

char                    szCodPlanTarifFamiliar[MAX_REGPLAN_FAMILIAR][4];

int                     iNumRegPlanFamiliar     ;

char                    szCodInformeGenerar  [7];

long                    lhNumSecuenciaInforme   ;

double                  dValorCTLDolar          ;
double                  dValorCTLUF             ;




#undef access

#ifdef _INFCTLPRECICLO_PC_
    #define access
access  BOOL    bMainReporte                ( void );
access  BOOL    bfnCargaCargosBasicos       ( void );
access  BOOL    bfnCargaInterfazClientes    ( void );
access  BOOL    bfnCargaMonedas             ( void );
access  BOOL    bfnCargaPlanFamiliar        ( void );
access  BOOL    bfnCargaStatCargosBasicos   ( void );
access  BOOL    bfnClassAbonado             ( void );
access  BOOL    bfnClassCliente             ( void );
access  BOOL    bfnEstadoProcCiclo          ( void );
access  BOOL    bfnGetSecuInfo              ( void );
access  BOOL    bfnInsertHeaderInfCtl       ( void );
access  BOOL    bfnInsertStatCartera        ( void );
access  BOOL    bfnStatCargosAbon           ( void );
access  BOOL    bfnStatCargosBasicos        ( void );
access  BOOL    bfnStatCargosServSupl       ( void );
access  BOOL    bfnStatCargosTrafico        ( void );
access  BOOL    bfnStatCargosVarios         ( void );
access  BOOL    bfnStatInterAbo             ( void );
access  BOOL    bfnStatInterfazPreCiclo     ( void );
access  BOOL    bfnUpdateInterAbo   		( void );
access  BOOL    bfnValPlanTarif             ( void );
access  BOOL    bfnValTipClie               ( void );
access  double  dfnValorCBasico             (char *szCBas,int iCodProducto);
access  void    vPrintStAbonados            ( void );
access  void    vPrintStCartera             ( void );
access  void    vPrintStCBasicos            ( void );
access  BOOL    bCargaCodCBasicos           ( void );

#else
    #define access extern
#endif
/****************************************************************************/
/*                  Definicion de Funciones Prototipos                      */
/****************************************************************************/


#undef access
#undef _INFCTLPRECICLO_PC_


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
