#ifndef _ImpSclSt_
#define _ImpSclSt_

/*  Version  FAC_DES_MAS ImpSclSt.h  7.000  */
#include <errores.h>
#include <GenFA.h>
#include <geora.h>
#include <malloc.h>
#include <memory.h>
#include <ORAcarga.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/timeb.h>

#include <ImpSclMemShared.h>

#define TAM_HOSTS_PEQ_JEM 5000

#define iBALANCE_ANTERIOR 1
#define iPAGOS_RECIBIDOS  2
#define iPAGOS_REVERTIDOS 3
#define iAJUSTE_CREDITO   4
#define iMISCELANEA       5
#define iCARGOS_MES       6
#define iTOTAL_FACTURA    7
#define iTOTAL_PAGAR      8

#define MAX_BYTE_A1000 650 /* P-MIX-09003 141767 */
#define MAX_BYTE_A1010 300
#define MAX_BYTE_A1100 150
#define MAX_BYTE_A1120 300 
#define MAX_BYTE_A1130 300
#define MAX_BYTE_A1150 153
#define MAX_BYTE_A1200 150
#define MAX_BYTE_A1250 300
#define MAX_BYTE_A1300 200
#define MAX_BYTE_A1400 665
#define MAX_BYTE_A1410 300
#define MAX_BYTE_A1420 300
#define MAX_BYTE_A1430 300
#define MAX_BYTE_A1500 300
#define MAX_BYTE_A1700 350
#define MAX_BYTE_A1800 150
#define MAX_BYTE_A1900 400
#define MAX_BYTE_A2000 100
#define MAX_BYTE_A2100 50
#define MAX_BYTE_A2200 50
#define MAX_BYTE_A2300 300
#define MAX_BYTE_A2400 500
#define MAX_BYTE_A2500 500
#define MAX_BYTE_A2600 500
#define MAX_BYTE_A2700 500

#define szCODINFORME_GENERAR    "IMPRES"
#define szCODPLANTARIFARIO_NULL "   "

#define szPROC_EST_ERR          "SUB PROCESO TERMINO CON ERROR"
#define szPROC_EST_OK           "SUB PROCESO TERMINO OK"

#define szVersionActual         "7.000"
#define szUltimaModificacion    "15-MAY-2009"

#define szCONCEP_FACTURABLE     "FA"
#define szCONCEP_NO_FACTURABLE  "NF"

#define iCONCEP_FACTURABLE      1
#define iCONCEP_NO_FACTURABLE   0

#define NUMERO_NORMAL           "HMNPP"
#define NUMERO_REDUCIDO         "HMOPP"
#define NUMERO_ROAMING          "VINPP"
#define NUMERO_FRECUENTE        "HMNPPR"

#define SEPARADOR_01            59
#define SEPARADOR_02            58
#define CUOTA_VENCIDA           1
#define CUOTA_PORVENCER         2

#define NO_FACTURABLE           99999
#define COD_GRUPO_CUOTA         18
#define COD_GRUPO_SALDANT       101

/******************************/
/* FORMATO DE IMPRESION REG A */
/******************************/
#define REG_1000        "A1000%08.8ld%1.1d%05.5d%015.15ld%-12.12s%-6.6s%-8.8s%-8.8s%-8.8s%-8.8s%-1.1s%-5.5s%-3.3s%-30.30s%012.12ld%-25.25s%-5.5s%-40.40s%-40.40s%-10.10s%015.4f%-1.1s%-8.8s%05.5ld%-8.8s%-5.5s%-70.70s%-2.2s%-20.20s%-20.20s%-40.40s%-25.25s%-10.10s%-10.10s%-10.10s%09.9ld%09.9ld%-30.30s%-30.30s%-30.30s\n\0"
#define REG_1010        "A1010%08.8ld%1.1d%-5.5s%-50.50s%-20.20s%-3.3s%-40.40s%06.6ld%-40.40s\n\0"
#define REG_1100        "A1100%015.4f%015.4f%015.4f%015.4f%015.4f%015.4f%015.4f%015.4f\n"
#define REG_1130        "A1130%-5.5s%-3.3s%5.5d%-25.25s%15.15ld%-8.8s%015.4f%-25.25s%15.15ld%-25.25s%-10.10s%5.5d%-10.10s%-15.15ld\n\0"
#define REG_1200        "A1200%015.4f%015.4f%015.4f%015.4f%1.1d%015.4f%015.4f%015.4f%015.4f\n\0"
#define REG_1300        "A1300%-20.20s%-90.90s%-15.15s%010.10d%-10.10s%-20.20s\n\0"
#define REG_1400        "A1400%-660.660s\n\0"
#define REG_1410        "A1410%-250.250s\n\0"
#define REG_1420        "A1420%-250.250s\n\0"
#define REG_1430        "A1430%-250.250s\n\0"
#define REG_1500        "A1500%-250.250s%-10.10s%-10.10s\n\0"
#define REG_INI1700     "A1700\0"
#define REG_1700        "%06.6d%08.8ld%08.8ld%08.8ld%015.4f\0"
#define REG_FIN1700     "%8.8ld%08.8ld%015.4f\n\0"
#define REG_1800        "A1800%1.1d%05.5d%-50.50s%015.4f%-12.12s%015.4f%015.4f%015.4f%1.1d%-5.5s%-5.5s\n"
#define REG_1710        "%sA1710%06.6ld%015.4f\n"
#define REG_1900        "A1900%010.10d%-50.50s%015.4f%-12.12s%07.7d%06.6ld%06.6ld%06.6ld%015.4f%015.4f%-12.12s%-12.12s%015.4f%-100.100s%015.4f%015.4f%015.4f%015.4f%015.4f%-15.15s\n"
#define REG_1890        "A1890%1.1d%05.5d%-50.50s%1.1d%-5.5s%-5.5s\n"
#define REG_1999        "A1999\n"
#define REG_2000        "%8.8d%02.2d%03.3d%5.5s\0"
#define REG_INI2000     "A2000\0"
#define REG_2100        "A2100%015.4f%-12.12s\n\0"
#define REG_2200        "A2200%015.4f\n\0"
#define REG_2300        "A2300%-200.200s\n\0"
#define REG_2400        "A2400%-150.150s%-70.70s%-20.20s%-30.30s%-30.30s\n\0"
#define REG_2400_Ingles "A2400%-300.300s\n\0"
#define REG_2600        "A2600%10.10d%-50.50s%-25.25s%20.20ld\n\0"
#define REG_2500        "A2500%010d%-50.50s%015.4f%012ld%07.7d%06ld%06ld%06ld%015.4f%015.4f%012ld%012ld%015.4f%-100.100s%015.4f%015.4f%015.4f%015.4f%015.4f\n"
#define REG_2700        "A2700%010d%-50.50s%015.4f%012ld%07.7d%06ld%06ld%06ld%015.4f%015.4f%012ld%012ld%015.4f%-100.100s%015.4f%015.4f%015.4f%015.4f%015.4f\n"

/******************************/
/* FORMATO DE IMPRESION REG B */
/******************************/
#define REG_B1000       "B1000%8.8ld%-20.20s%-20.20s%-20.20s%-20.20s%-15.15s%-15.15s%-15.15s%-15.15s%-30.30s%-30.30s%-30.30s%-30.30s%-15.15s%-1.1s%-1.1s%-1.1s%-20.20s%1.1d%-5.5s\n"
#define REG_B1100       "B1100%-8.8s%015.4f%015.4f%015.4f%015.4f%015.4f\n"
#define REG_B1200       "B1200%-5.5s%-30.30s%15.15s%10.10ld%15.15s%15.15s%15.15s%-8.8s%-8.8s%015.4f%-5.5s\n"
#define REG_B1300       "B1300%010.10ld%015.4f%015.4f%015.4f%015.4f%015.4f%015.4f%015.4f%015.4f\n"
#define REG_B2000       "B2000%05.5d%-50.50s%1.1s%012.12ld%1.1d%-5.5s%-5.5s\n"
#define REG_B3000       "B3000%05.5d%05.5d%-50.50s\n"
#define REG_B4001       "B4001%5.5d%5.5d%10.10d%-50.50s%015.4f%-12.12s%015.4f%-3.3s%-3.3s%-30.30s%6.6ld%015.4f%-15.15s%-15.15s%-15.15s%-15.15s%015.4f%015.4f%015.4f%015.4f%015.4f%015.4f\n"
#define REG_B4002       "B4002%5.5d%5.5d%10.10d%-50.50s%015.4f%015.4f%015.4f%015.4f%015.4f%015.4f%015.4f%015.4f\n" 
#define REG_B4003       "B4003%5.5d%5.5d%10.10d%-50.50s%015.4f%-12.12s%015.4f%-12.12s%-12.12s%015.4f%015.4f%6.6ld%6.6ld%6.6ld%015.4f%015.4f%015.4f%015.4f%015.4f%6.6ld%015.4f\n"
#define REG_B4004       "B4004%5.5d%5.5d%10.10d%-50.50s%015.4f%7.7d%015.4f%015.4f%015.4f%015.4f%015.4f%015.4f%015.4f\n"
#define REG_B4005       "B4005%5.5d%5.5d%10.10d%-50.50s%015.4f%-8.8s%9.9d%015.4f%015.4f%015.4f%015.4f%015.4f%015.4f%015.4f\n"
#define REG_B4006       "B4006%5.5d%5.5d%10.10d%-50.50s%015.4f%-50.50s%9.9ld%-8.8s%015.4f%015.4f%015.4f%015.4f%015.4f\n"
#define REG_B4007       "B4007%5.5d%5.5d%10.10d%-50.50s%015.4f%1s%-50.50s%3.3d%3.3d%-25.25s%9.9ld%-8.8s%015.4f%015.4f%015.4f%015.4f%015.4f%015.4f%015.4f%015.4f\n"
#define REG_B4008       "B4008%5.5d%5.5d%10.10d%-50.50s%-9.9d%015.4f%015.4f\n"
#define REG_B5000       "B5000%-5.5s%-5.5s%-30.30s%04d%04d%04d%04d%015.4f%-30.30s%19.19s%015.4f%-5.5s%1.1s%-5.5s\n"

#define GLS_PROCFINOK                       "Proceso Terminado OK"
#define GLS_PROCFINNOOK                     "Proceso Terminado NO OK"
#define COD_TIP_IMPRE                       1
#define COD_INFORME                         "IMPRES"
#define MAX_TRAZAPROC                       1000
#define COD_INTERFACT                       330
/*CMD inc. 182006   (INC 1-1 187599 JHJ)-- se agranda "MAX_GRUPOS" de 5000 a 20000*/
/*#define MAX_GRUPOS                          5000*/
#define MAX_GRUPOS                          20000
#define MAX_LARGOGRUPO                      50
#define PIE_TIPOLLAMADA                     "D2222"
#define PIE_ABONADO                         "D1111"
#define BUFF_ABONADO                        40000
#define BUFF_CLIENTE                        5000
#define COD_INFORME_CONTROL_ACTIVO          1
#define COD_INFORME_CONTROL_INACTIVO        0
#define COD_SERVICIO                        3
#define iLOGNIVEL_DEF                       3

#define MAX_CONCEPTOS_LOCAL_HOST            15000
#define MAX_CONCEPTOS_LOCAL                 60000
/* #define MAX_CUOTAS_LOCAL                    5000 *//* Se cambia de 1000 a 5000 Incidencia 211747 PPQL*/
#define MAX_CUOTAS_LOCAL                    20000 /* Se cambia de 5000 A 2000 Incidencia 212289 PGG */
#define MAX_LINEAS_MENSAJES                 50
#define MAX_SALDOS                          5000
#define NUMREG                              150
#define OK                                  TRUE
#define SQLOK                               0
#define FLUSH                               "flush_archivo"
#define MAX_BYTES_REGISTRO                  300
#define MAX_BYTES_BUFFER_IMP                ( MAX_BYTES_REGISTRO + 1 ) * NUMREG
#define MAX_ARRASTRE_ESTRUCTURA             60000
#define MAX_ARRASTRE_CURSOR                 30000

#define COD_INFORME_CONTROL_ACTIVO          1
#define COD_INFORME_CONTROL_INACTIVO        0

#define CARGOS_BASICOS                      1
#define CARGOS_VARIOS                       2
#define TRAFICO                             3
#define ARRIENDO_VENTA                      4
#define COBRANZA                            5
#define SALDO_ANTERIOR                      6
#define CUOTAS_PAGARES                      7
#define IMPUESTOS                           8
#define NO_EXISTE_PLAN                      "                              "

#define iIND_IMPRIME_TRAFICO_SI             1
#define iIND_TABLA_CARRIER                  4
#define iIND_TABLA_INTERZONA_ESPECIAL       2

#define DIREC_NOCICLO_NPROC                 67
#define MONTO_ESCRITO_PREFIJO               106
#define MONTO_ESCRITO_POSFIJO               107
#define MONTO_ESCRITO_MONEDA                108

#define iTIPLLAMADAS_LOCALES                1
#define iTIPLLAMADAS_INTERZONA              2
#define iTIPLLAMADAS_ESPECIALES             3
#define iTIPLLAMADAS_CARRIER                4
#define iTIPLLAMADAS_ROAMING                5
#define iTIPLLAMADAS_LDI                    6
#define iTIPLLAMADAS_ESPECIALES_DATA        7
#define iTIPLLAMADAS_TARIFA_ADICIONAL       8

#define iDIRECCION_FACTURACION              0
#define iDIRECCION_OPERADORA                1
#define iDIRECCION_PLAZA                    2
#define iDIRECCION_CORRESPONDENCIA          3
#define iDIRECCION_SUCURSAL                 4

#define iTIPO_CONCEPTO_CARRIER              4

#define COD_ABONADO                         "D1000"
#define COD_TIPOLLAMADA                     "D2000"
#define COD_LOCALES                         "D3001"
#define COD_INTERZONA                       "D3002"
#define COD_ESPECIALES                      "D3003"
#define COD_CARRIERS                        "D3004"
#define COD_ROAMING                         "D3005"
#define COD_LDI                             "D3006"
#define COD_ESPECIALES_DATA                 "D3007"
#define COD_TARIFA_ADICIONAL                "D3008"
#define COD_INTERCOMPANIA                   "D3010"
#define COD_MENSAJEPREMIMUN                 "D3011"

char    szModulo                 [50];
int     igDesde;           /* RPL 07-04-2020 */
int     iGPrimCateg                  ;
char    szformato_fecha          [22];
char    szformato_hora            [9];
char    szNumDecimal             [21];
char    szhIdiomaOper             [6];
int     iCodAbonoCel                 ;
char    szAplica_Cod_Autorizacion [2];

typedef struct TagAutorizFolio
{
    char    szCodAutorizacion  [11];
    char    szFechaVencimiento [10];
}AUTORIZ_FOLIO;

AUTORIZ_FOLIO stAutorizFolio;
char          gszCodTdir[11];

/************************************************************************/
/*  Estructura para recoger los datos por la linea de comandos.         */
/************************************************************************/

typedef struct stFa_DetLlamadas
{
    char    szSec_Empa          [30];
    char    szSec_Cdr            [6];
    char    szFecIniTasa        [16];
    char    szTieIniLlam         [7];
    char    szNumMovil1         [20];
    char    szNumMovil2         [20];
    double  dImpLocal1              ;
    double  dImpLarga2              ;
    char    szCodFranHoraSoc     [6];
    char    szCodAlm             [4];
    char    szDesMovil2       [30+1]; 
    char    szDurLocal1          [7];
    char    szDurLarga2          [7];
    char    szIndEntSal1         [6];
    double  dMto_Real               ;
    double  dMto_Dcto               ;
    int     iDur_Real               ;
    int     iDur_Dcto               ;
    int     iCod_Carg               ;
    char    szCodFCob            [6];
    double  dValorUndad             ;
    char    szCodTdir            [6];
    char    CodOperB             [6];
    char    szCodMarca           [7];
    char    szIndImpresion       [3];
    int     lCodConcCarrier         ;
    long    lNumPulsos              ; 
    char    szRecordType        [3] ; 
    char    szCodDcto           [6] ; 
    char    szTipDcto           [6] ; 
    double  dValorUnidad            ; 
    char    szDesLlamada     [100+1]; 
    char    szCodRegistro      [5+1]; 
}DETLLAMADAS;

typedef struct stFa_DetCelularAgrupado
{
    int         iNum_OrdenGr      ;
    int         iNum_OrdenSubGr   ;
    int         iCodGrupo         ;
    int         iCodSubGrupo      ;
    int         iCriterio         ;
    char        szCodRegistro  [6];
    int         iTipo_Llamada     ;
    DETLLAMADAS *stDetLlamadas    ;
    int         iCantLlamadas     ;
}DETCELULAR_AGRUP;


typedef struct stFa_DetCelular
{
    DETCELULAR_AGRUP *stAgrupacion;
    int              iCantEstructuras;
}DETCELULAR;


typedef struct stFa_DetLlamadas_Hosts
{
    char    szSec_Empa        [TAM_HOSTS_PEQ_JEM]   [30];
    char    szSec_Cdr         [TAM_HOSTS_PEQ_JEM]    [6];
    char    szFecIniTasa      [TAM_HOSTS_PEQ_JEM]   [16];
    char    szTieIniLlam      [TAM_HOSTS_PEQ_JEM]    [7];
    char    szNumMovil1       [TAM_HOSTS_PEQ_JEM]   [20];
    char    szNumMovil2       [TAM_HOSTS_PEQ_JEM]   [20];
    double  dImpLocal1        [TAM_HOSTS_PEQ_JEM]       ;
    double  dImpLarga2        [TAM_HOSTS_PEQ_JEM]       ;
    char    szCodFranHoraSoc  [TAM_HOSTS_PEQ_JEM]    [6];
    char    szCodAlm          [TAM_HOSTS_PEQ_JEM]    [4];                                        
    char    szDesMovil2       [TAM_HOSTS_PEQ_JEM] [30+1]; 
    char    szDurLocal1       [TAM_HOSTS_PEQ_JEM]    [7];
    char    szDurLarga2       [TAM_HOSTS_PEQ_JEM]    [7];
    char    szIndEntSal1      [TAM_HOSTS_PEQ_JEM]    [6];                                        
    double  dMto_Real         [TAM_HOSTS_PEQ_JEM]       ;
    double  dMto_Dcto         [TAM_HOSTS_PEQ_JEM]       ;
    int     iDur_Real         [TAM_HOSTS_PEQ_JEM]       ;
    int     iDur_Dcto         [TAM_HOSTS_PEQ_JEM]       ;
    int     iCod_Carg         [TAM_HOSTS_PEQ_JEM]       ;
    char    szCodFCob         [TAM_HOSTS_PEQ_JEM]    [6];
    double  dValorUndad       [TAM_HOSTS_PEQ_JEM]       ;
    char    szCodTdir         [TAM_HOSTS_PEQ_JEM]    [6];
    char    CodOperB          [TAM_HOSTS_PEQ_JEM]    [6];
    char    szCodMarca        [TAM_HOSTS_PEQ_JEM]    [7];
    char    szIndImpresion    [TAM_HOSTS_PEQ_JEM]    [3];
    long    lCodConcCarrier   [TAM_HOSTS_PEQ_JEM]       ;
    char    szCodLlam         [TAM_HOSTS_PEQ_JEM]    [4];
    long    lNumPulsos        [TAM_HOSTS_PEQ_JEM]       ;
    char    szRecordType      [TAM_HOSTS_PEQ_JEM]    [3];
    char    szCodDcto         [TAM_HOSTS_PEQ_JEM]    [6];
    char    szTipDcto         [TAM_HOSTS_PEQ_JEM]    [6];
    double  dValorUnidad      [TAM_HOSTS_PEQ_JEM]       ;
    char    szDesLlamada      [TAM_HOSTS_PEQ_JEM][100+1]; 
    char    szCodRegistro     [TAM_HOSTS_PEQ_JEM]  [5+1]; 
}DETLLAMADAS_HOSTS;

typedef struct tagTipDoc
{
    char    szDesTipDocum     [41];
    int     iCodTipDocum          ;
}TIPDOC;

typedef struct tagOTipDocum
{
    int     iNumTipDocum;
    TIPDOC  *stTipDocum;
}TIPDOCUM;

typedef struct tagTipDoc_Hosts
{
    char    szDesTipDocum     [TAM_HOSTS_PEQ][41];
    int     iCodTipDocum      [TAM_HOSTS_PEQ]    ;
}TIPDOC_HOSTS;

typedef struct tagCodCli
{
    long    lCodCliente             ;	
    char    szNomApoderado      [41];
    char    szCodServicio        [4];
    int     iCodSisPago             ;             
    char    szNumIdent2       [20+1];
    char    szCodCourrier     [10+1];
    char    szCodZonaCourrier [10+1];    
}CODCLI;


typedef struct tagCodCliente
{
    int     iNumCodClientes;
    CODCLI  *stTipDocum;
}CODCLIENTE;

typedef struct tagCodCli_Hosts
{
    long    lCodCliente       [TAM_HOSTS_PEQ]      ;
    char    szNomApoderado    [TAM_HOSTS_PEQ]  [41];
    char    szCodServicio     [TAM_HOSTS_PEQ]   [4];
    int     iCodSisPago       [TAM_HOSTS_PEQ]      ;    
    char    szNumIdent2       [TAM_HOSTS_PEQ][20+1];
    char    szCodCourrier     [TAM_HOSTS_PEQ][10+1];
    char    szCodZonaCourrier [TAM_HOSTS_PEQ][10+1];    
}CODCLI_HOSTS;

/* ESTRUCTURAS PARA CARGA DE DATOS OFICINAS  */
typedef struct tagOficina2
{
    char    szCodOficina       [3];
    char    szDesOficina      [41];
}OFICINA2;

typedef struct tagOficina_Hosts2
{
    char    szCodOficina      [TAM_HOSTS_PEQ] [2+1];
    char    szDesOficina      [TAM_HOSTS_PEQ][40+1];
}OFICINA_HOSTS2;

typedef struct tagOficinas2
{
    int         iNumOficinas;
    OFICINA2    *stOficina;
}OFICINAS2;


/* ESTRUCTURAS PARA CARGA DE DATOS OPERADORAS */
typedef struct tagOperadora
{
    char    szCodOperadora         [6];
    long    lCodClienteOperadora      ;
    char    szNomOperadora        [51];
    char    szNumIdenTRib         [21];
    char    szDireccion          [301];
}OPERADORA;

typedef struct tagOperadora_Hosts
{
    char    szCodOperadora      [100]  [6];
    long    lCodClienteOperadora[100]     ;
    char    szNomOperadora      [100] [51];
    char    szNumIdenTRib       [100] [21];
    char    szDireccion         [100][301];
}OPERADORA_HOSTS;

typedef struct tagOperadora2
{
    int         iNumOperadoras;
    OPERADORA   *stOperadora;
}OPERADORAS;

typedef struct tagVendedor
{
    char    szNomVendedor[41];
    long    lCodVendedor    ;
}VENDEDOR;


typedef struct tagVendedores
{
    int         iNumVendedores;
    VENDEDOR    *stVendedores;
}VENDEDORES;


typedef struct tagVendedor_Hosts
{
    char    szNomVendedor[TAM_HOSTS_PEQ][41];
    long    lCodVendedor [TAM_HOSTS_PEQ];
}VENDEDOR_HOSTS;


typedef struct tagDocPeriodo
{
    char    szCodOperadora [6];
    char    szCodOficina   [3];
    int     iCodTipDocum      ;
    char    szDesTipDocum [41];
    char    szPrefPlaza   [26];
    long    lNumFolio         ;
    char    szFecEmision  [11];
    double  dTotFactura      ;
}DOCPERIODO;

typedef struct tagDocsPeriodo
{
    int        iNumRegs;
    DOCPERIODO *stDocPeriodo;
}DOCSPERIODO;

typedef struct tagDocsPeriodo_Host
{
    char    szCodOperadora [TAM_HOSTS_PEQ] [6];
    char    szCodOficina   [TAM_HOSTS_PEQ] [3];
    int     iCodTipDocum   [TAM_HOSTS_PEQ]    ;
    char    szDesTipDocum  [TAM_HOSTS_PEQ][41];
    char    szPrefPlaza    [TAM_HOSTS_PEQ][26];
    long    lNumFolio      [TAM_HOSTS_PEQ]    ;
    char    szFecEmision   [TAM_HOSTS_PEQ][11];
    double  dTotFactura    [TAM_HOSTS_PEQ]    ;
}DOCPERIODO_HOSTS;

typedef struct tagPago
{
    double  dMonto           ;
    char    szFecha   [9]    ;
    char    szDecrip [41]    ;
    char    szModPago[21]    ;
    long    lTipPago         ;
    char    szCodOperadora[6];
    long    lCodTipDocum     ;
}PAGO;


typedef struct tagPagos
{
    int       iNumRegs;
    PAGO      *stPago;
}PAGOS;


typedef struct tagPagos_Hosts
{
    double  dMonto        [TAM_HOSTS_PEQ];
    char    szFecha       [TAM_HOSTS_PEQ][9];
    char    szDecrip      [TAM_HOSTS_PEQ][41];
    char    szModPago     [TAM_HOSTS_PEQ][21];
    long    lTipPago      [TAM_HOSTS_PEQ];     
    char    szCodOperadora[TAM_HOSTS_PEQ][6];  
    long    lCodTipDocum  [TAM_HOSTS_PEQ];     
}PAGO_HOSTS;


typedef struct {
    int     cod_ciclo;
    char    fec_desde     [9];
    char    fec_hasta     [9];
    char    szFec_Emision [9];
    char    szMesCiclo_0  [7];
    char    szMesCiclo_1  [7];
    char    szMesCiclo_2  [7];
    char    szMesCiclo_3  [7];
    char    szMesCiclo_4  [7];
    char    szMesCiclo_5  [7];
    int     iIndTasador;
    char    szFec_Desde   [9];
    char    szFec_Hasta   [9];
} ST_CICLOFACT ;

typedef struct
{
    double   dTotFactura ;
    double   dTotCuotas  ;
    double   dTotPagar   ;
    double   dTotSaldoAnt;
}ST_ACUMMTO;

typedef struct {
    int       iItem             [9];
    double    dMonto            [9];
    int       iPos              [9];
}ST_BALANCE;

typedef struct {
    char   szRowid        [19];
    int    iCodCliente        ;
    int    iCod_Concepto      ;
    int    iNumCuota          ;
    int    iSecCuota          ;
    double dMtoCuota          ;
    long   lNum_Folio         ;
    char   szNum_FolioCtc [13];
    char   szFec_Emision  [11];
    int    iInd_Facturado     ;
    char   szDes_Cuota    [50];
    char   szFechaEfectiva[9] ;
    char   szPrefPlaza    [26];    
    long   lNumAbonado        ;
}rg_cuotas;

typedef struct {
    long  lCod_Cliente       ;
    long  lNum_Secuenci      ;
    long  lNum_Folio         ;
    char  szNum_FolioCtc [13];
    char  szDes_Saldo    [41];
    int   iCod_Tipdoc        ;
    double dTotalSaldoAnt    ;
    char  szFechaEfectiva[9] ;
    long  lNumAbonado        ;

}rg_fa_factsaldoant;

typedef struct {
    char    szFec_Emision [9];
    double  dTotalSaldo       ;
    int     iNum_RegSaldo     ;
    rg_fa_factsaldoant stReg[MAX_SALDOS];
}STSALDO_ANTERIOR;

typedef struct {
    char    szUser          [50];   /*  Usuario Unix                        */
    char    szPass          [50];   /*  Password Oracle de Usuario Unix     */
    char    szUsuaOra       [50];   /*  Usuario Oracle                      */
    char    szDirLogs     [1024];   /*  Directorio de Archivos Log's y Err  */
    char    szDirDats     [1024];   /*  Directorio de Archivos Log's y Err  */
    char    szFDetLlam    [1024];   /*  Archivo de Detalle de Llamadas      */
    char    szFormato      [255];   /*  Formato Nombre Archivo              */
    long    lCodCiclFact        ;   /*  Codigo de Ciclo a Procesar          */
    long    lNumProceso         ;   /*  Numero de Proceso de Facturacion    */
    double  dValDolar           ;   /*  Valor de Dolar a Fecah de Emision   */
    int     iNivLog             ;   /*  Nivel de Log para Proceso           */
    int     szFecEmision    [20];   /*  Fecha de Emison de la Factura       */
    int     szFecDesdeLlam  [20];   /*  Fecha Inicio del Periodo Tasacion   */
    int     szFecHastaLlam  [20];   /*  Fecha Termino del Periodo Tasacion  */
    char    szCodIdioma     [6] ;   /*  Directorio de Archivos Log's y Err  */
    int     iCodTipDocum        ;
    char    szCodDespacho   [6] ;
    int     iReproceso          ;
    long    cod_clienteinic     ;
    long    cod_clientefina     ;
    long    lProceso            ;
    long    lNum_SecuInfo       ;
    char    szFecIngBegin    [9];
    char    szFecIngEnd      [9];
    int     iTipoCiclo          ;
    int     iCodSalida          ;
    int     iCodEntrada         ;
    char    szFechaHoraSis  [15];    
}LINEACOMANDO;

typedef struct{
    double     dTotalCuotas_venci           ;
    int        iNum_RegCuotas_venci         ;
    rg_cuotas  stReg_venci[MAX_CUOTAS_LOCAL];
    double     dTotalCuotas_pven            ;
    int        iNum_RegCuotas_pven          ;
    rg_cuotas  stReg_pven [MAX_CUOTAS_LOCAL];
    double     dTotalCuotas                 ;
}ST_CUOTAS;

typedef struct {
    char    direccion_fact   [251];
    char    direccion_corr   [251];
}ST_DIR;

/* Estructura HOST ARRAY */
typedef struct {
    int     iNum_OrdenGr         [MAX_CONCEPTOS_LOCAL_HOST];
    int     iNum_OrdenConc       [MAX_CONCEPTOS_LOCAL_HOST];
    int     iCodGrupo            [MAX_CONCEPTOS_LOCAL_HOST];
    char    szGlosaGrupo         [MAX_CONCEPTOS_LOCAL_HOST][51];
    int     iNum_OrdenSubGr      [MAX_CONCEPTOS_LOCAL_HOST];
    int     iCodSubGrupo         [MAX_CONCEPTOS_LOCAL_HOST];
    char    szGlosaSubGrupo      [MAX_CONCEPTOS_LOCAL_HOST][51];
    int     iCod_TipSubGrupo     [MAX_CONCEPTOS_LOCAL_HOST];
    long    lNumAbonado          [MAX_CONCEPTOS_LOCAL_HOST];
    int     iCod_Producto        [MAX_CONCEPTOS_LOCAL_HOST];
    int     iCodConcepto         [MAX_CONCEPTOS_LOCAL_HOST];
    int     iColumna             [MAX_CONCEPTOS_LOCAL_HOST];
    char    szDes_Concepto       [MAX_CONCEPTOS_LOCAL_HOST][61];
    int     iCodTipConce         [MAX_CONCEPTOS_LOCAL_HOST];
    long    lSeg_Consumo         [MAX_CONCEPTOS_LOCAL_HOST];
    int     iNum_Unidades        [MAX_CONCEPTOS_LOCAL_HOST];
    double  dTotalFacturableNet  [MAX_CONCEPTOS_LOCAL_HOST];
    double  dTotalFacturableImp  [MAX_CONCEPTOS_LOCAL_HOST];
    char    szNum_Celular        [MAX_CONCEPTOS_LOCAL_HOST][20+1];
    char    szCod_Nivel          [MAX_CONCEPTOS_LOCAL_HOST][4];
    char    szFec_Pago           [MAX_CONCEPTOS_LOCAL_HOST][11];
    char    szCod_CargoBasico    [MAX_CONCEPTOS_LOCAL_HOST][4];
    char    szTip_ConcNoFact     [MAX_CONCEPTOS_LOCAL_HOST][6];
    char    szCod_PlanTarif      [MAX_CONCEPTOS_LOCAL_HOST][4];
    char    szFec_FinContrato    [MAX_CONCEPTOS_LOCAL_HOST][11];
    long    lSeg_ConsumoReal     [MAX_CONCEPTOS_LOCAL_HOST];
    long    lSeg_ConsumoDcto     [MAX_CONCEPTOS_LOCAL_HOST];
    double  dTotalFacturableReal [MAX_CONCEPTOS_LOCAL_HOST];
    double  dTotalFacturableDcto [MAX_CONCEPTOS_LOCAL_HOST];
    long    lCntLlamReal         [MAX_CONCEPTOS_LOCAL_HOST];
    long    lCntLlamDcto         [MAX_CONCEPTOS_LOCAL_HOST];
    long    lCntLlamFAct         [MAX_CONCEPTOS_LOCAL_HOST];
    double  dImpValUnitario      [MAX_CONCEPTOS_LOCAL_HOST];
    char    szGlsDescrip         [MAX_CONCEPTOS_LOCAL_HOST][100];
    int     iCodConcerel         [MAX_CONCEPTOS_LOCAL_HOST];
    int     iColumnaRel          [MAX_CONCEPTOS_LOCAL_HOST];
    double  dPrcImpuesto         [MAX_CONCEPTOS_LOCAL_HOST];
    double  dImpMontoBase        [MAX_CONCEPTOS_LOCAL_HOST];
    int     iTipConcep           [MAX_CONCEPTOS_LOCAL_HOST];
    int     iNivelImpresion      [MAX_CONCEPTOS_LOCAL_HOST];
    char    szTipUnidad          [MAX_CONCEPTOS_LOCAL_HOST][10];
    char    szTipGrupo           [MAX_CONCEPTOS_LOCAL_HOST][10];
    long    lNumVenta            [MAX_CONCEPTOS_LOCAL_HOST];
    long    lNumPulsos           [MAX_CONCEPTOS_LOCAL_HOST];
    double  dImpFactConIva       [MAX_CONCEPTOS_LOCAL_HOST];   
    int     iFlagDescuento       [MAX_CONCEPTOS_LOCAL_HOST];  /* RPL 07-05-2020 SE AGREGA FLAG DE DESCUENTO */
}ST_DETCONSUMO_HOST;


/* RPL 19-05-2020 PROY CSR SE CREA FUNCIÓN QUE SOLO CARGA DESCUENTOS, ESTO PARA USARSE EN EL RECORRIDO DE CONCEPTOS DE PUT_A2700 */
/* Estructura HOST ARRAY */
typedef struct {
    int     iNum_OrdenGr         [MAX_CONCEPTOS_LOCAL_HOST];
    int     iNum_OrdenConc       [MAX_CONCEPTOS_LOCAL_HOST];
    int     iCodGrupo            [MAX_CONCEPTOS_LOCAL_HOST];
    char    szGlosaGrupo         [MAX_CONCEPTOS_LOCAL_HOST][51];
    int     iNum_OrdenSubGr      [MAX_CONCEPTOS_LOCAL_HOST];
    int     iCodSubGrupo         [MAX_CONCEPTOS_LOCAL_HOST];
    char    szGlosaSubGrupo      [MAX_CONCEPTOS_LOCAL_HOST][51];
    int     iCod_TipSubGrupo     [MAX_CONCEPTOS_LOCAL_HOST];
    long    lNumAbonado          [MAX_CONCEPTOS_LOCAL_HOST];
    int     iCod_Producto        [MAX_CONCEPTOS_LOCAL_HOST];
    int     iCodConcepto         [MAX_CONCEPTOS_LOCAL_HOST];
    int     iColumna             [MAX_CONCEPTOS_LOCAL_HOST];
    char    szDes_Concepto       [MAX_CONCEPTOS_LOCAL_HOST][61];
    int     iCodTipConce         [MAX_CONCEPTOS_LOCAL_HOST];
    long    lSeg_Consumo         [MAX_CONCEPTOS_LOCAL_HOST];
    int     iNum_Unidades        [MAX_CONCEPTOS_LOCAL_HOST];
    double  dTotalFacturableNet  [MAX_CONCEPTOS_LOCAL_HOST];
    double  dTotalFacturableImp  [MAX_CONCEPTOS_LOCAL_HOST];
    char    szNum_Celular        [MAX_CONCEPTOS_LOCAL_HOST][20+1];
    char    szCod_Nivel          [MAX_CONCEPTOS_LOCAL_HOST][4];
    char    szFec_Pago           [MAX_CONCEPTOS_LOCAL_HOST][11];
    char    szCod_CargoBasico    [MAX_CONCEPTOS_LOCAL_HOST][4];
    char    szTip_ConcNoFact     [MAX_CONCEPTOS_LOCAL_HOST][6];
    char    szCod_PlanTarif      [MAX_CONCEPTOS_LOCAL_HOST][4];
    char    szFec_FinContrato    [MAX_CONCEPTOS_LOCAL_HOST][11];
    long    lSeg_ConsumoReal     [MAX_CONCEPTOS_LOCAL_HOST];
    long    lSeg_ConsumoDcto     [MAX_CONCEPTOS_LOCAL_HOST];
    double  dTotalFacturableReal [MAX_CONCEPTOS_LOCAL_HOST];
    double  dTotalFacturableDcto [MAX_CONCEPTOS_LOCAL_HOST];
    long    lCntLlamReal         [MAX_CONCEPTOS_LOCAL_HOST];
    long    lCntLlamDcto         [MAX_CONCEPTOS_LOCAL_HOST];
    long    lCntLlamFAct         [MAX_CONCEPTOS_LOCAL_HOST];
    double  dImpValUnitario      [MAX_CONCEPTOS_LOCAL_HOST];
    char    szGlsDescrip         [MAX_CONCEPTOS_LOCAL_HOST][100];
    int     iCodConcerel         [MAX_CONCEPTOS_LOCAL_HOST];
    int     iColumnaRel          [MAX_CONCEPTOS_LOCAL_HOST];
    double  dPrcImpuesto         [MAX_CONCEPTOS_LOCAL_HOST];
    double  dImpMontoBase        [MAX_CONCEPTOS_LOCAL_HOST];
    int     iTipConcep           [MAX_CONCEPTOS_LOCAL_HOST];
    int     iNivelImpresion      [MAX_CONCEPTOS_LOCAL_HOST];
    char    szTipUnidad          [MAX_CONCEPTOS_LOCAL_HOST][10];
    char    szTipGrupo           [MAX_CONCEPTOS_LOCAL_HOST][10];
    long    lNumVenta            [MAX_CONCEPTOS_LOCAL_HOST];
    long    lNumPulsos           [MAX_CONCEPTOS_LOCAL_HOST];
    double  dImpFactConIva       [MAX_CONCEPTOS_LOCAL_HOST];   
    int     iFlagDescuento       [MAX_CONCEPTOS_LOCAL_HOST];  /* RPL 07-05-2020 SE AGREGA FLAG DE DESCUENTO */
}ST_CONCDESC_HOST;

/*  modificacion para manejo dinamico */

typedef struct {
    int     iNum_OrdenGr               ;
    int     iNum_OrdenConc             ;
    int     iCodGrupo                  ;
    char    szGlosaGrupo           [51];
    int     iNum_OrdenSubGr            ;
    int     iCodSubGrupo               ;
    char    szGlosaSubGrupo        [51];
    int     iCod_TipSubGrupo           ;
    long    lNumAbonado                ;
    int     iCod_Producto              ;
    int     iCodConcepto               ;
    int     iColumna                   ;
    char    szDes_Concepto         [61];
    int     iCodTipConce               ;
    long    lSeg_Consumo               ;
    int     iNum_Unidades              ;
    double  dTotalFacturableNet        ;
    double  dTotalFacturableImp        ;
    char    szNum_Celular        [20+1];
    char    szCod_Nivel             [4];
    char    szFec_Pago             [11];
    char    szCod_CargoBasico       [4];
    char    szTip_ConcNoFact        [6];
    char    szCod_PlanTarif         [4];
    char    szFec_FinContrato      [11];
    long    lSeg_ConsumoReal           ;
    long    lSeg_ConsumoDcto           ;
    double  dTotalFacturableReal       ;
    double  dTotalFacturableDcto       ;
    long    lCntLlamReal               ;
    long    lCntLlamDcto               ;
    long    lCntLlamFAct               ;
    double  dImpValUnitario            ;
    char    szGlsDescrip          [100];
    int     iCodConcerel               ;
    int     iColumnaRel                ;
    double  dPrcImpuesto               ;
    double  dImpMontoBase              ;
    int     iTipConcep                 ;
    int     iNivelImpresion            ;
    char    szTipUnidad            [10];
    char    szTipGrupo             [10];
    long    lNumVenta                  ;
    long    lNumPulsos                 ;
    double  dTotalPrimeraCateg         ;
    double  dTotalSegundaCateg         ;
    double  dImpFactConIva             ;  
    int     iFlagDescuento             ;             /* RPL 07-05-2020 SE AGREGA FLAG */ 
}STDETCONSUMO;

typedef struct
{
    int          iNumReg;
    STDETCONSUMO *stDetConsumo;
    double       dGravFactura;
    long         lNumTerminales;
}STDETCONSUMOS;

/* RPL 19-05-2020 PROY CSR SE CREA NUEVA ESTRUCTURA DE DESCUENTO */
typedef struct {
    int     iNum_OrdenGr               ;
    int     iNum_OrdenConc             ;
    int     iCodGrupo                  ;
    char    szGlosaGrupo           [51];
    int     iNum_OrdenSubGr            ;
    int     iCodSubGrupo               ;
    char    szGlosaSubGrupo        [51];
    int     iCod_TipSubGrupo           ;
    long    lNumAbonado                ;
    int     iCod_Producto              ;
    int     iCodConcepto               ;
    int     iColumna                   ;
    char    szDes_Concepto         [61];
    int     iCodTipConce               ;
    long    lSeg_Consumo               ;
    int     iNum_Unidades              ;
    double  dTotalFacturableNet        ;
    double  dTotalFacturableImp        ;
    char    szNum_Celular        [20+1];
    char    szCod_Nivel             [4];
    char    szFec_Pago             [11];
    char    szCod_CargoBasico       [4];
    char    szTip_ConcNoFact        [6];
    char    szCod_PlanTarif         [4];
    char    szFec_FinContrato      [11];
    long    lSeg_ConsumoReal           ;
    long    lSeg_ConsumoDcto           ;
    double  dTotalFacturableReal       ;
    double  dTotalFacturableDcto       ;
    long    lCntLlamReal               ;
    long    lCntLlamDcto               ;
    long    lCntLlamFAct               ;
    double  dImpValUnitario            ;
    char    szGlsDescrip          [100];
    int     iCodConcerel               ;
    int     iColumnaRel                ;
    double  dPrcImpuesto               ;
    double  dImpMontoBase              ;
    int     iTipConcep                 ;
    int     iNivelImpresion            ;
    char    szTipUnidad            [10];
    char    szTipGrupo             [10];
    long    lNumVenta                  ;
    long    lNumPulsos                 ;
    double  dTotalPrimeraCateg         ;
    double  dTotalSegundaCateg         ;
    double  dImpFactConIva             ;  
    int     iFlagDescuento             ;             /* RPL 07-05-2020 SE AGREGA FLAG */ 
}STCONCDESC;

/* RPL 19-05-2020 PROY CSR SE CREA NUEVA ESTRUCTURA DE DESCUENTO */
typedef struct
{
    int          iNumReg;
    STCONCDESC   *stConcDescuento;
    double       dGravFactura;
    long         lNumTerminales;
}STCONCDESCS;


typedef struct
{
    long lCodImptoFact;
}COD_IMPTOFACT;

typedef struct
{
    int           iNumReg;
    COD_IMPTOFACT *stCodImptosFact;
}CODIMPTOSFACT;

typedef struct
{
    int  iCodConcepto;
    int  iCodCategoria;
    char szFlagImpto[2];
    int  iCodTipImpto;
    double dPrcImpuesto;
}CATIMPUES;

typedef struct
{
    int       iNumRegs;
    CATIMPUES *stCatImpuesto;
}CATIMPUESTOS;

typedef struct
{
    char szTolCodLlam     [21];
    char szTolCodTDir     [21];
    char szTolCodTHor     [21];
    char szTolCodTHorAlta [21];
    char szTolCodTHorBaja [21];
    char szTolConCliente  [21];
    char szTolCodOperador [21];
    char szTolCodTDia     [21];
    char szTolCodSFran    [21];
}GEDPARAMETROS;

typedef struct
{
    char szCod_Plan [6];
    char szCod_Thor [6];
    long lSeg_Inic     ;
    long lSeg_Adic     ;
    double dMto_Inic   ;
    double dMto_Adic   ;
}ST_DATOSDOMINIO;

typedef struct tagMinPlan
{
    char     szCod_Plan [6];
    char     szCod_Thor [6];
    long     lSeg_Inic     ;
    long     lSeg_Adic     ;
    double   dMto_Inic     ;
    double   dMto_Adic     ;
}MINPLAN;

typedef struct tagMinPlanes
{
    int       iNumRegs;
    MINPLAN   *stMinPlan;
}MINPLANES;

typedef struct tagMinPlan_Hosts
{
    char     szCod_Plan[TAM_HOSTS_PEQ] [6];
    char     szCod_Thor[TAM_HOSTS_PEQ] [6];
    long     lSeg_Inic [TAM_HOSTS_PEQ]    ;
    long     lSeg_Adic [TAM_HOSTS_PEQ]    ;
    double   dMto_Inic [TAM_HOSTS_PEQ]    ;
    double   dMto_Adic [TAM_HOSTS_PEQ]    ;
}MINPLAN_HOSTS;


typedef struct tagTipoImpuesto
{
    int      iCodTipImpue      ;
    char     szDesTipImpue [41];
}TIPOIMPUESTO;

typedef struct tagTipoImpuestos
{
    int            iNumRegs;
    TIPOIMPUESTO   *stTipoImpuesto;
}TIPOSIMPUESTOS;

typedef struct tagTiposImpuestos_Hosts
{
    int      iCodTipImpue [TAM_HOSTS_PEQ]     ;
    char     szDesTipImpue[TAM_HOSTS_PEQ] [41];

}TIPOSIMPUESTOS_HOSTS;


ST_FACTCLIE   FacturaCliente[BUFF_CLIENTE];

typedef struct {
    long lhNumSecuenciaInforme         ;
    char szCodInformeGenerar        [7];
    char szPathDir               [1000];
    int  iContClientesProcesados       ;
    char szCOD_SERVICIO             [4];
    int  iSecuencial                   ;
    char szIdiomaOper               [6];
}ST_INFGENERAL;

/****************************************************************************/
/*  Estructuras para carga de descripciones de Orden                        */
/****************************************************************************/

typedef struct tagNumOrdenes
{
    int       iNumRegs;
    NUMORDEN  *stNumOrden;
}NUMORDENES;

typedef struct tagNumOrdenes_Hosts
{
    int     iNum_OrdenGr    [TAM_HOSTS_PEQ];
    int     iNum_OrdenSubGr [TAM_HOSTS_PEQ];
    int     iNum_OrdenConc  [TAM_HOSTS_PEQ];
    int     iCodGrupo       [TAM_HOSTS_PEQ];
    int     iCodSubGrupo    [TAM_HOSTS_PEQ];
    int     iCodConcepto    [TAM_HOSTS_PEQ];
    char    szCodRegistro   [TAM_HOSTS_PEQ][6];
    int     iCodCriterio    [TAM_HOSTS_PEQ];
    int     iTipo_Llamada   [TAM_HOSTS_PEQ];
    int     iTipo_SubGrupo  [TAM_HOSTS_PEQ];
}NUMORDENES_HOSTS;

NUMORDENES  stNumOrdenes;

typedef struct {
    long        lNumAbonado       [BUFF_ABONADO];
    long        lNumCelular       [BUFF_ABONADO];
    int         iCodProducto      [BUFF_ABONADO];
    int         iIndDetFact       [BUFF_ABONADO];
    int         iIndInterzona     [BUFF_ABONADO];
    int         iIndRoaming       [BUFF_ABONADO];
    int         iIndCarrier       [BUFF_ABONADO];
    int         iIndEspeciales    [BUFF_ABONADO];
    int         iIndLdi           [BUFF_ABONADO];
    int         iIndLocalDestino  [BUFF_ABONADO];
    int         iIndLocal         [BUFF_ABONADO];
    double      dImpFacturable    [BUFF_ABONADO];
    char        sznom_usuario     [BUFF_ABONADO][21];
    char        sznom_apellido1   [BUFF_ABONADO][21];
    char        sznom_apellido2   [BUFF_ABONADO][21];
    int         CantidadAbonados;
    int         iIndCobroDetLlam  [BUFF_ABONADO];    
} ST_ABONADO;

typedef struct {
    char   szCodInforme        [7];
    long   lNumSecuInfo           ;
    int    iCodTipImpres          ;
    int    iCodTipDocum           ;
    char   szCodDespacho       [6];
    char   szNomArchivo      [255];
    long   lNumClientes           ;
    double dTotFactura            ;
    double dTotCuotas             ;
    double dTotPagar              ;
    double dTotSaldoAnt           ;
    double dLla_Locales_Neto      ;
    double dLla_Interna_Neto      ;
    double dLla_Roaming_Neto      ;
    double dLla_LargaDI_Neto      ;
    double dLla_Especia_Neto      ;
} FADCTLIMPRES;

typedef struct {
    int     iCorrMensaje   [MAX_LINEAS_MENSAJES];
    int     iNumLinea      [MAX_LINEAS_MENSAJES];
    int     iCantCaract    [MAX_LINEAS_MENSAJES];
    char    zsCodIdioma [MAX_LINEAS_MENSAJES][6];
}ST_MENSAJES;

typedef struct {
    char    szMensajes     [MAX_LINEAS_MENSAJES][201];
    int     iCantLineas;
}ST_MENSAJES_NOCICLO;

typedef struct {
    int     iCodFactCiclo;
    int     iCodFactExenCiclo;
    int     iCodBoletaCiclo;
    int     iCodBoletaExenCiclo;
}DOCUM_CICLO;

typedef struct {
    char    szDes     [MAX_GRUPOS][MAX_LARGOGRUPO];
    int     iPosition [MAX_GRUPOS];
    int     iLastPosition;
}ST_TABLA;

typedef struct {
    int     iCodGrupo             [MAX_GRUPOS];
    char    szDesGrupo            [MAX_GRUPOS][51];
    double  dCostoFacturaNeto     [MAX_GRUPOS];
    long    lSegundos             [MAX_GRUPOS];
    int     iUnidades             [MAX_GRUPOS];
    int     iCodConcepto          [MAX_GRUPOS];
    char    szDesConcepto         [MAX_GRUPOS][61];
    int     iFacturable           [MAX_GRUPOS];
    char    szKey                 [MAX_GRUPOS][50];
    long    lCntLlamReal          [MAX_GRUPOS];
    long    lCntLlamDcto          [MAX_GRUPOS];
    long    lCntLlamFAct          [MAX_GRUPOS];
    long    lSegundosReal         [MAX_GRUPOS];
    long    lSegundosDcto         [MAX_GRUPOS];
    double  dCostoFacturaReal     [MAX_GRUPOS];
    double  dCostoFacturaDcto     [MAX_GRUPOS];
    int     iCantidad                         ;
    long    lTotalSeg                         ;
    double  dTotalCosto                       ; 
    double  dGravPrimeraCategoria [MAX_GRUPOS];
    double  dGravSegundaCategoria [MAX_GRUPOS];
    double  dPorcPrimeraCategoria [MAX_GRUPOS];
    double  dPorcSegundaCategoria [MAX_GRUPOS];
    int     iNivelImpresion       [MAX_GRUPOS];
    char    szTipUnidad           [MAX_GRUPOS][10];
    char    szTipGrupo            [MAX_GRUPOS][10];
    double  dImpValUnitario       [MAX_GRUPOS];
    long    lNumVenta             [MAX_GRUPOS];    
    char    szNum_Celular         [MAX_GRUPOS][21];
}ST_TABLA_ACUM;

typedef struct {
    char    szKey       [MAX_GRUPOS][50] ;
    int     iSocalo     [MAX_GRUPOS]     ;
}ST_TABLA_ORDEN;

typedef struct {
    int     iCodConcepto[MAX_CONCEPTOS_TAR];
    int     iIndTabla   [MAX_CONCEPTOS_TAR];
    int     iNumConceptos;
}CONCEPTOS_TAR;


/************************************************************************/
/* Estructura para recoger los datos de la tabla FA_LLAMADASROA         */
/************************************************************************/

typedef struct stFa_LlamadasRoa
{
    int             iCodOperRoa         ;
    char            szNumMovil      [16];
    char            szFecLlamada    [22];
    char            szHraLlamada     [9];
    double          dImporte            ;
    long            lSegundos           ;
    char            szIndEntSal      [6];
    char            szNumDestino    [19];
    char            szDesDestino  [30+1]; 
    char            szFiller         [2];
    int             iCod_Carg           ;
    double          dImpLocal1          ;     
    double          dImpLarga2          ;     
    char            szDurLocal1     [10];     
    char            szDurLarga2     [10];     
    long            lNumPulsos          ;     
    char            szRecordType     [3]; 
    char            szCodDcto        [6]; 
    char            szTipDcto        [6]; 
    double          dValorUnidad        ; 
    char            szDesLlamada [100+1]; 
    char            szCodRegistro  [5+1]; 
} DETROAMING;

/************************************************************************/
/* Estructura para recoger los datos de la tabla FA_DETFORTAS.          */
/************************************************************************/

typedef struct stFa_DetFortas
{
    int             iCodOperCarr     ;
    char            szFecLlamada [11];
    char            szHraLlamada  [7];
    char            szNumDestino [21];
    char            szDesDestino [21];
    long            lSegundos        ;
    double          dNeto            ;
    char            szCodTrafico  [4];
    char            szFiller      [2];
} DETCARRIER;

typedef struct stFa_FadParametros
{
    int     iCodFormulario                                  ;
    int     iCtesXArchivo                                   ;
    char    szIndFacturado                               [2];
    int     iIndLocal                                       ;
    int     iIndInterzona                                   ;
    int     iIndRoaming                                     ;
    int     iIndCarrier                                     ;
    int     iIndEspeciales                                  ;
    int     iIndLDI                                         ;
    char    szCodRegistro           [MAX_TIPOS_REGISTROS][6];
    int     iIndImp                 [MAX_TIPOS_REGISTROS]   ;
    int     iCod_tipdocum           [MAX_TIPOS_REGISTROS]   ;
    int     iCantRegistros                                  ;
    char    szWhere_Local                              [513];
    char    szWhere_Interzona                          [513];
    char    szWhere_LDI                                [513];
    char    szWhere_Especiales                         [513];
    char    szWhere_Especiales_data                    [513];
    char    szServicio                                 [3+1];
    int     iInd_Agrupacion                                 ;
} DETALLEOPER;

typedef struct tagCodPlanTarif
{
    char    szCod_Plantarif   [4];
    char    szDes_Plantarif  [31];
    long    lMinutosPlan         ;
    double  dValorPlan           ;
    int     iInd_Arrastre        ;
    char    szCod_Prestacion[5+1];
}PLAN_TARIFARIO;


typedef struct tagCodplan
{
    int             iNumRegPlanTarif;
    PLAN_TARIFARIO  *stPlanesTarifarios;
}PLAN_TARIF;

typedef struct tagRegTipD_Host
{
    int         iPosicion     [TAM_HOSTS_PEQ];
    char        szCodRegistro [TAM_HOSTS_PEQ][6];
    char        szCodTipLlam  [TAM_HOSTS_PEQ][4];
    char        szCodValor    [TAM_HOSTS_PEQ][6];
}REGTIP_D_HOST;

typedef struct tagRegTipD
{
    int         iPosicion;
    char        szCodRegistro[6];
    char        szCodTipLlam [6];
    char        szCodValor   [6];
}REGTIP_D;

typedef struct tagConfRegTipD
{
    int      iNumReg;
    REGTIP_D *stRegTipD;
}CONF_REGTIP_D;


typedef struct tagCodPlanTarif_Hosts
{
    char    szCod_Plantarif [MAX_PLANTARIF][4];
    char    szDes_Plantarif [MAX_PLANTARIF][31];
    long    lMinutosPlan    [MAX_PLANTARIF];
    double  dValorPlan      [MAX_PLANTARIF];
    int     iInd_Arrastre   [MAX_PLANTARIF];
    char    szCod_Prestacion[MAX_PLANTARIF][5+1]; 
}PLAN_TARIFARIO_HOSTS;

typedef struct tagTipoTraficoLD
{
    char    szCod_TipoTraficoLD[20];
    char    szNom_TipoTraficoLD[20];
    char    szDes_TipoTraficoLD[50];
}TIPO_TRAFICO_LD;


/****************************************************************************/
/*  Estructuras para carga de descripciones de Multiidiomas                 */
/****************************************************************************/
typedef struct tagMultiIdioma
{
    char    szCod_Idioma_Grupos  [6];
    char    szGlosa_Grupo       [51];
    char    szGlosa_Subgrp      [51];
}GRPMULTIIDIOMA;

typedef struct tagMultiIdiomas
{
    int            iNumRegs;
    GRPMULTIIDIOMA *stGrpIdiomas;
}GRPMULTIIDIOMAS;

typedef struct tagMultiIdioma_Hosts
{
    char szCod_Idioma_Grupos[TAM_HOSTS_PEQ][6];
    char szGlosa_Grupo      [TAM_HOSTS_PEQ][51];
    char szGlosa_Subgrp     [TAM_HOSTS_PEQ][51];
}GRPMULTIIDIOMAS_HOSTS;

GRPMULTIIDIOMAS stGrpMultiidiomas;

/****************************************************************************/

typedef struct
{
    long   lCodCliente       [MAX_ARRASTRE_ESTRUCTURA];
    long   lNumAbonado       [MAX_ARRASTRE_ESTRUCTURA];
    char   szCodBolsa        [MAX_ARRASTRE_ESTRUCTURA][6];
    char   szFecTasa         [MAX_ARRASTRE_ESTRUCTURA][11];
    int    iCodCiclo         [MAX_ARRASTRE_ESTRUCTURA];
    double dValBolsa         [MAX_ARRASTRE_ESTRUCTURA];
    char   szIndUnidad       [MAX_ARRASTRE_ESTRUCTURA][6];
    double dValArrastre      [MAX_ARRASTRE_ESTRUCTURA];
    double dValExpirado      [MAX_ARRASTRE_ESTRUCTURA];
    double dValDisponible    [MAX_ARRASTRE_ESTRUCTURA];
    double dValConsumo       [MAX_ARRASTRE_ESTRUCTURA];
    double dValResto         [MAX_ARRASTRE_ESTRUCTURA];
    char   szLlaveArrastre   [MAX_ARRASTRE_ESTRUCTURA][17];
    int    iCantidadArrastre;
}ST_DETARRASTRE;

typedef struct
{
    long   lCodCliente       [MAX_ARRASTRE_CURSOR];
    long   lNumAbonado       [MAX_ARRASTRE_CURSOR];
    char   szCodBolsa        [MAX_ARRASTRE_CURSOR][6];
    char   szFecTasa         [MAX_ARRASTRE_CURSOR][11];
    int    iCodCiclo         [MAX_ARRASTRE_CURSOR];
    double dValBolsa         [MAX_ARRASTRE_CURSOR];
    char   szIndUnidad       [MAX_ARRASTRE_CURSOR][6];
    double dValArrastre      [MAX_ARRASTRE_CURSOR];
    double dValExpirado      [MAX_ARRASTRE_CURSOR];
    double dValDisponible    [MAX_ARRASTRE_CURSOR];
    double dValConsumo       [MAX_ARRASTRE_CURSOR];
    double dValResto         [MAX_ARRASTRE_CURSOR];
    char   szLlaveArrastre   [MAX_ARRASTRE_CURSOR][17];
    int   iCantidadArrastre;
}ST_CURARRASTRE;

typedef  struct
{
    int     cod_parametro[MAX_FAD_PARAMETROS];
    char    des_parametro[MAX_FAD_PARAMETROS][1024];
    char    tip_parametro[MAX_FAD_PARAMETROS][32];
    int     val_numerico [MAX_FAD_PARAMETROS];
    char    val_caracter [MAX_FAD_PARAMETROS][512];
    char    val_fecha    [MAX_FAD_PARAMETROS][9];
    int     val_cantidad [MAX_FAD_PARAMETROS];
}ST_PARAMETROS;

typedef  struct
{
    char    szCodPlan              [MAX_MINUTOADICIONAL][6];
    char    szLlaveMinutoAdicional [MAX_MINUTOADICIONAL][7];
    double  dMtoAdicional          [MAX_MINUTOADICIONAL];
    int     iCantidadMinutoAdicional;
}ST_MINUTOADICIONAL;

typedef struct tagOpers
{
    int     iNumRegs;
    CODOPER *stOper;
}CODOPERS;


typedef struct tagOpers_Hosts
{
    int     iCodOperador  [TAM_HOSTS_PEQ];
    char    szDesOperador [TAM_HOSTS_PEQ][31];
}CODOPER_HOSTS;

/* estructura de orden alterno de detalle de consumo */
typedef struct tagOrden
{
    char    szKey[31];
    int     iPosicion;
}ST_ORDEN;

typedef struct tagOrdenado
{
    int      iNumRegs;
    ST_ORDEN *stOrden ;
}ST_ORDENADO;

/* INICIO ESTRUCTURAS RELACIONADAS CON EL MODULO DE VENTAS */
/*---------------------------------------------------------*/
/* Estructura de entrada a la funcion                      */
/*-------------------------------------------------------- */
typedef struct reg_entrada
{
    long   lCodCliente ;
    long   lNumVenta   ;
    long   lNumProceso ;
    int    iCodConcepto;
    int    iColumna    ;
    char   szDesConcepto[60+1];
}reg_entrada;

/*---------------------------------------------------------*/
/* Estructura de salida de la funcion                      */
/*---------------------------------------------------------*/
typedef struct reg_salida
{
    char   szNumSerie[25+1];
    long   lNumAbonado;
    int    iCodConcepto;
    char   szDesConcepto[60+1];
    long   lNumCelular;
    struct reg_salida * sgte;
}reg_salida;

typedef struct reg_salida stSalida;
stSalida   *lstSalida;

typedef struct tagBenefNodo
{
    long   lNumAbonado;       
    char   szCodEstadoBenef[6];
    char   szCodPlan[6] ;
    char   szDesPlan[31];
    int	   iNumPeriodos;      
    int	   iPeriodosOtor;     
    int	   iPeriodosRest;     
    int	   iMinAdicionales;   
    double dMontCargaAdic;    
    char   szNomUsuario[31];
    char   szFecIngreso[20];
    double dValAcumulado;     
    char   szCodEstado[6];
    char   szIndReevalua[2]; 
    char   szTipBeneficio[6];
}BENEF_NODO;

typedef struct tagBenefPromo
{
    long       lNumBenef;
    BENEF_NODO *stNodo;
}BENEF_PROMO;


ST_DETARRASTRE     sthDetArrastre;
ST_CURARRASTRE     sthCurArrastre;
ST_PARAMETROS      sthFadParametros;
ST_MINUTOADICIONAL sthMinutoAdicional;
TIPDOCUM           pstTipDocum;
CODCLIENTE         pstCodCliente;
OFICINAS2          pstOficinas2;
VENDEDORES         pstVendedores;
OPERADORAS         pstOperadoras;
PLAN_TARIF         pstPlanes;
CONF_REGTIP_D	   pstConfTipRegD; 
DETCELULAR_AGRUP   stDetLlamadasTAS;
DETLLAMADAS        stDetLlamadas;
DETCELULAR         stDetCelular;
TIPO_TRAFICO_LD    stTipoTrafico[MAX_TIPOS_LD];
BENEF_PROMO        stBenefPromo;
CODIMPTOSFACT      pstImptosFact;
CATIMPUESTOS       pstCatImpues;
GEDPARAMETROS      stGedParametros;
MINPLANES          stMinutosPlanes;
TIPOSIMPUESTOS     stTiposImpuestos; 
CODOPERS           stOperadores;
STDETCONSUMOS      stFaDetCons;
STCONCDESCS        stConcAllDescuentos;
ST_ORDENADO        stOrden2DetConsumo;
FILE               *fpAnomalias;

char               szFec_Desde[9];
char               szFec_Hasta[9];
int                igTipoCiclo;
long               lgNum_Proceso;
char               szgNombreArchivoAnomalias[128];
int                igDocumentoCero;
char               szgHostId[11];
long               lgCodClienteIni;
long               lgCodClienteFin;
int                igOpcionRango;
long               lCodCiclFactAux; 

#endif

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

