CREATE OR REPLACE PROCEDURE            P_INSERT_SERIE_PED
(vp_cod_pedido          in npt_serie_pedido.cod_pedido%TYPE
,vp_lin_det_pedido      in npt_serie_pedido.lin_det_pedido%TYPE
,vp_cod_serie_pedido    in npt_serie_pedido.cod_serie_pedido%TYPE
,vp_cod_bar_ser_pedido  in npt_serie_pedido.cod_bar_ser_pedido%TYPE
)
as
BEGIN
  insert into npt_serie_pedido (cod_pedido, lin_det_pedido, cod_serie_pedido, cod_bar_ser_pedido)
  values (vp_cod_pedido, vp_lin_det_pedido, vp_cod_serie_pedido, vp_cod_bar_ser_pedido);
END;
/
SHOW ERRORS
