package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
import java.util.Date;

public class PlanTarifarioOutDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String codPlanTarifario;
	private String desPlanTarifario;
	private String codBolsa;
	private String indUnidad;
	private long cntBolsa;
	private Date fecIniVig;
	private Date fecTerVig;
	private String desUnidad;

	public long getCntBolsa() {
		return cntBolsa;
	}
	public void setCntBolsa(long cntBolsa) {
		this.cntBolsa = cntBolsa;
	}
	public String getCodBolsa() {
		return codBolsa;
	}
	public void setCodBolsa(String codBolsa) {
		this.codBolsa = codBolsa;
	}
	public String getDesUnidad() {
		return desUnidad;
	}
	public void setDesUnidad(String desUnidad) {
		this.desUnidad = desUnidad;
	}
	public Date getFecIniVig() {
		return fecIniVig;
	}
	public void setFecIniVig(Date fecIniVig) {
		this.fecIniVig = fecIniVig;
	}
	public Date getFecTerVig() {
		return fecTerVig;
	}
	public void setFecTerVig(Date fecTerVig) {
		this.fecTerVig = fecTerVig;
	}
	public String getIndUnidad() {
		return indUnidad;
	}
	public void setIndUnidad(String indUnidad) {
		this.indUnidad = indUnidad;
	}
	public String getCodPlanTarifario() {
		return codPlanTarifario;
	}
	public void setCodPlanTarifario(String codPlanTarifario) {
		this.codPlanTarifario = codPlanTarifario;
	}
	public String getDesPlanTarifario() {
		return desPlanTarifario;
	}
	public void setDesPlanTarifario(String desPlanTarifario) {
		this.desPlanTarifario = desPlanTarifario;
	}

}
