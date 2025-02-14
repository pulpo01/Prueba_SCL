package com.tmmas.scl.operations.crm.common.dataTransferObject;

import java.io.Serializable;

public class ProductoContratadoSimpleDTO implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String numAbonado;
	private String numTerminal;
	private String usuario;
	private String codigo;
	private String descripcion;
	private String fechaDesde;
	private String fechaHasta;
	private NumeroSimpleDTO[] numeroSimpleDTOArr;
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
	public String getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(String numAbonado) {
		this.numAbonado = numAbonado;
	}
	public NumeroSimpleDTO[] getNumeroSimpleDTOArr() {
		return numeroSimpleDTOArr;
	}
	public void setNumeroSimpleDTOArr(NumeroSimpleDTO[] numeroSimpleDTOArr) {
		this.numeroSimpleDTOArr = numeroSimpleDTOArr;
	}
	public String getNumTerminal() {
		return numTerminal;
	}
	public void setNumTerminal(String numTerminal) {
		this.numTerminal = numTerminal;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	

	
}
