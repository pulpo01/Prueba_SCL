set pause off;
set lines 120;
set pages 66;
set underline '=';
DEFINE TITULO_REPORTE = 'SALDO CARTERA ';
DEFINE NOMBRE_REPORTE = 'Saldo';
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
column cod      format 999;
column concepto format A25 truncated;
column registros format 99999999;
column debe  format $999,999,999,999.00;
column haber format $999,999,999,999.00;
column saldo format $999,999,999,999.00;
compute sum LABEL 'TOTAL' of registros debe haber saldo on report;
 
set timing on;
spool &1;

select  g.cod_tipdocum   COD,
        g.des_tipdocum  CONCEPTO,
        sum(registros)        REGISTROS,
        sum(debe)  debe,
        sum(haber) haber,
	    sum(debe-haber) saldo
from 
    (
    select  cod_tipdocum, 
	        count(*) registros,
            sum(importe_debe)  debe,
            sum(importe_haber) haber
    from    co_cartera
    group by cod_tipdocum
    union all 
    select  cod_tipdocum, 
	        count(*) registros,
            sum(importe_debe)  debe,
            sum(importe_haber) haber
    from    co_cancelados
    group by cod_tipdocum) a , 
    ge_tipdocumen g
WHERE  a.cod_tipdocum = g.cod_tipdocum  (+)
group by g.cod_tipdocum,g.des_tipdocum;

exit;
