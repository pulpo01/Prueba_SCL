CREATE OR REPLACE TRIGGER SISCEL.al_afin_serord3
AFTER INSERT
ON SISCEL.AL_SERIES_ORDENES3
FOR EACH ROW

DECLARE
   v_serord    al_series_ordenes3%rowtype;
BEGIN
--
   v_serord.num_orden        := :new.num_orden;
   v_serord.tip_orden        := :new.tip_orden;
   v_serord.num_linea        := :new.num_linea;
   v_serord.num_serie        := :new.num_serie;
   v_serord.num_seriemec     := :new.num_seriemec;
   v_serord.cod_producto     := :new.cod_producto;
   v_serord.cod_central      := :new.cod_central;
   v_serord.cap_code         := :new.cap_code;
   v_serord.num_telefono     := :new.num_telefono;
   v_serord.cod_subalm       := :new.cod_subalm;
   v_serord.cod_cat          := :new.cod_cat;
   al_proc_devolucion.p_inserta_serord3(v_serord);
END;
/
SHOW ERRORS
