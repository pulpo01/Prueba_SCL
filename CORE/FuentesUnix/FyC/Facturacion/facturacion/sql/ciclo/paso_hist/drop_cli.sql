-- Script : drop_cli.sql
set ver off echo off feedback off
spool $WORKDIR/drop_cli
drop public synonym fa_factclie_&1;
drop table siscel.fa_factclie_&1;
spool off
exit;
