-- Script : drop_abo.sql
set ver off echo off feedback off
spool $WORKDIR/drop_bon
drop public synonym fa_factabon_&1;
drop table siscel.fa_factabon_&1;
spool off
exit;
