CREATE OR REPLACE TRIGGER SISCEL.AL_BEIN_MOVIM
BEFORE INSERT
ON SISCEL.AL_MOVIMIENTOS
FOR EACH ROW

DECLARE
  v_movim al_movimientos%ROWTYPE;
BEGIN
  v_movim.num_movimiento    := :new.num_movimiento;
  v_movim.tip_movimiento    := :new.tip_movimiento;
  v_movim.fec_movimiento    := :new.fec_movimiento;
  v_movim.cod_bodega        := :new.cod_bodega;
  v_movim.cod_articulo      := :new.cod_articulo;
  v_movim.num_cantidad      := :new.num_cantidad;
  v_movim.cod_estadomov     := :new.cod_estadomov;
  v_movim.num_serie         := :new.num_serie;
  v_movim.cod_bodega_dest   := :new.cod_bodega_dest;
  v_movim.num_desde         := :new.num_desde;
  v_movim.num_hasta         := :new.num_hasta;
  v_movim.num_guia          := :new.num_guia;
  v_movim.cod_uso           := :new.cod_uso;
  v_movim.cod_estado        := :new.cod_estado;
  v_movim.tip_stock         := :new.tip_stock;
  v_movim.tip_stock_dest    := :new.tip_stock_dest;
  v_movim.cod_uso_dest      := :new.cod_uso_dest;
  v_movim.cod_estado_dest   := :new.cod_estado_dest;
  v_movim.prc_unidad        := :new.prc_unidad;
  v_movim.cap_code          := :new.cap_code;
  v_movim.num_telefono      := :new.num_telefono;
  v_movim.num_seriemec      := :new.num_seriemec;
  v_movim.nom_usuarora      := :new.nom_usuarora;
  v_movim.cod_transaccion   := :new.cod_transaccion;
  v_movim.num_transaccion   := :new.num_transaccion;
  v_movim.cod_producto      := :new.cod_producto;
  v_movim.cod_central       := :new.cod_central;
  v_movim.cod_moneda        := :new.cod_moneda;
  v_movim.cod_subalm        := :new.cod_subalm;
  v_movim.cod_central_dest  := :new.cod_central_dest;
  v_movim.cod_subalm_dest   := :new.cod_subalm_dest;
  v_movim.num_telefono_dest := :new.num_telefono_dest;
  v_movim.cod_cat           := :new.cod_cat;
  v_movim.cod_cat_dest      := :new.cod_cat_dest;
  v_movim.ind_telefono      := :new.ind_telefono;
  v_movim.num_sec_loca      := :new.num_sec_loca;
  v_movim.plan              := :new.plan;
  v_movim.carga             := :new.carga;
  v_movim.cod_plaza         := :new.cod_plaza;
  v_movim.cod_hlr           := :new.cod_hlr;
  --
  -- Llamada al proceso de tratamiento del movimiento para actualizacion de
  -- las tablas de stock
  --
  al_proc_movto.p_trata_movim (v_movim);
  IF :new.cod_producto is null then
 al_pac_validaciones.p_obtiene_producto(:new.cod_articulo,
          :new.cod_producto);
  end if;
  :new.cod_estadomov := 'PR';
End;
/
SHOW ERRORS
