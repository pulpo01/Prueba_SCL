package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class CargosDescuentosManualesDTO implements Serializable{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private CargosManualesDTO cargos;
	private DescuentosManualesDTO descuento;
	
	
	public CargosManualesDTO getCargos() {
		return cargos;
	}
	public void setCargos(CargosManualesDTO cargos) {
		this.cargos = cargos;
	}
	public DescuentosManualesDTO getDescuento() {
		return descuento;
	}
	public void setDescuento(DescuentosManualesDTO descuento) {
		this.descuento = descuento;
	}

}
