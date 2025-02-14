package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
import java.util.Date;


public class LlamadaInFactDTO  implements Serializable {
	/*
	 * Autor: Juan Daniel Muñoz Queupul
	 * */
	
	private static final long serialVersionUID = 1L;
    private long 	numTelefono;
	private Long 	codCicloFact;
	private long 	numFolio;
	private Date 	fecIni;
	private Date 	fecTerm;
	private String 	usuario;
	private String 	campoOrden;
	private String 	tipoOrden;
	private long 	numAbonado;
	private AuditoriaDTO auditoria;
    
    

	public String getCampoOrden() {
		return campoOrden;
	}
	public void setCampoOrden(String campoOrden) {
		this.campoOrden = campoOrden;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public long getNumFolio() {
		return numFolio;
	}
	public void setNumFolio(long numFolio) {
		this.numFolio = numFolio;
	}
	public long getNumTelefono() {
		return numTelefono;
	}
	public void setNumTelefono(long numTelefono) {
		this.numTelefono = numTelefono;
	}
	public String getTipoOrden() {
		return tipoOrden;
	}
	public void setTipoOrden(String tipoOrden) {
		this.tipoOrden = tipoOrden;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public AuditoriaDTO getAuditoria() {
		return auditoria;
	}
	public void setAuditoria(AuditoriaDTO auditoria) {
		this.auditoria = auditoria;
	}
	public Date getFecIni() {
		return fecIni;
	}
	public void setFecIni(Date fecIni) {
		this.fecIni = fecIni;
	}
	public Date getFecTerm() {
		return fecTerm;
	}
	public void setFecTerm(Date fecTerm) {
		this.fecTerm = fecTerm;
	}
	public Long getCodCicloFact() {
		return codCicloFact;
	}
	public void setCodCicloFact(Long codCicloFact) {
		this.codCicloFact = codCicloFact;
	}


}