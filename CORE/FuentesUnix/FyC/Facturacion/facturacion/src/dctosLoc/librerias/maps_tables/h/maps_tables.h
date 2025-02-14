#ifndef NO_INDENT
#ident "@(#)$RCSfile: maps_tables.h,v $ $Revision: 1.10 $ $Date: 2008/08/04 21:25:28 $"
#endif

///
/// \file maps_tables.h
///


#ifndef MAP_TABLE_H
#define MAP_TABLE_H

#ifdef WIN32
#pragma warning (disable:4786)
#pragma warning (disable:4503)
#endif

#include "myString.h"
#include "range_map.h"
#include <iostream>
#include <string>
#include <vector>
#include <set>
#include <map>

using namespace std;

#define INDENT1LOGGER "@\t"
#define INDENT2LOGGER "@\t\t"
#define INDENT3LOGGER "@\t\t\t"
#define INDENT4LOGGER "@\t\t\t\t"
#define INDENT5LOGGER "@\t\t\t\t\t"
#define INDENT6LOGGER "@\t\t\t\t\t\t"
#define INDENT7LOGGER "@\t\t\t\t\t\t\t"
#define INDENT8LOGGER "@\t\t\t\t\t\t\t\t"
#define INDENT9LOGGER "@\t\t\t\t\t\t\t\t\t"
#define INDENT0LOGGER "@\t\t\t\t\t\t\t\t\t\t"
#define ENDLLOGGER "@\n";

#include "process_core_exception.h"

#define SECONDS_PER_HOUR 3600
#define SECONDS_PER_MINUTE 60

template < class STRING > 
int hhmmssToSec(const STRING &duracionHHMMSS)
{
    if(duracionHHMMSS.length() == 0) return 0;

    int durInSec = 0;

    int hora = 0;
    int minu = 0;
    int segu = 0;

    hora = atoi((duracionHHMMSS.substr(0, 2)).c_str());
    minu = atoi((duracionHHMMSS.substr(2, 2)).c_str());
    segu = atoi((duracionHHMMSS.substr(4, 2)).c_str());


    if(hora < 0 || hora > 99) return -1;
    if(minu < 0 || minu > 59) return -1;
    if(segu < 0 || segu > 59) return -1;

    durInSec = (hora * SECONDS_PER_HOUR) + (minu * SECONDS_PER_MINUTE) + segu;

    return durInSec;
}


void trim(MyString<>& s );

template<int SIZE> void trim(MyString<SIZE>& s )
{
    int j;
    for( j=s.length()-1; j >=0  &&  isspace(s[j]); j-- )
    {
    }
    s.erase( j + 1);

    int len = s.length();
    for( j=0; j < len  &&  isspace(s[j]); j++ )
    {
    }
    s.erase( 0, j );
};

void trim(string& s);
void trim(char* szpalabra);
void trim(const char* szpalabra);
void trim(char *szpalabra, int iini, int ilargo, char* szvuelta);

STRING date_minus_day(const char* yyyymmdd, int days);
bool bRestaFechas (char *szFecha1,char *szFecha2,int *iNumDias);
long gregorianoajuliano(int dia, int mes, int anno);


#define DATE_FORMAT_YYYYMMDD "yyyymmdd"
#define DATE_MAX_VALUE_YYYYMMDD "99991231"
#define DATE_MAX_VALUE_YYYYMMDDHH24MISS "99991231235959"
#define DATE_FORMAT_YYYYMMDDHH24MISS "yyyymmddhh24miss"


//#ifdef _USE_ORA_OCI_NUMBER
/// La especificacion del formato toma en cuenta el indicador de
/// signo para el numero, es por eso que en el formato solo
/// estan indicados 13 nueves para la parte entera
#define DECIMAL_FORMAT_14_4 "9999999999990D9999"
#define DECIMAL_FORMAT_8_2  "9999990D99"
#define DECIMAL_FORMAT_12_2  "99999999990D99" // Homologacion TOL 2.0 COLOMBIA INC 44023
//#endif



#ifndef _ENABLE_UPDATE_INSERT
    #ifdef _USE_SELECT_FOR_UPDATE
        #undef _USE_SELECT_FOR_UPDATE
    #endif //_USE_SELECT_FOR_UPDATE
#endif //_ENABLE_UPDATE_INSERT


#ifdef _USE_SELECT_FOR_UPDATE
#define SELECT_FOR_UPDATE " for update"
#else
#define SELECT_FOR_UPDATE ""
#endif



#define ENV_VAR_FOR_LOGPATH "XPF_LOG"


template<class T>
struct RecordSet
{
    int NUM_OF_RECORDS;
    typename std::vector<T> RECORDSET;

    void clear()
    {
        NUM_OF_RECORDS = 0;
        RECORDSET.clear();
    };
};




///////////////////////////////////////////////////////////////////////////////////////////
/* GE_CLILOCPADREHIJO_TO */
///////////////////////////////////////////////////////////////////////////////////////////
/*
CREATE TABLE GE_CLILOCPADREHIJO_TO
(
  COD_CLIENTE    NUMBER(8)                      NOT NULL,
  COD_CLI_PADRE  NUMBER(8)                      NOT NULL,
  TIPO_CLIENTE   VARCHAR2(1),
  FEC_INI        DATE                           NOT NULL,
  FEC_FIN        DATE                           NOT NULL,
  NOM_USUARIO    VARCHAR2(30)                   NOT NULL
)
*/


typedef set<int> SH_GE_CLILOCHIJO_TO;
typedef map<int, SH_GE_CLILOCHIJO_TO> SH_GE_CLILOCPADRE_TO;


#define QUERY_SH_GE_CLILOCPADREHIJO_TO "\
    select\
        COD_CLIENTE,\
        COD_CLI_PADRE,\
        TIPO_CLIENTE\
    from\
        GE_CLILOCPADREHIJO_TO\
    order by\
        COD_CLIENTE,\
        COD_CLI_PADRE"






///////////////////////////////////////////////////////////////////////////////////////////
/* FA_CICLFACT */
///////////////////////////////////////////////////////////////////////////////////////////
/*
CREATE TABLE FA_CICLFACT
(
  COD_CICLO         NUMBER(2)                   NOT NULL,
  ANO               NUMBER(2)                   NOT NULL,
  COD_CICLFACT      NUMBER(6)                   NOT NULL,
  FEC_VENCIMIE      DATE                        NOT NULL,
  FEC_EMISION       DATE                        NOT NULL,
  FEC_CADUCIDA      DATE                        NOT NULL,
  FEC_PROXVENC      DATE                        NOT NULL,
  FEC_DESDELLAM     DATE                        NOT NULL,
  FEC_HASTALLAM     DATE                        NOT NULL,
  DIA_PERIODO       NUMBER(2)                   NOT NULL,
  FEC_DESDECFIJOS   DATE                        NOT NULL,
  FEC_HASTACFIJOS   DATE                        NOT NULL,
  FEC_DESDEOCARGOS  DATE                        NOT NULL,
  FEC_HASTAOCARGOS  DATE                        NOT NULL,
  FEC_DESDEROA      DATE                        NOT NULL,
  FEC_HASTAROA      DATE                        NOT NULL,
  IND_FACTURACION   NUMBER(1)                   DEFAULT 0                     NOT NULL,
  DIR_LOGS          VARCHAR2(100)               NOT NULL,
  DIR_SPOOL         VARCHAR2(100)               NOT NULL,
  DES_LEYEN1        VARCHAR2(80),
  DES_LEYEN2        VARCHAR2(80),
  DES_LEYEN3        VARCHAR2(80),
  DES_LEYEN4        VARCHAR2(80),
  DES_LEYEN5        VARCHAR2(80),
  IND_TASADOR       NUMBER(1)                   DEFAULT 0
)
*/

struct RECORD_FA_CICLFACT_DTO
{
    int     COD_CICLOFACT;
    int     COD_CICLO;
    char    FEC_DESDELLAM[14+1];
    char    FEC_HASTALLAM[14+1];
    char    FEC_EMISION[14+1];
    int     DIA_PERIODO;
    int     IND_FACTURACION;

    void clear()
    {
        COD_CICLOFACT = 0;
        COD_CICLO = 0;
        FEC_DESDELLAM[0] = '\0';
        FEC_HASTALLAM[0] = '\0';
        FEC_EMISION[0] = '\0';
        DIA_PERIODO = 0;
        IND_FACTURACION = -99;
    };
};

#define QUERY_FA_CICLFACT "\
    select\
        COD_CICLO,\
        to_char(FEC_DESDELLAM, :format_date1<char[16]>) :#2<char[14]>,\
        to_char(FEC_HASTALLAM, :format_date2<char[16]>) :#3<char[14]>,\
        to_char(FEC_EMISION, :format_date3<char[16]>) :#4<char[14]>,\
        DIA_PERIODO\
    from\
        FA_CICLFACT\
    where\
        COD_CICLFACT = :ciclo_fact<int>\
    and\
        IND_TASADOR = :ind_tasa<int>\
    and\
        IND_FACTURACION = :ind_fact<int>"

#define IND_TASACION_TOL 1
#define IND_FACTURACION_PROC 1
#define IND_FACTURACION_PROC_JOB 0



///////////////////////////////////////////////////////////////////////////////////////////
/* FA_CICLFACT */
///////////////////////////////////////////////////////////////////////////////////////////
/*
CREATE TABLE FA_CICLOCLI
(
  COD_CLIENTE    NUMBER(8)                      NOT NULL,
  COD_CICLO      NUMBER(2)                      NOT NULL,
  COD_PRODUCTO   NUMBER(1)                      NOT NULL,
  NUM_ABONADO    NUMBER(8)                      NOT NULL,
  NUM_PROCESO    NUMBER(8)                      DEFAULT 0                     NOT NULL,
  COD_CALCLIEN   VARCHAR2(2)                    NOT NULL,
  IND_CAMBIO     NUMBER(1)                      NOT NULL,
  NOM_USUARIO    VARCHAR2(20)                   NOT NULL,
  NOM_APELLIDO1  VARCHAR2(20)                   NOT NULL,
  NOM_APELLIDO2  VARCHAR2(20),
  COD_CREDMOR    NUMBER(3),
  IND_DEBITO     VARCHAR2(1),
  COD_CICLONUE   NUMBER(2),
  FEC_ALTA       DATE                           NOT NULL,
  NUM_TERMINAL   NUMBER(15),
  FEC_ULTFACT    DATE,
  IND_MASCARA    NUMBER(2),
  COD_DESPACHO   VARCHAR2(5),
  COD_PRIORIDAD  NUMBER(3)
)
CREATE TABLE GA_INFACCEL
(
  COD_CLIENTE         NUMBER(8)                 NOT NULL,
  NUM_ABONADO         NUMBER(8)                 NOT NULL,
  COD_CICLFACT        NUMBER(6)                 NOT NULL,
  FEC_ALTA            DATE                      NOT NULL,
  FEC_BAJA            DATE                      NOT NULL,
  NUM_CELULAR         NUMBER(15)                NOT NULL,
  IND_ACTUAC          NUMBER(1)                 NOT NULL,
  FEC_FINCONTRA       DATE                      NOT NULL,
  IND_ALTA            NUMBER(1)                 NOT NULL,
  IND_DETALLE         NUMBER(1)                 NOT NULL,
  IND_FACTUR          NUMBER(1)                 NOT NULL,
  IND_CUOTAS          NUMBER(1)                 NOT NULL,
  IND_ARRIENDO        NUMBER(1)                 NOT NULL,
  IND_CARGOS          NUMBER(1)                 NOT NULL,
  IND_PENALIZA        NUMBER(1)                 NOT NULL,
  IND_SUPERTEL        NUMBER(1)                 NOT NULL,
  NUM_TELEFIJA        VARCHAR2(15),
  COD_SUPERTEL        NUMBER(5),
  IND_CARGOPRO        NUMBER(1),
  IND_CUENCONTROLADA  NUMBER(1),
  IND_BLOQUEO         NUMBER(1)                 DEFAULT 0,
  FEC_RECARGA         DATE
)
*/

struct RECORD_FA_CICLOCLI_DTO
{
    int     NUM_ABONADO;
    char    FEC_ALTA[14+1];
    char    FEC_BAJA[14+1];

    void clear()
    {
        NUM_ABONADO = -1;
        FEC_ALTA[0] = '\0';
        FEC_BAJA[0] = '\0';
    };
};

typedef RecordSet<RECORD_FA_CICLOCLI_DTO> FA_CICLOCLI_RECORDSET;


#define QUERY_FA_CICLOCLI "\
    select\
        a.NUM_ABONADO,\
        to_char(a.FEC_ALTA, :format_date1<char[16]>) :#2<char[14]>,\
        to_char(b.FEC_BAJA, :format_date2<char[16]>) :#3<char[14]>\
    from\
        FA_CICLOCLI a,\
        GA_INFACCEL b\
    where\
        a.COD_CLIENTE = b.COD_CLIENTE\
    and\
        a.NUM_ABONADO = b.NUM_ABONADO\
    and\
        a.COD_CLIENTE = :cod_clie<int>\
    and\
        a.COD_CICLO = :cod_ciclo<int>\
    and\
        b.COD_CICLFACT = :cod_ciclo_fact<int>\
    and\
        a.NUM_PROCESO = :num_proc<int>\
    and\
        a.IND_MASCARA = :ind_mask<int>"


#define QUERY_FA_CICLOCLI_JOB "\
    select\
        a.NUM_ABONADO,\
        to_char(a.FEC_ALTA, :format_date1<char[16]>) :#2<char[14]>,\
        to_char(b.FEC_BAJA, :format_date2<char[16]>) :#3<char[14]>\
    from\
        FA_CICLOCLI a,\
        GA_INFACCEL b\
    where\
        a.COD_CLIENTE = b.COD_CLIENTE\
    and\
        a.NUM_ABONADO = b.NUM_ABONADO\
    and\
        a.COD_CLIENTE = :cod_clie<int>\
    and\
        a.COD_CICLO = :cod_ciclo<int>\
    and\
        b.COD_CICLFACT = :cod_ciclo_fact<int>\
    and\
        a.NUM_PROCESO >= :num_proc<int>"

#define NUM_PROCESO_FA_CICLOCLI 0
#define IND_MASCARA_FA_CICLOCLI 1






///////////////////////////////////////////////////////////////////////////////////////////
/* FA_CLIENTEJOB_TO */
///////////////////////////////////////////////////////////////////////////////////////////
/*
CREATE TABLE FA_CLIENTEJOB_TO
(
  NUM_JOB       NUMBER(8)                       NOT NULL,
  COD_CICLO     NUMBER(2)                       NOT NULL,
  COD_CLIENTE   NUMBER(8)                       NOT NULL,
  NUM_ABONADO   NUMBER(8)                       NOT NULL,
  COD_PROCESO   NUMBER(4),
  COD_ESTAPROC  NUMBER(1),
  FEC_ESTADO    DATE
)
*/

#define QUERY_FA_CLIENTEJOB_TO "\
    select\
        1\
    from\
        FA_CLIENTEJOB_TO\
    where\
        COD_CLIENTE = :cod_clie<int>\
    and\
        NUM_JOB = :num_job<int>\
    and\
        COD_CICLO = :cod_ciclo<int>\
    and\
        COD_PROCESO = :num_proc<int>"




///////////////////////////////////////////////////////////////////////////////////////////
/* GAT_PLANDESCABO */
///////////////////////////////////////////////////////////////////////////////////////////
/*
CREATE TABLE GAT_PLANDESCABO
(
  COD_CLIENTE    NUMBER(8)                      NOT NULL,
  NUM_SECUENCIA  NUMBER(8)                      NOT NULL,
  NUM_ABONADO    NUMBER(8)                      NOT NULL,
  COD_CICLFACT   NUMBER(6)                      NOT NULL,
  COD_PLANDESC   VARCHAR2(5)                    NOT NULL,
  TIP_ENTIDAD    VARCHAR2(5)
)
CREATE TABLE FAD_PLANDESC
(
  COD_PLANDESC     VARCHAR2(5)                  NOT NULL,
  DES_PLANDESC     VARCHAR2(30)                 NOT NULL,
  FEC_DESDE        DATE                         NOT NULL,
  FEC_HASTA        DATE                         NOT NULL,
  IND_RESTRICCION  VARCHAR2(1)                  NOT NULL,
  FEC_ULTMOD       DATE                         NOT NULL,
  NOM_USUARIO      VARCHAR2(30)                 NOT NULL
)
CREATE TABLE FAD_DETPLANDESC
(
  COD_PLANDESC   VARCHAR2(5)                    NOT NULL,
  FEC_DESDE      DATE                           NOT NULL,
  FEC_HASTA      DATE                           NOT NULL,
  COD_TIPEVAL    VARCHAR2(1)                    NOT NULL,
  COD_TIPAPLI    VARCHAR2(1)                    NOT NULL,
  COD_GRUPOEVAL  NUMBER(6),
  COD_GRUPOAPLI  NUMBER(6),
  NUM_CUADRANTE  NUMBER(6)                      NOT NULL,
  TIP_UNIDAD     VARCHAR2(2)                    NOT NULL,
  COD_CONCDESC   NUMBER(4),
  MTO_MINFACT    NUMBER(8)                      DEFAULT 0                     NOT NULL,
  FEC_ULTMOD     DATE                           NOT NULL,
  NOM_USUARIO    VARCHAR2(30)                   NOT NULL
)
*/

struct RECORD_GAT_PLANDESCABO_DTO
{
    int     NUM_SECUENCIA;
    char    COD_PLANDESC[5+1];
    char    TIP_ENTIDAD[5+1];
    char    COD_TIPEVAL[1+1];
    char    COD_TIPAPLI[1+1];
    int     COD_GRUPOEVAL;
    int     COD_GRUPOAPLI;
    int     NUM_CUADRANTE;
    char    TIP_UNIDAD[2+1];
    int     COD_CONCDESC;
    int     MTO_MINFACT;

    void clear()
    {
        NUM_SECUENCIA = 0;
        COD_PLANDESC[0] = '\0';
        TIP_ENTIDAD[0] = '\0';
        COD_TIPEVAL[0] = '\0';
        COD_TIPAPLI[0] = '\0';
        COD_GRUPOEVAL = 0;
        COD_GRUPOAPLI = 0;
        NUM_CUADRANTE = 0;
        TIP_UNIDAD[0] = '\0';
        COD_CONCDESC = 0;
        MTO_MINFACT = 0;
    };
};

typedef RecordSet<RECORD_GAT_PLANDESCABO_DTO> GAT_PLANDESCABO_RECORDSET;



#define QUERY_GAT_PLANDESCABO_1 "\
    select\
        a.NUM_SECUENCIA,\
        a.COD_PLANDESC,\
        a.TIP_ENTIDAD,\
        c.COD_TIPEVAL,\
        c.COD_TIPAPLI,\
        c.COD_GRUPOEVAL,\
        c.COD_GRUPOAPLI,\
        c.NUM_CUADRANTE,\
        c.TIP_UNIDAD,\
        c.COD_CONCDESC,\
        c.MTO_MINFACT\
    from\
        GAT_PLANDESCABO"

#define QUERY_GAT_PLANDESCABO_2 " a,\
        FAD_PLANDESC b,\
        FAD_DETPLANDESC c\
    where\
        a.COD_PLANDESC = b.COD_PLANDESC\
    and\
        b.COD_PLANDESC = c.COD_PLANDESC\
    and\
        a.COD_CLIENTE = :cod_clie<int>\
    and\
        (a.COD_CICLFACT = :cod_ciclo_fact<int> or COD_CICLFACT = :zero_value<int>)\
    and\
        (a.NUM_ABONADO = :num_abon1<int> or a.NUM_ABONADO = :num_abon2<int>)\
    and\
        (to_date(:value_date1<char[14]>, :format_date1<char[16]>) between c.FEC_DESDE and c.FEC_HASTA)"\

#define TIP_EVAL_APLI_CONCEPTO "C"
#define TIP_ENTIDAD_CONCEPTO "C"
#define TIP_ENTIDAD_BOLSA "B"






///////////////////////////////////////////////////////////////////////////////////////////
/* FAD_CONCEVAL */
///////////////////////////////////////////////////////////////////////////////////////////
/*
CREATE TABLE FAD_CONCEVAL
(
  COD_GRUPO     NUMBER(6)                       NOT NULL,
  COD_CONCEPTO  NUMBER(4)                       NOT NULL,
  FEC_DESDE     DATE                            NOT NULL,
  FEC_HASTA     DATE                            NOT NULL,
  IND_OBLIGA    VARCHAR2(1)                     NOT NULL,
  MTO_MINFACT   NUMBER(6)                       DEFAULT 0                     NOT NULL,
  FEC_ULTMOD    DATE                            NOT NULL,
  NOM_USUARIO   VARCHAR2(30)                    NOT NULL
)
*/


struct RECORD_FAD_CONCEVAL_DTO
{
    int     COD_CONCEPTO;
    char    IND_OBLIGA[1+1];
    int     MTO_MINFACT;

    void clear()
    {
        COD_CONCEPTO = 0;
        IND_OBLIGA[0] = '\0';
        MTO_MINFACT = 0;
    };
};

typedef RecordSet<RECORD_FAD_CONCEVAL_DTO> FAD_CONCEVAL_RECORDSET;

#define QUERY_FAD_CONCEVAL "\
    select\
        COD_CONCEPTO,\
        IND_OBLIGA,\
        MTO_MINFACT\
    from\
        FAD_CONCEVAL\
    where\
        COD_GRUPO = :cod_grupo<int>\
    and\
        (to_date(:value_date1<char[14]>, :format_date1<char[16]>) between FEC_DESDE and FEC_HASTA)"\







///////////////////////////////////////////////////////////////////////////////////////////
/* FAD_CONCAPLI */
///////////////////////////////////////////////////////////////////////////////////////////
/*
CREATE TABLE FAD_CONCAPLI
(
  COD_GRUPO     NUMBER(6)                       NOT NULL,
  COD_CONCEPTO  NUMBER(4)                       NOT NULL,
  FEC_DESDE     DATE                            NOT NULL,
  FEC_HASTA     DATE                            NOT NULL,
  COD_CONREL    NUMBER(4),
  FEC_ULTMOD    DATE                            NOT NULL,
  NOM_USUARIO   VARCHAR2(30)                    NOT NULL
)
*/

struct RECORD_FAD_CONCAPLI_DTO
{
    int     COD_CONCEPTO;
    int     COD_CONREL;

    void clear()
    {
        COD_CONCEPTO = 0;
        COD_CONREL = 0;
    };
};

typedef RecordSet<RECORD_FAD_CONCAPLI_DTO> FAD_CONCAPLI_RECORDSET;

#define QUERY_FAD_CONCAPLI "\
    select\
        COD_CONCEPTO,\
        COD_CONREL\
    from\
        FAD_CONCAPLI\
    where\
        COD_GRUPO = :cod_grupo<int>\
    and\
        (to_date(:value_date1<char[14]>, :format_date1<char[16]>) between FEC_DESDE and FEC_HASTA)"\







///////////////////////////////////////////////////////////////////////////////////////////
/* FAD_CUADRANDESC */
///////////////////////////////////////////////////////////////////////////////////////////
/*
CREATE TABLE FAD_CUADRANDESC
(
  NUM_CUADRANTE  NUMBER(6)                      NOT NULL,
  VAL_DESDE      NUMBER(12,2)                   NOT NULL,
  VAL_HASTA      NUMBER(12,2)                   NOT NULL,
  FEC_DESDE      DATE                           NOT NULL,
  FEC_HASTA      DATE                           NOT NULL,
  TIP_DESCUENTO  VARCHAR2(1)                    NOT NULL,
  VAL_DESCUENTO  NUMBER(8,2)                    NOT NULL,
  TIP_MONEDA     VARCHAR2(3),
  FEC_ULTMOD     DATE                           NOT NULL,
  NOM_USUARIO    VARCHAR2(30)                   NOT NULL
)
*/


struct RECORD_FAD_CUADRANDESC_DTO
{
    char    VAL_DESDE[16+1];
    char    VAL_HASTA[16+1];
    char    TIP_DESCUENTO[1+1];
    char    VAL_DESCUENTO[12+1];
    char    TIP_MONEDA[3+1];

    void clear()
    {
        VAL_DESDE[0] = '\0';
        VAL_HASTA[0] = '\0';
        TIP_DESCUENTO[0] = '\0';
        VAL_DESCUENTO[0] = '\0';
        TIP_MONEDA[0] = '\0';
    };
};

typedef RecordSet<RECORD_FAD_CUADRANDESC_DTO> FAD_CUADRANDESC_RECORDSET;


#define QUERY_FAD_CUADRANDESC "\
    select\
        to_char(VAL_DESDE, :format_value1<char[15]>) :#1<char[16]>,\
        to_char(VAL_HASTA, :format_value2<char[15]>) :#2<char[16]>,\
        TIP_DESCUENTO,\
        to_char(VAL_DESCUENTO, :format_value3<char[11]>) :#4<char[12]>,\
        TIP_MONEDA\
    from\
        FAD_CUADRANDESC\
    where\
        NUM_CUADRANTE = :num_cuadrante<int>\
    and\
        (to_date(:value_date1<char[14]>, :format_date1<char[16]>) between FEC_DESDE and FEC_HASTA)"\





///////////////////////////////////////////////////////////////////////////////////////////
/* FA_CONCEPTOS */
///////////////////////////////////////////////////////////////////////////////////////////
/*
CREATE TABLE FA_CONCEPTOS
(
  COD_CONCEPTO     NUMBER(4)                    NOT NULL,
  COD_PRODUCTO     NUMBER(1)                    NOT NULL,
  DES_CONCEPTO     VARCHAR2(60)                 NOT NULL,
  COD_TIPCONCE     NUMBER(2)                    NOT NULL,
  COD_MODULO       VARCHAR2(2)                  NOT NULL,
  IND_ACTIVO       NUMBER(1)                    DEFAULT 0                     NOT NULL,
  COD_MONEDA       VARCHAR2(3)                  NOT NULL,
  COD_CONCORIG     NUMBER(4),
  COD_TIPDESCU     VARCHAR2(1),
  NOM_USUARIO      VARCHAR2(30),
  FEC_ULTMOD       DATE,
  COD_PRODSERVTFN  NUMBER(8)                    DEFAULT 1                     NOT NULL,
  IND_RECURRENTE   NUMBER(1)                    DEFAULT 0                     NOT NULL,
  COD_SUBCONCEPTO  VARCHAR2(2),
  IND_TECNOLOGIA   NUMBER(1)                    DEFAULT 0                     NOT NULL,
  DEF_TECNOLOGIA   VARCHAR2(7)                  DEFAULT 'NOTECNO'             NOT NULL,
  COD_GRPCONCEPTO  NUMBER(4)                    NOT NULL
)
*/

struct RECORD_FA_CONCEPTOS_DTO
{
    int     COD_PRODUCTO;
    int     COD_TIPCONCE;

    void clear()
    {
        COD_PRODUCTO = 0;
        COD_TIPCONCE = 0;
    };
};


typedef map<int, RECORD_FA_CONCEPTOS_DTO> SH_FA_CONCEPTOS;

#define QUERY_SH_FA_CONCEPTOS "\
    select\
        COD_CONCEPTO,\
        COD_PRODUCTO,\
        COD_TIPCONCE\
    from\
        FA_CONCEPTOS"






///////////////////////////////////////////////////////////////////////////////////////////
/* TOL_ACUMOPER_TO */
///////////////////////////////////////////////////////////////////////////////////////////
/*
CREATE TABLE TOL_ACUMOPER_TO
(
  COD_OPERADOR   NUMBER(5),
  COD_REGI       VARCHAR2(2),
  COD_GRUPO      NUMBER(8),
  COD_CLIENTE    NUMBER(8),
  NUM_ABONADO    NUMBER(8),
  COD_CICLFACT   NUMBER(8),
  NUM_PROCESO    NUMBER(8)                      DEFAULT 0,
  IND_EXEDENTE   VARCHAR2(1)                    DEFAULT ' ',
  COD_PLAN       VARCHAR2(5)                    DEFAULT ' ',
  IND_BILLETE    VARCHAR2(2),
  COD_CARG       NUMBER(5)                      DEFAULT 0,
  TIP_DCTO       VARCHAR2(5)                    DEFAULT ' ',
  COD_DCTO       VARCHAR2(5)                    DEFAULT ' ',
  COD_ITEM       VARCHAR2(5)                    DEFAULT ' ',
  IND_UNIDAD     VARCHAR2(5)                    DEFAULT ' ',
  CNT_INICIAL    NUMBER(14,4)                   DEFAULT 0,
  CNT_AUX        NUMBER(14,4)                   DEFAULT 0,
  MTO_REAL       NUMBER(14,4)                   DEFAULT 0,
  MTO_FACT       NUMBER(14,4)                   DEFAULT 0,
  MTO_DCTO       NUMBER(14,4)                   DEFAULT 0,
  DUR_REAL       NUMBER(9)                      DEFAULT 0,
  DUR_FACT       NUMBER(9)                      DEFAULT 0,
  DUR_DCTO       NUMBER(9)                      DEFAULT 0,
  TIP_MONE       VARCHAR2(5),
  CNT_LLAM_REAL  NUMBER(8),
  CNT_LLAM_DCTO  NUMBER(8),
  CNT_LLAM_FACT  NUMBER(8),
  COD_AREAA      VARCHAR2(5)                    DEFAULT '05'                  NOT NULL
)
*/

struct RECORD_TOL_ACUMOPER_TO_DTO
{
    int     COD_CLIENTE;
    int     COD_OPERADOR;
    char    COD_REGI[2+1];
    int     COD_GRUPO;
    int     COD_CICLFACT;
    char    IND_EXEDENTE[1+1];
    char    COD_PLAN[5+1];
    int     COD_CARG;
    char    TIP_DCTO[5+1];
    char    COD_DCTO[5+1];
    double  CNT_INICIAL;
    double  MTO_FACT;
    int     DUR_FACT;

    void clear()
    {
        COD_CLIENTE = 0;
        COD_OPERADOR = 0;
        COD_REGI[0] = '\0';
        COD_GRUPO = 0;;
        COD_CICLFACT = 0;
        IND_EXEDENTE[0] = '\0';
        COD_PLAN[0] = '\0';
        COD_CARG = 0;
        TIP_DCTO[0] = '\0';
        COD_DCTO[0] = '\0';
        CNT_INICIAL = 0.0;
        MTO_FACT = 0.0;
        DUR_FACT = 0;
    };
};


#define QUERY_TOL_ACUMOPER_TO "\
    select\
        a.COD_OPERADOR,\
        a.COD_REGI,\
        a.COD_GRUPO,\
        a.COD_CICLFACT,\
        a.IND_EXEDENTE,\
        a.COD_PLAN,\
        a.COD_CARG,\
        a.TIP_DCTO,\
        a.COD_DCTO,\
        max(a.CNT_INICIAL),\
        sum(a.MTO_FACT),\
        sum(a.DUR_FACT)\
    from\
        TOL_ACUMOPER_TO a,\
        FA_CICLFACT b\
    where\
        COD_CLIENTE = :codCliente<int>\
    and\
        NUM_ABONADO = :numAbon<int>\
    and\
        a.COD_CICLFACT = b.COD_CICLFACT\
    and\
        b.IND_FACTURACION = :indFact<int>\
    and\
        a.NUM_PROCESO = :numProc<int>\
    and\
        b.FEC_EMISION <= to_date(:value_date1<char[14]>, :format_date1<char[16]>)\
    and\
        a.MTO_FACT > :minMtoFact<int>\
    group by\
        a.COD_OPERADOR,\
        a.COD_REGI,\
        a.COD_GRUPO,\
        a.COD_CLIENTE,\
        a.NUM_ABONADO,\
        a.COD_CICLFACT,\
        a.NUM_PROCESO,\
        a.IND_EXEDENTE,\
        a.COD_PLAN,\
        a.COD_CARG,\
        a.TIP_DCTO,\
        a.COD_DCTO\
    order by\
        a.COD_CARG"



#define NUM_PROCESO_TOL_ACUMOPER 0
#define MTO_MIN_TOL_ACUMOPER 0


///////////////////////////////////////////////////////////////////////////////////////////
/* FA_DETDCTOCLIELOC_TO */
///////////////////////////////////////////////////////////////////////////////////////////
/*
CREATE TABLE FA_DETDCTOCLIELOC_TO
(
  COD_CLIENTE    NUMBER(8)                      NOT NULL,
  COD_CICLO      NUMBER(2)                      NOT NULL,
  COD_PLANDESC   VARCHAR2(5)                    NOT NULL,
  NUM_SECUENCIA  NUMBER(8)                      NOT NULL,
  COD_GRUPOAPLI  NUMBER(6)                      NOT NULL,
  NUM_CUADRANTE  NUMBER(6)                      NOT NULL,
  VALOR_DCTO     NUMBER                         NOT NULL,
  TIP_DCTO       VARCHAR2(2)                    NOT NULL,
  TIP_ENTIDAD    VARCHAR2(5)                    NOT NULL
)
FA_DETDCTOCLIELOC_80508_7
*/

struct RECORD_FA_DETDCTOCLIELOC_TO_DTO
{
    int         COD_CLIENTE;
    int         COD_CICLO;
    STRING16    COD_PLANDESC;
    int         NUM_SECUENCIA;
    int         COD_GRUPOAPLI;
    int         NUM_CUADRANTE;
    double      VALOR_DCTO;
    STRING16    TIP_DCTO;
    STRING16    TIP_ENTIDAD;

    void clear()
    {
        COD_CLIENTE = 0;
        COD_CICLO = 0;
        COD_PLANDESC.clear();
        NUM_SECUENCIA = 0;;
        COD_GRUPOAPLI = 0;
        NUM_CUADRANTE = 0;
        VALOR_DCTO = 0.0;
        TIP_DCTO.clear();
        TIP_ENTIDAD.clear();
    };
};

#define QUERY_CLEAR_FA_DETDCTOCLIELOC_TO_1 "\
    delete\
    from\
        "
#define QUERY_CLEAR_FA_DETDCTOCLIELOC_TO_3 "\
    where\
        COD_CICLO > :codciclo<int>"

#define QUERY_FA_DETDCTOCLIELOC_TO_1 "\
    insert\
    into\
        "

#define QUERY_FA_DETDCTOCLIELOC_TO_2 "FA_DETDCTOCLIELOC"

#define QUERY_FA_DETDCTOCLIELOC_TO_3 "\
        (\
            COD_CLIENTE,\
            COD_CICLO,\
            COD_PLANDESC,\
            NUM_SECUENCIA,\
            COD_GRUPOAPLI,\
            NUM_CUADRANTE,\
            VALOR_DCTO,\
            TIP_DCTO,\
            TIP_ENTIDAD\
        )\
    values\
    (\
        :codcliente<int>,\
        :condciclo<int>,\
        :codplan<char[5]>,\
        :numsec<int>,\
        :grupoapli<int>,\
        :numcuadra<int>,\
        :valor_dcto<double>,\
        :tipdcto<char[2]>,\
        :tipenti<char[5]>\
    )"













///////////////////////////////////////////////////////////////////////////////////////////
/* FA_TRAZAPROC */
///////////////////////////////////////////////////////////////////////////////////////////
/*
CREATE TABLE FA_PROCFACTPREC
(
  COD_PROCESO   NUMBER(4)                       NOT NULL,
  COD_PROCPREC  NUMBER(4)                       NOT NULL,
  COD_ESTAPREC  NUMBER(1)                       NOT NULL
)
CREATE TABLE FA_PROCFACT
(
  COD_PROCESO    NUMBER(4)                      NOT NULL,
  DES_PROCESO    VARCHAR2(30)                   NOT NULL,
  COD_PROCPREC   NUMBER(4),
  COD_ESTAPREC   NUMBER(1),
  IND_REPROCESO  NUMBER(1)                      NOT NULL
)
CREATE TABLE FA_TRAZAPROC
(
  COD_CICLFACT   NUMBER(8)                      NOT NULL,
  COD_PROCESO    NUMBER(4)                      NOT NULL,
  COD_ESTAPROC   NUMBER(1)                      NOT NULL,
  FEC_INICIO     DATE                           NOT NULL,
  FEC_TERMINO    DATE,
  GLS_PROCESO    VARCHAR2(50),
  COD_CLIENTE    NUMBER(8),
  NUM_ABONADO    NUMBER(8),
  NUM_REGISTROS  NUMBER(8)
)
*/

struct RECORD_FA_TRAZAPROC_DTO
{
    char    DES_PROCESO[30+1];
    int     COD_PROCPREC;
    char    DES_PROCPREC[30+1];
    int     COD_ESTAPREC;
    int     COD_ESTAPROC;

    void clear()
    {
        DES_PROCESO[0] = '\0';
        COD_PROCPREC = 0;
        DES_PROCPREC[0] = '\0';
        COD_ESTAPREC = 0;
        COD_ESTAPROC = 0;
    };
};

typedef RecordSet<RECORD_FA_TRAZAPROC_DTO> FA_TRAZAPROC_RECORDSET;



struct RECORD_FA_PROCFACT_DTO
{
    int     COD_PROCESO;
    int     IND_REPROCESO;

    void clear()
    {
        COD_PROCESO = 0;
        IND_REPROCESO = 0;
    };
};


#define QUERY_FA_PROCFACT "\
    select\
        IND_REPROCESO\
    from\
        FA_PROCFACT\
    where\
        COD_PROCESO = :cod_proc<int>"



#define QUERY_FA_TRAZAPROC "\
    select\
        PROC.DES_PROCESO,\
        PROC.COD_PROCPREC,\
        PROC.DES_PROCPREC,\
        PROC.COD_ESTAPREC,\
        NVL(TRAZ.COD_ESTAPROC,0)\
    from\
        FA_TRAZAPROC  TRAZ,\
        (select\
            A.COD_PROCESO   COD_PROCESO,\
            B.DES_PROCESO   DES_PROCESO,\
            A.COD_PROCPREC  COD_PROCPREC,\
            C.DES_PROCESO   DES_PROCPREC,\
            A.COD_ESTAPREC  COD_ESTAPREC\
        from\
            FA_PROCFACTPREC A ,\
            FA_PROCFACT B ,\
            FA_PROCFACT C\
        where\
            A.COD_PROCESO  = :codProceso<int>\
        and\
            A.COD_PROCESO  = B.COD_PROCESO\
        and\
            A.COD_PROCPREC = C.COD_PROCESO\
        ) PROC\
    where\
        TRAZ.COD_CICLFACT (+)  = :cicloFact<int>\
    and\
        TRAZ.COD_PROCESO  (+)  = PROC.COD_PROCPREC\
    order by\
        PROC.COD_PROCESO"



struct RECORD_STAT_FA_TRAZAPROC_DTO
{
    int     COD_ESTAPROC;
    char    DES_PROCESO[30+1];
    bool    RECORD_FOUND;

    void clear()
    {
        COD_ESTAPROC = 0;
        DES_PROCESO[0] = '\0';
        RECORD_FOUND = false;
    };
};


#define QUERY_STAT_FA_TRAZAPROC "\
    select\
        TRAZ.COD_ESTAPROC,\
        PROC.DES_PROCESO\
    from\
        FA_TRAZAPROC TRAZ,\
        FA_PROCFACT PROC\
    where\
        TRAZ.COD_CICLFACT = :cicloFact<int>\
    and\
        TRAZ.COD_PROCESO  = :codProceso<int>\
    and\
        TRAZ.COD_PROCESO  = PROC.COD_PROCESO"


#define QUERY_INSERT_FA_TRAZAPROC "\
    insert into\
        FA_TRAZAPROC\
        (\
            COD_CICLFACT,\
            COD_PROCESO,\
            COD_ESTAPROC,\
            FEC_INICIO,\
            GLS_PROCESO,\
            COD_CLIENTE,\
            NUM_ABONADO,\
            NUM_REGISTROS\
        )\
    values\
    (\
        :ciclfact<int>,\
        :codproceso<int>,\
        :estado<int>,\
        sysdate,\
        :glosaEstado<char[50]>,\
        :cliente<int>,\
        :abonado<int>,\
        :numreg<int>\
    )"\

#define QUERY_UPDATE_FA_TRAZAPROC "\
    update\
        FA_TRAZAPROC\
    set\
        COD_ESTAPROC = :ihCodEstaProc<int>,\
        FEC_TERMINO  = sysdate,\
        GLS_PROCESO  = :glosaEstado<char[50]>\
    where\
        COD_CICLFACT    = :codCiclFact<int>\
    and\
        COD_PROCESO     = :codProceso<int>"




///////////////////////////////////////////////////////////////////////////////////////////
/* FA_TRAZAPROC_JOB_TO */
///////////////////////////////////////////////////////////////////////////////////////////

#define QUERY_FA_TRAZAPROC_JOB_TO_SEQ_REPRO "\
    select\
        max(SEC_REPROCESO)\
    from\
        FA_TRAZAPROC_JOB_TO\
    where\
        NUM_JOB = :num_job<int>\
    and\
        COD_CICLFACT = :ciclo_fact<int>\
    and\
        COD_PROCESO  = :cod_proc<int>"


#define QUERY_FA_TRAZAPROC_JOB_TO "\
    select\
        PROC.DES_PROCESO,\
        PROC.COD_PROCPREC,\
        PROC.DES_PROCPREC,\
        PROC.COD_ESTAPREC,\
        NVL(TRAZ.COD_ESTAPROC,0)\
    from\
        FA_TRAZAPROC_JOB_TO  TRAZ,\
        (select\
            A.COD_PROCESO   COD_PROCESO,\
            B.DES_PROCESO   DES_PROCESO,\
            A.COD_PROCPREC  COD_PROCPREC,\
            C.DES_PROCESO   DES_PROCPREC,\
            A.COD_ESTAPREC  COD_ESTAPREC\
        from\
            FA_PROCFACTPREC A ,\
            FA_PROCFACT B ,\
            FA_PROCFACT C\
        where\
            A.COD_PROCESO  = :codProceso<int>\
        and\
            A.COD_PROCESO  = B.COD_PROCESO\
        and\
            A.COD_PROCPREC = C.COD_PROCESO\
        ) PROC\
    where\
        TRAZ.NUM_JOB (+) = :lhNroJob<int>\
    and\
        TRAZ.SEC_REPROCESO (+) = :lhSecReproceso<int>\
    and\
        TRAZ.COD_CICLFACT (+)  = :cicloFact<int>\
    and\
        TRAZ.COD_PROCESO  (+)  = PROC.COD_PROCPREC\
    order by\
        PROC.COD_PROCESO"


#define QUERY_STAT_FA_TRAZAPROC_JOB_TO "\
    select\
        TRAZ.COD_ESTAPROC,\
        PROC.DES_PROCESO\
    from\
        FA_TRAZAPROC_JOB_TO TRAZ,\
        FA_PROCFACT PROC\
    where\
        TRAZ.COD_CICLFACT = :cicloFact<int>\
    and\
        TRAZ.COD_PROCESO  = :codProceso<int>\
    and\
        TRAZ.COD_PROCESO  = PROC.COD_PROCESO\
    and\
        TRAZ.NUM_JOB       = :numJob<int>\
    and\
        TRAZ.SEC_REPROCESO = :secReproceso<int>"



#define QUERY_INSERT_FA_TRAZAPROC_JOB "\
    insert into\
        FA_TRAZAPROC_JOB_TO\
        (\
            NUM_JOB,\
            SEC_REPROCESO,\
            COD_CICLFACT,\
            COD_PROCESO,\
            COD_ESTAPROC,\
            FEC_INICIO,\
            GLS_PROCESO,\
            COD_CLIENTE,\
            NUM_ABONADO,\
            NUM_REGISTROS\
        )\
    values\
    (\
        :numjob<int>,\
        :secrepro<int>,\
        :ciclfact<int>,\
        :codproceso<int>,\
        :estado<int>,\
        sysdate,\
        :glosaEstado<char[50]>,\
        :cliente<int>,\
        :abonado<int>,\
        :numreg<int>\
    )"\

#define QUERY_UPDATE_FA_TRAZAPROC_JOB_TO "\
    update\
        FA_TRAZAPROC_JOB_TO\
    set\
        COD_ESTAPROC = :ihCodEstaProc<int>,\
        FEC_TERMINO  = sysdate,\
        GLS_PROCESO  = :glosaEstado<char[50]>\
    where\
        COD_CICLFACT    = :codCiclFact<int>\
    and\
        COD_PROCESO     = :codProceso<int>\
    and\
        NUM_JOB         = :numJob<int>\
    and\
        SEC_REPROCESO = :secReproceso<int>"





///////////////////////////////////////////////////////////////////////////////////////////
/* FA_JOBFACT_TO */
///////////////////////////////////////////////////////////////////////////////////////////

#define QUERY_FA_JOBFACT_TO "\
    select\
        1\
    from\
        FA_JOBFACT_TO\
    where\
        NUM_JOB = :numJob<int>\
    and\
        (COD_ESTADO = :estado1<int> or COD_ESTADO = :estado2<int>)"



#define COD_PROCESS_FACTURACION 2800
#define COD_PROCESS_FACTURACION_JOB 400

#define PROC_EST_RUN           1       /* Procesando                           */
#define GLS_EST_RUN "Procesando"
#define PROC_EST_ERR           2       /* Terminado con error                  */
#define GLS_EST_ERR "Terminado con error"
#define PROC_EST_OK            3       /* Terminado OK                         */
#define GLS_EST_OK "Terminado OK"

#define JOB_DISPONIBLE_STAT1    2
#define JOB_DISPONIBLE_STAT2    3







///////////////////////////////////////////////////////////////////////////////////////////
/* FA_CRITERIOJOB_TO */
///////////////////////////////////////////////////////////////////////////////////////////

#define QUERY_FA_CRITERIOJOB_TO "\
    select\
        1\
    from\
        FA_CICLFACT a,\
        FA_CRITERIOSFACT_TD b,\
        FA_CRITERIOJOB_TO c,\
        FA_JOBFACT_TO d\
    where\
        a.COD_CICLFACT = :codciclofact<int>\
    and\
        b.COD_CICLO = a.COD_CICLO\
    and\
        c.NUM_CRITERIO = b.NUM_CRITERIO\
    and\
        d.NUM_JOB = c.NUM_JOB\
    and\
        d.NUM_JOB = :numjob<int>"




#endif // MAP_TABLE_H

/******************************************************************************************/
/** Informacion de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  %ARCHIVE% */
/** Identificador en PVCS                               : */
/**  %PID% */
/** Producto                                            : */
/**  %PP% */
/** Revision                                             : */
/**  %PR% */
/** Autor de la Revision                                 : */
/**  %AUTHOR% */
/** Estado de la Revision ($TO_BE_DEFINED es Check-Out) : */
/**  %PS% */
/** Fecha de Creacion de la Revision                    : */
/**  %DATE% */
/** Worksets ******************************************************************************/
/** %PIRW% */
/** Historia ******************************************************************************/
/** %PL% */
/******************************************************************************************/


