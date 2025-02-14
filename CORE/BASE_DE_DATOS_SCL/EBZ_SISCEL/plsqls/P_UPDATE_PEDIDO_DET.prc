CREATE OR REPLACE PROCEDURE EBZ_SISCEL.P_UPDATE_PEDIDO_DET
(vp_cod_pedido               in  npt_detalle_pedido.cod_pedido%TYPE
,vp_lin_det_pedido           in  npt_detalle_pedido.lin_det_pedido%TYPE
,vp_cod_bodega               in  npt_detalle_pedido.cod_bodega%TYPE
,vp_cod_estado               in  npt_detalle_pedido.cod_estado%TYPE
,vp_can_asig_detalle_pedido  in  npt_detalle_pedido.can_asig_detalle_pedido%TYPE
)
as
BEGIN
--Inicio NC-201470
--recalcula mto_des_det_pedido
--Fin NC-201470

  update npt_detalle_pedido
  set cod_bodega = vp_cod_bodega,
      cod_estado = vp_cod_estado,
      can_asig_detalle_pedido = vp_can_asig_detalle_pedido,
      mto_des_det_pedido = (can_detalle_pedido * mto_uni_det_pedido ) * ( ptj_des_det_pedido / 100 )
  where cod_pedido = vp_cod_pedido
    and lin_det_pedido = vp_lin_det_pedido;
    
END;
/

SHOW ERRORS
