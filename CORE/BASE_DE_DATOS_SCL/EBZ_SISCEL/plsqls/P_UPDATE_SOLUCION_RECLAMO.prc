CREATE OR REPLACE PROCEDURE            P_UPDATE_SOLUCION_RECLAMO
(vp_cod_reclamo       in  npt_reclamo.cod_reclamo%TYPE
,vp_cod_mensaje       out npt_mensaje.cod_mensaje%TYPE
,vp_cod_estado_flujo  in  npt_estado_reclamo.cod_estado_flujo%TYPE
,vp_cod_usuario_cre   in  npt_reclamo.cod_usuario_cre%TYPE
,vp_cod_usuario_ing   in  npt_reclamo.cod_usuario_ing%TYPE
,vp_obs_sol_reclamo   in  npt_reclamo.obs_sol_reclamo%TYPE
)
as
v_fec_ing_reclamo           DATE;
vp_cod_usuario_des          number;
BEGIN
  select sysdate into v_fec_ing_reclamo from dual;
  update npt_reclamo set
  obs_sol_reclamo = vp_obs_sol_reclamo,
  fec_sol_reclamo = sysdate
  where cod_reclamo = vp_cod_reclamo;
  insert into npt_estado_reclamo (cod_reclamo, fec_cre_est_reclamo, cod_usuario_cre,
              cod_usuario_ing, cod_estado_flujo)
  values (vp_cod_reclamo, sysdate, vp_cod_usuario_cre, vp_cod_usuario_ing, vp_cod_estado_flujo);
  select cod_usuario_cre into vp_cod_usuario_des from npt_reclamo
  where cod_reclamo = vp_cod_reclamo;
  select np_seq_mensaje.nextval into vp_cod_mensaje from dual;
  insert into npt_mensaje (cod_mensaje, cod_usuario_ori, cod_usuario_des, fec_mensaje, tip_mensaje,
    cod_estado_flujo, num_peddevrec, est_mensaje)
  values (vp_cod_mensaje, vp_cod_usuario_cre, vp_cod_usuario_des, v_fec_ing_reclamo, 'R',
    vp_cod_estado_flujo, vp_cod_reclamo, 'V');
END;
/
SHOW ERRORS
