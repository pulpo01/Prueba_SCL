set echo off verify off
spool $WORKDIR/borra_ultpago.log

delete CO_ULTPAGO_TT
/

COMMIT
/

spool off
exit;
