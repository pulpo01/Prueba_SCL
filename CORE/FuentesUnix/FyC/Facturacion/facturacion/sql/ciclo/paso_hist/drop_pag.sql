-- Script : drop_pag.sql
set ver off echo off feedback off
spool $WORKDIR/drop_cli
delete from co_ultpago_tt where cod_ciclfact = &1;
spool off
exit;
