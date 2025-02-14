CREATE OR REPLACE TRIGGER SP_ORRE_AFINUPDE_TG
AFTER INSERT OR UPDATE OR DELETE
ON SP_ORDENES_REPARACION
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW

DECLARE
  v_des_estado_orden VARCHAR2(30);
  v_cod_estado_orden CHAR;

  BEGIN


	  IF :NEW.id_tarea IS NOT NULL THEN


		  IF (:NEW.COD_ESTADO_ORDEN > 1) and (:NEW.COD_ESTADO_ORDEN < 15) THEN

	   	  SELECT DES_ESTADO_ORDEN
		  INTO	 v_des_estado_orden
		  FROM    SP_ESTADOS_ORDEN
		  WHERE  COD_ESTADO_ORDEN = :NEW.COD_ESTADO_ORDEN;

		  IF (:NEW.COD_ESTADO_ORDEN = 2) THEN
		  	 v_cod_estado_orden := 'A';
		  END IF;


	      IF (:NEW.COD_ESTADO_ORDEN > 2) AND (:NEW.COD_ESTADO_ORDEN < 14) THEN
--	 	  	 	v_cod_estado_orden := 'P'; comentado por incidencia de certificacion levantada por Rodrigo Araneda
				v_cod_estado_orden := 'A';
		  END IF;

		  IF (:NEW.COD_ESTADO_ORDEN = 14) THEN
			 v_cod_estado_orden := 'C';
	      END IF;



		  BEGIN
	    	  GC_CONTACTOS_PG.GC_ModificacionTareas_PR(5,v_cod_estado_orden, NULL, 1, :NEW.id_tarea, NULL, v_des_estado_orden, USER );
		  END ;

		  END IF;

	  END IF;


   EXCEPTION
		 WHEN OTHERS THEN
			RAISE_APPLICATION_ERROR(-20302, 'Error en Trigger SP_ORRE_AFINUPDE_TG' || SQLERRM );

END;
/
SHOW ERRORS
