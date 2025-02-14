package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.RegionDTO;

public class WsListadoRegionesOutDTO extends RetornoDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private RegionDTO[] regionDTOs;

	public RegionDTO[] getRegionDTOs() {
		return regionDTOs;
	}

	public void setRegionDTOs(RegionDTO[] regionDTOs) {
		this.regionDTOs = regionDTOs;
	}



	


}
