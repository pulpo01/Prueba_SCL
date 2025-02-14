package com.tmmas.cl.scl.crmcommon.commonapp.dto;

import java.io.Serializable;

public class ParametrosValidacionDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	private String tipoCliente;
	private String numeroIdentificador;
	private String tipoIdentificador;
	private String codigoCliente;
	private String codigoVendedor;
	private String codigoModalidadVenta;
	private String codigoPlanTarifario;
	private String codigoBodega;
	private String numeroSerie;
	private String numeroSerieSimcard;
	private String numeroSerieTerminal;
	private String numeroCelular;
	private String codigoTecnologia;
	private String codigoProducto;
	private String codigoModulo;
	private String nombreParametro;
	private int largoSerieSimcard;
	private int largoSerieTerminal;
	private String estadoNuevoSimcard;
	private String usoVentaPostpago;
	private String usoVentaHibrido;
	private String nombreUsuario;
	private boolean bDireccionLinea;//Si es verdadero al crear la linea toma la dirección ingresada por el usuario en caso
									//contrario toma la dirección de la oficina del vendedor
	/*-- Reserva de series --*/
	private String estadoSerieTerminal;
	
	
	private String tipoProducto;
	
	//*-- MAYORISTA
	private String codigoCanal;
	
	public String getEstadoSerieTerminal() {
		return estadoSerieTerminal;
	}
	public void setEstadoSerieTerminal(String estadoSerieTerminal) {
		this.estadoSerieTerminal = estadoSerieTerminal;
	}
	public String getUsoVentaHibrido() {
		return usoVentaHibrido;
	}
	public void setUsoVentaHibrido(String usoVentaHibrido) {
		this.usoVentaHibrido = usoVentaHibrido;
	}
	public String getUsoVentaPostpago() {
		return usoVentaPostpago;
	}
	public void setUsoVentaPostpago(String usoVentaPostpago) {
		this.usoVentaPostpago = usoVentaPostpago;
	}
	public String getEstadoNuevoSimcard() {
		return estadoNuevoSimcard;
	}
	public void setEstadoNuevoSimcard(String estadoNuevoSimcard) {
		this.estadoNuevoSimcard = estadoNuevoSimcard;
	}
	public String getCodigoModulo() {
		return codigoModulo;
	}
	public void setCodigoModulo(String codigoModulo) {
		this.codigoModulo = codigoModulo;
	}
	public String getNombreParametro() {
		return nombreParametro;
	}
	public void setNombreParametro(String nombreParametro) {
		this.nombreParametro = nombreParametro;
	}
	public String getCodigoTecnologia() {
		return codigoTecnologia;
	}
	public void setCodigoTecnologia(String codigoTecnologia) {
		this.codigoTecnologia = codigoTecnologia;
	}
	public String getNumeroCelular() {
		return numeroCelular;
	}
	public void setNumeroCelular(String numeroCelular) {
		this.numeroCelular = numeroCelular;
	}
	
	public String getCodigoBodega() {
		return codigoBodega;
	}
	public void setCodigoBodega(String codigoBodega) {
		this.codigoBodega = codigoBodega;
	}
	public String getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public String getCodigoModalidadVenta() {
		return codigoModalidadVenta;
	}
	public void setCodigoModalidadVenta(String codigoModalidadVenta) {
		this.codigoModalidadVenta = codigoModalidadVenta;
	}
	public String getCodigoPlanTarifario() {
		return codigoPlanTarifario;
	}
	public void setCodigoPlanTarifario(String codigoPlanTarifario) {
		this.codigoPlanTarifario = codigoPlanTarifario;
	}
	public String getCodigoVendedor() {
		return codigoVendedor;
	}
	public void setCodigoVendedor(String codigoVendedor) {
		this.codigoVendedor = codigoVendedor;
	}
	public String getNumeroIdentificador() {
		return numeroIdentificador;
	}
	public void setNumeroIdentificador(String numeroIdentificador) {
		this.numeroIdentificador = numeroIdentificador;
	}
	public String getNumeroSerie() {
		return numeroSerie;
	}
	public void setNumeroSerie(String numeroSerie) {
		this.numeroSerie = numeroSerie;
	}
	public String getTipoIdentificador() {
		return tipoIdentificador;
	}
	public void setTipoIdentificador(String tipoIdentificador) {
		this.tipoIdentificador = tipoIdentificador;
	}
	public String getCodigoProducto() {
		return codigoProducto;
	}
	public void setCodigoProducto(String codigoProducto) {
		this.codigoProducto = codigoProducto;
	}
	public String getNumeroSerieTerminal() {
		return numeroSerieTerminal;
	}
	public void setNumeroSerieTerminal(String numeroSerieTerminal) {
		this.numeroSerieTerminal = numeroSerieTerminal;
	}
	
	public String getTipoCliente() {
		return tipoCliente;
	}
	public void setTipoCliente(String tipoCliente) {
		this.tipoCliente = tipoCliente;
	}
	public int getLargoSerieSimcard() {
		return largoSerieSimcard;
	}
	public void setLargoSerieSimcard(int largoSerieSimcard) {
		this.largoSerieSimcard = largoSerieSimcard;
	}
	public int getLargoSerieTerminal() {
		return largoSerieTerminal;
	}
	public void setLargoSerieTerminal(int largoSerieTerminal) {
		this.largoSerieTerminal = largoSerieTerminal;
	}
	public String getNombreUsuario() {
		return nombreUsuario;
	}
	public void setNombreUsuario(String nombreUsuario) {
		this.nombreUsuario = nombreUsuario;
	}
	public boolean isBDireccionLinea() {
		return bDireccionLinea;
	}
	public void setBDireccionLinea(boolean direccionLinea) {
		bDireccionLinea = direccionLinea;
	}
	public String getCodigoCanal() {
		return codigoCanal;
	}
	public void setCodigoCanal(String codigoCanal) {
		this.codigoCanal = codigoCanal;
	}
	public String getTipoProducto() {
		return tipoProducto;
	}
	public void setTipoProducto(String tipoProducto) {
		this.tipoProducto = tipoProducto;
	}
	public String getNumeroSerieSimcard() {
		return numeroSerieSimcard;
	}
	public void setNumeroSerieSimcard(String numeroSerieSimcard) {
		this.numeroSerieSimcard = numeroSerieSimcard;
	}
	
	

}
