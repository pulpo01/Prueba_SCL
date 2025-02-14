package com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring;

import java.io.Serializable;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.DocDigitalizadoDTO;

public class DocDigitalizadoScoringDTO extends DocDigitalizadoDTO implements Serializable {

	private static final long serialVersionUID = 5348586975866217564L;

	boolean requeridoScoring;

	long numSolScoring;

	String codScoring;

	String desScoring;
	
	String subido = "NO";
	
	String requeridoScoringRep;

	public String getCodScoring() {
		return codScoring;
	}

	public void setCodScoring(String codScoring) {
		this.codScoring = codScoring;
	}

	public String getDesScoring() {
		return desScoring;
	}

	public void setDesScoring(String desScoring) {
		this.desScoring = desScoring;
	}

	public long getNumSolScoring() {
		return numSolScoring;
	}

	public void setNumSolScoring(long numSolScoring) {
		this.numSolScoring = numSolScoring;
	}

	public boolean isRequeridoScoring() {
		return requeridoScoring;
	}

	public void setRequeridoScoring(boolean requerido) {
		this.requeridoScoring = requerido;
	}

	/**
	 * Constructs a <code>String</code> with all attributes in name = value format.
	 * 
	 * @return a <code>String</code> representation of this object.
	 */
	public String toString() {
		final String newLine = "\n";

		StringBuffer retValue = new StringBuffer();

		retValue.append("DocDigitalizadoScoringDTO ( ").append(super.toString()).append(newLine)
				.append("codScoring = ").append(this.codScoring).append(newLine).append("desScoring = ").append(
						this.desScoring).append(newLine).append("numSolScoring = ").append(this.numSolScoring).append(
						newLine).append("requeridoScoring = ").append(this.requeridoScoring).append(newLine).append(
						" )");

		return retValue.toString();
	}

	public String getRequeridoScoringRep() {
		return requeridoScoringRep;
	}

	public void setRequeridoScoringRep(String requeridoScoringRep) {
		this.requeridoScoringRep = requeridoScoringRep;
	}

	public String getSubido() {
		return subido;
	}

	public void setSubido(String subido) {
		this.subido = subido;
	}

}
