
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
    "./pc/GenORA.pc"
};


static unsigned int sqlctx = 862627;


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
   unsigned char  *sqhstv[4];
   unsigned long  sqhstl[4];
            int   sqhsts[4];
            short *sqindv[4];
            int   sqinds[4];
   unsigned long  sqharm[4];
   unsigned long  *sqharc[4];
   unsigned short  sqadto[4];
   unsigned short  sqtdso[4];
} sqlstm = {12,4};

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

 static const char *sq0003 = 
"select ROLE  from SESSION_ROLES            ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,0,0,27,75,0,0,4,4,0,1,0,1,5,0,0,1,10,0,0,1,10,0,0,1,10,0,0,
36,0,0,2,48,0,1,82,0,0,0,0,0,1,0,
51,0,0,3,43,0,9,126,0,0,0,0,0,1,0,
66,0,0,3,0,0,13,138,0,0,1,0,0,1,0,2,5,0,0,
85,0,0,3,0,0,15,154,0,0,0,0,0,1,0,
100,0,0,4,92,0,4,169,0,0,3,2,0,1,0,2,5,0,0,1,5,0,0,1,5,0,0,
127,0,0,5,0,0,24,215,0,0,1,1,0,1,0,1,5,0,0,
146,0,0,6,0,0,29,240,0,0,0,0,0,1,0,
161,0,0,7,0,0,31,257,0,0,0,0,0,1,0,
176,0,0,8,0,0,30,274,0,0,0,0,0,1,0,
191,0,0,9,0,0,32,291,0,0,0,0,0,1,0,
206,0,0,10,25,0,1,307,0,0,0,0,0,1,0,
221,0,0,11,0,0,24,332,0,0,1,1,0,1,0,1,5,0,0,
};


/*******************************************************************************

      Fichero:  GenORA.pc

         Descripcion: Definicion de funciones generales.

         Fecha: 05/10/1995

       Autor: Manolo Oterino

*******************************************************************************/

#include <stdio.h>
#include <stdarg.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include <signal.h>
#include <time.h>
#include <ctype.h>
#include <sys/types.h>
#include <sys/times.h>
#include <sys/time.h>
/*#include <GenTypes.h>*/
#include <coerr.h>
#include "GenORA.h"
/******************************************************************************/

#define MAXLITERAL  255

/****************inicio de las implementaciones de las funciones***************/

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



/* EXEC SQL WHENEVER SQLERROR    	CONTINUE; */ 

/* EXEC SQL WHENEVER SQLWARNING   	CONTINUE; */ 

/* EXEC SQL WHENEVER NOT FOUND     CONTINUE; */ 


/******************************************************************************/
int ifnConnectORA( char *szusr, char *szpsw )
{

 /* EXEC SQL BEGIN DECLARE SECTION; */ 


       char szhConnStr[128]; /* EXEC SQL VAR szhConnStr IS STRING(128); */ 


     /* EXEC SQL END DECLARE SECTION; */ 


   char szUser[31];
        int  i;

         /* Comprobamos si hay password*/
        strcpy( szhConnStr, szusr );

    if( szpsw[0] != (char) 0 )
      {
               for (i=0;i<strlen(szusr);i++)
                    szUser[i] = toupper(szusr[i]);
         szUser[i] = '\0';
               strcat( szhConnStr, "/" );
              strcat( szhConnStr, szpsw );
    }
       else
    {
               for (i=0;i<strlen(szusr);i++)
           {
                       if (szusr[i] == '/')
                        break;
                      szUser[i] = toupper(szusr[i]);
          }
               szUser[i] = '\0';
       }

       /* EXEC SQL 
               CONNECT :szhConnStr
     ; */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 4;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.iters = (unsigned int  )10;
       sqlstm.offset = (unsigned int  )5;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)szhConnStr;
       sqlstm.sqhstl[0] = (unsigned long )128;
       sqlstm.sqhsts[0] = (         int  )128;
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



       if( sqlca.sqlcode != 0 )
                return -1;

      /* EXEC SQL
                Alter Session Set NLS_DATE_FORMAT = 'DD/MM/YYYY'
        ; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 4;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "alter Session Set NLS_DATE_FORMAT = 'DD/MM/YYYY'";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )36;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



       if( sqlca.sqlcode != 0 )
                return -1;

      vfnActivateRole(szUser);

        return 0;
}

/*****************************************************************************/
void vfnActivateRole (char *szUser)
/*----------------------------------------------------------------------------*
Activa el ROLE TCP_IUD.
Recibe el usuario al que se le quiere activar el role.
Si el usario no lo tiene o ya lo tiene activado no hace nada.
Debe llamarse despues de realizar la conexion.
Utiliza la tabla TCP_PPR (Tcp Password Para Role).
No devuelve errores.
*-----------------------------------------------------------------------------*/
{

      /* EXEC SQL BEGIN DECLARE SECTION; */ 


         char szhCad[20]         ; /* EXEC SQL VAR szhCad                   IS STRING(20) ; */ 

         char szhStm[512]                ; /* EXEC SQL VAR szhStm                   IS STRING(255); */ 

         char *szhUser                   ; /* EXEC SQL VAR szhUser                  IS STRING(31) ; */ 

         char szhRA[512]                 ; /* EXEC SQL VAR szhRA                    IS STRING(512); */ 

         char szhGrantedRole[31] ; /* EXEC SQL VAR szhGrantedRole   IS STRING(31); */ 


  /* EXEC SQL END DECLARE SECTION; */ 


   char szPass[10] = "";
   char szRolesActivos[502];

       szhUser = szUser;

       /* Recuperamos roles activos con un cursor */
   /* EXEC SQL DECLARE C_RA CURSOR FOR
                SELECT ROLE
               FROM SESSION_ROLES; */ 


   /* EXEC SQL OPEN C_RA; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 4;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = sq0003;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )51;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqcmod = (unsigned int )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



     if (sqlca.sqlcode)
      {
               fprintf(stderr,"vfnActivateRole() Code:%s\n", szfnORAerror());
          return;
 }

       strcpy(szRolesActivos,"");

      while (1)
       {
               /* EXEC SQL FETCH C_RA
                              INTO :szhRA; */ 

{
               struct sqlexd sqlstm;
               sqlstm.sqlvsn = 12;
               sqlstm.arrsiz = 4;
               sqlstm.sqladtp = &sqladt;
               sqlstm.sqltdsp = &sqltds;
               sqlstm.iters = (unsigned int  )1;
               sqlstm.offset = (unsigned int  )66;
               sqlstm.selerr = (unsigned short)1;
               sqlstm.cud = sqlcud0;
               sqlstm.sqlest = (unsigned char  *)&sqlca;
               sqlstm.sqlety = (unsigned short)256;
               sqlstm.occurs = (unsigned int  )0;
               sqlstm.sqfoff = (         int )0;
               sqlstm.sqfmod = (unsigned int )2;
               sqlstm.sqhstv[0] = (unsigned char  *)szhRA;
               sqlstm.sqhstl[0] = (unsigned long )512;
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


           if (sqlca.sqlcode == NOT_FOUND)
                 break;

          if (sqlca.sqlcode <0)
           {
                       fprintf(stderr,"* Error FETCH C_RA %s\n",szfnORAerror());
                       strcpy(szRolesActivos,"");
                      return;
         }

               sprintf(szRolesActivos,"%s %s,",szRolesActivos,szhRA);

  }

       /* EXEC SQL CLOSE C_RA; */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 4;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )85;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (sqlca.sqlcode)
      {
               fprintf(stderr,"vfnActivateRole() Close Code:%s\n", szfnORAerror());
            return;
 }

       /* Ya tenemos los roles activos separados por coma "ROL1,ROL2,ROL3," */
 /* Si ya tiene activo el role TCP_IUD nos vamos sin mas */
      if ((char*) strstr(szRolesActivos,"TCP_IUD") != (char*) NULL)
           return;

 /* Comprobamos si tiene el role para activar */
 strcpy (szhCad,"TCP_IUD");
      /* EXEC SQL 
       SELECT GRANTED_ROLE 
      INTO :szhGrantedRole
    FROM USER_ROLE_PRIVS
    WHERE GRANTED_ROLE = :szhCad
          AND USERNAME     = :szhUser; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 4;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select GRANTED_ROLE into :b0  from USER_ROLE_PRIVS wher\
e (GRANTED_ROLE=:b1 and USERNAME=:b2)";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )100;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)szhGrantedRole;
      sqlstm.sqhstl[0] = (unsigned long )31;
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)szhCad;
      sqlstm.sqhstl[1] = (unsigned long )20;
      sqlstm.sqhsts[1] = (         int  )0;
      sqlstm.sqindv[1] = (         short *)0;
      sqlstm.sqinds[1] = (         int  )0;
      sqlstm.sqharm[1] = (unsigned long )0;
      sqlstm.sqadto[1] = (unsigned short )0;
      sqlstm.sqtdso[1] = (unsigned short )0;
      sqlstm.sqhstv[2] = (unsigned char  *)szhUser;
      sqlstm.sqhstl[2] = (unsigned long )31;
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



    if (sqlca.sqlcode == NOT_FOUND)
         return; /* No lo tiene y no hay que activarlo */

        if (sqlca.sqlcode)
      {
               fprintf(stderr,"* Error G_RO %s\n",szfnORAerror());
             return;
 }


  /* Recuperamos la password del ROLE TCP_IUD */
  /*
  EXEC SQL 
  SELECT PPR 
  INTO :szhCad
  FROM SYSTEM.TCP_PPR;
	*/

 if (sqlca.sqlcode)
      {
               fprintf(stderr,"vfnActivateRole() Code:%s\n", szfnORAerror());
          return;
 }

       /* Encendido de 6 cilindros 1-5-3-6-2-4 */
      szPass[0] = szhCad[0];
  szPass[1] = szhCad[4];
  szPass[2] = szhCad[2];
  szPass[3] = szhCad[5];
  szPass[4] = szhCad[1];
  szPass[5] = szhCad[3];
  szPass[6] = '6';
        szPass[7] = 'C';
        szPass[8] = '\0';

       sprintf(szhStm,"SET ROLE %s TCP_IUD IDENTIFIED BY %s\n",
                                        szRolesActivos,szPass); 


        /* EXEC SQL EXECUTE IMMEDIATE :szhStm; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 4;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )127;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhStm;
        sqlstm.sqhstl[0] = (unsigned long )255;
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



     /* Pasamos del error porque nos da igual */
     return;

} /* Fin vfnActivateRole() */

/******************************************************************************/
int ifnDisConnORA( void )
{
  long SQLCODE = IAPSUCC;

 /* Nos desconectamos de Oracle */
       if( ifnRollBackRelease( ) )
             return -1;

      return 0;
}

/******************************************************************************/
int ifnCommitWork( void )
{
    long SQLCODE = IAPSUCC;

 /* Hacemos un commit Work */
    /* EXEC SQL 
               COMMIT WORK
     ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )146;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    SQLCODE = sqlca.sqlcode;
}



       /* Comprobamos si hay error */
  if( SQLCODE != IAPSUCC )
                return -1;

      return 0;
}

/******************************************************************************/
int ifnRollBackWork( void )
{
  long SQLCODE = IAPSUCC;

 /*Hacemos el Rollbark */
        /* EXEC SQL 
               ROLLBACK WORK
   ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 4;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )161;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
        SQLCODE = sqlca.sqlcode;
}



       /*Comprobamos si hay error */
   if( SQLCODE != IAPSUCC )
                return -1;

      return 0;
}

/******************************************************************************/
int ifnCommitRelease( void )
{
 long SQLCODE = IAPSUCC;

 /* Hacemos un commit release */
 /* EXEC SQL 
               COMMIT WORK RELEASE
     ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )176;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
 SQLCODE = sqlca.sqlcode;
}



       /* Comprobamos si hay error */
  if( SQLCODE != IAPSUCC )
                return -1;

      return 0;
}

/******************************************************************************/
int ifnRollBackRelease( void )
{
       long SQLCODE = IAPSUCC;

 /*Hacemos el Rollbark */
        /* EXEC SQL 
               ROLLBACK WORK RELEASE
   ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 4;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )191;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
        SQLCODE = sqlca.sqlcode;
}



       /*Comprobamos si hay error */
   if( SQLCODE != IAPSUCC )
                return -1;

      return 0;
}

/******************************************************************************/
int ifnSetTransactionReadOnly( void )
{
        long SQLCODE = IAPSUCC;

 /* EXEC SQL
                SET TRANSACTION READ ONLY
       ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "set transaction READ ONLY";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )206;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
 SQLCODE = sqlca.sqlcode;
}



       /* Comprobamos si hay error */
  if( SQLCODE != IAPSUCC )
                return -1;

      return 0;
}

/******************************************************************************/
int ifnExecuteImmediate( char *szSQLStm )
{

    /* EXEC SQL BEGIN DECLARE SECTION; */ 


         char* szhSQLStm ; /* EXEC SQL VAR szhSQLStm IS STRING(1000); */ 


       /* EXEC SQL END DECLARE SECTION; */ 


   long SQLCODE = IAPSUCC;

 szhSQLStm = szSQLStm;

   /* EXEC SQL
                Execute Immediate :szhSQLStm
    ; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 4;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )221;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhSQLStm;
   sqlstm.sqhstl[0] = (unsigned long )1000;
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
   SQLCODE = sqlca.sqlcode;
}



       if( SQLCODE != IAPSUCC )
                return -1;

      return 0;
}

/******************************************************************************/
/******************************************************************************/
char *szfnORAerror(void)
{
  static char szMsg[BUFSIZ];
  int iMaxSize;
  int iOutSize;

  /* RAO220502: se producen errores al ejecutar funcion sqlglm 
  iMaxSize = sizeof(szMsg);
  sqlglm(szMsg,&iMaxSize,&iOutSize);
  szMsg[iOutSize] = '\0'           ;
  */
  strcpy (szMsg, sqlca.sqlerrm.sqlerrmc);
  return szMsg;
}

/******************************************************************************/

/* ******************************************************************************** */
/* cfnGetTime : Recupera la fecha en el formato deseado (pudiendo ser fecha y hora) */
/* ******************************************************************************** */
char *CfnGetTime(int fmto)
{
	char modulo[]="cfnGetTime";

	static time_t timer;
	static size_t nbytes;
	static char szTime[26]="";

	memset(szTime,'\0',26);
	timer = time((time_t *)0);

	switch (fmto)
	{
		case 1 :
				nbytes = strftime(szTime, 26, "[%d-%b-%Y] [%H:%M:%S]", (struct tm *)localtime(&timer));	
				break;
		case 2 :
				nbytes = strftime(szTime, 26, "%Y%m%d", (struct tm *)localtime(&timer));	
				break;
		case 3 :
				nbytes = strftime(szTime, 26, "[%H:%M:%S]", (struct tm *)localtime(&timer));	
				break;
		default :
				nbytes = strftime(szTime, 26, "%d/%m/%Y", (struct tm *)localtime(&timer));	
				break;
	}
	
	return szTime;
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

