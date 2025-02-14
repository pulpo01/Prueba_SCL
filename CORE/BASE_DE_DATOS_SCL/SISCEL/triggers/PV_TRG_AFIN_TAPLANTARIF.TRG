CREATE OR REPLACE TRIGGER PV_TRG_AFIN_TAPLANTARIF
AFTER INSERT ON TA_PLANTARIF
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
--	  Autor : Karem Fernandez Ayala
--   Fecha:   05/02/2003
--	 Comentario; triggers que inserta plan de prepago despues que inserta
---  			 planta tarifario en la tabla ta_plantarif, se sabe que es prepago
---- 			 cuando el codigo tipo de plan es igual a 1

BEGIN
IF INSERTING THEN
    IF :NEW.COD_TIPLAN = 1 THEN
		INSERT INTO PPD_PLANES (
		COD_PLANTARIF	,
	    DES_PLANTARIF,
		IND_COBSAL,
		IND_COBENT,
		FEC_DESDE,
		FEC_HASTA
		)
		VALUES
		(:NEW.COD_PLANTARIF,
	     :NEW.DES_PLANTARIF,
		 1,
		 1,
		 :NEW.FEC_DESDE,
		 :NEW.FEC_HASTA
		 );
	END IF;
	COMMIT;
END IF;
	EXCEPTION
	WHEN OTHERS THEN
	NULL;
END PV_TRG_AFIN_TAPLANTARIF;
/
SHOW ERRORS
