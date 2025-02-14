set echo off verify off
prompt Insertando en tabla fa_histdocu
spool $WORKDIR/fa_histdocu.log
insert into siscel.fa_histdocu
select * from fa_factdocu_&1
/
commit
/
spool off
exit;

