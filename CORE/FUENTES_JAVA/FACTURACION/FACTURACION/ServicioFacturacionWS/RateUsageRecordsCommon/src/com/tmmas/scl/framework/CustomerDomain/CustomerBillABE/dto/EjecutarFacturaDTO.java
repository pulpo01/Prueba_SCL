package com.tmmas.scl.framework.CustomerDomain.CustomerBillABE.dto;

import java.io.Serializable;

public class EjecutarFacturaDTO implements Serializable {
	private String EV_num_proceso;// IN VARCHAR2,-- Parametro secuenciasDatos

	private String EV_num_venta;// IN VARCHAR2,-- "0"

	private String EV_cod_modgener;// IN VARCHAR2,--
									// FA_SISTEMA_PG.FA_RECMODGENER_PR(CATEGORIA
									// TRIBUTARIA, MODALIDAD DE VENTA, CENTRO DE
									// EMISION, TIPO MOVIMIENTO, MOD_GENER. )

	private String EV_cod_tipmovimien;// IN VARCHAR2,--
										// FA_SISTEMA_PG.FA_RECDATOSGENER_PR(COD_MISCELA--
										// ESTE ES EL QUE TE SIRVE ES UN
										// PARAMETRO DE SALIDA, COD_MONEFACT
										// ESTE ES UN PARAMETRO DE SALIDA)

	private String EV_cod_catribut; // IN VARCHAR2,-- categoria TRIBUTARIA B o F

	private String EV_num_folio; // IN VARCHAR2,-- ""

	private String EV_cod_estadoc; // IN VARCHAR2,-- "100"

	private String EV_cod_estproc; // IN VARCHAR2,-- "3"

	private String EV_fec_vencimiento; // IN VARCHAR2,-- Fecha de vencimiento

	private String EV_fec_ingreso; // IN VARCHAR2,-- "0"

	private String EV_cod_modventa; // IN VARCHAR2,-- Parametro modalidad de
									// venta 1 contado, 2

	private String EV_num_cuotas; // IN VARCHAR2,-- Paramtero de numero de
									// cuotas

	private String EV_pref_plaza_rel; // IN VARCHAR2,-- ""

	private String EV_tip_foliacion; // IN VARCHAR2,-- ""

	private String EV_cod_tipdocum; // IN VARCHAR2,---- ""

	private String SN_COD_RETORNO;// OUT NOCOPY NUMBER,

	private String SV_MENS_RETORNO; // OUT NOCOPY VARCHAR2,

	private String SN_NUM_EVENTO;// OUT NOCOPY NUMBER)

	public String getEV_cod_catribut() {
		return EV_cod_catribut;
	}

	public void setEV_cod_catribut(String ev_cod_catribut) {
		EV_cod_catribut = ev_cod_catribut;
	}

	public String getEV_cod_estadoc() {
		return EV_cod_estadoc;
	}

	public void setEV_cod_estadoc(String ev_cod_estadoc) {
		EV_cod_estadoc = ev_cod_estadoc;
	}

	public String getEV_cod_estproc() {
		return EV_cod_estproc;
	}

	public void setEV_cod_estproc(String ev_cod_estproc) {
		EV_cod_estproc = ev_cod_estproc;
	}

	public String getEV_cod_modgener() {
		return EV_cod_modgener;
	}

	public void setEV_cod_modgener(String ev_cod_modgener) {
		EV_cod_modgener = ev_cod_modgener;
	}

	public String getEV_cod_modventa() {
		return EV_cod_modventa;
	}

	public void setEV_cod_modventa(String ev_cod_modventa) {
		EV_cod_modventa = ev_cod_modventa;
	}

	public String getEV_cod_tipdocum() {
		return EV_cod_tipdocum;
	}

	public void setEV_cod_tipdocum(String ev_cod_tipdocum) {
		EV_cod_tipdocum = ev_cod_tipdocum;
	}

	public String getEV_cod_tipmovimien() {
		return EV_cod_tipmovimien;
	}

	public void setEV_cod_tipmovimien(String ev_cod_tipmovimien) {
		EV_cod_tipmovimien = ev_cod_tipmovimien;
	}

	public String getEV_fec_ingreso() {
		return EV_fec_ingreso;
	}

	public void setEV_fec_ingreso(String ev_fec_ingreso) {
		EV_fec_ingreso = ev_fec_ingreso;
	}

	public String getEV_fec_vencimiento() {
		return EV_fec_vencimiento;
	}

	public void setEV_fec_vencimiento(String ev_fec_vencimiento) {
		EV_fec_vencimiento = ev_fec_vencimiento;
	}

	public String getEV_num_cuotas() {
		return EV_num_cuotas;
	}

	public void setEV_num_cuotas(String ev_num_cuotas) {
		EV_num_cuotas = ev_num_cuotas;
	}

	public String getEV_num_folio() {
		return EV_num_folio;
	}

	public void setEV_num_folio(String ev_num_folio) {
		EV_num_folio = ev_num_folio;
	}

	public String getEV_num_proceso() {
		return EV_num_proceso;
	}

	public void setEV_num_proceso(String ev_num_proceso) {
		EV_num_proceso = ev_num_proceso;
	}

	public String getEV_num_venta() {
		return EV_num_venta;
	}

	public void setEV_num_venta(String ev_num_venta) {
		EV_num_venta = ev_num_venta;
	}

	public String getEV_pref_plaza_rel() {
		return EV_pref_plaza_rel;
	}

	public void setEV_pref_plaza_rel(String ev_pref_plaza_rel) {
		EV_pref_plaza_rel = ev_pref_plaza_rel;
	}

	public String getEV_tip_foliacion() {
		return EV_tip_foliacion;
	}

	public void setEV_tip_foliacion(String ev_tip_foliacion) {
		EV_tip_foliacion = ev_tip_foliacion;
	}

	public String getSN_COD_RETORNO() {
		return SN_COD_RETORNO;
	}

	public void setSN_COD_RETORNO(String sn_cod_retorno) {
		SN_COD_RETORNO = sn_cod_retorno;
	}

	public String getSN_NUM_EVENTO() {
		return SN_NUM_EVENTO;
	}

	public void setSN_NUM_EVENTO(String sn_num_evento) {
		SN_NUM_EVENTO = sn_num_evento;
	}

	public String getSV_MENS_RETORNO() {
		return SV_MENS_RETORNO;
	}

	public void setSV_MENS_RETORNO(String sv_mens_retorno) {
		SV_MENS_RETORNO = sv_mens_retorno;
	}

}
