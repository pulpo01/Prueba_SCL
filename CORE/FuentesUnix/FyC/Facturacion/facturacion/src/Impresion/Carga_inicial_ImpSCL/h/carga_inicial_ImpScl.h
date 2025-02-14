#ifndef _comunes_h
#define _comunes_h 
#include <iostream>
#include <sstream>
#include <string>
#include <map>
#include <vector>
#include <signal.h>

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

CODCLI_HOSTS_M *codcli_hosts;

MEMORIA *memoria;

ST_FACTCLIE *st_factclie;


NUMORDEN *numorden;

int destroy_memory(int ret);
int destruir_semaforo(int sem_id);
int loguearse(char * user);
// RPL PROY CSR 15-07-2020 SE CAMBIA FUNCION get_reg_free Y SE LE AGREGA EL VALOR i
//int get_reg_free()
int get_reg_free(int i);  
int borra_facturados(int sem_id);
int cuenta_libres();
//RPL PROY CSR 04-08-2020 SE AGREGA NUEVA FUNCION cuenta_erroneos
int cuenta_erroneos();
//RPL PROY CSR 06-08-2020 SE AGREGA NUEVA FUNCION cuenta_pendientes
int cuenta_pendientes();
int clientes_regs;
int lock(int sem_id);
int Unlock(int sem_id);
int total_regs=0;
int todos=0;
int global_semid;
int global_ret;
int global_clientes;
int global_codcli;
int global_numorden;
int global_concatenador;
int ret_int;
int intentos;
int tiempo_venci;
std::string rango_clientes;



std::string szHModulo;
std::string despacho;
int tipo_documento;
int intentos_lectura = 50 ;
std::string global_ciclo;
std::string cliente_inicial;
std::string cliente_final;


otl_connect db;
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
