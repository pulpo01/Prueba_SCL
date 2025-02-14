CREATE OR REPLACE TRIGGER GSM_BEDE_PREFIJO_TG
BEFORE  DELETE
ON GSM_PREFIJO_TO
FOR EACH ROW

DECLARE
  v_cod_secuencia GSM_PREFIJO_TO.COD_SECUENCIA%TYPE;
  v_cod_prefijo   GSM_PREFIJO_TO.COD_PREFIJO%TYPE;
begin
     --  Borro el prefijo y su secuencia.
         v_cod_secuencia  :=  :old.COD_SECUENCIA;
     v_cod_prefijo    :=  :old.COD_PREFIJO;
     DELETE FROM GSM_SECUENCIA_TO
     WHERE COD_SECUENCIA = v_cod_secuencia;

     --  Borro sus relaciones.
     DELETE FROM GSM_DEFINICION_PREFIJO_TO
     WHERE COD_PREFIJO = v_cod_prefijo;

     -- Borro el rangos de prefijo
     DELETE FROM GSM_RANGOS_PREFIJOS_TO
     WHERE COD_PREFIJO = v_cod_prefijo;


end;
/
SHOW ERRORS
