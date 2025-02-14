package com.tmmas.cl.scl.spnsclwscommon.commonapp.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.AbonadoActivoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;

public class WsAbonadosActivosClienteOutDTO extends RetornoDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	private AbonadoActivoDTO[] abonadosActivosDTO;


	public AbonadoActivoDTO[] getAbonadosActivosDTO() {
		return abonadosActivosDTO;
	}


	public void setAbonadosActivosDTO(AbonadoActivoDTO[] abonadosActivosDTO) {
		this.abonadosActivosDTO = abonadosActivosDTO;
	}
	
	

}
