
/* Result Sets Interface */
#ifndef SQL_CRSR
#  define SQL_CRSR
  struct sql_cursor
  {
    unsigned int curocn;
    void *ptr1;
    void *ptr2;
    unsigned long magic;
  };
  typedef struct sql_cursor sql_cursor;
  typedef struct sql_cursor SQL_CURSOR;
#endif /* SQL_CRSR */

/* Thread Safety */
typedef void * sql_context;
typedef void * SQL_CONTEXT;

/* File name & Package Name */
struct sqlcxp
{
  unsigned short fillen;
           char  filnam[17];
};
static struct sqlcxp sqlfpn =
{
    16,
    "./pc/intarcel.pc"
};


static unsigned long sqlctx = 3457451;


static struct sqlexd {
   unsigned int   sqlvsn;
   unsigned int   arrsiz;
   unsigned int   iters;
   unsigned int   offset;
   unsigned short selerr;
   unsigned short sqlety;
   unsigned int   unused;
            short *cud;
   unsigned char  *sqlest;
            char  *stmt;
   unsigned char  **sqphsv;
   unsigned int   *sqphsl;
            short **sqpind;
   unsigned int   *sqparm;
   unsigned int   **sqparc;
   unsigned char  *sqhstv[5];
   unsigned int   sqhstl[5];
            short *sqindv[5];
   unsigned int   sqharm[5];
   unsigned int   *sqharc[5];
} sqlstm = {8,5};

/* Prototypes */
extern sqlcxt (/*_ void **, unsigned long *,
                   struct sqlexd *, struct sqlcxp * _*/);
extern sqlcx2t(/*_ void **, unsigned long *,
                   struct sqlexd *, struct sqlcxp * _*/);
extern sqlbuft(/*_ void **, char * _*/);
extern sqlgs2t(/*_ void **, char * _*/);
extern sqlorat(/*_ void **, unsigned long *, void * _*/);

/* Forms Interface */
static int IAPSUCC = 0;
static int IAPFAIL = 1403;
static int IAPFTL  = 535;
extern void sqliem(/*_ char *, int * _*/);

 static char *sq0004 = 
"select A.rowid  ,A.COD_CLIENTE ,A.NUM_ABONADO  from FA_CICLOCLI A ,GA_ABOBEE\
P B where (((((((A.COD_CICLO=:b0 and A.NUM_PROCESO=0) and A.COD_PRODUCTO=2) an\
d A.FEC_ALTA<=:b1) and B.NUM_ABONADO=A.NUM_ABONADO) and B.COD_CLIENTE=A.COD_CL\
IENTE) and B.COD_SITUACION in ('BAA','BAP')) and B.FEC_BAJA<=:b1) order by A.C\
OD_CLIENTE,A.NUM_ABONADO            ";
 static char *sq0005 = 
"select A.rowid  ,A.COD_CLIENTE ,A.NUM_ABONADO  from FA_CICLOCLI A ,GA_HABOBE\
EP B where ((((((A.COD_CICLO=:b0 and A.NUM_PROCESO=0) and A.COD_PRODUCTO=2) an\
d A.FEC_ALTA<=:b1) and B.NUM_ABONADO=A.NUM_ABONADO) and B.COD_SITUACION='REA')\
 and B.FEC_BAJACEN<:b2) order by A.COD_CLIENTE,A.NUM_ABONADO            ";
 static char *sq0006 = 
"select A.rowid  ,A.COD_CLIENTE ,A.NUM_ABONADO  from FA_CICLOCLI A ,GA_ABOCEL\
 B where (((((((A.COD_CICLO=:b0 and A.NUM_PROCESO=0) and A.COD_PRODUCTO=1) and\
 A.FEC_ALTA<=:b1) and B.NUM_ABONADO=A.NUM_ABONADO) and B.COD_CLIENTE=A.COD_CLI\
ENTE) and B.COD_SITUACION in ('BAA','BAP')) and B.FEC_BAJA<=:b1) order by A.CO\
D_CLIENTE,A.NUM_ABONADO            ";
 static char *sq0007 = 
"select A.rowid  ,A.COD_CLIENTE ,A.NUM_ABONADO  from FA_CICLOCLI A ,GA_HABOCE\
L B where ((((((A.COD_CICLO=:b0 and A.NUM_PROCESO=0) and A.COD_PRODUCTO=1) and\
 A.FEC_ALTA<=:b1) and B.NUM_ABONADO=A.NUM_ABONADO) and B.COD_SITUACION='REA') \
and B.FEC_BAJACEN<:b2) order by A.COD_CLIENTE,A.NUM_ABONADO            ";
 static char *sq0008 = 
"select ROWID ,COD_CLIENTE ,NUM_ABONADO  from FA_CICLOCLI where ((COD_CICLO=:\
b0 and NUM_PROCESO=0) and FEC_ALTA>:b1) order by COD_CLIENTE,NUM_ABONADO      \
      ";
 static char *sq0009 = 
"select ROWID ,COD_CLIENTE ,NUM_ABONADO ,COD_PRODUCTO  from FA_CICLOCLI where\
 ((COD_CICLO=:b0 and NUM_PROCESO=0) and FEC_ALTA<=:b1) order by COD_CLIENTE,NU\
M_ABONADO            ";
 static char *sq0010 = 
"select COD_CLIENTE ,NUM_ABONADO ,IND_ACTUAC ,IND_CUENCONTROLADA ,IND_CARGOPR\
O  from GA_INFACCEL where COD_CICLFACT=:b0 order by COD_CLIENTE,NUM_ABONADO   \
         ";
 static char *sq0011 = 
"select COD_CLIENTE ,NUM_ABONADO ,IND_ACTUAC ,IND_CARGOPRO  from GA_INFACBEEP\
 where COD_CICLFACT=:b0 order by COD_CLIENTE,NUM_ABONADO            ";
typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static short sqlcud0[] =
{8,4128,
2,0,0,1,0,0,32,167,0,0,0,0,1,0,
16,0,0,2,0,0,32,177,0,0,0,0,1,0,
30,0,0,3,108,0,4,222,0,4,1,0,1,0,2,3,0,0,2,97,0,0,2,97,0,0,1,3,0,0,
60,0,0,4,346,0,9,257,0,3,3,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,
86,0,0,4,0,0,13,265,0,3,0,0,1,0,2,97,0,0,2,3,0,0,2,3,0,0,
112,0,0,4,0,0,15,272,0,0,0,0,1,0,
126,0,0,5,304,0,9,293,0,3,3,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,
152,0,0,5,0,0,13,301,0,3,0,0,1,0,2,97,0,0,2,3,0,0,2,3,0,0,
178,0,0,5,0,0,15,308,0,0,0,0,1,0,
192,0,0,6,345,0,9,330,0,3,3,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,
218,0,0,6,0,0,13,338,0,3,0,0,1,0,2,97,0,0,2,3,0,0,2,3,0,0,
244,0,0,6,0,0,15,345,0,0,0,0,1,0,
258,0,0,7,303,0,9,366,0,3,3,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,
284,0,0,7,0,0,13,374,0,3,0,0,1,0,2,97,0,0,2,3,0,0,2,3,0,0,
310,0,0,7,0,0,15,381,0,0,0,0,1,0,
324,0,0,8,160,0,9,398,0,2,2,0,1,0,1,3,0,0,1,97,0,0,
346,0,0,8,0,0,13,406,0,3,0,0,1,0,2,97,0,0,2,3,0,0,2,3,0,0,
372,0,0,8,0,0,15,413,0,0,0,0,1,0,
386,0,0,9,175,0,9,430,0,2,2,0,1,0,1,3,0,0,1,97,0,0,
408,0,0,9,0,0,13,438,0,4,0,0,1,0,2,97,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
438,0,0,9,0,0,15,445,0,0,0,0,1,0,
452,0,0,10,163,0,9,460,0,1,1,0,1,0,1,3,0,0,
470,0,0,10,0,0,13,468,0,5,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
504,0,0,10,0,0,15,477,0,0,0,0,1,0,
518,0,0,11,144,0,9,492,0,1,1,0,1,0,1,3,0,0,
536,0,0,11,0,0,13,500,0,4,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
566,0,0,11,0,0,15,508,0,0,0,0,1,0,
580,0,0,12,87,0,4,552,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,
606,0,0,13,88,0,4,639,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,
632,0,0,14,128,0,4,692,0,5,4,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
666,0,0,15,108,0,4,711,0,4,3,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,
696,0,0,16,129,0,4,743,0,5,4,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
730,0,0,17,109,0,4,762,0,4,3,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,
760,0,0,18,55,0,5,796,0,2,2,0,1,0,1,3,0,0,1,97,0,0,
782,0,0,19,101,0,4,840,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
804,0,0,20,0,0,27,888,0,3,3,0,1,0,1,1,0,0,1,10,0,0,1,10,0,0,
830,0,0,21,54,0,1,891,0,0,0,0,1,0,
844,0,0,22,0,0,29,912,0,0,0,0,1,0,
858,0,0,23,0,0,29,928,0,0,0,0,1,0,
872,0,0,24,0,0,29,944,0,0,0,0,1,0,
886,0,0,25,0,0,29,960,0,0,0,0,1,0,
900,0,0,26,0,0,29,979,0,0,0,0,1,0,
914,0,0,27,0,0,30,1067,0,0,0,0,1,0,
};


/*************************************************************************/
/* Programa para detectar ausencia de registros en tabla GA_INTARCEL     */
/*                                                                       */
/* Por William Sepúlveda V.                                              */
/*-----------------------------------------------------------------------*/
/* Version 1 - Revision 00  ("kore.pc")					 */
/* 18 de enero de 1999.                                                  */
/*-----------------------------------------------------------------------*/
/* Version 1 - Revision 10  ("intarcel.pc")                              */
/* 18 de marzo de 1999.							 */
/* 									 */
/* - Se ajusta a estructura estandar de directorios.                     */
/*-----------------------------------------------------------------------*/
/* Version 2 - Revision 00						 */
/* Jueves 22 de abril de 1999.				        	 */
/*									 */
/* - Se agregan rutinas para determinar informacion de tabla FA_CICLFACT */
/* - Se disminuye la cantidad de argumentos recibidos externamente       */
/* - Se realiza separacion de anomalias posibles (para una mejor         */
/*   identificacion)							 */
/* - Se hacen mas precisas las condiciones de anomalias y se aumentan en */
/*   cuanto a cantidad							 */
/* - Se utiliza la tabla FA_CICLOCLI como universo de generacion de      */
/*   potenciales anomalias                                               */
/* - Se detectan tambien las ausencias en tabla GA_INFACCEL              */
/*-----------------------------------------------------------------------*/
/* Version 3 - Revision 00						 */
/* Viernes 30 de abril de 1999.						 */
/* 									 */
/* - Se aumenta la cantidad de anomalias que detecta.			 */
/* - Los registros con ind_actuac=2 en tabla GA_INFACCEL (bajas) se      */
/*   marcan como anomalias.						 */
/* - Se marcan diferenciadamente los abonados que tienen anomalias de    */
/*   aquellos que pertenecen a un cliente que tiene otros abonados con   */
/*   anomalias.                                                          */
/* - Cambia la filosofia de busqueda en tabla GA_INFACCEL, ya que ahora  */
/*   esta se lleva a memoria, con lo cual se trabaja a nivel de arrays.  */
/* - Cambian los accesos a la tabla FA_CICLOCLI, para realizar los       */
/*   updates: Ahora se hace por rowid.                                   */
/* - Se detectan y marcan los abonados celulares y beeper que estan en   */
/*   situacion de baja en la tabla GA_ABOCEL/GA_ABOBEEP.                 */
/* - Se hacen todas las detecciones tambien para beeper			 */
/*-----------------------------------------------------------------------*/
/* Version 3 - Revision 10						 */
/* Miercoles 05 de mayo de 1999.					 */
/*									 */
/* - Se detectan y marcan (con -95) los abonados dados de alta con       */
/*   posterioridad a la fecha de termino del periodo.			 */
/*-----------------------------------------------------------------------*/
/* Version 3 - Revision 20						 */
/* Martes 18 de mayo de 1999.   					 */
/*									 */
/* - Se modifica query sobre tablas GA_ABOCEL y GA_ABOBEEP, a fin de     */
/*   validar que la fecha de baja sea menor que la fecha de corte        */
/*   superior del periodo.                                               */
/*-----------------------------------------------------------------------*/
/* Version 3 - Revision 30						 */
/* Lunes 24 de mayo de 1999.    					 */
/*									 */
/* - Se incorpora la sentencia de alteracion del formato de fechas, para */
/*   contemplar manejo de hora, minuto y segundo.                        */
/*************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <string.h>
#include <strings.h>
#include <errno.h>
#include <sys/timeb.h>
#include <time.h>

#define MAX_BUFF     150000
#define MAX_BEEP      70000
#define MAX_OCURR      2000
#define PROG_VERSION  "3.30"
#define PATH            100
#define TRUE              1
#define FALSE             0
#define SQLNOTFOUND     100
#define SQLTMR        -2112
#define SQLOK             0
#define RET_OK            0
#define PROD_CELULAR      1
#define ANOM10	        -10
#define ANOM11	 	-11
#define ANOM12	 	-12
#define ANOM13	 	-13
#define ANOM14	 	-14
#define ANOM15	 	-15
#define ANOM16	 	-16
#define ANOM99	        -99     /* Abonado de Baja en GA_ABOCEL o en GA_ABOBEEP */
#define ANOM95	        -95     /* Abonado dado de alta con posterioridad a la fecha de termino del periodo */
#define ANOM40	 	-40
#define ANOM41	 	-41
#define ANOM42	 	-42
#define ANOM43	 	-43
#define ANOM44	 	-44
#define ANOM45	 	-45
#define RESTO	        -77	

/* EXEC SQL INCLUDE sqlca;
 */ 
/*
 * $Header: sqlca.h,v 1.3 1994/12/12 19:27:27 jbasu Exp $ sqlca.h 
 */

/* Copyright (c) 1985,1986 by Oracle Corporation. */
 
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
         /* b4  */ long    sqlabc;
         /* b4  */ long    sqlcode;
         struct
           {
           /* ub2 */ unsigned short sqlerrml;
           /* ub1 */ char           sqlerrmc[70];
           } sqlerrm;
         /* ub1 */ char    sqlerrp[8];
         /* b4  */ long    sqlerrd[6];
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



/* Variables globales definidas en base a campos de las tablas de la base de datos */

/* EXEC SQL BEGIN DECLARE SECTION; */ 

/*--------------------------------------------------*/
int	cod_cliente[MAX_BUFF];
int	num_abonado[MAX_BUFF];
int	num_celular[MAX_BUFF];
int	cliente_infac[MAX_BUFF];
int	abonado_infac[MAX_BUFF];
int	cliente_beep[MAX_BEEP];
int	abonado_beep[MAX_BEEP];
int	ind_cargopro_beep[MAX_BEEP];
int	ind_actuac_beep[MAX_BEEP];
short	indic_cp_beep[MAX_BEEP];
int	ind_actuac[MAX_BUFF];
int	ind_cuencontrolada[MAX_BUFF];
int	ind_cargopro[MAX_BUFF];
int	cod_producto[MAX_BUFF];
short	indic_cc[MAX_BUFF];
short	indic_cp[MAX_BUFF];
char	rowid[MAX_BUFF][19];
int	celular[MAX_BUFF];
int	cod_ciclfact;
int	cod_ciclo;
char	fec_desde[15];
char	fec_hasta[15];
/*--------------------------------------------------*/
/* EXEC SQL END DECLARE SECTION; */ 



/* -------------------------- */
/* Variables globales         */
/* -------------------------- */
char    file_anom[PATH]="";
int	anom10=0, anom11=0, anom12=0, anom13=0, anom14=0, anom15=0, anom16=0;
int	anom40=0, anom41=0, anom42=0, anom43=0, anom44=0, anom45=0, anom77=0;
int	mem_ind=0;
int	ret_infac[MAX_BUFF];

void 	Hora_Fecha()
{
	time_t timer;
	char date[25];
	size_t nbytes;

	timer = time((time_t *)0);
	nbytes = strftime(date, 25, "[%d/%m/%Y][%H:%M:%S]", (struct tm *)localtime(&timer));

	fprintf(stderr,"\n%s\n", date);
}


void 	sqlerror ()
{
        /* EXEC SQL WHENEVER SQLERROR CONTINUE; */ 


        Hora_Fecha();
        fprintf(stderr,"Error en ORACLE: ");
        fprintf(stderr,"\n%s\n", sqlca.sqlerrm.sqlerrmc);
        fprintf(stderr,"Proceso finalizado con error.\n");

        /* EXEC SQL ROLLBACK WORK RELEASE; */ 

{
        struct sqlexd sqlstm;

        sqlstm.sqlvsn = 8;
        sqlstm.arrsiz = 0;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )2;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        exit(1);
}


void 	FSigTerm (int sig)
{
        Hora_Fecha();
        fprintf(stderr,"FSigTerm: Fue invocada con sig[%d].\n",sig);
        fprintf(stderr,"Proceso finalizado anormalmente.");
        /* EXEC SQL ROLLBACK WORK RELEASE; */ 

{
        struct sqlexd sqlstm;

        sqlstm.sqlvsn = 8;
        sqlstm.arrsiz = 0;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )16;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        exit(1);
}


void    Config_Ambiente ()
{
        sprintf(file_anom, "%s/%d/anom_interfaz_%d.dat", getenv("DAT"), cod_ciclfact, cod_ciclfact);
}


FILE    *Abre_Arch (char *ptr, char *modo)
{
	FILE *fp;

	if((fp=fopen(ptr, modo)) == NULL)
	{
	   fprintf(stderr, "\nArchivo [%s] no pudo ser abierto.\n", ptr);
           fprintf(stderr, "Revise su existencia.\n");
	   fprintf(stderr, "Error Numero: %d     %s\n", errno, strerror(errno));
           fprintf(stderr, "Proceso finalizado con error.\n");
           exit(2);
        }

        return(fp);
}


void	Init_Variables ()
{
	int k;

	for(k=0; k<MAX_BUFF; k++)
	{
	   indic_cc[k] = 0;
	   indic_cp[k] = 0;
	   cod_cliente[k] = 0;
	   num_abonado[k] = 0;
	   strcpy(rowid[k], '\0');
	}
}


void	Busca_FaCiclFact ()
{
	/* EXEC SQL SELECT COD_CICLO, FEC_DESDECFIJOS, FEC_HASTACFIJOS
	INTO :cod_ciclo, :fec_desde, :fec_hasta
	FROM FA_CICLFACT
	WHERE COD_CICLFACT = :cod_ciclfact; */ 

{
 struct sqlexd sqlstm;

 sqlstm.sqlvsn = 8;
 sqlstm.arrsiz = 4;
 sqlstm.stmt = "select COD_CICLO ,FEC_DESDECFIJOS ,FEC_HASTACFIJOS into :b0,\
:b1,:b2  from FA_CICLFACT where COD_CICLFACT=:b3";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )30;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)0;
 sqlstm.sqhstv[0] = (unsigned char  *)&cod_ciclo;
 sqlstm.sqhstl[0] = (unsigned int  )4;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqharm[0] = (unsigned int  )0;
 sqlstm.sqhstv[1] = (unsigned char  *)fec_desde;
 sqlstm.sqhstl[1] = (unsigned int  )15;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqharm[1] = (unsigned int  )0;
 sqlstm.sqhstv[2] = (unsigned char  *)fec_hasta;
 sqlstm.sqhstl[2] = (unsigned int  )15;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqharm[2] = (unsigned int  )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&cod_ciclfact;
 sqlstm.sqhstl[3] = (unsigned int  )4;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqharm[3] = (unsigned int  )0;
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
 sqlstm.sqpind = sqlstm.sqindv;
 sqlstm.sqparm = sqlstm.sqharm;
 sqlstm.sqparc = sqlstm.sqharc;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	if(sqlca.sqlcode < SQLOK)
	{
          sqlerror();
	}
	if(sqlca.sqlcode == SQLNOTFOUND)
	{
	  fprintf(stderr, "No se ha encontrado informacion para el periodo [%d], en tabla FA_CICLFACT.\n");
	  fprintf(stderr, "Proceso se cancela.\n");
	  exit(3);
	}
}


int	Busca_Bajas_Beep ()
{
	int i=0;
	
	/* EXEC SQL DECLARE cursor_bajas_beep CURSOR FOR
 	SELECT A.ROWID, A.COD_CLIENTE, A.NUM_ABONADO
 	FROM FA_CICLOCLI A, GA_ABOBEEP B  
 	WHERE A.COD_CICLO  = :cod_ciclo
	AND A.NUM_PROCESO  = 0
	AND A.COD_PRODUCTO = 2
	AND A.FEC_ALTA    <= :fec_hasta  
	AND B.NUM_ABONADO  = A.NUM_ABONADO
	AND B.COD_CLIENTE  = A.COD_CLIENTE
	AND B.COD_SITUACION IN ('BAA', 'BAP')
	AND B.FEC_BAJA    <= :fec_hasta
	ORDER BY A.COD_CLIENTE, A.NUM_ABONADO; */ 


	/* EXEC SQL OPEN cursor_bajas_beep; */ 

{
 struct sqlexd sqlstm;

 sqlstm.sqlvsn = 8;
 sqlstm.arrsiz = 4;
 sqlstm.stmt = sq0004;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )60;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)0;
 sqlstm.sqhstv[0] = (unsigned char  *)&cod_ciclo;
 sqlstm.sqhstl[0] = (unsigned int  )4;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqharm[0] = (unsigned int  )0;
 sqlstm.sqhstv[1] = (unsigned char  *)fec_hasta;
 sqlstm.sqhstl[1] = (unsigned int  )15;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqharm[1] = (unsigned int  )0;
 sqlstm.sqhstv[2] = (unsigned char  *)fec_hasta;
 sqlstm.sqhstl[2] = (unsigned int  )15;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqharm[2] = (unsigned int  )0;
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
 sqlstm.sqpind = sqlstm.sqindv;
 sqlstm.sqparm = sqlstm.sqharm;
 sqlstm.sqparc = sqlstm.sqharc;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	while(1)
 	{
	   if(sqlca.sqlcode < 0) 
	   {
	      sqlerror();
	   }
    	   /* EXEC SQL FETCH cursor_bajas_beep
    	   INTO :rowid[i], :cod_cliente[i], :num_abonado[i]; */ 

{
        struct sqlexd sqlstm;

        sqlstm.sqlvsn = 8;
        sqlstm.arrsiz = 4;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )86;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)0;
        sqlstm.sqhstv[0] = (unsigned char  *)rowid[i];
        sqlstm.sqhstl[0] = (unsigned int  )19;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqharm[0] = (unsigned int  )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&cod_cliente[i];
        sqlstm.sqhstl[1] = (unsigned int  )4;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqharm[1] = (unsigned int  )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&num_abonado[i];
        sqlstm.sqhstl[2] = (unsigned int  )4;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqharm[2] = (unsigned int  )0;
        sqlstm.sqphsv = sqlstm.sqhstv;
        sqlstm.sqphsl = sqlstm.sqhstl;
        sqlstm.sqpind = sqlstm.sqindv;
        sqlstm.sqparm = sqlstm.sqharm;
        sqlstm.sqparc = sqlstm.sqharc;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



           if(sqlca.sqlcode == SQLNOTFOUND) break;
           i++;
        }

        /* EXEC SQL CLOSE cursor_bajas_beep; */ 

{
        struct sqlexd sqlstm;

        sqlstm.sqlvsn = 8;
        sqlstm.arrsiz = 4;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )112;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	return(i-1);
}


int	Busca_Bajas_Habobeep ()
{
	int i=0;
	
	/* EXEC SQL DECLARE cursor_habobeep CURSOR FOR
 	SELECT A.ROWID, A.COD_CLIENTE, A.NUM_ABONADO
 	FROM FA_CICLOCLI A, GA_HABOBEEP B  
 	WHERE A.COD_CICLO   = :cod_ciclo
	AND A.NUM_PROCESO   = 0
	AND A.COD_PRODUCTO  = 2
	AND A.FEC_ALTA     <= :fec_hasta  
	AND B.NUM_ABONADO   = A.NUM_ABONADO
	AND B.COD_SITUACION = 'REA'
	AND B.FEC_BAJACEN   < :fec_desde
	ORDER BY A.COD_CLIENTE, A.NUM_ABONADO; */ 


	/* EXEC SQL OPEN cursor_habobeep; */ 

{
 struct sqlexd sqlstm;

 sqlstm.sqlvsn = 8;
 sqlstm.arrsiz = 4;
 sqlstm.stmt = sq0005;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )126;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)0;
 sqlstm.sqhstv[0] = (unsigned char  *)&cod_ciclo;
 sqlstm.sqhstl[0] = (unsigned int  )4;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqharm[0] = (unsigned int  )0;
 sqlstm.sqhstv[1] = (unsigned char  *)fec_hasta;
 sqlstm.sqhstl[1] = (unsigned int  )15;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqharm[1] = (unsigned int  )0;
 sqlstm.sqhstv[2] = (unsigned char  *)fec_desde;
 sqlstm.sqhstl[2] = (unsigned int  )15;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqharm[2] = (unsigned int  )0;
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
 sqlstm.sqpind = sqlstm.sqindv;
 sqlstm.sqparm = sqlstm.sqharm;
 sqlstm.sqparc = sqlstm.sqharc;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	while(1)
 	{
	   if(sqlca.sqlcode < 0) 
	   {
	      sqlerror();
	   }
    	   /* EXEC SQL FETCH cursor_habobeep
    	   INTO :rowid[i], :cod_cliente[i], :num_abonado[i]; */ 

{
        struct sqlexd sqlstm;

        sqlstm.sqlvsn = 8;
        sqlstm.arrsiz = 4;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )152;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)0;
        sqlstm.sqhstv[0] = (unsigned char  *)rowid[i];
        sqlstm.sqhstl[0] = (unsigned int  )19;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqharm[0] = (unsigned int  )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&cod_cliente[i];
        sqlstm.sqhstl[1] = (unsigned int  )4;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqharm[1] = (unsigned int  )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&num_abonado[i];
        sqlstm.sqhstl[2] = (unsigned int  )4;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqharm[2] = (unsigned int  )0;
        sqlstm.sqphsv = sqlstm.sqhstv;
        sqlstm.sqphsl = sqlstm.sqhstl;
        sqlstm.sqpind = sqlstm.sqindv;
        sqlstm.sqparm = sqlstm.sqharm;
        sqlstm.sqparc = sqlstm.sqharc;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



           if(sqlca.sqlcode == SQLNOTFOUND) break;
           i++;
        }

        /* EXEC SQL CLOSE cursor_habobeep; */ 

{
        struct sqlexd sqlstm;

        sqlstm.sqlvsn = 8;
        sqlstm.arrsiz = 4;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )178;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	return(i-1);
}


int	Busca_Bajas_Cel ()
{
	int i=0;
	
	/* EXEC SQL DECLARE cursor_bajas_cel CURSOR FOR
 	SELECT A.ROWID, A.COD_CLIENTE, A.NUM_ABONADO
 	FROM FA_CICLOCLI A, GA_ABOCEL B  
 	WHERE A.COD_CICLO  = :cod_ciclo
	AND A.NUM_PROCESO  = 0
	AND A.COD_PRODUCTO = 1
	AND A.FEC_ALTA    <= :fec_hasta  
	AND B.NUM_ABONADO  = A.NUM_ABONADO
	AND B.COD_CLIENTE  = A.COD_CLIENTE
	AND B.COD_SITUACION IN ('BAA', 'BAP')
	AND B.FEC_BAJA    <= :fec_hasta
	ORDER BY A.COD_CLIENTE, A.NUM_ABONADO; */ 


	/* EXEC SQL OPEN cursor_bajas_cel; */ 

{
 struct sqlexd sqlstm;

 sqlstm.sqlvsn = 8;
 sqlstm.arrsiz = 4;
 sqlstm.stmt = sq0006;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )192;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)0;
 sqlstm.sqhstv[0] = (unsigned char  *)&cod_ciclo;
 sqlstm.sqhstl[0] = (unsigned int  )4;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqharm[0] = (unsigned int  )0;
 sqlstm.sqhstv[1] = (unsigned char  *)fec_hasta;
 sqlstm.sqhstl[1] = (unsigned int  )15;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqharm[1] = (unsigned int  )0;
 sqlstm.sqhstv[2] = (unsigned char  *)fec_hasta;
 sqlstm.sqhstl[2] = (unsigned int  )15;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqharm[2] = (unsigned int  )0;
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
 sqlstm.sqpind = sqlstm.sqindv;
 sqlstm.sqparm = sqlstm.sqharm;
 sqlstm.sqparc = sqlstm.sqharc;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	while(1)
 	{
	   if(sqlca.sqlcode < 0) 
	   {
	      sqlerror();
	   }
    	   /* EXEC SQL FETCH cursor_bajas_cel
    	   INTO :rowid[i], :cod_cliente[i], :num_abonado[i]; */ 

{
        struct sqlexd sqlstm;

        sqlstm.sqlvsn = 8;
        sqlstm.arrsiz = 4;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )218;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)0;
        sqlstm.sqhstv[0] = (unsigned char  *)rowid[i];
        sqlstm.sqhstl[0] = (unsigned int  )19;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqharm[0] = (unsigned int  )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&cod_cliente[i];
        sqlstm.sqhstl[1] = (unsigned int  )4;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqharm[1] = (unsigned int  )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&num_abonado[i];
        sqlstm.sqhstl[2] = (unsigned int  )4;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqharm[2] = (unsigned int  )0;
        sqlstm.sqphsv = sqlstm.sqhstv;
        sqlstm.sqphsl = sqlstm.sqhstl;
        sqlstm.sqpind = sqlstm.sqindv;
        sqlstm.sqparm = sqlstm.sqharm;
        sqlstm.sqparc = sqlstm.sqharc;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



           if(sqlca.sqlcode == SQLNOTFOUND) break;
           i++;
        }

        /* EXEC SQL CLOSE cursor_bajas_cel; */ 

{
        struct sqlexd sqlstm;

        sqlstm.sqlvsn = 8;
        sqlstm.arrsiz = 4;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )244;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	return(i-1);
}


int	Busca_Bajas_Habocel ()
{
	int i=0;
	
	/* EXEC SQL DECLARE cursor_habocel CURSOR FOR
 	SELECT A.ROWID, A.COD_CLIENTE, A.NUM_ABONADO
 	FROM FA_CICLOCLI A, GA_HABOCEL B  
 	WHERE A.COD_CICLO   = :cod_ciclo
	AND A.NUM_PROCESO   = 0
	AND A.COD_PRODUCTO  = 1
	AND A.FEC_ALTA     <= :fec_hasta  
	AND B.NUM_ABONADO   = A.NUM_ABONADO
	AND B.COD_SITUACION = 'REA'
	AND B.FEC_BAJACEN   < :fec_desde
	ORDER BY A.COD_CLIENTE, A.NUM_ABONADO; */ 


	/* EXEC SQL OPEN cursor_habocel; */ 

{
 struct sqlexd sqlstm;

 sqlstm.sqlvsn = 8;
 sqlstm.arrsiz = 4;
 sqlstm.stmt = sq0007;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )258;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)0;
 sqlstm.sqhstv[0] = (unsigned char  *)&cod_ciclo;
 sqlstm.sqhstl[0] = (unsigned int  )4;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqharm[0] = (unsigned int  )0;
 sqlstm.sqhstv[1] = (unsigned char  *)fec_hasta;
 sqlstm.sqhstl[1] = (unsigned int  )15;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqharm[1] = (unsigned int  )0;
 sqlstm.sqhstv[2] = (unsigned char  *)fec_desde;
 sqlstm.sqhstl[2] = (unsigned int  )15;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqharm[2] = (unsigned int  )0;
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
 sqlstm.sqpind = sqlstm.sqindv;
 sqlstm.sqparm = sqlstm.sqharm;
 sqlstm.sqparc = sqlstm.sqharc;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	while(1)
 	{
	   if(sqlca.sqlcode < 0) 
	   {
	      sqlerror();
	   }
    	   /* EXEC SQL FETCH cursor_habocel
    	   INTO :rowid[i], :cod_cliente[i], :num_abonado[i]; */ 

{
        struct sqlexd sqlstm;

        sqlstm.sqlvsn = 8;
        sqlstm.arrsiz = 4;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )284;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)0;
        sqlstm.sqhstv[0] = (unsigned char  *)rowid[i];
        sqlstm.sqhstl[0] = (unsigned int  )19;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqharm[0] = (unsigned int  )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&cod_cliente[i];
        sqlstm.sqhstl[1] = (unsigned int  )4;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqharm[1] = (unsigned int  )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&num_abonado[i];
        sqlstm.sqhstl[2] = (unsigned int  )4;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqharm[2] = (unsigned int  )0;
        sqlstm.sqphsv = sqlstm.sqhstv;
        sqlstm.sqphsl = sqlstm.sqhstl;
        sqlstm.sqpind = sqlstm.sqindv;
        sqlstm.sqparm = sqlstm.sqharm;
        sqlstm.sqparc = sqlstm.sqharc;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



           if(sqlca.sqlcode == SQLNOTFOUND) break;
           i++;
        }

        /* EXEC SQL CLOSE cursor_habocel; */ 

{
        struct sqlexd sqlstm;

        sqlstm.sqlvsn = 8;
        sqlstm.arrsiz = 4;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )310;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	return(i-1);
}


int	Busca_Altas_FaCicloCli ()
{
	int i=0;
	
	/* EXEC SQL DECLARE cursor_altas CURSOR FOR
 	SELECT ROWID, COD_CLIENTE, NUM_ABONADO
 	FROM FA_CICLOCLI   
 	WHERE COD_CICLO = :cod_ciclo
	AND NUM_PROCESO = 0
	AND FEC_ALTA > :fec_hasta  
	ORDER BY COD_CLIENTE, NUM_ABONADO; */ 


	/* EXEC SQL OPEN cursor_altas; */ 

{
 struct sqlexd sqlstm;

 sqlstm.sqlvsn = 8;
 sqlstm.arrsiz = 4;
 sqlstm.stmt = sq0008;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )324;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)0;
 sqlstm.sqhstv[0] = (unsigned char  *)&cod_ciclo;
 sqlstm.sqhstl[0] = (unsigned int  )4;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqharm[0] = (unsigned int  )0;
 sqlstm.sqhstv[1] = (unsigned char  *)fec_hasta;
 sqlstm.sqhstl[1] = (unsigned int  )15;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqharm[1] = (unsigned int  )0;
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
 sqlstm.sqpind = sqlstm.sqindv;
 sqlstm.sqparm = sqlstm.sqharm;
 sqlstm.sqparc = sqlstm.sqharc;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	while(1)
 	{
	   if(sqlca.sqlcode < 0) 
	   {
	      sqlerror();
	   }
    	   /* EXEC SQL FETCH cursor_altas
    	   INTO :rowid[i], :cod_cliente[i], :num_abonado[i]; */ 

{
        struct sqlexd sqlstm;

        sqlstm.sqlvsn = 8;
        sqlstm.arrsiz = 4;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )346;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)0;
        sqlstm.sqhstv[0] = (unsigned char  *)rowid[i];
        sqlstm.sqhstl[0] = (unsigned int  )19;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqharm[0] = (unsigned int  )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&cod_cliente[i];
        sqlstm.sqhstl[1] = (unsigned int  )4;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqharm[1] = (unsigned int  )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&num_abonado[i];
        sqlstm.sqhstl[2] = (unsigned int  )4;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqharm[2] = (unsigned int  )0;
        sqlstm.sqphsv = sqlstm.sqhstv;
        sqlstm.sqphsl = sqlstm.sqhstl;
        sqlstm.sqpind = sqlstm.sqindv;
        sqlstm.sqparm = sqlstm.sqharm;
        sqlstm.sqparc = sqlstm.sqharc;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



           if(sqlca.sqlcode == SQLNOTFOUND) break;
           i++;
        }

        /* EXEC SQL CLOSE cursor_altas; */ 

{
        struct sqlexd sqlstm;

        sqlstm.sqlvsn = 8;
        sqlstm.arrsiz = 4;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )372;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	return(i-1);
}


int	Busca_FaCicloCli ()
{
	int i=0;
	
	/* EXEC SQL DECLARE cursor_cli CURSOR FOR
 	SELECT ROWID, COD_CLIENTE, NUM_ABONADO, COD_PRODUCTO
 	FROM FA_CICLOCLI   
 	WHERE COD_CICLO = :cod_ciclo
	AND NUM_PROCESO = 0
	AND FEC_ALTA <= :fec_hasta  
	ORDER BY COD_CLIENTE, NUM_ABONADO; */ 


	/* EXEC SQL OPEN cursor_cli; */ 

{
 struct sqlexd sqlstm;

 sqlstm.sqlvsn = 8;
 sqlstm.arrsiz = 4;
 sqlstm.stmt = sq0009;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )386;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)0;
 sqlstm.sqhstv[0] = (unsigned char  *)&cod_ciclo;
 sqlstm.sqhstl[0] = (unsigned int  )4;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqharm[0] = (unsigned int  )0;
 sqlstm.sqhstv[1] = (unsigned char  *)fec_hasta;
 sqlstm.sqhstl[1] = (unsigned int  )15;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqharm[1] = (unsigned int  )0;
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
 sqlstm.sqpind = sqlstm.sqindv;
 sqlstm.sqparm = sqlstm.sqharm;
 sqlstm.sqparc = sqlstm.sqharc;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	while(1)
 	{
	   if(sqlca.sqlcode < 0) 
	   {
	      sqlerror();
	   }
    	   /* EXEC SQL FETCH cursor_cli
    	   INTO :rowid[i], :cod_cliente[i], :num_abonado[i], :cod_producto[i]; */ 

{
        struct sqlexd sqlstm;

        sqlstm.sqlvsn = 8;
        sqlstm.arrsiz = 4;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )408;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)0;
        sqlstm.sqhstv[0] = (unsigned char  *)rowid[i];
        sqlstm.sqhstl[0] = (unsigned int  )19;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqharm[0] = (unsigned int  )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&cod_cliente[i];
        sqlstm.sqhstl[1] = (unsigned int  )4;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqharm[1] = (unsigned int  )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&num_abonado[i];
        sqlstm.sqhstl[2] = (unsigned int  )4;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqharm[2] = (unsigned int  )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&cod_producto[i];
        sqlstm.sqhstl[3] = (unsigned int  )4;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqharm[3] = (unsigned int  )0;
        sqlstm.sqphsv = sqlstm.sqhstv;
        sqlstm.sqphsl = sqlstm.sqhstl;
        sqlstm.sqpind = sqlstm.sqindv;
        sqlstm.sqparm = sqlstm.sqharm;
        sqlstm.sqparc = sqlstm.sqharc;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



           if(sqlca.sqlcode == SQLNOTFOUND) break;
           i++;
        }

        /* EXEC SQL CLOSE cursor_cli; */ 

{
        struct sqlexd sqlstm;

        sqlstm.sqlvsn = 8;
        sqlstm.arrsiz = 4;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )438;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	return(i-1);
}


int	Carga_Infaccel ()
{
	int i=0;

        /* EXEC SQL DECLARE infac_cursor CURSOR FOR
	SELECT COD_CLIENTE, NUM_ABONADO, IND_ACTUAC, IND_CUENCONTROLADA, IND_CARGOPRO
        FROM GA_INFACCEL
        WHERE COD_CICLFACT  = :cod_ciclfact
	ORDER BY COD_CLIENTE, NUM_ABONADO; */ 


	/* EXEC SQL OPEN infac_cursor; */ 

{
 struct sqlexd sqlstm;

 sqlstm.sqlvsn = 8;
 sqlstm.arrsiz = 4;
 sqlstm.stmt = sq0010;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )452;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)0;
 sqlstm.sqhstv[0] = (unsigned char  *)&cod_ciclfact;
 sqlstm.sqhstl[0] = (unsigned int  )4;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqharm[0] = (unsigned int  )0;
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
 sqlstm.sqpind = sqlstm.sqindv;
 sqlstm.sqparm = sqlstm.sqharm;
 sqlstm.sqparc = sqlstm.sqharc;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	while(1)
	{
	   if(sqlca.sqlcode < 0)
	   {
	     sqlerror();
	   }
	   /* EXEC SQL FETCH infac_cursor
	   INTO :cliente_infac[i], :abonado_infac[i], :ind_actuac[i], 
		:ind_cuencontrolada[i] INDICATOR :indic_cc[i],
		:ind_cargopro[i] INDICATOR :indic_cp[i]; */ 

{
    struct sqlexd sqlstm;

    sqlstm.sqlvsn = 8;
    sqlstm.arrsiz = 5;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )470;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)0;
    sqlstm.sqhstv[0] = (unsigned char  *)&cliente_infac[i];
    sqlstm.sqhstl[0] = (unsigned int  )4;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqharm[0] = (unsigned int  )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&abonado_infac[i];
    sqlstm.sqhstl[1] = (unsigned int  )4;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqharm[1] = (unsigned int  )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ind_actuac[i];
    sqlstm.sqhstl[2] = (unsigned int  )4;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqharm[2] = (unsigned int  )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ind_cuencontrolada[i];
    sqlstm.sqhstl[3] = (unsigned int  )4;
    sqlstm.sqindv[3] = (         short *)&indic_cc[i];
    sqlstm.sqharm[3] = (unsigned int  )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&ind_cargopro[i];
    sqlstm.sqhstl[4] = (unsigned int  )4;
    sqlstm.sqindv[4] = (         short *)&indic_cp[i];
    sqlstm.sqharm[4] = (unsigned int  )0;
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
    sqlstm.sqpind = sqlstm.sqindv;
    sqlstm.sqparm = sqlstm.sqharm;
    sqlstm.sqparc = sqlstm.sqharc;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	   if(sqlca.sqlcode == SQLNOTFOUND) break;
	   i++;
	}

	/* EXEC SQL CLOSE infac_cursor; */ 

{
 struct sqlexd sqlstm;

 sqlstm.sqlvsn = 8;
 sqlstm.arrsiz = 5;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )504;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	return(i-1);
}


int	Carga_Infacbeep ()
{
	int i=0;

        /* EXEC SQL DECLARE infac_cursor_beep CURSOR FOR
	SELECT COD_CLIENTE, NUM_ABONADO, IND_ACTUAC, IND_CARGOPRO
        FROM GA_INFACBEEP
        WHERE COD_CICLFACT  = :cod_ciclfact
	ORDER BY COD_CLIENTE, NUM_ABONADO; */ 


	/* EXEC SQL OPEN infac_cursor_beep; */ 

{
 struct sqlexd sqlstm;

 sqlstm.sqlvsn = 8;
 sqlstm.arrsiz = 5;
 sqlstm.stmt = sq0011;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )518;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)0;
 sqlstm.sqhstv[0] = (unsigned char  *)&cod_ciclfact;
 sqlstm.sqhstl[0] = (unsigned int  )4;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqharm[0] = (unsigned int  )0;
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
 sqlstm.sqpind = sqlstm.sqindv;
 sqlstm.sqparm = sqlstm.sqharm;
 sqlstm.sqparc = sqlstm.sqharc;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	while(1)
	{
	   if(sqlca.sqlcode < 0)
	   {
	     sqlerror();
	   }
	   /* EXEC SQL FETCH infac_cursor_beep
	   INTO :cliente_beep[i], :abonado_beep[i], :ind_actuac_beep[i], 
		:ind_cargopro_beep[i] INDICATOR :indic_cp_beep[i]; */ 

{
    struct sqlexd sqlstm;

    sqlstm.sqlvsn = 8;
    sqlstm.arrsiz = 5;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )536;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)0;
    sqlstm.sqhstv[0] = (unsigned char  *)&cliente_beep[i];
    sqlstm.sqhstl[0] = (unsigned int  )4;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqharm[0] = (unsigned int  )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&abonado_beep[i];
    sqlstm.sqhstl[1] = (unsigned int  )4;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqharm[1] = (unsigned int  )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ind_actuac_beep[i];
    sqlstm.sqhstl[2] = (unsigned int  )4;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqharm[2] = (unsigned int  )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ind_cargopro_beep[i];
    sqlstm.sqhstl[3] = (unsigned int  )4;
    sqlstm.sqindv[3] = (         short *)&indic_cp_beep[i];
    sqlstm.sqharm[3] = (unsigned int  )0;
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
    sqlstm.sqpind = sqlstm.sqindv;
    sqlstm.sqparm = sqlstm.sqharm;
    sqlstm.sqparc = sqlstm.sqharc;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	   if(sqlca.sqlcode == SQLNOTFOUND) break;
	   i++;
	}

	/* EXEC SQL CLOSE infac_cursor_beep; */ 

{
 struct sqlexd sqlstm;

 sqlstm.sqlvsn = 8;
 sqlstm.arrsiz = 5;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )566;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	return(i-1);
}


int	Busca_Infaccel (int i, int max_infaccel)
{
	int k=mem_ind;

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int contador = 0;
	/* EXEC SQL END DECLARE SECTION; */ 


	while(((cod_cliente[i] != cliente_infac[k]) || (num_abonado[i] != abonado_infac[k])) &&
	      (k < max_infaccel))
	{
	   k++;
	}
	if(k == max_infaccel)
	{
	   if((cod_cliente[i] == cliente_infac[k]) && (num_abonado[i] == abonado_infac[k]))
	   {
	      if(ind_actuac[k] == 2)
	      {
		 anom10++;
		 return(ANOM10);
              }
	      if(ind_actuac[k] == 1)
	      {
		 if(indic_cc[k] == -1)
		 {
		   anom11++;
		   return(ANOM11);
		 }
		 if(indic_cp[k] == -1)
		 {
		   anom12++;
		   return(ANOM12);
		 }
		 return(RET_OK);
              }
	   }
	   else
	   {
              /* EXEC SQL SELECT COUNT(*) 
              INTO :contador
              FROM GA_INFACCEL
              WHERE COD_CLIENTE = :cod_cliente[i]
              AND NUM_ABONADO   = :num_abonado[i]; */ 

{
              struct sqlexd sqlstm;

              sqlstm.sqlvsn = 8;
              sqlstm.arrsiz = 5;
              sqlstm.stmt = "select count(*)  into :b0  from GA_INFACCEL whe\
re (COD_CLIENTE=:b1 and NUM_ABONADO=:b2)";
              sqlstm.iters = (unsigned int  )1;
              sqlstm.offset = (unsigned int  )580;
              sqlstm.selerr = (unsigned short)1;
              sqlstm.cud = sqlcud0;
              sqlstm.sqlest = (unsigned char  *)&sqlca;
              sqlstm.sqlety = (unsigned short)0;
              sqlstm.sqhstv[0] = (unsigned char  *)&contador;
              sqlstm.sqhstl[0] = (unsigned int  )4;
              sqlstm.sqindv[0] = (         short *)0;
              sqlstm.sqharm[0] = (unsigned int  )0;
              sqlstm.sqhstv[1] = (unsigned char  *)&cod_cliente[i];
              sqlstm.sqhstl[1] = (unsigned int  )4;
              sqlstm.sqindv[1] = (         short *)0;
              sqlstm.sqharm[1] = (unsigned int  )0;
              sqlstm.sqhstv[2] = (unsigned char  *)&num_abonado[i];
              sqlstm.sqhstl[2] = (unsigned int  )4;
              sqlstm.sqindv[2] = (         short *)0;
              sqlstm.sqharm[2] = (unsigned int  )0;
              sqlstm.sqphsv = sqlstm.sqhstv;
              sqlstm.sqphsl = sqlstm.sqhstl;
              sqlstm.sqpind = sqlstm.sqindv;
              sqlstm.sqparm = sqlstm.sqharm;
              sqlstm.sqparc = sqlstm.sqharc;
              sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	      if(sqlca.sqlcode < 0)
	      {
	        sqlerror();
	      }
	      if(contador > 0)
	      {
	        anom13++;
	        return(ANOM13);
	      }
	      else
	      {
		anom14++;
		return(ANOM14);
	      }
	   }
	}
	else
	{
	   mem_ind=k;
	   if(ind_actuac[k] == 2)
	   {
	     anom10++;
	     return(ANOM10);
           }
	   if(ind_actuac[k] == 1)
	   {
	     if(indic_cc[k] == -1)
	     {
	       anom11++;
	       return(ANOM11);
	     }
	     if(indic_cp[k] == -1)
	     {
	       anom12++;
	       return(ANOM12);
	     }
	     return(RET_OK);
           }
	}
}


int	Busca_Infacbeep (int i, int max_infacbeep)
{
	int k=0;

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int contador = 0;
	/* EXEC SQL END DECLARE SECTION; */ 


	while(((cod_cliente[i] != cliente_beep[k]) || (num_abonado[i] != abonado_beep[k])) &&
	      (k < max_infacbeep))
	{
	   k++;
	}
	if(k == max_infacbeep)
	{
	   if((cod_cliente[i] == cliente_beep[k]) && (num_abonado[i] == abonado_beep[k]))
	   {
	      if(ind_actuac_beep[k] == 2)
	      {
		 anom40++;
		 return(ANOM40);
              }
	      if(ind_actuac_beep[k] == 1)
	      {
		 if(indic_cp[k] == -1)
		 {
		   anom41++;
		   return(ANOM41);
		 }
		 if(ind_cargopro_beep[k] == 0)
		 {
		   anom41++;
		   return(ANOM41);
		 }
		 return(RET_OK);
              }
	   }
	   else
	   {
              /* EXEC SQL SELECT COUNT(*) 
              INTO :contador
              FROM GA_INFACBEEP
              WHERE COD_CLIENTE = :cod_cliente[i]
              AND NUM_ABONADO   = :num_abonado[i]; */ 

{
              struct sqlexd sqlstm;

              sqlstm.sqlvsn = 8;
              sqlstm.arrsiz = 5;
              sqlstm.stmt = "select count(*)  into :b0  from GA_INFACBEEP wh\
ere (COD_CLIENTE=:b1 and NUM_ABONADO=:b2)";
              sqlstm.iters = (unsigned int  )1;
              sqlstm.offset = (unsigned int  )606;
              sqlstm.selerr = (unsigned short)1;
              sqlstm.cud = sqlcud0;
              sqlstm.sqlest = (unsigned char  *)&sqlca;
              sqlstm.sqlety = (unsigned short)0;
              sqlstm.sqhstv[0] = (unsigned char  *)&contador;
              sqlstm.sqhstl[0] = (unsigned int  )4;
              sqlstm.sqindv[0] = (         short *)0;
              sqlstm.sqharm[0] = (unsigned int  )0;
              sqlstm.sqhstv[1] = (unsigned char  *)&cod_cliente[i];
              sqlstm.sqhstl[1] = (unsigned int  )4;
              sqlstm.sqindv[1] = (         short *)0;
              sqlstm.sqharm[1] = (unsigned int  )0;
              sqlstm.sqhstv[2] = (unsigned char  *)&num_abonado[i];
              sqlstm.sqhstl[2] = (unsigned int  )4;
              sqlstm.sqindv[2] = (         short *)0;
              sqlstm.sqharm[2] = (unsigned int  )0;
              sqlstm.sqphsv = sqlstm.sqhstv;
              sqlstm.sqphsl = sqlstm.sqhstl;
              sqlstm.sqpind = sqlstm.sqindv;
              sqlstm.sqparm = sqlstm.sqharm;
              sqlstm.sqparc = sqlstm.sqharc;
              sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	      if(sqlca.sqlcode < 0)
	      {
	        sqlerror();
	      }
	      if(contador > 0)
	      {
	        anom42++;
	        return(ANOM42);
	      }
	      else
	      {
		anom43++;
		return(ANOM43);
	      }
	   }
	}
	else
	{
	   if(ind_actuac_beep[k] == 2)
	   {
	     anom40++;
	     return(ANOM40);
           }
	   if(ind_actuac[k] == 1)
	   {
	     if(indic_cp_beep[k] == -1)
	     {
	       anom41++;
	       return(ANOM41);
	     }
	     if(ind_cargopro_beep[k] == 0) 
	     {
	       anom41++;
	       return(ANOM41);
	     }
	     return(RET_OK);
           }
	}
}


int	Busca_Intarcel (int i)
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int contador = 0;
	/* EXEC SQL END DECLARE SECTION; */ 


        /* EXEC SQL SELECT COUNT(*) 
        INTO :contador
        FROM GA_INTARCEL
        WHERE COD_CLIENTE = :cod_cliente[i]
        AND NUM_ABONADO   = :num_abonado[i]
	AND FEC_HASTA >= :fec_desde
	AND COD_CICLO  = :cod_ciclo; */ 

{
        struct sqlexd sqlstm;

        sqlstm.sqlvsn = 8;
        sqlstm.arrsiz = 5;
        sqlstm.stmt = "select count(*)  into :b0  from GA_INTARCEL where (((\
COD_CLIENTE=:b1 and NUM_ABONADO=:b2) and FEC_HASTA>=:b3) and COD_CICLO=:b4)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )632;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)0;
        sqlstm.sqhstv[0] = (unsigned char  *)&contador;
        sqlstm.sqhstl[0] = (unsigned int  )4;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqharm[0] = (unsigned int  )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&cod_cliente[i];
        sqlstm.sqhstl[1] = (unsigned int  )4;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqharm[1] = (unsigned int  )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&num_abonado[i];
        sqlstm.sqhstl[2] = (unsigned int  )4;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqharm[2] = (unsigned int  )0;
        sqlstm.sqhstv[3] = (unsigned char  *)fec_desde;
        sqlstm.sqhstl[3] = (unsigned int  )15;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqharm[3] = (unsigned int  )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&cod_ciclo;
        sqlstm.sqhstl[4] = (unsigned int  )4;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqharm[4] = (unsigned int  )0;
        sqlstm.sqphsv = sqlstm.sqhstv;
        sqlstm.sqphsl = sqlstm.sqhstl;
        sqlstm.sqpind = sqlstm.sqindv;
        sqlstm.sqparm = sqlstm.sqharm;
        sqlstm.sqparc = sqlstm.sqharc;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	if(sqlca.sqlcode < 0)
	{
	    sqlerror();
	}

	if(contador > 0)
	{
	   return(RET_OK);
	}
	else
	{
           /* EXEC SQL SELECT COUNT(*) 
           INTO :contador
           FROM GA_INTARCEL
           WHERE COD_CLIENTE = :cod_cliente[i]
           AND NUM_ABONADO   = :num_abonado[i]
	   AND FEC_HASTA >= :fec_desde; */ 

{
           struct sqlexd sqlstm;

           sqlstm.sqlvsn = 8;
           sqlstm.arrsiz = 5;
           sqlstm.stmt = "select count(*)  into :b0  from GA_INTARCEL where \
((COD_CLIENTE=:b1 and NUM_ABONADO=:b2) and FEC_HASTA>=:b3)";
           sqlstm.iters = (unsigned int  )1;
           sqlstm.offset = (unsigned int  )666;
           sqlstm.selerr = (unsigned short)1;
           sqlstm.cud = sqlcud0;
           sqlstm.sqlest = (unsigned char  *)&sqlca;
           sqlstm.sqlety = (unsigned short)0;
           sqlstm.sqhstv[0] = (unsigned char  *)&contador;
           sqlstm.sqhstl[0] = (unsigned int  )4;
           sqlstm.sqindv[0] = (         short *)0;
           sqlstm.sqharm[0] = (unsigned int  )0;
           sqlstm.sqhstv[1] = (unsigned char  *)&cod_cliente[i];
           sqlstm.sqhstl[1] = (unsigned int  )4;
           sqlstm.sqindv[1] = (         short *)0;
           sqlstm.sqharm[1] = (unsigned int  )0;
           sqlstm.sqhstv[2] = (unsigned char  *)&num_abonado[i];
           sqlstm.sqhstl[2] = (unsigned int  )4;
           sqlstm.sqindv[2] = (         short *)0;
           sqlstm.sqharm[2] = (unsigned int  )0;
           sqlstm.sqhstv[3] = (unsigned char  *)fec_desde;
           sqlstm.sqhstl[3] = (unsigned int  )15;
           sqlstm.sqindv[3] = (         short *)0;
           sqlstm.sqharm[3] = (unsigned int  )0;
           sqlstm.sqphsv = sqlstm.sqhstv;
           sqlstm.sqphsl = sqlstm.sqhstl;
           sqlstm.sqpind = sqlstm.sqindv;
           sqlstm.sqparm = sqlstm.sqharm;
           sqlstm.sqparc = sqlstm.sqharc;
           sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	   if(sqlca.sqlcode < 0)
	   {
	      sqlerror();
	   }

	   if(contador > 0)
	   {
	     anom15++;
	     return(ANOM15);
	   }
	   else
	   {
	     anom16++;
	     return(ANOM16);
           }
	}
}


int	Busca_Intarbeep (int i)
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int contador = 0;
	/* EXEC SQL END DECLARE SECTION; */ 


        /* EXEC SQL SELECT COUNT(*) 
        INTO :contador
        FROM GA_INTARBEEP
        WHERE COD_CLIENTE = :cod_cliente[i]
        AND NUM_ABONADO   = :num_abonado[i]
	AND FEC_HASTA >= :fec_desde
	AND COD_CICLO  = :cod_ciclo; */ 

{
        struct sqlexd sqlstm;

        sqlstm.sqlvsn = 8;
        sqlstm.arrsiz = 5;
        sqlstm.stmt = "select count(*)  into :b0  from GA_INTARBEEP where ((\
(COD_CLIENTE=:b1 and NUM_ABONADO=:b2) and FEC_HASTA>=:b3) and COD_CICLO=:b4)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )696;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)0;
        sqlstm.sqhstv[0] = (unsigned char  *)&contador;
        sqlstm.sqhstl[0] = (unsigned int  )4;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqharm[0] = (unsigned int  )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&cod_cliente[i];
        sqlstm.sqhstl[1] = (unsigned int  )4;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqharm[1] = (unsigned int  )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&num_abonado[i];
        sqlstm.sqhstl[2] = (unsigned int  )4;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqharm[2] = (unsigned int  )0;
        sqlstm.sqhstv[3] = (unsigned char  *)fec_desde;
        sqlstm.sqhstl[3] = (unsigned int  )15;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqharm[3] = (unsigned int  )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&cod_ciclo;
        sqlstm.sqhstl[4] = (unsigned int  )4;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqharm[4] = (unsigned int  )0;
        sqlstm.sqphsv = sqlstm.sqhstv;
        sqlstm.sqphsl = sqlstm.sqhstl;
        sqlstm.sqpind = sqlstm.sqindv;
        sqlstm.sqparm = sqlstm.sqharm;
        sqlstm.sqparc = sqlstm.sqharc;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	if(sqlca.sqlcode < 0)
	{
	    sqlerror();
	}

	if(contador > 0)
	{
	   return(RET_OK);
	}
	else
	{
           /* EXEC SQL SELECT COUNT(*) 
           INTO :contador
           FROM GA_INTARBEEP
           WHERE COD_CLIENTE = :cod_cliente[i]
           AND NUM_ABONADO   = :num_abonado[i]
	   AND FEC_HASTA >= :fec_desde; */ 

{
           struct sqlexd sqlstm;

           sqlstm.sqlvsn = 8;
           sqlstm.arrsiz = 5;
           sqlstm.stmt = "select count(*)  into :b0  from GA_INTARBEEP where\
 ((COD_CLIENTE=:b1 and NUM_ABONADO=:b2) and FEC_HASTA>=:b3)";
           sqlstm.iters = (unsigned int  )1;
           sqlstm.offset = (unsigned int  )730;
           sqlstm.selerr = (unsigned short)1;
           sqlstm.cud = sqlcud0;
           sqlstm.sqlest = (unsigned char  *)&sqlca;
           sqlstm.sqlety = (unsigned short)0;
           sqlstm.sqhstv[0] = (unsigned char  *)&contador;
           sqlstm.sqhstl[0] = (unsigned int  )4;
           sqlstm.sqindv[0] = (         short *)0;
           sqlstm.sqharm[0] = (unsigned int  )0;
           sqlstm.sqhstv[1] = (unsigned char  *)&cod_cliente[i];
           sqlstm.sqhstl[1] = (unsigned int  )4;
           sqlstm.sqindv[1] = (         short *)0;
           sqlstm.sqharm[1] = (unsigned int  )0;
           sqlstm.sqhstv[2] = (unsigned char  *)&num_abonado[i];
           sqlstm.sqhstl[2] = (unsigned int  )4;
           sqlstm.sqindv[2] = (         short *)0;
           sqlstm.sqharm[2] = (unsigned int  )0;
           sqlstm.sqhstv[3] = (unsigned char  *)fec_desde;
           sqlstm.sqhstl[3] = (unsigned int  )15;
           sqlstm.sqindv[3] = (         short *)0;
           sqlstm.sqharm[3] = (unsigned int  )0;
           sqlstm.sqphsv = sqlstm.sqhstv;
           sqlstm.sqphsl = sqlstm.sqhstl;
           sqlstm.sqpind = sqlstm.sqindv;
           sqlstm.sqparm = sqlstm.sqharm;
           sqlstm.sqparc = sqlstm.sqharc;
           sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	   if(sqlca.sqlcode < 0)
	   {
	      sqlerror();
	   }

	   if(contador > 0)
	   {
	     anom44++;
	     return(ANOM44);
	   }
	   else
	   {
	     anom45++;
	     return(ANOM45);
           }
	}
}


void	Update_FaCicloCli (int i, int anom)
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int num_proc = 0;
	/* EXEC SQL END DECLARE SECTION; */ 


	num_proc = anom;

	/* EXEC SQL UPDATE FA_CICLOCLI
	SET NUM_PROCESO   = :num_proc
	WHERE ROWID       = :rowid[i]; */ 

{
 struct sqlexd sqlstm;

 sqlstm.sqlvsn = 8;
 sqlstm.arrsiz = 5;
 sqlstm.stmt = "update FA_CICLOCLI  set NUM_PROCESO=:b0 where ROWID=:b1";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )760;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)0;
 sqlstm.sqhstv[0] = (unsigned char  *)&num_proc;
 sqlstm.sqhstl[0] = (unsigned int  )4;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqharm[0] = (unsigned int  )0;
 sqlstm.sqhstv[1] = (unsigned char  *)rowid[i];
 sqlstm.sqhstl[1] = (unsigned int  )19;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqharm[1] = (unsigned int  )0;
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
 sqlstm.sqpind = sqlstm.sqindv;
 sqlstm.sqparm = sqlstm.sqharm;
 sqlstm.sqparc = sqlstm.sqharc;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	if(sqlca.sqlcode < 0)
	{
	   sqlerror();
	}
}


void	Update_Resto (int i, int max_ciclocli)
{
	int k=0, flagcli=0;

	while((flagcli == 0) && (k < max_ciclocli))
	{
	  if(cod_cliente[i] != cod_cliente[k])
	  {
	     k++;
	  }
	  else
	  {
	     while(cod_cliente[i] == cod_cliente[k]) 
	     {
	       if(ret_infac[k] == 0)
	       {
	         ret_infac[k] = RESTO;
	         Update_FaCicloCli(k,ret_infac[k]);
		 anom77++;
	       }
	       k++;
	     }
	     flagcli=1;
 	  }	
	}
}

int	Clientes_Marcados ()
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int contador = 0;
	/* EXEC SQL END DECLARE SECTION; */ 


	/* EXEC SQL SELECT COUNT(DISTINCT COD_CLIENTE)
	INTO :contador
	FROM FA_CICLOCLI
	WHERE COD_CICLO = :cod_ciclo
	AND NUM_PROCESO < 0; */ 

{
 struct sqlexd sqlstm;

 sqlstm.sqlvsn = 8;
 sqlstm.arrsiz = 5;
 sqlstm.stmt = "select count(distinct COD_CLIENTE) into :b0  from FA_CICLOCL\
I where (COD_CICLO=:b1 and NUM_PROCESO<0)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )782;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)0;
 sqlstm.sqhstv[0] = (unsigned char  *)&contador;
 sqlstm.sqhstl[0] = (unsigned int  )4;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqharm[0] = (unsigned int  )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&cod_ciclo;
 sqlstm.sqhstl[1] = (unsigned int  )4;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqharm[1] = (unsigned int  )0;
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
 sqlstm.sqpind = sqlstm.sqindv;
 sqlstm.sqparm = sqlstm.sqharm;
 sqlstm.sqparc = sqlstm.sqharc;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	if(sqlca.sqlcode < 0)
	{
	   sqlerror();
	}

	return(contador);
}


int     main (int argc,char *argv[])
{
	int j=0, cont=0, cont_infac=0, cont_bajas_cel=0, cont_bajas_beep=0, cm=0;
	int cont_infac_beep=0, cont_altas=0, cont_habobeep=0, cont_habocel=0;
	FILE *fp_anom;

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char oracle_id = '/';
	/* EXEC SQL END DECLARE SECTION; */ 


	if(argc != 2)
	{
	   fprintf(stderr, "USO ES: %s <ciclfact> \n", argv[0]);
           exit(1);
        }

        Hora_Fecha();
        fprintf(stderr, "PROGRAMA DE DETECCION DE ANOMALIAS EN TABLAS DE INTERFAZ\n");
	fprintf(stderr, "VERSION %s\n\n", PROG_VERSION);
        fprintf(stderr, "\nNumero de proceso   : %d\n", getpid());
        fprintf(stderr, "Ejecutor del proceso: %s   (id = %d)\n", getlogin(), getuid());

	cod_ciclfact=atoi(argv[1]);

	Hora_Fecha();
	fprintf(stderr, "Configurando ambiente ...\n");
	Config_Ambiente();

	Hora_Fecha();
	fprintf(stderr, "Inicializando variables ...\n");
	Init_Variables();

	Hora_Fecha();
	/* EXEC SQL CONNECT :oracle_id; */ 

{
 struct sqlexd sqlstm;

 sqlstm.sqlvsn = 8;
 sqlstm.arrsiz = 5;
 sqlstm.iters = (unsigned int  )10;
 sqlstm.offset = (unsigned int  )804;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)0;
 sqlstm.sqhstv[0] = (unsigned char  *)&oracle_id;
 sqlstm.sqhstl[0] = (unsigned int  )1;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqharm[0] = (unsigned int  )0;
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
 sqlstm.sqpind = sqlstm.sqindv;
 sqlstm.sqparm = sqlstm.sqharm;
 sqlstm.sqparc = sqlstm.sqharc;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        fprintf(stderr, "Conexion con la base de datos ha resultado exitosa.\n");

	/* EXEC SQL ALTER SESSION SET NLS_DATE_FORMAT = 'yyyymmddhh24miss'; */ 

{
 struct sqlexd sqlstm;

 sqlstm.sqlvsn = 8;
 sqlstm.arrsiz = 5;
 sqlstm.stmt = "alter SESSION SET NLS_DATE_FORMAT = 'yyyymmddhh24miss'";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )830;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	Hora_Fecha();
	fprintf(stderr, "Buscando informacion en tabla FA_CICLFACT ...\n");
	Busca_FaCiclFact();
	fprintf(stderr, "Ciclo      : %d\n", cod_ciclo);
	fprintf(stderr, "Periodo    : %d\n", cod_ciclfact);
	fprintf(stderr, "Fecha Desde: %s\n", fec_desde);
	fprintf(stderr, "Fecha Hasta: %s\n", fec_hasta);

	Hora_Fecha();
	fprintf(stderr, "Buscando abonados beeper de baja en GA_HABOBEEP (ventas rechazadas) ...\n");
	cont_habobeep=Busca_Bajas_Habobeep();

	Hora_Fecha();
	fprintf(stderr, "Marcando en FA_CICLOCLI los abonados beeper de baja en GA_HABOBEEP ...\n");
	fp_anom=Abre_Arch(file_anom, "w");
	for(j=0; j<=cont_habobeep;j++)
	{
	   fprintf(fp_anom, "%.6d  %.6d  %d\n", cod_cliente[j], num_abonado[j], ANOM99);
	   Update_FaCicloCli(j,ANOM99);
	   /* EXEC SQL COMMIT; */ 

{
    struct sqlexd sqlstm;

    sqlstm.sqlvsn = 8;
    sqlstm.arrsiz = 5;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )844;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	}
	fclose(fp_anom);
	Init_Variables();

	Hora_Fecha();
	fprintf(stderr, "Buscando abonados celulares de baja en GA_HABOCEL (ventas rechazadas) ...\n");
	cont_habocel=Busca_Bajas_Habocel();

	Hora_Fecha();
	fprintf(stderr, "Marcando en FA_CICLOCLI los abonados celulares de baja en GA_HABOCEL ...\n");
	fp_anom=Abre_Arch(file_anom, "a");
	for(j=0; j<=cont_habocel;j++)
	{
	   fprintf(fp_anom, "%.6d  %.6d  %d\n", cod_cliente[j], num_abonado[j], ANOM99);
	   Update_FaCicloCli(j,ANOM99);
	   /* EXEC SQL COMMIT; */ 

{
    struct sqlexd sqlstm;

    sqlstm.sqlvsn = 8;
    sqlstm.arrsiz = 5;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )858;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	}
	fclose(fp_anom);
	Init_Variables();

	Hora_Fecha();
	fprintf(stderr, "Buscando abonados beeper dados de baja (GA_ABOBEEP) ...\n");
	cont_bajas_beep=Busca_Bajas_Beep();

	Hora_Fecha();
	fprintf(stderr, "Marcando en FA_CICLOCLI los abonados beeper dados de baja ...\n");
	fp_anom=Abre_Arch(file_anom, "a");
	for(j=0; j<=cont_bajas_beep;j++)
	{
	   fprintf(fp_anom, "%.6d  %.6d  %d\n", cod_cliente[j], num_abonado[j], ANOM99);
	   Update_FaCicloCli(j,ANOM99);
	   /* EXEC SQL COMMIT; */ 

{
    struct sqlexd sqlstm;

    sqlstm.sqlvsn = 8;
    sqlstm.arrsiz = 5;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )872;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	}
	fclose(fp_anom);
	Init_Variables();

	Hora_Fecha();
	fprintf(stderr, "Buscando abonados celulares dados de baja (GA_ABOCEL) ...\n");
	cont_bajas_cel=Busca_Bajas_Cel();

	Hora_Fecha();
	fprintf(stderr, "Marcando en FA_CICLOCLI los abonados celulares dados de baja ...\n");
	fp_anom=Abre_Arch(file_anom, "a");
	for(j=0; j<=cont_bajas_cel;j++)
	{
	   fprintf(fp_anom, "%.6d  %.6d  %d\n", cod_cliente[j], num_abonado[j], ANOM99);
	   Update_FaCicloCli(j,ANOM99);
	   /* EXEC SQL COMMIT; */ 

{
    struct sqlexd sqlstm;

    sqlstm.sqlvsn = 8;
    sqlstm.arrsiz = 5;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )886;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	}
	fclose(fp_anom);
	Init_Variables();

	Hora_Fecha();
	fprintf(stderr, "Llevando a memoria informacion de clientes/abonados en tablas GA_INFACCEL y GA_INFACBEEP ...\n");
	cont_infac=Carga_Infaccel();
	cont_infac_beep=Carga_Infacbeep();

	Hora_Fecha();
	fprintf(stderr, "Buscando clientes/abonados dados de alta mas alla del cierre del periodo ...\n");
	cont_altas=Busca_Altas_FaCicloCli();

	Hora_Fecha();
	fprintf(stderr, "Marcando en FA_CICLOCLI los abonados dados de alta ...\n");
	for(j=0; j<=cont_altas;j++)
	{
	   Update_FaCicloCli(j,ANOM95);
	   /* EXEC SQL COMMIT; */ 

{
    struct sqlexd sqlstm;

    sqlstm.sqlvsn = 8;
    sqlstm.arrsiz = 5;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )900;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	}
	Init_Variables();

	Hora_Fecha();
	fprintf(stderr, "Buscando informacion de clientes/abonados a facturar (FA_CICLOCLI) ...\n");
	cont=Busca_FaCicloCli();

	Hora_Fecha();
	fprintf(stderr, "Buscando anomalias en tablas de interfaz ...\n");
	fp_anom=Abre_Arch(file_anom, "a");
	for(j=0; j<=cont;j++)
	{
	  if(cod_producto[j] == PROD_CELULAR)
	  {
	    if((ret_infac[j]=Busca_Infaccel(j, cont_infac)) < 0)
	    {
	       fprintf(fp_anom, "%.6d  %.6d  %d\n", cod_cliente[j], num_abonado[j], ret_infac[j]);
	    }
	    else
	    {
	       if((ret_infac[j]=Busca_Intarcel(j)) < 0)
	       {
	          fprintf(fp_anom, "%.6d  %.6d  %d\n", cod_cliente[j], num_abonado[j], ret_infac[j]);
	       }	
	    }
	  }
	  else
	  {
	    if((ret_infac[j]=Busca_Infacbeep(j, cont_infac_beep)) < 0)
	    {
	       fprintf(fp_anom, "%.6d  %.6d  %d\n", cod_cliente[j], num_abonado[j], ret_infac[j]);
	    }
	    else
	    {
	       if((ret_infac[j]=Busca_Intarbeep(j)) < 0)
	       {
	          fprintf(fp_anom, "%.6d  %.6d  %d\n", cod_cliente[j], num_abonado[j], ret_infac[j]);
	       }	
	    }
	  }
	} /* Fin for */
	fclose(fp_anom);

	Hora_Fecha();
	fprintf(stderr, "Marcando anomalias en tabla FA_CICLOCLI ...\n");
	for(j=0; j<=cont;j++)
	{
	  if(ret_infac[j] < 0)
	  {
	     Update_FaCicloCli(j,ret_infac[j]);
	     Update_Resto(j,cont);
	  }
	}

	Hora_Fecha();
	fprintf(stderr, "Contabilizando los clientes marcados en tabla FA_CICLOCLI ...\n");
	cm=Clientes_Marcados();

	fprintf(stderr, "\nEstadistica del proceso:\n");
	fprintf(stderr, "========================\n");
        fprintf(stderr, "Cantidad de abonados a facturar        : %.6d\n", cont+1);
        fprintf(stderr, "Cantidad de bajas en GA_HABOBEEP       : %.6d\n", cont_habobeep+1);
        fprintf(stderr, "Cantidad de bajas en GA_HABOCEL        : %.6d\n", cont_habocel+1);
        fprintf(stderr, "Cantidad de abonados celulares de baja : %.6d\n", cont_bajas_cel+1);
        fprintf(stderr, "Cantidad de abonados beeper de baja    : %.6d\n", cont_bajas_beep+1);
        fprintf(stderr, "Cantidad de abonados dados de alta     : %.6d\n", cont_altas+1);
        fprintf(stderr, "Cantidad de abonados en GA_INFACCEL    : %.6d\n", cont_infac+1);
        fprintf(stderr, "Cantidad de abonados en GA_INFACBEEP   : %.6d\n", cont_infac_beep+1);
        fprintf(stderr, "Cantidad de abonados con anomalia 10   : %.6d\n", anom10);
        fprintf(stderr, "Cantidad de abonados con anomalia 11   : %.6d\n", anom11);
        fprintf(stderr, "Cantidad de abonados con anomalia 12   : %.6d\n", anom12);
        fprintf(stderr, "Cantidad de abonados con anomalia 13   : %.6d\n", anom13);
        fprintf(stderr, "Cantidad de abonados con anomalia 14   : %.6d\n", anom14);
        fprintf(stderr, "Cantidad de abonados con anomalia 15   : %.6d\n", anom15);
        fprintf(stderr, "Cantidad de abonados con anomalia 16   : %.6d\n", anom16);
        fprintf(stderr, "Cantidad de abonados con anomalia 40   : %.6d\n", anom40);
        fprintf(stderr, "Cantidad de abonados con anomalia 41   : %.6d\n", anom41);
        fprintf(stderr, "Cantidad de abonados con anomalia 42   : %.6d\n", anom42);
        fprintf(stderr, "Cantidad de abonados con anomalia 43   : %.6d\n", anom43);
        fprintf(stderr, "Cantidad de abonados con anomalia 44   : %.6d\n", anom44);
        fprintf(stderr, "Cantidad de abonados con anomalia 45   : %.6d\n", anom45);
        fprintf(stderr, "Cantidad de abonados marcados con 77   : %.6d\n", anom77);
        fprintf(stderr, "Cantidad de clientes anomalos marcados : %.6d\n", cm);

        Hora_Fecha();
        fprintf(stderr, "Proceso finalizado OK.\n");

        /* EXEC SQL COMMIT WORK RELEASE; */ 

{
        struct sqlexd sqlstm;

        sqlstm.sqlvsn = 8;
        sqlstm.arrsiz = 5;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )914;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	exit(0);

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

