CREATE OR REPLACE TRIGGER SC_MOTIVOPAGO_AFIN_TG
AFTER INSERT ON CO_MOTIVOPAGO_NA
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

-- PL/SQL Specification
--
-- *************************************************************
-- * trigger            : SC_MOTIVOPAGO_AFIN_TG
-- * Descripcion        : Inserta Motivos de Pago en tabla SC_CONCEPTO
-- * Fecha de creacion  : 17/08/2004
-- *************************************************************

DECLARE
v_codigo NUMBER(2);
v_largo NUMBER(2);

BEGIN
       SELECT cod_dominio_cto, nvl(len_concepto,6)
       INTO v_codigo, v_largo
       FROM SC_DOMINIO_CTO
       WHERE DES_DOMINIO_CTO = 'CO_MOTIVOPAGO_NA';

       IF v_codigo > 0  THEN

          INSERT INTO SC_CONCEPTO
          	 (COD_DOMINIO_CTO,COD_CONCEPTO,IND_CONTABILIZA,DES_CONCEPTO)
          VALUES (v_codigo, LPAD(:NEW.COD_MOTIVO,v_largo,'0'),0,:NEW.DES_MOTIVO);

       END IF;
EXCEPTION
               WHEN NO_DATA_FOUND THEN
                         v_codigo := 0;
               WHEN OTHERS THEN
                         RAISE_APPLICATION_ERROR  (-20002,'ERROR INESPERADO EN TRIGGER : ORA-'||TO_CHAR(SQLCODE)||'.',TRUE);
END;
/
SHOW ERRORS
