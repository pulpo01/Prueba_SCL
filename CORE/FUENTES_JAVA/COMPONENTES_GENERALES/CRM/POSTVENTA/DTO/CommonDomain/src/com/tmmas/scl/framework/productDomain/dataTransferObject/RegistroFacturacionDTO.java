package com.tmmas.scl.framework.productDomain.dataTransferObject;


import java.io.Serializable;

public class RegistroFacturacionDTO implements Serializable{
	
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
	private String tipoFoliacion;
	
	public String getTipoFoliacion() {
		return tipoFoliacion;
	}
	public void setTipoFoliacion(String tipoFoliacion) {
		this.tipoFoliacion = tipoFoliacion;
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
	public String getCausalEliminacion() {
		return causalEliminacion;
	}
	public void setCausalEliminacion(String causalEliminacion) {
		this.causalEliminacion = causalEliminacion;
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
	public String getCodigoOficina() {
		return codigoOficina;
	}
	public void setCodigoOficina(String codigoOficina) {
		this.codigoOficina = codigoOficina;
	}
	public int getCodigoPromedio() {
		return codigoPromedio;
	}
	public void setCodigoPromedio(int codigoPromedio) {
		this.codigoPromedio = codigoPromedio;
	}
	public String getCodigoSecuencia() {
		return codigoSecuencia;
	}
	public void setCodigoSecuencia(String codigoSecuencia) {
		this.codigoSecuencia = codigoSecuencia;
	}
	public String getCodigoTipoDocumento() {
		return codigoTipoDocumento;
	}
	public void setCodigoTipoDocumento(String codigoTipoDocumento) {
		this.codigoTipoDocumento = codigoTipoDocumento;
	}
	public String getCodigoTipoFoliacion() {
		return codigoTipoFoliacion;
	}
	public void setCodigoTipoFoliacion(String codigoTipoFoliacion) {
		this.codigoTipoFoliacion = codigoTipoFoliacion;
	}
	public String getCodigoTipoMovimiento() {
		return codigoTipoMovimiento;
	}
	public void setCodigoTipoMovimiento(String codigoTipoMovimiento) {
		this.codigoTipoMovimiento = codigoTipoMovimiento;
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
	public String getModalidadVenta() {
		return modalidadVenta;
	}
	public void setModalidadVenta(String modalidadVenta) {
		this.modalidadVenta = modalidadVenta;
	}
	public String getModoGeneracion() {
		return modoGeneracion;
	}
	public void setModoGeneracion(String modoGeneracion) {
		this.modoGeneracion = modoGeneracion;
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
	public String getPrefijoPlaza() {
		return prefijoPlaza;
	}
	public void setPrefijoPlaza(String prefijoPlaza) {
		this.prefijoPlaza = prefijoPlaza;
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
	public String getValorParametroConsumeFolio() {
		return valorParametroConsumeFolio;
	}
	public void setValorParametroConsumeFolio(String valorParametroConsumeFolio) {
		this.valorParametroConsumeFolio = valorParametroConsumeFolio;
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
	public float getValorPromedio() {
		return valorPromedio;
	}
	public void setValorPromedio(float valorPromedio) {
		this.valorPromedio = valorPromedio;
	}
	
	
	
	
}
