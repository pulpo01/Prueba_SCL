/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 12/07/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject;

import java.io.Serializable;

public class BusquedaFormasPagoDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private long numVenta;
	private long codCliente;
	private String paramOrdenCompraValor;
	private String existePlanFreedom;
	private String categoriaTributaria;
	
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public String getCategoriaTributaria() {
		return categoriaTributaria;
	}
	public void setCategoriaTributaria(String categoriaTributaria) {
		this.categoriaTributaria = categoriaTributaria;
	}
	public String getExistePlanFreedom() {
		return existePlanFreedom;
	}
	public void setExistePlanFreedom(String existePlanFreedom) {
		this.existePlanFreedom = existePlanFreedom;
	}
	public String getParamOrdenCompraValor() {
		return paramOrdenCompraValor;
	}
	public void setParamOrdenCompraValor(String paramOrdenCompraValor) {
		this.paramOrdenCompraValor = paramOrdenCompraValor;
	}
	public long getNumVenta() {
		return numVenta;
	}
	public void setNumVenta(long numVenta) {
		this.numVenta = numVenta;
	}
	
	
}

