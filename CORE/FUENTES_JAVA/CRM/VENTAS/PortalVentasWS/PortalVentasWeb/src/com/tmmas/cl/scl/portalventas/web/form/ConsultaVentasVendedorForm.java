package com.tmmas.cl.scl.portalventas.web.form;

import org.apache.struts.action.ActionForm;

import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.OficinaComDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosGeneralesDTO;

public class ConsultaVentasVendedorForm extends ActionForm {
	private static final long serialVersionUID = 1L;
	
	private String numVenta;
	private String codEstadoVenta;
	private DatosGeneralesDTO[] arrayEstadosVenta;
	private String codOficina;
	private OficinaComDTO[] arrayOficina;	
	private String codVendedor;
	private String codVendedorSeleccionado;
	private String fechaDesde;
	private String fechaHasta;
	private String codCliente;
	private String codTipoCliente;
	private String glsTipoCliente;
	private String moduloOrigenVenta;
	private String numVentaSel;
	private String codModuloConsultaPreVenta;
	private String codModuloConsultaVenta;
	private String codModuloConsultaDesbloqueo;
	private String codModuloConsultaCargosInst;
	private String codModuloConsultaDocumentos;
	private String codModuloEvaluacion;
	private String codModuloMisPendientesEval;
	private String codModuloMisPendientesInst;
	private String codModuloOverrideSolicitud;
	
	private String glsModulo;
	private String indOrigenConsultaVTA;/*se usa como filtro para query de ventas*/
	private String numAbonadoSel;
	private String codTipoDocumento;
	protected String codMoneda;
	protected String concepFactCargIns;
	protected String desConcepCargoIns;
	
	/*-- para la solicitud de la mac address --*/
	private int indMacAddress;	
	private String wimaxMacAddress;	
	
	protected String importeCargosInst;
	private String detalleInstalacionAbonado;
	
	private boolean activarOverrideFormalizacion;
	
	//Inicio P-CSR-11002 JLGN 12-05-2011
	private String defOverride; //--> override por defecto
	
	public String getDefOverride() {
		return defOverride;
	}
	public void setDefOverride(String defOverride) {
		this.defOverride = defOverride;
	}
	//Fin P-CSR-11002 JLGN 12-05-2011
	
	//	private String numCelular;
//	
//	public String getNumCelular() {
//		return numCelular;
//	}
//	public void setNumCelular(String numCelular) {
//		this.numCelular = numCelular;
//	}
	public final boolean isActivarOverrideFormalizacion() {
		return activarOverrideFormalizacion;
	}
	public final void setActivarOverrideFormalizacion(boolean activarOverrideFormalizacion) {
		this.activarOverrideFormalizacion = activarOverrideFormalizacion;
	}
	public String getDetalleInstalacionAbonado() {
		return detalleInstalacionAbonado;
	}
	public void setDetalleInstalacionAbonado(String detalleInstalacionAbonado) {
		this.detalleInstalacionAbonado = detalleInstalacionAbonado;
	}
	public String getNumAbonadoSel() {
		return numAbonadoSel;
	}
	public void setNumAbonadoSel(String numAbonadoSel) {
		this.numAbonadoSel = numAbonadoSel;
	}
	public String getIndOrigenConsultaVTA() {
		return indOrigenConsultaVTA;
	}
	public void setIndOrigenConsultaVTA(String indOrigenConsultaVTA) {
		this.indOrigenConsultaVTA = indOrigenConsultaVTA;
	}
	public String getCodModuloConsultaPreVenta() {
		return codModuloConsultaPreVenta;
	}
	public void setCodModuloConsultaPreVenta(String codModuloConsultaPreVenta) {
		this.codModuloConsultaPreVenta = codModuloConsultaPreVenta;
	}
	public String getCodModuloConsultaVenta() {
		return codModuloConsultaVenta;
	}
	public void setCodModuloConsultaVenta(String codModuloConsultaVenta) {
		this.codModuloConsultaVenta = codModuloConsultaVenta;
	}
	public String getNumVentaSel() {
		return numVentaSel;
	}
	public void setNumVentaSel(String numVentaSel) {
		this.numVentaSel = numVentaSel;
	}

	public String getModuloOrigenVenta() {
		return moduloOrigenVenta;
	}
	public void setModuloOrigenVenta(String moduloOrigenVenta) {
		this.moduloOrigenVenta = moduloOrigenVenta;
	}
	public OficinaComDTO[] getArrayOficina() {
		return arrayOficina;
	}
	public void setArrayOficina(OficinaComDTO[] arrayOficina) {
		this.arrayOficina = arrayOficina;
	}
	public String getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodOficina() {
		return codOficina;
	}
	public void setCodOficina(String codOficina) {
		this.codOficina = codOficina;
	}
	public String getCodTipoCliente() {
		return codTipoCliente;
	}
	public void setCodTipoCliente(String codTipoCliente) {
		this.codTipoCliente = codTipoCliente;
	}
	public String getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(String codVendedor) {
		this.codVendedor = codVendedor;
	}
	public String getFechaDesde() {
		return fechaDesde;
	}
	public void setFechaDesde(String fechaDesde) {
		this.fechaDesde = fechaDesde;
	}
	public String getFechaHasta() {
		return fechaHasta;
	}
	public void setFechaHasta(String fechaHasta) {
		this.fechaHasta = fechaHasta;
	}
	public String getGlsTipoCliente() {
		return glsTipoCliente;
	}
	public void setGlsTipoCliente(String glsTipoCliente) {
		this.glsTipoCliente = glsTipoCliente;
	}
	public String getCodVendedorSeleccionado() {
		return codVendedorSeleccionado;
	}
	public void setCodVendedorSeleccionado(String codVendedorSeleccionado) {
		this.codVendedorSeleccionado = codVendedorSeleccionado;
	}
	public String getNumVenta() {
		return numVenta;
	}
	public void setNumVenta(String numVenta) {
		this.numVenta = numVenta;
	}
	public DatosGeneralesDTO[] getArrayEstadosVenta() {
		return arrayEstadosVenta;
	}
	public void setArrayEstadosVenta(DatosGeneralesDTO[] arrayEstadosVenta) {
		this.arrayEstadosVenta = arrayEstadosVenta;
	}
	public String getCodEstadoVenta() {
		return codEstadoVenta;
	}
	public void setCodEstadoVenta(String codEstadoVenta) {
		this.codEstadoVenta = codEstadoVenta;
	}
	public String getCodModuloConsultaCargosInst() {
		return codModuloConsultaCargosInst;
	}
	public void setCodModuloConsultaCargosInst(String codModuloConsultaCargosInst) {
		this.codModuloConsultaCargosInst = codModuloConsultaCargosInst;
	}
	public String getCodModuloConsultaDesbloqueo() {
		return codModuloConsultaDesbloqueo;
	}
	public void setCodModuloConsultaDesbloqueo(String codModuloConsultaDesbloqueo) {
		this.codModuloConsultaDesbloqueo = codModuloConsultaDesbloqueo;
	}
	public String getGlsModulo() {
		return glsModulo;
	}
	public void setGlsModulo(String glsModulo) {
		this.glsModulo = glsModulo;
	}
	public String getImporteCargosInst() {
		return importeCargosInst;
	}
	public void setImporteCargosInst(String importeCargosInst) {
		this.importeCargosInst = importeCargosInst;
	}
	public String getCodMoneda() {
		return codMoneda;
	}
	public void setCodMoneda(String codMoneda) {
		this.codMoneda = codMoneda;
	}
	public String getConcepFactCargIns() {
		return concepFactCargIns;
	}
	public void setConcepFactCargIns(String concepFactCargIns) {
		this.concepFactCargIns = concepFactCargIns;
	}
	public String getDesConcepCargoIns() {
		return desConcepCargoIns;
	}
	public void setDesConcepCargoIns(String desConcepCargoIns) {
		this.desConcepCargoIns = desConcepCargoIns;
	}

	public String getCodModuloMisPendientesInst() {
		return codModuloMisPendientesInst;
	}
	public void setCodModuloMisPendientesInst(String codModuloMisPendientesInst) {
		this.codModuloMisPendientesInst = codModuloMisPendientesInst;
	}
	public String getCodModuloConsultaDocumentos() {
		return codModuloConsultaDocumentos;
	}
	public void setCodModuloConsultaDocumentos(String codModuloConsultaDocumentos) {
		this.codModuloConsultaDocumentos = codModuloConsultaDocumentos;
	}
	public String getCodTipoDocumento() {
		return codTipoDocumento;
	}
	public void setCodTipoDocumento(String codTipoDocumento) {
		this.codTipoDocumento = codTipoDocumento;
	}
	public String getCodModuloEvaluacion() {
		return codModuloEvaluacion;
	}
	public void setCodModuloEvaluacion(String codModuloEvaluacion) {
		this.codModuloEvaluacion = codModuloEvaluacion;
	}
	public String getCodModuloMisPendientesEval() {
		return codModuloMisPendientesEval;
	}
	public void setCodModuloMisPendientesEval(String codModuloMisPendientesEval) {
		this.codModuloMisPendientesEval = codModuloMisPendientesEval;
	}
	public int getIndMacAddress() {
		return indMacAddress;
	}
	public void setIndMacAddress(int indMacAddress) {
		this.indMacAddress = indMacAddress;
	}
	public String getWimaxMacAddress() {
		return wimaxMacAddress;
	}
	public void setWimaxMacAddress(String wimaxMacAddress) {
		this.wimaxMacAddress = wimaxMacAddress;
	}
	
	private String codModuloAsociacionDocumentos;

	public String getCodModuloAsociacionDocumentos() {
		return codModuloAsociacionDocumentos;
	}
	public void setCodModuloAsociacionDocumentos(String codModuloAsociacionDocumentos) {
		this.codModuloAsociacionDocumentos = codModuloAsociacionDocumentos;
	}

	public final String getCodModuloOverrideSolicitud() {
		return codModuloOverrideSolicitud;
	}

	public final void setCodModuloOverrideSolicitud(String codModuloOverrideSolicitud) {
		this.codModuloOverrideSolicitud = codModuloOverrideSolicitud;
	}
	
	
}
