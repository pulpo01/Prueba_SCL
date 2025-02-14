set serverout on size 1000000 echo off tab off feedback off linesize 110 long 110 newpage 0 pagesize 0 space 0 verify off wrap off;
--
select  b.cod_tipdocum, b.cod_cliente, b.acum_netograv, b.acum_netonograv, b.acum_iva, b.tot_factura, b.imp_saldoant, b.tot_pagar
from    FA_FACTDOCU_&1      b
where   b.ind_supertel  = 0
/
select  b.cod_tipdocum, b.cod_cliente, b.acum_netograv, b.acum_netonograv, b.acum_iva, b.tot_factura, b.imp_saldoant, b.tot_pagar
from    FA_FACTDOCU_&1    b
where   b.ind_supertel  = 1
/
exit
/
