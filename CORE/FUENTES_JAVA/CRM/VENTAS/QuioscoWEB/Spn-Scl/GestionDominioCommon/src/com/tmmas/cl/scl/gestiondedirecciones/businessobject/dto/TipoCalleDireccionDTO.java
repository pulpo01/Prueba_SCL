package com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto;

public class TipoCalleDireccionDTO extends ConceptoDireccionDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String descripcion;
	public  String indiceDefecto = "-1";
	
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getIndiceDefecto() {
		return indiceDefecto;
	}
	public void setIndiceDefecto(String indiceDefecto) {
		this.indiceDefecto = indiceDefecto;
	}

	
}
