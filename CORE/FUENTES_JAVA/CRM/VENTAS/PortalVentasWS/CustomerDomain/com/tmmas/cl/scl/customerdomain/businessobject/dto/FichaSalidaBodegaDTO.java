package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class FichaSalidaBodegaDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String estadoVenta;
	private String nomVendedor;
	private String nomCliente;
	private String nomUsuarora;
	
	DetalleFichaSalidaBodegaDTO[] detalle;
	
	public DetalleFichaSalidaBodegaDTO[] getDetalle() {
		return detalle;
	}
	public void setDetalle(DetalleFichaSalidaBodegaDTO[] detalle) {
		this.detalle = detalle;
	}
	public String getEstadoVenta() {
		return estadoVenta;
	}
	public void setEstadoVenta(String estadoVenta) {
		this.estadoVenta = estadoVenta;
	}
	public String getNomCliente() {
		return nomCliente;
	}
	public void setNomCliente(String nomCliente) {
		this.nomCliente = nomCliente;
	}
	public String getNomUsuarora() {
		return nomUsuarora;
	}
	public void setNomUsuarora(String nomUsuarora) {
		this.nomUsuarora = nomUsuarora;
	}
	public String getNomVendedor() {
		return nomVendedor;
	}
	public void setNomVendedor(String nomVendedor) {
		this.nomVendedor = nomVendedor;
	}
}
