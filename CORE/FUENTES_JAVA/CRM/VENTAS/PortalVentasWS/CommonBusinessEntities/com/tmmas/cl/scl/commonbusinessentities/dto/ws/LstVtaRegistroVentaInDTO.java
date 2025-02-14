package com.tmmas.cl.scl.commonbusinessentities.dto.ws;

import java.io.Serializable;
public class LstVtaRegistroVentaInDTO implements Serializable{
	private static final long serialVersionUID = 1L;

	private String codigoVendedor;
	private String codigoVendedorDealer;
	private String canalVendedor;
	private String fechaDesde;
	private String fechaHasta;
	private String filtro;
	
	public String getFiltro() {
		return filtro;
	}
	public void setFiltro(String filtro) {
		this.filtro = filtro;
	}
	
	public String getCanalVendedor() {
		return canalVendedor;
	}
	public void setCanalVendedor(String canalVendedor) {
		this.canalVendedor = canalVendedor;
	}
	public String getCodigoVendedor() {
		return codigoVendedor;
	}
	public void setCodigoVendedor(String codigoVendedor) {
		this.codigoVendedor = codigoVendedor;
	}
	public String getCodigoVendedorDealer() {
		return codigoVendedorDealer;
	}
	public void setCodigoVendedorDealer(String codigoVendedorDealer) {
		this.codigoVendedorDealer = codigoVendedorDealer;
	}
	public String getFechaDesde() {
		return fechaDesde;
	}
	public void setFechaDesde(String fechaDesde) {
		this.fechaDesde = fechaDesde;
	}
	public String getFechaHasta() {
		return fechaHasta;
	}
	public void setFechaHasta(String fechaHasta) {
		this.fechaHasta = fechaHasta;
	}

	
	
}//fin class LstVtaRegistroVentaInDTO

