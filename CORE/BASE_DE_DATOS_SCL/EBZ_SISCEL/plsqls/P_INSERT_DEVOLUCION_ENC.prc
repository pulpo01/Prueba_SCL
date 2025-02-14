CREATE OR REPLACE PROCEDURE            P_INSERT_DEVOLUCION_ENC(
vp_cod_devolucion         out npt_devolucion.cod_devolucion%TYPE,
vp_cod_mensaje        		out npt_mensaje.cod_mensaje%TYPE,
vp_cod_bodega             in  npt_devolucion.cod_bodega%TYPE,
vp_cod_cliente            in  npt_devolucion.cod_cliente%TYPE,
vp_cod_usuario_cre        in  npt_devolucion.cod_usuario_cre%TYPE,
vp_cod_usuario_ing        in  npt_devolucion.cod_usuario_ing%TYPE,
vp_cod_usuario_eje        in  npt_devolucion.cod_usuario_eje%TYPE,
vp_obs_devolucion         in  npt_devolucion.obs_devolucion%TYPE,
vp_guia_des_devolucion    in  npt_devolucion.guia_des_devolucion%TYPE,
vp_cod_funcion            in  npd_funcion.cod_funcion%TYPE,
v_cod_estado_flujo        in  npt_estado_devolucion.cod_estado_flujo%TYPE
)
as
v_fec_creacion   		 date;
BEGIN
	select sysdate into v_fec_creacion from dual;
	select np_seq_devolu.nextval into vp_cod_devolucion from dual;
	insert into npt_devolucion (cod_devolucion, cod_bodega, cod_cliente, cod_usuario_cre,
		cod_usuario_ing, cod_usuario_eje, fec_cre_devolucion, obs_devolucion, guia_des_devolucion)
	values (vp_cod_devolucion, vp_cod_bodega, vp_cod_cliente, vp_cod_usuario_cre,
		vp_cod_usuario_ing, vp_cod_usuario_eje, v_fec_creacion, vp_obs_devolucion, vp_guia_des_devolucion);
	insert into npt_estado_devolucion (cod_devolucion, fec_cre_est_devolucion, cod_usuario_cre,
		cod_usuario_ing, cod_estado_flujo, fec_inf_est_devolucion)
	values (vp_cod_devolucion, v_fec_creacion, vp_cod_usuario_cre,
		vp_cod_usuario_ing, v_cod_estado_flujo, v_fec_creacion);
	select np_seq_mensaje.nextval into vp_cod_mensaje from dual;
	insert into npt_mensaje (cod_mensaje, cod_usuario_ori, cod_usuario_des, fec_mensaje, tip_mensaje,
		cod_estado_flujo, num_peddevrec, est_mensaje)
	values (vp_cod_mensaje, vp_cod_usuario_cre, vp_cod_usuario_eje, v_fec_creacion, 'D',
		v_cod_estado_flujo, vp_cod_devolucion, 'V');
END;
/
SHOW ERRORS
