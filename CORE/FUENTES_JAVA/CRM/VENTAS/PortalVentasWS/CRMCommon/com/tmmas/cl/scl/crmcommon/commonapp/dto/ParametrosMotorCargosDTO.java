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

package com.tmmas.cl.scl.crmcommon.commonapp.dto;

public class ParametrosMotorCargosDTO extends ParametrosProcesadorCargosDTO{

	private static final long serialVersionUID = 1L;
	private String numeroTransaccion;
	private String codigoProducto;
	private String codigoSecuenciaCargo;
	private String codigoTecnologia;
	private String codigoPlanComercialCliente;
	private String codigoSecuenciaPaquete;
	private boolean facturacionaCiclo;
	private String parametroDiaVctoFact;
	private String moduloParametroDiaVctoFact;
	/*utilizados por prebilling*/
	private String nombreSecuenciaProcesoFacturacion;
	private String codigoTipoDocumento;
	private String tipoFoliacionDocumento;
	private String codigoOficina;
	private String nombreParametroDocumentoGuia;
	private String moduloParametroDocumentoGuia;
	private String nombreParametroFacturaGlobal;
	private String moduloParametroFacturaGlobal;
	private String parametroFlagCentroFac;
	private String moduloParametroFlagCentroFac;
	private String codigoTipoMovimiento;
	private String modalidadVenta;
	private String categoriaTributaria;
	
	private int numeroDecimalesBD;
	private int numeroDecimalesPorDesc;
	
	private Long num_terminal;
	private Long num_abonado;	
	
	//Parametros para la insercion de AL_PetiGuias_Abo
	private Long numeroPeticion;
	private Long codigoBodega;	
	private int numOrden;	
	
	
	private String codMonedaLocal;
	
	public String getCodMonedaLocal() {
		return codMonedaLocal;
	}
	public void setCodMonedaLocal(String codMonedaLocal) {
		this.codMonedaLocal = codMonedaLocal;
	}
	public boolean isFacturacionaCiclo() {
		return facturacionaCiclo;
	}
	public void setFacturacionaCiclo(boolean facturacionaCiclo) {
		this.facturacionaCiclo = facturacionaCiclo;
	}
	public String getCategoriaTributaria() {
		return categoriaTributaria;
	}
	public void setCategoriaTributaria(String categoriaTributaria) {
		this.categoriaTributaria = categoriaTributaria;
	}
	public String getModalidadVenta() {
		return modalidadVenta;
	}
	public void setModalidadVenta(String modalidadVenta) {
		this.modalidadVenta = modalidadVenta;
	}
	public String getCodigoTipoMovimiento() {
		return codigoTipoMovimiento;
	}
	public void setCodigoTipoMovimiento(String codigoTipoMovimiento) {
		this.codigoTipoMovimiento = codigoTipoMovimiento;
	}
	public String getCodigoOficina() {
		return codigoOficina;
	}
	public void setCodigoOficina(String codigoOficina) {
		this.codigoOficina = codigoOficina;
	}
	public String getCodigoTipoDocumento() {
		return codigoTipoDocumento;
	}
	public void setCodigoTipoDocumento(String codigoTipoDocumento) {
		this.codigoTipoDocumento = codigoTipoDocumento;
	}
	public String getTipoFoliacionDocumento() {
		return tipoFoliacionDocumento;
	}
	public void setTipoFoliacionDocumento(String tipoFoliacionDocumento) {
		this.tipoFoliacionDocumento = tipoFoliacionDocumento;
	}
	public String getNombreSecuenciaProcesoFacturacion() {
		return nombreSecuenciaProcesoFacturacion;
	}
	public void setNombreSecuenciaProcesoFacturacion(
			String nombreSecuenciaProcesoFacturacion) {
		this.nombreSecuenciaProcesoFacturacion = nombreSecuenciaProcesoFacturacion;
	}
	public String getCodigoSecuenciaPaquete() {
		return codigoSecuenciaPaquete;
	}
	public void setCodigoSecuenciaPaquete(String codigoSecuenciaPaquete) {
		this.codigoSecuenciaPaquete = codigoSecuenciaPaquete;
	}
	public String getCodigoTecnologia() {
		return codigoTecnologia;
	}
	public void setCodigoTecnologia(String codigoTecnologia) {
		this.codigoTecnologia = codigoTecnologia;
	}
	public String getCodigoSecuenciaCargo() {
		return codigoSecuenciaCargo;
	}
	public void setCodigoSecuenciaCargo(String codigoSecuenciaCargo) {
		this.codigoSecuenciaCargo = codigoSecuenciaCargo;
	}
	public String getCodigoProducto() {
		return codigoProducto;
	}
	public void setCodigoProducto(String codigoProducto) {
		this.codigoProducto = codigoProducto;
	}
	public String getNumeroTransaccion() {
		return numeroTransaccion;
	}
	public void setNumeroTransaccion(String numeroTransaccion) {
		this.numeroTransaccion = numeroTransaccion;
	}
	public String getCodigoPlanComercialCliente() {
		return codigoPlanComercialCliente;
	}
	public void setCodigoPlanComercialCliente(String codigoPlanComercialCliente) {
		this.codigoPlanComercialCliente = codigoPlanComercialCliente;
	}
	public String getNombreParametroDocumentoGuia() {
		return nombreParametroDocumentoGuia;
	}
	public void setNombreParametroDocumentoGuia(String nombreParametroDocumentoGuia) {
		this.nombreParametroDocumentoGuia = nombreParametroDocumentoGuia;
	}
	public String getNombreParametroFacturaGlobal() {
		return nombreParametroFacturaGlobal;
	}
	public void setNombreParametroFacturaGlobal(String nombreParametroFacturaGlobal) {
		this.nombreParametroFacturaGlobal = nombreParametroFacturaGlobal;
	}
	public String getParametroFlagCentroFac() {
		return parametroFlagCentroFac;
	}
	public void setParametroFlagCentroFac(String parametroFlagCentroFac) {
		this.parametroFlagCentroFac = parametroFlagCentroFac;
	}
	public String getModuloParametroDocumentoGuia() {
		return moduloParametroDocumentoGuia;
	}
	public void setModuloParametroDocumentoGuia(String moduloParametroDocumentoGuia) {
		this.moduloParametroDocumentoGuia = moduloParametroDocumentoGuia;
	}
	public String getModuloParametroFacturaGlobal() {
		return moduloParametroFacturaGlobal;
	}
	public void setModuloParametroFacturaGlobal(String moduloParametroFacturaGlobal) {
		this.moduloParametroFacturaGlobal = moduloParametroFacturaGlobal;
	}
	public String getModuloParametroFlagCentroFac() {
		return moduloParametroFlagCentroFac;
	}
	public void setModuloParametroFlagCentroFac(String moduloParametroFlagCentroFac) {
		this.moduloParametroFlagCentroFac = moduloParametroFlagCentroFac;
	}
	public String getParametroDiaVctoFact() {
		return parametroDiaVctoFact;
	}
	public void setParametroDiaVctoFact(String parametroDiaVctoFact) {
		this.parametroDiaVctoFact = parametroDiaVctoFact;
	}
	public String getModuloParametroDiaVctoFact() {
		return moduloParametroDiaVctoFact;
	}
	public void setModuloParametroDiaVctoFact(String moduloParametroDiaVctoFact) {
		this.moduloParametroDiaVctoFact = moduloParametroDiaVctoFact;
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
	public int getNumeroDecimalesBD() {
		return numeroDecimalesBD;
	}
	public void setNumeroDecimalesBD(int numeroDecimalesBD) {
		this.numeroDecimalesBD = numeroDecimalesBD;
	}
	public int getNumeroDecimalesPorDesc() {
		return numeroDecimalesPorDesc;
	}
	public void setNumeroDecimalesPorDesc(int numeroDecimalesPorDesc) {
		this.numeroDecimalesPorDesc = numeroDecimalesPorDesc;
	}
	public Long getCodigoBodega() {
		return codigoBodega;
	}
	public void setCodigoBodega(Long codigoBodega) {
		this.codigoBodega = codigoBodega;
	}
	public Long getNumeroPeticion() {
		return numeroPeticion;
	}
	public void setNumeroPeticion(Long numeroPeticion) {
		this.numeroPeticion = numeroPeticion;
	}
	public int getNumOrden() {
		return numOrden;
	}
	public void setNumOrden(int numOrden) {
		this.numOrden = numOrden;
	}

}
