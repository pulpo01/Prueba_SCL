set pages 0
set veri off
set head off
set termout on
set feed off
set linesize 70
select min(ind_ordentotal), max(ind_ordentotal)
from fa_factdocu
where cod_ciclfact = &1;
exit;
