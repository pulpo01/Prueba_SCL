CREATE OR REPLACE TRIGGER SISCEL.al_afde_serord3
AFTER DELETE
ON SISCEL.AL_SERIES_ORDENES3
FOR EACH ROW

DECLARE
   v_serord    al_series_ordenes3%rowtype;
BEGIN
--
   v_serord.num_orden      := :old.num_orden;
   v_serord.tip_orden      := :old.tip_orden;
   v_serord.num_linea      := :old.num_linea;
   v_serord.num_serie      := :old.num_serie;
   v_serord.num_seriemec   := :old.num_seriemec;
   v_serord.cod_producto   := :old.cod_producto;
   v_serord.cod_central    := :old.cod_central;
   v_serord.cap_code       := :old.cap_code;
   v_serord.num_telefono   := :old.num_telefono;
   v_serord.cod_subalm     := :old.cod_subalm;
   v_serord.cod_cat        := :old.cod_cat;
   al_proc_devolucion.p_borrado_serord3(v_serord);
END AL_AFDE_SERORD3;
/
SHOW ERRORS
