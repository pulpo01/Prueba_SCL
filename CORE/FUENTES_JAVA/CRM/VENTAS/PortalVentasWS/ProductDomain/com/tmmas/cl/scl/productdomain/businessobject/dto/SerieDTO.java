package com.tmmas.cl.scl.productdomain.businessobject.dto;

import java.io.Serializable;

public class SerieDTO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String numSerie;

	private String numTelefono;

	private int codCanal;

	private int codModVenta;

	private long codVendedor;

	private long codBodega;

	private long codArticulo;

	private String codHlr;

	private long codCentral;

	private int codUso;

	private String tipArticulo;

	private int codEstado;

	private String fechaEntrada;

	private String codTecnologia;

	private String tipTerminal;

	private String tipoStock;

	/** 
	 * Incidencia 148144
	 * @author JIB
	 * Operadora solicita mostrar des_uso en la búsqueda de series */
	private String desUso;

	public String getDesUso() {
		return desUso;
	}

	public void setDesUso(String desUso) {
		this.desUso = desUso;
	}

	public String getTipoStock() {
		return tipoStock;
	}

	public void setTipoStock(String tipoStock) {
		this.tipoStock = tipoStock;
	}

	public String getCodTecnologia() {
		return codTecnologia;
	}

	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}

	public String getFechaEntrada() {
		return fechaEntrada;
	}

	public void setFechaEntrada(String fechaEntrada) {
		this.fechaEntrada = fechaEntrada;
	}

	public long getCodArticulo() {
		return codArticulo;
	}

	public void setCodArticulo(long codArticulo) {
		this.codArticulo = codArticulo;
	}

	public long getCodBodega() {
		return codBodega;
	}

	public void setCodBodega(long codBodega) {
		this.codBodega = codBodega;
	}

	public int getCodCanal() {
		return codCanal;
	}

	public void setCodCanal(int codCanal) {
		this.codCanal = codCanal;
	}

	public long getCodCentral() {
		return codCentral;
	}

	public void setCodCentral(long codCentral) {
		this.codCentral = codCentral;
	}

	public String getCodHlr() {
		return codHlr;
	}

	public void setCodHlr(String codHlr) {
		this.codHlr = codHlr;
	}

	public int getCodModVenta() {
		return codModVenta;
	}

	public void setCodModVenta(int codModVenta) {
		this.codModVenta = codModVenta;
	}

	public int getCodUso() {
		return codUso;
	}

	public void setCodUso(int codUso) {
		this.codUso = codUso;
	}

	public long getCodVendedor() {
		return codVendedor;
	}

	public void setCodVendedor(long codVendedor) {
		this.codVendedor = codVendedor;
	}

	public String getNumSerie() {
		return numSerie;
	}

	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}

	public String getTipArticulo() {
		return tipArticulo;
	}

	public void setTipArticulo(String tipArticulo) {
		this.tipArticulo = tipArticulo;
	}

	public int getCodEstado() {
		return codEstado;
	}

	public void setCodEstado(int codEstado) {
		this.codEstado = codEstado;
	}

	public String getNumTelefono() {
		return numTelefono;
	}

	public void setNumTelefono(String numTelefono) {
		this.numTelefono = numTelefono;
	}

	public String getTipTerminal() {
		return tipTerminal;
	}

	public void setTipTerminal(String tipTerminal) {
		this.tipTerminal = tipTerminal;
	}

}
