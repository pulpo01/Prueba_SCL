CREATE OR REPLACE PROCEDURE            P_INSERT_RECLAMO
(vp_cod_reclamo        out npt_reclamo.cod_reclamo%TYPE
,vp_cod_mensaje        out npt_mensaje.cod_mensaje%TYPE
,vp_cod_tipo_reclamo   in npt_reclamo.cod_tipo_reclamo%TYPE
,vp_cod_pedido         in npt_reclamo.cod_pedido%TYPE
,vp_cod_usuario_cre    in npt_reclamo.cod_usuario_cre%TYPE
,vp_cod_usuario_ing    in npt_reclamo.cod_usuario_ing%TYPE
,vp_cod_usuario_eje    in npt_reclamo.cod_usuario_eje%TYPE
,vp_obs_ing_reclamo    in npt_reclamo.obs_ing_reclamo%TYPE
,vp_cod_funcion        in npd_funcion.cod_funcion%TYPE
,vp_err                out varchar2
)
as
v_fec_ing_reclamo           DATE;
v_cod_estado_flujo          number;
BEGIN
	vp_err:='';
	select sysdate into v_fec_ing_reclamo from dual;
	select np_seq_reclam.nextval into vp_cod_reclamo from dual;
	select cod_estado_flujo into v_cod_estado_flujo	from npt_fun_estado_flujo_esc
	where cod_funcion = vp_cod_funcion;
begin
	insert into npt_reclamo (cod_reclamo, cod_tipo_reclamo, cod_pedido, cod_usuario_cre,
		cod_usuario_ing, cod_usuario_eje, obs_ing_reclamo, fec_ing_reclamo)
	values (vp_cod_reclamo, vp_cod_tipo_reclamo, vp_cod_pedido, vp_cod_usuario_cre,
		vp_cod_usuario_ing, vp_cod_usuario_eje, vp_obs_ing_reclamo, v_fec_ing_reclamo);
EXCEPTION
	when others then
	vp_err:='p_insert_reclamo^' || sqlcode || '^npt_reclamo^';
	raise;
end;
begin
	insert into npt_estado_reclamo (cod_reclamo, fec_cre_est_reclamo, cod_usuario_cre,
		cod_usuario_ing, cod_estado_flujo)
	values (vp_cod_reclamo, v_fec_ing_reclamo, vp_cod_usuario_cre,
		vp_cod_usuario_ing, v_cod_estado_flujo);
EXCEPTION
	when others then
	vp_err:='p_insert_reclamo^' || sqlcode || '^npt_estado_reclamo^';
	raise;
end;
begin
	select np_seq_mensaje.nextval into vp_cod_mensaje from dual;
	insert into npt_mensaje (cod_mensaje, cod_usuario_ori, cod_usuario_des, fec_mensaje, tip_mensaje,
		cod_estado_flujo, num_peddevrec, est_mensaje)
	values (vp_cod_mensaje, vp_cod_usuario_cre, vp_cod_usuario_eje, v_fec_ing_reclamo, 'R',
		v_cod_estado_flujo, vp_cod_reclamo, 'V');
EXCEPTION
	when others then
	vp_err:='p_insert_reclamo^' || sqlcode || '^npt_mensaje^';
	raise;
end;
EXCEPTION
	when others then
	raise;
END;
/
SHOW ERRORS
