package com.tmmas.scl.serviciospostventasiga.transport;

import java.io.Serializable;

public class AbonadoDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Long numCelular;
	private Long numAbonado;
	private Integer codUso;
	private String codTecnologia;
	private String codPlanTarif;
	private String numMinMDN;
	private Integer codCentral;
	private Integer indPortado;
	private String codError;
	private String desError;
	public String getCodError() {
		return codError;
	}
	public void setCodError(String codError) {
		this.codError = codError;
	}
	public String getDesError() {
		return desError;
	}
	public void setDesError(String desError) {
		this.desError = desError;
	}
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
	 * @return the codUsos
	 */
	public Integer getCodUso() {
		return codUso;
	}
	/**
	 * @param codUsos the codUsos to set
	 */
	public void setCodUso(Integer codUso) {
		this.codUso = codUso;
	}
	/**
	 * @return the indPortado
	 */
	public Integer getIndPortado() {
		return indPortado;
	}
	/**
	 * @param indPortado the indPortado to set
	 */
	public void setIndPortado(Integer indPortado) {
		this.indPortado = indPortado;
	}
	/**
	 * @return the numCelular
	 */
	public Long getNumCelular() {
		return numCelular;
	}
	/**
	 * @param numCelular the numCelular to set
	 */
	public void setNumCelular(Long numCelular) {
		this.numCelular = numCelular;
	}
	public Long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(Long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getNumMinMDN() {
		return numMinMDN;
	}
	public void setNumMinMDN(String numMinMDN) {
		this.numMinMDN = numMinMDN;
	}
	public Integer getCodCentral() {
		return codCentral;
	}
	public void setCodCentral(Integer codCentral) {
		this.codCentral = codCentral;
	}
	
	
}
