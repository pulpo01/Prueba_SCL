package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class AltaClienteDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private long codCuenta;
	private String codPlanTarif;
	private String codPlanTarifNuevo;
	
	public long getCodCuenta() {
		return codCuenta;
	}
	public void setCodCuenta(long codCuenta) {
		this.codCuenta = codCuenta;
	}
	public String getCodPlanTarif() {
		return codPlanTarif;
	}
	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}
	public String getCodPlanTarifNuevo() {
		return codPlanTarifNuevo;
	}
	public void setCodPlanTarifNuevo(String codPlanTarifNuevo) {
		this.codPlanTarifNuevo = codPlanTarifNuevo;
	}
}
