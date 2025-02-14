package com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in;

import java.io.Serializable;

import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsTipoComisionistaOutDTO;

public class OutWsComisionistaDTO extends RetornoDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private WsTipoComisionistaOutDTO comisionistasDTO;
	public WsTipoComisionistaOutDTO getComisionistasDTO() {
		return comisionistasDTO;
	}
	public void setComisionistasDTO(WsTipoComisionistaOutDTO comisionistasDTO) {
		this.comisionistasDTO = comisionistasDTO;
	}
}
