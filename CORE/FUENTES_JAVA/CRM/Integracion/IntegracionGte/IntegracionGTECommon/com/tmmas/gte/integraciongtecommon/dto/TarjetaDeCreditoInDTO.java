package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;


public class TarjetaDeCreditoInDTO  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private long numeroTelefono;
	private String codTipTarjeta;
	private String numeroTarjeta;
	private String fechaVencTarjeta;
	private String codBancoTarjeta;
	private String nombreTitular;
	private String observaciones;
	private AuditoriaDTO auditoria;
	public AuditoriaDTO getAuditoria() {
		return auditoria;
	}
	public void setAuditoria(AuditoriaDTO auditoria) {
		this.auditoria = auditoria;
	}
	public String getCodBancoTarjeta() {
		return codBancoTarjeta;
	}
	public void setCodBancoTarjeta(String codBancoTarjeta) {
		this.codBancoTarjeta = codBancoTarjeta;
	}
	public String getCodTipTarjeta() {
		return codTipTarjeta;
	}
	public void setCodTipTarjeta(String codTipTarjeta) {
		this.codTipTarjeta = codTipTarjeta;
	}

	public String getNombreTitular() {
		return nombreTitular;
	}
	public void setNombreTitular(String nombreTitular) {
		this.nombreTitular = nombreTitular;
	}
	public String getNumeroTarjeta() {
		return numeroTarjeta;
	}
	public void setNumeroTarjeta(String numeroTarjeta) {
		this.numeroTarjeta = numeroTarjeta;
	}
	public long getNumTelefono() {
		return numeroTelefono;
	}
	public void setNumTelefono(long numTelefono) {
		this.numeroTelefono = numTelefono;
	}
	public String getObservaciones() {
		return observaciones;
	}
	public void setObservaciones(String observaciones) {
		this.observaciones = observaciones;
	}
	public String getFechaVencTarjeta() {
		return fechaVencTarjeta;
	}
	public void setFechaVencTarjeta(String fechaVencTarjeta) {
		this.fechaVencTarjeta = fechaVencTarjeta;
	}

	

}