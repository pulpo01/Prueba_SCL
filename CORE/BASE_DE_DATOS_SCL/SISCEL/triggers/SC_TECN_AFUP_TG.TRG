CREATE OR REPLACE TRIGGER SC_TECN_AFUP_TG
AFTER UPDATE ON AL_TECNOLOGIA
FOR EACH ROW

WHEN (
NEW.DES_TECNOLOGIA <> OLD.DES_TECNOLOGIA
      )
DECLARE
v_codigo NUMBER(2);
v_largo NUMBER(2);
BEGIN
       SELECT cod_dominio_cto, nvl(len_concepto,6)
       INTO v_codigo, v_largo
       FROM SC_DOMINIO_CTO
       WHERE DES_DOMINIO_CTO = 'AL_TECNOLOGIA';

	   IF v_codigo > 0  THEN

   	   UPDATE SC_CONCEPTO
          SET DES_CONCEPTO = :NEW.DES_TECNOLOGIA
          WHERE COD_DOMINIO_CTO = v_codigo
          AND COD_CONCEPTO = LPAD(:NEW.COD_TECNOLOGIA,v_largo,'0');

	   END IF;
EXCEPTION
       WHEN NO_DATA_FOUND THEN
                 v_codigo := 0;
       WHEN OTHERS THEN
                 RAISE_APPLICATION_ERROR  (-20002,'ERROR INESPERADO EN TRIGGER : ORA-'||TO_CHAR(SQLCODE)||'.',TRUE);
END;
/
SHOW ERRORS
