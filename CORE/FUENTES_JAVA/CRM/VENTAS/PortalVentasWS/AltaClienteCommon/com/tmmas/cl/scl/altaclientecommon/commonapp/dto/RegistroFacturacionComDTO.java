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
package com.tmmas.cl.scl.altaclientecommon.commonapp.dto;

import java.io.Serializable;

public class RegistroFacturacionComDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private float valorPromedio;
	private int codigoPromedio;
	private int codigoCicloFacturacion;
	private String descripcionCiclo;
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
	
	/*--Nivel de Facturacion--*/
	private String codigoABC;
	private String descripcionABC;
	
	/*--Indicador Facturable Utilizado alta cliente--*/
	private String codigoIndicadorFacturable;
	private String descripcionIndicadorFacturable;
	
	/*--atributos utilizados en caso de uso "Atributos del ciclo de facturacion"--*/
	private String restriccionTipoPlan;
	private boolean esCicloFacturacion;
	
	
	/* --Indice del objeto por defecto */ 
    public static int indiceDefectoCicloFacturacion = -1;
    public static int indiceDefectoIndicadorFacturable = -1;
    
	
	public String getCodigoIndicadorFacturable() {
		return codigoIndicadorFacturable;
	}
	public void setCodigoIndicadorFacturable(String codigoIndicadorFacturable) {
		this.codigoIndicadorFacturable = codigoIndicadorFacturable;
	}
	public String getDescripcionIndicadorFacturable() {
		return descripcionIndicadorFacturable;
	}
	public void setDescripcionIndicadorFacturable(
			String descripcionIndicadorFacturable) {
		this.descripcionIndicadorFacturable = descripcionIndicadorFacturable;
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
	public String getCodigoABC() {
		return codigoABC;
	}
	public void setCodigoABC(String codigoABC) {
		this.codigoABC = codigoABC;
	}
	public String getDescripcionABC() {
		return descripcionABC;
	}
	public void setDescripcionABC(String descripcionABC) {
		this.descripcionABC = descripcionABC;
	}
	public String getDescripcionCiclo() {
		return descripcionCiclo;
	}
	public void setDescripcionCiclo(String descripcionCiclo) {
		this.descripcionCiclo = descripcionCiclo;
	}
	public boolean isEsCicloFacturacion() {
		return esCicloFacturacion;
	}
	public void setEsCicloFacturacion(boolean esCicloFacturacion) {
		this.esCicloFacturacion = esCicloFacturacion;
	}
	public String getRestriccionTipoPlan() {
		return restriccionTipoPlan;
	}
	public void setRestriccionTipoPlan(String restriccionTipoPlan) {
		this.restriccionTipoPlan = restriccionTipoPlan;
	}

}
