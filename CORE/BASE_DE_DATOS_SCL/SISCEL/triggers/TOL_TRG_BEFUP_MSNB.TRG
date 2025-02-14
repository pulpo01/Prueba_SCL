CREATE OR REPLACE TRIGGER TOL_TRG_BEFUP_MSNB
BEFORE UPDATE ON ta_msnb
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE
     v_Ta_OperadoresCOD_TOPE ta_operadores.cod_tope%TYPE;
     v_Ta_OperadoresCOD_DOPE ta_operadores.cod_dope%TYPE;
     query_str    varchar2(1000):='';
     cod_troa     varchar2(5):='';
BEGIN
   -- Extrae Codigos Tipo Operadora y Direccion Operadora
     Select cod_tope,
            cod_dope
       Into v_Ta_OperadoresCOD_TOPE,
            v_Ta_OperadoresCOD_DOPE
     from ta_operadores
     where cod_operador = :NEW.cod_operador;

  IF (:NEW.IND_ROAMING = 1) THEN     --INSERTARA LOS RANGOS NUMERICO ROAMING AUTOMATICO
     cod_troa := 'A';
  ELSIF (:NEW.IND_ROAMING = 2) THEN  --INSERTARA LOS RANGOS NUMERICO ROAMING MANUAL
     cod_troa := 'M';
  ELSE
     cod_troa := ' ';
  END IF;

  query_str:='UPDATE TOL_RANNUME_TD SET ';
  query_str:=query_str || 'cod_oper=:1 ,num_lini =:2 ,num_linf = :3 ,';
  query_str:=query_str || 'cod_area=:4 ,cod_tope =:5 ,cod_dope = :6, cod_troa = :7';
  query_str:=query_str || ' WHERE cod_oper = :8';
  query_str:=query_str || '   AND num_lini = :9 AND num_linf = :10';

  EXECUTE IMMEDIATE query_str USING :NEW.cod_operador,:NEW.num_tdesde,:NEW.num_thasta,
                                   :NEW.cod_area, v_Ta_OperadoresCOD_TOPE,
                                                                   v_Ta_OperadoresCOD_DOPE,cod_troa,:OLD.cod_operador,
                                   :OLD.num_tdesde,:OLD.num_thasta;
 EXCEPTION
   WHEN OTHERS THEN
   RAISE_APPLICATION_ERROR(-20999,'ERROR EN EL TOL_TRG_BEFUP_MSNB '||SQLERRM);
   NULL;
END;
/
SHOW ERRORS
