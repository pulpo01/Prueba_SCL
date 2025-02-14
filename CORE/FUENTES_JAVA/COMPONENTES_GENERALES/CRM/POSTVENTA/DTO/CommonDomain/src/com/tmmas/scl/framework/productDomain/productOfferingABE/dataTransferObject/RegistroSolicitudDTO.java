/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 12/07/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject;

import java.io.Serializable;

public class RegistroSolicitudDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	private long numeroVenta;
	private long linAutoriza;
	private String codigoOficina;
	private String codigoEstado;
	private String descripcionEstado;
	private long numeroAutorizacion;
	private long codigoVendedor;
	private long numeroUnidades;
	private float precioOrigen;
	private int indicadorTipoVenta;
	private long codigoCliente;
	private int codigoModalidadVenta;
	private String nombreUsuarioVenta;
	private int codigoConcepto;
	private float importeCargo;
	private String codigoMoneda;
	private long numeroAbonado;
	private String numeroSerie;
	private int codigoConceptoDescuento;
	private float valorDescuento;
	private int tipoDescuento;
	private int indicadorModificacion;
	private String codigoOrigen;
	
	public String getDescripcionEstado() {
		return descripcionEstado;
	}
	public void setDescripcionEstado(String descripcionEstado) {
		this.descripcionEstado = descripcionEstado;
	}
	public long getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(long codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public int getCodigoConcepto() {
		return codigoConcepto;
	}
	public void setCodigoConcepto(int codigoConcepto) {
		this.codigoConcepto = codigoConcepto;
	}
	public int getCodigoConceptoDescuento() {
		return codigoConceptoDescuento;
	}
	public void setCodigoConceptoDescuento(int codigoConceptoDescuento) {
		this.codigoConceptoDescuento = codigoConceptoDescuento;
	}
	public String getCodigoEstado() {
		return codigoEstado;
	}
	public void setCodigoEstado(String codigoEstado) {
		this.codigoEstado = codigoEstado;
	}
	public int getCodigoModalidadVenta() {
		return codigoModalidadVenta;
	}
	public void setCodigoModalidadVenta(int codigoModalidadVenta) {
		this.codigoModalidadVenta = codigoModalidadVenta;
	}
	public String getCodigoMoneda() {
		return codigoMoneda;
	}
	public void setCodigoMoneda(String codigoMoneda) {
		this.codigoMoneda = codigoMoneda;
	}
	public String getCodigoOficina() {
		return codigoOficina;
	}
	public void setCodigoOficina(String codigoOficina) {
		this.codigoOficina = codigoOficina;
	}
	public String getCodigoOrigen() {
		return codigoOrigen;
	}
	public void setCodigoOrigen(String codigoOrigen) {
		this.codigoOrigen = codigoOrigen;
	}
	public long getCodigoVendedor() {
		return codigoVendedor;
	}
	public void setCodigoVendedor(long codigoVendedor) {
		this.codigoVendedor = codigoVendedor;
	}
	public float getImporteCargo() {
		return importeCargo;
	}
	public void setImporteCargo(float importeCargo) {
		this.importeCargo = importeCargo;
	}
	public int getIndicadorModificacion() {
		return indicadorModificacion;
	}
	public void setIndicadorModificacion(int indicadorModificacion) {
		this.indicadorModificacion = indicadorModificacion;
	}
	public int getIndicadorTipoVenta() {
		return indicadorTipoVenta;
	}
	public void setIndicadorTipoVenta(int indicadorTipoVenta) {
		this.indicadorTipoVenta = indicadorTipoVenta;
	}
	public long getLinAutoriza() {
		return linAutoriza;
	}
	public void setLinAutoriza(long linAutoriza) {
		this.linAutoriza = linAutoriza;
	}
	public String getNombreUsuarioVenta() {
		return nombreUsuarioVenta;
	}
	public void setNombreUsuarioVenta(String nombreUsuarioVenta) {
		this.nombreUsuarioVenta = nombreUsuarioVenta;
	}
	public long getNumeroAbonado() {
		return numeroAbonado;
	}
	public void setNumeroAbonado(long numeroAbonado) {
		this.numeroAbonado = numeroAbonado;
	}
	public long getNumeroAutorizacion() {
		return numeroAutorizacion;
	}
	public void setNumeroAutorizacion(long numeroAutorizacion) {
		this.numeroAutorizacion = numeroAutorizacion;
	}
	public String getNumeroSerie() {
		return numeroSerie;
	}
	public void setNumeroSerie(String numeroSerie) {
		this.numeroSerie = numeroSerie;
	}
	public long getNumeroUnidades() {
		return numeroUnidades;
	}
	public void setNumeroUnidades(long numeroUnidades) {
		this.numeroUnidades = numeroUnidades;
	}
	public long getNumeroVenta() {
		return numeroVenta;
	}
	public void setNumeroVenta(long numeroVenta) {
		this.numeroVenta = numeroVenta;
	}
	public float getPrecioOrigen() {
		return precioOrigen;
	}
	public void setPrecioOrigen(float precioOrigen) {
		this.precioOrigen = precioOrigen;
	}
	public int getTipoDescuento() {
		return tipoDescuento;
	}
	public void setTipoDescuento(int tipoDescuento) {
		this.tipoDescuento = tipoDescuento;
	}
	public float getValorDescuento() {
		return valorDescuento;
	}
	public void setValorDescuento(float valorDescuento) {
		this.valorDescuento = valorDescuento;
	}
	
}
