package com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject;


import java.io.Serializable;

public class ControlDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String id;
	private String tipo;
	private String habilitado;
	private String visible;
	private String valorDefecto;
	
	public String getHabilitado() {
		return habilitado;
	}
	public void setHabilitado(String habilitado) {
		this.habilitado = habilitado;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	
	public String getValorDefecto() {
		return valorDefecto;
	}
	public void setValorDefecto(String valorDefecto) {
		this.valorDefecto = valorDefecto;
	}
	public String getVisible() {
		return visible;
	}
	public void setVisible(String visible) {
		this.visible = visible;
	}
	
	

}
