package com.tmmas.scl.operation.crm.fab.cusintman.servsup.common.dataTransfertObject;

import java.io.Serializable;

public class NumeroAjaxDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String numCelular;
	private String tablaNumeracion;
	private String categoria;
	private String fechaBaja;

	public String getFechaBaja() {
		return fechaBaja;
	}

	public void setFechaBaja(String fechaBaja) {
		this.fechaBaja = fechaBaja;
	}

	public String getCategoria() {
		return categoria;
	}

	public void setCategoria(String categoria) {
		this.categoria = categoria;
	}

	public String getTablaNumeracion() {
		return tablaNumeracion;
	}

	public void setTablaNumeracion(String tablaNumeracion) {
		this.tablaNumeracion = tablaNumeracion;
	}

	public String getNumCelular() {
		return numCelular;
	}

	public void setNumCelular(String numCelular) {
		this.numCelular = numCelular;
	}
}
