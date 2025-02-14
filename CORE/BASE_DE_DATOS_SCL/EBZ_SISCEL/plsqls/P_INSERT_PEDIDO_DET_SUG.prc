CREATE OR REPLACE PROCEDURE P_INSERT_PEDIDO_DET_SUG(
vp_cod_pedido               in npt_detalle_pedido.cod_pedido%TYPE,
vp_lin_det_pedido           in npt_detalle_pedido.lin_det_pedido%TYPE,
vp_tip_stock                in npt_detalle_pedido.tip_stock%TYPE,
vp_cod_articulo             in npt_detalle_pedido.cod_articulo%TYPE,
vp_cod_uso                  in npt_detalle_pedido.cod_uso%TYPE,
vp_can_detalle_pedido       in npt_detalle_pedido.can_detalle_pedido%TYPE,
vp_mto_uni_det_pedido       in npt_detalle_pedido.mto_uni_det_pedido%TYPE,
vp_mto_des_det_pedido       in npt_detalle_pedido.mto_des_det_pedido%TYPE,
vp_ptj_des_det_pedido       in npt_detalle_pedido.ptj_des_det_pedido%TYPE,
vp_mto_net_det_pedido       in npt_detalle_pedido.mto_net_det_pedido%TYPE,
vp_cod_tecnologia            in npt_detalle_pedido.COD_TECNOLOGIA%TYPE
)
as

v_aplicatec varchar2(10);
v_cod_tecnologia varchar2(7);

BEGIN

     select valor_parametro
     into v_aplicatec
     from npt_parametro
     where alias_parametro ='APLICA_TEC';

     if v_aplicatec <>'TRUE' or v_aplicatec = '' then
         select cod_tecnologia
        into v_cod_tecnologia
        from AL_TECNOARTICULO_TD
        Where cod_articulo = vp_cod_articulo;

        insert into npt_detalle_pedido_sug (cod_pedido, lin_det_pedido, tip_stock, cod_articulo, cod_uso,
        can_detalle_pedido, mto_uni_det_pedido, mto_des_det_pedido,
        ptj_des_det_pedido, mto_net_det_pedido, tip_stock_orig, cod_tecnologia)
        values (vp_cod_pedido, vp_lin_det_pedido, vp_tip_stock, vp_cod_articulo, vp_cod_uso,
        vp_can_detalle_pedido, vp_mto_uni_det_pedido, vp_mto_des_det_pedido,
        vp_ptj_des_det_pedido, vp_mto_net_det_pedido, vp_tip_stock, v_cod_tecnologia);

     end if;

     if v_aplicatec ='TRUE' then

        insert into npt_detalle_pedido_sug (cod_pedido, lin_det_pedido, tip_stock, cod_articulo, cod_uso,
        can_detalle_pedido, mto_uni_det_pedido, mto_des_det_pedido,
        ptj_des_det_pedido, mto_net_det_pedido, tip_stock_orig, cod_tecnologia)
        values (vp_cod_pedido, vp_lin_det_pedido, vp_tip_stock, vp_cod_articulo, vp_cod_uso,
        vp_can_detalle_pedido, vp_mto_uni_det_pedido, vp_mto_des_det_pedido,
        vp_ptj_des_det_pedido, vp_mto_net_det_pedido, vp_tip_stock, vp_cod_tecnologia);

     end if;


END; 
/

