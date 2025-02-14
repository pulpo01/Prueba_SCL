package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class RegistroCargosDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	private long numeroCargo;
	private long numeroVenta;
	private String codigoCliente;
	private int codigoProducto;
	private String codigoConceptoPrecio;
	private float importeCargo;
	private String codigoMoneda;
	private String codigoPlanComercial;
	private int numeroUnidades;
	private String codigoCicloFacturacion;
	private long numeroTransaccion;
	private int mesGarantia;
	private String codigoConceptoDescuento;
	private float valorDescuento;
	private String tipoDescuento;
	private String indiceCuota;
	private int indiceFacturacion;
	private String numeroPaquete;
	private int indiceSuperTelefono;
	private String nombreUsuario;
	private String codigoTecnologia;
	private long numeroFactura;
	private String indiceManual;
	private String prefijoPlaza;
	private String codigoSecuencia;
	private String numAbonado;
	private String tipoFoliacion;
	private String codigoDocumento;
	private String numeroTerminal;
	private String numeroSerie;
	private String numeroContrato;
	private String numeroImei;
	
	
	public String getNumeroImei() {
		return numeroImei;
	}
	public void setNumeroImei(String numeroImei) {
		this.numeroImei = numeroImei;
	}
	public String getNumeroContrato() {
		return numeroContrato;
	}
	public void setNumeroContrato(String numeroContrato) {
		this.numeroContrato = numeroContrato;
	}
	public String getNumeroSerie() {
		return numeroSerie;
	}
	public void setNumeroSerie(String numeroSerie) {
		this.numeroSerie = numeroSerie;
	}
	public String getNumeroTerminal() {
		return numeroTerminal;
	}
	public void setNumeroTerminal(String numeroTerminal) {
		this.numeroTerminal = numeroTerminal;
	}
	public String getCodigoDocumento() {
		return codigoDocumento;
	}
	public void setCodigoDocumento(String codigoDocumento) {
		this.codigoDocumento = codigoDocumento;
	}
	public String getTipoFoliacion() {
		return tipoFoliacion;
	}
	public void setTipoFoliacion(String tipoFoliacion) {
		this.tipoFoliacion = tipoFoliacion;
	}
	public String getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(String numAbonado) {
		this.numAbonado = numAbonado;
	}
	
	public String getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public String getCodigoConceptoDescuento() {
		return codigoConceptoDescuento;
	}
	public void setCodigoConceptoDescuento(String codigoConceptoDescuento) {
		this.codigoConceptoDescuento = codigoConceptoDescuento;
	}
	public String getCodigoConceptoPrecio() {
		return codigoConceptoPrecio;
	}
	public void setCodigoConceptoPrecio(String codigoConceptoPrecio) {
		this.codigoConceptoPrecio = codigoConceptoPrecio;
	}
	public String getCodigoMoneda() {
		return codigoMoneda;
	}
	public void setCodigoMoneda(String codigoMoneda) {
		this.codigoMoneda = codigoMoneda;
	}
	public String getCodigoPlanComercial() {
		return codigoPlanComercial;
	}
	public void setCodigoPlanComercial(String codigoPlanComercial) {
		this.codigoPlanComercial = codigoPlanComercial;
	}
	public int getCodigoProducto() {
		return codigoProducto;
	}
	public void setCodigoProducto(int codigoProducto) {
		this.codigoProducto = codigoProducto;
	}
	public String getCodigoSecuencia() {
		return codigoSecuencia;
	}
	public void setCodigoSecuencia(String codigoSecuencia) {
		this.codigoSecuencia = codigoSecuencia;
	}
	public String getCodigoTecnologia() {
		return codigoTecnologia;
	}
	public void setCodigoTecnologia(String codigoTecnologia) {
		this.codigoTecnologia = codigoTecnologia;
	}
	public float getImporteCargo() {
		return importeCargo;
	}
	public void setImporteCargo(float importeCargo) {
		this.importeCargo = importeCargo;
	}
	public String getIndiceCuota() {
		return indiceCuota;
	}
	public void setIndiceCuota(String indiceCuota) {
		this.indiceCuota = indiceCuota;
	}
	public int getIndiceFacturacion() {
		return indiceFacturacion;
	}
	public void setIndiceFacturacion(int indiceFacturacion) {
		this.indiceFacturacion = indiceFacturacion;
	}
	public String getIndiceManual() {
		return indiceManual;
	}
	public void setIndiceManual(String indiceManual) {
		this.indiceManual = indiceManual;
	}
	public int getIndiceSuperTelefono() {
		return indiceSuperTelefono;
	}
	public void setIndiceSuperTelefono(int indiceSuperTelefono) {
		this.indiceSuperTelefono = indiceSuperTelefono;
	}
	public int getMesGarantia() {
		return mesGarantia;
	}
	public void setMesGarantia(int mesGarantia) {
		this.mesGarantia = mesGarantia;
	}
	public String getNombreUsuario() {
		return nombreUsuario;
	}
	public void setNombreUsuario(String nombreUsuario) {
		this.nombreUsuario = nombreUsuario;
	}
	public long getNumeroCargo() {
		return numeroCargo;
	}
	public void setNumeroCargo(long numeroCargo) {
		this.numeroCargo = numeroCargo;
	}
	public long getNumeroFactura() {
		return numeroFactura;
	}
	public void setNumeroFactura(long numeroFactura) {
		this.numeroFactura = numeroFactura;
	}
	public String getNumeroPaquete() {
		return numeroPaquete;
	}
	public void setNumeroPaquete(String numeroPaquete) {
		this.numeroPaquete = numeroPaquete;
	}
	public long getNumeroTransaccion() {
		return numeroTransaccion;
	}
	public void setNumeroTransaccion(long numeroTransaccion) {
		this.numeroTransaccion = numeroTransaccion;
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
	public String getPrefijoPlaza() {
		return prefijoPlaza;
	}
	public void setPrefijoPlaza(String prefijoPlaza) {
		this.prefijoPlaza = prefijoPlaza;
	}
	public String getTipoDescuento() {
		return tipoDescuento;
	}
	public void setTipoDescuento(String tipoDescuento) {
		this.tipoDescuento = tipoDescuento;
	}
	public float getValorDescuento() {
		return valorDescuento;
	}
	public void setValorDescuento(float valorDescuento) {
		this.valorDescuento = valorDescuento;
	}
	public String getCodigoCicloFacturacion() {
		return codigoCicloFacturacion;
	}
	public void setCodigoCicloFacturacion(String codigoCicloFacturacion) {
		this.codigoCicloFacturacion = codigoCicloFacturacion;
	}
	
	
}
