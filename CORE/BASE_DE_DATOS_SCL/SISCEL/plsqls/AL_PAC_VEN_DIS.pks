CREATE OR REPLACE PACKAGE al_pac_ven_dis IS
   PROCEDURE insertar_al_petiguias_abo (
      v_num_venta      IN   al_cargos.num_venta%TYPE,
      v_num_terminal   IN   al_cargos.num_terminal%TYPE,
      v_num_abonado    IN   al_cargos.num_abonado%TYPE,
      v_cod_cliente    IN   al_cargos.cod_cliente%TYPE,
      v_cod_bodega     IN   al_cargos.cod_bodega%TYPE,
      v_cod_articulo   IN   al_cargos.cod_articulo%TYPE,
      v_num_unidades   IN   al_cargos.num_unidades%TYPE,
      v_cod_moneda     IN   al_cargos.cod_moneda%TYPE,
      v_imp_cargo      IN   al_cargos.imp_cargo%TYPE,
      v_num_serie      IN   al_cargos.num_serie%TYPE,
      v_num_cargo      IN   al_cargos.num_cargo%TYPE,
      v_cod_concepto   IN   al_cargos.cod_concepto%TYPE
   );

   PROCEDURE insertar_icc_movimiento (
      v_cod_uso             IN   al_cargos.cod_uso%TYPE,
      v_cod_articulo        IN   al_cargos.cod_articulo%TYPE,
      v_num_serie           IN   al_cargos.num_serie%TYPE,
      v_cod_central         IN   al_cargos.cod_central%TYPE,
      v_num_terminal        IN   al_cargos.num_terminal%TYPE,
      v_ind_telefono        IN   al_cargos.ind_telefono%TYPE,
      v_plan                IN   al_cargos.PLAN%TYPE,
      v_carga               IN   al_cargos.carga%TYPE,
      var_ind_activacion    IN   al_ventas.ind_activacion%TYPE,
      v_cod_ami_plantarif   IN   ga_datosgener.cod_ami_plantarif%TYPE,
      v_tip_tecnologia      IN   icc_movimiento.tip_tecnologia%TYPE, -- GSM
      v_imsi                IN   icc_movimiento.imsi%TYPE, -- GSM IMSI
      v_imei                IN   icc_movimiento.imei%TYPE, -- GSM IMEI
      v_icc                 IN   icc_movimiento.icc%TYPE -- GSM ICC
   );

   PROCEDURE insertar_ga_ventas (var_ventas IN al_ventas%ROWTYPE);

   PROCEDURE insertar_ge_cargos (
      var_cargos          IN   al_cargos%ROWTYPE,
      var_nom_usuar_vta        al_ventas.nom_usuar_vta%TYPE
   );

   PROCEDURE upd_fa_interfact (
      v_folio         IN   al_ventas.num_folio%TYPE,
      v_num_venta     IN   VARCHAR2,
      v_fec_venci     IN   al_ventas.fec_vencimiento%TYPE,
      v_num_proceso   IN   fa_interfact.num_proceso%TYPE
   );

   PROCEDURE upd_ga_ventas (
      v_ind_estventa   IN   al_ventas.ind_estventa%TYPE,
      v_num_venta      IN   al_ventas.num_venta%TYPE
   );

   PROCEDURE insertar_ga_docventa (
      v_num_venta      IN   al_ventas.num_venta%TYPE,
      v_cod_tipdocum   IN   al_ventas.cod_tipdocum%TYPE,
      v_num_folio      IN   al_ventas.num_folio%TYPE
   );

   PROCEDURE insertar_ga_reservart (
      v_num_transaccion   IN   al_cargos.num_transaccion%TYPE,
      v_cod_articulo      IN   al_cargos.cod_articulo%TYPE,
      v_cod_bodega        IN   al_cargos.cod_bodega%TYPE,
      v_tip_stock         IN   al_cargos.tip_stock%TYPE,
      v_cod_estado        IN   al_cargos.cod_estado%TYPE,
      v_cod_uso           IN   al_cargos.cod_uso%TYPE,
      v_num_unidades      IN   al_cargos.num_unidades%TYPE,
      v_num_serie         IN   al_cargos.num_serie%TYPE,
      v_num_venta         IN   al_cargos.num_venta%TYPE,
      ilinea              IN   ga_reservart.num_linea%TYPE,
      iorden              IN   ga_reservart.num_orden%TYPE,
      v_cod_producto      IN   al_ventas.cod_producto%TYPE
   );

   PROCEDURE obtener_servsupl (
      v_cod_producto     IN       al_cargos.cod_producto%TYPE,
      v_cod_articulo     IN       al_cargos.cod_articulo%TYPE,
      v_cod_tecnologia   IN       ga_actabo.cod_tecnologia%TYPE,
      v_cod_servicios    IN OUT   icg_actuaciontercen.cod_servicios%TYPE
   );

   PROCEDURE insertar_ga_aboamist (
      v_num_abonado           IN       ga_aboamist.num_abonado%TYPE,
      v_cod_articulo          IN       al_cargos.cod_articulo%TYPE,
      v_num_terminal          IN       al_cargos.num_terminal%TYPE,
      v_cod_producto          IN       al_cargos.cod_producto%TYPE,
      v_cod_cliente           IN       al_cargos.cod_cliente%TYPE,
      v_cod_cuenta            IN       al_ventas.cod_cuenta%TYPE,
      v_cod_central           IN       al_cargos.cod_central%TYPE,
      v_cod_uso               IN       al_cargos.cod_uso%TYPE,
      v_cod_vendedor          IN       al_ventas.cod_vendedor%TYPE,
      v_cod_vendedor_agente   IN       al_ventas.cod_vendedor_agente%TYPE,
      v_num_serie             IN       al_cargos.num_serie%TYPE,
      v_num_venta             IN       al_ventas.num_venta%TYPE,
      v_cod_modventa          IN       al_ventas.cod_modventa%TYPE,
      v_cod_servicios         IN OUT   icg_actuaciontercen.cod_servicios%TYPE,
      v_ind_telefono          IN       al_cargos.ind_telefono%TYPE,
      v_cod_plantarif         IN       ga_aboamist.cod_plantarif%TYPE,
      v_tip_plantarif         IN       ga_aboamist.tip_plantarif%TYPE,
      v_cod_usuario           IN       ga_usuarios.cod_usuario%TYPE,
      vs_ind_telefono         IN       al_series.ind_telefono%TYPE,
      vs_plan                 IN       al_series.PLAN%TYPE,
      vs_carga                IN       al_series.carga%TYPE,
      v_cod_tecnologia        IN       al_tecnologia.cod_tecnologia%TYPE, --GSM
      v_imei                  IN       icc_movimiento.imei%TYPE, -- GSM
      v_cod_bodega_det        IN       npt_detalle_pedido.cod_bodega%TYPE,
      v_min_mdn                  IN       ga_aboamist.NUM_MIN_MDN%TYPE,
      v_cod_subalm              IN       al_series.COD_SUBALM%TYPE
   );

   PROCEDURE insertar_ga_equipaboser (
      v_num_abonado          IN   ga_aboamist.num_abonado%TYPE,
      v_num_serie            IN   al_cargos.num_serie%TYPE,
      v_cod_producto         IN   al_cargos.cod_producto%TYPE,
      v_cod_bodega           IN   al_cargos.cod_bodega%TYPE,
      v_tip_stock            IN   al_cargos.tip_stock%TYPE,
      v_cod_articulo         IN   al_cargos.cod_articulo%TYPE,
      v_cod_modventa         IN   al_ventas.cod_modventa%TYPE,
      v_cod_uso              IN   al_cargos.cod_uso%TYPE,
      v_cod_estado           IN   al_cargos.cod_estado%TYPE,
      v_des_cadena           IN   ga_transacabo.des_cadena%TYPE,
      v_num_serie_terminal   IN   ga_equipaboser.num_imei%TYPE, -- GSM
      v_cod_tecnologia         IN   al_cargos.COD_TECNOLOGIA%TYPE
   );

   PROCEDURE insertar_ga_servsuplabo (
      v_num_abonado     IN   ga_aboamist.num_abonado%TYPE,
      v_cod_producto    IN   al_cargos.cod_producto%TYPE,
      v_num_terminal    IN   al_cargos.num_terminal%TYPE,
      v_cod_servicios   IN   icg_actuaciontercen.cod_servicios%TYPE
   );

   PROCEDURE insertar_ga_usuamist (
      v_num_abonado    IN   ga_aboamist.num_abonado%TYPE,
      v_cod_tipident   IN   ge_clientes.cod_tipident%TYPE,
      v_num_ident      IN   ge_clientes.num_ident%TYPE,
      v_cod_usuario    IN   ga_usuarios.cod_usuario%TYPE
   );
END al_pac_ven_dis; 
/
SHOW ERRORS