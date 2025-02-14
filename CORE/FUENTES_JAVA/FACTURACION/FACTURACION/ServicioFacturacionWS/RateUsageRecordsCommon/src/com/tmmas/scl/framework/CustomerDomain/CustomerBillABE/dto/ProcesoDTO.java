package com.tmmas.scl.framework.CustomerDomain.CustomerBillABE.dto;

import java.io.Serializable;


public class ProcesoDTO implements Serializable
{
	
	private long numProceso;
	private int codTipDocum; 
	private long  codVenAgente;
	private int codCentremi;
	private String fecEfectividad;
	private String nomUsuarora;
	private String letraAg;
	private long numSecuag;
	private int codTipDocNot;
	private long codVenAgenteNot;
	private String letraNot;
	private int codCentrNot;
	private long numSecNot;
	private int indEstado;
	private long codCiclFact;
	private int indNotaCredc;
	
	
	public int getCodCentremi() {
		return codCentremi;
	}
	public void setCodCentremi(int codCentremi) {
		this.codCentremi = codCentremi;
	}
	public int getCodCentrNot() {
		return codCentrNot;
	}
	public void setCodCentrNot(int codCentrNot) {
		this.codCentrNot = codCentrNot;
	}
	public long getCodCiclFact() {
		return codCiclFact;
	}
	public void setCodCiclFact(long codCiclFact) {
		this.codCiclFact = codCiclFact;
	}
	public int getCodTipDocNot() {
		return codTipDocNot;
	}
	public void setCodTipDocNot(int codTipDocNot) {
		this.codTipDocNot = codTipDocNot;
	}
	public int getCodTipDocum() {
		return codTipDocum;
	}
	public void setCodTipDocum(int codTipDocum) {
		this.codTipDocum = codTipDocum;
	}
	public long getCodVenAgente() {
		return codVenAgente;
	}
	public void setCodVenAgente(long codVenAgente) {
		this.codVenAgente = codVenAgente;
	}
	public long getCodVenAgenteNot() {
		return codVenAgenteNot;
	}
	public void setCodVenAgenteNot(long codVenAgenteNot) {
		this.codVenAgenteNot = codVenAgenteNot;
	}
	public String getFecEfectividad() {
		return fecEfectividad;
	}
	public void setFecEfectividad(String fecEfectividad) {
		this.fecEfectividad = fecEfectividad;
	}
	public int getIndEstado() {
		return indEstado;
	}
	public void setIndEstado(int indEstado) {
		this.indEstado = indEstado;
	}
	public int getIndNotaCredc() {
		return indNotaCredc;
	}
	public void setIndNotaCredc(int indNotaCredc) {
		this.indNotaCredc = indNotaCredc;
	}
	public String getLetraAg() {
		return letraAg;
	}
	public void setLetraAg(String letraAg) {
		this.letraAg = letraAg;
	}
	public String getLetraNot() {
		return letraNot;
	}
	public void setLetraNot(String letraNot) {
		this.letraNot = letraNot;
	}
	public String getNomUsuarora() {
		return nomUsuarora;
	}
	public void setNomUsuarora(String nomUsuarora) {
		this.nomUsuarora = nomUsuarora;
	}
	public long getNumProceso() {
		return numProceso;
	}
	public void setNumProceso(long numProceso) {
		this.numProceso = numProceso;
	}
	public long getNumSecNot() {
		return numSecNot;
	}
	public void setNumSecNot(long numSecNot) {
		this.numSecNot = numSecNot;
	}
	public long getNumSecuag() {
		return numSecuag;
	}
	public void setNumSecuag(long numSecuag) {
		this.numSecuag = numSecuag;
	}
	
	  
	
}
