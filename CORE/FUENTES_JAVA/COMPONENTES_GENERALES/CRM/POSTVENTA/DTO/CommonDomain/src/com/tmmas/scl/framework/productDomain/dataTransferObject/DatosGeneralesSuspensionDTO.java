package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;
import java.util.Date;

public class DatosGeneralesSuspensionDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;

	private long maxDiasSuspVol;  		// Cantidad de dias maximo para el tope de la suspension voluntaria
	private long maxDiasAntelacionSusp; 	// Meses de antelacion para la suspension
	public long getMaxDiasAntelacionSusp() {
		return maxDiasAntelacionSusp;
	}
	public void setMaxDiasAntelacionSusp(long maxDiasAntelacionSusp) {
		this.maxDiasAntelacionSusp = maxDiasAntelacionSusp;
	}
	public long getMaxDiasSuspVol() {
		return maxDiasSuspVol;
	}
	public void setMaxDiasSuspVol(long maxDiasSuspVol) {
		this.maxDiasSuspVol = maxDiasSuspVol;
	}

	


	
} // DiasMaximoSuspencionDTO
