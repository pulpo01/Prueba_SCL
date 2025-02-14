package com.tmmas.cl.scl.pv.customerorder.commonapp.dto;

import java.io.Serializable;

public class ActualizarSSClienteDTO implements Serializable 
{
	private static final long serialVersionUID = 1L;
	
	private CustomerAccountDTO clienteServicio;
	private CustomerAccountDTO clientePago;
	
	private OrdenServicioDTO ooss;
	
	private ProductDTO[] servActivar;
	private ProductDTO[] servDesactivar;
	
	
	public CustomerAccountDTO getClientePago() {
		return clientePago;
	}
	public void setClientePago(CustomerAccountDTO clientePago) {
		this.clientePago = clientePago;
	}
	public CustomerAccountDTO getClienteServicio() {
		return clienteServicio;
	}
	public void setClienteServicio(CustomerAccountDTO clienteServicio) {
		this.clienteServicio = clienteServicio;
	}
	public OrdenServicioDTO getOoss() {
		return ooss;
	}
	public void setOoss(OrdenServicioDTO ooss) {
		this.ooss = ooss;
	}
	public ProductDTO[] getServActivar() {
		return servActivar;
	}
	public void setServActivar(ProductDTO[] servActivar) {
		this.servActivar = servActivar;
	}
	public ProductDTO[] getServDesactivar() {
		return servDesactivar;
	}
	public void setServDesactivar(ProductDTO[] servDesactivar) {
		this.servDesactivar = servDesactivar;
	}

}
