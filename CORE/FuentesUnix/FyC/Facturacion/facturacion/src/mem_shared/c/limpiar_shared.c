#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <sys/types.h>
#include <sys/time.h>
#include <sys/shm.h>
#include <sys/sem.h>
#include <sqlca.h>
#include "GenORA.h"

#include "tipos.h"
#include "tablas.h"
#include "shared.h"
#include "general.h"
#include "mem_shared.h"

#define SIZE 50

/*******************************************************************************
*MODULO			: limpiar_shared.c
*Analista Responsable	: THALES-IS
*Programador		: THALES-IS
*Fecha de Programacion	: Marzo 2004
*Version		: V.1.00
********************************************************************************/
int destruir_semaforo(int sem_id)
{
   int ret=semctl(sem_id,0,IPC_RMID,0);
   fprintf(stdout, "\n(destruir_semaforo)Borrando Semaforo ID : [%d]\n", sem_id);
   return ret;
}
int main()
{
	extern int errno;
	int Id_Semaforo=0;
	int Estado=-1;
	char string[80]="";
	char command[100]="";
	char str[10];
	int i=0;
	long j=0;

	vfnInitStructGeneral();

	Id_Semaforo=semget(TaS.kSemKey,3,0);
	Estado=semctl(Id_Semaforo, 0, IPC_RMID);
	fprintf(stderr,"\n\t- Semáforo de Memoria Compartida ha sido ELIMINADO. Id.:[%d] Ret:[%d]\n\n", Id_Semaforo, Estado);
	fprintf(stdout,"\n\nACCION SEMAFOROS");
	fprintf(stdout,"\n----------------\n");
	if(Estado<0)
	{
		fprintf(stderr,"\n\t- Eliminar conjunto de semaforos: No\n\n");
	}
	else
	{
		fprintf(stderr,"\n\t- Eliminar conjunto de semaforos: Si\n\n");
	}

	fprintf(stdout,"ACCION SEGMENTOS DE MEMORIA COMPARTIDA");
	fprintf(stdout,"\n--------------------------------------\n");

	strcpy(command,"ipcrm -M 0x");
	sprintf(str, "%x", TaS.kTableKey);
	strcat(command,str);
	strcat(command," 2>/dev/null");
	Estado=system(command);
	if(Estado!=0)
	{
		fprintf(stdout,"\n\t- Eliminar TABLA PRIMARIA: No");
	}
	else
	{
		fprintf(stdout,"\n\t- Eliminar TABLA PRIMARIA: Si");
	}

	for(i=0;i<NUM_SHARED_TABLES;i++)
	{
		strcpy(string,"");
		j=TaS.kTableKey+i+1;
		switch(i)
		{
                	case ID_CARGOS:
                                strcpy(string,"CARGOS");
				break;
			case ID_CABCUOTAS:
                                strcpy(string,"CABCUOTAS");
				break;
			case ID_TACONCEPFACT:
                                strcpy(string,"ID_TACONCEPFACT");
				break;
			case ID_CONCEPTO:
                                strcpy(string,"CONCEPTO");
				break;
			case ID_CONCEPTO_MI:
                                strcpy(string,"CONCEPTO_MI");
				break;
			case ID_RANGOTABLA:
                                strcpy(string,"RANGOTABLA");
				break;
			case ID_LIMCREDITOS:
                                strcpy(string,"LIMCREDITOS");
				break;
			case ID_ACTIVIDADES:
                                strcpy(string,"ACTIVIDADES");
				break;
			case ID_PROVINCIAS:
                                strcpy(string,"PROVINCIAS");
				break;
			case ID_REGIONES:
                                strcpy(string,"REGIONES");
				break;
			case ID_CATIMPOSITIVA:
                                strcpy(string,"CATIMPOSITIVA");
				break;
			case ID_ZONACIUDAD:
                                strcpy(string,"ZONACIUDAD");
				break;
			case ID_ZONAIMPOSITIVA:
                                strcpy(string,"ZONAIMPOSITIVA");
				break;
			case ID_IMPUESTOS:
                                strcpy(string,"IMPUESTOS");
				break;
			case ID_TIPIMPUES:
                                strcpy(string,"TIPIMPUES");
				break;
			case ID_GRPSERCONC:
                                strcpy(string,"GRPSERCONC");
				break;
			case ID_CONVERSION:
                                strcpy(string,"CONVERSION");
				break;
			case ID_DOCUMSUCURSAL:
                                strcpy(string,"DOCUMSUCURSAL");
				break;
			case ID_LETRAS:
                                strcpy(string,"LETRAS");
				break;
			case ID_GRUPOCOB:
                                strcpy(string,"GRUPOCOB");
				break;
			case ID_TARIFAS:
                                strcpy(string,"TARIFAS");
				break;
			case ID_ACTUASERV:
                                strcpy(string,"ACTUASERV");
				break;
			case ID_CUOTAS:
                                strcpy(string,"CUOTAS");
				break;
			case ID_FACTCARRIERS:
                                strcpy(string,"FACTCARRIERS");
				break;
			case ID_CUADCTOPLAN:
                                strcpy(string,"CUADCTOPLAN");
				break;
			case ID_CTOPLAN:
                                strcpy(string,"CTOPLAN");
				break;
			case ID_PLANCTOPLAN:
                                strcpy(string,"PLANCTOPLAN");
				break;
			case ID_ARRIENDO:
                                strcpy(string,"ARRIENDO");
				break;
			case ID_CARGOSBASICO:
                                strcpy(string,"CARGOSBASICO");
				break;
			case ID_OPTIMO:
                                strcpy(string,"OPTIMO");
				break;
			case ID_FERIADOS:
                                strcpy(string,"FERIADOS");
				break;
			case ID_PLANTARIF:
                                strcpy(string,"PLANTARIF");
				break;
			case ID_PENALIZA:
                                strcpy(string,"PENALIZA");
				break;
			case ID_FAC_CLIENTES:
                                strcpy(string,"FACCLIENTES");
				break;
			case ID_CICLOCLI:
                                strcpy(string,"FACCICLO");
				break;
			case ID_OFICINA:
                                strcpy(string,"OFICINA");
				break;
			case ID_FACTCOBR:
                                strcpy(string,"FACTCOBR");
				break;
			/*case ID_DETPLANDESC:
                                strcpy(string,"DETPLANDESC");
				break;*/
			case ID_CARGOSRECURRENTES:
                                strcpy(string,"CARGOSRECURRENTES");
				break;

		}
		strcpy(command,"ipcrm -M 0x");
		sprintf(str, "%x", j);
		strcat(command,str);
		strcat(command," 2>/dev/null");
		Estado=system(command);
		if(Estado!=0)
		{
			fprintf(stdout,"\n\t- Eliminar %s: No",string);
		}
		else
		{
			fprintf(stdout,"\n\t- Eliminar %s: Si",string);
		}
	}
	fprintf(stdout,"\n\n");

	return(Estado);
}

