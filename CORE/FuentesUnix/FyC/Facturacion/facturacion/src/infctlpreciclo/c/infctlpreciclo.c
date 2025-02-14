
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
           char  filnam[23];
};
static const struct sqlcxp sqlfpn =
{
    22,
    "./pc/infctlpreciclo.pc"
};


static unsigned int sqlctx = 221113843;


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
   unsigned char  *sqhstv[17];
   unsigned long  sqhstl[17];
            int   sqhsts[17];
            short *sqindv[17];
            int   sqinds[17];
   unsigned long  sqharm[17];
   unsigned long  *sqharc[17];
   unsigned short  sqadto[17];
   unsigned short  sqtdso[17];
} sqlstm = {12,17};

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

 static const char *sq0004 = 
"select ROWID ,COD_CLIENTE ,NUM_ABONADO ,COD_PRODUCTO ,IND_CAMBIO ,COD_CICLFA\
CT ,TO_CHAR(FEC_ALTA,'YYYYMMDDHH24MISS') ,TO_CHAR(FEC_BAJA,'YYYYMMDDHH24MISS')\
 ,IND_ACTUAC ,IND_SUPERTEL ,IND_FACTUR ,IND_BLOQUEO ,IND_ESTADO ,IND_CUENCONTR\
OLADA ,COD_EMPRESA ,COD_PLANTARIF ,COD_CARGOBASICO  from FAT_CTLINTERABO      \
      ";

 static const char *sq0007 = 
"AMBIO))) IMP_CARGO ,count(1) CANT  from GE_CARGOS B ,GE_CONVERSION C where (\
(((((((TO_DATE(:b0,'YYYYMMDDHH24MISS') between C.FEC_DESDE and C.FEC_HASTA and\
 C.COD_MONEDA=B.COD_MONEDA) and B.COD_CLIENTE>:b1) and B.COD_CONCEPTO_DTO is  \
not null ) and B.IMP_CARGO>:b1) and B.NUM_FACTURA=:b1) and B.NUM_TRANSACCION=:\
b1) and B.COD_CICLFACT in (select COD_CICLFACT  from FA_CICLFACT where FEC_EMI\
SION<=TO_DATE(:b0,'YYYYMMDDHH24MISS'))) and exists (select COD_CLIENTE  from F\
AT_CTLINTERABO A where (A.COD_CLIENTE=B.COD_CLIENTE and A.IND_ESTADO=1))) grou\
p by B.COD_CONCEPTO_DTO,B.COD_CICLFACT,B.COD_PRODUCTO)            ";

 static const char *sq0012 = 
"select A.COD_PRODUCTO ,A.COD_CONCEPTO ,T.COD_MONEDA ,count(A.COD_CONCEPTO) ,\
sum(T.IMP_TARIFA)  from (select distinct NUM_ABONADO  from FAT_CTLINTERABO whe\
re (IND_ESTADO=1 and NUM_ABONADO>0)) I ,GA_SERVSUPLABO A ,GA_SERVSUPL B ,GA_TA\
RIFAS T where ((((((((((T.COD_ACTABO='FA' and T.COD_TIPSERV=2) and T.IMP_TARIF\
A>0) and (TO_DATE(:b0,'YYYYMMDDHH24MISS') between T.FEC_DESDE and T.FEC_HASTA \
or T.FEC_HASTA is null )) and A.NUM_ABONADO=I.NUM_ABONADO) and A.COD_SERVICIO=\
T.COD_SERVICIO) and A.COD_PRODUCTO=T.COD_PRODUCTO) and A.IND_ESTADO in (1,2,5)\
) and B.COD_PRODUCTO=A.COD_PRODUCTO) and B.COD_SERVICIO=A.COD_SERVICIO) and A.\
COD_CONCEPTO is  not null ) group by A.COD_PRODUCTO,A.COD_CONCEPTO,T.COD_MONED\
A           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,29,0,2,403,0,0,0,0,0,1,0,
20,0,0,2,633,0,3,424,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
43,0,0,3,606,0,3,467,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
70,0,0,4,316,0,9,572,0,0,0,0,0,1,0,
85,0,0,4,0,0,13,583,0,0,17,0,0,1,0,2,9,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,
0,0,2,9,0,0,2,9,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,
9,0,0,2,9,0,0,
168,0,0,4,0,0,15,624,0,0,0,0,0,1,0,
183,0,0,4,0,0,15,696,0,0,0,0,0,1,0,
198,0,0,5,166,0,3,941,0,0,7,7,0,1,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,
3,0,0,1,3,0,0,
241,0,0,6,132,0,5,1010,0,0,6,6,0,1,0,1,3,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,
5,0,0,
280,0,0,7,1634,0,9,1119,0,0,13,13,0,1,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,
0,1,5,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
347,0,0,7,0,0,13,1128,0,0,5,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,4,0,0,
382,0,0,8,259,0,3,1154,0,0,13,13,0,1,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,4,0,0,1,3,0,0,
449,0,0,7,0,0,15,1205,0,0,0,0,0,1,0,
464,0,0,9,0,0,17,1476,0,0,1,1,0,1,0,1,97,0,0,
483,0,0,9,0,0,45,1496,0,0,1,1,0,1,0,1,3,0,0,
502,0,0,9,0,0,13,1505,0,0,7,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,4,0,0,2,
3,0,0,2,3,0,0,
545,0,0,10,259,0,3,1536,0,0,13,13,0,1,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,
0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,4,0,0,1,3,0,0,
612,0,0,9,0,0,15,1588,0,0,0,0,0,1,0,
627,0,0,11,280,0,3,1673,0,0,14,14,0,1,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,
0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,4,0,0,1,3,0,0,1,5,0,0,
698,0,0,12,712,0,9,1788,0,0,1,1,0,1,0,1,5,0,0,
717,0,0,12,0,0,13,1797,0,0,5,0,0,1,0,2,3,0,0,2,3,0,0,2,9,0,0,2,3,0,0,2,4,0,0,
752,0,0,13,259,0,3,1831,0,0,13,13,0,1,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,
0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,4,0,0,1,3,0,0,
819,0,0,12,0,0,15,1883,0,0,0,0,0,1,0,
834,0,0,14,83,0,4,1907,0,0,2,1,0,1,0,2,97,0,0,1,3,0,0,
857,0,0,15,419,0,4,1958,0,0,10,8,0,1,0,2,5,0,0,2,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
912,0,0,16,420,0,4,1976,0,0,10,8,0,1,0,2,5,0,0,2,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
967,0,0,17,88,0,5,2181,0,0,3,3,0,1,0,1,3,0,0,1,5,0,0,1,3,0,0,
994,0,0,18,246,0,3,2225,0,0,8,8,0,1,0,1,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,
1,5,0,0,1,5,0,0,1,3,0,0,
1041,0,0,19,55,0,4,2283,0,0,1,0,0,1,0,2,3,0,0,
1060,0,0,20,75,0,4,2298,0,0,2,1,0,1,0,2,5,0,0,1,3,0,0,
1083,0,0,21,247,0,4,2337,0,0,7,1,0,1,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
2,3,0,0,1,3,0,0,
1126,0,0,22,202,0,4,2393,0,0,5,1,0,1,0,2,3,0,0,2,9,0,0,2,4,0,0,2,9,0,0,1,5,0,0,
1161,0,0,23,69,0,4,2459,0,0,1,0,0,1,0,2,97,0,0,
1180,0,0,24,203,0,4,2504,0,0,3,2,0,1,0,2,4,0,0,1,5,0,0,1,5,0,0,
1207,0,0,25,144,0,4,2522,0,0,3,2,0,1,0,2,4,0,0,1,5,0,0,1,5,0,0,
1234,0,0,26,203,0,4,2540,0,0,3,2,0,1,0,2,4,0,0,1,5,0,0,1,5,0,0,
1261,0,0,27,144,0,4,2555,0,0,3,2,0,1,0,2,4,0,0,1,5,0,0,1,5,0,0,
1288,0,0,28,68,0,4,2722,0,0,2,0,0,1,0,2,3,0,0,2,3,0,0,
};


/* ********************************************************************** */
/* *  Fichero : infctlpreciclo.pc                                       * */
/* *  Informe de Pre-Facturacion de Ciclo                               * */
/* *  Autor : Mauricio Villagra V.                                      * */
/* *  Comentarios :                                                     * */
/* ********************************************************************** */


#define _INFCTLPRECICLO_PC_

#include "infctlpreciclo.h"

char szUsage[]=
   "\nUso:  infctlpreciclo -u Usuario/Password  "
   "\n\tOPCIONES:                               "
   "\n          -c Cod_CiclFact (DDMMYY)        "
   "\n          -l [LogNivel]                   "
   "\n          -t [Con Trazas] \n";

/****************************************************************************/
/*           Variables de Retorno de Oracle-Pro-C                           */
/****************************************************************************/

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



/****************************************************************************/
/*  Funcion :   main                                                        */
/****************************************************************************/

int main(int argc, char *argv[])
{

    extern  char *optarg        ;
    char    opt[]="u:c:l:t"      ;
    int     iOpt =0             ;
    char    szUsuario [63] = "" ;
    char    *psztmp      = ""   ;
    char    szaux     [10]      ;
    BOOL    bOptUsuario = FALSE ;
    char    szComando   [256]   ;
    char    *szDirLogs          ;
    char    szSysDate   [20]    ;
    char    szFecha     [20]    ; 
    

    memset(&stLineaComando,0,sizeof(PCF_LINEACOMANDO));
    memset(&stStatCargoBasico,0,sizeof(STATCTLCARGOBAS));


    while ( (iOpt = getopt(argc,argv,opt)) != EOF)
    {
        switch(iOpt)
        {   
            case 'u':
                    if (strlen (optarg))
                    {
                        strcpy(szUsuario, optarg);
                        bOptUsuario = TRUE;
                        fprintf (stdout," -u %s ", szUsuario);
                    }
                    break;
            case 'c':
                    if (strlen (optarg))
                    {
                        strcpy(szaux,optarg);
                        
                        stLineaComando.iCodCiclFact = atoi(szaux);
                        fprintf (stdout,"-c %d ", stLineaComando.iCodCiclFact);
                    }
                    break;
            case 't':
                    stLineaComando.bTrazas = TRUE;
                    break;
            case 'l':
                    if (strlen (optarg))
                    {
                        stStatus.LogNivel =
                        (atoi (optarg) > 0)? atoi (optarg):iLOGNIVEL_DEF ;
                        fprintf (stdout,"-l %d ", stStatus.LogNivel)     ;
                    }
                    break;
        }
    }

    /********************************************************************/
    /*              Validacion de Usuario Oracle                        */
    /********************************************************************/
    if (!bOptUsuario)
    {
        fprintf (stderr, "\n\t# Faltan Parametros de Entrada:\n%s\n", szUsage);
        return  (2);
    }
    else
    {
        if ( (psztmp=(char *)strstr (szUsuario,"/"))==(char *)NULL)
        {
            fprintf (stderr,"\n\tUsuario Oracle no Valido\n%s\n",szUsage);
            return (3);
        }
        else
        {
            strncpy (stLineaComando.szUser,szUsuario,psztmp-szUsuario);
            strcpy  (stLineaComando.szPass, psztmp+1)                 ;
        }
    }

    if (stStatus.LogNivel <= 0)
        stStatus.LogNivel = iLOGNIVEL_DEF     ;
    stLineaComando.iNivLog = stStatus.LogNivel;
     
    /********************************************************************/
    /*              Establece Conexion a ORACLE                         */
    /********************************************************************/
    if(!bfnConnectORA(stLineaComando.szUser,stLineaComando.szPass))
    {
        fprintf(stderr, "\n\tUsuario/Passwd Invalido\n\t\t"
                        "'sptel  <usuario> <passwd> '\n");
        return (3);
    }
    else
    {
        printf( "\n\t-------------------------------------------------------"
                "\n\tConectado a ORACLE: Usuario %s Passwd xxxxxxxx "
                "\n\t-------------------------------------------------------"
                ,stLineaComando.szUser);
    }
    /*********************************************************************************************/
    /*********************************************************************************************/
    if (!bGetDatosGener (&stDatosGener, szSysDate))
        return FALSE;
    /**************************************************************************************/
    szDirLogs=(char *)malloc(1024);
    if ((szDirLogs = szGetEnv("XPF_LOG")) == (char *)NULL)
        return (FALSE);
    /**************************************************************************************/
    sprintf(stLineaComando.szDirLogs,"%s/informes/Ciclo/%d/",szDirLogs,stLineaComando.iCodCiclFact);
    sprintf (szComando, "/usr/bin/mkdir -p %s",stLineaComando.szDirLogs );
    if (system (szComando))
    {
        printf( "\n\t***   Fallo mkdir de Directorio Logs : %s \n",szComando);
        return (FALSE);
    }
    /*********************************************************************************************/
    sprintf(stStatus.ErrName, "%sInfCtlPreCiclo_%s.err",
            stLineaComando.szDirLogs, szSysDate);

    if( (stStatus.ErrFile = fopen(stStatus.ErrName,"wb")) == (FILE*)NULL )
    {
        fprintf( stderr, "\n ### Error: No puede abrirse el fichero "
                         "de error %s\n", stStatus.ErrName);
        return (4);
    }
    
    /*********************************************************************************************/
    sprintf(stStatus.LogName, "%sInfCtlPreCiclo_%s.log",
            stLineaComando.szDirLogs, szSysDate);

    if ((stStatus.LogFile = fopen(stStatus.LogName,"wb")) == (FILE*)NULL)
    {
        fprintf( stderr, "\n ### Error: No puede abrirse el fichero "
                         "de log %s\n", stStatus.LogName);
        fclose(stStatus.ErrFile);
        return (5);
    }
    /*********************************************************************************************/
    vDTrazasLog  (szExeInfCtlPreCiclo,"\n\n\t******************************************"
                                    "\n\n\t****        Log   InfCtlPreCiclo          **"
                                    "\n\n\t******************************************"
                                    ,LOG03);

    vDTrazasError(szExeInfCtlPreCiclo,"\n\n\t***************************************"
                                    "\n\n\t****     Errores de InfCtlPreCiclo     **"
                                    "\n\n\t***************************************"
                                    ,LOG03);
    /*********************************************************************************************/

    if(!bMainReporte())
        bfnOraRollBackRelease();
    else 
    {
        if (!bfnOraCommit())
        {
           vDTrazasError(szExeInfCtlPreCiclo, "\n\n\tError en Commit ", LOG01);
           return FALSE;
        }
    }                                        
    /*********************************************************************************************/
    /*  Actualiza Traza  de Facturacion                                         */
    /****************************************************************************/
    if (stLineaComando.bTrazas){
            if (!bfnSelectSysDate(szFecha))
                return (FALSE);
            else
            {
                stTrazaProc.iCodEstaProc       = iPROC_EST_OK                                 ;
                strcpy(stTrazaProc.szFecTermino,szFecha)                                      ;

                if (stLineaComando.iIndFacturacion == iIND_FACT_NOPROCESADO){
                    strcpy(stTrazaProc.szGlsProceso,"Proceso de Control de Pre-Ciclo OK");
                    vDTrazasLog(szExeInfCtlPreCiclo,"Proceso de Control de Pre-Ciclo OK",LOG03);
                }               
                else {
                    strcpy(stTrazaProc.szGlsProceso,"Proceso de Control de Post-Ciclo OK");
                    vDTrazasLog(szExeInfCtlPreCiclo,"Proceso de Control de Post-Ciclo OK",LOG03);
                }
                stTrazaProc.lCodCliente        = 0                                            ;
                stTrazaProc.lNumAbonado        = 0                                            ;
                stTrazaProc.lNumRegistros      = 0                                            ;
                bPrintTrazaProc(stTrazaProc)                                                  ;
                if (!bfnUpdateTrazaProc(stTrazaProc))
                    return (FALSE);
            }
    }
    /*********************************************************************************************/
    if(bfnDisconnectORA(0))
    {
        vDTrazasLog(szExeInfCtlPreCiclo,
                "\n\t-------------------------------------------------------"
                "\n\tDesconectado de ORACLE  %s"
                "\n\t-------------------------------------------------------\n",
                LOG03, stLineaComando.szUser);
    }

    return (0);
}




/****************************************************************************/
/*  Funcion :   bMainReporte                                                */
/****************************************************************************/
BOOL  bMainReporte( void )
{
   vDTrazasLog(szExeInfCtlPreCiclo,  "\t\t==>Entrando a bMainReporte",   LOG03);
    
    if (stLineaComando.iCodCiclFact == 0)
    {
        vDTrazasError(szExeInfCtlPreCiclo, "Codigo de Ciclo de Facturacion Invalido [%d] (bMainReporte)"
                                          ,LOG01,stLineaComando.iCodCiclFact);
        return FALSE;
    }
    /****************************************************************/
    /*  Carga Planes Tarifarios de Planes Familiares                */
    /****************************************************************/
    if (!bfnCargaPlanFamiliar())
    {
        vDTrazasError(szExeInfCtlPreCiclo,"Error en Carga de Planes Familiares (bMainReporte)",LOG01);
        return FALSE;
    }
    /****************************************************************/
    /*  Carga Datos de Ciclo de Facturacion                         */
    /****************************************************************/
    if (!bfnEstadoProcCiclo())
    {
        vDTrazasError(szExeInfCtlPreCiclo,"Error en Carga de Ciclo Facturacion [%d](bMainReporte)"
                                         ,LOG01,stLineaComando.iCodCiclFact );
        return FALSE;
    }

    /****************************************************************/
    /*  Valida Traza de Proceso                                     */
    /****************************************************************/
   if (stLineaComando.bTrazas){
        if (stLineaComando.iIndFacturacion == iIND_FACT_NOPROCESADO){
            if (!bfnValidaTrazaProc(stLineaComando.iCodCiclFact, iPROC_PREFACT, iIND_FACT_NOPROCESADO))  
                return FALSE;
        } else {
            if (!bfnValidaTrazaProc(stLineaComando.iCodCiclFact, iPROC_POSTFACT, iIND_FACT_ENPROCESO)) 
                return FALSE;
        }
        
        if(!fnOraCommit()) {
            vDTrazasLog  (szExeInfCtlPreCiclo , "ERROR AL HACER EL COMMIT EN VALIDA TRAZA",LOG01, SQLERRM);
            vDTrazasError(szExeInfCtlPreCiclo , "ERROR AL HACER EL COMMIT EN VALIDA TRAZA",LOG01, SQLERRM);
            return (FALSE);
        }
    
        if (stLineaComando.iIndFacturacion == iIND_FACT_NOPROCESADO)
            bfnSelectTrazaProc (stLineaComando.iCodCiclFact, iPROC_PREFACT, &stTrazaProc);
        else
            bfnSelectTrazaProc (stLineaComando.iCodCiclFact, iPROC_POSTFACT, &stTrazaProc);
        bPrintTrazaProc(stTrazaProc);

    }

    /****************************************************************/
    /*  Carga Datos de Ciclo de Facturacion                         */
    /****************************************************************/
    if (!bfnCargaMonedas())
    {
        vDTrazasError(szExeInfCtlPreCiclo,"Error en Carga de Monedas (bMainReporte)",LOG01);
        return FALSE;
    }
    /****************************************************************/
    /*  Carga Planes Tarifarios de Planes Familiares                */
    /****************************************************************/
    if (!bfnCargaCargosBasicos())
    {
        vDTrazasError(szExeInfCtlPreCiclo,"Error en Carga de Cargos Basicos (bMainReporte)",LOG01);
        return FALSE;
    }
    /****************************************************************/
    /*  Carga Documentos a Considerar Como Universo de Datos        */
    /****************************************************************/
    if (!bfnCargaInterfazClientes())
    {
        vDTrazasError(szExeInfCtlPreCiclo,"Error en Carga de Interfaz (bMainReporte)",LOG01);
        return FALSE;
    }
    /****************************************************************/
    /*  Analiza Informacion de Clientes para Documentos Cargados    */
    /****************************************************************/
    if (!bfnStatInterfazPreCiclo())
    {
        vDTrazasError(szExeInfCtlPreCiclo,"Error en Estadisticas de Cartera (bMainReporte)",LOG01);
        return FALSE;
    }
    /****************************************************************/
    /*  Imprime Estadisticas de Cartera de Clientes                 */
    /****************************************************************/
    vPrintStCartera();
    vPrintStCBasicos();
    /****************************************************************/
    /*  Obtiene Numero de Secuencia de Informe                      */
    /****************************************************************/
    if (!bfnGetSecuInfo())
    {
        vDTrazasError(szExeInfCtlPreCiclo,"Error en Obtener Secuencia de Informe (bMainReporte)",LOG01);
        return FALSE;
    }
    /****************************************************************/
    /*  Inserta Resumen de Documentos Facturados                    */
    /****************************************************************/
    if (!bfnInsertHeaderInfCtl())
    {
        vDTrazasError(szExeInfCtlPreCiclo,"Error al Insertar Estadsticas de Clientes (bMainReporte)",LOG01);
        return FALSE;
    }
    /************************************************************************/
    /*  Analiza Cartera de Clientes                                         */
    /************************************************************************/
    if (!bfnInsertStatCartera())
    {
        vDTrazasError(szExeInfCtlPreCiclo,"Error al Insertar Estadsticas de Clientes (bMainReporte)",LOG01);
        return FALSE;
    }
    /************************************************************************/
    /*  Carga de Codigos de Cargo Basico                                    */
    /************************************************************************/
    if (!bCargaCodCBasicos())
    {
        vDTrazasError(szExeInfCtlPreCiclo,"Error al buscar codigos CBasico (bMainReporte)",LOG01);
        return FALSE;
    }
    
    /************************************************************************/
    /*  Analiza Cargos de Abonados                                          */
    /************************************************************************/
    if (!bfnStatCargosAbon())
    {
        vDTrazasError(szExeInfCtlPreCiclo,"Error al Insertar Estadisticas de Cargos (bMainReporte)",LOG01);
        return FALSE;
    }
    vDTrazasLog(szExeInfCtlPreCiclo,"\t%s ** Fin de Procesamiento (bMainReporte)",LOG03, cfnGetTime(1));
    return TRUE;
}



/****************************************************************************/
/*  Funcion :   bfnCargaInterfazClientes                                    */
/****************************************************************************/
BOOL bfnCargaInterfazClientes( void )
{

    /* EXEC SQL BEGIN DECLARE SECTION  ; */ 

        long    ihCodCiclFact       ;
        int     ihCodCiclo          ;
    /* EXEC SQL END DECLARE SECTION    ; */ 

    int     iRowCel,     iRowBeep   ;

    vDTrazasLog(szExeInfCtlPreCiclo,      "\n\t Carga de Tabla de Interfaz FAT_CTLINERTABO ",LOG03);

    /************************************************************************/
    /*   Inicializa Valores de Variables                                    */
    /************************************************************************/
    vDTrazasLog(szExeInfCtlPreCiclo ,"\n\t\t Codigo Ciclo de Facturacion   [%d]"
                                     "\n\t\t Ciclo de Facturacion          [%d]"
                                     "\n\t\t Estado Ciclo de Facturacion   [%d]"
                                    ,LOG03
                                    ,stLineaComando.iCodCiclFact
                                    ,stLineaComando.iCodCiclo
                                    ,stLineaComando.iIndFacturacion );
    ihCodCiclFact   = stLineaComando.iCodCiclFact   ;
    ihCodCiclo      = stLineaComando.iCodCiclo            ;
    /************************************************************************/
    /*   Elimina Registros Antiguos de tabla Interfaz                       */
    /************************************************************************/
    vDTrazasLog(szExeInfCtlPreCiclo ,"\t%s ** Elimina Registros de Interfaz ", LOG03, cfnGetTime(1));
    
    /* EXEC SQL DELETE FAT_CTLINTERABO; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 0;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "delete  from FAT_CTLINTERABO ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
        vDTrazasLog(szExeInfCtlPreCiclo,"\n\n\t**  Error en Delete de Interfaz (bfnCargaInterfazClientes) **"
                                        "\n\t\t Error Oracle [%d] [%s]"
                                       ,LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }
    vDTrazasLog(szExeInfCtlPreCiclo,   "\t\t\t**  Total Registros Eliminados [%ld] **",LOG03,SQLROWS);
    if (!bfnOraCommit())
    {
        vDTrazasError(szExeInfCtlPreCiclo, "\n\n\tError en Commit ", LOG01);
        return FALSE;
    }
     
    /************************************************************************/
    /*   Carga Interfaz con Abonados Celular (Producto 1)                   */
    /************************************************************************/
    vDTrazasLog(szExeInfCtlPreCiclo ,"\t%s ** Carga Interfaz Celular ", LOG03, cfnGetTime(1));
    vDTrazasLog(szExeInfCtlPreCiclo ,"\tCod.Ciclo [%d]\n\tCod.Ciclo Fact [%d]", LOG03,ihCodCiclo,ihCodCiclFact);

     /* EXEC SQL        
        INSERT INTO FAT_CTLINTERABO ( 
                COD_CLIENTE         ,NUM_ABONADO      ,
                COD_PRODUCTO        ,IND_CAMBIO       ,
                COD_CICLFACT        ,FEC_ALTA         ,
                FEC_BAJA            ,IND_ACTUAC       ,
                IND_SUPERTEL        ,IND_FACTUR       ,
                IND_BLOQUEO         ,IND_ESTADO       ,
                COD_EMPRESA         ,COD_PLANTARIF    ,
                COD_CARGOBASICO     ,IND_CUENCONTROLADA)
        SELECT  CIC.COD_CLIENTE     ,CIC.NUM_ABONADO  ,
                CIC.COD_PRODUCTO    ,CIC.IND_CAMBIO   ,
                INT.COD_CICLFACT    ,INT.FEC_ALTA     ,
                INT.FEC_BAJA        ,INT.IND_ACTUAC   ,
                INT.IND_SUPERTEL    ,INT.IND_FACTUR   ,
                NVL(INT.IND_BLOQUEO,0),0              ,
                0                   ,'---'            ,
                '---'               ,NVL(IND_CUENCONTROLADA,0)
        FROM    GA_INFACCEL     INT ,
                FA_CICLOCLI     CIC
        WHERE   CIC.COD_CICLO       = :ihCodCiclo
        AND     CIC.COD_CLIENTE     = INT.COD_CLIENTE
        AND     CIC.NUM_ABONADO     = INT.NUM_ABONADO
        AND     INT.COD_CICLFACT    = :ihCodCiclFact; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 2;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "insert into FAT_CTLINTERABO (COD_CLIENTE,NUM_ABONADO,COD\
_PRODUCTO,IND_CAMBIO,COD_CICLFACT,FEC_ALTA,FEC_BAJA,IND_ACTUAC,IND_SUPERTEL,IN\
D_FACTUR,IND_BLOQUEO,IND_ESTADO,COD_EMPRESA,COD_PLANTARIF,COD_CARGOBASICO,IND_\
CUENCONTROLADA)select CIC.COD_CLIENTE ,CIC.NUM_ABONADO ,CIC.COD_PRODUCTO ,CIC.\
IND_CAMBIO ,INT.COD_CICLFACT ,INT.FEC_ALTA ,INT.FEC_BAJA ,INT.IND_ACTUAC ,INT.\
IND_SUPERTEL ,INT.IND_FACTUR ,NVL(INT.IND_BLOQUEO,0) ,0 ,0 ,'---' ,'---' ,NVL(\
IND_CUENCONTROLADA,0)  from GA_INFACCEL INT ,FA_CICLOCLI CIC where (((CIC.COD_\
CICLO=:b0 and CIC.COD_CLIENTE=INT.COD_CLIENTE) and CIC.NUM_ABONADO=INT.NUM_ABO\
NADO) and INT.COD_CICLFACT=:b1)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )20;
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
     sqlstm.sqhstv[1] = (unsigned char  *)&ihCodCiclFact;
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



    if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
        vDTrazasLog(szExeInfCtlPreCiclo,"\n\n\t**  Error en Carga Interfaz Celular (bfnCargaInterfazClientes) **"
                                        "\n\t\t Error Oracle [%d] [%s]"
                                       ,LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }
    iRowCel =   SQLROWS;
    vDTrazasLog(szExeInfCtlPreCiclo,   "\t\t\t**  Total Registros Celular   [%ld] **",LOG03,iRowCel);
    if (!bfnOraCommit())
    {
        vDTrazasError(szExeInfCtlPreCiclo, "\n\n\tError en Commit ", LOG01);
        return FALSE;
    }
    /************************************************************************/
    /*   Carga Interfaz con Abonados Beeper (Producto 2)                    */
    /************************************************************************/
    vDTrazasLog(szExeInfCtlPreCiclo ,"\t%s ** Carga Interfaz Beeper", LOG03,cfnGetTime(1));
     /* EXEC SQL        
        INSERT INTO FAT_CTLINTERABO ( 
                COD_CLIENTE         ,NUM_ABONADO      ,
                COD_PRODUCTO        ,IND_CAMBIO       ,
                COD_CICLFACT        ,FEC_ALTA         ,
                FEC_BAJA            ,IND_ACTUAC       ,
                IND_SUPERTEL        ,IND_FACTUR       ,
                IND_BLOQUEO         ,IND_ESTADO       ,
                COD_EMPRESA         ,COD_PLANTARIF    ,
                COD_CARGOBASICO     ,IND_CUENCONTROLADA)
        SELECT  CIC.COD_CLIENTE     ,CIC.NUM_ABONADO  ,
                CIC.COD_PRODUCTO    ,CIC.IND_CAMBIO   ,
                :ihCodCiclFact      ,INT.FEC_ALTA     ,
                INT.FEC_BAJA        ,INT.IND_ACTUAC   ,
                0                   ,INT.IND_FACTUR   ,
                NVL(INT.IND_BLOQUEO,0),0              ,
                0                   ,'---'            ,
                '---'               ,NVL(IND_CUENCONTROLADA,0)
        FROM    GA_INFACBEEP    INT ,
                FA_CICLOCLI     CIC
        WHERE   CIC.COD_CICLO       = :ihCodCiclo
        AND     CIC.COD_CLIENTE     = INT.COD_CLIENTE
        AND     CIC.NUM_ABONADO     = INT.NUM_ABONADO
        AND     INT.COD_CICLFACT    = :ihCodCiclFact; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 3;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "insert into FAT_CTLINTERABO (COD_CLIENTE,NUM_ABONADO,COD\
_PRODUCTO,IND_CAMBIO,COD_CICLFACT,FEC_ALTA,FEC_BAJA,IND_ACTUAC,IND_SUPERTEL,IN\
D_FACTUR,IND_BLOQUEO,IND_ESTADO,COD_EMPRESA,COD_PLANTARIF,COD_CARGOBASICO,IND_\
CUENCONTROLADA)select CIC.COD_CLIENTE ,CIC.NUM_ABONADO ,CIC.COD_PRODUCTO ,CIC.\
IND_CAMBIO ,:b0 ,INT.FEC_ALTA ,INT.FEC_BAJA ,INT.IND_ACTUAC ,0 ,INT.IND_FACTUR\
 ,NVL(INT.IND_BLOQUEO,0) ,0 ,0 ,'---' ,'---' ,NVL(IND_CUENCONTROLADA,0)  from \
GA_INFACBEEP INT ,FA_CICLOCLI CIC where (((CIC.COD_CICLO=:b1 and CIC.COD_CLIEN\
TE=INT.COD_CLIENTE) and CIC.NUM_ABONADO=INT.NUM_ABONADO) and INT.COD_CICLFACT=\
:b0)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )43;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&ihCodCiclFact;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)&ihCodCiclo;
     sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)&ihCodCiclFact;
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


    if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
        vDTrazasLog(szExeInfCtlPreCiclo,"\n\n\t**  Error en Carga Interfaz Beeper (bfnCargaInterfazClientes) **"
                                        "\n\t\t Error Oracle [%d] [%s]"
                                        ,LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }
    iRowBeep =   SQLROWS;
    vDTrazasLog(szExeInfCtlPreCiclo,   "\t\t\t**  Total Registros Beeper    [%ld] **",LOG03,iRowBeep);
    if (!bfnOraCommit())
    {
        vDTrazasError(szExeInfCtlPreCiclo, "\n\n\tError en Commit ", LOG01);
        return FALSE;
    }
    /************************************************************************/
    vDTrazasLog(szExeInfCtlPreCiclo,   "\t\t**  Total Registros Cargados [%ld] **",LOG03,iRowCel+iRowBeep);
    return TRUE;                                                                               
}




/****************************************************************************/
/*  Funcion :                                         */
/****************************************************************************/
BOOL bfnStatInterfazPreCiclo( void )
{
    int     iContFetch          = 0;
    int     iContRowsFetch      = 0;
    int     iContRowsFetchAux   = 0;
    int     i                   = 0;
    long    lCodCliente_Ant     = 0;
    char    szTipCliente [2]    ="";
    int     iSqlCodeRet         = 0;

    /* EXEC SQL BEGIN DECLARE SECTION ; */ 

    /* VARCHAR aszhRowId            [MAX_INTERFAZ_CONTROL_FETCH][19]; */ 
struct { unsigned short len; unsigned char arr[22]; } aszhRowId[1000];

    long    alhCodCliente        [MAX_INTERFAZ_CONTROL_FETCH];
    long    alhNumAbonado        [MAX_INTERFAZ_CONTROL_FETCH];
    int     aihCodProducto       [MAX_INTERFAZ_CONTROL_FETCH];
    int     aihIndCambio         [MAX_INTERFAZ_CONTROL_FETCH];
    int     aihCodCiclFact       [MAX_INTERFAZ_CONTROL_FETCH];
    /* VARCHAR aszhFecAlta          [MAX_INTERFAZ_CONTROL_FETCH][15]; */ 
struct { unsigned short len; unsigned char arr[18]; } aszhFecAlta[1000];

    /* VARCHAR aszhFecBaja          [MAX_INTERFAZ_CONTROL_FETCH][15]; */ 
struct { unsigned short len; unsigned char arr[18]; } aszhFecBaja[1000];

    int     aihIndActuac         [MAX_INTERFAZ_CONTROL_FETCH];
    int     aihIndSupertel       [MAX_INTERFAZ_CONTROL_FETCH];
    int     aihIndFactur         [MAX_INTERFAZ_CONTROL_FETCH];
    int     aihIndBloqueo        [MAX_INTERFAZ_CONTROL_FETCH];
    int     aihIndEstado         [MAX_INTERFAZ_CONTROL_FETCH];
    int     aihCtaControlada     [MAX_INTERFAZ_CONTROL_FETCH];
    long    alhCodEmpresa        [MAX_INTERFAZ_CONTROL_FETCH];
    /* VARCHAR aszhCodPlanTarif     [MAX_INTERFAZ_CONTROL_FETCH][4]; */ 
struct { unsigned short len; unsigned char arr[6]; } aszhCodPlanTarif[1000];

    /* VARCHAR aszhCodCargoBasico   [MAX_INTERFAZ_CONTROL_FETCH][4]; */ 
struct { unsigned short len; unsigned char arr[6]; } aszhCodCargoBasico[1000];

    /* EXEC SQL END DECLARE SECTION ; */ 
    

    vDTrazasLog(szExeInfCtlPreCiclo,"\n\t%s Carga de Interfaz de Abonados en en Memoria",LOG03,cfnGetTime(1));

    /************************************************************************/
    /*   Inicializa Valores de Variables                                    */
    /************************************************************************/
    
    /* EXEC SQL DECLARE C_CURSOR_CTLINTERABO CURSOR FOR
        SELECT  ROWID               ,
                COD_CLIENTE         ,
                NUM_ABONADO         ,
                COD_PRODUCTO        ,
                IND_CAMBIO          ,
                COD_CICLFACT        ,
                TO_CHAR(FEC_ALTA    ,'YYYYMMDDHH24MISS') ,
                TO_CHAR(FEC_BAJA    ,'YYYYMMDDHH24MISS') ,
                IND_ACTUAC          ,
                IND_SUPERTEL        ,
                IND_FACTUR          ,
                IND_BLOQUEO         ,
                IND_ESTADO          ,
                IND_CUENCONTROLADA  ,
                COD_EMPRESA         ,
                COD_PLANTARIF       ,
                COD_CARGOBASICO                 
        FROM   FAT_CTLINTERABO; */ 


    /* EXEC SQL OPEN C_CURSOR_CTLINTERABO; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 3;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0004;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )70;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if(SQLCODE != SQLOK)
    {
        vDTrazasLog(szExeInfCtlPreCiclo,   "\n\n\t**  Error en Open Cursor (bfnStatInterfazPreCiclo) **"
                                        "\n\t\t Error Oracle [%d] [%s]"
                                        ,LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }    

    for (;;)
    {
        /* EXEC SQL 
            FETCH C_CURSOR_CTLINTERABO 
            INTO    :aszhRowId         ,
                    :alhCodCliente     ,
                    :alhNumAbonado     ,
                    :aihCodProducto    ,
                    :aihIndCambio      ,
                    :aihCodCiclFact    ,
                    :aszhFecAlta       ,
                    :aszhFecBaja       ,
                    :aihIndActuac      ,
                    :aihIndSupertel    ,
                    :aihIndFactur      ,
                    :aihIndBloqueo     ,
                    :aihIndEstado      ,
                    :aihCtaControlada  ,
                    :alhCodEmpresa     ,
                    :aszhCodPlanTarif  ,
                    :aszhCodCargoBasico; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 17;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1000;
        sqlstm.offset = (unsigned int  )85;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)aszhRowId;
        sqlstm.sqhstl[0] = (unsigned long )21;
        sqlstm.sqhsts[0] = (         int  )24;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqharc[0] = (unsigned long  *)0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)alhCodCliente;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )sizeof(long);
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqharc[1] = (unsigned long  *)0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)alhNumAbonado;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[2] = (         int  )sizeof(long);
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqharc[2] = (unsigned long  *)0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)aihCodProducto;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[3] = (         int  )sizeof(int);
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqharc[3] = (unsigned long  *)0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)aihIndCambio;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[4] = (         int  )sizeof(int);
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqharc[4] = (unsigned long  *)0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)aihCodCiclFact;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[5] = (         int  )sizeof(int);
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqharc[5] = (unsigned long  *)0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)aszhFecAlta;
        sqlstm.sqhstl[6] = (unsigned long )17;
        sqlstm.sqhsts[6] = (         int  )20;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqharc[6] = (unsigned long  *)0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)aszhFecBaja;
        sqlstm.sqhstl[7] = (unsigned long )17;
        sqlstm.sqhsts[7] = (         int  )20;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqharc[7] = (unsigned long  *)0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)aihIndActuac;
        sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[8] = (         int  )sizeof(int);
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqharc[8] = (unsigned long  *)0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)aihIndSupertel;
        sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[9] = (         int  )sizeof(int);
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqharc[9] = (unsigned long  *)0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)aihIndFactur;
        sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[10] = (         int  )sizeof(int);
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqharc[10] = (unsigned long  *)0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
        sqlstm.sqhstv[11] = (unsigned char  *)aihIndBloqueo;
        sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[11] = (         int  )sizeof(int);
        sqlstm.sqindv[11] = (         short *)0;
        sqlstm.sqinds[11] = (         int  )0;
        sqlstm.sqharm[11] = (unsigned long )0;
        sqlstm.sqharc[11] = (unsigned long  *)0;
        sqlstm.sqadto[11] = (unsigned short )0;
        sqlstm.sqtdso[11] = (unsigned short )0;
        sqlstm.sqhstv[12] = (unsigned char  *)aihIndEstado;
        sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[12] = (         int  )sizeof(int);
        sqlstm.sqindv[12] = (         short *)0;
        sqlstm.sqinds[12] = (         int  )0;
        sqlstm.sqharm[12] = (unsigned long )0;
        sqlstm.sqharc[12] = (unsigned long  *)0;
        sqlstm.sqadto[12] = (unsigned short )0;
        sqlstm.sqtdso[12] = (unsigned short )0;
        sqlstm.sqhstv[13] = (unsigned char  *)aihCtaControlada;
        sqlstm.sqhstl[13] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[13] = (         int  )sizeof(int);
        sqlstm.sqindv[13] = (         short *)0;
        sqlstm.sqinds[13] = (         int  )0;
        sqlstm.sqharm[13] = (unsigned long )0;
        sqlstm.sqharc[13] = (unsigned long  *)0;
        sqlstm.sqadto[13] = (unsigned short )0;
        sqlstm.sqtdso[13] = (unsigned short )0;
        sqlstm.sqhstv[14] = (unsigned char  *)alhCodEmpresa;
        sqlstm.sqhstl[14] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[14] = (         int  )sizeof(long);
        sqlstm.sqindv[14] = (         short *)0;
        sqlstm.sqinds[14] = (         int  )0;
        sqlstm.sqharm[14] = (unsigned long )0;
        sqlstm.sqharc[14] = (unsigned long  *)0;
        sqlstm.sqadto[14] = (unsigned short )0;
        sqlstm.sqtdso[14] = (unsigned short )0;
        sqlstm.sqhstv[15] = (unsigned char  *)aszhCodPlanTarif;
        sqlstm.sqhstl[15] = (unsigned long )6;
        sqlstm.sqhsts[15] = (         int  )8;
        sqlstm.sqindv[15] = (         short *)0;
        sqlstm.sqinds[15] = (         int  )0;
        sqlstm.sqharm[15] = (unsigned long )0;
        sqlstm.sqharc[15] = (unsigned long  *)0;
        sqlstm.sqadto[15] = (unsigned short )0;
        sqlstm.sqtdso[15] = (unsigned short )0;
        sqlstm.sqhstv[16] = (unsigned char  *)aszhCodCargoBasico;
        sqlstm.sqhstl[16] = (unsigned long )6;
        sqlstm.sqhsts[16] = (         int  )8;
        sqlstm.sqindv[16] = (         short *)0;
        sqlstm.sqinds[16] = (         int  )0;
        sqlstm.sqharm[16] = (unsigned long )0;
        sqlstm.sqharc[16] = (unsigned long  *)0;
        sqlstm.sqadto[16] = (unsigned short )0;
        sqlstm.sqtdso[16] = (unsigned short )0;
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


        
        iSqlCodeRet = SQLCODE;
        
        if(iSqlCodeRet != SQLOK && iSqlCodeRet != SQLNOTFOUND)
        {
            vDTrazasError(szExeInfCtlPreCiclo,   "\n\n\t**  Error en Fetch de Interfaz de Abonados (bfnStatInterfazPreCiclo) **"
                                            "\n\t\t Error Oracle [%d] [%s]"
                                            ,LOG01,SQLCODE,SQLERRM);
            return FALSE;
        }
        
        /************************************************************************/
        /*  Carga Doucmentos recuperados del Fetch en Arreglo Global en Memoria */
        /************************************************************************/
        /************************************************************************/
        iContFetch++;
        iContRowsFetchAux=SQLROWS-iContRowsFetch;
        iContRowsFetch=SQLROWS;
        if (iContRowsFetchAux <= 0)
        {
            vDTrazasLog(szExeInfCtlPreCiclo,  "\t\t**  No Retorno Filas [%d] [%d] [%d]",LOG03,iContRowsFetchAux ,SQLROWS,SQLCODE);

            /* EXEC SQL CLOSE C_CURSOR_CTLINTERABO; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 17;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )168;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


            break;
        }
        vDTrazasLog(szExeInfCtlPreCiclo,  "\t\t**  Fetch Numero     [%d]"
                                        "\n\t\t Numero Registros      [%d]"
                                        "\n\t\t Registros Acumulados  [%d]"
                                       ,LOG03,iContFetch,iContRowsFetchAux,SQLROWS);
        for (i=0;i<iContRowsFetchAux;i++)              
        {
            memset(&stCtlInterAbo,0,sizeof(INTERFAZABONADOS));
            
            sprintf(stCtlInterAbo.szRowId         ,"%.*s\0",aszhRowId[i].len,aszhRowId[i].arr);
                    stCtlInterAbo.lCodCliente     =         alhCodCliente     [i] ;   
                    stCtlInterAbo.lNumAbonado     =         alhNumAbonado     [i] ;
                    stCtlInterAbo.iCodProducto    =         aihCodProducto    [i] ;
                    stCtlInterAbo.iIndCambio      =         aihIndCambio      [i] ;
                    stCtlInterAbo.iCodCiclFact    =         aihCodCiclFact    [i] ;
            sprintf(stCtlInterAbo.szFecAlta       ,"%.*s\0",aszhFecAlta[i].len,aszhFecAlta[i].arr);
            sprintf(stCtlInterAbo.szFecBaja       ,"%.*s\0",aszhFecBaja[i].len,aszhFecBaja[i].arr);
                    stCtlInterAbo.iIndActuac      =         aihIndActuac      [i] ;
                    stCtlInterAbo.iIndSupertel    =         aihIndSupertel    [i] ;
                    stCtlInterAbo.iIndFactur      =         aihIndFactur      [i] ;
                    stCtlInterAbo.iIndBloqueo     =         aihIndBloqueo     [i] ;
                    stCtlInterAbo.iIndEstado      =         aihIndEstado      [i] ;
                    stCtlInterAbo.iCtaControlada  =         aihCtaControlada  [i] ;
                    stCtlInterAbo.lCodEmpresa     =         alhCodEmpresa     [i] ;
            sprintf(stCtlInterAbo.szCodPlanTarif  ,"%.*s\0",aszhCodPlanTarif  [i].len,aszhCodPlanTarif  [i].arr);
            sprintf(stCtlInterAbo.szCodCargoBasico,"%.*s\0",aszhCodCargoBasico[i].len,aszhCodCargoBasico[i].arr);

            
            /************************************************************************/
            /************************************************************************/
            /*   Valida Tipo de Cliente : Individual/Empresa/Familiar               */
            /************************************************************************/
            /************************************************************************/
            if (stCtlInterAbo.lCodCliente != lCodCliente_Ant )
            {
                if (!bfnValTipClie())
                {
                    vDTrazasError(szExeInfCtlPreCiclo,  "\n\n\t**  Error en Validar Tipo de Cliente () **",LOG01);
                    return FALSE;
                }
                sprintf(szTipCliente,"%s\0",stCtlInterAbo.szTipClie);
            }
            else
            {
                sprintf(stCtlInterAbo.szTipClie,"%s\0",szTipCliente);
            }
            /************************************************************************/
            /************************************************************************/
            /*  Analiza Estadisticas de Condicion de Abonados                       */
            /************************************************************************/
            /************************************************************************/
            if (!bfnStatInterAbo())
            {
                vDTrazasError(szExeInfCtlPreCiclo,"\n\t**  Error en bfnStatInterAbo **",LOG01);
                return FALSE;
            }
            /************************************************************************/
            /*   Acumula Estadisticas de Cargos Basicos                             */
            /************************************************************************/
            if (!bfnCargaStatCargosBasicos())
            {
                vDTrazasError(szExeInfCtlPreCiclo,  "\n\n\t**  Error en Actualizar Interfaz Abonado (bfnStatInterAbo) **",LOG01);
                return FALSE;
            }
            /************************************************************************/
            lCodCliente_Ant = stCtlInterAbo.lCodCliente;
        }
        if (iSqlCodeRet == SQLNOTFOUND)
        {
            vDTrazasLog(szExeInfCtlPreCiclo,  "\t\t**  No Encontro Filas [%d] [%d] [%d]",LOG03,iContRowsFetchAux ,SQLROWS,SQLCODE);
            /* EXEC SQL CLOSE C_CURSOR_CTLINTERABO; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 17;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )183;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


            break;
        }
        if (!bfnOraCommit())
        {
           vDTrazasError(szExeInfCtlPreCiclo, "\n\n\tError en Commit ", LOG01);
           return FALSE;
        }

    } /*  for (;;)  */
    if (!bfnOraCommit())
    {
        vDTrazasError(szExeInfCtlPreCiclo, "\n\n\tError en Commit ", LOG01);
        return FALSE;
    }
    vDTrazasLog(szExeInfCtlPreCiclo,   "\t**  Abonados Analizados [%ld] **",LOG03,iContRowsFetch);
    return TRUE;                                                                               
}




/****************************************************************************/
/*  Funcion :   bfnStatInterAbo                                             */
/****************************************************************************/
BOOL bfnStatInterAbo( void )
{
    int     iStat               = 0;

    vDTrazasLog(szExeInfCtlPreCiclo, "\n\t Analiza Estadisticas de Abonados Clientes ",LOG06);

    /************************************************************************/
    /*   Valida Plan Tarifario y Cargo Basico Abonado                       */
    /************************************************************************/
    if (!bfnValPlanTarif())
    {
        vDTrazasError(szExeInfCtlPreCiclo,  "\n\n\t**  Error en Validar Plan Tarifario (bfnStatInterAbo) **",LOG01);
        return FALSE;
    }
    /************************************************************************/
    /*   Clasifica Condicion del Cliente                                    */
    /************************************************************************/
    if (!bfnClassCliente())
    {
        vDTrazasError(szExeInfCtlPreCiclo,  "\n\n\t**  Error en Clasificar Cliente (bfnStatInterAbo) **",LOG01);
        return FALSE;
    }
    /************************************************************************/
    /*   Clasifica Condicion del Abonado                                    */
    /************************************************************************/
    if (!bfnClassAbonado())
    {
        vDTrazasError(szExeInfCtlPreCiclo,  "\n\n\t**  Error en Clasificar Abonado (bfnStatInterAbo) **",LOG01);
        return FALSE;
    }
    vPrintStAbonados();
    /************************************************************************/
    /*   Actualiza Estado de Abonados de Interfaz Pre-Ciclo                 */
    /************************************************************************/
    if (!bfnUpdateInterAbo())
    {
        vDTrazasError(szExeInfCtlPreCiclo,  "\n\n\t**  Error en Actualizar Interfaz Abonado (bfnStatInterAbo) **",LOG01);
        return FALSE;
    }
    /********************************************************************/
    /*  Valida si existe Combinacion de Analisis de Cartera             */
    /********************************************************************/
    for (iStat=0;iStat<stStatInterAbon.iNumStadisticas;iStat++)
    {
        if ((stStatInterAbon.stUnivStatInterAbo[iStat].iCodProducto     == stCtlInterAbo.iCodProducto      ) &&
            (stStatInterAbon.stUnivStatInterAbo[iStat].iCodCiclFact     == stCtlInterAbo.iCodCiclFact      ) &&
            (stStatInterAbon.stUnivStatInterAbo[iStat].iCodClassCliente == stCtlInterAbo.iCodClassCliente  ) &&
            (stStatInterAbon.stUnivStatInterAbo[iStat].iCodClassAbonado == stCtlInterAbo.iCodClassAbonado  )  )

        {
        /********************************************************************/
        /*  Actualiza Combinacion de Estadistica                            */
        /********************************************************************/
            vDTrazasLog(szExeInfCtlPreCiclo   ,"\t\t**(bfnStatInterAbo) Actualiza Estadistica [%d]"
                                            ,LOG06,iStat);
            stStatInterAbon.stUnivStatInterAbo[iStat].iNumAbonados++;
            break;
        }
        vDTrazasLog(szExeInfCtlPreCiclo   ,"\t\t**(bfnStatInterAbo) Incrementa iStat [%d]",LOG06,iStat);
    }
    
    /********************************************************************/
    /*  Agrega Nueva Combinacion de Estadistica                         */
    /********************************************************************/
    if (iStat == stStatInterAbon.iNumStadisticas || stStatInterAbon.iNumStadisticas == 0)
    {
        vDTrazasLog(szExeInfCtlPreCiclo   ,"\t\t**(bfnStatInterAbo) Agrega Nuevo Estadistica [%d] iStat[%d]"
                                        ,LOG06,stStatInterAbon.iNumStadisticas,iStat);
                                        
        stStatInterAbon.stUnivStatInterAbo[iStat].iCodProducto     = stCtlInterAbo.iCodProducto      ;
        stStatInterAbon.stUnivStatInterAbo[iStat].iCodCiclFact     = stCtlInterAbo.iCodCiclFact      ;
        stStatInterAbon.stUnivStatInterAbo[iStat].iCodClassCliente = stCtlInterAbo.iCodClassCliente  ;
        stStatInterAbon.stUnivStatInterAbo[iStat].iCodClassAbonado = stCtlInterAbo.iCodClassAbonado  ;
        stStatInterAbon.stUnivStatInterAbo[iStat].iNumAbonados++;
        stStatInterAbon.iNumStadisticas++;
    }
    return (TRUE);
}





/****************************************************************************/
/*  Funcion :    bfnCargaStatCargosBasicos                                      */
/****************************************************************************/
BOOL bfnCargaStatCargosBasicos( void )
{
    int iStat=0;
    /********************************************************************/
    /*  Valida si existe Combinacion de Estadistica generada            */
    /********************************************************************/
    for (iStat=0;iStat<stStatCargoBasico.iNumStadisticas;iStat++)
    {
        if ((stCtlInterAbo.iIndEstado       == IND_ESTADO_FACTURACION_ABONADO_SI )  &&
            (stCtlInterAbo.iCodProducto     == 
                    stStatCargoBasico.stUnivStatCBas[iStat].iCodProducto    )       &&
            (strcmp(stCtlInterAbo.szCodCargoBasico,
                    stStatCargoBasico.stUnivStatCBas[iStat].szCodCargoBasico)==0    ))
        {
        /********************************************************************/
        /*  Actualiza Combinacion de Estadistica                            */
        /********************************************************************/
            if (strcmp(stCtlInterAbo.szTipClie,COD_TIPCLIENTE_INDIVIDUAL)==0)
            {
                stStatCargoBasico.stUnivStatCBas[iStat].iNumCargosBasicos++;
            }
            else /*  Es Empresa o Familiar Solo 1 Cargo BasicoAboando 0  */
            {
                if (stCtlInterAbo.lNumAbonado == 0)
                    stStatCargoBasico.stUnivStatCBas[iStat].iNumCargosBasicos++;
            }
            stStatCargoBasico.stUnivStatCBas[iStat].iNumAbonados++;
            break;
        }
    }
    /********************************************************************/
    /*  Agrega Nueva Combinacion de Estadistica                         */
    /********************************************************************/
    if (iStat == stStatCargoBasico.iNumStadisticas || stStatCargoBasico.iNumStadisticas == 0)
    {
        if (stCtlInterAbo.iIndEstado       == IND_ESTADO_FACTURACION_ABONADO_SI )
        {
            if (strcmp(stCtlInterAbo.szTipClie,COD_TIPCLIENTE_INDIVIDUAL)==0)
            {
                stStatCargoBasico.stUnivStatCBas[iStat].iNumCargosBasicos++;
            }
            else /*  Es Empresa o Familiar Solo 1 Cargo BasicoAboando 0  */
            {
                if (stCtlInterAbo.lNumAbonado == 0)
                    stStatCargoBasico.stUnivStatCBas[iStat].iNumCargosBasicos++;
            }
                
                    stStatCargoBasico.stUnivStatCBas[iStat].iCodProducto      =     stCtlInterAbo.iCodProducto     ;
            sprintf(stStatCargoBasico.stUnivStatCBas[iStat].szCodCargoBasico,"%s\0",stCtlInterAbo.szCodCargoBasico);
                    stStatCargoBasico.stUnivStatCBas[iStat].iNumAbonados++;
            stStatCargoBasico.iNumStadisticas++;
        }
    }
    return (TRUE);
}




/****************************************************************************/
/*  Funcion :   bfnStatCargosAbon                                           */
/****************************************************************************/
BOOL bfnStatCargosAbon( void )
{
    vDTrazasLog(szExeInfCtlPreCiclo, "\n\t%s  ** Analiza Estadisticas de Cargos de Clientes ",LOG03,cfnGetTime(1));

    /************************************************************************/
    /*   Analiza Estadisticas de Cargos Basicos                             */
    /************************************************************************/
    if (!bfnStatCargosBasicos())
    {
        vDTrazasError(szExeInfCtlPreCiclo,  "\n\n\t**  Error en Analisis de Cargos Varios (bfnStatCargosAbon) **",LOG01);
        return FALSE;
    }
    /************************************************************************/
    /*   Analiza Estadisticas de Cargos Varios                              */
    /************************************************************************/
    if (!bfnStatCargosVarios())
    {
        vDTrazasError(szExeInfCtlPreCiclo,  "\n\n\t**  Error en Analisis de Cargos Varios (bfnStatCargosAbon) **",LOG01);
        return FALSE;
    }
    /************************************************************************/
    /*   Analiza Estadisticas de Cargos de Trafico                          */
    /************************************************************************/
    if (!bfnStatCargosTrafico())
    {
        vDTrazasError(szExeInfCtlPreCiclo,  "\n\n\t**  Error en Analisis de Cargos de Trafico (bfnStatCargosAbon) **",LOG01);
        return FALSE;
    }
    /************************************************************************/
    /*   Analiza Estadisticas de Cargos Servicios Suplementarios            */
    /************************************************************************/
    if (!bfnStatCargosServSupl())
    {
        vDTrazasError(szExeInfCtlPreCiclo,  "\n\n\t**  Error en Analisis de Cargos Servicios Suplementarios (bfnStatCargosAbon) **",LOG01);
        return FALSE;
    }
    return TRUE;
}



/****************************************************************************/
/*  Funcion :   bfnInsertStatCartera                                        */
/****************************************************************************/

BOOL bfnInsertStatCartera( void )
{
    int iStat=0;
    
    /* EXEC SQL BEGIN DECLARE SECTION ; */ 

    char    szhCodInforme   [7] ;/* EXEC SQL VAR szhCodInforme  IS STRING(7); */ 

    long    lhNumSecuInfo       ;
    int     ihCodProducto       ;
    int     iCodCiclFact        ;
    int     iCodClassCliente    ;
    int     iCodClassAbonado    ;
    long    ihNumAbonados       ;
    /* EXEC SQL END DECLARE SECTION ; */ 
    

    sprintf(szhCodInforme,"%s\0",szCodInformeGenerar);
    lhNumSecuInfo = lhNumSecuenciaInforme;
    
    vDTrazasLog(szExeInfCtlPreCiclo   ,"\n\t%s **(bfnInsertStatCartera) [%d]",LOG03,cfnGetTime(1),stStatInterAbon.iNumStadisticas);
    
    for (iStat=0;iStat<stStatInterAbon.iNumStadisticas;iStat++)
    {
        ihCodProducto    = stStatInterAbon.stUnivStatInterAbo[iStat].iCodProducto       ;
        iCodCiclFact     = stStatInterAbon.stUnivStatInterAbo[iStat].iCodCiclFact       ;
        iCodClassCliente = stStatInterAbon.stUnivStatInterAbo[iStat].iCodClassCliente   ;
        iCodClassAbonado = stStatInterAbon.stUnivStatInterAbo[iStat].iCodClassAbonado   ;
        ihNumAbonados    = stStatInterAbon.stUnivStatInterAbo[iStat].iNumAbonados       ;
    
        /* EXEC SQL INSERT INTO FAD_CTLINFCARTERA (
                COD_INFORME         ,
                NUM_SECUINFO        , 
                COD_PRODUCTO        ,
                COD_CICLFACT        ,
                COD_CLASSCLIENTE    ,
                COD_CLASSABONADO    ,
                NUM_ABONADOS        )               
        VALUES (:szhCodInforme      ,
                :lhNumSecuInfo      ,
                :ihCodProducto      ,
                :iCodCiclFact       ,
                :iCodClassCliente   ,
                :iCodClassAbonado   ,
                :ihNumAbonados      ); */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 17;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "insert into FAD_CTLINFCARTERA (COD_INFORME,NUM_SECUIN\
FO,COD_PRODUCTO,COD_CICLFACT,COD_CLASSCLIENTE,COD_CLASSABONADO,NUM_ABONADOS) v\
alues (:b0,:b1,:b2,:b3,:b4,:b5,:b6)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )198;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhCodInforme;
        sqlstm.sqhstl[0] = (unsigned long )7;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSecuInfo;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&ihCodProducto;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&iCodCiclFact;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&iCodClassCliente;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&iCodClassAbonado;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)&ihNumAbonados;
        sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
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



        if (SQLCODE)
        {
            vDTrazasLog(szExeInfCtlPreCiclo   ,"\t\t**(bfnInsertStatCartera) Error En Insert de Estadisticas "
                                             "\n\t\t Error Oracle [%d] [%s]"
                                            ,LOG01,SQLCODE,SQLERRM);
            return FALSE;
        }
    }
    return TRUE;
}




/****************************************************************************/
/*  Funcion :   bfnUpdateInterAbo                                           */
/****************************************************************************/
BOOL bfnUpdateInterAbo( void )
{
    /* EXEC SQL BEGIN DECLARE SECTION ; */ 

    static  char    szhRowId        [19];/* EXEC SQL VAR szhRowId          IS STRING(19); */ 

    static  int     ihIndEstado         ;
    static  char    szhCodPlanTarif  [4];/* EXEC SQL VAR szhCodPlanTarif   IS STRING (4); */ 

    static  char    szhCodCargoBasico[4];/* EXEC SQL VAR szhCodCargoBasico IS STRING (4); */ 

    static  int     ihCodClassCliente;
    static  int     ihCodClassAbonado;
    /* EXEC SQL END DECLARE SECTION ; */ 
    

    ihIndEstado               =       stCtlInterAbo.iIndEstado       ;
    sprintf(szhCodPlanTarif   ,"%s\0",stCtlInterAbo.szCodPlanTarif  );
    sprintf(szhCodCargoBasico ,"%s\0",stCtlInterAbo.szCodCargoBasico);
    sprintf(szhRowId          ,"%s\0",stCtlInterAbo.szRowId);
    ihCodClassCliente = stCtlInterAbo.iCodClassCliente;
    ihCodClassAbonado = stCtlInterAbo.iCodClassAbonado;

    if (strlen(szhCodPlanTarif) == 0)
        sprintf(szhCodPlanTarif,"---\0");

    if (strlen(szhCodCargoBasico) == 0)
        sprintf(szhCodCargoBasico ,"---\0");

    vDTrazasLog(szExeInfCtlPreCiclo,"\t\t**(bfnUpdateInterAbo) Valores de Datos "
                                    "\n\t\t ihIndEstado       [%d]"
                                    "\n\t\t szhCodPlanTarif   [%s]"
                                    "\n\t\t szhCodCargoBasico [%s]"
                                    "\n\t\t szhRowId;         [%s]"
                                    ,LOG05
                                    ,ihIndEstado       
                                    ,szhCodPlanTarif   
                                    ,szhCodCargoBasico 
                                    ,szhRowId          );

/* AEO 22/SEP/2000 */
    /* EXEC SQL
        UPDATE  FAT_CTLINTERABO
        SET     IND_ESTADO      = :ihIndEstado       ,
                COD_PLANTARIF   = :szhCodPlanTarif   ,
                COD_CARGOBASICO = :szhCodCargoBasico ,
                COD_CLASSCLIE   = :ihCodClassCliente ,
                COD_CLASSABON   = :ihCodClassAbonado
        WHERE   ROWID           = :szhRowId          ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update FAT_CTLINTERABO  set IND_ESTADO=:b0,COD_PLANTARIF=\
:b1,COD_CARGOBASICO=:b2,COD_CLASSCLIE=:b3,COD_CLASSABON=:b4 where ROWID=:b5";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )241;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihIndEstado;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodPlanTarif;
    sqlstm.sqhstl[1] = (unsigned long )4;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodCargoBasico;
    sqlstm.sqhstl[2] = (unsigned long )4;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihCodClassCliente;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&ihCodClassAbonado;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhRowId;
    sqlstm.sqhstl[5] = (unsigned long )19;
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




    if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND) 
    {            
        vDTrazasLog(szExeInfCtlPreCiclo   ,"\t\t**(bfnUpdateInterAbo) Error En Update de Interfaz de Abonados "
                                         "\n\t\t Error Oracle [%d] [%s]"
                                        ,LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szExeInfCtlPreCiclo   ,"\t\t**(bfnUpdateInterAbo) Error En Update de Interfaz de Abonados "
                                         "\n\t\t Error Oracle [%d] [%s]"
                                        ,LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }
    return TRUE;
}




/****************************************************************************/
/*  Funcion :   bfnStatCargosVarios                                         */
/****************************************************************************/
BOOL bfnStatCargosVarios( void )
{
    /* EXEC SQL BEGIN DECLARE SECTION  ; */ 

    char    szhCodInforme   [7] ;/* EXEC SQL VAR szhCodInforme  IS STRING(7); */ 

    long    lhNumSecuInfo       ;    
    int     ihIndFactur         ;
    int     ihIndSupertel       ;
    char    szhCodTipClie   [3] ;/* EXEC SQL VAR szhCodTipClie  IS STRING(3); */ 

    long    lhCodTipDocum       ;
    char    szhCodDespacho  [6] ;/* EXEC SQL VAR szhCodDespacho  IS STRING(6); */ 

    char    szhFecEmision[15]   ;/* EXEC SQL VAR szhFecEmision     IS STRING (15); */ 


    int     aihCodProducto  [MAX_CARGOS_VARIOS_FETCH];
    long    aihCodCiclFact  [MAX_CARGOS_VARIOS_FETCH];
    long    aihCodConcepto  [MAX_CARGOS_VARIOS_FETCH];
    int     aihCantidad     [MAX_CARGOS_VARIOS_FETCH];
    double  adhImpFacturable[MAX_CARGOS_VARIOS_FETCH];
    int     ihValorCero ;
    /* EXEC SQL END DECLARE SECTION ; */ 
    
    int     iSqlRow         = 0;
    int     iNumCargoVarios = 0;

    vDTrazasLog(szExeInfCtlPreCiclo   ,"\n\t%s  **(bfnStatCargosVarios) ", LOG03,cfnGetTime(1));

    sprintf(szhCodInforme,"%s\0", szCodInformeGenerar          );
            lhNumSecuInfo       = lhNumSecuenciaInforme         ;
    sprintf(szhFecEmision,"%s\0", stLineaComando.szFecEmision  );            
            ihIndFactur         =   1                           ;
            ihIndSupertel       =   0                           ;
    sprintf(szhCodTipClie,"I\0"                               );
            lhCodTipDocum       =   0                           ;
    sprintf(szhCodDespacho,"-----\0")                           ;

    ihValorCero = 0;

    /* EXEC SQL DECLARE C_CURSOR_CTLCARGOS_VARIOS CURSOR FOR
        SELECT      COD_PRODUCTO    ,
                    COD_CICLFACT    ,
                    COD_CONCEPTO    ,
                    CANT            ,
                    IMP_CARGO
        FROM   (    SELECT  /o+  INDEX (B ak_ge_cargos_codcliente ) o/
                            B.COD_CONCEPTO      COD_CONCEPTO,
                            B.COD_CICLFACT      COD_CICLFACT,
                            B.COD_PRODUCTO      COD_PRODUCTO,
                            SUM(B.IMP_CARGO*C.CAMBIO)    IMP_CARGO   ,
                            COUNT(1)            CANT
                    FROM    GE_CARGOS       B, GE_CONVERSION C
                    WHERE   TO_DATE (:szhFecEmision,'YYYYMMDDHH24MISS') BETWEEN C.FEC_DESDE AND C.FEC_HASTA
                    AND     C.COD_MONEDA  = B.COD_MONEDA
                    AND     B.COD_CLIENTE > :ihValorCero
                    AND     B.IMP_CARGO   > :ihValorCero
                    AND     B.NUM_FACTURA = :ihValorCero
                    AND     B.NUM_TRANSACCION = :ihValorCero
                    AND     B.COD_CICLFACT IN ( SELECT  COD_CICLFACT    
                                                FROM    FA_CICLFACT
                                                WHERE   FEC_EMISION <= TO_DATE (:szhFecEmision,'YYYYMMDDHH24MISS'))
                    AND EXISTS (SELECT COD_CLIENTE FROM FAT_CTLINTERABO A WHERE A.COD_CLIENTE = B.COD_CLIENTE AND IND_ESTADO  = 1 )
                    GROUP BY B.COD_CONCEPTO, B.COD_CICLFACT, B.COD_PRODUCTO
                UNION ALL
                    SELECT  /o+  INDEX (B ak_ge_cargos_codcliente ) o/
                            B.COD_CONCEPTO_DTO                  COD_CONCEPTO,
                            B.COD_CICLFACT                      COD_CICLFACT, 
                            B.COD_PRODUCTO                      COD_PRODUCTO,
                            SUM(DECODE(TIP_DTO,:ihValorCero,(VAL_DTO*C.CAMBIO),(IMP_CARGO*VAL_DTO/100*-1)*C.CAMBIO)) IMP_CARGO,
                            COUNT(1)                            CANT
                    FROM    GE_CARGOS       B, GE_CONVERSION C
                    WHERE   TO_DATE (:szhFecEmision,'YYYYMMDDHH24MISS') BETWEEN C.FEC_DESDE AND C.FEC_HASTA
                    AND     C.COD_MONEDA  = B.COD_MONEDA
                    AND     B.COD_CLIENTE > :ihValorCero
                    AND     B.COD_CONCEPTO_DTO  IS NOT NULL
                    AND     B.IMP_CARGO   > :ihValorCero
                    AND     B.NUM_FACTURA = :ihValorCero
                    AND     B.NUM_TRANSACCION = :ihValorCero
                    AND     B.COD_CICLFACT IN ( SELECT  COD_CICLFACT 
                                                FROM    FA_CICLFACT
                                                WHERE   FEC_EMISION <= TO_DATE (:szhFecEmision,'YYYYMMDDHH24MISS'))
                    AND EXISTS (SELECT COD_CLIENTE FROM FAT_CTLINTERABO A WHERE A.COD_CLIENTE = B.COD_CLIENTE AND A.IND_ESTADO = 1)
                    GROUP BY B.COD_CONCEPTO_DTO,B.COD_CICLFACT,B.COD_PRODUCTO); */ 

    
    /* EXEC SQL OPEN C_CURSOR_CTLCARGOS_VARIOS; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlbuft((void **)0, 
      "select COD_PRODUCTO ,COD_CICLFACT ,COD_CONCEPTO ,CANT ,IMP_CARGO  fro\
m (select  /*+   INDEX (B ak_ge_cargos_codcliente )  +*/ B.COD_CONCEPTO COD_\
CONCEPTO ,B.COD_CICLFACT COD_CICLFACT ,B.COD_PRODUCTO COD_PRODUCTO ,sum((B.I\
MP_CARGO* C.CAMBIO)) IMP_CARGO ,count(1) CANT  from GE_CARGOS B ,GE_CONVERSI\
ON C where (((((((TO_DATE(:b0,'YYYYMMDDHH24MISS') between C.FEC_DESDE and C.\
FEC_HASTA and C.COD_MONEDA=B.COD_MONEDA) and B.COD_CLIENTE>:b1) and B.IMP_CA\
RGO>:b1) and B.NUM_FACTURA=:b1) and B.NUM_TRANSACCION=:b1) and B.COD_CICLFAC\
T in (select COD_CICLFACT  from FA_CICLFACT where FEC_EMISION<=TO_DATE(:b0,'\
YYYYMMDDHH24MISS'))) and exists (select COD_CLIENTE  from FAT_CTLINTERABO A \
where (A.COD_CLIENTE=B.COD_CLIENTE and IND_ESTADO=1))) group by B.COD_CONCEP\
TO,B.COD_CICLFACT,B.COD_PRODUCTO union all select  /*+   INDEX (B ak_ge_carg\
os_codcliente )  +*/ B.COD_CONCEPTO_DTO COD_CONCEPTO ,B.COD_CICLFACT COD_CIC\
LFACT ,B.COD_PRODUCTO COD_PRODUCTO ,sum(DECODE(TIP_DTO,:b1,(VAL_DTO* C.CAMBI\
O),((((IMP_CARGO* VAL_DTO)/100)* (-1))* C.C");
    sqlstm.stmt = sq0007;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )280;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhFecEmision;
    sqlstm.sqhstl[0] = (unsigned long )15;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihValorCero;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihValorCero;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihValorCero;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&ihValorCero;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhFecEmision;
    sqlstm.sqhstl[5] = (unsigned long )15;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&ihValorCero;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)szhFecEmision;
    sqlstm.sqhstl[7] = (unsigned long )15;
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)&ihValorCero;
    sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)&ihValorCero;
    sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)&ihValorCero;
    sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)&ihValorCero;
    sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[11] = (         int  )0;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)szhFecEmision;
    sqlstm.sqhstl[12] = (unsigned long )15;
    sqlstm.sqhsts[12] = (         int  )0;
    sqlstm.sqindv[12] = (         short *)0;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
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


    if(SQLCODE != SQLOK)
    {
        vDTrazasLog(szExeInfCtlPreCiclo,   "\n\n\t**  Error en Open Cursor (bfnStatCargosVarios) **"
                                        "\n\t\t Error Oracle [%d] [%s]"
                                        ,LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }    
    
    /* EXEC SQL 
        FETCH C_CURSOR_CTLCARGOS_VARIOS
        INTO        :aihCodProducto  ,
                    :aihCodCiclFact  ,
                    :aihCodConcepto  ,
                    :aihCantidad     ,
                    :adhImpFacturable; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1000;
    sqlstm.offset = (unsigned int  )347;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)aihCodProducto;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )sizeof(int);
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)aihCodCiclFact;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )sizeof(long);
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)aihCodConcepto;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )sizeof(long);
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)aihCantidad;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )sizeof(int);
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqharc[3] = (unsigned long  *)0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)adhImpFacturable;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[4] = (         int  )sizeof(double);
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqharc[4] = (unsigned long  *)0;
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



    if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND) 
    {            
        vDTrazasLog(szExeInfCtlPreCiclo   , "\t\t**(bfnStatCargosVarios) Error En Fetch de Cargos Varios  "
                                            "\n\t\t Error Oracle [%d] [%s]"
                                            ,LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szExeInfCtlPreCiclo , "\t\t**(bfnStatCargosVarios) Error En Fetch de Cargos Varios "
                                            "\n\t\t Error Oracle [%d] [%s]"
                                            ,LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }
    iSqlRow = SQLROWS;
    if(SQLCODE == SQLNOTFOUND)
    {
        for (iNumCargoVarios = 0; iNumCargoVarios < iSqlRow ; iNumCargoVarios++)
        {
            /************************************************************************/
            /*  Inserta Registros de Cargos Varios en FAD_CTLINFCONC                */
            /************************************************************************/
                /* EXEC SQL 
                    INSERT INTO FAD_CTLINFCONC(
                                COD_INFORME     ,
                                NUM_SECUINFO    ,
                                IND_FACTUR      ,
                                IND_SUPERTEL    ,
                                COD_TIPCLIE     ,
                                COD_TIPDOCUM    ,
                                COD_DESPACHO    ,
                                COD_PRODUCTO    ,
                                COD_CICLFACT    ,
                                COD_CONCEPTO    ,
                                NUM_CONCEPTOS   ,
                                IMP_FACTURABLE  ,
                                NUM_MINUTOS     )
                    VALUES  (   :szhCodInforme  ,
                                :lhNumSecuInfo  ,
                                :ihIndFactur    ,
                                :ihIndSupertel  , 
                                :szhCodTipClie  ,
                                :lhCodTipDocum  ,
                                :szhCodDespacho ,
                                :aihCodProducto     [iNumCargoVarios],
                                :aihCodCiclFact     [iNumCargoVarios],
                                :aihCodConcepto     [iNumCargoVarios],
                                :aihCantidad        [iNumCargoVarios],
                                :adhImpFacturable   [iNumCargoVarios],
                                :ihValorCero ); */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 17;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "insert into FAD_CTLINFCONC (COD_INFORME,NUM_S\
ECUINFO,IND_FACTUR,IND_SUPERTEL,COD_TIPCLIE,COD_TIPDOCUM,COD_DESPACHO,COD_PROD\
UCTO,COD_CICLFACT,COD_CONCEPTO,NUM_CONCEPTOS,IMP_FACTURABLE,NUM_MINUTOS) value\
s (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8,:b9,:b10,:b11,:b12)";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )382;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)szhCodInforme;
                sqlstm.sqhstl[0] = (unsigned long )7;
                sqlstm.sqhsts[0] = (         int  )0;
                sqlstm.sqindv[0] = (         short *)0;
                sqlstm.sqinds[0] = (         int  )0;
                sqlstm.sqharm[0] = (unsigned long )0;
                sqlstm.sqadto[0] = (unsigned short )0;
                sqlstm.sqtdso[0] = (unsigned short )0;
                sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSecuInfo;
                sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[1] = (         int  )0;
                sqlstm.sqindv[1] = (         short *)0;
                sqlstm.sqinds[1] = (         int  )0;
                sqlstm.sqharm[1] = (unsigned long )0;
                sqlstm.sqadto[1] = (unsigned short )0;
                sqlstm.sqtdso[1] = (unsigned short )0;
                sqlstm.sqhstv[2] = (unsigned char  *)&ihIndFactur;
                sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[2] = (         int  )0;
                sqlstm.sqindv[2] = (         short *)0;
                sqlstm.sqinds[2] = (         int  )0;
                sqlstm.sqharm[2] = (unsigned long )0;
                sqlstm.sqadto[2] = (unsigned short )0;
                sqlstm.sqtdso[2] = (unsigned short )0;
                sqlstm.sqhstv[3] = (unsigned char  *)&ihIndSupertel;
                sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[3] = (         int  )0;
                sqlstm.sqindv[3] = (         short *)0;
                sqlstm.sqinds[3] = (         int  )0;
                sqlstm.sqharm[3] = (unsigned long )0;
                sqlstm.sqadto[3] = (unsigned short )0;
                sqlstm.sqtdso[3] = (unsigned short )0;
                sqlstm.sqhstv[4] = (unsigned char  *)szhCodTipClie;
                sqlstm.sqhstl[4] = (unsigned long )3;
                sqlstm.sqhsts[4] = (         int  )0;
                sqlstm.sqindv[4] = (         short *)0;
                sqlstm.sqinds[4] = (         int  )0;
                sqlstm.sqharm[4] = (unsigned long )0;
                sqlstm.sqadto[4] = (unsigned short )0;
                sqlstm.sqtdso[4] = (unsigned short )0;
                sqlstm.sqhstv[5] = (unsigned char  *)&lhCodTipDocum;
                sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[5] = (         int  )0;
                sqlstm.sqindv[5] = (         short *)0;
                sqlstm.sqinds[5] = (         int  )0;
                sqlstm.sqharm[5] = (unsigned long )0;
                sqlstm.sqadto[5] = (unsigned short )0;
                sqlstm.sqtdso[5] = (unsigned short )0;
                sqlstm.sqhstv[6] = (unsigned char  *)szhCodDespacho;
                sqlstm.sqhstl[6] = (unsigned long )6;
                sqlstm.sqhsts[6] = (         int  )0;
                sqlstm.sqindv[6] = (         short *)0;
                sqlstm.sqinds[6] = (         int  )0;
                sqlstm.sqharm[6] = (unsigned long )0;
                sqlstm.sqadto[6] = (unsigned short )0;
                sqlstm.sqtdso[6] = (unsigned short )0;
                sqlstm.sqhstv[7] = (unsigned char  *)&aihCodProducto[iNumCargoVarios];
                sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[7] = (         int  )0;
                sqlstm.sqindv[7] = (         short *)0;
                sqlstm.sqinds[7] = (         int  )0;
                sqlstm.sqharm[7] = (unsigned long )0;
                sqlstm.sqadto[7] = (unsigned short )0;
                sqlstm.sqtdso[7] = (unsigned short )0;
                sqlstm.sqhstv[8] = (unsigned char  *)&aihCodCiclFact[iNumCargoVarios];
                sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[8] = (         int  )0;
                sqlstm.sqindv[8] = (         short *)0;
                sqlstm.sqinds[8] = (         int  )0;
                sqlstm.sqharm[8] = (unsigned long )0;
                sqlstm.sqadto[8] = (unsigned short )0;
                sqlstm.sqtdso[8] = (unsigned short )0;
                sqlstm.sqhstv[9] = (unsigned char  *)&aihCodConcepto[iNumCargoVarios];
                sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[9] = (         int  )0;
                sqlstm.sqindv[9] = (         short *)0;
                sqlstm.sqinds[9] = (         int  )0;
                sqlstm.sqharm[9] = (unsigned long )0;
                sqlstm.sqadto[9] = (unsigned short )0;
                sqlstm.sqtdso[9] = (unsigned short )0;
                sqlstm.sqhstv[10] = (unsigned char  *)&aihCantidad[iNumCargoVarios];
                sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[10] = (         int  )0;
                sqlstm.sqindv[10] = (         short *)0;
                sqlstm.sqinds[10] = (         int  )0;
                sqlstm.sqharm[10] = (unsigned long )0;
                sqlstm.sqadto[10] = (unsigned short )0;
                sqlstm.sqtdso[10] = (unsigned short )0;
                sqlstm.sqhstv[11] = (unsigned char  *)&adhImpFacturable[iNumCargoVarios];
                sqlstm.sqhstl[11] = (unsigned long )sizeof(double);
                sqlstm.sqhsts[11] = (         int  )0;
                sqlstm.sqindv[11] = (         short *)0;
                sqlstm.sqinds[11] = (         int  )0;
                sqlstm.sqharm[11] = (unsigned long )0;
                sqlstm.sqadto[11] = (unsigned short )0;
                sqlstm.sqtdso[11] = (unsigned short )0;
                sqlstm.sqhstv[12] = (unsigned char  *)&ihValorCero;
                sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[12] = (         int  )0;
                sqlstm.sqindv[12] = (         short *)0;
                sqlstm.sqinds[12] = (         int  )0;
                sqlstm.sqharm[12] = (unsigned long )0;
                sqlstm.sqadto[12] = (unsigned short )0;
                sqlstm.sqtdso[12] = (unsigned short )0;
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



            if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND) 
            {            
                vDTrazasLog(szExeInfCtlPreCiclo   , "\t\t**(bfnStatCargosVarios) Error En Insert Cargos Varios "
                                                    "\n\t\t Error Oracle [%d] [%s]"
                                                    ,LOG01,SQLCODE,SQLERRM);
                vDTrazasError(szExeInfCtlPreCiclo , "\t\t**(bfnStatCargosVarios) Error En Insert Cargos Varios "
                                                    "\n\t\t Error Oracle [%d] [%s]"
                                                    ,LOG01,SQLCODE,SQLERRM);
                return FALSE;
            }
        }
    }
    else
    {
        vDTrazasLog(szExeInfCtlPreCiclo   , "\t\t**(bfnStatCargosVarios) Arreglo de Cargos Varios Sobrepasado"
                                            "\n\t\t Error Oracle [%d] [%s]"
                                            ,LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szExeInfCtlPreCiclo , "\t\t**(bfnStatCargosVarios) Arreglo de Cargos Varios Sobrepasado"
                                            "\n\t\t Error Oracle [%d] [%s]"
                                            ,LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }
    /* EXEC SQL CLOSE C_CURSOR_CTLCARGOS_VARIOS; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )449;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    vDTrazasLog(szExeInfCtlPreCiclo   ,"\t%s  **(bfnStatCargosVarios) Cargos Generados [%d] de [%d]", LOG03,cfnGetTime(1),iNumCargoVarios,iSqlRow);
    return TRUE;
}




/****************************************************************************/
/*  Funcion :   bfnStatCargosTrafico                                        */
/*  SAAM-20030106 Se cambia la declaración del cursor por una declaracion   */
/*  dinamica                                                                */
/****************************************************************************/
BOOL bfnStatCargosTrafico( void )
{
    /* EXEC SQL BEGIN DECLARE SECTION  ; */ 

    char    szhCodInforme   [7] ;/* EXEC SQL VAR szhCodInforme  IS STRING(7); */ 

    long    lhNumSecuInfo       ;    
    int     ihIndFactur         ;
    int     ihIndSupertel       ;
    char    szhCodTipClie   [3] ;/* EXEC SQL VAR szhCodTipClie  IS STRING(3); */ 

    long    lhCodTipDocum       ;
    char    szhCodDespacho  [6] ;/* EXEC SQL VAR szhCodDespacho  IS STRING(6); */ 

    int     ihCodCiclFact       ;

    int     aihCodProducto   [MAX_CARGOS_TRAFICO_FETCH];
    int     aihCodCiclFact   [MAX_CARGOS_TRAFICO_FETCH];
    long    aihCodConcepto   [MAX_CARGOS_TRAFICO_FETCH];
    int     aihCantidad      [MAX_CARGOS_TRAFICO_FETCH];
    double  adhImpFacturable [MAX_CARGOS_TRAFICO_FETCH];
    long    alhSegConsumido  [MAX_CARGOS_TRAFICO_FETCH];
    int     aihTipTrafico    [MAX_CARGOS_TRAFICO_FETCH];
    /* EXEC SQL END DECLARE SECTION ; */ 
    
    int     iSqlRow         = 0;
    int     iNumCargoTrafico= 0;
    char    szCadena[5000]; /* SAAM-20030106 */

    vDTrazasLog(szExeInfCtlPreCiclo   ,"\n\t%s  **(bfnStatCargosTrafico) ",LOG03,cfnGetTime(1));
    
    sprintf(szhCodInforme,"%s\0", szCodInformeGenerar   );
            lhNumSecuInfo       = lhNumSecuenciaInforme  ;
            ihCodCiclFact       = stLineaComando.iCodCiclFact;
            ihIndFactur         =   1;
            ihIndSupertel       =   0;
    sprintf(szhCodTipClie,"I\0"    );
            lhCodTipDocum       =   0;
    sprintf(szhCodDespacho,"-----\0");


    if (stLineaComando.iTipoTasacion==TIPO_TASA_CLASICA)
    {
        sprintf(szCadena,
            "SELECT COD_PRODUCTO , "
                "   COD_CICLFACT , "
                "   COD_CONCEPTO , "
                "   CANT         , "
                "   IMP_CONSUMIDO, "
                "   SEG_CONSUMIDO, "
                "   TIP_TRAFICO  "
              "FROM (SELECT  /*+  B PK_TA_ACUMAIREFRASOC */ "
	             "            D.COD_FACTURACION  COD_CONCEPTO    , "
	             "            B.COD_CICLFACT     COD_CICLFACT    , "
	             "            D.COD_PRODUCTO     COD_PRODUCTO    , "
	             "            SUM(SEG_CONSUMIDO) SEG_CONSUMIDO   , "
	             "            SUM(IMP_CONSUMIDO) IMP_CONSUMIDO   , "
	             "            COUNT(1)           CANT            , "
	             "            1                  TIP_TRAFICO  "
	             "    FROM    TA_CONCEPFACT       D   , "
	             "            TA_ACUMAIREFRASOC   B   ,  "
	             "            (SELECT DISTINCT NUM_ABONADO FROM FAT_CTLINTERABO WHERE IND_ESTADO  = 1 AND NUM_ABONADO > 0) A "
	             "    WHERE   B.NUM_ABONADO       = A.NUM_ABONADO "
	             "    AND     B.NUM_PROCESO       = 0 "
	             "    AND     D.COD_PRODUCTO      = 1 "
	             "    AND     D.IND_TABLA         = 1 "
	             "    AND     B.IND_ENTSAL        = D.IND_ENTSAL "
	             "    AND     B.COD_FRANHORASOC   = D.COD_TARIFICACION "
	             "    AND     B.IND_DESTINO       = D.IND_DESTINO "  /* NUEVO 03-09-2002  */
	             "    AND     B.COD_SERVICIO      = D.COD_SERVICIO " /* NUEVO 03-09-2002  */
	             "    AND     B.COD_CICLFACT IN ( SELECT  COD_CICLFACT  "
	             "                                FROM    FA_CICLFACT  "
	             "                                WHERE   FEC_EMISION <= (    SELECT  FEC_EMISION  "
	             "                                                            FROM    FA_CICLFACT  "
	             "                                                            WHERE   COD_CICLFACT = :ihCodCiclFact)) "
	             "    GROUP BY "
	             "            D.COD_FACTURACION , "
	             "            B.COD_CICLFACT    , "
	             "            D.COD_PRODUCTO "
	           "UNION ALL "
	             "    SELECT  /*+  B PK_TA_ACUMOPER */  "
	             "            D.COD_FACTURACION  COD_CONCEPTO, "
	             "            B.COD_CICLFACT     COD_CICLFACT, "
	             "            D.COD_PRODUCTO     COD_PRODUCTO, "
	             "            SUM(SEG_CONSUMIDO) SEG_CONSUMIDO, "
	             "            SUM(IMP_CONSUMIDO) IMP_CONSUMIDO, "
	             "            COUNT(1)           CANT         , "
	             "            2                  TIP_TRAFICO  "
	             "    FROM    TA_CONCEPFACT   D   , "
	             "            TA_ACUMOPER     B   , " 
	             "            (SELECT DISTINCT NUM_ABONADO FROM FAT_CTLINTERABO WHERE IND_ESTADO  = 1 AND NUM_ABONADO > 0) A "
	             "    WHERE   B.NUM_ABONADO       = A.NUM_ABONADO "
	             "    AND     B.NUM_PROCESO       = 0 "
	             "    AND     D.COD_PRODUCTO      = 1 "
	             "    AND     D.IND_TABLA         = 2 "
	             "    AND     B.COD_OPERADOR      = D.COD_TARIFICACION "
	             "    AND     B.COD_CICLFACT IN ( SELECT  COD_CICLFACT  "
	             "                                FROM    FA_CICLFACT "
	             "                                WHERE   FEC_EMISION <= (    SELECT  FEC_EMISION  "
	             "                                                            FROM    FA_CICLFACT  "
	             "                                                            WHERE   COD_CICLFACT = :ihCodCiclFact)) "
	             "    GROUP BY "
	             "            D.COD_FACTURACION   , "
	             "            B.COD_CICLFACT      , "
	             "            D.COD_PRODUCTO      "
	             "UNION ALL "
	             "    SELECT  /*+ INDEX (B PK_TA_ACUMLLAMADASROA) */ "
	             "            D.COD_FACTURACION   COD_CONCEPTO , "
	             "            B.COD_CICLFACT      COD_CICLFACT , "
	             "            D.COD_PRODUCTO      COD_PRODUCTO , "
	             "          SUM(SEG_CONSUMIDO)   SEG_CONSUMIDO, "
	             "          SUM(IMP_CONSUMIDO)   IMP_CONSUMIDO, "
	             "            COUNT(1)            CANT         , "
	             "            3                   TIP_TRAFICO  "
	             "  FROM    TA_ACUMLLAMADASROA  B ,  "
	             "          (SELECT DISTINCT NUM_ABONADO FROM FAT_CTLINTERABO WHERE IND_ESTADO  = 1 AND NUM_ABONADO > 0) A, "
	             "          TA_CONCEPFACT D  "
	             "    WHERE   D.COD_PRODUCTO      = 1 "
	             "    AND     D.IND_TABLA         = 3 "
	             "    AND     B.COD_OPERADOR      = D.COD_TARIFICACION "
	             "    AND     B.NUM_ABONADO       = A.NUM_ABONADO "
	             "    AND     B.COD_CICLFACT IN ( SELECT COD_CICLFACT  "
	                                              " FROM FA_CICLFACT "
	                                             " WHERE FEC_EMISION <= ( SELECT FEC_EMISION  "
	             	                                                      " FROM FA_CICLFACT "
	             	                                                     " WHERE COD_CICLFACT = :ihCodCiclFact)) "
	             "    AND     B.NUM_PROCESO       = 0 "
	             "    GROUP BY "
	             "            D.COD_FACTURACION                   , "
	             "            B.COD_CICLFACT                      , "
	             "            D.COD_PRODUCTO  ) "
	             "UNION ALL "
	             "    SELECT  D.COD_CONCFACT          COD_CONCEPTO, "
	             "            B.COD_PERIODO           COD_CICLFACT, "
	             "            1                       COD_PRODUCTO, "
	             "            SUM(SEG_CONSUMIDO)      SEG_CONSUMIDO, "
	             "            SUM(IMP_CONSUMIDO)      IMP_CONSUMIDO, "
	             "            COUNT(1)                CANT         , "
	             "            4                       TIP_TRAFICO  "
	             "    FROM    FA_CONCEPTOS        E , "
	             "            FA_FACTCARRIERS     D , "
	             "            FA_ACUMFORTAS       B ,  "
	             "            (SELECT DISTINCT NUM_ABONADO FROM FAT_CTLINTERABO WHERE IND_ESTADO  = 1 AND NUM_ABONADO > 0) A "
	             "  WHERE   B.NUM_ABONADO   = A.NUM_ABONADO "
	             "  AND     B.IND_ALQUILER  = 0 "
	             "    AND     B.COD_PERIODO IN ( SELECT   COD_CICLFACT  "
	             "                                FROM    FA_CICLFACT "
	             "                                WHERE   FEC_EMISION <= (    SELECT  FEC_EMISION  "
	             "                                                            FROM    FA_CICLFACT "
	             "                                                            WHERE   COD_CICLFACT = :ihCodCiclFact)) "
	             "  AND     B.NUM_PROCESO   = 0 "
	             "  AND     B.COD_TIPCONCE  = 4 "
	             "  AND     B.COD_OPERADOR  = D.COD_CONCCARRIER "
	             "  AND     D.COD_CONCFACT  = E.COD_CONCEPTO "
	             "   AND     E.COD_TIPCONCE  = 4 "
	             "  GROUP BY  "
	             "          D.COD_CONCFACT, "
	             "            B.COD_PERIODO   ) " );
    }
    else if (stLineaComando.iTipoTasacion==TIPO_TASA_ON_LINE)
    {
        sprintf(szCadena,
            "SELECT COD_PRODUCTO , "
                  " COD_CICLFACT , "
                  " COD_CONCEPTO , "
                  " CANT, "
                  " IMP_CONSUMIDO, "
                  " SEG_CONSUMIDO, "
                  " TIP_TRAFICO "
             "FROM ( SELECT  TA.COD_CARG  COD_CONCEPTO , "
                            " TA.COD_CICLFACT  COD_CICLFACT , "
                            " TP.COD_PRODUCTO  COD_PRODUCTO , "
                            " SUM(TA.DUR_FACT) SEG_CONSUMIDO, "
                            " SUM(TA.MTO_FACT) IMP_CONSUMIDO, "
                            " COUNT(1) CANT , "
                            " 0 TIP_TRAFICO "
                      " FROM TA_PLANTARIF TP, TOL_ACUMOPER_TO TA, TA_OPERADORES TT, "
                          " (SELECT DISTINCT NUM_ABONADO FROM FAT_CTLINTERABO WHERE IND_ESTADO= 1 AND NUM_ABONADO > 0) FC "
                      "WHERE TA.NUM_ABONADO   = FC.NUM_ABONADO "
                      "  AND TP.COD_PLANTARIF = TA.COD_PLAN "
                      "  AND TA.COD_OPERADOR  = TT.COD_OPERADOR "  /***para todos los casos salvo operadora propia y roaming*/
                      "  AND TT.COD_TOPE <> 'M' "
                      "  AND TA.COD_CICLFACT IN ( SELECT COD_CICLFACT "
                                                  " FROM FA_CICLFACT "
                                                  " WHERE FEC_EMISION <= (SELECT FEC_EMISION "
                                                                          " FROM FA_CICLFACT "
                                                                         " WHERE COD_CICLFACT = :ihCodCiclFact)) "
                      "  AND TA.NUM_PROCESO = 0 "
                      "GROUP BY TP.COD_PRODUCTO, TA.COD_CICLFACT, TA.COD_CARG "        
                "UNION ALL "
                      "SELECT TA.COD_CARG COD_CONCEPTO , "
                      	     "TA.COD_CICLFACT  COD_CICLFACT , "
                      	     "TP.COD_PRODUCTO  COD_PRODUCTO , "
                      	     "SUM(TA.DUR_FACT) SEG_CONSUMIDO, "
                      	     "SUM(TA.MTO_FACT) IMP_CONSUMIDO, "
                      	     "COUNT(1) CANT , "
                      	     "0 TIP_TRAFICO "
                       " FROM TA_PLANTARIF TP, TOL_ACUMOPER_TO TA, TA_OPERADORES TT, "             
                      		 " (SELECT DISTINCT NUM_ABONADO FROM FAT_CTLINTERABO WHERE IND_ESTADO = 1 AND NUM_ABONADO > 0) FC "
                      " WHERE TA.NUM_ABONADO  = FC.NUM_ABONADO "
                        " AND TP.COD_PLANTARIF = TA.COD_PLAN "
                        " AND TA.COD_OPERADOR = TT.COD_OPERADOR "  /***para caso operadora propia*/
                        " AND TT.COD_TOPE = 'M' "
                        " AND TT.COD_DOPE = 'P' "
                        " AND TA.COD_CICLFACT IN ( SELECT COD_CICLFACT "
              	                                    " FROM FA_CICLFACT "
              								       " WHERE FEC_EMISION <= (SELECT  FEC_EMISION "
              										 					   " FROM  FA_CICLFACT "
              															  " WHERE  COD_CICLFACT = :ihCodCiclFact)) "
                         "AND  TA.NUM_PROCESO = 0 "
                         "GROUP BY TP.COD_PRODUCTO, TA.COD_CICLFACT, TA.COD_CARG "        
                      "  UNION ALL "
                           " SELECT TA.COD_CARG COD_CONCEPTO , "
                                  " TA.COD_CICLFACT  COD_CICLFACT , "
                                  " TP.COD_PRODUCTO  COD_PRODUCTO , "
                                  " SUM(TA.DUR_FACT) SEG_CONSUMIDO, "
                                  " SUM(TA.MTO_FACT) IMP_CONSUMIDO, "
                                  " COUNT(1)         CANT , "
                                  " 3 TIP_TRAFICO "
                      "     FROM    TA_PLANTARIF TP, TOL_ACUMOPER_TO TA, TA_OPERADORES TT,"
                      			  " (SELECT DISTINCT NUM_ABONADO FROM FAT_CTLINTERABO WHERE IND_ESTADO = 1 AND NUM_ABONADO > 0) FC "
                         " WHERE TA.NUM_ABONADO   = FC.NUM_ABONADO "
                           " AND TP.COD_PLANTARIF = TA.COD_PLAN "
                           " AND TA.COD_OPERADOR = TT.COD_OPERADOR "
                           " AND TT.COD_TOPE = 'M' "
                           " AND TT.COD_DOPE <> 'P' "
                           " AND TT.IND_PORTADOR = 0 "
                           " AND TA.COD_CICLFACT IN ( SELECT COD_CICLFACT  "
                      							        " FROM FA_CICLFACT "
                      								   " WHERE FEC_EMISION <= (SELECT FEC_EMISION  "
                      														   " FROM FA_CICLFACT "
                      													      " WHERE COD_CICLFACT = :ihCodCiclFact)) "
                           " AND   TA.NUM_PROCESO = 0 "
                           " GROUP BY  TP.COD_PRODUCTO, TA.COD_CICLFACT, TA.COD_CARG "
                      "  UNION ALL "
                           " SELECT  D.COD_CONCFACT     COD_CONCEPTO, "
			                       " B.COD_PERIODO      COD_CICLFACT, "
			                       " 1 COD_PRODUCTO, "
			                       " SUM(SEG_CONSUMIDO) SEG_CONSUMIDO, "
			                       " SUM(IMP_CONSUMIDO) IMP_CONSUMIDO, "
			                       " COUNT(1) CANT , "
			                       " 4 TIP_TRAFICO  "
                            "  FROM  FA_CONCEPTOS E, FA_FACTCARRIERS D, FA_ACUMFORTAS B, "
                            	   " (SELECT DISTINCT NUM_ABONADO FROM FAT_CTLINTERABO WHERE IND_ESTADO = 1 AND NUM_ABONADO > 0) A "
                            " WHERE  B.NUM_ABONADO   = A.NUM_ABONADO "
                              " AND  B.IND_ALQUILER  = 0 "
                              " AND  B.COD_PERIODO IN ( SELECT COD_CICLFACT "
                                                        " FROM FA_CICLFACT "
                                                       " WHERE FEC_EMISION <= (SELECT FEC_EMISION "
                                                                               " FROM FA_CICLFACT "
                                                                              " WHERE COD_CICLFACT = :ihCodCiclFact)) "
                             " AND B.NUM_PROCESO  = 0 "
                             " AND B.COD_TIPCONCE = 4 "
                             " AND B.COD_OPERADOR = D.COD_CONCCARRIER "
                             " AND D.COD_CONCFACT = E.COD_CONCEPTO "
                             " AND E.COD_TIPCONCE = 4 "
                            " GROUP BY D.COD_CONCFACT, B.COD_PERIODO) ");
    }
    


    vDTrazasLog  (szExeInfCtlPreCiclo,"\n\t**  Cadena : [%s]  **",LOG05,szCadena);

    /* EXEC SQL PREPARE sql_CTLCARGOS_TRAFICO FROM :szCadena; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )464;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadena;
    sqlstm.sqhstl[0] = (unsigned long )5000;
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


  
 
    if (SQLCODE)  {
        vDTrazasLog  (szExeInfCtlPreCiclo,"\n\t**  Error en SQL-PREPARE sql_CTLCARGOS_TRAFICO **"
                                          "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szExeInfCtlPreCiclo,"\n\t**  Error en SQL-PREPARE sql_CTLCARGOS_TRAFICO **"
                                          "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }
                                    
    /* EXEC SQL DECLARE C_CURSOR_CTLCARGOS_TRAFICO CURSOR FOR sql_CTLCARGOS_TRAFICO; */ 

    if (SQLCODE)  {
        vDTrazasLog  (szExeInfCtlPreCiclo,"\n\t**  Error en SQL-DECLARE C_CURSOR_CTLCARGOS_TRAFICO  **"
                                          "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szExeInfCtlPreCiclo,"\n\t**  Error en SQL-DECLARE C_CURSOR_CTLCARGOS_TRAFICO  **"
                                          "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }                           

    /* EXEC SQL OPEN C_CURSOR_CTLCARGOS_TRAFICO USING :ihCodCiclFact; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )483;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodCiclFact;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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


    if(SQLCODE != SQLOK)
    {
        vDTrazasLog(szExeInfCtlPreCiclo,   "\n\n\t**  Error en Open Cursor (bfnStatCargosTrafico) **"
                                        "\n\t\t Error Oracle [%d] [%s]"
                                        ,LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }    
    
    /* EXEC SQL 
        FETCH C_CURSOR_CTLCARGOS_TRAFICO
        INTO        :aihCodProducto  ,
                    :aihCodCiclFact  ,
                    :aihCodConcepto  ,
                    :aihCantidad     ,
                    :adhImpFacturable,
                    :alhSegConsumido ,
                    :aihTipTrafico   ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1000;
    sqlstm.offset = (unsigned int  )502;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)aihCodProducto;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )sizeof(int);
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)aihCodCiclFact;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )sizeof(int);
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)aihCodConcepto;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )sizeof(long);
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)aihCantidad;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )sizeof(int);
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqharc[3] = (unsigned long  *)0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)adhImpFacturable;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[4] = (         int  )sizeof(double);
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqharc[4] = (unsigned long  *)0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)alhSegConsumido;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[5] = (         int  )sizeof(long);
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqharc[5] = (unsigned long  *)0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)aihTipTrafico;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[6] = (         int  )sizeof(int);
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqharc[6] = (unsigned long  *)0;
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



    if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND) 
    {            
        vDTrazasLog(szExeInfCtlPreCiclo   , "\t\t**(bfnStatCargosTrafico) Error En Fetch de Cargos Trafico "
                                            "\n\t\t Error Oracle [%d] [%s]"
                                            ,LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szExeInfCtlPreCiclo , "\t\t**(bfnStatCargosTrafico) Error En Fetch de Cargos Trafico "
                                            "\n\t\t Error Oracle [%d] [%s]"
                                            ,LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }
    iSqlRow = SQLROWS;
    if(SQLCODE == SQLNOTFOUND)
    {
        for (iNumCargoTrafico = 0; iNumCargoTrafico < iSqlRow ; iNumCargoTrafico++)
        {
            if (aihTipTrafico  [iNumCargoTrafico] == 3) /*  Roaming */
                adhImpFacturable [iNumCargoTrafico] = (double)(adhImpFacturable [iNumCargoTrafico] * dValorCTLDolar);
                
            /************************************************************************/
            /*  Inserta Registros de Cargos Trafifo en FAD_CTLINFCONC               */
            /************************************************************************/
                /* EXEC SQL 
                    INSERT INTO FAD_CTLINFCONC(
                                COD_INFORME     ,
                                NUM_SECUINFO    ,
                                IND_FACTUR      ,
                                IND_SUPERTEL    ,
                                COD_TIPCLIE     ,
                                COD_TIPDOCUM    ,
                                COD_DESPACHO    ,
                                COD_PRODUCTO    ,
                                COD_CICLFACT    ,
                                COD_CONCEPTO    ,
                                NUM_CONCEPTOS   ,
                                IMP_FACTURABLE  ,
                                NUM_MINUTOS     )
                    VALUES  (   :szhCodInforme  ,
                                :lhNumSecuInfo  ,
                                :ihIndFactur    ,
                                :ihIndSupertel  , 
                                :szhCodTipClie  ,
                                :lhCodTipDocum  ,
                                :szhCodDespacho ,
                                :aihCodProducto     [iNumCargoTrafico],
                                :aihCodCiclFact     [iNumCargoTrafico],
                                :aihCodConcepto     [iNumCargoTrafico],
                                :aihCantidad        [iNumCargoTrafico],
                                :adhImpFacturable   [iNumCargoTrafico],
                                :alhSegConsumido    [iNumCargoTrafico] ); */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 17;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "insert into FAD_CTLINFCONC (COD_INFORME,NUM_S\
ECUINFO,IND_FACTUR,IND_SUPERTEL,COD_TIPCLIE,COD_TIPDOCUM,COD_DESPACHO,COD_PROD\
UCTO,COD_CICLFACT,COD_CONCEPTO,NUM_CONCEPTOS,IMP_FACTURABLE,NUM_MINUTOS) value\
s (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8,:b9,:b10,:b11,:b12)";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )545;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)szhCodInforme;
                sqlstm.sqhstl[0] = (unsigned long )7;
                sqlstm.sqhsts[0] = (         int  )0;
                sqlstm.sqindv[0] = (         short *)0;
                sqlstm.sqinds[0] = (         int  )0;
                sqlstm.sqharm[0] = (unsigned long )0;
                sqlstm.sqadto[0] = (unsigned short )0;
                sqlstm.sqtdso[0] = (unsigned short )0;
                sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSecuInfo;
                sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[1] = (         int  )0;
                sqlstm.sqindv[1] = (         short *)0;
                sqlstm.sqinds[1] = (         int  )0;
                sqlstm.sqharm[1] = (unsigned long )0;
                sqlstm.sqadto[1] = (unsigned short )0;
                sqlstm.sqtdso[1] = (unsigned short )0;
                sqlstm.sqhstv[2] = (unsigned char  *)&ihIndFactur;
                sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[2] = (         int  )0;
                sqlstm.sqindv[2] = (         short *)0;
                sqlstm.sqinds[2] = (         int  )0;
                sqlstm.sqharm[2] = (unsigned long )0;
                sqlstm.sqadto[2] = (unsigned short )0;
                sqlstm.sqtdso[2] = (unsigned short )0;
                sqlstm.sqhstv[3] = (unsigned char  *)&ihIndSupertel;
                sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[3] = (         int  )0;
                sqlstm.sqindv[3] = (         short *)0;
                sqlstm.sqinds[3] = (         int  )0;
                sqlstm.sqharm[3] = (unsigned long )0;
                sqlstm.sqadto[3] = (unsigned short )0;
                sqlstm.sqtdso[3] = (unsigned short )0;
                sqlstm.sqhstv[4] = (unsigned char  *)szhCodTipClie;
                sqlstm.sqhstl[4] = (unsigned long )3;
                sqlstm.sqhsts[4] = (         int  )0;
                sqlstm.sqindv[4] = (         short *)0;
                sqlstm.sqinds[4] = (         int  )0;
                sqlstm.sqharm[4] = (unsigned long )0;
                sqlstm.sqadto[4] = (unsigned short )0;
                sqlstm.sqtdso[4] = (unsigned short )0;
                sqlstm.sqhstv[5] = (unsigned char  *)&lhCodTipDocum;
                sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[5] = (         int  )0;
                sqlstm.sqindv[5] = (         short *)0;
                sqlstm.sqinds[5] = (         int  )0;
                sqlstm.sqharm[5] = (unsigned long )0;
                sqlstm.sqadto[5] = (unsigned short )0;
                sqlstm.sqtdso[5] = (unsigned short )0;
                sqlstm.sqhstv[6] = (unsigned char  *)szhCodDespacho;
                sqlstm.sqhstl[6] = (unsigned long )6;
                sqlstm.sqhsts[6] = (         int  )0;
                sqlstm.sqindv[6] = (         short *)0;
                sqlstm.sqinds[6] = (         int  )0;
                sqlstm.sqharm[6] = (unsigned long )0;
                sqlstm.sqadto[6] = (unsigned short )0;
                sqlstm.sqtdso[6] = (unsigned short )0;
                sqlstm.sqhstv[7] = (unsigned char  *)&aihCodProducto[iNumCargoTrafico];
                sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[7] = (         int  )0;
                sqlstm.sqindv[7] = (         short *)0;
                sqlstm.sqinds[7] = (         int  )0;
                sqlstm.sqharm[7] = (unsigned long )0;
                sqlstm.sqadto[7] = (unsigned short )0;
                sqlstm.sqtdso[7] = (unsigned short )0;
                sqlstm.sqhstv[8] = (unsigned char  *)&aihCodCiclFact[iNumCargoTrafico];
                sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[8] = (         int  )0;
                sqlstm.sqindv[8] = (         short *)0;
                sqlstm.sqinds[8] = (         int  )0;
                sqlstm.sqharm[8] = (unsigned long )0;
                sqlstm.sqadto[8] = (unsigned short )0;
                sqlstm.sqtdso[8] = (unsigned short )0;
                sqlstm.sqhstv[9] = (unsigned char  *)&aihCodConcepto[iNumCargoTrafico];
                sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[9] = (         int  )0;
                sqlstm.sqindv[9] = (         short *)0;
                sqlstm.sqinds[9] = (         int  )0;
                sqlstm.sqharm[9] = (unsigned long )0;
                sqlstm.sqadto[9] = (unsigned short )0;
                sqlstm.sqtdso[9] = (unsigned short )0;
                sqlstm.sqhstv[10] = (unsigned char  *)&aihCantidad[iNumCargoTrafico];
                sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[10] = (         int  )0;
                sqlstm.sqindv[10] = (         short *)0;
                sqlstm.sqinds[10] = (         int  )0;
                sqlstm.sqharm[10] = (unsigned long )0;
                sqlstm.sqadto[10] = (unsigned short )0;
                sqlstm.sqtdso[10] = (unsigned short )0;
                sqlstm.sqhstv[11] = (unsigned char  *)&adhImpFacturable[iNumCargoTrafico];
                sqlstm.sqhstl[11] = (unsigned long )sizeof(double);
                sqlstm.sqhsts[11] = (         int  )0;
                sqlstm.sqindv[11] = (         short *)0;
                sqlstm.sqinds[11] = (         int  )0;
                sqlstm.sqharm[11] = (unsigned long )0;
                sqlstm.sqadto[11] = (unsigned short )0;
                sqlstm.sqtdso[11] = (unsigned short )0;
                sqlstm.sqhstv[12] = (unsigned char  *)&alhSegConsumido[iNumCargoTrafico];
                sqlstm.sqhstl[12] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[12] = (         int  )0;
                sqlstm.sqindv[12] = (         short *)0;
                sqlstm.sqinds[12] = (         int  )0;
                sqlstm.sqharm[12] = (unsigned long )0;
                sqlstm.sqadto[12] = (unsigned short )0;
                sqlstm.sqtdso[12] = (unsigned short )0;
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



            if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND) 
            {            
                vDTrazasLog(szExeInfCtlPreCiclo   , "\t\t**(bfnStatCargosTrafico) Error En Insert Cargos Trafico "
                                                    "\n\t\t Error Oracle [%d] [%s]"
                                                    ,LOG01,SQLCODE,SQLERRM);
                vDTrazasError(szExeInfCtlPreCiclo , "\t\t**(bfnStatCargosTrafico) Error En Insert Cargos Trafico "
                                                    "\n\t\t Error Oracle [%d] [%s]"
                                                    ,LOG01,SQLCODE,SQLERRM);
                return FALSE;
            }

        }
    }
    else
    {
        vDTrazasLog(szExeInfCtlPreCiclo   , "\t\t**(bfnStatCargosTrafico) Arreglo de Cargos de Trafico Sobrepasado"
                                            "\n\t\t Error Oracle [%d] [%s]"
                                            ,LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szExeInfCtlPreCiclo , "\t\t**(bfnStatCargosTrafico) Arreglo de Cargos de Trafico Sobrepasado"
                                            "\n\t\t Error Oracle [%d] [%s]"
                                            ,LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }
    /* EXEC SQL CLOSE C_CURSOR_CTLCARGOS_TRAFICO; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )612;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    vDTrazasLog(szExeInfCtlPreCiclo   ,"\t%s  **(bfnStatCargosTrafico) Cargos Generados [%d] de [%d]", LOG03,cfnGetTime(1),iNumCargoTrafico,iSqlRow);
    return TRUE;
}


/****************************************************************************/
/*  Funcion :   bfnStatCargosBasicos                                        */
/****************************************************************************/
BOOL bfnStatCargosBasicos( void )
{
    /* EXEC SQL BEGIN DECLARE SECTION  ; */ 

    char    szhCodInforme   [7] ;/* EXEC SQL VAR szhCodInforme     IS STRING(7); */ 

    long    lhNumSecuInfo       ;    
    int     ihIndFactur         ;
    int     ihIndSupertel       ;
    char    szhCodTipClie   [3] ;/* EXEC SQL VAR szhCodTipClie     IS STRING(3); */ 

    long    lhCodTipDocum       ;
    char    szhCodDespacho  [6] ;/* EXEC SQL VAR szhCodDespacho    IS STRING(6); */ 

    int     ihCodCiclFact       ;
    int     ihCodProducto       ;
    long    ihCodConcepto       ;
    int     ihCantidad          ;
    double  dhImpFacturable     ;
    long    lhSegConsumido      ;
    char    szhCodCBasico   [4] ;/* EXEC SQL VAR szhCodCBasico     IS STRING(4); */ 

    /* EXEC SQL END DECLARE SECTION; */ 

    int iStat=0;

    sprintf(szhCodInforme,"%s\0", szCodInformeGenerar   );
            lhNumSecuInfo       = lhNumSecuenciaInforme  ;
            ihCodCiclFact       = stLineaComando.iCodCiclFact;
            ihIndFactur         =   1;
            ihIndSupertel       =   0;
    sprintf(szhCodTipClie,"I\0"    );
            lhCodTipDocum       =   0;
    sprintf(szhCodDespacho,"-----\0");
            lhSegConsumido      = 0;
    
    vDTrazasLog(szExeInfCtlPreCiclo   ,"\n\t%s  **(bfnStatCargosBasicos) ",LOG03,cfnGetTime(1));

    for (iStat=0;iStat<stStatCargoBasico.iNumStadisticas;iStat++)
    {
        ihCodProducto   = stStatCargoBasico.stUnivStatCBas[iStat].iCodProducto;
        ihCodConcepto   = (ihCodProducto == 1?stCodCargosBasicos.lCodAbonoCel:stCodCargosBasicos.lCodAbonoBeep);
        ihCantidad      = stStatCargoBasico.stUnivStatCBas[iStat].iNumCargosBasicos;
        sprintf(szhCodCBasico,"%s\0",stStatCargoBasico.stUnivStatCBas[iStat].szCodCargoBasico);
        dhImpFacturable = (double)((double)(ihCantidad) * dfnValorCBasico(szhCodCBasico,ihCodProducto));

        vDTrazasLog(szExeInfCtlPreCiclo,
            "\n\t\t**(bfnStatCargosBasicos) Inserta Cargos Basicos"
            "\n\t\t[%d]** Codigo Informe            [%s]"
            "\n\t\t[%d]** Numero Secuencia          [%ld]"      
            "\n\t\t[%d]** Indicador Facturacion     [%d]"       
            "\n\t\t[%d]** Indicador Supertelefono   [%d]"       
            "\n\t\t[%d]** Tipo Cliente              [%s]"       
            "\n\t\t[%d]** Tipo Documento            [%ld]"      
            "\n\t\t[%d]** Codigo Despacho           [%s]"       
            "\n\t\t[%d]** Codigo Producto           [%d]"       
            "\n\t\t[%d]** Ciclo Facturacion         [%d]"      
            "\n\t\t[%d]** Codigo Concepto           [%d]"       
            "\n\t\t[%d]** Cargo Basico              [%s]"      
            "\n\t\t[%d]** Cantidad  Cargos Basicos  [%d]"       
            "\n\t\t[%d]** Importe Facturable        [%.f]"      
            "\n\t\t[%d]** Segundos Consumidos       [%ld]"      
            ,LOG03
            ,iStat,szhCodInforme  
            ,iStat,lhNumSecuInfo  
            ,iStat,ihIndFactur    
            ,iStat,ihIndSupertel  
            ,iStat,szhCodTipClie  
            ,iStat,lhCodTipDocum  
            ,iStat,szhCodDespacho 
            ,iStat,ihCodProducto  
            ,iStat,ihCodCiclFact  
            ,iStat,ihCodConcepto  
            ,iStat,szhCodCBasico
            ,iStat,ihCantidad     
            ,iStat,dhImpFacturable
            ,iStat,lhSegConsumido  );

        /****************************************************************/
        /*  Inserta Cargos Basicos de Pre-Ciclo                         */
        /****************************************************************/

        /* EXEC SQL 
            INSERT INTO FAD_CTLINFCONC(
                        COD_INFORME     ,
                        NUM_SECUINFO    ,
                        IND_FACTUR      ,
                        IND_SUPERTEL    ,
                        COD_TIPCLIE     ,
                        COD_TIPDOCUM    ,
                        COD_DESPACHO    ,
                        COD_PRODUCTO    ,
                        COD_CICLFACT    ,
                        COD_CONCEPTO    ,
                        NUM_CONCEPTOS   ,
                        IMP_FACTURABLE  ,
                        NUM_MINUTOS     ,
                        COD_CARGOBASICO )
            VALUES  (   :szhCodInforme  ,
                        :lhNumSecuInfo  ,
                        :ihIndFactur    ,
                        :ihIndSupertel  , 
                        :szhCodTipClie  ,
                        :lhCodTipDocum  ,
                        :szhCodDespacho ,
                        :ihCodProducto  ,
                        :ihCodCiclFact  ,
                        :ihCodConcepto  ,
                        :ihCantidad     ,
                        :dhImpFacturable,
                        :lhSegConsumido ,
                        :szhCodCBasico  ); */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 17;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "insert into FAD_CTLINFCONC (COD_INFORME,NUM_SECUINFO,\
IND_FACTUR,IND_SUPERTEL,COD_TIPCLIE,COD_TIPDOCUM,COD_DESPACHO,COD_PRODUCTO,COD\
_CICLFACT,COD_CONCEPTO,NUM_CONCEPTOS,IMP_FACTURABLE,NUM_MINUTOS,COD_CARGOBASIC\
O) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8,:b9,:b10,:b11,:b12,:b13)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )627;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhCodInforme;
        sqlstm.sqhstl[0] = (unsigned long )7;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSecuInfo;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&ihIndFactur;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&ihIndSupertel;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhCodTipClie;
        sqlstm.sqhstl[4] = (unsigned long )3;
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&lhCodTipDocum;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)szhCodDespacho;
        sqlstm.sqhstl[6] = (unsigned long )6;
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)&ihCodProducto;
        sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)&ihCodCiclFact;
        sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[8] = (         int  )0;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)&ihCodConcepto;
        sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[9] = (         int  )0;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)&ihCantidad;
        sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[10] = (         int  )0;
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
        sqlstm.sqhstv[11] = (unsigned char  *)&dhImpFacturable;
        sqlstm.sqhstl[11] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[11] = (         int  )0;
        sqlstm.sqindv[11] = (         short *)0;
        sqlstm.sqinds[11] = (         int  )0;
        sqlstm.sqharm[11] = (unsigned long )0;
        sqlstm.sqadto[11] = (unsigned short )0;
        sqlstm.sqtdso[11] = (unsigned short )0;
        sqlstm.sqhstv[12] = (unsigned char  *)&lhSegConsumido;
        sqlstm.sqhstl[12] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[12] = (         int  )0;
        sqlstm.sqindv[12] = (         short *)0;
        sqlstm.sqinds[12] = (         int  )0;
        sqlstm.sqharm[12] = (unsigned long )0;
        sqlstm.sqadto[12] = (unsigned short )0;
        sqlstm.sqtdso[12] = (unsigned short )0;
        sqlstm.sqhstv[13] = (unsigned char  *)szhCodCBasico;
        sqlstm.sqhstl[13] = (unsigned long )4;
        sqlstm.sqhsts[13] = (         int  )0;
        sqlstm.sqindv[13] = (         short *)0;
        sqlstm.sqinds[13] = (         int  )0;
        sqlstm.sqharm[13] = (unsigned long )0;
        sqlstm.sqadto[13] = (unsigned short )0;
        sqlstm.sqtdso[13] = (unsigned short )0;
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


                        
        if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND) 
        {            
            vDTrazasLog(szExeInfCtlPreCiclo,"\t\t**(bfnStatCargosBasicos) Error En Insert Cargos Basicos "
                                            "\n\t\t Error Oracle [%d] [%s]"
                                            ,LOG01,SQLCODE,SQLERRM);
            vDTrazasError(szExeInfCtlPreCiclo , "\t\t**(bfnStatCargosBasicos) Error En Insert Cargos Basicos "
                                                "\n\t\t Error Oracle [%d] [%s]"
                                                ,LOG01,SQLCODE,SQLERRM);
            return FALSE;
        }
    }
    vDTrazasLog(szExeInfCtlPreCiclo   ,"\t%s  **(bfnStatCargosBasicos) Cargos Basicos Generados [%d] ", LOG03,cfnGetTime(1),iStat,iStat);
    return TRUE;
}

/****************************************************************************/
/*  Funcion :   bfnStatCargosServSupl                                       */
/****************************************************************************/
BOOL bfnStatCargosServSupl( void )
{
    /* EXEC SQL BEGIN DECLARE SECTION  ; */ 

    char    szhCodInforme   [7] ;/* EXEC SQL VAR szhCodInforme  IS STRING(7); */ 

    long    lhNumSecuInfo       ;    
    int     ihIndFactur         ;
    int     ihIndSupertel       ;
    char    szhCodTipClie   [3] ;/* EXEC SQL VAR szhCodTipClie  IS STRING(3); */ 

    long    lhCodTipDocum       ;
    char    szhCodDespacho  [6] ;/* EXEC SQL VAR szhCodDespacho  IS STRING(6); */ 

    int     ihCodCiclFact       ;
    long    lhSegConsumido      ;
    char    szhFecEmision [15]  ;/* EXEC SQL VAR szhFecEmision IS STRING (15); */ 

    char    szhCodMoneda   [4]  ;/* EXEC SQL VAR szhCodMoneda  IS STRING(4); */ 

    
    int     aihCodProducto   [MAX_CARGOS_SERVSUPL_FETCH];
    long    aihCodConcepto   [MAX_CARGOS_SERVSUPL_FETCH];
    /* VARCHAR aszhCodMoneda    [MAX_CARGOS_SERVSUPL_FETCH][4]; */ 
struct { unsigned short len; unsigned char arr[6]; } aszhCodMoneda[1000];

    int     aihCantidad      [MAX_CARGOS_SERVSUPL_FETCH];
    double  adhImpFacturable [MAX_CARGOS_SERVSUPL_FETCH];
    /* EXEC SQL END DECLARE SECTION ; */ 
    
    int     iSqlRow         = 0;
    int     iNumServSupl= 0;

    vDTrazasLog(szExeInfCtlPreCiclo   ,"\n\t%s  **(bfnStatCargosServSupl) ",LOG03,cfnGetTime(1));
    
    if (stLineaComando.iIndFacturacion == iIND_FACT_NOPROCESADO)
    {
        sprintf(szhFecEmision  ,"%s\0",stLineaComando.szFecEmision     );    
        sprintf(szhCodInforme,"%s\0", szCodInformeGenerar   );
                lhNumSecuInfo       = lhNumSecuenciaInforme  ;
                ihCodCiclFact       = stLineaComando.iCodCiclFact;
                ihIndFactur         =   1;
                ihIndSupertel       =   0;
        sprintf(szhCodTipClie,"I\0"    );
                lhCodTipDocum       =   0;
        sprintf(szhCodDespacho,"-----\0");
                lhSegConsumido     =   0;
    
        /* EXEC SQL DECLARE C_CURSOR_CTLCARGOS_SERVSUPL CURSOR FOR
            SELECT  A.COD_PRODUCTO      ,
                    A.COD_CONCEPTO      ,
                    T.COD_MONEDA        ,
                    COUNT(A.COD_CONCEPTO),
                    SUM(T.IMP_TARIFA)   
            FROM    (SELECT DISTINCT NUM_ABONADO FROM FAT_CTLINTERABO WHERE IND_ESTADO  = 1 AND NUM_ABONADO > 0) I,
                    GA_SERVSUPLABO  A   , 
                    GA_SERVSUPL     B   ,
                    GA_TARIFAS      T
            WHERE   T.COD_ACTABO = 'FA'
            AND     T.COD_TIPSERV = 2
            AND     T.IMP_TARIFA > 0
            AND     (   TO_DATE(:szhFecEmision,'YYYYMMDDHH24MISS') 
                        BETWEEN T.FEC_DESDE AND T.FEC_HASTA OR  T.FEC_HASTA IS NULL)
            AND     A.NUM_ABONADO   = I.NUM_ABONADO
            AND     A.COD_SERVICIO  = T.COD_SERVICIO
            AND     A.COD_PRODUCTO  = T.COD_PRODUCTO
            AND     A.IND_ESTADO    IN (1, 2, 5)
            AND     B.COD_PRODUCTO  = A.COD_PRODUCTO
            AND     B.COD_SERVICIO  = A.COD_SERVICIO
            AND     A.COD_CONCEPTO IS NOT NULL
            GROUP BY
                    A.COD_PRODUCTO      ,
                    A.COD_CONCEPTO      ,
                    T.COD_MONEDA        ; */ 

    
        /* EXEC SQL OPEN C_CURSOR_CTLCARGOS_SERVSUPL; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 17;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0012;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )698;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhFecEmision;
        sqlstm.sqhstl[0] = (unsigned long )15;
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


        if(SQLCODE != SQLOK)
        {
            vDTrazasLog(szExeInfCtlPreCiclo,   "\n\n\t**  Error en Open Cursor (bfnStatCargosServSupl) **"
                                            "\n\t\t Error Oracle [%d] [%s]"
                                            ,LOG01,SQLCODE,SQLERRM);
            return FALSE;
        }    
        
        /* EXEC SQL 
            FETCH C_CURSOR_CTLCARGOS_SERVSUPL
            INTO        :aihCodProducto  ,
                        :aihCodConcepto  ,
                        :aszhCodMoneda   ,
                        :aihCantidad     ,
                        :adhImpFacturable; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 17;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1000;
        sqlstm.offset = (unsigned int  )717;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)aihCodProducto;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )sizeof(int);
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqharc[0] = (unsigned long  *)0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)aihCodConcepto;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )sizeof(long);
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqharc[1] = (unsigned long  *)0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)aszhCodMoneda;
        sqlstm.sqhstl[2] = (unsigned long )6;
        sqlstm.sqhsts[2] = (         int  )8;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqharc[2] = (unsigned long  *)0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)aihCantidad;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[3] = (         int  )sizeof(int);
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqharc[3] = (unsigned long  *)0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)adhImpFacturable;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[4] = (         int  )sizeof(double);
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqharc[4] = (unsigned long  *)0;
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


    
        if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND) 
        {            
            vDTrazasLog(szExeInfCtlPreCiclo   , "\t\t**(bfnStatCargosServSupl) Error En Fetch de Servicios Suplementarios "
                                                "\n\t\t Error Oracle [%d] [%s]"
                                                ,LOG01,SQLCODE,SQLERRM);
            vDTrazasError(szExeInfCtlPreCiclo , "\t\t**(bfnStatCargosServSupl) Error En Fetch de Servicios Suplementarios "
                                                "\n\t\t Error Oracle [%d] [%s]"
                                                ,LOG01,SQLCODE,SQLERRM);
            return FALSE;
        }
        iSqlRow = SQLROWS;
        if(SQLCODE == SQLNOTFOUND)
        {
            for (iNumServSupl = 0; iNumServSupl < iSqlRow ; iNumServSupl++)
            {
                /************************************************************************/
                /*   Conversion de Monedas                                              */
                /************************************************************************/
                sprintf(szhCodMoneda,"%.*s\0" , aszhCodMoneda[iNumServSupl].len , aszhCodMoneda[iNumServSupl].arr );
                if (strcmp(szhCodMoneda, "002")==0) /*  Dolar  */
                    adhImpFacturable[iNumServSupl] = adhImpFacturable [iNumServSupl] * dValorCTLDolar;
                if (strcmp(szhCodMoneda, "003")==0) /*  U.F.   */
                    adhImpFacturable[iNumServSupl] = adhImpFacturable [iNumServSupl] * dValorCTLUF   ;
                /************************************************************************/
                /*  Inserta Registros de Cargos Varios en FAD_CTLINFCONC                */
                /************************************************************************/
                    /* EXEC SQL 
                        INSERT INTO FAD_CTLINFCONC(
                                    COD_INFORME     ,
                                    NUM_SECUINFO    ,
                                    IND_FACTUR      ,
                                    IND_SUPERTEL    ,
                                    COD_TIPCLIE     ,
                                    COD_TIPDOCUM    ,
                                    COD_DESPACHO    ,
                                    COD_PRODUCTO    ,
                                    COD_CICLFACT    ,
                                    COD_CONCEPTO    ,
                                    NUM_CONCEPTOS   ,
                                    IMP_FACTURABLE  ,
                                    NUM_MINUTOS     )
                        VALUES  (   :szhCodInforme  ,
                                    :lhNumSecuInfo  ,
                                    :ihIndFactur    ,
                                    :ihIndSupertel  , 
                                    :szhCodTipClie  ,
                                    :lhCodTipDocum  ,
                                    :szhCodDespacho ,
                                    :aihCodProducto     [iNumServSupl],
                                    :ihCodCiclFact  ,
                                    :aihCodConcepto     [iNumServSupl],
                                    :aihCantidad        [iNumServSupl],
                                    :adhImpFacturable   [iNumServSupl],
                                    :lhSegConsumido ); */ 

{
                    struct sqlexd sqlstm;
                    sqlstm.sqlvsn = 12;
                    sqlstm.arrsiz = 17;
                    sqlstm.sqladtp = &sqladt;
                    sqlstm.sqltdsp = &sqltds;
                    sqlstm.stmt = "insert into FAD_CTLINFCONC (COD_INFORME,N\
UM_SECUINFO,IND_FACTUR,IND_SUPERTEL,COD_TIPCLIE,COD_TIPDOCUM,COD_DESPACHO,COD_\
PRODUCTO,COD_CICLFACT,COD_CONCEPTO,NUM_CONCEPTOS,IMP_FACTURABLE,NUM_MINUTOS) v\
alues (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8,:b9,:b10,:b11,:b12)";
                    sqlstm.iters = (unsigned int  )1;
                    sqlstm.offset = (unsigned int  )752;
                    sqlstm.cud = sqlcud0;
                    sqlstm.sqlest = (unsigned char  *)&sqlca;
                    sqlstm.sqlety = (unsigned short)256;
                    sqlstm.occurs = (unsigned int  )0;
                    sqlstm.sqhstv[0] = (unsigned char  *)szhCodInforme;
                    sqlstm.sqhstl[0] = (unsigned long )7;
                    sqlstm.sqhsts[0] = (         int  )0;
                    sqlstm.sqindv[0] = (         short *)0;
                    sqlstm.sqinds[0] = (         int  )0;
                    sqlstm.sqharm[0] = (unsigned long )0;
                    sqlstm.sqadto[0] = (unsigned short )0;
                    sqlstm.sqtdso[0] = (unsigned short )0;
                    sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSecuInfo;
                    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
                    sqlstm.sqhsts[1] = (         int  )0;
                    sqlstm.sqindv[1] = (         short *)0;
                    sqlstm.sqinds[1] = (         int  )0;
                    sqlstm.sqharm[1] = (unsigned long )0;
                    sqlstm.sqadto[1] = (unsigned short )0;
                    sqlstm.sqtdso[1] = (unsigned short )0;
                    sqlstm.sqhstv[2] = (unsigned char  *)&ihIndFactur;
                    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
                    sqlstm.sqhsts[2] = (         int  )0;
                    sqlstm.sqindv[2] = (         short *)0;
                    sqlstm.sqinds[2] = (         int  )0;
                    sqlstm.sqharm[2] = (unsigned long )0;
                    sqlstm.sqadto[2] = (unsigned short )0;
                    sqlstm.sqtdso[2] = (unsigned short )0;
                    sqlstm.sqhstv[3] = (unsigned char  *)&ihIndSupertel;
                    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
                    sqlstm.sqhsts[3] = (         int  )0;
                    sqlstm.sqindv[3] = (         short *)0;
                    sqlstm.sqinds[3] = (         int  )0;
                    sqlstm.sqharm[3] = (unsigned long )0;
                    sqlstm.sqadto[3] = (unsigned short )0;
                    sqlstm.sqtdso[3] = (unsigned short )0;
                    sqlstm.sqhstv[4] = (unsigned char  *)szhCodTipClie;
                    sqlstm.sqhstl[4] = (unsigned long )3;
                    sqlstm.sqhsts[4] = (         int  )0;
                    sqlstm.sqindv[4] = (         short *)0;
                    sqlstm.sqinds[4] = (         int  )0;
                    sqlstm.sqharm[4] = (unsigned long )0;
                    sqlstm.sqadto[4] = (unsigned short )0;
                    sqlstm.sqtdso[4] = (unsigned short )0;
                    sqlstm.sqhstv[5] = (unsigned char  *)&lhCodTipDocum;
                    sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
                    sqlstm.sqhsts[5] = (         int  )0;
                    sqlstm.sqindv[5] = (         short *)0;
                    sqlstm.sqinds[5] = (         int  )0;
                    sqlstm.sqharm[5] = (unsigned long )0;
                    sqlstm.sqadto[5] = (unsigned short )0;
                    sqlstm.sqtdso[5] = (unsigned short )0;
                    sqlstm.sqhstv[6] = (unsigned char  *)szhCodDespacho;
                    sqlstm.sqhstl[6] = (unsigned long )6;
                    sqlstm.sqhsts[6] = (         int  )0;
                    sqlstm.sqindv[6] = (         short *)0;
                    sqlstm.sqinds[6] = (         int  )0;
                    sqlstm.sqharm[6] = (unsigned long )0;
                    sqlstm.sqadto[6] = (unsigned short )0;
                    sqlstm.sqtdso[6] = (unsigned short )0;
                    sqlstm.sqhstv[7] = (unsigned char  *)&aihCodProducto[iNumServSupl];
                    sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
                    sqlstm.sqhsts[7] = (         int  )0;
                    sqlstm.sqindv[7] = (         short *)0;
                    sqlstm.sqinds[7] = (         int  )0;
                    sqlstm.sqharm[7] = (unsigned long )0;
                    sqlstm.sqadto[7] = (unsigned short )0;
                    sqlstm.sqtdso[7] = (unsigned short )0;
                    sqlstm.sqhstv[8] = (unsigned char  *)&ihCodCiclFact;
                    sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
                    sqlstm.sqhsts[8] = (         int  )0;
                    sqlstm.sqindv[8] = (         short *)0;
                    sqlstm.sqinds[8] = (         int  )0;
                    sqlstm.sqharm[8] = (unsigned long )0;
                    sqlstm.sqadto[8] = (unsigned short )0;
                    sqlstm.sqtdso[8] = (unsigned short )0;
                    sqlstm.sqhstv[9] = (unsigned char  *)&aihCodConcepto[iNumServSupl];
                    sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
                    sqlstm.sqhsts[9] = (         int  )0;
                    sqlstm.sqindv[9] = (         short *)0;
                    sqlstm.sqinds[9] = (         int  )0;
                    sqlstm.sqharm[9] = (unsigned long )0;
                    sqlstm.sqadto[9] = (unsigned short )0;
                    sqlstm.sqtdso[9] = (unsigned short )0;
                    sqlstm.sqhstv[10] = (unsigned char  *)&aihCantidad[iNumServSupl];
                    sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
                    sqlstm.sqhsts[10] = (         int  )0;
                    sqlstm.sqindv[10] = (         short *)0;
                    sqlstm.sqinds[10] = (         int  )0;
                    sqlstm.sqharm[10] = (unsigned long )0;
                    sqlstm.sqadto[10] = (unsigned short )0;
                    sqlstm.sqtdso[10] = (unsigned short )0;
                    sqlstm.sqhstv[11] = (unsigned char  *)&adhImpFacturable[iNumServSupl];
                    sqlstm.sqhstl[11] = (unsigned long )sizeof(double);
                    sqlstm.sqhsts[11] = (         int  )0;
                    sqlstm.sqindv[11] = (         short *)0;
                    sqlstm.sqinds[11] = (         int  )0;
                    sqlstm.sqharm[11] = (unsigned long )0;
                    sqlstm.sqadto[11] = (unsigned short )0;
                    sqlstm.sqtdso[11] = (unsigned short )0;
                    sqlstm.sqhstv[12] = (unsigned char  *)&lhSegConsumido;
                    sqlstm.sqhstl[12] = (unsigned long )sizeof(long);
                    sqlstm.sqhsts[12] = (         int  )0;
                    sqlstm.sqindv[12] = (         short *)0;
                    sqlstm.sqinds[12] = (         int  )0;
                    sqlstm.sqharm[12] = (unsigned long )0;
                    sqlstm.sqadto[12] = (unsigned short )0;
                    sqlstm.sqtdso[12] = (unsigned short )0;
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


    
                if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND) 
                {            
                    vDTrazasLog(szExeInfCtlPreCiclo   , "\t\t**(bfnStatCargosServSupl) Error En Insert Servicios Suplementarios "
                                                        "\n\t\t Error Oracle [%d] [%s]"
                                                        ,LOG01,SQLCODE,SQLERRM);
                    vDTrazasError(szExeInfCtlPreCiclo , "\t\t**(bfnStatCargosServSupl) Error En Insert Servicios Suplementarios "
                                                        "\n\t\t Error Oracle [%d] [%s]"
                                                        ,LOG01,SQLCODE,SQLERRM);
                    return FALSE;
                }
    
            }
        }
        else
        {
            vDTrazasLog(szExeInfCtlPreCiclo   , "\t\t**(bfnStatCargosServSupl) Arreglo de Servicios Suplementarios Sobrepasado"
                                                "\n\t\t Error Oracle [%d] [%s]"
                                                ,LOG01,SQLCODE,SQLERRM);
            vDTrazasError(szExeInfCtlPreCiclo , "\t\t**(bfnStatCargosServSupl) Arreglo de Servicios Suplementarios Sobrepasado"
                                                "\n\t\t Error Oracle [%d] [%s]"
                                                ,LOG01,SQLCODE,SQLERRM);
            return FALSE;
        }
        /* EXEC SQL CLOSE C_CURSOR_CTLCARGOS_SERVSUPL; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 17;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )819;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    }
    vDTrazasLog(szExeInfCtlPreCiclo   ,"\t%s  **(bfnStatCargosServSupl) Cargos Generados [%d] de [%d]", LOG03,cfnGetTime(1),iNumServSupl,iSqlRow);
    return TRUE;
}






/****************************************************************************/
/*  Funcion :   bfnValTipClie                                               */
/****************************************************************************/
BOOL bfnValTipClie( void )
{
    int i=0;
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    char    szhCodPlanTarif[4];
    long    lhCodCliente      ;
    /* EXEC SQL END DECLARE SECTION; */ 

    
    lhCodCliente = stCtlInterAbo.lCodCliente;
    
    /* EXEC SQL    SELECT  COD_PLANTARIF 
                INTO    :szhCodPlanTarif
                FROM    GA_EMPRESA
                WHERE   COD_CLIENTE = :lhCodCliente
                AND     ROWNUM = 1      ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_PLANTARIF into :b0  from GA_EMPRESA where (COD\
_CLIENTE=:b1 and ROWNUM=1)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )834;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodPlanTarif;
    sqlstm.sqhstl[0] = (unsigned long )4;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCliente;
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


        
    if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
        vDTrazasError(szExeInfCtlPreCiclo, "\n\tError en Select GA_EMPRESA (bfnValTipClie)", LOG01);
        return FALSE;
    }
    if(SQLCODE == SQLNOTFOUND)
    {
        sprintf(stCtlInterAbo.szTipClie,"%s\0",COD_TIPCLIENTE_INDIVIDUAL);
        return TRUE;
    }
    sprintf(stCtlInterAbo.szTipClie,"%s\0",COD_TIPCLIENTE_EMPRESA);
    for (i=0;i<iNumRegPlanFamiliar;i++)
    {
        if (strcmp(szCodPlanTarifFamiliar[i],szhCodPlanTarif)==0)
        {
            sprintf(stCtlInterAbo.szTipClie,"%s\0",COD_TIPCLIENTE_FAMILIAR);
            break;
        }
    }
    return TRUE;
}



/****************************************************************************/
/*  Funcion :   bfnValPlanTarif()                                           */
/****************************************************************************/
BOOL bfnValPlanTarif( void )
{
    /* EXEC SQL BEGIN DECLARE SECTION  ; */ 

    char   szhCodPlanTarif[4]       ;/* EXEC SQL VAR szhCodPlanTarif   IS STRING (4); */ 

    char   szhCodCargoBasico[4]     ;/* EXEC SQL VAR szhCodCargoBasico IS STRING (4); */ 

    long   lhCodCliente             ;
    long   lhNumAbonado             ;
    char   szhFecDesde[15]          ;/* EXEC SQL VAR szhFecDesde   IS STRING (15); */ 

    char   szhFecHasta[15]          ;/* EXEC SQL VAR szhFecHasta   IS STRING (15); */ 

    /* EXEC SQL END DECLARE SECTION    ; */ 


    lhCodCliente = stCtlInterAbo.lCodCliente    ;
    lhNumAbonado = stCtlInterAbo.lNumAbonado    ;
    sprintf(szhFecDesde,"%s\0",stLineaComando.szFecDesdeCFijos);
    sprintf(szhFecHasta,"%s\0",stLineaComando.szFecHastaCFijos);

    if ((stCtlInterAbo.iCodProducto == 1) || (stCtlInterAbo.iCodProducto == 5))
    {
        /* EXEC SQL
        SELECT  COD_PLANTARIF       ,
                COD_CARGOBASICO
        INTO    :szhCodPlanTarif    ,
                :szhCodCargoBasico  
        FROM    GA_INTARCEL
        WHERE   COD_CLIENTE = :lhCodCliente
        AND     NUM_ABONADO = :lhNumAbonado
        AND     ((  FEC_DESDE  <= TO_DATE(:szhFecDesde,'YYYYMMDDHH24MISS')  AND
                    FEC_HASTA  >= TO_DATE(:szhFecDesde,'YYYYMMDDHH24MISS'))
            OR   (  FEC_DESDE  <= TO_DATE(:szhFecHasta,'YYYYMMDDHH24MISS')  AND
                    FEC_HASTA  >= TO_DATE(:szhFecHasta,'YYYYMMDDHH24MISS'))
            OR   (  FEC_DESDE  <= TO_DATE(:szhFecDesde,'YYYYMMDDHH24MISS')  AND
                    FEC_HASTA  >= TO_DATE(:szhFecHasta,'YYYYMMDDHH24MISS')))                    
        AND     ROWNUM      = 1; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 17;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select COD_PLANTARIF ,COD_CARGOBASICO into :b0,:b1  f\
rom GA_INTARCEL where (((COD_CLIENTE=:b2 and NUM_ABONADO=:b3) and (((FEC_DESDE\
<=TO_DATE(:b4,'YYYYMMDDHH24MISS') and FEC_HASTA>=TO_DATE(:b4,'YYYYMMDDHH24MISS\
')) or (FEC_DESDE<=TO_DATE(:b6,'YYYYMMDDHH24MISS') and FEC_HASTA>=TO_DATE(:b6,\
'YYYYMMDDHH24MISS'))) or (FEC_DESDE<=TO_DATE(:b4,'YYYYMMDDHH24MISS') and FEC_H\
ASTA>=TO_DATE(:b6,'YYYYMMDDHH24MISS')))) and ROWNUM=1)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )857;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhCodPlanTarif;
        sqlstm.sqhstl[0] = (unsigned long )4;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhCodCargoBasico;
        sqlstm.sqhstl[1] = (unsigned long )4;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCliente;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&lhNumAbonado;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhFecDesde;
        sqlstm.sqhstl[4] = (unsigned long )15;
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)szhFecDesde;
        sqlstm.sqhstl[5] = (unsigned long )15;
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)szhFecHasta;
        sqlstm.sqhstl[6] = (unsigned long )15;
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)szhFecHasta;
        sqlstm.sqhstl[7] = (unsigned long )15;
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)szhFecDesde;
        sqlstm.sqhstl[8] = (unsigned long )15;
        sqlstm.sqhsts[8] = (         int  )0;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)szhFecHasta;
        sqlstm.sqhstl[9] = (unsigned long )15;
        sqlstm.sqhsts[9] = (         int  )0;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
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
    else if (stCtlInterAbo.iCodProducto == 2)
    {
        /* EXEC SQL
        SELECT  COD_PLANTARIF       ,
                COD_CARGOBASICO 
        INTO    :szhCodPlanTarif    ,
                :szhCodCargoBasico
        FROM    GA_INTARBEEP
        WHERE   COD_CLIENTE = :lhCodCliente
        AND     NUM_ABONADO = :lhNumAbonado
        AND     ((  FEC_DESDE  <= TO_DATE(:szhFecDesde,'YYYYMMDDHH24MISS')  AND
                    FEC_HASTA  >= TO_DATE(:szhFecDesde,'YYYYMMDDHH24MISS'))
            OR   (  FEC_DESDE  <= TO_DATE(:szhFecHasta,'YYYYMMDDHH24MISS')  AND
                    FEC_HASTA  >= TO_DATE(:szhFecHasta,'YYYYMMDDHH24MISS'))
            OR   (  FEC_DESDE  <= TO_DATE(:szhFecDesde,'YYYYMMDDHH24MISS')  AND
                    FEC_HASTA  >= TO_DATE(:szhFecHasta,'YYYYMMDDHH24MISS')))                    
        AND     ROWNUM      = 1; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 17;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select COD_PLANTARIF ,COD_CARGOBASICO into :b0,:b1  f\
rom GA_INTARBEEP where (((COD_CLIENTE=:b2 and NUM_ABONADO=:b3) and (((FEC_DESD\
E<=TO_DATE(:b4,'YYYYMMDDHH24MISS') and FEC_HASTA>=TO_DATE(:b4,'YYYYMMDDHH24MIS\
S')) or (FEC_DESDE<=TO_DATE(:b6,'YYYYMMDDHH24MISS') and FEC_HASTA>=TO_DATE(:b6\
,'YYYYMMDDHH24MISS'))) or (FEC_DESDE<=TO_DATE(:b4,'YYYYMMDDHH24MISS') and FEC_\
HASTA>=TO_DATE(:b6,'YYYYMMDDHH24MISS')))) and ROWNUM=1)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )912;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhCodPlanTarif;
        sqlstm.sqhstl[0] = (unsigned long )4;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhCodCargoBasico;
        sqlstm.sqhstl[1] = (unsigned long )4;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCliente;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&lhNumAbonado;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhFecDesde;
        sqlstm.sqhstl[4] = (unsigned long )15;
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)szhFecDesde;
        sqlstm.sqhstl[5] = (unsigned long )15;
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)szhFecHasta;
        sqlstm.sqhstl[6] = (unsigned long )15;
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)szhFecHasta;
        sqlstm.sqhstl[7] = (unsigned long )15;
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)szhFecDesde;
        sqlstm.sqhstl[8] = (unsigned long )15;
        sqlstm.sqhsts[8] = (         int  )0;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)szhFecHasta;
        sqlstm.sqhstl[9] = (unsigned long )15;
        sqlstm.sqhsts[9] = (         int  )0;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
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
    
    if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
        vDTrazasError(szExeInfCtlPreCiclo, "\n\tError en Select GA_INTARCEL/GA_INTARBEEP (bfnValPlanTarif)", LOG01);
        return FALSE;
    }
    if (SQLCODE == SQLNOTFOUND)
    {
        sprintf(stCtlInterAbo.szCodPlanTarif  ,"---\0");
        sprintf(stCtlInterAbo.szCodCargoBasico,"---\0");
    }
    else
    {
        sprintf(stCtlInterAbo.szCodPlanTarif  ,"%s\0",szhCodPlanTarif    );
        sprintf(stCtlInterAbo.szCodCargoBasico,"%s\0",szhCodCargoBasico  );
    }
    return TRUE;
}



/****************************************************************************/
/*  Funcion :   bfnClassCliente()                                           */
/****************************************************************************/
BOOL bfnClassCliente( void )
{
    if (stCtlInterAbo.iIndSupertel == IND_SUPERTELEFONO_ACTIVO)
    {
        stCtlInterAbo.iCodClassCliente= COD_CLASSCLIENTE_STB;
    }
    else if (strcmp(stCtlInterAbo.szTipClie, "F")==0)
    {
        stCtlInterAbo.iCodClassCliente= COD_CLASSCLIENTE_FAMILIAR;
    }
    else if (strcmp(stCtlInterAbo.szTipClie, "E")==0)
    {
        stCtlInterAbo.iCodClassCliente= COD_CLASSCLIENTE_EMPRESA;
    }
    else
    {
        stCtlInterAbo.iCodClassCliente= COD_CLASSCLIENTE_INDIVIDUAL;
    }
    return TRUE;    
}


/****************************************************************************/
/*  Funcion :   bfnClassAbonado()                                           */
/****************************************************************************/
BOOL bfnClassAbonado( void )
{
    switch (stCtlInterAbo.iIndActuac)
    {
        case    IND_ACTUAC_BAJA:
                {
                    if (strcmp(stCtlInterAbo.szFecBaja,stLineaComando.szFecDesdeCFijos) >= 0 &&
                        strcmp(stCtlInterAbo.szFecBaja,stLineaComando.szFecHastaCFijos) <= 0 )
                    {
                        stCtlInterAbo.iCodClassAbonado = COD_CLASSABONADO_BAJAS;
                    }
                    else
                    {
                        stCtlInterAbo.iCodClassAbonado = COD_CLASSABONADO_BAJAS_ANTIGUA;
                    }
                }
                break;
        case    IND_ACTUAC_TRASPASO:
                {
                    if (strcmp(stCtlInterAbo.szFecBaja,stLineaComando.szFecDesdeCFijos) >= 0 &&
                        strcmp(stCtlInterAbo.szFecBaja,stLineaComando.szFecHastaCFijos) <= 0 )
                    {
                        stCtlInterAbo.iCodClassAbonado= COD_CLASSABONADO_TRASPASO;
                    }
                    else
                    {
                        stCtlInterAbo.iCodClassAbonado= COD_CLASSABONADO_TRASPASO_ANTIGUO;
                    }
                }
                break;
        case    IND_ACTUAC_LIQUIDACION:
                {
                    stCtlInterAbo.iCodClassAbonado= COD_CLASSABONADO_LIQUIDACION;
                }
                break;
        case    IND_ACTUAC_RECHAZO:
                {
                    stCtlInterAbo.iCodClassAbonado= COD_CLASSABONADO_RECHAZO;
                }
                break;
        case    IND_ACTUAC_ANULACION_BAJA:
                {
                    stCtlInterAbo.iCodClassAbonado = COD_CLASSABONADO_ANULACION_BAJA;
                }
                break;
        case    IND_ACTUAC_NORMAL:
                {   
                    if (strcmp(stCtlInterAbo.szFecAlta,stLineaComando.szFecDesdeCFijos) > 0 &&
                        strcmp(stCtlInterAbo.szFecAlta,stLineaComando.szFecHastaCFijos) < 0 )
                    {
                        stCtlInterAbo.iCodClassAbonado = COD_CLASSABONADO_NUEVOS;
                    }
                    else if (stCtlInterAbo.iIndBloqueo == IND_BLOQUEADO || stCtlInterAbo.iIndBloqueo == IND_BLOQUEADO_FACTURADO)
                    {
                        stCtlInterAbo.iCodClassAbonado = COD_CLASSABONADO_BLOQUEADOS;
                    }
                    else if (stCtlInterAbo.iCtaControlada == IND_CUENTACONTROLADA_ACTIVO)
                    {
                        stCtlInterAbo.iCodClassAbonado = COD_CLASSABONADO_CTA_CONT;
                    }
                    else if (stCtlInterAbo.iIndCambio == IND_CAMBIOCICLO_ACTIVO)
                    {
                        stCtlInterAbo.iCodClassAbonado = COD_CLASSABONADO_CAMBIO_CICLO;
                    }
                    else
                    {
                        stCtlInterAbo.iCodClassAbonado = COD_CLASSABONADO_ANTIGUOS;
                    }
                }
                break;
    }
    

    switch (stCtlInterAbo.iCodClassAbonado)
    {
        case    COD_CLASSABONADO_BAJAS:
        case    COD_CLASSABONADO_BAJAS_ANTIGUA:
        case    COD_CLASSABONADO_TRASPASO:
        case    COD_CLASSABONADO_TRASPASO_ANTIGUO:
        case    COD_CLASSABONADO_LIQUIDACION:
        case    COD_CLASSABONADO_RECHAZO:
        case    COD_CLASSABONADO_ANULACION_BAJA:
        case    COD_CLASSABONADO_BLOQUEADOS:
                {
                    stCtlInterAbo.iIndEstado = IND_ESTADO_FACTURACION_ABONADO_NO;
                }
                break;
        default:
                {
                    stCtlInterAbo.iIndEstado = IND_ESTADO_FACTURACION_ABONADO_SI;
                }
                break;
    }
    return TRUE;
}




/****************************************************************************/
/*  Funcion :   bfnInsertHeaderInfCtl                                       */
/****************************************************************************/
BOOL bfnInsertHeaderInfCtl( void )
{
    
    /* EXEC SQL BEGIN DECLARE SECTION ; */ 

    char    szhCodInforme   [7] ;/* EXEC SQL VAR szhCodInforme  IS STRING(7); */ 

    long    lhNumSecuInfo       ;
    int     ihIndActivo         ;    
    char    szhFecEmision   [15];/* EXEC SQL VAR szhFecEmision  IS STRING(15); */ 

    char    szhFecPerDesde  [15];/* EXEC SQL VAR szhFecPerDesde IS STRING(15); */ 

    char    szhFecPerHasta  [15];/* EXEC SQL VAR szhFecPerHasta IS STRING(15); */ 

    char    szhCodUsuario   [50];/* EXEC SQL VAR szhCodUsuario  IS STRING(50); */ 

    char    szhCodUsuaSoli  [50];/* EXEC SQL VAR szhCodUsuaSoli IS STRING(50); */ 

    int     ihCodCiclFact       ;
    /* EXEC SQL END DECLARE SECTION ; */ 
    

    vDTrazasLog(szExeInfCtlPreCiclo   ,"\n\t%s**(bfnInsertHeaderInfCtl)",LOG03,cfnGetTime(1));
    
    sprintf(szhCodInforme,"%s\0",szCodInformeGenerar);
    lhNumSecuInfo   = lhNumSecuenciaInforme           ;
    ihCodCiclFact   = stLineaComando.iCodCiclFact          ;    
    ihIndActivo     = COD_INFORME_CONTROL_INACTIVO  ;
    sprintf(szhFecEmision  ,"%s\0",stLineaComando.szFecEmision     );
    sprintf(szhFecPerDesde ,"%s\0",stLineaComando.szFecDesdeCFijos );
    sprintf(szhFecPerHasta ,"%s\0",stLineaComando.szFecHastaCFijos );
    


    /****************************************************************************/
    /*  Actualiza Informe Anterior de Facturacion de Ciclo Como Inactivos.      */
    /****************************************************************************/
    vDTrazasLog(szExeInfCtlPreCiclo   ,"\n\t\t**(bfnInsertHeaderInfCtl) Actualiza Informe Anterior como Inactivo"
                                    "\n\t\t** Cod. Informe          [%s]"
                                    "\n\t\t** Codigo Ciclo Factur.  [%d]"
                                    "\n\t\t** Ind. Activo           [%d]"
                                    ,LOG03
                                    ,szhCodInforme  
                                    ,ihCodCiclFact  
                                    ,COD_INFORME_CONTROL_INACTIVO);
    /* EXEC SQL 
        UPDATE  FAD_CTLINFHEADER
        SET     IND_ACTIVO  = :ihIndActivo
        WHERE   COD_INFORME = :szhCodInforme
        AND     COD_CICLFACT= :ihCodCiclFact; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update FAD_CTLINFHEADER  set IND_ACTIVO=:b0 where (COD_IN\
FORME=:b1 and COD_CICLFACT=:b2)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )967;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihIndActivo;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodInforme;
    sqlstm.sqhstl[1] = (unsigned long )7;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihCodCiclFact;
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



    if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND) 
    {            
        vDTrazasLog(szExeInfCtlPreCiclo   ,"\t\t**(bfnInsertHeaderInfCtl) Error En Update de Header de Informe"
                                         "\n\t\t Error Oracle [%d] [%s]"
                                        ,LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }

    /****************************************************************************/
    /*  Genera Nuevo registro Header de Informe de Facturacion de Ciclo         */
    /****************************************************************************/

    ihIndActivo     = COD_INFORME_CONTROL_ACTIVO            ;
    sprintf(szhCodUsuario  ,"%s\0",stLineaComando.szUser    );
    sprintf(szhCodUsuaSoli ,"%s\0",stLineaComando.szUser    );


    vDTrazasLog(szExeInfCtlPreCiclo   ,"\n\t\t**(bfnInsertHeaderInfCtl)"
                                    "\n\t\t** Cod. Informe          [%s]"
                                    "\n\t\t** Secuencia Infortme    [%d]"
                                    "\n\t\t** Ind. Activo           [%d]"
                                    "\n\t\t** Fec. Emision          [%s]"
                                    "\n\t\t** Fec. Periodo Desde    [%s]"
                                    "\n\t\t** Fec. Periodo Hasta    [%s]"
                                    "\n\t\t** Usuario Generador     [%s]"
                                    "\n\t\t** Usuario Solicitante   [%s]"
                                    "\n\t\t** Codigo Ciclo Factur.  [%ld]"
                                    ,LOG03
                                    ,szhCodInforme  
                                    ,lhNumSecuInfo  
                                    ,ihIndActivo    
                                    ,szhFecEmision  
                                    ,szhFecPerDesde 
                                    ,szhFecPerHasta 
                                    ,szhCodUsuario  
                                    ,szhCodUsuaSoli 
                                    ,ihCodCiclFact  );

    /* EXEC SQL INSERT INTO FAD_CTLINFHEADER(
                COD_INFORME    ,
                NUM_SECUINFO   ,
                IND_ACTIVO     ,
                FEC_EMISION    ,
                FEC_PERDESDE   ,
                FEC_PERHASTA   ,
                COD_USUAGEN    ,
                COD_USUASOL    ,
                COD_CICLFACT   )        
    VALUES (    :szhCodInforme  ,
                :lhNumSecuInfo  ,
                :ihIndActivo    ,
                SYSDATE         ,
                TO_DATE(:szhFecPerDesde ,'YYYYMMDDHH24MISS'),
                TO_DATE(:szhFecPerHasta ,'YYYYMMDDHH24MISS'),
                :szhCodUsuario  ,
                :szhCodUsuaSoli ,
                :ihCodCiclFact  ); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into FAD_CTLINFHEADER (COD_INFORME,NUM_SECUINFO,IN\
D_ACTIVO,FEC_EMISION,FEC_PERDESDE,FEC_PERHASTA,COD_USUAGEN,COD_USUASOL,COD_CIC\
LFACT) values (:b0,:b1,:b2,SYSDATE,TO_DATE(:b3,'YYYYMMDDHH24MISS'),TO_DATE(:b4\
,'YYYYMMDDHH24MISS'),:b5,:b6,:b7)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )994;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodInforme;
    sqlstm.sqhstl[0] = (unsigned long )7;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSecuInfo;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihIndActivo;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhFecPerDesde;
    sqlstm.sqhstl[3] = (unsigned long )15;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhFecPerHasta;
    sqlstm.sqhstl[4] = (unsigned long )15;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhCodUsuario;
    sqlstm.sqhstl[5] = (unsigned long )50;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)szhCodUsuaSoli;
    sqlstm.sqhstl[6] = (unsigned long )50;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&ihCodCiclFact;
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


                 
    if (SQLCODE) 
    {            
        vDTrazasLog(szExeInfCtlPreCiclo   ,"\t\t**(bfnInsertHeaderInfCtl) Error En Insert de Header de Informe"
                                         "\n\t\t Error Oracle [%d] [%s]"
                                        ,LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }
    return TRUE;
}




/****************************************************************************/
/*  Funcion :   bfnGetSecuInfo Selecciona Numero de Secuencia de Informe    */
/****************************************************************************/
BOOL bfnGetSecuInfo ( void )
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    int     ihCodTipInforme ;
    long    lhNumSecuInfo   ;
    char    szhCodInformeGenerar[7];/* EXEC SQL VAR szhCodInformeGenerar IS STRING (7); */ 

    /* EXEC SQL END DECLARE SECTION; */ 


    if (stLineaComando.iIndFacturacion == iIND_FACT_NOPROCESADO)
    {
        ihCodTipInforme = COD_INFORME_FAD_CTL_PRE_CICLO;
    }
    else if (stLineaComando.iIndFacturacion == iIND_FACT_ENPROCESO)
    {
        ihCodTipInforme  = COD_INFORME_FAD_CTL_PST_CICLO;
    }
    else if (stLineaComando.iIndFacturacion == iIND_FACT_TERMINADO)
    {
        ihCodTipInforme = COD_INFORME_FAD_CTL_PST_CICLO;
    }


    /* EXEC SQL
        SELECT  FA_SEQ_CTLINFORMES.NEXTVAL 
        INTO    :lhNumSecuInfo 
        FROM DUAL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select FA_SEQ_CTLINFORMES.nextval  into :b0  from DUAL ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1041;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSecuInfo;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
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



    if(SQLCODE != SQLOK)
    {

        vDTrazasError(szExeInfCtlPreCiclo, "\n\n\tError en lhNumSecuInfo"
                                        "\n\t\t Error [%d] [%s]"
                                        , LOG01, SQLCODE, SQLERRM);
        return FALSE;
    }
    lhNumSecuenciaInforme = lhNumSecuInfo;

    /* EXEC SQL
        SELECT  COD_INFORME 
        INTO    :szhCodInformeGenerar
        FROM    FAD_CTLINFOPARAM 
        WHERE   COD_TIPINFORME = :ihCodTipInforme; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_INFORME into :b0  from FAD_CTLINFOPARAM where \
COD_TIPINFORME=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1060;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodInformeGenerar;
    sqlstm.sqhstl[0] = (unsigned long )7;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCodTipInforme;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
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



    if(SQLCODE != SQLOK)
    {
        vDTrazasError(szExeInfCtlPreCiclo, "\n\n\tError en szhCodInformeGenerar"
                                        "\n\t\t Error [%d] [%s]"
                                        , LOG01, SQLCODE, SQLERRM);
        return FALSE;
    }
    sprintf(szCodInformeGenerar,"%s\0",szhCodInformeGenerar);
    vDTrazasLog (szExeInfCtlPreCiclo, "\n\t\t Informe  de Control [%s]"
                                    "\n\t\t Secuencia Informe   [%ld]"
                                    , LOG03, szCodInformeGenerar, lhNumSecuenciaInforme);
    return TRUE;
}



/****************************************************************************/
/*  Funcion :   bfnEstadoProcCiclo                                          */
/****************************************************************************/
BOOL bfnEstadoProcCiclo( void )
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    int     ihIndFacturacion        ;
    int     ihCodCiclFact           ;
    int     ihCodCiclo              ;
    char    szhFecEmision[15]       ;/* EXEC SQL VAR szhFecEmision     IS STRING (15); */ 

    char    szhFecDesdeCFijos[15]   ;/* EXEC SQL VAR szhFecDesdeCFijos IS STRING (15); */ 

    char    szhFecHastaCFijos[15]   ;/* EXEC SQL VAR szhFecHastaCFijos IS STRING (15); */ 

    int     ihTipoTasacion; /* SAAM-20030106 */
    /* EXEC SQL END DECLARE SECTION; */ 


    ihCodCiclFact = stLineaComando.iCodCiclFact;
    
    /* EXEC SQL    SELECT  IND_FACTURACION                         ,
                        COD_CICLO                               ,
                        TO_CHAR(FEC_EMISION,'YYYYMMDDHH24MISS') ,
                        TO_CHAR(FEC_DESDECFIJOS,'YYYYMMDDHH24MISS') ,
                        TO_CHAR(FEC_HASTACFIJOS,'YYYYMMDDHH24MISS') ,
                        IND_TASADOR /o SAAM-20030106 o/
                INTO    :ihIndFacturacion   ,
                        :ihCodCiclo         ,
                        :szhFecEmision      ,
                        :szhFecDesdeCFijos  ,
                        :szhFecHastaCFijos  ,
                        :ihTipoTasacion /o SAAM-20030106 o/
                    FROM    FA_CICLFACT
                WHERE   COD_CICLFACT = :ihCodCiclFact; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select IND_FACTURACION ,COD_CICLO ,TO_CHAR(FEC_EMISION,'Y\
YYYMMDDHH24MISS') ,TO_CHAR(FEC_DESDECFIJOS,'YYYYMMDDHH24MISS') ,TO_CHAR(FEC_HA\
STACFIJOS,'YYYYMMDDHH24MISS') ,IND_TASADOR into :b0,:b1,:b2,:b3,:b4,:b5  from \
FA_CICLFACT where COD_CICLFACT=:b6";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1083;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihIndFacturacion;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCodCiclo;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhFecEmision;
    sqlstm.sqhstl[2] = (unsigned long )15;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhFecDesdeCFijos;
    sqlstm.sqhstl[3] = (unsigned long )15;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhFecHastaCFijos;
    sqlstm.sqhstl[4] = (unsigned long )15;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihTipoTasacion;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&ihCodCiclFact;
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


    
    if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
        vDTrazasError(szExeInfCtlPreCiclo, "\n\tError en Select en FA_CICLFACT (bfnEstadoProcCiclo)", LOG01);
        return FALSE;
    }
    if(SQLCODE == SQLNOTFOUND)
    {
        vDTrazasError(szExeInfCtlPreCiclo, "\n\tCodigo de Ciclo de Facturacion No Valido (bfnEstadoProcCiclo)", LOG01);
        return FALSE;
    }
    stLineaComando.iIndFacturacion          = ihIndFacturacion          ;
    stLineaComando.iCodCiclo                = ihCodCiclo                ;
    sprintf(stLineaComando.szFecEmision     ,"%s\0",szhFecEmision      );
    sprintf(stLineaComando.szFecDesdeCFijos ,"%s\0",szhFecDesdeCFijos  );
    sprintf(stLineaComando.szFecHastaCFijos ,"%s\0",szhFecHastaCFijos  );
    stLineaComando.iTipoTasacion = ihTipoTasacion;
    return TRUE;
}



/****************************************************************************/
/*  Funcion :   bfnCargaCargosBasicos                                       */
/****************************************************************************/
BOOL bfnCargaCargosBasicos( void )
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    int     aihCodProducto       [MAX_REG_CARGOBASICO];
    /* VARCHAR aszhCodCargoBasico   [MAX_REG_CARGOBASICO][4]; */ 
struct { unsigned short len; unsigned char arr[6]; } aszhCodCargoBasico[3000];

    double  adhImporteCBasico    [MAX_REG_CARGOBASICO];
    /* VARCHAR aszhCodMoneda        [MAX_REG_CARGOBASICO][4]; */ 
struct { unsigned short len; unsigned char arr[6]; } aszhCodMoneda[3000];

    /* EXEC SQL END DECLARE SECTION; */ 

    
    char    szhFecEmision [15]  ;/* EXEC SQL VAR szhFecEmision IS STRING (15); */ 

    int     iNumRegCBasico  ;

    memset(&stTaCargosBasico ,0,sizeof(TACARGOSBASICO));
    sprintf(szhFecEmision  ,"%s\0",stLineaComando.szFecEmision     );    



    /* EXEC SQL    
    SELECT  COD_PRODUCTO        ,
            COD_CARGOBASICO     ,
            IMP_CARGOBASICO     ,
            COD_MONEDA          
    INTO    :aihCodProducto     ,
            :aszhCodCargoBasico ,
            :adhImporteCBasico  ,
            :aszhCodMoneda      
    FROM    TA_CARGOSBASICO 
    WHERE   ( TO_DATE(:szhFecEmision,'YYYYMMDDHH24MISS')
                BETWEEN FEC_DESDE AND 
                        FEC_HASTA OR 
                        FEC_HASTA IS NULL); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_PRODUCTO ,COD_CARGOBASICO ,IMP_CARGOBASICO ,CO\
D_MONEDA into :b0,:b1,:b2,:b3  from TA_CARGOSBASICO where (TO_DATE(:b4,'YYYYMM\
DDHH24MISS') between FEC_DESDE and FEC_HASTA or FEC_HASTA is null )";
    sqlstm.iters = (unsigned int  )3000;
    sqlstm.offset = (unsigned int  )1126;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)aihCodProducto;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )sizeof(int);
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)aszhCodCargoBasico;
    sqlstm.sqhstl[1] = (unsigned long )6;
    sqlstm.sqhsts[1] = (         int  )8;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)adhImporteCBasico;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[2] = (         int  )sizeof(double);
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)aszhCodMoneda;
    sqlstm.sqhstl[3] = (unsigned long )6;
    sqlstm.sqhsts[3] = (         int  )8;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqharc[3] = (unsigned long  *)0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhFecEmision;
    sqlstm.sqhstl[4] = (unsigned long )15;
    sqlstm.sqhsts[4] = (         int  )15;
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



    if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
        vDTrazasError(szExeInfCtlPreCiclo,  "\n\tError en Select TA_CARGOSBASICO (bfnCargaCargosBasicos)"
                                            "\n\t\t Error Oracle [%d] [%s]"
                                            ,LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }

    if(SQLCODE == SQLNOTFOUND)
    {
        for (iNumRegCBasico = 0; iNumRegCBasico < SQLROWS; iNumRegCBasico++)
        {
            stTaCargosBasico.stCBasico[iNumRegCBasico].iCodProducto = 
                            aihCodProducto[iNumRegCBasico];

            sprintf(stTaCargosBasico.stCBasico[iNumRegCBasico].szCodCargoBasico,
                    "%.*s\0" , aszhCodCargoBasico[iNumRegCBasico].len , aszhCodCargoBasico[iNumRegCBasico].arr );

            stTaCargosBasico.stCBasico[iNumRegCBasico].dImpCarboBasico =
                            adhImporteCBasico[iNumRegCBasico];

            sprintf(stTaCargosBasico.stCBasico[iNumRegCBasico].szCodMoneda,
                    "%.*s\0" , aszhCodMoneda[iNumRegCBasico].len,aszhCodMoneda[iNumRegCBasico].arr);
                    
            stTaCargosBasico.iNumStadisticas++;
            
            vDTrazasLog(szExeInfCtlPreCiclo   ,"\t Cargo Basico  [%d][%s][%.f][%s]"
                                            ,LOG03
                                            ,stTaCargosBasico.stCBasico[iNumRegCBasico].iCodProducto
                                            ,stTaCargosBasico.stCBasico[iNumRegCBasico].szCodCargoBasico
                                            ,stTaCargosBasico.stCBasico[iNumRegCBasico].dImpCarboBasico
                                            ,stTaCargosBasico.stCBasico[iNumRegCBasico].szCodMoneda );
        }
        return TRUE;
    }
    vDTrazasError(szExeInfCtlPreCiclo, "\n\tDesbordamiento de Arreglo de Cargos Basicos ", LOG01);
    return FALSE;
}




/****************************************************************************/
/*  Funcion :   bfnCargaPlanFamiliar                                        */
/****************************************************************************/
BOOL bfnCargaPlanFamiliar( void )
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    char    szhCodPlanTarif[MAX_REGPLAN_FAMILIAR][4];
    /* EXEC SQL END DECLARE SECTION; */ 

    
    /* EXEC SQL    SELECT  COD_PLANTARIF 
                INTO    :szhCodPlanTarif
                FROM    TA_PLANTARIF
                WHERE   IND_FAMILIAR = 1; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_PLANTARIF into :b0  from TA_PLANTARIF where IN\
D_FAMILIAR=1";
    sqlstm.iters = (unsigned int  )1000;
    sqlstm.offset = (unsigned int  )1161;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodPlanTarif;
    sqlstm.sqhstl[0] = (unsigned long )4;
    sqlstm.sqhsts[0] = (         int  )4;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
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



    if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
        vDTrazasError(szExeInfCtlPreCiclo, "\n\tError en Select TA_PLANTARIF (bfnCargaPlanFamiliar)", LOG01);
        return FALSE;
    }
    if(SQLCODE == SQLNOTFOUND)
    {
        for (iNumRegPlanFamiliar = 0; iNumRegPlanFamiliar < SQLROWS; iNumRegPlanFamiliar++)
        {
            sprintf(szCodPlanTarifFamiliar[iNumRegPlanFamiliar],"%s\0",szhCodPlanTarif[iNumRegPlanFamiliar]);
            
            vDTrazasLog(szExeInfCtlPreCiclo   ,"\t PLAN TARIFARIO FAMILIAR [%d][%s]"
                                            ,LOG04
                                            ,iNumRegPlanFamiliar
                                            ,szhCodPlanTarif[iNumRegPlanFamiliar]);
        }
        return TRUE;
    }
    vDTrazasError(szExeInfCtlPreCiclo, "\n\tDesbordamiento de Arreglo de PLantes Tarifarios Familiar", LOG01);
    return FALSE;
}




/****************************************************************************/
/*  Funcion :   bfnCargaMonedas                                             */
/****************************************************************************/
BOOL bfnCargaMonedas( void )
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    char    szhCodMoneda[4] ;   /* EXEC SQL VAR szhCodMoneda IS STRING (4); */ 

    double  dhValorUF    = 0;
    double  dhValorDolar = 0;
    /* EXEC SQL END DECLARE SECTION; */ 

    char    szhFecEmision [15]  ;/* EXEC SQL VAR szhFecEmision IS STRING (15); */ 

    sprintf(szhFecEmision  ,"%s\0",stLineaComando.szFecEmision     );    
    
    sprintf(szhCodMoneda,"002\0");    /*  Dolar */

    /* EXEC SQL    SELECT  CAMBIO 
                INTO    :dhValorDolar
                FROM    GE_CONVERSION
                WHERE   COD_MONEDA = :szhCodMoneda
                AND     ( TO_DATE(TO_CHAR(TO_DATE(:szhFecEmision,'YYYYMMDDHH24MISS'),'YYYYMM') || '01','YYYYMMDD')
                               BETWEEN FEC_DESDE AND FEC_HASTA OR 
                                    FEC_HASTA IS NULL); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select CAMBIO into :b0  from GE_CONVERSION where (COD_MON\
EDA=:b1 and (TO_DATE((TO_CHAR(TO_DATE(:b2,'YYYYMMDDHH24MISS'),'YYYYMM')||'01')\
,'YYYYMMDD') between FEC_DESDE and FEC_HASTA or FEC_HASTA is null ))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1180;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&dhValorDolar;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodMoneda;
    sqlstm.sqhstl[1] = (unsigned long )4;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhFecEmision;
    sqlstm.sqhstl[2] = (unsigned long )15;
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



                

    if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
        vDTrazasError(szExeInfCtlPreCiclo, "\n\tError en Select GE_CONVERSION-Dolar(bfnCargaMonedas)", LOG01);
        return FALSE;
    }

    if(SQLCODE == SQLNOTFOUND)
    {
        /* EXEC SQL    
                SELECT  CAMBIO 
                INTO    :dhValorDolar
                FROM    GE_CONVERSION
                WHERE   COD_MONEDA = :szhCodMoneda
                AND     FEC_DESDE   = ( SELECT  MAX(FEC_DESDE) 
                                        FROM    GE_CONVERSION
                                        WHERE   COD_MONEDA = :szhCodMoneda); */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 17;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select CAMBIO into :b0  from GE_CONVERSION where (COD\
_MONEDA=:b1 and FEC_DESDE=(select max(FEC_DESDE)  from GE_CONVERSION where COD\
_MONEDA=:b1))";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1207;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&dhValorDolar;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhCodMoneda;
        sqlstm.sqhstl[1] = (unsigned long )4;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhCodMoneda;
        sqlstm.sqhstl[2] = (unsigned long )4;
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


        if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
        {
            vDTrazasError(szExeInfCtlPreCiclo, "\n\tError en Select GE_CONVERSION-Dolar(2)(bfnCargaMonedas)", LOG01);
            return FALSE;
        }
    }


    sprintf(szhCodMoneda,"003\0");  /*  U.F.  */

    /* EXEC SQL    SELECT  CAMBIO 
                INTO    :dhValorUF
                FROM    GE_CONVERSION
                WHERE   COD_MONEDA = :szhCodMoneda
                AND     ( TO_DATE(TO_CHAR(TO_DATE(:szhFecEmision,'YYYYMMDDHH24MISS'),'YYYYMM') || '01','YYYYMMDD')
                               BETWEEN FEC_DESDE AND FEC_HASTA OR 
                                    FEC_HASTA IS NULL); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select CAMBIO into :b0  from GE_CONVERSION where (COD_MON\
EDA=:b1 and (TO_DATE((TO_CHAR(TO_DATE(:b2,'YYYYMMDDHH24MISS'),'YYYYMM')||'01')\
,'YYYYMMDD') between FEC_DESDE and FEC_HASTA or FEC_HASTA is null ))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1234;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&dhValorUF;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodMoneda;
    sqlstm.sqhstl[1] = (unsigned long )4;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhFecEmision;
    sqlstm.sqhstl[2] = (unsigned long )15;
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



    if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
        vDTrazasError(szExeInfCtlPreCiclo, "\n\tError en Select GE_CONVERSION-U.F. (bfnCargaMonedas)", LOG01);
        return FALSE;
    }
        if(SQLCODE == SQLNOTFOUND)
    {
        /* EXEC SQL    
                SELECT  CAMBIO 
                INTO    :dhValorUF
                FROM    GE_CONVERSION
                WHERE   COD_MONEDA = :szhCodMoneda
                AND     FEC_DESDE   = ( SELECT  MAX(FEC_DESDE) 
                                        FROM    GE_CONVERSION
                                        WHERE   COD_MONEDA = :szhCodMoneda); */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 17;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select CAMBIO into :b0  from GE_CONVERSION where (COD\
_MONEDA=:b1 and FEC_DESDE=(select max(FEC_DESDE)  from GE_CONVERSION where COD\
_MONEDA=:b1))";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1261;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&dhValorUF;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhCodMoneda;
        sqlstm.sqhstl[1] = (unsigned long )4;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhCodMoneda;
        sqlstm.sqhstl[2] = (unsigned long )4;
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


        if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
        {
            vDTrazasError(szExeInfCtlPreCiclo, "\n\tError en Select GE_CONVERSION-UF (2)(bfnCargaMonedas)", LOG01);
            return FALSE;
        }
    }
    vDTrazasLog(szExeInfCtlPreCiclo ,"\t\t ** Valores de Monedas "
                                     "\n\t\t==> Valor Dolar   [%.f]"
                                     "\n\t\t==> Valor U.F.    [%.f]"
                                    ,LOG03
                                    ,dhValorDolar
                                    ,dhValorUF     );
                                    
    dValorCTLDolar  = dhValorDolar  ;
    dValorCTLUF     = dhValorUF     ;
    return TRUE;
}



/****************************************************************************/
/*  Funcion :   dfnValorCBasico                                            */
/****************************************************************************/
double dfnValorCBasico(char *szCBas,int iCodProducto)
{
    int i;
    double dValorCambio;
    
    for (i= 0; i < stTaCargosBasico.iNumStadisticas; i++)
    {
        if ((strcmp(stTaCargosBasico.stCBasico[i].szCodCargoBasico,szCBas)==0            )  && 
                   (stTaCargosBasico.stCBasico[i].iCodProducto            == iCodProducto))
        {
            if (strcmp(stTaCargosBasico.stCBasico[i].szCodMoneda,"002") == 0)
            {
                dValorCambio = dValorCTLDolar;
            }
            else if (strcmp(stTaCargosBasico.stCBasico[i].szCodMoneda,"003") == 0)
            {
                dValorCambio = dValorCTLUF   ;
            }
            else
            {
                dValorCambio = 1;
            }
            return (stTaCargosBasico.stCBasico[i].dImpCarboBasico*dValorCambio);
        }
    }
    return (0.0);
}




/****************************************************************************/
/*  Funcion :   vPrintStAbonados                                            */
/****************************************************************************/
void vPrintStAbonados( void )
{
    vDTrazasLog(szExeInfCtlPreCiclo,
            "\n\t\t**(vPrintStAbonados) Valores de Interfaz Abonado "
            "\n\t\t** Row Id            [%s]"
            "\n\t\t** Cod. Cliente      [%ld]"
            "\n\t\t** Num. Abonado      [%ld]"
            "\n\t\t** Cod. Producto     [%d]" 
            "\n\t\t** Ind. Cambio       [%d]" 
            "\n\t\t** Cod. CiclFact     [%ld]"
            "\n\t\t** Fecha Alta        [%s]" 
            "\n\t\t** Fecha Baja        [%s]" 
            "\n\t\t** Ind. Actuac       [%d]" 
            "\n\t\t** Ind. Supertel     [%d]" 
            "\n\t\t** Ind. Factur       [%d]" 
            "\n\t\t** Ind. Bloqueo      [%d]" 
            "\n\t\t** Cod. Empresa      [%ld]"
            "\n\t\t** Tipo Cliente      [%s]" 
            "\n\t\t** Plan Tarifario    [%s]" 
            "\n\t\t** Cargo Basico      [%s]" 
            "\n\t\t** Clase Cliente     [%d]" 
            "\n\t\t** Clase Abonado     [%d]" 
            "\n\t\t** Ind. Estado Fact. [%d]" 
            ,LOG05
            ,stCtlInterAbo.szRowId
            ,stCtlInterAbo.lCodCliente
            ,stCtlInterAbo.lNumAbonado
            ,stCtlInterAbo.iCodProducto
            ,stCtlInterAbo.iIndCambio  
            ,stCtlInterAbo.iCodCiclFact
            ,stCtlInterAbo.szFecAlta   
            ,stCtlInterAbo.szFecBaja   
            ,stCtlInterAbo.iIndActuac  
            ,stCtlInterAbo.iIndSupertel
            ,stCtlInterAbo.iIndFactur  
            ,stCtlInterAbo.iIndBloqueo 
            ,stCtlInterAbo.lCodEmpresa 
            ,stCtlInterAbo.szTipClie
            ,stCtlInterAbo.szCodPlanTarif  
            ,stCtlInterAbo.szCodCargoBasico
            ,stCtlInterAbo.iCodClassCliente
            ,stCtlInterAbo.iCodClassAbonado
            ,stCtlInterAbo.iIndEstado);
}


/****************************************************************************/
/*  Funcion :   vPrintStCartera                                             */
/****************************************************************************/
void vPrintStCartera( void )
{
    int iStat=0;
    for (iStat=0;iStat<stStatInterAbon.iNumStadisticas;iStat++)
    {
        vDTrazasLog(szExeInfCtlPreCiclo,
            "\n\t\t**(vPrintStCartera) Estadisticas de Cartera de Clientes"
            "\n\t\t** Cod. Producto         [%d]"
            "\n\t\t** Cod. CiclFact         [%d]"
            "\n\t\t** Cod. Class.Cliente    [%ld]"
            "\n\t\t** Cod. Class.Abonado    [%ld]"
            "\n\t\t** Cantidad Abonados     [%d]"
            ,LOG05                                 
            ,stStatInterAbon.stUnivStatInterAbo[iStat].iCodProducto
            ,stStatInterAbon.stUnivStatInterAbo[iStat].iCodCiclFact
            ,stStatInterAbon.stUnivStatInterAbo[iStat].iCodClassCliente
            ,stStatInterAbon.stUnivStatInterAbo[iStat].iCodClassAbonado
            ,stStatInterAbon.stUnivStatInterAbo[iStat].iNumAbonados );
    }
}

/****************************************************************************/
/*  Funcion :   vPrintStCBasicos                                            */
/****************************************************************************/
void vPrintStCBasicos( void )
{
    int iStat=0;
    for (iStat=0;iStat<stStatCargoBasico.iNumStadisticas;iStat++)
    {
        vDTrazasLog(szExeInfCtlPreCiclo,
            "\n\t\t**(vPrintStCBasicos) Estadisticas de Cargos Basicos"
            "\n\t\t[%d]** Codigo Producto           [%ld]"
            "\n\t\t[%d]** Codigo Cargo Basico       [%s]"
            "\n\t\t[%d]** Cantidad  Cargos Basicos  [%ld]"
            "\n\t\t[%d]** Cantidad Abonados         [%d]"
            ,LOG03
            ,iStat,stStatCargoBasico.stUnivStatCBas[iStat].iCodProducto
            ,iStat,stStatCargoBasico.stUnivStatCBas[iStat].szCodCargoBasico
            ,iStat,stStatCargoBasico.stUnivStatCBas[iStat].iNumCargosBasicos
            ,iStat,stStatCargoBasico.stUnivStatCBas[iStat].iNumAbonados);
    }
}

/****************************************************************************/
/*  Funcion :   bCargaCodCBasicos                                           */
/****************************************************************************/
BOOL  bCargaCodCBasicos( void )
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long lhCodAbonoCel;
        long lhCodAbonoBeep;
    /* EXEC SQL END DECLARE SECTION; */ 

    
    /* EXEC SQL
        SELECT COD_ABONOCEL,
               COD_ABONOBEEP INTO
               :lhCodAbonoCel,
               :lhCodAbonoBeep
        FROM FA_DATOSGENER; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_ABONOCEL ,COD_ABONOBEEP into :b0,:b1  from FA_\
DATOSGENER ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1288;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCodAbonoCel;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhCodAbonoBeep;
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


               
    if(SQLCODE != SQLOK )
    {
        vDTrazasError(szExeInfCtlPreCiclo, "\n\tError en Select FA_DATOSGENER", LOG01);
        return FALSE;
    }

    stCodCargosBasicos.lCodAbonoCel  = lhCodAbonoCel;
    stCodCargosBasicos.lCodAbonoBeep = lhCodAbonoBeep;
    return TRUE;
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

