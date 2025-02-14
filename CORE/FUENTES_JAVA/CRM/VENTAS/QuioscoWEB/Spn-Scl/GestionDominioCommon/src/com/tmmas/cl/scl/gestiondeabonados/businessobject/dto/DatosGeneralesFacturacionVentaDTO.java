package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class DatosGeneralesFacturacionVentaDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	transient private AbonadosFactVentaDTO[] abonadosFactVentaDTO;

	public AbonadosFactVentaDTO[] getAbonadosFactVentaDTO() {
		return abonadosFactVentaDTO;
	}

	public void setAbonadosFactVentaDTO(AbonadosFactVentaDTO[] abonadosFactVentaDTO) {
		this.abonadosFactVentaDTO = abonadosFactVentaDTO;
	}


}
