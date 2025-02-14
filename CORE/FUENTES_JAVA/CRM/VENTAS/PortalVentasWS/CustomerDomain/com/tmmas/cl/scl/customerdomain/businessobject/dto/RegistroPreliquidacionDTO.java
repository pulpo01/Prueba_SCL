package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.commonbusinessentities.dto.ProgramaDTO;

public class RegistroPreliquidacionDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private long numeroVenta;
	private String codigoCliente;
	private String codigoVendedor;
	private long codigoVendedorRaiz;
	private String estadoVenta;
	private int codigoModalidadVenta;
	private int numeroUnidades;
	private double importeVenta;
	private String fechaVenta;
	private String tipoVenta;
	private ProgramaDTO datosPrograma;

	public ProgramaDTO getDatosPrograma() {
		return datosPrograma;
	}
	public void setDatosPrograma(ProgramaDTO datosPrograma) {
		this.datosPrograma = datosPrograma;
	}
	public String getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public int getCodigoModalidadVenta() {
		return codigoModalidadVenta;
	}
	public void setCodigoModalidadVenta(int codigoModalidadVenta) {
		this.codigoModalidadVenta = codigoModalidadVenta;
	}
	public String getEstadoVenta() {
		return estadoVenta;
	}
	public void setEstadoVenta(String estadoVenta) {
		this.estadoVenta = estadoVenta;
	}
	public String getFechaVenta() {
		return fechaVenta;
	}
	public void setFechaVenta(String fechaVenta) {
		this.fechaVenta = fechaVenta;
	}
	public double getImporteVenta() {
		return importeVenta;
	}
	public void setImporteVenta(double importeVenta) {
		this.importeVenta = importeVenta;
	}
	public int getNumeroUnidades() {
		return numeroUnidades;
	}
	public void setNumeroUnidades(int numeroUnidades) {
		this.numeroUnidades = numeroUnidades;
	}
	public long getNumeroVenta() {
		return numeroVenta;
	}
	public void setNumeroVenta(long numeroVenta) {
		this.numeroVenta = numeroVenta;
	}
	public String getTipoVenta() {
		return tipoVenta;
	}
	public void setTipoVenta(String tipoVenta) {
		this.tipoVenta = tipoVenta;
	}
	public String getCodigoVendedor() {
		return codigoVendedor;
	}
	public void setCodigoVendedor(String codigoVendedor) {
		this.codigoVendedor = codigoVendedor;
	}
	public long getCodigoVendedorRaiz() {
		return codigoVendedorRaiz;
	}
	public void setCodigoVendedorRaiz(long codigoVendedorRaiz) {
		this.codigoVendedorRaiz = codigoVendedorRaiz;
	}
	
}
