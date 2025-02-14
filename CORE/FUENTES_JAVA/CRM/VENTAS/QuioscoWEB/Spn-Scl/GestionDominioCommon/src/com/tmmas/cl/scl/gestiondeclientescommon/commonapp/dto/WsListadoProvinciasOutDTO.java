package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ProvinciaDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.RegionDTO;

public class WsListadoProvinciasOutDTO extends RetornoDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private ProvinciaDTO[] provinciaDTOs;

	public ProvinciaDTO[] getProvinciaDTOs() {
		return provinciaDTOs;
	}

	public void setProvinciaDTOs(ProvinciaDTO[] provinciaDTOs) {
		this.provinciaDTOs = provinciaDTOs;
	}





	


}
