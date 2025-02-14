set pages 0
set pause off
set veri off
set head off
set linesize 110
set feedback off
set termout on
SELECT  NUM_PROCESO,COD_TIPDOCUM
FROM  FA_INTERVENTA 
WHERE  COD_ESTADO=&1
AND  COD_ESTPROC=&2
/
exit;
