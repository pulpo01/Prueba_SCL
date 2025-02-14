CREATE OR REPLACE TRIGGER SC_AFIN_GE_OPERPLAZA_TD
AFTER INSERT
ON GE_OPERPLAZA_TD
FOR EACH ROW
DECLARE
v_codigo NUMBER(2);
v_des_plaza VARCHAR2(50);
BEGIN
       SELECT cod_dominio_cto
       INTO v_codigo
       FROM SC_DOMINIO_CTO
       WHERE DES_DOMINIO_CTO = 'GE_OPERPLAZA_TD';
       IF v_codigo > 0  THEN
              SELECT DES_PLAZA
                  INTO v_des_plaza
                  FROM GE_PLAZAS_TD
                  WHERE COD_PLAZA =  :NEW.COD_PLAZA;
          INSERT
          INTO SC_CONCEPTO(COD_DOMINIO_CTO, COD_CONCEPTO, IND_CONTABILIZA, DES_CONCEPTO)
          VALUES (v_codigo, LPAD(:NEW.COD_PLAZA,6,'0'), 0, v_des_plaza);
       END IF;
EXCEPTION
       WHEN NO_DATA_FOUND THEN
                 v_codigo := 0;
                                 v_des_plaza := '';
       WHEN OTHERS THEN
                 RAISE_APPLICATION_ERROR  (-20002,'ERROR INESPERADO EN TRIGGER : ORA-'||TO_CHAR(SQLCODE)||'.',TRUE);
END;
/
SHOW ERRORS
