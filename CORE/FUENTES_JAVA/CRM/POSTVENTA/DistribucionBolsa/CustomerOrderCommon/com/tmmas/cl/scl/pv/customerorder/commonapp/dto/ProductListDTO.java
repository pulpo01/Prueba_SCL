/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 17/08/2006     Jimmy Lopez              					Versión Inicial
 */
package com.tmmas.cl.scl.pv.customerorder.commonapp.dto;

import java.io.Serializable;
import java.util.Date;


public class ProductListDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private ProductDTO products[];
	private ProductDTO productsDisabled[];
	private CustomerAccountDTO customer;
	private OrdenServicioDTO serviceOrder;
	private boolean aciclo;
	
	private Date fec_hasta;
	private long cod_cliclo;
	private String fec_tasa;
	
	public long getCod_cliclo() {
		return cod_cliclo;
	}

	public void setCod_cliclo(long cod_cliclo) {
		this.cod_cliclo = cod_cliclo;
	}

	public Date getFec_hasta() {
		return fec_hasta;
	}

	public void setFec_hasta(Date fec_hasta) {
		this.fec_hasta = fec_hasta;
	}

	public String getFec_tasa() {
		return fec_tasa;
	}

	public void setFec_tasa(String fec_tasa) {
		this.fec_tasa = fec_tasa;
	}

	public ProductListDTO()
	{
	}
	
	public ProductListDTO(ListaSSDTO list)
	{
		customer = new CustomerAccountDTO();
		AbonadoDTO abonado = new AbonadoDTO();
		abonado.setNum_abonado(list.getNum_abonado());
		aciclo = list.isAciclo();
		customer.setAbonado(abonado);
		
		customer.setCode(list.getCod_cliente());
		setProducts(list.getProductos());
		setCustomer(customer);	
	}
	

	
	public ProductDTO[] getProducts() {
		return products;
	}
	public void setProducts(ProductDTO[] products) {
		this.products = products;
	}
	public CustomerAccountDTO getCustomer() {
		return customer;
	}
	public void setCustomer(CustomerAccountDTO customer) {
		this.customer = customer;
	}
	
	public ProductDTO[] getProductsDisabled() {
		return productsDisabled;
	}
	public void setProductsDisabled(ProductDTO[] productsDisabled) {
		this.productsDisabled = productsDisabled;
	}
	public OrdenServicioDTO getOrdenServicio() {
		return serviceOrder;
	}
	public void setOrdenServicio(OrdenServicioDTO ordenServicio) {
		this.serviceOrder = ordenServicio;
	}

	public boolean isAciclo() {
		return aciclo;
	}

	public void setAciclo(boolean aciclo) {
		this.aciclo = aciclo;
	}
}
