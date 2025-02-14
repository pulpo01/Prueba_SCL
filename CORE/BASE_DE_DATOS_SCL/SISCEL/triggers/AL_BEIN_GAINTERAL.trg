CREATE OR REPLACE TRIGGER SISCEL.AL_BEIN_GAINTERAL
BEFORE INSERT
ON SISCEL.AL_GAINTERAL
FOR EACH ROW

DECLARE
   v_interal   ga_pac_interal.type_inter;
BEGIN
 v_interal.tipo      := :new.tipo;
 v_interal.tipstock  := :new.tip_stock;
 v_interal.bodega    := :new.cod_bodega;
 v_interal.articulo  := :new.cod_articulo;
 v_interal.uso       := :new.cod_uso;
 v_interal.estado    := :new.cod_estado;
 v_interal.venta     := :new.num_venta;
 v_interal.cantid  := :new.num_cantidad;
 v_interal.serie     := :new.num_serie;
 v_interal.indtel    := :new.ind_telefono;
 v_interal.transac   := :new.num_transaccion;
 v_interal.error     := 0;
 v_interal.central   := null;
 v_interal.subalm    := null;
 v_interal.celular   := null;
 v_interal.cat       := null;
 ga_pac_interal.p_trata_interfaz(v_interal);
END;
/
SHOW ERRORS
