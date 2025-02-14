package com.tmmas.scl.serviciospostventasiga.transport;

import java.io.Serializable;

public class PlanesTarifariosDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String codPlantarif;
	private String desPlanTarif;
	private Integer limConsumo;
	private String codCargoBasico;
	private Integer numABonados;
	private Integer indFamiliar;
	private Integer indProporcs;
	private Integer indCargoHabil;
	private Integer numDiasExpira;
	private Integer codUso;
	
	/**
	 * @return the codCargoBasico
	 */
	public String getCodCargoBasico() {
		return codCargoBasico;
	}
	/**
	 * @param codCargoBasico the codCargoBasico to set
	 */
	public void setCodCargoBasico(String codCargoBasico) {
		this.codCargoBasico = codCargoBasico;
	}
	/**
	 * @return the codPlantarif
	 */
	public String getCodPlantarif() {
		return codPlantarif;
	}
	/**
	 * @param codPlantarif the codPlantarif to set
	 */
	public void setCodPlantarif(String codPlantarif) {
		this.codPlantarif = codPlantarif;
	}
	/**
	 * @return the codUso
	 */
	public Integer getCodUso() {
		return codUso;
	}
	/**
	 * @param codUso the codUso to set
	 */
	public void setCodUso(Integer codUso) {
		this.codUso = codUso;
	}
	/**
	 * @return the desPlanTarif
	 */
	public String getDesPlanTarif() {
		return desPlanTarif;
	}
	/**
	 * @param desPlanTarif the desPlanTarif to set
	 */
	public void setDesPlanTarif(String desPlanTarif) {
		this.desPlanTarif = desPlanTarif;
	}
	/**
	 * @return the indCargoHabil
	 */
	public Integer getIndCargoHabil() {
		return indCargoHabil;
	}
	/**
	 * @param indCargoHabil the indCargoHabil to set
	 */
	public void setIndCargoHabil(Integer indCargoHabil) {
		this.indCargoHabil = indCargoHabil;
	}
	/**
	 * @return the indFamiliar
	 */
	public Integer getIndFamiliar() {
		return indFamiliar;
	}
	/**
	 * @param indFamiliar the indFamiliar to set
	 */
	public void setIndFamiliar(Integer indFamiliar) {
		this.indFamiliar = indFamiliar;
	}
	/**
	 * @return the indProporcs
	 */
	public Integer getIndProporcs() {
		return indProporcs;
	}
	/**
	 * @param indProporcs the indProporcs to set
	 */
	public void setIndProporcs(Integer indProporcs) {
		this.indProporcs = indProporcs;
	}
	/**
	 * @return the limConsumo
	 */
	public Integer getLimConsumo() {
		return limConsumo;
	}
	/**
	 * @param limConsumo the limConsumo to set
	 */
	public void setLimConsumo(Integer limConsumo) {
		this.limConsumo = limConsumo;
	}
	/**
	 * @return the numABonados
	 */
	public Integer getNumABonados() {
		return numABonados;
	}
	/**
	 * @param numABonados the numABonados to set
	 */
	public void setNumABonados(Integer numABonados) {
		this.numABonados = numABonados;
	}
	/**
	 * @return the numDiasExpira
	 */
	public Integer getNumDiasExpira() {
		return numDiasExpira;
	}
	/**
	 * @param numDiasExpira the numDiasExpira to set
	 */
	public void setNumDiasExpira(Integer numDiasExpira) {
		this.numDiasExpira = numDiasExpira;
	}
	
}
