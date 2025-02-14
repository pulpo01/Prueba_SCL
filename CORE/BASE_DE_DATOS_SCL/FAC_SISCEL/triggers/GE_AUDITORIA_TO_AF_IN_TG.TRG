CREATE OR REPLACE TRIGGER GE_AUDITORIA_TO_AF_IN_TG AFTER
INSERT
OR UPDATE ON GE_AUDITORIA_TO FOR EACH ROW DECLARE
	error_actualizacion EXCEPTION;
BEGIN
 /*
    IF :NEW.estado_solicitud <> :OLD.estado_solicitud OR :NEW.cantidad_registro = 0 THEN
        INSERT INTO GE_AUDITORIA_TH(num_ticket, fecha_estado, estado_solicitud, fecha_solicitud, fecha_cierre_solicitud,
		                            usuario, num_proceso, parametros_in, cantidad_registro, evento, cod_msgerror, cod_plataforma,
									cod_servicio, cod_transaccion)
        VALUES(:NEW.num_ticket, :NEW.fecha_estado, :NEW.estado_solicitud, :NEW.fecha_solicitud, :NEW.fecha_cierre_solicitud,
		       :NEW.usuario, :NEW.num_proceso, :NEW.parametros_in, :NEW.cantidad_registro, :NEW.evento, :NEW.cod_msgerror,
			   :NEW.cod_plataforma, :NEW.cod_servicio, :NEW.cod_transaccion);
	END IF;
	EXCEPTION
	    WHEN OTHERS THEN
	        RAISE_APPLICATION_ERROR (-20098,'Se produjo un error al actualizar. - '||SQLERRM);
   */
   
   NULL ;	        
END;
/
SHOW ERRORS
