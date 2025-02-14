#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/time.h>
#include <sys/shm.h>
#include <sqlca.h>
#include "GenORA.h"
#include <pthread.h>
#include <predefs.h>

#include "tipos.h"
#include "tablas.h"
#include "shared.h"
#include "carga_inicial.h"
#include "semap.h"
#include "general.h"

#include <trazafact.h>

int 	ciclo=0;
int		factura=0;
long 	lClienteIni=-1;
long 	lClienteFin=0;
char 	tipFactura[10]="ciclo";
char    szSysDate[15]="";
char    szFecEmision[15]="";

char    szHostID [21]="";

/*******************************************************************************
*MODULO			: Carga_Inicial.c
*Analista Responsable	: THALES-IS
*Programador		: THALES-IS
*Fecha de Programacion	: Marzo 2004
*Version		: V.1.00
********************************************************************************/

int main (int argc, char *argv[])
{
	int iRet = 0;
	int iError = 0;
	char szUserIni[61],szUser[31],szPass[31];
	extern int   opterr;
  	extern int   optopt;
  	extern char* optarg;
  	char opt[]="u:c:v:t:n:p:l:e:f:s:m:a:b:q:r:d:g:h:";
  	int iOpt = 0;
  	BOOL MemShared=FALSE;
  	BOOL Usuario=FALSE;
  	BOOL Ciclo=FALSE;
	pthread_t pth_Datos;
	PARAM stParamDatos;
	pthread_t pth_Clientes;
	PARAM stParamClientes;
	pthread_t pth_Anexos;
	PARAM stParamAnexos;
	pthread_t pth_Direcciones;
	PARAM stParamDirecciones;
	pthread_t pth_GrupoCob;
	PARAM stParamGrupoCob;
	pthread_t pth_Unipac;
	PARAM stParamUnipac;
	void *pRet;
	char *psztmp;

	opterr = 0;
  	optopt = 0;
	vfnInitStructGeneral();
	strcpy(szUser,"");
	strcpy(szPass,"");
	strcpy(szUserIni,"");

	long 	plClienteIni=0;
	long 	plClienteFin=0;

  	memset(szUser,0x00,sizeof(szUser));

	while ( (iOpt=getopt(argc,argv,opt) ) !=EOF)
	{
    		switch (iOpt)
    		{
    			case 'u':
            		if ( strlen (optarg) )
                	{
                      		strcpy (szUserIni,optarg);
                      		Usuario=TRUE;
                      		fprintf(stderr,"-u %s ",szUserIni);
                	}
                	break;
            		case 'm':
            		if ( strcmp (optarg,"c") == 0)
                	{
                		MemShared=TRUE;
                    		fprintf (stderr,"-mc ");
                	}
                	break;
            		case 'c':
            		if ( strlen (optarg) )
                	{
                      		factura=(atoi(optarg) > 0)?atoi(optarg):0;
                      		Ciclo=TRUE;
                      		fprintf(stderr,"-c %s ",optarg);
                	}
                	break;
            		case 'g':
                 	if ( strlen (optarg) )
                 	{
                       		lClienteIni = atol (optarg) ;
                       		fprintf (stderr,"-g %ld ", atol (optarg));
                 	}
                 	break;
            		case 'h':
                 	if ( strlen (optarg) )
                 	{
                       		lClienteFin = atol (optarg) ;
                       		fprintf (stderr,"-h %ld ", atol (optarg));
                 	}
                 	break;
            		case 't':
            		if ( strlen (optarg) )
                 	{
                     		if ( !strcmp (optarg,"ciclo") )
                     		{
                           		strcpy(tipFactura,"ciclo");
                           		fprintf (stderr,"-t %s ",tipFactura);
                     		}
                 	}
                 	break;
    		}
    	}

	if(MemShared!=TRUE)
	{
		fprintf(stdout,"\n[CARGA INICIAL] - No se utilizara memoria compartida.\nSalida normal.\n");
		return(0);
	}
	if(Usuario!=TRUE)
	{
		fprintf(stderr,"\n[CARGA INICIAL] - No se ingreso el USERNAME de la base.\n");
		return(-1);
	}
	else
	{
		if ( (psztmp=(char *)strstr (szUserIni,"/"))==(char *)NULL)
     		{
        		fprintf (stderr,"\n[CARGA INICIAL] - Usuario Oracle no Valido\n");
           		return (-1);
     		}
     		else
     		{
        		strncpy (szUser,szUserIni,psztmp-szUserIni);
        		strcpy  (szPass,psztmp+1);
     		}
	}
	if(Ciclo!=TRUE)
	{
		fprintf(stdout,"\n[CARGA INICIAL] - No se ha ingresado el ciclo de facturacion.\n");
		return(-1);
	}
	else
	{
		if(factura==0)
		{
			fprintf(stdout,"\n[CARGA INICIAL] - El ciclo es 0.\n");
			return(-1);
		}
	}
	if((lClienteFin<=lClienteIni))
	{
		fprintf(stdout,"\n[CARGA INICIAL] - El cliente final debe ser mayor que el cliente inicial.\n");
		return(-1);
	}

	ifnInitORATh(szUser,szPass,&ciclo,factura,szSysDate,szFecEmision);
	if(ciclo==-1){
        	fprintf(stdout,"\n[CARGA INICIAL] - No se pudo obtener el codigo del ciclo a procesar (COD_CICLO).\n");
		return(-1);
	}


	fprintf(stdout,"\n[CARGA INICIAL] - Validando ejecucion por Host ...\n");
	if (!ifnGetHostId (szHostID))
	{
		if (!iGetRangosHost (szHostID, factura, &plClienteIni, &plClienteFin))
		{
			lClienteIni = plClienteIni;
			lClienteFin = plClienteFin;
		}
	}


	fprintf(stdout,"\n[CARGA INICIAL] - Procesando tablas en memoria compartida...\n");

	fprintf(stdout, "\n\n - Bloqueo del semaforo del administrador de memoria");
  	if ( (iError = ifnLockSemForWrite(TaS.kSemKey, TaS.SemPerms)) != SALIR_OK)
  	{
    		fprintf(stderr, "\n\nERROR(ifnProcesar): "
            		"Error al intentar bloquear los semaforos de escritura"
            		"\n\t Error:[%s]", strerror(iError));
    			return ERROR_SEM_LOCK;
  	}
  	fprintf(stdout, "\n - Semaforo del administrador de memoria bloqueado");
  	fprintf(stdout, "\n - Comienza la lectura de tablas");

	stParamClientes.p1 = szUser;
	stParamClientes.p2 = szPass;
	if (iRet = pthread_create(&pth_Clientes, NULL, fncClientes, &stParamClientes))
	{
  		printf( "\n\nERROR(main): \n\tal lanzar Thread CLIENTES [%s]",strerror(iRet));
  		return -1;
	}

	stParamDatos.p1 = szUser;
	stParamDatos.p2 = szPass;
	if (iRet = pthread_create(&pth_Datos, NULL, fncDatos, &stParamDatos))
	{
  		printf( "\n\nERROR(main): \n\tal lanzar Thread DATOS [%s]",strerror(iRet));
  		return -1;
	}


	stParamAnexos.p1 = szUser;
	stParamAnexos.p2 = szPass;
	if (iRet = pthread_create(&pth_Anexos, NULL, fncAnexos, &stParamAnexos))
	{
  		printf( "\n\nERROR(main): \n\tal lanzar Thread ANEXOS [%s]",strerror(iRet));
  		return -1;
	}

	stParamDirecciones.p1 = szUser;
	stParamDirecciones.p2 = szPass;
	if (iRet = pthread_create(&pth_Direcciones, NULL, fncDirecciones, &stParamDirecciones))
	{
  		printf( "\n\nERROR(main): \n\tal lanzar Thread Direcciones [%s]",strerror(iRet));
  		return -1;
	}

	stParamGrupoCob.p1 = szUser;
	stParamGrupoCob.p2 = szPass;
	if (iRet = pthread_create(&pth_GrupoCob, NULL, fncGrupoCob, &stParamGrupoCob))
	{
  		printf( "\n\nERROR(main): \n\tal lanzar Thread GrupoCob [%s]",strerror(iRet));
  		return -1;
	}

	stParamUnipac.p1 = szUser;
	stParamUnipac.p2 = szPass;
	if (iRet = pthread_create(&pth_Unipac, NULL, fncUnipac, &stParamUnipac))
	{
  		printf( "\n\nERROR(main): \n\tal lanzar Thread Unipac [%s]",strerror(iRet));
  		return -1;
	}

	sleep(5);

	pthread_join( pth_Datos, &pRet);
	if (!pRet)
	{
		printf( "\n\nERROR(main):\n\tError en retorno Thread de Datos");
		return -1;
	}
	
/* bloqueo para evitar colicion de conexiones */
	pthread_mutex_init(&mutexIO, NULL);	

	pthread_join( pth_Clientes, &pRet);
	if (!pRet)
	{
		printf( "\n\nERROR(main):\n\tError en retorno Thread de Datos");
		return -1;
	}

	pthread_join( pth_Anexos, &pRet);
	if (!pRet)
	{
		printf( "\n\nERROR(main):\n\tError en retorno Thread de Anexos");
		return -1;
	}

	pthread_join( pth_Direcciones, &pRet);
	if (!pRet)
	{
		printf( "\n\nERROR(main):\n\tError en retorno Thread de Direcciones");
		return -1;
	}

	pthread_join( pth_GrupoCob, &pRet);
	if (!pRet)
	{
		printf( "\n\nERROR(main):\n\tError en retorno Thread de GrupoCob");
		return -1;
	}

	pthread_join( pth_Unipac, &pRet);
	if (!pRet)
	{
		printf( "\n\nERROR(main):\n\tError en retorno Thread de Unipac");
		return -1;
	}

	iRet = ifnCopiarShared();
	if (iRet)
	{
		vfnLog(FILE_BOTH, "Error en ifnCopiarShared\n");
		return 5;
	}

  	fprintf(stdout, "\n\n - Deslockeando semaforos");
  	if ( (iError = ifnUnlockSemForWrite(TaS.kSemKey, TaS.SemPerms)) != SALIR_OK)
  	{
    		fprintf(stderr, "\n\nERROR(ifnProcesar): "
            		"Error al intentar desbloquear los semaforos de escritura"
            		"\n\t Error:[%s]", strerror(iError));
    		return ERROR_SEM_UNLOCK;
  	}
  	
/* bloqueo para evitar colision de conexiones */
  	pthread_mutex_destroy(&mutexIO);  	
  	
  	fprintf(stdout, "\n - Semaforos Deslockeados\n\n");

	return 0;
}

/******************************************************************************
Funcion         :       ifnCopiarShared
*******************************************************************************/

int ifnCopiarShared(void)
{
	int iCont = 0;
	int iRet = 0;
	int iError = 0;
	int iDescriptor = 0;
	long j=0;
	long i=0;
	BOOL bFound=FALSE;

	/* ----------------------------------------------------- */
	/* MAS-05062 FAC-Estabilización de la Facturación en TMC */
	/* Se optimiza pareo de arreglos de memoria compartida   */
	/* ----------------------------------------------------- */
	i=0;
	j=0;
    while(i<TaS.lFacClientes && j<TaS.lFacCiclo)
	{
		if(TaS.pstlFacClientes[i].lCodCliente==TaS.pstlFacCiclo[j].lCodCliente)
		{
			TaS.pstlFacClientes[i].lRowNum=j;
			i++;
			j++;
		}
		else
		{
			if(TaS.pstlFacClientes[i].lCodCliente > TaS.pstlFacCiclo[j].lCodCliente)
			{
				j++;
			}
			else
			{
				if(TaS.pstlFacClientes[i].lCodCliente < TaS.pstlFacCiclo[j].lCodCliente)
				{
					TaS.pstlFacClientes[i].lRowNum = -1;
					i++;
				}
			}
		}
	}
	/* ----------------------------------------------------- */
	/* MAS-05062 FAC-Estabilización de la Facturación en TMC */
	/* Se optimiza pareo de arreglos de memoria compartida   */
	/* ----------------------------------------------------- */
	i=0;
	j=0;
	while (i<TaS.lFacClientes && j<TaS.lGeCargos)
	{
		if(TaS.pstlFacClientes[i].lCodCliente == TaS.pstlGeCargos[j].lCodCliente)
		{
			TaS.pstlFacClientes[i].lCargos=j;
			i++;
			j++;
		}
		else
		{
			if(TaS.pstlFacClientes[i].lCodCliente > TaS.pstlGeCargos[j].lCodCliente)
			{
				j++;
			}
			else
			{
				if(TaS.pstlFacClientes[i].lCodCliente < TaS.pstlGeCargos[j].lCodCliente)
				{
					TaS.pstlFacClientes[i].lCargos= -1;
					i++;
				}
			}
		}
	}
	/* ----------------------------------------------------- */
	/* MAS-05062 FAC-Estabilización de la Facturación en TMC */
	/* Se optimiza pareo de arreglos de memoria compartida   */
	/* ----------------------------------------------------- */
	i=0;
	j=0;
	while(i<TaS.lFacClientes && j<TaS.lGeCatImpClientes)
	{
		if(TaS.pstlFacClientes[i].lCodCliente==TaS.pstlGeCatImpClientes[j].lCodCliente)
	    {
            TaS.pstlFacClientes[i].iCodCatImpos=TaS.pstlGeCatImpClientes[j].iCodCatImpos;
			strcpy(TaS.pstlFacClientes[i].szIndOrdenTotal,TaS.pstlGeCatImpClientes[j].szIndOrdenTotal);
			i++;
			j++;
		}
		else
		{
			if(TaS.pstlFacClientes[i].lCodCliente > TaS.pstlGeCatImpClientes[j].lCodCliente)
			{
				j++;
			}
			else
			{
				if(TaS.pstlFacClientes[i].lCodCliente < TaS.pstlGeCatImpClientes[j].lCodCliente)
				{
		            TaS.pstlFacClientes[i].iCodCatImpos = -1;
					TaS.pstlFacClientes[i].szIndOrdenTotal[0] = '\0';
					i++;
				}
			}
		}
	}
	/* ----------------------------------------------------- */
	/* MAS-05062 FAC-Estabilización de la Facturación en TMC */
	/* Se optimiza pareo de arreglos de memoria compartida   */
	/* ----------------------------------------------------- */
	i=0;
	j=0;
    while(i<TaS.lFacClientes && j<TaS.lGeUnipac)
	{
		if(TaS.pstlFacClientes[i].lCodCliente==TaS.pstlGeUnipac[j].lCodCliente)
		{
			strcpy(TaS.pstlFacClientes[i].szCodBancoUniPac,TaS.pstlGeUnipac[j].szCodBanco);
			i++;
			j++;
		}
		else
		{
			if(TaS.pstlFacClientes[i].lCodCliente > TaS.pstlGeUnipac[j].lCodCliente)
			{
				j++;
			}
			else
			{
				if(TaS.pstlFacClientes[i].lCodCliente < TaS.pstlGeUnipac[j].lCodCliente)
				{
					TaS.pstlFacClientes[i].szCodBancoUniPac[0] = '\0';
					i++;
				}
			}
		}
	}

	i=0;
	if (TaS.pstlGeDirecciones != NULL)
	{
		for(j=0;j<TaS.lFacClientes;j++)
		{
			strcpy(TaS.pstlFacClientes[j].szCodRegion_1,TaS.pstlGeDirecciones[j].szCodRegion);
			strcpy(TaS.pstlFacClientes[j].szCodProvincia_1,TaS.pstlGeDirecciones[j].szCodProvincia);
			strcpy(TaS.pstlFacClientes[j].szCodCiudad_1,TaS.pstlGeDirecciones[j].szCodCiudad);
			strcpy(TaS.pstlFacClientes[j].szCodComuna_1,TaS.pstlGeDirecciones[j].szCodComuna);
			strcpy(TaS.pstlFacClientes[j].szNomCalle_1,TaS.pstlGeDirecciones[j].szNomCalle);
			strcpy(TaS.pstlFacClientes[j].szNumCalle_1,TaS.pstlGeDirecciones[j].szNumCalle);
			strcpy(TaS.pstlFacClientes[j].szNumPiso_1,TaS.pstlGeDirecciones[j].szNumPiso);
		}
	}

	i=0;
	if(TaS.pstlGeDirecciones2 != NULL)
	{
		for(j=0;j<TaS.lFacClientes;j++)
		{
			strcpy(TaS.pstlFacClientes[j].szCodRegion_3,TaS.pstlGeDirecciones2[j].szCodRegion);
			strcpy(TaS.pstlFacClientes[j].szCodProvincia_3,TaS.pstlGeDirecciones2[j].szCodProvincia);
			strcpy(TaS.pstlFacClientes[j].szCodCiudad_3,TaS.pstlGeDirecciones2[j].szCodCiudad);
			strcpy(TaS.pstlFacClientes[j].szCodComuna_3,TaS.pstlGeDirecciones2[j].szCodComuna);
			strcpy(TaS.pstlFacClientes[j].szNomCalle_3,TaS.pstlGeDirecciones2[j].szNomCalle);
			strcpy(TaS.pstlFacClientes[j].szNumCalle_3,TaS.pstlGeDirecciones2[j].szNumCalle);
			strcpy(TaS.pstlFacClientes[j].szNumPiso_3,TaS.pstlGeDirecciones2[j].szNumPiso);
		}
	}

	fprintf(stdout, "\n - Lockeo de semaforo de datos y espera de lectores");
  	iError = ifnLockSemDataAndWaitForReaders(TaS.kSemKey, TaS.SemPerms);
  	if (iError != SALIR_OK)
  	{
    		fprintf(stderr, "\n\nERROR(ifnProcesar): "
            		"Error al intentar bloquear los semaforos de escritura"
            		"\n y esperar por los facturadores"
            		"\n\t Error:[%s]", strerror(iError));
    		return ERROR_SEM_LOCK_AND_WAIT;
  	}

	printf("\n\nDatos leidos, se procede a copiar a la shared......\n");
	sleep(5);

  	if ((iError = ifnOpenShared(TaS.kTableKey,MIN_SHARED,TaS.SharedPerms,&TaS.iTableDescriptor)) == SALIR_OK)
  	{
    		if (ifnRemoveShared(TaS.iTableDescriptor) != SALIR_OK)
    		{
      			fprintf(stderr, "\n\nERROR(ifnProcesar): "
              			"Error al intentar eliminar la tabla primaria"
              			"\n\t Error:[%s]", strerror(iError));
      			return 3;
    		}
  	}

  	if ((iError = ifnOpenShared(TaS.kTableKey,sizeof(DATA_TABLE)*NUM_SHARED_TABLES,
          			    TaS.SharedPerms | IPC_CREAT,&TaS.iTableDescriptor)) != SALIR_OK)
  	{
    		fprintf(stderr, "\n\nERROR(ifnProcesar):"
      			"\n Imposible conseguir memoria compartida"
      			"\n Error: [%s]", strerror(iError));
    		return 3;
  	}

  	if ((iError = ifnAttachShared(TaS.iTableDescriptor,0,(void *)&TaS.pDataTable)) != SALIR_OK)
  	{
    		fprintf(stderr, "\n\nERROR(ifnProcesar):"
      			"\n Imposible mapear memoria compartida"
      			"\n Error: [%s]", strerror(iError));
    		return 3;
  	}

  	for (iCont = 0 ; iCont < NUM_SHARED_TABLES ; iCont++)
  	{
    		TaS.pDataTable[iCont].iCompartido = MODE_NO_DATA;
    		memset(TaS.pDataTable[iCont].szTableName, '\0',sizeof(TaS.pDataTable[iCont].szTableName));
    		TaS.pDataTable[iCont].kTableKey = TaS.kTableKey + iCont + 1;
    		TaS.pDataTable[iCont].iDescriptor = -1;
    		TaS.pDataTable[iCont].lTotalBytes = 0;
    		TaS.pDataTable[iCont].lTotalRegistros = 0;
    		memset(TaS.pDataTable[iCont].szFechaAct, ' ',sizeof(TaS.pDataTable[iCont].szFechaAct)-1);
    		TaS.pDataTable[iCont].szFechaAct[sizeof(TaS.pDataTable[iCont].szFechaAct)-1] = '\0';
  	}
/*
	if (!bfnCargarShared("GE_TIPIMPUES"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [GE_TIPIMPUES]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}
*/
	if (!bfnCargarShared("GE_IMPUESTOS"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [GE_IMPUESTOS]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("FAC_CLIENTES"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [FAC_CLIENTES]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("CICLOCLI"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [CICLOCLI]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("CARGOS"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [CARGOS]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("CABCUOTAS"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [CABCUOTAS]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("TACONCEPFACT"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [TACONCEPFACT]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("CONCEPTO"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [CONCEPTO]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("CONCEPTO_MI"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [CONCEPTO_MI]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("RANGOTABLA"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [RANGOTABLA]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("LIMCREDITOS"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [LIMCREDITOS]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("ACTIVIDADES"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [ACTIVIDADES]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("PROVINCIAS"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [PROVINCIAS]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("REGIONES"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [REGIONES]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("CATIMPOSITIVA"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [CATIMPOSITIVA]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("ZONACIUDAD"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [ZONACIUDAD]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("ZONAIMPOSITIVA"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [ZONAIMPOSITIVA]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("GRPSERCONC"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [GRPSERCONC]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("CONVERSION"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [CONVERSION]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("DOCUMSUCURSAL"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [DOCUMSUCURSAL]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("LETRAS"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [LETRAS]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("GRUPOCOB"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [GRUPOCOB]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("TARIFAS"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [TARIFAS]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("ACTUASERV"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [ACTUASERV]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("CUOTAS"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [CUOTAS]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("FACTCARRIERS"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [FACTCARRIERS]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("CUADCTOPLAN"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [CUADCTOPLAN]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("CTOPLAN"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [CTOPLAN]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("PLANCTOPLAN"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [PLANCTOPLAN]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("ARRIENDO"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [ARRIENDO]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("CARGOSBASICO"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [CARGOSBASICO]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("OPTIMO"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [OPTIMO]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("FERIADOS"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [FERIADOS]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("PLANTARIF"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [PLANTARIF]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("PENALIZA"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [PENALIZA]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("OFICINA"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [OFICINA]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}

	if (!bfnCargarShared("FACTCOBR"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [FACTCOBR]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}
	
	if (!bfnCargarShared("CARGOSRECURRENTES"))                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [CARGOSRECURRENTES]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}


/* rao
	if (!bfnCargarShared("DETPLANDESC"))
	{
    		fprintf(stdout, "\n\nERROR(ifnCopiarShared):"
      			"\nError al compartir datos de [DETPLANDESC]"
      			"\nError: [%s]", strerror(iRet));
    		return FALSE;
	}
*/

	iCont = (TaS.kTableKey+NUM_SHARED_TABLES+1);
  	while(1)
  	{

    		if (ifnOpenShared(iCont,MIN_SHARED,TaS.SharedPerms,&iDescriptor) == SALIR_OK)
    		{
      			ifnRemoveShared(iDescriptor);
      			iCont++;
    		}
    		else
    		{
      			if (iCont >= (TaS.kTableKey+NUM_SHARED_TABLES))
        		break;
      			else
        		iCont++;
    		}
  	}

	fprintf(stdout, "\n\n TOTAL DE MEMORIA LEIDO:  [%ld]", TaS.lMemoriaTotal);

  	vfnImprimirDetalleMemoria(stdout, TaS.pDataTable);

  	return SALIR_OK;
}

/******************************************************************************
Funcion         :       bfnCargarShared
*******************************************************************************/

BOOL bfnCargarShared(char *szTable)
{
  	int iRet;
/*
  	if (!strcmp("GE_TIPIMPUES", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: TIPIMPUES");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_TIPIMPUES,"GE_TIPIMPUES",
                    			 (TaS.lGeTipImpues*sizeof(TIPIMPUES)),
                    			  TaS.lGeTipImpues,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGeTipImpues)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_TIPIMPUES].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGeTipImpues);
  	}
*/
  	if (!strcmp("GE_IMPUESTOS", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: IMPUESTOS");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_IMPUESTOS,"GE_IMPUESTOS",
                    			 (TaS.lGeImpuestos*sizeof(IMPUESTOS)),
                    			  TaS.lGeImpuestos,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGeImpuestos)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_IMPUESTOS].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGeImpuestos);
  	}

  	if (!strcmp("FAC_CLIENTES", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: FAC_CLIENTES");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_FAC_CLIENTES,"FA_CLIENTES",
                    			 (TaS.lFacClientes*sizeof(FAC_CLIENTES)),
                    			  TaS.lFacClientes,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlFacClientes)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_FAC_CLIENTES].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlFacClientes);
  	}

  	if (!strcmp("CICLOCLI", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: CICLOCLI");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_CICLOCLI,"FA_ABONADOS",
                    			 (TaS.lFacCiclo*sizeof(CICLOCLI)),
                    			  TaS.lFacCiclo,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlFacCiclo)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_CICLOCLI].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlFacCiclo);
  	}

	  	if (!strcmp("CARGOS", szTable))
	  	{
	    		fprintf(stdout,"\n\t\tCopiando: CARGOS");
	    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_CARGOS,"GE_CARGOS",
	                    			 (TaS.lGeCargos*sizeof(CARGOS)),
	                    			  TaS.lGeCargos,&TaS.lMemoriaTotal,
	                    			 (TaS.SharedPerms | IPC_CREAT),
	                    			 (void *) TaS.pstlGeCargos)) != SALIR_OK)
	    		{
	      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
	        			"\nError al compartir datos de [%s]"
	        			"\nError: [%s]", TaS.pDataTable[ID_CARGOS].szTableName,
	          			strerror(iRet));
	      			return FALSE;
	    		}
	    		free(TaS.pstlGeCargos);
	  	}

  	if (!strcmp("CABCUOTAS", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: CABCUOTAS");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_CABCUOTAS,"FA_CABCUOTAS",
                    			 (TaS.lGeCabCuotas*sizeof(CABCUOTAS)),
                    			  TaS.lGeCabCuotas,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGeCabCuotas)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_CABCUOTAS].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGeCabCuotas);
  	}

  	if (!strcmp("TACONCEPFACT", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: TACONCEPFACT");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_TACONCEPFACT,"TA_CONCEPFACT",
                    			 (TaS.lGeTaConcepFact*sizeof(TACONCEPFACT)),
                    			  TaS.lGeTaConcepFact,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGeTaConcepFact)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_TACONCEPFACT].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGeTaConcepFact);
  	}

	if (!strcmp("CONCEPTO", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: CONCEPTO");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_CONCEPTO,"FA_CONCEPTOS",
                    			 (TaS.lGeConceptos*sizeof(CONCEPTO)),
                    			  TaS.lGeConceptos,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGeConceptos)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_CONCEPTO].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGeConceptos);
  	}

	if (!strcmp("CONCEPTO_MI", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: CONCEPTO_MI");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_CONCEPTO_MI,"GE_MULTIIDIOMA",
                    			 (TaS.lGeConceptos_Mi*sizeof(CONCEPTO_MI)),
                    			  TaS.lGeConceptos_Mi,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGeConceptos_Mi)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_CONCEPTO_MI].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGeConceptos_Mi);
  	}

  	if (!strcmp("RANGOTABLA", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: RANGOTABLA");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_RANGOTABLA,"FA_RANGO_TABLA",
                			 (TaS.lGeRangoTabla*sizeof(RANGOTABLA)),
                			  TaS.lGeRangoTabla,&TaS.lMemoriaTotal,
                			 (TaS.SharedPerms | IPC_CREAT),
                			 (void *) TaS.pstlGeRangoTabla)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_RANGOTABLA].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGeRangoTabla);
  	}

  	if (!strcmp("LIMCREDITOS", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: LIMCREDITOS");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_LIMCREDITOS,"CO_LIMCREDITOS",
                    			 (TaS.lGeLimCreditos*sizeof(LIMCREDITOS)),
                    			  TaS.lGeLimCreditos,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGeLimCreditos)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_LIMCREDITOS].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGeLimCreditos);
  	}

  	if (!strcmp("ACTIVIDADES", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: ACTIVIDADES");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_ACTIVIDADES,"GE_ACTIVIDADES",
                    			 (TaS.lGeActividades*sizeof(ACTIVIDADES)),
                    			  TaS.lGeActividades,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGeActividades)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_ACTIVIDADES].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
   		 free(TaS.pstlGeActividades);
  	}

  	if (!strcmp("PROVINCIAS", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: PROVINCIAS");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_PROVINCIAS,"GE_PROVINCIAS",
                    			 (TaS.lGeProvincias*sizeof(PROVINCIAS)),
                    			  TaS.lGeProvincias,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGeProvincias)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_PROVINCIAS].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGeProvincias);
  	}

  	if (!strcmp("REGIONES", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: REGIONES");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_REGIONES,"GE_REGIONES",
                    			 (TaS.lGeRegiones*sizeof(REGIONES)),
                    			  TaS.lGeRegiones,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGeRegiones)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_REGIONES].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGeRegiones);
  	}

  	if (!strcmp("CATIMPOSITIVA", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: CATIMPOSITIVA");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_CATIMPOSITIVA,"GE_CATIMPOSITIVA",
                    			 (TaS.lGeCatImpositiva*sizeof(CATIMPOSITIVA)),
                    			  TaS.lGeCatImpositiva,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGeCatImpositiva)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_CATIMPOSITIVA].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGeCatImpositiva);
  	}

  	if (!strcmp("ZONACIUDAD", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: ZONACIUDAD");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_ZONACIUDAD,"GE_ZONACIUDAD",
                    			 (TaS.lGeZonaCiudad*sizeof(ZONACIUDAD)),
                    			  TaS.lGeZonaCiudad,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGeZonaCiudad)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_ZONACIUDAD].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGeZonaCiudad);
  	}

	if (!strcmp("ZONAIMPOSITIVA", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: ZONAIMPOSITIVA");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_ZONAIMPOSITIVA,"GE_ZONAIMPOSITIVA",
                    			 (TaS.lGeZonaImpositiva*sizeof(ZONAIMPOSITIVA)),
                    			  TaS.lGeZonaImpositiva,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGeZonaImpositiva)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_ZONAIMPOSITIVA].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGeZonaImpositiva);
  	}

  	if (!strcmp("GRPSERCONC", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: GRPSERCONC");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_GRPSERCONC,"FA_GRPSERCONC",
                    			 (TaS.lGeGrpSerConc*sizeof(GRPSERCONC)),
                    			  TaS.lGeGrpSerConc,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGeGrpSerConc)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_GRPSERCONC].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGeGrpSerConc);
  	}

  	if (!strcmp("CONVERSION", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: CONVERSION");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_CONVERSION,"GE_CONVERSION",
                    			 (TaS.lGeConversion*sizeof(CONVERSION)),
                    			  TaS.lGeConversion,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGeConversion)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_CONVERSION].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGeConversion);
  	}

  	if (!strcmp("DOCUMSUCURSAL", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: DOCUMSUCURSAL");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_DOCUMSUCURSAL,"AL_DOCUM_SUCURSAL",
                    			 (TaS.lGeDocumSucursal*sizeof(DOCUMSUCURSAL)),
                    			  TaS.lGeDocumSucursal,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGeDocumSucursal)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_DOCUMSUCURSAL].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGeDocumSucursal);
  	}

  	if (!strcmp("LETRAS", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: LETRAS");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_LETRAS,"GE_LETRAS",
                    			 (TaS.lGeLetras*sizeof(LETRAS)),
                    			  TaS.lGeLetras,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGeLetras)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_LETRAS].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGeLetras);
  	}

  	if (!strcmp("GRUPOCOB", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: GRUPOCOB");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_GRUPOCOB,"FA_GRUPOCOB",
                    			 (TaS.lGeGrupoCob*sizeof(GRUPOCOB)),
                    			  TaS.lGeGrupoCob,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGeGrupoCob)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_GRUPOCOB].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGeGrupoCob);
  	}

  	if (!strcmp("TARIFAS", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: TARIFAS");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_TARIFAS,"GA_TARIFAS",
                    			 (TaS.lGeTarifas*sizeof(TARIFAS)),
                    			  TaS.lGeTarifas,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGeTarifas)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_TARIFAS].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGeTarifas);
  	}

  	if (!strcmp("ACTUASERV", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: ACTUASERV");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_ACTUASERV,"GA_ACTUASERV",
                    			 (TaS.lGeActuaServ*sizeof(ACTUASERV)),
                    			  TaS.lGeActuaServ,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGeActuaServ)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_ACTUASERV].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGeActuaServ);
  	}

  	if (!strcmp("CUOTAS", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: CUOTAS");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_CUOTAS,"FA_CUOTAS",
                    			 (TaS.lGeCuotas*sizeof(CUOTAS)),
                    			  TaS.lGeCuotas,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGeCuotas)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_CUOTAS].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGeCuotas);
  	}

  	if (!strcmp("FACTCARRIERS", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: FACTCARRIERS");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_FACTCARRIERS,"FA_FACTCARRIERS",
                    			 (TaS.lGeFactCarriers*sizeof(FACTCARRIERS)),
                    			  TaS.lGeFactCarriers,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGeFactCarriers)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_FACTCARRIERS].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGeFactCarriers);
  	}

  	if (!strcmp("CUADCTOPLAN", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: CUADCTOPLAN");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_CUADCTOPLAN,"VE_CUADCTOPLAN",
                    			 (TaS.lGeCuadCtoPlan*sizeof(CUADCTOPLAN)),
                    			  TaS.lGeCuadCtoPlan,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGeCuadCtoPlan)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_CUADCTOPLAN].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGeCuadCtoPlan);
  	}

  	if (!strcmp("CTOPLAN", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: CTOPLAN");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_CTOPLAN,"VE_CTOPLAN",
                    			 (TaS.lGeCtoPlan*sizeof(CTOPLAN)),
                    			  TaS.lGeCtoPlan,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGeCtoPlan)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_CTOPLAN].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGeCtoPlan);
  	}

  	if (!strcmp("PLANCTOPLAN", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: PLANCTOPLAN");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_PLANCTOPLAN,"VE_PLAN_CTOPLAN",
                    			 (TaS.lGePlanCtoPlan*sizeof(PLANCTOPLAN)),
                    			  TaS.lGePlanCtoPlan,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGePlanCtoPlan)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_PLANCTOPLAN].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGePlanCtoPlan);
  	}

  	if (!strcmp("ARRIENDO", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: ARRIENDO");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_ARRIENDO,"FA_ARRIENDO",
                    			 (TaS.lGeArriendo*sizeof(ARRIENDO)),
                    			  TaS.lGeArriendo,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGeArriendo)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_ARRIENDO].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGeArriendo);
  	}

  	if (!strcmp("CARGOSBASICO", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: CARGOSBASICO");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_CARGOSBASICO,"TA_CARGOSBASICO",
                    			 (TaS.lGeCargosBasico*sizeof(CARGOSBASICO)),
                    			  TaS.lGeCargosBasico,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGeCargosBasico)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_CARGOSBASICO].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGeCargosBasico);
  	}

  	if (!strcmp("OPTIMO", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: OPTIMO");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_OPTIMO,"FA_OPTIMO",
                    			 (TaS.lGeOptimo*sizeof(OPTIMO)),
                    			  TaS.lGeOptimo,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGeOptimo)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_OPTIMO].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGeOptimo);
  	}

  	if (!strcmp("FERIADOS", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: FERIADOS");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_FERIADOS,"TA_DIASFEST",
                    			 (TaS.lGeFeriados*sizeof(FERIADOS)),
                    			  TaS.lGeFeriados,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGeFeriados)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_FERIADOS].szTableName,
          			strerror(iRet));
      				return FALSE;
    		}
    		free(TaS.pstlGeFeriados);
  	}

  	if (!strcmp("PLANTARIF", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: PLANTARIF");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_PLANTARIF,"TA_PLANTARIF",
                    			 (TaS.lGePlanTarif*sizeof(PLANTARIF)),
                    			  TaS.lGePlanTarif,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGePlanTarif)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_PLANTARIF].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGePlanTarif);
  	}

  	if (!strcmp("PENALIZA", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: PENALIZA");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_PENALIZA,"CA_PENALIZACIONES",
                    			 (TaS.lGePenalizaciones*sizeof(PENALIZA)),
                    			  TaS.lGePenalizaciones,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGePenalizaciones)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_PENALIZA].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGePenalizaciones);
  	}

	if (!strcmp("OFICINA", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: OFICINA");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_OFICINA,"GE_OFICINAS",
                    			 (TaS.lGeOficina*sizeof(OFICINA)),
                    			  TaS.lGeOficina,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGeOficina)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_OFICINA].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGeOficina);
  	}

	if (!strcmp("FACTCOBR", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: FACTCOBR");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_FACTCOBR,"FA_FACTCOBR",
                    			 (TaS.lGeFactCobr*sizeof(FACTCOBR)),
                    			  TaS.lGeFactCobr,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGeFactCobr)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_FACTCOBR].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGeFactCobr);
  	}
  	
  	if (!strcmp("CARGOSRECURRENTES", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: CARGOSRECURRENTES");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_CARGOSRECURRENTES,"PF_CARGOS_PRODUCTOS_TD",
                    			 (TaS.lGeCargosRecurrentes*sizeof(CARGOSRECURRENTES)),
                    			  TaS.lGeCargosRecurrentes,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGeCargosRecurrentes)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_CARGOSRECURRENTES].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGeCargosRecurrentes);
  	}

  	
/* rao
	if (!strcmp("DETPLANDESC", szTable))
  	{
    		fprintf(stdout,"\n\t\tCopiando: DETPLANDESC");
    		if( (iRet=ifnCreateShared(TaS.pDataTable, ID_DETPLANDESC,"FAD_DETPLANDESC",
                    			 (TaS.lGeDetPlanDesc*sizeof(DETPLANDESC)),
                    			  TaS.lGeDetPlanDesc,&TaS.lMemoriaTotal,
                    			 (TaS.SharedPerms | IPC_CREAT),
                    			 (void *) TaS.pstlGeDetPlanDesc)) != SALIR_OK)
    		{
      			fprintf(stdout, "\n\nERROR(bfnCargarTablasShared):"
        			"\nError al compartir datos de [%s]"
        			"\nError: [%s]", TaS.pDataTable[ID_DETPLANDESC].szTableName,
          			strerror(iRet));
      			return FALSE;
    		}
    		free(TaS.pstlGeDetPlanDesc);
  	}

*/
  	return TRUE;
}

/******************************************************************************
Funcion         :       fncDatos
*******************************************************************************/

void *fncDatos(	void* pArg)
{
	PARAM *pstArg = (PARAM*)pArg;
	void* ctxDatos;
	int iOra = 0;
	char szUser[100],szPass[100];

	strcpy(szUser,pstArg->p1);
	strcpy(szPass,pstArg->p2);

	if(iOra=ifnConnectORATh(szUser,szPass,&ctxDatos))
	{
		printf( "\n\nERROR(main): al conectar Thread de Datos a la base\n");
		return (void*)FALSE;
	}

	if (!bfnObtGeCargos(&TaS.lGeCargos, &TaS.pstlGeCargos, ctxDatos, ciclo, lClienteIni, lClienteFin))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGeCargos");
		return (void*)FALSE;
	}

	if (!bfnObtGeCabCuotas(&TaS.lGeCabCuotas,&TaS.pstlGeCabCuotas, ctxDatos))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGeCabCuotas");
		return (void*)FALSE;
	}

	if (!bfnObtGeTaConcepFact(&TaS.lGeTaConcepFact,&TaS.pstlGeTaConcepFact, ctxDatos ))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGeTaConcepFact");
		return (void*)FALSE;
	}

	if (!bfnObtGeConceptos(&TaS.lGeConceptos,&TaS.pstlGeConceptos, ctxDatos, factura))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGeConcepto");
		return (void*)FALSE;
	}

	if (!bfnObtGeConceptos_Mi(&TaS.lGeConceptos_Mi,&TaS.pstlGeConceptos_Mi, ctxDatos))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGeConcepto_Mi");
		return (void*)FALSE;
	}

	if (!bfnObtGeRangoTabla(&TaS.lGeRangoTabla,&TaS.pstlGeRangoTabla, ctxDatos))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGeRangoTabla");
		return (void*)FALSE;
	}

	if (!bfnObtGeLimCreditos(&TaS.lGeLimCreditos,&TaS.pstlGeLimCreditos, ctxDatos))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGeLimCreditos");
		return (void*)FALSE;
	}

	if (!bfnObtGeActividades(&TaS.lGeActividades,&TaS.pstlGeActividades, ctxDatos))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGeActividades");
		return (void*)FALSE;
	}

	if (!bfnObtGeProvincias(&TaS.lGeProvincias,&TaS.pstlGeProvincias, ctxDatos))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGeProvincias");
		return (void*)FALSE;
	}

	if (!bfnObtGeRegiones(&TaS.lGeRegiones,&TaS.pstlGeRegiones, ctxDatos))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGeRegiones");
		return (void*)FALSE;
	}

	if (!bfnObtGeCatImpositiva(&TaS.lGeCatImpositiva,&TaS.pstlGeCatImpositiva, ctxDatos))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGeCatImpositiva");
		return (void*)FALSE;
	}

	if (!bfnObtGeZonaCiudad(&TaS.lGeZonaCiudad,&TaS.pstlGeZonaCiudad, ctxDatos))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGeZonaCiudad");
		return (void*)FALSE;
	}

	if (!bfnObtGeZonaImpositiva(&TaS.lGeZonaImpositiva,&TaS.pstlGeZonaImpositiva, ctxDatos))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGeZonaImpositiva");
		return (void*)FALSE;
	}

	if (!bfnObtGeImpuestos(&TaS.lGeImpuestos,&TaS.pstlGeImpuestos, ctxDatos))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGeImpuestos");
		return (void*)FALSE;
	}
/*
	if (!bfnObtGeTipImpues(&TaS.lGeTipImpues,&TaS.pstlGeTipImpues, ctxDatos))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGeTipImpues");
		return (void*)FALSE;
	}
*/
	if (!bfnObtGeGrpSerConc(&TaS.lGeGrpSerConc,&TaS.pstlGeGrpSerConc, ctxDatos))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGeGrpSerconc");
		return (void*)FALSE;
	}

	if (!bfnObtGeConversion(&TaS.lGeConversion,&TaS.pstlGeConversion, ctxDatos))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGeConversion");
		return (void*)FALSE;
	}

	if (!bfnObtGeDocumSucursal(&TaS.lGeDocumSucursal,&TaS.pstlGeDocumSucursal, ctxDatos))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGeDocumSucursal");
		return (void*)FALSE;
	}

	if (!bfnObtGeLetras(&TaS.lGeLetras,&TaS.pstlGeLetras, ctxDatos))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGeLetras");
		return (void*)FALSE;
	}

	if (!bfnObtGeTarifas(&TaS.lGeTarifas,&TaS.pstlGeTarifas, ctxDatos))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGeTarifas");
		return (void*)FALSE;
	}

	if (!bfnObtGeActuaServ(&TaS.lGeActuaServ,&TaS.pstlGeActuaServ, ctxDatos))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGeActuaServ");
		return (void*)FALSE;
	}

	if (!bfnObtGeCuotas(&TaS.lGeCuotas,&TaS.pstlGeCuotas, ctxDatos))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGeCuotas");
		return (void*)FALSE;
	}

	if (!bfnObtGeFactCarriers(&TaS.lGeFactCarriers,&TaS.pstlGeFactCarriers, ctxDatos))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGeFactCarriers");
		return (void*)FALSE;
	}

	if (!bfnObtGeCuadCtoPlan(&TaS.lGeCuadCtoPlan,&TaS.pstlGeCuadCtoPlan, ctxDatos))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGeCuadCtoPlan");
		return (void*)FALSE;
	}

	if (!bfnObtGeCtoPlan(&TaS.lGeCtoPlan,&TaS.pstlGeCtoPlan, ctxDatos))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGeCtoPlan");
		return (void*)FALSE;
	}

	if (!bfnObtGePlanCtoPlan(&TaS.lGePlanCtoPlan,&TaS.pstlGePlanCtoPlan, ctxDatos))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGePlanCtoPlan");
		return (void*)FALSE;
	}

	if (!bfnObtGeArriendo(&TaS.lGeArriendo,&TaS.pstlGeArriendo, ctxDatos))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGeArriendo");
		return (void*)FALSE;
	}

	if (!bfnObtGeCargosBasico(&TaS.lGeCargosBasico,&TaS.pstlGeCargosBasico, ctxDatos, szFecEmision))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGeCargosBasico");
		return (void*)FALSE;
	}

	if (!bfnObtGeOptimo(&TaS.lGeOptimo,&TaS.pstlGeOptimo, ctxDatos))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGeOptimo");
		return (void*)FALSE;
	}

	if (!bfnObtGeFeriados(&TaS.lGeFeriados,&TaS.pstlGeFeriados, ctxDatos))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGeFeriados");
		return (void*)FALSE;
	}

	if (!bfnObtGePlanTarif(&TaS.lGePlanTarif,&TaS.pstlGePlanTarif, ctxDatos, szFecEmision))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGePlanTarif");
		return (void*)FALSE;
	}

	if (!bfnObtGePenalizaciones(&TaS.lGePenalizaciones,&TaS.pstlGePenalizaciones, ctxDatos))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGePenalizaciones");
		return (void*)FALSE;
	}
	
	return (void*)TRUE;
}

/******************************************************************************
Funcion         :       fncClientes
*******************************************************************************/

void *fncClientes(void* pArg)
{
	PARAM *pstArg = (PARAM*)pArg;
	void* ctxClientes;
	int iOra = 0;
	char szUser[100],szPass[100];

	strcpy(szUser,pstArg->p1);
	strcpy(szPass,pstArg->p2);

	if(iOra=ifnConnectORATh(szUser,szPass,&ctxClientes))
	{
		printf( "\n\nERROR(main): al conectar Thread de Clientes a la base\n");
		return (void*)FALSE;
	}

	if (!bfnObtFacClientes(&TaS.lFacClientes, &TaS.pstlFacClientes, ctxClientes, ciclo, lClienteIni, lClienteFin,szFecEmision))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtFacClientes");
		return (void*)FALSE;
	}

/*	if (!bfnObtFacCiclo(&TaS.lFacCiclo, &TaS.pstlFacCiclo, ctxClientes, ciclo, lClienteIni, lClienteFin))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtFacCiclo");
		return (void*)FALSE;
	}

	for(j=0;j<TaS.lFacClientes;j++)
	{
		bFound=FALSE;
		while(i<TaS.lFacCiclo && bFound==FALSE)
		{
			if(TaS.pstlFacClientes[j].lCodCliente==TaS.pstlFacCiclo[i].lCodCliente)
			{
				TaS.pstlFacClientes[j].lRowNum=i;
				bFound=TRUE;
			}
			i++;
		}
	}*/

	return (void*)TRUE;
}

/******************************************************************************
Funcion         :       fncAnexos
*******************************************************************************/

void *fncAnexos(void* pArg)
{
	PARAM *pstArg = (PARAM*)pArg;
	void* ctxAnexos;
	int iOra = 0;
	char szUser[100],szPass[100];

	strcpy(szUser,pstArg->p1);
	strcpy(szPass,pstArg->p2);

	if(iOra=ifnConnectORATh(szUser,szPass,&ctxAnexos))
	{
		printf( "\n\nERROR(main): al conectar Thread de Anexos a la base\n");
		return (void*)FALSE;
	}

        if (!bfnObtCatImpClientes(&TaS.lGeCatImpClientes,&TaS.pstlGeCatImpClientes,ctxAnexos,lClienteIni,lClienteFin,szSysDate,ciclo))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtCatImpClientes");
		return (void*)FALSE;
	}

	if (!bfnObtGeOficina(&TaS.lGeOficina,&TaS.pstlGeOficina, ctxAnexos))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGeOficina");
		return (void*)FALSE;
	}

	return (void*)TRUE;
}

/******************************************************************************
Funcion         :       fncDirecciones
*******************************************************************************/

void *fncDirecciones(void* pArg)
{
	PARAM *pstArg = (PARAM*)pArg;
	void* ctxDirecciones;
	int iOra = 0;
	char szUser[100],szPass[100];

	strcpy(szUser,pstArg->p1);
	strcpy(szPass,pstArg->p2);

	if(iOra=ifnConnectORATh(szUser,szPass,&ctxDirecciones))
	{
		printf( "\n\nERROR(main): al conectar Thread de Direcciones a la base\n");
		return (void*)FALSE;
	}

        if (!bfnObtDirecciones(&TaS.lGeDirecciones, &TaS.pstlGeDirecciones, ctxDirecciones, lClienteIni, lClienteFin, TIPDIRECCION_FACTURA, ciclo))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtDirecciones");
		return (void*)FALSE;
	}

	return (void*)TRUE;
}

/******************************************************************************
Funcion         :       fncGrupoCob
*******************************************************************************/

void *fncGrupoCob(void* pArg)
{
	PARAM *pstArg = (PARAM*)pArg;
	void* ctxGrupoCob;
	int iOra = 0;
	char szUser[100],szPass[100];

	strcpy(szUser,pstArg->p1);
	strcpy(szPass,pstArg->p2);

	if(iOra=ifnConnectORATh(szUser,szPass,&ctxGrupoCob))
	{
		printf( "\n\nERROR(main): al conectar Thread de GrupoCob a la base\n");
		return (void*)FALSE;
	}

        if (!bfnObtFacCiclo(&TaS.lFacCiclo, &TaS.pstlFacCiclo, ctxGrupoCob, ciclo, lClienteIni, lClienteFin))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtFacCiclo");
		return (void*)FALSE;
	}

        if (!bfnObtGeGrupoCob(&TaS.lGeGrupoCob,&TaS.pstlGeGrupoCob, ctxGrupoCob, ciclo))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGeGrupoCob");
		return (void*)FALSE;
	}

	return (void*)TRUE;
}

/******************************************************************************
Funcion         :       fncUnipac
*******************************************************************************/

void *fncUnipac(void* pArg)
{
	PARAM *pstArg = (PARAM*)pArg;
	void* ctxUnipac;
	int iOra = 0;
	char szUser[100],szPass[100];

	strcpy(szUser,pstArg->p1);
	strcpy(szPass,pstArg->p2);

	if(iOra=ifnConnectORATh(szUser,szPass,&ctxUnipac))
	{
		printf( "\n\nERROR(main): al conectar Thread de GrupoCob a la base\n");
		return (void*)FALSE;
	}

    if (!bfnObtCoUnipac(&TaS.lGeUnipac, &TaS.pstlGeUnipac, ctxUnipac, lClienteIni, lClienteFin, ciclo))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtCoUnipac");
		return (void*)FALSE;
	}

	if (!bfnObtDirecciones2(&TaS.lGeDirecciones2, &TaS.pstlGeDirecciones2, ctxUnipac, lClienteIni, lClienteFin, iTIP_CORRESPONDENCIA, ciclo))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtDirecciones2");
		return (void*)FALSE;
	}

    if (!bfnObtGeFactCobr(&TaS.lGeFactCobr,&TaS.pstlGeFactCobr, ctxUnipac))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGeFactCobr");
		return (void*)FALSE;
	}

	if (!bfnObtGeCargosRecurrentes(&TaS.lGeCargosRecurrentes, &TaS.pstlGeCargosRecurrentes, ctxUnipac))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtGeCargosRecurrentes");
		return (void*)FALSE;
	}

    /*if (!bfnObtDetPlanDesc ( &TaS.lGeDetPlanDesc,&TaS.pstlGeDetPlanDesc,ctxUnipac, factura))
	{
		vfnLog(FILE_BOTH, "Error en bfnObtDetPlanDesc");
		return (void*)FALSE;
	}*/
	return (void*)TRUE;
}


