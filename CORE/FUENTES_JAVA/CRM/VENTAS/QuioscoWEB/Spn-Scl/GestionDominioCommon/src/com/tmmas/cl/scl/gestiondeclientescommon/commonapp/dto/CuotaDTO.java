package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class CuotaDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String codCuota;
	private String desCuota;
	private int numCuotas;
	private int porIntereses;
	private int numDias;
	private int indForminteres;
	public String getCodCuota() {
		return codCuota;
	}
	public void setCodCuota(String codCuota) {
		this.codCuota = codCuota;
	}
	public String getDesCuota() {
		return desCuota;
	}
	public void setDesCuota(String desCuota) {
		this.desCuota = desCuota;
	}
	public int getIndForminteres() {
		return indForminteres;
	}
	public void setIndForminteres(int indForminteres) {
		this.indForminteres = indForminteres;
	}
	public int getNumCuotas() {
		return numCuotas;
	}
	public void setNumCuotas(int numCuotas) {
		this.numCuotas = numCuotas;
	}
	public int getNumDias() {
		return numDias;
	}
	public void setNumDias(int numDias) {
		this.numDias = numDias;
	}
	public int getPorIntereses() {
		return porIntereses;
	}
	public void setPorIntereses(int porIntereses) {
		this.porIntereses = porIntereses;
	}
}