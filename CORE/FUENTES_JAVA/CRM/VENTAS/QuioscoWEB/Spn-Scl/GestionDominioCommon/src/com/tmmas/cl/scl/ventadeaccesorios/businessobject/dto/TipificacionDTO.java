package com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto;

import java.io.Serializable;

public class TipificacionDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private int 	codArticulo;
	private String	numSerie;
	private String	descripArticulo;
	private double 	precioArticulo;
	private String 	numCelular;
	private String 	equiAcc;
	private String  tipTerminal;
	private double 	impITMB;
	private double 	impISC;
	private double 	descuentoPrecio;
	private int 	codError;
	private String 	msgError;	
	private int 	numEvento;	
	
	public int getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(int codArticulo) {
		this.codArticulo = codArticulo;
	}
	public String getDescripArticulo() {
		return descripArticulo;
	}
	public void setDescripArticulo(String descripArticulo) {
		this.descripArticulo = descripArticulo;
	}
	public String getEquiAcc() {
		return equiAcc;
	}
	public void setEquiAcc(String equiAcc) {
		this.equiAcc = equiAcc;
	}	
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}
	public double getPrecioArticulo() {
		return precioArticulo;
	}
	public void setPrecioArticulo(double precioArticulo) {
		this.precioArticulo = precioArticulo;
	}
	public String getTipTerminal() {
		return tipTerminal;
	}
	public void setTipTerminal(String tipTerminal) {
		this.tipTerminal = tipTerminal;
	}
	public int getCodError() {
		return codError;
	}
	public void setCodError(int codError) {
		this.codError = codError;
	}
	public String getMsgError() {
		return msgError;
	}
	public void setMsgError(String msgError) {
		this.msgError = msgError;
	}
	public int getNumEvento() {
		return numEvento;
	}
	public void setNumEvento(int numEvento) {
		this.numEvento = numEvento;
	}
	public String getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(String numCelular) {
		this.numCelular = numCelular;
	}
	public double getImpISC() {
		return impISC;
	}
	public void setImpISC(double impISC) {
		this.impISC = impISC;
	}
	public double getImpITMB() {
		return impITMB;
	}
	public void setImpITMB(double impITMB) {
		this.impITMB = impITMB;
	}
	public double getDescuentoPrecio() {
		return descuentoPrecio;
	}
	public void setDescuentoPrecio(double descuentoPrecio) {
		this.descuentoPrecio = descuentoPrecio;
	}	
}
