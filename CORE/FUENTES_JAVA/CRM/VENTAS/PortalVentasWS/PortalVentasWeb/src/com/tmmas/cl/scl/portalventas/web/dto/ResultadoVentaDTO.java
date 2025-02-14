package com.tmmas.cl.scl.portalventas.web.dto;

import java.io.Serializable;

public class ResultadoVentaDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private String nroVenta;
	private String codCliente;
	private String nombreCliente;
	private String codVendedor;	
	private String nombreVendedor;
	private String descripcionTipoDocumento;
	private String cantidadLineas;
	
	public String getCantidadLineas() {
		return cantidadLineas;
	}
	public void setCantidadLineas(String cantidadLineas) {
		this.cantidadLineas = cantidadLineas;
	}
	public String getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(String codVendedor) {
		this.codVendedor = codVendedor;
	}
	public String getDescripcionTipoDocumento() {
		return descripcionTipoDocumento;
	}
	public void setDescripcionTipoDocumento(String descripcionTipoDocumento) {
		this.descripcionTipoDocumento = descripcionTipoDocumento;
	}
	public String getNombreCliente() {
		return nombreCliente;
	}
	public void setNombreCliente(String nombreCliente) {
		this.nombreCliente = nombreCliente;
	}
	public String getNombreVendedor() {
		return nombreVendedor;
	}
	public void setNombreVendedor(String nombreVendedor) {
		this.nombreVendedor = nombreVendedor;
	}
	public String getNroVenta() {
		return nroVenta;
	}
	public void setNroVenta(String nroVenta) {
		this.nroVenta = nroVenta;
	}
}
