package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class CargoOcasionalListDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private CargoOcasionalDTO cargoOcasional[];
	
	
	public CargoOcasionalDTO[] getCargoOcasional() {
		return cargoOcasional;
	}
	public void setCargoOcasional(CargoOcasionalDTO[] cargoOcasional) {
		this.cargoOcasional = cargoOcasional;
	}
	
	
	

}
