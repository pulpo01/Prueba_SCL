package com.tmmas.scl.operations.crm.common.dataTransferObject;

import java.io.Serializable;

public class DatosObtProductosContratadosDTO implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String numCelular;
	private String tipoComportamiento;
	private String nivelAplicacion;
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public String getNivelAplicacion() {
		return nivelAplicacion;
	}
	public void setNivelAplicacion(String nivelAplicacion) {
		this.nivelAplicacion = nivelAplicacion;
	}
	public String getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(String numCelular) {
		this.numCelular = numCelular;
	}
	public String getTipoComportamiento() {
		return tipoComportamiento;
	}
	public void setTipoComportamiento(String tipoComportamiento) {
		this.tipoComportamiento = tipoComportamiento;
	}
	
}
