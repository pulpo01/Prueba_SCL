CREATE OR REPLACE TRIGGER ICC_AFIN_HISTMOV
 AFTER INSERT ON ICC_HISTMOVIMIENTO

DECLARE
  V_TABLA VARCHAR2(35):= NULL;
BEGIN
  V_TABLA:= 'ICC_HISTMOVIMIENTO';

  DELETE FROM ICC_HISTMOVIMIENTO WHERE COD_ACT = 'BO';

  EXCEPTION WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20006,'ERROR TRIGGER ICC_AFIN_HISTMOV: '||V_TABLA||' ORA'||TO_CHAR(SQLCODE),TRUE);
END;
/
SHOW ERRORS
