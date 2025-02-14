package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class CargoRecurrenteListDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	CargoRecurrenteDTO cargoRecurrente[];
	public CargoRecurrenteDTO[] getCargoRecurrente() {
		return cargoRecurrente;
	}
	public void setCargoRecurrente(CargoRecurrenteDTO[] cargoRecurrente) {
		this.cargoRecurrente = cargoRecurrente;
	}
	
	
}
