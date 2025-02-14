-- Script : FaPermiso_ICONTABLE_SCL.sql
-- Date   : 10/05/05
set ver off feed off term off echo off
spool $WORKDIR/FaPermiso_ICONTABLE_SCL
grant SELECT on fa_histclie_&1 to ICONTABLE_SCL;
grant SELECT on fa_histconc_&1 to ICONTABLE_SCL;
grant SELECT on fa_histecno_th_&1 to ICONTABLE_SCL;
grant SELECT on fa_histabon_&1 to ICONTABLE_SCL;
spool off
exit;

