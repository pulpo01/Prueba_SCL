set pages 0
set pause off
set veri off
set head off
set linesize 50
set feedback off
set termout on
select cod_estaproc
from fa_trazaproc
where cod_ciclfact = &1
and cod_proceso = &2;
exit;
