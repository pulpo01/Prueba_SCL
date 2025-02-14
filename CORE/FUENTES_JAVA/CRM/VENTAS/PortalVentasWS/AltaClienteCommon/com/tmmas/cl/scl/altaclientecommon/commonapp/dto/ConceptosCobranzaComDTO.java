package com.tmmas.cl.scl.altaclientecommon.commonapp.dto;

import java.io.Serializable;

public class ConceptosCobranzaComDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	private String codigo123;
	private String descripcion123;
	private String codigoABC;
	private String descripcionABC;
	private boolean visible;
	
	public boolean isVisible() {
		return visible;
	}
	public void setVisible(boolean visible) {
		this.visible = visible;
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
	
}//fin ConceptosCobranzaDTO
