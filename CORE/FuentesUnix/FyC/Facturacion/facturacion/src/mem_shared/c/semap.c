#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/time.h>
#include <sys/shm.h>
#include <sys/sem.h>

#include "tipos.h"
#include "shared.h"
#include "tablas.h"
#include "general.h"

struct sembuf opUnlockSemForRead[1]=
{
	{1, -1, SEM_UNDO | IPC_NOWAIT}
};
  
struct sembuf opLockSemForRead[3]=
{
	{0, -1, IPC_NOWAIT},          
	{1, 1, SEM_UNDO|IPC_NOWAIT},  
	{0, 1, IPC_NOWAIT}            
};

struct sembuf opLockSemForWrite[5]=
{
    	{0, -1, IPC_NOWAIT},        
    	{1, 0, 0},                  
    	{2, 1, 0},                  
    	{2, -1, SEM_UNDO},          
    	{2, -1, IPC_NOWAIT|SEM_UNDO}
};

struct sembuf opUnlockSemForWrite[1]=
{
    	{0, 1, 0}           
};

/******************************************************************************
Funcion         :       ifnLockSemForRead
*******************************************************************************/

int ifnLockSemForRead(key_t kKey,int iFlags)
{
  	extern int errno;
  	int iSemDescriptor;
  	
	fprintf(stderr, "\n\n\t Funcion ifnLockSemForRead.."); /* borrar */

  	if ((iSemDescriptor = semget(kKey,3,iFlags)) == -1)
  	{
  	        fprintf(stderr, "\n\n\t Error1 ifnLockSemForRead..[%d]",errno); /* borrar */
    		return errno;
    		}

  	if (semop(iSemDescriptor,opLockSemForRead,3) == -1)
  	{
  		fprintf(stderr, "\n\n\t Error2 ifnLockSemForRead..[%d]",errno); /* borrar */
    		return errno;
    		}

        fprintf(stderr, "\n\n\t Saliendo OK funcion ifnLockSemForRead..[%d]",errno); /* borrar */

  	return SALIR_OK;
}

/******************************************************************************
Funcion         :       ifnUnlockSemForRead
*******************************************************************************/

int ifnUnlockSemForRead(key_t kKey,int iFlags)
{
  	extern int errno;
  	int iSemDescriptor;

  	if ((iSemDescriptor = semget(kKey,3,iFlags)) == -1)
    		return errno;

  	if (semop(iSemDescriptor,opUnlockSemForRead,1) == -1)
    		return errno;

  	return SALIR_OK;
}

/******************************************************************************
Funcion         :       ifnLockSemDataAndWaitForReaders
*******************************************************************************/

int ifnLockSemDataAndWaitForReaders(key_t kKey,int iFlags)
{
  	extern int errno;
  	int iSemDescriptor;

  	iSemDescriptor = semget(kKey,3,iFlags);

  	if (iSemDescriptor == -1)
    		return errno;
  
  	semop(iSemDescriptor,&opLockSemForWrite[0],1);
  
  	while(semop(iSemDescriptor,&opLockSemForWrite[1],1)==-1)
  	{
		fprintf(stdout,"\nEsperando a lectores.....\n");
		sleep(1);
	}

  	return SALIR_OK;
}

/******************************************************************************
Funcion         :       ifnLockSemForWrite
*******************************************************************************/

int ifnLockSemForWrite(key_t kKey,int iFlags)
{
  	extern int errno;
  	int iSemDescriptor;

  	iSemDescriptor = semget(kKey,3,iFlags);

  	if (iSemDescriptor == -1)
  	{

    		if (errno == ENOENT)
    		{
      			if ((iSemDescriptor = semget(kKey,3,iFlags | IPC_CREAT)) == -1)
      			{
        			return errno;
      			}
      			else
      			{
               			if (semop(iSemDescriptor,&opLockSemForWrite[2],2) == -1)
               			{
          				return errno;
				}
        			return SALIR_OK;
      			}
    		}
    		else
    		{
      			return errno;
    		}
  	}


   	while(semop(iSemDescriptor,&opLockSemForWrite[4],1)==-1)
	{
		fprintf(stdout,"\nEsperando para escribir.....\n");
		sleep(1);
	}

  	return SALIR_OK;
}

/******************************************************************************
Funcion         :       ifnUnlockSemForWrite
*******************************************************************************/

int ifnUnlockSemForWrite(key_t kKey,int iFlags)
{
  	extern int errno;
  	int iSemDescriptor;

  	if ((iSemDescriptor = semget(kKey,3,iFlags)) == -1)
    		return errno;

  	if (semop(iSemDescriptor,opUnlockSemForWrite,1) == -1)
    		return errno;

  	return SALIR_OK;
}



