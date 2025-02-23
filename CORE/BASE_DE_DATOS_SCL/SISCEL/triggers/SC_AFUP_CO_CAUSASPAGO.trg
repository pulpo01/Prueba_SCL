CREATE OR REPLACE TRIGGER SC_AFUP_CO_CAUSASPAGO
AFTER UPDATE
ON CO_CAUSASPAGO FOR EACH ROW

WHEN (
NEW.DES_CAUPAGO <> OLD.DES_CAUPAGO
      )
DECLARE
v_codigo NUMBER(2);
BEGIN
       SELECT cod_dominio_cto
       INTO v_codigo
       FROM SC_DOMINIO_CTO
       WHERE DES_DOMINIO_CTO = 'CO_CAUSASPAGO';
       IF v_codigo > 0 THEN
       UPDATE SC_CONCEPTO
       SET DES_CONCEPTO = :NEW.DES_CAUPAGO
       WHERE COD_DOMINIO_CTO = v_codigo
       AND COD_CONCEPTO = LPAD(:OLD.COD_CAUPAGO,6,'0');
       END IF;
EXCEPTION
      WHEN NO_DATA_FOUND THEN
                v_codigo := 0;
      WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR  (-20002,'ERROR INESPERADO EN TRIGGER : ORA-'||TO_CHAR(SQLCODE)||'.',TRUE);
END;
/
SHOW ERRORS
