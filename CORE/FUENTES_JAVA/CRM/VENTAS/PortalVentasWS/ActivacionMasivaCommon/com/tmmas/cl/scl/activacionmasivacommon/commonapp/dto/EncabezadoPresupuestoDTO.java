package com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.commonbusinessentities.dto.CargoXMLDTO;


public class EncabezadoPresupuestoDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private int codigoProducto;
	private String descripcionProducto;
	private String codigoTipoContrato;
	private String descripcionTipoContrato;
	private String codigoModalidadVenta;
	private String descripcionModalidadVenta;
	private String codigoVendedor;
	private String codigoDealer;
	private String nombreVendedor;
	private String codigoCuenta;
	private String descripcionCuenta;
	private String codigoCliente;
	private String nombreCliente;
	private String codigoTipoDocumento;
	private String descripcionTipoDocumento;
	private long numeroVenta;
	private String numeroProcesoFacturacion;
	private CargoXMLDTO[] arregloCargos;
	private DetallePresupuestoDTO[] detalle;
	public String getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public int getCodigoProducto() {
		return codigoProducto;
	}
	public void setCodigoProducto(int codigoProducto) {
		this.codigoProducto = codigoProducto;
	}
	public String getCodigoVendedor() {
		return codigoVendedor;
	}
	public void setCodigoVendedor(String codigoVendedor) {
		this.codigoVendedor = codigoVendedor;
	}
	public String getCodigoCuenta() {
		return codigoCuenta;
	}
	public void setCodigoCuenta(String codigoCuenta) {
		this.codigoCuenta = codigoCuenta;
	}
	public String getDescripcionModalidadVenta() {
		return descripcionModalidadVenta;
	}
	public void setDescripcionModalidadVenta(String descripcionModalidadVenta) {
		this.descripcionModalidadVenta = descripcionModalidadVenta;
	}
	public String getDescripcionProducto() {
		return descripcionProducto;
	}
	public void setDescripcionProducto(String descripcionProducto) {
		this.descripcionProducto = descripcionProducto;
	}
	public String getDescripcionTipoDocumento() {
		return descripcionTipoDocumento;
	}
	public void setDescripcionTipoDocumento(String descripcionTipoDocumento) {
		this.descripcionTipoDocumento = descripcionTipoDocumento;
	}

	public void setNombreVendedor(String nombreVendedor) {
		this.nombreVendedor = nombreVendedor;
	}
	public String getNombreCliente() {
		return nombreCliente;
	}
	public void setNombreCliente(String nombreCliente) {
		this.nombreCliente = nombreCliente;
	}
	public String getDescripcionTipoContrato() {
		return descripcionTipoContrato;
	}
	public void setDescripcionTipoContrato(String descripcionTipoContrato) {
		this.descripcionTipoContrato = descripcionTipoContrato;
	}
	public DetallePresupuestoDTO[] getDetalle() {
		return detalle;
	}
	public void setDetalle(DetallePresupuestoDTO[] detalle) {
		this.detalle = detalle;
	}
	public String getNombreVendedor() {
		return nombreVendedor;
	}

	public CargoXMLDTO[] getArregloCargos() {
		return arregloCargos;
	}
	public void setArregloCargos(CargoXMLDTO[] arregloCargos) {
		this.arregloCargos = arregloCargos;
	}
	public String getCodigoTipoContrato() {
		return codigoTipoContrato;
	}
	public void setCodigoTipoContrato(String codigoTipoContrato) {
		this.codigoTipoContrato = codigoTipoContrato;
	}
	public String getCodigoModalidadVenta() {
		return codigoModalidadVenta;
	}
	public void setCodigoModalidadVenta(String codigoModalidadVenta) {
		this.codigoModalidadVenta = codigoModalidadVenta;
	}
	public String getCodigoTipoDocumento() {
		return codigoTipoDocumento;
	}
	public void setCodigoTipoDocumento(String codigoTipoDocumento) {
		this.codigoTipoDocumento = codigoTipoDocumento;
	}
	public String getNumeroProcesoFacturacion() {
		return numeroProcesoFacturacion;
	}
	public void setNumeroProcesoFacturacion(String numeroProcesoFacturacion) {
		this.numeroProcesoFacturacion = numeroProcesoFacturacion;
	}
	public long getNumeroVenta() {
		return numeroVenta;
	}
	public void setNumeroVenta(long numeroVenta) {
		this.numeroVenta = numeroVenta;
	}
	public String getDescripcionCuenta() {
		return descripcionCuenta;
	}
	public void setDescripcionCuenta(String descripcionCuenta) {
		this.descripcionCuenta = descripcionCuenta;
	}
	public String getCodigoDealer() {
		return codigoDealer;
	}
	public void setCodigoDealer(String codigoDealer) {
		this.codigoDealer = codigoDealer;
	}

}
