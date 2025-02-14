package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ConceptoDireccionDTO;

public class ObservacionDireccionDTO extends ConceptoDireccionDTO{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String descripcion;
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

}
