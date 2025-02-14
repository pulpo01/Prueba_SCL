package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class RepresentanteLegalComDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String codigoTipoIdentificacion;
	private String numeroTipoIdentificacion;
	private String nombre;
	private int NumeroOrdenRepresentanteLegal;
	
	
	public int getNumeroOrdenRepresentanteLegal() {
		return NumeroOrdenRepresentanteLegal;
	}
	public void setNumeroOrdenRepresentanteLegal(int numeroOrdenRepresentanteLegal) {
		NumeroOrdenRepresentanteLegal = numeroOrdenRepresentanteLegal;
	}
	public String getCodigoTipoIdentificacion() {
		return codigoTipoIdentificacion;
	}
	public void setCodigoTipoIdentificacion(String codigoTipoIdentificacion) {
		this.codigoTipoIdentificacion = codigoTipoIdentificacion;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getNumeroTipoIdentificacion() {
		return numeroTipoIdentificacion;
	}
	public void setNumeroTipoIdentificacion(String numeroTipoIdentificacion) {
		this.numeroTipoIdentificacion = numeroTipoIdentificacion;
	}

}

