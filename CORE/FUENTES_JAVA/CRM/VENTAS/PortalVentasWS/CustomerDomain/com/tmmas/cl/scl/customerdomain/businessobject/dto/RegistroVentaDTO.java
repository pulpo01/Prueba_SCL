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
 * 16/03/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class RegistroVentaDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	private long numeroVenta;
	private long numeroTransaccionVenta;
	private String prefijoMin;
	private long numeroCelular;
	private String codigoSecuencia;
	private String numeroPaquete;
	private boolean existePlanFreedom;
	private String minMDN;

	// Servicios Activaciones WEB - Colombia
	private String Codigo_vendedor_dealer;
	private String Fecha_desde;
	private String Fecha_hasta;
	private int Filtro;

	private String Canal_vendedor;
	private String Codigo_vendedor;
	private String Nombre_vendedor;
	private String Numero_cuenta;
	private String Numero_abonado;
	private String Tipo_identificacion;
	private String Numero_identificacion;
	private String Nombre_cliente;
	private String Apellido1_cliente;
	private String Apellido2_cliente;
	private String Fecha_venta;
	private String Fecha_alta;
	private String Codigo_plantarif;
	private String Descripcion_plantarif;
	private String Tipo_producto;
	private String Numero_factura;
	private Double Valor_factura;
	private String Indicador_factura_impresa;
	
	//*-- Mayorista
	private String numeroSerie;
	private int    tipoProceso;
	private String codigoUso;
	private String descripcionUso;
	private String codigoArticulo;
	private String descripcionArticulo;
			   
	public String getApellido1_cliente() {
		return Apellido1_cliente;
	}

	public void setApellido1_cliente(String apellido1_cliente) {
		Apellido1_cliente = apellido1_cliente;
	}

	public String getApellido2_cliente() {
		return Apellido2_cliente;
	}

	public void setApellido2_cliente(String apellido2_cliente) {
		Apellido2_cliente = apellido2_cliente;
	}

	public String getCanal_vendedor() {
		return Canal_vendedor;
	}

	public void setCanal_vendedor(String canal_vendedor) {
		Canal_vendedor = canal_vendedor;
	}

	public String getCodigo_plantarif() {
		return Codigo_plantarif;
	}

	public void setCodigo_plantarif(String codigo_plantarif) {
		Codigo_plantarif = codigo_plantarif;
	}

	public String getCodigo_vendedor() {
		return Codigo_vendedor;
	}

	public void setCodigo_vendedor(String codigo_vendedor) {
		Codigo_vendedor = codigo_vendedor;
	}

	public String getCodigo_vendedor_dealer() {
		return Codigo_vendedor_dealer;
	}

	public void setCodigo_vendedor_dealer(String codigo_vendedor_dealer) {
		Codigo_vendedor_dealer = codigo_vendedor_dealer;
	}

	public String getDescripcion_plantarif() {
		return Descripcion_plantarif;
	}

	public void setDescripcion_plantarif(String descripcion_plantarif) {
		Descripcion_plantarif = descripcion_plantarif;
	}

	public String getFecha_alta() {
		return Fecha_alta;
	}

	public void setFecha_alta(String fecha_alta) {
		Fecha_alta = fecha_alta;
	}

	public String getFecha_desde() {
		return Fecha_desde;
	}

	public void setFecha_desde(String fecha_desde) {
		Fecha_desde = fecha_desde;
	}

	public String getFecha_hasta() {
		return Fecha_hasta;
	}

	public void setFecha_hasta(String fecha_hasta) {
		Fecha_hasta = fecha_hasta;
	}

	public String getFecha_venta() {
		return Fecha_venta;
	}

	public void setFecha_venta(String fecha_venta) {
		Fecha_venta = fecha_venta;
	}

	public int getFiltro() {
		return Filtro;
	}

	public void setFiltro(int filtro) {
		Filtro = filtro;
	}

	public String getIndicador_factura_impresa() {
		return Indicador_factura_impresa;
	}

	public void setIndicador_factura_impresa(String indicador_factura_impresa) {
		Indicador_factura_impresa = indicador_factura_impresa;
	}

	public String getNombre_cliente() {
		return Nombre_cliente;
	}

	public void setNombre_cliente(String nombre_cliente) {
		Nombre_cliente = nombre_cliente;
	}

	public String getNombre_vendedor() {
		return Nombre_vendedor;
	}

	public void setNombre_vendedor(String nombre_vendedor) {
		Nombre_vendedor = nombre_vendedor;
	}

	public String getNumero_abonado() {
		return Numero_abonado;
	}

	public void setNumero_abonado(String numero_abonado) {
		Numero_abonado = numero_abonado;
	}

	public String getNumero_cuenta() {
		return Numero_cuenta;
	}

	public void setNumero_cuenta(String numero_cuenta) {
		Numero_cuenta = numero_cuenta;
	}

	public String getNumero_factura() {
		return Numero_factura;
	}

	public void setNumero_factura(String numero_factura) {
		Numero_factura = numero_factura;
	}

	public String getNumero_identificacion() {
		return Numero_identificacion;
	}

	public void setNumero_identificacion(String numero_identificacion) {
		Numero_identificacion = numero_identificacion;
	}

	public String getTipo_identificacion() {
		return Tipo_identificacion;
	}

	public void setTipo_identificacion(String tipo_identificacion) {
		Tipo_identificacion = tipo_identificacion;
	}

	public String getTipo_producto() {
		return Tipo_producto;
	}

	public void setTipo_producto(String tipo_producto) {
		Tipo_producto = tipo_producto;
	}

	public Double getValor_factura() {
		return Valor_factura;
	}

	public void setValor_factura(Double valor_factura) {
		Valor_factura = valor_factura;
	}

	public String getMinMDN() {
		return minMDN;
	}

	public void setMinMDN(String minMDN) {
		this.minMDN = minMDN;
	}

	public String getCodigoSecuencia() {
		return codigoSecuencia;
	}

	public void setCodigoSecuencia(String codigoSecuencia) {
		this.codigoSecuencia = codigoSecuencia;
	}

	public long getNumeroCelular() {
		return numeroCelular;
	}

	public void setNumeroCelular(long numeroCelular) {
		this.numeroCelular = numeroCelular;
	}

	public long getNumeroVenta() {
		return numeroVenta;
	}

	public void setNumeroVenta(long numeroVenta) {
		this.numeroVenta = numeroVenta;
	}

	public String getPrefijoMin() {
		return prefijoMin;
	}

	public void setPrefijoMin(String prefijoMin) {
		this.prefijoMin = prefijoMin;
	}

	public long getNumeroTransaccionVenta() {
		return numeroTransaccionVenta;
	}

	public void setNumeroTransaccionVenta(long numeroTransaccionVenta) {
		this.numeroTransaccionVenta = numeroTransaccionVenta;
	}
	
	public void setExistePlanFreedom(boolean existePlanFreedom) {
		this.existePlanFreedom = existePlanFreedom;
	}
	
	public boolean existePlanFreedom() {
		return existePlanFreedom;
	}

	public String getNumeroPaquete() {
		return numeroPaquete;
	}

	public void setNumeroPaquete(String numeroPaquete) {
		this.numeroPaquete = numeroPaquete;
	}

	public String getCodigoArticulo() {
		return codigoArticulo;
	}

	public void setCodigoArticulo(String codigoArticulo) {
		this.codigoArticulo = codigoArticulo;
	}

	public String getCodigoUso() {
		return codigoUso;
	}

	public void setCodigoUso(String codigoUso) {
		this.codigoUso = codigoUso;
	}

	public String getDescripcionArticulo() {
		return descripcionArticulo;
	}

	public void setDescripcionArticulo(String descripcionArticulo) {
		this.descripcionArticulo = descripcionArticulo;
	}

	public String getDescripcionUso() {
		return descripcionUso;
	}

	public void setDescripcionUso(String descripcionUso) {
		this.descripcionUso = descripcionUso;
	}

	public String getNumeroSerie() {
		return numeroSerie;
	}

	public void setNumeroSerie(String numeroSerie) {
		this.numeroSerie = numeroSerie;
	}

	public int getTipoProceso() {
		return tipoProceso;
	}

	public void setTipoProceso(int tipoProceso) {
		this.tipoProceso = tipoProceso;
	}

	public boolean isExistePlanFreedom() {
		return existePlanFreedom;
	}
	
	
}
