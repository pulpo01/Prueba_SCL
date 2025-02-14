/***************************************************************************/
/* Rutinas de utilidad, de caracter general, usadas en diversos sistemas.  */
/* Por William Sepulveda Valenzuela.                                       */
/*-------------------------------------------------------------------------*/
/* tabstop=3.                                                              */
/*-------------------------------------------------------------------------*/
/* Version 1 - Revision 00.                                                */
/* Jueves 22 de julio de 1999.                                             */
/*-------------------------------------------------------------------------*/
/* Version 1 - Revision 10.                                                */
/* Martes 21 de marzo del 2000.                                            */
/*                                                                         */
/* - Se incluye rutina para escritura en archivos de log.                  */
/***************************************************************************/

#include <time.h>
#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <string.h>
#include <strings.h>
#include <sys/stat.h>
#include <sys/timeb.h>
#include <stdarg.h>

#include <utils.h>

#define	FAIL		-1
#define	OK			 0

/***************************************************************************/
/* Procedimiento que escribe en la salida de errores estandar, la fecha y  */
/* hora actual, de acuerdo al formato [dd/mm/yyyy][hh:mi:ss].              */
/***************************************************************************/
void  vFechaHora ( void )
{
	time_t timer;
	char date[25];
	size_t nbytes;

	timer = time((time_t *)0);
	nbytes = strftime(date, 25, "[%d/%m/%Y][%H:%M:%S]", (struct tm *)localtime(&timer));

	fprintf(stderr,"\n%s\n", date);
}


/***************************************************************************/
/* Funcion analoga a vFechaHora, pero que retorna la fecha formateada en   */
/* una variable de tipo puntero a char.                                    */
/***************************************************************************/
char  *pszFechaHora ( void )
{
	time_t timer;
	char szDate[25];
	size_t nbytes;

	timer = time((time_t *)0);
	nbytes = strftime(szDate, 25, "[%d/%m/%Y][%H:%M:%S]", (struct tm *)localtime(&timer));

	return(szDate);
}

/***************************************************************************/
/* Funcion que convierte el string apuntado por str en un entero, el cual  */
/* es retornado. El valor de n indica la cantidad de bytes del string que  */
/* se consideraran para la conversion.                                     */
/***************************************************************************/
int 	iMyAtoi (char *str, int n)
{
	char aux[10];

	bzero(aux, sizeof(aux));
	strncpy(aux, str, n);
	return(atoi(aux));
}


/***************************************************************************/
/* Funcion que se encarga de validar la existencia de configuracion para   */
/* una determinada  variable de ambiente, retornado, en forma de puntero a */
/* char el valor de dicha variable.                                        */
/***************************************************************************/
char	*pszEnviron (char *pszVarAmb, char *pszAmbiente)
{
   char  *pszPathDir;
   char  *pszDatDir ;

	pszPathDir = (char *)malloc(1024);
	pszDatDir  = (char *)malloc(1024);
	
   if((pszPathDir = getenv((const char *)pszVarAmb)) == NULL)
   {
      fprintf(stderr, "\nVariable de ambiente [%s] no esta definida. Se cancela.\n", pszVarAmb);
      return((char *)NULL);
   }
   sprintf(pszDatDir, "%s/%s", pszPathDir, pszAmbiente);
   return(pszDatDir);
}	


/***************************************************************************/
/* Funcion que recupera la fecha actual del sistema, en formato "yyyymmdd" */
/* y la retorna como puntero a char.                                       */
/***************************************************************************/
char	*pszGetDate ( void )
{
	time_t timer;
	/* RAO char *pszDate=""; */
	char pszDate[9]="";
	size_t nbytes;

	timer = time((time_t *)0);
	nbytes = strftime(pszDate, (size_t)9, "%Y%m%d", (struct tm *)localtime(&timer));
	return(pszDate);
}


/***************************************************************************/
/* Funcion que recupera los segundos actuales del sistema, en una variable */
/* de tipo time_t.                                                         */
/***************************************************************************/
long	lGetTimer ( void )
{
	return((long )time((time_t *)NULL));
}

	
/***************************************************************************/
/* Funcion que recupera la fecha actual del sistema, en formato            */
/* "yyyymmddhhmiss" y la retorna como puntero a char.                      */
/***************************************************************************/
char	*pszGetDateExt ( void )
{
	time_t timer;
	char pszDate[15]="";
	size_t nbytes;

	timer = time((time_t *)0);
	nbytes = strftime(pszDate, (size_t)15, "%Y%m%d%H%M%S", (struct tm *)localtime(&timer));
	return((char *)pszDate);
}


/***************************************************************************/
/* Funcion que crea un directorio, usando el path y nombre que se entregan */
/* como parametros. Si el directorio ya existe, no se considera error,     */
/* pero si un componente del path falta (no esta creado), la funcion       */
/* devuelve un error (valor -1).                                           */
/***************************************************************************/
int	iMakeDir (char *pszDir)
{
   if(mkdir(pszDir, S_IRWXU|S_IRWXG|S_IRWXO) == FAIL)
	{
		if(errno != EEXIST)
		{
			fprintf(stderr, "Fallo la creacion del directorio \n[%s]\n", pszDir);
			fprintf(stderr, "Error Numero: %d     %s\n", errno, strerror(errno));
			fprintf(stderr, "Proceso se cancela.\n");
			return(FAIL);
		}
	}
	return(OK);
}


/***************************************************************************/
/* Rutina para manejo de escritura en archivos de log.                     */
/***************************************************************************/
void	vWriteLog (FILE *Args,...)
{	
	/* va_dcl */
	
	FILE 	*pfLog;
	char 	*pszFuncName;
	int		iCodErr;
	char	*pszFormat;
	va_list ap;
	
	pfLog=(FILE *)Args;

	va_start(ap,Args);
	
	pszFuncName=(char *)va_arg(ap, char *);
	iCodErr=(int)va_arg(ap, char *);
	pszFormat=(char *)va_arg(ap, char *);
	
	if(pfLog == (FILE *)NULL)
	{
		fprintf(stderr, "Error: Archivo de log no puede ser accedido. Proceso se cancela.\n");
		exit(FAIL);
	}
	
	if(iCodErr != 0)
	{
		fprintf(pfLog, "\nError [%d] en funcion %s\n", iCodErr, pszFuncName);
	}
	vfprintf(pfLog, pszFormat, ap);
	
	va_end(ap);
	fflush(pfLog);
}


/***************************************************************************/
/* Funcion que retorna la fecha del dia en formato "dd-NombreMes-yyyy" en  */
/* una variable de tipo puntero a char.                                    */
/***************************************************************************/
char  *pszHumanDate ( void )
{
	time_t timer;
	char szDate[25];
	size_t nbytes;

	timer = time((time_t *)0);
	nbytes = strftime(szDate, 25, "%d-%B-%Y", (struct tm *)localtime(&timer));

	return((char *) szDate);
}

/***************************************************************************/
/* Funcion que retorna la fecha del dia en formato "dd-NombreMes-yyyy" en  */
/* una variable de tipo puntero a char, recibiendo como parametro la fecha */
/* a traves de un puntero auna estructura tm.                              */
/***************************************************************************/
char  *pszTransformDate (struct tm *pstTm)
{
	static char szDate[25];
	size_t nbytes;

	nbytes = strftime(szDate, 25, "%d-%B-%Y", (struct tm *)pstTm);

	return((char *) szDate);
}

/***************************************************************************/
/* Funcion que retorna el numero de dia de la semana en una variable de    */
/* tipo entero, recibiendo como parametro la fecha a traves de un puntero  */
/* a una estructura tm.                                                    */
/***************************************************************************/
int	iGetNumDia (struct tm *pstTm)
{
	char 		szDate[50];
	size_t 	nbytes   ;
	int		iWeekDay ;

	nbytes = strftime(szDate, 26, "%u", (struct tm *)pstTm);
	
	iWeekDay = atoi(szDate);

	return(iWeekDay);
}


/***************************************************************************/
/* Funcion que recupera la fecha actual del sistema, en formato            */
/* "ddMesyyyy_hhmiss" y la retorna como puntero a char (para ser usada en  */
/* componentes del nombre de archivos de log).                             */
/***************************************************************************/
char	*pszGetDateLog ( void )
{
	time_t timer;
	char pszDate[20]="";
	size_t nbytes;

	timer = time((time_t *)0);
	nbytes = strftime(pszDate, (size_t)20, "%d%h%Y_%H%M%S", (struct tm *)localtime(&timer));
	return((char *)pszDate);
}

/***************************************************************************/
/* Funciones de Manejo de strings                                          */
/***************************************************************************/

/* StrLen Seguro, si el string es NULL no da CORE !     */

int _strlen(char *s)
{
        int i=0;
        if( isnull(s) ) return(0);
        while(s[i]!=0) i++;
        return(i);
}

/* LTrim limpia por la izquierda     */
char *_ltrim(char *s)
{
    char *p=s;
    if( strnull(s) ) return(NULL);
    while( *p<=32 && *p>1 ) p++;
    strcpy(s,p);
    return(s);
}

/* RTrim limpia por la Derecha     */
char *_rtrim(char *s)
{
    char *p=NULL;
    if( strnull(s) ) return(NULL);
    p=(s+_strlen(s)-1);
    while( *p<=32 && *p>1 )  p--;
    *(++p)=0;
    return(s);
}


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

