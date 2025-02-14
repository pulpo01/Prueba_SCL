CREATE OR REPLACE PACKAGE AL_PASOHIS_ORD IS
  PROCEDURE p_pasohis_ord(
  v_cabord IN al_cabecera_ordenes1%ROWTYPE ,
  v_fec_his IN al_hcabecera_ordenes.fec_historico%TYPE )
;
  PROCEDURE p_ins_cabord(
  v_cabord IN al_cabecera_ordenes1%ROWTYPE ,
  v_fec_his IN al_hcabecera_ordenes.fec_historico%TYPE )
;
  PROCEDURE p_ins_cabgui(
  v_num_ord IN al_cabecera_ordenes.num_orden%TYPE ,
  v_tip_ord IN al_cabecera_ordenes.tip_orden%TYPE ,
  v_fec_his IN al_hcabecera_ordenes.fec_historico%TYPE )
;
  PROCEDURE p_ins_linord(
  v_num_ord IN al_cabecera_ordenes.num_orden%TYPE ,
  v_tip_ord IN al_cabecera_ordenes.tip_orden%TYPE ,
  v_fec_his IN al_hcabecera_ordenes.fec_historico%TYPE )
;
  PROCEDURE p_ins_serord(
  v_num_ord IN al_cabecera_ordenes.num_orden%TYPE ,
  v_tip_ord IN al_cabecera_ordenes.tip_orden%TYPE ,
  v_fec_his IN al_hcabecera_ordenes.fec_historico%TYPE )
;
  PROCEDURE p_del_serord(
  v_num_ord IN al_cabecera_ordenes.num_orden%TYPE ,
  v_tip_ord IN al_cabecera_ordenes.tip_orden%TYPE )
;
  PROCEDURE p_del_linord(
  v_num_ord IN al_cabecera_ordenes.num_orden%TYPE ,
  v_tip_ord IN al_cabecera_ordenes.tip_orden%TYPE )
;
  PROCEDURE p_del_cabgui(
  v_num_ord IN al_cabecera_ordenes.num_orden%TYPE ,
  v_tip_ord IN al_cabecera_ordenes.tip_orden%TYPE )
;
  PROCEDURE p_del_ficsers(
  v_num_ord IN al_cabecera_ordenes.num_orden%TYPE ,
  v_tip_ord IN al_cabecera_ordenes.tip_orden%TYPE )
;
  PROCEDURE p_del_seranomgui(
  v_num_ord IN al_cabecera_ordenes.num_orden%TYPE ,
  v_tip_ord IN al_cabecera_ordenes.tip_orden%TYPE )
;
END AL_PASOHIS_ORD; 
/
SHOW ERRORS
