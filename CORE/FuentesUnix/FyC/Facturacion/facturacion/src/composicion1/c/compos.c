
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
           char  filnam[15];
};
static const struct sqlcxp sqlfpn =
{
    14,
    "./pc/compos.pc"
};


static unsigned int sqlctx = 862947;


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
   unsigned char  *sqhstv[60];
   unsigned long  sqhstl[60];
            int   sqhsts[60];
            short *sqindv[60];
            int   sqinds[60];
   unsigned long  sqharm[60];
   unsigned long  *sqharc[60];
   unsigned short  sqadto[60];
   unsigned short  sqtdso[60];
} sqlstm = {12,60};

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

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,331,0,4,47,0,0,3,2,0,1,0,2,97,0,0,1,97,0,0,1,97,0,0,
32,0,0,2,67,0,4,569,0,0,1,0,0,1,0,2,5,0,0,
51,0,0,3,138,0,5,776,0,0,4,4,0,1,0,1,4,0,0,1,97,0,0,1,3,0,0,1,3,0,0,
82,0,0,4,112,0,5,785,0,0,3,3,0,1,0,1,4,0,0,1,97,0,0,1,3,0,0,
109,0,0,5,136,0,5,800,0,0,3,3,0,1,0,1,4,0,0,1,97,0,0,1,3,0,0,
136,0,0,6,402,0,4,839,0,0,6,5,0,1,0,1,3,0,0,2,4,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,
3,0,0,
175,0,0,7,0,0,17,1073,0,0,1,1,0,1,0,1,97,0,0,
194,0,0,7,0,0,21,1085,0,0,57,57,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
1,4,0,0,1,4,0,0,1,4,0,0,1,4,0,0,1,4,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,
0,0,1,4,0,0,1,4,0,0,1,4,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,
3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,3,
0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,
4,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,4,0,0,1,
97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
437,0,0,7,0,0,21,1118,0,0,60,60,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
1,4,0,0,1,4,0,0,1,4,0,0,1,4,0,0,1,4,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,
0,0,1,4,0,0,1,4,0,0,1,4,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,
3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,3,
0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,
4,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,4,0,0,1,
97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
692,0,0,8,126,0,4,1561,0,0,2,1,0,1,0,2,5,0,0,1,3,0,0,
715,0,0,9,0,0,17,1796,0,0,1,1,0,1,0,1,97,0,0,
734,0,0,9,0,0,21,1807,0,0,30,30,0,1,0,1,97,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,0,
0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,
0,0,1,97,0,0,1,97,0,0,1,4,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,
97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
869,0,0,10,147,0,4,2352,0,0,3,2,0,1,0,2,4,0,0,1,3,0,0,1,3,0,0,
896,0,0,11,0,0,17,2449,0,0,1,1,0,1,0,1,97,0,0,
915,0,0,11,0,0,21,2535,0,0,24,24,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,5,0,0,1,4,0,0,1,4,0,0,1,4,0,0,1,4,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,5,0,
0,1,5,0,0,1,5,0,0,1,4,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,
1026,0,0,11,0,0,21,2584,0,0,24,24,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,
0,1,5,0,0,1,4,0,0,1,4,0,0,1,4,0,0,1,4,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,5,
0,0,1,5,0,0,1,5,0,0,1,4,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,
1137,0,0,12,0,0,17,3001,0,0,1,1,0,1,0,1,97,0,0,
1156,0,0,12,0,0,21,3067,0,0,52,52,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,
0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,4,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,4,0,0,1,3,0,
0,1,4,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,
0,0,1,97,0,0,1,97,0,0,1,4,0,0,1,4,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,4,0,0,1,4,0,0,1,3,
0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,4,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,4,0,0,
1379,0,0,12,0,0,21,3247,0,0,52,52,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,
0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,4,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,4,0,0,1,3,0,
0,1,4,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,
0,0,1,97,0,0,1,97,0,0,1,4,0,0,1,4,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,4,0,0,1,4,0,0,1,3,
0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,4,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,4,0,0,
1602,0,0,13,144,0,4,3483,0,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,
1629,0,0,14,377,0,4,3519,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
1652,0,0,15,224,0,4,3583,0,0,7,4,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,1,5,0,0,1,3,0,0,
1,3,0,0,1,3,0,0,
};


/****************************************************************************/
/* Fichero    : compos.pc                                                   */
/* Descripcio : funciones para el paso a Historicos de los datos facturados */
/* Autor      : Mauricio Villagra Villalobos                                */
/* Fecha      : 09-08-1999                                                  */
/*              Modificación para Insertar facturas y detalle en nuevas     */
/*              tablas de proceso, FA_FACTDOCU_CICLO, FA_FACTCLIE_CICLO,    */
/*              FA_FACTABON_CICLO; FA_FACTCONC_CICLO. (MVV)                 */
/****************************************************************************/
#define _COMPOSICION_PC_

#include <compos.h>
#include <New_ImpreOnline.h> 

/* EXEC SQL INCLUDE sqlca;
 */ 
/*
 * $Header: sqlca.h 24-apr-2003.12:50:58 mkandarp Exp $ sqlca.h 
 */

/* Copyright (c) 1985, 2003, Oracle Corporation.  All rights reserved.  */
 
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
 * $Header: sqlca.h 24-apr-2003.12:50:58 mkandarp Exp $ sqlca.h 
 */

/* Copyright (c) 1985, 2003, Oracle Corporation.  All rights reserved.  */
 
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


#define NREG_HOSTARRAY 80
#define NREG_CONC_HOSTARRAY 100

double round(double valor)
{
    if (valor > 0) 
    {
        return((double)(long)(valor+0.5));
    }
    else
    {
        return((double)(long)(valor-0.5));
    } 
}

/*---------------------------------------------------------------------------*/
/* OBTENCION DE OFICINA EMISORA A PARTIR DE LA OFICINA DE LA PRIMER VENTA    */
/*---------------------------------------------------------------------------*/
char * bfnObtieneOficinaEmisora(char *Oficina, char *Operadora)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char    szhCod_Oficina[3];
        char    szhCod_OficinaEmis[3];
        char    szhCod_Operadora[5];
    /* EXEC SQL END DECLARE SECTION; */ 

    char OficinaRet[3];

    strcpy(szhCod_Oficina,Oficina);
    strcpy(szhCod_Operadora, Operadora);

     /* EXEC SQL SELECT COD_OFICINA
        INTO :szhCod_OficinaEmis
        FROM  GE_OPERPLAZA_TD
        WHERE COD_PLAZA = (
            SELECT  C.COD_PLAZA
            FROM    GE_OFICINAS A   ,
                GE_DIRECCIONES B,
                GE_CIUDADES C
            WHERE   A.COD_OFICINA   = :szhCod_Oficina
            AND     A.COD_DIRECCION = B.COD_DIRECCION
            AND     B.COD_REGION    = C.COD_REGION
            AND     B.COD_PROVINCIA = C.COD_PROVINCIA
            AND     B.COD_CIUDAD    = C.COD_CIUDAD)
        AND COD_OPERADORA_SCL = :szhCod_Operadora ; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 3;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select COD_OFICINA into :b0  from GE_OPERPLAZA_TD where \
(COD_PLAZA=(select C.COD_PLAZA  from GE_OFICINAS A ,GE_DIRECCIONES B ,GE_CIUDA\
DES C where ((((A.COD_OFICINA=:b1 and A.COD_DIRECCION=B.COD_DIRECCION) and B.C\
OD_REGION=C.COD_REGION) and B.COD_PROVINCIA=C.COD_PROVINCIA) and B.COD_CIUDAD=\
C.COD_CIUDAD)) and COD_OPERADORA_SCL=:b2)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )5;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)szhCod_OficinaEmis;
     sqlstm.sqhstl[0] = (unsigned long )3;
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)szhCod_Oficina;
     sqlstm.sqhstl[1] = (unsigned long )3;
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)szhCod_Operadora;
     sqlstm.sqhstl[2] = (unsigned long )5;
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



    if(SQLCODE == SQLNOTFOUND)
    {
        vDTrazasLog(szExeName,"\t=>No hay registros para la obtencion de la Oficina Emisora",LOG01);
        strcpy(OficinaRet,"--");
    }
    if(SQLCODE != SQLOK)
    {
        vDTrazasLog(szExeName,  "\n\t=>Error en la obtencion de la Oficina Emisora"
        						"\n\t=>szhCod_Operadora   [%s]"
        						"\n\t=>szhCod_Oficina [%s]"
        						"\n\t=>Retorno szhCod_OficinaEmis [%s]"
        						,LOG01, szhCod_Operadora, szhCod_Oficina, szhCod_OficinaEmis);

        strcpy(OficinaRet,"--");
    }
    else
    {
        strcpy(OficinaRet,szhCod_OficinaEmis);
    }

	return (OficinaRet);

}

/*---------------------------------------------------------------------------*/
/* QUITA LOS ESPACIOS EN BLANCO AL INICIO Y AL FINAL DE UNA CADENA DE        */
/* CARACTERES                                                */
/*---------------------------------------------------------------------------*/
char * szfnTrim(char * strin)
{
    int  i= 0,l=0;
    char strtmps[STR_HUGE];

    memset(strtmps, 0, STR_LONG);

    while (*(strin + i) == ' ')
        i++;

    strcpy(strtmps,(strin + i));


    l = strlen(strtmps) - 1;
    while ((l >= 0) && ((*(strtmps + l ) == ' ')||(*(strtmps + l ) == '\n')))
    {
        *(strtmps + l ) = '\0';l--;
    }

    strcpy(strin,strtmps);
    return(strin);
}


/****************************************************************************/
/*                            funcion : bfnPasoHistoricos                   */
/****************************************************************************/
BOOL bfnPasoHistoricos (void)
{
    int bConcAfecto = FALSE;
    int bConcExento = FALSE;
    int iCaTriBut   = 0;

    strcpy (stAnomProceso.szDesProceso,"Paso a Historicos")  ;
    vDTrazasLog (szExeName,"\n\t\t* %s",LOG03,stAnomProceso.szDesProceso);

    /********************************************************************/
    /*  Validacion de Conceptos Afectos y Exentos en un Documento       */
    /********************************************************************/

    if (!bfnValCatImpDocu(stCliente.lCodCliente,&bConcAfecto, &bConcExento))
    {
        iDError(szExeName, ERR000, vInsertarIncidencia, "Paso a Historicos"
                             ,"Flag de Impuestos Inconsistente (bfnValCatImpDocu)");
        return FALSE;
    }


    /********************************************************************/
    /*  Validacion de Documentos Puntuales Exentos o Afectos  No Valido */
    /********************************************************************/

    if (stProceso.iCodTipDocum != stDatosGener.iCodCiclo)
    {
        if (!bConcAfecto && !bConcExento)
        {
            vDTrazasError(szExeName,"\n\t=> Error en el Paso Historico de Documentos"
                                    "\n\t   No Se Puede Emitir Documento con Conceptos Afectos y Exentos",LOG03);
            iDError(szExeName, ERR000, vInsertarIncidencia, "Paso a Historicos"
                             ,"No Se Puede Emitir Documento con Conceptos Afectos y Exentos");
            return FALSE;
        }
    }
    else
    /********************************************************************/
    /*  Validacion de Documentos Puntuales Exentos y Afectos            */
    /*  Dtermionar la Categoria Tributaria del Cliente Factura o Boleta */
    /********************************************************************/
    {
       
        
        if (!bGetCatTribCliente(stCliente.lCodCliente   ,
                           stInterFact.szCodCaTribut    ,
                           stCiclo.szFecEmision         ))
        {
            vDTrazasError(szExeName,"\n\t=> Error al Obtener Categoria Tributaria del Clientes "
                                    "\n\t\t Cod. Cliente [%ld]",LOG03,stCliente.lCodCliente);
            iDError(szExeName, ERR000, vInsertarIncidencia, "Paso a Historicos","bGetCatTribCliente");
            return FALSE;
        }
        stInterFact.iCodTipMovimien =   stDatosGener.iCodCiclo  ;
        stInterFact.iCodModVenta    =   iCONTADO                ;
        stInterFact.iNumCuotas      =   0                       ;
        if (!bfnAddHistAboCero())
        {
            iDError(szExeName, ERR000, vInsertarIncidencia, "Paso a Historicos","bfnAddHistAboCero");
            return FALSE;
        }
    }
    /********************************************************************/

    if (((bConcAfecto) && (bConcExento)) || (bConcAfecto))
    {
        vDTrazasLog(szExeName,"\n\t\t\t** Documento Afecto **",LOG04);
        iCaTriBut=iCODCATRIBUT_AFECTO;
    }
    else
    {
        vDTrazasLog(szExeName,"\n\t\t\t** Documento Exento **",LOG04);
        iCaTriBut=iCODCATRIBUT_EXENTO;
    }
    vDTrazasLog(szExeName,"\n**** Paso Historico de Documentos ****",LOG04);

    if (!bfnPasoHistDocu (iCaTriBut))
    {
        vDTrazasError(szExeName,"\n\t=> Error en el Paso Historico de Documentos\n",LOG01);
        return FALSE;
    }
    vDTrazasLog(szExeName,"\n**** Paso Historico de Clientes ****",LOG04);
    if (!bfnPasoHistClie ())
    {
        vDTrazasError(szExeName,"\n\t=> Error en el Paso Historico de Cliente\n",LOG01);
        return FALSE;
    }
    vDTrazasLog(szExeName,"\n**** Paso Historico de Abonados ****",LOG04);
    if (!bfnPasoHistAbo ())
    {
        vfnFreeHistAbo();
        vDTrazasError (szExeName,"\n\t=> Error en el Paso Historico de Abonados\n",LOG01);
        return FALSE;
    }
    vfnFreeHistAbo();
    vDTrazasLog(szExeName,"\n**** Paso Historico de Conceptos ****",LOG04);

    if (!bfnCargaValUnit())
    {
        vDTrazasError(szExeName,"\n\t=>Error en el carag de valor unitario\n",LOG01);
        return FALSE;
    }

    if (!bfnPasoHistConc ())
    {
        vDTrazasError(szExeName,"\n\t=>Error en el Paso Historico de Conceptos\n",LOG01);
        return FALSE;
    }

    vDTrazasLog(szExeName,"**** Fin Paso Historicos ****\n",LOG03);

    return TRUE;
}/**************************** Final bfnPasoHistoricos **********************/

/**********************************************************************************/
/*                             funcion : bfnPasoHistDocu                          */
/**********************************************************************************/
/* static BOOL bfnPasoHistDocu  (int iTipImpositiva, BOOL  bAfecto, BOOL bExento) */
/* se va a generar solo un documento aunque tenga conceptos afectos y afectos     */
/* cdescouv 12/04/2002                                                            */
/**********************************************************************************/
static BOOL bfnPasoHistDocu  (int iTipImpositiva)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    static char *szhIndOrdenTotal  ; /* EXEC SQL VAR szhIndOrdenTotal IS STRING(13); */ 

    static char szhCodRegion    [4]; /* EXEC SQL VAR szhCodRegion IS STRING(4); */ 

    static char szhCodProvincia [6]; /* EXEC SQL VAR szhCodProvincia IS STRING(6); */ 

    static char szhCodCiudad    [6]; /* EXEC SQL VAR szhCodCiudad IS STRING(6); */ 

    static char szhCodOficina   [3]; /* EXEC SQL VAR szhCodOficina IS STRING(3); */ 

    static char szhFecEmision   [9]; /* EXEC SQL VAR szhFecEmision IS STRING(9); */ 

    static char szhHorEmision   [7]; /* EXEC SQL VAR szhHorEmision IS STRING(7); */ 



    /* EXEC SQL END DECLARE SECTION  ; */ 


    
    char    szCadenaResultado  [500];
    char    szCamposEncriptados [41];
    BOOL    bFlagFolios      = FALSE;
    char    szFecEmision    [15]= "";
    char    szFecVencimi    [15]= "";
    char    szCodOficEmisora [3]= "";
    OFICINA pstOficina              ; /* estructura temporal para obtencion de los datos de oficina */
    char    pszCodOficina     [3]="";

    vDTrazasLog (szExeName, "\t\t* Paso a Historico de Documento %s "
                            ,LOG04,(iTipImpositiva == iCODCATRIBUT_AFECTO ? "Afecto":"Exento"));

    memset (&stHistDocu,0,sizeof(HISTDOCU));

    if((stProceso.iCodTipDocum == MISCELANEA) || (stProceso.iCodTipDocum == NOTACRED))  /* FACTURA MISCELANEA o NOTA CRED*/
    {
        strcpy (stHistDocu.szhCodMonedaImp,stPreFactura.A_PFactura[0].szhCodMonedaImp);
        stHistDocu.dhImpConversion = stPreFactura.A_PFactura[0].dhImpConversion;
    }
    else
    {
        strcpy (stHistDocu.szhCodMonedaImp, stDatosGener.szCodMoneFact);
        stHistDocu.dhImpConversion = 1;
    }


    stHistDocu.lCodCliente        = stCliente.lCodCliente       ;
    stHistDocu.lCodVendedorAgente = stProceso.lCodVendedorAgente;
    stHistDocu.lCodVendedor       = stProceso.lCodVendedorAgente;
    stHistDocu.iCodCentrEmi       = stProceso.iCodCentrEmi      ;

    vDTrazasLog (szExeName, "\n\t A_PFactura.szhCodMonedaImp[0] = [%s]"
                            "\n\t A_PFactura.dhImpConversion[0] = [%f]"
                            "\n\t stHistDocu.szhCodMonedaImp  	= [%s]"
                            "\n\t stHistDocu.dhImpConversion  	= [%f]"
                            "\n\t GE_CLIENTES.IND_FACTUR   		= [%d]"
                            "\n\t FA_PREFACTURA.IND_FACTUR 		= [%d]"
                            "\n\t TIPO DOCUMENTO           		= [%d]"
                            , LOG05 ,stPreFactura.A_PFactura[0].szhCodMonedaImp
                            ,stPreFactura.A_PFactura[0].dhImpConversion
                            ,stHistDocu.szhCodMonedaImp
                            ,stHistDocu.dhImpConversion
                            ,stCliente.iIndFactur
                            ,stPreFactura.A_PFactura[0].iIndFactur
                            ,stProceso.iCodTipDocum );

    if(stProceso.iCodTipDocum == NOTACRED)  /* 25 = NOTA CREDITO */
    {
        stHistDocu.iIndFactur  = stPreFactura.A_PFactura[0].iIndFactur;
    }
    else
    {
        stHistDocu.iIndFactur  = stCliente.iIndFactur;
    }

    stHistDocu.lNumFolio          = 0                           ;

    strcpy (stHistDocu.szPrefPlaza,"");
    strcpy (stHistDocu.szCodOperadora,szfnTrim(stCliente.szCodOperadora));

    strcpy (szhCodRegion,stCliente.szCodRegion);
    strcpy (szhCodProvincia,stCliente.szCodProvincia);
    strcpy (szhCodCiudad,stCliente.szCodCiudad);

    vDTrazasLog (szExeName,"stProceso.iCodTipDocum(%d)\n",LOG05,stProceso.iCodTipDocum);

    if(stProceso.iCodTipDocum==stDatosGener.iCodContado)
    {
        strcpy(szhCodOficina,stVenta.szCodOficina);
    }
    else if(stProceso.iCodTipDocum==stDatosGener.iCodCompra)
    {
        if (stTransContado.lNumTransaccion > 0)
        {
            strcpy(szhCodOficina,stTransContado.szCodOficina);
        }
        else
        {
            strcpy(szhCodOficina,stVenta.szCodOficina);
        }
    }
    else if( stProceso.iCodTipDocum==stDatosGener.iCodNotaCre ||
             stProceso.iCodTipDocum==stDatosGener.iCodNotaDeb)
    {
        strcpy(stHistDocu.szCodPlaza,szfnTrim(stNota.szCodPlaza));
        strcpy(stHistDocu.szCodOperadora,szfnTrim(stNota.szCodOperadora));

		if (!bfnGetDirOfiVend (stProceso.lCodVendedorAgente, pszCodOficina))
        {
            vDTrazasError(szExeName,"\n\t** ERROR, al obtener la oficina del vendedor **",LOG01);
            vDTrazasLog  (szExeName,"\n\t** ERROR, al obtener la oficina del vendedor **",LOG01);
            return FALSE;
        }

        strcpy(stProceso.szCodOficina,pszCodOficina);

		vDTrazasLog (szExeName,"cod_oficina proceso : (%s)\n"
		 					   "cod_oficina Nota    : (%s)\n"
		 					   "cod_Vendedor        : (%ld)\n"
							  ,LOG05,stProceso.szCodOficina,stNota.szCodOficina
							  ,stProceso.lCodVendedorAgente );
		strcpy(szhCodOficina,stProceso.szCodOficina);
		vDTrazasLog  (szExeName,"\n\t** cjg 4- szhCodOficina Vendedor  : (%s)",LOG03,szhCodOficina);
    }
    else
    {
    		if (!bfnGetDirOfiVend (stProceso.lCodVendedorAgente, pszCodOficina))
        {
            vDTrazasError(szExeName,"\n\t**** ERROR, al obtener la oficina del vendedor **",LOG01);
            vDTrazasLog  (szExeName,"\n\t**** ERROR, al obtener la oficina del vendedor **",LOG01);
            return FALSE;
        }

        strcpy(stProceso.szCodOficina,pszCodOficina);

		vDTrazasLog (szExeName,"cjg cod_oficina proceso : (%s)\n"
		 					   "cjg cod_oficina miscelanea    : (%s)\n"
		 					   "cjg cod_Vendedor        : (%ld)\n"
							  ,LOG05,stProceso.szCodOficina,stNota.szCodOficina
							  ,stProceso.lCodVendedorAgente );
		strcpy(szhCodOficina,stProceso.szCodOficina);
    }
    vDTrazasLog (szExeName,"bfnPasoHistDocu:szhCodOficina(%s)\n",LOG05,szhCodOficina);


    if (!bfnFindOficina (szhCodOficina, &pstOficina ))
    {
        vDTrazasLog (szExeName, "\n\t\t Error Obtener oficina : [%s] \n",LOG01,szhCodOficina);
        return FALSE;
    }

    strcpy(stHistDocu.szCodPlaza,szfnTrim(pstOficina.szCodPlaza));
    strcpy (stHistDocu.szNomUsuarOra,stProceso.szNomUsuarOra);
    strcpy (stHistDocu.szFecCambioMo,szSysDate)              ;

    stHistDocu.iIndSuperTel = stCliente.iIndSuperTel;

    /* Zona Impositiva */
    stHistDocu.iCodZonaImpo = stPreFactura.iCodZonaImpo;
    /* *************** */

    if (!bfnGetTotDocu (&stHistDocu))
         return FALSE;

    /************************************************************************************/
    /*  Rutina bfnGetCodTipDocum interfact.pc : Asignacion el Tipo de Documento segun   */
    /*  Tipo de Movimiento y Tipo de Factura Afecta/Exenta                              */
    /************************************************************************************/
    if (!bfnGetCodTipDocum(&stInterFact, iTipImpositiva))
        return FALSE;
    /************************************************************************************/
    /*  Asignacion del Tipo de Documento para Movimiento de Ciclo                       */
    /************************************************************************************/
    stHistDocu.iCodTipDocum       = stInterFact.iCodTipDocum;
    stHistDocu.iCodModVenta       = stInterFact.iCodModVenta;
    stHistDocu.iNumCuotas         = stInterFact.iNumCuotas  ;
    /************************************************************************************/

    vDTrazasLog(szExeName,"\n\t**** stProceso.iCodTipDocum=[%d] stDatosGener.iCodCiclo=[%d] stHistDocu.iCodTipDocum=[%d]\n"
                            "\t**** stCliente.iIndFactur=[%d] stHistDocu.dTotFactura=[%f] stCliente.iIndSuperTel=[%d]\n"
                            "\t**** stVenta.lNumVenta=[%ld] stVenta.lNumTransaccion=[%ld] stTransContado.lNumTransaccion=[%ld]\n"
                            "\t**** stDatosGener.iCodMiscela=[%d] stHistDocu.iCodModVenta=[%d]", LOG05,
                            stProceso.iCodTipDocum, stDatosGener.iCodCiclo, stHistDocu.iCodTipDocum,
                            stCliente.iIndFactur, stHistDocu.dTotFactura, stCliente.iIndSuperTel,
                            stVenta.lNumVenta, stVenta.lNumTransaccion, stTransContado.lNumTransaccion,
                            stDatosGener.iCodMiscela, stHistDocu.iCodModVenta);

    if (stProceso.iCodTipDocum == stDatosGener.iCodCiclo)
    {
        if (!bGetLetra (stProceso.iCodTipDocum,stCliente.iCodCatImpos,
                        stHistDocu.szLetra))
            return FALSE;

        if (!bGenNumSecuenciasEmi (stProceso.iCodTipDocum, stHistDocu.szLetra,
                                   stProceso.iCodCentrEmi,&stProceso.lNumSecuAg))
            return FALSE;
     /*
        2005/04/25 Indra    Modificacion proyecto P-COL-05001-SCL (Colombia) para documentos en 0 (cero):
        Se condiciona total de la factura en cero   y que el valor del parametro sea distinto de
        'S' ('S' Documentos facturables con total factura =0) osea 'N' para  que no se cumpla la condicion
        del IF y salgo por fin de IF, que es la condicion de un documento normal a facturar
     */
        if (!stCliente.iIndFactur  || (0 == fnCnvDouble(abs(stHistDocu.dTotFactura),USOFACT) && (pstParamGener.sDocumentoCero == 'N'))
        || stCliente.iIndSuperTel)
        {
             if (pstParamGener.iTipoFoliacion == 1)
             {
                 strcpy(szCodOficEmisora, bfnObtieneOficinaEmisora(stCliente.szCodOficina, stCliente.szCodOperadora));  /* Incorporado por PGonzalez 17-03-2004 */
                 if (strcmp(szCodOficEmisora, "--") == 0)
                 {
                     vDTrazasLog  (szExeName,"\n\t** Error En la obtencion de Oficina Emisora**\n",LOG01);
                     return FALSE;
                 }
                 if (!bfnConsumeFolio ( szCodOficEmisora,
                                        stHistDocu.iCodTipDocum      ,
                                        szfnTrim(stCliente.szCodOperadora) ,
                                        stProceso.lNumProceso        ,
                                        szSysDate                    ,
                                        &stHistDocu.lNumFolio        ,
                                        stHistDocu.szPrefPlaza))
                 {
                     vDTrazasLog  (szExeName,"\n\t** Error Consumo de folios **",LOG01);
                     vDTrazasError(szExeName,"\n\t** Error Consumo de folios **",LOG01);
                     return FALSE;
                 }else{
                 	bFlagFolios = TRUE;
                 }
                 
                 strcpy(stHistDocu.szCodOficina, szCodOficEmisora);
             }
             else
             {
                 if (!bfnConsumeFolio (  stDatosGener.szCodOficCentral,
                                         stHistDocu.iCodTipDocum      ,
                                         szfnTrim(stCliente.szCodOperadora) ,
                                         stProceso.lNumProceso        ,
                                         szSysDate                    ,
                                         &stHistDocu.lNumFolio        ,
                                         stHistDocu.szPrefPlaza))
                 {
                     vDTrazasLog  (szExeName,"\n\t** Error Consumo de folios **",LOG01);
                     vDTrazasError(szExeName,"\n\t** Error Consumo de folios **",LOG01);
                     return FALSE;
                 }else{
                 	bFlagFolios = TRUE;
                 }
             }
        }

        stHistDocu.lNumSecuenci = stProceso.lNumSecuAg        ;
        stHistDocu.lCodVendedor = stProceso.lCodVendedorAgente;
    }
    else
    {
        /****************************************************************/
        /* * Documentos No Ciclicos                                   * */
        /****************************************************************/
        stHistDocu.lNumSecuenci   = stProceso.lNumSecuAg;
        strcpy (stHistDocu.szLetra, stProceso.szLetraAg);

        if (stVenta.lNumVenta > 0 && stVenta.lNumTransaccion > 0)
        {
            stHistDocu.lNumVenta       = stVenta.lNumVenta      ;
            stHistDocu.lCodVendedor    = stVenta.lCodVendedor   ;
            stHistDocu.lNumTransaccion = stVenta.lNumTransaccion;
            strcpy(stHistDocu.szCodOficina, stVenta.szCodOficina);

        }
        else
        {
            if (stTransContado.lNumTransaccion > 0)
            {
                stHistDocu.lNumTransaccion = stTransContado.lNumTransaccion   ;
                stHistDocu.lCodVendedor    = stTransContado.lCodVendedorAgente;
            }

            strcpy(stHistDocu.szCodOficina, stProceso.szCodOficina);

        }
        if (stProceso.iCodTipDocum == stDatosGener.iCodMiscela)
        {
            strcpy (stHistDocu.szPrefPlaza,stInterFact.szPrefPlaza);

            stHistDocu.lNumVenta       = stInterFact.lNumVenta;
            if (stHistDocu.iCodModVenta == iCONSIGNACION ||
                stHistDocu.iCodModVenta == iCARGOCUENTA  ||
                stHistDocu.iCodModVenta == iCTDOCONSIG   ||
                stHistDocu.iCodModVenta == iNVOREGALO     )
            {

                if (!bfnConsumeFolio (  stDatosGener.szCodOficCentral,
                                        stDatosGener.iCodConsignacion ,
                                        szfnTrim(stCliente.szCodOperadora)  ,
                                        stProceso.lNumProceso         ,
                                        szSysDate                     ,
                                        &stHistDocu.lNumFolio         ,
                                        stHistDocu.szPrefPlaza))
                {
                    vDTrazasLog  (szExeName,"\n\t** Error Consumo de folios **",LOG01);
                    vDTrazasError(szExeName,"\n\t** Error Consumo de folios **",LOG01);
                    return FALSE;
                }else{
                 	bFlagFolios = TRUE;
                }
            }
        }
    }
    
    if (bFlagFolios)
    {	
    	strncpy(szhFecEmision,stHistDocu.szFecEmision,8);
		strncpy(szhHorEmision,&stHistDocu.szFecEmision[8],6);
		
    	if (!bfnEncriptaContTec (szCadenaResultado,stHistDocu.szPrefPlaza,
                             stHistDocu.lNumFolio,szhFecEmision,szhHorEmision,
                             stHistDocu.dTotCargosMe,stHistDocu.dAcumIva,
                             stDatosGener.szClaConTecnico,stCliente.szCodIdTipDian,
                             stCliente.szNumIdentTrib, stDatosGener.szNitOperadora))
	    {
	    	return(FALSE); 
	    }
	    
	    sprintf(szCamposEncriptados,"%s\0",szCadenaResultado);
	    vDTrazasLog(szExeName , "\n\t\tRetorno Funcion Encriptación [%s]",LOG05,szCamposEncriptados);
	    
	    strcpy (stHistDocu.szKeyConTecnico,stDatosGener.szClaConTecnico);
	    strcpy (stHistDocu.szContTecnico,szCamposEncriptados);
    }else{
    	strcpy (stHistDocu.szKeyConTecnico,"");
        strcpy (stHistDocu.szContTecnico,"");
    }
    
    if (stDatosGener.szIndOrdenTotal [0] == 0)
    {
        szhIndOrdenTotal = stDatosGener.szIndOrdenTotal;

        /* EXEC SQL SELECT TO_CHAR (FA_SEQ_IND_ORDENTOTAL.NEXTVAL)
                 INTO   :szhIndOrdenTotal
                 FROM   DUAL; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 3;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select TO_CHAR(FA_SEQ_IND_ORDENTOTAL.nextval ) into :\
b0  from DUAL ";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )32;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhIndOrdenTotal;
        sqlstm.sqhstl[0] = (unsigned long )13;
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


        if (SQLCODE)
        {
            iDError (szExeName,ERR000,vInsertarIncidencia,"Fa_Seq_Ind_OrdenTotal",
                     szfnORAerror ());
            return   FALSE           ;
        }
    }
    strcpy (stHistDocu.szIndOrdenTotal, stDatosGener.szIndOrdenTotal);

    vDTrazasLog(szExeName,"\n\t**** stHistDocu.lNumFolio=[%ld] stHistDocu.lNumSecuenci=[%ld] stHistDocu.lCodVendedor=[%ld]"
                          "\n\t**** stHistDocu.lNumTransaccion=[%ld] stHistDocu.lCodVendedor=[%ld] stHistDocu.szIndOrdenTotal=[%s]"
                            ,LOG05,stHistDocu.lNumFolio, stHistDocu.lNumSecuenci, stHistDocu.lCodVendedor,
                            stHistDocu.lNumTransaccion, stHistDocu.lCodVendedor,stHistDocu.szIndOrdenTotal);


    vfnComposicionNumCTC(stHistDocu.szNumCTC);

    stHistDocu.lNumProceso     = stProceso.lNumProceso ;
    stHistDocu.lCodPlanCom     = stCliente.lCodPlanCom ;
    stHistDocu.iCodCatImpos    = stCliente.iCodCatImpos;

    if ((stCiclo.lCodCiclFact > 0) && (stProceso.iCodTipDocum != stDatosGener.iCodBaja))
    {
        strcpy (stHistDocu.szFecEmision ,stCiclo.szFecEmision );
        strcpy (stHistDocu.szFecCaducida,stCiclo.szFecCaducida);
        strcpy (stHistDocu.szFecProxVenc,stCiclo.szFecProxVenc);

        if (!bfnDiasVencimiento(stCliente.lCodCliente,
                                stCliente.lCodCuenta,
                                stProceso.iCodTipDocum,
                                stCiclo.szFecEmision,
                                stCiclo.szFecVencimie,
                                szFecVencimi))
        {
            vDTrazasLog  (szExeName,"\n\t** Error obtencion de la fecha de vencimiento **",LOG01);
            vDTrazasError(szExeName,"\n\t** Error obtencion de la fecha de vencimiento **",LOG01);
            return   FALSE;
        }
        strcpy (stHistDocu.szFecVencimie,szFecVencimi);
        strcpy (stHistDocu.szFecCaducida,szFecVencimi); /* SAAM-20061102 Se igualan las fecha de caducidad y vencimiento, XO-200610301233 */

        stHistDocu.lCodCiclFact = stCiclo.lCodCiclFact;
    }
    else
    {
        if (strlen(stInterFact.szFecVencimiento))
        {
            strcpy (stHistDocu.szFecVencimie,stInterFact.szFecVencimiento);
            strcpy (stHistDocu.szFecCaducida,stInterFact.szFecVencimiento);  /* SAAM-20061102 Se igualan las fecha de caducidad y vencimiento, XO-200610301233 */
        }
        else
        {
            if (!bfnDiasVencimiento(stCliente.lCodCliente,
                                    stCliente.lCodCuenta,
                                    stProceso.iCodTipDocum,
                                    szSysDate,
                                    szSysDate,
                                    szFecVencimi))
            {
                vDTrazasLog  (szExeName,"\n\t** Error obtencion de la fecha de vencimiento **",LOG01);
                vDTrazasError(szExeName,"\n\t** Error obtencion de la fecha de vencimiento **",LOG01);
                return   FALSE;
            }
            strcpy (stHistDocu.szFecVencimie,szFecVencimi);
            strcpy (stHistDocu.szFecCaducida,szFecVencimi); /* SAAM-20061102 Se igualan las fecha de caducidad y vencimiento, XO-200610301233 */
        }
        strcpy (stHistDocu.szFecEmision ,stInterFact.szFecIngreso);

        stHistDocu.lCodCiclFact      = ORA_NULL    ;
        stHistDocu.szFecProxVenc [0] = 0           ;
    }

    if (stProceso.iCodTipDocum != stDatosGener.iCodCiclo)
    {
        stHistDocu.lCodCiclFact      = stDatosGener.lCodCicloDocPuntual;
    }
    if (stProceso.iCodTipDocum == stDatosGener.iCodNotaCre ||
        stProceso.iCodTipDocum == stDatosGener.iCodNotaDeb )
    {
        strcpy (stHistDocu.szLetraRel, stProceso.szLetraNot)              ;
        stHistDocu.lNumSecuRel           = stProceso.lNumSecuNot          ;
        stHistDocu.iCodTipDocumRel       = stProceso.iCodTipDocNot        ;
        stHistDocu.lCodVendedorAgenteRel = stProceso.lCodVendedorAgenteNot;
        stHistDocu.iCodCentrRel          = stProceso.iCodCentrNot         ;

    }
    if (stProceso.iCodTipDocum == stDatosGener.iCodCiclo ||
        stProceso.iCodTipDocum == stDatosGener.iCodBaja  ||
        stProceso.iCodTipDocum == stDatosGener.iCodLiquidacion)
    {
        if (stProceso.iCodTipDocum == stDatosGener.iCodCiclo)
            strcpy (szFecEmision,stCiclo.szFecEmision);
        else
            strcpy (szFecEmision,szSysDate);
        vDTrazasLog (szExeName, "\t\t=> Fecha de Emision: %s", LOG04, szFecEmision);

        if (!bfnGetSaldoAnt (stCliente.lCodCliente,&stHistDocu.dImpSaldoAnt))
             return FALSE;

        if (!bConversionMoneda  (stCliente.lCodCliente      ,
                                 stDatosGener.szMonedaCobros,
                                 stDatosGener.szCodMoneFact ,
                                 stHistDocu.szFecEmision    ,
                                &stHistDocu.dImpSaldoAnt    ))
             return FALSE; /* P-MIX-09003 4 */

       if (stCliente.dImpRecargo != 0.0)
            stHistDocu.dImpSaldoAnt -= stCliente.dImpRecargo ;

       if (stHistDocu.dImpSaldoAnt < 0)
           stHistDocu.dTotPagar = (stHistDocu.dTotFactura <
                                   (-1)*stHistDocu.dImpSaldoAnt)?0.0:
                                   stHistDocu.dTotPagar + stHistDocu.dImpSaldoAnt;
       else
           stHistDocu.dTotPagar += stHistDocu.dImpSaldoAnt;
    }
    else
    {
        stHistDocu.dImpSaldoAnt = 0.0;
    }
    stHistDocu.iIndSuperTel = stCliente.iIndSuperTel ;
    
    strcpy(stHistDocu.szCodSegmentacion,stCliente.szCodSegmentacion);
    
    strcpy(stHistDocu.szCodDespacho,stCliente.szCodDespacho);
    
    strcpy(stHistDocu.szNomEmail,stCliente.szNomEmail);
    
    

    if (stProceso.iCodTipDocum == stDatosGener.iCodContado)
    {
        if (!bfnDBUpdateVenta (&stHistDocu))
             return FALSE;
    }


    if (!bfnInsertHistDocu (&stHistDocu))
         return FALSE;
    return TRUE;
}/***************************** Final bfnPasoHistDocu  ***********************/

/*****************************************************************************/
/*                            funcion : vfnComposicionNumCTC                 */
/* - Posicion 1 (long 1): 8                                                  */
/* - Posicion 2 (long 9): Ind_OrdenTotal                                     */
/* - Posicion 3 (long 1): Digito Verificador                                 */
/*****************************************************************************/
static void vfnComposicionNumCTC (char *szNumCTC)
{
    int i       = 0;
    int j       = 2; /* j tomara los valores de 2 a 7 inclusives */
    int iDigito = 0;
    long lInd_OrdenTotal=0;

    char szAux[2] = "";
    char szCTC[13]= "";

    div_t stRes       ;

    lInd_OrdenTotal=atol(stDatosGener.szIndOrdenTotal);
    sprintf(szCTC, "%9.9ld", lInd_OrdenTotal);

    i = strlen(szCTC)-1;

    while (i >= 0)
    {
       if (j >= 8)
         j  = 2;
       strncpy (szAux, &szCTC [i], 1);
       iDigito += (atoi (szAux) * j);
       j++;
       i--;
    }

    stRes = div (iDigito, 11);

    if( (11-stRes.rem) == 10 )
       sprintf (szNumCTC,"%s%s",szCTC, szDIG10);
    else
       sprintf (szNumCTC,"%s%d",szCTC,((11-stRes.rem)==11)?0:11-stRes.rem);

    vDTrazasLog (szExeName, "\n\t\t=> Numero CTC %s", LOG04, szNumCTC);

}/**************************** Final vfnComposicionNumCTC ********************/

/*****************************************************************************/
/*                            funcion : bfnDBUpdateVenta                     */
/*****************************************************************************/
static BOOL bfnDBUpdateVenta (HISTDOCU *stHis)
{
  char szFuncion [99] = "";

  if (stHis->lNumVenta > 0 )
  {
      vDTrazasLog (szExeName,
                   "\n\t\t* Parametros de Entrada a Update Venta"
                   "\n\t\t=>Num.Venta       [%ld]"
                   "\n\t\t=>Num.Transaccion [%ld]", LOG06,
                   stHis->lNumVenta, stHis->lNumTransaccion);

      strcpy (szFuncion, "Update=>Ga_Ventas");
      if (stHis->lNumTransaccion > 0)
      {
          /* EXEC SQL UPDATE /o+ index (GA_VENTAS PK_GA_VENTAS) o/
                          GA_VENTAS
                   SET    IMP_VENTA = :stHis->dTotCargosMe,     /o P-MIX-09003 o/
                          COD_MONEDA= :stDatosGener.szCodMoneFact
                   WHERE  NUM_VENTA     = :stHis->lNumVenta
                   AND  NUM_TRANSACCION = :stHis->lNumTransaccion; */ 

{
          struct sqlexd sqlstm;
          sqlstm.sqlvsn = 12;
          sqlstm.arrsiz = 4;
          sqlstm.sqladtp = &sqladt;
          sqlstm.sqltdsp = &sqltds;
          sqlstm.stmt = "update  /*+  index (GA_VENTAS PK_GA_VENTAS)  +*/ GA\
_VENTAS  set IMP_VENTA=:b0,COD_MONEDA=:b1 where (NUM_VENTA=:b2 and NUM_TRANSAC\
CION=:b3)";
          sqlstm.iters = (unsigned int  )1;
          sqlstm.offset = (unsigned int  )51;
          sqlstm.cud = sqlcud0;
          sqlstm.sqlest = (unsigned char  *)&sqlca;
          sqlstm.sqlety = (unsigned short)256;
          sqlstm.occurs = (unsigned int  )0;
          sqlstm.sqhstv[0] = (unsigned char  *)&(stHis->dTotCargosMe);
          sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
          sqlstm.sqhsts[0] = (         int  )0;
          sqlstm.sqindv[0] = (         short *)0;
          sqlstm.sqinds[0] = (         int  )0;
          sqlstm.sqharm[0] = (unsigned long )0;
          sqlstm.sqadto[0] = (unsigned short )0;
          sqlstm.sqtdso[0] = (unsigned short )0;
          sqlstm.sqhstv[1] = (unsigned char  *)(stDatosGener.szCodMoneFact);
          sqlstm.sqhstl[1] = (unsigned long )4;
          sqlstm.sqhsts[1] = (         int  )0;
          sqlstm.sqindv[1] = (         short *)0;
          sqlstm.sqinds[1] = (         int  )0;
          sqlstm.sqharm[1] = (unsigned long )0;
          sqlstm.sqadto[1] = (unsigned short )0;
          sqlstm.sqtdso[1] = (unsigned short )0;
          sqlstm.sqhstv[2] = (unsigned char  *)&(stHis->lNumVenta);
          sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[2] = (         int  )0;
          sqlstm.sqindv[2] = (         short *)0;
          sqlstm.sqinds[2] = (         int  )0;
          sqlstm.sqharm[2] = (unsigned long )0;
          sqlstm.sqadto[2] = (unsigned short )0;
          sqlstm.sqtdso[2] = (unsigned short )0;
          sqlstm.sqhstv[3] = (unsigned char  *)&(stHis->lNumTransaccion);
          sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
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
          /* EXEC SQL UPDATE /o+ index (GA_VENTAS PK_GA_VENTAS) o/
                          GA_VENTAS
                   SET    IMP_VENTA = :stHis->dTotCargosMe,    /o P-MIX-09003 o/
                          COD_MONEDA= :stDatosGener.szCodMoneFact
                   WHERE  NUM_VENTA = :stHis->lNumVenta; */ 

{
          struct sqlexd sqlstm;
          sqlstm.sqlvsn = 12;
          sqlstm.arrsiz = 4;
          sqlstm.sqladtp = &sqladt;
          sqlstm.sqltdsp = &sqltds;
          sqlstm.stmt = "update  /*+  index (GA_VENTAS PK_GA_VENTAS)  +*/ GA\
_VENTAS  set IMP_VENTA=:b0,COD_MONEDA=:b1 where NUM_VENTA=:b2";
          sqlstm.iters = (unsigned int  )1;
          sqlstm.offset = (unsigned int  )82;
          sqlstm.cud = sqlcud0;
          sqlstm.sqlest = (unsigned char  *)&sqlca;
          sqlstm.sqlety = (unsigned short)256;
          sqlstm.occurs = (unsigned int  )0;
          sqlstm.sqhstv[0] = (unsigned char  *)&(stHis->dTotCargosMe);
          sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
          sqlstm.sqhsts[0] = (         int  )0;
          sqlstm.sqindv[0] = (         short *)0;
          sqlstm.sqinds[0] = (         int  )0;
          sqlstm.sqharm[0] = (unsigned long )0;
          sqlstm.sqadto[0] = (unsigned short )0;
          sqlstm.sqtdso[0] = (unsigned short )0;
          sqlstm.sqhstv[1] = (unsigned char  *)(stDatosGener.szCodMoneFact);
          sqlstm.sqhstl[1] = (unsigned long )4;
          sqlstm.sqhsts[1] = (         int  )0;
          sqlstm.sqindv[1] = (         short *)0;
          sqlstm.sqinds[1] = (         int  )0;
          sqlstm.sqharm[1] = (unsigned long )0;
          sqlstm.sqadto[1] = (unsigned short )0;
          sqlstm.sqtdso[1] = (unsigned short )0;
          sqlstm.sqhstv[2] = (unsigned char  *)&(stHis->lNumVenta);
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
  }
  else
  {
      vDTrazasLog (szExeName,
                   "\n\t\t* Parametros de Entrada a Update Ga_TransContado"
                   "\n\t\t=>Num.Transaccion[%ld]",LOG06,stHis->lNumTransaccion);

      strcpy (szFuncion, "Update=>Ga_TransContado");

      /* EXEC SQL UPDATE /o+ index (GA_TRANSCONTADO PK_GA_TRANSCONTADO) o/
                      GA_TRANSCONTADO
               SET    IMP_VENTA = :stHis->dTotCargosMe, /o P-MIX-09003 o/
                      COD_MONEDA= :stDatosGener.szCodMoneFact
               WHERE  NUM_TRANSACCION = :stHis->lNumTransaccion; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 4;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "update  /*+  index (GA_TRANSCONTADO PK_GA_TRANSCONTADO)\
  +*/ GA_TRANSCONTADO  set IMP_VENTA=:b0,COD_MONEDA=:b1 where NUM_TRANSACCION=\
:b2";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )109;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&(stHis->dTotCargosMe);
      sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)(stDatosGener.szCodMoneFact);
      sqlstm.sqhstl[1] = (unsigned long )4;
      sqlstm.sqhsts[1] = (         int  )0;
      sqlstm.sqindv[1] = (         short *)0;
      sqlstm.sqinds[1] = (         int  )0;
      sqlstm.sqharm[1] = (unsigned long )0;
      sqlstm.sqadto[1] = (unsigned short )0;
      sqlstm.sqtdso[1] = (unsigned short )0;
      sqlstm.sqhstv[2] = (unsigned char  *)&(stHis->lNumTransaccion);
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
  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,szFuncion,szfnORAerror());

  return (SQLCODE != SQLOK)?FALSE:TRUE;
}/**************************** Fina bfnDBUpdateVenta    **********************/

/*****************************************************************************/
/*                          funcion : bfnGetSaldoAnt                         */
/*****************************************************************************/
static BOOL bfnGetSaldoAnt (long    lCodCliente ,
                            double *dImpSaldoAnt)
{

   /* EXEC SQL BEGIN DECLARE SECTION; */ 

   static char   szhFecEmision[9];/* EXEC SQL VAR szhFecEmision IS STRING(9); */ 

   static double dhImporte       ;
   static long   lhCodCliente    ;
   static int    ihValorUno		 ;
   static int    ihValorCero	 ;
   /* EXEC SQL END DECLARE SECTION; */ 


   strncpy (szhFecEmision,szSysDate,8);
   szhFecEmision [8] = '\0' ;

   lhCodCliente = lCodCliente;
   ihValorUno   = 1;
   ihValorCero  = 0;

   vDTrazasLog (szExeName,"\n\t\t* Parametros de Entra Saldo Anterior"
                          "\n\t\t=> Cod.Cliente  [%ld]"
                          "\n\t\t=> FecEmision   [%s] ",LOG05,
                          lCodCliente,szSysDate);

    /* EXEC SQL
         SELECT /o+ index (CO_CARTERA PK_CO_CARTERA) o/
                NVL(SUM(A.IMPORTE_DEBE-A.IMPORTE_HABER),:ihValorCero)
         INTO   :dhImporte
         FROM   CO_CARTERA A
         WHERE  A.COD_CLIENTE	= :lhCodCliente
         AND    A.FEC_CADUCIDA  <= SYSDATE
         AND    A.IND_FACTURADO  = :ihValorUno
         AND   (A.NUM_CUOTA = :ihValorCero OR A.NUM_CUOTA IS NULL)
	 AND NOT EXISTS ( SELECT :ihValorUno
                	  FROM CO_CODIGOS F
                          WHERE F.NOM_TABLA   = 'CO_CARTERA'
                	  AND F.NOM_COLUMNA = 'COD_TIPDOCUM'
                          AND F.COD_VALOR   = A.COD_TIPDOCUM ); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select  /*+  index (CO_CARTERA PK_CO_CARTERA)  +*/ NVL(su\
m((A.IMPORTE_DEBE-A.IMPORTE_HABER)),:b0) into :b1  from CO_CARTERA A where (((\
(A.COD_CLIENTE=:b2 and A.FEC_CADUCIDA<=SYSDATE) and A.IND_FACTURADO=:b3) and (\
A.NUM_CUOTA=:b0 or A.NUM_CUOTA is null )) and  not exists (select :b3  from CO\
_CODIGOS F where ((F.NOM_TABLA='CO_CARTERA' and F.NOM_COLUMNA='COD_TIPDOCUM') \
and F.COD_VALOR=A.COD_TIPDOCUM)))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )136;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihValorCero;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&dhImporte;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
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
    sqlstm.sqhstv[3] = (unsigned char  *)&ihValorUno;
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
    sqlstm.sqhstv[5] = (unsigned char  *)&ihValorUno;
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



    if (SQLCODE != SQLOK)
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,"Co_Cartera", szfnORAerror());
        return  (FALSE);
     }
     else
     {
        *dImpSaldoAnt = dhImporte;
        vDTrazasLog ("bfnGetSaldoAnt","\t\t=> Importe Saldo Anterior: [%f]\n", LOG05, *dImpSaldoAnt);
        return  (TRUE);
     }
}/****************************** Final bfnGetSaldoAnt ************************/

/*****************************************************************************/
/*                          funcion : bfnGetTotDocu                          */
/*****************************************************************************/
static BOOL bfnGetTotDocu (HISTDOCU *pHis)
{
    int    i        = 0  ;
    for (i=0;i<stPreFactura.iNumRegistros;i++)
    {
        if (stPreFactura.A_PFactura[i].lNumProceso      == stStatus.IdPro       &&
            stPreFactura.A_PFactura[i].lCodCliente      == pHis->lCodCliente )
        {
            if (stPreFactura.A_PFactura[i].iCodTipConce != IMPUESTO )
               {
                  if (stPreFactura.A_PFactura[i].iFlagImpues  == 1)
                      pHis->dAcumNetoGrav   += fnCnvDouble (stPreFactura.A_PFactura[i].dImpFacturable,USOFACT);
                  else
                      pHis->dAcumNetoNoGrav += fnCnvDouble ( stPreFactura.A_PFactura[i].dImpFacturable,USOFACT);
                }
            if (stPreFactura.A_PFactura[i].iCodTipConce == IMPUESTO)
               pHis->dAcumIva        += fnCnvDouble(stPreFactura.A_PFactura[i].dImpFacturable,USOFACT);
            if (stPreFactura.A_PFactura[i].iCodTipConce == DESCUENTO)
               pHis->dTotDescuento   += fnCnvDouble(stPreFactura.A_PFactura[i].dImpFacturable,USOFACT);
        }
    }

    /*********************************************************/
    /* Realizacion de ajuste de IVA en factura (FA_HISTDOCU) */
    /*********************************************************/
    if(stPreFactura.iNumRegistros > 0)
    {
        pHis->dTotCargosMe = fnCnvDouble(pHis->dAcumNetoGrav + pHis->dAcumNetoNoGrav + pHis->dAcumIva,USOFACT);
    }

    pHis->dTotCuotas  = 0;
    pHis->dTotFactura = fnCnvDouble(pHis->dTotCargosMe,USOFACT);
    pHis->dTotPagar   = fnCnvDouble(( (pHis->iCodModVenta == iREGALO )?0.0 :pHis->dTotFactura ),USOFACT);

   return TRUE;
}/************************** Final bfnGetTotDocu *****************************/


/*****************************************************************************/
/*                        funcion : bfnValCatImpDocu                         */
/*****************************************************************************/
static BOOL bfnValCatImpDocu (long lCodClie, int *bpAfecto , int *bpExento )
{
    int    i = 0     ;
    vDTrazasLog (szExeName,"\n\t\t\t* Validando Categoria Impositiva de Conceptos",LOG03);
    *bpAfecto = (int)  FALSE ;
    *bpExento = (int)  TRUE ;

    if (stPreFactura.iNumRegistros == 0)
    {
        vDTrazasLog   (szExeName,"\t\t\t* Cantidad de Conceptos Cero => Cliente [%ld]"
                                 "\n\t\t\t* Se asume Afecto "
                                ,LOG03,lCodClie);
        *bpAfecto = (int) TRUE;
    }
	else
	{
	    for (i=0;i<stPreFactura.iNumRegistros;i++)
	    {
	        if (stPreFactura.A_PFactura[i].lNumProceso         == stStatus.IdPro     &&
	            stPreFactura.A_PFactura[i].lCodCliente         == lCodClie           &&
	            stPreFactura.A_PFactura[i].iCodTipConce        != IMPUESTO           &&
	            stPreFactura.A_PFactura[i].dImpFacturable      !=  0.0             )
	        {
	            switch (stPreFactura.A_PFactura[i].iFlagImpues )
	            {
	                case    iCODCATRIBUT_AFECTO :
	                        *bpAfecto = (int) TRUE;
	                        break;
	                case    iCODCATRIBUT_EXENTO :
	                        *bpExento = (int) TRUE;
	                        break;
	            }
	        }
	    }
	}
    return TRUE;
}/************************** Final bfnValCatImpDocu **************************/


/*****************************************************************************/
/*                            funcion : bfnInsertHistDocu                    */
/*****************************************************************************/
BOOL bfnInsertHistDocu (HISTDOCU *pHis)
{
    char szCadena  [3000] = "";
    char szNomTable[25]   = "";
    char szFuncion [99]   = "";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         static short i_shFecVencimie         ;
         static short i_shFecCaducida         ;
         static short i_shFecProxVenc         ;
         static short i_shCodCiclFact         ;
         static short i_shNumSecuRel          ;
         static short i_shLetraRel            ;
         static short i_shCodTipDocumRel      ;
         static short i_shCodVendedorAgenteRel;
         static short i_shCodCentrRel         ;
         static short i_shNumVenta            ;
         static short i_shNumTransaccion      ;
         static short i_shCodOpRedFija        ;
         static short i_shCodModVenta         ;
         static short i_shCodOficina          ;
         static short i_shCodDespacho         ;
         static short i_shNomEmail            ;
         static short i_shKeyConTecnico       ;
         static short i_shContTecnico         ;  
         static short i_shCodTipologia        ;/* P-MIX-09003 133873 */
         static short i_shCodAreaImputable    ;/* P-MIX-09003 133873 */
         static short i_shCodAreaSolicitante  ;/* P-MIX-09003 133873 */
         char         szhCodTipologia       [5+1]; /* EXEC SQL VAR szhCodTipologia    IS STRING(6); */ 
 /* P-MIX-09003 133873 */
         char         szhCodAreaImputable   [5+1]; /* EXEC SQL VAR szhCodAreaImputable   IS STRING(6); */ 
 /* P-MIX-09003 133873 */
         char         szhCodAreaSolicitante [5+1]; /* EXEC SQL VAR szhCodAreaSolicitante IS STRING(6); */ 
 /* P-MIX-09003 133873 */
    /* EXEC SQL END DECLARE SECTION; */ 


    i_shFecVencimie           = (strcmp (pHis->szFecVencimie,""))?0:ORA_NULL;
    i_shFecCaducida           = (strcmp (pHis->szFecCaducida,""))?0:ORA_NULL;
    i_shFecProxVenc           = (strcmp (pHis->szFecProxVenc,""))?0:ORA_NULL;
    i_shCodCiclFact           = (pHis->lCodCiclFact    == ORA_NULL||
                                 pHis->lCodCiclFact    == 0)?ORA_NULL:0;
    i_shNumSecuRel            = (pHis->lNumSecuRel     == ORA_NULL||
                                 pHis->lNumSecuRel     == 0)?ORA_NULL:0;
    i_shLetraRel              = (pHis->szLetraRel[0]   == 0)?ORA_NULL:0;
    i_shCodTipDocumRel        = (pHis->iCodTipDocumRel == ORA_NULL||
                                 pHis->iCodTipDocumRel == 0)?ORA_NULL:0;
    i_shCodVendedorAgenteRel  = (pHis->lCodVendedorAgenteRel == ORA_NULL||
                                 pHis->lCodVendedorAgenteRel == 0)?ORA_NULL:0;
    i_shCodCentrRel           = (pHis->iCodCentrRel    == ORA_NULL||
                                 pHis->iCodCentrRel    == 0)?ORA_NULL:0;
    i_shNumVenta              = (pHis->lNumVenta       == ORA_NULL||
                                 pHis->lNumVenta       == 0)?ORA_NULL:0;
    i_shNumTransaccion        = (pHis->lNumTransaccion == ORA_NULL||
                                 pHis->lNumTransaccion == 0)?ORA_NULL:0;
    i_shCodModVenta           = (pHis->iCodModVenta    <= 0)?ORA_NULL:0;
    i_shCodOpRedFija          = (pHis->iCodOpRedFija   == 0)?ORA_NULL:0;
    i_shCodOficina            = (strcmp (pHis->szCodOficina,""))?0:ORA_NULL;
    i_shCodDespacho           = (strcmp (pHis->szCodDespacho,""))?0:ORA_NULL;
    i_shNomEmail              = (strcmp (pHis->szNomEmail,""))?0:ORA_NULL; 
    i_shKeyConTecnico         = (strcmp (pHis->szKeyConTecnico,""))?0:ORA_NULL;
    i_shContTecnico           = (strcmp (pHis->szContTecnico,""))?0:ORA_NULL;   
    i_shCodTipologia          = (strcmp (pHis->szCodTipologia,""))?0:ORA_NULL; /* P-MIX-09003 133873 */
    i_shCodAreaImputable      = (strcmp (pHis->szCodAreaImputable,""))?0:ORA_NULL; /* P-MIX-09003 133873 */
    i_shCodAreaSolicitante    = (strcmp (pHis->szCodAreaSolicitante,""))?0:ORA_NULL; /* P-MIX-09003 133873 */

    pHis->dTotPagar       = fnCnvDouble (pHis->dTotPagar      ,USOFACT);
    pHis->dTotCargosMe    = fnCnvDouble (pHis->dTotCargosMe   ,USOFACT);
    pHis->dAcumNetoGrav   = fnCnvDouble (pHis->dAcumNetoGrav  ,USOFACT);
    pHis->dAcumIva        = fnCnvDouble (pHis->dAcumIva       ,USOFACT);
    pHis->dImpSaldoAnt    = fnCnvDouble (pHis->dImpSaldoAnt   ,USOFACT);
    pHis->dTotFactura     = fnCnvDouble (pHis->dTotFactura    ,USOFACT);
    pHis->dTotCuotas      = fnCnvDouble (pHis->dTotCuotas     ,USOFACT);
    pHis->dTotDescuento   = fnCnvDouble (pHis->dTotDescuento  ,USOFACT);

    pHis->dAcumIva        = pHis->dAcumIva;        /* P-MIX-09003 */
    pHis->dImpSaldoAnt    = pHis->dImpSaldoAnt;    /* P-MIX-09003 */
    pHis->dTotFactura     = pHis->dTotFactura;     /* P-MIX-09003 */
    pHis->dTotCuotas      = pHis->dTotCuotas;      /* P-MIX-09003 */
    pHis->dAcumNetoNoGrav = pHis->dAcumNetoNoGrav; /* P-MIX-09003 */
    pHis->dTotCargosMe    = pHis->dTotCargosMe;    /* P-MIX-09003 */
    pHis->dTotPagar       = pHis->dTotPagar;       /* P-MIX-09003 */
    pHis->dTotDescuento   = pHis->dTotDescuento;   /* P-MIX-09003 */
    pHis->dAcumNetoGrav   = pHis->dTotFactura - (pHis->dAcumNetoNoGrav + pHis->dAcumIva);
  
    vDTrazasLog   (szExeName, "\n\t\t\t*************************  => Cliente [%f]"
                              "\n\t\t\t "
                            , LOG05
                            , pHis->dhImpConversion);

    pHis->dhImpConversion = fnCnvDouble (pHis->dhImpConversion,USOFACT);

    if (stProceso.iCodTipDocum == FACT_CICLO)
    {
        sprintf(szNomTable,"FA_FACTDOCU_%ld",stCiclo.lCodCiclFact);
    }
    else
    {
        strcpy (szNomTable,"FA_FACTDOCU_NOCICLO");
        if (stProceso.iCodTipDocum == NOTACRED)
        {   /* P-MIX-09003 */
            memset(szhCodTipologia,0,sizeof(szhCodTipologia));
            memset(szhCodAreaImputable,0,sizeof(szhCodAreaImputable));
            memset(szhCodAreaSolicitante,0,sizeof(szhCodAreaSolicitante));

            if (!bfnFindDatosAuditoria(pHis,szhCodTipologia,szhCodAreaImputable,szhCodAreaSolicitante))
            {          	
            	vDTrazasLog (szExeName, "\n\t** Error en recuperacion de Datos Auditoria Tabla FA_AJUSTES\n"
            	                      , LOG01);
                i_shCodTipologia          = (strcmp (szhCodTipologia,""))?0:ORA_NULL; /* P-MIX-09003 133873 */
                i_shCodAreaImputable      = (strcmp (szhCodAreaImputable,""))?0:ORA_NULL; /* P-MIX-09003 133873 */
                i_shCodAreaSolicitante    = (strcmp (szhCodAreaSolicitante,""))?0:ORA_NULL; /* P-MIX-09003 133873 */            	                      
            }
            
            strcpy(pHis->szCodTipologia,szhCodTipologia);
            strcpy(pHis->szCodAreaImputable,szhCodAreaImputable);
            strcpy(pHis->szCodAreaSolicitante,szhCodAreaSolicitante);
            /* P-MIX-09003 */            
        }
    }

    vfnPrintHistDocu (pHis,szNomTable,stProceso.iCodTipDocum);
    vfnInitCadenaInsertHistDocu (szCadena,szNomTable);

    /* EXEC SQL PREPARE sql_insert_histdocu FROM :szCadena; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )175;
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


    if (SQLCODE)
    {
        strcpy (szFuncion,"PrePare=>");
        strcat (szFuncion,szNomTable);
        iDError(szExeName,ERR000,vInsertarIncidencia,szFuncion,szfnORAerror());
        return FALSE;
    }
    
    /* P-MIX-09003 133873 */
    if (stProceso.iCodTipDocum == FACT_CICLO)
    {
        /* EXEC SQL EXECUTE sql_insert_histdocu
         USING :pHis->lNumSecuenci                                  , :pHis->iCodTipDocum                                  ,
               :pHis->lCodVendedorAgente                            , :pHis->szLetra                                       ,
               :pHis->iCodCentrEmi                                  , :pHis->dTotPagar                                     ,
               :pHis->dTotCargosMe                                  , :pHis->dTotFactura                                   ,
               :pHis->dTotCuotas                                    , :pHis->dTotDescuento                                 ,
               :pHis->lCodVendedor                                  , :pHis->lCodCliente                                   ,
               :pHis->szFecEmision                                  , :pHis->szFecCambioMo                                 ,
               :pHis->szNomUsuarOra                                 , :pHis->dAcumNetoGrav                                 ,
               :pHis->dAcumNetoNoGrav                               , :pHis->dAcumIva                                      ,
               :pHis->szIndOrdenTotal                               , :pHis->iIndFactur                                    ,
               :pHis->iIndVisada                                    , :pHis->iIndLibroIva                                  ,
               :pHis->iIndPasoCobro                                 , :pHis->iIndSuperTel                                  ,
               :pHis->iIndAnulada                                   , :pHis->lNumProceso                                   ,
               :pHis->lNumFolio                                     , :pHis->szNumCTC                                      ,
               :pHis->lCodPlanCom                                   , :pHis->iCodCatImpos                                  ,
               :pHis->szFecVencimie        :i_shFecVencimie         , :pHis->szFecCaducida        :i_shFecCaducida         ,
               :pHis->szFecProxVenc        :i_shFecProxVenc         , :pHis->lCodCiclFact         :i_shCodCiclFact         ,
               :pHis->lNumSecuRel          :i_shNumSecuRel          , :pHis->szLetraRel           :i_shLetraRel            ,
               :pHis->iCodTipDocumRel      :i_shCodTipDocumRel      , :pHis->lCodVendedorAgenteRel:i_shCodVendedorAgenteRel,
               :pHis->iCodCentrRel         :i_shCodCentrRel         , :pHis->lNumVenta            :i_shNumVenta            ,
               :pHis->lNumTransaccion      :i_shNumTransaccion      , :pHis->iCodModVenta         :i_shCodModVenta         ,                   
               :pHis->iNumCuotas                                    , :pHis->dImpSaldoAnt                                  ,
               :pHis->iCodOpRedFija        :i_shCodOpRedFija        , :pHis->szCodOficina         :i_shCodOficina          ,
               :pHis->iCodZonaImpo                                  , :pHis->szPrefPlaza                                   ,
               :pHis->szCodOperadora                                , :pHis->szCodPlaza                                    ,
               :pHis->szhCodMonedaImp                               , :pHis->dhImpConversion                               ,
               :pHis->szCodSegmentacion                             , :pHis->szCodDespacho        :i_shCodDespacho         ,
               :pHis->szNomEmail           :i_shNomEmail            , :pHis->szKeyConTecnico      :i_shKeyConTecnico       ,
               :pHis->szContTecnico        :i_shContTecnico         ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 57;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )194;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&(pHis->lNumSecuenci);
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&(pHis->iCodTipDocum);
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&(pHis->lCodVendedorAgente);
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)(pHis->szLetra);
        sqlstm.sqhstl[3] = (unsigned long )2;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&(pHis->iCodCentrEmi);
        sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&(pHis->dTotPagar);
        sqlstm.sqhstl[5] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)&(pHis->dTotCargosMe);
        sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)&(pHis->dTotFactura);
        sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)&(pHis->dTotCuotas);
        sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[8] = (         int  )0;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)&(pHis->dTotDescuento);
        sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[9] = (         int  )0;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)&(pHis->lCodVendedor);
        sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[10] = (         int  )0;
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
        sqlstm.sqhstv[11] = (unsigned char  *)&(pHis->lCodCliente);
        sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[11] = (         int  )0;
        sqlstm.sqindv[11] = (         short *)0;
        sqlstm.sqinds[11] = (         int  )0;
        sqlstm.sqharm[11] = (unsigned long )0;
        sqlstm.sqadto[11] = (unsigned short )0;
        sqlstm.sqtdso[11] = (unsigned short )0;
        sqlstm.sqhstv[12] = (unsigned char  *)(pHis->szFecEmision);
        sqlstm.sqhstl[12] = (unsigned long )15;
        sqlstm.sqhsts[12] = (         int  )0;
        sqlstm.sqindv[12] = (         short *)0;
        sqlstm.sqinds[12] = (         int  )0;
        sqlstm.sqharm[12] = (unsigned long )0;
        sqlstm.sqadto[12] = (unsigned short )0;
        sqlstm.sqtdso[12] = (unsigned short )0;
        sqlstm.sqhstv[13] = (unsigned char  *)(pHis->szFecCambioMo);
        sqlstm.sqhstl[13] = (unsigned long )15;
        sqlstm.sqhsts[13] = (         int  )0;
        sqlstm.sqindv[13] = (         short *)0;
        sqlstm.sqinds[13] = (         int  )0;
        sqlstm.sqharm[13] = (unsigned long )0;
        sqlstm.sqadto[13] = (unsigned short )0;
        sqlstm.sqtdso[13] = (unsigned short )0;
        sqlstm.sqhstv[14] = (unsigned char  *)(pHis->szNomUsuarOra);
        sqlstm.sqhstl[14] = (unsigned long )31;
        sqlstm.sqhsts[14] = (         int  )0;
        sqlstm.sqindv[14] = (         short *)0;
        sqlstm.sqinds[14] = (         int  )0;
        sqlstm.sqharm[14] = (unsigned long )0;
        sqlstm.sqadto[14] = (unsigned short )0;
        sqlstm.sqtdso[14] = (unsigned short )0;
        sqlstm.sqhstv[15] = (unsigned char  *)&(pHis->dAcumNetoGrav);
        sqlstm.sqhstl[15] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[15] = (         int  )0;
        sqlstm.sqindv[15] = (         short *)0;
        sqlstm.sqinds[15] = (         int  )0;
        sqlstm.sqharm[15] = (unsigned long )0;
        sqlstm.sqadto[15] = (unsigned short )0;
        sqlstm.sqtdso[15] = (unsigned short )0;
        sqlstm.sqhstv[16] = (unsigned char  *)&(pHis->dAcumNetoNoGrav);
        sqlstm.sqhstl[16] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[16] = (         int  )0;
        sqlstm.sqindv[16] = (         short *)0;
        sqlstm.sqinds[16] = (         int  )0;
        sqlstm.sqharm[16] = (unsigned long )0;
        sqlstm.sqadto[16] = (unsigned short )0;
        sqlstm.sqtdso[16] = (unsigned short )0;
        sqlstm.sqhstv[17] = (unsigned char  *)&(pHis->dAcumIva);
        sqlstm.sqhstl[17] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[17] = (         int  )0;
        sqlstm.sqindv[17] = (         short *)0;
        sqlstm.sqinds[17] = (         int  )0;
        sqlstm.sqharm[17] = (unsigned long )0;
        sqlstm.sqadto[17] = (unsigned short )0;
        sqlstm.sqtdso[17] = (unsigned short )0;
        sqlstm.sqhstv[18] = (unsigned char  *)(pHis->szIndOrdenTotal);
        sqlstm.sqhstl[18] = (unsigned long )13;
        sqlstm.sqhsts[18] = (         int  )0;
        sqlstm.sqindv[18] = (         short *)0;
        sqlstm.sqinds[18] = (         int  )0;
        sqlstm.sqharm[18] = (unsigned long )0;
        sqlstm.sqadto[18] = (unsigned short )0;
        sqlstm.sqtdso[18] = (unsigned short )0;
        sqlstm.sqhstv[19] = (unsigned char  *)&(pHis->iIndFactur);
        sqlstm.sqhstl[19] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[19] = (         int  )0;
        sqlstm.sqindv[19] = (         short *)0;
        sqlstm.sqinds[19] = (         int  )0;
        sqlstm.sqharm[19] = (unsigned long )0;
        sqlstm.sqadto[19] = (unsigned short )0;
        sqlstm.sqtdso[19] = (unsigned short )0;
        sqlstm.sqhstv[20] = (unsigned char  *)&(pHis->iIndVisada);
        sqlstm.sqhstl[20] = (unsigned long )sizeof(short);
        sqlstm.sqhsts[20] = (         int  )0;
        sqlstm.sqindv[20] = (         short *)0;
        sqlstm.sqinds[20] = (         int  )0;
        sqlstm.sqharm[20] = (unsigned long )0;
        sqlstm.sqadto[20] = (unsigned short )0;
        sqlstm.sqtdso[20] = (unsigned short )0;
        sqlstm.sqhstv[21] = (unsigned char  *)&(pHis->iIndLibroIva);
        sqlstm.sqhstl[21] = (unsigned long )sizeof(short);
        sqlstm.sqhsts[21] = (         int  )0;
        sqlstm.sqindv[21] = (         short *)0;
        sqlstm.sqinds[21] = (         int  )0;
        sqlstm.sqharm[21] = (unsigned long )0;
        sqlstm.sqadto[21] = (unsigned short )0;
        sqlstm.sqtdso[21] = (unsigned short )0;
        sqlstm.sqhstv[22] = (unsigned char  *)&(pHis->iIndPasoCobro);
        sqlstm.sqhstl[22] = (unsigned long )sizeof(short);
        sqlstm.sqhsts[22] = (         int  )0;
        sqlstm.sqindv[22] = (         short *)0;
        sqlstm.sqinds[22] = (         int  )0;
        sqlstm.sqharm[22] = (unsigned long )0;
        sqlstm.sqadto[22] = (unsigned short )0;
        sqlstm.sqtdso[22] = (unsigned short )0;
        sqlstm.sqhstv[23] = (unsigned char  *)&(pHis->iIndSuperTel);
        sqlstm.sqhstl[23] = (unsigned long )sizeof(short);
        sqlstm.sqhsts[23] = (         int  )0;
        sqlstm.sqindv[23] = (         short *)0;
        sqlstm.sqinds[23] = (         int  )0;
        sqlstm.sqharm[23] = (unsigned long )0;
        sqlstm.sqadto[23] = (unsigned short )0;
        sqlstm.sqtdso[23] = (unsigned short )0;
        sqlstm.sqhstv[24] = (unsigned char  *)&(pHis->iIndAnulada);
        sqlstm.sqhstl[24] = (unsigned long )sizeof(short);
        sqlstm.sqhsts[24] = (         int  )0;
        sqlstm.sqindv[24] = (         short *)0;
        sqlstm.sqinds[24] = (         int  )0;
        sqlstm.sqharm[24] = (unsigned long )0;
        sqlstm.sqadto[24] = (unsigned short )0;
        sqlstm.sqtdso[24] = (unsigned short )0;
        sqlstm.sqhstv[25] = (unsigned char  *)&(pHis->lNumProceso);
        sqlstm.sqhstl[25] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[25] = (         int  )0;
        sqlstm.sqindv[25] = (         short *)0;
        sqlstm.sqinds[25] = (         int  )0;
        sqlstm.sqharm[25] = (unsigned long )0;
        sqlstm.sqadto[25] = (unsigned short )0;
        sqlstm.sqtdso[25] = (unsigned short )0;
        sqlstm.sqhstv[26] = (unsigned char  *)&(pHis->lNumFolio);
        sqlstm.sqhstl[26] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[26] = (         int  )0;
        sqlstm.sqindv[26] = (         short *)0;
        sqlstm.sqinds[26] = (         int  )0;
        sqlstm.sqharm[26] = (unsigned long )0;
        sqlstm.sqadto[26] = (unsigned short )0;
        sqlstm.sqtdso[26] = (unsigned short )0;
        sqlstm.sqhstv[27] = (unsigned char  *)(pHis->szNumCTC);
        sqlstm.sqhstl[27] = (unsigned long )13;
        sqlstm.sqhsts[27] = (         int  )0;
        sqlstm.sqindv[27] = (         short *)0;
        sqlstm.sqinds[27] = (         int  )0;
        sqlstm.sqharm[27] = (unsigned long )0;
        sqlstm.sqadto[27] = (unsigned short )0;
        sqlstm.sqtdso[27] = (unsigned short )0;
        sqlstm.sqhstv[28] = (unsigned char  *)&(pHis->lCodPlanCom);
        sqlstm.sqhstl[28] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[28] = (         int  )0;
        sqlstm.sqindv[28] = (         short *)0;
        sqlstm.sqinds[28] = (         int  )0;
        sqlstm.sqharm[28] = (unsigned long )0;
        sqlstm.sqadto[28] = (unsigned short )0;
        sqlstm.sqtdso[28] = (unsigned short )0;
        sqlstm.sqhstv[29] = (unsigned char  *)&(pHis->iCodCatImpos);
        sqlstm.sqhstl[29] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[29] = (         int  )0;
        sqlstm.sqindv[29] = (         short *)0;
        sqlstm.sqinds[29] = (         int  )0;
        sqlstm.sqharm[29] = (unsigned long )0;
        sqlstm.sqadto[29] = (unsigned short )0;
        sqlstm.sqtdso[29] = (unsigned short )0;
        sqlstm.sqhstv[30] = (unsigned char  *)(pHis->szFecVencimie);
        sqlstm.sqhstl[30] = (unsigned long )15;
        sqlstm.sqhsts[30] = (         int  )0;
        sqlstm.sqindv[30] = (         short *)&i_shFecVencimie;
        sqlstm.sqinds[30] = (         int  )0;
        sqlstm.sqharm[30] = (unsigned long )0;
        sqlstm.sqadto[30] = (unsigned short )0;
        sqlstm.sqtdso[30] = (unsigned short )0;
        sqlstm.sqhstv[31] = (unsigned char  *)(pHis->szFecCaducida);
        sqlstm.sqhstl[31] = (unsigned long )15;
        sqlstm.sqhsts[31] = (         int  )0;
        sqlstm.sqindv[31] = (         short *)&i_shFecCaducida;
        sqlstm.sqinds[31] = (         int  )0;
        sqlstm.sqharm[31] = (unsigned long )0;
        sqlstm.sqadto[31] = (unsigned short )0;
        sqlstm.sqtdso[31] = (unsigned short )0;
        sqlstm.sqhstv[32] = (unsigned char  *)(pHis->szFecProxVenc);
        sqlstm.sqhstl[32] = (unsigned long )15;
        sqlstm.sqhsts[32] = (         int  )0;
        sqlstm.sqindv[32] = (         short *)&i_shFecProxVenc;
        sqlstm.sqinds[32] = (         int  )0;
        sqlstm.sqharm[32] = (unsigned long )0;
        sqlstm.sqadto[32] = (unsigned short )0;
        sqlstm.sqtdso[32] = (unsigned short )0;
        sqlstm.sqhstv[33] = (unsigned char  *)&(pHis->lCodCiclFact);
        sqlstm.sqhstl[33] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[33] = (         int  )0;
        sqlstm.sqindv[33] = (         short *)&i_shCodCiclFact;
        sqlstm.sqinds[33] = (         int  )0;
        sqlstm.sqharm[33] = (unsigned long )0;
        sqlstm.sqadto[33] = (unsigned short )0;
        sqlstm.sqtdso[33] = (unsigned short )0;
        sqlstm.sqhstv[34] = (unsigned char  *)&(pHis->lNumSecuRel);
        sqlstm.sqhstl[34] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[34] = (         int  )0;
        sqlstm.sqindv[34] = (         short *)&i_shNumSecuRel;
        sqlstm.sqinds[34] = (         int  )0;
        sqlstm.sqharm[34] = (unsigned long )0;
        sqlstm.sqadto[34] = (unsigned short )0;
        sqlstm.sqtdso[34] = (unsigned short )0;
        sqlstm.sqhstv[35] = (unsigned char  *)(pHis->szLetraRel);
        sqlstm.sqhstl[35] = (unsigned long )2;
        sqlstm.sqhsts[35] = (         int  )0;
        sqlstm.sqindv[35] = (         short *)&i_shLetraRel;
        sqlstm.sqinds[35] = (         int  )0;
        sqlstm.sqharm[35] = (unsigned long )0;
        sqlstm.sqadto[35] = (unsigned short )0;
        sqlstm.sqtdso[35] = (unsigned short )0;
        sqlstm.sqhstv[36] = (unsigned char  *)&(pHis->iCodTipDocumRel);
        sqlstm.sqhstl[36] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[36] = (         int  )0;
        sqlstm.sqindv[36] = (         short *)&i_shCodTipDocumRel;
        sqlstm.sqinds[36] = (         int  )0;
        sqlstm.sqharm[36] = (unsigned long )0;
        sqlstm.sqadto[36] = (unsigned short )0;
        sqlstm.sqtdso[36] = (unsigned short )0;
        sqlstm.sqhstv[37] = (unsigned char  *)&(pHis->lCodVendedorAgenteRel);
        sqlstm.sqhstl[37] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[37] = (         int  )0;
        sqlstm.sqindv[37] = (         short *)&i_shCodVendedorAgenteRel;
        sqlstm.sqinds[37] = (         int  )0;
        sqlstm.sqharm[37] = (unsigned long )0;
        sqlstm.sqadto[37] = (unsigned short )0;
        sqlstm.sqtdso[37] = (unsigned short )0;
        sqlstm.sqhstv[38] = (unsigned char  *)&(pHis->iCodCentrRel);
        sqlstm.sqhstl[38] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[38] = (         int  )0;
        sqlstm.sqindv[38] = (         short *)&i_shCodCentrRel;
        sqlstm.sqinds[38] = (         int  )0;
        sqlstm.sqharm[38] = (unsigned long )0;
        sqlstm.sqadto[38] = (unsigned short )0;
        sqlstm.sqtdso[38] = (unsigned short )0;
        sqlstm.sqhstv[39] = (unsigned char  *)&(pHis->lNumVenta);
        sqlstm.sqhstl[39] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[39] = (         int  )0;
        sqlstm.sqindv[39] = (         short *)&i_shNumVenta;
        sqlstm.sqinds[39] = (         int  )0;
        sqlstm.sqharm[39] = (unsigned long )0;
        sqlstm.sqadto[39] = (unsigned short )0;
        sqlstm.sqtdso[39] = (unsigned short )0;
        sqlstm.sqhstv[40] = (unsigned char  *)&(pHis->lNumTransaccion);
        sqlstm.sqhstl[40] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[40] = (         int  )0;
        sqlstm.sqindv[40] = (         short *)&i_shNumTransaccion;
        sqlstm.sqinds[40] = (         int  )0;
        sqlstm.sqharm[40] = (unsigned long )0;
        sqlstm.sqadto[40] = (unsigned short )0;
        sqlstm.sqtdso[40] = (unsigned short )0;
        sqlstm.sqhstv[41] = (unsigned char  *)&(pHis->iCodModVenta);
        sqlstm.sqhstl[41] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[41] = (         int  )0;
        sqlstm.sqindv[41] = (         short *)&i_shCodModVenta;
        sqlstm.sqinds[41] = (         int  )0;
        sqlstm.sqharm[41] = (unsigned long )0;
        sqlstm.sqadto[41] = (unsigned short )0;
        sqlstm.sqtdso[41] = (unsigned short )0;
        sqlstm.sqhstv[42] = (unsigned char  *)&(pHis->iNumCuotas);
        sqlstm.sqhstl[42] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[42] = (         int  )0;
        sqlstm.sqindv[42] = (         short *)0;
        sqlstm.sqinds[42] = (         int  )0;
        sqlstm.sqharm[42] = (unsigned long )0;
        sqlstm.sqadto[42] = (unsigned short )0;
        sqlstm.sqtdso[42] = (unsigned short )0;
        sqlstm.sqhstv[43] = (unsigned char  *)&(pHis->dImpSaldoAnt);
        sqlstm.sqhstl[43] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[43] = (         int  )0;
        sqlstm.sqindv[43] = (         short *)0;
        sqlstm.sqinds[43] = (         int  )0;
        sqlstm.sqharm[43] = (unsigned long )0;
        sqlstm.sqadto[43] = (unsigned short )0;
        sqlstm.sqtdso[43] = (unsigned short )0;
        sqlstm.sqhstv[44] = (unsigned char  *)&(pHis->iCodOpRedFija);
        sqlstm.sqhstl[44] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[44] = (         int  )0;
        sqlstm.sqindv[44] = (         short *)&i_shCodOpRedFija;
        sqlstm.sqinds[44] = (         int  )0;
        sqlstm.sqharm[44] = (unsigned long )0;
        sqlstm.sqadto[44] = (unsigned short )0;
        sqlstm.sqtdso[44] = (unsigned short )0;
        sqlstm.sqhstv[45] = (unsigned char  *)(pHis->szCodOficina);
        sqlstm.sqhstl[45] = (unsigned long )3;
        sqlstm.sqhsts[45] = (         int  )0;
        sqlstm.sqindv[45] = (         short *)&i_shCodOficina;
        sqlstm.sqinds[45] = (         int  )0;
        sqlstm.sqharm[45] = (unsigned long )0;
        sqlstm.sqadto[45] = (unsigned short )0;
        sqlstm.sqtdso[45] = (unsigned short )0;
        sqlstm.sqhstv[46] = (unsigned char  *)&(pHis->iCodZonaImpo);
        sqlstm.sqhstl[46] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[46] = (         int  )0;
        sqlstm.sqindv[46] = (         short *)0;
        sqlstm.sqinds[46] = (         int  )0;
        sqlstm.sqharm[46] = (unsigned long )0;
        sqlstm.sqadto[46] = (unsigned short )0;
        sqlstm.sqtdso[46] = (unsigned short )0;
        sqlstm.sqhstv[47] = (unsigned char  *)(pHis->szPrefPlaza);
        sqlstm.sqhstl[47] = (unsigned long )26;
        sqlstm.sqhsts[47] = (         int  )0;
        sqlstm.sqindv[47] = (         short *)0;
        sqlstm.sqinds[47] = (         int  )0;
        sqlstm.sqharm[47] = (unsigned long )0;
        sqlstm.sqadto[47] = (unsigned short )0;
        sqlstm.sqtdso[47] = (unsigned short )0;
        sqlstm.sqhstv[48] = (unsigned char  *)(pHis->szCodOperadora);
        sqlstm.sqhstl[48] = (unsigned long )6;
        sqlstm.sqhsts[48] = (         int  )0;
        sqlstm.sqindv[48] = (         short *)0;
        sqlstm.sqinds[48] = (         int  )0;
        sqlstm.sqharm[48] = (unsigned long )0;
        sqlstm.sqadto[48] = (unsigned short )0;
        sqlstm.sqtdso[48] = (unsigned short )0;
        sqlstm.sqhstv[49] = (unsigned char  *)(pHis->szCodPlaza);
        sqlstm.sqhstl[49] = (unsigned long )6;
        sqlstm.sqhsts[49] = (         int  )0;
        sqlstm.sqindv[49] = (         short *)0;
        sqlstm.sqinds[49] = (         int  )0;
        sqlstm.sqharm[49] = (unsigned long )0;
        sqlstm.sqadto[49] = (unsigned short )0;
        sqlstm.sqtdso[49] = (unsigned short )0;
        sqlstm.sqhstv[50] = (unsigned char  *)(pHis->szhCodMonedaImp);
        sqlstm.sqhstl[50] = (unsigned long )4;
        sqlstm.sqhsts[50] = (         int  )0;
        sqlstm.sqindv[50] = (         short *)0;
        sqlstm.sqinds[50] = (         int  )0;
        sqlstm.sqharm[50] = (unsigned long )0;
        sqlstm.sqadto[50] = (unsigned short )0;
        sqlstm.sqtdso[50] = (unsigned short )0;
        sqlstm.sqhstv[51] = (unsigned char  *)&(pHis->dhImpConversion);
        sqlstm.sqhstl[51] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[51] = (         int  )0;
        sqlstm.sqindv[51] = (         short *)0;
        sqlstm.sqinds[51] = (         int  )0;
        sqlstm.sqharm[51] = (unsigned long )0;
        sqlstm.sqadto[51] = (unsigned short )0;
        sqlstm.sqtdso[51] = (unsigned short )0;
        sqlstm.sqhstv[52] = (unsigned char  *)(pHis->szCodSegmentacion);
        sqlstm.sqhstl[52] = (unsigned long )6;
        sqlstm.sqhsts[52] = (         int  )0;
        sqlstm.sqindv[52] = (         short *)0;
        sqlstm.sqinds[52] = (         int  )0;
        sqlstm.sqharm[52] = (unsigned long )0;
        sqlstm.sqadto[52] = (unsigned short )0;
        sqlstm.sqtdso[52] = (unsigned short )0;
        sqlstm.sqhstv[53] = (unsigned char  *)(pHis->szCodDespacho);
        sqlstm.sqhstl[53] = (unsigned long )6;
        sqlstm.sqhsts[53] = (         int  )0;
        sqlstm.sqindv[53] = (         short *)&i_shCodDespacho;
        sqlstm.sqinds[53] = (         int  )0;
        sqlstm.sqharm[53] = (unsigned long )0;
        sqlstm.sqadto[53] = (unsigned short )0;
        sqlstm.sqtdso[53] = (unsigned short )0;
        sqlstm.sqhstv[54] = (unsigned char  *)(pHis->szNomEmail);
        sqlstm.sqhstl[54] = (unsigned long )71;
        sqlstm.sqhsts[54] = (         int  )0;
        sqlstm.sqindv[54] = (         short *)&i_shNomEmail;
        sqlstm.sqinds[54] = (         int  )0;
        sqlstm.sqharm[54] = (unsigned long )0;
        sqlstm.sqadto[54] = (unsigned short )0;
        sqlstm.sqtdso[54] = (unsigned short )0;
        sqlstm.sqhstv[55] = (unsigned char  *)(pHis->szKeyConTecnico);
        sqlstm.sqhstl[55] = (unsigned long )41;
        sqlstm.sqhsts[55] = (         int  )0;
        sqlstm.sqindv[55] = (         short *)&i_shKeyConTecnico;
        sqlstm.sqinds[55] = (         int  )0;
        sqlstm.sqharm[55] = (unsigned long )0;
        sqlstm.sqadto[55] = (unsigned short )0;
        sqlstm.sqtdso[55] = (unsigned short )0;
        sqlstm.sqhstv[56] = (unsigned char  *)(pHis->szContTecnico);
        sqlstm.sqhstl[56] = (unsigned long )41;
        sqlstm.sqhsts[56] = (         int  )0;
        sqlstm.sqindv[56] = (         short *)&i_shContTecnico;
        sqlstm.sqinds[56] = (         int  )0;
        sqlstm.sqharm[56] = (unsigned long )0;
        sqlstm.sqadto[56] = (unsigned short )0;
        sqlstm.sqtdso[56] = (unsigned short )0;
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
        /* EXEC SQL EXECUTE sql_insert_histdocu
         USING :pHis->lNumSecuenci                                  , :pHis->iCodTipDocum                                  ,
               :pHis->lCodVendedorAgente                            , :pHis->szLetra                                       ,
               :pHis->iCodCentrEmi                                  , :pHis->dTotPagar                                     ,
               :pHis->dTotCargosMe                                  , :pHis->dTotFactura                                   ,
               :pHis->dTotCuotas                                    , :pHis->dTotDescuento                                 ,
               :pHis->lCodVendedor                                  , :pHis->lCodCliente                                   ,
               :pHis->szFecEmision                                  , :pHis->szFecCambioMo                                 ,
               :pHis->szNomUsuarOra                                 , :pHis->dAcumNetoGrav                                 ,
               :pHis->dAcumNetoNoGrav                               , :pHis->dAcumIva                                      ,
               :pHis->szIndOrdenTotal                               , :pHis->iIndFactur                                    ,
               :pHis->iIndVisada                                    , :pHis->iIndLibroIva                                  ,
               :pHis->iIndPasoCobro                                 , :pHis->iIndSuperTel                                  ,
               :pHis->iIndAnulada                                   , :pHis->lNumProceso                                   ,
               :pHis->lNumFolio                                     , :pHis->szNumCTC                                      ,
               :pHis->lCodPlanCom                                   , :pHis->iCodCatImpos                                  ,
               :pHis->szFecVencimie        :i_shFecVencimie         , :pHis->szFecCaducida        :i_shFecCaducida         ,
               :pHis->szFecProxVenc        :i_shFecProxVenc         , :pHis->lCodCiclFact         :i_shCodCiclFact         ,
               :pHis->lNumSecuRel          :i_shNumSecuRel          , :pHis->szLetraRel           :i_shLetraRel            ,
               :pHis->iCodTipDocumRel      :i_shCodTipDocumRel      , :pHis->lCodVendedorAgenteRel:i_shCodVendedorAgenteRel,
               :pHis->iCodCentrRel         :i_shCodCentrRel         , :pHis->lNumVenta            :i_shNumVenta            ,
               :pHis->lNumTransaccion      :i_shNumTransaccion      , :pHis->iCodModVenta         :i_shCodModVenta         ,                   
               :pHis->iNumCuotas                                    , :pHis->dImpSaldoAnt                                  ,
               :pHis->iCodOpRedFija        :i_shCodOpRedFija        , :pHis->szCodOficina         :i_shCodOficina          ,
               :pHis->iCodZonaImpo                                  , :pHis->szPrefPlaza                                   ,
               :pHis->szCodOperadora                                , :pHis->szCodPlaza                                    ,
               :pHis->szhCodMonedaImp                               , :pHis->dhImpConversion                               ,
               :pHis->szCodSegmentacion                             , :pHis->szCodDespacho        :i_shCodDespacho         ,
               :pHis->szNomEmail           :i_shNomEmail            , :pHis->szKeyConTecnico      :i_shKeyConTecnico       ,
               :pHis->szContTecnico        :i_shContTecnico         , :pHis->szCodTipologia                                ,
               :pHis->szCodAreaImputable                            , :pHis->szCodAreaSolicitante                          ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 60;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )437;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&(pHis->lNumSecuenci);
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&(pHis->iCodTipDocum);
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&(pHis->lCodVendedorAgente);
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)(pHis->szLetra);
        sqlstm.sqhstl[3] = (unsigned long )2;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&(pHis->iCodCentrEmi);
        sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&(pHis->dTotPagar);
        sqlstm.sqhstl[5] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)&(pHis->dTotCargosMe);
        sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)&(pHis->dTotFactura);
        sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)&(pHis->dTotCuotas);
        sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[8] = (         int  )0;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)&(pHis->dTotDescuento);
        sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[9] = (         int  )0;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)&(pHis->lCodVendedor);
        sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[10] = (         int  )0;
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
        sqlstm.sqhstv[11] = (unsigned char  *)&(pHis->lCodCliente);
        sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[11] = (         int  )0;
        sqlstm.sqindv[11] = (         short *)0;
        sqlstm.sqinds[11] = (         int  )0;
        sqlstm.sqharm[11] = (unsigned long )0;
        sqlstm.sqadto[11] = (unsigned short )0;
        sqlstm.sqtdso[11] = (unsigned short )0;
        sqlstm.sqhstv[12] = (unsigned char  *)(pHis->szFecEmision);
        sqlstm.sqhstl[12] = (unsigned long )15;
        sqlstm.sqhsts[12] = (         int  )0;
        sqlstm.sqindv[12] = (         short *)0;
        sqlstm.sqinds[12] = (         int  )0;
        sqlstm.sqharm[12] = (unsigned long )0;
        sqlstm.sqadto[12] = (unsigned short )0;
        sqlstm.sqtdso[12] = (unsigned short )0;
        sqlstm.sqhstv[13] = (unsigned char  *)(pHis->szFecCambioMo);
        sqlstm.sqhstl[13] = (unsigned long )15;
        sqlstm.sqhsts[13] = (         int  )0;
        sqlstm.sqindv[13] = (         short *)0;
        sqlstm.sqinds[13] = (         int  )0;
        sqlstm.sqharm[13] = (unsigned long )0;
        sqlstm.sqadto[13] = (unsigned short )0;
        sqlstm.sqtdso[13] = (unsigned short )0;
        sqlstm.sqhstv[14] = (unsigned char  *)(pHis->szNomUsuarOra);
        sqlstm.sqhstl[14] = (unsigned long )31;
        sqlstm.sqhsts[14] = (         int  )0;
        sqlstm.sqindv[14] = (         short *)0;
        sqlstm.sqinds[14] = (         int  )0;
        sqlstm.sqharm[14] = (unsigned long )0;
        sqlstm.sqadto[14] = (unsigned short )0;
        sqlstm.sqtdso[14] = (unsigned short )0;
        sqlstm.sqhstv[15] = (unsigned char  *)&(pHis->dAcumNetoGrav);
        sqlstm.sqhstl[15] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[15] = (         int  )0;
        sqlstm.sqindv[15] = (         short *)0;
        sqlstm.sqinds[15] = (         int  )0;
        sqlstm.sqharm[15] = (unsigned long )0;
        sqlstm.sqadto[15] = (unsigned short )0;
        sqlstm.sqtdso[15] = (unsigned short )0;
        sqlstm.sqhstv[16] = (unsigned char  *)&(pHis->dAcumNetoNoGrav);
        sqlstm.sqhstl[16] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[16] = (         int  )0;
        sqlstm.sqindv[16] = (         short *)0;
        sqlstm.sqinds[16] = (         int  )0;
        sqlstm.sqharm[16] = (unsigned long )0;
        sqlstm.sqadto[16] = (unsigned short )0;
        sqlstm.sqtdso[16] = (unsigned short )0;
        sqlstm.sqhstv[17] = (unsigned char  *)&(pHis->dAcumIva);
        sqlstm.sqhstl[17] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[17] = (         int  )0;
        sqlstm.sqindv[17] = (         short *)0;
        sqlstm.sqinds[17] = (         int  )0;
        sqlstm.sqharm[17] = (unsigned long )0;
        sqlstm.sqadto[17] = (unsigned short )0;
        sqlstm.sqtdso[17] = (unsigned short )0;
        sqlstm.sqhstv[18] = (unsigned char  *)(pHis->szIndOrdenTotal);
        sqlstm.sqhstl[18] = (unsigned long )13;
        sqlstm.sqhsts[18] = (         int  )0;
        sqlstm.sqindv[18] = (         short *)0;
        sqlstm.sqinds[18] = (         int  )0;
        sqlstm.sqharm[18] = (unsigned long )0;
        sqlstm.sqadto[18] = (unsigned short )0;
        sqlstm.sqtdso[18] = (unsigned short )0;
        sqlstm.sqhstv[19] = (unsigned char  *)&(pHis->iIndFactur);
        sqlstm.sqhstl[19] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[19] = (         int  )0;
        sqlstm.sqindv[19] = (         short *)0;
        sqlstm.sqinds[19] = (         int  )0;
        sqlstm.sqharm[19] = (unsigned long )0;
        sqlstm.sqadto[19] = (unsigned short )0;
        sqlstm.sqtdso[19] = (unsigned short )0;
        sqlstm.sqhstv[20] = (unsigned char  *)&(pHis->iIndVisada);
        sqlstm.sqhstl[20] = (unsigned long )sizeof(short);
        sqlstm.sqhsts[20] = (         int  )0;
        sqlstm.sqindv[20] = (         short *)0;
        sqlstm.sqinds[20] = (         int  )0;
        sqlstm.sqharm[20] = (unsigned long )0;
        sqlstm.sqadto[20] = (unsigned short )0;
        sqlstm.sqtdso[20] = (unsigned short )0;
        sqlstm.sqhstv[21] = (unsigned char  *)&(pHis->iIndLibroIva);
        sqlstm.sqhstl[21] = (unsigned long )sizeof(short);
        sqlstm.sqhsts[21] = (         int  )0;
        sqlstm.sqindv[21] = (         short *)0;
        sqlstm.sqinds[21] = (         int  )0;
        sqlstm.sqharm[21] = (unsigned long )0;
        sqlstm.sqadto[21] = (unsigned short )0;
        sqlstm.sqtdso[21] = (unsigned short )0;
        sqlstm.sqhstv[22] = (unsigned char  *)&(pHis->iIndPasoCobro);
        sqlstm.sqhstl[22] = (unsigned long )sizeof(short);
        sqlstm.sqhsts[22] = (         int  )0;
        sqlstm.sqindv[22] = (         short *)0;
        sqlstm.sqinds[22] = (         int  )0;
        sqlstm.sqharm[22] = (unsigned long )0;
        sqlstm.sqadto[22] = (unsigned short )0;
        sqlstm.sqtdso[22] = (unsigned short )0;
        sqlstm.sqhstv[23] = (unsigned char  *)&(pHis->iIndSuperTel);
        sqlstm.sqhstl[23] = (unsigned long )sizeof(short);
        sqlstm.sqhsts[23] = (         int  )0;
        sqlstm.sqindv[23] = (         short *)0;
        sqlstm.sqinds[23] = (         int  )0;
        sqlstm.sqharm[23] = (unsigned long )0;
        sqlstm.sqadto[23] = (unsigned short )0;
        sqlstm.sqtdso[23] = (unsigned short )0;
        sqlstm.sqhstv[24] = (unsigned char  *)&(pHis->iIndAnulada);
        sqlstm.sqhstl[24] = (unsigned long )sizeof(short);
        sqlstm.sqhsts[24] = (         int  )0;
        sqlstm.sqindv[24] = (         short *)0;
        sqlstm.sqinds[24] = (         int  )0;
        sqlstm.sqharm[24] = (unsigned long )0;
        sqlstm.sqadto[24] = (unsigned short )0;
        sqlstm.sqtdso[24] = (unsigned short )0;
        sqlstm.sqhstv[25] = (unsigned char  *)&(pHis->lNumProceso);
        sqlstm.sqhstl[25] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[25] = (         int  )0;
        sqlstm.sqindv[25] = (         short *)0;
        sqlstm.sqinds[25] = (         int  )0;
        sqlstm.sqharm[25] = (unsigned long )0;
        sqlstm.sqadto[25] = (unsigned short )0;
        sqlstm.sqtdso[25] = (unsigned short )0;
        sqlstm.sqhstv[26] = (unsigned char  *)&(pHis->lNumFolio);
        sqlstm.sqhstl[26] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[26] = (         int  )0;
        sqlstm.sqindv[26] = (         short *)0;
        sqlstm.sqinds[26] = (         int  )0;
        sqlstm.sqharm[26] = (unsigned long )0;
        sqlstm.sqadto[26] = (unsigned short )0;
        sqlstm.sqtdso[26] = (unsigned short )0;
        sqlstm.sqhstv[27] = (unsigned char  *)(pHis->szNumCTC);
        sqlstm.sqhstl[27] = (unsigned long )13;
        sqlstm.sqhsts[27] = (         int  )0;
        sqlstm.sqindv[27] = (         short *)0;
        sqlstm.sqinds[27] = (         int  )0;
        sqlstm.sqharm[27] = (unsigned long )0;
        sqlstm.sqadto[27] = (unsigned short )0;
        sqlstm.sqtdso[27] = (unsigned short )0;
        sqlstm.sqhstv[28] = (unsigned char  *)&(pHis->lCodPlanCom);
        sqlstm.sqhstl[28] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[28] = (         int  )0;
        sqlstm.sqindv[28] = (         short *)0;
        sqlstm.sqinds[28] = (         int  )0;
        sqlstm.sqharm[28] = (unsigned long )0;
        sqlstm.sqadto[28] = (unsigned short )0;
        sqlstm.sqtdso[28] = (unsigned short )0;
        sqlstm.sqhstv[29] = (unsigned char  *)&(pHis->iCodCatImpos);
        sqlstm.sqhstl[29] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[29] = (         int  )0;
        sqlstm.sqindv[29] = (         short *)0;
        sqlstm.sqinds[29] = (         int  )0;
        sqlstm.sqharm[29] = (unsigned long )0;
        sqlstm.sqadto[29] = (unsigned short )0;
        sqlstm.sqtdso[29] = (unsigned short )0;
        sqlstm.sqhstv[30] = (unsigned char  *)(pHis->szFecVencimie);
        sqlstm.sqhstl[30] = (unsigned long )15;
        sqlstm.sqhsts[30] = (         int  )0;
        sqlstm.sqindv[30] = (         short *)&i_shFecVencimie;
        sqlstm.sqinds[30] = (         int  )0;
        sqlstm.sqharm[30] = (unsigned long )0;
        sqlstm.sqadto[30] = (unsigned short )0;
        sqlstm.sqtdso[30] = (unsigned short )0;
        sqlstm.sqhstv[31] = (unsigned char  *)(pHis->szFecCaducida);
        sqlstm.sqhstl[31] = (unsigned long )15;
        sqlstm.sqhsts[31] = (         int  )0;
        sqlstm.sqindv[31] = (         short *)&i_shFecCaducida;
        sqlstm.sqinds[31] = (         int  )0;
        sqlstm.sqharm[31] = (unsigned long )0;
        sqlstm.sqadto[31] = (unsigned short )0;
        sqlstm.sqtdso[31] = (unsigned short )0;
        sqlstm.sqhstv[32] = (unsigned char  *)(pHis->szFecProxVenc);
        sqlstm.sqhstl[32] = (unsigned long )15;
        sqlstm.sqhsts[32] = (         int  )0;
        sqlstm.sqindv[32] = (         short *)&i_shFecProxVenc;
        sqlstm.sqinds[32] = (         int  )0;
        sqlstm.sqharm[32] = (unsigned long )0;
        sqlstm.sqadto[32] = (unsigned short )0;
        sqlstm.sqtdso[32] = (unsigned short )0;
        sqlstm.sqhstv[33] = (unsigned char  *)&(pHis->lCodCiclFact);
        sqlstm.sqhstl[33] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[33] = (         int  )0;
        sqlstm.sqindv[33] = (         short *)&i_shCodCiclFact;
        sqlstm.sqinds[33] = (         int  )0;
        sqlstm.sqharm[33] = (unsigned long )0;
        sqlstm.sqadto[33] = (unsigned short )0;
        sqlstm.sqtdso[33] = (unsigned short )0;
        sqlstm.sqhstv[34] = (unsigned char  *)&(pHis->lNumSecuRel);
        sqlstm.sqhstl[34] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[34] = (         int  )0;
        sqlstm.sqindv[34] = (         short *)&i_shNumSecuRel;
        sqlstm.sqinds[34] = (         int  )0;
        sqlstm.sqharm[34] = (unsigned long )0;
        sqlstm.sqadto[34] = (unsigned short )0;
        sqlstm.sqtdso[34] = (unsigned short )0;
        sqlstm.sqhstv[35] = (unsigned char  *)(pHis->szLetraRel);
        sqlstm.sqhstl[35] = (unsigned long )2;
        sqlstm.sqhsts[35] = (         int  )0;
        sqlstm.sqindv[35] = (         short *)&i_shLetraRel;
        sqlstm.sqinds[35] = (         int  )0;
        sqlstm.sqharm[35] = (unsigned long )0;
        sqlstm.sqadto[35] = (unsigned short )0;
        sqlstm.sqtdso[35] = (unsigned short )0;
        sqlstm.sqhstv[36] = (unsigned char  *)&(pHis->iCodTipDocumRel);
        sqlstm.sqhstl[36] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[36] = (         int  )0;
        sqlstm.sqindv[36] = (         short *)&i_shCodTipDocumRel;
        sqlstm.sqinds[36] = (         int  )0;
        sqlstm.sqharm[36] = (unsigned long )0;
        sqlstm.sqadto[36] = (unsigned short )0;
        sqlstm.sqtdso[36] = (unsigned short )0;
        sqlstm.sqhstv[37] = (unsigned char  *)&(pHis->lCodVendedorAgenteRel);
        sqlstm.sqhstl[37] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[37] = (         int  )0;
        sqlstm.sqindv[37] = (         short *)&i_shCodVendedorAgenteRel;
        sqlstm.sqinds[37] = (         int  )0;
        sqlstm.sqharm[37] = (unsigned long )0;
        sqlstm.sqadto[37] = (unsigned short )0;
        sqlstm.sqtdso[37] = (unsigned short )0;
        sqlstm.sqhstv[38] = (unsigned char  *)&(pHis->iCodCentrRel);
        sqlstm.sqhstl[38] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[38] = (         int  )0;
        sqlstm.sqindv[38] = (         short *)&i_shCodCentrRel;
        sqlstm.sqinds[38] = (         int  )0;
        sqlstm.sqharm[38] = (unsigned long )0;
        sqlstm.sqadto[38] = (unsigned short )0;
        sqlstm.sqtdso[38] = (unsigned short )0;
        sqlstm.sqhstv[39] = (unsigned char  *)&(pHis->lNumVenta);
        sqlstm.sqhstl[39] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[39] = (         int  )0;
        sqlstm.sqindv[39] = (         short *)&i_shNumVenta;
        sqlstm.sqinds[39] = (         int  )0;
        sqlstm.sqharm[39] = (unsigned long )0;
        sqlstm.sqadto[39] = (unsigned short )0;
        sqlstm.sqtdso[39] = (unsigned short )0;
        sqlstm.sqhstv[40] = (unsigned char  *)&(pHis->lNumTransaccion);
        sqlstm.sqhstl[40] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[40] = (         int  )0;
        sqlstm.sqindv[40] = (         short *)&i_shNumTransaccion;
        sqlstm.sqinds[40] = (         int  )0;
        sqlstm.sqharm[40] = (unsigned long )0;
        sqlstm.sqadto[40] = (unsigned short )0;
        sqlstm.sqtdso[40] = (unsigned short )0;
        sqlstm.sqhstv[41] = (unsigned char  *)&(pHis->iCodModVenta);
        sqlstm.sqhstl[41] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[41] = (         int  )0;
        sqlstm.sqindv[41] = (         short *)&i_shCodModVenta;
        sqlstm.sqinds[41] = (         int  )0;
        sqlstm.sqharm[41] = (unsigned long )0;
        sqlstm.sqadto[41] = (unsigned short )0;
        sqlstm.sqtdso[41] = (unsigned short )0;
        sqlstm.sqhstv[42] = (unsigned char  *)&(pHis->iNumCuotas);
        sqlstm.sqhstl[42] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[42] = (         int  )0;
        sqlstm.sqindv[42] = (         short *)0;
        sqlstm.sqinds[42] = (         int  )0;
        sqlstm.sqharm[42] = (unsigned long )0;
        sqlstm.sqadto[42] = (unsigned short )0;
        sqlstm.sqtdso[42] = (unsigned short )0;
        sqlstm.sqhstv[43] = (unsigned char  *)&(pHis->dImpSaldoAnt);
        sqlstm.sqhstl[43] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[43] = (         int  )0;
        sqlstm.sqindv[43] = (         short *)0;
        sqlstm.sqinds[43] = (         int  )0;
        sqlstm.sqharm[43] = (unsigned long )0;
        sqlstm.sqadto[43] = (unsigned short )0;
        sqlstm.sqtdso[43] = (unsigned short )0;
        sqlstm.sqhstv[44] = (unsigned char  *)&(pHis->iCodOpRedFija);
        sqlstm.sqhstl[44] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[44] = (         int  )0;
        sqlstm.sqindv[44] = (         short *)&i_shCodOpRedFija;
        sqlstm.sqinds[44] = (         int  )0;
        sqlstm.sqharm[44] = (unsigned long )0;
        sqlstm.sqadto[44] = (unsigned short )0;
        sqlstm.sqtdso[44] = (unsigned short )0;
        sqlstm.sqhstv[45] = (unsigned char  *)(pHis->szCodOficina);
        sqlstm.sqhstl[45] = (unsigned long )3;
        sqlstm.sqhsts[45] = (         int  )0;
        sqlstm.sqindv[45] = (         short *)&i_shCodOficina;
        sqlstm.sqinds[45] = (         int  )0;
        sqlstm.sqharm[45] = (unsigned long )0;
        sqlstm.sqadto[45] = (unsigned short )0;
        sqlstm.sqtdso[45] = (unsigned short )0;
        sqlstm.sqhstv[46] = (unsigned char  *)&(pHis->iCodZonaImpo);
        sqlstm.sqhstl[46] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[46] = (         int  )0;
        sqlstm.sqindv[46] = (         short *)0;
        sqlstm.sqinds[46] = (         int  )0;
        sqlstm.sqharm[46] = (unsigned long )0;
        sqlstm.sqadto[46] = (unsigned short )0;
        sqlstm.sqtdso[46] = (unsigned short )0;
        sqlstm.sqhstv[47] = (unsigned char  *)(pHis->szPrefPlaza);
        sqlstm.sqhstl[47] = (unsigned long )26;
        sqlstm.sqhsts[47] = (         int  )0;
        sqlstm.sqindv[47] = (         short *)0;
        sqlstm.sqinds[47] = (         int  )0;
        sqlstm.sqharm[47] = (unsigned long )0;
        sqlstm.sqadto[47] = (unsigned short )0;
        sqlstm.sqtdso[47] = (unsigned short )0;
        sqlstm.sqhstv[48] = (unsigned char  *)(pHis->szCodOperadora);
        sqlstm.sqhstl[48] = (unsigned long )6;
        sqlstm.sqhsts[48] = (         int  )0;
        sqlstm.sqindv[48] = (         short *)0;
        sqlstm.sqinds[48] = (         int  )0;
        sqlstm.sqharm[48] = (unsigned long )0;
        sqlstm.sqadto[48] = (unsigned short )0;
        sqlstm.sqtdso[48] = (unsigned short )0;
        sqlstm.sqhstv[49] = (unsigned char  *)(pHis->szCodPlaza);
        sqlstm.sqhstl[49] = (unsigned long )6;
        sqlstm.sqhsts[49] = (         int  )0;
        sqlstm.sqindv[49] = (         short *)0;
        sqlstm.sqinds[49] = (         int  )0;
        sqlstm.sqharm[49] = (unsigned long )0;
        sqlstm.sqadto[49] = (unsigned short )0;
        sqlstm.sqtdso[49] = (unsigned short )0;
        sqlstm.sqhstv[50] = (unsigned char  *)(pHis->szhCodMonedaImp);
        sqlstm.sqhstl[50] = (unsigned long )4;
        sqlstm.sqhsts[50] = (         int  )0;
        sqlstm.sqindv[50] = (         short *)0;
        sqlstm.sqinds[50] = (         int  )0;
        sqlstm.sqharm[50] = (unsigned long )0;
        sqlstm.sqadto[50] = (unsigned short )0;
        sqlstm.sqtdso[50] = (unsigned short )0;
        sqlstm.sqhstv[51] = (unsigned char  *)&(pHis->dhImpConversion);
        sqlstm.sqhstl[51] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[51] = (         int  )0;
        sqlstm.sqindv[51] = (         short *)0;
        sqlstm.sqinds[51] = (         int  )0;
        sqlstm.sqharm[51] = (unsigned long )0;
        sqlstm.sqadto[51] = (unsigned short )0;
        sqlstm.sqtdso[51] = (unsigned short )0;
        sqlstm.sqhstv[52] = (unsigned char  *)(pHis->szCodSegmentacion);
        sqlstm.sqhstl[52] = (unsigned long )6;
        sqlstm.sqhsts[52] = (         int  )0;
        sqlstm.sqindv[52] = (         short *)0;
        sqlstm.sqinds[52] = (         int  )0;
        sqlstm.sqharm[52] = (unsigned long )0;
        sqlstm.sqadto[52] = (unsigned short )0;
        sqlstm.sqtdso[52] = (unsigned short )0;
        sqlstm.sqhstv[53] = (unsigned char  *)(pHis->szCodDespacho);
        sqlstm.sqhstl[53] = (unsigned long )6;
        sqlstm.sqhsts[53] = (         int  )0;
        sqlstm.sqindv[53] = (         short *)&i_shCodDespacho;
        sqlstm.sqinds[53] = (         int  )0;
        sqlstm.sqharm[53] = (unsigned long )0;
        sqlstm.sqadto[53] = (unsigned short )0;
        sqlstm.sqtdso[53] = (unsigned short )0;
        sqlstm.sqhstv[54] = (unsigned char  *)(pHis->szNomEmail);
        sqlstm.sqhstl[54] = (unsigned long )71;
        sqlstm.sqhsts[54] = (         int  )0;
        sqlstm.sqindv[54] = (         short *)&i_shNomEmail;
        sqlstm.sqinds[54] = (         int  )0;
        sqlstm.sqharm[54] = (unsigned long )0;
        sqlstm.sqadto[54] = (unsigned short )0;
        sqlstm.sqtdso[54] = (unsigned short )0;
        sqlstm.sqhstv[55] = (unsigned char  *)(pHis->szKeyConTecnico);
        sqlstm.sqhstl[55] = (unsigned long )41;
        sqlstm.sqhsts[55] = (         int  )0;
        sqlstm.sqindv[55] = (         short *)&i_shKeyConTecnico;
        sqlstm.sqinds[55] = (         int  )0;
        sqlstm.sqharm[55] = (unsigned long )0;
        sqlstm.sqadto[55] = (unsigned short )0;
        sqlstm.sqtdso[55] = (unsigned short )0;
        sqlstm.sqhstv[56] = (unsigned char  *)(pHis->szContTecnico);
        sqlstm.sqhstl[56] = (unsigned long )41;
        sqlstm.sqhsts[56] = (         int  )0;
        sqlstm.sqindv[56] = (         short *)&i_shContTecnico;
        sqlstm.sqinds[56] = (         int  )0;
        sqlstm.sqharm[56] = (unsigned long )0;
        sqlstm.sqadto[56] = (unsigned short )0;
        sqlstm.sqtdso[56] = (unsigned short )0;
        sqlstm.sqhstv[57] = (unsigned char  *)(pHis->szCodTipologia);
        sqlstm.sqhstl[57] = (unsigned long )6;
        sqlstm.sqhsts[57] = (         int  )0;
        sqlstm.sqindv[57] = (         short *)0;
        sqlstm.sqinds[57] = (         int  )0;
        sqlstm.sqharm[57] = (unsigned long )0;
        sqlstm.sqadto[57] = (unsigned short )0;
        sqlstm.sqtdso[57] = (unsigned short )0;
        sqlstm.sqhstv[58] = (unsigned char  *)(pHis->szCodAreaImputable);
        sqlstm.sqhstl[58] = (unsigned long )6;
        sqlstm.sqhsts[58] = (         int  )0;
        sqlstm.sqindv[58] = (         short *)0;
        sqlstm.sqinds[58] = (         int  )0;
        sqlstm.sqharm[58] = (unsigned long )0;
        sqlstm.sqadto[58] = (unsigned short )0;
        sqlstm.sqtdso[58] = (unsigned short )0;
        sqlstm.sqhstv[59] = (unsigned char  *)(pHis->szCodAreaSolicitante);
        sqlstm.sqhstl[59] = (unsigned long )6;
        sqlstm.sqhsts[59] = (         int  )0;
        sqlstm.sqindv[59] = (         short *)0;
        sqlstm.sqinds[59] = (         int  )0;
        sqlstm.sqharm[59] = (unsigned long )0;
        sqlstm.sqadto[59] = (unsigned short )0;
        sqlstm.sqtdso[59] = (unsigned short )0;
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

    if (SQLCODE)
    {
        strcpy (szFuncion,"Insert=>");
        strcat (szFuncion,szNomTable);
        iDError(szExeName,ERR000,vInsertarIncidencia,szFuncion,szfnORAerror());
        return  FALSE;
    }
    
    return TRUE;

}/**************************** Final bfnInsertHistDocu ***********************/

/*****************************************************************************/
/*                            funcion : vfnPrintHistDocu                     */
/*****************************************************************************/
static void vfnPrintHistDocu (HISTDOCU *pHis,char *szTable, int iCodTipDocum)
{
   char szNomTabla [21] = "";

   strcpy (szNomTabla,szTable);
      
   /* P-MIX-09003 133873 */
   if (stProceso.iCodTipDocum == FACT_CICLO)
   {
       vDTrazasLog ("", "\n\t=> Insertando en %.*s\n"
                        "\t\t Num.Secuenci   [%ld]\n" "\t\t Cod.TipDocum   [%d] \n"
                        "\t\t Cod.VendedorAg.[%ld]\n" "\t\t Letra          [%s] \n"
                        "\t\t Cod.CentrEmi   [%d] \n" "\t\t Tot.Pagar      [%f] \n"
                        "\t\t Tot.Cargos Mes [%f] \n" "\t\t Tot.Factura    [%f] \n"
                        "\t\t Tot.Cuotas     [%f] \n" "\t\t Tot. Descuento [%f] \n"                            
                        "\t\t Cod.Vendedor   [%ld]\n" "\t\t Cod.Cliente    [%ld]\n"
                        "\t\t Fec.Emision    [%s] \n" "\t\t Fec.Cambio Mo  [%s] \n"                  
                        "\t\t Nom.UsuarOra   [%s] \n" "\t\t Acum.NetoGrav  [%f] \n"
                        "\t\t Acum.NetoNoGrav[%f] \n" "\t\t Acum.Iva       [%f] \n"
                        "\t\t Ind.OrdenTotal [%s] \n" "\t\t Ind.Factur     [%d] \n"
                        "\t\t Ind.Visada     [%d] \n" "\t\t Ind.Libro Iva  [%d] \n"                
                        "\t\t Ind.Paso Cobro [%d] \n" "\t\t Ind.SuperTel   [%d] \n"
                        "\t\t Ind.Anulada    [%d] \n" "\t\t Num.Proceso    [%ld]\n"
                        "\t\t Num.Folio      [%ld]\n" "\t\t Num.CTC        [%s] \n"
                        "\t\t Cod.Plan Com.  [%ld]\n" "\t\t Cod.Cat. Impo. [%d] \n"                  
                        "\t\t Fec.Vencimie   [%s] \n" "\t\t Fec.Caducidad  [%s] \n"                  
                        "\t\t Fec.ProxVenc   [%s] \n" "\t\t Cod.CiclFact   [%ld]\n"
                        "\t\t Num.SecuRel    [%ld]\n" "\t\t LetraRel       [%s] \n"
                        "\t\t Cod.TipoDocumRe[%d] \n" "\t\t Cod.Vend.AgenRe[%ld]\n"
                        "\t\t Cod.CentrRel   [%d] \n" "\t\t Num.Venta      [%ld]\n"
                        "\t\t Num.Transacc.  [%ld]\n" "\t\t Cod.Mod. Venta [%d] \n"
                        "\t\t Num.Cuotas     [%d] \n" "\t\t Imp.SaldoAnt   [%f] \n"
                        "\t\t Cod.Op.Red Fija[%d] \n" "\t\t Cod. Oficina   [%s] \n"                                    
                        "\t\t Zona Impositiva[%d] \n" "\t\t Prefijo Plaza  [%s] \n"
                        "\t\t COD_OPERADORA  [%s] \n" "\t\t COD_PLAZA      [%s] \n"
                        "\t\t CodMonedaImp.  [%s] \n" "\t\t ImpConversion  [%f] \n"
                        "\t\t Cod. Segment.  [%s] \n" "\t\t Cod. Despacho  [%s] \n"
                        "\t\t Email          [%s] \n" "\t\t Key Tecnico    [%s] \n"
                        "\t\t Cont. Tecnico  [%s] \n"
                      , LOG05
                      , strlen(szNomTabla), szNomTabla
                      , pHis->lNumSecuenci         , pHis->iCodTipDocum         
                      , pHis->lCodVendedorAgente   , pHis->szLetra              
                      , pHis->iCodCentrEmi         , pHis->dTotPagar            
                      , pHis->dTotCargosMe         , pHis->dTotFactura          
                      , pHis->dTotCuotas           , pHis->dTotDescuento        
                      , pHis->lCodVendedor         , pHis->lCodCliente          
                      , pHis->szFecEmision         , pHis->szFecCambioMo        
                      , pHis->szNomUsuarOra        , pHis->dAcumNetoGrav        
                      , pHis->dAcumNetoNoGrav      , pHis->dAcumIva             
                      , pHis->szIndOrdenTotal      , pHis->iIndFactur           
                      , pHis->iIndVisada           , pHis->iIndLibroIva         
                      , pHis->iIndPasoCobro        , pHis->iIndSuperTel         
                      , pHis->iIndAnulada          , pHis->lNumProceso          
                      , pHis->lNumFolio            , pHis->szNumCTC                               
                      , pHis->lCodPlanCom          , pHis->iCodCatImpos         
                      , pHis->szFecVencimie        , pHis->szFecCaducida        
                      , pHis->szFecProxVenc        , pHis->lCodCiclFact         
                      , pHis->lNumSecuRel          , pHis->szLetraRel           
                      , pHis->iCodTipDocumRel      , pHis->lCodVendedorAgenteRel
                      , pHis->iCodCentrRel         , pHis->lNumVenta            
                      , pHis->lNumTransaccion      , pHis->iCodModVenta         
                      , pHis->iNumCuotas           , pHis->dImpSaldoAnt         
                      , pHis->iCodOpRedFija        , pHis->szCodOficina         
                      , pHis->iCodZonaImpo         , pHis->szPrefPlaza          
                      , pHis->szCodOperadora       , pHis->szCodPlaza           
                      , pHis->szhCodMonedaImp      , pHis->dhImpConversion      
       		      , pHis->szCodSegmentacion    , pHis->szCodDespacho        
       		      , pHis->szNomEmail           , pHis->szKeyConTecnico      
       		      , pHis->szContTecnico        );
    }
    else
    {
       vDTrazasLog ("", "\n\t=> Insertando en %.*s\n"
                        "\t\t Num.Secuenci   [%ld]\n" "\t\t Cod.TipDocum   [%d] \n"
                        "\t\t Cod.VendedorAg.[%ld]\n" "\t\t Letra          [%s] \n"
                        "\t\t Cod.CentrEmi   [%d] \n" "\t\t Tot.Pagar      [%f] \n"
                        "\t\t Tot.Cargos Mes [%f] \n" "\t\t Tot.Factura    [%f] \n"
                        "\t\t Tot.Cuotas     [%f] \n" "\t\t Tot. Descuento [%f] \n"                            
                        "\t\t Cod.Vendedor   [%ld]\n" "\t\t Cod.Cliente    [%ld]\n"
                        "\t\t Fec.Emision    [%s] \n" "\t\t Fec.Cambio Mo  [%s] \n"                  
                        "\t\t Nom.UsuarOra   [%s] \n" "\t\t Acum.NetoGrav  [%f] \n"
                        "\t\t Acum.NetoNoGrav[%f] \n" "\t\t Acum.Iva       [%f] \n"
                        "\t\t Ind.OrdenTotal [%s] \n" "\t\t Ind.Factur     [%d] \n"
                        "\t\t Ind.Visada     [%d] \n" "\t\t Ind.Libro Iva  [%d] \n"                
                        "\t\t Ind.Paso Cobro [%d] \n" "\t\t Ind.SuperTel   [%d] \n"
                        "\t\t Ind.Anulada    [%d] \n" "\t\t Num.Proceso    [%ld]\n"
                        "\t\t Num.Folio      [%ld]\n" "\t\t Num.CTC        [%s] \n"
                        "\t\t Cod.Plan Com.  [%ld]\n" "\t\t Cod.Cat. Impo. [%d] \n"                  
                        "\t\t Fec.Vencimie   [%s] \n" "\t\t Fec.Caducidad  [%s] \n"                  
                        "\t\t Fec.ProxVenc   [%s] \n" "\t\t Cod.CiclFact   [%ld]\n"
                        "\t\t Num.SecuRel    [%ld]\n" "\t\t LetraRel       [%s] \n"
                        "\t\t Cod.TipoDocumRe[%d] \n" "\t\t Cod.Vend.AgenRe[%ld]\n"
                        "\t\t Cod.CentrRel   [%d] \n" "\t\t Num.Venta      [%ld]\n"
                        "\t\t Num.Transacc.  [%ld]\n" "\t\t Cod.Mod. Venta [%d] \n"
                        "\t\t Num.Cuotas     [%d] \n" "\t\t Imp.SaldoAnt   [%f] \n"
                        "\t\t Cod.Op.Red Fija[%d] \n" "\t\t Cod. Oficina   [%s] \n"                                    
                        "\t\t Zona Impositiva[%d] \n" "\t\t Prefijo Plaza  [%s] \n"
                        "\t\t COD_OPERADORA  [%s] \n" "\t\t COD_PLAZA      [%s] \n"
                        "\t\t CodMonedaImp.  [%s] \n" "\t\t ImpConversion  [%f] \n"
                        "\t\t Cod. Segment.  [%s] \n" "\t\t Cod. Despacho  [%s] \n"
                        "\t\t Email          [%s] \n" "\t\t Key Tecnico    [%s] \n"
                        "\t\t Cont. Tecnico  [%s] \n" "\t\t Cod. Tipologia [%s] \n"
                        "\t\t Cod. Area Imputable [%s] \n" "\t\t Cod. Area Solicitantes [%s] \n"                        
                      , LOG05
                      , strlen(szNomTabla), szNomTabla
                      , pHis->lNumSecuenci         , pHis->iCodTipDocum         
                      , pHis->lCodVendedorAgente   , pHis->szLetra              
                      , pHis->iCodCentrEmi         , pHis->dTotPagar            
                      , pHis->dTotCargosMe         , pHis->dTotFactura          
                      , pHis->dTotCuotas           , pHis->dTotDescuento        
                      , pHis->lCodVendedor         , pHis->lCodCliente          
                      , pHis->szFecEmision         , pHis->szFecCambioMo        
                      , pHis->szNomUsuarOra        , pHis->dAcumNetoGrav        
                      , pHis->dAcumNetoNoGrav      , pHis->dAcumIva             
                      , pHis->szIndOrdenTotal      , pHis->iIndFactur           
                      , pHis->iIndVisada           , pHis->iIndLibroIva         
                      , pHis->iIndPasoCobro        , pHis->iIndSuperTel         
                      , pHis->iIndAnulada          , pHis->lNumProceso          
                      , pHis->lNumFolio            , pHis->szNumCTC                               
                      , pHis->lCodPlanCom          , pHis->iCodCatImpos         
                      , pHis->szFecVencimie        , pHis->szFecCaducida        
                      , pHis->szFecProxVenc        , pHis->lCodCiclFact         
                      , pHis->lNumSecuRel          , pHis->szLetraRel           
                      , pHis->iCodTipDocumRel      , pHis->lCodVendedorAgenteRel
                      , pHis->iCodCentrRel         , pHis->lNumVenta            
                      , pHis->lNumTransaccion      , pHis->iCodModVenta         
                      , pHis->iNumCuotas           , pHis->dImpSaldoAnt         
                      , pHis->iCodOpRedFija        , pHis->szCodOficina         
                      , pHis->iCodZonaImpo         , pHis->szPrefPlaza          
                      , pHis->szCodOperadora       , pHis->szCodPlaza           
                      , pHis->szhCodMonedaImp      , pHis->dhImpConversion      
       		      , pHis->szCodSegmentacion    , pHis->szCodDespacho        
       		      , pHis->szNomEmail           , pHis->szKeyConTecnico      
       		      , pHis->szContTecnico        , pHis->szCodTipologia
       		      , pHis->szCodAreaImputable   , pHis->szCodAreaSolicitante);    	
    }


}/**************************** Final vfnPrintHistDocu ************************/

/*****************************************************************************/
/*                            funcion : vfnInitCadenaInsertHistDocu          */
/*****************************************************************************/
static void vfnInitCadenaInsertHistDocu (char *szCadena,char *szTabla)
{
  int iDiasVencimiento = 0;


  if (stProceso.iCodTipDocum == stDatosGener.iCodNotaDeb)
  {
      iDiasVencimiento = iDIAS_VENCIMIENTO;
  }
  
  if (stProceso.iCodTipDocum == FACT_CICLO)
  { 	
      /* P-MIX-09003 133873 */ /* FA_FACTDOCU_%ld */      
      sprintf (szCadena, "INSERT INTO %.*s "
                         "(NUM_SECUENCI         ," "COD_TIPDOCUM          ,"
                         "COD_VENDEDOR_AGENTE   ," "LETRA                 ,"
                         "COD_CENTREMI          ," "TOT_PAGAR             ,"
                         "TOT_CARGOSME          ," "TOT_FACTURA           ,"
                         "TOT_CUOTAS            ," "TOT_DESCUENTO         ,"
                         "COD_VENDEDOR          ," "COD_CLIENTE           ,"
                         "FEC_EMISION           ," "FEC_CAMBIOMO          ,"
                         "NOM_USUARORA          ," "ACUM_NETOGRAV         ,"
                         "ACUM_NETONOGRAV       ," "ACUM_IVA              ,"
                         "IND_ORDENTOTAL        ," "IND_FACTUR            ,"
                         "IND_VISADA            ," "IND_LIBROIVA          ,"
                         "IND_PASOCOBRO         ," "IND_SUPERTEL          ,"
                         "IND_ANULADA           ," "NUM_PROCESO           ,"
                         "NUM_FOLIO             ," "NUM_CTC               ,"
                         "COD_PLANCOM           ," "COD_CATIMPOS          ,"
                         "FEC_VENCIMIE          ," "FEC_CADUCIDA          ,"
                         "FEC_PROXVENC          ," "COD_CICLFACT          ,"
                         "NUM_SECUREL           ," "LETRAREL              ,"
                         "COD_TIPDOCUMREL       ," "COD_VENDEDOR_AGENTEREL,"
                         "COD_CENTRREL          ," "NUM_VENTA             ,"
                         "NUM_TRANSACCION       ," "COD_MODVENTA          ,"           
                         "NUM_CUOTAS            ," "IMP_SALDOANT          ,"
                         "COD_OPREDFIJA         ," "COD_OFICINA           ,"
                         "COD_ZONAIMPO          ," "PREF_PLAZA            ,"           
                         "COD_OPERADORA         ," "COD_PLAZA             ,"
                         "COD_MONEDAIMP         ," "IMP_CONVERSION        ," 
                         "COD_SEGMENTACION      ," "COD_DESPACHO          ,"
                         "NOM_EMAIL             ," "KEY_CONTECNICO        ,"
                         "CONT_TECNICO          ," "FEC_ULTMOD	 	  )"
                       "VALUES(:lNumSecuenci    ," ":iCodTipDocum         ,"
                         ":lCodVendedorAgente   ," ":szLetra              ,"
                         ":iCodCentrEmi         ," ":dTotPagar            ,"
                         ":dTotCargosMe         ," ":dTotFactura          ,"
                         ":dTotCuotas           ," ":dTotDescuento        ,"
                         ":lCodVendedor         ," ":lCodCliente          ,"
                         "TO_DATE(:szFecEmision ,'YYYYMMDDHH24MISS')      ,"
                         "TO_DATE(:szFecCambioMo,'YYYYMMDDHH24MISS')      ,"
                         ":szNomUsuarOra        ," ":dAcumNetoGrav        ,"
                         ":dAcumNetoNoGrav      ," ":dAcumIva             ,"
                         "TO_NUMBER (:szIndOrdenTotal)," ":iIndFactur     ,"
                         ":iIndVisada           ," ":iIndLibroIva         ,"
                         ":iIndPasoCobro        ," ":iIndSuperTel         ,"
                         ":iIndAnulada          ," ":lNumProceso          ,"
                         ":lNumFolio            ," ":szNumCTC             ,"
                         ":lCodPlanCom          ," ":iCodCatImpos         ,"
                         "TO_DATE(:szFecVencimie,'YYYYMMDDHH24MISS')+%d   ,"
                         "TO_DATE(:szFecCaducida,'YYYYMMDDHH24MISS')      ,"
                         "TO_DATE(:szFecProxVenc,'YYYYMMDDHH24MISS')      ,"
                         ":lCodCiclFact         ," ":lNumSecuRel          ,"
                         ":szLetraRel           ," ":iCodTipDocumRel      ,"
                         ":lCodVendedorAgenteRel," ":iCodCentrRel         ,"
                         ":lNumVenta            ," ":lNumTransaccion      ,"
                         ":iCodModVenta         ," ":iNumCuotas           ,"
                         ":dImpSaldoAnt         ," ":iCodOpRedFija        ,"
                         ":szCodOficina         ," ":iCodZonaImpo         ,"
                         "NVL(:szPrefPlaza,'0000000000000000000000000')   ,"
                         "NVL(:szCodOperadora,'00000')," "NVL(:szCodPlaza,'00000'),"
                         ":szhCodMonedaImp      ," ":dhImpConversion      ,"
                         ":szCodSegmentacion    ," ":szCodDespacho        ,"
                         ":szNomEmail           ," ":szKeyConTecnico      ,"
                         ":szContTecnico        ," "SYSDATE)               "
                        ,strlen(szTabla)
                        ,szTabla,iDiasVencimiento);
  }
  else
  {  	
      /* P-MIX-09003 133873 */ /* FA_FACTDOCU_NOCICLO */
      sprintf (szCadena, "INSERT INTO %.*s "
                         "(NUM_SECUENCI         ," "COD_TIPDOCUM          ,"
                         "COD_VENDEDOR_AGENTE   ," "LETRA                 ,"
                         "COD_CENTREMI          ," "TOT_PAGAR             ,"
                         "TOT_CARGOSME          ," "TOT_FACTURA           ,"
                         "TOT_CUOTAS            ," "TOT_DESCUENTO         ,"
                         "COD_VENDEDOR          ," "COD_CLIENTE           ,"
                         "FEC_EMISION           ," "FEC_CAMBIOMO          ,"
                         "NOM_USUARORA          ," "ACUM_NETOGRAV         ,"
                         "ACUM_NETONOGRAV       ," "ACUM_IVA              ,"
                         "IND_ORDENTOTAL        ," "IND_FACTUR            ,"
                         "IND_VISADA            ," "IND_LIBROIVA          ,"
                         "IND_PASOCOBRO         ," "IND_SUPERTEL          ,"
                         "IND_ANULADA           ," "NUM_PROCESO           ,"
                         "NUM_FOLIO             ," "NUM_CTC               ,"
                         "COD_PLANCOM           ," "COD_CATIMPOS          ,"
                         "FEC_VENCIMIE          ," "FEC_CADUCIDA          ,"
                         "FEC_PROXVENC          ," "COD_CICLFACT          ,"
                         "NUM_SECUREL           ," "LETRAREL              ,"
                         "COD_TIPDOCUMREL       ," "COD_VENDEDOR_AGENTEREL,"
                         "COD_CENTRREL          ," "NUM_VENTA             ,"
                         "NUM_TRANSACCION       ," "COD_MODVENTA          ,"           
                         "NUM_CUOTAS            ," "IMP_SALDOANT          ,"
                         "COD_OPREDFIJA         ," "COD_OFICINA           ,"
                         "COD_ZONAIMPO          ," "PREF_PLAZA            ,"           
                         "COD_OPERADORA         ," "COD_PLAZA             ,"
                         "COD_MONEDAIMP         ," "IMP_CONVERSION        ," 
                         "COD_SEGMENTACION      ," "COD_DESPACHO          ,"
                         "NOM_EMAIL             ," "KEY_CONTECNICO        ,"
                         "CONT_TECNICO          ," "FEC_ULTMOD	 	  ,"
                         "COD_TIPOLOGIA         ," "COD_AREAIMPUTABLE     ,"
                         "COD_AREASOLICITANTE   )                          "
                       "VALUES(:lNumSecuenci    ," ":iCodTipDocum         ,"
                         ":lCodVendedorAgente   ," ":szLetra              ,"
                         ":iCodCentrEmi         ," ":dTotPagar            ,"
                         ":dTotCargosMe         ," ":dTotFactura          ,"
                         ":dTotCuotas           ," ":dTotDescuento        ,"
                         ":lCodVendedor         ," ":lCodCliente          ,"
                         "TO_DATE(:szFecEmision ,'YYYYMMDDHH24MISS')      ,"
                         "TO_DATE(:szFecCambioMo,'YYYYMMDDHH24MISS')      ,"
                         ":szNomUsuarOra        ," ":dAcumNetoGrav        ,"
                         ":dAcumNetoNoGrav      ," ":dAcumIva             ,"
                         "TO_NUMBER (:szIndOrdenTotal)," ":iIndFactur     ,"
                         ":iIndVisada           ," ":iIndLibroIva         ,"
                         ":iIndPasoCobro        ," ":iIndSuperTel         ,"
                         ":iIndAnulada          ," ":lNumProceso          ,"
                         ":lNumFolio            ," ":szNumCTC             ,"
                         ":lCodPlanCom          ," ":iCodCatImpos         ,"
                         "TO_DATE(:szFecVencimie,'YYYYMMDDHH24MISS')+%d   ,"
                         "TO_DATE(:szFecCaducida,'YYYYMMDDHH24MISS')      ,"
                         "TO_DATE(:szFecProxVenc,'YYYYMMDDHH24MISS')      ,"
                         ":lCodCiclFact         ," ":lNumSecuRel          ,"
                         ":szLetraRel           ," ":iCodTipDocumRel      ,"
                         ":lCodVendedorAgenteRel," ":iCodCentrRel         ,"
                         ":lNumVenta            ," ":lNumTransaccion      ,"
                         ":iCodModVenta         ," ":iNumCuotas           ,"
                         ":dImpSaldoAnt         ," ":iCodOpRedFija        ,"
                         ":szCodOficina         ," ":iCodZonaImpo         ,"
                         "NVL(:szPrefPlaza,'0000000000000000000000000')   ,"
                         "NVL(:szCodOperadora,'00000')," "NVL(:szCodPlaza,'00000'),"
                         ":szhCodMonedaImp      ," ":dhImpConversion      ,"
                         ":szCodSegmentacion    ," ":szCodDespacho        ,"
                         ":szNomEmail           ," ":szKeyConTecnico      ,"
                         ":szContTecnico        ," "SYSDATE               ,"
                         ":szCodTipologia       ," ":szCodAreaImputable   ,"
                         ":szCodAreaSolicitante )                          "
                        ,strlen(szTabla)
                        ,szTabla,iDiasVencimiento);      
  }

}/************************ Final vfnInitCadenaInsertHistDocu *****************/

/*****************************************************************************/
/*                            funcion : bfnPasoHistClie                      */
/*****************************************************************************/
static BOOL bfnPasoHistClie ()
{
  COMUNAS  stComuna  ;
  CIUDADES stCiudad  ;

  memset (&stComuna  ,0,sizeof(COMUNAS) );
  memset (&stCiudad  ,0,sizeof(CIUDADES));
  memset (&stHistClie,0,sizeof(HISTCLIE));

  strcpy (stHistClie.szIndOrdenTotal, stDatosGener.szIndOrdenTotal);

  stHistClie.lCodCliente = stCliente.lCodCliente;
  stHistClie.lCodPlanCom = stCliente.lCodPlanCom;

  strcpy (stHistClie.szIndDebito    ,stCliente.szIndDebito)    ;
  strcpy (stHistClie.szNomCliente   ,stCliente.szNomCliente)   ;
  strcpy (stHistClie.szNomApeClien1 ,stCliente.szNomApeClien1) ;
  strcpy (stHistClie.szNomApeClien2 ,stCliente.szNomApeClien2) ;
  strcpy (stHistClie.szTefCliente1  ,stCliente.szTefCliente1)  ;
  strcpy (stHistClie.szTefCliente2  ,stCliente.szTefCliente2)  ;
  strcpy (stHistClie.szCodPais      ,stCliente.szCodPais)      ;
  strcpy (stHistClie.szCodBanco     ,stCliente.szCodBanco)     ;
  strcpy (stHistClie.szCodSucursal  ,stCliente.szCodSucursal)  ;
  strcpy (stHistClie.szIndTipCuenta ,stCliente.szIndTipCuenta) ;
  strcpy (stHistClie.szCodTipTarjeta,stCliente.szCodTipTarjeta);
  strcpy (stHistClie.szNumCtaCorr   ,stCliente.szNumCtaCorr)   ;
  strcpy (stHistClie.szNumTarjeta   ,stCliente.szNumTarjeta)   ;
  strcpy (stHistClie.szFecVenciTarj ,stCliente.szFecVenciTarj) ;
  strcpy (stHistClie.szCodBancoTarj ,stCliente.szCodBancoTarj) ;
  strcpy (stHistClie.szCodTipIdTrib ,stCliente.szCodTipIdTrib) ;
  strcpy (stHistClie.szNumIdentTrib ,stCliente.szNumIdentTrib) ;

  strcpy (stHistClie.szNomCalle,stCliente.szNomCalle);
  strcpy (stHistClie.szNumCalle,stCliente.szNumCalle);
  strcpy (stHistClie.szNumPiso ,stCliente.szNumPiso );

  strcpy (stComuna.szCodRegion   ,stCliente.szCodRegion)   ;
  strcpy (stComuna.szCodProvincia,stCliente.szCodProvincia);
  strcpy (stComuna.szCodComuna   ,stCliente.szCodComuna)   ;

  if (!bfnFindComuna (&stComuna,stProceso.iCodTipDocum))
       return FALSE;

  strcpy (stHistClie.szDesComuna,stComuna.szDesComuna);

  strcpy (stCiudad.szCodRegion   ,stCliente.szCodRegion)   ;
  strcpy (stCiudad.szCodProvincia,stCliente.szCodProvincia);
  strcpy (stCiudad.szCodCiudad   ,stCliente.szCodCiudad)   ;

  if (!bfnFindCiudad (&stCiudad,stProceso.iCodTipDocum))
       return FALSE;

  strcpy (stHistClie.szDesCiudad,stCiudad.szDesCiudad);
  strcpy (stHistClie.szCodPais  ,stCliente.szCodPais );
  strcpy (stHistClie.szNumFax   ,stCliente.szNumFax  );
  strcpy (stHistClie.szCodIdioma,stCliente.szCodIdioma);
  strcpy (stHistClie.szGlsDirecClie,stCliente.szGls_DirecClie);

  strcpy (stHistClie.szCodPlaza,szfnTrim(stCiudad.szCodPlaza));
  vDTrazasLog ("","bfnPasoHistClie:COD_PLAZA(%s)\n",LOG05,stHistClie.szCodPlaza);
  stHistClie.dImpStopDebit = stCliente.dImpStopDebit;

  if (stCliente.iCodActividad > 0)
  {
      if (!bfnFindActividad (stCliente.iCodActividad,stHistClie.szDesActividad,
                             stProceso.iCodTipDocum))
           return FALSE;
  }
  if (!bfnInsertHistClie ())
       return FALSE;
  return TRUE;
}/*************************** Final bfnPasoHistClie  *************************/

/*****************************************************************************/
/*                          funcion : bfnFindActividad                       */
/*****************************************************************************/
static BOOL bfnFindActividad (int iCodActividad,char *szDesActividad,
                              int iCodTipDocum)
{
   ACTIVIDADES stkey;
   ACTIVIDADES *pAct = (ACTIVIDADES *)NULL;

   /* EXEC SQL BEGIN DECLARE SECTION; */ 

   static char *szhDesActividad;/* EXEC SQL VAR szhDesActividad IS STRING(41); */ 

   /* EXEC SQL END DECLARE SECTION; */ 


   memset (&stkey,0,sizeof(ACTIVIDADES));

   vDTrazasLog (szExeName,"\n\t\t* Parametros Entrada Ge_Actividades"
                          "\n\t\t=> Cod.Actividad  [%d]",LOG06,
                          iCodActividad);

   if (iCodTipDocum != stDatosGener.iCodCiclo)
   {
       szhDesActividad = szDesActividad;
       /* EXEC SQL
        SELECT /o+ index (GE_ACTIVIDADES PK_GE_ACTIVIDADES) o/
               DES_ACTIVIDAD
          INTO :szhDesActividad
          FROM GE_ACTIVIDADES
         WHERE COD_ACTIVIDAD = :iCodActividad; */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 60;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "select  /*+  index (GE_ACTIVIDADES PK_GE_ACTIVIDADES) \
 +*/ DES_ACTIVIDAD into :b0  from GE_ACTIVIDADES where COD_ACTIVIDAD=:b1";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )692;
       sqlstm.selerr = (unsigned short)1;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)szhDesActividad;
       sqlstm.sqhstl[0] = (unsigned long )41;
       sqlstm.sqhsts[0] = (         int  )0;
       sqlstm.sqindv[0] = (         short *)0;
       sqlstm.sqinds[0] = (         int  )0;
       sqlstm.sqharm[0] = (unsigned long )0;
       sqlstm.sqadto[0] = (unsigned short )0;
       sqlstm.sqtdso[0] = (unsigned short )0;
       sqlstm.sqhstv[1] = (unsigned char  *)&iCodActividad;
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



       if (SQLCODE)
       {
           iDError (szExeName,ERR000,vInsertarIncidencia,
                    "Select->Ge_Actividades",szfnORAerror());
           return FALSE;
      }
      else
           return TRUE;
   }

   stkey.iCodActividad = iCodActividad;

   if ((pAct = (ACTIVIDADES *)bsearch (&stkey,pstActividades,NUM_ACTIVIDADES,
                                       sizeof(ACTIVIDADES),iCmpActividades))
       == (ACTIVIDADES *)NULL)
   {
       iDError (szExeName,ERR021,vInsertarIncidencia,"pstActividades");
       return FALSE;
   }

   strcpy (szDesActividad,pAct->szDesActividad);
   return TRUE;
}/*************************** Final bfnFindActividad *************************/

/*****************************************************************************/
/*                            funcion : bfnInsertHistClie                    */
/*****************************************************************************/
static BOOL bfnInsertHistClie (void)
{
    char szCadena  [2000] ="";
    char szNomTabla[21]   ="";
    char szFuncion [31]   ="";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    static short  i_shNomApeClien1    ;
    static short  i_shNomApeClien2    ;
    static short  i_shTefCliente1     ;
    static short  i_shTefCliente2     ;
    static short  i_shDesActividad    ;
    static short  i_shNomCalle        ;
    static short  i_shNumCalle        ;
    static short  i_shNumPiso         ;
    static short  i_shDesComuna       ;
    static short  i_shDesCiudad       ;
    static short  i_shCodPais         ;
    static short  i_shIndDebito       ;
    static short  i_shImpStopDebit    ;
    static short  i_shCodBanco        ;
    static short  i_shCodSucursal     ;
    static short  i_shIndTipCuenta    ;
    static short  i_shCodTipTarjeta   ;
    static short  i_shNumCtaCorr      ;
    static short  i_shNumTarjeta      ;
    static short  i_Fec               ;
    static short  i_shCodBancoTarj    ;
    static short  i_shCodTipIdTrib    ;
    static short  i_shNumIdentTrib    ;
    static short  i_shNumFax          ;
    /* EXEC SQL END DECLARE SECTION; */ 


    stHistClie.szNomCliente[strlen(stHistClie.szNomCliente)]='\0';
    stHistClie.szIndOrdenTotal[strlen(stHistClie.szIndOrdenTotal)]='\0';
    
    stHistClie.szNomApeClien1[strlen(stHistClie.szNomApeClien1)]='\0';
    if (strcmp (stHistClie.szNomApeClien1,"") == 0)
        i_shNomApeClien1 = ORA_NULL;
    else
        i_shNomApeClien1 = 0       ;

    stHistClie.szNomApeClien2[strlen(stHistClie.szNomApeClien2)]='\0';
    if (strcmp (stHistClie.szNomApeClien2,"") == 0)
        i_shNomApeClien2 = ORA_NULL;
    else
        i_shNomApeClien2 = 0       ;

    stHistClie.szTefCliente1[strlen(stHistClie.szTefCliente1)]='\0';
    if (strcmp (stHistClie.szTefCliente1 ,"") == 0)
        i_shTefCliente1 = ORA_NULL ;
    else
        i_shTefCliente1 = 0        ;

    stHistClie.szTefCliente2[strlen(stHistClie.szTefCliente2)]='\0';
    if (strcmp (stHistClie.szTefCliente2 ,"") == 0)
        i_shTefCliente2 = ORA_NULL ;
    else
        i_shTefCliente2 = 0        ;

    stHistClie.szDesActividad[strlen(stHistClie.szDesActividad)]='\0';
    if (strcmp (stHistClie.szDesActividad,"") == 0)
        i_shDesActividad = ORA_NULL;
    else
        i_shDesActividad = 0       ;

    stHistClie.szNomCalle[strlen(stHistClie.szNomCalle)]='\0';
    if (strcmp (stHistClie.szNomCalle,"") == 0)
        i_shNomCalle = ORA_NULL    ;
    else
        i_shNomCalle = 0           ;

    stHistClie.szNumCalle[strlen(stHistClie.szNumCalle)]='\0';
    if (strcmp (stHistClie.szNumCalle,"") == 0)
        i_shNumCalle = ORA_NULL    ;
    else
        i_shNumCalle = 0           ;

    stHistClie.szNumPiso[strlen(stHistClie.szNumPiso)]='\0';
    if (strcmp (stHistClie.szNumPiso,"") == 0)
        i_shNumPiso = ORA_NULL     ;
    else
        i_shNumPiso = 0            ;

    stHistClie.szDesComuna[strlen(stHistClie.szDesComuna)]='\0';
    if (strcmp (stHistClie.szDesComuna,"") == 0)
        i_shDesComuna = ORA_NULL   ;
    else
        i_shDesComuna = 0          ;

    stHistClie.szDesCiudad[strlen(stHistClie.szDesCiudad)]='\0';
    if (strcmp (stHistClie.szDesCiudad,"") == 0)
        i_shDesCiudad = ORA_NULL   ;
    else
        i_shDesCiudad = 0          ;

    stHistClie.szIndDebito[strlen(stHistClie.szIndDebito)]='\0';
    if (strcmp (stHistClie.szIndDebito,"") == 0)
        i_shIndDebito = ORA_NULL   ;
    else
        i_shIndDebito = 0          ;

    stHistClie.szCodBanco[strlen(stHistClie.szCodBanco)]='\0';
    if (strcmp (stHistClie.szCodBanco,"") == 0)
        i_shCodBanco = ORA_NULL    ;
    else
        i_shCodBanco = 0           ;

    stHistClie.szCodSucursal[strlen(stHistClie.szCodSucursal)]='\0';
    if (strcmp (stHistClie.szCodSucursal,"") == 0)
        i_shCodSucursal = ORA_NULL ;
    else
        i_shCodSucursal = 0        ;

    stHistClie.szIndTipCuenta[strlen(stHistClie.szIndTipCuenta)]='\0';
    if (strcmp (stHistClie.szIndTipCuenta,"") == 0)
        i_shIndTipCuenta = ORA_NULL;
    else
        i_shIndTipCuenta = 0       ;

    stHistClie.szCodTipTarjeta[strlen(stHistClie.szCodTipTarjeta)]='\0';
    if (strcmp (stHistClie.szCodTipTarjeta,"") == 0)
        i_shCodTipTarjeta = ORA_NULL;
    else
        i_shCodTipTarjeta = 0       ;

    stHistClie.szNumCtaCorr[strlen(stHistClie.szNumCtaCorr)]='\0';
    if (strcmp (stHistClie.szNumCtaCorr,"") == 0)
        i_shNumCtaCorr = ORA_NULL   ;
    else
        i_shNumCtaCorr = 0          ;

    stHistClie.szNumTarjeta[strlen(stHistClie.szNumTarjeta)]='\0';
    if (strcmp (stHistClie.szNumTarjeta,"") == 0)
        i_shNumTarjeta = ORA_NULL   ;
    else
        i_shNumTarjeta = 0          ;

    stHistClie.szCodBancoTarj[strlen(stHistClie.szCodBancoTarj)]='\0';
    if (strcmp (stHistClie.szCodBancoTarj,"") == 0)
        i_shCodBancoTarj = ORA_NULL ;
    else
        i_shCodBancoTarj = 0        ;

    stHistClie.szCodTipIdTrib[strlen(stHistClie.szCodTipIdTrib)]='\0';
    if (strcmp (stHistClie.szCodTipIdTrib,"") == 0)
        i_shCodTipIdTrib = ORA_NULL ;
    else
        i_shCodTipIdTrib = 0        ;

    stHistClie.szNumIdentTrib[strlen(stHistClie.szNumIdentTrib)]='\0';
    if (strcmp (stHistClie.szNumIdentTrib,"") == 0)
        i_shNumIdentTrib = ORA_NULL ;
    else
        i_shNumIdentTrib = 0        ;

    stHistClie.szNumFax[strlen(stHistClie.szNumFax)]='\0';
    if (strcmp (stHistClie.szNumFax,"") == 0)
        i_shNumFax = ORA_NULL;
    else
        i_shNumFax = 0       ;

    if (strcmp (stHistClie.szGlsDirecClie,"") == 0)
    {
    	strcpy(stHistClie.szGlsDirecClie," ");
    }
    stHistClie.szGlsDirecClie[strlen(stHistClie.szGlsDirecClie)]='\0';


    if (strcmp (stHistClie.szCodIdioma,"") == 0)
	{
		strcpy(stHistClie.szCodIdioma,pstParamGener.szCodIdioma); /*P-COL-08012*/
	}
    stHistClie.szCodIdioma[strlen(stHistClie.szCodIdioma)]='\0';
	
	
    stHistClie.szFecVenciTarj[strlen(stHistClie.szFecVenciTarj)]='\0';
    if (strcmp (stHistClie.szFecVenciTarj,"") == 0)
		i_Fec = ORA_NULL;
    else
		i_Fec = 0       ;
        
    stHistClie.szCodPais[strlen(stHistClie.szCodPais)]='\0';
    
    if (strcmp (stHistClie.szCodPais,"") == 0)
       	i_shCodPais = ORA_NULL;
    else
	i_shCodPais = 0       ;
		
    if (stProceso.iCodTipDocum == stDatosGener.iCodCiclo)
    {
        sprintf (szNomTabla,"FA_FACTCLIE_%ld",stCiclo.lCodCiclFact);
    }
    else
    {
        strcpy  (szNomTabla,"FA_FACTCLIE_NOCICLO");
    }

    vfnInitCadenaInsertHistClie (szCadena,szNomTabla);
    vfnPrintHistClie (&stHistClie,szNomTabla)         ;

    /* EXEC SQL PREPARE sql_insert_histclie FROM :szCadena; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 60;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )715;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadena;
    sqlstm.sqhstl[0] = (unsigned long )2000;
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


    if (SQLCODE)
    {
      strcpy (szFuncion,"PrePare=>");
      strcat (szFuncion,szNomTabla) ;

      iDError (szExeName,ERR000,vInsertarIncidencia,szFuncion,
               szfnORAerror())      ;
      return FALSE                  ;
    }

    /* EXEC SQL EXECUTE sql_insert_histclie
           USING   :stHistClie.szIndOrdenTotal                   ,
                   :stHistClie.lCodCliente                       ,
                   :stHistClie.szNomCliente                      ,
                   :stHistClie.lCodPlanCom                       ,
                   :stHistClie.szNomApeClien1:i_shNomApeClien1   ,
                   :stHistClie.szNomApeClien2:i_shNomApeClien2   ,
                   :stHistClie.szTefCliente1:i_shTefCliente1     ,
                   :stHistClie.szTefCliente2:i_shTefCliente2     ,
                   :stHistClie.szDesActividad:i_shDesActividad   ,
                   :stHistClie.szNomCalle:i_shNomCalle           ,
                   :stHistClie.szNumCalle:i_shNumCalle           ,
                   :stHistClie.szNumPiso:i_shNumPiso             ,
                   :stHistClie.szDesComuna:i_shDesComuna         ,
                   :stHistClie.szDesCiudad:i_shDesCiudad         ,
                   :stHistClie.szCodPais:i_shCodPais             ,
                   :stHistClie.szIndDebito:i_shIndDebito         ,
                   :stHistClie.dImpStopDebit:i_shImpStopDebit    ,
                   :stHistClie.szCodBanco:i_shCodBanco           ,
                   :stHistClie.szCodSucursal:i_shCodSucursal     ,
                   :stHistClie.szIndTipCuenta:i_shIndTipCuenta   ,
                   :stHistClie.szCodTipTarjeta:i_shCodTipTarjeta ,
                   :stHistClie.szNumCtaCorr:i_shNumCtaCorr       ,
                   :stHistClie.szNumTarjeta:i_shNumTarjeta       ,
                   :stHistClie.szFecVenciTarj:i_Fec              ,
                   :stHistClie.szCodBancoTarj:i_shCodBancoTarj   ,
                   :stHistClie.szCodTipIdTrib:i_shCodTipIdTrib   ,
                   :stHistClie.szNumIdentTrib:i_shNumIdentTrib   ,
                   :stHistClie.szNumFax:i_shNumFax               ,
                   :stHistClie.szCodIdioma                       ,
                   :stHistClie.szGlsDirecClie                    ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 60;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )734;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)(stHistClie.szIndOrdenTotal);
    sqlstm.sqhstl[0] = (unsigned long )13;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&(stHistClie.lCodCliente);
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)(stHistClie.szNomCliente);
    sqlstm.sqhstl[2] = (unsigned long )51;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&(stHistClie.lCodPlanCom);
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)(stHistClie.szNomApeClien1);
    sqlstm.sqhstl[4] = (unsigned long )21;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)&i_shNomApeClien1;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)(stHistClie.szNomApeClien2);
    sqlstm.sqhstl[5] = (unsigned long )21;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)&i_shNomApeClien2;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)(stHistClie.szTefCliente1);
    sqlstm.sqhstl[6] = (unsigned long )16;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)&i_shTefCliente1;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)(stHistClie.szTefCliente2);
    sqlstm.sqhstl[7] = (unsigned long )16;
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)&i_shTefCliente2;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)(stHistClie.szDesActividad);
    sqlstm.sqhstl[8] = (unsigned long )41;
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)&i_shDesActividad;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)(stHistClie.szNomCalle);
    sqlstm.sqhstl[9] = (unsigned long )51;
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)&i_shNomCalle;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)(stHistClie.szNumCalle);
    sqlstm.sqhstl[10] = (unsigned long )11;
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)&i_shNumCalle;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)(stHistClie.szNumPiso);
    sqlstm.sqhstl[11] = (unsigned long )11;
    sqlstm.sqhsts[11] = (         int  )0;
    sqlstm.sqindv[11] = (         short *)&i_shNumPiso;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)(stHistClie.szDesComuna);
    sqlstm.sqhstl[12] = (unsigned long )31;
    sqlstm.sqhsts[12] = (         int  )0;
    sqlstm.sqindv[12] = (         short *)&i_shDesComuna;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
    sqlstm.sqhstv[13] = (unsigned char  *)(stHistClie.szDesCiudad);
    sqlstm.sqhstl[13] = (unsigned long )31;
    sqlstm.sqhsts[13] = (         int  )0;
    sqlstm.sqindv[13] = (         short *)&i_shDesCiudad;
    sqlstm.sqinds[13] = (         int  )0;
    sqlstm.sqharm[13] = (unsigned long )0;
    sqlstm.sqadto[13] = (unsigned short )0;
    sqlstm.sqtdso[13] = (unsigned short )0;
    sqlstm.sqhstv[14] = (unsigned char  *)(stHistClie.szCodPais);
    sqlstm.sqhstl[14] = (unsigned long )4;
    sqlstm.sqhsts[14] = (         int  )0;
    sqlstm.sqindv[14] = (         short *)&i_shCodPais;
    sqlstm.sqinds[14] = (         int  )0;
    sqlstm.sqharm[14] = (unsigned long )0;
    sqlstm.sqadto[14] = (unsigned short )0;
    sqlstm.sqtdso[14] = (unsigned short )0;
    sqlstm.sqhstv[15] = (unsigned char  *)(stHistClie.szIndDebito);
    sqlstm.sqhstl[15] = (unsigned long )2;
    sqlstm.sqhsts[15] = (         int  )0;
    sqlstm.sqindv[15] = (         short *)&i_shIndDebito;
    sqlstm.sqinds[15] = (         int  )0;
    sqlstm.sqharm[15] = (unsigned long )0;
    sqlstm.sqadto[15] = (unsigned short )0;
    sqlstm.sqtdso[15] = (unsigned short )0;
    sqlstm.sqhstv[16] = (unsigned char  *)&(stHistClie.dImpStopDebit);
    sqlstm.sqhstl[16] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[16] = (         int  )0;
    sqlstm.sqindv[16] = (         short *)&i_shImpStopDebit;
    sqlstm.sqinds[16] = (         int  )0;
    sqlstm.sqharm[16] = (unsigned long )0;
    sqlstm.sqadto[16] = (unsigned short )0;
    sqlstm.sqtdso[16] = (unsigned short )0;
    sqlstm.sqhstv[17] = (unsigned char  *)(stHistClie.szCodBanco);
    sqlstm.sqhstl[17] = (unsigned long )16;
    sqlstm.sqhsts[17] = (         int  )0;
    sqlstm.sqindv[17] = (         short *)&i_shCodBanco;
    sqlstm.sqinds[17] = (         int  )0;
    sqlstm.sqharm[17] = (unsigned long )0;
    sqlstm.sqadto[17] = (unsigned short )0;
    sqlstm.sqtdso[17] = (unsigned short )0;
    sqlstm.sqhstv[18] = (unsigned char  *)(stHistClie.szCodSucursal);
    sqlstm.sqhstl[18] = (unsigned long )5;
    sqlstm.sqhsts[18] = (         int  )0;
    sqlstm.sqindv[18] = (         short *)&i_shCodSucursal;
    sqlstm.sqinds[18] = (         int  )0;
    sqlstm.sqharm[18] = (unsigned long )0;
    sqlstm.sqadto[18] = (unsigned short )0;
    sqlstm.sqtdso[18] = (unsigned short )0;
    sqlstm.sqhstv[19] = (unsigned char  *)(stHistClie.szIndTipCuenta);
    sqlstm.sqhstl[19] = (unsigned long )2;
    sqlstm.sqhsts[19] = (         int  )0;
    sqlstm.sqindv[19] = (         short *)&i_shIndTipCuenta;
    sqlstm.sqinds[19] = (         int  )0;
    sqlstm.sqharm[19] = (unsigned long )0;
    sqlstm.sqadto[19] = (unsigned short )0;
    sqlstm.sqtdso[19] = (unsigned short )0;
    sqlstm.sqhstv[20] = (unsigned char  *)(stHistClie.szCodTipTarjeta);
    sqlstm.sqhstl[20] = (unsigned long )4;
    sqlstm.sqhsts[20] = (         int  )0;
    sqlstm.sqindv[20] = (         short *)&i_shCodTipTarjeta;
    sqlstm.sqinds[20] = (         int  )0;
    sqlstm.sqharm[20] = (unsigned long )0;
    sqlstm.sqadto[20] = (unsigned short )0;
    sqlstm.sqtdso[20] = (unsigned short )0;
    sqlstm.sqhstv[21] = (unsigned char  *)(stHistClie.szNumCtaCorr);
    sqlstm.sqhstl[21] = (unsigned long )19;
    sqlstm.sqhsts[21] = (         int  )0;
    sqlstm.sqindv[21] = (         short *)&i_shNumCtaCorr;
    sqlstm.sqinds[21] = (         int  )0;
    sqlstm.sqharm[21] = (unsigned long )0;
    sqlstm.sqadto[21] = (unsigned short )0;
    sqlstm.sqtdso[21] = (unsigned short )0;
    sqlstm.sqhstv[22] = (unsigned char  *)(stHistClie.szNumTarjeta);
    sqlstm.sqhstl[22] = (unsigned long )19;
    sqlstm.sqhsts[22] = (         int  )0;
    sqlstm.sqindv[22] = (         short *)&i_shNumTarjeta;
    sqlstm.sqinds[22] = (         int  )0;
    sqlstm.sqharm[22] = (unsigned long )0;
    sqlstm.sqadto[22] = (unsigned short )0;
    sqlstm.sqtdso[22] = (unsigned short )0;
    sqlstm.sqhstv[23] = (unsigned char  *)(stHistClie.szFecVenciTarj);
    sqlstm.sqhstl[23] = (unsigned long )15;
    sqlstm.sqhsts[23] = (         int  )0;
    sqlstm.sqindv[23] = (         short *)&i_Fec;
    sqlstm.sqinds[23] = (         int  )0;
    sqlstm.sqharm[23] = (unsigned long )0;
    sqlstm.sqadto[23] = (unsigned short )0;
    sqlstm.sqtdso[23] = (unsigned short )0;
    sqlstm.sqhstv[24] = (unsigned char  *)(stHistClie.szCodBancoTarj);
    sqlstm.sqhstl[24] = (unsigned long )16;
    sqlstm.sqhsts[24] = (         int  )0;
    sqlstm.sqindv[24] = (         short *)&i_shCodBancoTarj;
    sqlstm.sqinds[24] = (         int  )0;
    sqlstm.sqharm[24] = (unsigned long )0;
    sqlstm.sqadto[24] = (unsigned short )0;
    sqlstm.sqtdso[24] = (unsigned short )0;
    sqlstm.sqhstv[25] = (unsigned char  *)(stHistClie.szCodTipIdTrib);
    sqlstm.sqhstl[25] = (unsigned long )3;
    sqlstm.sqhsts[25] = (         int  )0;
    sqlstm.sqindv[25] = (         short *)&i_shCodTipIdTrib;
    sqlstm.sqinds[25] = (         int  )0;
    sqlstm.sqharm[25] = (unsigned long )0;
    sqlstm.sqadto[25] = (unsigned short )0;
    sqlstm.sqtdso[25] = (unsigned short )0;
    sqlstm.sqhstv[26] = (unsigned char  *)(stHistClie.szNumIdentTrib);
    sqlstm.sqhstl[26] = (unsigned long )21;
    sqlstm.sqhsts[26] = (         int  )0;
    sqlstm.sqindv[26] = (         short *)&i_shNumIdentTrib;
    sqlstm.sqinds[26] = (         int  )0;
    sqlstm.sqharm[26] = (unsigned long )0;
    sqlstm.sqadto[26] = (unsigned short )0;
    sqlstm.sqtdso[26] = (unsigned short )0;
    sqlstm.sqhstv[27] = (unsigned char  *)(stHistClie.szNumFax);
    sqlstm.sqhstl[27] = (unsigned long )16;
    sqlstm.sqhsts[27] = (         int  )0;
    sqlstm.sqindv[27] = (         short *)&i_shNumFax;
    sqlstm.sqinds[27] = (         int  )0;
    sqlstm.sqharm[27] = (unsigned long )0;
    sqlstm.sqadto[27] = (unsigned short )0;
    sqlstm.sqtdso[27] = (unsigned short )0;
    sqlstm.sqhstv[28] = (unsigned char  *)(stHistClie.szCodIdioma);
    sqlstm.sqhstl[28] = (unsigned long )6;
    sqlstm.sqhsts[28] = (         int  )0;
    sqlstm.sqindv[28] = (         short *)0;
    sqlstm.sqinds[28] = (         int  )0;
    sqlstm.sqharm[28] = (unsigned long )0;
    sqlstm.sqadto[28] = (unsigned short )0;
    sqlstm.sqtdso[28] = (unsigned short )0;
    sqlstm.sqhstv[29] = (unsigned char  *)(stHistClie.szGlsDirecClie);
    sqlstm.sqhstl[29] = (unsigned long )251;
    sqlstm.sqhsts[29] = (         int  )0;
    sqlstm.sqindv[29] = (         short *)0;
    sqlstm.sqinds[29] = (         int  )0;
    sqlstm.sqharm[29] = (unsigned long )0;
    sqlstm.sqadto[29] = (unsigned short )0;
    sqlstm.sqtdso[29] = (unsigned short )0;
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
        strcpy (szFuncion,"Insert=>");
        strcat (szFuncion,szNomTabla);
        iDError (szExeName,ERR000,vInsertarIncidencia,szFuncion,szfnORAerror());
        return FALSE;
    }
    return TRUE;
}/**************************** Final bfnInsertHistClie ***********************/


/*****************************************************************************/
/*                          funcion : vfnPrintHistClie                       */
/*****************************************************************************/
static void vfnPrintHistClie (HISTCLIE *stHis,char *szTable)
{
  char szNomTabla [21]="";

  strcpy (szNomTabla,szTable);

  vDTrazasLog (szExeName,"\n\t\t=> Insertarndo en  %.*s\n"
                         "\t\t Ind.OrdenTotal [%s] \n"
                         "\t\t Cod.Cliente    [%ld]\n"
                         "\t\t Nom.Cliente    [%s] \n"
                         "\t\t Cod.PlanCom    [%ld]\n"
                         "\t\t Nom.ApeClien1  [%s] \n"
                         "\t\t Nom.ApeClien2  [%s] \n"
                         "\t\t Tef.Cliente1   [%s] \n"
                         "\t\t Tef.Cliente2   [%s] \n"
                         "\t\t Des.Actividad  [%s] \n"
                         "\t\t Nom.Calle      [%s] \n"
                         "\t\t Num.Calle      [%s] \n"
                         "\t\t Num.Piso       [%s] \n"
                         "\t\t Des.Comuna     [%s] \n"
                         "\t\t Des.Ciudad     [%s] \n"
                         "\t\t Cod.Pais       [%s] \n"
                         "\t\t Ind.Debito     [%s] \n"
                         "\t\t Imp.StopDebit  [%f] \n"
                         "\t\t Cod.Banco      [%s] \n"
                         "\t\t Cod.Sucursal   [%s] \n"
                         "\t\t Ind.TipCuenta  [%s] \n"
                         "\t\t Cod.TipTarjeta [%s] \n"
                         "\t\t Num.CtaCorr    [%s] \n"
                         "\t\t Num.NumTarjeta [%s] \n"
                         "\t\t Fec.VenciTarj  [%s] \n"
                         "\t\t Cod.BancoTarj  [%s] \n"
                         "\t\t Cod.TipIdTrib  [%s] \n"
                         "\t\t Num.IdentTrib  [%s] \n"
                         "\t\t Num.Fax        [%s] \n"
                         "\t\t Cod.Idioma     [%s] \n"
                         "\t\t Gls.DirClie    [%s] \n",
                         LOG05,strlen (szNomTabla),szNomTabla,
                         stHis->szIndOrdenTotal,
                         stHis->lCodCliente    ,
                         stHis->szNomCliente   ,
                         stHis->lCodPlanCom    ,
                         stHis->szNomApeClien1 ,
                         stHis->szNomApeClien2 ,
                         stHis->szTefCliente1  ,
                         stHis->szTefCliente2  ,
                         stHis->szDesActividad ,
                         stHis->szNomCalle     ,
                         stHis->szNumCalle     ,
                         stHis->szNumPiso      ,
                         stHis->szDesComuna    ,
                         stHis->szDesCiudad    ,
                         stHis->szCodPais      ,
                         stHis->szIndDebito    ,
                         stHis->dImpStopDebit  ,
                         stHis->szCodBanco     ,
                         stHis->szCodSucursal  ,
                         stHis->szIndTipCuenta ,
                         stHis->szCodTipTarjeta,
                         stHis->szNumCtaCorr   ,
                         stHis->szNumTarjeta   ,
                         stHis->szFecVenciTarj ,
                         stHis->szCodBancoTarj ,
                         stHis->szCodTipIdTrib ,
                         stHis->szNumIdentTrib ,
                         stHis->szNumFax       ,
                         stHis->szCodIdioma    ,
                   		 stHis->szGlsDirecClie );

}/*************************** Final vfnPrintHistClie *************************/

/*****************************************************************************/
/*                          funcion : vfnInitCadenaInsertHistClie            */
/*****************************************************************************/
static void vfnInitCadenaInsertHistClie (char *szCadena,char *szNomTabla)
{
  sprintf (szCadena,
          "INSERT INTO %.*s "
                  "(IND_ORDENTOTAL,"
                  "COD_CLIENTE    ,"
                  "NOM_CLIENTE    ,"
                  "COD_PLANCOM    ,"
                  "NOM_APECLIEN1  ,"
                  "NOM_APECLIEN2  ,"
                  "TEF_CLIENTE1   ,"
                  "TEF_CLIENTE2   ,"
                  "DES_ACTIVIDAD  ,"
                  "NOM_CALLE      ,"
                  "NUM_CALLE      ,"
                  "NUM_PISO       ,"
                  "DES_COMUNA     ,"
                  "DES_CIUDAD     ,"
                  "COD_PAIS       ,"
                  "IND_DEBITO     ,"
                  "IMP_STOPDEBIT  ,"
                  "COD_BANCO      ,"
                  "COD_SUCURSAL   ,"
                  "IND_TIPCUENTA  ,"
                  "COD_TIPTARJETA ,"
                  "NUM_CTACORR    ,"
                  "NUM_TARJETA    ,"
                  "FEC_VENCITARJ  ,"
                  "COD_BANCOTARJ  ,"
                  "COD_TIPIDTRIB  ,"
                  "NUM_IDENTTRIB  ,"
                  "NUM_FAX        ,"
                  "COD_IDIOMA     ,"
                  "GLS_DIRECCLIE )"
          "VALUES (TO_NUMBER (:szIndOrdenTotal),"
                  ":lCodCliente            ,"
                  ":szNomCliente           ,"
                  ":lCodPlanCom            ,"
                  ":szNomApeClien1         ,"
                  ":szNomApeClien2         ,"
                  ":szTefCliente1          ,"
                  ":szTefCliente2          ,"
                  ":szDesActividad         ,"
                  ":szNomCalle             ,"
                  ":szNumCalle             ,"
                  ":szNumPiso              ,"
                  ":szDesComuna            ,"
                  ":szDesCiudad            ,"
                  ":szCodPais              ,"
                  ":szIndDebito            ,"
                  ":dImpStopDebit          ,"
                  ":szCodBanco             ,"
                  ":szCodSucursal          ,"
                  ":szIndTipCuenta         ,"
                  ":szCodTipTarjeta        ,"
                  ":szNumCtaCorr           ,"
                  ":szNumTarjeta           ,"
                  "TO_DATE(:szFecVenciTarj,'YYYYMMDDHH24MISS'),"
                  ":szCodBancoTarj         ,"
                  ":szCodTipIdTrib         ,"
                  ":szNumIdentTrib         ,"
                  ":szNumFax               ,"
                  ":szCodIdioma            ,"
                  ":szGlsDirecClie)",strlen(szNomTabla),szNomTabla);

}/*************************** Final vfnInitCadenaInsertHistClie **************/

/*****************************************************************************/
/*                            funcion : bfnPasoHistAbo                       */
/*****************************************************************************/
static BOOL bfnPasoHistAbo ()
{
  int i = 0;
  int j = 0;
  int x = 0;
  int ihEsPrepago=0; /* SAAM-20050922 nueva variable XO-200509190692 */
  /**************************************************************/
  /* Estructuras Globales para que sean vistas por la impresion */
  /**************************************************************/
  memset (&stHistAboCel  ,0,sizeof(HISTABOP));

  for(j=0;j<stAbonoCli.lNumAbonados;j++)
  {
      i = 0;
      if (stAbonoCli.pCicloCli [j].iCodProducto == stDatosGener.iProdCelular)
      {
          if ((stHistAboCel.pAbo =
              (HISTABO *)realloc ( (HISTABO *)stHistAboCel.pAbo,
              (stHistAboCel.iNumReg+1)*sizeof(HISTABO) ))==(HISTABO *)NULL)
          {
               iDError (szExeName,ERR005,vInsertarIncidencia,
                        "stHistAboCel.pAbo");
               return  FALSE                ;
          }
          i = stHistAboCel.iNumReg                         ;
          memset (&stHistAboCel.pAbo[i],0,sizeof (HISTABO));
          strcpy (stHistAboCel.pAbo[i].szIndOrdenTotal,
                  stDatosGener.szIndOrdenTotal)            ;

          strcpy (stHistAboCel.pAbo[i].szCodPlanTarif,
                  stAbonoCli.pCicloCli [j].szCodPlanTarif);

          stHistAboCel.pAbo[i].lCodCliente   =
                                           stAbonoCli.pCicloCli[j].lCodCliente;
          stHistAboCel.pAbo[i].lNumAbonado   =
                                           stAbonoCli.pCicloCli[j].lNumAbonado;
          stHistAboCel.pAbo[i].iCodDetFact   =
                                           stAbonoCli.pCicloCli[j].iIndDetalle;
          strcpy (stHistAboCel.pAbo[i].szNomUsuario  ,
                  stAbonoCli.pCicloCli [j].szNomUsuario)  ;
          strcpy (stHistAboCel.pAbo[i].szNomApellido1,
                  stAbonoCli.pCicloCli [j].szNomApellido1);
          strcpy (stHistAboCel.pAbo[i].szNomApellido2,
                  stAbonoCli.pCicloCli [j].szNomApellido2);
          stHistAboCel.pAbo[i].iCodCredMor   =
                                           stAbonoCli.pCicloCli[j].iCodCredMor;

          strcpy (stHistAboCel.pAbo[i].szNumTerminal,
                  stAbonoCli.pCicloCli[j].szNumTerminal);

          stHistAboCel.pAbo[i].iIndFactur   =
                                          stAbonoCli.pCicloCli[j].iIndFactur  ;
          stHistAboCel.pAbo[i].iIndSuperTel =
                                          stAbonoCli.pCicloCli[j].iIndSuperTel;
          stHistAboCel.pAbo[i].lCodGrupo    =
                                          stAbonoCli.pCicloCli[j].lCodGrupo   ;
		
          stHistAboCel.pAbo[i].iIndCobroDetLlam = stAbonoCli.pCicloCli[j].iIndCobroDetLlam   ;

          strcpy (stHistAboCel.pAbo[i].szNumTeleFija ,
                  stAbonoCli.pCicloCli[j].szNumTeleFija) ;
          strcpy (stHistAboCel.pAbo[i].szFecFinContra,
                  stAbonoCli.pCicloCli[j].szFecFinContra);

          if (!bfnGetTotCargosMeAbo (&stHistAboCel.pAbo[i]))
               return FALSE;

          if (stHistAboCel.pAbo[i].iCodCredMor > 0)
          {
              if (!bfnGetLimCredito (stHistAboCel.pAbo[i].iCodCredMor    ,
                                     stAbonoCli.pCicloCli[j].iCodProducto,
                                     &stHistAboCel.pAbo[i].dLimCredito   ,
                                     stProceso.iCodTipDocum))
                   return FALSE;
          }
          /* registra Zona Imppositiva del Abonado */
          /* SAAM-20050922 Se incluye filtro para tratamiento de Zona Impositiva de Abonados para Facturas de Venta (Contado) XO-200509190692 */
          if (stProceso.iCodTipDocum != stDatosGener.iCodContado)
          {
              for (x=0;x<stZonaAbon.iNumAbonados;x++)
              {
                  if (stZonaAbon.stAbon[x].lNumAbonado == stHistAboCel.pAbo[i].lNumAbonado )
                  {
                      stHistAboCel.pAbo[i].iCodZonaAbon=stZonaAbon.stAbon[x].iCodZonaAbon;
                      break;
                  }
              }
          }
          else
          {
              if (!bfnEsPrePago(stHistAboCel.pAbo[i].lNumAbonado,&ihEsPrepago))
              {
                  return FALSE;
              }
              if ((ihEsPrepago == 1) || (stHistAboCel.pAbo[i].lNumAbonado == 0))
              {
                  stHistAboCel.pAbo[i].iCodZonaAbon=stPreFactura.iCodZonaImpo;
              }
              else
              {
                  if (!bfnGetCodZonaAbon(stHistAboCel.pAbo[i].lNumAbonado,&stHistAboCel.pAbo[i].iCodZonaAbon))
                      return FALSE;
              }
          }
          stHistAboCel.iNumReg++;
      }
  }/* fin for */
  if (stHistAboCel.iNumReg > 0)
  {
      if (!bfnInsertHistAbo (&stHistAboCel  ,stDatosGener.iProdCelular))
           return (FALSE);
  }

  return TRUE;
}/************************** Final bfnPasoHistAbo ****************************/


static BOOL fnbChequeaAcumulados()
{
    stAcumulador     * pAcumulador=NULL;

    for (pAcumulador = lstAcumulador; pAcumulador != NULL; pAcumulador = pAcumulador->sgte)
    {
       if (pAcumulador->dMonto < 0.000001 && pAcumulador->dMonto > -0.000001)
           pAcumulador->dMonto = (double)0.0;

        if (pAcumulador->dMonto < 0)
        {
            vDTrazasLog(szExeName,"\n\t---FUNCION - fnbChequeaAcumulados ERROR"
                                  "\n\t\tpAcumulador->lAbonado    [%ld]"
                                  "\n\t\tpAcumulador->lCod_ConCobr[%ld]"
                                  "\n\t\tpAcumulador->dMonto      [%.15f]"
                                  ,LOG01, pAcumulador->lAbonado, pAcumulador->lCod_ConCobr,pAcumulador->dMonto);
            pAcumulador->dMonto = 0;
            return (FALSE);
        }
        else
            vDTrazasLog(szExeName,"\n\t---FUNCION - fnbChequeaAcumulados"
                                  "\n\t\tpAcumulador->lAbonado    [%ld]"
                                  "\n\t\tpAcumulador->lCod_ConCobr[%ld]"
                                  "\n\t\tpAcumulador->dMonto      [%.15f]"
                                  ,LOG05, pAcumulador->lAbonado, pAcumulador->lCod_ConCobr,pAcumulador->dMonto);
    }
    return (TRUE);
}


static BOOL bfnLlenaAcumulados(int iCodConCobr, long lNum_Abonado, double dMontoImporte)
{
    stAcumulador     * pAcumulador=NULL;
    int isw = 0;

    vDTrazasLog(szExeName,"\n\t---FUNCION - bfnLlenaAcumulados antes "
                          "\n\t\t lAbonado      [%ld]"
                          "\n\t\t iCod_ConCobr  [%d]"
                          "\n\t\t dMontoImporte [%f]"
                          ,LOG05, lNum_Abonado, iCodConCobr, dMontoImporte);

	if (dMontoImporte > 0.00 || dMontoImporte < 0.00)
	{
	    for (pAcumulador = lstAcumulador; pAcumulador != NULL; pAcumulador = pAcumulador->sgte)
	    {
	        if (pAcumulador->lCod_ConCobr == iCodConCobr &&
	            pAcumulador->lAbonado == lNum_Abonado)
	        {
	            isw = 1;
	        	pAcumulador->dMonto = pAcumulador->dMonto + fnCnvDouble(dMontoImporte,USOFACT);
	            break;
	        }
	    }

	    if (isw == 0)
	    {
	        pAcumulador = (stAcumulador *) malloc(sizeof(stAcumulador));
	        pAcumulador->lAbonado       = lNum_Abonado;
	        pAcumulador->lCod_ConCobr   = iCodConCobr;
	        pAcumulador->dMonto     = fnCnvDouble(dMontoImporte,USOFACT);
	        pAcumulador->sgte           = lstAcumulador;
	        lstAcumulador               = pAcumulador;
	    }

	    vDTrazasLog(szExeName,"\t--- Despues ---"
	                          "\n\t\t lAbonado         [%ld]"
	                          "\n\t\t lCod_ConCobr     [%ld]"
	                          "\n\t\t dMonto Acumulado [%f] "
	                          ,LOG05, pAcumulador->lAbonado, pAcumulador->lCod_ConCobr,pAcumulador->dMonto);
	}
    return (TRUE);
}



static BOOL bfnComparaEstructuras(int iCod_Concepto, long lNumAbonado, double dImporte)
{
    int iCodConCobr=0;

    if (!bfnFindFactCobr (iCod_Concepto, &iCodConCobr ))
    {
        vDTrazasLog (szExeName, "\n\t\t Error Obtener Concepto Cobro : [%d] \n",LOG01,iCod_Concepto);
        return FALSE;
    }

    if (!bfnLlenaAcumulados(iCodConCobr, lNumAbonado, dImporte))
    {
        vDTrazasLog(szExeName,"\nError en funcion bfnLlenaAcumulados\n",LOG01);
        return (FALSE);
    }

    return (TRUE);

}

static BOOL bfnMuestraAcumulados()
{
    stAcumulador    * pAcumulador=NULL;

    for (pAcumulador = lstAcumulador; pAcumulador != NULL; pAcumulador = pAcumulador->sgte)
    {
        vDTrazasLog(szExeName,"\n\t-----bfnMuestraAcumulados --------"
                              "\n\t\tpAcumulador->lAbonado      [%ld]"
                              "\n\t\tpAcumulador->lCod_ConCobr  [%ld]"
                              "\n\t\tpAcumulador->dMonto        [%f] "
                              , LOG05, pAcumulador->lAbonado, pAcumulador->lCod_ConCobr, pAcumulador->dMonto);

    }

    return (TRUE);
}

static void vLiberaAcumulador(void)
{
    stAcumulador    * pCabeceraAux=NULL;

    while (lstAcumulador != NULL)
    {
        pCabeceraAux = lstAcumulador->sgte;
        free(lstAcumulador);
        lstAcumulador = pCabeceraAux;
    }

    lstAcumulador = (stAcumulador *)NULL;
	return;
}


/*****************************************************************************/
/*                          funcion : bfnGetCargosMeAbo                      */
/*****************************************************************************/
static BOOL bfnGetTotCargosMeAbo (HISTABO *pHis)
{

   int    i        = 0  ;
   double dTotalAbonado = 0.0;

   vLiberaAcumulador();

   for (i=0;i<stPreFactura.iNumRegistros;i++)
   {
        if (stPreFactura.A_PFactura[i].lNumAbonado  == pHis->lNumAbonado  	 &&
            stPreFactura.A_PFactura[i].lNumProceso  == stStatus.IdPro        &&
            stPreFactura.A_PFactura[i].lCodCliente  == stCliente.lCodCliente )
        {
            pHis->dTotCargosMe += stPreFactura.A_PFactura[i].dImpFacturable;
            if (stPreFactura.A_PFactura[i].iCodTipConce  == ARTICULO)
            {
                pHis->dAcumCargo += stPreFactura.A_PFactura[i].dImpFacturable;
            }
            else if (stPreFactura.A_PFactura[i].iCodTipConce  == IMPUESTO)
            {
                pHis->dAcumIva   += stPreFactura.A_PFactura[i].dImpFacturable;
            }
            else if (stPreFactura.A_PFactura[i].iCodTipConce  == DESCUENTO)
            {
                pHis->dAcumDto   += stPreFactura.A_PFactura[i].dImpFacturable;
            }

            if (!bfnComparaEstructuras(stPreFactura.A_PFactura[i].iCodConcepto, stPreFactura.A_PFactura[i].lNumAbonado, stPreFactura.A_PFactura[i].dImpFacturable))
            {
                vDTrazasLog(szExeName,"\nError en funcion bfnComparaEstructuras\n",LOG01);
            }

            /*****************************************************************/
            /* En las Facturas de Contado o PVenta no tienen el interface con*/
            /* Ga_InfacCel donde se encuentra el iIndSuperTel a nivel de Abo-*/
            /* nado, por eso necesitamos este control para recuperar la infor*/
            /* macion a este nivel.                                          */
            /*****************************************************************/
            if (stPreFactura.A_PFactura[i].iIndSuperTel  == 1 &&
                pHis->iIndSuperTel                       <  1)
                pHis->iIndSuperTel = 1;
        }
   }

   pHis->dTotCargosMe = fnCnvDouble (pHis->dTotCargosMe,USOFACT);
   pHis->dAcumCargo   = fnCnvDouble (pHis->dAcumCargo  ,USOFACT);
   pHis->dAcumIva     = fnCnvDouble (pHis->dAcumIva    ,USOFACT);
   pHis->dAcumDto     = fnCnvDouble (pHis->dAcumDto    ,USOFACT);

   dTotalAbonado =    pHis->dTotCargosMe + pHis->dAcumCargo + pHis->dAcumIva + pHis->dAcumDto;

   dTotalAbonado = fnCnvDouble(dTotalAbonado,USOFACT);

   vDTrazasLog(szExeName,"\t** TotalAbonado = [%f]\n"
   						 "\t** dTotCargosMe = [%f]\n"
   						 "\t** dAcumCargo	= [%f]\n"
   						 "\t** dAcumIva		= [%f]\n"
   						 "\t** dAcumDto	    = [%f]\n"
   						 , LOG05, dTotalAbonado
   						 , pHis->dTotCargosMe
   						 , pHis->dAcumCargo
   						 , pHis->dAcumIva
   						 , pHis->dAcumDto );

   /* PR-200402160376: Se controla condicion de borde por decimales */
   if (dTotalAbonado < 0.000001 && dTotalAbonado > -0.000001)
       dTotalAbonado = (double)0.0;

   if (dTotalAbonado < 0.0)
   {
       vLiberaAcumulador();
       iDError(szExeName, ERR061, vInsertarIncidencia,pHis->lCodCliente,pHis->lNumAbonado);
       return FALSE;
   }

   if (!bfnMuestraAcumulados())
    vDTrazasLog(szExeName,"Error mostrando LISTA ENLAZADA acumulados\n", LOG01);

   if (!fnbChequeaAcumulados())
   {
        iDError(szExeName, ERR62, vInsertarIncidencia,pHis->lCodCliente,pHis->lNumAbonado);
        vLiberaAcumulador();
   }

   return TRUE;
}/************************** Final bfnGetTotCargosMeAbo **********************/

/*****************************************************************************/
/*                         funcion : bfnGetLimCredito                        */
/*****************************************************************************/
static BOOL bfnGetLimCredito (int     iCodCredito, int iCodProducto,
                              double *dLimCredito, int iTipoFact)
{
  double dImpMorosidad = 0.0;

  LIMCREDITOS stkey                    ;
  LIMCREDITOS *pL = (LIMCREDITOS *)NULL;

  memset (&stkey,0,sizeof(LIMCREDITOS));

  vDTrazasLog (szExeName,"\n\t\t* Parametros Entrada Co_LimCreditos\n"
             "\t\t=> Cod.Credito   [%d]\n"
                     "\t\t=> Cod.Producto  [%d]\n",LOG06,
                     iCodCredito,iCodProducto);

  if (iTipoFact != stDatosGener.iCodCiclo)
  {
      /* EXEC SQL SELECT /o+ index (CO_LIMCREDITOS PK_CO_LIMCREDITOS) o/
                      IMP_MOROSIDAD
               INTO   :dImpMorosidad
               FROM   CO_LIMCREDITOS
               WHERE  COD_CREDMOR = :iCodCredito
                 AND  COD_PRODUCTO= :iCodProducto; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 60;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select  /*+  index (CO_LIMCREDITOS PK_CO_LIMCREDITOS)  \
+*/ IMP_MOROSIDAD into :b0  from CO_LIMCREDITOS where (COD_CREDMOR=:b1 and COD\
_PRODUCTO=:b2)";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )869;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&dImpMorosidad;
      sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)&iCodCredito;
      sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[1] = (         int  )0;
      sqlstm.sqindv[1] = (         short *)0;
      sqlstm.sqinds[1] = (         int  )0;
      sqlstm.sqharm[1] = (unsigned long )0;
      sqlstm.sqadto[1] = (unsigned short )0;
      sqlstm.sqtdso[1] = (unsigned short )0;
      sqlstm.sqhstv[2] = (unsigned char  *)&iCodProducto;
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


      if (SQLCODE)
      {
          iDError (szExeName,ERR000,vInsertarIncidencia,
                   "Select->Co_LimCreditos",szfnORAerror());
          return FALSE;
      }
      if (SQLCODE == SQLOK)
          *dLimCredito = dImpMorosidad;
      return TRUE;
  }
  stkey.iCodCredMor = iCodCredito ;
  stkey.iCodProducto= iCodProducto;

  if ((pL = (LIMCREDITOS *)bsearch (&stkey,pstLimCreditos,NUM_LIMCREDITOS,
                                     sizeof(LIMCREDITOS),iCmpLimCreditos))
          ==(LIMCREDITOS *)NULL)
  {
       iDError (szExeName,ERR021,vInsertarIncidencia,"pstLimCreditos");
       return FALSE;

  }
  *dLimCredito = pL->dImpMorosidad;
  return TRUE;
}/************************* Final bfnGetLimCredito ***************************/

/*****************************************************************************/
/*                          funcion : bInsertHistAbo                         */
/*****************************************************************************/
static BOOL bfnInsertHistAbo (HISTABOP *stHis,int iCodProducto)
{
  char szFuncion [25]  ="\0"    ;
  char szCadena  [1500]="\0"    ;
  char szNomTable[25]  ="\0"    ;

  int  i               = 0    ;
  int  j               = 0    ;
  BOOL bError          = FALSE;
  int  iInd            = 0    ;/* Indice del Reg. donde se Produce Error */

  /* EXEC SQL BEGIN DECLARE SECTION; */ 


  static long   lhIndOrdenTotal    [NREG_HOSTARRAY]    ;
  static long   lhNumAbonado       [NREG_HOSTARRAY]    ;
  static int    ihCodZonaAbon      [NREG_HOSTARRAY]    ;
  static long   lhCodCliente       [NREG_HOSTARRAY]    ;
  static double dhTotCargosMe      [NREG_HOSTARRAY]    ;
  static double dhAcumCargo        [NREG_HOSTARRAY]    ;
  static double dhAcumIva          [NREG_HOSTARRAY]    ;
  static double dhAcumDto          [NREG_HOSTARRAY]    ;
  static int    ihCodProducto      [NREG_HOSTARRAY]    ;
  static char   szhCodSituacion    [NREG_HOSTARRAY] [4]; /* EXEC SQL VAR szhCodSituacion   IS STRING(4) ; */ 

  static char   szhNumTerminal     [NREG_HOSTARRAY][16]; /* EXEC SQL VAR szhNumTerminal    IS STRING(16); */ 

  static char   szhNumBeeper       [NREG_HOSTARRAY][16]; /* EXEC SQL VAR szhNumBeeper      IS STRING(16); */ 

  static int    ihCodDetFact       [NREG_HOSTARRAY]    ;
  static char   szhFecFinContra    [NREG_HOSTARRAY][15]; /* EXEC SQL VAR szhFecFinContra   IS STRING(15); */ 

  static int    ihIndFactur        [NREG_HOSTARRAY]    ;
  static int    ihCodCredMor       [NREG_HOSTARRAY]    ;
  static char   szhNomApellido1    [NREG_HOSTARRAY][21]; /* EXEC SQL VAR szhNomApellido1   IS STRING(21); */ 

  static char   szhNomApellido2    [NREG_HOSTARRAY][21]; /* EXEC SQL VAR szhNomApellido2   IS STRING(21); */ 

  static char   szhNomUsuario      [NREG_HOSTARRAY][21]; /* EXEC SQL VAR szhNomUsuario     IS STRING(21); */ 

  static double dhLimCredito       [NREG_HOSTARRAY]    ;
  static long   lhCapCode          [NREG_HOSTARRAY]    ;
  static int    ihIndSuperTel      [NREG_HOSTARRAY]    ;
  static int    ihIndPrePago       [NREG_HOSTARRAY]    ;
  static char   szhNumTeleFija     [NREG_HOSTARRAY][16]; /* EXEC SQL VAR szhNumTeleFija    IS STRING(16); */ 

  static int    ihIndCobroDetLlam  [NREG_HOSTARRAY]    ;
  static short  i_shNumTerminal    [NREG_HOSTARRAY]    ;
  static short  i_shCapCode        [NREG_HOSTARRAY]    ;
  static short  i_Fec              [NREG_HOSTARRAY]    ;
  static short  i_shCodCredMor     [NREG_HOSTARRAY]    ;
  static short  i_shNomApellido1   [NREG_HOSTARRAY]    ;
  static short  i_shNomApellido2   [NREG_HOSTARRAY]    ;
  static short  i_shNomUsuario     [NREG_HOSTARRAY]    ;
  static short  i_shIndSuperTel    [NREG_HOSTARRAY]    ;
  static short  i_shIndPrePago     [NREG_HOSTARRAY]    ;
  static short  i_shNumTeleFija    [NREG_HOSTARRAY]    ;
  static short  i_shLimCredito     [NREG_HOSTARRAY]    ;
  static short  i_shIndCobroDetLlam[NREG_HOSTARRAY]    ;
  /* EXEC SQL END DECLARE SECTION; */ 



    if (stProceso.iCodTipDocum == stDatosGener.iCodCiclo)
    {
        sprintf(szNomTable,"FA_FACTABON_%ld\0",stCiclo.lCodCiclFact);
    }
    else
    {
        strcpy (szNomTable,"FA_FACTABON_NOCICLO") ;
    }
    vfnInitCadenaInsertHistAbo (szCadena,szNomTable);

    /* EXEC SQL PREPARE sql_insert_histabon FROM :szCadena; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 60;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )896;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadena;
    sqlstm.sqhstl[0] = (unsigned long )1500;
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


    if (SQLCODE)
    {
        sprintf (szFuncion,"PrePare=>%s",szNomTable);
        iDError (szExeName,ERR000,vInsertarIncidencia,szFuncion,szfnORAerror ());
        return (FALSE);
    }

    vDTrazasLog (szExeName,"\n\t\t* Entrada bfnInsertHistAbo  NumReg=%d\n", LOG03, stHis->iNumReg);

    /************************************************************/

    for (j=0;j<stHis->iNumReg;j++)
    {
       
        lhIndOrdenTotal [i] = atol(stHis->pAbo[j].szIndOrdenTotal)   ;
        lhNumAbonado    [i] = stHis->pAbo[j].lNumAbonado             ;
        ihCodZonaAbon   [i] = stHis->pAbo[j].iCodZonaAbon            ;
        lhCodCliente    [i] = stHis->pAbo[j].lCodCliente             ;
        dhTotCargosMe   [i] = stHis->pAbo[j].dTotCargosMe            ;
        dhAcumCargo     [i] = stHis->pAbo[j].dAcumCargo              ;
        dhAcumIva       [i] = stHis->pAbo[j].dAcumIva                ;
        dhAcumDto       [i] = stHis->pAbo[j].dAcumDto                ;
        ihCodProducto   [i] = iCodProducto                          ;

        strcpy(szhCodSituacion  [i], "ZZZ");
        strcpy(szhNumBeeper     [i], "0")  ;

        ihCodCredMor  [i] = stHis->pAbo[j].iCodCredMor             ;
        i_shCodCredMor[i] = (stHis->pAbo[j].iCodCredMor == ORA_NULL)?ORA_NULL:0;
        ihCodDetFact  [i] = stHis->pAbo[j].iCodDetFact                        ;
        strcpy (szhFecFinContra [i], stHis->pAbo[j].szFecFinContra);
        ihIndFactur   [i] = stHis->pAbo[j].iIndFactur    ;
        strcpy (szhNomUsuario[i], stHis->pAbo[j].szNomUsuario);

        if (strcmp(stHis->pAbo[j].szNumTerminal, "") == 0)
            i_shNumTerminal [i] = ORA_NULL;
        else
        {
            i_shNumTerminal [i] = 0;
            strcpy (szhNumTerminal[i],stHis->pAbo[j].szNumTerminal);
        }

        if (strcmp (stHis->pAbo[j].szFecFinContra,"") == 0)
            i_Fec [i] = ORA_NULL;
        else
            i_Fec [i] = 0       ;

        if (strcmp (stHis->pAbo[j].szNomUsuario,"") == 0)
            i_shNomUsuario [i] = ORA_NULL;
        else
            i_shNomUsuario [i] = 0       ;

        strcpy (szhNomApellido1[i], stHis->pAbo[j].szNomApellido1);

        if (strcmp (stHis->pAbo[j].szNomApellido1,"") == 0)
            i_shNomApellido1 [i] = ORA_NULL;
        else
            i_shNomApellido1 [i] = 0       ;

        strcpy (szhNomApellido2 [i], stHis->pAbo[j].szNomApellido2);
        if (strcmp (stHis->pAbo[j].szNomApellido2,"") == 0)
            i_shNomApellido2 [i] = ORA_NULL;
        else
            i_shNomApellido2 [i] = 0       ;

        dhLimCredito  [i]  = stHis->pAbo[j].dLimCredito ;
        ihIndSuperTel [i]  = stHis->pAbo[j].iIndSuperTel;

        i_shIndSuperTel[i] = (ihIndSuperTel[i] == ORA_NULL)?ORA_NULL:0;
        i_shIndPrePago [i] = (ihIndPrePago [i] == ORA_NULL)?ORA_NULL:0;
        
        ihIndCobroDetLlam [i]  = stHis->pAbo[j].iIndCobroDetLlam;
        i_shIndCobroDetLlam [i] = (ihIndCobroDetLlam [i] == ORA_NULL)?ORA_NULL:0;

        strcpy (szhNumTeleFija [i], stHis->pAbo[j].szNumTeleFija);
        if (strcmp (szhNumTeleFija[i],"") == 0)
            i_shNumTeleFija [i] = ORA_NULL;
        else
            i_shNumTeleFija [i] = 0       ;

        vfnPrintHistAbo (&stHis->pAbo[j],j,bError)     ;

        if (i == NREG_HOSTARRAY-1)
        {
            
            /* EXEC SQL FOR :NREG_HOSTARRAY
                EXECUTE sql_insert_histabon
                USING   :lhIndOrdenTotal                 ,
                        :lhNumAbonado                    ,
                        :ihCodZonaAbon                   ,
                        :lhCodCliente                    ,
                        :ihCodProducto                   ,
                        :szhCodSituacion                 ,
                        :dhTotCargosMe                   ,
                        :dhAcumCargo                     ,
                        :dhAcumDto                       ,
                        :dhAcumIva                       ,
                        :ihCodDetFact                    ,
                        :szhFecFinContra:i_Fec           ,
                        :ihIndFactur                     ,
                        :ihCodCredMor:i_shCodCredMor     ,
                        :szhNomUsuario:i_shNomUsuario    ,
                        :szhNomApellido1:i_shNomApellido1,
                        :szhNomApellido2:i_shNomApellido2,
                        :dhLimCredito:i_shLimCredito     ,
                        :szhNumTerminal:i_shNumTerminal  ,
                        :szhNumBeeper                    ,
                        :lhCapCode:i_shCapCode           ,
                        :ihIndSuperTel                   ,
                        :szhNumTeleFija:i_shNumTeleFija  ,
                        :ihIndCobroDetLlam:i_shIndCobroDetLlam; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 60;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "";
            sqlstm.iters = (unsigned int  )80;
            sqlstm.offset = (unsigned int  )915;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)lhIndOrdenTotal;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[0] = (         int  )sizeof(long);
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqharc[0] = (unsigned long  *)0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)lhNumAbonado;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[1] = (         int  )sizeof(long);
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqharc[1] = (unsigned long  *)0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)ihCodZonaAbon;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[2] = (         int  )sizeof(int);
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqharc[2] = (unsigned long  *)0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)lhCodCliente;
            sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[3] = (         int  )sizeof(long);
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqharc[3] = (unsigned long  *)0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)ihCodProducto;
            sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[4] = (         int  )sizeof(int);
            sqlstm.sqindv[4] = (         short *)0;
            sqlstm.sqinds[4] = (         int  )0;
            sqlstm.sqharm[4] = (unsigned long )0;
            sqlstm.sqharc[4] = (unsigned long  *)0;
            sqlstm.sqadto[4] = (unsigned short )0;
            sqlstm.sqtdso[4] = (unsigned short )0;
            sqlstm.sqhstv[5] = (unsigned char  *)szhCodSituacion;
            sqlstm.sqhstl[5] = (unsigned long )4;
            sqlstm.sqhsts[5] = (         int  )4;
            sqlstm.sqindv[5] = (         short *)0;
            sqlstm.sqinds[5] = (         int  )0;
            sqlstm.sqharm[5] = (unsigned long )0;
            sqlstm.sqharc[5] = (unsigned long  *)0;
            sqlstm.sqadto[5] = (unsigned short )0;
            sqlstm.sqtdso[5] = (unsigned short )0;
            sqlstm.sqhstv[6] = (unsigned char  *)dhTotCargosMe;
            sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[6] = (         int  )sizeof(double);
            sqlstm.sqindv[6] = (         short *)0;
            sqlstm.sqinds[6] = (         int  )0;
            sqlstm.sqharm[6] = (unsigned long )0;
            sqlstm.sqharc[6] = (unsigned long  *)0;
            sqlstm.sqadto[6] = (unsigned short )0;
            sqlstm.sqtdso[6] = (unsigned short )0;
            sqlstm.sqhstv[7] = (unsigned char  *)dhAcumCargo;
            sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[7] = (         int  )sizeof(double);
            sqlstm.sqindv[7] = (         short *)0;
            sqlstm.sqinds[7] = (         int  )0;
            sqlstm.sqharm[7] = (unsigned long )0;
            sqlstm.sqharc[7] = (unsigned long  *)0;
            sqlstm.sqadto[7] = (unsigned short )0;
            sqlstm.sqtdso[7] = (unsigned short )0;
            sqlstm.sqhstv[8] = (unsigned char  *)dhAcumDto;
            sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[8] = (         int  )sizeof(double);
            sqlstm.sqindv[8] = (         short *)0;
            sqlstm.sqinds[8] = (         int  )0;
            sqlstm.sqharm[8] = (unsigned long )0;
            sqlstm.sqharc[8] = (unsigned long  *)0;
            sqlstm.sqadto[8] = (unsigned short )0;
            sqlstm.sqtdso[8] = (unsigned short )0;
            sqlstm.sqhstv[9] = (unsigned char  *)dhAcumIva;
            sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[9] = (         int  )sizeof(double);
            sqlstm.sqindv[9] = (         short *)0;
            sqlstm.sqinds[9] = (         int  )0;
            sqlstm.sqharm[9] = (unsigned long )0;
            sqlstm.sqharc[9] = (unsigned long  *)0;
            sqlstm.sqadto[9] = (unsigned short )0;
            sqlstm.sqtdso[9] = (unsigned short )0;
            sqlstm.sqhstv[10] = (unsigned char  *)ihCodDetFact;
            sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[10] = (         int  )sizeof(int);
            sqlstm.sqindv[10] = (         short *)0;
            sqlstm.sqinds[10] = (         int  )0;
            sqlstm.sqharm[10] = (unsigned long )0;
            sqlstm.sqharc[10] = (unsigned long  *)0;
            sqlstm.sqadto[10] = (unsigned short )0;
            sqlstm.sqtdso[10] = (unsigned short )0;
            sqlstm.sqhstv[11] = (unsigned char  *)szhFecFinContra;
            sqlstm.sqhstl[11] = (unsigned long )15;
            sqlstm.sqhsts[11] = (         int  )15;
            sqlstm.sqindv[11] = (         short *)i_Fec;
            sqlstm.sqinds[11] = (         int  )sizeof(short);
            sqlstm.sqharm[11] = (unsigned long )0;
            sqlstm.sqharc[11] = (unsigned long  *)0;
            sqlstm.sqadto[11] = (unsigned short )0;
            sqlstm.sqtdso[11] = (unsigned short )0;
            sqlstm.sqhstv[12] = (unsigned char  *)ihIndFactur;
            sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[12] = (         int  )sizeof(int);
            sqlstm.sqindv[12] = (         short *)0;
            sqlstm.sqinds[12] = (         int  )0;
            sqlstm.sqharm[12] = (unsigned long )0;
            sqlstm.sqharc[12] = (unsigned long  *)0;
            sqlstm.sqadto[12] = (unsigned short )0;
            sqlstm.sqtdso[12] = (unsigned short )0;
            sqlstm.sqhstv[13] = (unsigned char  *)ihCodCredMor;
            sqlstm.sqhstl[13] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[13] = (         int  )sizeof(int);
            sqlstm.sqindv[13] = (         short *)i_shCodCredMor;
            sqlstm.sqinds[13] = (         int  )sizeof(short);
            sqlstm.sqharm[13] = (unsigned long )0;
            sqlstm.sqharc[13] = (unsigned long  *)0;
            sqlstm.sqadto[13] = (unsigned short )0;
            sqlstm.sqtdso[13] = (unsigned short )0;
            sqlstm.sqhstv[14] = (unsigned char  *)szhNomUsuario;
            sqlstm.sqhstl[14] = (unsigned long )21;
            sqlstm.sqhsts[14] = (         int  )21;
            sqlstm.sqindv[14] = (         short *)i_shNomUsuario;
            sqlstm.sqinds[14] = (         int  )sizeof(short);
            sqlstm.sqharm[14] = (unsigned long )0;
            sqlstm.sqharc[14] = (unsigned long  *)0;
            sqlstm.sqadto[14] = (unsigned short )0;
            sqlstm.sqtdso[14] = (unsigned short )0;
            sqlstm.sqhstv[15] = (unsigned char  *)szhNomApellido1;
            sqlstm.sqhstl[15] = (unsigned long )21;
            sqlstm.sqhsts[15] = (         int  )21;
            sqlstm.sqindv[15] = (         short *)i_shNomApellido1;
            sqlstm.sqinds[15] = (         int  )sizeof(short);
            sqlstm.sqharm[15] = (unsigned long )0;
            sqlstm.sqharc[15] = (unsigned long  *)0;
            sqlstm.sqadto[15] = (unsigned short )0;
            sqlstm.sqtdso[15] = (unsigned short )0;
            sqlstm.sqhstv[16] = (unsigned char  *)szhNomApellido2;
            sqlstm.sqhstl[16] = (unsigned long )21;
            sqlstm.sqhsts[16] = (         int  )21;
            sqlstm.sqindv[16] = (         short *)i_shNomApellido2;
            sqlstm.sqinds[16] = (         int  )sizeof(short);
            sqlstm.sqharm[16] = (unsigned long )0;
            sqlstm.sqharc[16] = (unsigned long  *)0;
            sqlstm.sqadto[16] = (unsigned short )0;
            sqlstm.sqtdso[16] = (unsigned short )0;
            sqlstm.sqhstv[17] = (unsigned char  *)dhLimCredito;
            sqlstm.sqhstl[17] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[17] = (         int  )sizeof(double);
            sqlstm.sqindv[17] = (         short *)i_shLimCredito;
            sqlstm.sqinds[17] = (         int  )sizeof(short);
            sqlstm.sqharm[17] = (unsigned long )0;
            sqlstm.sqharc[17] = (unsigned long  *)0;
            sqlstm.sqadto[17] = (unsigned short )0;
            sqlstm.sqtdso[17] = (unsigned short )0;
            sqlstm.sqhstv[18] = (unsigned char  *)szhNumTerminal;
            sqlstm.sqhstl[18] = (unsigned long )16;
            sqlstm.sqhsts[18] = (         int  )16;
            sqlstm.sqindv[18] = (         short *)i_shNumTerminal;
            sqlstm.sqinds[18] = (         int  )sizeof(short);
            sqlstm.sqharm[18] = (unsigned long )0;
            sqlstm.sqharc[18] = (unsigned long  *)0;
            sqlstm.sqadto[18] = (unsigned short )0;
            sqlstm.sqtdso[18] = (unsigned short )0;
            sqlstm.sqhstv[19] = (unsigned char  *)szhNumBeeper;
            sqlstm.sqhstl[19] = (unsigned long )16;
            sqlstm.sqhsts[19] = (         int  )16;
            sqlstm.sqindv[19] = (         short *)0;
            sqlstm.sqinds[19] = (         int  )0;
            sqlstm.sqharm[19] = (unsigned long )0;
            sqlstm.sqharc[19] = (unsigned long  *)0;
            sqlstm.sqadto[19] = (unsigned short )0;
            sqlstm.sqtdso[19] = (unsigned short )0;
            sqlstm.sqhstv[20] = (unsigned char  *)lhCapCode;
            sqlstm.sqhstl[20] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[20] = (         int  )sizeof(long);
            sqlstm.sqindv[20] = (         short *)i_shCapCode;
            sqlstm.sqinds[20] = (         int  )sizeof(short);
            sqlstm.sqharm[20] = (unsigned long )0;
            sqlstm.sqharc[20] = (unsigned long  *)0;
            sqlstm.sqadto[20] = (unsigned short )0;
            sqlstm.sqtdso[20] = (unsigned short )0;
            sqlstm.sqhstv[21] = (unsigned char  *)ihIndSuperTel;
            sqlstm.sqhstl[21] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[21] = (         int  )sizeof(int);
            sqlstm.sqindv[21] = (         short *)0;
            sqlstm.sqinds[21] = (         int  )0;
            sqlstm.sqharm[21] = (unsigned long )0;
            sqlstm.sqharc[21] = (unsigned long  *)0;
            sqlstm.sqadto[21] = (unsigned short )0;
            sqlstm.sqtdso[21] = (unsigned short )0;
            sqlstm.sqhstv[22] = (unsigned char  *)szhNumTeleFija;
            sqlstm.sqhstl[22] = (unsigned long )16;
            sqlstm.sqhsts[22] = (         int  )16;
            sqlstm.sqindv[22] = (         short *)i_shNumTeleFija;
            sqlstm.sqinds[22] = (         int  )sizeof(short);
            sqlstm.sqharm[22] = (unsigned long )0;
            sqlstm.sqharc[22] = (unsigned long  *)0;
            sqlstm.sqadto[22] = (unsigned short )0;
            sqlstm.sqtdso[22] = (unsigned short )0;
            sqlstm.sqhstv[23] = (unsigned char  *)ihIndCobroDetLlam;
            sqlstm.sqhstl[23] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[23] = (         int  )sizeof(int);
            sqlstm.sqindv[23] = (         short *)i_shIndCobroDetLlam;
            sqlstm.sqinds[23] = (         int  )sizeof(short);
            sqlstm.sqharm[23] = (unsigned long )0;
            sqlstm.sqharc[23] = (unsigned long  *)0;
            sqlstm.sqadto[23] = (unsigned short )0;
            sqlstm.sqtdso[23] = (unsigned short )0;
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
                sprintf(szFuncion,"Insert(1)=>%s",szNomTable);
                iInd  =(sqlca.sqlerrd[2] == SQLOK)?SQLOK:sqlca.sqlerrd[2]-1;
                bError= TRUE                 ;
                iDError (szExeName,ERR000,vInsertarIncidencia,szFuncion,szfnORAerror())     ;
                vfnPrintHistAbo (&stHis->pAbo[iInd],iInd,bError);
                return  TRUE;
            }
            else
            {
                i = 0;
            }
        }/* if i == NREG_HOSTARRAY */
        else
        {
            i++;
        }
    }/* for j ... */
    
    if (i > 0)
    {
        /* EXEC SQL FOR :i
                 EXECUTE sql_insert_histabon
                 USING   :lhIndOrdenTotal                 ,
                         :lhNumAbonado                    ,
                         :ihCodZonaAbon                   ,
                         :lhCodCliente                    ,
                         :ihCodProducto                   ,
                         :szhCodSituacion                 ,
                         :dhTotCargosMe                   ,
                         :dhAcumCargo                     ,
                         :dhAcumDto                       ,
                         :dhAcumIva                       ,
                         :ihCodDetFact                    ,
                         :szhFecFinContra:i_Fec           ,
                         :ihIndFactur                     ,
                         :ihCodCredMor:i_shCodCredMor     ,
                         :szhNomUsuario:i_shNomUsuario    ,
                         :szhNomApellido1:i_shNomApellido1,
                         :szhNomApellido2:i_shNomApellido2,
                         :dhLimCredito:i_shLimCredito     ,
                         :szhNumTerminal:i_shNumTerminal  ,
                         :szhNumBeeper                    ,
                         :lhCapCode:i_shCapCode           ,
                         :ihIndSuperTel                   ,
                         :szhNumTeleFija:i_shNumTeleFija  ,
                         :ihIndCobroDetLlam:i_shIndCobroDetLlam; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 60;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )i;
        sqlstm.offset = (unsigned int  )1026;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)lhIndOrdenTotal;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )sizeof(long);
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqharc[0] = (unsigned long  *)0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)lhNumAbonado;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )sizeof(long);
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqharc[1] = (unsigned long  *)0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)ihCodZonaAbon;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[2] = (         int  )sizeof(int);
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqharc[2] = (unsigned long  *)0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)lhCodCliente;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[3] = (         int  )sizeof(long);
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqharc[3] = (unsigned long  *)0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)ihCodProducto;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[4] = (         int  )sizeof(int);
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqharc[4] = (unsigned long  *)0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)szhCodSituacion;
        sqlstm.sqhstl[5] = (unsigned long )4;
        sqlstm.sqhsts[5] = (         int  )4;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqharc[5] = (unsigned long  *)0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)dhTotCargosMe;
        sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[6] = (         int  )sizeof(double);
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqharc[6] = (unsigned long  *)0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)dhAcumCargo;
        sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[7] = (         int  )sizeof(double);
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqharc[7] = (unsigned long  *)0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)dhAcumDto;
        sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[8] = (         int  )sizeof(double);
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqharc[8] = (unsigned long  *)0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)dhAcumIva;
        sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[9] = (         int  )sizeof(double);
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqharc[9] = (unsigned long  *)0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)ihCodDetFact;
        sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[10] = (         int  )sizeof(int);
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqharc[10] = (unsigned long  *)0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
        sqlstm.sqhstv[11] = (unsigned char  *)szhFecFinContra;
        sqlstm.sqhstl[11] = (unsigned long )15;
        sqlstm.sqhsts[11] = (         int  )15;
        sqlstm.sqindv[11] = (         short *)i_Fec;
        sqlstm.sqinds[11] = (         int  )sizeof(short);
        sqlstm.sqharm[11] = (unsigned long )0;
        sqlstm.sqharc[11] = (unsigned long  *)0;
        sqlstm.sqadto[11] = (unsigned short )0;
        sqlstm.sqtdso[11] = (unsigned short )0;
        sqlstm.sqhstv[12] = (unsigned char  *)ihIndFactur;
        sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[12] = (         int  )sizeof(int);
        sqlstm.sqindv[12] = (         short *)0;
        sqlstm.sqinds[12] = (         int  )0;
        sqlstm.sqharm[12] = (unsigned long )0;
        sqlstm.sqharc[12] = (unsigned long  *)0;
        sqlstm.sqadto[12] = (unsigned short )0;
        sqlstm.sqtdso[12] = (unsigned short )0;
        sqlstm.sqhstv[13] = (unsigned char  *)ihCodCredMor;
        sqlstm.sqhstl[13] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[13] = (         int  )sizeof(int);
        sqlstm.sqindv[13] = (         short *)i_shCodCredMor;
        sqlstm.sqinds[13] = (         int  )sizeof(short);
        sqlstm.sqharm[13] = (unsigned long )0;
        sqlstm.sqharc[13] = (unsigned long  *)0;
        sqlstm.sqadto[13] = (unsigned short )0;
        sqlstm.sqtdso[13] = (unsigned short )0;
        sqlstm.sqhstv[14] = (unsigned char  *)szhNomUsuario;
        sqlstm.sqhstl[14] = (unsigned long )21;
        sqlstm.sqhsts[14] = (         int  )21;
        sqlstm.sqindv[14] = (         short *)i_shNomUsuario;
        sqlstm.sqinds[14] = (         int  )sizeof(short);
        sqlstm.sqharm[14] = (unsigned long )0;
        sqlstm.sqharc[14] = (unsigned long  *)0;
        sqlstm.sqadto[14] = (unsigned short )0;
        sqlstm.sqtdso[14] = (unsigned short )0;
        sqlstm.sqhstv[15] = (unsigned char  *)szhNomApellido1;
        sqlstm.sqhstl[15] = (unsigned long )21;
        sqlstm.sqhsts[15] = (         int  )21;
        sqlstm.sqindv[15] = (         short *)i_shNomApellido1;
        sqlstm.sqinds[15] = (         int  )sizeof(short);
        sqlstm.sqharm[15] = (unsigned long )0;
        sqlstm.sqharc[15] = (unsigned long  *)0;
        sqlstm.sqadto[15] = (unsigned short )0;
        sqlstm.sqtdso[15] = (unsigned short )0;
        sqlstm.sqhstv[16] = (unsigned char  *)szhNomApellido2;
        sqlstm.sqhstl[16] = (unsigned long )21;
        sqlstm.sqhsts[16] = (         int  )21;
        sqlstm.sqindv[16] = (         short *)i_shNomApellido2;
        sqlstm.sqinds[16] = (         int  )sizeof(short);
        sqlstm.sqharm[16] = (unsigned long )0;
        sqlstm.sqharc[16] = (unsigned long  *)0;
        sqlstm.sqadto[16] = (unsigned short )0;
        sqlstm.sqtdso[16] = (unsigned short )0;
        sqlstm.sqhstv[17] = (unsigned char  *)dhLimCredito;
        sqlstm.sqhstl[17] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[17] = (         int  )sizeof(double);
        sqlstm.sqindv[17] = (         short *)i_shLimCredito;
        sqlstm.sqinds[17] = (         int  )sizeof(short);
        sqlstm.sqharm[17] = (unsigned long )0;
        sqlstm.sqharc[17] = (unsigned long  *)0;
        sqlstm.sqadto[17] = (unsigned short )0;
        sqlstm.sqtdso[17] = (unsigned short )0;
        sqlstm.sqhstv[18] = (unsigned char  *)szhNumTerminal;
        sqlstm.sqhstl[18] = (unsigned long )16;
        sqlstm.sqhsts[18] = (         int  )16;
        sqlstm.sqindv[18] = (         short *)i_shNumTerminal;
        sqlstm.sqinds[18] = (         int  )sizeof(short);
        sqlstm.sqharm[18] = (unsigned long )0;
        sqlstm.sqharc[18] = (unsigned long  *)0;
        sqlstm.sqadto[18] = (unsigned short )0;
        sqlstm.sqtdso[18] = (unsigned short )0;
        sqlstm.sqhstv[19] = (unsigned char  *)szhNumBeeper;
        sqlstm.sqhstl[19] = (unsigned long )16;
        sqlstm.sqhsts[19] = (         int  )16;
        sqlstm.sqindv[19] = (         short *)0;
        sqlstm.sqinds[19] = (         int  )0;
        sqlstm.sqharm[19] = (unsigned long )0;
        sqlstm.sqharc[19] = (unsigned long  *)0;
        sqlstm.sqadto[19] = (unsigned short )0;
        sqlstm.sqtdso[19] = (unsigned short )0;
        sqlstm.sqhstv[20] = (unsigned char  *)lhCapCode;
        sqlstm.sqhstl[20] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[20] = (         int  )sizeof(long);
        sqlstm.sqindv[20] = (         short *)i_shCapCode;
        sqlstm.sqinds[20] = (         int  )sizeof(short);
        sqlstm.sqharm[20] = (unsigned long )0;
        sqlstm.sqharc[20] = (unsigned long  *)0;
        sqlstm.sqadto[20] = (unsigned short )0;
        sqlstm.sqtdso[20] = (unsigned short )0;
        sqlstm.sqhstv[21] = (unsigned char  *)ihIndSuperTel;
        sqlstm.sqhstl[21] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[21] = (         int  )sizeof(int);
        sqlstm.sqindv[21] = (         short *)0;
        sqlstm.sqinds[21] = (         int  )0;
        sqlstm.sqharm[21] = (unsigned long )0;
        sqlstm.sqharc[21] = (unsigned long  *)0;
        sqlstm.sqadto[21] = (unsigned short )0;
        sqlstm.sqtdso[21] = (unsigned short )0;
        sqlstm.sqhstv[22] = (unsigned char  *)szhNumTeleFija;
        sqlstm.sqhstl[22] = (unsigned long )16;
        sqlstm.sqhsts[22] = (         int  )16;
        sqlstm.sqindv[22] = (         short *)i_shNumTeleFija;
        sqlstm.sqinds[22] = (         int  )sizeof(short);
        sqlstm.sqharm[22] = (unsigned long )0;
        sqlstm.sqharc[22] = (unsigned long  *)0;
        sqlstm.sqadto[22] = (unsigned short )0;
        sqlstm.sqtdso[22] = (unsigned short )0;
        sqlstm.sqhstv[23] = (unsigned char  *)ihIndCobroDetLlam;
        sqlstm.sqhstl[23] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[23] = (         int  )sizeof(int);
        sqlstm.sqindv[23] = (         short *)i_shIndCobroDetLlam;
        sqlstm.sqinds[23] = (         int  )sizeof(short);
        sqlstm.sqharm[23] = (unsigned long )0;
        sqlstm.sqharc[23] = (unsigned long  *)0;
        sqlstm.sqadto[23] = (unsigned short )0;
        sqlstm.sqtdso[23] = (unsigned short )0;
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
            sprintf (szFuncion,"Insert(2)=>%s",szNomTable);
            iInd  =(sqlca.sqlerrd[2] == SQLOK)?SQLOK:sqlca.sqlerrd[2]-1;
            bError= (TRUE);
            vfnPrintHistAbo (&stHis->pAbo[iInd],iInd,bError);
            iDError (szExeName,ERR000,vInsertarIncidencia,szFuncion,szfnORAerror())     ;
            return  (FALSE);
        }
    }
    return TRUE;
}/************************* Final bfnInsertHistAbo ***************************/


/*****************************************************************************/
/*                          funcion : vfnPrintHistAbo                        */
/*****************************************************************************/
static void vfnPrintHistAbo (HISTABO  *stHisAbo,
                             int      j       ,/* Indice del array       */
                             BOOL     bError  )/* Si True => Traza Error */
{
    char szTabla [20] = "";

    if (stProceso.iCodTipDocum == stDatosGener.iCodCiclo)
        sprintf(szTabla,"FA_FACTABON_%ld",stCiclo.lCodCiclFact);
    else
        strcpy (szTabla,"FA_FACTABON_NOCICLO");
    if (bError)
    {
        vDTrazasError (szExeName,
                    "\n\t\t=> Insertando en %.*s"
                    "\n\t\t [%d]-Ind.OrdenTotal    [%s] "
                    "\n\t\t [%d]-Num.Abonado       [%ld]"
                    "\n\t\t [%d]-Cod.Cliente       [%ld]"
                    "\n\t\t [%d]-Tot.Cargos Mes    [%f] "
                    "\n\t\t [%d]-Acum.Cargo        [%f] "
                    "\n\t\t [%d]-Acum.Dto          [%f] "
                    "\n\t\t [%d]-Acum.Iva          [%f] "
                    "\n\t\t [%d]-Num.Terminal      [%s] "
                    "\n\t\t [%d]-Cap.Code          [%ld]"
                    "\n\t\t [%d]-Cod.Detalle Fact. [%d] "
                    "\n\t\t [%d]-Fec.Fin Contrato  [%s] "
                    "\n\t\t [%d]-Ind.Factur        [%d] "
                    "\n\t\t [%d]-Cod.CredMor       [%d] "
                    "\n\t\t [%d]-Nom.Usuario       [%s] "
                    "\n\t\t [%d]-Nom.Apellido1     [%s] "
                    "\n\t\t [%d]-Nom.Apellido2     [%s] "
                    "\n\t\t [%d]-Lim.Credito       [%f] "
                    "\n\t\t [%d]-Ind.SuperTel      [%d] "
                    "\n\t\t [%d]-Num.TeleFija      [%s] "
                    "\n\t\t [%d]-Cod.ZonaAbon      [%d] "
                    "\n\t\t [%d]-Ind.CobDetLla     [%d] ",
                    LOG03,strlen(szTabla),szTabla,
                    j,stHisAbo->szIndOrdenTotal,
                    j,stHisAbo->lNumAbonado    ,
                    j,stHisAbo->lCodCliente    ,
                    j,stHisAbo->dTotCargosMe   ,
                    j,stHisAbo->dAcumCargo     ,
                    j,stHisAbo->dAcumDto       ,
                    j,stHisAbo->dAcumIva       ,
                    j,stHisAbo->szNumTerminal  ,
                    j,stHisAbo->lCapCode       ,
                    j,stHisAbo->iCodDetFact    ,
                    j,stHisAbo->szFecFinContra ,
                    j,stHisAbo->iIndFactur     ,
                    j,stHisAbo->iCodCredMor    ,
                    j,stHisAbo->szNomUsuario   ,
                    j,stHisAbo->szNomApellido1 ,
                    j,stHisAbo->szNomApellido2 ,
                    j,stHisAbo->dLimCredito    ,
                    j,stHisAbo->iIndSuperTel   ,
                    j,stHisAbo->szNumTeleFija  ,
                    j,stHisAbo->iCodZonaAbon   ,
                    j,stHisAbo->iIndCobroDetLlam) ;
    }
    else
    {
        vDTrazasLog   (szExeName,
                    "\n\t\t=> Insertando en %.*s"
                    "\n\t\t [%d]-Ind.OrdenTotal    [%s] "
                    "\n\t\t [%d]-Num.Abonado       [%ld]"
                    "\n\t\t [%d]-Cod.Cliente       [%ld]"
                    "\n\t\t [%d]-Tot.Cargos Mes    [%f] "
                    "\n\t\t [%d]-Acum.Cargo        [%f] "
                    "\n\t\t [%d]-Acum.Dto          [%f] "
                    "\n\t\t [%d]-Acum.Iva          [%f] "
                    "\n\t\t [%d]-Num.Terminal      [%s] "
                    "\n\t\t [%d]-Cap.Code          [%ld]"
                    "\n\t\t [%d]-Cod.Detalle Fact. [%d] "
                    "\n\t\t [%d]-Fec.Fin Contrato  [%s] "
                    "\n\t\t [%d]-Ind.Factur        [%d] "
                    "\n\t\t [%d]-Cod.CredMor       [%d] "
                    "\n\t\t [%d]-Nom.Usuario       [%s] "
                    "\n\t\t [%d]-Nom.Apellido1     [%s] "
                    "\n\t\t [%d]-Nom.Apellido2     [%s] "
                    "\n\t\t [%d]-Lim.Credito       [%f] "
                    "\n\t\t [%d]-Ind.SuperTel      [%d] "
                    "\n\t\t [%d]-Num.TeleFija      [%s] "
                    "\n\t\t [%d]-Cod.ZonaAbon      [%d] "
                    "\n\t\t [%d]-Ind.CobDetLla     [%d] ",
                    LOG05,strlen(szTabla),szTabla,
                    j,stHisAbo->szIndOrdenTotal,
                    j,stHisAbo->lNumAbonado    ,
                    j,stHisAbo->lCodCliente    ,
                    j,stHisAbo->dTotCargosMe   ,
                    j,stHisAbo->dAcumCargo     ,
                    j,stHisAbo->dAcumDto       ,
                    j,stHisAbo->dAcumIva       ,
                    j,stHisAbo->szNumTerminal  ,
                    j,stHisAbo->lCapCode       ,
                    j,stHisAbo->iCodDetFact    ,
                    j,stHisAbo->szFecFinContra ,
                    j,stHisAbo->iIndFactur     ,
                    j,stHisAbo->iCodCredMor    ,
                    j,stHisAbo->szNomUsuario   ,
                    j,stHisAbo->szNomApellido1 ,
                    j,stHisAbo->szNomApellido2 ,
                    j,stHisAbo->dLimCredito    ,
                    j,stHisAbo->iIndSuperTel   ,
                    j,stHisAbo->szNumTeleFija  ,
                    j,stHisAbo->iCodZonaAbon   ,
                    j,stHisAbo->iIndCobroDetLlam) ;
    }
}/************************** vfnPrintHistAbo *********************************/

/*****************************************************************************/
/*                         funcion : vfnInitCadenaInsertHistAbo              */
/*                      ":szNumTerminal             ,"                       */
/*                      ":szNumTerminal             ,"                       */
/*****************************************************************************/
static void vfnInitCadenaInsertHistAbo (char *szCadena  ,
                                        char *szNomTabla)
{
    sprintf (szCadena,
              "INSERT INTO %.*s ("
              "IND_ORDENTOTAL  ,"
              "NUM_ABONADO     ,"
              "COD_ZONAABON    ,"
              "COD_CLIENTE     ,"
              "COD_PRODUCTO    ,"
              "COD_SITUACION   ,"
              "TOT_CARGOSME    ,"
              "ACUM_CARGO      ,"
              "ACUM_DTO        ,"
              "ACUM_IVA        ,"
              "COD_DETFACT     ,"
              "FEC_FINCONTRA   ,"
              "IND_FACTUR      ,"
              "COD_CREDMOR     ,"
              "NOM_USUARIO     ,"
              "NOM_APELLIDO1   ,"
              "NOM_APELLIDO2   ,"
              "LIM_CREDITO     ,"
              "NUM_CELULAR     ,"
              "NUM_BEEPER      ,"
              "CAP_CODE        ,"
              "IND_SUPERTEL    ,"
              "NUM_TELEFIJA    ,"
              "IND_COBRODETLLAM)"
              "VALUES (:lhIndOrdenTotal           ,"
                      ":lNumAbonado               ,"
                      ":iCodZonaAbon              ,"
                      ":lCodCliente               ,"
                      ":iCodProducto              ,"
                      ":szCodSituacion            ,"
                      ":dTotCargosMe              ,"
                      ":dAcumCargo                ,"
                      ":dAcumDto                  ,"
                      ":dAcumIva                  ,"
                      ":iCodDetFact               ,"
                      "TO_DATE (:szFecFinContra,'YYYYMMDDHH24MISS'),"
                      ":iIndFactur                ,"
                      ":iCodCredMor               ,"
                      ":szNomUsuario              ,"
                      ":szNomApellido1            ,"
                      ":szNomApellido2            ,"
                      ":dLimCredito               ,"
                      ":szNumTerminal             ,"
                      ":szNumTerminal             ,"
                      ":lCapCode                  ,"
                      ":iIndSuperTel              ,"
                      ":szNumTeleFija             ,"
                      ":iIndCobroDetLlam)\0",strlen (szNomTabla),szNomTabla);

}/************************* Final vfnInitCadenaInsertHistAbo *****************/

/*****************************************************************************/
/*                        funcion : vPrintHistConc                           */
/*****************************************************************************/


/*****************************************************************************/
/*                              funcion : vInitCadena                        */
/*****************************************************************************/
static void vfnInitCadenaInsertHistConc (char *szCadena,char *szTabla )
{
    vDTrazasLog (szExeName, "\n\t\t=> Compone Insert [%s]", LOG04, szTabla);
    sprintf (szCadena,
                "INSERT INTO %.*s "
                "(IND_ORDENTOTAL  ,"
                "COD_CONCEPTO     ,"
                "COLUMNA          ,"
                "COD_MONEDA       ,"
                "COD_PRODUCTO     ,"
                "COD_TIPCONCE     ,"
                "FEC_VALOR        ,"
                "FEC_EFECTIVIDAD  ,"
                "IMP_CONCEPTO     ,"
                "COD_REGION       ,"
                "COD_PROVINCIA    ,"
                "COD_CIUDAD       ,"
                "IMP_MONTOBASE    ,"
                "IND_FACTUR       ,"
                "IMP_FACTURABLE   ,"
                "IND_SUPERTEL     ,"
                "NUM_ABONADO      ,"
                "COD_PORTADOR     ,"
                "DES_CONCEPTO     ,"
                "SEG_CONSUMIDO    ,"
                "SEQ_CUOTAS       ,"
                "NUM_CUOTAS       ,"
                "ORD_CUOTA        ,"
                "NUM_UNIDADES     ,"
                "NUM_SERIEMEC     ,"
                "NUM_SERIELE      ,"
                "PRC_IMPUESTO     ,"
                "VAL_DTO          ,"
                "TIP_DTO          ,"
                "MES_GARANTIA     ,"
                "NUM_GUIA         ,"
                "IND_ALTA         ,"
                "NUM_PAQUETE      ,"
                "FLAG_IMPUES      ,"
                "FLAG_DTO         ,"
                "COD_CONCEREL     ,"
                "COLUMNA_REL      ,"
                "COD_PLANTARIF    ,"
                "COD_CARGOBASICO  ,"
                "TIP_PLANTARIF    ,"
                "IMP_REAL         ,"
                "IMP_DCTO         ,"
                "DUR_REAL         ,"
                "DUR_DCTO         ,"
                "CNT_LLAM_REAL    ,"
                "CNT_LLAM_DCTO    ,"
                "CNT_LLAM_FACT    ,"
                "IMP_VALUNITARIO  ,"
                "GLS_DESCRIP      ,"
                "NUM_VENTA	  ,"
                "NUM_PULSO	  ,"
                "IMP_FACT_CON_IVA )" /* P-MIX-09003 77 */
            "VALUES( "
                "TO_NUMBER(:szIndOrdenTotal),"
                ":iCodConcepto   ,"
                ":lColumna       ,"
                ":szCodMoneda    ,"
                ":iCodProducto   ,"
                ":iCodTipConce   ,"
                "TO_DATE(:szFecValor      ,'YYYYMMDDHH24MISS'),"
                "TO_DATE(:szFecEfectividad,'YYYYMMDDHH24MISS'),"
                ":dImpConcepto   ,"
                ":szCodRegion    ,"
                ":szCodProvincia ,"
                ":szCodCiudad    ,"
                ":dImpMontoBase  ,"
                ":iIndFactur     ,"
                ":dImpFacturable ,"
                ":iIndSuperTel   ,"
                ":lNumAbonado    ,"
                ":iCodPortador   ,"
                ":szDesConcepto  ,"
                ":lSegConsumido  ,"
                ":lSeqCuotas     ,"
                ":iNumCuotas     ,"
                ":iOrdCuota      ,"
                ":iNumUnidades   ,"
                ":szNumSerieMec  ,"
                ":szNumSerieLe   ,"
                ":fPrcImpuesto   ,"
                ":dValDto        ,"
                ":iTipDto        ,"
                ":iMesGarantia   ,"
                ":szNumGuia      ,"
                ":iIndAlta       ,"
                ":iNumPaquete    ,"
                ":iFlagImpues    ,"
                ":iFlagDto       ,"
                ":iCodConceRel   ,"
                ":lColumnaRel    ,"
                ":szCodPlanTarif ,"
                ":szCodCargoBasico,"
                ":szTipPlanTarif ,"
                ":dhMtoReal      ,"
                ":dhMtoDcto      ,"
                ":lhDurReal      ,"
                ":lhDurDcto      ,"
                ":lhCntLlamReal  ,"
                ":lhCntLlamFact  ,"
                ":lhCntLlamDcto  ,"
                ":dImpValunitario,"
                ":szhGlsDescrip  ,"
                ":lhNumVenta     ,"
                ":lhNumPulsos    ,"
                ":dImpFactConIva )" /* P-MIX-09003 77 */
             ,strlen(szTabla),szTabla);
}/******************************** Final vInitCadena *************************/

/*****************************************************************************/
/*                            funcion : bfnInsertHistConc                   */
/*****************************************************************************/
static BOOL bfnInsertHistConc(int piNumRegs )
{

	char  modulo[] = "bfnInsertHistConc";
/* EXEC SQL BEGIN DECLARE SECTION; */ 

    char    szIndOrdenTotal [NREG_CONC_HOSTARRAY][13];
    int     iCodConcepto    [NREG_CONC_HOSTARRAY];
    long    lColumna        [NREG_CONC_HOSTARRAY];
    char    szCodMoneda     [NREG_CONC_HOSTARRAY][4];
    short   iCodProducto    [NREG_CONC_HOSTARRAY];
    int     iCodTipConce    [NREG_CONC_HOSTARRAY];
    char    szFecValor      [NREG_CONC_HOSTARRAY][15];
    char    szFecEfectividad[NREG_CONC_HOSTARRAY][15];
    double  dImpConcepto    [NREG_CONC_HOSTARRAY];
    char    szCodRegion     [NREG_CONC_HOSTARRAY][4];
    char    szCodProvincia  [NREG_CONC_HOSTARRAY][6];
    char    szCodCiudad     [NREG_CONC_HOSTARRAY][6];
    double  dImpMontoBase   [NREG_CONC_HOSTARRAY];
    short   iIndFactur      [NREG_CONC_HOSTARRAY];
    double  dImpFacturable  [NREG_CONC_HOSTARRAY];
    short   iIndSuperTel    [NREG_CONC_HOSTARRAY];
    long    lNumAbonado     [NREG_CONC_HOSTARRAY];
    int     iCodPortador    [NREG_CONC_HOSTARRAY];
    char    szDesConcepto   [NREG_CONC_HOSTARRAY][61];
    long    lSegConsumido   [NREG_CONC_HOSTARRAY];
    long    lSeqCuotas      [NREG_CONC_HOSTARRAY];
    int     iNumCuotas      [NREG_CONC_HOSTARRAY];
    int     iOrdCuota       [NREG_CONC_HOSTARRAY];
    long    lNumUnidades    [NREG_CONC_HOSTARRAY];
    char    szNumSerieMec   [NREG_CONC_HOSTARRAY][26];
    char    szNumSerieLe    [NREG_CONC_HOSTARRAY][26];
    float   fPrcImpuesto    [NREG_CONC_HOSTARRAY];
    double  dValDto         [NREG_CONC_HOSTARRAY];
    short   iTipDto         [NREG_CONC_HOSTARRAY];
    int     iMesGarantia    [NREG_CONC_HOSTARRAY];
    char    szNumGuia       [NREG_CONC_HOSTARRAY][11];
    short   iIndAlta        [NREG_CONC_HOSTARRAY];
    int     iNumPaquete     [NREG_CONC_HOSTARRAY];
    short   iFlagImpues     [NREG_CONC_HOSTARRAY];
    short   iFlagDto        [NREG_CONC_HOSTARRAY];
    int     iCodConceRel    [NREG_CONC_HOSTARRAY];
    long    lColumnaRel     [NREG_CONC_HOSTARRAY];
    char    szCodPlanTarif  [NREG_CONC_HOSTARRAY][4];
    char    szCodCargoBasico[NREG_CONC_HOSTARRAY][4];
    char    szTipPlanTarif  [NREG_CONC_HOSTARRAY][2];
    double  dhMtoReal       [NREG_CONC_HOSTARRAY];
    double  dhMtoDcto       [NREG_CONC_HOSTARRAY];
    long    lhDurReal       [NREG_CONC_HOSTARRAY];
    long    lhDurDcto       [NREG_CONC_HOSTARRAY];
    long    lhCntLlamReal   [NREG_CONC_HOSTARRAY];
    long    lhCntLlamFact   [NREG_CONC_HOSTARRAY];
    long    lhCntLlamDcto   [NREG_CONC_HOSTARRAY];
    double  dImpValunitario [NREG_CONC_HOSTARRAY];
    char    szhGlsDescrip   [NREG_CONC_HOSTARRAY][101];
    long    lhNumVenta	    [NREG_CONC_HOSTARRAY];
    long    lhNumPulsos     [NREG_CONC_HOSTARRAY];
    double  dImpFactConIva  [NREG_CONC_HOSTARRAY]; /* P-MIX-09003 77 */
    int     Indx;
 /* EXEC SQL END DECLARE SECTION; */ 


    int i;
    char szCadena  [2500] ="";
    char szNomTabla[50]   ="";
    char szFuncion [99]   ="";

    vDTrazasLog( szExeName,"\t\t* Entrada en %s NumReg=%d\n",LOG04,modulo, piNumRegs);

    if (stProceso.iCodTipDocum == stDatosGener.iCodCiclo)
    {
        sprintf(szNomTabla,"FA_FACTCONC_%ld",stCiclo.lCodCiclFact);
    }
    else
    {
        strcpy (szNomTabla,"FA_FACTCONC_NOCICLO");
    }

    strcpy (szFuncion," PrePare=>");
    strcat (szFuncion,szNomTabla) ;

    vfnInitCadenaInsertHistConc (szCadena,szNomTabla);

    /* EXEC SQL PREPARE sql_insert_histconcelu FROM :szCadena; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 60;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1137;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadena;
    sqlstm.sqhstl[0] = (unsigned long )2500;
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


    if (SQLCODE)
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,szFuncion, szfnORAerror ())     ;
        return FALSE                  ;
    }

    memset(szIndOrdenTotal ,0,sizeof(szIndOrdenTotal ));
    memset(iCodConcepto    ,0,sizeof(iCodConcepto    ));
    memset(lColumna        ,0,sizeof(lColumna        ));
    memset(szCodMoneda     ,0,sizeof(szCodMoneda     ));
    memset(iCodProducto    ,0,sizeof(iCodProducto    ));
    memset(iCodTipConce    ,0,sizeof(iCodTipConce    ));
    memset(szFecValor      ,0,sizeof(szFecValor      ));
    memset(szFecEfectividad,0,sizeof(szFecEfectividad));
    memset(dImpConcepto    ,0,sizeof(dImpConcepto    ));
    memset(szCodRegion     ,0,sizeof(szCodRegion     ));
    memset(szCodProvincia  ,0,sizeof(szCodProvincia  ));
    memset(szCodCiudad     ,0,sizeof(szCodCiudad     ));
    memset(dImpMontoBase   ,0,sizeof(dImpMontoBase   ));
    memset(iIndFactur      ,0,sizeof(iIndFactur      ));
    memset(dImpFacturable  ,0,sizeof(dImpFacturable  ));
    memset(iIndSuperTel    ,0,sizeof(iIndSuperTel    ));
    memset(lNumAbonado     ,0,sizeof(lNumAbonado     ));
    memset(iCodPortador    ,0,sizeof(iCodPortador    ));
    memset(szDesConcepto   ,0,sizeof(szDesConcepto   ));
    memset(lSegConsumido   ,0,sizeof(lSegConsumido   ));
    memset(lSeqCuotas      ,0,sizeof(lSeqCuotas      ));
    memset(iNumCuotas      ,0,sizeof(iNumCuotas      ));
    memset(iOrdCuota       ,0,sizeof(iOrdCuota       ));
    memset(lNumUnidades    ,0,sizeof(lNumUnidades    ));
    memset(szNumSerieMec   ,0,sizeof(szNumSerieMec   ));
    memset(szNumSerieLe    ,0,sizeof(szNumSerieLe    ));
    memset(fPrcImpuesto    ,0,sizeof(fPrcImpuesto    ));
    memset(dValDto         ,0,sizeof(dValDto         ));
    memset(iTipDto         ,0,sizeof(iTipDto         ));
    memset(iMesGarantia    ,0,sizeof(iMesGarantia    ));
    memset(szNumGuia       ,0,sizeof(szNumGuia       ));
    memset(iIndAlta        ,0,sizeof(iIndAlta        ));
    memset(iNumPaquete     ,0,sizeof(iNumPaquete     ));
    memset(iFlagImpues     ,0,sizeof(iFlagImpues     ));
    memset(iFlagDto        ,0,sizeof(iFlagDto        ));
    memset(iCodConceRel    ,0,sizeof(iCodConceRel    ));
    memset(lColumnaRel     ,0,sizeof(lColumnaRel     ));
    memset(szCodPlanTarif  ,0,sizeof(szCodPlanTarif  ));
    memset(szCodCargoBasico,0,sizeof(szCodCargoBasico));
    memset(szTipPlanTarif  ,0,sizeof(szTipPlanTarif  ));
    memset(dhMtoReal       ,0,sizeof(dhMtoReal       ));
    memset(dhMtoDcto       ,0,sizeof(dhMtoDcto       ));
    memset(lhDurReal       ,0,sizeof(lhDurReal       ));
    memset(lhDurDcto       ,0,sizeof(lhDurDcto       ));
    memset(lhCntLlamReal   ,0,sizeof(lhCntLlamReal   ));
    memset(lhCntLlamFact   ,0,sizeof(lhCntLlamFact   ));
    memset(lhCntLlamDcto   ,0,sizeof(lhCntLlamDcto   ));
    memset(dImpValunitario ,0,sizeof(dImpValunitario ));
    memset(szhGlsDescrip   ,0,sizeof(szhGlsDescrip   ));
    memset(lhNumVenta      ,0,sizeof(lhNumVenta      ));
    memset(lhNumPulsos     ,0,sizeof(lhNumPulsos     ));
    memset(dImpFactConIva  ,0,sizeof(dImpFactConIva  )); /* P-MIX-09003 77 */


    for(Indx=0,i=0;i<piNumRegs;i++)
    {
        if (Indx == NREG_CONC_HOSTARRAY)
        {
            vDTrazasLog ( szExeName,"\t\t* %s voy a insert(1) %d regs\n",LOG04,modulo, Indx);
            /* EXEC SQL FOR :Indx
            EXECUTE  sql_insert_histconcelu USING
            :szIndOrdenTotal ,
            :iCodConcepto    ,
            :lColumna        ,
            :szCodMoneda     ,
            :iCodProducto    ,
            :iCodTipConce    ,
            :szFecValor      ,
            :szFecEfectividad,
            :dImpConcepto    ,
            :szCodRegion     ,
            :szCodProvincia  ,
            :szCodCiudad     ,
            :dImpMontoBase   ,
            :iIndFactur      ,
            :dImpFacturable  ,
            :iIndSuperTel    ,
            :lNumAbonado     ,
            :iCodPortador    ,
            :szDesConcepto   ,
            :lSegConsumido   ,
            :lSeqCuotas      ,
            :iNumCuotas      ,
            :iOrdCuota       ,
            :lNumUnidades    ,
            :szNumSerieMec   ,
            :szNumSerieLe    ,
            :fPrcImpuesto    ,
            :dValDto         ,
            :iTipDto         ,
            :iMesGarantia    ,
            :szNumGuia       ,
            :iIndAlta        ,
            :iNumPaquete     ,
            :iFlagImpues     ,
            :iFlagDto        ,
            :iCodConceRel    ,
            :lColumnaRel     ,
            :szCodPlanTarif  ,
            :szCodCargoBasico,
            :szTipPlanTarif  ,
            :dhMtoReal       ,
            :dhMtoDcto       ,
            :lhDurReal       ,
            :lhDurDcto       ,
            :lhCntLlamReal   ,
            :lhCntLlamFact   ,
            :lhCntLlamDcto   ,
            :dImpValunitario ,
            :szhGlsDescrip   ,
            :lhNumVenta      ,            
            :lhNumPulsos     ,
            :dImpFactConIva  ; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 60;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "";
            sqlstm.iters = (unsigned int  )Indx;
            sqlstm.offset = (unsigned int  )1156;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)szIndOrdenTotal;
            sqlstm.sqhstl[0] = (unsigned long )13;
            sqlstm.sqhsts[0] = (         int  )13;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqharc[0] = (unsigned long  *)0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)iCodConcepto;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[1] = (         int  )sizeof(int);
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqharc[1] = (unsigned long  *)0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)lColumna;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[2] = (         int  )sizeof(long);
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqharc[2] = (unsigned long  *)0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)szCodMoneda;
            sqlstm.sqhstl[3] = (unsigned long )4;
            sqlstm.sqhsts[3] = (         int  )4;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqharc[3] = (unsigned long  *)0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)iCodProducto;
            sqlstm.sqhstl[4] = (unsigned long )sizeof(short);
            sqlstm.sqhsts[4] = (         int  )sizeof(short);
            sqlstm.sqindv[4] = (         short *)0;
            sqlstm.sqinds[4] = (         int  )0;
            sqlstm.sqharm[4] = (unsigned long )0;
            sqlstm.sqharc[4] = (unsigned long  *)0;
            sqlstm.sqadto[4] = (unsigned short )0;
            sqlstm.sqtdso[4] = (unsigned short )0;
            sqlstm.sqhstv[5] = (unsigned char  *)iCodTipConce;
            sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[5] = (         int  )sizeof(int);
            sqlstm.sqindv[5] = (         short *)0;
            sqlstm.sqinds[5] = (         int  )0;
            sqlstm.sqharm[5] = (unsigned long )0;
            sqlstm.sqharc[5] = (unsigned long  *)0;
            sqlstm.sqadto[5] = (unsigned short )0;
            sqlstm.sqtdso[5] = (unsigned short )0;
            sqlstm.sqhstv[6] = (unsigned char  *)szFecValor;
            sqlstm.sqhstl[6] = (unsigned long )15;
            sqlstm.sqhsts[6] = (         int  )15;
            sqlstm.sqindv[6] = (         short *)0;
            sqlstm.sqinds[6] = (         int  )0;
            sqlstm.sqharm[6] = (unsigned long )0;
            sqlstm.sqharc[6] = (unsigned long  *)0;
            sqlstm.sqadto[6] = (unsigned short )0;
            sqlstm.sqtdso[6] = (unsigned short )0;
            sqlstm.sqhstv[7] = (unsigned char  *)szFecEfectividad;
            sqlstm.sqhstl[7] = (unsigned long )15;
            sqlstm.sqhsts[7] = (         int  )15;
            sqlstm.sqindv[7] = (         short *)0;
            sqlstm.sqinds[7] = (         int  )0;
            sqlstm.sqharm[7] = (unsigned long )0;
            sqlstm.sqharc[7] = (unsigned long  *)0;
            sqlstm.sqadto[7] = (unsigned short )0;
            sqlstm.sqtdso[7] = (unsigned short )0;
            sqlstm.sqhstv[8] = (unsigned char  *)dImpConcepto;
            sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[8] = (         int  )sizeof(double);
            sqlstm.sqindv[8] = (         short *)0;
            sqlstm.sqinds[8] = (         int  )0;
            sqlstm.sqharm[8] = (unsigned long )0;
            sqlstm.sqharc[8] = (unsigned long  *)0;
            sqlstm.sqadto[8] = (unsigned short )0;
            sqlstm.sqtdso[8] = (unsigned short )0;
            sqlstm.sqhstv[9] = (unsigned char  *)szCodRegion;
            sqlstm.sqhstl[9] = (unsigned long )4;
            sqlstm.sqhsts[9] = (         int  )4;
            sqlstm.sqindv[9] = (         short *)0;
            sqlstm.sqinds[9] = (         int  )0;
            sqlstm.sqharm[9] = (unsigned long )0;
            sqlstm.sqharc[9] = (unsigned long  *)0;
            sqlstm.sqadto[9] = (unsigned short )0;
            sqlstm.sqtdso[9] = (unsigned short )0;
            sqlstm.sqhstv[10] = (unsigned char  *)szCodProvincia;
            sqlstm.sqhstl[10] = (unsigned long )6;
            sqlstm.sqhsts[10] = (         int  )6;
            sqlstm.sqindv[10] = (         short *)0;
            sqlstm.sqinds[10] = (         int  )0;
            sqlstm.sqharm[10] = (unsigned long )0;
            sqlstm.sqharc[10] = (unsigned long  *)0;
            sqlstm.sqadto[10] = (unsigned short )0;
            sqlstm.sqtdso[10] = (unsigned short )0;
            sqlstm.sqhstv[11] = (unsigned char  *)szCodCiudad;
            sqlstm.sqhstl[11] = (unsigned long )6;
            sqlstm.sqhsts[11] = (         int  )6;
            sqlstm.sqindv[11] = (         short *)0;
            sqlstm.sqinds[11] = (         int  )0;
            sqlstm.sqharm[11] = (unsigned long )0;
            sqlstm.sqharc[11] = (unsigned long  *)0;
            sqlstm.sqadto[11] = (unsigned short )0;
            sqlstm.sqtdso[11] = (unsigned short )0;
            sqlstm.sqhstv[12] = (unsigned char  *)dImpMontoBase;
            sqlstm.sqhstl[12] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[12] = (         int  )sizeof(double);
            sqlstm.sqindv[12] = (         short *)0;
            sqlstm.sqinds[12] = (         int  )0;
            sqlstm.sqharm[12] = (unsigned long )0;
            sqlstm.sqharc[12] = (unsigned long  *)0;
            sqlstm.sqadto[12] = (unsigned short )0;
            sqlstm.sqtdso[12] = (unsigned short )0;
            sqlstm.sqhstv[13] = (unsigned char  *)iIndFactur;
            sqlstm.sqhstl[13] = (unsigned long )sizeof(short);
            sqlstm.sqhsts[13] = (         int  )sizeof(short);
            sqlstm.sqindv[13] = (         short *)0;
            sqlstm.sqinds[13] = (         int  )0;
            sqlstm.sqharm[13] = (unsigned long )0;
            sqlstm.sqharc[13] = (unsigned long  *)0;
            sqlstm.sqadto[13] = (unsigned short )0;
            sqlstm.sqtdso[13] = (unsigned short )0;
            sqlstm.sqhstv[14] = (unsigned char  *)dImpFacturable;
            sqlstm.sqhstl[14] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[14] = (         int  )sizeof(double);
            sqlstm.sqindv[14] = (         short *)0;
            sqlstm.sqinds[14] = (         int  )0;
            sqlstm.sqharm[14] = (unsigned long )0;
            sqlstm.sqharc[14] = (unsigned long  *)0;
            sqlstm.sqadto[14] = (unsigned short )0;
            sqlstm.sqtdso[14] = (unsigned short )0;
            sqlstm.sqhstv[15] = (unsigned char  *)iIndSuperTel;
            sqlstm.sqhstl[15] = (unsigned long )sizeof(short);
            sqlstm.sqhsts[15] = (         int  )sizeof(short);
            sqlstm.sqindv[15] = (         short *)0;
            sqlstm.sqinds[15] = (         int  )0;
            sqlstm.sqharm[15] = (unsigned long )0;
            sqlstm.sqharc[15] = (unsigned long  *)0;
            sqlstm.sqadto[15] = (unsigned short )0;
            sqlstm.sqtdso[15] = (unsigned short )0;
            sqlstm.sqhstv[16] = (unsigned char  *)lNumAbonado;
            sqlstm.sqhstl[16] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[16] = (         int  )sizeof(long);
            sqlstm.sqindv[16] = (         short *)0;
            sqlstm.sqinds[16] = (         int  )0;
            sqlstm.sqharm[16] = (unsigned long )0;
            sqlstm.sqharc[16] = (unsigned long  *)0;
            sqlstm.sqadto[16] = (unsigned short )0;
            sqlstm.sqtdso[16] = (unsigned short )0;
            sqlstm.sqhstv[17] = (unsigned char  *)iCodPortador;
            sqlstm.sqhstl[17] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[17] = (         int  )sizeof(int);
            sqlstm.sqindv[17] = (         short *)0;
            sqlstm.sqinds[17] = (         int  )0;
            sqlstm.sqharm[17] = (unsigned long )0;
            sqlstm.sqharc[17] = (unsigned long  *)0;
            sqlstm.sqadto[17] = (unsigned short )0;
            sqlstm.sqtdso[17] = (unsigned short )0;
            sqlstm.sqhstv[18] = (unsigned char  *)szDesConcepto;
            sqlstm.sqhstl[18] = (unsigned long )61;
            sqlstm.sqhsts[18] = (         int  )61;
            sqlstm.sqindv[18] = (         short *)0;
            sqlstm.sqinds[18] = (         int  )0;
            sqlstm.sqharm[18] = (unsigned long )0;
            sqlstm.sqharc[18] = (unsigned long  *)0;
            sqlstm.sqadto[18] = (unsigned short )0;
            sqlstm.sqtdso[18] = (unsigned short )0;
            sqlstm.sqhstv[19] = (unsigned char  *)lSegConsumido;
            sqlstm.sqhstl[19] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[19] = (         int  )sizeof(long);
            sqlstm.sqindv[19] = (         short *)0;
            sqlstm.sqinds[19] = (         int  )0;
            sqlstm.sqharm[19] = (unsigned long )0;
            sqlstm.sqharc[19] = (unsigned long  *)0;
            sqlstm.sqadto[19] = (unsigned short )0;
            sqlstm.sqtdso[19] = (unsigned short )0;
            sqlstm.sqhstv[20] = (unsigned char  *)lSeqCuotas;
            sqlstm.sqhstl[20] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[20] = (         int  )sizeof(long);
            sqlstm.sqindv[20] = (         short *)0;
            sqlstm.sqinds[20] = (         int  )0;
            sqlstm.sqharm[20] = (unsigned long )0;
            sqlstm.sqharc[20] = (unsigned long  *)0;
            sqlstm.sqadto[20] = (unsigned short )0;
            sqlstm.sqtdso[20] = (unsigned short )0;
            sqlstm.sqhstv[21] = (unsigned char  *)iNumCuotas;
            sqlstm.sqhstl[21] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[21] = (         int  )sizeof(int);
            sqlstm.sqindv[21] = (         short *)0;
            sqlstm.sqinds[21] = (         int  )0;
            sqlstm.sqharm[21] = (unsigned long )0;
            sqlstm.sqharc[21] = (unsigned long  *)0;
            sqlstm.sqadto[21] = (unsigned short )0;
            sqlstm.sqtdso[21] = (unsigned short )0;
            sqlstm.sqhstv[22] = (unsigned char  *)iOrdCuota;
            sqlstm.sqhstl[22] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[22] = (         int  )sizeof(int);
            sqlstm.sqindv[22] = (         short *)0;
            sqlstm.sqinds[22] = (         int  )0;
            sqlstm.sqharm[22] = (unsigned long )0;
            sqlstm.sqharc[22] = (unsigned long  *)0;
            sqlstm.sqadto[22] = (unsigned short )0;
            sqlstm.sqtdso[22] = (unsigned short )0;
            sqlstm.sqhstv[23] = (unsigned char  *)lNumUnidades;
            sqlstm.sqhstl[23] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[23] = (         int  )sizeof(long);
            sqlstm.sqindv[23] = (         short *)0;
            sqlstm.sqinds[23] = (         int  )0;
            sqlstm.sqharm[23] = (unsigned long )0;
            sqlstm.sqharc[23] = (unsigned long  *)0;
            sqlstm.sqadto[23] = (unsigned short )0;
            sqlstm.sqtdso[23] = (unsigned short )0;
            sqlstm.sqhstv[24] = (unsigned char  *)szNumSerieMec;
            sqlstm.sqhstl[24] = (unsigned long )26;
            sqlstm.sqhsts[24] = (         int  )26;
            sqlstm.sqindv[24] = (         short *)0;
            sqlstm.sqinds[24] = (         int  )0;
            sqlstm.sqharm[24] = (unsigned long )0;
            sqlstm.sqharc[24] = (unsigned long  *)0;
            sqlstm.sqadto[24] = (unsigned short )0;
            sqlstm.sqtdso[24] = (unsigned short )0;
            sqlstm.sqhstv[25] = (unsigned char  *)szNumSerieLe;
            sqlstm.sqhstl[25] = (unsigned long )26;
            sqlstm.sqhsts[25] = (         int  )26;
            sqlstm.sqindv[25] = (         short *)0;
            sqlstm.sqinds[25] = (         int  )0;
            sqlstm.sqharm[25] = (unsigned long )0;
            sqlstm.sqharc[25] = (unsigned long  *)0;
            sqlstm.sqadto[25] = (unsigned short )0;
            sqlstm.sqtdso[25] = (unsigned short )0;
            sqlstm.sqhstv[26] = (unsigned char  *)fPrcImpuesto;
            sqlstm.sqhstl[26] = (unsigned long )sizeof(float);
            sqlstm.sqhsts[26] = (         int  )sizeof(float);
            sqlstm.sqindv[26] = (         short *)0;
            sqlstm.sqinds[26] = (         int  )0;
            sqlstm.sqharm[26] = (unsigned long )0;
            sqlstm.sqharc[26] = (unsigned long  *)0;
            sqlstm.sqadto[26] = (unsigned short )0;
            sqlstm.sqtdso[26] = (unsigned short )0;
            sqlstm.sqhstv[27] = (unsigned char  *)dValDto;
            sqlstm.sqhstl[27] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[27] = (         int  )sizeof(double);
            sqlstm.sqindv[27] = (         short *)0;
            sqlstm.sqinds[27] = (         int  )0;
            sqlstm.sqharm[27] = (unsigned long )0;
            sqlstm.sqharc[27] = (unsigned long  *)0;
            sqlstm.sqadto[27] = (unsigned short )0;
            sqlstm.sqtdso[27] = (unsigned short )0;
            sqlstm.sqhstv[28] = (unsigned char  *)iTipDto;
            sqlstm.sqhstl[28] = (unsigned long )sizeof(short);
            sqlstm.sqhsts[28] = (         int  )sizeof(short);
            sqlstm.sqindv[28] = (         short *)0;
            sqlstm.sqinds[28] = (         int  )0;
            sqlstm.sqharm[28] = (unsigned long )0;
            sqlstm.sqharc[28] = (unsigned long  *)0;
            sqlstm.sqadto[28] = (unsigned short )0;
            sqlstm.sqtdso[28] = (unsigned short )0;
            sqlstm.sqhstv[29] = (unsigned char  *)iMesGarantia;
            sqlstm.sqhstl[29] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[29] = (         int  )sizeof(int);
            sqlstm.sqindv[29] = (         short *)0;
            sqlstm.sqinds[29] = (         int  )0;
            sqlstm.sqharm[29] = (unsigned long )0;
            sqlstm.sqharc[29] = (unsigned long  *)0;
            sqlstm.sqadto[29] = (unsigned short )0;
            sqlstm.sqtdso[29] = (unsigned short )0;
            sqlstm.sqhstv[30] = (unsigned char  *)szNumGuia;
            sqlstm.sqhstl[30] = (unsigned long )11;
            sqlstm.sqhsts[30] = (         int  )11;
            sqlstm.sqindv[30] = (         short *)0;
            sqlstm.sqinds[30] = (         int  )0;
            sqlstm.sqharm[30] = (unsigned long )0;
            sqlstm.sqharc[30] = (unsigned long  *)0;
            sqlstm.sqadto[30] = (unsigned short )0;
            sqlstm.sqtdso[30] = (unsigned short )0;
            sqlstm.sqhstv[31] = (unsigned char  *)iIndAlta;
            sqlstm.sqhstl[31] = (unsigned long )sizeof(short);
            sqlstm.sqhsts[31] = (         int  )sizeof(short);
            sqlstm.sqindv[31] = (         short *)0;
            sqlstm.sqinds[31] = (         int  )0;
            sqlstm.sqharm[31] = (unsigned long )0;
            sqlstm.sqharc[31] = (unsigned long  *)0;
            sqlstm.sqadto[31] = (unsigned short )0;
            sqlstm.sqtdso[31] = (unsigned short )0;
            sqlstm.sqhstv[32] = (unsigned char  *)iNumPaquete;
            sqlstm.sqhstl[32] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[32] = (         int  )sizeof(int);
            sqlstm.sqindv[32] = (         short *)0;
            sqlstm.sqinds[32] = (         int  )0;
            sqlstm.sqharm[32] = (unsigned long )0;
            sqlstm.sqharc[32] = (unsigned long  *)0;
            sqlstm.sqadto[32] = (unsigned short )0;
            sqlstm.sqtdso[32] = (unsigned short )0;
            sqlstm.sqhstv[33] = (unsigned char  *)iFlagImpues;
            sqlstm.sqhstl[33] = (unsigned long )sizeof(short);
            sqlstm.sqhsts[33] = (         int  )sizeof(short);
            sqlstm.sqindv[33] = (         short *)0;
            sqlstm.sqinds[33] = (         int  )0;
            sqlstm.sqharm[33] = (unsigned long )0;
            sqlstm.sqharc[33] = (unsigned long  *)0;
            sqlstm.sqadto[33] = (unsigned short )0;
            sqlstm.sqtdso[33] = (unsigned short )0;
            sqlstm.sqhstv[34] = (unsigned char  *)iFlagDto;
            sqlstm.sqhstl[34] = (unsigned long )sizeof(short);
            sqlstm.sqhsts[34] = (         int  )sizeof(short);
            sqlstm.sqindv[34] = (         short *)0;
            sqlstm.sqinds[34] = (         int  )0;
            sqlstm.sqharm[34] = (unsigned long )0;
            sqlstm.sqharc[34] = (unsigned long  *)0;
            sqlstm.sqadto[34] = (unsigned short )0;
            sqlstm.sqtdso[34] = (unsigned short )0;
            sqlstm.sqhstv[35] = (unsigned char  *)iCodConceRel;
            sqlstm.sqhstl[35] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[35] = (         int  )sizeof(int);
            sqlstm.sqindv[35] = (         short *)0;
            sqlstm.sqinds[35] = (         int  )0;
            sqlstm.sqharm[35] = (unsigned long )0;
            sqlstm.sqharc[35] = (unsigned long  *)0;
            sqlstm.sqadto[35] = (unsigned short )0;
            sqlstm.sqtdso[35] = (unsigned short )0;
            sqlstm.sqhstv[36] = (unsigned char  *)lColumnaRel;
            sqlstm.sqhstl[36] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[36] = (         int  )sizeof(long);
            sqlstm.sqindv[36] = (         short *)0;
            sqlstm.sqinds[36] = (         int  )0;
            sqlstm.sqharm[36] = (unsigned long )0;
            sqlstm.sqharc[36] = (unsigned long  *)0;
            sqlstm.sqadto[36] = (unsigned short )0;
            sqlstm.sqtdso[36] = (unsigned short )0;
            sqlstm.sqhstv[37] = (unsigned char  *)szCodPlanTarif;
            sqlstm.sqhstl[37] = (unsigned long )4;
            sqlstm.sqhsts[37] = (         int  )4;
            sqlstm.sqindv[37] = (         short *)0;
            sqlstm.sqinds[37] = (         int  )0;
            sqlstm.sqharm[37] = (unsigned long )0;
            sqlstm.sqharc[37] = (unsigned long  *)0;
            sqlstm.sqadto[37] = (unsigned short )0;
            sqlstm.sqtdso[37] = (unsigned short )0;
            sqlstm.sqhstv[38] = (unsigned char  *)szCodCargoBasico;
            sqlstm.sqhstl[38] = (unsigned long )4;
            sqlstm.sqhsts[38] = (         int  )4;
            sqlstm.sqindv[38] = (         short *)0;
            sqlstm.sqinds[38] = (         int  )0;
            sqlstm.sqharm[38] = (unsigned long )0;
            sqlstm.sqharc[38] = (unsigned long  *)0;
            sqlstm.sqadto[38] = (unsigned short )0;
            sqlstm.sqtdso[38] = (unsigned short )0;
            sqlstm.sqhstv[39] = (unsigned char  *)szTipPlanTarif;
            sqlstm.sqhstl[39] = (unsigned long )2;
            sqlstm.sqhsts[39] = (         int  )2;
            sqlstm.sqindv[39] = (         short *)0;
            sqlstm.sqinds[39] = (         int  )0;
            sqlstm.sqharm[39] = (unsigned long )0;
            sqlstm.sqharc[39] = (unsigned long  *)0;
            sqlstm.sqadto[39] = (unsigned short )0;
            sqlstm.sqtdso[39] = (unsigned short )0;
            sqlstm.sqhstv[40] = (unsigned char  *)dhMtoReal;
            sqlstm.sqhstl[40] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[40] = (         int  )sizeof(double);
            sqlstm.sqindv[40] = (         short *)0;
            sqlstm.sqinds[40] = (         int  )0;
            sqlstm.sqharm[40] = (unsigned long )0;
            sqlstm.sqharc[40] = (unsigned long  *)0;
            sqlstm.sqadto[40] = (unsigned short )0;
            sqlstm.sqtdso[40] = (unsigned short )0;
            sqlstm.sqhstv[41] = (unsigned char  *)dhMtoDcto;
            sqlstm.sqhstl[41] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[41] = (         int  )sizeof(double);
            sqlstm.sqindv[41] = (         short *)0;
            sqlstm.sqinds[41] = (         int  )0;
            sqlstm.sqharm[41] = (unsigned long )0;
            sqlstm.sqharc[41] = (unsigned long  *)0;
            sqlstm.sqadto[41] = (unsigned short )0;
            sqlstm.sqtdso[41] = (unsigned short )0;
            sqlstm.sqhstv[42] = (unsigned char  *)lhDurReal;
            sqlstm.sqhstl[42] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[42] = (         int  )sizeof(long);
            sqlstm.sqindv[42] = (         short *)0;
            sqlstm.sqinds[42] = (         int  )0;
            sqlstm.sqharm[42] = (unsigned long )0;
            sqlstm.sqharc[42] = (unsigned long  *)0;
            sqlstm.sqadto[42] = (unsigned short )0;
            sqlstm.sqtdso[42] = (unsigned short )0;
            sqlstm.sqhstv[43] = (unsigned char  *)lhDurDcto;
            sqlstm.sqhstl[43] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[43] = (         int  )sizeof(long);
            sqlstm.sqindv[43] = (         short *)0;
            sqlstm.sqinds[43] = (         int  )0;
            sqlstm.sqharm[43] = (unsigned long )0;
            sqlstm.sqharc[43] = (unsigned long  *)0;
            sqlstm.sqadto[43] = (unsigned short )0;
            sqlstm.sqtdso[43] = (unsigned short )0;
            sqlstm.sqhstv[44] = (unsigned char  *)lhCntLlamReal;
            sqlstm.sqhstl[44] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[44] = (         int  )sizeof(long);
            sqlstm.sqindv[44] = (         short *)0;
            sqlstm.sqinds[44] = (         int  )0;
            sqlstm.sqharm[44] = (unsigned long )0;
            sqlstm.sqharc[44] = (unsigned long  *)0;
            sqlstm.sqadto[44] = (unsigned short )0;
            sqlstm.sqtdso[44] = (unsigned short )0;
            sqlstm.sqhstv[45] = (unsigned char  *)lhCntLlamFact;
            sqlstm.sqhstl[45] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[45] = (         int  )sizeof(long);
            sqlstm.sqindv[45] = (         short *)0;
            sqlstm.sqinds[45] = (         int  )0;
            sqlstm.sqharm[45] = (unsigned long )0;
            sqlstm.sqharc[45] = (unsigned long  *)0;
            sqlstm.sqadto[45] = (unsigned short )0;
            sqlstm.sqtdso[45] = (unsigned short )0;
            sqlstm.sqhstv[46] = (unsigned char  *)lhCntLlamDcto;
            sqlstm.sqhstl[46] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[46] = (         int  )sizeof(long);
            sqlstm.sqindv[46] = (         short *)0;
            sqlstm.sqinds[46] = (         int  )0;
            sqlstm.sqharm[46] = (unsigned long )0;
            sqlstm.sqharc[46] = (unsigned long  *)0;
            sqlstm.sqadto[46] = (unsigned short )0;
            sqlstm.sqtdso[46] = (unsigned short )0;
            sqlstm.sqhstv[47] = (unsigned char  *)dImpValunitario;
            sqlstm.sqhstl[47] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[47] = (         int  )sizeof(double);
            sqlstm.sqindv[47] = (         short *)0;
            sqlstm.sqinds[47] = (         int  )0;
            sqlstm.sqharm[47] = (unsigned long )0;
            sqlstm.sqharc[47] = (unsigned long  *)0;
            sqlstm.sqadto[47] = (unsigned short )0;
            sqlstm.sqtdso[47] = (unsigned short )0;
            sqlstm.sqhstv[48] = (unsigned char  *)szhGlsDescrip;
            sqlstm.sqhstl[48] = (unsigned long )101;
            sqlstm.sqhsts[48] = (         int  )101;
            sqlstm.sqindv[48] = (         short *)0;
            sqlstm.sqinds[48] = (         int  )0;
            sqlstm.sqharm[48] = (unsigned long )0;
            sqlstm.sqharc[48] = (unsigned long  *)0;
            sqlstm.sqadto[48] = (unsigned short )0;
            sqlstm.sqtdso[48] = (unsigned short )0;
            sqlstm.sqhstv[49] = (unsigned char  *)lhNumVenta;
            sqlstm.sqhstl[49] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[49] = (         int  )sizeof(long);
            sqlstm.sqindv[49] = (         short *)0;
            sqlstm.sqinds[49] = (         int  )0;
            sqlstm.sqharm[49] = (unsigned long )0;
            sqlstm.sqharc[49] = (unsigned long  *)0;
            sqlstm.sqadto[49] = (unsigned short )0;
            sqlstm.sqtdso[49] = (unsigned short )0;
            sqlstm.sqhstv[50] = (unsigned char  *)lhNumPulsos;
            sqlstm.sqhstl[50] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[50] = (         int  )sizeof(long);
            sqlstm.sqindv[50] = (         short *)0;
            sqlstm.sqinds[50] = (         int  )0;
            sqlstm.sqharm[50] = (unsigned long )0;
            sqlstm.sqharc[50] = (unsigned long  *)0;
            sqlstm.sqadto[50] = (unsigned short )0;
            sqlstm.sqtdso[50] = (unsigned short )0;
            sqlstm.sqhstv[51] = (unsigned char  *)dImpFactConIva;
            sqlstm.sqhstl[51] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[51] = (         int  )sizeof(double);
            sqlstm.sqindv[51] = (         short *)0;
            sqlstm.sqinds[51] = (         int  )0;
            sqlstm.sqharm[51] = (unsigned long )0;
            sqlstm.sqharc[51] = (unsigned long  *)0;
            sqlstm.sqadto[51] = (unsigned short )0;
            sqlstm.sqtdso[51] = (unsigned short )0;
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

 /* P-MIX-09003 77 */

            vDTrazasLog( szExeName,"\t\t*%s 1 Inserte en %s, %d Registros (SQLCODE=%d)\n",LOG04,modulo, szNomTabla, sqlca.sqlerrd[2],SQLCODE);
            if (SQLCODE)
            {
                sprintf(szFuncion,"HistConc(1)=>%s(%d)",szNomTabla,SQLCODE);
                iDError (szExeName,ERR000,vInsertarIncidencia,szFuncion,szfnORAerror());
                return(FALSE);
            }
            else
            {
                Indx = 0;
                memset(szIndOrdenTotal ,0,sizeof(szIndOrdenTotal ));
                memset(iCodConcepto    ,0,sizeof(iCodConcepto    ));
                memset(lColumna        ,0,sizeof(lColumna        ));
                memset(szCodMoneda     ,0,sizeof(szCodMoneda     ));
                memset(iCodProducto    ,0,sizeof(iCodProducto    ));
                memset(iCodTipConce    ,0,sizeof(iCodTipConce    ));
                memset(szFecValor      ,0,sizeof(szFecValor      ));
                memset(szFecEfectividad,0,sizeof(szFecEfectividad));
                memset(dImpConcepto    ,0,sizeof(dImpConcepto    ));
                memset(szCodRegion     ,0,sizeof(szCodRegion     ));
                memset(szCodProvincia  ,0,sizeof(szCodProvincia  ));
                memset(szCodCiudad     ,0,sizeof(szCodCiudad     ));
                memset(dImpMontoBase   ,0,sizeof(dImpMontoBase   ));
                memset(iIndFactur      ,0,sizeof(iIndFactur      ));
                memset(dImpFacturable  ,0,sizeof(dImpFacturable  ));
                memset(iIndSuperTel    ,0,sizeof(iIndSuperTel    ));
                memset(lNumAbonado     ,0,sizeof(lNumAbonado     ));
                memset(iCodPortador    ,0,sizeof(iCodPortador    ));
                memset(szDesConcepto   ,0,sizeof(szDesConcepto   ));
                memset(lSegConsumido   ,0,sizeof(lSegConsumido   ));
                memset(lSeqCuotas      ,0,sizeof(lSeqCuotas      ));
                memset(iNumCuotas      ,0,sizeof(iNumCuotas      ));
                memset(iOrdCuota       ,0,sizeof(iOrdCuota       ));
                memset(lNumUnidades    ,0,sizeof(lNumUnidades    ));
                memset(szNumSerieMec   ,0,sizeof(szNumSerieMec   ));
                memset(szNumSerieLe    ,0,sizeof(szNumSerieLe    ));
                memset(fPrcImpuesto    ,0,sizeof(fPrcImpuesto    ));
                memset(dValDto         ,0,sizeof(dValDto         ));
                memset(iTipDto         ,0,sizeof(iTipDto         ));
                memset(iMesGarantia    ,0,sizeof(iMesGarantia    ));
                memset(szNumGuia       ,0,sizeof(szNumGuia       ));
                memset(iIndAlta        ,0,sizeof(iIndAlta        ));
                memset(iNumPaquete     ,0,sizeof(iNumPaquete     ));
                memset(iFlagImpues     ,0,sizeof(iFlagImpues     ));
                memset(iFlagDto        ,0,sizeof(iFlagDto        ));
                memset(iCodConceRel    ,0,sizeof(iCodConceRel    ));
                memset(lColumnaRel     ,0,sizeof(lColumnaRel     ));
                memset(szCodPlanTarif  ,0,sizeof(szCodPlanTarif  ));
                memset(szCodCargoBasico,0,sizeof(szCodCargoBasico));
                memset(szTipPlanTarif  ,0,sizeof(szTipPlanTarif  ));
                memset(dhMtoReal       ,0,sizeof(dhMtoReal       ));
                memset(dhMtoDcto       ,0,sizeof(dhMtoDcto       ));
                memset(lhDurReal       ,0,sizeof(lhDurReal       ));
                memset(lhDurDcto       ,0,sizeof(lhDurDcto       ));
                memset(lhCntLlamReal   ,0,sizeof(lhCntLlamReal   ));
                memset(lhCntLlamFact   ,0,sizeof(lhCntLlamFact   ));
                memset(lhCntLlamDcto   ,0,sizeof(lhCntLlamDcto   ));
                memset(dImpValunitario ,0,sizeof(dImpValunitario ));
                memset(szhGlsDescrip   ,0,sizeof(szhGlsDescrip   ));
                memset(lhNumVenta      ,0,sizeof(lhNumVenta      ));
                memset(lhNumPulsos     ,0,sizeof(lhNumPulsos     ));
                memset(dImpFactConIva  ,0,sizeof(dImpFactConIva  )); /* P-MIX-09003 77 */
            }
        }

        strcpy(szIndOrdenTotal      [Indx],stDatosGener.szIndOrdenTotal                );
        iCodConcepto                [Indx]=stPreFactura.A_PFactura[i].iCodConcepto      ;
        lColumna                    [Indx]=stPreFactura.A_PFactura[i].lColumna          ;
        strcpy(szCodMoneda          [Indx],stPreFactura.A_PFactura[i].szCodMoneda      );
        iCodProducto                [Indx]=stPreFactura.A_PFactura[i].iCodProducto      ;
        iCodTipConce                [Indx]=stPreFactura.A_PFactura[i].iCodTipConce      ;
        strcpy(szFecValor           [Indx],stPreFactura.A_PFactura[i].szFecValor       );
        strcpy(szFecEfectividad     [Indx],stPreFactura.A_PFactura[i].szFecEfectividad );
        dImpConcepto                [Indx]=stPreFactura.A_PFactura[i].dImpConcepto      ;
        strcpy(szCodRegion          [Indx],stPreFactura.A_PFactura[i].szCodRegion      );
        strcpy(szCodProvincia       [Indx],stPreFactura.A_PFactura[i].szCodProvincia   );
        strcpy(szCodCiudad          [Indx],stPreFactura.A_PFactura[i].szCodCiudad      );
        dImpMontoBase               [Indx]=stPreFactura.A_PFactura[i].dImpMontoBase     ;
        iIndFactur                  [Indx]=stPreFactura.A_PFactura[i].iIndFactur        ;
        dImpFacturable              [Indx]=stPreFactura.A_PFactura[i].dImpFacturable    ; /* P-MIX-09003 */
        /*dImpFacturable              [Indx]=fnCnvDouble(stPreFactura.A_PFactura[i].dImpFacturable,USOFACT)    ;*/ /* P-MIX-09003 */            
        iIndSuperTel                [Indx]=stPreFactura.A_PFactura[i].iIndSuperTel      ;
        lNumAbonado                 [Indx]=stPreFactura.A_PFactura[i].lNumAbonado       ;
        iCodPortador                [Indx]=stPreFactura.A_PFactura[i].iCodPortador      ;
        strcpy(szDesConcepto        [Indx],stPreFactura.A_PFactura[i].szDesConcepto    );
        lSegConsumido               [Indx]=stPreFactura.A_PFactura[i].lSegConsumido     ;
        lSeqCuotas                  [Indx]=stPreFactura.A_PFactura[i].lSeqCuotas        ;
        iNumCuotas                  [Indx]=stPreFactura.A_PFactura[i].iNumCuotas        ;
        iOrdCuota                   [Indx]=stPreFactura.A_PFactura[i].iOrdCuota         ;
        lNumUnidades                [Indx]=stPreFactura.A_PFactura[i].lNumUnidades      ;
        strcpy(szNumSerieMec        [Indx],stPreFactura.A_PFactura[i].szNumSerieMec    );
        strcpy(szNumSerieLe         [Indx],stPreFactura.A_PFactura[i].szNumSerieLe     );
        fPrcImpuesto                [Indx]=stPreFactura.A_PFactura[i].fPrcImpuesto      ;
        dValDto                     [Indx]=stPreFactura.A_PFactura[i].dValDto           ;
        iTipDto                     [Indx]=stPreFactura.A_PFactura[i].iTipDto           ;
        iMesGarantia                [Indx]=stPreFactura.A_PFactura[i].iMesGarantia      ;
        strcpy(szNumGuia            [Indx],stPreFactura.A_PFactura[i].szNumGuia        );
        iIndAlta                    [Indx]=stPreFactura.A_PFactura[i].iMesGarantia      ;
        iNumPaquete                 [Indx]=stPreFactura.A_PFactura[i].iNumPaquete       ;
        iFlagImpues                 [Indx]=stPreFactura.A_PFactura[i].iFlagImpues       ;
        iFlagDto                    [Indx]=stPreFactura.A_PFactura[i].iFlagDto          ;
        iCodConceRel                [Indx]=stPreFactura.A_PFactura[i].iCodConceRel      ;
        lColumnaRel                 [Indx]=stPreFactura.A_PFactura[i].lColumnaRel       ;
        strcpy(szCodPlanTarif       [Indx],stPreFactura.A_PFactura[i].szCodPlanTarif   );
        strcpy(szCodCargoBasico     [Indx],stPreFactura.A_PFactura[i].szCodCargoBasico );
        strcpy(szTipPlanTarif       [Indx],stPreFactura.A_PFactura[i].szTipPlanTarif   );
        dhMtoReal                   [Indx]=stPreFactura.A_PFactura[i].dhMtoReal         ;
        dhMtoDcto                   [Indx]=stPreFactura.A_PFactura[i].dhMtoDcto         ;
        lhDurReal                   [Indx]=stPreFactura.A_PFactura[i].lhDurReal         ;
        lhDurDcto                   [Indx]=stPreFactura.A_PFactura[i].lhDurDcto         ;
        lhCntLlamReal               [Indx]=stPreFactura.A_PFactura[i].lhCntLlamReal     ;
        lhCntLlamFact               [Indx]=stPreFactura.A_PFactura[i].lhCntLlamFact     ;
        lhCntLlamDcto               [Indx]=stPreFactura.A_PFactura[i].lhCntLlamDcto     ;
        dImpValunitario             [Indx]=stPreFactura.A_PFactura[i].dImpValunitario   ;
        strcpy(szhGlsDescrip        [Indx],stPreFactura.A_PFactura[i].szhGlsDescrip    );
        lhNumVenta                  [Indx]=stPreFactura.A_PFactura[i].lNumVenta         ;
        lhNumPulsos                 [Indx]=stPreFactura.A_PFactura[i].lhNumPulsos       ;
        dImpFactConIva              [Indx]=stPreFactura.A_PFactura[i].dImpFactConIva    ; /* P-MIX-09003 77 */            
        /*dImpFactConIva              [Indx]=fnCnvDouble(stPreFactura.A_PFactura[i].dImpFactConIva,USOFACT);*/ /* P-MIX-09003 77 */
      
        Indx++;
    }
    if (Indx> 0)
    {
        vDTrazasLog ( szExeName,"\t\t* %s  insert(2) %d regs\n",LOG04,modulo, Indx);
        /* EXEC SQL FOR :Indx
        EXECUTE  sql_insert_histconcelu USING
        :szIndOrdenTotal ,
        :iCodConcepto    ,
        :lColumna        ,
        :szCodMoneda     ,
        :iCodProducto    ,
        :iCodTipConce    ,
        :szFecValor      ,
        :szFecEfectividad,
        :dImpConcepto    ,
        :szCodRegion     ,
        :szCodProvincia  ,
        :szCodCiudad     ,
        :dImpMontoBase   ,
        :iIndFactur      ,
        :dImpFacturable  ,
        :iIndSuperTel    ,
        :lNumAbonado     ,
        :iCodPortador    ,
        :szDesConcepto   ,
        :lSegConsumido   ,
        :lSeqCuotas      ,
        :iNumCuotas      ,
        :iOrdCuota       ,
        :lNumUnidades    ,
        :szNumSerieMec   ,
        :szNumSerieLe    ,
        :fPrcImpuesto    ,
        :dValDto         ,
        :iTipDto         ,
        :iMesGarantia    ,
        :szNumGuia       ,
        :iIndAlta        ,
        :iNumPaquete     ,
        :iFlagImpues     ,
        :iFlagDto        ,
        :iCodConceRel    ,
        :lColumnaRel     ,
        :szCodPlanTarif  ,
        :szCodCargoBasico,
        :szTipPlanTarif  ,
        :dhMtoReal       ,
        :dhMtoDcto       ,
        :lhDurReal       ,
        :lhDurDcto       ,
        :lhCntLlamReal   ,
        :lhCntLlamFact   ,
        :lhCntLlamDcto   ,
        :dImpValunitario ,
        :szhGlsDescrip	 ,
        :lhNumVenta	 ,
        :lhNumPulsos     ,
        :dImpFactConIva  ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 60;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )Indx;
        sqlstm.offset = (unsigned int  )1379;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szIndOrdenTotal;
        sqlstm.sqhstl[0] = (unsigned long )13;
        sqlstm.sqhsts[0] = (         int  )13;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqharc[0] = (unsigned long  *)0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)iCodConcepto;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )sizeof(int);
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqharc[1] = (unsigned long  *)0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)lColumna;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[2] = (         int  )sizeof(long);
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqharc[2] = (unsigned long  *)0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szCodMoneda;
        sqlstm.sqhstl[3] = (unsigned long )4;
        sqlstm.sqhsts[3] = (         int  )4;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqharc[3] = (unsigned long  *)0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)iCodProducto;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(short);
        sqlstm.sqhsts[4] = (         int  )sizeof(short);
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqharc[4] = (unsigned long  *)0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)iCodTipConce;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[5] = (         int  )sizeof(int);
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqharc[5] = (unsigned long  *)0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)szFecValor;
        sqlstm.sqhstl[6] = (unsigned long )15;
        sqlstm.sqhsts[6] = (         int  )15;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqharc[6] = (unsigned long  *)0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)szFecEfectividad;
        sqlstm.sqhstl[7] = (unsigned long )15;
        sqlstm.sqhsts[7] = (         int  )15;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqharc[7] = (unsigned long  *)0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)dImpConcepto;
        sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[8] = (         int  )sizeof(double);
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqharc[8] = (unsigned long  *)0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)szCodRegion;
        sqlstm.sqhstl[9] = (unsigned long )4;
        sqlstm.sqhsts[9] = (         int  )4;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqharc[9] = (unsigned long  *)0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)szCodProvincia;
        sqlstm.sqhstl[10] = (unsigned long )6;
        sqlstm.sqhsts[10] = (         int  )6;
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqharc[10] = (unsigned long  *)0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
        sqlstm.sqhstv[11] = (unsigned char  *)szCodCiudad;
        sqlstm.sqhstl[11] = (unsigned long )6;
        sqlstm.sqhsts[11] = (         int  )6;
        sqlstm.sqindv[11] = (         short *)0;
        sqlstm.sqinds[11] = (         int  )0;
        sqlstm.sqharm[11] = (unsigned long )0;
        sqlstm.sqharc[11] = (unsigned long  *)0;
        sqlstm.sqadto[11] = (unsigned short )0;
        sqlstm.sqtdso[11] = (unsigned short )0;
        sqlstm.sqhstv[12] = (unsigned char  *)dImpMontoBase;
        sqlstm.sqhstl[12] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[12] = (         int  )sizeof(double);
        sqlstm.sqindv[12] = (         short *)0;
        sqlstm.sqinds[12] = (         int  )0;
        sqlstm.sqharm[12] = (unsigned long )0;
        sqlstm.sqharc[12] = (unsigned long  *)0;
        sqlstm.sqadto[12] = (unsigned short )0;
        sqlstm.sqtdso[12] = (unsigned short )0;
        sqlstm.sqhstv[13] = (unsigned char  *)iIndFactur;
        sqlstm.sqhstl[13] = (unsigned long )sizeof(short);
        sqlstm.sqhsts[13] = (         int  )sizeof(short);
        sqlstm.sqindv[13] = (         short *)0;
        sqlstm.sqinds[13] = (         int  )0;
        sqlstm.sqharm[13] = (unsigned long )0;
        sqlstm.sqharc[13] = (unsigned long  *)0;
        sqlstm.sqadto[13] = (unsigned short )0;
        sqlstm.sqtdso[13] = (unsigned short )0;
        sqlstm.sqhstv[14] = (unsigned char  *)dImpFacturable;
        sqlstm.sqhstl[14] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[14] = (         int  )sizeof(double);
        sqlstm.sqindv[14] = (         short *)0;
        sqlstm.sqinds[14] = (         int  )0;
        sqlstm.sqharm[14] = (unsigned long )0;
        sqlstm.sqharc[14] = (unsigned long  *)0;
        sqlstm.sqadto[14] = (unsigned short )0;
        sqlstm.sqtdso[14] = (unsigned short )0;
        sqlstm.sqhstv[15] = (unsigned char  *)iIndSuperTel;
        sqlstm.sqhstl[15] = (unsigned long )sizeof(short);
        sqlstm.sqhsts[15] = (         int  )sizeof(short);
        sqlstm.sqindv[15] = (         short *)0;
        sqlstm.sqinds[15] = (         int  )0;
        sqlstm.sqharm[15] = (unsigned long )0;
        sqlstm.sqharc[15] = (unsigned long  *)0;
        sqlstm.sqadto[15] = (unsigned short )0;
        sqlstm.sqtdso[15] = (unsigned short )0;
        sqlstm.sqhstv[16] = (unsigned char  *)lNumAbonado;
        sqlstm.sqhstl[16] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[16] = (         int  )sizeof(long);
        sqlstm.sqindv[16] = (         short *)0;
        sqlstm.sqinds[16] = (         int  )0;
        sqlstm.sqharm[16] = (unsigned long )0;
        sqlstm.sqharc[16] = (unsigned long  *)0;
        sqlstm.sqadto[16] = (unsigned short )0;
        sqlstm.sqtdso[16] = (unsigned short )0;
        sqlstm.sqhstv[17] = (unsigned char  *)iCodPortador;
        sqlstm.sqhstl[17] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[17] = (         int  )sizeof(int);
        sqlstm.sqindv[17] = (         short *)0;
        sqlstm.sqinds[17] = (         int  )0;
        sqlstm.sqharm[17] = (unsigned long )0;
        sqlstm.sqharc[17] = (unsigned long  *)0;
        sqlstm.sqadto[17] = (unsigned short )0;
        sqlstm.sqtdso[17] = (unsigned short )0;
        sqlstm.sqhstv[18] = (unsigned char  *)szDesConcepto;
        sqlstm.sqhstl[18] = (unsigned long )61;
        sqlstm.sqhsts[18] = (         int  )61;
        sqlstm.sqindv[18] = (         short *)0;
        sqlstm.sqinds[18] = (         int  )0;
        sqlstm.sqharm[18] = (unsigned long )0;
        sqlstm.sqharc[18] = (unsigned long  *)0;
        sqlstm.sqadto[18] = (unsigned short )0;
        sqlstm.sqtdso[18] = (unsigned short )0;
        sqlstm.sqhstv[19] = (unsigned char  *)lSegConsumido;
        sqlstm.sqhstl[19] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[19] = (         int  )sizeof(long);
        sqlstm.sqindv[19] = (         short *)0;
        sqlstm.sqinds[19] = (         int  )0;
        sqlstm.sqharm[19] = (unsigned long )0;
        sqlstm.sqharc[19] = (unsigned long  *)0;
        sqlstm.sqadto[19] = (unsigned short )0;
        sqlstm.sqtdso[19] = (unsigned short )0;
        sqlstm.sqhstv[20] = (unsigned char  *)lSeqCuotas;
        sqlstm.sqhstl[20] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[20] = (         int  )sizeof(long);
        sqlstm.sqindv[20] = (         short *)0;
        sqlstm.sqinds[20] = (         int  )0;
        sqlstm.sqharm[20] = (unsigned long )0;
        sqlstm.sqharc[20] = (unsigned long  *)0;
        sqlstm.sqadto[20] = (unsigned short )0;
        sqlstm.sqtdso[20] = (unsigned short )0;
        sqlstm.sqhstv[21] = (unsigned char  *)iNumCuotas;
        sqlstm.sqhstl[21] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[21] = (         int  )sizeof(int);
        sqlstm.sqindv[21] = (         short *)0;
        sqlstm.sqinds[21] = (         int  )0;
        sqlstm.sqharm[21] = (unsigned long )0;
        sqlstm.sqharc[21] = (unsigned long  *)0;
        sqlstm.sqadto[21] = (unsigned short )0;
        sqlstm.sqtdso[21] = (unsigned short )0;
        sqlstm.sqhstv[22] = (unsigned char  *)iOrdCuota;
        sqlstm.sqhstl[22] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[22] = (         int  )sizeof(int);
        sqlstm.sqindv[22] = (         short *)0;
        sqlstm.sqinds[22] = (         int  )0;
        sqlstm.sqharm[22] = (unsigned long )0;
        sqlstm.sqharc[22] = (unsigned long  *)0;
        sqlstm.sqadto[22] = (unsigned short )0;
        sqlstm.sqtdso[22] = (unsigned short )0;
        sqlstm.sqhstv[23] = (unsigned char  *)lNumUnidades;
        sqlstm.sqhstl[23] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[23] = (         int  )sizeof(long);
        sqlstm.sqindv[23] = (         short *)0;
        sqlstm.sqinds[23] = (         int  )0;
        sqlstm.sqharm[23] = (unsigned long )0;
        sqlstm.sqharc[23] = (unsigned long  *)0;
        sqlstm.sqadto[23] = (unsigned short )0;
        sqlstm.sqtdso[23] = (unsigned short )0;
        sqlstm.sqhstv[24] = (unsigned char  *)szNumSerieMec;
        sqlstm.sqhstl[24] = (unsigned long )26;
        sqlstm.sqhsts[24] = (         int  )26;
        sqlstm.sqindv[24] = (         short *)0;
        sqlstm.sqinds[24] = (         int  )0;
        sqlstm.sqharm[24] = (unsigned long )0;
        sqlstm.sqharc[24] = (unsigned long  *)0;
        sqlstm.sqadto[24] = (unsigned short )0;
        sqlstm.sqtdso[24] = (unsigned short )0;
        sqlstm.sqhstv[25] = (unsigned char  *)szNumSerieLe;
        sqlstm.sqhstl[25] = (unsigned long )26;
        sqlstm.sqhsts[25] = (         int  )26;
        sqlstm.sqindv[25] = (         short *)0;
        sqlstm.sqinds[25] = (         int  )0;
        sqlstm.sqharm[25] = (unsigned long )0;
        sqlstm.sqharc[25] = (unsigned long  *)0;
        sqlstm.sqadto[25] = (unsigned short )0;
        sqlstm.sqtdso[25] = (unsigned short )0;
        sqlstm.sqhstv[26] = (unsigned char  *)fPrcImpuesto;
        sqlstm.sqhstl[26] = (unsigned long )sizeof(float);
        sqlstm.sqhsts[26] = (         int  )sizeof(float);
        sqlstm.sqindv[26] = (         short *)0;
        sqlstm.sqinds[26] = (         int  )0;
        sqlstm.sqharm[26] = (unsigned long )0;
        sqlstm.sqharc[26] = (unsigned long  *)0;
        sqlstm.sqadto[26] = (unsigned short )0;
        sqlstm.sqtdso[26] = (unsigned short )0;
        sqlstm.sqhstv[27] = (unsigned char  *)dValDto;
        sqlstm.sqhstl[27] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[27] = (         int  )sizeof(double);
        sqlstm.sqindv[27] = (         short *)0;
        sqlstm.sqinds[27] = (         int  )0;
        sqlstm.sqharm[27] = (unsigned long )0;
        sqlstm.sqharc[27] = (unsigned long  *)0;
        sqlstm.sqadto[27] = (unsigned short )0;
        sqlstm.sqtdso[27] = (unsigned short )0;
        sqlstm.sqhstv[28] = (unsigned char  *)iTipDto;
        sqlstm.sqhstl[28] = (unsigned long )sizeof(short);
        sqlstm.sqhsts[28] = (         int  )sizeof(short);
        sqlstm.sqindv[28] = (         short *)0;
        sqlstm.sqinds[28] = (         int  )0;
        sqlstm.sqharm[28] = (unsigned long )0;
        sqlstm.sqharc[28] = (unsigned long  *)0;
        sqlstm.sqadto[28] = (unsigned short )0;
        sqlstm.sqtdso[28] = (unsigned short )0;
        sqlstm.sqhstv[29] = (unsigned char  *)iMesGarantia;
        sqlstm.sqhstl[29] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[29] = (         int  )sizeof(int);
        sqlstm.sqindv[29] = (         short *)0;
        sqlstm.sqinds[29] = (         int  )0;
        sqlstm.sqharm[29] = (unsigned long )0;
        sqlstm.sqharc[29] = (unsigned long  *)0;
        sqlstm.sqadto[29] = (unsigned short )0;
        sqlstm.sqtdso[29] = (unsigned short )0;
        sqlstm.sqhstv[30] = (unsigned char  *)szNumGuia;
        sqlstm.sqhstl[30] = (unsigned long )11;
        sqlstm.sqhsts[30] = (         int  )11;
        sqlstm.sqindv[30] = (         short *)0;
        sqlstm.sqinds[30] = (         int  )0;
        sqlstm.sqharm[30] = (unsigned long )0;
        sqlstm.sqharc[30] = (unsigned long  *)0;
        sqlstm.sqadto[30] = (unsigned short )0;
        sqlstm.sqtdso[30] = (unsigned short )0;
        sqlstm.sqhstv[31] = (unsigned char  *)iIndAlta;
        sqlstm.sqhstl[31] = (unsigned long )sizeof(short);
        sqlstm.sqhsts[31] = (         int  )sizeof(short);
        sqlstm.sqindv[31] = (         short *)0;
        sqlstm.sqinds[31] = (         int  )0;
        sqlstm.sqharm[31] = (unsigned long )0;
        sqlstm.sqharc[31] = (unsigned long  *)0;
        sqlstm.sqadto[31] = (unsigned short )0;
        sqlstm.sqtdso[31] = (unsigned short )0;
        sqlstm.sqhstv[32] = (unsigned char  *)iNumPaquete;
        sqlstm.sqhstl[32] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[32] = (         int  )sizeof(int);
        sqlstm.sqindv[32] = (         short *)0;
        sqlstm.sqinds[32] = (         int  )0;
        sqlstm.sqharm[32] = (unsigned long )0;
        sqlstm.sqharc[32] = (unsigned long  *)0;
        sqlstm.sqadto[32] = (unsigned short )0;
        sqlstm.sqtdso[32] = (unsigned short )0;
        sqlstm.sqhstv[33] = (unsigned char  *)iFlagImpues;
        sqlstm.sqhstl[33] = (unsigned long )sizeof(short);
        sqlstm.sqhsts[33] = (         int  )sizeof(short);
        sqlstm.sqindv[33] = (         short *)0;
        sqlstm.sqinds[33] = (         int  )0;
        sqlstm.sqharm[33] = (unsigned long )0;
        sqlstm.sqharc[33] = (unsigned long  *)0;
        sqlstm.sqadto[33] = (unsigned short )0;
        sqlstm.sqtdso[33] = (unsigned short )0;
        sqlstm.sqhstv[34] = (unsigned char  *)iFlagDto;
        sqlstm.sqhstl[34] = (unsigned long )sizeof(short);
        sqlstm.sqhsts[34] = (         int  )sizeof(short);
        sqlstm.sqindv[34] = (         short *)0;
        sqlstm.sqinds[34] = (         int  )0;
        sqlstm.sqharm[34] = (unsigned long )0;
        sqlstm.sqharc[34] = (unsigned long  *)0;
        sqlstm.sqadto[34] = (unsigned short )0;
        sqlstm.sqtdso[34] = (unsigned short )0;
        sqlstm.sqhstv[35] = (unsigned char  *)iCodConceRel;
        sqlstm.sqhstl[35] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[35] = (         int  )sizeof(int);
        sqlstm.sqindv[35] = (         short *)0;
        sqlstm.sqinds[35] = (         int  )0;
        sqlstm.sqharm[35] = (unsigned long )0;
        sqlstm.sqharc[35] = (unsigned long  *)0;
        sqlstm.sqadto[35] = (unsigned short )0;
        sqlstm.sqtdso[35] = (unsigned short )0;
        sqlstm.sqhstv[36] = (unsigned char  *)lColumnaRel;
        sqlstm.sqhstl[36] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[36] = (         int  )sizeof(long);
        sqlstm.sqindv[36] = (         short *)0;
        sqlstm.sqinds[36] = (         int  )0;
        sqlstm.sqharm[36] = (unsigned long )0;
        sqlstm.sqharc[36] = (unsigned long  *)0;
        sqlstm.sqadto[36] = (unsigned short )0;
        sqlstm.sqtdso[36] = (unsigned short )0;
        sqlstm.sqhstv[37] = (unsigned char  *)szCodPlanTarif;
        sqlstm.sqhstl[37] = (unsigned long )4;
        sqlstm.sqhsts[37] = (         int  )4;
        sqlstm.sqindv[37] = (         short *)0;
        sqlstm.sqinds[37] = (         int  )0;
        sqlstm.sqharm[37] = (unsigned long )0;
        sqlstm.sqharc[37] = (unsigned long  *)0;
        sqlstm.sqadto[37] = (unsigned short )0;
        sqlstm.sqtdso[37] = (unsigned short )0;
        sqlstm.sqhstv[38] = (unsigned char  *)szCodCargoBasico;
        sqlstm.sqhstl[38] = (unsigned long )4;
        sqlstm.sqhsts[38] = (         int  )4;
        sqlstm.sqindv[38] = (         short *)0;
        sqlstm.sqinds[38] = (         int  )0;
        sqlstm.sqharm[38] = (unsigned long )0;
        sqlstm.sqharc[38] = (unsigned long  *)0;
        sqlstm.sqadto[38] = (unsigned short )0;
        sqlstm.sqtdso[38] = (unsigned short )0;
        sqlstm.sqhstv[39] = (unsigned char  *)szTipPlanTarif;
        sqlstm.sqhstl[39] = (unsigned long )2;
        sqlstm.sqhsts[39] = (         int  )2;
        sqlstm.sqindv[39] = (         short *)0;
        sqlstm.sqinds[39] = (         int  )0;
        sqlstm.sqharm[39] = (unsigned long )0;
        sqlstm.sqharc[39] = (unsigned long  *)0;
        sqlstm.sqadto[39] = (unsigned short )0;
        sqlstm.sqtdso[39] = (unsigned short )0;
        sqlstm.sqhstv[40] = (unsigned char  *)dhMtoReal;
        sqlstm.sqhstl[40] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[40] = (         int  )sizeof(double);
        sqlstm.sqindv[40] = (         short *)0;
        sqlstm.sqinds[40] = (         int  )0;
        sqlstm.sqharm[40] = (unsigned long )0;
        sqlstm.sqharc[40] = (unsigned long  *)0;
        sqlstm.sqadto[40] = (unsigned short )0;
        sqlstm.sqtdso[40] = (unsigned short )0;
        sqlstm.sqhstv[41] = (unsigned char  *)dhMtoDcto;
        sqlstm.sqhstl[41] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[41] = (         int  )sizeof(double);
        sqlstm.sqindv[41] = (         short *)0;
        sqlstm.sqinds[41] = (         int  )0;
        sqlstm.sqharm[41] = (unsigned long )0;
        sqlstm.sqharc[41] = (unsigned long  *)0;
        sqlstm.sqadto[41] = (unsigned short )0;
        sqlstm.sqtdso[41] = (unsigned short )0;
        sqlstm.sqhstv[42] = (unsigned char  *)lhDurReal;
        sqlstm.sqhstl[42] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[42] = (         int  )sizeof(long);
        sqlstm.sqindv[42] = (         short *)0;
        sqlstm.sqinds[42] = (         int  )0;
        sqlstm.sqharm[42] = (unsigned long )0;
        sqlstm.sqharc[42] = (unsigned long  *)0;
        sqlstm.sqadto[42] = (unsigned short )0;
        sqlstm.sqtdso[42] = (unsigned short )0;
        sqlstm.sqhstv[43] = (unsigned char  *)lhDurDcto;
        sqlstm.sqhstl[43] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[43] = (         int  )sizeof(long);
        sqlstm.sqindv[43] = (         short *)0;
        sqlstm.sqinds[43] = (         int  )0;
        sqlstm.sqharm[43] = (unsigned long )0;
        sqlstm.sqharc[43] = (unsigned long  *)0;
        sqlstm.sqadto[43] = (unsigned short )0;
        sqlstm.sqtdso[43] = (unsigned short )0;
        sqlstm.sqhstv[44] = (unsigned char  *)lhCntLlamReal;
        sqlstm.sqhstl[44] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[44] = (         int  )sizeof(long);
        sqlstm.sqindv[44] = (         short *)0;
        sqlstm.sqinds[44] = (         int  )0;
        sqlstm.sqharm[44] = (unsigned long )0;
        sqlstm.sqharc[44] = (unsigned long  *)0;
        sqlstm.sqadto[44] = (unsigned short )0;
        sqlstm.sqtdso[44] = (unsigned short )0;
        sqlstm.sqhstv[45] = (unsigned char  *)lhCntLlamFact;
        sqlstm.sqhstl[45] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[45] = (         int  )sizeof(long);
        sqlstm.sqindv[45] = (         short *)0;
        sqlstm.sqinds[45] = (         int  )0;
        sqlstm.sqharm[45] = (unsigned long )0;
        sqlstm.sqharc[45] = (unsigned long  *)0;
        sqlstm.sqadto[45] = (unsigned short )0;
        sqlstm.sqtdso[45] = (unsigned short )0;
        sqlstm.sqhstv[46] = (unsigned char  *)lhCntLlamDcto;
        sqlstm.sqhstl[46] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[46] = (         int  )sizeof(long);
        sqlstm.sqindv[46] = (         short *)0;
        sqlstm.sqinds[46] = (         int  )0;
        sqlstm.sqharm[46] = (unsigned long )0;
        sqlstm.sqharc[46] = (unsigned long  *)0;
        sqlstm.sqadto[46] = (unsigned short )0;
        sqlstm.sqtdso[46] = (unsigned short )0;
        sqlstm.sqhstv[47] = (unsigned char  *)dImpValunitario;
        sqlstm.sqhstl[47] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[47] = (         int  )sizeof(double);
        sqlstm.sqindv[47] = (         short *)0;
        sqlstm.sqinds[47] = (         int  )0;
        sqlstm.sqharm[47] = (unsigned long )0;
        sqlstm.sqharc[47] = (unsigned long  *)0;
        sqlstm.sqadto[47] = (unsigned short )0;
        sqlstm.sqtdso[47] = (unsigned short )0;
        sqlstm.sqhstv[48] = (unsigned char  *)szhGlsDescrip;
        sqlstm.sqhstl[48] = (unsigned long )101;
        sqlstm.sqhsts[48] = (         int  )101;
        sqlstm.sqindv[48] = (         short *)0;
        sqlstm.sqinds[48] = (         int  )0;
        sqlstm.sqharm[48] = (unsigned long )0;
        sqlstm.sqharc[48] = (unsigned long  *)0;
        sqlstm.sqadto[48] = (unsigned short )0;
        sqlstm.sqtdso[48] = (unsigned short )0;
        sqlstm.sqhstv[49] = (unsigned char  *)lhNumVenta;
        sqlstm.sqhstl[49] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[49] = (         int  )sizeof(long);
        sqlstm.sqindv[49] = (         short *)0;
        sqlstm.sqinds[49] = (         int  )0;
        sqlstm.sqharm[49] = (unsigned long )0;
        sqlstm.sqharc[49] = (unsigned long  *)0;
        sqlstm.sqadto[49] = (unsigned short )0;
        sqlstm.sqtdso[49] = (unsigned short )0;
        sqlstm.sqhstv[50] = (unsigned char  *)lhNumPulsos;
        sqlstm.sqhstl[50] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[50] = (         int  )sizeof(long);
        sqlstm.sqindv[50] = (         short *)0;
        sqlstm.sqinds[50] = (         int  )0;
        sqlstm.sqharm[50] = (unsigned long )0;
        sqlstm.sqharc[50] = (unsigned long  *)0;
        sqlstm.sqadto[50] = (unsigned short )0;
        sqlstm.sqtdso[50] = (unsigned short )0;
        sqlstm.sqhstv[51] = (unsigned char  *)dImpFactConIva;
        sqlstm.sqhstl[51] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[51] = (         int  )sizeof(double);
        sqlstm.sqindv[51] = (         short *)0;
        sqlstm.sqinds[51] = (         int  )0;
        sqlstm.sqharm[51] = (unsigned long )0;
        sqlstm.sqharc[51] = (unsigned long  *)0;
        sqlstm.sqadto[51] = (unsigned short )0;
        sqlstm.sqtdso[51] = (unsigned short )0;
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

 /* P-MIX-09003 77 */

        vDTrazasLog( szExeName,"\t\t*%s 2 Inserte en %s, %d Registros (SQLCODE=%d)\n",LOG04,modulo, szNomTabla, sqlca.sqlerrd[2],SQLCODE);
        if (SQLCODE)
        {
            sprintf(szFuncion,"HistConc(2)=>%s(%d)",szNomTabla,SQLCODE);
            iDError (szExeName,ERR000,vInsertarIncidencia,szFuncion,szfnORAerror());
            
            return(FALSE);
        }
    }
    vDTrazasLog (szExeName,"\n\t\t*%s Conceptos Procesados [%d]==[%d] del Cliente [%ld]\n",LOG03,modulo,sqlca.sqlerrd[2],i,stCliente.lCodCliente);
    return(TRUE);

}/************************* Final bfnInsertHistConc *************************/


/*****************************************************************************/
/*                            funcion : bfnPasoHistConc                      */
/* -Funcion que inserta en Fa_HistConc%  todos los Conceptos Facturables a un*/
/*  Cliente ,sus Descuentos e Impuestos todos ellos guardados en la estruc-  */
/*  tura stPreFactura.                                                       */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bfnPasoHistConc ()
{

    vDTrazasLog(szExeName, "bfnPasoHistConc Llaves a insertar tabla de conceptos (iNumRegistros=%d)\n",
                     LOG04, stPreFactura.iNumRegistros);

    if (stPreFactura.iNumRegistros > 0)
    {
        if (!bfnInsertHistConc(stPreFactura.iNumRegistros))
        {
        	return (FALSE)	;
        }
    }

    vDTrazasLog (szExeName,"\n\t\t* Conceptos Procesados [%d] del Cliente [%ld]\n"
    			,LOG03, stPreFactura.iNumRegistros,stCliente.lCodCliente);
   return TRUE;
}/****************************** Final bInsertHistConc ***********************/


/*****************************************************************************/
/*                              funcion : vfnFreeHistAbo                     */
/*****************************************************************************/
void vfnFreeHistAbo (void)
{
  if (stHistAboCel.pAbo != (HISTABO *)NULL)
  {
      free (stHistAboCel.pAbo)            ;
      stHistAboCel.pAbo  = (HISTABO *)NULL;
  }
  stHistAboCel.iNumReg = 0;

}/***************************** vfnFreeHistAbo *******************************/


/*****************************************************************************/
/*                            funcion : bfnAddHistAboCero                    */
/*****************************************************************************/
static BOOL bfnAddHistAboCero ()
{
    int k = 0;
    int iIndiceAbon = 0;

    k = stAbonoCli.lNumAbonados;

    vDTrazasLog (szExeName,"\n\t\t* (bfnAddHistAboCero)  Valida Generacion de Abonado Cero ",LOG04);
    if (bfnCargosNivCliente(&iIndiceAbon))
    {
        vDTrazasLog (szExeName,"\t\t**(bfnAddHistAboCero)  Crea de Abonado Cero para el Cliente [%ld]",LOG04,stAbonoCli.pCicloCli [iIndiceAbon].lCodCliente);
        if ((stAbonoCli.pCicloCli = (CICLOCLI *) realloc ((CICLOCLI *)stAbonoCli.pCicloCli,sizeof(CICLOCLI)*(k+1))
             ) == (CICLOCLI *)NULL )
        {
            iDError (szExeName,ERR005,vInsertarIncidencia,"stAbonoCli.pCicloCli");
                      return (FALSE);
        }
        memset(&stAbonoCli.pCicloCli [k],0,sizeof(CICLOCLI))   ;


                stAbonoCli.pCicloCli [k].iCodProducto     = stAbonoCli.pCicloCli [iIndiceAbon].iCodProducto     ;
        strcpy( stAbonoCli.pCicloCli [k].szCodPlanTarif   , stAbonoCli.pCicloCli [iIndiceAbon].szCodPlanTarif  );
                stAbonoCli.pCicloCli [k].lCodCliente      = stAbonoCli.pCicloCli [iIndiceAbon].lCodCliente      ;
                stAbonoCli.pCicloCli [k].lNumAbonado      = 0                                         ;
                stAbonoCli.pCicloCli [k].iIndDetalle      = 0                                         ;
        strcpy( stAbonoCli.pCicloCli [k].szNomUsuario     , stAbonoCli.pCicloCli [iIndiceAbon].szNomUsuario    );
        strcpy( stAbonoCli.pCicloCli [k].szNomApellido1   , stAbonoCli.pCicloCli [iIndiceAbon].szNomApellido1  );
        strcpy( stAbonoCli.pCicloCli [k].szNomApellido2   , stAbonoCli.pCicloCli [iIndiceAbon].szNomApellido2  );
                stAbonoCli.pCicloCli [k].iCodCredMor      = stAbonoCli.pCicloCli [iIndiceAbon].iCodCredMor      ;
        strcpy( stAbonoCli.pCicloCli [k].szNumTerminal    , "0"                                                );
                stAbonoCli.pCicloCli [k].iIndFactur       = stAbonoCli.pCicloCli [iIndiceAbon].iIndFactur       ;
                stAbonoCli.pCicloCli [k].iIndSuperTel     = stAbonoCli.pCicloCli [iIndiceAbon].iIndSuperTel     ;
                stAbonoCli.pCicloCli [k].lCodGrupo        = stAbonoCli.pCicloCli [iIndiceAbon].lCodGrupo        ;
        strcpy( stAbonoCli.pCicloCli [k].szNumTeleFija    , stAbonoCli.pCicloCli [iIndiceAbon].szNumTeleFija   );
        strcpy( stAbonoCli.pCicloCli [k].szFecFinContra   , stAbonoCli.pCicloCli [iIndiceAbon].szFecFinContra  );
                stAbonoCli.pCicloCli [k].iIndCobroDetLlam = 0 ;
        stAbonoCli.lNumAbonados++;
    }
    return (TRUE);
}

/*****************************************************************************/
/*                            funcion : bfnCargosNivCliente                    */
/*****************************************************************************/
static BOOL bfnCargosNivCliente (int *ipIndiceAbon)
{
    int i                   = 0;
    int iProductoAbonCero   = 0;
    BOOL bfnCargo_A_Cliente = FALSE;
    BOOL bfnAbondoCero      = FALSE;

    vDTrazasLog (szExeName,"\t\t\t* (MVV)-(bfnCargosNivCliente)  Verifica Cargos A Nivel de Cliente"
                            "\n\t\t\t=> Cantidad de Abonados  [%d]"
                            ,LOG04
                            ,stAbonoCli.lNumAbonados);
    /************************************************************************/
    iProductoAbonCero = stAbonoCli.pCicloCli [0].iCodProducto;
    *ipIndiceAbon = 0;

    /************************************************************************/
    /*  Analiza Si Existe Abonado Cero para el Cliente                      */
    /************************************************************************/
    for(i=0;i<stAbonoCli.lNumAbonados;i++)
    {
        if (stAbonoCli.pCicloCli [i].lNumAbonado == 0 )
        {
            bfnAbondoCero = TRUE;
            *ipIndiceAbon = i;
            iProductoAbonCero = stAbonoCli.pCicloCli [i].iCodProducto;
            vDTrazasLog (szExeName, "\t\t\t* (MVV) Encuentra Abonado Cero en Posicion [%d] Producto [%d]"
                                    ,LOG04
                                    ,*ipIndiceAbon
                                    ,iProductoAbonCero);
            break;
        }
    }

    /************************************************************************/
    /*  Cliente Sin Abonado Cero y Modifica Conceptos a Abonado Cero        */
    /************************************************************************/

    for (i=0;i<stPreFactura.iNumRegistros;i++)
    {
        /************************************************************************/
        /*  Cargos a Nivel de Cliente o Abonado Cero Cambia el Producto         */
        /************************************************************************/
        if (stPreFactura.A_PFactura[i].lNumAbonado  <= 0)
        {
            stPreFactura.A_PFactura[i].lNumAbonado  = 0;
            stPreFactura.A_PFactura[i].iCodProducto = (bfnAbondoCero?stDatosGener.iProdGeneral:iProductoAbonCero);
            bfnCargo_A_Cliente = (bfnAbondoCero?FALSE:TRUE);
        }
    }
    return (bfnCargo_A_Cliente);
}

BOOL bfnCargaValUnit(void)
{
    int i;

    for (i=0;i<stPreFactura.iNumRegistros;i++)
    {
        if (stPreFactura.A_PFactura[i].iCodTipConce== ARTICULO )
        {
            stPreFactura.A_PFactura[i].dImpValunitario = stPreFactura.A_PFactura[i].dImpConcepto / ((stPreFactura.A_PFactura[i].lNumUnidades>1)?stPreFactura.A_PFactura[i].lNumUnidades:1);
        }
    }
    return (TRUE);
}

/*****************************************************************************/
/*                         funcion : bfnEsPrePago                            */
/*****************************************************************************/
static BOOL bfnEsPrePago (long lNumAbon,int *iEsPrePago)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    static long   lhNumAbon;
    static int    ihEsPrePago;
    /* EXEC SQL END DECLARE SECTION; */ 


    lhNumAbon = lNumAbon;
    /* EXEC SQL
    SELECT CAMPO
      INTO :ihEsPrePago
    FROM (
        SELECT 0 CAMPO FROM GA_ABOCEL WHERE NUM_ABONADO=:lhNumAbon
        UNION
        SELECT 1 CAMPO FROM GA_ABOAMIST WHERE NUM_ABONADO=:lhNumAbon); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 60;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select CAMPO into :b0  from (select 0 CAMPO  from GA_ABOC\
EL where NUM_ABONADO=:b1 union select 1 CAMPO  from GA_ABOAMIST where NUM_ABON\
ADO=:b1) ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1602;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihEsPrePago;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbon;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhNumAbon;
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



    if (SQLCODE != SQLOK)
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,"GA_ABOCEL/GA_ABOAMIST", szfnORAerror());
        return  (FALSE);
    }
    else
    {
       *iEsPrePago = ihEsPrePago;
       vDTrazasLog ("bfnEsPrePago","\n\t\t=> Numero Abonado [%ld] es [%d] (0 PostPago / 1 Prepago)\n", LOG05, lNumAbon, *iEsPrePago);
       return (TRUE);
    }
} /* FIN bfnEsPrePago */


/*****************************************************************************/
/*                         funcion : bfnGetCodZonaAbon                       */
/*****************************************************************************/
static BOOL bfnGetCodZonaAbon (long lNumAbon, int *iCodZonaAbon)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    static long   lhNumAbon;
    static int    ihCodZonaAbon;
    /* EXEC SQL END DECLARE SECTION; */ 


    lhNumAbon = lNumAbon;

    vDTrazasLog ("bfnGetCodZonaAbon","\n\t\t=> Abonado [%ld]\n", LOG05, lhNumAbon);

    /* EXEC SQL
    SELECT A.COD_ZONAIMPO
      INTO :ihCodZonaAbon
    FROM GE_ZONACIUDAD A, GE_DIRECCIONES B , GA_DIRECUSUAR C, GA_ABOCEL D
    WHERE D.NUM_ABONADO      = :lhNumAbon
      AND C.COD_USUARIO      = D.COD_USUARIO
      AND C.COD_TIPDIRECCION = '2'
      AND C.COD_DIRECCION    = B.COD_DIRECCION
      AND A.COD_REGION       = B.COD_REGION
      AND A.COD_PROVINCIA    = B.COD_PROVINCIA
      AND A.COD_CIUDAD       = B.COD_CIUDAD
      AND SYSDATE BETWEEN A.FEC_DESDE AND A.FEC_HASTA; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 60;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select A.COD_ZONAIMPO into :b0  from GE_ZONACIUDAD A ,GE_\
DIRECCIONES B ,GA_DIRECUSUAR C ,GA_ABOCEL D where (((((((D.NUM_ABONADO=:b1 and\
 C.COD_USUARIO=D.COD_USUARIO) and C.COD_TIPDIRECCION='2') and C.COD_DIRECCION=\
B.COD_DIRECCION) and A.COD_REGION=B.COD_REGION) and A.COD_PROVINCIA=B.COD_PROV\
INCIA) and A.COD_CIUDAD=B.COD_CIUDAD) and SYSDATE between A.FEC_DESDE and A.FE\
C_HASTA)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1629;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodZonaAbon;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbon;
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



    if (SQLCODE != SQLOK)
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,"GE_ZONACIUDAD/GE_DIRECCIONES/GA_DIRECUSUAR/GA_ABOCEL", szfnORAerror());
        return  (FALSE);
    }
    else
    {
        *iCodZonaAbon = ihCodZonaAbon;
        vDTrazasLog ("bfnGetCodZonaAbon","\n\t\t=> Zona Impositiva del Abonado [%ld] es [%d]\n", LOG05, lNumAbon, *iCodZonaAbon);
        return (TRUE);
    }
} /* FIN bfnGetCodZonaAbon */

/*****************************************************************************/
/* FUNCION : bfnFindDatosAuditoria                                           */
/*****************************************************************************/
BOOL bfnFindDatosAuditoria ( HISTDOCU *pHis, char *szCodTipologia, 
                             char *szCodAreaImputable, char *szCodAreaSolicitante)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         char szhCodTipologia       [6]; /* EXEC SQL VAR szhCodTipologia       IS STRING(6); */ 

         char szhCodAreaImputable   [6]; /* EXEC SQL VAR szhCodAreaImputable   IS STRING(6); */ 

         char szhCodAreaSolicitante [6]; /* EXEC SQL VAR szhCodAreaSolicitante IS STRING(6); */ 

         char szhPrefPlaza         [26]; /* EXEC SQL VAR szhPrefPlaza          IS STRING(26); */ 

         int  ihCodTipDocum            ;
         long lhNumFolio               ;
         long lhCodCliente             ;
    /* EXEC SQL END DECLARE SECTION; */ 

    
    memset(szhCodTipologia,0,sizeof(szhCodTipologia));
    memset(szhCodAreaImputable,0,sizeof(szhCodAreaImputable));
    memset(szhCodAreaSolicitante,0,sizeof(szhCodAreaSolicitante));
    
    memset(szhPrefPlaza,0,sizeof(szhPrefPlaza));    

    vDTrazasLog ("bfnFindDatosAuditoria", "\n\t\t*** Entrada en %s ***"
                                          "\n\t=> Pref. Plaza      [%s]"
                                          "\n\t=> Num. Folio       [%ld]"
                                          "\n\t=> Cod. Cliente     [%ld]"
                                          "\n\t=> Cod. Tip. Docum. [%d]\n"
                                        , LOG05, "bfnFindDatosAuditoria"
                                        , stNota.szPrefPlaza
                                        , stNota.lNumFolio
                                        , pHis->lCodCliente
                                        , stProceso.iCodTipDocNot);
                                        
    lhCodCliente  = pHis->lCodCliente;
    lhNumFolio    = stNota.lNumFolio;
    ihCodTipDocum = stProceso.iCodTipDocNot;
    strcpy(szhPrefPlaza,stNota.szPrefPlaza);       

    /* EXEC SQL
         SELECT NVL(A.COD_TIPOLOGIA,' '), NVL(A.COD_AREAIMPUTABLE,' '), NVL(A.COD_AREASOLICITANTE,' ')
         INTO   :szhCodTipologia, :szhCodAreaImputable, :szhCodAreaSolicitante
         FROM   FA_AJUSTES A
         WHERE  PREF_PLAZA   = :szhPrefPlaza
         AND    NUM_FOLIO    = :lhNumFolio
         AND    COD_CLIENTE  = :lhCodCliente
         AND    COD_TIPDOCUM = TO_CHAR(:ihCodTipDocum); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 60;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select NVL(A.COD_TIPOLOGIA,' ') ,NVL(A.COD_AREAIMPUTABLE,\
' ') ,NVL(A.COD_AREASOLICITANTE,' ') into :b0,:b1,:b2  from FA_AJUSTES A where\
 (((PREF_PLAZA=:b3 and NUM_FOLIO=:b4) and COD_CLIENTE=:b5) and COD_TIPDOCUM=TO\
_CHAR(:b6))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1652;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodTipologia;
    sqlstm.sqhstl[0] = (unsigned long )6;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodAreaImputable;
    sqlstm.sqhstl[1] = (unsigned long )6;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodAreaSolicitante;
    sqlstm.sqhstl[2] = (unsigned long )6;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhPrefPlaza;
    sqlstm.sqhstl[3] = (unsigned long )26;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&lhNumFolio;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&lhCodCliente;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&ihCodTipDocum;
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

    

    if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
        vDTrazasLog ("bfnFindDatosAuditoria", "\n\t\t*** Error en bfnFindDatosAuditoria"
                                          "\n\t=> Pref. Plaza      [%s]"
                                          "\n\t=> Num. Folio       [%ld]"
                                          "\n\t=> Cod. Cliente     [%ld]"
                                          "\n\t=> Cod. Tip. Docum. [%d]"
                                        , LOG01
                                        , szhPrefPlaza
                                        , lhNumFolio
                                        , lhCodCliente
                                        , ihCodTipDocum);    	
        iDError (szExeName,ERR000,vInsertarIncidencia,"", szfnORAerror());
        return  (FALSE);
    }
    else
    {
    	if (SQLCODE != SQLNOTFOUND)
    	{
            strcpy(szCodTipologia       ,szhCodTipologia);
            strcpy(szCodAreaImputable   ,szhCodAreaImputable);        
            strcpy(szCodAreaSolicitante ,szhCodAreaSolicitante);
            
            vDTrazasLog ("bfnFindDatosAuditoria", "\n\t\t=> Datos Auditoria [%s] [%s] [%s]\n"
                                                , LOG05
                                                , szCodTipologia
                                                , szCodAreaImputable
                                                , szCodAreaSolicitante);
        }
        else
        {
            vDTrazasLog ("bfnFindDatosAuditoria", "\n\t*** No hay Datos Auditoria ***\n"
                                                  "\t Pref. PLaza  =>  [%s]\n"
                                                  "\t Num. Folio   => [%ld]\n"
                                                  "\t Cod. Cliente => [%ld]\n"
                                                  "\t Tip. Docum.  =>  [%d]\n"
                                                , LOG05
                                                , stNota.szPrefPlaza
                                                , stNota.lNumFolio
                                                , pHis->lCodCliente
                                                , stProceso.iCodTipDocNot);        	
        }
        return (TRUE);
    }
}/******************************* FIN bfnFindDatosAuditoria *******************************/

/******************************************************************************************/
/** Información de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  CORE/FUENTES_UNIX/FyC/Facturacion/facturacion/src/composicion1/pc/compos.pc */
/** Identificador en PVCS                               : */
/**  SCL:A474.A-UNIX;des#2.18 */
/** Producto                                            : */
/**  SCL */
/** Revisión                                            : */
/**  des#2.18 */
/** Autor de la Revisión                                : */
/**  MWN70299 */
/** Estado de la Revisión ($TO_BE_DEFINED es Check-Out) : */
/**  CERTIFICADO */
/** Fecha de Creación de la Revisión                    : */
/**  22-NOV-2004 17:56:57 */
/** Worksets ******************************************************************************/
/** 1:                                                                      */
/**     Workset:     "$GENERIC:$GLOBAL"                                                                                                         */
/**     Description: Global workset for database                                                                                                */
/**                                                                                                                                             */
/** 2:                                                                                                                                          */
/**     Workset:     "SCL:WS/D"                                                                                                                 */
/**     Description: Workset de Desarrollo                                                                                                      */
/**                                                                                                                                             */
/** 3:                                                                                                                                          */
/**     Workset:     "SCL:WS/ADEC-TMM-OLD"                                                                                                      */
/**     Description: (10M)Proyecto  Mejoras al proceso de Interfaz con Centrales                                                                */
/**                                                                                                                                             */
/** 4:                                                                                                                                          */
/**     Workset:     "SCL:WS/ADEC-TMM"                                                                                                          */
/**     Description: Work Set WS/ADEC-TMM1.AAAA                                                                                                 */
/**                                                                                                                                             */
/** 5:                                                                                                                                          */
/**     Workset:     "SCL:WS/D-P-TMM-03075"                                                                                                     */
/**     Description: P-TMM-03075 Evolución de Factura miscelánea (Facturación en Dólares e incorporación de unidad en los conceptos)            */
/**                                                                                                                                             */
/** Historia ******************************************************************************/
/**     Initial Revision                                                                                                                        */
/******************************************************************************************/
