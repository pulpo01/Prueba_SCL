CREATE OR REPLACE PACKAGE NP_PRECIO_PRODUCTO_PG
AS
  TYPE refcursor IS REF CURSOR;

  PROCEDURE NP_INSERT_PEDIDO_DET_PR(
			EN_cod_pedido               IN npt_detalle_pedido.cod_pedido%TYPE,
			EN_lin_det_pedido           IN npt_detalle_pedido.lin_det_pedido%TYPE,
			EN_tip_stock                IN npt_detalle_pedido.tip_stock%TYPE,
			EN_cod_articulo             IN npt_detalle_pedido.cod_articulo%TYPE,
			EN_cod_uso                  IN npt_detalle_pedido.cod_uso%TYPE,
			EN_can_detalle_pedido       IN npt_detalle_pedido.can_detalle_pedido%TYPE,
			EN_mto_uni_det_pedido       IN npt_detalle_pedido.mto_uni_det_pedido%TYPE,
			EN_mto_des_det_pedido       IN npt_detalle_pedido.mto_des_det_pedido%TYPE,
			EN_ptj_des_det_pedido       IN npt_detalle_pedido.ptj_des_det_pedido%TYPE,
			EN_mto_net_det_pedido       IN npt_detalle_pedido.mto_net_det_pedido%TYPE,
			EV_cod_tecnologia			IN npt_detalle_pedido.cod_tecnologia%TYPE,
			SV_Error		  OUT NOCOPY VARCHAR2
			);

	PROCEDURE NP_INSERT_DETALLE_CARGO_PR(
			  EN_cod_pedido IN np_detalle_cargo_to.cod_pedido%TYPE,
			  EN_lin_det_pedido IN np_detalle_cargo_to.lin_det_pedido%TYPE,
			  EN_cod_producto IN np_detalle_cargo_to.cod_producto%TYPE,
			  EV_cod_servicio IN np_detalle_cargo_to.cod_servicio%TYPE,
			  EN_mto_cargo IN np_detalle_cargo_to.mto_cargo%TYPE,
			  SV_Error		  OUT NOCOPY VARCHAR2
			  );

	PROCEDURE NP_MANTENER_CARGO_OCACIONAL_PR(
			  EN_cod_articulo IN np_cargo_ocacional_td.cod_articulo%TYPE,
			  EN_tip_stock IN np_cargo_ocacional_td.tip_stock%TYPE,
			  EN_cod_uso IN np_cargo_ocacional_td.cod_uso%TYPE,
			  EN_cod_producto IN np_cargo_ocacional_td.cod_producto%TYPE,
			  EN_cod_servicio IN np_cargo_ocacional_td.cod_servicio%TYPE,
			  EV_accion		  IN VARCHAR2,
			  SV_Error		  OUT NOCOPY VARCHAR2
			  );

	PROCEDURE NP_CARGO_OCACIONALES_PR(
			EN_cod_articulo             IN npt_detalle_pedido.cod_articulo%TYPE,
			EN_tip_stock                IN npt_detalle_pedido.tip_stock%TYPE,
			EN_cod_uso                  IN npt_detalle_pedido.cod_uso%TYPE,
			EN_cod_producto             IN ga_servicios.cod_producto%TYPE,
			SC_cargos					OUT NOCOPY  refCursor,
			SV_Error		  OUT NOCOPY VARCHAR2
			);

	PROCEDURE NP_DESCRIPCION_CARGO_PR(SC_cargos	OUT NOCOPY  refCursor,
			  SV_Error		  OUT NOCOPY VARCHAR2);

	FUNCTION NP_VALOR_CARGO_FN(
			EN_cod_producto             IN ga_servicios.cod_producto%TYPE,
			EV_cod_servicio				IN ga_servicios.cod_servicio%TYPE
			) RETURN NUMBER;

END NP_PRECIO_PRODUCTO_PG;
/
SHOW ERRORS
