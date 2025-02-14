package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class WSPlanTarifarioInDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String codPlanTarifario;
	private String codigoVendedor;
	
	public String getCodigoVendedor() {
		return codigoVendedor;
	}
	public void setCodigoVendedor(String codigoVendedor) {
		this.codigoVendedor = codigoVendedor;
	}
	public String getCodPlanTarifario() {
		return codPlanTarifario;
	}
	public void setCodPlanTarifario(String codPlanTarifario) {
		this.codPlanTarifario = codPlanTarifario;
	}
	

}
