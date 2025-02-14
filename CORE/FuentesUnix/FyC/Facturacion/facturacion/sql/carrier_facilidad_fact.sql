set pause off;
set lines 120;
set pages 66;
set underline '=';
set verify on;
DEFINE TITULO_REPORTE = 'INFORME FACTURACION CARRIER ';
DEFINE NOMBRE_REPORTE = 'FACILIDAD FACTURACION ';
column today new_value _date ;
column hora  new_value _time ;
break on today;
break on hora;
select to_char(sysdate,'dd/mm/yyyy') today from dual; 
select to_char(sysdate,'HH24:MI:SS') hora from dual; 
ttitle left "TELEFONICA MOVIL " center titulo_reporte right 'Pag.  :   ' format 999,999 sql.pno skip 1 - 
left nombre_reporte center center  sql.user  right  'Fecha : '_date skip 1 -
right                         'Hora  :   ' _time skip 1 -
center 'Ciclo de Facturacion ' &1 skip 3;

clear breaks;
break on report;

/* Formato de salida */
set underline '=';
set recsepchar '=';
column MONTO_CARRIER format $999,999,999,999,999;
compute sum LABEL 'TOTAL' of MONTO_CARRIER on report;

set timing on;
spool &2;
SELECT  A.COD_CICLFACT                      CICLO_FACTURACION   ,
        B.COD_PORTADOR                      OPERADOR_CARRIER    ,
        COUNT(DISTINCT A.IND_ORDENTOTAL)    NUMERO_FACTURAS     ,
        SUM(B.IMP_FACTURABLE)               MONTO_CARRIER       
FROM    FA_HISTDOCU A   ,
        FA_HISTCONC_&1 B
WHERE   B.COD_TIPCONCE    = 4
AND     B.IND_ORDENTOTAL  = A.IND_ORDENTOTAL
GROUP BY 
        A.COD_CICLFACT  ,
        B.COD_PORTADOR  ,
        A.IND_SUPERTEL  ;
exit;



SISCEL                         AK_CO_PAGOS_CO_CAUSASPAGO      COD_CAUPAGO                    NONUNIQUE               1
SISCEL                         AK_CO_PAGOS_FEC_EFECTIVIDAD    FEC_EFECTIVIDAD                NONUNIQUE               1
SISCEL                         AK_CO_PAGOS_GE_BANCOS          COD_BANCO                      NONUNIQUE               1
SISCEL                         AK_CO_PAGOS_GE_CENTROSEMI      COD_CENTREMI                   NONUNIQUE               1
SISCEL                         AK_CO_PAGOS_GE_ORIGENPAGO      COD_ORIPAGO                    NONUNIQUE               1
SISCEL                         AK_CO_PAGOS_GE_SISPAGO         COD_SISPAGO                    NONUNIQUE               1
SISCEL                         AK_CO_PAGOS_GE_TIPDOCUMEN      COD_TIPDOCUM                   NONUNIQUE               1
SISCEL                         AK_CO_PAGOS_GE_TIPTARJETA      COD_TIPTARJETA                 NONUNIQUE               1
SISCEL                         AK_PAGOS_CLIENTE               COD_CLIENTE                    NONUNIQUE               1
SISCEL                         PK_CO_PAGOS                    NUM_SECUENCI                   UNIQUE                  1
SISCEL                         PK_CO_PAGOS                    COD_TIPDOCUM                   UNIQUE                  2
SISCEL                         PK_CO_PAGOS                    COD_VENDEDOR_AGENTE            UNIQUE                  3
SISCEL                         PK_CO_PAGOS                    LETRA                          UNIQUE                  4
SISCEL                         PK_CO_PAGOS                    COD_CENTREMI                   UNIQUE                  5
Cayoman >>Cayoman >>verindx co_pagos_conc
Cayoman >>verindx co_pagosconc 

SISCEL                         AK_CO_PAGOSCONC                NUM_SECUENCI                   NONUNIQUE               1
SISCEL                         AK_CO_PAGOSCONC                COD_TIPDOCUM                   NONUNIQUE               2
SISCEL                         AK_CO_PAGOSCONC                COD_VENDEDOR_AGENTE            NONUNIQUE               3
SISCEL                         AK_CO_PAGOSCONC                COD_CENTREMI                   NONUNIQUE               4
Cayoman >>verindx co_pagosconc