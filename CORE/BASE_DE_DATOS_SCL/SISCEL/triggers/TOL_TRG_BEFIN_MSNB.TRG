CREATE OR REPLACE TRIGGER TOL_TRG_BEFIN_MSNB
BEFORE INSERT ON TA_MSNB
--REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE
     v_Ta_OperadoresCOD_DOPE  ta_operadores.COD_DOPE%TYPE;
     v_Ta_OperadoresCOD_TOPE  ta_operadores.COD_TOPE%TYPE;
     query_str                VARCHAR2(1000):='';
     cod_troa                 VARCHAR2(5):='';
BEGIN
   -- Extrae Codigos Tipo Operadora y Direccion Operadora
     SELECT t.COD_DOPE,
            t.COD_TOPE
       INTO v_Ta_OperadoresCOD_DOPE,
            v_Ta_OperadoresCOD_TOPE
     FROM  TA_OPERADORES t
     WHERE COD_OPERADOR = :NEW.cod_operador;
  IF (:NEW.IND_ROAMING = 1) THEN     --INSERTARA LOS RANGOS NUMERICO ROAMING AUTOMATICO
     cod_troa := 'A';
  ELSIF (:NEW.IND_ROAMING = 2) THEN  --INSERTARA LOS RANGOS NUMERICO ROAMING MANUAL
     cod_troa := 'M';
  ELSE
     cod_troa := ' ';
  END IF;
 query_str:='INSERT INTO TOL_RANNUME_TD (cod_rang,cod_oper,num_lini,num_linf,cod_area,cod_tope,cod_dope,cod_troa)';
 query_str:=query_str || ' VALUES (:1,:2,:3,:4,:5,:6,:7,:8)';
 EXECUTE IMMEDIATE query_str USING 'ROAM',:NEW.cod_operador,:NEW.num_tdesde,:NEW.num_thasta,
                                   :NEW.cod_area, v_Ta_OperadoresCOD_TOPE,
                                                                   v_Ta_OperadoresCOD_DOPE,cod_troa;
 EXCEPTION
   WHEN OTHERS THEN
   RAISE_APPLICATION_ERROR(-20999,'ERROR EN EL TRIGGER TOL_TRG_BEFIN_NUMINTERNACIONAL '||SQLERRM);
   NULL;
END;
/
SHOW ERRORS
