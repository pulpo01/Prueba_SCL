set pages 0
set pause off
set veri off
set head off
set linesize 110
set feedback off
set termout on
UPDATE  FA_INTERVENTA
SET  COD_ESTADO = &2,
COD_ESTPROC = &3,
FEC_PROCESO = SYSDATE,
FEC_ESTADO = SYSDATE
WHERE  NUM_PROCESO = &1 ;
COMMIT
/
exit;
