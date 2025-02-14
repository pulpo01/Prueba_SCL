package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class ParametrosCargoHabilitacionDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;

	private String indComodato;
	private Integer codProducto;
	private Integer codModVenta;
	private Integer tipStock;
	private Long codArticulo;
	private Integer codUso;
	private Integer numMeses;
	private String codPlanTarif;
	private String codAntiguedad;
	
	public String getCodAntiguedad() {
		return codAntiguedad;
	}
	public void setCodAntiguedad(String codAntiguedad) {
		this.codAntiguedad = codAntiguedad;
	}
	public Long getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(Long codArticulo) {
		this.codArticulo = codArticulo;
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
