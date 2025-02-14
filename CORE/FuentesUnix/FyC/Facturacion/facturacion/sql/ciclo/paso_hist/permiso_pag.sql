-- Script : permiso_pag.sql
-- Date   : 12/12/2007
set ver off feed off term off echo off

spool $WORKDIR/permiso_cli

grant ALTER on  fa_histpago_&1 to SISCEL_ADMIN;
grant DELETE on fa_histpago_&1 to SISCEL_ADMIN;
grant INSERT on fa_histpago_&1 to SISCEL_ADMIN;
grant SELECT on fa_histpago_&1 to SISCEL_ADMIN;
grant UPDATE on fa_histpago_&1 to SISCEL_ADMIN;
grant SELECT on fa_histpago_&1 to SISCEL_SELECT;
grant DELETE on fa_histpago_&1 to SISCEL_FA;
grant INSERT on fa_histpago_&1 to SISCEL_FA;
grant SELECT on fa_histpago_&1 to SISCEL_FA;
grant UPDATE on fa_histpago_&1 to SISCEL_FA;
create public synonym fa_histpago_&1 for fa_histpago_&1;
spool off
exit;

