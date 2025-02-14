package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;
import java.sql.Timestamp;

public class GaSegmentacionCargosDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private long cod_concepto; 
	private String cod_moneda; 
	private long cod_seg_des; 
	private long cod_seg_orig; 
	private Timestamp fec_desde; 
	private Timestamp fec_hasta; 
	private double imp_cargo; 
	private String nom_usuario; 
	private long tipo_cargo; 
	private String tipo_seg_des; 
	private String tipo_seg_orig; 
	private String tipo_valor;
	private String des_concepto;
	private String des_moneda;
	private String codTipoCargoSegm;
	
	public String getCodTipoCargoSegm() {
		return codTipoCargoSegm;
	}
	public void setCodTipoCargoSegm(String codTipoCargoSegm) {
		this.codTipoCargoSegm = codTipoCargoSegm;
	}
	public String getDes_moneda() {
		return des_moneda;
	}
	public void setDes_moneda(String des_moneda) {
		this.des_moneda = des_moneda;
	}
	public String getDes_concepto() {
		return des_concepto;
	}
	public void setDes_concepto(String des_concepto) {
		this.des_concepto = des_concepto;
	}
	public long getCod_concepto() {
		return cod_concepto;
	}
	public void setCod_concepto(long cod_concepto) {
		this.cod_concepto = cod_concepto;
	}
	public String getCod_moneda() {
		return cod_moneda;
	}
	public void setCod_moneda(String cod_moneda) {
		this.cod_moneda = cod_moneda;
	}
	public long getCod_seg_des() {
		return cod_seg_des;
	}
	public void setCod_seg_des(long cod_seg_des) {
		this.cod_seg_des = cod_seg_des;
	}
	public long getCod_seg_orig() {
		return cod_seg_orig;
	}
	public void setCod_seg_orig(long cod_seg_orig) {
		this.cod_seg_orig = cod_seg_orig;
	}
	public Timestamp getFec_desde() {
		return fec_desde;
	}
	public void setFec_desde(Timestamp fec_desde) {
		this.fec_desde = fec_desde;
	}
	public Timestamp getFec_hasta() {
		return fec_hasta;
	}
	public void setFec_hasta(Timestamp fec_hasta) {
		this.fec_hasta = fec_hasta;
	}
	public double getImp_cargo() {
		return imp_cargo;
	}
	public void setImp_cargo(double imp_cargo) {
		this.imp_cargo = imp_cargo;
	}
	public String getNom_usuario() {
		return nom_usuario;
	}
	public void setNom_usuario(String nom_usuario) {
		this.nom_usuario = nom_usuario;
	}
	public long getTipo_cargo() {
		return tipo_cargo;
	}
	public void setTipo_cargo(long tipo_cargo) {
		this.tipo_cargo = tipo_cargo;
	}
	public String getTipo_seg_des() {
		return tipo_seg_des;
	}
	public void setTipo_seg_des(String tipo_seg_des) {
		this.tipo_seg_des = tipo_seg_des;
	}
	public String getTipo_seg_orig() {
		return tipo_seg_orig;
	}
	public void setTipo_seg_orig(String tipo_seg_orig) {
		this.tipo_seg_orig = tipo_seg_orig;
	}
	public String getTipo_valor() {
		return tipo_valor;
	}
	public void setTipo_valor(String tipo_valor) {
		this.tipo_valor = tipo_valor;
	}
}
