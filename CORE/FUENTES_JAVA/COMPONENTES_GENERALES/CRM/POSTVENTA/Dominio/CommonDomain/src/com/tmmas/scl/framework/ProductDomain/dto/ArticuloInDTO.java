package com.tmmas.scl.framework.ProductDomain.dto;

import java.io.Serializable;

public class ArticuloInDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String cod_tecnologia;
	private String cod_fabricante;
	private String tipTerminal;
	private String indEquipo;
	private int mesGarantia;
	private long codArticulo;
	private String desArticulo;
	private long tipoArticulo;
	private int codUso;
	
	
	public int getCodUso() {
		return codUso;
	}
	public void setCodUso(int codUso) {
		this.codUso = codUso;
	}
	public int getMesGarantia() {
		return mesGarantia;
	}
	public void setMesGarantia(int mesGarantia) {
		this.mesGarantia = mesGarantia;
	}
	public String getDesArticulo() {
		return desArticulo;
	}
	public void setDesArticulo(String desArticulo) {
		this.desArticulo = desArticulo;
	}
	public String getIndEquipo() {
		return indEquipo;
	}
	public void setIndEquipo(String indEquipo) {
		this.indEquipo = indEquipo;
	}
	public String getTipTerminal() {
		return tipTerminal;
	}
	public void setTipTerminal(String tipTerminal) {
		this.tipTerminal = tipTerminal;
	}
	public String getCod_fabricante() {
		return cod_fabricante;
	}
	public void setCod_fabricante(String cod_fabricante) {
		this.cod_fabricante = cod_fabricante;
	}
	public String getCod_tecnologia() {
		return cod_tecnologia;
	}
	public void setCod_tecnologia(String cod_tecnologia) {
		this.cod_tecnologia = cod_tecnologia;
	}
	public long getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(long codArticulo) {
		this.codArticulo = codArticulo;
	}
	public long getTipoArticulo() {
		return tipoArticulo;
	}
	public void setTipoArticulo(long tipoArticulo) {
		this.tipoArticulo = tipoArticulo;
	}
	
}