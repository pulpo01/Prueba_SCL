CREATE OR REPLACE PACKAGE ve_venta_accesorios_pg
AS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   cv_modulove         CONSTANT VARCHAR2 (5) := 'VE';
   cv_version          CONSTANT VARCHAR2 (5) := '1.0';
   cn_mov_salida       CONSTANT NUMBER       := 3;
   cn_estado_salida    CONSTANT NUMBER       := 7;
   cn_mov_reserv       CONSTANT NUMBER       := 6;
   cn_estado_reser     CONSTANT NUMBER       := 1;
   cn_est_reser_dest   CONSTANT NUMBER       := 7;

   TYPE refcursor IS REF CURSOR;


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_ins_acce_reserv_movim_pr (
      ev_cod_bodega        IN              al_movimientos.cod_bodega%TYPE,
      ev_cod_articulo      IN              al_movimientos.cod_articulo%TYPE,
      ev_cod_uso           IN              al_movimientos.cod_uso%TYPE,
      ev_nom_usuario       IN              al_movimientos.nom_usuarora%TYPE,
      ev_num_cantidad      IN              al_movimientos.num_cantidad%TYPE,
      ev_num_serie         IN              al_movimientos.num_serie%TYPE,
      ev_num_transaccion   IN              al_movimientos.num_transaccion%TYPE,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_ins_acce_salida_movim_pr (
      ev_cod_bodega        IN              al_movimientos.cod_bodega%TYPE,
      ev_cod_articulo      IN              al_movimientos.cod_articulo%TYPE,
      ev_cod_uso           IN              al_movimientos.cod_uso%TYPE,
      ev_nom_usuario       IN              al_movimientos.nom_usuarora%TYPE,
      ev_num_cantidad      IN              al_movimientos.num_cantidad%TYPE,
      ev_num_serie         IN              al_movimientos.num_serie%TYPE,
      ev_num_transaccion   IN              al_movimientos.num_transaccion%TYPE,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_select_datos_serie (
      v_serie           IN              al_series.num_serie%TYPE,
      v_central         OUT NOCOPY      al_series.cod_central%TYPE,
      v_subalm          OUT NOCOPY      al_series.cod_subalm%TYPE,
      v_telefono        OUT NOCOPY      al_series.num_telefono%TYPE,
      v_cat             OUT NOCOPY      al_series.cod_cat%TYPE,
      v_tip_stock       OUT NOCOPY      al_series.tip_stock%TYPE,
      v_plan            OUT NOCOPY      al_series.PLAN%TYPE,
      v_carga           OUT NOCOPY      al_series.carga%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_select_producto (
      v_articulo        IN              al_series.cod_articulo%TYPE,
      v_producto        OUT NOCOPY      al_series.cod_producto%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_select_tip_stock (
      v_cod_bodega      IN              al_stock.cod_bodega%TYPE,
      v_cod_articulo    IN              al_stock.cod_articulo%TYPE,
      v_cod_uso         IN              al_stock.cod_uso%TYPE,
      v_cod_estado      IN              al_stock.cod_estado%TYPE,
      sn_tip_stock      OUT NOCOPY      al_stock.tip_stock%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_existe_serie (
      v_num_serie       IN              al_series.num_serie%TYPE,
      v_cod_articulo    IN              al_stock.cod_articulo%TYPE,
      v_cod_uso         IN              al_stock.cod_uso%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_insert_reserv_art_pr (
      ev_cod_bodega        IN              ga_reservart.cod_bodega%TYPE,
      ev_cod_articulo      IN              ga_reservart.cod_articulo%TYPE,
      ev_cod_uso           IN              ga_reservart.cod_uso%TYPE,
      ev_nom_usuario       IN              ga_reservart.nom_usuario%TYPE,
      ev_num_cantidad      IN              ga_reservart.num_unidades%TYPE,
      ev_num_serie         IN              ga_reservart.num_serie%TYPE,
      ev_num_transaccion   IN              ga_reservart.num_transaccion%TYPE,
      ev_num_venta         IN              ga_reservart.num_venta%TYPE,
      ev_num_linea         IN              ga_reservart.num_linea%TYPE,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_select_datos_vendedor (
      v_cod_vendedor      IN              ve_vendedores.cod_vendedor%TYPE,
      sn_cod_tipcomis     OUT NOCOPY      ve_vendedores.cod_tipcomis%TYPE,
      sn_tipventa         OUT NOCOPY      ve_vendedores.ind_tipventa%TYPE,
      sn_cod_vende_raiz   OUT NOCOPY      ve_vendedores.cod_vende_raiz%TYPE,
      sv_cod_oficina      OUT NOCOPY      ve_vendedores.cod_oficina%TYPE,
      sv_cod_plaza        OUT NOCOPY      ve_vendedores.cod_plaza%TYPE,
      sv_cod_ciudad       OUT NOCOPY      ge_direcciones.cod_ciudad%TYPE,
      sv_cod_region       OUT NOCOPY      ge_direcciones.cod_region%TYPE,
      sv_cod_provincia    OUT NOCOPY      ge_direcciones.cod_provincia%TYPE,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_insert_venta_pr (
      v_num_venta             IN              ga_ventas.num_venta%TYPE,
      v_cod_producto          IN              ga_ventas.cod_producto%TYPE,
      v_cod_oficina           IN              ga_ventas.cod_oficina%TYPE,
      v_cod_tipcomis          IN              ga_ventas.cod_tipcomis%TYPE,
      v_cod_vendedor          IN              ga_ventas.cod_vendedor%TYPE,
      v_cod_vendedor_agente   IN              ga_ventas.cod_vendedor_agente%TYPE,
      v_num_unidades          IN              ga_ventas.num_unidades%TYPE,
      v_cod_region            IN              ga_ventas.cod_region%TYPE,
      v_cod_provincia         IN              ga_ventas.cod_provincia%TYPE,
      v_cod_ciudad            IN              ga_ventas.cod_ciudad%TYPE,
      v_ind_estventa          IN              ga_ventas.ind_estventa%TYPE,
      v_num_transaccion       IN              ga_ventas.num_transaccion%TYPE,
      v_nom_usuario           IN              ga_ventas.nom_usuar_vta%TYPE,
      v_ind_venta             IN              ga_ventas.ind_venta%TYPE,
      v_ind_tipventa          IN              ga_ventas.ind_tipventa%TYPE,
      v_cod_cliente           IN              ga_ventas.cod_cliente%TYPE,
      v_tip_foliacion         IN              ga_ventas.tip_foliacion%TYPE,
      v_cod_tipdocum          IN              ga_ventas.cod_tipdocum%TYPE,
      v_cod_plaza             IN              ga_ventas.cod_plaza%TYPE,
      sn_cod_retorno          OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno         OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento           OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_ciclo_factura_cliente (
      ev_cod_cliente    IN              ge_clientes.cod_cliente%TYPE,
      sn_cod_ciclfact   OUT NOCOPY      fa_ciclfact.cod_ciclfact%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_update_venta_pr (
      en_imp_venta      IN              ga_ventas.imp_venta%TYPE,
      ev_ind_estventa   IN              ga_ventas.ind_estventa%TYPE,
      en_num_venta      IN              ga_ventas.num_venta%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_elimina_reserva_pr (
      ev_num_transaccion   IN              ga_reservart.num_transaccion%TYPE,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_obt_tip_document_pr (
      ev_cod_cliente     IN              ge_clientes.cod_cliente%TYPE,
      sn_cod_tipdocum    OUT NOCOPY      ge_tipdocumen.cod_tipdocum%TYPE,
      sv_tip_foliacion   OUT NOCOPY      ge_tipdocumen.tip_foliacion%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_obt_centrales_quiosco_pr (
      sc_centrales      OUT NOCOPY   refcursor,
      sn_cod_retorno    OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_sel_emp_recaudador_pr (
      en_cod_caja            IN              co_empresas_rex.cod_caja%TYPE,
      sv_emp_recaudadora     OUT NOCOPY      co_empresas_rex.emp_recaudadora%TYPE,
      sv_cod_oficina         OUT NOCOPY      co_empresas_rex.cod_oficina%TYPE,
      sn_cod_caja            OUT NOCOPY      co_empresas_rex.cod_caja%TYPE,
      sv_cod_estado          OUT NOCOPY      co_empresas_rex.cod_estado%TYPE,
      sn_ind_abierta         OUT NOCOPY      co_empresas_rex.ind_abierta%TYPE,
      sv_cod_operadora_scl   OUT NOCOPY      co_empresas_rex.cod_operadora_scl%TYPE,
      sv_cod_plaza           OUT NOCOPY      co_empresas_rex.cod_plaza%TYPE,
      sn_cod_retorno         OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno        OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento          OUT NOCOPY      ge_errores_pg.evento
   );
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END ve_venta_accesorios_pg;
/

SHOW ERRORS