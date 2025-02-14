set serverout on size 1000000 echo off tab off feedback off linesize 500 long 1000 newpage 0 pagesize 0 space 0 verify off wrap off;
--
select  a.cod_cliente ,'|', b.cod_concepto,'|', b.des_concepto,'|', b.imp_facturable
from    &2                   b,
        FA_FACTDOCU_&1       a
where   a.ind_supertel  = 0
and     a.ind_ordentotal = b.ind_ordentotal;
--
select  a.cod_cliente ,'|', b.cod_concepto,'|', b.des_concepto,'|', b.imp_facturable
from    &2                    b,
        FA_FACTDOCU_&1        a
where   a.ind_supertel  = 1
and     a.ind_ordentotal = b.ind_ordentotal;
--
exit;
