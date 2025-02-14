CREATE OR REPLACE TRIGGER GSM_AFUP_SEC_ARC_TG
AFTER UPDATE
ON GSM_ARCHIVOS_TO
FOR EACH ROW
             
WHEN ( NEW.COD_ESTADO = '1'   AND   NEW.COD_ESTADO <> OLD.COD_ESTADO )
declare
  v_archivo  GSM_ARCHIVOS_TO%rowtype;
begin
        v_archivo.num_version    :=  :new.num_version;
        v_archivo.cod_archivo    :=      :new.cod_archivo;

        update GSM_PROVEEDORES_ARCHIVOS_TO
        set    num_version = v_archivo.num_version
        where  cod_archivo =v_archivo.cod_archivo;
END;
/
SHOW ERRORS
