/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 04/06/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class CodigoDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;

	private String  cod_valor = "";
	private String  des_valor = "";
	private String  nom_tabla = "";
	private String  nom_columna = "";
	private String  cod_modulo = "";
	
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
	

}
