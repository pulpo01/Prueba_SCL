package com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto;

import java.io.Serializable;

public class ArticuloDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private int 	   codArticulo;	
	private int		   numUnidades;
	private int		   codbodega;
	private String 	   numSerie;
	private int 	   codUso;
	
	public int getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(int codArticulo) {
		this.codArticulo = codArticulo;
	}
	public int getNumUnidades() {
		return numUnidades;
	}
	public void setNumUnidades(int numUnidades) {
		this.numUnidades = numUnidades;
	}
	public int getCodbodega() {
		return codbodega;
	}
	public void setCodbodega(int codbodega) {
		this.codbodega = codbodega;
	}
	
	public int getCodUso() {
		return codUso;
	}
	public void setCodUso(int codUso) {
		this.codUso = codUso;
	}
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}
}
