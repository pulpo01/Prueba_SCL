package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;
import java.sql.Timestamp;

public class GaEquipAboserDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private long numAbonado;//NUM_ABONADO     NUMBER(8)                     NOT NULL,
	private String numSerie;//  NUM_SERIE       VARCHAR2(25 BYTE)             NOT NULL,
	private long codProducto;//  COD_PRODUCTO    NUMBER(1)                     NOT NULL,
	private String indProcequi;//  IND_PROCEQUI    VARCHAR2(1 BYTE)              NOT NULL,
	private Timestamp fecAlta;//  FEC_ALTA        DATE                          NOT NULL,
	private String indPropiedad;//  IND_PROPIEDAD   VARCHAR2(1 BYTE)              NOT NULL,
	private String numMovimiento;
	private String numSerieDummy;
	private String tipTerminal;
	private String codArticulo;
	private String codBodega;
	private String tipStock;
	private String codUso;
	private String codEstado;
	private String desEquipo;
	
	
	public String getTipStock() {
		return tipStock;
	}
	public void setTipStock(String tipStock) {
		this.tipStock = tipStock;
	}
	public String getCodBodega() {
		return codBodega;
	}
	public void setCodBodega(String codBodega) {
		this.codBodega = codBodega;
	}
	public String getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(String codArticulo) {
		this.codArticulo = codArticulo;
	}
	public String getTipTerminal() {
		return tipTerminal;
	}
	public void setTipTerminal(String tipTerminal) {
		this.tipTerminal = tipTerminal;
	}
	public String getNumSerieDummy() {
		return numSerieDummy;
	}
	public void setNumSerieDummy(String numSerieDummy) {
		this.numSerieDummy = numSerieDummy;
	}
	public String getNumMovimiento() {
		return numMovimiento;
	}
	public void setNumMovimiento(String numMovimiento) {
		this.numMovimiento = numMovimiento;
	}
	public long getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(long codProducto) {
		this.codProducto = codProducto;
	}
	public Timestamp getFecAlta() {
		return fecAlta;
	}
	public void setFecAlta(Timestamp fecAlta) {
		this.fecAlta = fecAlta;
	}
	public String getIndProcequi() {
		return indProcequi;
	}
	public void setIndProcequi(String indProcequi) {
		this.indProcequi = indProcequi;
	}
	public String getIndPropiedad() {
		return indPropiedad;
	}
	public void setIndPropiedad(String indPropiedad) {
		this.indPropiedad = indPropiedad;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}
	public String getCodEstado() {
		return codEstado;
	}
	public void setCodEstado(String codEstado) {
		this.codEstado = codEstado;
	}
	public String getCodUso() {
		return codUso;
	}
	public void setCodUso(String codUso) {
		this.codUso = codUso;
	}
	public String getDesEquipo() {
		return desEquipo;
	}
	public void setDesEquipo(String desEquipo) {
		this.desEquipo = desEquipo;
	}
	

}
