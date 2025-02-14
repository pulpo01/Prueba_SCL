#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/shm.h>

#include "tipos.h"
#include "shared.h"
#include "tablas.h"
#include "general.h"

/******************************************************************************
Funcion         :       ifnOpenShared
*******************************************************************************/

int ifnOpenShared(key_t Key,long  Size,int Flags,int *iDescriptor)
{
  	int iRet = 0;
  	extern  int errno;
  	
  	iRet = shmget(Key,Size,Flags);
  	if (iRet == -1)
    		return errno;
  	*iDescriptor = iRet;
  	return SALIR_OK;
}

/******************************************************************************
Funcion         :       ifnAttachDataTable
*******************************************************************************/

int ifnAttachDataTable(key_t kKey,int SharedPerms,long lSize,DATA_TABLE  **pDataTable)
{
  	extern int errno;
  	void  *pTemp;
  	int   iDescriptor;

  	*pDataTable = NULL;
  	
  	if (ifnOpenShared(kKey, lSize, SharedPerms, &iDescriptor) != SALIR_OK)
  			return errno;
    
	if (ifnAttachShared(iDescriptor, 0, &pTemp) != SALIR_OK)
  			return errno;
    

  	*pDataTable = (DATA_TABLE *) pTemp;

  	return SALIR_OK;
}

/******************************************************************************
Funcion         :       ifnDettachShared
*******************************************************************************/

int ifnDettachShared( void  *pShared)
{
  	extern int errno;
  	
  	if (shmdt(pShared) == -1)
    		return errno;
  	return SALIR_OK;
}

/******************************************************************************
Funcion         :       ifnDettachDataTable
*******************************************************************************/

int ifnDettachDataTable(DATA_TABLE  *pDataTable)
{
  	extern int errno;

  	if (shmdt((void*) pDataTable) == -1)
    		return errno;
  	return SALIR_OK;
}

/******************************************************************************
Funcion         :       ifnAttachMemory
*******************************************************************************/

int ifnAttachMemory(int iTableIndex,DATA_TABLE  *pDataTable,int  SharedPerms,void  **pData,long *lNumData)
{
  	void  *pTemp;
  	extern int errno;

  	*pData = NULL;
  	if (lNumData)
    		*lNumData = 0;

  	if (pDataTable[iTableIndex].iCompartido != MODE_DATA)
    		return SALIR_OK;

  	if (ifnOpenShared(pDataTable[iTableIndex].kTableKey,
            pDataTable[iTableIndex].lTotalBytes, SharedPerms,
            &pDataTable[iTableIndex].iDescriptor) != SALIR_OK)
    		return errno;

  	if (ifnAttachShared(pDataTable[iTableIndex].iDescriptor, 0, &pTemp)!= SALIR_OK)
    		return errno;

  	*pData = pTemp;
  	if (lNumData)
    		*lNumData = pDataTable[iTableIndex].lTotalRegistros;
  	return SALIR_OK;
}

/******************************************************************************
Funcion         :       ifnAttachShared
*******************************************************************************/

int ifnAttachShared(int iDescriptor,int Flags,void  **pMemory)
{
  	void  *pRet = NULL;
  	extern  int errno;

  	pRet = shmat(iDescriptor, 0, Flags);
  	if (pRet == (void *)-1)
    		return errno;

  	*pMemory = pRet;
  	return SALIR_OK;
}

/******************************************************************************
Funcion         :       ifnRemoveShared
*******************************************************************************/

int ifnRemoveShared(int iDescriptor)
{
  	extern int errno;
  	int iError;

  	iError = shmctl(iDescriptor, IPC_RMID, 0);
  	if (iError == -1)
    		return errno;

  	return SALIR_OK;
}

/******************************************************************************
Funcion         :       ifnCreateShared
*******************************************************************************/

int ifnCreateShared(DATA_TABLE *pDataTable,int iTableIndex,char *szTableName,
  		    long Size,long lRegs,long *lMemoriaTotal,int SharedPerms,void *pData)
{
  	void *pTemp;
  	extern int errno;
  	int iError;
  	char  szFecha[15];
  
  	strcpy(pDataTable[iTableIndex].szTableName, szTableName);
  	vfnRecuperarFechaHora("%Y%m%d%H%M%S", szFecha);
  	strcpy(pDataTable[iTableIndex].szFechaAct, szFecha);

  	if(Size == 0)
  	{
    		pDataTable[iTableIndex].iCompartido = MODE_NO_DATA;
    		pDataTable[iTableIndex].lTotalBytes = 0;
    		pDataTable[iTableIndex].lTotalRegistros = 0;
    	return SALIR_OK;
  	}

  	if (ifnOpenShared(pDataTable[iTableIndex].kTableKey,MIN_SHARED,
  			  SharedPerms,&pDataTable[iTableIndex].iDescriptor)!= SALIR_OK)
        {
    		return errno;
	}

  	iError = ifnRemoveShared(pDataTable[iTableIndex].iDescriptor);
  	if (iError != ENOENT && iError != 0)
    		return errno;

  	if (ifnOpenShared(pDataTable[iTableIndex].kTableKey,Size, 
            		  SharedPerms,&pDataTable[iTableIndex].iDescriptor) != SALIR_OK)
    		return errno;

  	if (ifnAttachShared(pDataTable[iTableIndex].iDescriptor, 0, &pTemp) != SALIR_OK)
    		return errno;

    	memcpy(pTemp, pData, Size);

  	if (ifnDettachShared(pTemp) != SALIR_OK)
    		return errno;

  	pDataTable[iTableIndex].lTotalBytes = Size;
  	pDataTable[iTableIndex].lTotalRegistros = lRegs;
  	pDataTable[iTableIndex].iCompartido = MODE_DATA;
  	*lMemoriaTotal += Size;

  	return SALIR_OK;
}

/******************************************************************************
Funcion         :       vfnImprimirDetalleMemoria
*******************************************************************************/

void vfnImprimirDetalleMemoria(FILE *pF,DATA_TABLE  *pDataTable)
{
  	int iCont = 0;

  	fprintf(pF, "\n\n\t Estado de la memoria");
  	fprintf(pF, "\n\t --------------------");

  	if (!pDataTable)
  	{
    		fprintf(pF, "\n\n DATOS COMPARTIDOS NO DISPONIBLES.");
    		return;
  	}

  	fprintf(pF, "\n\n"
  		"Fecha          Indice      Comp     Clave     Total_Bytes       Total_Regitros     Descripcion");

  	fprintf(pF, "\n"
  		"--------------------------------------------------------------------------");
  	for (iCont = 0 ; iCont < NUM_SHARED_TABLES ; iCont++)
  	{
  		if(strcmp(pDataTable[iCont].szTableName,"")!=0)
	    		fprintf(pF, "\n"
	     			"%s\t%02d\t\t%01d\t%03d\t%010ld\t\t%010ld\t%s",
	      			pDataTable[iCont].szFechaAct,
	      			iCont,
	      			pDataTable[iCont].iCompartido,
	      			pDataTable[iCont].kTableKey,
	      			pDataTable[iCont].lTotalBytes,
	      			pDataTable[iCont].lTotalRegistros,
	      			pDataTable[iCont].szTableName);
  	}

  	fprintf(pF, "\n"
  	"--------------------------------------------------------------------------\n");

}


