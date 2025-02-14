CREATE OR REPLACE TRIGGER PV_CARGOS_BE_IN_TG
BEFORE INSERT ON GE_CARGOS
FOR EACH ROW
DECLARE
v_tecnologia GE_CARGOS.cod_tecnologia%type;

-- Autor : Patricia Castro R.(Posventa)
-- Fecha 01 Julio 2003

-- Modificacion 16 Septiembre 2003
-- Comentario : Inserta la tecnologia del abonado,
-- 	        siempre y cuando exita un numero de venta

-- Modificacion : 31 Mayo 2004
-- Autor        : Wildo Ramos C.
-- Comentario   : Inserta la subtecnologia del articulo asociado
-- 	          al concepto del cargo. Si el valor obtenido es nulo
--                inserta el valor por defecto que se encuentra definido
--                en la tabla GED_PARAMETROS para el nom_parametro =
--                'NO_TECNOLOGIA'

-- Modificacion : 31 agosto 2004
-- Autor        : Igor Gonzalez.
-- Comentario   : Modificacion para obtener la tecnologia del abonado,
-- 	          cuando este existe

BEGIN
	 v_tecnologia := null;
	 IF (:NEW.num_abonado IS NOT NULL) AND (:NEW.num_abonado > 0) THEN
	     IF (:NEW.NUM_VENTA IS NOT NULL) THEN
	 	BEGIN
  	 		 SELECT  COD_TECNOLOGIA
		  	 INTO v_tecnologia
		  	 FROM ( SELECT COD_TECNOLOGIA
		  	   	  FROM GA_ABOAMIST
			   	  WHERE NUM_ABONADO = :NEW.NUM_ABONADO
			   	  UNION
			   	  SELECT COD_TECNOLOGIA
			   	  FROM GA_ABOCEL
			   	  WHERE NUM_ABONADO =:NEW.NUM_ABONADO);

	 		 IF (v_tecnologia IS NOT NULL) THEN
			 	BEGIN
				    :NEW.COD_TECNOLOGIA := v_tecnologia;
				END;
			 END IF;
		END;
	     END IF;
	END IF;

	EXCEPTION
	WHEN OTHERS THEN
	NULL;

END PV_CARGOS_BE_IN_TG;
/
SHOW ERRORS
