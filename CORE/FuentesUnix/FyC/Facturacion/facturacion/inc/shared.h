
#define MIN_SHARED    	    	20


#define NUM_SHARED_TABLES   	38


#define ID_CARGOS 			0
#define ID_CABCUOTAS  		1
#define ID_TACONCEPFACT  	2
#define ID_CONCEPTO  		3
#define ID_CONCEPTO_MI  	4
#define ID_RANGOTABLA  		5
#define ID_LIMCREDITOS  	6
#define ID_ACTIVIDADES  	7
#define ID_PROVINCIAS  		8
#define ID_REGIONES  		9
#define ID_CATIMPOSITIVA  	10
#define ID_ZONACIUDAD  		11
#define ID_ZONAIMPOSITIVA  	12
#define ID_IMPUESTOS  		13
#define ID_TIPIMPUES  		14
#define ID_GRPSERCONC 		15
#define ID_CONVERSION  		16
#define ID_DOCUMSUCURSAL  	17
#define ID_LETRAS  			18
#define ID_GRUPOCOB  		19
#define ID_TARIFAS  		20
#define ID_ACTUASERV  		21
#define ID_CUOTAS  			22
#define ID_FACTCARRIERS  	23
#define ID_CUADCTOPLAN  	24
#define ID_CTOPLAN  		25
#define ID_PLANCTOPLAN  	26
#define ID_ARRIENDO  		27
#define ID_CARGOSBASICO  	28
#define ID_OPTIMO  			29
#define ID_FERIADOS   		30
#define ID_PLANTARIF  		31
#define ID_PENALIZA  		32
#define ID_FAC_CLIENTES     33
#define ID_CICLOCLI        	34
/********************************************************
	INICIO NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/
#define ID_OFICINA        	35
#define ID_FACTCOBR        	36
/*#define ID_DETPLANDESC    	37*/ 
/********************************************************
	FIN NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/
/***********   Inicio Cargos Recurrentes   *************/
#define ID_CARGOSRECURRENTES  	37
/***********     Fin Cargos Recurrentes    *************/

#define USE_STAGE     		TRUE

#define MODE_DATA		10
#define MODE_NO_DATA        	20
#define MODE_NO_DATA_FOUND  	30

typedef struct tagDATA_TABLE
{
  int   iCompartido;        
  char  szTableName[100];   
  key_t kTableKey;          
  int   iDescriptor;        
  long  lTotalBytes;        
  long  lTotalRegistros;    
  char  szFechaAct[15];     
} DATA_TABLE;

int   ifnOpenShared(key_t Key, long Size, int Flags, int *iDescriptor);
int   ifnAttachShared(int iDescriptor, int Flags, void **pMemory);
int   ifnDettachShared(void *pShared);
int   ifnRemoveShared(int iDescriptor);
int   ifnAttachMemory(int iTableIndex, DATA_TABLE  *pDataTable,
            	     int SharedPerms, void **pData, long *lNumData);            	                 	                 	                 	                 	     
int   ifnAttachDataTable(key_t kKey, int SharedPerms, long lSize,
              		 DATA_TABLE **pDataTable);
int   ifnDettachDataTable(DATA_TABLE  *pDataTable);
void  vfnImprimirDetalleMemoria(FILE *pF, DATA_TABLE *pDataTable);
int   ifnCreateShared(DATA_TABLE  *pDataTable,int iTableIndex,
      		      char *szTableName,long Size,long lRegs,
      		      long *lMemoriaTotal,int SharedPerms,void *pData);


