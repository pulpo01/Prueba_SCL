package com.tmmas.cl.scl.frameworkcargossrv.service.dto;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosReglaDTO;



//import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosReglaDTO;

public class ParametrosReglasDiferenciaGarantiaDTO extends ParametrosReglaDTO {
	
	private static final long serialVersionUID = 1L;

	private Double valorDiferencia;
	
	public Double getValorDiferencia() {
		return valorDiferencia;
	}
	public void setValorDiferencia(Double valorDiferencia) {
		this.valorDiferencia = valorDiferencia;
	}
	
	
	
}//fin ParametrosReglasDiferenciaGarantiaDTO
