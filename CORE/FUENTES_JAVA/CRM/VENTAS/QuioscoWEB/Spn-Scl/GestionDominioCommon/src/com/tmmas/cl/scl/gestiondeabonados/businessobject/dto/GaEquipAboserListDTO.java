package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class GaEquipAboserListDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private GaEquipAboserDTO[] gaEquipAboserDTO;
	
	public GaEquipAboserDTO[] getGaEquipAboserDTO() {
		return gaEquipAboserDTO;
	}
	public void setGaEquipAboserDTO(GaEquipAboserDTO[] gaEquipAboserDTO) {
		this.gaEquipAboserDTO = gaEquipAboserDTO;
	} 

}
