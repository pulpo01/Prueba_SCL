package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class ConceptosCobranzaDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String codigo123;
	private String descripcion123;
	private String codigoABC;
	private String descripcionABC;

	/*-- Pago Automatico --*/
	private String codigoBanco;
	private String codigoZona;
	private String codigoCentral;
	private String codigoCliente;
	private String numeroTelefono;
	private String codigoBcoi;   
			  
	public String getCodigoABC() {
		return codigoABC;
	}
	public void setCodigoABC(String codigoABC) {
		this.codigoABC = codigoABC;
	}
	public String getDescripcionABC() {
		return descripcionABC;
	}
	public void setDescripcionABC(String descripcionABC) {
		this.descripcionABC = descripcionABC;
	}
	public String getCodigo123() {
		return codigo123;
	}
	public void setCodigo123(String codigo123) {
		this.codigo123 = codigo123;
	}
	public String getDescripcion123() {
		return descripcion123;
	}
	public void setDescripcion123(String descripcion123) {
		this.descripcion123 = descripcion123;
	}
	public String getCodigoBanco() {
		return codigoBanco;
	}
	public void setCodigoBanco(String codigoBanco) {
		this.codigoBanco = codigoBanco;
	}
	public String getCodigoBcoi() {
		return codigoBcoi;
	}
	public void setCodigoBcoi(String codigoBcoi) {
		this.codigoBcoi = codigoBcoi;
	}
	public String getCodigoCentral() {
		return codigoCentral;
	}
	public void setCodigoCentral(String codigoCentral) {
		this.codigoCentral = codigoCentral;
	}
	public String getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public String getCodigoZona() {
		return codigoZona;
	}
	public void setCodigoZona(String codigoZona) {
		this.codigoZona = codigoZona;
	}
	public String getNumeroTelefono() {
		return numeroTelefono;
	}
	public void setNumeroTelefono(String numeroTelefono) {
		this.numeroTelefono = numeroTelefono;
	}
	
}//fin ConceptosCobranzaDTO
