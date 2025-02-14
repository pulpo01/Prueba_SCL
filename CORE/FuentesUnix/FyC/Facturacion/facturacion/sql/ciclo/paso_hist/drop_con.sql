-- Script : drop_con.sql
set ver off echo off feedback off
spool $WORKDIR/drop_con
drop public synonym fa_factconc_&1;
drop table siscel.fa_factconc_&1;
spool off
exit;
