-- Script : permiso_tecno.sql
-- Date   : 05/9/03
set ver off feed off term off echo off
spool $WORKDIR/permiso_tecno
grant ALTER on fa_histecno_th_&1 to SISCEL_ADMIN;
grant DELETE on fa_histecno_th_&1 to SISCEL_ADMIN;
grant INSERT on fa_histecno_th_&1 to SISCEL_ADMIN;
grant SELECT on fa_histecno_th_&1 to SISCEL_ADMIN;
grant UPDATE on fa_histecno_th_&1 to SISCEL_ADMIN;
grant SELECT on fa_histecno_th_&1 to SISCEL_SELECT;
grant DELETE on fa_histecno_th_&1 to SISCEL_FA;
grant INSERT on fa_histecno_th_&1 to SISCEL_FA;
grant SELECT on fa_histecno_th_&1 to SISCEL_FA;
grant UPDATE on fa_histecno_th_&1 to SISCEL_FA;
create public synonym fa_histecno_th_&1 for fa_histecno_th_&1;
spool off
exit;

