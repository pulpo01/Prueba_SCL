CREATE OR REPLACE TRIGGER SC_GEOF_AFIN_TG
AFTER INSERT ON GE_OFICINAS
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

-- PL/SQL Specification
--
-- *************************************************************
-- * trigger            : SC_GEOF_AFIN_TG
-- * Descripción        : Inserta Oficinas en tabla SC_CONCEPTO
-- * Fecha de creación  : 08/04/2004
-- * Responsable        : Nestor Rodriguez
-- *************************************************************
DECLARE
v_codigo NUMBER(2);
v_largo NUMBER(2);

BEGIN
       SELECT cod_dominio_cto, nvl(len_concepto,6)
       INTO v_codigo, v_largo
       FROM SC_DOMINIO_CTO
       WHERE DES_DOMINIO_CTO = 'GE_OFICINAS';

       IF v_codigo > 0  THEN

          INSERT INTO SC_CONCEPTO
          	 (COD_DOMINIO_CTO,COD_CONCEPTO,IND_CONTABILIZA,DES_CONCEPTO)
          VALUES (v_codigo, LPAD(:NEW.COD_OFICINA,v_largo,'0'),0,:NEW.DES_OFICINA);

       END IF;
EXCEPTION
               WHEN NO_DATA_FOUND THEN
                         v_codigo := 0;
               WHEN OTHERS THEN
                         RAISE_APPLICATION_ERROR  (-20002,'ERROR INESPERADO EN TRIGGER : ORA-'||TO_CHAR(SQLCODE)||'.',TRUE);
END;
/
SHOW ERRORS
