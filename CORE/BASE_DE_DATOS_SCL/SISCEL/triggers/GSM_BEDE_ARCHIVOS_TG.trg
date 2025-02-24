CREATE OR REPLACE TRIGGER GSM_BEDE_ARCHIVOS_TG
BEFORE  DELETE
ON GSM_ARCHIVOS_TO
FOR EACH ROW

DECLARE
   v_COD_ARCHIVO GSM_ARCHIVOS_TO.COD_ARCHIVO%TYPE;
   v_NUM_VERSION GSM_ARCHIVOS_TO.NUM_VERSION%TYPE;
begin
   v_COD_ARCHIVO := :old.COD_ARCHIVO;
   v_NUM_VERSION := :old.NUM_VERSION;
   -- Elimina de GSM_SECIONES_ARCHIVOS_TO
   DELETE GSM_SECIONES_ARCHIVOS_TO
   WHERE COD_ARCHIVO = v_COD_ARCHIVO
   AND NUM_VERSION =v_NUM_VERSION;
end;
/
SHOW ERRORS
