CREATE OR REPLACE TRIGGER "EBZ_SISCEL".npt_devolucion_ACT_DEVO_TG
after INSERT
ON NPT_ESTADO_DEVOLUCION
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE
	error_actualizacion EXCEPTION;
BEGIN

    UPDATE NPT_DEVOLUCION SET estado_devolucion = :NEW.cod_estado_flujo
    WHERE cod_devolucion = :NEW.cod_devolucion;

    EXCEPTION
	WHEN OTHERS THEN
	RAISE_APPLICATION_ERROR (0,'Se produjo un error al actualizar la tabla npt_devolucion.');

end;
/
SHOW ERRORS
