package com.tmmas.scl.framework.ProductDomain.dto;

import java.io.Serializable;

import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;

public class CentralDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private long cod_central;
	private long cod_producto;
	private String nom_central;
	private String cod_nemotec;
	private String cod_alm;
	private long num_maxintentos;
	private long cod_sistema;
	private long cod_cobertura;
	private long tie_respuesta;
	private String nodocom;
	private String cod_tecnologia;
	private String cod_hlr;
	private MensajeRetornoDTO mensajeRetorno;
	
	public MensajeRetornoDTO getMensajeRetorno() {
		return mensajeRetorno;
	}
	public void setMensajeRetorno(MensajeRetornoDTO mensajeRetorno) {
		this.mensajeRetorno = mensajeRetorno;
	}
	public String getCod_alm() {
		return cod_alm;
	}
	public void setCod_alm(String cod_alm) {
		this.cod_alm = cod_alm;
	}
	public long getCod_central() {
		return cod_central;
	}
	public void setCod_central(long cod_central) {
		this.cod_central = cod_central;
	}
	public long getCod_cobertura() {
		return cod_cobertura;
	}
	public void setCod_cobertura(long cod_cobertura) {
		this.cod_cobertura = cod_cobertura;
	}
	public String getCod_hlr() {
		return cod_hlr;
	}
	public void setCod_hlr(String cod_hlr) {
		this.cod_hlr = cod_hlr;
	}
	public String getCod_nemotec() {
		return cod_nemotec;
	}
	public void setCod_nemotec(String cod_nemotec) {
		this.cod_nemotec = cod_nemotec;
	}
	public long getCod_producto() {
		return cod_producto;
	}
	public void setCod_producto(long cod_producto) {
		this.cod_producto = cod_producto;
	}
	public long getCod_sistema() {
		return cod_sistema;
	}
	public void setCod_sistema(long cod_sistema) {
		this.cod_sistema = cod_sistema;
	}
	public String getCod_tecnologia() {
		return cod_tecnologia;
	}
	public void setCod_tecnologia(String cod_tecnologia) {
		this.cod_tecnologia = cod_tecnologia;
	}
	public String getNodocom() {
		return nodocom;
	}
	public void setNodocom(String nodocom) {
		this.nodocom = nodocom;
	}
	public String getNom_central() {
		return nom_central;
	}
	public void setNom_central(String nom_central) {
		this.nom_central = nom_central;
	}
	public long getNum_maxintentos() {
		return num_maxintentos;
	}
	public void setNum_maxintentos(long num_maxintentos) {
		this.num_maxintentos = num_maxintentos;
	}
	public long getTie_respuesta() {
		return tie_respuesta;
	}
	public void setTie_respuesta(long tie_respuesta) {
		this.tie_respuesta = tie_respuesta;
	}	      
}
