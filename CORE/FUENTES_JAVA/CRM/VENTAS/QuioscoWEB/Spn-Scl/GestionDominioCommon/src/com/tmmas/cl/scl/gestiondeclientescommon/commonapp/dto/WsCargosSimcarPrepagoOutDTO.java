package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.CargosSimcarPrepagoDTO;

public class WsCargosSimcarPrepagoOutDTO extends RetornoDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private CargosSimcarPrepagoDTO[] CargosSimcarPrepago;

	public CargosSimcarPrepagoDTO[] getCargosSimcarPrepago() {
		return CargosSimcarPrepago;
	}

	public void setCargosSimcarPrepago(CargosSimcarPrepagoDTO[] cargosSimcarPrepago) {
		CargosSimcarPrepago = cargosSimcarPrepago;
	} 

}
