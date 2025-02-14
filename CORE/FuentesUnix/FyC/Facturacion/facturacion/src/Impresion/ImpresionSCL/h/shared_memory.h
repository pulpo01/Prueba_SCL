#ifndef _shared_memory_
#define _shared_memory_

#include <sys/shm.h>
#include <unistd.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <sys/types.h>
#include <sys/shm.h>

#include <ImpSclSt.h>

struct sembuf operaciones[1];

CODCLI_HOSTS_M *codcli_hosts;

MEMORIA *memoria;

/*ST_FACTCLIE   FacturaCliente	[BUFF_CLIENTE];*/

/*AQUI SE GUARDAN TABLAS ESTATICAS PARA MEMORIA COMPARTIDA */ 


ST_FACTCLIE     *st_factclie_mc;
ST_FACTCLIE     FacturaCliente_mc;

typedef struct 
{
  	int   	iNum_OrdenGr 	;
  	int   	iNum_OrdenSubGr ;
  	int   	iNum_OrdenConc  ;
  	int	iCodGrupo       ;
  	int	iCodSubGrupo    ;
  	int	iCodConcepto    ;
  	char	szCodRegistro[6];
  	int	iCodCriterio	;
  	int	iTipo_Llamada	;
  	int	iTipo_SubGrupo	;
  	
} NUMORDEN_MC;

NUMORDEN_MC     *numorden;


int  flg_mc ;
int  total_regs;
int  id_memoria;
int  id_numorden;
int  id_codcli;
int  id_concatenador;
char REGA1000[6];
int  unir_a_memoria(int max,int id_tabla);
int  crear_semaforo(int id_tabla);
int  get_cliente (int sem_id,int total_regs);
int  marca_cliente_facturado(int sem_id,int puntero);
void muestra_registro();
void muestra_registro_mc();
//RPL PROYC CSR 04-08-2020 SE AGREGA FUNCION DE DOCUMENTOS CON ERROR
void suma_errores(long cod_cliente);


void muestra_parametros();
void muestra_parametros_ged();
void muestra_plan_tarifario();
void muestra_oficina_hosts2();
void muestra_vendedor_hosts2();
void muestra_tipdoc();
void muestra_ciclofact();
void muestra_operadora_hosts();
void muestra_conceptos_tar();
void muestra_codcli_hosts();
void muestra_detalleoper();
void muestra_minutoadicional();
void muestra_tabla_comandos();
int  CargaFadParametrosMC();
int  CargaFadParametros_GED_MC();
int  bCargaMascaraOperadora_MC(DETALLEOPER *pst_MascaraOper);
int  GetCiclFact_MC(ST_CICLOFACT * pstCicFact,long lCodCiclFact);
int  bfnCargaCod_Plantarif_MC (PLAN_TARIFARIO **pstCodPlanTarif, int *iNumCodPlanes);
int  CargaMinutoAdicional_MC();
int  bfnCargaOficinas2_MC(OFICINA2 **pstOfici2, int *iNumOficinas);
int  bfnCargaOperadora_MC(OPERADORA **pstOper, int *iNumOperadoras);
int  bfnCargaTipDocum_MC (TIPDOC **pstTipDoc, int *iNumTipDocs);
int  bfnCargaCodClientes_MC(CODCLI **pstCodClie, int *iNumCodCientes, long lCicloFact);
int  bfnCargaVendedores_MC(VENDEDOR **pstVendedor, int *iNumVendedores);
int  bCargaConceptosTar_MC(CONCEPTOS_TAR *pstConceptos);
int  ManejoArchImp_MC(ST_FACTCLIE *FactDocuClie,LINEACOMANDO *ParEntrada,ST_CICLOFACT *sthFa_CicloFact,
                      ST_INFGENERAL *sthFa_InfGeneral,DETALLEOPER *stMascaraOper,FILE **Fd_ArchImp ,
                      char *szNombreArchivo);
int  CargaInfCliente_MC(ST_FACTCLIE * FacCli,LINEACOMANDO * Param,ST_MENSAJES * Mensajes,
                        ST_MENSAJES_NOCICLO * Mensajes_NoCiclo,STSALDO_ANTERIOR * Saldo,
                        ST_CICLOFACT * CicloFact,ST_CUOTAS * pstFaCuotas,ST_INFGENERAL * pstInfGeneral,
                        DETALLEOPER * pst_MascaraOper);
                       
void trae_valor_fadparametros_mc(int cod_parametro,char * resultado);
BOOL CargaNumOrden_MC(NUMORDEN **pstNumOrden, int *iNumRegs, int iCodFormulario );
int  get_registro (int sem_id);

                  

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


