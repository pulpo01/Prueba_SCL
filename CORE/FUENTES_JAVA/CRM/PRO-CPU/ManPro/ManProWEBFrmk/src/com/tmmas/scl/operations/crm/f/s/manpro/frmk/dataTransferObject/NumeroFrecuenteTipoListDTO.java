package com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject;

import java.io.Serializable;
import java.util.ArrayList;

public class NumeroFrecuenteTipoListDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String tipo;
	private int cantidadMaxTipo = 0;
	private NumeroFrecuenteDTO [] numFrecuentesIngresadosList;
	public int getCantidadMaxTipo() {
		return cantidadMaxTipo;
	}
	public void setCantidadMaxTipo(int cantidadMaxTipo) {
		this.cantidadMaxTipo = cantidadMaxTipo;
	}
	public NumeroFrecuenteDTO[] getNumFrecuentesIngresadosList() {
		return numFrecuentesIngresadosList;
	}
	public void setNumFrecuentesIngresadosList(
			NumeroFrecuenteDTO[] numFrecuentesIngresadosList) {
		this.numFrecuentesIngresadosList = numFrecuentesIngresadosList;
	}
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

}
