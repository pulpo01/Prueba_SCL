CREATE OR REPLACE TRIGGER SC_AFUP_FACONCEPTOS
AFTER UPDATE
ON FA_CONCEPTOS
FOR EACH ROW

WHEN (
NEW.DES_CONCEPTO <> OLD.DES_CONCEPTO
      )
DECLARE
v_codigo NUMBER(2);
v_mapeo   NUMBER(1);

BEGIN
       SELECT cod_dominio_cto, IND_MAPEO_GRP
       INTO v_codigo, v_mapeo
       FROM SC_DOMINIO_CTO
       WHERE DES_DOMINIO_CTO = 'FA_CONCEPTOS';

       IF (v_codigo > 0) and (v_mapeo = 0) THEN
	       UPDATE SC_GRPCONCEPTO_TD
	       		 SET DES_GRPCONCEPTO = :NEW.DES_CONCEPTO
	       WHERE COD_GRPCONCEPTO = :OLD.COD_CONCEPTO
	       		 AND DOMINIO = 'FA_CONCEPTOS';
       END IF;

EXCEPTION
       WHEN NO_DATA_FOUND THEN
                 v_codigo := 0;
       WHEN OTHERS THEN
                 RAISE_APPLICATION_ERROR  (-20002,'ERROR INESPERADO EN TRIGGER : ORA-'||TO_CHAR(SQLCODE)||'.',TRUE);
END;
/
SHOW ERRORS
