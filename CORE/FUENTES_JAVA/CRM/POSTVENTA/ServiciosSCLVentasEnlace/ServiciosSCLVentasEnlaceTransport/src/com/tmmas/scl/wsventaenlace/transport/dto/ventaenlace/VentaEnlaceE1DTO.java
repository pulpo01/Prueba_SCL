package com.tmmas.scl.wsventaenlace.transport.dto.ventaenlace;

import com.tmmas.scl.wsventaenlace.transport.dto.OOSSDTO;

public class VentaEnlaceE1DTO extends OOSSDTO {
	private static final long serialVersionUID = 5090133200710037652L;
	private long numAbonado;
	private String codOs;
	
	public String getCodOs() {
		return codOs;
	}

	public void setCodOs(String codOs) {
		this.codOs = codOs;
	}

	public long getNumAbonado() {
		return numAbonado;
	}

	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}	
}
