package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
import java.util.Date;

public class BolsaResponseDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String codBolsa;
	private String indUnidad;
	private long cntBolsa;
	private Date fecIniVig;
	private Date fecTerVig;
	private String desUnidad;
	private RespuestaDTO respuesta;
	
	public String getDesUnidad() {
		return desUnidad;
	}
	public void setDesUnidad(String desUnidad) {
		this.desUnidad = desUnidad;
	}
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
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	
}
