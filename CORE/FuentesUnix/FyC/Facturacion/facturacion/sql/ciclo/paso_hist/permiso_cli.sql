-- Script : permiso_cli.sql
-- Date   : 23/9/99
set ver off feed off term off echo off
spool $WORKDIR/permiso_cli
grant ALTER on fa_histclie_&1 to SISCEL_ADMIN;
grant DELETE on fa_histclie_&1 to SISCEL_ADMIN;
grant INSERT on fa_histclie_&1 to SISCEL_ADMIN;
grant SELECT on fa_histclie_&1 to SISCEL_ADMIN;
grant UPDATE on fa_histclie_&1 to SISCEL_ADMIN;
grant SELECT on fa_histclie_&1 to SISCEL_SELECT;
grant DELETE on fa_histclie_&1 to SISCEL_FA;
grant INSERT on fa_histclie_&1 to SISCEL_FA;
grant SELECT on fa_histclie_&1 to SISCEL_FA;
grant UPDATE on fa_histclie_&1 to SISCEL_FA;
create public synonym fa_histclie_&1 for fa_histclie_&1;
spool off
exit;

