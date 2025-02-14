#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
/*#include <memory.h>         */
#include <stdarg.h>
#include <time.h>
/*#include <signal.h>         */
/*#include <sys/systeminfo.h> */
#include <sys/types.h>
/*#include <sys/times.h>      */
#include <sys/time.h>
#include <sys/stat.h>
/*#include <sys/shm.h>        */

#include "tipos.h"
#include "shared.h"
#include "tablas.h"
#include "general.h"

/******************************************************************************
Funcion         :       vfnLog
*******************************************************************************/

void vfnLog(int iCode, /* Error o Log */  char *szformat,...)
{
  	FILE  *pFile = NULL;
  	va_list ap;
  	va_start(ap,null);

  	if (iCode == FILE_LOG || iCode == FILE_BOTH)
  	{
    		if (TaS.pFileLOG)
      			pFile = TaS.pFileLOG;
    		else
      			pFile = stdout;

    		vfprintf(pFile, szformat, ap);
    		fflush(pFile);
  	}

  	if (iCode == FILE_ERR || iCode == FILE_BOTH)
  	{
    		if (TaS.pFileERR)
      			pFile = TaS.pFileERR;
    		else
      			pFile = stderr;

    		vfprintf(pFile, szformat, ap);
    		fflush(pFile);
  	}

  	va_end(ap);
}

/******************************************************************************
Funcion         :       vfnRecuperarFechaHora
*******************************************************************************/

void vfnRecuperarFechaHora(char *szFormato,char *szTime)
{
  	time_t ltime;
  	time(&ltime);
  	cftime(szTime, szFormato, &ltime);
}

/******************************************************************************
Funcion         :       vfnInitStructGeneral
*******************************************************************************/

void vfnInitStructGeneral(void)
{
	FILE *stream;
	long ltKey=0;
	long lsKey=0;
	char string[80]="";
	char string1[80]="";
	char string2[80]="";
	int largo=0;
	int i=0;
	int j=0;
	char *ruta=NULL;
	char archivo[255]="";
	
	ruta=getenv("XPF_CFG");
	if(ruta==NULL)
	{
		fprintf(stderr,"No existe la variable de ambiente XPF_CFG.\n");
		exit(3);	
	}
	else
	{
		strcpy(archivo,ruta);	
		strcat(archivo,"/datos.txt");
	}
	
	if((stream=fopen(archivo,"r"))==NULL)
	{
		fprintf(stderr,"No se pudo abrir el archivo de datos 'datos.txt'\n");
		exit(3);
	}

	ltKey=0;
	lsKey=0;
	TaS.pFileLOG = stdout;
	TaS.pFileERR = stderr;
	TaS.lGeCargos = 0;
	TaS.lGeCabCuotas = 0;
	TaS.lGeTaConcepFact = 0;
	TaS.lGeConceptos = 0;
	TaS.lGeConceptos_Mi = 0;
	TaS.lGeRangoTabla = 0;
	TaS.lGeLimCreditos = 0;
	TaS.lGeActividades = 0;
	TaS.lGeProvincias = 0;
	TaS.lGeRegiones = 0;
	TaS.lGeCatImpositiva = 0;
	TaS.lGeZonaCiudad = 0;
	TaS.lGeZonaImpositiva = 0;
	TaS.lGeImpuestos = 0;
	TaS.lGeTipImpues = 0;
	TaS.lGeGrpSerConc = 0;
	TaS.lGeConversion = 0;
	TaS.lGeDocumSucursal = 0;
	TaS.lGeLetras = 0;
	TaS.lGeGrupoCob = 0;
	TaS.lGeTarifas = 0;
	TaS.lGeActuaServ = 0;
	TaS.lGeCuotas = 0;
	TaS.lGeFactCarriers = 0;
	TaS.lGeCuadCtoPlan = 0;
	TaS.lGeCtoPlan = 0;
	TaS.lGePlanCtoPlan = 0;
	TaS.lGeArriendo = 0;
	TaS.lGeCargosBasico = 0;
	TaS.lGeOptimo = 0;
	TaS.lGeFeriados = 0;
	TaS.lGePlanTarif = 0;
	TaS.lGePenalizaciones = 0;
	TaS.lFacClientes = 0;
	TaS.lFacCiclo = 0;
        TaS.lGeCatImpClientes = 0;
  	TaS.lGeDirecciones = 0;
  	TaS.lGeDirecciones2 = 0;
  	TaS.lGeUnipac = 0;
/********************************************************
	INICIO NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/
	TaS.lGeOficina = 0;
	TaS.lGeFactCobr = 0;
/********************************************************
	FIN NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/
/***********   Inicio Cargos Recurrentes   *************/
	TaS.lGeCargosRecurrentes=0;
/***********     Fin Cargos Recurrentes    *************/

	TaS.pstlGeCargos = NULL;
	TaS.pstlGeCabCuotas = NULL;
	TaS.pstlGeTaConcepFact = NULL;
	TaS.pstlGeConceptos = NULL;
	TaS.pstlGeConceptos_Mi = NULL;
	TaS.pstlGeRangoTabla = NULL;
	TaS.pstlGeLimCreditos = NULL;
	TaS.pstlGeActividades = NULL;
	TaS.pstlGeProvincias = NULL;
	TaS.pstlGeRegiones = NULL;
	TaS.pstlGeCatImpositiva = NULL;
	TaS.pstlGeZonaCiudad = NULL;
	TaS.pstlGeZonaImpositiva = NULL;
	TaS.pstlGeImpuestos = NULL;
	TaS.pstlGeTipImpues = NULL;
	TaS.pstlGeGrpSerConc = NULL;
	TaS.pstlGeConversion = NULL;
	TaS.pstlGeDocumSucursal = NULL;
	TaS.pstlGeLetras = NULL;
	TaS.pstlGeGrupoCob = NULL;
	TaS.pstlGeTarifas = NULL;
	TaS.pstlGeActuaServ = NULL;
	TaS.pstlGeCuotas = NULL;
	TaS.pstlGeFactCarriers = NULL;
	TaS.pstlGeCuadCtoPlan = NULL;
	TaS.pstlGeCtoPlan = NULL;
	TaS.pstlGePlanCtoPlan = NULL;
	TaS.pstlGeArriendo = NULL;
	TaS.pstlGeCargosBasico = NULL;
	TaS.pstlGeOptimo = NULL;
	TaS.pstlGeFeriados = NULL;
	TaS.pstlGePlanTarif = NULL;
	TaS.pstlGePenalizaciones = NULL;
	TaS.pstlFacClientes = NULL;
	TaS.pstlFacCiclo = NULL;
	TaS.pstlGeCatImpClientes = NULL;
	TaS.pstlGeDirecciones = NULL;
	TaS.pstlGeDirecciones2 = NULL;
	TaS.pstlGeUnipac = NULL;
/********************************************************
	INICIO NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/
	TaS.pstlGeOficina = NULL;
	TaS.pstlGeFactCobr = NULL;
/********************************************************
	FIN NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/
/***********   Inicio Cargos Recurrentes   *************/
	TaS.pstlGeCargosRecurrentes = NULL;
/***********     Fin Cargos Recurrentes    *************/

	TaS.kTableKey = 0;
	TaS.kSemKey = 0;
	TaS.SharedPerms = S_IRWXU | S_IRWXG | S_IRWXO;
	TaS.SemPerms = S_IRWXU | S_IRWXG | S_IRWXO;
	TaS.iTableDescriptor= -1;
	TaS.pDataTable = NULL;
	TaS.lMemoriaTotal = 0;
	while(!feof(stream))
	{
		fscanf(stream,"%s",string);	
		if(strcmp(strncpy(string1,string,10),"TABLE_KEY=")==0)
		{
			for(i=10;i<strlen(string);i++)
			{
				string2[j]=string[i];
				j++;	
			}
			ltKey=atoi(string2);
		}
		j=0;
		if(strcmp(strncpy(string1,string,10),"SEMAP_KEY=")==0)
		{
			for(i=10;i<strlen(string);i++)
			{
				string2[j]=string[i];
				j++;	
			}
			lsKey=atoi(string2);
		}
		j=0;
	}
	fflush(stream);
	fclose(stream);

	TaS.kTableKey = ltKey;
	TaS.kSemKey = lsKey;

	if(TaS.kTableKey==0)
	{
		fprintf(stderr,"\nNo existe el valor de TABLE_KEY.");
		exit(3);
	}
	if(TaS.kSemKey==0)
	{
		fprintf(stderr,"\nNo existe el valor de SEMAP_KEY.");
		exit(3);
	}
}


