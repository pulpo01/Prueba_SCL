package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class CicloDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private int codCiclo;
	private String fmtFecha;
	
	private String FecDesdeLlam;
	private int periodoCodCiclFact;
	
	public String getFecDesdeLlam() {
		return FecDesdeLlam;
	}
	public void setFecDesdeLlam(String fecDesdeLlam) {
		FecDesdeLlam = fecDesdeLlam;
	}
	public int getPeriodoCodCiclFact() {
		return periodoCodCiclFact;
	}
	public void setPeriodoCodCiclFact(int periodoCodCiclFact) {
		this.periodoCodCiclFact = periodoCodCiclFact;
	}
	public int getCodCiclo() {
		return codCiclo;
	}
	public void setCodCiclo(int codCiclo) {
		this.codCiclo = codCiclo;
	}
	public String getFmtFecha() {
		return fmtFecha;
	}
	public void setFmtFecha(String fmtFecha) {
		this.fmtFecha = fmtFecha;
	}
}
