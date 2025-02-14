
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
           char  filnam[13];
};
static const struct sqlcxp sqlfpn =
{
    12,
    "./pc/Baja.pc"
};


static unsigned int sqlctx = 214883;


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
   unsigned char  *sqhstv[52];
   unsigned long  sqhstl[52];
            int   sqhsts[52];
            short *sqindv[52];
            int   sqinds[52];
   unsigned long  sqharm[52];
   unsigned long  *sqharc[52];
   unsigned short  sqadto[52];
   unsigned short  sqtdso[52];
} sqlstm = {12,52};

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

 static const char *sq0009 = 
"N not  in (:b23,:b24)) and B.COD_TIPCONTRATO=GP.COD_TIPCONTRATO) union all s\
elect A.COD_PRODUCTO ,A.NUM_ABONADO ,A.COD_SITUACION ,:b0 ,A.COD_CENTRAL ,:b0 \
,A.NUM_BEEPER ,:b0 ,:b12 ,:b3 ,NVL(A.COD_MODVENTA,:b0) ,A.IND_PROCEQUI ,NVL(A.\
COD_CICLO,:b0) ,A.COD_PLANSERV ,NVL(A.NUM_CONTRATO,:b6) ,NVL(A.NUM_ANEXO,:b6) \
,A.COD_CUENTA ,A.COD_USO ,A.COD_PLANTARIF ,:b0 ,:b35 ,:b10 ,NVL(TRUNC(MONTHS_B\
ETWEEN(A.FEC_FINCONTRA,SYSDATE)),:b37) ,:b37 ,NVL(TRUNC(MONTHS_BETWEEN(SYSDATE\
,A.FEC_ALTA)),:b37) ,:b12 ,TO_CHAR(A.FEC_ALTA,:b11) ,:b3 ,:b15 ,G.NUM_MESES ,:\
b15 ,A.NUM_SERIE ,:b15 ,:b15 IMSI ,:b15  from GA_PERCONTRATO G ,GA_ABOBEEP A w\
here (((A.COD_CLIENTE=:b21 and A.COD_SITUACION not  in (:b23,:b24)) and A.NUM_\
BEEPER>=:b51) and A.COD_TIPCONTRATO=G.COD_TIPCONTRATO)           ";

 static const char *sq0041 = 
"select NUM_ABONADO ,NUM_CELULAR ,TIP_TERMINAL ,COD_CENTRAL ,NVL(NUM_SERIEHEX\
,:b0) ,COD_TECNOLOGIA ,NVL(NUM_SERIE,:b1) ,NVL(NUM_IMEI,:b1) ,DECODE(COD_TECNO\
LOGIA,:b3,fRecuperSIMCARD_FN(NUM_SERIE,:b4),:b1) IMSI  from GA_ABOCEL where ((\
COD_CLIENTE=:b6 and NUM_ABONADO<>:b7) and COD_SITUACION<>:b8)           ";

 static const char *sq0062 = 
"select COD_SERVSUPL ,COD_NIVEL  from GA_SERVSUPLABO where (NUM_ABONADO=:b0 a\
nd IND_ESTADO<:b1)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4138,1,0,0,
5,0,0,1,192,0,4,275,0,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,
32,0,0,2,77,0,6,310,0,0,1,1,0,1,0,2,5,0,0,
51,0,0,3,95,0,4,317,0,0,3,2,0,1,0,2,97,0,0,1,97,0,0,1,97,0,0,
78,0,0,4,54,0,4,334,0,0,1,0,0,1,0,2,3,0,0,
97,0,0,5,72,0,4,344,0,0,2,0,0,1,0,2,3,0,0,2,3,0,0,
120,0,0,6,100,0,4,355,0,0,4,3,0,1,0,1,97,0,0,1,97,0,0,2,5,0,0,1,97,0,0,
151,0,0,7,95,0,4,378,0,0,3,2,0,1,0,2,5,0,0,1,97,0,0,1,97,0,0,
178,0,0,8,100,0,4,398,0,0,4,3,0,1,0,2,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,
209,0,0,9,1789,0,9,505,0,0,52,52,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,
0,1,3,0,0,1,97,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,
0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,1,3,0,
0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,
97,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,
0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,1,5,0,0,1,5,
0,0,1,3,0,0,
432,0,0,9,0,0,13,517,0,0,35,0,0,1,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,
3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,5,0,0,
2,5,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,
0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,
0,0,
587,0,0,10,133,0,5,658,0,0,7,7,0,1,0,1,97,0,0,1,5,0,0,1,97,0,0,1,5,0,0,1,97,0,
0,1,5,0,0,1,3,0,0,
630,0,0,11,117,0,5,673,0,0,5,5,0,1,0,1,3,0,0,1,5,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
665,0,0,12,147,0,6,699,0,0,6,6,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,3,3,0,0,
3,5,0,0,
704,0,0,13,72,0,6,721,0,0,2,2,0,1,0,1,3,0,0,2,5,0,0,
727,0,0,14,51,0,4,772,0,0,1,0,0,1,0,2,3,0,0,
746,0,0,15,430,0,3,787,0,0,24,24,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,3,0,
0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,5,
0,0,1,5,0,0,1,97,0,0,1,5,0,0,1,5,0,0,1,97,0,0,1,5,0,0,1,5,0,0,1,97,0,0,1,5,0,0,
857,0,0,16,51,0,4,816,0,0,1,0,0,1,0,2,3,0,0,
876,0,0,17,446,0,3,829,0,0,25,25,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,
0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,97,0,0,1,3,
0,0,1,5,0,0,1,5,0,0,1,97,0,0,1,5,0,0,1,5,0,0,1,97,0,0,1,5,0,0,1,5,0,0,1,97,0,0,
1,5,0,0,
991,0,0,18,446,0,3,857,0,0,25,25,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,
0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,97,0,0,1,3,
0,0,1,5,0,0,1,5,0,0,1,97,0,0,1,5,0,0,1,5,0,0,1,97,0,0,1,5,0,0,1,5,0,0,1,97,0,0,
1,5,0,0,
1106,0,0,19,138,0,3,894,0,0,5,5,0,1,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
1141,0,0,20,116,0,3,933,0,0,3,3,0,1,0,1,5,0,0,1,3,0,0,1,3,0,0,
1168,0,0,21,62,0,4,977,0,0,2,1,0,1,0,2,3,0,0,1,5,0,0,
1191,0,0,22,47,0,2,1014,0,0,1,1,0,1,0,1,3,0,0,
1210,0,0,23,134,0,5,1027,0,0,7,7,0,1,0,1,97,0,0,1,5,0,0,1,97,0,0,1,5,0,0,1,97,
0,0,1,5,0,0,1,3,0,0,
1253,0,0,24,119,0,5,1043,0,0,5,5,0,1,0,1,3,0,0,1,5,0,0,1,97,0,0,1,97,0,0,1,3,0,
0,
1288,0,0,25,86,0,4,1057,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
1311,0,0,26,70,0,4,1073,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
1334,0,0,27,117,0,3,1093,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1365,0,0,28,252,0,4,1109,0,0,22,1,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,
0,2,5,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,
0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,1,3,0,0,
1468,0,0,29,51,0,4,1127,0,0,1,0,0,1,0,2,3,0,0,
1487,0,0,30,410,0,3,1139,0,0,29,29,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,3,
0,0,1,97,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,5,0,0,1,
5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
1618,0,0,31,507,0,6,1197,0,0,8,8,0,1,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,2,97,0,
0,2,5,0,0,2,3,0,0,2,3,0,0,
1665,0,0,32,498,0,6,1233,0,0,8,8,0,1,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,2,97,0,
0,2,5,0,0,2,3,0,0,2,3,0,0,
1712,0,0,33,495,0,6,1280,0,0,7,7,0,1,0,1,5,0,0,1,3,0,0,1,3,0,0,2,97,0,0,2,5,0,
0,2,3,0,0,2,3,0,0,
1755,0,0,9,0,0,15,1312,0,0,0,0,0,1,0,
1770,0,0,34,133,0,4,1329,0,0,7,6,0,1,0,2,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,97,0,
0,1,97,0,0,1,97,0,0,
1813,0,0,35,134,0,4,1345,0,0,7,6,0,1,0,2,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,97,0,
0,1,97,0,0,1,97,0,0,
1856,0,0,36,290,0,3,1391,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
1879,0,0,37,72,0,2,1420,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
1902,0,0,38,84,0,5,1453,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
1929,0,0,39,127,0,4,1494,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
1952,0,0,40,153,0,4,1513,0,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,5,0,0,
1979,0,0,41,304,0,9,1728,0,0,9,9,0,1,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,
97,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
2030,0,0,41,0,0,13,1737,0,0,9,0,0,1,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,5,0,0,
2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
2081,0,0,42,183,0,5,1762,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
2112,0,0,43,62,0,5,1793,0,0,2,2,0,1,0,1,97,0,0,1,3,0,0,
2135,0,0,44,132,0,4,1805,0,0,5,4,0,1,0,2,3,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,5,0,
0,
2170,0,0,45,51,0,4,1828,0,0,1,0,0,1,0,2,3,0,0,
2189,0,0,46,317,0,3,1869,0,0,16,16,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,
0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,97,0,0,1,5,0,0,1,97,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
1,5,0,0,1,5,0,0,
2268,0,0,47,141,0,6,1917,0,0,4,4,0,1,0,2,5,0,0,1,97,0,0,2,5,0,0,1,4,0,0,
2299,0,0,48,142,0,4,1931,0,0,3,2,0,1,0,2,97,0,0,1,3,0,0,1,3,0,0,
2326,0,0,49,147,0,4,1952,0,0,7,6,0,1,0,1,97,0,0,1,97,0,0,2,5,0,0,1,3,0,0,1,3,0,
0,1,5,0,0,1,97,0,0,
2369,0,0,50,122,0,6,1974,0,0,4,4,0,1,0,2,5,0,0,1,5,0,0,1,97,0,0,1,4,0,0,
2400,0,0,51,116,0,5,1989,0,0,5,5,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,97,0,
0,
2435,0,0,52,619,0,3,2004,0,0,6,6,0,1,0,1,5,0,0,1,97,0,0,1,5,0,0,1,97,0,0,1,3,0,
0,1,97,0,0,
2474,0,0,53,79,0,5,2061,0,0,3,3,0,1,0,1,5,0,0,1,97,0,0,1,97,0,0,
2501,0,0,41,0,0,15,2074,0,0,0,0,0,1,0,
2516,0,0,54,54,0,4,2109,0,0,1,0,0,1,0,2,3,0,0,
2535,0,0,55,98,0,6,2123,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,2,3,0,0,2,97,0,0,
2566,0,0,56,54,0,4,2168,0,0,1,0,0,1,0,2,3,0,0,
2585,0,0,57,75,0,6,2180,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,
2612,0,0,58,73,0,4,2189,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
2635,0,0,59,70,0,4,2245,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
2658,0,0,60,154,0,4,2261,0,0,6,2,0,1,0,1,97,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,
0,1,3,0,0,
2697,0,0,61,178,0,3,2301,0,0,8,8,0,1,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,1,3,0,0,1,3,0,0,
2744,0,0,62,105,0,9,2360,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
2767,0,0,62,0,0,13,2370,0,0,2,0,0,1,0,2,3,0,0,2,3,0,0,
2790,0,0,62,0,0,15,2393,0,0,0,0,0,1,0,
2805,0,0,63,141,0,4,2434,0,0,5,4,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
2840,0,0,64,120,0,4,2481,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
2863,0,0,65,74,0,4,2525,0,0,3,2,0,1,0,1,3,0,0,2,3,0,0,1,3,0,0,
};


/* ===========================================================================================================
Tipo        :  ACCION
Nombre      :  Baja.pc ("BAJA"->szfnBaja)
Descripcion :  Da de Baja todos los abonados (Celular y Beeper) del cliente dado
Recibe      :  by Val -> Cod Cliente 
Devuelve    :	"SQL"  -> Ocurrio un error de oracle ( queda registrado en el log )
				   "NORUT"-> Fue imposible determinar el rut del cliente dado
				   "NOSER"-> El equipo no se encuentra en AL_SERIES 
				   "ENOAL"-> El equipo no se encuentra en el almacen 
				   "SVTEC"-> El equipo se encuentra en servicio tecnico 
				   "ERRDT"-> Error en el formato de un dato necesario
				   "OK"   -> La accion se ejecuto correctamente
Autor       :  Roy Barrera Richards
Fecha       :  10 - Agosto - 2000 
======================================================================
Modificacion: 	Proyecto MPR_04008 - Flexibilidad de Enrutamiento - GAC
Fecha       :  06-08-2004
======================================================================
Modificado 20-11-2004 por proyecto P_MAS-04037 Mejoras Excluidor y Ejecutor - G.A.C.
               Se agregan 2 parametros a la accion :
               - Puntero de archivo log tipo Hilo. 
               - Variable de contexto para instancia de BD tipo hilo	
========================================================================================================= 
Modificado 30-12-2004 por Proyecto MAS_03043 Mejoras Cancelacion de Credito - G.A.C.

========================================================================================================= 
Modificado 28-05-2005 por Proyecto Baja de Abonado.

			- Se agrega llamada al Package CO_INDEMNIZACION_PG.CO_INDEMNIZACION_PR para realizar el calculo 
			  de indemnizacion
			- Se eliminan las funciones
				bfnTipoIndemnizacion
				bAplicarIndemEscalonada
				bfnAplicarIndemEstandar  
========================================================================================================= */

#define _COLIBGENERALES_PC_ /* Agregado por PGonzalez 20-10-2004 MAS-04037 */
#define _COLIBACCIONES_PC_  /* Agregado por PGonzalez 20-10-2004 MAS-04037 */
#include "Baja.h"
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


/* ============================================================================= */
/* funcion de da de Baja a todos los abonados de un cliente */
/* ============================================================================= */
char  *szfnBaja(FILE **ptArchLog, long lCliente, sql_context ctxCont)
{
char modulo[] = "szfnBaja";
static char szStsFin[6] = "";
int	iAux = 0, iError = 0;
long	lClienteAnterior = -999;
int	iEnAlmacen = 8;
int	iEnComodato = 6;    
int	iEnArriendo = 3;    
int	iEnServTecnico = 0;
char	szServAux[8] = "";
BOOL	bAplicarIndem = FALSE;
int	iRet = 0, iResul = 0;
char	szTipoIndem[2];
int	iDiffMeses = 0;
char	szCodActuacion[3]; 
char	szAccion[5];
char 	szCodActAbo[3];
    
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long	lhCodCliente               = 0  ;
	int	ihCodProdCelular           = 0  ;
	int	ihCodProdBeeper            = 0  ;   
	int	ihProducto                 = 0  ;
	long	lhNumAbonado               = 0  ;
	char	szhCodSituacion[4]         =""  ; /* EXEC SQL VAR szhCodSituacion IS STRING (4); */ 

	int	ihIndPlexsys               = 0  ;
	int	ihCodCentral               = 0  ;
	int	ihCodCentralPlex           = 0  ;
	long	lhNumCelularBeeper         = 0  ;
	long	lhNumCelularPlex           = 0  ;
	char	szhNumSerieHex[9]          =""  ; /* EXEC SQL VAR szhNumSerieHex IS STRING (9); */ 

	char	szhTipTerminal[2]          =""  ; /* EXEC SQL VAR szhTipTerminal IS STRING (2); */ 

	int	ihCodModventa              = 0  ;
	char	szhIndProcequi[3]          =""  ; /* EXEC SQL VAR szhIndProcequi IS STRING (3); */ 

	int	ihCodCiclo                 = 0  ;
	char	szhCodPlanserv[4]          =""  ; /* EXEC SQL VAR szhCodPlanserv IS STRING (4); */ 

	char	szhNumContrato[22]         =""  ; /* EXEC SQL VAR szhNumContrato IS STRING (22); */ 

	char	szhNumAnexo[22]            =""  ; /* EXEC SQL VAR szhNumAnexo IS STRING (22); */ 

	long	lhCodCuenta                = 0  ;
	int	ihIndDisp                  = 0  ;
	int	ihCodUso                   = 0  ;
	char	szhCodPlanTarif[4]         =""  ; /* EXEC SQL VAR szhCodPlanTarif IS STRING (4); */ 

	int	ihIndSupertel              = 0  ;
	char	szhNumTeleFija[16]         =""  ; /* EXEC SQL VAR szhNumTeleFija IS STRING (16); */ 

	char	szhAuxTeleFija[16]         =""  ; /* EXEC SQL VAR szhAuxTeleFija IS STRING (16); */ 

	char	szhActAbo[3]         	   =""  ; /* EXEC SQL VAR szhActAbo IS STRING (3); */ 

	char	szhNumMin[4]               =""  ; /* EXEC SQL VAR szhNumMin IS STRING (4); */ 

	char	szhCodTecnologia[iLENCODTECNO]    	   =""  ; 	/* EXEC SQL VAR szhCodTecnologia IS STRING (iLENCODTECNO); */ 

	char	szhNumSerie[iLENNUMSERIE]  ="" ; /* EXEC SQL VAR szhNumSerie IS STRING (iLENNUMSERIE); */ 

	char	szhNumImei[iLENNUMIMEI]    ="" ; /* EXEC SQL VAR szhNumImei IS STRING (iLENNUMIMEI); */ 

	char	szhNumImsi[iLENNUMIMSI]    ="" ; /* EXEC SQL VAR szhNumImsi IS STRING (iLENNUMIMSI); */ 


	long	lhNumSeqMov1               = 0  ;
	long	lhNumSeqMov2               = 0  ;
	char	szhTs[2]                   =""  ; /* EXEC SQL VAR szhTs IS STRING(2); */ 

	long	lhId                       = 0  ; 
	long	lhCc                       = 0  ; 
	char	szhTp[2]                   =""  ; /* EXEC SQL VAR szhTp IS STRING(2); */ 

	char	szhPro[3]                  =""  ; /* EXEC SQL VAR szhPro IS STRING(3); */ 

	char	szhVel[5]                  =""  ; /* EXEC SQL VAR szhVel IS STRING(5); */ 

	int		ihFre                      = 0  ;	
	char	szhFre[2]                  =""  ; /* EXEC SQL VAR szhFre IS STRING(2); */ 

	char	szhCob[4]                  =""  ; /* EXEC SQL VAR szhCob IS STRING(4); */ 

	char	szhNom[51]                 =""  ; /* EXEC SQL VAR szhNom IS STRING(51); */ 

	char	szhGm1[8]                  =""  ; /* EXEC SQL VAR szhGm1 IS STRING(8); */ 

	char	szhGm2[8]                  =""  ; /* EXEC SQL VAR szhGm2 IS STRING(8); */ 

	char	szhGm3[8]                  =""  ; /* EXEC SQL VAR szhGm3 IS STRING(8); */ 

	char	szhGm4[8]                  =""  ; /* EXEC SQL VAR szhGm4 IS STRING(8); */ 

	char	szhGm5[8]                  =""  ; /* EXEC SQL VAR szhGm5 IS STRING(8); */ 

	char	szhRut[iLENNUMIDENT]       =""  ; /* EXEC SQL VAR szhRut IS STRING(iLENNUMIDENT); */ 

	char	szhSta[2]                  =""  ; /* EXEC SQL VAR szhSta IS STRING(2); */ 

	char	szhMarp[21]                =""  ; /* EXEC SQL VAR szhMarp IS STRING(21); */ 

	char	szhModp[51]                =""  ; /* EXEC SQL VAR szhModp IS STRING(51); */ 

	char	szhNser[31]                =""  ; /* EXEC SQL VAR szhNser IS STRING(31); */ 

	char	szhTcue[2]                 =""  ; /* EXEC SQL VAR szhTcue IS STRING(2); */ 

	char	szhEmp[51]                 =""  ; /* EXEC SQL VAR szhEmp IS STRING(51); */ 

	int		ihCodUso2                  = 0  ;
	int		ihCodCat                   = 0  ;
	char	szhCodSubAlm[6]            =""  ; /* EXEC SQL VAR szhCodSubAlm IS STRING(6); */ 

	long	lhNumAboAux                = 0  ;
	short	shAboAux                   = 0  ;
	int		ihCodControlada            = 0  ;
	int		ihCodUsoAmistar            = 3  ;
	int		ihCodCtaSeguraCtc          = 15 ;
	char	szhComando[128]            =""  ; /* EXEC SQL VAR szhComando IS STRING(128); */ 

	char	szhAuxSeqTx[10]            =""  ; /* EXEC SQL VAR szhAuxSeqTx IS STRING(10); */ 

	char	szhAuxAbonado[10]          =""  ; /* EXEC SQL VAR szhAuxAbonado IS STRING(10); */ 

	char	szhAuxProducto[2]          =""  ; /* EXEC SQL VAR szhAuxProducto IS STRING(2); */ 

	char	szhCodCausaBajaCelular[3]  =""  ; /* EXEC SQL VAR szhCodCausaBajaCelular IS STRING(3); */ 

	char	szhCodCausaBajaBeeper[3]   =""  ; /* EXEC SQL VAR szhCodCausaBajaBeeper IS STRING(3); */ 

	int		ihCodActuacionCelular      = 51 ;
	int		ihCodActuacionBeeper       = 7  ; 
	int		ihCodEstado                = 0  ;
	int		ihRetornoPL                = 0  ;                
	char	szhRetornoPL[2]        =""  ; /* EXEC SQL VAR szhRetornoPL IS STRING(2); */ 

	int		ihCodServSupl=0;
	int		ihCodNivel = 0;						/* SIEMPRE DEBE SER 0 (cuando estoy suspendiendo) */
	char	szhServicios[256]      =""  ; /* EXEC SQL VAR szhServicios IS STRING(256); */ 

	int		ihContServSupl             = 0  ;  
	int		ihVeces                    = 0  ;
	int		iCuentaAboCelu = 0;
	int		iCuentaAboBeep = 0;   
	
	char	szhFecIndemEscal[9]		= "";	/* EXEC SQL VAR szhFecIndemEscal IS STRING(9); */ 

	char	szhFecAlta[9]			= "";	/* EXEC SQL VAR szhFecAlta IS STRING(9); */ 

	char	szhFecAlta_aux[20]			= "";	/* EXEC SQL VAR szhFecAlta IS STRING(20); */ 

	char	szhFecProrroga[9]		= "";	/* EXEC SQL VAR szhFecProrroga IS STRING(9); */ 

	int		ihDifFecSysPror         = 0;
	int		ihDifFecSysAlta         = 0;
	int		ihDifFecFinContSys      = 0;
	char	szhIndEqPrestado[2]	   = "";	/* EXEC SQL VAR szhIndEqPrestado IS STRING(2); */ 

	char	szhIndProcEqui[3]	   = "";	/* EXEC SQL VAR szhIndProcEqui IS STRING(3); */ 

	int		ihMesesDiff				   = 0;
	int		ihNumMeses				   = 0;
	int		ihCodActuacion			   = 0;
	int		ihCodCicloFact			   = 0;
	char	szhFecSysdate[20]	   = "";	/* EXEC SQL VAR szhFecSysdate IS STRING(20); */ 

	char	szhFecSysdate_aux[20]	   = "";	/* EXEC SQL VAR szhFecSysdate_aux IS STRING(20); */ 

	char	szhInteresMora[21]	   = "";	/* EXEC SQL VAR szhInteresMora IS STRING(21); */ 


	int		ihCodCicloCliente       = 0  ;
	char 	szhCodTiPlan[9];			/* EXEC SQL VAR szhCodTiPlan IS STRING (9); */ 

	char  	szhInd_SerTecnico[2];

	/* Variables Bind*/
	int   ihValor_Cero    = 0;
	int   ihValor_Uno     = 1;
	int   ihValor_Dos     = 2;
	int   ihValor_UnoNeg  =-1;
   	long  lh9000000       = 9000000;

	char  szhModulo   			[3];
	char  szhUno               [2];
	char  szhddmmyy   			[7];
	char  szhyyyymmdd 			[9];
	char  szhDDMMYYYYHH24MISS  [22];
	char  szhBA                [3];
	char  szhBAP               [4];
	char  szhBAA               [4];
	char  szhGSM               [4];
	char  szhIMSI              [5];
	char  szhBAJAPROC[4];             /* EXEC SQL VAR szhBAJAPROC IS STRING(4); */ 
     /* CH-200408232102  27-08-2004 PRM */ 
	char  szhBAJAABO[4];              /* EXEC SQL VAR szhBAJAABO IS STRING(4); */ 
      /* CH-200408232102  27-08-2004 PRM */ 
	char  szhCAUBAJA_CO[15];          /* EXEC SQL VAR szhCAUBAJA_CO IS STRING(15); */ 
  /* CH-200408232102  27-08-2004 PRM */ 
	char  szhFEC_INDEM_ESCAL  	[16];
	char  szhINTERES_MORA_BAJA [18];
	char  szhPENDIENTE         [10];
	char  szh00000000000       [12];
	char  szh00000000          [9];
	char  szh000000            [7];
	char  szh000               [4];
	char  szh90                [3];
	char  szh43                [3];
	char  szh44                [3];
	char  szhFiller            [2];
	char  szhEvaluasvtec       [13];
	int	  ihCntTemp;
	char  szhLetra_T [2];
	sql_context CXX;
	char  szh00000             [6];
	char  szhDesError[500] = ""  ; /* EXEC SQL VAR szhDesError IS STRING(500); */ 

	int	ihCodRetorno;
   int   ihNum_evento;
	int   ihCount ;
/* EXEC SQL END DECLARE SECTION; */ 

FILE *pfLog=*ptArchLog;
struct sqlca sqlca;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

	ifnTrazaHilos( modulo,&pfLog, "Ingreso modulo => [%s].", LOG03, modulo );
	ifnTrazaHilos( modulo,&pfLog, "VERSION : [%s].", LOG03, szVersion);
    
	memset( szTipoIndem, '\0', sizeof( szTipoIndem ) );
	memset( szCodActuacion, '\0', sizeof( szCodActuacion ) );
	memset( szAccion, '\0', sizeof( szAccion ) );
	memset( szhFecSysdate, '\0', sizeof( szhFecSysdate ) );
	memset( szhCodTecnologia, '\0', sizeof( szhCodTecnologia ) );
	memset( szhNumSerie, '\0', sizeof( szhNumSerie ) );
	memset( szhNumImei, '\0', sizeof( szhNumImei ) );
	memset( szhNumImsi, '\0', sizeof( szhNumImsi ) );
	memset( szhRetornoPL, '\0', sizeof( szhRetornoPL ) );
	memset( szhCodTiPlan, '\0', sizeof( szhCodTiPlan ) );
	memset( szCodActAbo, '\0', sizeof( szCodActAbo ) );
	memset( szhDesError, '\0', sizeof( szhDesError ) );

	/****************************/
	/* Variables Bind           */
	/****************************/
	strcpy(szhModulo,"CO");
	strcpy(szhUno,"1");
	strcpy(szhddmmyy   ,"ddmmyy");
	strcpy(szhyyyymmdd ,"yyyymmdd");
	strcpy(szhDDMMYYYYHH24MISS,"DD-MM-YYYY HH24:MI:SS");
	strcpy(szhFEC_INDEM_ESCAL ,"FEC_INDEM_ESCAL");
	strcpy(szhINTERES_MORA_BAJA ,"INTERES_MORA_BAJA");
	strcpy(szhPENDIENTE ,"PENDIENTE");	
	strcpy( szhBAJAPROC, BAJAENPROCESO );    /* CH-200408232102  27-08-2004 PRM */    
	strcpy( szhBAJAABO, BAJAABONADO );           /* CH-200408232102  27-08-2004 PRM */
	strcpy( szhCAUBAJA_CO, CAUSABAJA_CO );   /* CH-200408232102  27-08-2004 PRM */    	
	strcpy(szhBA  ,"BA");
	strcpy(szhBAP ,"BAP");
	strcpy(szhBAA ,"BAA");
	strcpy(szhGSM ,"GSM");
	strcpy(szhIMSI,"IMSI");
	strcpy(szh00000000000,"00000000000");
	strcpy(szh00000000,"00000000");
	strcpy(szh000000 ,"000000");
	strcpy(szh000  ,"000");
	strcpy(szh90,"90");
	strcpy(szh43,"43");
	strcpy(szh44,"44");
	strcpy(szhFiller," ");
	strcpy(szhEvaluasvtec,"EVALUASVTEC");
	strcpy(szhLetra_T,"T");
	strcpy(szh00000  ,"00000");
	
	/****************************/
		
	lhCodCliente = lCliente; /* Asigna el Cliente Original */
	iAboCeluGlobal = 0;
	iAboBeepGlobal = 0;

	/* verifica si algun abonado del cliente se encuentra en un estado temporal 
	if( ( iResul = ifnAbonadosSituacionTemporal(&pfLog, lhCodCliente, CXX ) ) < 0 )
		return "PND";
	if( iResul )	 el cliente presenta abonados en situacion temporal 
		return "PND";*/
	sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
	/* EXEC SQL
	SELECT COUNT(*)
	INTO  :ihCntTemp
	FROM  GA_ABOCEL G
	WHERE G.COD_CLIENTE = :lhCodCliente
	AND   G.COD_SITUACION IN (SELECT COD_SITUACION
								     FROM  GA_SITUABO
								     WHERE G.COD_SITUACION = COD_SITUACION 
							        AND   TIP_SITUACION = :szhLetra_T ); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 3;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(*)  into :b0  from GA_ABOCEL G where (G.COD_CLI\
ENTE=:b1 and G.COD_SITUACION in (select COD_SITUACION  from GA_SITUABO where (\
G.COD_SITUACION=COD_SITUACION and TIP_SITUACION=:b2)))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )5;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCntTemp;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
 sqlstm.sqhstv[2] = (unsigned char  *)szhLetra_T;
 sqlstm.sqhstl[2] = (unsigned long )2;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

	 /* marca estado temporal */
    
	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{   
		ifnTrazaHilos( modulo,&pfLog,  "Cliente => [%ld], Error comprobando situacion temporal =>[%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
		return "PND";
	}
	if ( ihCntTemp > 0 )	  {
		ifnTrazaHilos( modulo,&pfLog,  "Cliente => [%ld], TIENE ABONADOS CON SITUACION TEMPORAL.", LOG02, lhCodCliente );  
		return "PND";
	}

			
	/* Actualizamos  AbonadoGarantia */
	/*if( !bfnActualizaAbonadoGarantia(&pfLog, lhCodCliente, CXX ) )
		return "PND";   eliminada  MAS_03043     */
	
	strcpy( szCodActuacion, ACTUACIONBAJAPLS );
	strcpy( szAccion, ACCIONBAJA );
	strcpy( szhCodCausaBajaCelular, CAUSABAJA );	/* BAJA DE CUENTA FINAL */
	strcpy( szhCodCausaBajaBeeper, CAUSABAJA );	/* BAJA DE CUENTA FINAL */
	
	rtrim( szCodActuacion );
	rtrim( szAccion );
	rtrim( szhCodCausaBajaCelular );
	rtrim( szhCodCausaBajaBeeper );
		
	sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
	/* EXEC SQL EXECUTE
		BEGIN
			:szhFecSysdate:=TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS');
		END;
	END-EXEC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 3;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "begin :szhFecSysdate := TO_CHAR ( SYSDATE , 'DD-MM-YYYY HH24\
:MI:SS' ) ; END ;";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )32;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhFecSysdate;
 sqlstm.sqhstl[0] = (unsigned long )20;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	
	sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
	/* EXEC SQL
	SELECT VAL_PARAMETRO
	INTO   :szhInd_SerTecnico
	FROM   GED_PARAMETROS
	WHERE  NOM_PARAMETRO = :szhEvaluasvtec
	AND    COD_MODULO    = :szhModulo; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 3;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select VAL_PARAMETRO into :b0  from GED_PARAMETROS where (NO\
M_PARAMETRO=:b1 and COD_MODULO=:b2)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )51;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhInd_SerTecnico;
 sqlstm.sqhstl[0] = (unsigned long )2;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhEvaluasvtec;
 sqlstm.sqhstl[1] = (unsigned long )13;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhModulo;
 sqlstm.sqhstl[2] = (unsigned long )3;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	if( sqlca.sqlcode != SQLOK  && sqlca.sqlcode != SQLNOTFOUND)	{   
		ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) GED_PARAMETROS (1)-  %s ",LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
		return "PND";    
	}
	if (sqlca.sqlcode == SQLNOTFOUND ) { 
		ifnTrazaHilos( modulo,&pfLog, "Parametro de Servicio Tecnico Desactivado.",LOG02);  
		strcpy(szhInd_SerTecnico,"S");
	}
	ifnTrazaHilos( modulo,&pfLog, "szhInd_SerTecnico [%s].",LOG03,szhInd_SerTecnico);

	sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
	/* EXEC SQL
	SELECT COD_USOCONTROLADA
	INTO	 :ihCodControlada
	FROM	 GA_DATOSGENER; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 3;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select COD_USOCONTROLADA into :b0  from GA_DATOSGENER ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )78;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCodControlada;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	if( sqlca.sqlcode != SQLOK )	{   
		ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) GA_DATOSGENER(1) - %s ",LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
		return "PND";    
	}

	sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
	/* EXEC SQL             
	SELECT B.PROD_CELULAR   ,	B.PROD_BEEPER            
	INTO	 :ihCodProdCelular,	:ihCodProdBeeper         
	FROM	 GE_DATOSGENER B; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 3;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select B.PROD_CELULAR ,B.PROD_BEEPER into :b0,:b1  from GE_D\
ATOSGENER B ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )97;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCodProdCelular;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihCodProdBeeper;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


    
	if( sqlca.sqlcode != SQLOK )   {   
		ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) GE_DATOSGENER(2) - %s ",LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
		return "PND";    
   }

	sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
	/* EXEC SQL             
	SELECT TO_CHAR( TO_DATE( VAL_PARAMETRO, :szhddmmyy ), :szhyyyymmdd )
	INTO	 :szhFecIndemEscal
	FROM	 GED_PARAMETROS
	WHERE  NOM_PARAMETRO = :szhFEC_INDEM_ESCAL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select TO_CHAR(TO_DATE(VAL_PARAMETRO,:b0),:b1) into :b2  fro\
m GED_PARAMETROS where NOM_PARAMETRO=:b3";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )120;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhddmmyy;
 sqlstm.sqhstl[0] = (unsigned long )7;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhyyyymmdd;
 sqlstm.sqhstl[1] = (unsigned long )9;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhFecIndemEscal;
 sqlstm.sqhstl[2] = (unsigned long )9;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhFEC_INDEM_ESCAL;
 sqlstm.sqhstl[3] = (unsigned long )16;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	if( sqlca.sqlcode != SQLOK )   {   
		ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) GED_PARAMETROS (2) - %s ", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
		return "PND";    
	}
    
   /* obtenemos el ciclo de facturacion del cliente */
   if( ( ihCodCicloCliente = ifnGetCodCiclFactCliente(&pfLog, lhCodCliente, CXX ) ) <= 0 )
    	return "PND";

   /* obtenemos el codigo de ciclo de facturacion vigente */
   if( ( ihCodCicloFact = ifnGetCodCiclFact(&pfLog, ihCodCicloCliente, CXX ) ) <= 0 )
    	return "PND";
    
   /* cancelamos la garantia de pago */
   if( !bfnCancelaGarantiaPago(&pfLog, lhCodCliente, CXX ) )
    	return "PND";
    
	sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
	/* EXEC SQL
	SELECT VAL_PARAMETRO
	INTO  :szhInteresMora
	FROM  GED_PARAMETROS
	WHERE COD_MODULO  = :szhModulo
	AND   NOM_PARAMETRO = :szhINTERES_MORA_BAJA; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select VAL_PARAMETRO into :b0  from GED_PARAMETROS where (CO\
D_MODULO=:b1 and NOM_PARAMETRO=:b2)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )151;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhInteresMora;
 sqlstm.sqhstl[0] = (unsigned long )21;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhModulo;
 sqlstm.sqhstl[1] = (unsigned long )3;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhINTERES_MORA_BAJA;
 sqlstm.sqhstl[2] = (unsigned long )18;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	if( sqlca.sqlcode != SQLOK || sqlca.sqlcode == SQLNOTFOUND)   {   
		ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) GED_PARAMETROS (3) - %s ", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
		return "PND";    
   }
	
	rtrim( szhInteresMora );
	/* cobramos los intereses a los documentos vencidos del cliente */
	/* szhInteresMora = 0  No genera intereses  ; szhInteresMora != 0  genera intereses */
	if ( strcmp( szhInteresMora, "0" ))	{
		if( !bfnGenInteresesBaja(&pfLog, lhCodCliente, CXX ) )
			return "PND";
   }
   
   /* Inicio Modificacion P-COL-08022  MAC*/   
   /* EXEC SQL
   SELECT COUNT(1) 
   INTO  :ihCount
   FROM GA_ABOCEL 
   WHERE COD_CLIENTE = :lhCodCliente
   AND 	COD_SITUACION NOT IN ( :szhBAJAABO, :szhBAJAPROC ); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 4;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select count(1) into :b0  from GA_ABOCEL where (COD_CLIENT\
E=:b1 and COD_SITUACION not  in (:b2,:b3))";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )178;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihCount;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
   sqlstm.sqhstv[2] = (unsigned char  *)szhBAJAABO;
   sqlstm.sqhstl[2] = (unsigned long )4;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhBAJAPROC;
   sqlstm.sqhstl[3] = (unsigned long )4;
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
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	if( sqlca.sqlcode != SQLOK || sqlca.sqlcode == SQLNOTFOUND)   {   
		ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) GA_ABOCEL(count) - %s ", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
		return "PND";    
   }
	ifnTrazaHilos( modulo,&pfLog, "ihCount Abonados BAA-BAP[%d].",LOG03,ihCount);
   /* fin Modificacion P-COL-08022  MAC*/   
   
    
   /* selecciona el universo de todos los abonados (celulares y beepers) de todos los clientes del rut encontrado */
	sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
	/* EXEC SQL DECLARE curUniverso CURSOR FOR
	SELECT   B.COD_PRODUCTO,
			 B.NUM_ABONADO,
			 B.COD_SITUACION,
			 NVL( B.IND_PLEXSYS, :ihValor_Cero ),
			 B.COD_CENTRAL,
			 NVL( B.COD_CENTRAL_PLEX, :ihValor_Cero ),
			 B.NUM_CELULAR,
			 NVL( B.NUM_CELULAR_PLEX, :ihValor_Cero ),
			 NVL( B.NUM_SERIEHEX, :szhUno),
			 B.TIP_TERMINAL,
			 NVL( B.COD_MODVENTA, :ihValor_Cero ),
			 B.IND_PROCEQUI,
			 NVL( B.COD_CICLO, :ihValor_Cero ),
			 B.COD_PLANSERV,
			 NVL( B.NUM_CONTRATO, :szh00000 ),
			 NVL( B.NUM_ANEXO, :szh00000 ),
			 B.COD_CUENTA,
			 B.COD_USO,
			 B.COD_PLANTARIF,
			 NVL( B.IND_SUPERTEL, :ihValor_Cero ),
			 NVL( B.NUM_TELEFIJA, :szh000000 ),
			 NVL( B.IND_DISP, :ihValor_Uno ),
			 NVL( TRUNC( MONTHS_BETWEEN( B.FEC_FINCONTRA, SYSDATE ) ), -1 ),
			 NVL( TRUNC( MONTHS_BETWEEN( SYSDATE, B.FEC_PRORROGA ) ), -1 ),
			 NVL( TRUNC( MONTHS_BETWEEN( SYSDATE, B.FEC_ALTA ) ), -1 ),
			 NVL( TO_CHAR( B.FEC_PRORROGA, :szhyyyymmdd ), :szh00000000 ),
			 TO_CHAR( B.FEC_ALTA, :szhyyyymmdd ),
			 NVL( B.IND_EQPRESTADO, :szhUno ),
			 NVL( B.NUM_MIN, :szhFiller ),
			 GP.NUM_MESES,
			 B.COD_TECNOLOGIA,
			 NVL( NUM_SERIE, :szhFiller ),
			 NVL( B.NUM_IMEI, :szhFiller ),
			 DECODE( B.COD_TECNOLOGIA, :szhGSM, fRecuperSIMCARD_FN( B.NUM_SERIE, :szhIMSI), :szhFiller ) IMSI,
			 CO_fGetTipPlanCelular( COD_PLANTARIF )			
	FROM	 GA_PERCONTRATO GP, GA_ABOCEL B
	WHERE	 B.COD_CLIENTE	 = :lhCodCliente
	  AND	 B.COD_USO		!= :ihCodUsoAmistar
	/oAND	 B.COD_SITUACION NOT IN ( :szhBAA, :szhBAP )o/
	  AND 	 B.COD_SITUACION NOT IN ( :szhBAJAABO, :szhBAJAPROC )  /oCH-200408232102  Homologado por PGonzalez 22-11-2004 o/
	  AND    B.COD_TIPCONTRATO = GP.COD_TIPCONTRATO
	UNION ALL
	SELECT A.COD_PRODUCTO,
			 A.NUM_ABONADO,
			 A.COD_SITUACION,
			 :ihValor_Cero,         /o ind plexsys o/
			 A.COD_CENTRAL,
			 :ihValor_Cero,         /o cod_central_plex o/
			 A.NUM_BEEPER,     	   /o num_celular o/
			 :ihValor_Cero,         /o num_celular_plex o/
			 :szh00000000,       	/o num_seriehex o/
			 :szhUno,              	/o tip_terminal o/
			 NVL(A.COD_MODVENTA,:ihValor_Cero),
			 A.IND_PROCEQUI,
			 NVL( A.COD_CICLO, :ihValor_Cero ),
			 A.COD_PLANSERV,
			 NVL(A.NUM_CONTRATO,:szh00000),
			 NVL(A.NUM_ANEXO, :szh00000),
			 A.COD_CUENTA,
			 A.COD_USO,
			 A.COD_PLANTARIF,
			 :ihValor_Cero,          /o ind_supertelo/
			 :szh00000000000,   	    /o num_telefija o/
			 :ihValor_Uno,           /o ind_disp o/
			 NVL( TRUNC( MONTHS_BETWEEN( A.FEC_FINCONTRA, SYSDATE ) ), :ihValor_UnoNeg ),
			 :ihValor_UnoNeg,
			 NVL( TRUNC( MONTHS_BETWEEN( SYSDATE, A.FEC_ALTA ) ), :ihValor_UnoNeg ),
			 :szh00000000,
			 TO_CHAR( A.FEC_ALTA, :szhyyyymmdd ),
			 :szhUno,
			 :szhFiller,
			 G.NUM_MESES,
			 :szhFiller,
			 A.NUM_SERIE,
			 :szhFiller,
			 :szhFiller IMSI,
			 :szhFiller
	FROM   GA_PERCONTRATO G, GA_ABOBEEP A
	WHERE  A.COD_CLIENTE = :lhCodCliente
	/o AND    A.COD_SITUACION NOT IN ( :szhBAA, :szhBAP ) o/
	AND A.COD_SITUACION NOT IN ( :szhBAJAABO, :szhBAJAPROC )   /oCH-200408232102  27-08-2004 PRMo/
	AND    A.NUM_BEEPER >= :lh9000000
	AND    A.COD_TIPCONTRATO = G.COD_TIPCONTRATO; */ 

    
	if( sqlca.sqlcode != SQLOK )	{
		ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) Declare curUniverso %s ",LOG00,lCliente,sqlca.sqlerrm.sqlerrmc);  
		return "PND";
	}

	sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
	/* EXEC SQL OPEN curUniverso; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 52;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlbuft(&CXX,
   "select B.COD_PRODUCTO ,B.NUM_ABONADO ,B.COD_SITUACION ,NVL(B.IND_PLEXSYS\
,:b0) ,B.COD_CENTRAL ,NVL(B.COD_CENTRAL_PLEX,:b0) ,B.NUM_CELULAR ,NVL(B.NUM_\
CELULAR_PLEX,:b0) ,NVL(B.NUM_SERIEHEX,:b3) ,B.TIP_TERMINAL ,NVL(B.COD_MODVEN\
TA,:b0) ,B.IND_PROCEQUI ,NVL(B.COD_CICLO,:b0) ,B.COD_PLANSERV ,NVL(B.NUM_CON\
TRATO,:b6) ,NVL(B.NUM_ANEXO,:b6) ,B.COD_CUENTA ,B.COD_USO ,B.COD_PLANTARIF ,\
NVL(B.IND_SUPERTEL,:b0) ,NVL(B.NUM_TELEFIJA,:b9) ,NVL(B.IND_DISP,:b10) ,NVL(\
TRUNC(MONTHS_BETWEEN(B.FEC_FINCONTRA,SYSDATE)),(-1)) ,NVL(TRUNC(MONTHS_BETWE\
EN(SYSDATE,B.FEC_PRORROGA)),(-1)) ,NVL(TRUNC(MONTHS_BETWEEN(SYSDATE,B.FEC_AL\
TA)),(-1)) ,NVL(TO_CHAR(B.FEC_PRORROGA,:b11),:b12) ,TO_CHAR(B.FEC_ALTA,:b11)\
 ,NVL(B.IND_EQPRESTADO,:b3) ,NVL(B.NUM_MIN,:b15) ,GP.NUM_MESES ,B.COD_TECNOL\
OGIA ,NVL(NUM_SERIE,:b15) ,NVL(B.NUM_IMEI,:b15) ,DECODE(B.COD_TECNOLOGIA,:b1\
8,fRecuperSIMCARD_FN(B.NUM_SERIE,:b19),:b15) IMSI ,CO_fGetTipPlanCelular(COD\
_PLANTARIF)  from GA_PERCONTRATO GP ,GA_ABOCEL B where (((B.COD_CLIENTE=:b21\
 and B.COD_USO<>:b22) and B.COD_SITUACIO");
 sqlstm.stmt = sq0009;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )209;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_Cero;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihValor_Cero;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_Cero;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhUno;
 sqlstm.sqhstl[3] = (unsigned long )2;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&ihValor_Cero;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&ihValor_Cero;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szh00000;
 sqlstm.sqhstl[6] = (unsigned long )6;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)szh00000;
 sqlstm.sqhstl[7] = (unsigned long )6;
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)&ihValor_Cero;
 sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)szh000000;
 sqlstm.sqhstl[9] = (unsigned long )7;
 sqlstm.sqhsts[9] = (         int  )0;
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)&ihValor_Uno;
 sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[10] = (         int  )0;
 sqlstm.sqindv[10] = (         short *)0;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
 sqlstm.sqhstv[11] = (unsigned char  *)szhyyyymmdd;
 sqlstm.sqhstl[11] = (unsigned long )9;
 sqlstm.sqhsts[11] = (         int  )0;
 sqlstm.sqindv[11] = (         short *)0;
 sqlstm.sqinds[11] = (         int  )0;
 sqlstm.sqharm[11] = (unsigned long )0;
 sqlstm.sqadto[11] = (unsigned short )0;
 sqlstm.sqtdso[11] = (unsigned short )0;
 sqlstm.sqhstv[12] = (unsigned char  *)szh00000000;
 sqlstm.sqhstl[12] = (unsigned long )9;
 sqlstm.sqhsts[12] = (         int  )0;
 sqlstm.sqindv[12] = (         short *)0;
 sqlstm.sqinds[12] = (         int  )0;
 sqlstm.sqharm[12] = (unsigned long )0;
 sqlstm.sqadto[12] = (unsigned short )0;
 sqlstm.sqtdso[12] = (unsigned short )0;
 sqlstm.sqhstv[13] = (unsigned char  *)szhyyyymmdd;
 sqlstm.sqhstl[13] = (unsigned long )9;
 sqlstm.sqhsts[13] = (         int  )0;
 sqlstm.sqindv[13] = (         short *)0;
 sqlstm.sqinds[13] = (         int  )0;
 sqlstm.sqharm[13] = (unsigned long )0;
 sqlstm.sqadto[13] = (unsigned short )0;
 sqlstm.sqtdso[13] = (unsigned short )0;
 sqlstm.sqhstv[14] = (unsigned char  *)szhUno;
 sqlstm.sqhstl[14] = (unsigned long )2;
 sqlstm.sqhsts[14] = (         int  )0;
 sqlstm.sqindv[14] = (         short *)0;
 sqlstm.sqinds[14] = (         int  )0;
 sqlstm.sqharm[14] = (unsigned long )0;
 sqlstm.sqadto[14] = (unsigned short )0;
 sqlstm.sqtdso[14] = (unsigned short )0;
 sqlstm.sqhstv[15] = (unsigned char  *)szhFiller;
 sqlstm.sqhstl[15] = (unsigned long )2;
 sqlstm.sqhsts[15] = (         int  )0;
 sqlstm.sqindv[15] = (         short *)0;
 sqlstm.sqinds[15] = (         int  )0;
 sqlstm.sqharm[15] = (unsigned long )0;
 sqlstm.sqadto[15] = (unsigned short )0;
 sqlstm.sqtdso[15] = (unsigned short )0;
 sqlstm.sqhstv[16] = (unsigned char  *)szhFiller;
 sqlstm.sqhstl[16] = (unsigned long )2;
 sqlstm.sqhsts[16] = (         int  )0;
 sqlstm.sqindv[16] = (         short *)0;
 sqlstm.sqinds[16] = (         int  )0;
 sqlstm.sqharm[16] = (unsigned long )0;
 sqlstm.sqadto[16] = (unsigned short )0;
 sqlstm.sqtdso[16] = (unsigned short )0;
 sqlstm.sqhstv[17] = (unsigned char  *)szhFiller;
 sqlstm.sqhstl[17] = (unsigned long )2;
 sqlstm.sqhsts[17] = (         int  )0;
 sqlstm.sqindv[17] = (         short *)0;
 sqlstm.sqinds[17] = (         int  )0;
 sqlstm.sqharm[17] = (unsigned long )0;
 sqlstm.sqadto[17] = (unsigned short )0;
 sqlstm.sqtdso[17] = (unsigned short )0;
 sqlstm.sqhstv[18] = (unsigned char  *)szhGSM;
 sqlstm.sqhstl[18] = (unsigned long )4;
 sqlstm.sqhsts[18] = (         int  )0;
 sqlstm.sqindv[18] = (         short *)0;
 sqlstm.sqinds[18] = (         int  )0;
 sqlstm.sqharm[18] = (unsigned long )0;
 sqlstm.sqadto[18] = (unsigned short )0;
 sqlstm.sqtdso[18] = (unsigned short )0;
 sqlstm.sqhstv[19] = (unsigned char  *)szhIMSI;
 sqlstm.sqhstl[19] = (unsigned long )5;
 sqlstm.sqhsts[19] = (         int  )0;
 sqlstm.sqindv[19] = (         short *)0;
 sqlstm.sqinds[19] = (         int  )0;
 sqlstm.sqharm[19] = (unsigned long )0;
 sqlstm.sqadto[19] = (unsigned short )0;
 sqlstm.sqtdso[19] = (unsigned short )0;
 sqlstm.sqhstv[20] = (unsigned char  *)szhFiller;
 sqlstm.sqhstl[20] = (unsigned long )2;
 sqlstm.sqhsts[20] = (         int  )0;
 sqlstm.sqindv[20] = (         short *)0;
 sqlstm.sqinds[20] = (         int  )0;
 sqlstm.sqharm[20] = (unsigned long )0;
 sqlstm.sqadto[20] = (unsigned short )0;
 sqlstm.sqtdso[20] = (unsigned short )0;
 sqlstm.sqhstv[21] = (unsigned char  *)&lhCodCliente;
 sqlstm.sqhstl[21] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[21] = (         int  )0;
 sqlstm.sqindv[21] = (         short *)0;
 sqlstm.sqinds[21] = (         int  )0;
 sqlstm.sqharm[21] = (unsigned long )0;
 sqlstm.sqadto[21] = (unsigned short )0;
 sqlstm.sqtdso[21] = (unsigned short )0;
 sqlstm.sqhstv[22] = (unsigned char  *)&ihCodUsoAmistar;
 sqlstm.sqhstl[22] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[22] = (         int  )0;
 sqlstm.sqindv[22] = (         short *)0;
 sqlstm.sqinds[22] = (         int  )0;
 sqlstm.sqharm[22] = (unsigned long )0;
 sqlstm.sqadto[22] = (unsigned short )0;
 sqlstm.sqtdso[22] = (unsigned short )0;
 sqlstm.sqhstv[23] = (unsigned char  *)szhBAJAABO;
 sqlstm.sqhstl[23] = (unsigned long )4;
 sqlstm.sqhsts[23] = (         int  )0;
 sqlstm.sqindv[23] = (         short *)0;
 sqlstm.sqinds[23] = (         int  )0;
 sqlstm.sqharm[23] = (unsigned long )0;
 sqlstm.sqadto[23] = (unsigned short )0;
 sqlstm.sqtdso[23] = (unsigned short )0;
 sqlstm.sqhstv[24] = (unsigned char  *)szhBAJAPROC;
 sqlstm.sqhstl[24] = (unsigned long )4;
 sqlstm.sqhsts[24] = (         int  )0;
 sqlstm.sqindv[24] = (         short *)0;
 sqlstm.sqinds[24] = (         int  )0;
 sqlstm.sqharm[24] = (unsigned long )0;
 sqlstm.sqadto[24] = (unsigned short )0;
 sqlstm.sqtdso[24] = (unsigned short )0;
 sqlstm.sqhstv[25] = (unsigned char  *)&ihValor_Cero;
 sqlstm.sqhstl[25] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[25] = (         int  )0;
 sqlstm.sqindv[25] = (         short *)0;
 sqlstm.sqinds[25] = (         int  )0;
 sqlstm.sqharm[25] = (unsigned long )0;
 sqlstm.sqadto[25] = (unsigned short )0;
 sqlstm.sqtdso[25] = (unsigned short )0;
 sqlstm.sqhstv[26] = (unsigned char  *)&ihValor_Cero;
 sqlstm.sqhstl[26] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[26] = (         int  )0;
 sqlstm.sqindv[26] = (         short *)0;
 sqlstm.sqinds[26] = (         int  )0;
 sqlstm.sqharm[26] = (unsigned long )0;
 sqlstm.sqadto[26] = (unsigned short )0;
 sqlstm.sqtdso[26] = (unsigned short )0;
 sqlstm.sqhstv[27] = (unsigned char  *)&ihValor_Cero;
 sqlstm.sqhstl[27] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[27] = (         int  )0;
 sqlstm.sqindv[27] = (         short *)0;
 sqlstm.sqinds[27] = (         int  )0;
 sqlstm.sqharm[27] = (unsigned long )0;
 sqlstm.sqadto[27] = (unsigned short )0;
 sqlstm.sqtdso[27] = (unsigned short )0;
 sqlstm.sqhstv[28] = (unsigned char  *)szh00000000;
 sqlstm.sqhstl[28] = (unsigned long )9;
 sqlstm.sqhsts[28] = (         int  )0;
 sqlstm.sqindv[28] = (         short *)0;
 sqlstm.sqinds[28] = (         int  )0;
 sqlstm.sqharm[28] = (unsigned long )0;
 sqlstm.sqadto[28] = (unsigned short )0;
 sqlstm.sqtdso[28] = (unsigned short )0;
 sqlstm.sqhstv[29] = (unsigned char  *)szhUno;
 sqlstm.sqhstl[29] = (unsigned long )2;
 sqlstm.sqhsts[29] = (         int  )0;
 sqlstm.sqindv[29] = (         short *)0;
 sqlstm.sqinds[29] = (         int  )0;
 sqlstm.sqharm[29] = (unsigned long )0;
 sqlstm.sqadto[29] = (unsigned short )0;
 sqlstm.sqtdso[29] = (unsigned short )0;
 sqlstm.sqhstv[30] = (unsigned char  *)&ihValor_Cero;
 sqlstm.sqhstl[30] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[30] = (         int  )0;
 sqlstm.sqindv[30] = (         short *)0;
 sqlstm.sqinds[30] = (         int  )0;
 sqlstm.sqharm[30] = (unsigned long )0;
 sqlstm.sqadto[30] = (unsigned short )0;
 sqlstm.sqtdso[30] = (unsigned short )0;
 sqlstm.sqhstv[31] = (unsigned char  *)&ihValor_Cero;
 sqlstm.sqhstl[31] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[31] = (         int  )0;
 sqlstm.sqindv[31] = (         short *)0;
 sqlstm.sqinds[31] = (         int  )0;
 sqlstm.sqharm[31] = (unsigned long )0;
 sqlstm.sqadto[31] = (unsigned short )0;
 sqlstm.sqtdso[31] = (unsigned short )0;
 sqlstm.sqhstv[32] = (unsigned char  *)szh00000;
 sqlstm.sqhstl[32] = (unsigned long )6;
 sqlstm.sqhsts[32] = (         int  )0;
 sqlstm.sqindv[32] = (         short *)0;
 sqlstm.sqinds[32] = (         int  )0;
 sqlstm.sqharm[32] = (unsigned long )0;
 sqlstm.sqadto[32] = (unsigned short )0;
 sqlstm.sqtdso[32] = (unsigned short )0;
 sqlstm.sqhstv[33] = (unsigned char  *)szh00000;
 sqlstm.sqhstl[33] = (unsigned long )6;
 sqlstm.sqhsts[33] = (         int  )0;
 sqlstm.sqindv[33] = (         short *)0;
 sqlstm.sqinds[33] = (         int  )0;
 sqlstm.sqharm[33] = (unsigned long )0;
 sqlstm.sqadto[33] = (unsigned short )0;
 sqlstm.sqtdso[33] = (unsigned short )0;
 sqlstm.sqhstv[34] = (unsigned char  *)&ihValor_Cero;
 sqlstm.sqhstl[34] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[34] = (         int  )0;
 sqlstm.sqindv[34] = (         short *)0;
 sqlstm.sqinds[34] = (         int  )0;
 sqlstm.sqharm[34] = (unsigned long )0;
 sqlstm.sqadto[34] = (unsigned short )0;
 sqlstm.sqtdso[34] = (unsigned short )0;
 sqlstm.sqhstv[35] = (unsigned char  *)szh00000000000;
 sqlstm.sqhstl[35] = (unsigned long )12;
 sqlstm.sqhsts[35] = (         int  )0;
 sqlstm.sqindv[35] = (         short *)0;
 sqlstm.sqinds[35] = (         int  )0;
 sqlstm.sqharm[35] = (unsigned long )0;
 sqlstm.sqadto[35] = (unsigned short )0;
 sqlstm.sqtdso[35] = (unsigned short )0;
 sqlstm.sqhstv[36] = (unsigned char  *)&ihValor_Uno;
 sqlstm.sqhstl[36] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[36] = (         int  )0;
 sqlstm.sqindv[36] = (         short *)0;
 sqlstm.sqinds[36] = (         int  )0;
 sqlstm.sqharm[36] = (unsigned long )0;
 sqlstm.sqadto[36] = (unsigned short )0;
 sqlstm.sqtdso[36] = (unsigned short )0;
 sqlstm.sqhstv[37] = (unsigned char  *)&ihValor_UnoNeg;
 sqlstm.sqhstl[37] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[37] = (         int  )0;
 sqlstm.sqindv[37] = (         short *)0;
 sqlstm.sqinds[37] = (         int  )0;
 sqlstm.sqharm[37] = (unsigned long )0;
 sqlstm.sqadto[37] = (unsigned short )0;
 sqlstm.sqtdso[37] = (unsigned short )0;
 sqlstm.sqhstv[38] = (unsigned char  *)&ihValor_UnoNeg;
 sqlstm.sqhstl[38] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[38] = (         int  )0;
 sqlstm.sqindv[38] = (         short *)0;
 sqlstm.sqinds[38] = (         int  )0;
 sqlstm.sqharm[38] = (unsigned long )0;
 sqlstm.sqadto[38] = (unsigned short )0;
 sqlstm.sqtdso[38] = (unsigned short )0;
 sqlstm.sqhstv[39] = (unsigned char  *)&ihValor_UnoNeg;
 sqlstm.sqhstl[39] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[39] = (         int  )0;
 sqlstm.sqindv[39] = (         short *)0;
 sqlstm.sqinds[39] = (         int  )0;
 sqlstm.sqharm[39] = (unsigned long )0;
 sqlstm.sqadto[39] = (unsigned short )0;
 sqlstm.sqtdso[39] = (unsigned short )0;
 sqlstm.sqhstv[40] = (unsigned char  *)szh00000000;
 sqlstm.sqhstl[40] = (unsigned long )9;
 sqlstm.sqhsts[40] = (         int  )0;
 sqlstm.sqindv[40] = (         short *)0;
 sqlstm.sqinds[40] = (         int  )0;
 sqlstm.sqharm[40] = (unsigned long )0;
 sqlstm.sqadto[40] = (unsigned short )0;
 sqlstm.sqtdso[40] = (unsigned short )0;
 sqlstm.sqhstv[41] = (unsigned char  *)szhyyyymmdd;
 sqlstm.sqhstl[41] = (unsigned long )9;
 sqlstm.sqhsts[41] = (         int  )0;
 sqlstm.sqindv[41] = (         short *)0;
 sqlstm.sqinds[41] = (         int  )0;
 sqlstm.sqharm[41] = (unsigned long )0;
 sqlstm.sqadto[41] = (unsigned short )0;
 sqlstm.sqtdso[41] = (unsigned short )0;
 sqlstm.sqhstv[42] = (unsigned char  *)szhUno;
 sqlstm.sqhstl[42] = (unsigned long )2;
 sqlstm.sqhsts[42] = (         int  )0;
 sqlstm.sqindv[42] = (         short *)0;
 sqlstm.sqinds[42] = (         int  )0;
 sqlstm.sqharm[42] = (unsigned long )0;
 sqlstm.sqadto[42] = (unsigned short )0;
 sqlstm.sqtdso[42] = (unsigned short )0;
 sqlstm.sqhstv[43] = (unsigned char  *)szhFiller;
 sqlstm.sqhstl[43] = (unsigned long )2;
 sqlstm.sqhsts[43] = (         int  )0;
 sqlstm.sqindv[43] = (         short *)0;
 sqlstm.sqinds[43] = (         int  )0;
 sqlstm.sqharm[43] = (unsigned long )0;
 sqlstm.sqadto[43] = (unsigned short )0;
 sqlstm.sqtdso[43] = (unsigned short )0;
 sqlstm.sqhstv[44] = (unsigned char  *)szhFiller;
 sqlstm.sqhstl[44] = (unsigned long )2;
 sqlstm.sqhsts[44] = (         int  )0;
 sqlstm.sqindv[44] = (         short *)0;
 sqlstm.sqinds[44] = (         int  )0;
 sqlstm.sqharm[44] = (unsigned long )0;
 sqlstm.sqadto[44] = (unsigned short )0;
 sqlstm.sqtdso[44] = (unsigned short )0;
 sqlstm.sqhstv[45] = (unsigned char  *)szhFiller;
 sqlstm.sqhstl[45] = (unsigned long )2;
 sqlstm.sqhsts[45] = (         int  )0;
 sqlstm.sqindv[45] = (         short *)0;
 sqlstm.sqinds[45] = (         int  )0;
 sqlstm.sqharm[45] = (unsigned long )0;
 sqlstm.sqadto[45] = (unsigned short )0;
 sqlstm.sqtdso[45] = (unsigned short )0;
 sqlstm.sqhstv[46] = (unsigned char  *)szhFiller;
 sqlstm.sqhstl[46] = (unsigned long )2;
 sqlstm.sqhsts[46] = (         int  )0;
 sqlstm.sqindv[46] = (         short *)0;
 sqlstm.sqinds[46] = (         int  )0;
 sqlstm.sqharm[46] = (unsigned long )0;
 sqlstm.sqadto[46] = (unsigned short )0;
 sqlstm.sqtdso[46] = (unsigned short )0;
 sqlstm.sqhstv[47] = (unsigned char  *)szhFiller;
 sqlstm.sqhstl[47] = (unsigned long )2;
 sqlstm.sqhsts[47] = (         int  )0;
 sqlstm.sqindv[47] = (         short *)0;
 sqlstm.sqinds[47] = (         int  )0;
 sqlstm.sqharm[47] = (unsigned long )0;
 sqlstm.sqadto[47] = (unsigned short )0;
 sqlstm.sqtdso[47] = (unsigned short )0;
 sqlstm.sqhstv[48] = (unsigned char  *)&lhCodCliente;
 sqlstm.sqhstl[48] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[48] = (         int  )0;
 sqlstm.sqindv[48] = (         short *)0;
 sqlstm.sqinds[48] = (         int  )0;
 sqlstm.sqharm[48] = (unsigned long )0;
 sqlstm.sqadto[48] = (unsigned short )0;
 sqlstm.sqtdso[48] = (unsigned short )0;
 sqlstm.sqhstv[49] = (unsigned char  *)szhBAJAABO;
 sqlstm.sqhstl[49] = (unsigned long )4;
 sqlstm.sqhsts[49] = (         int  )0;
 sqlstm.sqindv[49] = (         short *)0;
 sqlstm.sqinds[49] = (         int  )0;
 sqlstm.sqharm[49] = (unsigned long )0;
 sqlstm.sqadto[49] = (unsigned short )0;
 sqlstm.sqtdso[49] = (unsigned short )0;
 sqlstm.sqhstv[50] = (unsigned char  *)szhBAJAPROC;
 sqlstm.sqhstl[50] = (unsigned long )4;
 sqlstm.sqhsts[50] = (         int  )0;
 sqlstm.sqindv[50] = (         short *)0;
 sqlstm.sqinds[50] = (         int  )0;
 sqlstm.sqharm[50] = (unsigned long )0;
 sqlstm.sqadto[50] = (unsigned short )0;
 sqlstm.sqtdso[50] = (unsigned short )0;
 sqlstm.sqhstv[51] = (unsigned char  *)&lh9000000;
 sqlstm.sqhstl[51] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[51] = (         int  )0;
 sqlstm.sqindv[51] = (         short *)0;
 sqlstm.sqinds[51] = (         int  )0;
 sqlstm.sqharm[51] = (unsigned long )0;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	if( sqlca.sqlcode != SQLOK ) {
		ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) Open curUniverso %s ",LOG00,lCliente,sqlca.sqlerrm.sqlerrmc);  
		return "PND";
	}

	strcpy( szStsFin, "OK" );

   /* forever */
   for( ; ; )	   {
		bAplicarIndem = FALSE;
		sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
		/* EXEC SQL FETCH curUniverso 
		INTO	:ihProducto,
				:lhNumAbonado,
				:szhCodSituacion,   
				:ihIndPlexsys,    
				:ihCodCentral,      
				:ihCodCentralPlex,  
				:lhNumCelularBeeper,
				:lhNumCelularPlex,  
				:szhNumSerieHex,    
				:szhTipTerminal,  
				:ihCodModventa,     
				:szhIndProcequi,  
				:ihCodCiclo,
				:szhCodPlanserv, 
				:szhNumContrato,  
				:szhNumAnexo, 
				:lhCodCuenta,
				:ihCodUso,
				:szhCodPlanTarif,
				:ihIndSupertel,     
				:szhNumTeleFija,
				:ihIndDisp,
				:ihDifFecFinContSys,
				:ihDifFecSysPror,
				:ihDifFecSysAlta,
				:szhFecProrroga,
				:szhFecAlta,
				:szhIndEqPrestado,
				:szhNumMin,
				:ihNumMeses,
				:szhCodTecnologia,
				:szhNumSerie,
				:szhNumImei,
				:szhNumImsi,
				:szhCodTiPlan; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 52;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )432;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihProducto;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhCodSituacion;
  sqlstm.sqhstl[2] = (unsigned long )4;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&ihIndPlexsys;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&ihCodCentral;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)&ihCodCentralPlex;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)&lhNumCelularBeeper;
  sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)&lhNumCelularPlex;
  sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)szhNumSerieHex;
  sqlstm.sqhstl[8] = (unsigned long )9;
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)szhTipTerminal;
  sqlstm.sqhstl[9] = (unsigned long )2;
  sqlstm.sqhsts[9] = (         int  )0;
  sqlstm.sqindv[9] = (         short *)0;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)&ihCodModventa;
  sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[10] = (         int  )0;
  sqlstm.sqindv[10] = (         short *)0;
  sqlstm.sqinds[10] = (         int  )0;
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)szhIndProcequi;
  sqlstm.sqhstl[11] = (unsigned long )3;
  sqlstm.sqhsts[11] = (         int  )0;
  sqlstm.sqindv[11] = (         short *)0;
  sqlstm.sqinds[11] = (         int  )0;
  sqlstm.sqharm[11] = (unsigned long )0;
  sqlstm.sqadto[11] = (unsigned short )0;
  sqlstm.sqtdso[11] = (unsigned short )0;
  sqlstm.sqhstv[12] = (unsigned char  *)&ihCodCiclo;
  sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[12] = (         int  )0;
  sqlstm.sqindv[12] = (         short *)0;
  sqlstm.sqinds[12] = (         int  )0;
  sqlstm.sqharm[12] = (unsigned long )0;
  sqlstm.sqadto[12] = (unsigned short )0;
  sqlstm.sqtdso[12] = (unsigned short )0;
  sqlstm.sqhstv[13] = (unsigned char  *)szhCodPlanserv;
  sqlstm.sqhstl[13] = (unsigned long )4;
  sqlstm.sqhsts[13] = (         int  )0;
  sqlstm.sqindv[13] = (         short *)0;
  sqlstm.sqinds[13] = (         int  )0;
  sqlstm.sqharm[13] = (unsigned long )0;
  sqlstm.sqadto[13] = (unsigned short )0;
  sqlstm.sqtdso[13] = (unsigned short )0;
  sqlstm.sqhstv[14] = (unsigned char  *)szhNumContrato;
  sqlstm.sqhstl[14] = (unsigned long )22;
  sqlstm.sqhsts[14] = (         int  )0;
  sqlstm.sqindv[14] = (         short *)0;
  sqlstm.sqinds[14] = (         int  )0;
  sqlstm.sqharm[14] = (unsigned long )0;
  sqlstm.sqadto[14] = (unsigned short )0;
  sqlstm.sqtdso[14] = (unsigned short )0;
  sqlstm.sqhstv[15] = (unsigned char  *)szhNumAnexo;
  sqlstm.sqhstl[15] = (unsigned long )22;
  sqlstm.sqhsts[15] = (         int  )0;
  sqlstm.sqindv[15] = (         short *)0;
  sqlstm.sqinds[15] = (         int  )0;
  sqlstm.sqharm[15] = (unsigned long )0;
  sqlstm.sqadto[15] = (unsigned short )0;
  sqlstm.sqtdso[15] = (unsigned short )0;
  sqlstm.sqhstv[16] = (unsigned char  *)&lhCodCuenta;
  sqlstm.sqhstl[16] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[16] = (         int  )0;
  sqlstm.sqindv[16] = (         short *)0;
  sqlstm.sqinds[16] = (         int  )0;
  sqlstm.sqharm[16] = (unsigned long )0;
  sqlstm.sqadto[16] = (unsigned short )0;
  sqlstm.sqtdso[16] = (unsigned short )0;
  sqlstm.sqhstv[17] = (unsigned char  *)&ihCodUso;
  sqlstm.sqhstl[17] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[17] = (         int  )0;
  sqlstm.sqindv[17] = (         short *)0;
  sqlstm.sqinds[17] = (         int  )0;
  sqlstm.sqharm[17] = (unsigned long )0;
  sqlstm.sqadto[17] = (unsigned short )0;
  sqlstm.sqtdso[17] = (unsigned short )0;
  sqlstm.sqhstv[18] = (unsigned char  *)szhCodPlanTarif;
  sqlstm.sqhstl[18] = (unsigned long )4;
  sqlstm.sqhsts[18] = (         int  )0;
  sqlstm.sqindv[18] = (         short *)0;
  sqlstm.sqinds[18] = (         int  )0;
  sqlstm.sqharm[18] = (unsigned long )0;
  sqlstm.sqadto[18] = (unsigned short )0;
  sqlstm.sqtdso[18] = (unsigned short )0;
  sqlstm.sqhstv[19] = (unsigned char  *)&ihIndSupertel;
  sqlstm.sqhstl[19] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[19] = (         int  )0;
  sqlstm.sqindv[19] = (         short *)0;
  sqlstm.sqinds[19] = (         int  )0;
  sqlstm.sqharm[19] = (unsigned long )0;
  sqlstm.sqadto[19] = (unsigned short )0;
  sqlstm.sqtdso[19] = (unsigned short )0;
  sqlstm.sqhstv[20] = (unsigned char  *)szhNumTeleFija;
  sqlstm.sqhstl[20] = (unsigned long )16;
  sqlstm.sqhsts[20] = (         int  )0;
  sqlstm.sqindv[20] = (         short *)0;
  sqlstm.sqinds[20] = (         int  )0;
  sqlstm.sqharm[20] = (unsigned long )0;
  sqlstm.sqadto[20] = (unsigned short )0;
  sqlstm.sqtdso[20] = (unsigned short )0;
  sqlstm.sqhstv[21] = (unsigned char  *)&ihIndDisp;
  sqlstm.sqhstl[21] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[21] = (         int  )0;
  sqlstm.sqindv[21] = (         short *)0;
  sqlstm.sqinds[21] = (         int  )0;
  sqlstm.sqharm[21] = (unsigned long )0;
  sqlstm.sqadto[21] = (unsigned short )0;
  sqlstm.sqtdso[21] = (unsigned short )0;
  sqlstm.sqhstv[22] = (unsigned char  *)&ihDifFecFinContSys;
  sqlstm.sqhstl[22] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[22] = (         int  )0;
  sqlstm.sqindv[22] = (         short *)0;
  sqlstm.sqinds[22] = (         int  )0;
  sqlstm.sqharm[22] = (unsigned long )0;
  sqlstm.sqadto[22] = (unsigned short )0;
  sqlstm.sqtdso[22] = (unsigned short )0;
  sqlstm.sqhstv[23] = (unsigned char  *)&ihDifFecSysPror;
  sqlstm.sqhstl[23] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[23] = (         int  )0;
  sqlstm.sqindv[23] = (         short *)0;
  sqlstm.sqinds[23] = (         int  )0;
  sqlstm.sqharm[23] = (unsigned long )0;
  sqlstm.sqadto[23] = (unsigned short )0;
  sqlstm.sqtdso[23] = (unsigned short )0;
  sqlstm.sqhstv[24] = (unsigned char  *)&ihDifFecSysAlta;
  sqlstm.sqhstl[24] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[24] = (         int  )0;
  sqlstm.sqindv[24] = (         short *)0;
  sqlstm.sqinds[24] = (         int  )0;
  sqlstm.sqharm[24] = (unsigned long )0;
  sqlstm.sqadto[24] = (unsigned short )0;
  sqlstm.sqtdso[24] = (unsigned short )0;
  sqlstm.sqhstv[25] = (unsigned char  *)szhFecProrroga;
  sqlstm.sqhstl[25] = (unsigned long )9;
  sqlstm.sqhsts[25] = (         int  )0;
  sqlstm.sqindv[25] = (         short *)0;
  sqlstm.sqinds[25] = (         int  )0;
  sqlstm.sqharm[25] = (unsigned long )0;
  sqlstm.sqadto[25] = (unsigned short )0;
  sqlstm.sqtdso[25] = (unsigned short )0;
  sqlstm.sqhstv[26] = (unsigned char  *)szhFecAlta;
  sqlstm.sqhstl[26] = (unsigned long )20;
  sqlstm.sqhsts[26] = (         int  )0;
  sqlstm.sqindv[26] = (         short *)0;
  sqlstm.sqinds[26] = (         int  )0;
  sqlstm.sqharm[26] = (unsigned long )0;
  sqlstm.sqadto[26] = (unsigned short )0;
  sqlstm.sqtdso[26] = (unsigned short )0;
  sqlstm.sqhstv[27] = (unsigned char  *)szhIndEqPrestado;
  sqlstm.sqhstl[27] = (unsigned long )2;
  sqlstm.sqhsts[27] = (         int  )0;
  sqlstm.sqindv[27] = (         short *)0;
  sqlstm.sqinds[27] = (         int  )0;
  sqlstm.sqharm[27] = (unsigned long )0;
  sqlstm.sqadto[27] = (unsigned short )0;
  sqlstm.sqtdso[27] = (unsigned short )0;
  sqlstm.sqhstv[28] = (unsigned char  *)szhNumMin;
  sqlstm.sqhstl[28] = (unsigned long )4;
  sqlstm.sqhsts[28] = (         int  )0;
  sqlstm.sqindv[28] = (         short *)0;
  sqlstm.sqinds[28] = (         int  )0;
  sqlstm.sqharm[28] = (unsigned long )0;
  sqlstm.sqadto[28] = (unsigned short )0;
  sqlstm.sqtdso[28] = (unsigned short )0;
  sqlstm.sqhstv[29] = (unsigned char  *)&ihNumMeses;
  sqlstm.sqhstl[29] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[29] = (         int  )0;
  sqlstm.sqindv[29] = (         short *)0;
  sqlstm.sqinds[29] = (         int  )0;
  sqlstm.sqharm[29] = (unsigned long )0;
  sqlstm.sqadto[29] = (unsigned short )0;
  sqlstm.sqtdso[29] = (unsigned short )0;
  sqlstm.sqhstv[30] = (unsigned char  *)szhCodTecnologia;
  sqlstm.sqhstl[30] = (unsigned long )9;
  sqlstm.sqhsts[30] = (         int  )0;
  sqlstm.sqindv[30] = (         short *)0;
  sqlstm.sqinds[30] = (         int  )0;
  sqlstm.sqharm[30] = (unsigned long )0;
  sqlstm.sqadto[30] = (unsigned short )0;
  sqlstm.sqtdso[30] = (unsigned short )0;
  sqlstm.sqhstv[31] = (unsigned char  *)szhNumSerie;
  sqlstm.sqhstl[31] = (unsigned long )26;
  sqlstm.sqhsts[31] = (         int  )0;
  sqlstm.sqindv[31] = (         short *)0;
  sqlstm.sqinds[31] = (         int  )0;
  sqlstm.sqharm[31] = (unsigned long )0;
  sqlstm.sqadto[31] = (unsigned short )0;
  sqlstm.sqtdso[31] = (unsigned short )0;
  sqlstm.sqhstv[32] = (unsigned char  *)szhNumImei;
  sqlstm.sqhstl[32] = (unsigned long )26;
  sqlstm.sqhsts[32] = (         int  )0;
  sqlstm.sqindv[32] = (         short *)0;
  sqlstm.sqinds[32] = (         int  )0;
  sqlstm.sqharm[32] = (unsigned long )0;
  sqlstm.sqadto[32] = (unsigned short )0;
  sqlstm.sqtdso[32] = (unsigned short )0;
  sqlstm.sqhstv[33] = (unsigned char  *)szhNumImsi;
  sqlstm.sqhstl[33] = (unsigned long )51;
  sqlstm.sqhsts[33] = (         int  )0;
  sqlstm.sqindv[33] = (         short *)0;
  sqlstm.sqinds[33] = (         int  )0;
  sqlstm.sqharm[33] = (unsigned long )0;
  sqlstm.sqadto[33] = (unsigned short )0;
  sqlstm.sqtdso[33] = (unsigned short )0;
  sqlstm.sqhstv[34] = (unsigned char  *)szhCodTiPlan;
  sqlstm.sqhstl[34] = (unsigned long )9;
  sqlstm.sqhsts[34] = (         int  )0;
  sqlstm.sqindv[34] = (         short *)0;
  sqlstm.sqinds[34] = (         int  )0;
  sqlstm.sqharm[34] = (unsigned long )0;
  sqlstm.sqadto[34] = (unsigned short )0;
  sqlstm.sqtdso[34] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


				        		
      if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )   {
            ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) Fetch curUniverso %s ", LOG00, lCliente, sqlca.sqlerrm.sqlerrmc );
            strcpy( szStsFin, "PND" );
            break;
      }
      else if( sqlca.sqlcode == SQLNOTFOUND )     {
            ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) fue dado de Baja", LOG03, lCliente );
            strcpy( szStsFin, "OK" );
            break; 
      }

		ifnTrazaHilos( modulo,&pfLog, 	"Datos del Cliente %ld\n"
								"\t\t   ihProducto         = [%d],\n"
								"\t\t   lhNumAbonado       = [%ld],\n"
								"\t\t   szhCodSituacion    = [%s],\n"
								"\t\t   ihIndPlexsys       = [%d],\n"
								"\t\t   ihCodCentral       = [%d],\n"      
								"\t\t   ihCodCentralPlex   = [%d],\n"  
								"\t\t   lhNumCelularBeeper = [%ld],\n"
								"\t\t   lhNumCelularPlex   = [%ld],\n"  
								"\t\t   szhNumSerieHex     = [%s],\n"    
								"\t\t   szhTipTerminal     = [%s],\n"  
								"\t\t   szhNumSerie        = [%s],\n"
								"\t\t   ihCodModventa      = [%d],\n"     
								"\t\t   szhIndProcequi     = [%s],\n"  
								"\t\t   ihCodCiclo         = [%d],\n"
								"\t\t   szhCodPlanserv     = [%s],\n" 
								"\t\t   szhNumContrato     = [%s],\n"  
								"\t\t   szhNumAnexo        = [%s],\n" 
								"\t\t   lhCodCuenta        = [%ld],\n"
								"\t\t   ihCodUso           = [%d],\n"
								"\t\t   szhCodPlanTarif    = [%s],\n"
								"\t\t   ihIndSupertel      = [%d],\n"     
								"\t\t   szhNumTeleFija     = [%s],\n"
								"\t\t   ihIndDisp          = [%d],\n"
								"\t\t   ihDifFecFinContSys = [%d],\n"
								"\t\t   ihDifFecSysPror    = [%d],\n"
								"\t\t   ihDifFecSysAlta    = [%d],\n"
								"\t\t   szhFecProrroga     = [%s],\n"
								"\t\t   szhFecAlta         = [%s],\n"
								"\t\t   szhIndEqPrestado   = [%s],\n"
								"\t\t   szhNumMin          = [%s],\n"
								"\t\t   ihNumMeses         = [%d],\n"
								"\t\t   szhCodTecnologia   = [%s],\n"
								"\t\t   szhNumSerie        = [%s],\n"
								"\t\t   szhNumImei         = [%s],\n"
								"\t\t   szhNumImsi         = [%s].\n",
								LOG05, 
								lhCodCliente,
								ihProducto,
								lhNumAbonado,
								szhCodSituacion,   
								ihIndPlexsys,    
								ihCodCentral,      
								ihCodCentralPlex,  
								lhNumCelularBeeper,
								lhNumCelularPlex,  
								szhNumSerieHex,    
								szhTipTerminal,  
								szhNumSerie,
								ihCodModventa,     
								szhIndProcequi,  
								ihCodCiclo,
								szhCodPlanserv, 
								szhNumContrato,  
								szhNumAnexo, 
								lhCodCuenta,
								ihCodUso,
								szhCodPlanTarif,
								ihIndSupertel,     
								szhNumTeleFija,
								ihIndDisp,
								ihDifFecFinContSys,
								ihDifFecSysPror,
								ihDifFecSysAlta,
								szhFecProrroga,
								szhFecAlta,
								szhIndEqPrestado,
								szhNumMin,
								ihNumMeses,
								szhCodTecnologia,
								szhNumSerie,
								szhNumImei,
								szhNumImsi );

		if( ihProducto == ihCodProdCelular )	/* si es celular */
		{
			/* debemos revisar si el par cliente/abonado tiene ciclo de facturacion vigente */
			iRet = ifnCiclFactVigenteAbonado(&pfLog, lhCodCliente, lhNumAbonado, ihCodCicloFact, CXX );
			if( iRet < 0 )	/* hubo un error */
			{
				strcpy( szStsFin, "PND" );
				break;
			}
			else if( iRet == 0 ) /* no tiene ciclo vigente, se necesita para operaciones posteriores */
			{
				ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld], Abonado => [%ld], No tiene ciclo de facturacion vigente.", LOG00, lhCodCliente, lhNumAbonado );
				strcpy( szStsFin, "NOPER" );
				break;
			}		

			/* actualizamos la ga_abocel */
			ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld|Abonado:%ld) Cod Situacion = 'BAP'.", LOG05, lhCodCliente, lhNumAbonado );
			sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
			/* EXEC SQL
			UPDATE GA_ABOCEL  SET		
			      COD_SITUACION	 = :szhBAP, 
					FEC_BAJA        = TO_DATE( :szhFecSysdate, :szhDDMMYYYYHH24MISS ), 
					FEC_ULTMOD      = TO_DATE( :szhFecSysdate, :szhDDMMYYYYHH24MISS ), 
					COD_CAUSABAJA   = :szhCodCausaBajaCelular
			WHERE	NUM_ABONADO     = :lhNumAbonado ; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 52;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update GA_ABOCEL  set COD_SITUACION=:b0,FEC_BAJA=TO_DATE(:\
b1,:b2),FEC_ULTMOD=TO_DATE(:b1,:b2),COD_CAUSABAJA=:b5 where NUM_ABONADO=:b6";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )587;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhBAP;
   sqlstm.sqhstl[0] = (unsigned long )4;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhFecSysdate;
   sqlstm.sqhstl[1] = (unsigned long )20;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhDDMMYYYYHH24MISS;
   sqlstm.sqhstl[2] = (unsigned long )22;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhFecSysdate;
   sqlstm.sqhstl[3] = (unsigned long )20;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)szhDDMMYYYYHH24MISS;
   sqlstm.sqhstl[4] = (unsigned long )22;
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhCodCausaBajaCelular;
   sqlstm.sqhstl[5] = (unsigned long )3;
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)&lhNumAbonado;
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
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



			if( sqlca.sqlcode ) {
				ifnTrazaHilos( modulo,&pfLog, "UPDATE GA_ABOCEL (Cliente:%ld|Abonado:%ld) %s", LOG00, lhCodCliente, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
				strcpy( szStsFin, "PND" );
				break;
			}

			sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
			/* EXEC SQL
			UPDATE GE_CLIENTES SET		
			       NUM_ABOCEL	   = NUM_ABOCEL - :ihValor_Uno,
					 FEC_BAJA      = TO_DATE( :szhFecSysdate, :szhDDMMYYYYHH24MISS ),
					 IND_SITUACION = :szhBA
			WHERE	 COD_CLIENTE   = :lhCodCliente; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 52;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update GE_CLIENTES  set NUM_ABOCEL=(NUM_ABOCEL-:b0),FEC_BA\
JA=TO_DATE(:b1,:b2),IND_SITUACION=:b3 where COD_CLIENTE=:b4";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )630;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_Uno;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhFecSysdate;
   sqlstm.sqhstl[1] = (unsigned long )20;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhDDMMYYYYHH24MISS;
   sqlstm.sqhstl[2] = (unsigned long )22;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhBA;
   sqlstm.sqhstl[3] = (unsigned long )3;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&lhCodCliente;
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
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


			
			if( sqlca.sqlcode )  {
				ifnTrazaHilos( modulo,&pfLog, "UPDATE GE_CLIENTES (Cliente:%ld) %s", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );
				strcpy( szStsFin,"PND" );
				break;
			}

			ihCodRetorno = 0;
			memset( szhDesError, '\0', sizeof( szhDesError ) );
			
			ifnTrazaHilos( modulo, &pfLog, "\n", LOG05 );
			ifnTrazaHilos( modulo, &pfLog, "Datos para CO_INDEMNIZACION_PR", LOG05 );
			ifnTrazaHilos( modulo, &pfLog, "Cliente  => [%ld]", LOG05, lhCodCliente );
			ifnTrazaHilos( modulo, &pfLog, "Abonado  => [%ld]", LOG05, lhNumAbonado );
			ifnTrazaHilos( modulo, &pfLog, "Modulo   => [%s]", LOG05, szhModulo );
			ifnTrazaHilos( modulo, &pfLog, "Producto => [%d]", LOG05, ihProducto );
			ifnTrazaHilos( modulo, &pfLog, "Retorno  => [%d]", LOG05, ihCodRetorno );
			ifnTrazaHilos( modulo, &pfLog, "Error    => [%s]", LOG05, szhDesError );
			ifnTrazaHilos( modulo, &pfLog, "\n", LOG05 );

			/* EXEC SQL EXECUTE
				BEGIN
					CO_INDEMNIZACION_PG.CO_INDEMNIZACION_PR ( :lhCodCliente, :lhNumAbonado, :szhModulo, :ihProducto, :ihCodRetorno, :szhDesError );
				END;	
			END-EXEC; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 52;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "begin CO_INDEMNIZACION_PG . CO_INDEMNIZACION_PR ( :lhCodCl\
iente , :lhNumAbonado , :szhModulo , :ihProducto , :ihCodRetorno , :szhDesErro\
r ) ; END ;";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )665;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCliente;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhModulo;
   sqlstm.sqhstl[2] = (unsigned long )3;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&ihProducto;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&ihCodRetorno;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhDesError;
   sqlstm.sqhstl[5] = (unsigned long )500;
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
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

 

			ifnTrazaHilos( modulo, &pfLog, "CO_INDEMNIZACION_PG.CO_INDEMNIZACION_PR( Abonado:%ld) Codigo [%d] Retorno[%s].", LOG06, lhNumAbonado, ihCodRetorno, szhDesError );
			
			if( ihCodRetorno != 0 ) /* retorno 0 = OK, 1 = Error */
			{
				ifnTrazaHilos( modulo, &pfLog, "en CO_INDEMNIZACION_PG.CO_INDEMNIZACION_PR ( Abonado =  [%ld] Retorno [%s]", LOG00, lhNumAbonado, szhDesError );
				strcpy ( szStsFin, "PND");
				break;
			}

			/* debemos cobrar indemnizacion si corresponde, Vemos si es comodato */
			if( strcmp( szhIndEqPrestado, COMODATO ) == 0 ) /* es comodato */
			{
				memset( szhRetornoPL, '\0', sizeof( szhRetornoPL ) );
				
				/* Ejecuta PL de abonados para Comodato jlr_17.05.01 */
				sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
				/* EXEC SQL EXECUTE
					BEGIN
						P_BAJAMOROSIDAD_COMODATO( :lhNumAbonado, :szhRetornoPL );
					END;
				END-EXEC; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 52;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "begin P_BAJAMOROSIDAD_COMODATO ( :lhNumAbonado , :szhReto\
rnoPL ) ; END ;";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )704;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumAbonado;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhRetornoPL;
    sqlstm.sqhstl[1] = (unsigned long )2;
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
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

 
				
				ifnTrazaHilos( modulo,&pfLog, "P_BAJAMOROSIDAD_COMODATO(Abonado:%ld) Retorno[%s].", LOG05, lhNumAbonado, szhRetornoPL );
				
				if( !strcmp( szhRetornoPL, "2" ) ) /* retorno 0,1: OK, 2: Error */
				{
					ifnTrazaHilos( modulo,&pfLog, "en P_BAJAMOROSIDAD_COMODATO (Abonado:%ld) Retorno[%s]",LOG00,lhNumAbonado,szhRetornoPL);
					strcpy( szStsFin, "PLBMC");
					break;
				}
			}
	
			/* pasamos el celular a hibernacion */
			if( !bfnHibernacionEquipo(&pfLog, lhNumCelularBeeper, ihCodCentral, ihCodUso, CXX ) )	{
				strcpy( szStsFin, "PND" );
				break;
			}	

			memset( szhServicios, '\0', sizeof( szhServicios ) );

			/* recuperamos los servicios activos del abonado */
			if( !bfnObtServSuplAboAct(&pfLog, lhNumAbonado, szhServicios, CXX ) )  {
				strcpy( szStsFin, "PND" );
				break;
			}	

			memset( szhActAbo, '\0', sizeof( szhActAbo ) );

			/* distinguimos si el celular es prepago o postpago */
			iRet = ifnObtieneUsoVenta(&pfLog, ihCodUso, szhCodTecnologia, CXX );
			
			
			/* recuperamos la actuacion de abonado celular */
			if( !bfnGetActAbodeAccion(&pfLog, szCODRUTINA, szhCodTiPlan, 1, szCodActAbo, CXX ) ) 	{
				strcpy( szStsFin, "PND" );
				break;
			}
			strcpy( szhActAbo, szCodActAbo );
			/* recuperamos el codigo de actuacion de la central, relacionado con la actuacion del abonado */
			if( ( ihCodActuacionCelular = ifnGetActuacionCentralCelularAcc(&pfLog, szhActAbo, ihProducto, szMODULOCOBRANZA, szhCodTecnologia, CXX ) ) < 0 )
			{
				strcpy( szStsFin, "PND" );
				break;
			}	
			
			/*Decomentar cuando se pase el nuevo esquema de la tabla GA_ACTABO, el que incorpora los campops	COD_MODULO y TIP_TECNOLOGIA*/						
			sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
			/* EXEC SQL
			SELECT ICC_SEQ_NUMMOV.NEXTVAL 
			INTO   :lhNumSeqMov1
			FROM   DUAL; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 52;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select ICC_SEQ_NUMMOV.nextval  into :b0  from DUAL ";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )727;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSeqMov1;
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
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



			if( sqlca.sqlcode ) 	{
				ifnTrazaHilos( modulo,&pfLog, "SELECT ICC_SEQ_NUMMOV.NEXTVAL (Cliente:%ld) %s", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );
				strcpy( szStsFin, "PND" );
				break;
			}

			/* Inserta en ICC_MOVIMIENTO */
			if (ihIndPlexsys == 0) /* Si no es Plexsys */
			{
				sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
				/* EXEC SQL
				INSERT INTO ICC_MOVIMIENTO 
						 (NUM_MOVIMIENTO,  NUM_ABONADO   ,	COD_ESTADO   , 
						  COD_MODULO    ,  NOM_USUARORA  ,	COD_CENTRAL  , 
					     NUM_CELULAR   ,  COD_ACTUACION ,	FEC_INGRESO  , 
					     NUM_SERIE     ,  TIP_TERMINAL  ,	COD_ACTABO   ,
					     COD_SERVICIOS ,  NUM_INTENTOS  ,	DES_RESPUESTA,
					     IND_BLOQUEO   ,	 TIP_TECNOLOGIA,	IMEI         ,
					     IMSI          ,	 ICC			   ) 
				VALUES (:lhNumSeqMov1      , :lhNumAbonado         ,  :szhUno, 
					     :szhModulo         , USER                  ,  :ihCodCentral,
					     :lhNumCelularBeeper, :ihCodActuacionCelular,  SYSDATE,   
					     :szhNumSerieHex    , :szhTipTerminal       ,  :szhActAbo,
					     :szhServicios      , :ihValor_Cero         ,  :szhPENDIENTE,
					     :ihValor_Cero      , :szhCodTecnologia     ,
					     DECODE(:szhNumImei , :szhFiller, NULL, :szhNumImei ),
   				     DECODE(:szhNumImsi , :szhFiller, NULL, :szhNumImsi ),
					     DECODE(:szhNumSerie, :szhFiller, NULL, :szhNumSerie) ); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 52;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into ICC_MOVIMIENTO (NUM_MOVIMIENTO,NUM_ABONADO,CO\
D_ESTADO,COD_MODULO,NOM_USUARORA,COD_CENTRAL,NUM_CELULAR,COD_ACTUACION,FEC_ING\
RESO,NUM_SERIE,TIP_TERMINAL,COD_ACTABO,COD_SERVICIOS,NUM_INTENTOS,DES_RESPUEST\
A,IND_BLOQUEO,TIP_TECNOLOGIA,IMEI,IMSI,ICC) values (:b0,:b1,:b2,:b3,USER,:b4,:\
b5,:b6,SYSDATE,:b7,:b8,:b9,:b10,:b11,:b12,:b11,:b14,DECODE(:b15,:b16,null ,:b1\
5),DECODE(:b18,:b16,null ,:b18),DECODE(:b21,:b16,null ,:b21))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )746;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSeqMov1;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhUno;
    sqlstm.sqhstl[2] = (unsigned long )2;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhModulo;
    sqlstm.sqhstl[3] = (unsigned long )3;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&ihCodCentral;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&lhNumCelularBeeper;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&ihCodActuacionCelular;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)szhNumSerieHex;
    sqlstm.sqhstl[7] = (unsigned long )9;
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)szhTipTerminal;
    sqlstm.sqhstl[8] = (unsigned long )2;
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)szhActAbo;
    sqlstm.sqhstl[9] = (unsigned long )3;
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)szhServicios;
    sqlstm.sqhstl[10] = (unsigned long )256;
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)&ihValor_Cero;
    sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[11] = (         int  )0;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)szhPENDIENTE;
    sqlstm.sqhstl[12] = (unsigned long )10;
    sqlstm.sqhsts[12] = (         int  )0;
    sqlstm.sqindv[12] = (         short *)0;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
    sqlstm.sqhstv[13] = (unsigned char  *)&ihValor_Cero;
    sqlstm.sqhstl[13] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[13] = (         int  )0;
    sqlstm.sqindv[13] = (         short *)0;
    sqlstm.sqinds[13] = (         int  )0;
    sqlstm.sqharm[13] = (unsigned long )0;
    sqlstm.sqadto[13] = (unsigned short )0;
    sqlstm.sqtdso[13] = (unsigned short )0;
    sqlstm.sqhstv[14] = (unsigned char  *)szhCodTecnologia;
    sqlstm.sqhstl[14] = (unsigned long )9;
    sqlstm.sqhsts[14] = (         int  )0;
    sqlstm.sqindv[14] = (         short *)0;
    sqlstm.sqinds[14] = (         int  )0;
    sqlstm.sqharm[14] = (unsigned long )0;
    sqlstm.sqadto[14] = (unsigned short )0;
    sqlstm.sqtdso[14] = (unsigned short )0;
    sqlstm.sqhstv[15] = (unsigned char  *)szhNumImei;
    sqlstm.sqhstl[15] = (unsigned long )26;
    sqlstm.sqhsts[15] = (         int  )0;
    sqlstm.sqindv[15] = (         short *)0;
    sqlstm.sqinds[15] = (         int  )0;
    sqlstm.sqharm[15] = (unsigned long )0;
    sqlstm.sqadto[15] = (unsigned short )0;
    sqlstm.sqtdso[15] = (unsigned short )0;
    sqlstm.sqhstv[16] = (unsigned char  *)szhFiller;
    sqlstm.sqhstl[16] = (unsigned long )2;
    sqlstm.sqhsts[16] = (         int  )0;
    sqlstm.sqindv[16] = (         short *)0;
    sqlstm.sqinds[16] = (         int  )0;
    sqlstm.sqharm[16] = (unsigned long )0;
    sqlstm.sqadto[16] = (unsigned short )0;
    sqlstm.sqtdso[16] = (unsigned short )0;
    sqlstm.sqhstv[17] = (unsigned char  *)szhNumImei;
    sqlstm.sqhstl[17] = (unsigned long )26;
    sqlstm.sqhsts[17] = (         int  )0;
    sqlstm.sqindv[17] = (         short *)0;
    sqlstm.sqinds[17] = (         int  )0;
    sqlstm.sqharm[17] = (unsigned long )0;
    sqlstm.sqadto[17] = (unsigned short )0;
    sqlstm.sqtdso[17] = (unsigned short )0;
    sqlstm.sqhstv[18] = (unsigned char  *)szhNumImsi;
    sqlstm.sqhstl[18] = (unsigned long )51;
    sqlstm.sqhsts[18] = (         int  )0;
    sqlstm.sqindv[18] = (         short *)0;
    sqlstm.sqinds[18] = (         int  )0;
    sqlstm.sqharm[18] = (unsigned long )0;
    sqlstm.sqadto[18] = (unsigned short )0;
    sqlstm.sqtdso[18] = (unsigned short )0;
    sqlstm.sqhstv[19] = (unsigned char  *)szhFiller;
    sqlstm.sqhstl[19] = (unsigned long )2;
    sqlstm.sqhsts[19] = (         int  )0;
    sqlstm.sqindv[19] = (         short *)0;
    sqlstm.sqinds[19] = (         int  )0;
    sqlstm.sqharm[19] = (unsigned long )0;
    sqlstm.sqadto[19] = (unsigned short )0;
    sqlstm.sqtdso[19] = (unsigned short )0;
    sqlstm.sqhstv[20] = (unsigned char  *)szhNumImsi;
    sqlstm.sqhstl[20] = (unsigned long )51;
    sqlstm.sqhsts[20] = (         int  )0;
    sqlstm.sqindv[20] = (         short *)0;
    sqlstm.sqinds[20] = (         int  )0;
    sqlstm.sqharm[20] = (unsigned long )0;
    sqlstm.sqadto[20] = (unsigned short )0;
    sqlstm.sqtdso[20] = (unsigned short )0;
    sqlstm.sqhstv[21] = (unsigned char  *)szhNumSerie;
    sqlstm.sqhstl[21] = (unsigned long )26;
    sqlstm.sqhsts[21] = (         int  )0;
    sqlstm.sqindv[21] = (         short *)0;
    sqlstm.sqinds[21] = (         int  )0;
    sqlstm.sqharm[21] = (unsigned long )0;
    sqlstm.sqadto[21] = (unsigned short )0;
    sqlstm.sqtdso[21] = (unsigned short )0;
    sqlstm.sqhstv[22] = (unsigned char  *)szhFiller;
    sqlstm.sqhstl[22] = (unsigned long )2;
    sqlstm.sqhsts[22] = (         int  )0;
    sqlstm.sqindv[22] = (         short *)0;
    sqlstm.sqinds[22] = (         int  )0;
    sqlstm.sqharm[22] = (unsigned long )0;
    sqlstm.sqadto[22] = (unsigned short )0;
    sqlstm.sqtdso[22] = (unsigned short )0;
    sqlstm.sqhstv[23] = (unsigned char  *)szhNumSerie;
    sqlstm.sqhstl[23] = (unsigned long )26;
    sqlstm.sqhsts[23] = (         int  )0;
    sqlstm.sqindv[23] = (         short *)0;
    sqlstm.sqinds[23] = (         int  )0;
    sqlstm.sqharm[23] = (unsigned long )0;
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
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



				if( sqlca.sqlcode ) {
					ifnTrazaHilos( modulo,&pfLog, "INSERT INTO ICC_MOVIMIENTO -NO PLEXSYS- (Cliente:%ld) %s",
											LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );
					strcpy( szStsFin,"PND" );
					break;
				}
			}
			else /* Si es Plexsys*/
			{
				sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
				/* EXEC SQL
				SELECT ICC_SEQ_NUMMOV.NEXTVAL 
				INTO	 :lhNumSeqMov2
				FROM   DUAL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 52;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select ICC_SEQ_NUMMOV.nextval  into :b0  from DUAL ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )857;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSeqMov2;
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
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


				if( sqlca.sqlcode )  {
					ifnTrazaHilos( modulo,&pfLog, "SELECT 2 ICC_SEQ_NUMMOV.NEXTVAL (Cliente:%ld) %s",
											LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );
					strcpy( szStsFin,"PND" );
					break;
				}
				
				/* Inserta primer movimiento */
				sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
				/* EXEC SQL
				INSERT INTO ICC_MOVIMIENTO 
				       (NUM_MOVPOS   , NUM_MOVIMIENTO, NUM_ABONADO   , 
					     COD_ESTADO   , COD_MODULO    , NOM_USUARORA  , 
					     COD_CENTRAL  , NUM_CELULAR   , COD_ACTUACION , 
					     FEC_INGRESO  , NUM_SERIE     , TIP_TERMINAL  , 
					     COD_ACTABO   , COD_SERVICIOS , NUM_INTENTOS  ,    
					     DES_RESPUESTA, IND_BLOQUEO   , TIP_TECNOLOGIA,		
					     IMEI         , IMSI          ,	ICC			  ) 
				VALUES (:lhNumSeqMov2, :lhNumSeqMov1      ,	:lhNumAbonado,
					     :szhUno      , :szhModulo         ,  USER, 
					     :ihCodCentral, :lhNumCelularBeeper,  :ihCodActuacionCelular,
					     SYSDATE      , :szhNumSerieHex    ,  :szhTipTerminal,
					     :szhActAbo   , :szhServicios      ,  :ihValor_Cero,         
					     :szhPENDIENTE, :ihValor_Cero      ,  :szhCodTecnologia,
					     DECODE(:szhNumImei , :szhFiller, NULL, :szhNumImei ),
   				     DECODE(:szhNumImsi , :szhFiller, NULL, :szhNumImsi ),
					     DECODE(:szhNumSerie, :szhFiller, NULL, :szhNumSerie )); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 52;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into ICC_MOVIMIENTO (NUM_MOVPOS,NUM_MOVIMIENTO,NUM\
_ABONADO,COD_ESTADO,COD_MODULO,NOM_USUARORA,COD_CENTRAL,NUM_CELULAR,COD_ACTUAC\
ION,FEC_INGRESO,NUM_SERIE,TIP_TERMINAL,COD_ACTABO,COD_SERVICIOS,NUM_INTENTOS,D\
ES_RESPUESTA,IND_BLOQUEO,TIP_TECNOLOGIA,IMEI,IMSI,ICC) values (:b0,:b1,:b2,:b3\
,:b4,USER,:b5,:b6,:b7,SYSDATE,:b8,:b9,:b10,:b11,:b12,:b13,:b12,:b15,DECODE(:b1\
6,:b17,null ,:b16),DECODE(:b19,:b17,null ,:b19),DECODE(:b22,:b17,null ,:b22))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )876;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSeqMov2;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSeqMov1;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhNumAbonado;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhUno;
    sqlstm.sqhstl[3] = (unsigned long )2;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhModulo;
    sqlstm.sqhstl[4] = (unsigned long )3;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihCodCentral;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&lhNumCelularBeeper;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&ihCodActuacionCelular;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)szhNumSerieHex;
    sqlstm.sqhstl[8] = (unsigned long )9;
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)szhTipTerminal;
    sqlstm.sqhstl[9] = (unsigned long )2;
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)szhActAbo;
    sqlstm.sqhstl[10] = (unsigned long )3;
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)szhServicios;
    sqlstm.sqhstl[11] = (unsigned long )256;
    sqlstm.sqhsts[11] = (         int  )0;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)&ihValor_Cero;
    sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[12] = (         int  )0;
    sqlstm.sqindv[12] = (         short *)0;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
    sqlstm.sqhstv[13] = (unsigned char  *)szhPENDIENTE;
    sqlstm.sqhstl[13] = (unsigned long )10;
    sqlstm.sqhsts[13] = (         int  )0;
    sqlstm.sqindv[13] = (         short *)0;
    sqlstm.sqinds[13] = (         int  )0;
    sqlstm.sqharm[13] = (unsigned long )0;
    sqlstm.sqadto[13] = (unsigned short )0;
    sqlstm.sqtdso[13] = (unsigned short )0;
    sqlstm.sqhstv[14] = (unsigned char  *)&ihValor_Cero;
    sqlstm.sqhstl[14] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[14] = (         int  )0;
    sqlstm.sqindv[14] = (         short *)0;
    sqlstm.sqinds[14] = (         int  )0;
    sqlstm.sqharm[14] = (unsigned long )0;
    sqlstm.sqadto[14] = (unsigned short )0;
    sqlstm.sqtdso[14] = (unsigned short )0;
    sqlstm.sqhstv[15] = (unsigned char  *)szhCodTecnologia;
    sqlstm.sqhstl[15] = (unsigned long )9;
    sqlstm.sqhsts[15] = (         int  )0;
    sqlstm.sqindv[15] = (         short *)0;
    sqlstm.sqinds[15] = (         int  )0;
    sqlstm.sqharm[15] = (unsigned long )0;
    sqlstm.sqadto[15] = (unsigned short )0;
    sqlstm.sqtdso[15] = (unsigned short )0;
    sqlstm.sqhstv[16] = (unsigned char  *)szhNumImei;
    sqlstm.sqhstl[16] = (unsigned long )26;
    sqlstm.sqhsts[16] = (         int  )0;
    sqlstm.sqindv[16] = (         short *)0;
    sqlstm.sqinds[16] = (         int  )0;
    sqlstm.sqharm[16] = (unsigned long )0;
    sqlstm.sqadto[16] = (unsigned short )0;
    sqlstm.sqtdso[16] = (unsigned short )0;
    sqlstm.sqhstv[17] = (unsigned char  *)szhFiller;
    sqlstm.sqhstl[17] = (unsigned long )2;
    sqlstm.sqhsts[17] = (         int  )0;
    sqlstm.sqindv[17] = (         short *)0;
    sqlstm.sqinds[17] = (         int  )0;
    sqlstm.sqharm[17] = (unsigned long )0;
    sqlstm.sqadto[17] = (unsigned short )0;
    sqlstm.sqtdso[17] = (unsigned short )0;
    sqlstm.sqhstv[18] = (unsigned char  *)szhNumImei;
    sqlstm.sqhstl[18] = (unsigned long )26;
    sqlstm.sqhsts[18] = (         int  )0;
    sqlstm.sqindv[18] = (         short *)0;
    sqlstm.sqinds[18] = (         int  )0;
    sqlstm.sqharm[18] = (unsigned long )0;
    sqlstm.sqadto[18] = (unsigned short )0;
    sqlstm.sqtdso[18] = (unsigned short )0;
    sqlstm.sqhstv[19] = (unsigned char  *)szhNumImsi;
    sqlstm.sqhstl[19] = (unsigned long )51;
    sqlstm.sqhsts[19] = (         int  )0;
    sqlstm.sqindv[19] = (         short *)0;
    sqlstm.sqinds[19] = (         int  )0;
    sqlstm.sqharm[19] = (unsigned long )0;
    sqlstm.sqadto[19] = (unsigned short )0;
    sqlstm.sqtdso[19] = (unsigned short )0;
    sqlstm.sqhstv[20] = (unsigned char  *)szhFiller;
    sqlstm.sqhstl[20] = (unsigned long )2;
    sqlstm.sqhsts[20] = (         int  )0;
    sqlstm.sqindv[20] = (         short *)0;
    sqlstm.sqinds[20] = (         int  )0;
    sqlstm.sqharm[20] = (unsigned long )0;
    sqlstm.sqadto[20] = (unsigned short )0;
    sqlstm.sqtdso[20] = (unsigned short )0;
    sqlstm.sqhstv[21] = (unsigned char  *)szhNumImsi;
    sqlstm.sqhstl[21] = (unsigned long )51;
    sqlstm.sqhsts[21] = (         int  )0;
    sqlstm.sqindv[21] = (         short *)0;
    sqlstm.sqinds[21] = (         int  )0;
    sqlstm.sqharm[21] = (unsigned long )0;
    sqlstm.sqadto[21] = (unsigned short )0;
    sqlstm.sqtdso[21] = (unsigned short )0;
    sqlstm.sqhstv[22] = (unsigned char  *)szhNumSerie;
    sqlstm.sqhstl[22] = (unsigned long )26;
    sqlstm.sqhsts[22] = (         int  )0;
    sqlstm.sqindv[22] = (         short *)0;
    sqlstm.sqinds[22] = (         int  )0;
    sqlstm.sqharm[22] = (unsigned long )0;
    sqlstm.sqadto[22] = (unsigned short )0;
    sqlstm.sqtdso[22] = (unsigned short )0;
    sqlstm.sqhstv[23] = (unsigned char  *)szhFiller;
    sqlstm.sqhstl[23] = (unsigned long )2;
    sqlstm.sqhsts[23] = (         int  )0;
    sqlstm.sqindv[23] = (         short *)0;
    sqlstm.sqinds[23] = (         int  )0;
    sqlstm.sqharm[23] = (unsigned long )0;
    sqlstm.sqadto[23] = (unsigned short )0;
    sqlstm.sqtdso[23] = (unsigned short )0;
    sqlstm.sqhstv[24] = (unsigned char  *)szhNumSerie;
    sqlstm.sqhstl[24] = (unsigned long )26;
    sqlstm.sqhsts[24] = (         int  )0;
    sqlstm.sqindv[24] = (         short *)0;
    sqlstm.sqinds[24] = (         int  )0;
    sqlstm.sqharm[24] = (unsigned long )0;
    sqlstm.sqadto[24] = (unsigned short )0;
    sqlstm.sqtdso[24] = (unsigned short )0;
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
    sqlstm.sqphss = sqlstm.sqhsts;
    sqlstm.sqpind = sqlstm.sqindv;
    sqlstm.sqpins = sqlstm.sqinds;
    sqlstm.sqparm = sqlstm.sqharm;
    sqlstm.sqparc = sqlstm.sqharc;
    sqlstm.sqpadto = sqlstm.sqadto;
    sqlstm.sqptdso = sqlstm.sqtdso;
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


				
				if (sqlca.sqlcode) {
					ifnTrazaHilos( modulo,&pfLog, "INSERT 1 INTO ICC_MOVIMIENTO -PLEXSYS- (Cliente:%ld) %s",
											LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );
					strcpy( szStsFin, "PND" );
					break;
				}
				
				/*Inserta segundo movimiento*/
				sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
				/* EXEC SQL
				INSERT INTO ICC_MOVIMIENTO 
				       (NUM_MOVANT   ,	NUM_MOVIMIENTO,  NUM_ABONADO, 
					     COD_ESTADO   ,  COD_MODULO    ,  NOM_USUARORA, 
					     COD_CENTRAL  ,  NUM_CELULAR   ,  COD_ACTUACION, 
					     FEC_INGRESO  ,  NUM_SERIE     ,  TIP_TERMINAL, 
					     COD_ACTABO   ,  COD_SERVICIOS ,  NUM_INTENTOS,    
					     DES_RESPUESTA, 	IND_BLOQUEO   ,  TIP_TECNOLOGIA,		
					     IMEI         ,  IMSI          ,  ICC		) 
				VALUES (:lhNumSeqMov1    ,	 :lhNumSeqMov2    , :lhNumAbonado,
					     :szhUno          ,  :szhModulo       , USER, 
					     :ihCodCentralPlex,  :lhNumCelularPlex, :ihCodActuacionCelular, 
					     SYSDATE          ,  :szhNumSerieHex  , :szhTipTerminal,  
					     :szhActAbo       ,  :szhServicios    , :ihValor_Cero,         
					     :szhPENDIENTE    ,  :ihValor_Cero    , :szhCodTecnologia,
					     DECODE(:szhNumImei , :szhFiller, NULL, :szhNumImei ),
   				     DECODE(:szhNumImsi , :szhFiller, NULL, :szhNumImsi ),
					     DECODE(:szhNumSerie, :szhFiller, NULL, :szhNumSerie )); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 52;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into ICC_MOVIMIENTO (NUM_MOVANT,NUM_MOVIMIENTO,NUM\
_ABONADO,COD_ESTADO,COD_MODULO,NOM_USUARORA,COD_CENTRAL,NUM_CELULAR,COD_ACTUAC\
ION,FEC_INGRESO,NUM_SERIE,TIP_TERMINAL,COD_ACTABO,COD_SERVICIOS,NUM_INTENTOS,D\
ES_RESPUESTA,IND_BLOQUEO,TIP_TECNOLOGIA,IMEI,IMSI,ICC) values (:b0,:b1,:b2,:b3\
,:b4,USER,:b5,:b6,:b7,SYSDATE,:b8,:b9,:b10,:b11,:b12,:b13,:b12,:b15,DECODE(:b1\
6,:b17,null ,:b16),DECODE(:b19,:b17,null ,:b19),DECODE(:b22,:b17,null ,:b22))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )991;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSeqMov1;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSeqMov2;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhNumAbonado;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhUno;
    sqlstm.sqhstl[3] = (unsigned long )2;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhModulo;
    sqlstm.sqhstl[4] = (unsigned long )3;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihCodCentralPlex;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&lhNumCelularPlex;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&ihCodActuacionCelular;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)szhNumSerieHex;
    sqlstm.sqhstl[8] = (unsigned long )9;
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)szhTipTerminal;
    sqlstm.sqhstl[9] = (unsigned long )2;
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)szhActAbo;
    sqlstm.sqhstl[10] = (unsigned long )3;
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)szhServicios;
    sqlstm.sqhstl[11] = (unsigned long )256;
    sqlstm.sqhsts[11] = (         int  )0;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)&ihValor_Cero;
    sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[12] = (         int  )0;
    sqlstm.sqindv[12] = (         short *)0;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
    sqlstm.sqhstv[13] = (unsigned char  *)szhPENDIENTE;
    sqlstm.sqhstl[13] = (unsigned long )10;
    sqlstm.sqhsts[13] = (         int  )0;
    sqlstm.sqindv[13] = (         short *)0;
    sqlstm.sqinds[13] = (         int  )0;
    sqlstm.sqharm[13] = (unsigned long )0;
    sqlstm.sqadto[13] = (unsigned short )0;
    sqlstm.sqtdso[13] = (unsigned short )0;
    sqlstm.sqhstv[14] = (unsigned char  *)&ihValor_Cero;
    sqlstm.sqhstl[14] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[14] = (         int  )0;
    sqlstm.sqindv[14] = (         short *)0;
    sqlstm.sqinds[14] = (         int  )0;
    sqlstm.sqharm[14] = (unsigned long )0;
    sqlstm.sqadto[14] = (unsigned short )0;
    sqlstm.sqtdso[14] = (unsigned short )0;
    sqlstm.sqhstv[15] = (unsigned char  *)szhCodTecnologia;
    sqlstm.sqhstl[15] = (unsigned long )9;
    sqlstm.sqhsts[15] = (         int  )0;
    sqlstm.sqindv[15] = (         short *)0;
    sqlstm.sqinds[15] = (         int  )0;
    sqlstm.sqharm[15] = (unsigned long )0;
    sqlstm.sqadto[15] = (unsigned short )0;
    sqlstm.sqtdso[15] = (unsigned short )0;
    sqlstm.sqhstv[16] = (unsigned char  *)szhNumImei;
    sqlstm.sqhstl[16] = (unsigned long )26;
    sqlstm.sqhsts[16] = (         int  )0;
    sqlstm.sqindv[16] = (         short *)0;
    sqlstm.sqinds[16] = (         int  )0;
    sqlstm.sqharm[16] = (unsigned long )0;
    sqlstm.sqadto[16] = (unsigned short )0;
    sqlstm.sqtdso[16] = (unsigned short )0;
    sqlstm.sqhstv[17] = (unsigned char  *)szhFiller;
    sqlstm.sqhstl[17] = (unsigned long )2;
    sqlstm.sqhsts[17] = (         int  )0;
    sqlstm.sqindv[17] = (         short *)0;
    sqlstm.sqinds[17] = (         int  )0;
    sqlstm.sqharm[17] = (unsigned long )0;
    sqlstm.sqadto[17] = (unsigned short )0;
    sqlstm.sqtdso[17] = (unsigned short )0;
    sqlstm.sqhstv[18] = (unsigned char  *)szhNumImei;
    sqlstm.sqhstl[18] = (unsigned long )26;
    sqlstm.sqhsts[18] = (         int  )0;
    sqlstm.sqindv[18] = (         short *)0;
    sqlstm.sqinds[18] = (         int  )0;
    sqlstm.sqharm[18] = (unsigned long )0;
    sqlstm.sqadto[18] = (unsigned short )0;
    sqlstm.sqtdso[18] = (unsigned short )0;
    sqlstm.sqhstv[19] = (unsigned char  *)szhNumImsi;
    sqlstm.sqhstl[19] = (unsigned long )51;
    sqlstm.sqhsts[19] = (         int  )0;
    sqlstm.sqindv[19] = (         short *)0;
    sqlstm.sqinds[19] = (         int  )0;
    sqlstm.sqharm[19] = (unsigned long )0;
    sqlstm.sqadto[19] = (unsigned short )0;
    sqlstm.sqtdso[19] = (unsigned short )0;
    sqlstm.sqhstv[20] = (unsigned char  *)szhFiller;
    sqlstm.sqhstl[20] = (unsigned long )2;
    sqlstm.sqhsts[20] = (         int  )0;
    sqlstm.sqindv[20] = (         short *)0;
    sqlstm.sqinds[20] = (         int  )0;
    sqlstm.sqharm[20] = (unsigned long )0;
    sqlstm.sqadto[20] = (unsigned short )0;
    sqlstm.sqtdso[20] = (unsigned short )0;
    sqlstm.sqhstv[21] = (unsigned char  *)szhNumImsi;
    sqlstm.sqhstl[21] = (unsigned long )51;
    sqlstm.sqhsts[21] = (         int  )0;
    sqlstm.sqindv[21] = (         short *)0;
    sqlstm.sqinds[21] = (         int  )0;
    sqlstm.sqharm[21] = (unsigned long )0;
    sqlstm.sqadto[21] = (unsigned short )0;
    sqlstm.sqtdso[21] = (unsigned short )0;
    sqlstm.sqhstv[22] = (unsigned char  *)szhNumSerie;
    sqlstm.sqhstl[22] = (unsigned long )26;
    sqlstm.sqhsts[22] = (         int  )0;
    sqlstm.sqindv[22] = (         short *)0;
    sqlstm.sqinds[22] = (         int  )0;
    sqlstm.sqharm[22] = (unsigned long )0;
    sqlstm.sqadto[22] = (unsigned short )0;
    sqlstm.sqtdso[22] = (unsigned short )0;
    sqlstm.sqhstv[23] = (unsigned char  *)szhFiller;
    sqlstm.sqhstl[23] = (unsigned long )2;
    sqlstm.sqhsts[23] = (         int  )0;
    sqlstm.sqindv[23] = (         short *)0;
    sqlstm.sqinds[23] = (         int  )0;
    sqlstm.sqharm[23] = (unsigned long )0;
    sqlstm.sqadto[23] = (unsigned short )0;
    sqlstm.sqtdso[23] = (unsigned short )0;
    sqlstm.sqhstv[24] = (unsigned char  *)szhNumSerie;
    sqlstm.sqhstl[24] = (unsigned long )26;
    sqlstm.sqhsts[24] = (         int  )0;
    sqlstm.sqindv[24] = (         short *)0;
    sqlstm.sqinds[24] = (         int  )0;
    sqlstm.sqharm[24] = (unsigned long )0;
    sqlstm.sqadto[24] = (unsigned short )0;
    sqlstm.sqtdso[24] = (unsigned short )0;
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
    sqlstm.sqphss = sqlstm.sqhsts;
    sqlstm.sqpind = sqlstm.sqindv;
    sqlstm.sqpins = sqlstm.sqinds;
    sqlstm.sqparm = sqlstm.sqharm;
    sqlstm.sqparc = sqlstm.sqharc;
    sqlstm.sqpadto = sqlstm.sqadto;
    sqlstm.sqptdso = sqlstm.sqtdso;
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


				
				if (sqlca.sqlcode)  {
					ifnTrazaHilos( modulo,&pfLog, "INSERT 2 INTO ICC_MOVIMIENTO -PLEXSYS- (Cliente:%ld) %s",
											LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );
					strcpy(szStsFin,"PND");
					break;
				}
			} /* Fin Plexsys */
        
			sprintf( szhComando,"m 9%ld,"
								"SERVICE=PPS,"
								"STATE=DISABLED,"
								"USER=INFOHIA|D 9%ld,"
								"SERVICE=PPS,"
								"USER=INFOHIA",
								lhNumCelularBeeper, lhNumCelularBeeper);    
			
			if( ihCodUso == ihCodControlada || ihCodUso == ihCodCtaSeguraCtc )  {     
				sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
				/* EXEC SQL
				INSERT INTO GA_MOVCCONTROL 
				       (NUM_LINEA    ,  
				        FEC_INICIO   ,  
				        COD_PLANTARIF,  
				        IND_TIPMOV   ,  
				        IND_PROCESADO,  
				        CMD_COMVERSE ) 
				VALUES (:lhNumCelularBeeper,  
				        SYSDATE         ,  
				        :szhCodPlanTarif,
					     :ihValor_Dos    ,
					     :ihValor_Cero   ,
					     :szhComando    ); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 52;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into GA_MOVCCONTROL (NUM_LINEA,FEC_INICIO,COD_PLAN\
TARIF,IND_TIPMOV,IND_PROCESADO,CMD_COMVERSE) values (:b0,SYSDATE,:b1,:b2,:b3,:\
b4)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1106;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumCelularBeeper;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
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
    sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_Dos;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_Cero;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhComando;
    sqlstm.sqhstl[4] = (unsigned long )128;
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
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


				
				if (sqlca.sqlcode) {
					ifnTrazaHilos( modulo,&pfLog, "INSERT INTO GA_MOVCCONTROL (Cliente:%ld|NumLinea:%ld) %s",
											LOG00, lhCodCliente, lhNumCelularBeeper, sqlca.sqlerrm.sqlerrmc );
					strcpy( szStsFin,"PND" );
					break;
				}
			} /* if( ihCodUso == ihCodControlada || ihCodUso == ihCodCtaSeguraCtc ) */
            
			/* Voy a insertar la Baja de STM (en caso de serlo) en GA_CTC_MOVIMIENTOS */
			if ( ihIndSupertel == 1 ) /* si es supertelefono */
			{
				for( iAux = 0; iAux < strlen( szhNumTeleFija ); iAux++ )   
					if( szhNumTeleFija[iAux] != 0 ) break; /* elimina ceros a la izquierda */
				
				strcpy( szhAuxTeleFija, &szhNumTeleFija[iAux] );
				
				if( strlen( szhAuxTeleFija ) > 10 ) /* Valor mas largo que el campo que lo contendra */
				{
					ifnTrazaHilos( modulo,&pfLog, "Num Telefija (%s) > 10 caracteres ",LOG01,szhNumTeleFija);
					strcpy(szStsFin,"ERRDT");
					break; 
				}
				
				sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
				/* EXEC SQL
				INSERT INTO GA_CTC_MOVIMIENTOS 
				       (NUM_REDFIJA   ,  
					     FEC_MOVIMIENTO, 
					     TIP_MOVIMIENTO, 
					     NUM_CELULAR1  ) 
				VALUES (:szhAuxTeleFija    ,
					     SYSDATE            ,
					     :ihValor_Uno       ,		/o BAJAo/
					     :lhNumCelularBeeper); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 52;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into GA_CTC_MOVIMIENTOS (NUM_REDFIJA,FEC_MOVIMIENT\
O,TIP_MOVIMIENTO,NUM_CELULAR1) values (:b0,SYSDATE,:b1,:b2)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1141;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhAuxTeleFija;
    sqlstm.sqhstl[0] = (unsigned long )16;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihValor_Uno;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhNumCelularBeeper;
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
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


				
				if (sqlca.sqlcode)  {
					ifnTrazaHilos( modulo,&pfLog, "INSERT INTO GA_CTC_MOVIMIENTOS (Cliente:%ld|Celular1:%ld) %s",
											LOG00, lhCodCliente, lhNumCelularBeeper, sqlca.sqlerrm.sqlerrmc );
					strcpy(szStsFin,"PND");
					break; 
				}
			}

         iRet = ifnVerificaExisteFyF(&pfLog,  lhCodCliente, lhNumAbonado, lhNumCelularBeeper, CXX );
	      if( iRet < 0 )  {
				strcpy( szStsFin, "PND" );
				break;
	        }
	        else if( iRet == 1 ) /* tiene plan familiar */
	        {
				/* debemos desactivar el servicio FyF, del segundo abonado */
				if( !bfnDesactivarServSuplFriendsAbo(&pfLog, lhCodCliente, lhNumAbonado, lhNumCelularBeeper, ihCodCentral, 
														szhNumSerie, szhTipTerminal, ihProducto, szhNumMin, CXX ) )
				{
					ifnTrazaHilos( modulo,&pfLog, "Cliente : %ld - Abonado : %ld. bfnDesactivarServSuplFriendsAbo.", LOG00, lhCodCliente, lhNumAbonado );
					{
						strcpy( szStsFin, "PND" );
						break;
					}	
				}					
			} /* if( iRet < 0 ) */	

			iAboCeluGlobal ++;
		}
		else if( ihCodModventa == iEnComodato || ihCodModventa == iEnArriendo ) /* esto es para beepers comodato */
		{
			/* pmarin_19.01.01, solo se hace si es beepeer */
			sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
			/* EXEC SQL
			SELECT COD_ESTADO
			INTO	 :ihCodEstado
			FROM	 AL_SERIES
			WHERE	 NUM_SERIE = :szhNumSerie; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 52;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select COD_ESTADO into :b0  from AL_SERIES where NUM_SERIE\
=:b1";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1168;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihCodEstado;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhNumSerie;
   sqlstm.sqhstl[1] = (unsigned long )26;
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
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


			if( sqlca.sqlcode == SQLNOTFOUND ) 	{
				ifnTrazaHilos( modulo,&pfLog, "NO EXISTE SERIE EN AL_SERIES (Cliente:%ld):(Serie:%s)",LOG00,lhCodCliente,szhNumSerie);
				strcpy(szStsFin,"NOSER");
				break;    
			}
			if( sqlca.sqlcode )  {
				ifnTrazaHilos( modulo,&pfLog, "SELECT COD_ESTADO DE AL_SERIE (Cliente:%ld) %s", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );
				strcpy( szStsFin, "PND" );
				break;    
			}
			
			if( ihCodEstado != iEnAlmacen )  {
				ifnTrazaHilos( modulo,&pfLog, "Equipo No esta en Almacen (cliente:%ld|abonado:%ld|serie:%s)",
										LOG01, lhCodCliente, lhNumAbonado, szhNumSerie );
				strcpy(szStsFin,"ENOAL");
				break;
			}
		} /* else if( ihCodModventa == iEnComodato || ihCodModventa == iEnArriendo ) */

		
		if (strcmp(szhInd_SerTecnico,"S")==0) {
			ifnTrazaHilos( modulo,&pfLog, "Verifica Equipo en Serv. Tecnico",LOG03);
			/* se verifica si el equipo esta en servicio tecnico */
			if ( ihIndDisp == iEnServTecnico ) 	{
				ifnTrazaHilos( modulo,&pfLog, "Equipo esta en Servicio Tecnico (cliente:%ld|abonado:%ld|celular:%ld)",
									LOG01, lhCodCliente, lhNumAbonado, lhNumCelularBeeper );
				strcpy( szStsFin, "SVTEC" );
				break;
			}
		}

		sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
		/* EXEC SQL  
		DELETE FROM GA_FINCICLO 
		WHERE	 NUM_ABONADO = :lhNumAbonado; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 52;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "delete  from GA_FINCICLO  where NUM_ABONADO=:b0";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1191;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&lhNumAbonado;
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
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


		
		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{
			ifnTrazaHilos( modulo,&pfLog, "DELETE GA_FINCICLO (Cliente:%ld|Abonado:%ld) %s", LOG00, lhCodCliente, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
			strcpy( szStsFin,"PND" );
			break;
		}

		if( ihProducto == ihCodProdBeeper )		{
			/*  Modifica GA_ABOBEEP y GE_CLIENTES */
			sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
			/* EXEC SQL
			UPDATE GA_ABOBEEP  SET		
			       COD_SITUACION	= :szhBAP, 
					 FEC_BAJA      = TO_DATE( :szhFecSysdate, :szhDDMMYYYYHH24MISS ), 
					 FEC_ULTMOD    = TO_DATE( :szhFecSysdate, :szhDDMMYYYYHH24MISS ), 
					 COD_CAUSABAJA = :szhCodCausaBajaBeeper
			WHERE  NUM_ABONADO	= :lhNumAbonado ; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 52;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update GA_ABOBEEP  set COD_SITUACION=:b0,FEC_BAJA=TO_DATE(\
:b1,:b2),FEC_ULTMOD=TO_DATE(:b1,:b2),COD_CAUSABAJA=:b5 where NUM_ABONADO=:b6";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1210;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhBAP;
   sqlstm.sqhstl[0] = (unsigned long )4;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhFecSysdate;
   sqlstm.sqhstl[1] = (unsigned long )20;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhDDMMYYYYHH24MISS;
   sqlstm.sqhstl[2] = (unsigned long )22;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhFecSysdate;
   sqlstm.sqhstl[3] = (unsigned long )20;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)szhDDMMYYYYHH24MISS;
   sqlstm.sqhstl[4] = (unsigned long )22;
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhCodCausaBajaBeeper;
   sqlstm.sqhstl[5] = (unsigned long )3;
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)&lhNumAbonado;
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
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



			if( sqlca.sqlcode ) 	{
				ifnTrazaHilos( modulo,&pfLog, "UPDATE GA_ABOBEEP (Cliente:%ld|Abonado:%ld) %s",
										LOG00,lhCodCliente,lhNumAbonado,sqlca.sqlerrm.sqlerrmc);
				strcpy(szStsFin,"PND");
				break;
			}

			sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
			/* EXEC SQL
			UPDATE GE_CLIENTES SET		
			      NUM_ABOBEEP	  = NUM_ABOBEEP - :ihValor_Uno,
					FEC_BAJA      = TO_DATE( :szhFecSysdate, :szhDDMMYYYYHH24MISS ), 
					IND_SITUACION = :szhBA
			WHERE	COD_CLIENTE	  = :lhCodCliente; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 52;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update GE_CLIENTES  set NUM_ABOBEEP=(NUM_ABOBEEP-:b0),FEC_\
BAJA=TO_DATE(:b1,:b2),IND_SITUACION=:b3 where COD_CLIENTE=:b4";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1253;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_Uno;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhFecSysdate;
   sqlstm.sqhstl[1] = (unsigned long )20;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhDDMMYYYYHH24MISS;
   sqlstm.sqhstl[2] = (unsigned long )22;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhBA;
   sqlstm.sqhstl[3] = (unsigned long )3;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&lhCodCliente;
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
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



			if (sqlca.sqlcode) {
				ifnTrazaHilos( modulo,&pfLog, "UPDATE 2 GE_CLIENTES (Cliente:%ld) %s", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );
				strcpy(szStsFin,"PND");
				break;
			}
			
			sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
			/* EXEC SQL
			SELECT COD_USO
			INTO   :ihCodUso2
			FROM   GA_BEEPNUM_USO
			WHERE  :lhNumCelularBeeper BETWEEN NUM_DESDE AND NUM_HASTA ; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 52;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select COD_USO into :b0  from GA_BEEPNUM_USO where :b1 bet\
ween NUM_DESDE and NUM_HASTA";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1288;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihCodUso2;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&lhNumCelularBeeper;
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
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


			
			if( sqlca.sqlcode ) 	{
				ifnTrazaHilos( modulo,&pfLog, "SELECT FROM GA_BEEPNUM_USO (Cliente:%ld|Beeper:%ld) %s",
										LOG00, lhCodCliente, lhNumCelularBeeper, sqlca.sqlerrm.sqlerrmc );
				strcpy(szStsFin,"PND");
				break;
			}

         ihVeces = 0;

			sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
			/* EXEC SQL
			SELECT COUNT(*)
			INTO	 :ihVeces
			FROM	 GA_BEEPNUM_REUTIL
			WHERE	 NUM_BEEPER = :lhNumCelularBeeper; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 52;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select count(*)  into :b0  from GA_BEEPNUM_REUTIL where NU\
M_BEEPER=:b1";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1311;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihVeces;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&lhNumCelularBeeper;
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
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


			
			if( sqlca.sqlcode )	{
				ifnTrazaHilos( modulo,&pfLog, "SELECT COUNT FROM GA_BEEPNUM_REUTIL (Cliente:%ld|Beeper:%ld) %s",
										LOG00, lhCodCliente, lhNumCelularBeeper, sqlca.sqlerrm.sqlerrmc );
				strcpy(szStsFin,"PND");
				break;

			} else {
				if (ihVeces != 0)	{
					ifnTrazaHilos( modulo,&pfLog, "EL BEEPER YA SE ENCUENTRA EN GA_BEEPNUM_REUTIL (Cliente:%ld|Beeper:%ld) %s",
											LOG02, lhCodCliente, lhNumCelularBeeper, sqlca.sqlerrm.sqlerrmc );

				} else {
					
					sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
					/* EXEC SQL
					INSERT INTO GA_BEEPNUM_REUTIL  
					       (NUM_BEEPER, COD_PRODUCTO, COD_CENTRAL, COD_USO, FEC_BAJA)
					VALUES (:lhNumCelularBeeper, :ihValor_Dos, :ihCodCentral, :ihCodUso2, SYSDATE ); */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 52;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "insert into GA_BEEPNUM_REUTIL (NUM_BEEPER,COD_PRODUCTO,C\
OD_CENTRAL,COD_USO,FEC_BAJA) values (:b0,:b1,:b2,:b3,SYSDATE)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )1334;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&lhNumCelularBeeper;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)&ihValor_Dos;
     sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)&ihCodCentral;
     sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[2] = (         int  )0;
     sqlstm.sqindv[2] = (         short *)0;
     sqlstm.sqinds[2] = (         int  )0;
     sqlstm.sqharm[2] = (unsigned long )0;
     sqlstm.sqadto[2] = (unsigned short )0;
     sqlstm.sqtdso[2] = (unsigned short )0;
     sqlstm.sqhstv[3] = (unsigned char  *)&ihCodUso2;
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
     sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


					
					if (sqlca.sqlcode) {
						ifnTrazaHilos( modulo,&pfLog, "INSERT INTO GA_BEEPNUM_REUTIL (Cliente:%ld|Beeper:%ld) %s",
												LOG00, lhCodCliente, lhNumCelularBeeper, sqlca.sqlerrm.sqlerrmc );
						strcpy(szStsFin,"PND");
						break;
					}
				}
			}

			/* Inserta en ICG_MOVIMIENTOS */
			sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
			/* EXEC SQL    
			SELECT TS,       ID,       CC,        TP,        PRO,       VEL,       FRE, 
					 COB,      NOM,      GM1,       GM2,       GM3,       GM4,       GM5, 
					 RUT,      STA,      MARP,      MODP,      NSER,      TCUE,      EMPR
			INTO   :szhTs,   :lhId,    :lhCc,     :szhTp,    :szhPro,   :szhVel,   :ihFre,
					 :szhCob,  :szhNom,  :szhGm1,   :szhGm2,   :szhGm3,   :szhGm4,   :szhGm5,
					 :szhRut,  :szhSta,  :szhMarp,  :szhModp,  :szhNser,  :szhTcue,  :szhEmp
			FROM	 GA_SUSCBEEP 
			WHERE	 NUM_ABONADO = :lhNumAbonado; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 52;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select TS ,ID ,CC ,TP ,PRO ,VEL ,FRE ,COB ,NOM ,GM1 ,GM2 ,\
GM3 ,GM4 ,GM5 ,RUT ,STA ,MARP ,MODP ,NSER ,TCUE ,EMPR into :b0,:b1,:b2,:b3,:b4\
,:b5,:b6,:b7,:b8,:b9,:b10,:b11,:b12,:b13,:b14,:b15,:b16,:b17,:b18,:b19,:b20  f\
rom GA_SUSCBEEP where NUM_ABONADO=:b21";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1365;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhTs;
   sqlstm.sqhstl[0] = (unsigned long )2;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&lhId;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&lhCc;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhTp;
   sqlstm.sqhstl[3] = (unsigned long )2;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)szhPro;
   sqlstm.sqhstl[4] = (unsigned long )3;
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhVel;
   sqlstm.sqhstl[5] = (unsigned long )5;
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)&ihFre;
   sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)szhCob;
   sqlstm.sqhstl[7] = (unsigned long )4;
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)szhNom;
   sqlstm.sqhstl[8] = (unsigned long )51;
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)szhGm1;
   sqlstm.sqhstl[9] = (unsigned long )8;
   sqlstm.sqhsts[9] = (         int  )0;
   sqlstm.sqindv[9] = (         short *)0;
   sqlstm.sqinds[9] = (         int  )0;
   sqlstm.sqharm[9] = (unsigned long )0;
   sqlstm.sqadto[9] = (unsigned short )0;
   sqlstm.sqtdso[9] = (unsigned short )0;
   sqlstm.sqhstv[10] = (unsigned char  *)szhGm2;
   sqlstm.sqhstl[10] = (unsigned long )8;
   sqlstm.sqhsts[10] = (         int  )0;
   sqlstm.sqindv[10] = (         short *)0;
   sqlstm.sqinds[10] = (         int  )0;
   sqlstm.sqharm[10] = (unsigned long )0;
   sqlstm.sqadto[10] = (unsigned short )0;
   sqlstm.sqtdso[10] = (unsigned short )0;
   sqlstm.sqhstv[11] = (unsigned char  *)szhGm3;
   sqlstm.sqhstl[11] = (unsigned long )8;
   sqlstm.sqhsts[11] = (         int  )0;
   sqlstm.sqindv[11] = (         short *)0;
   sqlstm.sqinds[11] = (         int  )0;
   sqlstm.sqharm[11] = (unsigned long )0;
   sqlstm.sqadto[11] = (unsigned short )0;
   sqlstm.sqtdso[11] = (unsigned short )0;
   sqlstm.sqhstv[12] = (unsigned char  *)szhGm4;
   sqlstm.sqhstl[12] = (unsigned long )8;
   sqlstm.sqhsts[12] = (         int  )0;
   sqlstm.sqindv[12] = (         short *)0;
   sqlstm.sqinds[12] = (         int  )0;
   sqlstm.sqharm[12] = (unsigned long )0;
   sqlstm.sqadto[12] = (unsigned short )0;
   sqlstm.sqtdso[12] = (unsigned short )0;
   sqlstm.sqhstv[13] = (unsigned char  *)szhGm5;
   sqlstm.sqhstl[13] = (unsigned long )8;
   sqlstm.sqhsts[13] = (         int  )0;
   sqlstm.sqindv[13] = (         short *)0;
   sqlstm.sqinds[13] = (         int  )0;
   sqlstm.sqharm[13] = (unsigned long )0;
   sqlstm.sqadto[13] = (unsigned short )0;
   sqlstm.sqtdso[13] = (unsigned short )0;
   sqlstm.sqhstv[14] = (unsigned char  *)szhRut;
   sqlstm.sqhstl[14] = (unsigned long )21;
   sqlstm.sqhsts[14] = (         int  )0;
   sqlstm.sqindv[14] = (         short *)0;
   sqlstm.sqinds[14] = (         int  )0;
   sqlstm.sqharm[14] = (unsigned long )0;
   sqlstm.sqadto[14] = (unsigned short )0;
   sqlstm.sqtdso[14] = (unsigned short )0;
   sqlstm.sqhstv[15] = (unsigned char  *)szhSta;
   sqlstm.sqhstl[15] = (unsigned long )2;
   sqlstm.sqhsts[15] = (         int  )0;
   sqlstm.sqindv[15] = (         short *)0;
   sqlstm.sqinds[15] = (         int  )0;
   sqlstm.sqharm[15] = (unsigned long )0;
   sqlstm.sqadto[15] = (unsigned short )0;
   sqlstm.sqtdso[15] = (unsigned short )0;
   sqlstm.sqhstv[16] = (unsigned char  *)szhMarp;
   sqlstm.sqhstl[16] = (unsigned long )21;
   sqlstm.sqhsts[16] = (         int  )0;
   sqlstm.sqindv[16] = (         short *)0;
   sqlstm.sqinds[16] = (         int  )0;
   sqlstm.sqharm[16] = (unsigned long )0;
   sqlstm.sqadto[16] = (unsigned short )0;
   sqlstm.sqtdso[16] = (unsigned short )0;
   sqlstm.sqhstv[17] = (unsigned char  *)szhModp;
   sqlstm.sqhstl[17] = (unsigned long )51;
   sqlstm.sqhsts[17] = (         int  )0;
   sqlstm.sqindv[17] = (         short *)0;
   sqlstm.sqinds[17] = (         int  )0;
   sqlstm.sqharm[17] = (unsigned long )0;
   sqlstm.sqadto[17] = (unsigned short )0;
   sqlstm.sqtdso[17] = (unsigned short )0;
   sqlstm.sqhstv[18] = (unsigned char  *)szhNser;
   sqlstm.sqhstl[18] = (unsigned long )31;
   sqlstm.sqhsts[18] = (         int  )0;
   sqlstm.sqindv[18] = (         short *)0;
   sqlstm.sqinds[18] = (         int  )0;
   sqlstm.sqharm[18] = (unsigned long )0;
   sqlstm.sqadto[18] = (unsigned short )0;
   sqlstm.sqtdso[18] = (unsigned short )0;
   sqlstm.sqhstv[19] = (unsigned char  *)szhTcue;
   sqlstm.sqhstl[19] = (unsigned long )2;
   sqlstm.sqhsts[19] = (         int  )0;
   sqlstm.sqindv[19] = (         short *)0;
   sqlstm.sqinds[19] = (         int  )0;
   sqlstm.sqharm[19] = (unsigned long )0;
   sqlstm.sqadto[19] = (unsigned short )0;
   sqlstm.sqtdso[19] = (unsigned short )0;
   sqlstm.sqhstv[20] = (unsigned char  *)szhEmp;
   sqlstm.sqhstl[20] = (unsigned long )51;
   sqlstm.sqhsts[20] = (         int  )0;
   sqlstm.sqindv[20] = (         short *)0;
   sqlstm.sqinds[20] = (         int  )0;
   sqlstm.sqharm[20] = (unsigned long )0;
   sqlstm.sqadto[20] = (unsigned short )0;
   sqlstm.sqtdso[20] = (unsigned short )0;
   sqlstm.sqhstv[21] = (unsigned char  *)&lhNumAbonado;
   sqlstm.sqhstl[21] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[21] = (         int  )0;
   sqlstm.sqindv[21] = (         short *)0;
   sqlstm.sqinds[21] = (         int  )0;
   sqlstm.sqharm[21] = (unsigned long )0;
   sqlstm.sqadto[21] = (unsigned short )0;
   sqlstm.sqtdso[21] = (unsigned short )0;
   sqlstm.sqphsv = sqlstm.sqhstv;
   sqlstm.sqphsl = sqlstm.sqhstl;
   sqlstm.sqphss = sqlstm.sqhsts;
   sqlstm.sqpind = sqlstm.sqindv;
   sqlstm.sqpins = sqlstm.sqinds;
   sqlstm.sqparm = sqlstm.sqharm;
   sqlstm.sqparc = sqlstm.sqharc;
   sqlstm.sqpadto = sqlstm.sqadto;
   sqlstm.sqptdso = sqlstm.sqtdso;
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


			
			if (sqlca.sqlcode)  {
				ifnTrazaHilos( modulo,&pfLog, "SELECT FROM GA_SUSCBEEP (Cliente:%ld|Abonado:%ld) %s",
										LOG00, lhCodCliente, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
				strcpy(szStsFin,"PND");
				break;
			}
			
			sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
			/* EXEC SQL
			SELECT ICC_SEQ_NUMMOV.NEXTVAL 
			INTO	 :lhNumSeqMov1
			FROM	 DUAL; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 52;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select ICC_SEQ_NUMMOV.nextval  into :b0  from DUAL ";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1468;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSeqMov1;
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
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


			if( sqlca.sqlcode )  {
				ifnTrazaHilos( modulo,&pfLog, "SELECT ICC_SEQ_NUMMOV.NEXTVAL (Cliente:%ld) %s",
										LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );
				strcpy(szStsFin,"PND");
				break;
			}

			sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
			/* EXEC SQL                     
			INSERT INTO ICB_MOVIMIENTO 
			       (NUM_MOVIMIENTO, NUM_ABONADO,      COD_ESTADO, 
				     COD_MODULO,     COD_ACTUACION,    COD_ACTABO, 
				     NOM_USUARORA,   FEC_INGRESO,      COD_CENTRAL, 
				     TS,             ID,               CC, 
				     PRO,            VEL,              FRE, 
				     COB,            NOM,              GM1, 
				     GM2,            GM3,              GM4, 
				     GM5,            NUM_IDENT,        STA, 
				     MARP,           MODP,             NSER, 
				     TCUE,           TIP_TERMINAL,     EMP,
				     COD_SERVICIOS	) 
			VALUES (:lhNumSeqMov1,      :lhNumAbonado,            :szhUno, 
				     :szhModulo,         :ihCodActuacionBeeper,    :szhBA, 
				     USER,               SYSDATE,                  :ihCodCentral,
				     :szhTs,             :lhId,                    :lhCc,     
				     :szhPro,            :szhVel,                  :ihFre,
				     :szhCob,            :szhNom,                  :szhGm1,   
				     :szhGm2,            :szhGm3,                  :szhGm4,   
				     :szhGm5,            :szhRut,                  :szhSta,  
				     :szhMarp,           :szhModp,                 :szhNser,  
				     :szhTcue,           :szhTp,                   :szhEmp,
				     :szhServicios		 ); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 52;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "insert into ICB_MOVIMIENTO (NUM_MOVIMIENTO,NUM_ABONADO,COD\
_ESTADO,COD_MODULO,COD_ACTUACION,COD_ACTABO,NOM_USUARORA,FEC_INGRESO,COD_CENTR\
AL,TS,ID,CC,PRO,VEL,FRE,COB,NOM,GM1,GM2,GM3,GM4,GM5,NUM_IDENT,STA,MARP,MODP,NS\
ER,TCUE,TIP_TERMINAL,EMP,COD_SERVICIOS) values (:b0,:b1,:b2,:b3,:b4,:b5,USER,S\
YSDATE,:b6,:b7,:b8,:b9,:b10,:b11,:b12,:b13,:b14,:b15,:b16,:b17,:b18,:b19,:b20,\
:b21,:b22,:b23,:b24,:b25,:b26,:b27,:b28)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1487;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSeqMov1;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhUno;
   sqlstm.sqhstl[2] = (unsigned long )2;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhModulo;
   sqlstm.sqhstl[3] = (unsigned long )3;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&ihCodActuacionBeeper;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhBA;
   sqlstm.sqhstl[5] = (unsigned long )3;
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)&ihCodCentral;
   sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)szhTs;
   sqlstm.sqhstl[7] = (unsigned long )2;
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)&lhId;
   sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)&lhCc;
   sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[9] = (         int  )0;
   sqlstm.sqindv[9] = (         short *)0;
   sqlstm.sqinds[9] = (         int  )0;
   sqlstm.sqharm[9] = (unsigned long )0;
   sqlstm.sqadto[9] = (unsigned short )0;
   sqlstm.sqtdso[9] = (unsigned short )0;
   sqlstm.sqhstv[10] = (unsigned char  *)szhPro;
   sqlstm.sqhstl[10] = (unsigned long )3;
   sqlstm.sqhsts[10] = (         int  )0;
   sqlstm.sqindv[10] = (         short *)0;
   sqlstm.sqinds[10] = (         int  )0;
   sqlstm.sqharm[10] = (unsigned long )0;
   sqlstm.sqadto[10] = (unsigned short )0;
   sqlstm.sqtdso[10] = (unsigned short )0;
   sqlstm.sqhstv[11] = (unsigned char  *)szhVel;
   sqlstm.sqhstl[11] = (unsigned long )5;
   sqlstm.sqhsts[11] = (         int  )0;
   sqlstm.sqindv[11] = (         short *)0;
   sqlstm.sqinds[11] = (         int  )0;
   sqlstm.sqharm[11] = (unsigned long )0;
   sqlstm.sqadto[11] = (unsigned short )0;
   sqlstm.sqtdso[11] = (unsigned short )0;
   sqlstm.sqhstv[12] = (unsigned char  *)&ihFre;
   sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[12] = (         int  )0;
   sqlstm.sqindv[12] = (         short *)0;
   sqlstm.sqinds[12] = (         int  )0;
   sqlstm.sqharm[12] = (unsigned long )0;
   sqlstm.sqadto[12] = (unsigned short )0;
   sqlstm.sqtdso[12] = (unsigned short )0;
   sqlstm.sqhstv[13] = (unsigned char  *)szhCob;
   sqlstm.sqhstl[13] = (unsigned long )4;
   sqlstm.sqhsts[13] = (         int  )0;
   sqlstm.sqindv[13] = (         short *)0;
   sqlstm.sqinds[13] = (         int  )0;
   sqlstm.sqharm[13] = (unsigned long )0;
   sqlstm.sqadto[13] = (unsigned short )0;
   sqlstm.sqtdso[13] = (unsigned short )0;
   sqlstm.sqhstv[14] = (unsigned char  *)szhNom;
   sqlstm.sqhstl[14] = (unsigned long )51;
   sqlstm.sqhsts[14] = (         int  )0;
   sqlstm.sqindv[14] = (         short *)0;
   sqlstm.sqinds[14] = (         int  )0;
   sqlstm.sqharm[14] = (unsigned long )0;
   sqlstm.sqadto[14] = (unsigned short )0;
   sqlstm.sqtdso[14] = (unsigned short )0;
   sqlstm.sqhstv[15] = (unsigned char  *)szhGm1;
   sqlstm.sqhstl[15] = (unsigned long )8;
   sqlstm.sqhsts[15] = (         int  )0;
   sqlstm.sqindv[15] = (         short *)0;
   sqlstm.sqinds[15] = (         int  )0;
   sqlstm.sqharm[15] = (unsigned long )0;
   sqlstm.sqadto[15] = (unsigned short )0;
   sqlstm.sqtdso[15] = (unsigned short )0;
   sqlstm.sqhstv[16] = (unsigned char  *)szhGm2;
   sqlstm.sqhstl[16] = (unsigned long )8;
   sqlstm.sqhsts[16] = (         int  )0;
   sqlstm.sqindv[16] = (         short *)0;
   sqlstm.sqinds[16] = (         int  )0;
   sqlstm.sqharm[16] = (unsigned long )0;
   sqlstm.sqadto[16] = (unsigned short )0;
   sqlstm.sqtdso[16] = (unsigned short )0;
   sqlstm.sqhstv[17] = (unsigned char  *)szhGm3;
   sqlstm.sqhstl[17] = (unsigned long )8;
   sqlstm.sqhsts[17] = (         int  )0;
   sqlstm.sqindv[17] = (         short *)0;
   sqlstm.sqinds[17] = (         int  )0;
   sqlstm.sqharm[17] = (unsigned long )0;
   sqlstm.sqadto[17] = (unsigned short )0;
   sqlstm.sqtdso[17] = (unsigned short )0;
   sqlstm.sqhstv[18] = (unsigned char  *)szhGm4;
   sqlstm.sqhstl[18] = (unsigned long )8;
   sqlstm.sqhsts[18] = (         int  )0;
   sqlstm.sqindv[18] = (         short *)0;
   sqlstm.sqinds[18] = (         int  )0;
   sqlstm.sqharm[18] = (unsigned long )0;
   sqlstm.sqadto[18] = (unsigned short )0;
   sqlstm.sqtdso[18] = (unsigned short )0;
   sqlstm.sqhstv[19] = (unsigned char  *)szhGm5;
   sqlstm.sqhstl[19] = (unsigned long )8;
   sqlstm.sqhsts[19] = (         int  )0;
   sqlstm.sqindv[19] = (         short *)0;
   sqlstm.sqinds[19] = (         int  )0;
   sqlstm.sqharm[19] = (unsigned long )0;
   sqlstm.sqadto[19] = (unsigned short )0;
   sqlstm.sqtdso[19] = (unsigned short )0;
   sqlstm.sqhstv[20] = (unsigned char  *)szhRut;
   sqlstm.sqhstl[20] = (unsigned long )21;
   sqlstm.sqhsts[20] = (         int  )0;
   sqlstm.sqindv[20] = (         short *)0;
   sqlstm.sqinds[20] = (         int  )0;
   sqlstm.sqharm[20] = (unsigned long )0;
   sqlstm.sqadto[20] = (unsigned short )0;
   sqlstm.sqtdso[20] = (unsigned short )0;
   sqlstm.sqhstv[21] = (unsigned char  *)szhSta;
   sqlstm.sqhstl[21] = (unsigned long )2;
   sqlstm.sqhsts[21] = (         int  )0;
   sqlstm.sqindv[21] = (         short *)0;
   sqlstm.sqinds[21] = (         int  )0;
   sqlstm.sqharm[21] = (unsigned long )0;
   sqlstm.sqadto[21] = (unsigned short )0;
   sqlstm.sqtdso[21] = (unsigned short )0;
   sqlstm.sqhstv[22] = (unsigned char  *)szhMarp;
   sqlstm.sqhstl[22] = (unsigned long )21;
   sqlstm.sqhsts[22] = (         int  )0;
   sqlstm.sqindv[22] = (         short *)0;
   sqlstm.sqinds[22] = (         int  )0;
   sqlstm.sqharm[22] = (unsigned long )0;
   sqlstm.sqadto[22] = (unsigned short )0;
   sqlstm.sqtdso[22] = (unsigned short )0;
   sqlstm.sqhstv[23] = (unsigned char  *)szhModp;
   sqlstm.sqhstl[23] = (unsigned long )51;
   sqlstm.sqhsts[23] = (         int  )0;
   sqlstm.sqindv[23] = (         short *)0;
   sqlstm.sqinds[23] = (         int  )0;
   sqlstm.sqharm[23] = (unsigned long )0;
   sqlstm.sqadto[23] = (unsigned short )0;
   sqlstm.sqtdso[23] = (unsigned short )0;
   sqlstm.sqhstv[24] = (unsigned char  *)szhNser;
   sqlstm.sqhstl[24] = (unsigned long )31;
   sqlstm.sqhsts[24] = (         int  )0;
   sqlstm.sqindv[24] = (         short *)0;
   sqlstm.sqinds[24] = (         int  )0;
   sqlstm.sqharm[24] = (unsigned long )0;
   sqlstm.sqadto[24] = (unsigned short )0;
   sqlstm.sqtdso[24] = (unsigned short )0;
   sqlstm.sqhstv[25] = (unsigned char  *)szhTcue;
   sqlstm.sqhstl[25] = (unsigned long )2;
   sqlstm.sqhsts[25] = (         int  )0;
   sqlstm.sqindv[25] = (         short *)0;
   sqlstm.sqinds[25] = (         int  )0;
   sqlstm.sqharm[25] = (unsigned long )0;
   sqlstm.sqadto[25] = (unsigned short )0;
   sqlstm.sqtdso[25] = (unsigned short )0;
   sqlstm.sqhstv[26] = (unsigned char  *)szhTp;
   sqlstm.sqhstl[26] = (unsigned long )2;
   sqlstm.sqhsts[26] = (         int  )0;
   sqlstm.sqindv[26] = (         short *)0;
   sqlstm.sqinds[26] = (         int  )0;
   sqlstm.sqharm[26] = (unsigned long )0;
   sqlstm.sqadto[26] = (unsigned short )0;
   sqlstm.sqtdso[26] = (unsigned short )0;
   sqlstm.sqhstv[27] = (unsigned char  *)szhEmp;
   sqlstm.sqhstl[27] = (unsigned long )51;
   sqlstm.sqhsts[27] = (         int  )0;
   sqlstm.sqindv[27] = (         short *)0;
   sqlstm.sqinds[27] = (         int  )0;
   sqlstm.sqharm[27] = (unsigned long )0;
   sqlstm.sqadto[27] = (unsigned short )0;
   sqlstm.sqtdso[27] = (unsigned short )0;
   sqlstm.sqhstv[28] = (unsigned char  *)szhServicios;
   sqlstm.sqhstl[28] = (unsigned long )256;
   sqlstm.sqhsts[28] = (         int  )0;
   sqlstm.sqindv[28] = (         short *)0;
   sqlstm.sqinds[28] = (         int  )0;
   sqlstm.sqharm[28] = (unsigned long )0;
   sqlstm.sqadto[28] = (unsigned short )0;
   sqlstm.sqtdso[28] = (unsigned short )0;
   sqlstm.sqphsv = sqlstm.sqhstv;
   sqlstm.sqphsl = sqlstm.sqhstl;
   sqlstm.sqphss = sqlstm.sqhsts;
   sqlstm.sqpind = sqlstm.sqindv;
   sqlstm.sqpins = sqlstm.sqinds;
   sqlstm.sqparm = sqlstm.sqharm;
   sqlstm.sqparc = sqlstm.sqharc;
   sqlstm.sqpadto = sqlstm.sqadto;
   sqlstm.sqptdso = sqlstm.sqtdso;
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


			
			if (sqlca.sqlcode)  {
				ifnTrazaHilos( modulo,&pfLog, "INSERT INTO ICB_MOVIMIENTO (Cliente:%ld|Abonado:%ld) %s",
										LOG00, lhCodCliente, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
				strcpy(szStsFin,"PND");
				break;
			}
	
			iAboBeepGlobal ++;
        } /* endif ihProducto */
        
        /* Independiente si es Celular o Beeper llama a la PL de Baja */
		if( !bfnEjecutaPLInterfasesAbonados(&pfLog, lhNumAbonado, ihProducto, szhActAbo, CXX ) )
		{
			strcpy( szStsFin, "PLIAB" );
			break;
		}

   		/* Llamamos a la PL CO_BAJAS_ABO */
		if( !bfnEjecutaPLCoBajasAbo(&pfLog, lhNumAbonado, szAccion, CXX ) )
		{
			strcpy( szStsFin, "PLCBA" );
			break;
		}
		
	   /* Inicio Modificacion P-COL-08022  MAC*/
	   sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/

      ifnTrazaHilos( modulo,&pfLog, "Ejecutando PV_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR.. ", LOG03);
      ifnTrazaHilos( modulo,&pfLog, "(Cliente   :[%ld]) proceso Producto", LOG03, lhCodCliente );
      ifnTrazaHilos( modulo,&pfLog, "(Abonado   :[%ld]) proceso Producto", LOG03, lhNumAbonado);
      ifnTrazaHilos( modulo,&pfLog, "(szhFecSysdate:[%s]) proceso Producto", LOG03, szhFecSysdate);
	   /* Se ejecuta la descontratacion de todos los planes adicionales del abonado */
	   
	   /* EXEC SQL EXECUTE
		   DECLARE
			   iCod_retorno NUMBER:=0;
			   szMens_retorno VARCHAR2(3000);
			   iNum_evento  NUMBER:=0;
			   szhFecAlta_aux_full VARCHAR2(19);
		   BEGIN
			   szhFecAlta_aux_full:=:szhFecSysdate;
			   PV_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR ( :lhCodCliente, :lhNumAbonado, szhFecAlta_aux_full, NULL, :lhNumSeqMov1, '0', 'CO', iCod_retorno, szMens_retorno, iNum_evento  );
	         :szhFecAlta_aux:=	szhFecAlta_aux_full;
	         :szhDesError:=szMens_retorno;
	         :ihCodRetorno:=iCod_retorno;
	         :ihNum_evento:=iNum_evento;
           END;
      END-EXEC; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 52;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "declare iCod_retorno NUMBER := 0 ; szMens_retorno VARCHAR\
2 ( 3000 ) ; iNum_evento NUMBER := 0 ; szhFecAlta_aux_full VARCHAR2 ( 19 ) ; B\
EGIN szhFecAlta_aux_full := :szhFecSysdate ; PV_PLANES_ADICIONALES_PG . PV_BAJ\
A_PLANES_PR ( :lhCodCliente , :lhNumAbonado , szhFecAlta_aux_full , NULL , :lh\
NumSeqMov1 , '0' , 'CO' , iCod_retorno , szMens_retorno , iNum_evento ) ; :szh\
FecAlta_aux := szhFecAlta_aux_full ; :szhDesError := szMens_retorno ; :ihCodRe\
torno := iCod_retorno ; :ihNum_evento := iNum_evento ; END ;";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1618;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhFecSysdate;
    sqlstm.sqhstl[0] = (unsigned long )20;
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
    sqlstm.sqhstv[2] = (unsigned char  *)&lhNumAbonado;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&lhNumSeqMov1;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhFecAlta_aux;
    sqlstm.sqhstl[4] = (unsigned long )20;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhDesError;
    sqlstm.sqhstl[5] = (unsigned long )500;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&ihCodRetorno;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&ihNum_evento;
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
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

 


      ifnTrazaHilos( modulo,&pfLog, "((PV_BAJA_PLANES_PR)szhFecAlta_aux:[%s]) ", LOG03, szhFecAlta_aux);
      ifnTrazaHilos( modulo,&pfLog, "((PV_BAJA_PLANES_PR)szhDesError   :[%s]) ", LOG03, szhDesError);
      ifnTrazaHilos( modulo,&pfLog, "((PV_BAJA_PLANES_PR)ihCodRetorno  :[%d]) ", LOG03, ihCodRetorno);
      ifnTrazaHilos( modulo,&pfLog, "((PV_BAJA_PLANES_PR)ihNum_evento  :[%d]) ", LOG03, ihNum_evento);
      ifnTrazaHilos( modulo,&pfLog, "((PV_BAJA_PLANES_PR)sqlca.sqlcode :[%d]) ", LOG03, sqlca.sqlcode);
      memset(szhFecAlta_aux,'\0',sizeof(szhFecAlta_aux));
      ifnTrazaHilos( modulo,&pfLog, "(szhFecAlta_aux seteada:[%s])\n", LOG03, szhFecAlta_aux);
      
      if (ihCodRetorno != 0 ) {
      	strcpy(szStsFin,"PND");
      	break;
      }

      ifnTrazaHilos( modulo,&pfLog, "Ejecutando PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR.... ", LOG03);
      ifnTrazaHilos( modulo,&pfLog, "(Cliente   :[%ld]) proceso Producto", LOG03, lhCodCliente );
      ifnTrazaHilos( modulo,&pfLog, "(Abonado   :[%ld]) proceso Producto", LOG03, lhNumAbonado);
      ifnTrazaHilos( modulo,&pfLog, "(szhFecAlta:[%s]) proceso Producto", LOG03, szhFecAlta);
	   /* Se ejecuta la provisión de los movimientos de baja de los planes del cliente para el abonado */
	   sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
	   /* EXEC SQL EXECUTE
	 	   DECLARE
			   iCod_retorno NUMBER:=0;
			   szMens_retorno VARCHAR2(3000);
			   iNum_evento  NUMBER:=0;
			   szhFecAlta_aux_full VARCHAR2(19);
		   BEGIN
			   szhFecAlta_aux_full:=:szhFecSysdate;
            PV_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR ( :lhCodCliente, :lhNumAbonado, szhFecAlta_aux_full, :lhNumSeqMov1,0, iCod_retorno, szMens_retorno, iNum_evento  );
	         :szhFecAlta_aux:=	szhFecAlta_aux_full;
	         :szhDesError:=szMens_retorno;
	         :ihCodRetorno:=iCod_retorno;
	         :ihNum_evento:=iNum_evento;
		   END;
	   END-EXEC; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 52;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "declare iCod_retorno NUMBER := 0 ; szMens_retorno VARCHAR\
2 ( 3000 ) ; iNum_evento NUMBER := 0 ; szhFecAlta_aux_full VARCHAR2 ( 19 ) ; B\
EGIN szhFecAlta_aux_full := :szhFecSysdate ; PV_PLANES_ADICIONALES_PG . PV_PRO\
VISION_BAJA_ABO_PR ( :lhCodCliente , :lhNumAbonado , szhFecAlta_aux_full , :lh\
NumSeqMov1 , 0 , iCod_retorno , szMens_retorno , iNum_evento ) ; :szhFecAlta_a\
ux := szhFecAlta_aux_full ; :szhDesError := szMens_retorno ; :ihCodRetorno := \
iCod_retorno ; :ihNum_evento := iNum_evento ; END ;";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1665;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhFecSysdate;
    sqlstm.sqhstl[0] = (unsigned long )20;
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
    sqlstm.sqhstv[2] = (unsigned char  *)&lhNumAbonado;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&lhNumSeqMov1;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhFecAlta_aux;
    sqlstm.sqhstl[4] = (unsigned long )20;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhDesError;
    sqlstm.sqhstl[5] = (unsigned long )500;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&ihCodRetorno;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&ihNum_evento;
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
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

 

      ifnTrazaHilos( modulo,&pfLog, "((PV_PROVISION_BAJA_ABO_PR)szhFecAlta_aux:[%s]) ", LOG03, szhFecAlta_aux);
      ifnTrazaHilos( modulo,&pfLog, "((PV_PROVISION_BAJA_ABO_PR)szhDesError   :[%s]) ", LOG03, szhDesError);
      ifnTrazaHilos( modulo,&pfLog, "((PV_PROVISION_BAJA_ABO_PR)ihCodRetorno  :[%d]) ", LOG03, ihCodRetorno);
      ifnTrazaHilos( modulo,&pfLog, "((PV_PROVISION_BAJA_ABO_PR)ihNum_evento  :[%d]) ", LOG03, ihNum_evento);
      ifnTrazaHilos( modulo,&pfLog, "((PV_PROVISION_BAJA_ABO_PR)sqlca.sqlcode :[%d]) ", LOG03, sqlca.sqlcode);
      memset(szhFecAlta_aux,'\0',sizeof(szhFecAlta_aux));
      ifnTrazaHilos( modulo,&pfLog, "(szhFecAlta_aux seteada:[%s])\n", LOG03, szhFecAlta_aux);
      ifnTrazaHilos( modulo,&pfLog, "Fin modificacion PV_PLANES_ADICIONALES_PG....\n", LOG03);

      if (ihCodRetorno != 0 ) {
      	strcpy(szStsFin,"PND");
      	break;
      }
      /*fin Modificacion P-COL-08022  MAC */

		/* Llamamos a la PL P_AL_INTERFAZ_CLUB 
		if( !bfnEjecutaPLAlInterfazClub(&pfLog, lhNumAbonado, szhCodCausaBajaCelular, szCodActuacion, CXX ) )
		{
			strcpy( szStsFin, "PLICL" );
			break;
		}*/
		
    } /* endfor */
    
	/* Inicio Modificacion P-COL-08022  [AROG] */
	/* Se ejecuta la descontratacion de todos los planes adicionales del cliente */
	sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
   ifnTrazaHilos( modulo,&pfLog, "Ejecutando Ultimo PV_BAJA_PLANES_PR.. ", LOG03);
   ifnTrazaHilos( modulo,&pfLog, "(Cliente   :[%ld])", LOG03, lhCodCliente );
   ifnTrazaHilos( modulo,&pfLog, "(Abonado   :[%ld])", LOG03, lhNumAbonado);
   ifnTrazaHilos( modulo,&pfLog, "(szhFecAlta:[%s]) ", LOG03, szhFecAlta);
	/* EXEC SQL EXECUTE
		DECLARE
			iCod_retorno NUMBER:=0;
			szMens_retorno VARCHAR2(3000);
			iNum_evento  NUMBER:=0;
			szhFecAlta_aux_full VARCHAR2(19);
		BEGIN
		   szhFecAlta_aux_full:=:szhFecSysdate;
         PV_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR ( :lhCodCliente, 0, szhFecAlta_aux_full, NULL, :lhNumSeqMov1, '0', 'CO', iCod_retorno, szMens_retorno, iNum_evento  );
         :szhFecAlta_aux:=	szhFecAlta_aux_full;
         :szhDesError:=szMens_retorno;
         :ihCodRetorno:=iCod_retorno;
         :ihNum_evento:=iNum_evento;

		END;
	END-EXEC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 52;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "declare iCod_retorno NUMBER := 0 ; szMens_retorno VARCHAR2 (\
 3000 ) ; iNum_evento NUMBER := 0 ; szhFecAlta_aux_full VARCHAR2 ( 19 ) ; BEGI\
N szhFecAlta_aux_full := :szhFecSysdate ; PV_PLANES_ADICIONALES_PG . PV_BAJA_P\
LANES_PR ( :lhCodCliente , 0 , szhFecAlta_aux_full , NULL , :lhNumSeqMov1 , '0\
' , 'CO' , iCod_retorno , szMens_retorno , iNum_evento ) ; :szhFecAlta_aux := \
szhFecAlta_aux_full ; :szhDesError := szMens_retorno ; :ihCodRetorno := iCod_r\
etorno ; :ihNum_evento := iNum_evento ; END ;";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1712;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhFecSysdate;
 sqlstm.sqhstl[0] = (unsigned long )20;
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
 sqlstm.sqhstv[2] = (unsigned char  *)&lhNumSeqMov1;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhFecAlta_aux;
 sqlstm.sqhstl[3] = (unsigned long )20;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhDesError;
 sqlstm.sqhstl[4] = (unsigned long )500;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&ihCodRetorno;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)&ihNum_evento;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


   ifnTrazaHilos( modulo,&pfLog, "((PV_BAJA_PLANES_PR 2)szhFecAlta_aux:[%s]) ", LOG03, szhFecAlta_aux);
   ifnTrazaHilos( modulo,&pfLog, "((PV_BAJA_PLANES_PR 2)szhDesError   :[%s]) ", LOG03, szhDesError);
   ifnTrazaHilos( modulo,&pfLog, "((PV_BAJA_PLANES_PR 2)ihCodRetorno  :[%d]) ", LOG03, ihCodRetorno);
   ifnTrazaHilos( modulo,&pfLog, "((PV_BAJA_PLANES_PR 2)ihNum_evento  :[%d]) ", LOG03, ihNum_evento);
   ifnTrazaHilos( modulo,&pfLog, "((PV_BAJA_PLANES_PR 2)sqlca.sqlcode :[%d]) ", LOG03, sqlca.sqlcode);
   memset(szhFecAlta_aux,'\0',sizeof(szhFecAlta_aux));
   ifnTrazaHilos( modulo,&pfLog, "(szhFecAlta_aux seteada:[%s])\n", LOG03, szhFecAlta_aux);
   ifnTrazaHilos( modulo,&pfLog, "Fin modificacion PV_PLANES_ADICIONALES_PG.... ", LOG03);

   if (ihCodRetorno != 0 ) {
   	strcpy(szStsFin,"PND");
   }
	/*fin Modificacion P-COL-08022  [AROG] */	 

 
	sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
	/* EXEC SQL CLOSE curUniverso ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 52;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1755;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	if( sqlca.sqlcode )  {
		ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) Close curUniverso %s ",LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
		strcpy(szStsFin,"PND");
	}
	
	/* inicio P-COL-08022*/
	ifnTrazaHilos( modulo,&pfLog, "Retorna szStsFin [%s] ",LOG03,szStsFin);  
	if( strcmp( szStsFin, "OK" )!=0 )  {
	   ifnTrazaHilos( modulo,&pfLog, "Retorna Distinto de OK.",LOG03);  
	   return (char *)szStsFin;
	}
	/* fin P-COL-08022*/
	
	/*- MGG 01/03/2001, Se cuenta la cantidad total a la fecha, de abonados celulares y -*/
	/*- beepers afectados por la accion, para guardar estadistica en la tabla co_morosos-*/ 
	sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
	/* EXEC SQL 
	SELECT COUNT(*)
	INTO	 :iCuentaAboCelu
	FROM	 GA_ABOCEL
	WHERE	 COD_CLIENTE   = :lhCodCliente
	/o AND	 COD_SITUACION IN ( :szhBAA, :szhBAP ) o/
	AND  	COD_SITUACION IN ( :szhBAJAABO, :szhBAJAPROC )    /oCH-200408232102  Homologado por PGonzalez 22-11-2004 o/	
	AND	 COD_CAUSABAJA IN ( :szh90,:szh43,:szh44); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 52;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(*)  into :b0  from GA_ABOCEL where ((COD_CLIENT\
E=:b1 and COD_SITUACION in (:b2,:b3)) and COD_CAUSABAJA in (:b4,:b5,:b6))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1770;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&iCuentaAboCelu;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
 sqlstm.sqhstv[2] = (unsigned char  *)szhBAJAABO;
 sqlstm.sqhstl[2] = (unsigned long )4;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhBAJAPROC;
 sqlstm.sqhstl[3] = (unsigned long )4;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szh90;
 sqlstm.sqhstl[4] = (unsigned long )3;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szh43;
 sqlstm.sqhstl[5] = (unsigned long )3;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szh44;
 sqlstm.sqhstl[6] = (unsigned long )3;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	
	if (sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND) 
	{
		ifnTrazaHilos( modulo,&pfLog, "Recuperando abonados bajas GA_ABOCEL (Cliente:%ld) %s", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );
		return "PND";
	}
	
	sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
	/* EXEC SQL 
	SELECT COUNT(*)
	INTO	 :iCuentaAboBeep
	FROM	 GA_ABOBEEP
	WHERE	 COD_CLIENTE   = :lhCodCliente
	/oAND	 COD_SITUACION IN ( :szhBAA, :szhBAP )o/
	AND 	COD_SITUACION IN ( :szhBAJAABO, :szhBAJAPROC )    /oCH-200408232102  27-08-2004 PRMo/	
	AND	 COD_CAUSABAJA IN ( :szh90,:szh43,:szh44); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 52;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(*)  into :b0  from GA_ABOBEEP where ((COD_CLIEN\
TE=:b1 and COD_SITUACION in (:b2,:b3)) and COD_CAUSABAJA in (:b4,:b5,:b6))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1813;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&iCuentaAboBeep;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
 sqlstm.sqhstv[2] = (unsigned char  *)szhBAJAABO;
 sqlstm.sqhstl[2] = (unsigned long )4;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhBAJAPROC;
 sqlstm.sqhstl[3] = (unsigned long )4;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szh90;
 sqlstm.sqhstl[4] = (unsigned long )3;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szh43;
 sqlstm.sqhstl[5] = (unsigned long )3;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szh44;
 sqlstm.sqhstl[6] = (unsigned long )3;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



	if (sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND) 	{
		ifnTrazaHilos( modulo,&pfLog, "Recuperando abonados bajas GA_ABOBEEP (Cliente:%ld) %s", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );
		return "PND";
	}
	
	iMRAboCeluGlobal = iCuentaAboCelu;
	iMRAboBeepGlobal = iCuentaAboBeep;
	return "OK";   
} /* Fin a szfnBaja*/ 

/*********************************************************************************************************/
/*********************************************************************************************************/
BOOL bfnBorraDtosTarif(FILE **ptArchLog, long lNumAbonado, long iCodCiclo , sql_context ctxCont)
{
/************************************************************
	Funcion que Pasa a Historico Los datos de GA_DTOSTARIF
	menos los del Ciclo Actual
************************************************************/
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long	lhNumAbonado = 0;
	long	ihCodCiclo = 0;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char	modulo[] = "bfnBorraDtosTarif";
FILE *pfLog=*ptArchLog;
struct sqlca sqlca;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

	
	ifnTrazaHilos( modulo,&pfLog, "Ingresando Modulo %s", LOG05, modulo );
	
	lhNumAbonado = lNumAbonado;
	ihCodCiclo = iCodCiclo;
	
	/* Pasamos a Historico los descuentos del abonado en este momento */
	sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
	/* EXEC SQL
	INSERT INTO GA_HDTOSTARIF 	
	       (NUM_ABONADO,
			  COD_CICLFACT,
			  NUM_MINUTOS,
			  TIP_PLANTARIF,
			  COD_VENDEDOR,
			  NOM_USUARORA,
			  FEC_GRABACION,
			  FEC_BAJA 		  ) 
	SELECT  NUM_ABONADO,
			  COD_CICLFACT,
			  NUM_MINUTOS,
			  TIP_PLANTARIF,
			  COD_VENDEDOR,
			  USER,
			  SYSDATE,										
			  SYSDATE
			  FROM	GA_DTOSTARIF
			  WHERE	NUM_ABONADO = :lhNumAbonado
			  AND		COD_CICLFACT <> :ihCodCiclo; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 52;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "insert into GA_HDTOSTARIF (NUM_ABONADO,COD_CICLFACT,NUM_MINU\
TOS,TIP_PLANTARIF,COD_VENDEDOR,NOM_USUARORA,FEC_GRABACION,FEC_BAJA)select NUM_\
ABONADO ,COD_CICLFACT ,NUM_MINUTOS ,TIP_PLANTARIF ,COD_VENDEDOR ,USER ,SYSDATE\
 ,SYSDATE  from GA_DTOSTARIF where (NUM_ABONADO=:b0 and COD_CICLFACT<>:b1)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1856;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhNumAbonado;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihCodCiclo;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


      
	if ( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{
		ifnTrazaHilos( modulo,&pfLog, "Abonado = %ld. INSERT INTO GA_HDTOSTARIF [%s]", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
	}

	/* ahora que ya tenemos los datos en el historico borramos de 'GA_DTOSTARIF menos el del Ciclo Actual */
	sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
	/* EXEC SQL
	DELETE FROM	GA_DTOSTARIF
	WHERE	 NUM_ABONADO = :lhNumAbonado
	AND	 COD_CICLFACT <> :ihCodCiclo; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 52;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "delete  from GA_DTOSTARIF  where (NUM_ABONADO=:b0 and COD_CI\
CLFACT<>:b1)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1879;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhNumAbonado;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihCodCiclo;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



	if ( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{
		ifnTrazaHilos( modulo,&pfLog, "Abonado = %ld. DELETE	GA_DTOSTARIF [%s]", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
	}
    
	return TRUE;
} /* BOOL bfnBorraDtosTarif( long lNumAbonado, long iCodCiclo ) */

/*********************************************************************************************************/
/*********************************************************************************************************/
BOOL bfnDesactivarServSuplAbo(FILE **ptArchLog, long lNumAbonado, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long	lhNumAbonado;
	int   ihValor_Tres    = 3;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char	modulo[] = "bfnDesactivarServSuplAbo";
FILE *pfLog=*ptArchLog;
struct sqlca sqlca;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

	ifnTrazaHilos( modulo,&pfLog, "Ingresando Modulo %s", LOG05, modulo );

	lhNumAbonado = lNumAbonado;
	
	sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
	/* EXEC SQL
	UPDATE GA_SERVSUPLABO SET     
	       IND_ESTADO  = :ihValor_Tres
	WHERE	 NUM_ABONADO = :lhNumAbonado
	AND	 IND_ESTADO  < :ihValor_Tres; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 52;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "update GA_SERVSUPLABO  set IND_ESTADO=:b0 where (NUM_ABONADO\
=:b1 and IND_ESTADO<:b0)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1902;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_Tres;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_Tres;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	
	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND ) {   
		ifnTrazaHilos( modulo,&pfLog, "(Abonado:%ld) Dessactivando servicios suplementarios %s.", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );  
		return FALSE;	
	}
	return TRUE;
} /* bfnDesactivarServSuplAbo */

/*********************************************************************************************************/
/*********************************************************************************************************/
int ifnVerificaExisteFyF(FILE **ptArchLog, long lCodCliente, long lNumAbonado, long lNumCelular , sql_context ctxCont)
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long	lhCodCliente = 0;
	long	lhNumAbonado = 0;
	int	ihIndFamiliarEmp = 0;
	int	ihIndFamiliarAbo = 0;
  	char  szhBAA          [4];
  	char    szhBAJAABO[4];              /* EXEC SQL VAR szhBAJAABO IS STRING(4); */ 
      /* CH-200408232102  Homologado por PGonzalez 22-11-2004 */
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char	modulo[] = "bfnBajaPlanFamiliar";
FILE *pfLog=*ptArchLog;
struct sqlca sqlca;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

	
	ifnTrazaHilos( modulo,&pfLog, "Ingresando Modulo %s", LOG05, modulo );
	strcpy(szhBAA ,"BAA");
	strcpy( szhBAJAABO, BAJAABONADO );           /* CH-200408232102  Homologado por PGonzalez 22-11-2004 */
	
	lhCodCliente = lCodCliente;
	lhNumAbonado = lNumAbonado;

	sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
	/* EXEC SQL
	SELECT A.IND_FAMILIAR
	INTO	 :ihIndFamiliarEmp
	FROM	 TA_PLANTARIF A,
			 GA_EMPRESA B
	WHERE	 B.COD_CLIENTE = :lhCodCliente
	AND	 A.COD_PLANTARIF = B.COD_PLANTARIF; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 52;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select A.IND_FAMILIAR into :b0  from TA_PLANTARIF A ,GA_EMPR\
ESA B where (B.COD_CLIENTE=:b1 and A.COD_PLANTARIF=B.COD_PLANTARIF)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1929;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihIndFamiliarEmp;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{   
		ifnTrazaHilos( modulo,&pfLog, "(Abonado:%ld) Verificando Plan Familiar Emp %s.", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );  
		return -1;	
	}

	if( sqlca.sqlcode == SQLNOTFOUND )	{   
		ifnTrazaHilos( modulo,&pfLog, "(Abonado:%ld) No tiene Plan Familiar.", LOG03, lhNumAbonado );  
		return 0;	
	}

	sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
	/* EXEC SQL
	SELECT A.IND_FAMILIAR
	INTO	 :ihIndFamiliarAbo
	FROM	 TA_PLANTARIF A,
			 GA_ABOCEL B
	WHERE	 B.NUM_ABONADO = :lhNumAbonado
	AND	 A.COD_PLANTARIF = B.COD_PLANTARIF
	/oAND    B.COD_SITUACION <> :szhBAA; o/ 
	AND      B.COD_SITUACION <> :szhBAJAABO ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 52;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select A.IND_FAMILIAR into :b0  from TA_PLANTARIF A ,GA_ABOC\
EL B where ((B.NUM_ABONADO=:b1 and A.COD_PLANTARIF=B.COD_PLANTARIF) and B.COD_\
SITUACION<>:b2)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1952;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihIndFamiliarAbo;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhBAJAABO;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

         /*CH-200408232102  Homologado por PGonzalez 22-11-2004 */

	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{   
		ifnTrazaHilos( modulo,&pfLog, "(Abonado:%ld) Verificando Plan Familiar Abo %s.", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );  
		return -1;	
	}

	if( sqlca.sqlcode == SQLNOTFOUND ) 	{   
		ifnTrazaHilos( modulo,&pfLog, "(Abonado:%ld) No tiene Plan Familiar.", LOG00, lhNumAbonado );  
		return 0;	
	}

	if( ihIndFamiliarEmp == 1 && ihIndFamiliarAbo == 1 )
		return 1;
		
	return 0;			
} /* int ifnBajaPlanFamiliar */

/*********************************************************************************************************/
/*********************************************************************************************************/
/*char *szGetCadenaServNivelAbo(FILE **ptArchLog, long lNumAbonado, char *szCadena , sql_context ctxCont) 
{*/
/* Obtiene una Cadena formada por la concatenacion de todos los Servicios Suplementarios
   Que tenemos para un N­ de Abonado en la tabla GA_SERVSUPLABO 							 */
/*EXEC SQL BEGIN DECLARE SECTION;
	long	lhNumAbonado;
	int	ihCodServSupl;
	int	ihCodNivel;
	int   ihValor_Tres    = 3;
	int   ihValor_Cinco   = 5;
EXEC SQL END DECLARE SECTION;       
char 	modulo[] = "szGetCadenaServNivelAbo";
char	szCadenaAux[256];
int		iError = 0;
FILE *pfLog=*ptArchLog;
sql_context CXX;
struct sqlca sqlca;

	CXX = ctxCont;
	EXEC SQL CONTEXT USE :CXX; 	
	lhNumAbonado = lNumAbonado;            
	memset ( szCadenaAux, 0, sizeof( szCadenaAux ) );
	
	EXEC SQL DECLARE curGaSurp CURSOR FOR
	SELECT COD_SERVSUPL, 
			 COD_NIVEL 
	FROM 	 GA_SERVSUPLABO
	WHERE  NUM_ABONADO = :lhNumAbonado
	AND 	(IND_ESTADO < :ihValor_Tres or IND_ESTADO = :ihValor_Cinco );

	if ( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{
		ifnTrazaHilos( modulo,&pfLog, "lhNumAbonado:[%ld] DECLARE curGaSurp. %s ", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
		return "PND";
	}

	EXEC SQL OPEN curGaSurp;
	if ( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{
		ifnTrazaHilos( modulo,&pfLog, "lhNumAbonado:[%ld] OPEN curGaSurp. %s ", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
		return "PND";
	}
	
	for ( ; ; ) 	{		
		EXEC SQL FETCH curGaSurp INTO
					:ihCodServSupl,
					:ihCodNivel;

		if ( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{
			ifnTrazaHilos( modulo,&pfLog, "lhNumAbonado:[%ld] FETCH curGaSurp. %s ", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
			iError = 1;
			break;
		}

		if ( sqlca.sqlcode == SQLNOTFOUND )		{
			ifnTrazaHilos( modulo,&pfLog, "lhNumAbonado:[%ld] Fin Datos Cursor curGaSurp.", LOG03, lhNumAbonado );
			break;
		}
		
		sprintf ( szCadenaAux, "%s%02d%04d", szCadenaAux, ihCodServSupl, ihCodNivel );
	}

	EXEC SQL CLOSE curGaSurp;
	if ( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{
		ifnTrazaHilos( modulo,&pfLog, "lhNumAbonado:[%ld] CLOSE curGaSurp. %s ", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
		return "PND";
	}

	if( iError == 1 )	* si hubo error *
		return "PND";
		
	sprintf( szCadena, "%s", szCadenaAux );
	ifnTrazaHilos( modulo,&pfLog, "NumAbonado:[%ld] szGetCadenaServNivelAbo, Retorno Cadena. %s.", LOG03, lhNumAbonado, szCadena );

	return "OK";
} *//* char *szGetCadenaServNivelAbo( long lNumAbonado, char *szCadena ) */

/*********************************************************************************************************/
/*********************************************************************************************************/
BOOL bfnDesactivarServSuplFriendsAbo(FILE **ptArchLog, long lCodCliente, long lNumAbonado, long lNumCelular, int iCodCentral,
										char *szNumSerie, char *szTipTerminal, int iProducto, char *szNumMin , sql_context ctxCont) 
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long	lhCodCliente = 0;
	long	lhNumAbonado = 0;
	long	lhNumCelular = 0;
	long	lhNumAbonado2 = 0;
	long	lhNumMovimiento = 0;
	int	ihCodCentral = 0;
	int	ihProducto = 0;
	int	ihCodActCen = 0;
	char	szhTipTerminal[2] = "";			/* EXEC SQL VAR szhTipTerminal 	IS STRING (2); */ 

	char	szhNumMin[4] = "";				/* EXEC SQL VAR szhNumMin			IS STRING (4); */ 

	char	szhFecha[20] = "";				/* EXEC SQL VAR szhFecha			IS STRING (20); */ 

	char	szhFechaIni[20] = "";			/* EXEC SQL VAR szhFechaIni		IS STRING (20); */ 

	char	szhFechaFin[20] = "";			/* EXEC SQL VAR szhFechaFin		IS STRING (20); */ 

	char	szhFechaMin[20] = "";			/* EXEC SQL VAR szhFechaMin		IS STRING (20); */ 

	char	szhNumSerieHex[9] = "";			/* EXEC SQL VAR szhNumSerieHex		IS STRING (9); */ 

	char	szhCodTecnologia[iLENCODTECNO] =""  ; 	/* EXEC SQL VAR szhCodTecnologia IS STRING (iLENCODTECNO); */ 

	char	szhNumSerie[iLENNUMSERIE] ="" ; /* EXEC SQL VAR szhNumSerie IS STRING (iLENNUMSERIE); */ 

	char	szhNumImei[iLENNUMIMEI]   ="" ; /* EXEC SQL VAR szhNumImei IS STRING (iLENNUMIMEI); */ 

	char	szhNumImsi[iLENNUMIMSI]   ="" ; /* EXEC SQL VAR szhNumImsi IS STRING (iLENNUMIMSI); */ 

	char	szhCadenaServNivel[256];		
	char	szhRowid[19];
	long	lhNumCelular2 = 0;
	char	szhServFyF[256];
	int   ihValor_Tres    = 3;
	int   ihValor_Cinco   = 5;	
	char    szhBAJAABO[4];              /* EXEC SQL VAR szhBAJAABO IS STRING(4); */ 
      /* CH-200408232102  Homologado por PGonzalez 22-11-2004 */
	char  szhSS           [3];
	char  szhGA           [3];
	char  szhGSM          [4];
	char  szhIMSI         [5];
	char  szhFiller       [2];
	char  szhUno          [2];
  	char  szhBAA          [4];
	char  szhModulo   	 [3];
  	char  szhDDMMYYYYHH24MISS  [22];
	float fh00001         = 0.00001;
	int   ihValor_Cero    = 0;
	int   ihValor_Uno     = 1;
	sql_context CXX;
   
/* EXEC SQL END DECLARE SECTION; */ 

char	 *pszRet;
static char	szRet[4];
int	 iError = 0;	
char	 modulo[] = "bfnDesactivarServSuplFriendsAbo";
FILE *pfLog=*ptArchLog;
struct sqlca sqlca;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

	ifnTrazaHilos( modulo,&pfLog, "Ingresando Modulo %s. Abonado %ld", LOG05, modulo, lNumAbonado );
	strcpy( szhBAJAABO, BAJAABONADO );           /* CH-200408232102  Homologado por PGonzalez 22-11-2004 */
	strcpy(szhModulo,"CO");
	strcpy(szhSS  ,"SS");
	strcpy(szhGA  ,"GA");
	strcpy(szhGSM ,"GSM");
	strcpy(szhIMSI,"IMSI");
	strcpy(szhFiller," ");
	strcpy(szhUno,"1");
	strcpy(szhBAA ,"BAA");
	strcpy(szhDDMMYYYYHH24MISS,"DD-MM-YYYY HH24:MI:SS");

	memset( szhRowid, '\0', sizeof( szhRowid ) );
	memset( szhNumSerie, '\0', sizeof( szhNumSerie ) );
	memset( szhTipTerminal, '\0', sizeof( szhTipTerminal ) );
	memset( szhCadenaServNivel, '\0', sizeof( szhCadenaServNivel ) );
	memset( szhNumMin, '\0', sizeof( szhNumMin ) );
	memset( szhNumSerieHex, '\0', sizeof( szhNumSerieHex ) );
	memset( szhCodTecnologia, '\0', sizeof( szhCodTecnologia ) );
	memset( szhNumSerie, '\0', sizeof( szhNumSerie ) );
	memset( szhNumImei, '\0', sizeof( szhNumImei ) );
	memset( szhNumImsi, '\0', sizeof( szhNumImsi ) );
	memset( szhServFyF, '\0', sizeof( szhServFyF ) );
	
	strcpy( szhNumMin, szNumMin );
	lhCodCliente = lCodCliente;
	lhNumAbonado = lNumAbonado;
	lhNumCelular = lNumCelular;
	ihProducto = iProducto;
	strcpy(szhServFyF, "180000");

	/* Buscamos los abonados del cliente asociados al abonado actual para desactivar servicio friends */
	sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
	/* EXEC SQL DECLARE curAbonadosFri CURSOR FOR
	SELECT NUM_ABONADO,
			 NUM_CELULAR,
			 TIP_TERMINAL,
			 COD_CENTRAL,
			 NVL(NUM_SERIEHEX, :szhUno),
			 COD_TECNOLOGIA,
			 NVL( NUM_SERIE, :szhFiller ),
			 NVL( NUM_IMEI, :szhFiller ),
			 DECODE( COD_TECNOLOGIA, :szhGSM, fRecuperSIMCARD_FN( NUM_SERIE, :szhIMSI), :szhFiller ) IMSI
			 /o fRecuperSIMCARD_FN( NUM_SERIE, 'IMSI') IMSI o/
	FROM	 GA_ABOCEL
	WHERE	 COD_CLIENTE = :lhCodCliente
	AND	 NUM_ABONADO != :lhNumAbonado
	/oAND	 COD_SITUACION != :szhBAA;o/
	AND  	COD_SITUACION != :szhBAJAABO; */ 
    /*CH-200408232102  Homologado por PGonzalez 22-11-2004 */

	if( sqlca.sqlcode != SQLOK )	{   
		ifnTrazaHilos( modulo,&pfLog, "(Abonado:%ld) DECLARE curAbonadosFri %s.", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );  
		return FALSE;	
	}

	sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
	/* EXEC SQL OPEN curAbonadosFri; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 52;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0041;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1979;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhUno;
 sqlstm.sqhstl[0] = (unsigned long )2;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhFiller;
 sqlstm.sqhstl[1] = (unsigned long )2;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhFiller;
 sqlstm.sqhstl[2] = (unsigned long )2;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhGSM;
 sqlstm.sqhstl[3] = (unsigned long )4;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhIMSI;
 sqlstm.sqhstl[4] = (unsigned long )5;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhFiller;
 sqlstm.sqhstl[5] = (unsigned long )2;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)&lhCodCliente;
 sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)&lhNumAbonado;
 sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)szhBAJAABO;
 sqlstm.sqhstl[8] = (unsigned long )4;
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
 sqlstm.sqphss = sqlstm.sqhsts;
 sqlstm.sqpind = sqlstm.sqindv;
 sqlstm.sqpins = sqlstm.sqinds;
 sqlstm.sqparm = sqlstm.sqharm;
 sqlstm.sqparc = sqlstm.sqharc;
 sqlstm.sqpadto = sqlstm.sqadto;
 sqlstm.sqptdso = sqlstm.sqtdso;
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	if( sqlca.sqlcode != SQLOK )	{   
		ifnTrazaHilos( modulo,&pfLog, "(Abonado:%ld) OPEN curAbonadosFri %s.", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );  
		return FALSE;	
	}

	while( TRUE )
	{
		sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
		/* EXEC SQL FETCH curAbonadosFri
		INTO	:lhNumAbonado2,
				:lhNumCelular2,
				:szhTipTerminal,
				:ihCodCentral,
				:szhNumSerieHex,
				:szhCodTecnologia,
				:szhNumSerie,
				:szhNumImei,
				:szhNumImsi; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 52;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2030;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&lhNumAbonado2;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&lhNumCelular2;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhTipTerminal;
  sqlstm.sqhstl[2] = (unsigned long )2;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&ihCodCentral;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhNumSerieHex;
  sqlstm.sqhstl[4] = (unsigned long )9;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhCodTecnologia;
  sqlstm.sqhstl[5] = (unsigned long )9;
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)szhNumSerie;
  sqlstm.sqhstl[6] = (unsigned long )26;
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)szhNumImei;
  sqlstm.sqhstl[7] = (unsigned long )26;
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)szhNumImsi;
  sqlstm.sqhstl[8] = (unsigned long )51;
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


		
		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{   
			ifnTrazaHilos( modulo,&pfLog, "(Abonado:%ld) FETCH curAbonadosFri %s.", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );  
			iError = 1;
			break;
		}
		if( sqlca.sqlcode == SQLNOTFOUND )	{   
			ifnTrazaHilos( modulo,&pfLog, "(Abonado:%ld) Fin Datos Cursor curAbonadosFri.", LOG03, lhNumAbonado );  
			break;
		}
	
		ifnTrazaHilos( modulo,&pfLog, "Friends Abonado %ld", LOG03, lhNumAbonado2 );

		/* desactivamos el friends family del segundo abonado */
		sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
		/* EXEC SQL
		UPDATE GA_SERVSUPLABO
		SET	 FEC_BAJABD = SYSDATE,
				 IND_ESTADO = :ihValor_Tres
		WHERE	 NUM_ABONADO = :lhNumAbonado2
		AND	 COD_SERVICIO = ( SELECT COD_FYFCEL FROM GA_DATOSGENER )
		AND	(IND_ESTADO < :ihValor_Tres or IND_ESTADO = :ihValor_Cinco ); */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 52;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "update GA_SERVSUPLABO  set FEC_BAJABD=SYSDATE,IND_ESTADO=:b\
0 where ((NUM_ABONADO=:b1 and COD_SERVICIO=(select COD_FYFCEL  from GA_DATOSGE\
NER )) and (IND_ESTADO<:b0 or IND_ESTADO=:b3))";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2081;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_Tres;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado2;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_Tres;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_Cinco;
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
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{   
			ifnTrazaHilos( modulo,&pfLog, "(Abonado:%ld) UPDATE GA_SERVSUPLABO %s.", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );  
			iError = 1;
			break;
		}

		if( sqlca.sqlcode == SQLNOTFOUND )	{   
			ifnTrazaHilos( modulo,&pfLog, "(Abonado:%ld) No es Friends del Abonado.", LOG03, lhNumAbonado2 );  
			continue;	/* vamos por el proximo abonado si existe */
		}

       	/* obtenemos la nueva cadena de servicios del segundo abonado */
        /*pszRet = (*szGetCadenaServNivelAbo)(&pfLog,  lhNumAbonado2, szhCadenaServNivel, CXX );*/
        pszRet = (*szGetCadenaServNivel)   (&pfLog,  lhNumAbonado2, szhCadenaServNivel, CXX );       /*CH-200408232102 Homologado por PGonzalez 22-11-2004 */
		sprintf ( szRet, "%s\0", pszRet );
		
		if ( strcmp( szRet, "OK" ) != 0 )	{				
			iError = 1;
			break;
		}

      	/* Actualizamos la GA_ABOCEL con los nuevos servicios */
		sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
		/* EXEC SQL 
		UPDATE GA_ABOCEL SET	 
		       CLASE_SERVICIO= :szhCadenaServNivel
		WHERE  NUM_ABONADO 	= :lhNumAbonado2; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 52;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "update GA_ABOCEL  set CLASE_SERVICIO=:b0 where NUM_ABONADO=\
:b1";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2112;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhCadenaServNivel;
  sqlstm.sqhstl[0] = (unsigned long )256;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado2;
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
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



		if ( sqlca.sqlcode != SQLOK )		{
			ifnTrazaHilos( modulo,&pfLog, "lhNumAbonado:[%ld] Error al actualizar GA_ABOCEL, CLASE_SERVICIO. %s ", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
			iError = 1;
			break;
		}

		sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
		/* EXEC SQL
		SELECT COD_ACTCEN
		INTO	 :ihCodActCen
		FROM	 GA_ACTABO 
		WHERE	 COD_ACTABO = :szhSS 
		AND	 COD_PRODUCTO = :ihProducto
		AND    COD_MODULO = :szhGA
		AND    COD_TECNOLOGIA = :szhCodTecnologia; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 52;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select COD_ACTCEN into :b0  from GA_ACTABO where (((COD_ACT\
ABO=:b1 and COD_PRODUCTO=:b2) and COD_MODULO=:b3) and COD_TECNOLOGIA=:b4)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2135;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihCodActCen;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhSS;
  sqlstm.sqhstl[1] = (unsigned long )3;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&ihProducto;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhGA;
  sqlstm.sqhstl[3] = (unsigned long )3;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhCodTecnologia;
  sqlstm.sqhstl[4] = (unsigned long )9;
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
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


		
		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )  {
			ifnTrazaHilos( modulo,&pfLog, "lhNumAbonado:[%ld] Error al actualizar GA_ABOCEL, CLASE_SERVICIO. %s ", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
			iError = 1;
			break;
		} 
		else if( sqlca.sqlcode == SQLNOTFOUND )   {  
	    	ihCodActCen = 0;
	    	ifnTrazaHilos( modulo,&pfLog, "No hay codigo de activacion en Central Abonado = %ld", LOG03, lhNumAbonado );
      } 

		ifnTrazaHilos( modulo,&pfLog, "lhNumAbonado:[%ld] ihCodActCen %d ", LOG03, lhNumAbonado2, ihCodActCen );
			 
	   if( ihCodActCen != 0 )   {
		    sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
		    /* EXEC SQL
		    SELECT 	ICC_SEQ_NUMMOV.NEXTVAL
		    INTO 	:lhNumMovimiento
		    FROM 	DUAL; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 52;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select ICC_SEQ_NUMMOV.nextval  into :b0  from DUAL ";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )2170;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&lhNumMovimiento;
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
      sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

       
	
		    if( sqlca.sqlcode != SQLOK )  {  
		    	ifnTrazaHilos( modulo,&pfLog, "SELECT ICC_SEQ_NUMMOV.NEXTVAL 1 Abonado:%ld %s", LOG05, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
				iError = 1;
				break;
		    } 

			ifnTrazaHilos( modulo,&pfLog, 	"Datos Insert Icc_Movimientos\n"
									"\t\tlhNumMovimiento    = [%ld],\n"
									"\t\tlhNumAbonado2      = [%ld],\n" 
									"\t\tihCodCentral       = [%d],\n"
									"\t\tlhNumCelular2      = [%ld],\n"
									"\t\tihCodActCen        = [%d],\n"
									"\t\tszhNumSerieHex     = [%s],\n"
									"\t\tszhServFyF         = [%s],\n"  
									"\t\tszhTipTerminal     = [%s],\n"
									"\t\tszhNumMin          = [%s],\n"
									"\t\tszhCodTecnologia   = [%s],\n"
									"\t\tszhNumSerie        = [%s],\n"
									"\t\tszhNumImei         = [%s],\n"
									"\t\tszhNumImsi         = [%s].\n",
									LOG03,
									lhNumMovimiento,
									lhNumAbonado2,
									ihCodCentral,
									lhNumCelular2,
									ihCodActCen,
									szhNumSerieHex,
									szhServFyF,               
									szhTipTerminal,
									szhNumMin,
									szhCodTecnologia,
									szhNumSerie,
									szhNumImei,
									szhNumImsi );

			sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
			/* EXEC SQL 
			INSERT INTO ICC_MOVIMIENTO 
			       (NUM_MOVIMIENTO,
					  NUM_ABONADO,
					  COD_ESTADO,
					  COD_MODULO,
					  NOM_USUARORA,
					  COD_CENTRAL,
					  NUM_CELULAR,
					  COD_ACTUACION,
					  FEC_INGRESO,
					  NUM_SERIE,
					  COD_SERVICIOS,
					  TIP_TERMINAL,
					  COD_ACTABO,
					  NUM_MIN,
					  TIP_TECNOLOGIA,		
					  IMEI,				
					  IMSI,
					  ICC ) 
			VALUES (:lhNumMovimiento,
					  :lhNumAbonado2,
					  :ihValor_Uno,
					  :szhModulo,
					  USER,
					  :ihCodCentral,
					  :lhNumCelular2,
					  :ihCodActCen,
					  SYSDATE,
					  :szhNumSerieHex,
					  :szhServFyF,
					  :szhTipTerminal,
					  :szhSS,
					  :szhNumMin,
					  :szhCodTecnologia,	
					  :szhNumImei,		
					  :szhNumImsi,
					  :szhNumSerie	); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 52;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "insert into ICC_MOVIMIENTO (NUM_MOVIMIENTO,NUM_ABONADO,COD\
_ESTADO,COD_MODULO,NOM_USUARORA,COD_CENTRAL,NUM_CELULAR,COD_ACTUACION,FEC_INGR\
ESO,NUM_SERIE,COD_SERVICIOS,TIP_TERMINAL,COD_ACTABO,NUM_MIN,TIP_TECNOLOGIA,IME\
I,IMSI,ICC) values (:b0,:b1,:b2,:b3,USER,:b4,:b5,:b6,SYSDATE,:b7,:b8,:b9,:b10,\
:b11,:b12,:b13,:b14,:b15)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )2189;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&lhNumMovimiento;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado2;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_Uno;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhModulo;
   sqlstm.sqhstl[3] = (unsigned long )3;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&ihCodCentral;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)&lhNumCelular2;
   sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)&ihCodActCen;
   sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)szhNumSerieHex;
   sqlstm.sqhstl[7] = (unsigned long )9;
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)szhServFyF;
   sqlstm.sqhstl[8] = (unsigned long )256;
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)szhTipTerminal;
   sqlstm.sqhstl[9] = (unsigned long )2;
   sqlstm.sqhsts[9] = (         int  )0;
   sqlstm.sqindv[9] = (         short *)0;
   sqlstm.sqinds[9] = (         int  )0;
   sqlstm.sqharm[9] = (unsigned long )0;
   sqlstm.sqadto[9] = (unsigned short )0;
   sqlstm.sqtdso[9] = (unsigned short )0;
   sqlstm.sqhstv[10] = (unsigned char  *)szhSS;
   sqlstm.sqhstl[10] = (unsigned long )3;
   sqlstm.sqhsts[10] = (         int  )0;
   sqlstm.sqindv[10] = (         short *)0;
   sqlstm.sqinds[10] = (         int  )0;
   sqlstm.sqharm[10] = (unsigned long )0;
   sqlstm.sqadto[10] = (unsigned short )0;
   sqlstm.sqtdso[10] = (unsigned short )0;
   sqlstm.sqhstv[11] = (unsigned char  *)szhNumMin;
   sqlstm.sqhstl[11] = (unsigned long )4;
   sqlstm.sqhsts[11] = (         int  )0;
   sqlstm.sqindv[11] = (         short *)0;
   sqlstm.sqinds[11] = (         int  )0;
   sqlstm.sqharm[11] = (unsigned long )0;
   sqlstm.sqadto[11] = (unsigned short )0;
   sqlstm.sqtdso[11] = (unsigned short )0;
   sqlstm.sqhstv[12] = (unsigned char  *)szhCodTecnologia;
   sqlstm.sqhstl[12] = (unsigned long )9;
   sqlstm.sqhsts[12] = (         int  )0;
   sqlstm.sqindv[12] = (         short *)0;
   sqlstm.sqinds[12] = (         int  )0;
   sqlstm.sqharm[12] = (unsigned long )0;
   sqlstm.sqadto[12] = (unsigned short )0;
   sqlstm.sqtdso[12] = (unsigned short )0;
   sqlstm.sqhstv[13] = (unsigned char  *)szhNumImei;
   sqlstm.sqhstl[13] = (unsigned long )26;
   sqlstm.sqhsts[13] = (         int  )0;
   sqlstm.sqindv[13] = (         short *)0;
   sqlstm.sqinds[13] = (         int  )0;
   sqlstm.sqharm[13] = (unsigned long )0;
   sqlstm.sqadto[13] = (unsigned short )0;
   sqlstm.sqtdso[13] = (unsigned short )0;
   sqlstm.sqhstv[14] = (unsigned char  *)szhNumImsi;
   sqlstm.sqhstl[14] = (unsigned long )51;
   sqlstm.sqhsts[14] = (         int  )0;
   sqlstm.sqindv[14] = (         short *)0;
   sqlstm.sqinds[14] = (         int  )0;
   sqlstm.sqharm[14] = (unsigned long )0;
   sqlstm.sqadto[14] = (unsigned short )0;
   sqlstm.sqtdso[14] = (unsigned short )0;
   sqlstm.sqhstv[15] = (unsigned char  *)szhNumSerie;
   sqlstm.sqhstl[15] = (unsigned long )26;
   sqlstm.sqhsts[15] = (         int  )0;
   sqlstm.sqindv[15] = (         short *)0;
   sqlstm.sqinds[15] = (         int  )0;
   sqlstm.sqharm[15] = (unsigned long )0;
   sqlstm.sqadto[15] = (unsigned short )0;
   sqlstm.sqtdso[15] = (unsigned short )0;
   sqlstm.sqphsv = sqlstm.sqhstv;
   sqlstm.sqphsl = sqlstm.sqhstl;
   sqlstm.sqphss = sqlstm.sqhsts;
   sqlstm.sqpind = sqlstm.sqindv;
   sqlstm.sqpins = sqlstm.sqinds;
   sqlstm.sqparm = sqlstm.sqharm;
   sqlstm.sqparc = sqlstm.sqharc;
   sqlstm.sqpadto = sqlstm.sqadto;
   sqlstm.sqptdso = sqlstm.sqtdso;
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



		    if( sqlca.sqlcode != SQLOK )   {  
		    	ifnTrazaHilos( modulo,&pfLog, "INSERT INTO ICC_MOVIMIENTO Abonado:%ld %s", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
				iError = 1;
				break;
		    } 
    	} /* if( ihCodActCen != 0 ) */
    	
		/* Obtenemos fechas para actualizar la GA_INTARCEL */
		sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
		/* EXEC SQL EXECUTE
			BEGIN
				:szhFecha   := TO_CHAR( SYSDATE, :szhDDMMYYYYHH24MISS );
				:szhFechaIni:= TO_CHAR( SYSDATE + :fh00001, :szhDDMMYYYYHH24MISS );
			END;
		END-EXEC; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 52;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "begin :szhFecha := TO_CHAR ( SYSDATE , :szhDDMMYYYYHH24MISS\
 ) ; :szhFechaIni := TO_CHAR ( SYSDATE + :fh00001 , :szhDDMMYYYYHH24MISS ) ; E\
ND ;";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2268;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhFecha;
  sqlstm.sqhstl[0] = (unsigned long )20;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhDDMMYYYYHH24MISS;
  sqlstm.sqhstl[1] = (unsigned long )22;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhFechaIni;
  sqlstm.sqhstl[2] = (unsigned long )20;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&fh00001;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(float);
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
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


		if( sqlca.sqlcode != SQLOK )   {  
	    	ifnTrazaHilos( modulo,&pfLog, "Error al recuperar Fechas Abonado:%ld %s", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
			iError = 1;
			break;
	   } 

		/* Recuperamos el rowid del registro de ciclo actual en la GA_INTARCEL */
		sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
		/* EXEC SQL
		SELECT ROWIDTOCHAR( ROWID )
		INTO	 :szhRowid
		FROM	 GA_INTARCEL
		WHERE	 COD_CLIENTE	= :lhCodCliente
		AND	 NUM_ABONADO	= :lhNumAbonado2
		AND	 SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 52;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select ROWIDTOCHAR(ROWID) into :b0  from GA_INTARCEL where \
((COD_CLIENTE=:b1 and NUM_ABONADO=:b2) and SYSDATE between FEC_DESDE and FEC_H\
ASTA)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2299;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
  sqlstm.sqhstl[0] = (unsigned long )19;
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
  sqlstm.sqhstv[2] = (unsigned char  *)&lhNumAbonado2;
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
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND ) {  
	    	ifnTrazaHilos( modulo,&pfLog, "Error al recuperar periodo GA_INTARCEL Abonado:%ld %s", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
			iError = 1;
			break;
	   } 
	   else if( sqlca.sqlcode == SQLNOTFOUND )   {
			continue;	/* si hay mas abonados, aunque no debiera */    	
		}
		
		ifnTrazaHilos( modulo,&pfLog, "Rowid %s", LOG05, szhRowid );
		
		/* comprobamos si ya se abrio un ciclo futuro para el abonado */
		sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
		/* EXEC SQL
		SELECT NVL( MIN( TO_CHAR( FEC_DESDE, :szhDDMMYYYYHH24MISS ) ), :szhUno )
		INTO	 :szhFechaMin
		FROM	 GA_INTARCEL
		WHERE	 COD_CLIENTE = :lhCodCliente
		AND	 NUM_ABONADO = :lhNumAbonado2
		AND	 FEC_DESDE > TO_DATE( :szhFecha, :szhDDMMYYYYHH24MISS ); */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 52;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select NVL(min(TO_CHAR(FEC_DESDE,:b0)),:b1) into :b2  from \
GA_INTARCEL where ((COD_CLIENTE=:b3 and NUM_ABONADO=:b4) and FEC_DESDE>TO_DATE\
(:b5,:b0))";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2326;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhDDMMYYYYHH24MISS;
  sqlstm.sqhstl[0] = (unsigned long )22;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhUno;
  sqlstm.sqhstl[1] = (unsigned long )2;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhFechaMin;
  sqlstm.sqhstl[2] = (unsigned long )20;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&lhCodCliente;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&lhNumAbonado2;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhFecha;
  sqlstm.sqhstl[5] = (unsigned long )20;
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)szhDDMMYYYYHH24MISS;
  sqlstm.sqhstl[6] = (unsigned long )22;
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
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND ) {  
	    	ifnTrazaHilos( modulo,&pfLog, "SELECT MIN FECHA GA_INTARCEL Abonado:%ld %s", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
			iError = 1;
			break;
	   } 
		
		if( !strcmp( szhFechaMin, "0" ) ) {
			/* si no hay ciclo futuro el nuevo sera el ultimo */
			strcpy( szhFechaFin, "31-12-3000 00:00:00" );
		}
		else
		{
			/* si hay ciclo futuro, debemos cortar el actual, para crear el resto del que queda */
			sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
			/* EXEC SQL EXECUTE
				BEGIN
				:szhFechaFin:= TO_CHAR( TO_DATE( :szhFechaMin, :szhDDMMYYYYHH24MISS ) - :fh00001, :szhDDMMYYYYHH24MISS );
				END;
			END-EXEC; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 52;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "begin :szhFechaFin := TO_CHAR ( TO_DATE ( :szhFechaMin , :\
szhDDMMYYYYHH24MISS ) -:fh00001 , :szhDDMMYYYYHH24MISS ) ; END ;";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )2369;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhFechaFin;
   sqlstm.sqhstl[0] = (unsigned long )20;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhFechaMin;
   sqlstm.sqhstl[1] = (unsigned long )20;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhDDMMYYYYHH24MISS;
   sqlstm.sqhstl[2] = (unsigned long )22;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&fh00001;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(float);
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
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


			if( sqlca.sqlcode != SQLOK )   {  
		    	ifnTrazaHilos( modulo,&pfLog, "Recuperando Fecha Fin GA_INTARCEL Abonado:%ld %s", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
				iError = 1;
				break;
		   } 
		
		} /* if( !strcmp( szhFechaMin, "0" ) ) */	

		/* actualizamos el indicador de FyF, del ciclo futuro */
		sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
		/* EXEC SQL
		UPDATE  GA_INTARCEL SET		
		        IND_FRIENDS = :ihValor_Cero
		WHERE	  COD_CLIENTE = :lhCodCliente
		AND	  NUM_ABONADO = :lhNumAbonado2
		AND	  FEC_DESDE 	> TO_DATE( :szhFecha, :szhDDMMYYYYHH24MISS); */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 52;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "update GA_INTARCEL  set IND_FRIENDS=:b0 where ((COD_CLIENTE\
=:b1 and NUM_ABONADO=:b2) and FEC_DESDE>TO_DATE(:b3,:b4))";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2400;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_Cero;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
  sqlstm.sqhstv[2] = (unsigned char  *)&lhNumAbonado2;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhFecha;
  sqlstm.sqhstl[3] = (unsigned long )20;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhDDMMYYYYHH24MISS;
  sqlstm.sqhstl[4] = (unsigned long )22;
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
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


		
		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )  {  
	    	ifnTrazaHilos( modulo,&pfLog, "UPDATE GA_INTARCEL IND_FRIENDS = 0 Abonado:%ld %s", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
			iError = 1;
			break;
	   } 
		
		/* insertamos un nuevo registro en la GA_INTARCEL */
		sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
		/* EXEC SQL
		INSERT INTO GA_INTARCEL	
		      (COD_CLIENTE,
				 NUM_ABONADO,
				 IND_NUMERO,
				 FEC_DESDE,
				 FEC_HASTA,
				 IMP_LIMCONSUMO,
				 IND_FRIENDS,
				 IND_DIASESP,
				 COD_CELDA,
				 TIP_PLANTARIF,
				 COD_PLANTARIF,
				 NUM_SERIE,
				 NUM_CELULAR,
				 COD_CARGOBASICO,
				 COD_CICLO,
				 COD_PLANCOM,
				 COD_PLANSERV,
				 COD_GRPSERV,
				 COD_GRUPO,
				 COD_PORTADOR,
				 COD_USO,
				 NUM_IMSI )
		SELECT COD_CLIENTE,
				 NUM_ABONADO,
				 IND_NUMERO,
				 TO_DATE( :szhFechaIni, :szhDDMMYYYYHH24MISS ),
				 TO_DATE( :szhFechaFin, :szhDDMMYYYYHH24MISS ),
				 IMP_LIMCONSUMO,
				 :ihValor_Cero,
				 IND_DIASESP,
				 COD_CELDA,
				 TIP_PLANTARIF,
				 COD_PLANTARIF,
				 NUM_SERIE,
				 NUM_CELULAR,
				 COD_CARGOBASICO,
				 COD_CICLO,
				 COD_PLANCOM,
				 COD_PLANSERV,
				 COD_GRPSERV,
				 COD_GRUPO,
				 COD_PORTADOR,
				 COD_USO,
				 NUM_IMSI
		FROM	 GA_INTARCEL
		WHERE	 ROWID = CHARTOROWID( :szhRowid ); */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 52;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "insert into GA_INTARCEL (COD_CLIENTE,NUM_ABONADO,IND_NUMERO\
,FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,IND_FRIENDS,IND_DIASESP,COD_CELDA,TIP_PLAN\
TARIF,COD_PLANTARIF,NUM_SERIE,NUM_CELULAR,COD_CARGOBASICO,COD_CICLO,COD_PLANCO\
M,COD_PLANSERV,COD_GRPSERV,COD_GRUPO,COD_PORTADOR,COD_USO,NUM_IMSI)select COD_\
CLIENTE ,NUM_ABONADO ,IND_NUMERO ,TO_DATE(:b0,:b1) ,TO_DATE(:b2,:b1) ,IMP_LIMC\
ONSUMO ,:b4 ,IND_DIASESP ,COD_CELDA ,TIP_PLANTARIF ,COD_PLANTARIF ,NUM_SERIE ,\
NUM_CELULAR ,COD_CARGOBASICO ,COD_CICLO ,COD_PLANCOM ,COD_PLANSERV ,COD_GRPSER\
V ,COD_GRUPO ,COD_PORTADOR ,COD_USO ,NUM_IMSI  from GA_INTARCEL where ROWID=CH\
ARTOROWID(:b5)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2435;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhFechaIni;
  sqlstm.sqhstl[0] = (unsigned long )20;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhDDMMYYYYHH24MISS;
  sqlstm.sqhstl[1] = (unsigned long )22;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhFechaFin;
  sqlstm.sqhstl[2] = (unsigned long )20;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhDDMMYYYYHH24MISS;
  sqlstm.sqhstl[3] = (unsigned long )22;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&ihValor_Cero;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhRowid;
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
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



		if( sqlca.sqlcode != SQLOK )   {  
	    	ifnTrazaHilos( modulo,&pfLog, "INSERT INTO GA_INTARCEL Abonado:%ld %s", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
			iError = 1;
			break;
	   } 
		
		/* el ciclo que era actual, lo cerramos, ya creamos el nuevo registro */
		sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
		/* EXEC SQL
		UPDATE GA_INTARCEL  SET	 
		       FEC_HASTA = TO_DATE( :szhFecha, :szhDDMMYYYYHH24MISS )
		WHERE	 ROWID = CHARTOROWID( :szhRowid ); */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 52;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "update GA_INTARCEL  set FEC_HASTA=TO_DATE(:b0,:b1) where RO\
WID=CHARTOROWID(:b2)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2474;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhFecha;
  sqlstm.sqhstl[0] = (unsigned long )20;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhDDMMYYYYHH24MISS;
  sqlstm.sqhstl[1] = (unsigned long )22;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhRowid;
  sqlstm.sqhstl[2] = (unsigned long )19;
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
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )   {  
	    	ifnTrazaHilos( modulo,&pfLog, "UPDATE GA_INTARCEL IND_FRIENDS = 0 Abonado:%ld %s", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
			iError = 1;
			break;
	   } 
	} /* while( TRUE ) */
	
	sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
	/* EXEC SQL CLOSE curAbonadosFri; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 52;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2501;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	if( sqlca.sqlcode != SQLOK ) {  
    	ifnTrazaHilos( modulo,&pfLog, "CLOSE curAbonadosFri Abonado:%ld %s", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
		iError = 1;
   } 

	if( iError == 1 )
		return FALSE;
		
	return TRUE;
} /* bfnDesactivarServSuplFriendsAbo */


/*********************************************************************************************************/
/* Se modifica funcion ejecutando llamado a PL CO_ACTIVAGARANTIA_PR                                      */
/*********************************************************************************************************/
BOOL bfnCancelaGarantiaPago(FILE **ptArchLog, long lCodCliente, sql_context ctxCont) 
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long	lhCodCliente;
	long  lhNum_Transaccion     ;
	int   ihRetorno             ;
	char  szhGlosa         [500];
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char	modulo[] = "bfnCancelaGarantiaPago";
FILE *pfLog=*ptArchLog;
struct sqlca sqlca;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 
 

	ifnTrazaHilos( modulo,&pfLog, "1. Ingresando Modulo %s", LOG05, modulo );
	lhCodCliente = lCodCliente;

	/* EXEC SQL
	SELECT GA_SEQ_TRANSACABO.NEXTVAL
	INTO   :lhNum_Transaccion
	FROM   DUAL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 52;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select GA_SEQ_TRANSACABO.nextval  into :b0  from DUAL ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2516;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhNum_Transaccion;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	if (sqlca.sqlcode != SQLOK) {
	    ifnTrazaHilos( modulo,&pfLog, "SELECT GA_SEQ_TRANSACABO.NEXTVAL - %s", LOG00, modulo,sqlca.sqlerrm.sqlerrmc );
	    return FALSE;
	}
	
	lhCodCliente=lCodCliente;
	ifnTrazaHilos( modulo,&pfLog, "\n\t\t******************************"
							            "\n\t\t=> lhCodCliente      [%ld]"
							            "\n\t\t=> lhNum_Transaccion [%ld]\n\n",LOG03, lhCodCliente ,lhNum_Transaccion );

	/* EXEC SQL EXECUTE
		BEGIN
				CO_ACTIVAGARANTIA_PR(:lhCodCliente, :lhNum_Transaccion , :ihRetorno , :szhGlosa );
		END;
	END-EXEC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 52;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "begin CO_ACTIVAGARANTIA_PR ( :lhCodCliente , :lhNum_Transacc\
ion , :ihRetorno , :szhGlosa ) ; END ;";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2535;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCliente;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lhNum_Transaccion;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&ihRetorno;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhGlosa;
 sqlstm.sqhstl[3] = (unsigned long )500;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	
	if (sqlca.sqlcode != SQLOK ) {
      ifnTrazaHilos( modulo,&pfLog, "Cliente = %ld, Error al actualizar GARANTIA DE PAGO. - %s", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );
      ifnTrazaHilos( modulo,&pfLog, "CO_ACTIVAGARANTIA_PR ihRetorno [%d] - szhGlosa [%s]", LOG03, ihRetorno, szhGlosa );
		return FALSE;

   }

	ifnTrazaHilos( modulo,&pfLog, "CO_ACTIVAGARANTIA_PR Termino OK.\n", LOG03 );
	return TRUE;
} /* BOOL bfnCancelaGarantiaPago( long lCodCliente ) */

/*********************************************************************************************************/
/*********************************************************************************************************/
BOOL bfnEjecutaPLCoBajasAbo(FILE **ptArchLog, long lNumAbonado, char *szAccion, sql_context ctxCont) 
{
/*
	Llamamos a la PL CO_BAJAS_ABO 
*/
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long	lhNumAbonado;
	char	szhAccion[5];
	long	lhNumSecuencia;
	int		ihRetornoPL = 0;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char	modulo[] = "bfnEjecutaPLCoBajasAbo";
FILE *pfLog=*ptArchLog;
struct sqlca sqlca;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

	ifnTrazaHilos( modulo,&pfLog, "Ingresando Modulo %s", LOG05, modulo );
	
	memset( szhAccion, '\0', sizeof( szhAccion ) );
	
	lhNumAbonado = lNumAbonado;
	strcpy( szhAccion, szAccion );
	
	sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
	/* EXEC SQL
	SELECT	GA_SEQ_TRANSACABO.NEXTVAL
	INTO	:lhNumSecuencia
	FROM	DUAL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 52;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select GA_SEQ_TRANSACABO.nextval  into :b0  from DUAL ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2566;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSecuencia;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	
	if( sqlca.sqlcode )
	{
		ifnTrazaHilos( modulo,&pfLog, "Abonado = %ld, SELECT GA_SEQ_TRANSACABO.NEXTVAL %s", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
	}
	
	sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
	/* EXEC SQL EXECUTE
		BEGIN
			CO_BAJAS_ABO( :lhNumSecuencia, :lhNumAbonado, :szhAccion );
		END;
	END-EXEC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 52;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "begin CO_BAJAS_ABO ( :lhNumSecuencia , :lhNumAbonado , :szhA\
ccion ) ; END ;";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2585;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSecuencia;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhAccion;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

 
	
	ifnTrazaHilos( modulo,&pfLog, "Retorno PL CO_BAJAS_ABO => [%d].", LOG05, sqlca.sqlcode );

	sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
	/* EXEC SQL 
	SELECT	COD_RETORNO
	INTO	:ihRetornoPL
	FROM	GA_TRANSACABO
	WHERE	NUM_TRANSACCION = :lhNumSecuencia; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 52;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select COD_RETORNO into :b0  from GA_TRANSACABO where NUM_TR\
ANSACCION=:b1";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2612;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihRetornoPL;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSecuencia;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	
	if( sqlca.sqlcode ) 
	{
		ifnTrazaHilos( modulo,&pfLog, "Abonado = %ld, SELECT COD_RETORNO GA_TRANSACABO %s", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
		return FALSE;	
	}
	else if( ihRetornoPL != 0 )
	{
		ifnTrazaHilos( modulo,&pfLog, "En CO_BAJAS_ABO (Transaccion:%ld)(Abonado:%ld)(Accion:'BAJA')",
								LOG00, lhNumSecuencia, lhNumAbonado, szhAccion );
		return FALSE;
	}
	
	return TRUE;
} /* BOOL bfnEjecutaPLCoBajasAbo( long lNumAbonado, int iCodActuacion ) */

BOOL bfnHibernacionEquipo(FILE **ptArchLog, long lNumEquipo, int iCodCentral, int iCodUso, sql_context ctxCont) 
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int	ihCodUsoRango;
	int	ihCodUsoActual;
	int	ihCnt;
	int	ihCodCat;
	int	ihCodCentral;
	char	szhCodSubAlm[6];	/* EXEC SQL VAR szhCodSubAlm IS STRING(6); */ 
 
	long	lhNumEquipo;
	char  szhFiller  [2];
	int   ihValor_uno = 1;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char	modulo[] = "bfnHibernacionEquipo";
FILE *pfLog=*ptArchLog;
struct sqlca sqlca;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

	memset( szhCodSubAlm, '\0', sizeof( szhCodSubAlm ) );
	memset( &ihCodCentral, 0, sizeof( ihCodCentral ) );
	memset( &ihCodCat, 0, sizeof( ihCodCat ) );
	memset( &ihCodUsoActual, 0, sizeof( ihCodUsoActual ) );
	memset( &ihCodUsoRango, 0, sizeof( ihCodUsoRango ) );
	memset( &lhNumEquipo, 0, sizeof( lhNumEquipo ) );

	ifnTrazaHilos( modulo,&pfLog, "Ingresando Modulo %s", LOG05, modulo );
	strcpy(szhFiller," ");
	ihCodCentral = iCodCentral;
	ihCodUsoActual	= iCodUso;
	lhNumEquipo  = lNumEquipo;
	
	/* revisamos si el celular se encuentra en hibernacion */
	sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
	/* EXEC SQL
	SELECT COUNT(*)
	INTO	 :ihCnt
	FROM	 GA_CELNUM_REUTIL
	WHERE	 NUM_CELULAR = :lhNumEquipo; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 52;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(*)  into :b0  from GA_CELNUM_REUTIL where NUM_C\
ELULAR=:b1";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2635;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCnt;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lhNumEquipo;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
	{
		ifnTrazaHilos( modulo,&pfLog, "Equipo => [%ld], Verificando existencia en GA_CELNUM_REUTIL => [%s]", LOG00, lhNumEquipo, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
	}

	if( ihCnt == 0 )	/* no esta en hibernacion */
	{
		/* obtenemos datos para hibernacion */
		sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
		/* EXEC SQL
		SELECT NVL( C.COD_SUBALM, :szhFiller ),
				C.COD_CAT,
				C.COD_USO,
				C.COD_CENTRAL
		INTO	:szhCodSubAlm,
				:ihCodCat,
				:ihCodUsoRango, 
				:ihCodCentral   /o Homol. a CH-200403021704  GAC o/
		FROM	GA_CELNUM_USO C
		WHERE	:lhNumEquipo BETWEEN C.NUM_DESDE AND C.NUM_HASTA; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 52;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select NVL(C.COD_SUBALM,:b0) ,C.COD_CAT ,C.COD_USO ,C.COD_C\
ENTRAL into :b1,:b2,:b3,:b4  from GA_CELNUM_USO C where :b5 between C.NUM_DESD\
E and C.NUM_HASTA";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2658;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhFiller;
  sqlstm.sqhstl[0] = (unsigned long )2;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhCodSubAlm;
  sqlstm.sqhstl[1] = (unsigned long )6;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&ihCodCat;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&ihCodUsoRango;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&ihCodCentral;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)&lhNumEquipo;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
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
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


		
		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
		{
			ifnTrazaHilos( modulo,&pfLog, "Equipo => [%ld], SELECT FROM GA_CELNUM_USO => [%s]", LOG00, lhNumEquipo, sqlca.sqlerrm.sqlerrmc );
			return FALSE;
		}
		else if( sqlca.sqlcode == SQLNOTFOUND )
		{
			ifnTrazaHilos( modulo,&pfLog, "Equipo => [%ld], NO PERTENECE A RANGO DEFINIDO EN GA_CELNUM_USO.", LOG02, lhNumEquipo );
			return FALSE;
		}
		else
		{
			ifnTrazaHilos( modulo,&pfLog, "Valores a insertar GA_CELNUM_REUTIL.\n"
								"\t\t   lhNumEquipo      => [%ld],\n"
								"\t\t   szhCodSubAlm     => [%s],\n"
								"\t\t   ihCodCentral     => [%d],\n"
								"\t\t   ihCodCat         => [%d],\n"
								"\t\t   ihCodUsoActual   => [%d],\n"
								"\t\t   ihCodUsoRango    => [%d],\n",
								LOG05,          
								lhNumEquipo,
								szhCodSubAlm,
								ihCodCentral,
								ihCodCat,
								ihCodUsoActual,
								ihCodUsoRango );

			sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
			/* EXEC SQL
			INSERT  INTO GA_CELNUM_REUTIL (
				     NUM_CELULAR  ,	COD_SUBALM	,	COD_PRODUCTO,	COD_CENTRAL  ,	COD_CAT    ,	
				     COD_USO	   ,	FEC_BAJA    ,	IND_EQUIPADO,	USO_ANTERIOR			) 
			VALUES (:lhNumEquipo	,	:szhCodSubAlm,	:ihValor_uno	,	:ihCodCentral ,	:ihCodCat,      
				     :ihCodUsoActual	,	SYSDATE   ,	:ihValor_uno	,	:ihCodUsoRango			); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 52;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "insert into GA_CELNUM_REUTIL (NUM_CELULAR,COD_SUBALM,COD_P\
RODUCTO,COD_CENTRAL,COD_CAT,COD_USO,FEC_BAJA,IND_EQUIPADO,USO_ANTERIOR) values\
 (:b0,:b1,:b2,:b3,:b4,:b5,SYSDATE,:b2,:b7)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )2697;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&lhNumEquipo;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhCodSubAlm;
   sqlstm.sqhstl[1] = (unsigned long )6;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_uno;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&ihCodCentral;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&ihCodCat;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)&ihCodUsoActual;
   sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)&ihValor_uno;
   sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)&ihCodUsoRango;
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
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


		
			if( sqlca.sqlcode )
			{ 
				ifnTrazaHilos( modulo,&pfLog, "Equipo => [%ld], INSERT INTO GA_CELNUM_REUTIL => [%s].", LOG00, lhNumEquipo, sqlca.sqlerrm.sqlerrmc );
				return FALSE;
			}	
		}
	}
	else
	{
		ifnTrazaHilos( modulo,&pfLog, "Equipo => [%ld], YA SE ENCUENTRA EN GA_CELNUM_REUTIL.", LOG02, lhNumEquipo );
	}

	return TRUE;
} /* BOOL bfnHibernacionEquipo( long lNumEquipo ) */	


/******************************************************************************************************/
BOOL bfnObtServSuplAboAct(FILE **ptArchLog, long lNumAbonado, char *szCadena, sql_context ctxCont) 
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long	lhNumAbonado;
	int	ihCodServSupl;
	int	ihCodNivel;
	int   ihValor_tres = 3;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 
       
char 	modulo[] = "bfnObtServSuplAboAct";
char	szCadenaAux[256];
BOOL	bSinError = TRUE;
FILE *pfLog=*ptArchLog;
struct sqlca sqlca;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 
 	
	lhNumAbonado = lNumAbonado;            
	memset ( szCadenaAux, 0, sizeof( szCadenaAux ) );
	
	sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
	/* EXEC SQL DECLARE curGaServSupl CURSOR FOR
	SELECT COD_SERVSUPL, 
			COD_NIVEL 
	FROM 	GA_SERVSUPLABO
	WHERE NUM_ABONADO = :lhNumAbonado
	AND 	IND_ESTADO < :ihValor_tres; */ 
 

	if ( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
	{
		ifnTrazaHilos( modulo,&pfLog, "lhNumAbonado:[%ld] DECLARE curGaServSupl. %s ", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
	}

	sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
	/* EXEC SQL OPEN curGaServSupl; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 52;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0062;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2744;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhNumAbonado;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihValor_tres;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	if ( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
	{
		ifnTrazaHilos( modulo,&pfLog, "lhNumAbonado:[%ld] OPEN curGaServSupl. %s ", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
	}
	
	while( bSinError )
	{		
		sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
		/* EXEC SQL 
		FETCH	curGaServSupl 
		INTO	:ihCodServSupl,
				:ihCodNivel; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 52;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2767;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihCodServSupl;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&ihCodNivel;
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
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
		{
			ifnTrazaHilos( modulo,&pfLog, "lhNumAbonado:[%ld] FETCH curGaServSupl. %s ", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
			bSinError = FALSE;
		}
		else if( sqlca.sqlcode == SQLNOTFOUND )
		{
			ifnTrazaHilos( modulo,&pfLog, "lhNumAbonado:[%ld] Fin Datos curGaServSupl.", LOG03, lhNumAbonado );
			break;
		}
		else
		{
			ihCodNivel = 0;
			sprintf ( szCadenaAux, "%s%02d%04d", szCadenaAux, ihCodServSupl, ihCodNivel );
		}
	}

	sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
	/* EXEC SQL CLOSE curGaServSupl; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 52;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2790;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	if ( sqlca.sqlcode )
	{
		ifnTrazaHilos( modulo,&pfLog, "lhNumAbonado:[%ld] CLOSE curGaSurple. %s ", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
	}

	if( !bSinError )
		return FALSE;
		
	sprintf( szCadena, "%s", szCadenaAux );
	ifnTrazaHilos( modulo,&pfLog, "bfnObtServSuplAboAct, lhNumAbonado:[%ld] Retorno Cadena. %s ", LOG03, lhNumAbonado, szCadena );

	return TRUE;
} /* BOOL bfnObtServSuplAboAct( long lNumAbonado, char *szCadena ) */

/*********************************************************************************************************/
int ifnCiclFactVigenteAbonado(FILE **ptArchLog, long lCodCliente, long lNumAbonado, int iCodCiclFact, sql_context ctxCont) 
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long	lhCodCliente = 0;
	long	lhNumAbonado = 0;
	int	ihCodCiclFact = 0;
	int	ihCnt = 0;
	int   ihValor_uno = 1;	
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char	modulo[] = "ifnCiclFactVigenteAbonado";
FILE *pfLog=*ptArchLog;
struct sqlca sqlca;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

	ifnTrazaHilos( modulo,&pfLog, "Ingresando Modulo %s", LOG05, modulo );

	lhCodCliente = lCodCliente;
	lhNumAbonado = lNumAbonado;
	ihCodCiclFact = iCodCiclFact;
	
	/* Verifica si el par cliente/abonado tiene periodo vigente */
	sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
	/* EXEC SQL
	SELECT COUNT( COD_CICLFACT )
	INTO  :ihCnt
	FROM 	GA_INFACCEL  
	WHERE COD_CLIENTE  = :lhCodCliente 
	AND   NUM_ABONADO  = :lhNumAbonado
	AND	COD_CICLFACT = :ihCodCiclFact 
	AND   IND_ACTUAC = :ihValor_uno; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 52;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(COD_CICLFACT) into :b0  from GA_INFACCEL where \
(((COD_CLIENTE=:b1 and NUM_ABONADO=:b2) and COD_CICLFACT=:b3) and IND_ACTUAC=:\
b4)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2805;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCnt;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
 sqlstm.sqhstv[2] = (unsigned char  *)&lhNumAbonado;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihCodCiclFact;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&ihValor_uno;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



	if ( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
	{
		ifnTrazaHilos( modulo,&pfLog, "Cliente = %ld. Validando Ciclo de Facturacion [%s]", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );
		return -1;
	}

	if( ihCnt == 0 ) /* El par cliente/abonado no tiene ciclo vigente */
	{
		ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld], Abonado => [%ld]. No tiene Ciclo Vigente en GA_INFACCEL.", LOG03, lhCodCliente, lhNumAbonado );  
		return 0;
	}
	
	ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld], Abonado => [%ld]. Tiene Ciclo Vigente en GA_INFACCEL.", LOG05, lhCodCliente, lhNumAbonado );  
	return 1;
} /* fin ifnCicloFactVigente */

/*********************************************************************************************************/
int ifnGetCodCiclFact(FILE **ptArchLog, int iCodCiclo, sql_context ctxCont) 
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int		ihCodCiclo = 0;
	int		ihCodCiclFac = 0;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char	modulo[] = "ifnGetCodCiclFact";
FILE *pfLog=*ptArchLog;
struct sqlca sqlca;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

	ifnTrazaHilos( modulo,&pfLog, "Ingresando Modulo %s", LOG05, modulo );

	ihCodCiclo = iCodCiclo;
	
	ifnTrazaHilos( modulo,&pfLog, 	"Datos entrada %s. iCodCiclo => [%d].", LOG05, modulo, iCodCiclo );

	/* recuperamos el ciclo de facturacion vigente segun parametro de entrada */
	sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
	/* EXEC SQL
	SELECT COD_CICLFACT
	INTO	:ihCodCiclFac
	FROM 	FA_CICLFACT
	WHERE COD_CICLO = :ihCodCiclo
	AND	SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 52;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select COD_CICLFACT into :b0  from FA_CICLFACT where (COD_CI\
CLO=:b1 and SYSDATE between FEC_DESDELLAM and FEC_HASTALLAM)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2840;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCodCiclFac;
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
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
 sqlstm.sqphss = sqlstm.sqhsts;
 sqlstm.sqpind = sqlstm.sqindv;
 sqlstm.sqpins = sqlstm.sqinds;
 sqlstm.sqparm = sqlstm.sqharm;
 sqlstm.sqparc = sqlstm.sqharc;
 sqlstm.sqpadto = sqlstm.sqadto;
 sqlstm.sqptdso = sqlstm.sqtdso;
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND ) 
	{
		ifnTrazaHilos( modulo,&pfLog, "CodCiclo => [%d]. Recuperando Codigo Ciclo de Facturacion [%s]", LOG00, ihCodCiclo, sqlca.sqlerrm.sqlerrmc );
		return -1;
	}
	
	if ( sqlca.sqlcode == SQLNOTFOUND )
	{
		ifnTrazaHilos( modulo,&pfLog, "CodCiclo => [%d]. No existe Codigo Ciclo de Facturacion Vigente.", LOG00, ihCodCiclo );
		return 0;
	}

	return	ihCodCiclFac;
} /* fin ifnGetCodCiclFact */

int ifnGetCodCiclFactCliente(FILE **ptArchLog, long lCodCliente, sql_context ctxCont) 
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long	lhCodCliente = 0;
	int	ihCodCiclo   = 0;
	int   ihUno_Negat = -1;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char	modulo[] = "ifnGetCodCiclFactCliente";
FILE *pfLog=*ptArchLog;
struct sqlca sqlca;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

	ifnTrazaHilos( modulo,&pfLog, "Ingresando Modulo %s", LOG05, modulo );

	lhCodCliente = lCodCliente;
	
	ifnTrazaHilos( modulo,&pfLog, 	"Datos entrada %s. iCliente => [%ld].", LOG05, modulo, lhCodCliente );

	/* recuperamos el ciclo de facturacion vigente segun parametro de entrada */
	sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
	/* EXEC SQL
	SELECT NVL( COD_CICLO, :ihUno_Negat )
	INTO	 :ihCodCiclo
	FROM 	 GE_CLIENTES
	WHERE  COD_CLIENTE = :lhCodCliente; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 52;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select NVL(COD_CICLO,:b0) into :b1  from GE_CLIENTES where C\
OD_CLIENTE=:b2";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2863;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihUno_Negat;
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
 sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCliente;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND ) 
	{
		ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld]. Recuperando Codigo Ciclo de Facturacion [%s]", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );
		return -1;
	}
	
	if ( sqlca.sqlcode == SQLNOTFOUND )
	{
		ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld]. No existe en GE_CLIENTES.", LOG03, lhCodCliente );
		return 0;
	}
	
	if ( ihCodCiclo < 0 )
	{
		ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld]. No tiene definido Ciclo de Facturacion en GE_CLIENTES.", LOG03, lhCodCliente );
		return 0;
	}
	
	ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld]. Ciclo de Facturacion en GE_CLIENTES => [%d]", LOG05, lhCodCliente, ihCodCiclo );
	return	ihCodCiclo;
} /* fin ifnGetCodCiclFact */



/******************************************************************************************/
/** InformaciÆn de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  %ARCHIVE% */
/** Identificador en PVCS                               : */
/**  %PID% */
/** Producto                                            : */
/**  %PP% */
/** RevisiÆn                                            : */
/**  %PR% */
/** Autor de la RevisiÆn                                : */
/**  %AUTHOR% */
/** Estado de la RevisiÆn ($TO_BE_DEFINED es Check-Out) : */
/**  %PS% */
/** Fecha de CreaciÆn de la RevisiÆn                    : */
/**  %DATE% */
/** Worksets ******************************************************************************/
/** %PIRW% */
/** Historia ******************************************************************************/
/** %PL% */
/******************************************************************************************/

