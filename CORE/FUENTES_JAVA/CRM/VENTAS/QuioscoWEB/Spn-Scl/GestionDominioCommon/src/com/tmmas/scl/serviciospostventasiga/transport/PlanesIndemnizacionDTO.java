package com.tmmas.scl.serviciospostventasiga.transport;

import java.io.Serializable;

public class PlanesIndemnizacionDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Integer codPlanIndemnizacion;
	private String desPlanIndemnizacion;
	/**
	 * @return the codPlanIndemnizacion
	 */
	public Integer getCodPlanIndemnizacion() {
		return codPlanIndemnizacion;
	}
	/**
	 * @param codPlanIndemnizacion the codPlanIndemnizacion to set
	 */
	public void setCodPlanIndemnizacion(Integer codPlanIndemnizacion) {
		this.codPlanIndemnizacion = codPlanIndemnizacion;
	}
	/**
	 * @return the desPlanIndemnizacion
	 */
	public String getDesPlanIndemnizacion() {
		return desPlanIndemnizacion;
	}
	/**
	 * @param desPlanIndemnizacion the desPlanIndemnizacion to set
	 */
	public void setDesPlanIndemnizacion(String desPlanIndemnizacion) {
		this.desPlanIndemnizacion = desPlanIndemnizacion;
	}
	
	
}
