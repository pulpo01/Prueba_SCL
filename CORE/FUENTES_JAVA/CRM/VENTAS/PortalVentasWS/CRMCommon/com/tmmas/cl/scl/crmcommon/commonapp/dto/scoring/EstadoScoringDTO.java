package com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring;

import java.io.Serializable;
import java.util.Date;

public class EstadoScoringDTO extends EstadoDTO implements Serializable {

	private static final long serialVersionUID = 7245544804324226804L;

	private long codVendedor;

	private Date fechaInicio;
	
	private Date fechaTermino;
    
	private String nomVendedor;
	
	private long numSolScoring;
	
	public long getCodVendedor() {
		return codVendedor;
	}

	public Date getFechaInicio() {
		return fechaInicio;
	}

	public Date getFechaTermino() {
		return fechaTermino;
	}

	public String getNomVendedor() {
		return nomVendedor;
	}

	public long getNumSolScoring() {
		return numSolScoring;
	}

	public void setCodVendedor(long codVendedor) {
		this.codVendedor = codVendedor;
	}

	public void setFechaInicio(Date fechaInicio) {
		this.fechaInicio = fechaInicio;
	}

	public void setFechaTermino(Date fechaTermino) {
		this.fechaTermino = fechaTermino;
	}

	public void setNomVendedor(String nomVendedor) {
		this.nomVendedor = nomVendedor;
	}

	public void setNumSolScoring(long numSolScoring) {
		this.numSolScoring = numSolScoring;
	}

	public String toString() {
		StringBuffer b = new StringBuffer();
		b.append(super.toString() + "\n");
		b.append("getNumSolScoring()" + " [" + getNumSolScoring() + "]\n");
		b.append("getCodVendedor()" + " [" + getCodVendedor() + "]\n");
		b.append("getNomVendedor()" + " [" + getNomVendedor() + "]\n");
		b.append("getFechaInicio()" + " [" + getFechaInicio() + "]\n");
		b.append("getFechaTermino()" + " [" + getFechaTermino() + "]\n");
		b.append("getCodEstado()" + " [" + getCodEstado() + "]\n");
		b.append("getDesEstado()" + " [" + getDesEstado() + "]\n");
		return b.toString();
	}

}
