-- Script : permiso_bon.sql
-- Date   : 23/9/99
set ver off feed off term off echo off 
spool $WORKDIR/permiso_bon
grant ALTER on fa_histabon_&1 to SISCEL_ADMIN;
grant DELETE on fa_histabon_&1 to SISCEL_ADMIN;
grant INSERT on fa_histabon_&1 to SISCEL_ADMIN;
grant SELECT on fa_histabon_&1 to SISCEL_ADMIN;
grant UPDATE on fa_histabon_&1 to SISCEL_ADMIN;
grant SELECT on fa_histabon_&1 to SISCEL_SELECT;
grant DELETE on fa_histabon_&1 to SISCEL_FA;
grant INSERT on fa_histabon_&1 to SISCEL_FA;
grant SELECT on fa_histabon_&1 to SISCEL_FA;
grant UPDATE on fa_histabon_&1 to SISCEL_FA;
create public synonym fa_histabon_&1 for fa_histabon_&1;
spool off
exit;
