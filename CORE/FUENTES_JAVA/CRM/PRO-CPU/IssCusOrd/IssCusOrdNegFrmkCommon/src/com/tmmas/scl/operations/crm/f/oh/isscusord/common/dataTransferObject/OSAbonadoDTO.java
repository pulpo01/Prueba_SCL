package com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject;

import java.io.Serializable;

import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;

public class OSAbonadoDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private long numOOSS;
	private AbonadoDTO abonado;
	
	public AbonadoDTO getAbonado() {
		return abonado;
	}
	public void setAbonado(AbonadoDTO abonado) {
		this.abonado = abonado;
	}
	public long getNumOOSS() {
		return numOOSS;
	}
	public void setNumOOSS(long numOOSS) {
		this.numOOSS = numOOSS;
	}
	
}
