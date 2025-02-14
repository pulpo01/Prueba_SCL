CREATE OR REPLACE TRIGGER GR_BEUP_AUDITORIA
BEFORE UPDATE
ON GR_AUDITORIA
FOR EACH ROW
 
WHEN (
new.cod_estado<>old.cod_estado
      )
DECLARE
fecha date;
BEGIN
fecha:=sysdate;
:new.fec_termino_dh:=fecha;
:new.fec_termino_d:=trunc(fecha);
END;
/
SHOW ERRORS
