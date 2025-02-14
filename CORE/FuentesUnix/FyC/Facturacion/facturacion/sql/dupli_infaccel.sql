set pages 0
set pause off
set veri off
set head off
set linesize 110
set feedback off
set termout on
select cod_cliente, num_abonado, num_celular, count(*)
from ga_infaccel
where cod_ciclfact = &1
and ind_actuac = 1
group by cod_cliente, num_abonado, num_celular
having count(*) > 1;
exit;
