CREATE OR REPLACE TRIGGER SC_AFUP_AL_MOTIVOS_ES_EXTRAS
AFTER UPDATE
ON AL_MOTIVOS_ES_EXTRAS FOR EACH ROW

WHEN (
NEW.DES_MOTIVO <> OLD.DES_MOTIVO
      )
DECLARE
v_codigo NUMBER(2);
BEGIN
       SELECT cod_dominio_cto
       INTO v_codigo
       FROM SC_DOMINIO_CTO
       WHERE DES_DOMINIO_CTO = 'AL_MOTIVOS_ES_EXTRAS';
       IF v_codigo > 0  THEN
       UPDATE SC_CONCEPTO
       SET DES_CONCEPTO = :NEW.DES_MOTIVO
       WHERE COD_DOMINIO_CTO = v_codigo
       AND COD_CONCEPTO = LPAD(:OLD.COD_MOTIVO,6,'0');
       END IF;
EXCEPTION
       WHEN NO_DATA_FOUND THEN
                 v_codigo := 0;
       WHEN OTHERS THEN
       RAISE_APPLICATION_ERROR  (-20002,'ERROR INESPERADO EN TRIGGER : ORA-'||TO_CHAR(SQLCODE)||'.',TRUE);
END;
/
SHOW ERRORS
