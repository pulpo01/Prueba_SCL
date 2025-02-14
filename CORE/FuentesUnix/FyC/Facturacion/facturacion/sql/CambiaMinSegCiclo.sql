set pages 0
set pause off
set veri off
set head off
set linesize 110
set feedback off
set termout on
UPDATE
  TOL_ACUMOPER
SET
  CNT_INICIAL = DECODE(IND_UNIDAD,'M',CNT_INICIAL*60,CNT_INICIAL),
  IND_UNIDAD  = DECODE(IND_UNIDAD,'M','S',IND_UNIDAD)
WHERE
  COD_CICLFACT = &1
AND 
  LTRIM(RTRIM(TIP_DCTO)) IS NOT NULL;
COMMIT;
/
exit;
