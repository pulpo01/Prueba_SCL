package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class ModalidadCancelacionComDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	private String codigo;
	private String descripcion;
	/* --Indice del objeto por defecto */ 
    public static int indiceDefecto = -1;
    
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

}
