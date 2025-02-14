package com.tmmas.cl.scl.productdomain.businessobject.dto;

import java.io.Serializable;

public class EquipoKitDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String numKit;
	private String codTecnologia;
	
	//Datos Simcard
	private long codArticuloSimcard;
	private String numSerieSimcard;
	private long codBodegaSimcard;
	private long tipoStockSimcard;
	private int indTelefonoSimcard;
	private long numTelefonoSimcard;
	private String numSerieMecSimcard;
	private String tipTerminalSimcard;
	
	//Datos Equipo
	private long codArticuloEquipo;
	private String numSerieEquipo; 
	private long codBodegaEquipo;
	private long tipoStockEquipo;
	private int indTelefonoEquipo;
	private long numTelefonoEquipo;
	private String numSerieMecEquipo;
	private String tipTerminalEquipo;
	
	
	public long getCodArticuloEquipo() {
		return codArticuloEquipo;
	}
	public void setCodArticuloEquipo(long codArticuloEquipo) {
		this.codArticuloEquipo = codArticuloEquipo;
	}
	public long getCodArticuloSimcard() {
		return codArticuloSimcard;
	}
	public void setCodArticuloSimcard(long codArticuloSimcard) {
		this.codArticuloSimcard = codArticuloSimcard;
	}
	public long getCodBodegaEquipo() {
		return codBodegaEquipo;
	}
	public void setCodBodegaEquipo(long codBodegaEquipo) {
		this.codBodegaEquipo = codBodegaEquipo;
	}
	public long getCodBodegaSimcard() {
		return codBodegaSimcard;
	}
	public void setCodBodegaSimcard(long codBodegaSimcard) {
		this.codBodegaSimcard = codBodegaSimcard;
	}
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	public int getIndTelefonoEquipo() {
		return indTelefonoEquipo;
	}
	public void setIndTelefonoEquipo(int indTelefonoEquipo) {
		this.indTelefonoEquipo = indTelefonoEquipo;
	}
	public int getIndTelefonoSimcard() {
		return indTelefonoSimcard;
	}
	public void setIndTelefonoSimcard(int indTelefonoSimcard) {
		this.indTelefonoSimcard = indTelefonoSimcard;
	}
	public String getNumKit() {
		return numKit;
	}
	public void setNumKit(String numKit) {
		this.numKit = numKit;
	}
	public String getNumSerieEquipo() {
		return numSerieEquipo;
	}
	public void setNumSerieEquipo(String numSerieEquipo) {
		this.numSerieEquipo = numSerieEquipo;
	}
	public String getNumSerieMecEquipo() {
		return numSerieMecEquipo;
	}
	public void setNumSerieMecEquipo(String numSerieMecEquipo) {
		this.numSerieMecEquipo = numSerieMecEquipo;
	}
	public String getNumSerieMecSimcard() {
		return numSerieMecSimcard;
	}
	public void setNumSerieMecSimcard(String numSerieMecSimcard) {
		this.numSerieMecSimcard = numSerieMecSimcard;
	}
	public String getNumSerieSimcard() {
		return numSerieSimcard;
	}
	public void setNumSerieSimcard(String numSerieSimcard) {
		this.numSerieSimcard = numSerieSimcard;
	}
	public long getNumTelefonoEquipo() {
		return numTelefonoEquipo;
	}
	public void setNumTelefonoEquipo(long numTelefonoEquipo) {
		this.numTelefonoEquipo = numTelefonoEquipo;
	}
	public long getNumTelefonoSimcard() {
		return numTelefonoSimcard;
	}
	public void setNumTelefonoSimcard(long numTelefonoSimcard) {
		this.numTelefonoSimcard = numTelefonoSimcard;
	}
	public long getTipoStockEquipo() {
		return tipoStockEquipo;
	}
	public void setTipoStockEquipo(long tipoStockEquipo) {
		this.tipoStockEquipo = tipoStockEquipo;
	}
	public long getTipoStockSimcard() {
		return tipoStockSimcard;
	}
	public void setTipoStockSimcard(long tipoStockSimcard) {
		this.tipoStockSimcard = tipoStockSimcard;
	}
	public String getTipTerminalEquipo() {
		return tipTerminalEquipo;
	}
	public void setTipTerminalEquipo(String tipTerminalEquipo) {
		this.tipTerminalEquipo = tipTerminalEquipo;
	}
	public String getTipTerminalSimcard() {
		return tipTerminalSimcard;
	}
	public void setTipTerminalSimcard(String tipTerminalSimcard) {
		this.tipTerminalSimcard = tipTerminalSimcard;
	}
	

}
