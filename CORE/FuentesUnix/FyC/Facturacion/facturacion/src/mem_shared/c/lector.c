#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <memory.h>
#include <stdarg.h>
#include <time.h>
#include <signal.h>
#include <errno.h>
#include <sys/systeminfo.h>
#include <sys/types.h>
#include <sys/times.h>
#include <sys/time.h>
#include <sys/stat.h>
#include <sys/shm.h>
#include <pthread.h>

#include "tipos.h"
#include "tablas.h"
#include "shared.h"
#include "semap.h"
#include "general.h"
#include "lector.h"

int my_pid;

int main(int argc, char*argv[])
{

  	int iRet = 0;
  	int iCont = 0;
  	int iError = 0;
  	char szUser[100],szPass[100];

	FAC_CLIENTES * pstCliente = NULL;

	vfnInitStructGeneral();

	my_pid=getpid();

  	iError = ifnLockSemForRead(TaS.kSemKey, 0);
  	if (iError != 0)
  	{
    		if (iError == ENOENT)
    		{
      			fprintf(stderr, "\n\nLECTOR: ERROR(bfnAttachMemory):\n\tNo existe semaforos para la memoria compartida");
    		}
    		else if (iError == EAGAIN)
    		{
      			fprintf(stderr, "\n\nERROR(bfnAttachMemory):\n\tLos semaforos estan ocupados, memoria no disponible...\n");
    		}
			else
    			{
      			fprintf(stderr, "\n\nERROR(bfnAttachMemory):\n\tError al obtener set de semaforos de la memoria compartida\n\tError: [%d][%s]", errno, strerror(errno));
    			}
    		return FALSE;
  	}


	iError = ifnAttachDataTable(TaS.kTableKey, 0,(NUM_SHARED_TABLES*sizeof(DATA_TABLE)), &TaS.pDataTable);

  	if (iError)
  	{
    		if (iError == ENOENT)
    		{
      			vfnLog (FILE_BOTH, "\n\nERROR(bfnAttachMemory):\n\tNo existe memoria compartida");
    		}
    	else
    	{
      		vfnLog (FILE_BOTH, "\n\nERROR(bfnAttachMemory):\n\tError al abrir memoria compartida\n\tError: [%d][%s]", errno, strerror(errno));
    	}
    	return 1;
  	}

  
	iError = ifnAttachMemory(ID_FAC_CLIENTES, TaS.pDataTable, 0,
        (void*)&TaS.pstlFacClientes, &TaS.lFacClientes);
  	if (iError != 0)
  	{
    		vfnLog(FILE_BOTH, "\n\nERROR(bfnAttachMemory):\n\tError al mapear la memoria para la tabla FA_CICLOCLI.\nError: [%s]", strerror(iError));
    		return 1;
  	}
  

	if (!bfnImprimirDatosAttach())
	{
    		vfnLog(FILE_BOTH, "\n\nERROR(bfnAttachMemory): \n\tError al imprimir datos\n");
    		return 1;
	}

	return 0;
}

/******************************************************************************
Funcion         :       bfnImprimirDatosAttach
*******************************************************************************/

BOOL bfnImprimirDatosAttach(void)

{
	int iCont = 0;
	long b;
	FAC_CLIENTES *pstFind;
	FAC_CLIENTES stData;
	if(TaS.pDataTable[ID_FAC_CLIENTES].lTotalRegistros!=0)
	{
		printf("lector %d: DATOS ENCONTRADOS.\n",my_pid);	
		printf("-----------------------------\n");	
		for (iCont = 0 ; iCont < TaS.pDataTable[ID_FAC_CLIENTES].lTotalRegistros ; iCont++)
		{
			pstFind = NULL;
			memset( &stData, 0x00, sizeof(stData));
			printf("lector %d -> COD_CLIENTE: [%d] \n",my_pid,TaS.pstlFacClientes[iCont].lCodCliente);
		}		
	}
	else
	{
		printf("lector %d: DATOS **NO** ENCONTRADOS.\n",my_pid);	
	}
	
	

	return TRUE;
}
