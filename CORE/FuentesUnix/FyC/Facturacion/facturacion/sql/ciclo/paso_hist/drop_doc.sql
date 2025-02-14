-- Script : drop_doc.sql
set ver off echo off feedback off
spool $WORKDIR/drop_doc
drop public synonym fa_factdocu_&1;
drop table siscel.fa_factdocu_&1;
spool off
exit;
