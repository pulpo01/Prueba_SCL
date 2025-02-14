-- Script : drop_tecno.sql
set ver off echo off feedback off
spool $WORKDIR/drop_tecno
drop public synonym fa_factecno_to_&1;
drop table siscel.fa_factecno_to_&1;
spool off
exit;
