package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.CiudadDTO;

public class WsListadoCiudadesOutDTO extends RetornoDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private CiudadDTO[] ciudadDTOs;

	public CiudadDTO[] getCiudadDTOs() {
		return ciudadDTOs;
	}

	public void setCiudadDTOs(CiudadDTO[] ciudadDTOs) {
		this.ciudadDTOs = ciudadDTOs;
	}







	


}
