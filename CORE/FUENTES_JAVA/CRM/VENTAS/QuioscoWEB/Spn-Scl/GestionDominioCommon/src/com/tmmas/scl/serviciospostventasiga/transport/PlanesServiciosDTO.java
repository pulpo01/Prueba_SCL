package com.tmmas.scl.serviciospostventasiga.transport;

import java.io.Serializable;

public class PlanesServiciosDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String codPlanServ;
	private String desPlanServ;
	private String codTecnologia;
	private String codPlanTarif;
	
	/**
	 * @return the codPlanTarif
	 */
	public String getCodPlanTarif() {
		return codPlanTarif;
	}
	/**
	 * @param codPlanTarif the codPlanTarif to set
	 */
	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}
	/**
	 * @return the codTecnologia
	 */
	public String getCodTecnologia() {
		return codTecnologia;
	}
	/**
	 * @param codTecnologia the codTecnologia to set
	 */
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	/**
	 * @return the codPlanServ
	 */
	/**
	 * @return the desPlanServ
	 */
	public String getDesPlanServ() {
		return desPlanServ;
	}
	/**
	 * @param desPlanServ the desPlanServ to set
	 */
	public void setDesPlanServ(String desPlanServ) {
		this.desPlanServ = desPlanServ;
	}
	public String getCodPlanServ() {
		return codPlanServ;
	}
	public void setCodPlanServ(String codPlanServ) {
		this.codPlanServ = codPlanServ;
	}
	
	
}
