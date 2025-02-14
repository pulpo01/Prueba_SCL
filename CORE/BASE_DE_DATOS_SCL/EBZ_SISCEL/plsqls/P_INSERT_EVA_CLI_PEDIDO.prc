CREATE OR REPLACE PROCEDURE            P_INSERT_EVA_CLI_PEDIDO(
vp_cod_cliente							in	npt_eva_cliente_pedido.cod_cliente%TYPE,
vp_cod_pedido								in	npt_eva_cliente_pedido.cod_pedido%TYPE,
vp_tip_doc_pedido						in 	npt_pedido.tip_doc_pedido%TYPE,
vp_mor_eva_cli_pedido				in	npt_eva_cliente_pedido.mor_eva_cli_pedido%TYPE,
vp_dicom_eva_cli_pedido			in	npt_eva_cliente_pedido.dicom_eva_cli_pedido%TYPE,
vp_min_venta_eva_cli_pedido	in	npt_eva_cliente_pedido.min_venta_eva_cli_pedido%TYPE,
vp_max_venta_eva_cli_pedido	in	npt_eva_cliente_pedido.max_venta_eva_cli_pedido%TYPE,
vp_lim_ven_eva_cli_pedido		in	npt_eva_cliente_pedido.lim_ven_eva_cli_pedido%TYPE,
vp_cod_funcion							in	npd_funcion.cod_funcion%TYPE,
vp_cod_usuario_cre					in	npt_usuario.cod_usuario%TYPE,
vp_cod_usuario_ing					in	npt_usuario.cod_usuario%TYPE
)
as
v_fec_creacion							DATE;
v_cod_estado_flujo					number;
BEGIN
	select sysdate into v_fec_creacion from dual;
	select cod_estado_flujo into v_cod_estado_flujo	from npt_fun_estado_flujo_esc
	where cod_funcion = vp_cod_funcion;
	update npt_pedido
	set tip_doc_pedido = vp_tip_doc_pedido
	where cod_pedido = vp_cod_pedido;
	insert into npt_eva_cliente_pedido (cod_cliente, cod_pedido, fec_cre_eva_cli_pedido,
		mor_eva_cli_pedido, dicom_eva_cli_pedido, min_venta_eva_cli_pedido,
		max_venta_eva_cli_pedido, lim_ven_eva_cli_pedido)
	values (vp_cod_cliente, vp_cod_pedido, v_fec_creacion,
		nvl(vp_mor_eva_cli_pedido, 0), nvl(vp_dicom_eva_cli_pedido, 0), nvl(vp_min_venta_eva_cli_pedido, 0),
		nvl(vp_max_venta_eva_cli_pedido, 0), nvl(vp_lim_ven_eva_cli_pedido, 0));
	insert into npt_estado_pedido (cod_pedido, fec_cre_est_pedido, cod_usuario_cre,
		cod_usuario_ing, cod_estado_flujo, fec_inf_est_pedido)
	values (vp_cod_pedido, v_fec_creacion, vp_cod_usuario_cre,
		vp_cod_usuario_ing, v_cod_estado_flujo, v_fec_creacion);
END;
/
SHOW ERRORS
