CREATE OR REPLACE PROCEDURE            P_INSERT_ESTADO_DEVOLUCION (
vp_cod_mensaje              OUT npt_mensaje.cod_mensaje%TYPE,
vp_cod_devolucion           in npt_estado_devolucion.cod_devolucion%TYPE,
vp_cod_usuario_cre          in npt_estado_devolucion.cod_usuario_cre%TYPE,
vp_cod_usuario_ing          in npt_estado_devolucion.cod_usuario_ing%TYPE,
vp_cod_motivo_rechazo       in npt_estado_devolucion.cod_motivo_rechazo%TYPE,
vp_cod_estado_flujo         in npt_estado_devolucion.cod_estado_flujo%TYPE,
vp_fec_inf_est_devolucion   in varchar2,
vp_obs_est_devolucion       in npt_estado_devolucion.obs_est_devolucion%TYPE
)
as
v_fec_rec_devolucion           DATE;
vp_cod_usuario_des          number;
BEGIN
  select sysdate into v_fec_rec_devolucion from dual;
  insert into npt_estado_devolucion (cod_devolucion, fec_cre_est_devolucion, cod_usuario_cre,
    cod_usuario_ing, cod_motivo_rechazo, cod_estado_flujo, fec_inf_est_devolucion, obs_est_devolucion)
  values (vp_cod_devolucion, sysdate, vp_cod_usuario_cre,
    vp_cod_usuario_ing, vp_cod_motivo_rechazo,  vp_cod_estado_flujo, to_date(vp_fec_inf_est_devolucion,'dd-mm-yyyy hh24:mi'), vp_obs_est_devolucion);
  select cod_usuario_eje into vp_cod_usuario_des from npt_devolucion
  where cod_devolucion = vp_cod_devolucion;
  select np_seq_mensaje.nextval into vp_cod_mensaje from dual;
  insert into npt_mensaje (cod_mensaje, cod_usuario_ori, cod_usuario_des, fec_mensaje, tip_mensaje,
    cod_estado_flujo, num_peddevrec, est_mensaje)
  values (vp_cod_mensaje, vp_cod_usuario_cre, vp_cod_usuario_des, v_fec_rec_devolucion, 'D',
    vp_cod_estado_flujo, vp_cod_devolucion, 'V');
END;
/
SHOW ERRORS
