package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class PrecioEquipoNuevoDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;

    private Long numAbonado;
    private String codPlanTarif;
	private Long codArticulo;
	private String indComodato;
	private Integer codProducto;
	private Integer codModVenta;
	private Integer codUso;
	private Integer tipStock;
	private Integer codEstado;
	private Integer numMeses;
	private Integer indRecambio;
	
	public Long getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(Long codArticulo) {
		this.codArticulo = codArticulo;
	}
	public Integer getCodEstado() {
		return codEstado;
	}
	public void setCodEstado(Integer codEstado) {
		this.codEstado = codEstado;
	}
	public Integer getCodModVenta() {
		return codModVenta;
	}
	public void setCodModVenta(Integer codModVenta) {
		this.codModVenta = codModVenta;
	}
	public String getCodPlanTarif() {
		return codPlanTarif;
	}
	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}
	public Integer getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(Integer codProducto) {
		this.codProducto = codProducto;
	}
	public Integer getCodUso() {
		return codUso;
	}
	public void setCodUso(Integer codUso) {
		this.codUso = codUso;
	}
	public String getIndComodato() {
		return indComodato;
	}
	public void setIndComodato(String indComodato) {
		this.indComodato = indComodato;
	}

	public Integer getIndRecambio() {
		return indRecambio;
	}
	public void setIndRecambio(Integer indRecambio) {
		this.indRecambio = indRecambio;
	}
	public Long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(Long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public Integer getNumMeses() {
		return numMeses;
	}
	public void setNumMeses(Integer numMeses) {
		this.numMeses = numMeses;
	}
	public Integer getTipStock() {
		return tipStock;
	}
	public void setTipStock(Integer tipStock) {
		this.tipStock = tipStock;
	}
	
	
}
