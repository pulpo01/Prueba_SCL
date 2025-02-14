/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 18/05/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;
import java.util.Date;

public class ParametroDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String nomParametro;
	private String codModulo;
	private int codProducto;
	private String valor;
	private String descripcion;
	private float valorNum;
	private Date valorFecha;
	private String valorDominio;
	
	public String getValorDominio() {
		return valorDominio;
	}
	public void setValorDominio(String valorDominio) {
		this.valorDominio = valorDominio;
	}
	public String getCodModulo() {
		return codModulo;
	}
	public void setCodModulo(String codModulo) {
		this.codModulo = codModulo;
	}
	public int getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(int codProducto) {
		this.codProducto = codProducto;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getNomParametro() {
		return nomParametro;
	}
	public void setNomParametro(String nomParametro) {
		this.nomParametro = nomParametro;
	}
	public String getValor() {
		return valor;
	}
	public void setValor(String valor) {
		this.valor = valor;
	}
	public Date getValorFecha() {
		return valorFecha;
	}
	public void setValorFecha(Date valorFecha) {
		this.valorFecha = valorFecha;
	}
	public float getValorNum() {
		return valorNum;
	}
	public void setValorNum(float valorNum) {
		this.valorNum = valorNum;
	}
	
}
