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
 * 12/04/2007     H&eacute;ctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class RegistroFacturacionDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private float valorPromedio;
	private int codigoPromedio;
	private int codigoCicloFacturacion;
	private String secuenciaTransacabo;
	private String actuacionPrebilling;
	private String productoGeneral;
	private String codigoCliente;
	private String numeroVenta;
	private String numeroTransaccionVenta;
	private String numeroProcesoFacturacion;
	private String modoGeneracion;
	private String categoriaTributaria;
	private String codigoSecuencia;
	/*--Obtiene modo Generacion--*/
	private String valorParametroFacturaGlobal;
	private String valorParametroDocumentoGuia;
	private String valorParametroFlagCentroFact;
	private String valorParametroConsumeFolio;
	private String codigoOficina;
	private String codigoTipoDocumento;
	private String codigoTipoFoliacion;
	private String modalidadVenta;
	private String codigoTipoMovimiento;
	
	/*--Actualiza Facturación--*/
	private String estadoProceso;
	private String estadoDocumento;
	private String numeroFolio;
	private String prefijoPlaza;
	private String fechaVencimiento;
	private String nombreUsuarioEliminacion;
	private String causalEliminacion;
	
	/*-- Ciclos Facturacion --*/
	private int cicloPrePago;
	private String descripcionCiclo;

	private String agno; 
	private String codigoCiclo; 
	private boolean cicloFreedom;
	private String fechaEmision;
	private String fechaCaducida; 
	private String fechaProxvenc;
	private String fechaDesdellam; 
	private String fechaHastallam; 
	private String diaPeriodo; 
	private String fechaDesdecfijos; 
	private String fechaHastacfijos;
	private String fechaDesdeocargos; 
	private String fechaHastaocargos; 
	private String fechaDesderoa; 
	private String fechaHastaroa; 
	private String indicadorFacturacion;
	private String direccionLogs; 
	private String direccionSpool;
	private String descripcionLeyen1; 
	private String descripcionLeyen2; 
	private String descripcionLeyen3;
	private String descripcionLeyen4;
	private String descripcionLeyen5; 
	private String indicadorTasador;
	private String tipoFoliacion;
	private String formatoFecha;
	private int diasProrrateo;
	private int diasDiferencia;
	private float importePlan;
	private float importeTotal;
	
	/*-- Codigo Despacho --*/
	private String codigoDespacho;
	
	public String getCodigoDespacho() {
		return codigoDespacho;
	}
	public void setCodigoDespacho(String codigoDespacho) {
		this.codigoDespacho = codigoDespacho;
	}
	public String getDescripcionCiclo() {
		return descripcionCiclo;
	}
	public void setDescripcionCiclo(String descripcionCiclo) {
		this.descripcionCiclo = descripcionCiclo;
	}
	public int getCicloPrePago() {
		return cicloPrePago;
	}
	public void setCicloPrePago(int cicloPrePago) {
		this.cicloPrePago = cicloPrePago;
	}
	public String getCausalEliminacion() {
		return causalEliminacion;
	}
	public void setCausalEliminacion(String causalEliminacion) {
		this.causalEliminacion = causalEliminacion;
	}
	public String getEstadoDocumento() {
		return estadoDocumento;
	}
	public void setEstadoDocumento(String estadoDocumento) {
		this.estadoDocumento = estadoDocumento;
	}
	public String getEstadoProceso() {
		return estadoProceso;
	}
	public void setEstadoProceso(String estadoProceso) {
		this.estadoProceso = estadoProceso;
	}
	public String getFechaVencimiento() {
		return fechaVencimiento;
	}
	public void setFechaVencimiento(String fechaVencimiento) {
		this.fechaVencimiento = fechaVencimiento;
	}
	public String getNombreUsuarioEliminacion() {
		return nombreUsuarioEliminacion;
	}
	public void setNombreUsuarioEliminacion(String nombreUsuarioEliminacion) {
		this.nombreUsuarioEliminacion = nombreUsuarioEliminacion;
	}
	public String getNumeroFolio() {
		return numeroFolio;
	}
	public void setNumeroFolio(String numeroFolio) {
		this.numeroFolio = numeroFolio;
	}
	public String getPrefijoPlaza() {
		return prefijoPlaza;
	}
	public void setPrefijoPlaza(String prefijoPlaza) {
		this.prefijoPlaza = prefijoPlaza;
	}
	public String getCodigoTipoMovimiento() {
		return codigoTipoMovimiento;
	}
	public void setCodigoTipoMovimiento(String codigoTipoMovimiento) {
		this.codigoTipoMovimiento = codigoTipoMovimiento;
	}
	public String getCodigoTipoFoliacion() {
		return codigoTipoFoliacion;
	}
	public void setCodigoTipoFoliacion(String codigoTipoFoliacion) {
		this.codigoTipoFoliacion = codigoTipoFoliacion;
	}
	public String getModalidadVenta() {
		return modalidadVenta;
	}
	public void setModalidadVenta(String modalidadVenta) {
		this.modalidadVenta = modalidadVenta;
	}
	public String getCodigoTipoDocumento() {
		return codigoTipoDocumento;
	}
	public void setCodigoTipoDocumento(String codigoTipoDocumento) {
		this.codigoTipoDocumento = codigoTipoDocumento;
	}
	public String getCodigoOficina() {
		return codigoOficina;
	}
	public void setCodigoOficina(String codigoOficina) {
		this.codigoOficina = codigoOficina;
	}
	public String getCodigoSecuencia() {
		return codigoSecuencia;
	}
	public void setCodigoSecuencia(String codigoSecuencia) {
		this.codigoSecuencia = codigoSecuencia;
	}
	public int getCodigoCicloFacturacion() {
		return codigoCicloFacturacion;
	}
	public void setCodigoCicloFacturacion(int codigoCicloFacturacion) {
		this.codigoCicloFacturacion = codigoCicloFacturacion;
	}
	public int getCodigoPromedio() {
		return codigoPromedio;
	}
	public void setCodigoPromedio(int codigoPromedio) {
		this.codigoPromedio = codigoPromedio;
	}
	public float getValorPromedio() {
		return valorPromedio;
	}
	public void setValorPromedio(float valorPromedio) {
		this.valorPromedio = valorPromedio;
	}
	public String getActuacionPrebilling() {
		return actuacionPrebilling;
	}
	public void setActuacionPrebilling(String actuacionPrebilling) {
		this.actuacionPrebilling = actuacionPrebilling;
	}
	public String getCategoriaTributaria() {
		return categoriaTributaria;
	}
	public void setCategoriaTributaria(String categoriaTributaria) {
		this.categoriaTributaria = categoriaTributaria;
	}
	public String getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public String getModoGeneracion() {
		return modoGeneracion;
	}
	public void setModoGeneracion(String modoGeneracion) {
		this.modoGeneracion = modoGeneracion;
	}
	public String getNumeroProcesoFacturacion() {
		return numeroProcesoFacturacion;
	}
	public void setNumeroProcesoFacturacion(String numeroProcesoFacturacion) {
		this.numeroProcesoFacturacion = numeroProcesoFacturacion;
	}
	public String getNumeroTransaccionVenta() {
		return numeroTransaccionVenta;
	}
	public void setNumeroTransaccionVenta(String numeroTransaccionVenta) {
		this.numeroTransaccionVenta = numeroTransaccionVenta;
	}
	public String getNumeroVenta() {
		return numeroVenta;
	}
	public void setNumeroVenta(String numeroVenta) {
		this.numeroVenta = numeroVenta;
	}
	public String getProductoGeneral() {
		return productoGeneral;
	}
	public void setProductoGeneral(String productoGeneral) {
		this.productoGeneral = productoGeneral;
	}
	public String getSecuenciaTransacabo() {
		return secuenciaTransacabo;
	}
	public void setSecuenciaTransacabo(String secuenciaTransacabo) {
		this.secuenciaTransacabo = secuenciaTransacabo;
	}
	public String getValorParametroDocumentoGuia() {
		return valorParametroDocumentoGuia;
	}
	public void setValorParametroDocumentoGuia(String valorParametroDocumentoGuia) {
		this.valorParametroDocumentoGuia = valorParametroDocumentoGuia;
	}
	public String getValorParametroFacturaGlobal() {
		return valorParametroFacturaGlobal;
	}
	public void setValorParametroFacturaGlobal(String valorParametroFacturaGlobal) {
		this.valorParametroFacturaGlobal = valorParametroFacturaGlobal;
	}
	public String getValorParametroFlagCentroFact() {
		return valorParametroFlagCentroFact;
	}
	public void setValorParametroFlagCentroFact(String valorParametroFlagCentroFact) {
		this.valorParametroFlagCentroFact = valorParametroFlagCentroFact;
	}
	public String getValorParametroConsumeFolio() {
		return valorParametroConsumeFolio;
	}
	public void setValorParametroConsumeFolio(String valorParametroConsumeFolio) {
		this.valorParametroConsumeFolio = valorParametroConsumeFolio;
	}
	public String getAgno() {
		return agno;
	}
	public void setAgno(String agno) {
		this.agno = agno;
	}
	public String getCodigoCiclo() {
		return codigoCiclo;
	}
	public void setCodigoCiclo(String codigoCiclo) {
		this.codigoCiclo = codigoCiclo;
	}
	public String getDescripcionLeyen1() {
		return descripcionLeyen1;
	}
	public void setDescripcionLeyen1(String descripcionLeyen1) {
		this.descripcionLeyen1 = descripcionLeyen1;
	}
	public String getDescripcionLeyen2() {
		return descripcionLeyen2;
	}
	public void setDescripcionLeyen2(String descripcionLeyen2) {
		this.descripcionLeyen2 = descripcionLeyen2;
	}
	public String getDescripcionLeyen3() {
		return descripcionLeyen3;
	}
	public void setDescripcionLeyen3(String descripcionLeyen3) {
		this.descripcionLeyen3 = descripcionLeyen3;
	}
	public String getDescripcionLeyen4() {
		return descripcionLeyen4;
	}
	public void setDescripcionLeyen4(String descripcionLeyen4) {
		this.descripcionLeyen4 = descripcionLeyen4;
	}
	public String getDescripcionLeyen5() {
		return descripcionLeyen5;
	}
	public void setDescripcionLeyen5(String descripcionLeyen5) {
		this.descripcionLeyen5 = descripcionLeyen5;
	}
	public String getDiaPeriodo() {
		return diaPeriodo;
	}
	public void setDiaPeriodo(String diaPeriodo) {
		this.diaPeriodo = diaPeriodo;
	}
	public String getDireccionLogs() {
		return direccionLogs;
	}
	public void setDireccionLogs(String direccionLogs) {
		this.direccionLogs = direccionLogs;
	}
	public String getDireccionSpool() {
		return direccionSpool;
	}
	public void setDireccionSpool(String direccionSpool) {
		this.direccionSpool = direccionSpool;
	}
	public String getFechaCaducida() {
		return fechaCaducida;
	}
	public void setFechaCaducida(String fechaCaducida) {
		this.fechaCaducida = fechaCaducida;
	}
	public String getFechaDesdecfijos() {
		return fechaDesdecfijos;
	}
	public void setFechaDesdecfijos(String fechaDesdecfijos) {
		this.fechaDesdecfijos = fechaDesdecfijos;
	}
	public String getFechaDesdellam() {
		return fechaDesdellam;
	}
	public void setFechaDesdellam(String fechaDesdellam) {
		this.fechaDesdellam = fechaDesdellam;
	}
	public String getFechaDesdeocargos() {
		return fechaDesdeocargos;
	}
	public void setFechaDesdeocargos(String fechaDesdeocargos) {
		this.fechaDesdeocargos = fechaDesdeocargos;
	}
	public String getFechaDesderoa() {
		return fechaDesderoa;
	}
	public void setFechaDesderoa(String fechaDesderoa) {
		this.fechaDesderoa = fechaDesderoa;
	}
	public String getFechaEmision() {
		return fechaEmision;
	}
	public void setFechaEmision(String fechaEmision) {
		this.fechaEmision = fechaEmision;
	}
	public String getFechaHastacfijos() {
		return fechaHastacfijos;
	}
	public void setFechaHastacfijos(String fechaHastacfijos) {
		this.fechaHastacfijos = fechaHastacfijos;
	}
	public String getFechaHastallam() {
		return fechaHastallam;
	}
	public void setFechaHastallam(String fechaHastallam) {
		this.fechaHastallam = fechaHastallam;
	}
	public String getFechaHastaocargos() {
		return fechaHastaocargos;
	}
	public void setFechaHastaocargos(String fechaHastaocargos) {
		this.fechaHastaocargos = fechaHastaocargos;
	}
	public String getFechaHastaroa() {
		return fechaHastaroa;
	}
	public void setFechaHastaroa(String fechaHastaroa) {
		this.fechaHastaroa = fechaHastaroa;
	}
	public String getFechaProxvenc() {
		return fechaProxvenc;
	}
	public void setFechaProxvenc(String fechaProxvenc) {
		this.fechaProxvenc = fechaProxvenc;
	}
	public String getIndicadorFacturacion() {
		return indicadorFacturacion;
	}
	public void setIndicadorFacturacion(String indicadorFacturacion) {
		this.indicadorFacturacion = indicadorFacturacion;
	}
	public String getIndicadorTasador() {
		return indicadorTasador;
	}
	public void setIndicadorTasador(String indicadorTasador) {
		this.indicadorTasador = indicadorTasador;
	}
	public boolean isCicloFreedom() {
		return cicloFreedom;
	}
	public void setCicloFreedom(boolean cicloFreedom) {
		this.cicloFreedom = cicloFreedom;
	}
	public String getTipoFoliacion() {
		return tipoFoliacion;
	}
	public void setTipoFoliacion(String tipoFoliacion) {
		this.tipoFoliacion = tipoFoliacion;
	}
	public String getFormatoFecha() {
		return formatoFecha;
	}
	public void setFormatoFecha(String formatoFecha) {
		this.formatoFecha = formatoFecha;
	}
	public int getDiasDiferencia() {
		return diasDiferencia;
	}
	public void setDiasDiferencia(int diasDiferencia) {
		this.diasDiferencia = diasDiferencia;
	}
	public int getDiasProrrateo() {
		return diasProrrateo;
	}
	public void setDiasProrrateo(int diasProrrateo) {
		this.diasProrrateo = diasProrrateo;
	}
	public float getImportePlan() {
		return importePlan;
	}
	public void setImportePlan(float importePlan) {
		this.importePlan = importePlan;
	}
	public float getImporteTotal() {
		return importeTotal;
	}
	public void setImporteTotal(float importeTotal) {
		this.importeTotal = importeTotal;
	}

}
