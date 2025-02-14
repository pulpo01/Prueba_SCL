package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;
import java.sql.Timestamp;

public class GedCodigosDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String cod_modulo; 
	private String cod_valor; 
	private String des_valor; 
	private Timestamp fec_ultmod; 
	private String nom_columna; 
	private String nom_tabla; 
	private String nom_usuario;
	
	public String getCod_modulo() {
		return cod_modulo;
	}
	public void setCod_modulo(String cod_modulo) {
		this.cod_modulo = cod_modulo;
	}
	public String getCod_valor() {
		return cod_valor;
	}
	public void setCod_valor(String cod_valor) {
		this.cod_valor = cod_valor;
	}
	public String getDes_valor() {
		return des_valor;
	}
	public void setDes_valor(String des_valor) {
		this.des_valor = des_valor;
	}
	public Timestamp getFec_ultmod() {
		return fec_ultmod;
	}
	public void setFec_ultmod(Timestamp fec_ultmod) {
		this.fec_ultmod = fec_ultmod;
	}
	public String getNom_columna() {
		return nom_columna;
	}
	public void setNom_columna(String nom_columna) {
		this.nom_columna = nom_columna;
	}
	public String getNom_tabla() {
		return nom_tabla;
	}
	public void setNom_tabla(String nom_tabla) {
		this.nom_tabla = nom_tabla;
	}
	public String getNom_usuario() {
		return nom_usuario;
	}
	public void setNom_usuario(String nom_usuario) {
		this.nom_usuario = nom_usuario;
	}
	
	

}
