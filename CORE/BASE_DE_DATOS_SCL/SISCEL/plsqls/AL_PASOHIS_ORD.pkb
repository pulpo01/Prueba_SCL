CREATE OR REPLACE PACKAGE BODY AL_PASOHIS_ORD IS
 PROCEDURE p_pasohis_ord(
 v_cabord IN al_cabecera_ordenes1%ROWTYPE ,
 v_fec_his IN al_hcabecera_ordenes.fec_historico%TYPE )
 IS
 CURSOR c_cab_guias IS
 SELECT num_orden, tip_orden
 FROM al_cabecera_ordenes2
 WHERE num_orden_ref = v_cabord.num_orden
 AND tip_orden_ref = v_cabord.tip_orden;
 v_num_ordg al_cabecera_ordenes.num_orden%TYPE;
 v_tip_ordg al_cabecera_ordenes.tip_orden%TYPE;
 BEGIN
 p_ins_cabord(v_cabord,
 v_fec_his);
 p_ins_linord(v_cabord.num_orden,
 v_cabord.tip_orden,
 v_fec_his);
 IF v_cabord.tip_orden = 3 THEN
 p_ins_serord(v_cabord.num_orden,
 v_cabord.tip_orden,
 v_fec_his);
 END IF;
 IF v_cabord.tip_orden = 1
 OR v_cabord.tip_orden = 3 THEN
 p_del_ficsers(v_cabord.num_orden,
 v_cabord.tip_orden);
 END IF;
 FOR c_cab_guias_rec IN c_cab_guias LOOP
 v_num_ordg := c_cab_guias_rec.num_orden;
 v_tip_ordg := c_cab_guias_rec.tip_orden;
 p_ins_cabgui(v_num_ordg,
 v_tip_ordg,
 v_fec_his);
 p_ins_linord(v_num_ordg,
 v_tip_ordg,
 v_fec_his);
 p_ins_serord(v_num_ordg,
 v_tip_ordg,
 v_fec_his);
 p_del_serord(v_num_ordg,
 v_tip_ordg);
 p_del_linord(v_num_ordg,
 v_tip_ordg);
 p_del_cabgui(v_num_ordg,
 v_tip_ordg);
 p_del_seranomgui(v_num_ordg,
 v_tip_ordg);
 END LOOP;
 IF v_cabord.tip_orden = 1 THEN
 p_del_linord(v_cabord.num_orden,
 v_cabord.tip_orden);
 END IF;
 EXCEPTION
 WHEN OTHERS THEN
 RAISE_APPLICATION_ERROR (-20100, '<ALMACEN> Paso a Historico '
 || TO_CHAR(SQLCODE));
 END;
 PROCEDURE p_ins_cabord(
 v_cabord IN al_cabecera_ordenes1%ROWTYPE ,
 v_fec_his IN al_hcabecera_ordenes.fec_historico%TYPE )
 IS
 BEGIN
 INSERT INTO al_hcabecera_ordenes
 (num_orden,
 tip_orden,
 fec_historico,
 cod_proveedor,
 cod_bodega,
 fec_creacion,
 cod_sector,
 cod_transp,
 tip_pedido,
 fec_autoriza,
 fec_embarque,
 fec_arribo,
 cod_moneda,
 cod_estado,
 pct_iva,
 tot_arancel_est,
 tot_flete_est,
 tot_seguro_est,
 tip_orden_ref,
 num_orden_ref,
 usu_creacion,
 usu_autoriza,
 cod_accion,
 num_orden_prov,
 tip_numeracion,
 PLAN,
 carga,
 cod_grpconcepto,
 num_orden_sap)
 VALUES
 (v_cabord.num_orden,
 v_cabord.tip_orden,
 v_fec_his,
 v_cabord.cod_proveedor,
 v_cabord.cod_bodega,
 v_cabord.fec_creacion,
 v_cabord.cod_sector,
 v_cabord.cod_transp,
 v_cabord.tip_pedido,
 v_cabord.fec_autoriza,
 v_cabord.fec_embarque,
 v_cabord.fec_arribo,
 v_cabord.cod_moneda,
 v_cabord.cod_estado,
 v_cabord.pct_iva,
 v_cabord.tot_arancel_est,
 v_cabord.tot_flete_est,
 v_cabord.tot_seguro_est,
 v_cabord.tip_orden_ref,
 v_cabord.num_orden_ref,
 v_cabord.usu_creacion,
 v_cabord.usu_autoriza,
 1,
 v_cabord.num_orden_prov,
 v_cabord.tip_numeracion,
 v_cabord.PLAN,
 v_cabord.carga,
 v_cabord.cod_grpconcepto,
 v_cabord.num_orden_sap);
 EXCEPTION
 WHEN OTHERS THEN
 RAISE_APPLICATION_ERROR (-20101, '<ALMACEN> Ins Cabecera Orden '
 || TO_CHAR(SQLCODE));
 END;
 PROCEDURE p_ins_cabgui(
 v_num_ord IN al_cabecera_ordenes.num_orden%TYPE ,
 v_tip_ord IN al_cabecera_ordenes.tip_orden%TYPE ,
 v_fec_his IN al_hcabecera_ordenes.fec_historico%TYPE )
 IS
 BEGIN
 
 INSERT INTO al_hcabecera_ordenes
 (num_orden,
 tip_orden,
 fec_historico,
 cod_proveedor,
 cod_bodega,
 fec_creacion,
 cod_sector,
 cod_transp,
 tip_pedido,
 fec_autoriza,
 fec_embarque,
 fec_arribo,
 cod_moneda,
 cod_estado,
 pct_iva,
 tot_arancel_est,
 tot_flete_est,
 tot_seguro_est,
 tip_orden_ref,
 num_orden_ref,
 usu_creacion,
 usu_autoriza,
 cod_accion,
 num_orden_prov,
 tip_numeracion,
 PLAN,
 carga,
 cod_grpconcepto,num_orden_sap)
 SELECT
 num_orden,
 tip_orden,
 v_fec_his,
 cod_proveedor,
 cod_bodega,
 fec_creacion,
 cod_sector,
 cod_transp,
 tip_pedido,
 fec_autoriza,
 fec_embarque,
 fec_arribo,
 cod_moneda,
 cod_estado,
 pct_iva,
 tot_arancel_est,
 tot_flete_est,
 tot_seguro_est,
 tip_orden_ref,
 num_orden_ref,
 usu_creacion,
 usu_autoriza,
 1,
 num_orden_prov,
 tip_numeracion,
 PLAN,
 carga,
 cod_grpconcepto, num_orden_sap
 FROM al_cabecera_ordenes2
 WHERE num_orden = v_num_ord
 AND tip_orden = v_tip_ord;
 EXCEPTION
 WHEN OTHERS THEN
 RAISE_APPLICATION_ERROR (-20102, '<ALMACEN> Ins Cabecera Guia '
 || TO_CHAR(SQLCODE));
 END;
 PROCEDURE p_ins_linord(
 v_num_ord IN al_cabecera_ordenes.num_orden%TYPE ,
 v_tip_ord IN al_cabecera_ordenes.tip_orden%TYPE ,
 v_fec_his IN al_hcabecera_ordenes.fec_historico%TYPE )
 IS
 BEGIN
 INSERT INTO al_hlineas_ordenes
 (num_orden,
 tip_orden,
 fec_historico,
 num_linea,
 cod_articulo,
 can_orden,
 can_servida,
 cod_causa,
 can_series,
 cod_accion,
 prc_unidad,
 tip_stock,
 cod_uso,
 cod_estado,
 num_linea_ref,
 tip_movimiento,
 can_orden_ing,
 num_desde,
 num_hasta,
 prc_ff,
 prc_adic,
 cod_plaza,
 cod_metodo_carga,
 cod_grpconcepto)
 SELECT
 num_orden,
 tip_orden,
 v_fec_his,
 num_linea,
 cod_articulo,
 can_orden,
 can_servida,
 cod_causa,
 can_series,
 1,
 prc_unidad,
 tip_stock,
 cod_uso,
 cod_estado,
 num_linea_ref,
 tip_movimiento,
 can_orden_ing,
 num_desde,
 num_hasta,
 prc_ff,
 prc_adic,
 cod_plaza,
 cod_metodo_carga,
 AL_BUSCA_GRUPO_ARTICULO_FN(cod_articulo)
 FROM al_vlineas_ordenes
 WHERE num_orden = v_num_ord
 AND tip_orden = v_tip_ord;
 DBMS_OUTPUT.PUT_LINE('insert en hlineas');
 EXCEPTION
 WHEN OTHERS THEN
 RAISE_APPLICATION_ERROR (-20103, '<ALMACEN> Ins Lineas '
 || TO_CHAR(SQLCODE));
 END;
 PROCEDURE p_ins_serord(
 v_num_ord IN al_cabecera_ordenes.num_orden%TYPE ,
 v_tip_ord IN al_cabecera_ordenes.tip_orden%TYPE ,
 v_fec_his IN al_hcabecera_ordenes.fec_historico%TYPE )
 IS
 BEGIN
 INSERT INTO al_hseries_ordenes
 (num_orden,
 tip_orden,
 fec_historico,
 num_linea,
 num_serie,
 cod_accion,
 num_seriemec,
 cod_producto,
 cod_central,
 cap_code,
 num_telefono,
 cod_subalm,
 cod_cat,
 ind_telefono,
 PLAN,
 carga,
 cod_hlr)
 SELECT
 num_orden,
 tip_orden,
 v_fec_his,
 num_linea,
 num_serie,
 1,
 num_seriemec,
 cod_producto,
 cod_central,
 cap_code,
 num_telefono,
 cod_subalm,
 cod_cat,
 ind_telefono,
 PLAN,
 carga,
 cod_hlr
 FROM al_vseries_ordenes
 WHERE num_orden = v_num_ord
 AND tip_orden = v_tip_ord;
 EXCEPTION
 WHEN OTHERS THEN
 RAISE_APPLICATION_ERROR (-20104, '<ALMACEN> Ins Series '
 || TO_CHAR(SQLCODE));
 END;
 PROCEDURE p_del_serord(
 v_num_ord IN al_cabecera_ordenes.num_orden%TYPE ,
 v_tip_ord IN al_cabecera_ordenes.tip_orden%TYPE )
 IS
 BEGIN
 IF v_tip_ord = 2 THEN
 DELETE al_series_ordenes2
 WHERE num_orden = v_num_ord;
 ELSIF v_tip_ord = 3 THEN
 DELETE al_series_ordenes3
 WHERE num_orden = v_num_ord;
 END IF;
 EXCEPTION
 WHEN OTHERS THEN
 RAISE_APPLICATION_ERROR (-20105, '<ALMACEN> Del Series '
 || TO_CHAR(SQLCODE));
 END;
 PROCEDURE p_del_linord(
 v_num_ord IN al_cabecera_ordenes.num_orden%TYPE ,
 v_tip_ord IN al_cabecera_ordenes.tip_orden%TYPE )
 IS
 BEGIN
 IF v_tip_ord = 1 THEN
 DELETE al_lineas_ordenes1
 WHERE num_orden = v_num_ord;
 ELSIF v_tip_ord = 2 THEN
 DELETE al_lineas_ordenes2
 WHERE num_orden = v_num_ord;
 ELSE
 DELETE al_lineas_ordenes3
 WHERE num_orden = v_num_ord;
 END IF;
 EXCEPTION
 WHEN OTHERS THEN
 RAISE_APPLICATION_ERROR (-20106, '<ALMACEN> Del Lineas '
 || TO_CHAR(SQLCODE));
 END;
 PROCEDURE p_del_cabgui(
 v_num_ord IN al_cabecera_ordenes.num_orden%TYPE ,
 v_tip_ord IN al_cabecera_ordenes.tip_orden%TYPE )
 IS
 BEGIN
 DELETE al_cabecera_ordenes2
 WHERE num_orden = v_num_ord
 AND tip_orden = v_tip_ord;
 EXCEPTION
 WHEN OTHERS THEN
 RAISE_APPLICATION_ERROR (-20107, '<ALMACEN> Del Cab Ord-Guia '
 || TO_CHAR(SQLCODE));
 END;
 PROCEDURE p_del_ficsers(
 v_num_ord IN al_cabecera_ordenes.num_orden%TYPE ,
 v_tip_ord IN al_cabecera_ordenes.tip_orden%TYPE )
 IS
 BEGIN
 DELETE al_fic_series
 WHERE num_orden = v_num_ord
 AND tip_orden = v_tip_ord;
 EXCEPTION
 WHEN OTHERS THEN
 RAISE_APPLICATION_ERROR (-20108, '<ALMACEN> Del FicSeries Ord-Compra '
 || TO_CHAR(SQLCODE));
 END;
 PROCEDURE p_del_seranomgui(
 v_num_ord IN al_cabecera_ordenes.num_orden%TYPE ,
 v_tip_ord IN al_cabecera_ordenes.tip_orden%TYPE )
 IS
 BEGIN
 DELETE al_series_anomalias
 WHERE num_orden = v_num_ord
 AND tip_orden = v_tip_ord;
 EXCEPTION
 WHEN OTHERS THEN
 RAISE_APPLICATION_ERROR (-20109, '<ALMACEN> Del SerAnomalas Guia '
 || TO_CHAR(SQLCODE));
 END;
END AL_PASOHIS_ORD; 
/
SHOW ERRORS
