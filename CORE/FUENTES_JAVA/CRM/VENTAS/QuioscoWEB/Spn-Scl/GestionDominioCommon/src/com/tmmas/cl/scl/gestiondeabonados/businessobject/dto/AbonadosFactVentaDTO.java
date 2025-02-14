package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

import com.tmmas.scl.framework.productDomain.dataTransferObject.SimcardDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.TerminalDTO;

public class AbonadosFactVentaDTO extends AbonadoDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	transient private SimcardDTO simcardDTO;
	transient private TerminalDTO terminalDTO;
	
	public SimcardDTO getSimcardDTO() {
		return simcardDTO;
	}
	public void setSimcardDTO(SimcardDTO simcardDTO) {
		this.simcardDTO = simcardDTO;
	}
	public TerminalDTO getTerminalDTO() {
		return terminalDTO;
	}
	public void setTerminalDTO(TerminalDTO terminalDTO) {
		this.terminalDTO = terminalDTO;
	}

}
