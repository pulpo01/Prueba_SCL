#include <iostream>
#include <sstream>
#include <string>
#include <map>
#include <vector>

#define OTL_ORA9I
#define OTL_STL
#include "otlv4.h"
#define OTL_ANSI_CPP
#define OTL_SELECT 16384

#include <ImpSclMemShared.h>

typedef struct{
  int shmid;
  int cod_param;
  char des_param[101];
}valores;

#define MAX_CONJUNTO        5000000
#define NRO_COD_PROCESO_JOB  851
#define NRO_COD_PROCESO     5000
extern int     iCOD_PROCESO ;

std::string dir_archivo();

typedef struct{
  std::string login;                        
  std::string ciclo_facturacion;            
  std::string frecuencia;                   
  std::string total_regs;                   
  std::string num_secuinfo;                 
  std::string cod_tipdocum;                 
  std::string cod_despacho;                 
  std::string nivel_de_log;                 
} ENTRADA;                                  


typedef struct{
  long lCodCliente;
  char szNomApoderado[41];
  char szCodServicio[4];
  int  iCodSisPago;
} CODCLI_HOSTS;

CODCLI_HOSTS *codcli_hosts;

typedef struct
{
    int  itipdocum;
    char szCod_Despacho[6];
} CONJUNTO;

CONJUNTO mi_conjunto[MAX_CONJUNTO];


typedef struct{
  int itipdocum;
  std::string szCod_Despacho;
  std::string szNom_Archivo;
  long tot_cuotas;
  long tot_pagar;
  long tot_saldoant;
  int num_clientes;
} LLAVES;

LLAVES llaves[100];
int  nro_llaves;

/*MEMORIA *memoria;*/

otl_connect db;
std::vector<std::string> vec;
std::string trae_secuencial();
int insert_into_FAD_CTLIMPRES(const std::string& secuencial);
int escribe_archivo_tiempo();
int cuenta_cliente(int ciclo_facturacion ,int tipo_documento,const std::string& tipo_despacho);
void trae_totales(int ciclo_facturacion ,int tipo_documento,const std::string& tipo_despacho, long * tot_cuotas , long * tot_pagar , long * tot_saldoant);
