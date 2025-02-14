package com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject;

import java.io.Serializable;



public class ParamRegistroOrdenServicioDTO  extends OrdenServicioBaseDTO implements Serializable {


	private static final long serialVersionUID = 1L;
	
	private CargosObtenidosDTO RegistroCargos;
	private RegistroPlanDTO RegistroPlan;
	
	public CargosObtenidosDTO getRegistroCargos() {
		return RegistroCargos;
	}
	public void setRegistroCargos(CargosObtenidosDTO registroCargos) {
		RegistroCargos = registroCargos;
	}
	public RegistroPlanDTO getRegistroPlan() {
		return RegistroPlan;
	}
	public void setRegistroPlan(RegistroPlanDTO registroPlan) {
		RegistroPlan = registroPlan;
	}
}
