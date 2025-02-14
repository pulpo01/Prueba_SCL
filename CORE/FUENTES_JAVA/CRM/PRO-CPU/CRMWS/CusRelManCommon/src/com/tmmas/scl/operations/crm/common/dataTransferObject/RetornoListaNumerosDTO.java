package com.tmmas.scl.operations.crm.common.dataTransferObject;

import java.io.Serializable;

import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroListDTO;

public class RetornoListaNumerosDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private NumeroCategDTO[] listaNumeros;
	private String codigo;
	private String descripcion;
	private boolean resultado;
	
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public boolean isResultado() {
		return resultado;
	}
	public void setResultado(boolean resultado) {
		this.resultado = resultado;
	}
	public NumeroCategDTO[] getListaNumeros() {
		return listaNumeros;
	}
	public void setListaNumeros(NumeroCategDTO[] listaNumeros) {
		this.listaNumeros = listaNumeros;
	}

}
