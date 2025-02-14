CREATE OR REPLACE TRIGGER AUD_EXCLUIDOS_ACCIONES_AFIN_TG
AFTER DELETE ON CO_EXCLUIDOS_ACCIONES_TO
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
DECLARE
    N_RESPUESTA NUMBER;
	lv_fec_ini VARCHAR2(50);
    ERROR_PROCESO EXCEPTION;
BEGIN

    IF :OLD.fec_ini_exclusion IS NULL THEN
	   lv_fec_ini:= 'NULL';
	ELSE
	   lv_fec_ini:= TO_CHAR(:OLD.fec_ini_exclusion,'DD/MM/YYYY HH24:MI:SS');
	END IF;
	N_RESPUESTA := AUD_AUDITORIA_PG.AUD_REGISTRA_AUDITORIA_FN (
				ev_owner => 'SISCEL',
				ev_tabla => 'CO_EXCLUIDOS_ACCIONES_TO',
				ev_operacion => 'DELETE',
				ev_pk => :OLD.cod_cliente||'#' ||:OLD.tip_exclusion,
				ev_detalle => TO_CHAR(:OLD.fec_ingreso,'DD/MM/YYYY HH24:MI:SS' ) || ',' ||
							lv_fec_ini

				);

EXCEPTION
        WHEN ERROR_PROCESO THEN
           NULL;
		WHEN OTHERS THEN
		   NULL;
END AUD_GE_DIRECCIONES_AFIN_TG;
/
SHOW ERRORS
