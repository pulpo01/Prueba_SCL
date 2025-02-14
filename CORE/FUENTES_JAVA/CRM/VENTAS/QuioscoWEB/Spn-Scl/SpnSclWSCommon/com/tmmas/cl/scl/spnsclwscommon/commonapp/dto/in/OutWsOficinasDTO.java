package com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in;

import java.io.Serializable;

import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.OficinaWSDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;

public class OutWsOficinasDTO extends RetornoDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private OficinaWSDTO[] oficinasWSDTO;

	public OficinaWSDTO[] getOficinasWSDTO() {
		return oficinasWSDTO;
	}

	public void setOficinasWSDTO(OficinaWSDTO[] oficinasWSDTO) {
		this.oficinasWSDTO = oficinasWSDTO;
	} 

}
