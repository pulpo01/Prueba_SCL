CREATE OR REPLACE PACKAGE        AL_PAC_REPORT IS
  --
  -- Retrofitted
  PROCEDURE p_genera_report(
  v_interrep IN OUT al_interrep%rowtype ,
  v_bodega IN al_bodegas.cod_bodega%type ,
  v_mes IN date ,
  v_moneda IN ge_monedas.cod_moneda%type )
;
  --
  -- Retrofitted
  PROCEDURE p_obtiene_factura_seriado(
  v_transaccion IN al_movimientos.num_transaccion%type ,
  v_articulo IN al_movimientos.cod_articulo%type ,
  v_serie IN al_movimientos.num_serie%type ,
  v_factura IN OUT al_rep_consignacion.num_factura%type )
;
  --
  -- Retrofitted
  PROCEDURE p_obtiene_factura(
  v_transaccion IN al_movimientos.num_transaccion%type ,
  v_articulo IN al_movimientos.cod_articulo%type ,
  v_cantidad IN al_movimientos.num_cantidad%type ,
  v_factura IN OUT al_rep_consignacion.num_factura%type )
;
  --
  -- Retrofitted
  PROCEDURE p_obtiene_lista(
  v_articulo IN al_movimientos.cod_articulo%type ,
  v_fecha IN al_movimientos.fec_movimiento%type ,
  v_proveedor IN OUT al_rep_consignacion.cod_proveedor%type ,
  v_numlista IN OUT al_rep_consignacion.num_lista%type ,
  v_moneda IN OUT al_rep_consignacion.cod_moneda%type ,
  v_precio IN OUT al_rep_consignacion.prc_articulo%type ,
  v_error IN OUT al_interrep.cod_retorno%type ,
  v_mensa IN OUT al_interrep.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_obtiene_proveedor(
  v_articulo IN al_articulos.cod_articulo%type ,
  v_proveedor IN OUT al_articulos.cod_proveedor%type ,
  v_error IN OUT number )
;
  --
  -- Retrofitted
  PROCEDURE p_inserta_repcon(
  v_repcon IN al_rep_consignacion%rowtype ,
  v_error IN OUT al_interrep.cod_retorno%type ,
  v_mensa IN OUT al_interrep.des_cadena%type )
;
  --
  -- Retrofitted
  --
  -- Retrofitted
  --
  -- Retrofitted
  --
  -- Retrofitted
  --
  -- Retrofitted
  --
  -- Retrofitted
--
--
--
--
--
--
--
END AL_PAC_REPORT;
/
SHOW ERRORS
