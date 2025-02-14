-- Programa : permiso.sql
-- Author   : ACT
-- Date     : 23/9/99
-- Remarks  : Da los permisos a los roles necesarios para accesar la nueva fa_detcelular.
-- =====================================================================================
set ver off
spool $WORKDIR/permiso
create public synonym fa_detcelular_&1 for siscel.fa_detcelular_&1;
-- grant delete, insert, select, update on fa_detcelular_&1 to siscel_fa; 28/04/2000
grant select on fa_detcelular_&1 to siscel_select;
grant select on fa_detcelular_&1 to internet_select;
spool off
exit;
