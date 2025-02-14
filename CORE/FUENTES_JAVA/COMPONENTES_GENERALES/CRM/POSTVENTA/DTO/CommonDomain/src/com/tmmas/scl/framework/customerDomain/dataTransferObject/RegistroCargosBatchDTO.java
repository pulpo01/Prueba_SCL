/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 16/10/2007     			 Daniel Sagredo            		Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;
import java.sql.Date;


public class RegistroCargosBatchDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	private long numOs;
	private long numCargo;
	private long codConcepto;
	private Date fecAlta;
	private float impCargo;
	private String codMoneda;
	private long numUnidades;
	private long indFactur;
	private long numPaquete;
	private long codCiclFact;
	private long mesGarantia;
	private String numPreGuia;
	private String numGuia;
	private long numFactura;
	private long codConceptoDto;
	private float valDto;
	private long tipDto;
	private long indCuota;
	private long indSupertel;
	private long indManual;
	private String nomUsuarOra;
	private long codCliente;
	private long codProducto;
	private long numTransaccion;
	private long numVenta;
	private String numTerminal;
	private String numSerie;
	private long capCode;
	private long numAbonado;
	private long codPlanCom;
	private String numSerieMec;
	public long getCapCode() {
		return capCode;
	}
	public void setCapCode(long capCode) {
		this.capCode = capCode;
	}
	public long getCodCiclFact() {
		return codCiclFact;
	}
	public void setCodCiclFact(long codCiclFact) {
		this.codCiclFact = codCiclFact;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public long getCodConcepto() {
		return codConcepto;
	}
	public void setCodConcepto(long codConcepto) {
		this.codConcepto = codConcepto;
	}
	public long getCodConceptoDto() {
		return codConceptoDto;
	}
	public void setCodConceptoDto(long codConceptoDto) {
		this.codConceptoDto = codConceptoDto;
	}
	public String getCodMoneda() {
		return codMoneda;
	}
	public void setCodMoneda(String codMoneda) {
		this.codMoneda = codMoneda;
	}
	public long getCodPlanCom() {
		return codPlanCom;
	}
	public void setCodPlanCom(long codPlanCom) {
		this.codPlanCom = codPlanCom;
	}
	public long getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(long codProducto) {
		this.codProducto = codProducto;
	}
	public Date getFecAlta() {
		return fecAlta;
	}
	public void setFecAlta(Date fecAlta) {
		this.fecAlta = fecAlta;
	}
	public float getImpCargo() {
		return impCargo;
	}
	public void setImpCargo(float impCargo) {
		this.impCargo = impCargo;
	}
	public long getIndCuota() {
		return indCuota;
	}
	public void setIndCuota(long indCuota) {
		this.indCuota = indCuota;
	}
	public long getIndFactur() {
		return indFactur;
	}
	public void setIndFactur(long indFactur) {
		this.indFactur = indFactur;
	}
	public long getIndManual() {
		return indManual;
	}
	public void setIndManual(long indManual) {
		this.indManual = indManual;
	}
	public long getIndSupertel() {
		return indSupertel;
	}
	public void setIndSupertel(long indSupertel) {
		this.indSupertel = indSupertel;
	}
	public long getMesGarantia() {
		return mesGarantia;
	}
	public void setMesGarantia(long mesGarantia) {
		this.mesGarantia = mesGarantia;
	}
	public String getNomUsuarOra() {
		return nomUsuarOra;
	}
	public void setNomUsuarOra(String nomUsuarOra) {
		this.nomUsuarOra = nomUsuarOra;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public long getNumCargo() {
		return numCargo;
	}
	public void setNumCargo(long numCargo) {
		this.numCargo = numCargo;
	}
	public long getNumFactura() {
		return numFactura;
	}
	public void setNumFactura(long numFactura) {
		this.numFactura = numFactura;
	}
	public String getNumGuia() {
		return numGuia;
	}
	public void setNumGuia(String numGuia) {
		this.numGuia = numGuia;
	}
	public long getNumOs() {
		return numOs;
	}
	public void setNumOs(long numOs) {
		this.numOs = numOs;
	}
	public long getNumPaquete() {
		return numPaquete;
	}
	public void setNumPaquete(long numPaquete) {
		this.numPaquete = numPaquete;
	}
	public String getNumPreGuia() {
		return numPreGuia;
	}
	public void setNumPreGuia(String numPreGuia) {
		this.numPreGuia = numPreGuia;
	}
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}
	public String getNumSerieMec() {
		return numSerieMec;
	}
	public void setNumSerieMec(String numSerieMec) {
		this.numSerieMec = numSerieMec;
	}
	public String getNumTerminal() {
		return numTerminal;
	}
	public void setNumTerminal(String numTerminal) {
		this.numTerminal = numTerminal;
	}
	public long getNumTransaccion() {
		return numTransaccion;
	}
	public void setNumTransaccion(long numTransaccion) {
		this.numTransaccion = numTransaccion;
	}
	public long getNumUnidades() {
		return numUnidades;
	}
	public void setNumUnidades(long numUnidades) {
		this.numUnidades = numUnidades;
	}
	public long getNumVenta() {
		return numVenta;
	}
	public void setNumVenta(long numVenta) {
		this.numVenta = numVenta;
	}
	public long getTipDto() {
		return tipDto;
	}
	public void setTipDto(long tipDto) {
		this.tipDto = tipDto;
	}
	public float getValDto() {
		return valDto;
	}
	public void setValDto(float valDto) {
		this.valDto = valDto;
	}
	

}
