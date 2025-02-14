set pages 0
set pause off
set veri off
set head off
set linesize 70
set feedback off
set termout on
select cod_cliente, num_abonado, num_beeper, count(*)
from ga_infacbeep
where cod_ciclfact = &1
and ind_actuac = 1
group by cod_cliente, num_abonado, num_beeper
having count(*) > 1;
exit;
