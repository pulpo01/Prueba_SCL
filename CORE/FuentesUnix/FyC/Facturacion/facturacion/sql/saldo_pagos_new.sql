set pause off;
set lines 120;
set pages 66;
set underline '=';
DEFINE TITULO_REPORTE = 'SALDO PAGOS ';
DEFINE NOMBRE_REPORTE = 'Pagos';
column today new_value _date ;
column hora  new_value _time ;
break on today;
break on hora;
select to_char(sysdate,'dd/mm/yyyy') today from dual; 
select to_char(sysdate,'HH24:MI:SS') hora from dual; 
ttitle left "CTC STARTEL " center titulo_reporte right 'Pag.  :   ' format 999,999 sql.pno skip 1 - 
left nombre_reporte center center  sql.user  right  'Fecha : '_date skip 1 -
right                         'Hora  :   ' _time skip 1 -
center &1 skip 3;

clear breaks;
break on report;

/* Formato de salida */
set underline '=';
set recsepchar '=';
column pago  format $999,999,999,999,999;
compute sum LABEL 'TOTAL' of pago on report;
 
set timing on;
spool &1;
select  des_pago,sum(imp_pago) pago
from    co_pagos
group by des_pago;
exit;