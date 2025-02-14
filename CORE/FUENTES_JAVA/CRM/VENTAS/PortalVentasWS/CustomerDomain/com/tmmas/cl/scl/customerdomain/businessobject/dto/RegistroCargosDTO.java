/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 20/04/2007     Héctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class RegistroCargosDTO implements Serializable {
	
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
	private int codigoCicloFacturacion;
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
	private String tipoFoliacion;
	private String codigoDocumento;
	
	private Long num_terminal;
	private Long num_abonado;
	private String num_serie;
	private String codBodega;
	private String codOficina;
	private int tipoServicioCobroAdelantado;

	public int getTipoServicioCobroAdelantado() {
		return tipoServicioCobroAdelantado;
	}
	public void setTipoServicioCobroAdelantado(int tipoServicioCobroAdelantado) {
		this.tipoServicioCobroAdelantado = tipoServicioCobroAdelantado;
	}
	public String getCodOficina() {
		return codOficina;
	}
	public void setCodOficina(String codOficina) {
		this.codOficina = codOficina;
	}
	public String getNum_serie() {
		return num_serie;
	}
	public void setNum_serie(String num_serie) {
		this.num_serie = num_serie;
	}
	public Long getNum_abonado() {
		return num_abonado;
	}
	public void setNum_abonado(Long num_abonado) {
		this.num_abonado = num_abonado;
	}
	public Long getNum_terminal() {
		return num_terminal;
	}
	public void setNum_terminal(Long num_terminal) {
		this.num_terminal = num_terminal;
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
	public String getCodigoSecuencia() {
		return codigoSecuencia;
	}
	public void setCodigoSecuencia(String codigoSecuencia) {
		this.codigoSecuencia = codigoSecuencia;
	}
	public String getPrefijoPlaza() {
		return prefijoPlaza;
	}
	public void setPrefijoPlaza(String prefijoPlaza) {
		this.prefijoPlaza = prefijoPlaza;
	}
	public long getNumeroFactura() {
		return numeroFactura;
	}
	public void setNumeroFactura(long numeroFactura) {
		this.numeroFactura = numeroFactura;
	}
	public int getCodigoCicloFacturacion() {
		return codigoCicloFacturacion;
	}
	public void setCodigoCicloFacturacion(int codigoCicloFacturacion) {
		this.codigoCicloFacturacion = codigoCicloFacturacion;
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
	public long getNumeroVenta() {
		return numeroVenta;
	}
	public void setNumeroVenta(long numeroVenta) {
		this.numeroVenta = numeroVenta;
	}
	public String getIndiceManual() {
		return indiceManual;
	}
	public void setIndiceManual(String indiceManual) {
		this.indiceManual = indiceManual;
	}
	public String getCodBodega() {
		return codBodega;
	}
	public void setCodBodega(String codBodega) {
		this.codBodega = codBodega;
	}
	
		
	
	
	

}
