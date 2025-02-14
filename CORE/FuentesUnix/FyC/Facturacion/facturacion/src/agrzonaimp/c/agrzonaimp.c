
/* Result Sets Interface */
#ifndef SQL_CRSR
#  define SQL_CRSR
  struct sql_cursor
  {
    unsigned int curocn;
    void *ptr1;
    void *ptr2;
    unsigned int magic;
  };
  typedef struct sql_cursor sql_cursor;
  typedef struct sql_cursor SQL_CURSOR;
#endif /* SQL_CRSR */

/* Thread Safety */
typedef void * sql_context;
typedef void * SQL_CONTEXT;

/* Object support */
struct sqltvn
{
  unsigned char *tvnvsn; 
  unsigned short tvnvsnl; 
  unsigned char *tvnnm;
  unsigned short tvnnml; 
  unsigned char *tvnsnm;
  unsigned short tvnsnml;
};
typedef struct sqltvn sqltvn;

struct sqladts
{
  unsigned int adtvsn; 
  unsigned short adtmode; 
  unsigned short adtnum;  
  sqltvn adttvn[1];       
};
typedef struct sqladts sqladts;

static struct sqladts sqladt = {
  1,1,0,
};

/* Binding to PL/SQL Records */
struct sqltdss
{
  unsigned int tdsvsn; 
  unsigned short tdsnum; 
  unsigned char *tdsval[1]; 
};
typedef struct sqltdss sqltdss;
static struct sqltdss sqltds =
{
  1,
  0,
};

/* File name & Package Name */
struct sqlcxp
{
  unsigned short fillen;
           char  filnam[19];
};
static const struct sqlcxp sqlfpn =
{
    18,
    "./pc/agrzonaimp.pc"
};


static unsigned int sqlctx = 13794379;


static struct sqlexd {
   unsigned long  sqlvsn;
   unsigned int   arrsiz;
   unsigned int   iters;
   unsigned int   offset;
   unsigned short selerr;
   unsigned short sqlety;
   unsigned int   occurs;
      const short *cud;
   unsigned char  *sqlest;
      const char  *stmt;
   sqladts *sqladtp;
   sqltdss *sqltdsp;
   unsigned char  **sqphsv;
   unsigned long  *sqphsl;
            int   *sqphss;
            short **sqpind;
            int   *sqpins;
   unsigned long  *sqparm;
   unsigned long  **sqparc;
   unsigned short  *sqpadto;
   unsigned short  *sqptdso;
   unsigned int   sqlcmax;
   unsigned int   sqlcmin;
   unsigned int   sqlcincr;
   unsigned int   sqlctimeout;
   unsigned int   sqlcnowait;
            int   sqfoff;
   unsigned int   sqcmod;
   unsigned int   sqfmod;
   unsigned char  *sqhstv[8];
   unsigned long  sqhstl[8];
            int   sqhsts[8];
            short *sqindv[8];
            int   sqinds[8];
   unsigned long  sqharm[8];
   unsigned long  *sqharc[8];
   unsigned short  sqadto[8];
   unsigned short  sqtdso[8];
} sqlstm = {12,8};

/* SQLLIB Prototypes */
extern void sqlcxt (void **, unsigned int *,
                    struct sqlexd *, const struct sqlcxp *);
extern void sqlcx2t(void **, unsigned int *,
                    struct sqlexd *, const struct sqlcxp *);
extern void sqlbuft(void **, char *);
extern void sqlgs2t(void **, char *);
extern void sqlorat(void **, unsigned int *, void *);

/* Forms Interface */
static const int IAPSUCC = 0;
static const int IAPFAIL = 1403;
static const int IAPFTL  = 535;
extern void sqliem(char *, int *);

 static const char *sq0024 = 
"select COD_CICLO ,COD_CICLFACT ,TO_CHAR(FEC_EMISION,'YYYYMMDDHH24MISS')  fro\
m FA_CICLFACT where ((IND_FACTURACION in (:b0,:b1) and FEC_EMISION<=TO_DATE(:b\
2,'YYYYMMDDHH24MISS')) and COD_CICLFACT in (select distinct COD_CICLFACT  from\
 TOL_ACUMOPER_TO where (COD_CLIENTE between :b3 and :b4 or 1<>:b5)))          \
 ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,0,0,27,268,0,0,4,4,0,1,0,1,5,0,0,1,10,0,0,1,10,0,0,1,10,0,0,
36,0,0,2,84,0,6,428,0,0,2,2,0,1,0,1,3,0,0,1,97,0,0,
59,0,0,3,173,0,6,463,0,0,5,5,0,1,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
94,0,0,4,0,0,30,536,0,0,0,0,0,1,0,
109,0,0,5,0,0,31,575,0,0,0,0,0,1,0,
124,0,0,6,91,0,4,595,0,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,
151,0,0,7,392,0,4,635,0,0,7,6,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,
3,0,0,1,3,0,0,
194,0,0,8,194,0,4,681,0,0,2,1,0,1,0,2,3,0,0,1,5,0,0,
217,0,0,9,87,0,2,734,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
244,0,0,10,66,0,6,742,0,0,0,0,0,1,0,
259,0,0,11,65,0,6,752,0,0,0,0,0,1,0,
274,0,0,12,66,0,6,762,0,0,0,0,0,1,0,
289,0,0,13,65,0,6,773,0,0,0,0,0,1,0,
304,0,0,14,190,0,4,821,0,0,8,5,0,1,0,2,3,0,0,2,3,0,0,2,5,0,0,1,97,0,0,1,3,0,0,
1,97,0,0,1,97,0,0,1,3,0,0,
351,0,0,15,168,0,3,869,0,0,8,8,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,
1,3,0,0,1,3,0,0,1,97,0,0,
398,0,0,16,169,0,4,902,0,0,7,4,0,1,0,2,3,0,0,2,3,0,0,2,5,0,0,1,97,0,0,1,3,0,0,
1,97,0,0,1,3,0,0,
441,0,0,17,0,0,17,933,0,0,1,1,0,1,0,1,97,0,0,
460,0,0,17,0,0,45,939,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
487,0,0,17,0,0,13,942,0,0,2,0,0,1,0,2,3,0,0,2,3,0,0,
510,0,0,17,0,0,15,950,0,0,0,0,0,1,0,
525,0,0,18,151,0,4,971,0,0,6,4,0,1,0,2,5,0,0,2,3,0,0,1,97,0,0,1,3,0,0,1,97,0,0,
1,3,0,0,
564,0,0,19,170,0,5,1001,0,0,7,7,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,0,
0,1,97,0,0,1,3,0,0,
607,0,0,20,127,0,2,1033,0,0,4,4,0,1,0,1,97,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
638,0,0,21,109,0,4,1110,0,0,4,3,0,1,0,2,3,0,0,1,5,0,0,1,3,0,0,1,5,0,0,
669,0,0,22,85,0,4,1120,0,0,3,2,0,1,0,2,3,0,0,1,5,0,0,1,3,0,0,
696,0,0,23,111,0,4,1179,0,0,3,1,0,1,0,2,3,0,0,2,5,0,0,1,3,0,0,
723,0,0,24,311,0,9,1241,0,0,6,6,0,1,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,
762,0,0,24,0,0,13,1263,0,0,3,0,0,1,0,2,3,0,0,2,3,0,0,2,5,0,0,
};


/************************************************************************************************
* MODULO			            : agrzonaimp.pc
* Descripción			        : Proceso que genera un respaldo de la tabla TOL_ACUMOPER_TO
                            y despues reagrupa por area impositiva.
* Periodicidad			      : Ciclico.
* Parámetros			        : szUsername, szPassword
* Entradas			          : Archivos de Entrada
* Salidas			            : ERROR -> Error durante la ejecucion del proceso
* Analista responsable		:
* Programador		        	: cgf
* Modificado por          : JPP
* Fecha Programación		  : 05 Mayo 2005
* Fecha Modificacion      : 18 Enero 2006
*************************************************************************************************/

/*****************************************************************************/
/* Declaracion de Librerias                                                  */
/*****************************************************************************/
#include "agrzonaimp.h"
#define CLEAR(x) memset(x,0x0,sizeof(x))


/* EXEC SQL INCLUDE sqlca;
 */ 
/*
 * $Header: sqlca.h,v 1.3 1994/12/12 19:27:27 jbasu Exp $ sqlca.h 
 */

/* Copyright (c) 1985,1986, 1998 by Oracle Corporation. */
 
/*
NAME
  SQLCA : SQL Communications Area.
FUNCTION
  Contains no code. Oracle fills in the SQLCA with status info
  during the execution of a SQL stmt.
NOTES
  **************************************************************
  ***                                                        ***
  *** This file is SOSD.  Porters must change the data types ***
  *** appropriately on their platform.  See notes/pcport.doc ***
  *** for more information.                                  ***
  ***                                                        ***
  **************************************************************

  If the symbol SQLCA_STORAGE_CLASS is defined, then the SQLCA
  will be defined to have this storage class. For example:
 
    #define SQLCA_STORAGE_CLASS extern
 
  will define the SQLCA as an extern.
 
  If the symbol SQLCA_INIT is defined, then the SQLCA will be
  statically initialized. Although this is not necessary in order
  to use the SQLCA, it is a good pgming practice not to have
  unitialized variables. However, some C compilers/OS's don't
  allow automatic variables to be init'd in this manner. Therefore,
  if you are INCLUDE'ing the SQLCA in a place where it would be
  an automatic AND your C compiler/OS doesn't allow this style
  of initialization, then SQLCA_INIT should be left undefined --
  all others can define SQLCA_INIT if they wish.

  If the symbol SQLCA_NONE is defined, then the SQLCA variable will
  not be defined at all.  The symbol SQLCA_NONE should not be defined
  in source modules that have embedded SQL.  However, source modules
  that have no embedded SQL, but need to manipulate a sqlca struct
  passed in as a parameter, can set the SQLCA_NONE symbol to avoid
  creation of an extraneous sqlca variable.
 
MODIFIED
    lvbcheng   07/31/98 -  long to int
    jbasu      12/12/94 -  Bug 217878: note this is an SOSD file
    losborne   08/11/92 -  No sqlca var if SQLCA_NONE macro set 
  Clare      12/06/84 - Ch SQLCA to not be an extern.
  Clare      10/21/85 - Add initialization.
  Bradbury   01/05/86 - Only initialize when SQLCA_INIT set
  Clare      06/12/86 - Add SQLCA_STORAGE_CLASS option.
*/
 
#ifndef SQLCA
#define SQLCA 1
 
struct   sqlca
         {
         /* ub1 */ char    sqlcaid[8];
         /* b4  */ int     sqlabc;
         /* b4  */ int     sqlcode;
         struct
           {
           /* ub2 */ unsigned short sqlerrml;
           /* ub1 */ char           sqlerrmc[70];
           } sqlerrm;
         /* ub1 */ char    sqlerrp[8];
         /* b4  */ int     sqlerrd[6];
         /* ub1 */ char    sqlwarn[8];
         /* ub1 */ char    sqlext[8];
         };

#ifndef SQLCA_NONE 
#ifdef   SQLCA_STORAGE_CLASS
SQLCA_STORAGE_CLASS struct sqlca sqlca
#else
         struct sqlca sqlca
#endif
 
#ifdef  SQLCA_INIT
         = {
         {'S', 'Q', 'L', 'C', 'A', ' ', ' ', ' '},
         sizeof(struct sqlca),
         0,
         { 0, {0}},
         {'N', 'O', 'T', ' ', 'S', 'E', 'T', ' '},
         {0, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 0, 0, 0, 0}
         }
#endif
         ;
#endif
 
#endif
 
/* end SQLCA */
/*  */ 
/*
 * $Header: sqlca.h,v 1.3 1994/12/12 19:27:27 jbasu Exp $ sqlca.h 
 */

/* Copyright (c) 1985,1986, 1998 by Oracle Corporation. */
 
/*
NAME
  SQLCA : SQL Communications Area.
FUNCTION
  Contains no code. Oracle fills in the SQLCA with status info
  during the execution of a SQL stmt.
NOTES
  **************************************************************
  ***                                                        ***
  *** This file is SOSD.  Porters must change the data types ***
  *** appropriately on their platform.  See notes/pcport.doc ***
  *** for more information.                                  ***
  ***                                                        ***
  **************************************************************

  If the symbol SQLCA_STORAGE_CLASS is defined, then the SQLCA
  will be defined to have this storage class. For example:
 
    #define SQLCA_STORAGE_CLASS extern
 
  will define the SQLCA as an extern.
 
  If the symbol SQLCA_INIT is defined, then the SQLCA will be
  statically initialized. Although this is not necessary in order
  to use the SQLCA, it is a good pgming practice not to have
  unitialized variables. However, some C compilers/OS's don't
  allow automatic variables to be init'd in this manner. Therefore,
  if you are INCLUDE'ing the SQLCA in a place where it would be
  an automatic AND your C compiler/OS doesn't allow this style
  of initialization, then SQLCA_INIT should be left undefined --
  all others can define SQLCA_INIT if they wish.

  If the symbol SQLCA_NONE is defined, then the SQLCA variable will
  not be defined at all.  The symbol SQLCA_NONE should not be defined
  in source modules that have embedded SQL.  However, source modules
  that have no embedded SQL, but need to manipulate a sqlca struct
  passed in as a parameter, can set the SQLCA_NONE symbol to avoid
  creation of an extraneous sqlca variable.
 
MODIFIED
    lvbcheng   07/31/98 -  long to int
    jbasu      12/12/94 -  Bug 217878: note this is an SOSD file
    losborne   08/11/92 -  No sqlca var if SQLCA_NONE macro set 
  Clare      12/06/84 - Ch SQLCA to not be an extern.
  Clare      10/21/85 - Add initialization.
  Bradbury   01/05/86 - Only initialize when SQLCA_INIT set
  Clare      06/12/86 - Add SQLCA_STORAGE_CLASS option.
*/
 
#ifndef SQLCA
#define SQLCA 1
 
struct   sqlca
         {
         /* ub1 */ char    sqlcaid[8];
         /* b4  */ int     sqlabc;
         /* b4  */ int     sqlcode;
         struct
           {
           /* ub2 */ unsigned short sqlerrml;
           /* ub1 */ char           sqlerrmc[70];
           } sqlerrm;
         /* ub1 */ char    sqlerrp[8];
         /* b4  */ int     sqlerrd[6];
         /* ub1 */ char    sqlwarn[8];
         /* ub1 */ char    sqlext[8];
         };

#ifndef SQLCA_NONE 
#ifdef   SQLCA_STORAGE_CLASS
SQLCA_STORAGE_CLASS struct sqlca sqlca
#else
         struct sqlca sqlca
#endif
 
#ifdef  SQLCA_INIT
         = {
         {'S', 'Q', 'L', 'C', 'A', ' ', ' ', ' '},
         sizeof(struct sqlca),
         0,
         { 0, {0}},
         {'N', 'O', 'T', ' ', 'S', 'E', 'T', ' '},
         {0, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 0, 0, 0, 0}
         }
#endif
         ;
#endif
 
#endif
 
/* end SQLCA */

/* EXEC ORACLE OPTION (MAXOPENCURSORS=60); */ 

/*****************************************************************************/
/* Definicion de variables globales para ser usadas con	Oracle.		     */
/*****************************************************************************/
/* EXEC SQL BEGIN DECLARE SECTION; */ 


char  szUsuario [51] = ""  ; /* EXEC SQL VAR szUsuario        IS STRING(51); */ 

char  szUsername      [30]; /* EXEC SQL VAR szUsername       IS STRING(30); */ 

char  szPassword      [30]; /* EXEC SQL VAR szPassword       IS STRING(30); */ 

char  szhCiclo_Fact   [30]; /* EXEC SQL VAR szhCiclo_Fact    IS STRING(30); */ 

long  lhCiclo_fact=0;
char  szEstadoRecovery[6]; /* EXEC SQL VAR szEstadoRecovery IS STRING(6); */ 


long  ihValMinimo = 0;
long  ihValMaximo = 0;
long  lZonaimp  = 0L;
int    giCodCiclo = 0;
char   gszFecEmision[30];   /* EXEC SQL VAR gszFecEmision IS STRING(30); */ 

long   glhCodCiclFact = 0L;
char   gszhFecEmision[30]; /* EXEC SQL VAR gszhFecEmision IS STRING(30); */ 


/* EXEC SQL END DECLARE SECTION; */ 


char *gpszModulo = "agrzonaimp";


/*****************************************************************************/
/* Inicio main								                                 */
/*****************************************************************************/
int main (int argc, char *argv[])
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int iIngRngClientes = 0;
    long lClienteIni = 0L;	
    long lClienteFin = 0L;
    char szhHostId[25]="";
	/* EXEC SQL END   DECLARE SECTION; */ 

	
	
	/** Variables utilizadas para getopt() **/
	extern char *optarg;
	extern int optind, opterr, optopt;
	char opt[] = ":u:c:i:f:l:";
	int iOpt=0;
	char szUso[]= "\nUso: agrzonaimp -u [usuario/password | / ] -c [Ciclo Facturacion] -i [Rango inicio clientes] -f [Rango Fin Clientes] -l [Nivel de Log]"
	                "\nDonde       -u : Usuario/Password Oracle."
	                "\n            -c : Ciclo de facturacion a procesar."
	                "\n            -i : Rango Inicial de clientes (opcional)."
	                "\n            -f : Rango Final   de clientes (opcional)."
	                "\n            -l : Nivel de Log (opcional, por defecto 3).\n";
	char *psztmp =NULL;

    /* Caracteres no permitidos en las cadenas de entrada */
    const char *szCadValidacion = ":\\%";
    /* Tamanio maximo para cadena de usuario */
    const int iMaxLargoUsr = 50;
    /* Tamanio maximo para cadena de ciclo */
    const int iMaxLargoCiclo = 6;

    register int i = 0;
    int iResult    = 0;
    int iUserflag  = 0;
	int iCicloFlag = 0;
	int iClieIniFlag = 0;
    int iClieFinFlag = 0;
    long lClieIniBD  = 0L;
    long lClieFinBD  = 0L;
    int  iNivelLog   = 3;
    
    char szFecha[15];
    
    
    atexit(vfnSalidaExit);
    
    DATOSHOST stDatosHost;
    memset(&stDatosHost,'\0',sizeof(DATOSHOST));
    
    strcpy(stDatosHost.szHostId,"");
    stDatosHost.bExisteHostId = FALSE;

	vEncabezado();

    opterr=0;

	while ((iOpt = getopt(argc, argv, opt)) != EOF)
	{
		switch(iOpt)
		{
			case 'u': /* username/password */
				if (strlen(optarg))
                {
                    strncpy(szUsuario,optarg,iMaxLargoUsr);
                    szUsuario[iMaxLargoUsr]='\0';
                    if(strpbrk(szUsuario,szCadValidacion)!=NULL)
                    {
                        fprintf(stderr,"\n<< ERROR (main):Caracteres no validos en nombre de usuario.>>\n%s\n",szUso);
                        return -1;

                    }
                    iUserflag=1;
                }
				break;

            case 'c': /* Ciclo de facturacion */
				if(strlen(optarg))
                {
                    strncpy(szhCiclo_Fact,optarg,iMaxLargoCiclo);
                    szhCiclo_Fact[iMaxLargoCiclo]='\0';
                    alltrim(szhCiclo_Fact);
                    iCicloFlag=1;
                }
                else
                {
                    fprintf(stderr, "\n\t<< ERROR (main): Debe ingresar ciclo >>\n%s",szUso);
                    return -1;
                }
                break;

            case 'i':
                lClienteIni = atol(optarg);
                iClieIniFlag = 1;
                break;

            case 'f':
                lClienteFin = atol(optarg);
                iClieFinFlag = 1;
                break;

			case 'l':
				iNivelLog = atoi(optarg);
			    break;
			
			case '?':
				fprintf(stderr,"\n<< ERROR (main): Se ha ingresado parametro desconocido: -%c >>\n%s\n",optopt,szUso);
				return -1;


			case ':':
				if ( optopt == 'u' ) {
					fprintf(stderr,"\n<< ERROR (main): Falta especificar usuario/password o \"/\" >>\n%s\n",szUso);
				    return -1;
				}
                if ( optopt == 'c' ) {
				    fprintf(stderr,"\n<< ERROR (main): Falta especificar ciclo de facturacion. >>\n%s\n",szUso);
				    return -1;
			    }
                if ( optopt == 'l' ) {
				    fprintf(stderr,"\n<< ERROR (main): Falta especificar Nivel de Log. >>\n%s\n",szUso);
				    return -1;
			    }

			default :
			    return -1;
		}
	}

    /** Comprobacion del parametro de ciclo **/
    if (iCicloFlag == 0)
    {
        fprintf (stderr, "\n<< ERROR (main): Falta especificar ciclo de facturacion. >>\n%s", szUso);
        return -1;
    }

    if(iCicloFlag==1)
    {
        if(!ifnEsNumerico(szhCiclo_Fact))
        {
            fprintf (stderr, "\n\t<< ERROR (main): Ciclo de facturacion debe ser numerico >> \n");
            fprintf(stderr,"%s\n",szUso);
            return -1;
        }
        else
        {
            lhCiclo_fact = atol(szhCiclo_Fact);

            if (lhCiclo_fact < 1000 || lhCiclo_fact > 999999)
            {
                fprintf (stderr, "\n<< ERROR (main): Ciclo de Facturacion con Rango Invalido. >>\n%s\n", szUso);
                return -1;
            }
        }

    }/*if(iCicloFlag==1)*/

    /** Comprobacion del parametro de usuario/password **/
	if (iUserflag == 0)	/*Si no se especifico usuario/password asume los de oracle */
	{
		fprintf (stdout,"\tUsuario  : [default]\n\tPassword : [default]\n");
	}
	else
	{
		if ( (psztmp=(char *)strstr (szUsuario,"/"))==(char *)NULL)
		{
			fprintf (stderr,"\n\t<< ERROR (main): Usuario Oracle especificado [%s] no Valido >> \n", szUsuario);
			return -1;
		}
		else if (strlen(szUsuario) == 1)
		{
			fprintf (stdout,"\n\tUsuario                : [default]"
			                "\n\tPassword               : [default]"
			                "\n\tCiclo de Facturacion   : [%ld]\n",lhCiclo_fact);
		}
		else
		{
			strncpy (szUsername,szUsuario,psztmp-szUsuario);
			strcpy  (szPassword, psztmp+1);
			fprintf (stdout,"\n\tUsuario                : [%s]"
		                    "\n\tPassword               : [%s]"
		                    "\n\tCiclo de Facturacion   : [%ld]\n",
		    	 			 szUsername, szPassword,lhCiclo_fact);
		}

    }

    if( (iClieIniFlag==1 && iClieFinFlag==0) || (iClieIniFlag==0 && iClieFinFlag==1))
    {
        fprintf (stderr,"\n(EE)\t<< Error : falta opcion '-i' o '-f' >>\n%s\n",szUso);
        return (false);
    }

    if((iClieIniFlag==1 && iClieFinFlag==1))
        iIngRngClientes = 1;
    else
        iIngRngClientes = 0;

    if(lClienteIni - lClienteFin > 0L)
    {
        fprintf (stderr,"(EE)\t<< Error : Cliente inicial debe ser menor a Cliente final >>\n%s\n",szUso);
        return (false);
    }

	signal(SIGTERM,sigTermHandler);
	
	/*** Apertura de archivos de Log  ***/
	if(bfnAbreArchivosLog( lhCiclo_fact, iNivelLog)==FALSE)
	{
        fprintf (stderr,"(EE)\t<< Error : En Apertura de archivos de Log. >>\n");
        return (false);		
	}
	
	/*===================================================================================================*/
	/* (II) Conexion a Oracle   	 						                     */
	/*===================================================================================================*/

   /* EXEC SQL CONNECT :szUsuario; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 4;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )60;
   sqlstm.offset = (unsigned int  )5;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szUsuario;
   sqlstm.sqhstl[0] = (unsigned long )51;
   sqlstm.sqhsts[0] = (         int  )51;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqphsv = sqlstm.sqhstv;
   sqlstm.sqphsl = sqlstm.sqhstl;
   sqlstm.sqphss = sqlstm.sqhsts;
   sqlstm.sqpind = sqlstm.sqindv;
   sqlstm.sqpins = sqlstm.sqinds;
   sqlstm.sqparm = sqlstm.sqharm;
   sqlstm.sqparc = sqlstm.sqharc;
   sqlstm.sqpadto = sqlstm.sqadto;
   sqlstm.sqptdso = sqlstm.sqtdso;
   sqlstm.sqlcmax = (unsigned int )100;
   sqlstm.sqlcmin = (unsigned int )2;
   sqlstm.sqlcincr = (unsigned int )1;
   sqlstm.sqlctimeout = (unsigned int )0;
   sqlstm.sqlcnowait = (unsigned int )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	 vfnMsgError("Conexion Base de Datos",sqlca.sqlcode,false);


    /*** Si conexion es exitosa, indicar por pantalla ***/
    fprintf(stdout,"(II) main(): >> Conectado a la Base de Datos <<\n\n");
    vDTrazasLog("main","(II) main(): >> Conectado a la Base de Datos <<", LOG03);

	fprintf(stdout, "\n*[Procesando...]\n");
       
    /*** Validacion de la Traza de facturacion en FA_TRAZAPROC  ***/
    if (!bfnWrapperValidaTrazaProc(lhCiclo_fact, iPROC_AGRZONAIMP, iIND_FACT_ENPROCESO))
        exit (-1);
    
    if (!bfnOraCommit ())
    {
        vDTrazasError(gpszModulo," en Commit bfnWrapperValidaTrazaProc", LOG01);
        vDTrazasLog  (gpszModulo," en Commit bfnWrapperValidaTrazaProc", LOG01);
        exit (-1);
    }
    bfnWrapperSelectTrazaProc (lhCiclo_fact, iPROC_AGRZONAIMP, &stTrazaProc);
    bPrintTrazaProc(stTrazaProc);    
    
    
    /*** Obtencion de rangos de clientes, si existen ***/
    stDatosHost.bExisteHostId = (ifnGetHostId(stDatosHost.szHostId)==0)?TRUE:FALSE;
    
    if( (stDatosHost.bExisteHostId)== FALSE )
    {
        vDTrazasLog(gpszModulo, "(AVISO) main(): No se rescatan datos de Rango de clientes desde base de datos"
                                "\n\tSe mantienen datos ingresados desde linea de comando (Si existen).\n", LOG03);
        /* 20061002: Se ingresa un Host por defecto para clave primaria de FA_RECOVERY_TO */
        strcpy(stDatosHost.szHostId,"AGRZONA0");
        stDatosHost.bExisteHostId = TRUE;

        
    }
    else
    {
        /*** Busqueda de rangos de clientes desde Base de Datos ***/
	    alltrim(stDatosHost.szHostId);
	    vDTrazasLog(gpszModulo,"Cadena despues de trim: [%s]\n",LOG03,stDatosHost.szHostId);
	    vDTrazasLog(gpszModulo,"(INFO) main(): Tratando de obtener Rangos de clientes desde Base de Datos...\n",LOG03);
        if( (iGetRangosHost(stDatosHost.szHostId, lhCiclo_fact, &lClieIniBD, &lClieFinBD))==0 )
        {
            lClienteIni = lClieIniBD;
            lClienteFin = lClieFinBD;
            iIngRngClientes = 1;
        }
        else
        {
            vDTrazasLog(gpszModulo, "(AVISO) main(): No se rescatan datos de Rango de clientes desde base de datos"
                            "\n\tSe mantienen datos ingresados desde linea de comando (Si existen).\n", LOG03);
        }
    }
    vDTrazasLog(gpszModulo, "Datos obtenidos para Rangos Inicial y final de clientes\n"
                    "\tRango inicial  : [%ld]\n"
                    "\tRango Final    : [%ld]\n"
                    "\tiIngRngClientes: [%d]\n"
                    , LOG03
                    , lClienteIni
                    , lClienteFin
                    , iIngRngClientes);

    /*** Valida si el ciclo ya ha sido procesado por la aplicacion ***/
    iResult = ifnExisteProcCiclo(lhCiclo_fact, stDatosHost);

    switch(iResult)
    {
        case 1:
            vDTrazasLog(gpszModulo,"\n\t>> (ERROR) main(): El ciclo [%ld] ya fue procesado. <<\n",LOG01,lhCiclo_fact);
            vDTrazasError(gpszModulo,"\n\t>> (ERROR) main(): El ciclo [%ld] ya fue procesado. <<\n",LOG01,lhCiclo_fact);
            return -1;

        case -1:
            vDTrazasLog(gpszModulo,"\n\t>> (ERROR) main(): En la consulta de estado del ciclo [%ld]. <<\n",LOG01,lhCiclo_fact);
            vDTrazasError(gpszModulo,"\n\t>> (ERROR) main(): En la consulta de estado del ciclo [%ld]. <<\n",LOG01,lhCiclo_fact);
            return -1;

        case 0:
            vDTrazasLog(gpszModulo,"\n\t>> (INFO) main(): El ciclo [%ld] sera procesado. <<\n",LOG03,lhCiclo_fact);
            break;

        default:
            vDTrazasLog(gpszModulo, "\n\t>> (ERROR) main(): Opcion [%d] desconocida. <<\n"
                            "\n\t>> Al validar procesamiento del ciclo [%ld]. <<\n", LOG01, iResult, lhCiclo_fact);
            vDTrazasError(gpszModulo, "\n\t>> (ERROR) main(): Opcion [%d] desconocida. <<\n"
                            "\n\t>> Al validar procesamiento del ciclo [%ld]. <<\n", LOG01, iResult, lhCiclo_fact);
            return -1;

    }



    /*** Verifica apertura del ciclo a procesar  ***/
	vDTrazasLog(gpszModulo,"(INFO) main(): Verificando apertura del ciclo....", LOG03);
	if (!ifnVerificarAperturaCiclo (lhCiclo_fact))
	    exit(1);
	else
	    vDTrazasLog(gpszModulo,"OK: Ciclo [%ld] abierto.", LOG03, lhCiclo_fact);


    /* 20051220: Obtiene todos los ciclos de facturacion que deben ser agrupados */
    vDTrazasLog(gpszModulo,"(INFO) main(): Obteniendo ciclos a agrupar...", LOG03);
    if(ifnObtenerCiclosParaAgrupar(lhCiclo_fact, iIngRngClientes, lClienteIni, lClienteFin)!=0)
    {
        vDTrazasLog(gpszModulo,"(ERROR) main(): En Obtencion de ciclos para agrupar", LOG01);
        vDTrazasError(gpszModulo,"(ERROR) main(): En Obtencion de ciclos para agrupar", LOG01);
        exit(1);
    }

	/*===================================================================================================*/
	/* (IV) Verifica si estan las parametrizadas todas las areas Impositivas                             */
	/*===================================================================================================*/
	vDTrazasLog(gpszModulo, "(INFO) main(): Validando Parametrizacion de Zonas Impositivas...",LOG03);
	if (!ifnValidaZonaimp(stDatosHost, iIngRngClientes, lClienteIni, lClienteFin))
	    exit(1);


	/*===================================================================================================*/
	/* (  ) Truncate de Tablas                                                                           */
	/*===================================================================================================*/

    CLEAR(szEstadoRecovery);
    vfnGetEstado(PROC_RZOIM,0, stDatosHost);
    vDTrazasLog(gpszModulo,"(INFO) main(): Estado de respaldo rescatado desde FA_RECOVERY_TO: [%s].\n", LOG03,szEstadoRecovery);
    if(strcmp(szEstadoRecovery,"TER")!=0)
    {
        vDTrazasLog(gpszModulo,"(INFO) main(): Estado de Respaldo !=[TER], verificando condicion de respaldo...", LOG03);
        if(strcmp(szEstadoRecovery,"PRC")!=0)
        {
            /** Truncado de tablas de traspaso **/
            vDTrazasLog(gpszModulo,"(INFO) main(): Truncando FA_ACUMOPER_RESP_TH ", LOG03);
            if (!ifnTruncateTable(FA_ACUMOPER_RESP_TH, iIngRngClientes, lClienteIni, lClienteFin) )
            {
                 vDTrazasLog  (gpszModulo,"(ERROR) main(): En truncado de datos de FA_ACUMOPER_RESP_TH", LOG03);
                 vDTrazasError(gpszModulo,"(ERROR) main(): En truncado de datos de FA_ACUMOPER_RESP_TH", LOG03);
                 exit(1);
            }
        }
        else
            vDTrazasLog(gpszModulo,"(INFO) main(): Continuando respaldo de tabla TOL_ACUMOPER_TO...", LOG03);

	    vDTrazasLog(gpszModulo,"(INFO) main(): Contando cuantos registros se procesaran del Ciclo Facturable...", LOG03);
        if (!ifnCuentaAbiertos())
        {
            vDTrazasLog(gpszModulo,"(ERROR) main(): En funcion ifnCuentaAbiertos()", LOG03);
            vDTrazasError(gpszModulo,"(ERROR) main(): En funcion ifnCuentaAbiertos()", LOG03);
            exit(1);
        }


	     /*===============================================================================================*/
	     /* (VI) Genera Respaldos de la tabla TOL_ACUMOPER_TO                                              */
	     /*===============================================================================================*/
	     vDTrazasLog(gpszModulo,"(INFO) main(): Generando Respaldo...", LOG03);
         
         glhCodCiclFact = lhCiclo_fact;
         strcpy(szhHostId, stDatosHost.szHostId);
         alltrim(szhHostId);
         /* EXEC SQL EXECUTE
            BEGIN
                FA_ZONAIMPOSITIVA_PG.FA_RESPALDO_PR(:glhCodCiclFact, :szhHostId);
            END;
         END-EXEC; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 4;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.stmt = "begin FA_ZONAIMPOSITIVA_PG . FA_RESPALDO_PR ( :glhCo\
dCiclFact , :szhHostId ) ; END ;";
         sqlstm.iters = (unsigned int  )1;
         sqlstm.offset = (unsigned int  )36;
         sqlstm.cud = sqlcud0;
         sqlstm.sqlest = (unsigned char  *)&sqlca;
         sqlstm.sqlety = (unsigned short)256;
         sqlstm.occurs = (unsigned int  )0;
         sqlstm.sqhstv[0] = (unsigned char  *)&glhCodCiclFact;
         sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[0] = (         int  )0;
         sqlstm.sqindv[0] = (         short *)0;
         sqlstm.sqinds[0] = (         int  )0;
         sqlstm.sqharm[0] = (unsigned long )0;
         sqlstm.sqadto[0] = (unsigned short )0;
         sqlstm.sqtdso[0] = (unsigned short )0;
         sqlstm.sqhstv[1] = (unsigned char  *)szhHostId;
         sqlstm.sqhstl[1] = (unsigned long )25;
         sqlstm.sqhsts[1] = (         int  )0;
         sqlstm.sqindv[1] = (         short *)0;
         sqlstm.sqinds[1] = (         int  )0;
         sqlstm.sqharm[1] = (unsigned long )0;
         sqlstm.sqadto[1] = (unsigned short )0;
         sqlstm.sqtdso[1] = (unsigned short )0;
         sqlstm.sqphsv = sqlstm.sqhstv;
         sqlstm.sqphsl = sqlstm.sqhstl;
         sqlstm.sqphss = sqlstm.sqhsts;
         sqlstm.sqpind = sqlstm.sqindv;
         sqlstm.sqpins = sqlstm.sqinds;
         sqlstm.sqparm = sqlstm.sqharm;
         sqlstm.sqparc = sqlstm.sqharc;
         sqlstm.sqpadto = sqlstm.sqadto;
         sqlstm.sqptdso = sqlstm.sqtdso;
         sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



         if(sqlca.sqlcode!=SqlOk)
         {
             vDTrazasLog(gpszModulo, "(ERROR) main(): En llamada a Package FA_ZONAIMPOSITIVA_PG.FA_RESPALDO_PR.\n"
                             		 "   - Codigo de error: [%d].\n"
                             		, LOG01
                             		,sqlca.sqlcode);
             vDTrazasError(gpszModulo, "(ERROR) main(): En llamada a Package FA_ZONAIMPOSITIVA_PG.FA_RESPALDO_PR.\n"
                             		 "   - Codigo de error: [%d].\n"
                             		, LOG01
                             		,sqlca.sqlcode);

             exit(1);
         }

    }
    else
        vDTrazasLog(gpszModulo,"(INFO) main(): El respaldo de la tabla TOL_ACUMOPER_TO ya fue realizado.", LOG03);


	/*===================================================================================================*/
	/* (XII) Reagrupa  Valores por Zona Impositiva en  tol_acumoper_to                                   */
	/*===================================================================================================*/
    for(i=0;i<stCiclos.iCantCiclos;i++)
    {
        vDTrazasLog(gpszModulo,"(INFO) main(): Procesando Ciclo[%d]:\t[%ld]...", LOG03, i, stCiclos.stCiclo[i].lhCodCiclFact);

        glhCodCiclFact = stCiclos.stCiclo[i].lhCodCiclFact;
        strcpy(gszhFecEmision, stCiclos.stCiclo[i].szhFechaEmision);

        /* EXEC SQL EXECUTE
            BEGIN
                FA_ZONAIMPOSITIVA_PG.FA_AGRUPACION_PR ( TO_DATE(:gszhFecEmision,'YYYYMMDDHH24MISS')
                                                        , :glhCodCiclFact
                                                        , :iIngRngClientes
                                                        , :lClienteIni
                                                        , :lClienteFin);
            END;
        END-EXEC; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 5;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "begin FA_ZONAIMPOSITIVA_PG . FA_AGRUPACION_PR ( TO_DA\
TE ( :gszhFecEmision , 'YYYYMMDDHH24MISS' ) , :glhCodCiclFact , :iIngRngClient\
es , :lClienteIni , :lClienteFin ) ; END ;";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )59;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)gszhFecEmision;
        sqlstm.sqhstl[0] = (unsigned long )30;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&glhCodCiclFact;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&iIngRngClientes;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&lClienteIni;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&lClienteFin;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqphsv = sqlstm.sqhstv;
        sqlstm.sqphsl = sqlstm.sqhstl;
        sqlstm.sqphss = sqlstm.sqhsts;
        sqlstm.sqpind = sqlstm.sqindv;
        sqlstm.sqpins = sqlstm.sqinds;
        sqlstm.sqparm = sqlstm.sqharm;
        sqlstm.sqparc = sqlstm.sqharc;
        sqlstm.sqpadto = sqlstm.sqadto;
        sqlstm.sqptdso = sqlstm.sqtdso;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



        if(sqlca.sqlcode!=SqlOk)
        {
            vDTrazasLog(gpszModulo, "(AVISO) main(): En llamada a Package FA_ZONAIMPOSITIVA_PG.FA_AGRUPACION_PR.\n"
                            "   - Codigo : [%d].\n"
                            , LOG03
                            ,sqlca.sqlcode);
        }



    }

	/*===================================================================================================*/
	/* (XVI) Elimina Registros de tabla Control                                                          */
	/*===================================================================================================*/
    vDTrazasLog(gpszModulo, "(INFO) main(): Elimina los registros de fa_recovery.", LOG03);
    vfnDeleteRecovery( PROC_RZOIM, 0, stDatosHost);

    /* Borrar registro de seguimiento de agrupacion */
    for(i=0;i<stCiclos.iCantCiclos;i++)
        vfnDeleteRecovery( PROC_ZOIMP, stCiclos.stCiclo[i].lhCodCiclFact, stDatosHost);


	/** Inserta registro que indica termino correcto del Proceso **/
	if(!ifnCargaFa_recovery_to( ESTADO_TER, PROC_AGRZONAIMP, lhCiclo_fact, 1, stDatosHost.szHostId) )
	{
	    vDTrazasLog(gpszModulo,"(ERROR) main(): Al insertar Estado de Proceso Terminado", LOG01);
	    vDTrazasError(gpszModulo,"(ERROR) main(): Al insertar Estado de Proceso Terminado", LOG01);
	}
	else
	{
	    vDTrazasLog(gpszModulo,"(INFO) main(): Proceso registrado en forma correcta.", LOG03);
	}

	
    /*** Actualizacion de la traza ***/

    if(!bfnSelectSysDate(szFecha))
    {
        vDTrazasError(gpszModulo," [%s][%d] - En Recuperacion de fecha de sistema con bfnSelectSysDate", LOG01, __FILE__, __LINE__);
        vDTrazasLog  (gpszModulo," [%s][%d] - En Recuperacion de fecha de sistema con bfnSelectSysDate", LOG01, __FILE__, __LINE__);
        return FALSE;    	
    }

    stTrazaProc.iCodEstaProc = iPROC_EST_OK;
    /*strcpy(stTrazaProc.szFecInicio,stArgsEntrada.szHoraInicProc);*/
    strcpy(stTrazaProc.szFecTermino,szFecha);
    strcpy(stTrazaProc.szGlsProceso,"Proceso Generacion de Cuotas Terminado OK");
    
    bPrintTrazaProc(stTrazaProc);
    
    if(!bfnWrapperUpdateTrazaProc(stTrazaProc))
        return FALSE;
    if (!bfnOraCommit ())
    {
        vDTrazasError(gpszModulo," en Commit bfnWrapperUpdateTrazaProc", LOG01);
        vDTrazasLog  (gpszModulo," en Commit bfnWrapperUpdateTrazaProc", LOG01);
        return FALSE;
    }	

	/*===================================================================================================*/
	/* (XVII) Cierra Proceso   	 						                     */
	/*===================================================================================================*/
	/* EXEC SQL COMMIT WORK RELEASE; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 5;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )94;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	vDTrazasLog(gpszModulo, "(INFO) main(): Proceso agrupacion por Zonas terminado exitosamente.", LOG03);

	
	/* Cierre de archivos de .log y .err */
	fclose(stStatus.ErrFile);
	fclose(stStatus.LogFile);
	
	printf("\n*[Finalizado.]\n");
	
	return 0;

}


/************************************************************/
/* Funcion    :sigTermHandler                               */
/* Objetivo   :                                             */
/************************************************************/
extern void sigTermHandler(int p)
{
 fprintf (stdout, "Programa recibe Kill(%d) \n",p);
 exit(1);
}


/***************************************************************************/
/* Control Error                                                           */
/***************************************************************************/
void vfnMsgError(char* szMsg, int iErrNum, int bRollCom)
{

 if ((iErrNum != SqlOk) &&  (iErrNum != SqlNotFound) && (iErrNum != SqlNull))
  {

 	   vDTrazasError(gpszModulo, "+++++ ERROR : [%d] En [%s]\n",LOG01,iErrNum,szMsg);

       if (bRollCom)
         /* EXEC SQL ROLLBACK WORK; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 5;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.iters = (unsigned int  )1;
         sqlstm.offset = (unsigned int  )109;
         sqlstm.cud = sqlcud0;
         sqlstm.sqlest = (unsigned char  *)&sqlca;
         sqlstm.sqlety = (unsigned short)256;
         sqlstm.occurs = (unsigned int  )0;
         sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


           exit(1);
  }
}


/*****************************************************************************/
/* Verifica Ciclos Abiertos para Facturar                                    */
/*****************************************************************************/
int ifnVerificarAperturaCiclo (long lCodCiclFact)
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

    int  ihEstado=1;
    long lhCodCiclfact = lCodCiclFact;
    int  ihCronograma = 0;
	/* EXEC SQL END DECLARE SECTION; */ 

    
    char *pszModulo="ifnVerificarAperturaCiclo";
    
	sqlca.sqlcode = 0;
	/* EXEC SQL
	     SELECT COUNT(1)
	     INTO   :ihCronograma
	     FROM   FA_CICLFACT
	     WHERE  COD_CICLFACT    = :lhCodCiclfact /o Viene por Parametro o/
         AND  IND_FACTURACION   = :ihEstado; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 5;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(1) into :b0  from FA_CICLFACT where (COD_CICLFA\
CT=:b1 and IND_FACTURACION=:b2)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )124;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCronograma;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCiclfact;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&ihEstado;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
 sqlstm.sqphss = sqlstm.sqhsts;
 sqlstm.sqpind = sqlstm.sqindv;
 sqlstm.sqpins = sqlstm.sqinds;
 sqlstm.sqparm = sqlstm.sqharm;
 sqlstm.sqparc = sqlstm.sqharc;
 sqlstm.sqpadto = sqlstm.sqadto;
 sqlstm.sqptdso = sqlstm.sqtdso;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	if (ihCronograma == 0)
	{
		vfnMsgError("Ciclo de Facturacion no Abierto",sqlca.sqlcode,false);
		vDTrazasLog(pszModulo, "##### Ciclo de Facturacion = [%ld], no esta en estado 1.", LOG03,lhCiclo_fact);
		return(false);
	}

	return(true);

}/* fin ifnVerificarAperturaCiclo */


/*****************************************************************************/
/* Verifica Parametrizacion de Areas Impositivas vs Areas de TOL              */
/*****************************************************************************/
int ifnValidaZonaimp (DATOSHOST stDatosHost, int iIngRngCli, long lClienteIni, long lClienteFin)
{

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long lNumFilas  = 0L;
	int  ihValorUno = 1;
	int  ihValorDos = 2;
	int  ihIngRngCli  = iIngRngCli;
	long lhClienteIni = lClienteIni;
	long lhClienteFin = lClienteFin;
    /* EXEC SQL END DECLARE SECTION; */ 


    char *pszModulo="ifnValidaZonaimp";
    
    vDTrazasLog(pszModulo, "(INFO) ifnValidaZonaimp(): Lee TOL_ACUMOPER_TO, por Ciclo de Facturacion Activo ", LOG03);

	sqlca.sqlcode = 0;

	/* EXEC SQL

        SELECT COUNT(1)
        INTO  :lNumFilas
        FROM  TOL_ACUMOPER_TO A
        WHERE A.COD_CICLFACT IN
            (SELECT COD_CICLFACT
                 FROM FA_CICLFACT
                 WHERE
                    IND_FACTURACION IN (:ihValorUno,:ihValorDos)
                    AND FEC_EMISION <=TO_DATE(:gszFecEmision,'YYYYMMDDHH24MISS'))
        AND   A.COD_AREAA NOT IN (SELECT /o+ PARALLEL o/ B.COD_AREA FROM FA_AREAIMP_TD B
                                    WHERE SYSDATE BETWEEN B.FEC_INI_VIG AND B.FEC_TER_VIG)
        AND   ( (A.COD_CLIENTE BETWEEN :lhClienteIni AND :lhClienteFin) OR (1 <> :ihIngRngCli) ); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 7;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(1) into :b0  from TOL_ACUMOPER_TO A where ((A.C\
OD_CICLFACT in (select COD_CICLFACT  from FA_CICLFACT where (IND_FACTURACION i\
n (:b1,:b2) and FEC_EMISION<=TO_DATE(:b3,'YYYYMMDDHH24MISS'))) and A.COD_AREAA\
 not  in (select  /*+  PARALLEL  +*/ B.COD_AREA  from FA_AREAIMP_TD B where SY\
SDATE between B.FEC_INI_VIG and B.FEC_TER_VIG)) and (A.COD_CLIENTE between :b4\
 and :b5 or 1<>:b6))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )151;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lNumFilas;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihValorUno;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&ihValorDos;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)gszFecEmision;
 sqlstm.sqhstl[3] = (unsigned long )30;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&lhClienteIni;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&lhClienteFin;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)&ihIngRngCli;
 sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
 sqlstm.sqphss = sqlstm.sqhsts;
 sqlstm.sqpind = sqlstm.sqindv;
 sqlstm.sqpins = sqlstm.sqinds;
 sqlstm.sqparm = sqlstm.sqharm;
 sqlstm.sqparc = sqlstm.sqharc;
 sqlstm.sqpadto = sqlstm.sqadto;
 sqlstm.sqptdso = sqlstm.sqtdso;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}




        /*=====================================================*/
        /* Valida solo cuando procesa por primera vez el Ciclo */
        /*=====================================================*/

	vDTrazasLog(pszModulo, "(INFO) ifnValidaZonaimp(): lNumFilas [%ld]  - szEstadoRecovery:[%s]\n", LOG03,lNumFilas,szEstadoRecovery);

	CLEAR( szEstadoRecovery );
    vfnGetEstado( PROC_PROCESAN, SUBPROCESO_0, stDatosHost);

	if ((lNumFilas != 0) && ( strcmp(szEstadoRecovery, ESTADO_TER ) != 0 ))
	{
		vfnMsgError("No estan todas las Areas Parametrizadas como Zonas Impositivas o no estan vigentes, para el ciclo.",sqlca.sqlcode,false);
		vDTrazasLog(pszModulo, "No estan todas las Areas Parametrizadas como Zonas Impositivas o no estan vigentes, para el ciclo de facturacion.", LOG01);
		return(false);
	}

	return(true);
}/* fin ifnValidaZonaimp */


/*****************************************************************************/
/* Cuenta cuantos registros se procesaran con ciclo abierto                  */
/*****************************************************************************/
int ifnCuentaAbiertos(void)
{

	char *pszModulo="ifnCuentaAbiertos";
	
	lZonaimp = 0;
	sqlca.sqlcode = 0;
	/* EXEC SQL

        SELECT COUNT(1)
        INTO   :lZonaimp
        FROM   TOL_ACUMOPER_TO A
        /oWHERE  a.cod_ciclfact  = :lhCiclo_fact;o/
        WHERE
             A.COD_CICLFACT IN
            (SELECT COD_CICLFACT
                 FROM FA_CICLFACT
                 WHERE
                    /oCOD_CICLO = :giCodCicloo/
                    IND_FACTURACION IN (1,2)  /o 20060110 o/
                    AND FEC_EMISION <=TO_DATE(:gszFecEmision,'YYYYMMDDHH24MISS')); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 7;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(1) into :b0  from TOL_ACUMOPER_TO A where A.COD\
_CICLFACT in (select COD_CICLFACT  from FA_CICLFACT where (IND_FACTURACION in \
(1,2) and FEC_EMISION<=TO_DATE(:b1,'YYYYMMDDHH24MISS')))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )194;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lZonaimp;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)gszFecEmision;
 sqlstm.sqhstl[1] = (unsigned long )30;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
 sqlstm.sqphss = sqlstm.sqhsts;
 sqlstm.sqpind = sqlstm.sqindv;
 sqlstm.sqpins = sqlstm.sqinds;
 sqlstm.sqparm = sqlstm.sqharm;
 sqlstm.sqparc = sqlstm.sqharc;
 sqlstm.sqpadto = sqlstm.sqadto;
 sqlstm.sqptdso = sqlstm.sqtdso;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



                    /* AND COD_CICLFACT IN (SELECT DISTINCT(COD_CICLFACT) FROM TOL_ACUMOPER_TO));  Se SACA POR INEFICIENTE LEO - RA-RA-200601130578*/

	if (lZonaimp == 0)
	{
		vfnMsgError("(ERROR) ifnCuentaAbiertos(): No existen registros en estado Abierto para procesar ",sqlca.sqlcode,false);
		vDTrazasLog(pszModulo, "(ERROR) ifnCuentaAbiertos(): No existen registros en estado Abierto para procesar", LOG01);
		return(false);
	}

	vDTrazasLog(pszModulo, "(INFO) ifnCuentaAbiertos(): Cantidad de registros con ciclos Abierto en tol_acumoper_to = [%ld]\n", LOG03,lZonaimp);
	return(true);

}/* fin ifnCuentaAbiertos */


/***************************************************************************************/
/* Truncate de la tabla tol_acumoper_to                      			       */
/***************************************************************************************/
int ifnTruncateTable(int iIdTabla, int iIngRngCli, long lClienteIni, long lClienteFin)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 
	
	int  ihIngRngCli  = iIngRngCli;
	long lhClienteIni = lClienteIni;
	long lhClienteFin = lClienteFin;
    /* EXEC SQL END DECLARE SECTION; */ 

    
    char *pszModulo="ifnTruncateTable";

    sqlca.sqlcode = 0;

    char szNomTabla[30] = "";

    switch(iIdTabla)
    {

        case FA_ACUMOPER_RESP_TH:
            vDTrazasLog(pszModulo, "(INFO) ifnTruncateTable(): Borrando [FA_ACUMOPER_RESP_TH]:", LOG03);
            strcpy(szNomTabla,"FA_ACUMOPER_RESP_TH");
            /* EXEC SQL
                DELETE FA_ACUMOPER_RESP_TH A
                WHERE ( (A.COD_CLIENTE BETWEEN :lhClienteIni AND :lhClienteFin) OR (1 <> :ihIngRngCli) ); */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 7;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "delete  from FA_ACUMOPER_RESP_TH A  where (A.COD_\
CLIENTE between :b0 and :b1 or 1<>:b2)";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )217;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&lhClienteIni;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&lhClienteFin;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&ihIngRngCli;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqphsv = sqlstm.sqhstv;
            sqlstm.sqphsl = sqlstm.sqhstl;
            sqlstm.sqphss = sqlstm.sqhsts;
            sqlstm.sqpind = sqlstm.sqindv;
            sqlstm.sqpins = sqlstm.sqinds;
            sqlstm.sqparm = sqlstm.sqharm;
            sqlstm.sqparc = sqlstm.sqharc;
            sqlstm.sqpadto = sqlstm.sqadto;
            sqlstm.sqptdso = sqlstm.sqtdso;
            sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


            break;

        case FA_ACUMOPER_RESP_CICL_TH:
            vDTrazasLog(pszModulo, "(INFO) ifnTruncateTable(): Truncando [FA_ACUMOPER_RESP_CICL_TH]:", LOG03);
            strcpy(szNomTabla,"FA_ACUMOPER_RESP_CICL_TH");
            /* EXEC SQL EXECUTE
                BEGIN
                    FA_TRCT_ADMIN_PG.FA_TRUNC_OPER_RESP_CICL_TH_PR();
                END;
            END-EXEC; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 7;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "begin FA_TRCT_ADMIN_PG . FA_TRUNC_OPER_RESP_CICL_\
TH_PR ( ) ; END ;";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )244;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


            break;

        case FA_AGRZONAIMP_TO:
            vDTrazasLog(pszModulo, "(INFO) ifnTruncateTable(): Truncando [FA_AGRZONAIMP_TO]:", LOG03);
            strcpy(szNomTabla,"FA_AGRZONAIMP_TO");
            /* EXEC SQL EXECUTE
                BEGIN
                    FA_TRCT_ADMIN_PG.FA_TRUNC_FA_AGRZONAIMP_TO_PR();
                END;
            END-EXEC; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 7;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "begin FA_TRCT_ADMIN_PG . FA_TRUNC_FA_AGRZONAIMP_T\
O_PR ( ) ; END ;";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )259;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


            break;

        case TOL_ACUMOPER_TO:
            vDTrazasLog(pszModulo, "(INFO) ifnTruncateTable(): Truncando [TOL_ACUMOPER_TO]:", LOG03);
            strcpy(szNomTabla,"TOL_ACUMOPER_TO");
            /* EXEC SQL EXECUTE
                BEGIN
                    FA_TOL_ADMIN_PG.FA_TRUNCATE_TOL_ACUMOPER_TO_PR();
                END;
            END-EXEC; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 7;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "begin FA_TOL_ADMIN_PG . FA_TRUNCATE_TOL_ACUMOPER_\
TO_PR ( ) ; END ;";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )274;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


            break;

        default:
            /* Por defecto se trunca FA_ACUMOPER_RESP_TH */
            vDTrazasLog(pszModulo, "(INFO) ifnTruncateTable(): Truncando [FA_ACUMOPER_RESP_TH] por defecto:", LOG03);
            strcpy(szNomTabla,"FA_ACUMOPER_RESP_CICL_TH");
            /* EXEC SQL EXECUTE
                BEGIN
                    FA_TRCT_ADMIN_PG.FA_TRUNC_ACUMOPER_RESP_TH_PR();
                END;
            END-EXEC; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 7;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "begin FA_TRCT_ADMIN_PG . FA_TRUNC_ACUMOPER_RESP_T\
H_PR ( ) ; END ;";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )289;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


            break;
    }

    vDTrazasLog(pszModulo,"(INFO) ifnTruncateTable(): TRUNCANDO [%s], sqlca.sqlcode devuelto: [%d]\n", LOG03,szNomTabla,sqlca.sqlcode);
    /* Verificacion del codigo SQL devuelto */
    if (sqlca.sqlcode == 0 || sqlca.sqlcode == SqlNotFound)
        return(true);
    else
    {
       vDTrazasLog(pszModulo, "(ERROR) ifnTruncateTable(): Al Realizar DELETE A LA  TABLA [%s]\n", LOG01, szNomTabla);
       vfnMsgError("ifnTruncateTable",sqlca.sqlcode,false);
       return(false);
    }

}   /* Fin ifnTruncateTable */


/*********************************************************************************/
/* Funcion que Verifica la existencia del tipo de Proceso                        */
/*********************************************************************************/
int ifnExisteFa_recovery( char* pProceso, char* pEstado, int iModulo, long lCanReg, DATOSHOST stDatosHost)
{
   /* EXEC SQL BEGIN DECLARE SECTION; */ 

      char szhEstado[6]; /* EXEC SQL VAR szhEstado is STRING(6); */ 

      int ihExisteHostId = 0;
      char szhHostId[25] ="";
   /* EXEC SQL END DECLARE SECTION; */ 

   
   char *pszModulo="ifnExisteFa_recovery";
   
   vDTrazasLog(pszModulo,"##### ifnExisteFa_recovery #####\n"
   				  "##### pProceso = [%s]\n"
   				  "##### pEstado  = [%s]\n" 
   				  "##### iModulo  = [%d]\n"
   				  , LOG03
   				  , pProceso
   				  , pEstado
   				  , iModulo);  

   strcpy(szhHostId, stDatosHost.szHostId);
   ihExisteHostId = (stDatosHost.bExisteHostId==TRUE)?1:0;
   
   
   /* EXEC SQL
   SELECT  /o+ PARALLEL o/ VAL_MINIMO, VAL_MAXIMO, COD_ESTADO
   INTO    :ihValMinimo, :ihValMaximo, :szhEstado  
   FROM    FA_RECOVERY_TO
   WHERE   COD_PROC   = :pProceso
   AND     NUM_MODULO = :iModulo
   AND     COD_ESTADO = :pEstado
   AND     ((HOST_ID    = :szhHostId) OR (1 <> :ihExisteHostId) ); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 8;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select  /*+  PARALLEL  +*/ VAL_MINIMO ,VAL_MAXIMO ,COD_EST\
ADO into :b0,:b1,:b2  from FA_RECOVERY_TO where (((COD_PROC=:b3 and NUM_MODULO\
=:b4) and COD_ESTADO=:b5) and (HOST_ID=:b6 or 1<>:b7))";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )304;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihValMinimo;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&ihValMaximo;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhEstado;
   sqlstm.sqhstl[2] = (unsigned long )6;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)pProceso;
   sqlstm.sqhstl[3] = (unsigned long )0;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&iModulo;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)pEstado;
   sqlstm.sqhstl[5] = (unsigned long )0;
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)szhHostId;
   sqlstm.sqhstl[6] = (unsigned long )25;
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)&ihExisteHostId;
   sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqphsv = sqlstm.sqhstv;
   sqlstm.sqphsl = sqlstm.sqhstl;
   sqlstm.sqphss = sqlstm.sqhsts;
   sqlstm.sqpind = sqlstm.sqindv;
   sqlstm.sqpins = sqlstm.sqinds;
   sqlstm.sqparm = sqlstm.sqharm;
   sqlstm.sqparc = sqlstm.sqharc;
   sqlstm.sqpadto = sqlstm.sqadto;
   sqlstm.sqptdso = sqlstm.sqtdso;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



   if( sqlca.sqlcode == SqlNotFound )
   {
         if (!ifnCargaFa_recovery_to( ESTADO_INI, pProceso, iModulo, lCanReg, szhHostId ))
             return(false);
   }

   if( abs(sqlca.sqlcode) == SqlNull )
   {
         ihValMinimo = 0;
         ihValMaximo = 0;
   }
   vDTrazasLog(pszModulo, "##### Obtiene de Recovey: [%ld] [%ld] de Proceso [%s]\n", LOG03, ihValMinimo, ihValMaximo, pProceso);
   return(true);

}


/***************************************************************************/
/* Genera tabla para procesar por tramos de clientes                       */
/***************************************************************************/
int ifnCargaFa_recovery_to( char* pEstado, char* pProceso, long lModulo, long lCanReg, char *pszHostId )
{
   int iValorCero = 0;

   char *pszModulo="ifnCargaFa_recovery_to";
   
   vDTrazasLog(pszModulo, "##### ifnCargaFa_recovery_to #####\n"
          		   "##### pEstado   = [%s]\n" 
          		   "##### pProceso  = [%s]\n"
          		   "##### iModulo   = [%ld]\n" 
          		   "##### lCanReg   = [%ld]\n" 
          		   "##### pszHostId = [%s]\n"
          		   , LOG03
          		   , pEstado
          		   , pProceso
          		   , lModulo 
          		   , lCanReg
          		   , pszHostId);  

   /* EXEC SQL
   INSERT /o+ APPEND o/ INTO FA_RECOVERY_TO(COD_PROC,NUM_MODULO,VAL_MINIMO,VAL_MAXIMO,COD_ESTADO,NUM_ROWS,NUM_BLOQUE,HOST_ID)
   VALUES(:pProceso,:lModulo,:iValorCero,:iValorCero,:pEstado,:lCanReg,:iValorCero, :pszHostId); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 8;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "insert  /*+  APPEND  +*/ into FA_RECOVERY_TO (COD_PROC,NUM\
_MODULO,VAL_MINIMO,VAL_MAXIMO,COD_ESTADO,NUM_ROWS,NUM_BLOQUE,HOST_ID) values (\
:b0,:b1,:b2,:b2,:b4,:b5,:b2,:b7)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )351;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)pProceso;
   sqlstm.sqhstl[0] = (unsigned long )0;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&lModulo;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&iValorCero;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&iValorCero;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)pEstado;
   sqlstm.sqhstl[4] = (unsigned long )0;
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)&lCanReg;
   sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)&iValorCero;
   sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)pszHostId;
   sqlstm.sqhstl[7] = (unsigned long )0;
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqphsv = sqlstm.sqhstv;
   sqlstm.sqphsl = sqlstm.sqhstl;
   sqlstm.sqphss = sqlstm.sqhsts;
   sqlstm.sqpind = sqlstm.sqindv;
   sqlstm.sqpins = sqlstm.sqinds;
   sqlstm.sqparm = sqlstm.sqharm;
   sqlstm.sqparc = sqlstm.sqharc;
   sqlstm.sqpadto = sqlstm.sqadto;
   sqlstm.sqptdso = sqlstm.sqtdso;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



   if( sqlca.sqlcode != 0 )
   {
       vfnMsgError("Insert FA_RECOVERY_TO",sqlca.sqlcode,false);
       vDTrazasLog(pszModulo, "##### Error = [%d] en Insert FA_RECOVERY_TO\n", LOG01,sqlca.sqlcode);
       return(false);
   }
   return(true);
}


/*************************************************************************************************/
/* Lee tabla recovery y actualiza zona impositiva por grupo de clientes                           */
/*************************************************************************************************/
void vfnLeeFa_recovery( char *pTabla, char* pProceso, char* pEstado1, int iCursor, int iModulo, DATOSHOST stDatosHost)
{
   /* EXEC SQL BEGIN DECLARE SECTION; */ 

      char szhEstado[6]; /* EXEC SQL VAR szhEstado IS STRING(6); */ 

      char szhHostId[25] ="";
      int  ihExisteRango =0;
   /* EXEC SQL END DECLARE SECTION; */ 


   char szCadena[3000];
   char *pszModulo="vfnLeeFa_recovery";
   
   CLEAR( szCadena );
   
   ihExisteRango = (stDatosHost.bExisteHostId==TRUE)?1:0;
   strcpy(szhHostId, stDatosHost.szHostId);
   
   /* EXEC SQL
   SELECT  /o+ PARALLEL o/ VAL_MINIMO, VAL_MAXIMO, COD_ESTADO
   INTO    :ihValMinimo, :ihValMaximo, :szhEstado
   FROM    FA_RECOVERY_TO
   WHERE   COD_PROC   = :pProceso
   AND     NUM_MODULO = :iModulo
   AND     ( (HOST_ID = :szhHostId) OR (1 <> :ihExisteRango) ); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 8;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select  /*+  PARALLEL  +*/ VAL_MINIMO ,VAL_MAXIMO ,COD_EST\
ADO into :b0,:b1,:b2  from FA_RECOVERY_TO where ((COD_PROC=:b3 and NUM_MODULO=\
:b4) and (HOST_ID=:b5 or 1<>:b6))";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )398;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihValMinimo;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&ihValMaximo;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhEstado;
   sqlstm.sqhstl[2] = (unsigned long )6;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)pProceso;
   sqlstm.sqhstl[3] = (unsigned long )0;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&iModulo;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhHostId;
   sqlstm.sqhstl[5] = (unsigned long )25;
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)&ihExisteRango;
   sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqphsv = sqlstm.sqhstv;
   sqlstm.sqphsl = sqlstm.sqhstl;
   sqlstm.sqphss = sqlstm.sqhsts;
   sqlstm.sqpind = sqlstm.sqindv;
   sqlstm.sqpins = sqlstm.sqinds;
   sqlstm.sqparm = sqlstm.sqharm;
   sqlstm.sqparc = sqlstm.sqharc;
   sqlstm.sqpadto = sqlstm.sqadto;
   sqlstm.sqptdso = sqlstm.sqtdso;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



   vDTrazasLog(pszModulo, "##### Procesando pProceso en vfnLeeFa_recovery: = [%s]",LOG03,pProceso);
   vDTrazasLog(pszModulo, "##### Rangos despues del Select en vfnLeeFa_recovery: min = [%ld] max = [%ld] estado = [%s]\n"
   				 , LOG03
   				 , ihValMinimo
   				 , ihValMaximo
   				 , szhEstado);
   vDTrazasLog(pszModulo, "##### Tabla        = :v1 = [%s]" ,LOG03,pTabla);
   vDTrazasLog(pszModulo, "##### rownum       < :v2 = [%d]" ,LOG03,iCursor);
   vDTrazasLog(pszModulo, "##### cod_cliente  > :v3 = [%ld]",LOG03,ihValMaximo);
   vDTrazasLog(pszModulo, "##### cod_ciclfact = :v4 = [%ld]",LOG03,lhCiclo_fact);

   /* Ya esta cargada la tabla fa_recovery_to */

   sprintf( szCadena, "SELECT  /*+ PARALLEL */ MIN(cod_cliente), MAX(cod_cliente) FROM "
                      "(SELECT /*+ INDEX (TOL_ACUMOPER_TO TOL_ACUM_CLIE_IE) */ DISTINCT cod_cliente FROM "
                      "%s "
                      "WHERE rownum < :v2 AND cod_cliente > :v3 "
                      "  AND cod_ciclfact =:v4)", pTabla);

    vDTrazasLog(pszModulo, "----- vfnLeeFa_recovery szCadena [%s]\n", LOG05,szCadena);
    /* EXEC SQL DECLARE select_codCliente STATEMENT; */ 

    vfnMsgError("SELECT1 cursorCliente",sqlca.sqlcode,false);

    /* EXEC SQL PREPARE select_codCliente FROM :szCadena; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 8;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )441;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadena;
    sqlstm.sqhstl[0] = (unsigned long )3000;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
    sqlstm.sqphss = sqlstm.sqhsts;
    sqlstm.sqpind = sqlstm.sqindv;
    sqlstm.sqpins = sqlstm.sqinds;
    sqlstm.sqparm = sqlstm.sqharm;
    sqlstm.sqparc = sqlstm.sqharc;
    sqlstm.sqpadto = sqlstm.sqadto;
    sqlstm.sqptdso = sqlstm.sqtdso;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    vfnMsgError("SELECT2 cursorCliente",sqlca.sqlcode,false);

    /* EXEC SQL DECLARE cursorCliente CURSOR for select_codCliente; */ 

    vfnMsgError("SELECT3 cursorCliente",sqlca.sqlcode,false);

    /* EXEC SQL OPEN cursorCliente using :iCursor, :ihValMaximo, :lhCiclo_fact; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 8;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )460;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&iCursor;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihValMaximo;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhCiclo_fact;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
    sqlstm.sqphss = sqlstm.sqhsts;
    sqlstm.sqpind = sqlstm.sqindv;
    sqlstm.sqpins = sqlstm.sqinds;
    sqlstm.sqparm = sqlstm.sqharm;
    sqlstm.sqparc = sqlstm.sqharc;
    sqlstm.sqpadto = sqlstm.sqadto;
    sqlstm.sqptdso = sqlstm.sqtdso;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    vfnMsgError("SELECT4 cursorCliente",sqlca.sqlcode,false);

    /* EXEC SQL FETCH cursorCliente INTO :ihValMinimo, :ihValMaximo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 8;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )487;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihValMinimo;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihValMaximo;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
    sqlstm.sqphss = sqlstm.sqhsts;
    sqlstm.sqpind = sqlstm.sqindv;
    sqlstm.sqpins = sqlstm.sqinds;
    sqlstm.sqparm = sqlstm.sqharm;
    sqlstm.sqparc = sqlstm.sqharc;
    sqlstm.sqpadto = sqlstm.sqadto;
    sqlstm.sqptdso = sqlstm.sqtdso;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if( abs(sqlca.sqlcode) == SqlNull )
    {
         ihValMinimo = 0;
         ihValMaximo = 0;
    }
    vDTrazasLog(pszModulo, "##### Rangos Reales Procesados en vfnLeeFa_recovery: [%ld] [%ld]\n",LOG03, ihValMinimo, ihValMaximo);
    /* EXEC SQL CLOSE cursorCliente; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 8;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )510;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    return;

}/* Fin vfnLeeFa_recovery */


/***********************************************************/
/* Estado fa_recovery_to                                   */
/***********************************************************/
void vfnGetEstado(char* pProceso, int iModulo, DATOSHOST stDatosHost)
{
   /* EXEC SQL BEGIN DECLARE SECTION; */ 

   char     szhHostId[25]="";
   int      ihExisteHostId=0;
   /* EXEC SQL END   DECLARE SECTION; */ 

   
   strcpy(szhHostId,stDatosHost.szHostId);
   ihExisteHostId = (stDatosHost.bExisteHostId==TRUE)?1:0;
   
   lZonaimp=0;
   /* EXEC SQL
   SELECT  /o+ PARALLEL o/ COD_ESTADO, NUM_ROWS
   INTO    :szEstadoRecovery,
           :lZonaimp  /o Cantidada de Filas Iniciales a traspasar de ACUMOPER ==> AGRZONAIMP o/
   FROM    FA_RECOVERY_TO
   WHERE   COD_PROC   = :pProceso
   AND     NUM_MODULO = :iModulo
   AND     ( (HOST_ID    = :szhHostId) OR (1 <> :ihExisteHostId) ); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 8;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select  /*+  PARALLEL  +*/ COD_ESTADO ,NUM_ROWS into :b0,:\
b1  from FA_RECOVERY_TO where ((COD_PROC=:b2 and NUM_MODULO=:b3) and (HOST_ID=\
:b4 or 1<>:b5))";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )525;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szEstadoRecovery;
   sqlstm.sqhstl[0] = (unsigned long )6;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&lZonaimp;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)pProceso;
   sqlstm.sqhstl[2] = (unsigned long )0;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&iModulo;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)szhHostId;
   sqlstm.sqhstl[4] = (unsigned long )25;
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)&ihExisteHostId;
   sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqphsv = sqlstm.sqhstv;
   sqlstm.sqphsl = sqlstm.sqhstl;
   sqlstm.sqphss = sqlstm.sqhsts;
   sqlstm.sqpind = sqlstm.sqindv;
   sqlstm.sqpins = sqlstm.sqinds;
   sqlstm.sqparm = sqlstm.sqharm;
   sqlstm.sqparc = sqlstm.sqharc;
   sqlstm.sqpadto = sqlstm.sqadto;
   sqlstm.sqptdso = sqlstm.sqtdso;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



   vfnMsgError("Verifica estado vfnGetEstado ",sqlca.sqlcode,false);
   return;
} /* Fin vfnGetEstado */


/***************************************************************/
/* Actualiza fa_recovery_to                                    */
/***************************************************************/
int ifnUpdateRecovery(char* pProceso, int iModulo, char* pEstado, DATOSHOST stDatosHost)
{
   /* EXEC SQL BEGIN DECLARE SECTION; */ 

   char     szhHostId[25]="";
   int      ihExisteHostId=0;
   /* EXEC SQL END   DECLARE SECTION; */ 

   
   char *pszModulo="ifnUpdateRecovery";
   
   strcpy(szhHostId,stDatosHost.szHostId);
   ihExisteHostId = (stDatosHost.bExisteHostId==TRUE)?1:0;
    
    
    /* EXEC SQL
    UPDATE /o+ APPEND PARALLEL 4 o/
           FA_RECOVERY_TO
    SET
           VAL_MINIMO = :ihValMinimo,
           VAL_MAXIMO = :ihValMaximo,
           COD_ESTADO = :pEstado
    WHERE
           NUM_MODULO   = :iModulo
           AND COD_PROC = :pProceso
           AND ( (HOST_ID    = :szhHostId) OR (1 <> :ihExisteHostId) ); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 8;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update  /*+  APPEND PARALLEL 4  +*/ FA_RECOVERY_TO  set V\
AL_MINIMO=:b0,VAL_MAXIMO=:b1,COD_ESTADO=:b2 where ((NUM_MODULO=:b3 and COD_PRO\
C=:b4) and (HOST_ID=:b5 or 1<>:b6))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )564;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihValMinimo;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihValMaximo;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)pEstado;
    sqlstm.sqhstl[2] = (unsigned long )0;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&iModulo;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)pProceso;
    sqlstm.sqhstl[4] = (unsigned long )0;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhHostId;
    sqlstm.sqhstl[5] = (unsigned long )25;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&ihExisteHostId;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
    sqlstm.sqphss = sqlstm.sqhsts;
    sqlstm.sqpind = sqlstm.sqindv;
    sqlstm.sqpins = sqlstm.sqinds;
    sqlstm.sqparm = sqlstm.sqharm;
    sqlstm.sqparc = sqlstm.sqharc;
    sqlstm.sqpadto = sqlstm.sqadto;
    sqlstm.sqptdso = sqlstm.sqtdso;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    vDTrazasLog(pszModulo, "##### Update Recovery. Estado[%s] Min[%ld] Max[%ld]\n", LOG03, pEstado, ihValMinimo, ihValMaximo);
    if( sqlca.sqlcode != SqlOk )
       return false;

    return true;
}/* Fin ifnUpdateRecovery */

/***********************************************************/
/* Borra    fa_recovery_to                                 */
/***********************************************************/
void vfnDeleteRecovery( char* pProceso, long lModulo, DATOSHOST stDatosHost)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    char     szhHostId[25]="";
    int      ihExisteHostId=0;
    /* EXEC SQL END   DECLARE SECTION; */ 

    
    strcpy(szhHostId,stDatosHost.szHostId);
    ihExisteHostId = (stDatosHost.bExisteHostId==TRUE)?1:0;
    
    /* EXEC SQL
    DELETE /o+ APPEND PARALLEL 4 o/ FROM FA_RECOVERY_TO
    WHERE COD_PROC = :pProceso
    AND NUM_MODULO = :lModulo
    AND ( (HOST_ID    = :szhHostId) OR (1 <> :ihExisteHostId) ); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 8;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "delete  /*+  APPEND PARALLEL 4  +*/  from FA_RECOVERY_TO \
 where ((COD_PROC=:b0 and NUM_MODULO=:b1) and (HOST_ID=:b2 or 1<>:b3))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )607;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)pProceso;
    sqlstm.sqhstl[0] = (unsigned long )0;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lModulo;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhHostId;
    sqlstm.sqhstl[2] = (unsigned long )25;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihExisteHostId;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
    sqlstm.sqphss = sqlstm.sqhsts;
    sqlstm.sqpind = sqlstm.sqindv;
    sqlstm.sqpins = sqlstm.sqinds;
    sqlstm.sqparm = sqlstm.sqharm;
    sqlstm.sqparc = sqlstm.sqharc;
    sqlstm.sqpadto = sqlstm.sqadto;
    sqlstm.sqptdso = sqlstm.sqtdso;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    
    vfnMsgError("DELETE fa_recovery_to", sqlca.sqlcode, true);
    
    return;
   
}/* Fin vfnDeleteRecovery */

/*************************************************************************************************/
/* Funcion que imprime encabezado del programa     			                         */
/*************************************************************************************************/
void vEncabezado(void)
{
	fprintf(stdout, "\n%s\n",RAYA);
	fprintf(stdout, "Nombre Programa     : [%s]\n",NOM_PROGRAMA);
	fprintf(stdout, "Descripcion         : [%s]\n",GLS_PROGRAMA);
	fprintf(stdout, "Fecha de compilacion: [%s] - [%s]\n",__DATE__,__TIME__);
	fprintf(stdout, "%s\n",RAYA);


    return;
} /* Fin vEncabezado */

/**
 * Funcion     : bfnEsNumerico
 * Descripcion : Indica si una cadena es numerica.
 * Retorna     : 1       La cadena es numerica.
 *               0      La cadena no es numerica.
 */
int ifnEsNumerico(char *pszCad)
{
    unsigned int iLargoCad=0;
    register int i=0;

    iLargoCad = strlen(pszCad);
    if(iLargoCad==0)
        return 0;

    for(i=0;i<iLargoCad;i++)
    {
      if(!isdigit(pszCad[i]))
        return 0;

    }

    return 1;

} /* Fin  ifnEsNumerico */

/**
 * Funcion     : ifnExisteProcCiclo
 * Descripcion : Indica si el ciclo pasado por parametro existe en la tabla RECOVERY.
 * Retorna     : 1          El ciclo ya existe en la tabla.
 *               0          El ciclo no existe en la tabla.
 */
int ifnExisteProcCiclo(long lCodCicloFact, DATOSHOST stDatosHost)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    long lhCodCicloFact = 0L;
    char szhCodProc[30] ; /* EXEC SQL VAR szhCodProc IS STRING(30); */ 

    long lhNumRegs = 0L ;
    char szhHostId [25] ; /* EXEC SQL VAR szhHostId IS STRING(25); */ 

    /* EXEC SQL END   DECLARE SECTION; */ 

    
    char *pszModulo="ifnExisteProcCiclo";
    
     lhCodCicloFact = lCodCicloFact;
     strcpy(szhCodProc,PROC_AGRZONAIMP);
     strcpy(szhHostId, stDatosHost.szHostId);
    /* Validar la existencia del ciclo en la tabla de Log */

    if( stDatosHost.bExisteHostId == TRUE)
    {
        /* EXEC SQL
            SELECT COUNT(1)
              INTO :lhNumRegs
              FROM FA_RECOVERY_TO
             WHERE COD_PROC   = :szhCodProc
               AND NUM_MODULO = :lhCodCicloFact
               AND HOST_ID    = TRIM (:szhHostId); */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 8;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select count(1) into :b0  from FA_RECOVERY_TO where (\
(COD_PROC=:b1 and NUM_MODULO=:b2) and HOST_ID=trim(:b3))";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )638;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhNumRegs;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhCodProc;
        sqlstm.sqhstl[1] = (unsigned long )30;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCicloFact;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szhHostId;
        sqlstm.sqhstl[3] = (unsigned long )25;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqphsv = sqlstm.sqhstv;
        sqlstm.sqphsl = sqlstm.sqhstl;
        sqlstm.sqphss = sqlstm.sqhsts;
        sqlstm.sqpind = sqlstm.sqindv;
        sqlstm.sqpins = sqlstm.sqinds;
        sqlstm.sqparm = sqlstm.sqharm;
        sqlstm.sqparc = sqlstm.sqharc;
        sqlstm.sqpadto = sqlstm.sqadto;
        sqlstm.sqptdso = sqlstm.sqtdso;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    }
    else
    {
        /* EXEC SQL
            SELECT
                COUNT(1)
            INTO
                :lhNumRegs
            FROM
                FA_RECOVERY_TO
            WHERE
                COD_PROC       = :szhCodProc
                AND NUM_MODULO = :lhCodCicloFact; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 8;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select count(1) into :b0  from FA_RECOVERY_TO where (\
COD_PROC=:b1 and NUM_MODULO=:b2)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )669;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhNumRegs;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhCodProc;
        sqlstm.sqhstl[1] = (unsigned long )30;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCicloFact;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqphsv = sqlstm.sqhstv;
        sqlstm.sqphsl = sqlstm.sqhstl;
        sqlstm.sqphss = sqlstm.sqhsts;
        sqlstm.sqpind = sqlstm.sqindv;
        sqlstm.sqpins = sqlstm.sqinds;
        sqlstm.sqparm = sqlstm.sqharm;
        sqlstm.sqparc = sqlstm.sqharc;
        sqlstm.sqpadto = sqlstm.sqadto;
        sqlstm.sqptdso = sqlstm.sqtdso;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    }


    if(sqlca.sqlcode!= SqlOk ) {
        vDTrazasLog(pszModulo,"\t >> ERROR(ifnExisteProcCiclo): Al realizar SELECT COUNT(1) FROM FA_RECOVERY_TO <<\n", LOG01);
        vDTrazasLog(pszModulo,"\t >> Codigo Error Oracle: %d <<\n", LOG01,sqlca.sqlcode);
        vDTrazasError(pszModulo,"\t >> ERROR(ifnExisteProcCiclo): Al realizar SELECT COUNT(1) FROM FA_RECOVERY_TO <<\n", LOG01);
        vDTrazasError(pszModulo,"\t >> Codigo Error Oracle: %d <<\n", LOG01,sqlca.sqlcode);        
        
        return -1;

    }

    /* Si existen registros, devolver uno */
    if(lhNumRegs != 0)
        return 1;
    else
        return 0;



}


int ifnObtenerCiclosParaAgrupar(long lCodCiclFact, int iExistRngClientes, long lClieIni, long lClieFin)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    long    lhCodCiclFact = 0L;
    int     ihCodCiclo    = 0;
    char    szhFechaEmision[20]=""; /* EXEC SQL VAR szhFechaEmision IS STRING (20); */ 

    int     ihCodCicloCur    = 0;
    long    lhCodCiclFactCur = 0L;
    char    szhFechaEmisionCur[20]=""; /* EXEC SQL VAR szhFechaEmisionCur IS STRING (20); */ 

    int     ihValorUno = 1;
    int     ihValorDos = 2;
    int     ihExisteRangoClie =0;
    long    lhClienteInicial =0L;
    long    lhClienteFinal   =0L;
    /* EXEC SQL END   DECLARE SECTION; */ 


    register int i = 0;
    char  *pszModulo="ifnObtenerCiclosParaAgrupar";
    
    lhCodCiclFact = lCodCiclFact;
    lhClienteInicial = lClieIni;
    lhClienteFinal =  lClieFin;
    
    
    /* Obtencion de la fecha de emision y codigo de ciclo */
    /* EXEC SQL
        SELECT
            COD_CICLO
            ,TO_CHAR(FEC_EMISION,'YYYYMMDDHH24MISS')
        INTO
            :ihCodCiclo
            ,:szhFechaEmision
        FROM
            FA_CICLFACT
        WHERE
            COD_CICLFACT = :lhCodCiclFact; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 8;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_CICLO ,TO_CHAR(FEC_EMISION,'YYYYMMDDHH24MISS')\
 into :b0,:b1  from FA_CICLFACT where COD_CICLFACT=:b2";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )696;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodCiclo;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhFechaEmision;
    sqlstm.sqhstl[1] = (unsigned long )20;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCiclFact;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
    sqlstm.sqphss = sqlstm.sqhsts;
    sqlstm.sqpind = sqlstm.sqindv;
    sqlstm.sqpins = sqlstm.sqinds;
    sqlstm.sqparm = sqlstm.sqharm;
    sqlstm.sqparc = sqlstm.sqharc;
    sqlstm.sqpadto = sqlstm.sqadto;
    sqlstm.sqptdso = sqlstm.sqtdso;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if(sqlca.sqlcode!=SqlOk)
    {
        vDTrazasLog(pszModulo, "(ERROR) ifnObtenerCiclosParaAgrupar(): En obtencion de ciclo y fec_emision FA_CICLFACT\n"
                        "   - Codigo de error: [%d]\n"
                        , LOG01
                        , sqlca.sqlcode);
        vDTrazasError(pszModulo, "(ERROR) ifnObtenerCiclosParaAgrupar(): En obtencion de ciclo y fec_emision FA_CICLFACT\n"
                        "   - Codigo de error: [%d]\n"
                        , LOG01
                        , sqlca.sqlcode);                        
                        
        return -1;
    }

    giCodCiclo = ihCodCiclo;
    strcpy(gszFecEmision,szhFechaEmision);

    ihExisteRangoClie = (iExistRngClientes==1)?1:0;
    
    /* Obtencion de los ciclos de facturacion a procesar */
    /* EXEC SQL DECLARE curCiclosFact CURSOR FOR
        SELECT
            COD_CICLO
            ,COD_CICLFACT
            ,TO_CHAR(FEC_EMISION,'YYYYMMDDHH24MISS')
        FROM
            FA_CICLFACT
        WHERE
            IND_FACTURACION IN (:ihValorUno,:ihValorDos)
            AND FEC_EMISION <= TO_DATE(:szhFechaEmision,'YYYYMMDDHH24MISS')
            AND COD_CICLFACT IN (SELECT
                                    DISTINCT(COD_CICLFACT)
                                  FROM
                                      TOL_ACUMOPER_TO
                                  WHERE ( (COD_CLIENTE BETWEEN :lhClienteInicial AND :lhClienteFinal) OR (1 <> :ihExisteRangoClie) )); */ 


    if(sqlca.sqlcode!=SqlOk)
    {
        vDTrazasLog(pszModulo, "(ERROR) ifnObtenerCiclosParaAgrupar(): En EXEC SQL DECLARE curCiclosFact.\n"
                        "   - Codigo de error: [%d].\n"
                        , LOG01
                        ,sqlca.sqlcode);
        vDTrazasError(pszModulo, "(ERROR) ifnObtenerCiclosParaAgrupar(): En EXEC SQL DECLARE curCiclosFact.\n"
                        "   - Codigo de error: [%d].\n"
                        , LOG01
                        ,sqlca.sqlcode);

        return -1;
    }

    /* EXEC SQL OPEN curCiclosFact; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 8;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0024;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )723;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihValorUno;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihValorDos;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhFechaEmision;
    sqlstm.sqhstl[2] = (unsigned long )20;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&lhClienteInicial;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&lhClienteFinal;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihExisteRangoClie;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
    sqlstm.sqphss = sqlstm.sqhsts;
    sqlstm.sqpind = sqlstm.sqindv;
    sqlstm.sqpins = sqlstm.sqinds;
    sqlstm.sqparm = sqlstm.sqharm;
    sqlstm.sqparc = sqlstm.sqharc;
    sqlstm.sqpadto = sqlstm.sqadto;
    sqlstm.sqptdso = sqlstm.sqtdso;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if(sqlca.sqlcode!=SqlOk)
    {
        vDTrazasLog(pszModulo, "(ERROR) ifnObtenerCiclosParaAgrupar(): En EXEC SQL OPEN curCiclosFact.\n"
                        "   - Codigo de error: [%d].\n"
                        , LOG01
                        ,sqlca.sqlcode);
        vDTrazasError(pszModulo, "(ERROR) ifnObtenerCiclosParaAgrupar(): En EXEC SQL OPEN curCiclosFact.\n"
                        "   - Codigo de error: [%d].\n"
                        , LOG01
                        ,sqlca.sqlcode);
        return -1;
    }

    /* Romper el loop cuando todos los datos hayan sido recuperados */
    /* EXEC SQL WHENEVER NOT FOUND DO break; */ 


    stCiclos.iCantCiclos = 0;

    for(i=0;;i++)
    {
        /* EXEC SQL
            FETCH
                curCiclosFact
            INTO
                :ihCodCicloCur
                ,:lhCodCiclFactCur
                ,:szhFechaEmisionCur; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 8;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )762;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&ihCodCicloCur;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCiclFactCur;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhFechaEmisionCur;
        sqlstm.sqhstl[2] = (unsigned long )20;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqphsv = sqlstm.sqhstv;
        sqlstm.sqphsl = sqlstm.sqhstl;
        sqlstm.sqphss = sqlstm.sqhsts;
        sqlstm.sqpind = sqlstm.sqindv;
        sqlstm.sqpins = sqlstm.sqinds;
        sqlstm.sqparm = sqlstm.sqharm;
        sqlstm.sqparc = sqlstm.sqharc;
        sqlstm.sqpadto = sqlstm.sqadto;
        sqlstm.sqptdso = sqlstm.sqtdso;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
        if (sqlca.sqlcode == 1403) break;
}



        if(sqlca.sqlcode!=SqlOk)
        {
            vDTrazasLog(pszModulo, "(ERROR) ifnObtenerCiclosParaAgrupar(): En EXEC SQL FETCH curCiclosFact.\n"
                            "   - Codigo de error: [%d].\n"
                            , LOG01
                            , sqlca.sqlcode);
            vDTrazasError(pszModulo, "(ERROR) ifnObtenerCiclosParaAgrupar(): En EXEC SQL FETCH curCiclosFact.\n"
                            "   - Codigo de error: [%d].\n"
                            , LOG01
                            , sqlca.sqlcode);
            return -1;
        }


        /* Copia a la estructura */
        stCiclos.stCiclo[i].ihCodCiclo    = ihCodCicloCur;
        stCiclos.stCiclo[i].lhCodCiclFact = lhCodCiclFactCur;
        strcpy(stCiclos.stCiclo[i].szhFechaEmision, szhFechaEmisionCur);

        stCiclos.iCantCiclos++;

    }

    vDTrazasLog(pszModulo,"(INFO) ifnObtenerCiclosParaAgrupar(): Cantidad de ciclos recuperados: [%d]", LOG03,stCiclos.iCantCiclos);
    for(i=0;i<stCiclos.iCantCiclos;i++)
        vDTrazasLog(pszModulo,"\t- Ciclo[%d]:\t[%ld]\n", LOG03, i, stCiclos.stCiclo[i].lhCodCiclFact);

    /* Salida en forma exitosa */
    return 0;
}


#ifndef isnull
    #define isnull(name) (name==(char )NULL )
#endif
#ifndef strnull
    #define strnull(name) (name==(char *)NULL || name[0]==(char)NULL)
#endif

char *ltrim(char *s)
{
    char *p=s;
    if( strnull(s) ) 
        return(s);
    while( *p<=32 && *p>1 ) 
        p++;
    strcpy(s,p);
    return(s);
}

char *rtrim(char *s)
{
    char *p=NULL;
    if( strnull(s) ) 
        return(s);
    p=(s+strlen(s)-1);
    while( *p<=32 && *p>1 )  
        p--;
    *(++p)=0;
    return(s);
}

char *alltrim(char *s)
{
    return(ltrim(rtrim(s)));
}

/*! Funcion		: bfnAbreArchivosLog
 *  Descripcion : Apertura de archivos de Log y de error.
 *  
 */

BOOL bfnAbreArchivosLog(long lCodCiclFact, int iLogLevel)
{
    char modulo[]="bfnAbreArchivosLog";

    char *pathDir;
    char szArchivo[52]="";
    char szPath[128]="";
    char szComando[128]="";

    memset(szArchivo,'\0',sizeof(szArchivo));
    sprintf(szArchivo,"agrzonaimp_%s",cfnGetTime(5));

    pathDir=(char *)malloc(128);
    
    if( (pathDir=szGetEnv("XPF_LOG"))== (char*)NULL)
    {
    	fprintf(stdout,"(EE) Debe definirse la variable de  entorno \"XPF_LOG\" \n");	
    	return FALSE;
    }
    
    sprintf(szPath,"%s/agrzonaimp/%ld",pathDir,lCodCiclFact);
    free(pathDir);

    fprintf( stdout, "\n\tCrea Directorio Log  : %s\n", szPath);
    sprintf(szComando,"mkdir -p %s", szPath);
    system (szComando);

    fprintf( stdout, "\n\tCrea Archivo Log/Err : %s\n\n", szArchivo);

    stStatus.LogNivel = iLogLevel;

    sprintf(stStatus.ErrName,"%s/%s.err",szPath,szArchivo);
    if((stStatus.ErrFile = fopen(stStatus.ErrName,"a")) == (FILE*)NULL )/* "wb+" */
    {
        fprintf( stderr, "\n\t<< No pudo crearse el archivo de errores %s >> \n", stStatus.ErrName);
        return (FALSE);
    }

    sprintf(stStatus.LogName,"%s/%s.log",szPath,szArchivo);
    if((stStatus.LogFile = fopen(stStatus.LogName,"a")) == (FILE*)NULL ) /* "wb+" */
    {
        fprintf(stderr, "\n\t<< No pudo crearse el archivo de log %s >>\n", stStatus.LogName);
        vDTrazasError(modulo, " << No pudo crearse el archivo de log %s >>\n", LOG01, stStatus.LogName);
        return (FALSE);
    }

    vDTrazasLog(modulo, "(II)\t%s << Apertura exitosa Archivo de Log >>", LOG03, cfnGetTime(1));
    vDTrazasLog(modulo, "(II)\t%s << Apertura exitosa Archivo de Errores >>", LOG03, cfnGetTime(1));

    return (TRUE);
}

/*
 * Funcion      : bfnValidarTrazaDeProceso
 * Descripcion  : Funcion "wrapper" que ejecuta la validacion de traza de acuerdo a
 *                si existe o no defincion de Host_id en la configuracion de maquina.
 */
BOOL bfnWrapperValidaTrazaProc(long lCodCiclFact,int iCodProceso, int iIndFacturacion)
{

    char szHostId[25];


    if( (ifnGetHostId(szHostId))!=0 )
    {
        vDTrazasLog("bfnWrapperValidaTrazaProc", "(II)\t<< En bfnWrapperValidaTrazaProc->bfnValidaTrazaProc >>", LOG06);
        if (!bfnValidaTrazaProc( lCodCiclFact, iCodProceso, iIndFacturacion))
            return (FALSE);

    }
    else
    {
        vDTrazasLog("bfnWrapperValidaTrazaProc", "(II)\t<< En bfnWrapperValidaTrazaProc->bfnValidaTrazaProcHost >>", LOG06);
        if (!bfnValidaTrazaProcHost( lCodCiclFact, iCodProceso, iIndFacturacion, szHostId))
            return (FALSE);

    }

    return (TRUE);

}

/*
 * Funcion      : bfnWrapperSelectTrazaProc
 * Descripcion  : Funcion "wrapper" que selecciona datos de traza de acuerdo a
 *                si existe o no defincion de Host_id en la configuracion de maquina.
 */
BOOL bfnWrapperSelectTrazaProc (long lCicloFac,int iCodProc, TRAZAPROC * pstTraza)
{
    char szHostId[25];

    if( (ifnGetHostId(szHostId))!=0 )
    {
        if (!bfnSelectTrazaProc (lCicloFac, iCodProc, pstTraza))
            return (FALSE);
    }
    else
    {
        if (!bfnSelectTrazaProcHost (lCicloFac, iCodProc, pstTraza, szHostId))
            return (FALSE);
    }

    return (TRUE);

}

/*
 * Funcion      : bfnWrapperUpdateTrazaProc
 * Descripcion  : Funcion "wrapper" que actualiza datos de traza de acuerdo a
 *                si existe o no defincion de Host_id en la configuracion de maquina.
 */
BOOL bfnWrapperUpdateTrazaProc (TRAZAPROC pstTraza)
{
    char szHostId[25];

    if( (ifnGetHostId(szHostId))!=0 )
    {
        if (!bfnUpdateTrazaProc (pstTraza))
            return (FALSE);
    }
    else
    {
        if (!bfnUpdateTrazaProcHost (pstTraza, szHostId))
            return (FALSE);
    }

    return (TRUE);

}


/** Funcion que sera llamada por la aplicacion ante una salida abrupta utilizando exit()  **/
void vfnSalidaExit(void)
{
	char szFecha[15];
	
	/* Marcar FA_TRAZAPROC con error */
    
    if(!bfnSelectSysDate(szFecha))
    {
        vDTrazasError(gpszModulo," [%s][%d] - En Recuperacion de fecha de sistema con bfnSelectSysDate", LOG01, __FILE__, __LINE__);
        vDTrazasLog  (gpszModulo," [%s][%d] - En Recuperacion de fecha de sistema con bfnSelectSysDate", LOG01, __FILE__, __LINE__);
        return;    	
    }
    
    /*** Actualizacion de la traza ***/
    stTrazaProc.iCodEstaProc = iPROC_EST_ERR;
    /*strcpy(stTrazaProc.szFecInicio,stArgsEntrada.szHoraInicProc);*/
    strcpy(stTrazaProc.szFecTermino,szFecha);
    strcpy(stTrazaProc.szGlsProceso,"Proceso Agrupador terminado NO OK");
    
    bPrintTrazaProc(stTrazaProc);
    
    if(!bfnWrapperUpdateTrazaProc(stTrazaProc))
        return;
    if (!bfnOraCommit ())
    {
        vDTrazasError(gpszModulo," en Commit bfnWrapperUpdateTrazaProc", LOG01);
        vDTrazasLog  (gpszModulo," en Commit bfnWrapperUpdateTrazaProc", LOG01);
        return;
    }
	
		
	fprintf(stdout, "[ATENCION] Salida previa a finalizacion, consultar archivos de Log.\n");	
}

/****************************    Fin bfnAbreArchivosLog   ******************************/



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
