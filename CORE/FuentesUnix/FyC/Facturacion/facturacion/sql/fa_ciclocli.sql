set pages 0
set pause off
set veri off
set head off
set linesize 50
set feedback off
set termout on
select num_proceso from fa_ciclocli
where cod_ciclo = &1
and num_proceso > 0
and num_proceso != 99999999
group by num_proceso
having count(*) > 1;
exit;
