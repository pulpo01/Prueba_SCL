package com.tmmas.scl.framework.ProductDomain.dto;

import java.io.Serializable;

import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;

public class BodegaDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String cod_bodega;     
	private String des_bodega;     
	private long   tip_bodega;     
	private long   cod_direccion;    
	private long   ind_asignada;     
	private long   cod_bodega_padre; 
	private String num_telefono1;    
	private String num_telefono2;    
	private String num_fax;          
	private String nom_responsable;  
	private long   cod_grpconcepto;
	private MensajeRetornoDTO mensajeRetorno; 
	private long codVendedor;
	
	public String getCod_bodega() {
		return cod_bodega;
	}
	public void setCod_bodega(String cod_bodega) {
		this.cod_bodega = cod_bodega;
	}
	public long getCod_bodega_padre() {
		return cod_bodega_padre;
	}
	public void setCod_bodega_padre(long cod_bodega_padre) {
		this.cod_bodega_padre = cod_bodega_padre;
	}
	public long getCod_direccion() {
		return cod_direccion;
	}
	public void setCod_direccion(long cod_direccion) {
		this.cod_direccion = cod_direccion;
	}
	public long getCod_grpconcepto() {
		return cod_grpconcepto;
	}
	public void setCod_grpconcepto(long cod_grpconcepto) {
		this.cod_grpconcepto = cod_grpconcepto;
	}
	public String getDes_bodega() {
		return des_bodega;
	}
	public void setDes_bodega(String des_bodega) {
		this.des_bodega = des_bodega;
	}
	public long getInd_asignada() {
		return ind_asignada;
	}
	public void setInd_asignada(long ind_asignada) {
		this.ind_asignada = ind_asignada;
	}
	public String getNom_responsable() {
		return nom_responsable;
	}
	public void setNom_responsable(String nom_responsable) {
		this.nom_responsable = nom_responsable;
	}
	public String getNum_fax() {
		return num_fax;
	}
	public void setNum_fax(String num_fax) {
		this.num_fax = num_fax;
	}
	public String getNum_telefono1() {
		return num_telefono1;
	}
	public void setNum_telefono1(String num_telefono1) {
		this.num_telefono1 = num_telefono1;
	}
	public String getNum_telefono2() {
		return num_telefono2;
	}
	public void setNum_telefono2(String num_telefono2) {
		this.num_telefono2 = num_telefono2;
	}
	public long getTip_bodega() {
		return tip_bodega;
	}
	public void setTip_bodega(long tip_bodega) {
		this.tip_bodega = tip_bodega;
	}
	public MensajeRetornoDTO getMensajeRetorno() {
		return mensajeRetorno;
	}
	public void setMensajeRetorno(MensajeRetornoDTO mensajeRetorno) {
		this.mensajeRetorno = mensajeRetorno;
	}
	public long getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(long codVendedor) {
		this.codVendedor = codVendedor;
	}  

}
