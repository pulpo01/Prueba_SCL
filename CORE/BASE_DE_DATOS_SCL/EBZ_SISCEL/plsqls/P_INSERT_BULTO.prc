CREATE OR REPLACE PROCEDURE            P_INSERT_BULTO
(vp_cod_pedido         in  npt_pedido.cod_pedido%TYPE
,vp_cod_mensaje        out npt_mensaje.cod_mensaje%TYPE
,vp_guia_des_pedido    in  npt_pedido.guia_des_pedido%TYPE
,vp_cod_funcion        in  npd_funcion.cod_funcion%TYPE
,vp_cod_tipo_embalaje  in  npt_pedido.cod_tipo_embalaje%TYPE
,vp_can_caja_pedido    in  npt_pedido.can_caja_pedido%TYPE
,vp_pes_uni_pedido     in  npt_pedido.pes_uni_pedido%TYPE
,vp_pes_tot_pedido     in  npt_pedido.pes_tot_pedido%TYPE
,vp_cod_usuario_cre    in  npt_estado_pedido.cod_usuario_cre%TYPE
,vp_cod_usuario_ing    in  npt_estado_pedido.cod_usuario_ing%TYPE
)
as
v_fec_creacion        DATE;
v_cod_estado_flujo    number;
v_cod_usuario_des     number;
BEGIN
  select sysdate into v_fec_creacion from dual;
  select cod_estado_flujo into v_cod_estado_flujo from npt_fun_estado_flujo_esc
  where cod_funcion = vp_cod_funcion;
  update npt_pedido
  set cod_tipo_embalaje = vp_cod_tipo_embalaje,
    can_caja_pedido = vp_can_caja_pedido,
    pes_uni_pedido = vp_pes_uni_pedido,
    pes_tot_pedido = vp_pes_tot_pedido,
    guia_des_pedido = vp_guia_des_pedido
  where cod_pedido = vp_cod_pedido;
  insert into npt_estado_pedido (cod_pedido, fec_cre_est_pedido, cod_usuario_cre,
  cod_usuario_ing, cod_estado_flujo, fec_inf_est_pedido)
  values (vp_cod_pedido, v_fec_creacion, vp_cod_usuario_cre,
  vp_cod_usuario_ing, v_cod_estado_flujo, v_fec_creacion);
  select cod_usuario_eje into v_cod_usuario_des from npt_pedido
  where cod_pedido = vp_cod_pedido;
  select np_seq_mensaje.nextval into vp_cod_mensaje from dual;
  insert into npt_mensaje (cod_mensaje, cod_usuario_ori, cod_usuario_des, fec_mensaje, tip_mensaje,
    cod_estado_flujo, num_peddevrec, est_mensaje)
  values (vp_cod_mensaje, vp_cod_usuario_cre, v_cod_usuario_des, v_fec_creacion, 'P',
    v_cod_estado_flujo, vp_cod_pedido, 'V');
END;
/
SHOW ERRORS
