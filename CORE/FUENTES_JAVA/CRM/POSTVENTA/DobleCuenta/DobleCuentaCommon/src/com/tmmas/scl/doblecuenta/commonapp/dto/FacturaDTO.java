package com.tmmas.scl.doblecuenta.commonapp.dto;

import java.io.Serializable;
import java.util.Date;



public class FacturaDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private Date fecIngRegistro;
	private Date fecCieRegistro;
	private String fecIngRegistroSTR;
	private String fecCieRegistroSTR;
	private long codCiclo;
	private long tipOperación;
	private long tipModalidad;
	private long tipValor;
	private long numSecEncabezadoFd;
	private long numSecDetalleFd;
	
	private ConceptoDTO conceptos;
	private String user;
	
	public ConceptoDTO getConceptos() {
		return conceptos;
	}
	public void setConceptos(ConceptoDTO conceptos) {
		this.conceptos = conceptos;
	}
	public long getCodCiclo() {
		return codCiclo;
	}
	public void setCodCiclo(long codCiclo) {
		this.codCiclo = codCiclo;
	}
	public Date getFecCieRegistro() {
		return fecCieRegistro;
	}
	public void setFecCieRegistro(Date fecCieRegistro) {
		this.fecCieRegistro = fecCieRegistro;
	}
	public Date getFecIngRegistro() {
		return fecIngRegistro;
	}
	public void setFecIngRegistro(Date fecIngRegistro) {
		this.fecIngRegistro = fecIngRegistro;
	}
	public long getTipModalidad() {
		return tipModalidad;
	}
	public void setTipModalidad(long tipModalidad) {
		this.tipModalidad = tipModalidad;
	}
	public long getTipOperación() {
		return tipOperación;
	}
	public void setTipOperación(long tipOperación) {
		this.tipOperación = tipOperación;
	}
	public long getTipValor() {
		return tipValor;
	}
	public void setTipValor(long tipValor) {
		this.tipValor = tipValor;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getFecCieRegistroSTR() {
		return fecCieRegistroSTR;
	}
	public void setFecCieRegistroSTR(String fecCieRegistroSTR) {
		this.fecCieRegistroSTR = fecCieRegistroSTR;
	}
	public String getFecIngRegistroSTR() {
		return fecIngRegistroSTR;
	}
	public void setFecIngRegistroSTR(String fecIngRegistroSTR) {
		this.fecIngRegistroSTR = fecIngRegistroSTR;
	}
	public long getNumSecEncabezadoFd() {
		return numSecEncabezadoFd;
	}
	public void setNumSecEncabezadoFd(long numSecEncabezadoFd) {
		this.numSecEncabezadoFd = numSecEncabezadoFd;
	}
	public long getNumSecDetalleFd() {
		return numSecDetalleFd;
	}
	public void setNumSecDetalleFd(long numSecDetalleFd) {
		this.numSecDetalleFd = numSecDetalleFd;
	}
	
	

}
