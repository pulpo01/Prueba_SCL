CREATE OR REPLACE TRIGGER SC_AFIN_VETIPCOMIS
AFTER INSERT
ON VE_TIPCOMIS
FOR EACH ROW

DECLARE
v_codigo NUMBER(2);
v_largo NUMBER(2);
BEGIN
       INSERT INTO ve_plantilla_tipcomis_td
       (SELECT cod_campo, :NEW.COD_TIPCOMIS,1,1,sysdate, user from ve_campos_td );

	   SELECT cod_dominio_cto, nvl(len_concepto,6)
       INTO v_codigo, v_largo
       FROM SC_DOMINIO_CTO
       WHERE DES_DOMINIO_CTO = 'VE_TIPCOMIS';

       IF v_codigo > 0  THEN

          INSERT INTO SC_CONCEPTO
          		 (COD_DOMINIO_CTO,COD_CONCEPTO,IND_CONTABILIZA,DES_CONCEPTO)
          VALUES (v_codigo, LPAD(:NEW.COD_TIPCOMIS,v_largo,'0'),0,:NEW.DES_TIPCOMIS);

       END IF;


EXCEPTION
               WHEN NO_DATA_FOUND THEN
                         v_codigo := 0;
               WHEN OTHERS THEN
                         RAISE_APPLICATION_ERROR  (-20002,'ERROR INESPERADO EN TRIGGER : ORA-'||TO_CHAR(SQLCODE)||'.',TRUE);
END;
/
SHOW ERRORS
