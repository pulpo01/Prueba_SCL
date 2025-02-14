CREATE OR REPLACE procedure P_INSERT_PEDIDO_SUG_ENC(
vp_cod_pedido             out npt_pedido_sugerido.cod_pedido%TYPE,
vp_cod_mensaje                  out npt_mensaje.cod_mensaje%TYPE,
vp_cod_cliente            in npt_pedido_sugerido.cod_cliente%TYPE,
vp_cod_bodega             in npt_pedido_sugerido.cod_bodega%TYPE,
vp_cod_usuario_cre        in npt_pedido_sugerido.cod_usuario_cre%TYPE,
vp_cod_usuario_ing        in npt_pedido_sugerido.cod_usuario_ing%TYPE,
vp_cod_usuario_eje        in npt_pedido_sugerido.cod_usuario_eje%TYPE,
vp_cod_tipo_pago          in npt_pedido_sugerido.cod_tipo_pago%TYPE,
vp_cod_sistema_despacho   in npt_pedido_sugerido.cod_sistema_despacho%TYPE,
vp_obs_pedido             in npt_pedido_sugerido.obs_pedido%TYPE,
vp_can_total_pedido       in npt_pedido_sugerido.can_total_pedido%TYPE,
vp_mto_pago_pedido        in npt_pedido_sugerido.mto_pago_pedido%TYPE,
vp_mto_neto_pedido        in npt_pedido_sugerido.mto_neto_pedido%TYPE,
vp_mto_des_pedido         in npt_pedido_sugerido.mto_des_pedido%TYPE,
vp_mto_iva_pedido         in npt_pedido_sugerido.mto_iva_pedido%TYPE,
vp_mto_tot_pedido         in npt_pedido_sugerido.mto_tot_pedido%TYPE,
vp_cod_funcion            in npd_funcion.cod_funcion%TYPE,
vp_num_orden_compra       in npt_pedido_sugerido.num_orden_compra%TYPE,
vp_cod_plaza              in npt_pedido_sugerido.cod_plaza%TYPE,
vp_cod_promo              in npt_pedido_sugerido.cod_promocion%TYPE DEFAULT NULL
)
as

--
-- *************************************************************
-- * procedimiento      : P_INSERT_PEDIDO_ENC
-- * Descripcion        : Procedimiento encargado de insertar la cabecera del pedido.
-- * Fecha de creacion  : 22-08-2003
-- * Responsable        : Freddy Zavala G.
-- *************************************************************


v_fec_creacion                   date;
BEGIN
        select sysdate into v_fec_creacion from dual;
        select np_seq_pedido_sug.nextval into vp_cod_pedido from dual;
        insert into npt_pedido_sugerido (cod_pedido, cod_cliente, cod_bodega, cod_usuario_cre, cod_usuario_ing,
                cod_usuario_eje, cod_tipo_pago, cod_sistema_despacho, obs_pedido, fec_cre_pedido,
                fec_ten_ent_pedido, can_total_pedido, mto_pago_pedido, mto_neto_pedido, mto_des_pedido,
                mto_iva_pedido, mto_tot_pedido, num_orden_compra, cod_plaza, cod_promocion)
        values (vp_cod_pedido, vp_cod_cliente, vp_cod_bodega, vp_cod_usuario_cre, vp_cod_usuario_ing,
                vp_cod_usuario_eje, vp_cod_tipo_pago, vp_cod_sistema_despacho, vp_obs_pedido, v_fec_creacion,
                v_fec_creacion, vp_can_total_pedido, vp_mto_pago_pedido, vp_mto_neto_pedido, vp_mto_des_pedido,
                vp_mto_iva_pedido, vp_mto_tot_pedido,vp_num_orden_compra,vp_cod_plaza, vp_cod_promo);

END; 
/

