CREATE OR REPLACE TRIGGER SISCEL.AL_AFIN_HSERORD
AFTER INSERT
ON SISCEL.AL_HSERIES_ORDENES

DECLARE
BEGIN
DELETE AL_HSERIES_ORDENES WHERE TIP_ORDEN=9  AND NUM_ORDEN > 0;
END;
/
SHOW ERRORS
