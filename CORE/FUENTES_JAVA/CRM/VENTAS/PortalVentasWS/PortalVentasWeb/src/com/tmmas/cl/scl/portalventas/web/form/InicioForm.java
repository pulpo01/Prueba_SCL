package com.tmmas.cl.scl.portalventas.web.form;

import org.apache.struts.action.ActionForm;

public class InicioForm extends ActionForm {
	private static final long serialVersionUID = 1L;

	private String codMenuAltaCliente;

	private String codMenuSolicitudVenta;

	private String codMenuConsultaVenta;

	private String codMenuFormalizarVenta;

	private String codMenuAsociacionDocumentos;

	private String codMenuImpresionDocumentos;

	private String codMenuCargosInstalacion;

	private String codMenuEvaluacionSolicitud;

	private String codMisPendientesCredito;

	private String codMenuDesbloqueoTM;

	private String codMenuMisPendientes;

	private String codMenuPasilloLDI;

	private String codMenuOverride;
	
	private String codMenuScoring;
	
	private String codMenuReporteScoring;

	public InicioForm() {
		this.codMenuAltaCliente = "ALTACLIENTE";
		this.codMenuSolicitudVenta = "SOLICVTA";
		this.codMenuConsultaVenta = "CONSULTAVTA";
		this.codMenuFormalizarVenta = "FORMVTA";
		this.codMenuAsociacionDocumentos = "ASOCDOC";
		this.codMenuImpresionDocumentos = "IMPDOC";
		this.codMenuCargosInstalacion = "CARGOSADIC";
		this.codMenuEvaluacionSolicitud = "EVSOLC";
		this.codMisPendientesCredito = "MPDTC";
		this.codMenuDesbloqueoTM = "DESBLOQUEOTM";
		this.codMenuMisPendientes = "MISPDTE";
		this.codMenuPasilloLDI = "PLDI";
		this.codMenuOverride = "MOVR";
		this.codMenuScoring = "SCRN";
		this.codMenuReporteScoring = "RSCR";
	}

	public String getCodMenuAltaCliente() {
		return codMenuAltaCliente;
	}

	public void setCodMenuAltaCliente(String codMenuAltaCliente) {
		this.codMenuAltaCliente = codMenuAltaCliente;
	}

	public String getCodMenuAsociacionDocumentos() {
		return codMenuAsociacionDocumentos;
	}

	public void setCodMenuAsociacionDocumentos(String codMenuAsociacionDocumentos) {
		this.codMenuAsociacionDocumentos = codMenuAsociacionDocumentos;
	}

	public String getCodMenuCargosInstalacion() {
		return codMenuCargosInstalacion;
	}

	public void setCodMenuCargosInstalacion(String codMenuCargosInstalacion) {
		this.codMenuCargosInstalacion = codMenuCargosInstalacion;
	}

	public String getCodMenuConsultaVenta() {
		return codMenuConsultaVenta;
	}

	public void setCodMenuConsultaVenta(String codMenuConsultaVenta) {
		this.codMenuConsultaVenta = codMenuConsultaVenta;
	}

	public String getCodMenuDesbloqueoTM() {
		return codMenuDesbloqueoTM;
	}

	public void setCodMenuDesbloqueoTM(String codMenuDesbloqueoTM) {
		this.codMenuDesbloqueoTM = codMenuDesbloqueoTM;
	}

	public String getCodMenuEvaluacionSolicitud() {
		return codMenuEvaluacionSolicitud;
	}

	public void setCodMenuEvaluacionSolicitud(String codMenuEvaluacionSolicitud) {
		this.codMenuEvaluacionSolicitud = codMenuEvaluacionSolicitud;
	}

	public String getCodMenuFormalizarVenta() {
		return codMenuFormalizarVenta;
	}

	public void setCodMenuFormalizarVenta(String codMenuFormalizarVenta) {
		this.codMenuFormalizarVenta = codMenuFormalizarVenta;
	}

	public String getCodMenuImpresionDocumentos() {
		return codMenuImpresionDocumentos;
	}

	public void setCodMenuImpresionDocumentos(String codMenuImpresionDocumentos) {
		this.codMenuImpresionDocumentos = codMenuImpresionDocumentos;
	}

	public String getCodMenuMisPendientes() {
		return codMenuMisPendientes;
	}

	public void setCodMenuMisPendientes(String codMenuMisPendientes) {
		this.codMenuMisPendientes = codMenuMisPendientes;
	}

	public String getCodMenuSolicitudVenta() {
		return codMenuSolicitudVenta;
	}

	public void setCodMenuSolicitudVenta(String codMenuSolicitudVenta) {
		this.codMenuSolicitudVenta = codMenuSolicitudVenta;
	}

	public String getCodMisPendientesCredito() {
		return codMisPendientesCredito;
	}

	public void setCodMisPendientesCredito(String codMisPendientesCredito) {
		this.codMisPendientesCredito = codMisPendientesCredito;
	}

	public final String getCodMenuPasilloLDI() {
		return codMenuPasilloLDI;
	}

	public final void setCodMenuPasilloLDI(String codMenuPasilloLDI) {
		this.codMenuPasilloLDI = codMenuPasilloLDI;
	}

	public final String getCodMenuOverride() {
		return codMenuOverride;
	}

	public final void setCodMenuOverride(String codMenuOverride) {
		this.codMenuOverride = codMenuOverride;
	}

	public final String getCodMenuScoring() {
		return codMenuScoring;
	}

	public final void setCodMenuScoring(String codMenuScoring) {
		this.codMenuScoring = codMenuScoring;
	}

	public String getCodMenuReporteScoring() {
		return codMenuReporteScoring;
	}

	public void setCodMenuReporteScoring(String codMenuReporteScoring) {
		this.codMenuReporteScoring = codMenuReporteScoring;
	}
	
	

}
