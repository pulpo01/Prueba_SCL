package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;


public class ConServSupleDTO implements Serializable  {
    /**
	 * Autor : Juan Muñoz Queupul
	 */
	private static final long serialVersionUID = 1L;
    private long numeroAbonado;
	private String codPlantarif;
	private String codPlanServi;
    private long  tipo;
    

	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public long getTipo() {
		return tipo;
	}
	public void setTipo(long tipo) {
		this.tipo = tipo;
	}
	public long getNumeroAbonado() {
		return numeroAbonado;
	}
	public void setNumeroAbonado(long numeroAbonado) {
		this.numeroAbonado = numeroAbonado;
	}
	public String getCodPlantarif() {
		return codPlantarif;
	}
	public void setCodPlantarif(String codPlantarif) {
		this.codPlantarif = codPlantarif;
	}
	public String getCodPlanServi() {
		return codPlanServi;
	}
	public void setCodPlanServi(String codPlanServi) {
		this.codPlanServi = codPlanServi;
	}

}