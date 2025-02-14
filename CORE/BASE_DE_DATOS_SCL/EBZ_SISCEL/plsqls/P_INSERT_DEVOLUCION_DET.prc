CREATE OR REPLACE PROCEDURE            P_INSERT_DEVOLUCION_DET(
vp_cod_devolucion            in npt_detalle_devolucion.cod_devolucion%TYPE,
vp_lin_det_devolucion        in npt_detalle_devolucion.lin_det_devolucion%TYPE,
vp_cod_pedido                in npt_detalle_devolucion.cod_pedido%TYPE,
vp_lin_det_pedido            in npt_detalle_devolucion.lin_det_pedido%TYPE,
vp_cod_serie_pedido          in npt_detalle_devolucion.cod_serie_pedido%TYPE,
vp_ind_seriado               in npt_detalle_devolucion.ind_seriado%TYPE,
vp_can_det_devolucion        in npt_detalle_devolucion.can_det_devolucion%TYPE,
vp_cod_tipo_devolucion       in npt_detalle_devolucion.cod_tipo_devolucion%TYPE,
vp_ind_telefono				 in npt_detalle_devolucion.ind_telefono%TYPE
)
as
BEGIN
  insert into npt_detalle_devolucion (cod_devolucion, lin_det_devolucion, cod_pedido, lin_det_pedido,
    ind_seriado, can_det_devolucion, cod_serie_pedido, cod_tipo_devolucion, ind_telefono)
  values (vp_cod_devolucion, vp_lin_det_devolucion, vp_cod_pedido, vp_lin_det_pedido,
    vp_ind_seriado, vp_can_det_devolucion, vp_cod_serie_pedido, vp_cod_tipo_devolucion, vp_ind_telefono);
END;
/
SHOW ERRORS
