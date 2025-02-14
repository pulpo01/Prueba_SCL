package com.tmmas.cl.scl.portalventas.web.form;

import org.apache.struts.action.ActionForm;

import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.OficinaComDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ModalidadPagoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.NumeroCuotasDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.TipoSolicitudDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.VendedorDTO;

public class DatosVentaForm extends ActionForm {
	private static final long serialVersionUID = 1L;
	
	private String codOficina;
	private OficinaComDTO[] arrayOficina;
	private String codTipoComisionista;
	private VendedorDTO[] arrayTipoComisionista;
	private String indVtaExterna;
	private String codDistribuidor;
	private String codDistribuidorSeleccionado;
	private String codVendedor;
	private String codVendedorSeleccionado;
	private String codTipoContrato;
	private String codTipoContratoSeleccionado;
	private String codModalidadVenta;
	private String codModalidadVentaSeleccionada;
	private String codPeriodo;
	private String codPeriodoSeleccionado;
	private String codTipoCliente;
	private String glsTipoCliente;	
	private String codCliente="";
	private String facturaTercero;	
	private String flagFacturacionTercero="0";
	private String codCrediticia;
	private double montoPreAutorizado;
	private long numeroVenta;
	private long numeroTransaccionVenta;
	private ModalidadPagoDTO[] listaModalidadPago;
    private String numCuotas;
    private NumeroCuotasDTO[] arrayCuotas;
    private String numCuotasSeleccionado;
	private String codTipoClientePrepago;
    private String indBloqueoVendedor="0";
    private String codCalificacionCliente;
    private String indBusquedaVendedor;
    
    //Para busqueda de cliente 
    private String tipoVendedor;
    private String codVendedorBusqueda;
    
    private String codTipoSolicitud;
    private TipoSolicitudDTO[] arrayTipoSolicitud;
    
	public TipoSolicitudDTO[] getArrayTipoSolicitud() {
		return arrayTipoSolicitud;
	}
	public void setArrayTipoSolicitud(TipoSolicitudDTO[] arrayTipoSolicitud) {
		this.arrayTipoSolicitud = arrayTipoSolicitud;
	}
	public String getCodTipoSolicitud() {
		return codTipoSolicitud;
	}
	public void setCodTipoSolicitud(String codTipoSolicitud) {
		this.codTipoSolicitud = codTipoSolicitud;
	}
	public String getCodVendedorBusqueda() {
		return codVendedorBusqueda;
	}
	public void setCodVendedorBusqueda(String codVendedorBusqueda) {
		this.codVendedorBusqueda = codVendedorBusqueda;
	}
	public String getTipoVendedor() {
		return tipoVendedor;
	}
	public void setTipoVendedor(String tipoVendedor) {
		this.tipoVendedor = tipoVendedor;
	}
	public String getCodCalificacionCliente() {
		return codCalificacionCliente;
	}
	public void setCodCalificacionCliente(String codCalificacionCliente) {
		this.codCalificacionCliente = codCalificacionCliente;
	}
	public String getCodTipoClientePrepago() {
		return codTipoClientePrepago;
	}
	public void setCodTipoClientePrepago(String codTipoClientePrepago) {
		this.codTipoClientePrepago = codTipoClientePrepago;
	}
	public String getIndBloqueoVendedor() {
		return indBloqueoVendedor;
	}
	public void setIndBloqueoVendedor(String indBloqueoVendedor) {
		this.indBloqueoVendedor = indBloqueoVendedor;
	}
	public String getNumCuotasSeleccionado() {
		return numCuotasSeleccionado;
	}
	public void setNumCuotasSeleccionado(String numCuotasSeleccionado) {
		this.numCuotasSeleccionado = numCuotasSeleccionado;
	}
	public long getNumeroTransaccionVenta() {
		return numeroTransaccionVenta;
	}
	public void setNumeroTransaccionVenta(long numeroTransaccionVenta) {
		this.numeroTransaccionVenta = numeroTransaccionVenta;
	}
	public long getNumeroVenta() {
		return numeroVenta;
	}
	public void setNumeroVenta(long numeroVenta) {
		this.numeroVenta = numeroVenta;
	}
	public String getCodCrediticia() {
		return codCrediticia;
	}
	public void setCodCrediticia(String codCrediticia) {
		this.codCrediticia = codCrediticia;
	}
	public double getMontoPreAutorizado() {
		return montoPreAutorizado;
	}
	public void setMontoPreAutorizado(double montoPreAutorizado) {
		this.montoPreAutorizado = montoPreAutorizado;
	}

	public String getCodTipoContratoSeleccionado() {
		return codTipoContratoSeleccionado;
	}
	public void setCodTipoContratoSeleccionado(String codTipoContratoSeleccionado) {
		this.codTipoContratoSeleccionado = codTipoContratoSeleccionado;
	}
	public String getCodDistribuidorSeleccionado() {
		return codDistribuidorSeleccionado;
	}
	public void setCodDistribuidorSeleccionado(String codDistribuidorSeleccionado) {
		this.codDistribuidorSeleccionado = codDistribuidorSeleccionado;
	}

	public String getCodModalidadVentaSeleccionada() {
		return codModalidadVentaSeleccionada;
	}
	public void setCodModalidadVentaSeleccionada(
			String codModalidadVentaSeleccionada) {
		this.codModalidadVentaSeleccionada = codModalidadVentaSeleccionada;
	}
	public OficinaComDTO[] getArrayOficina() {
		return arrayOficina;
	}
	public void setArrayOficina(OficinaComDTO[] arrayOficina) {
		this.arrayOficina = arrayOficina;
	}

	public String getCodPeriodoSeleccionado() {
		return codPeriodoSeleccionado;
	}
	public void setCodPeriodoSeleccionado(String codPeriodoSeleccionado) {
		this.codPeriodoSeleccionado = codPeriodoSeleccionado;
	}
	public VendedorDTO[] getArrayTipoComisionista() {
		return arrayTipoComisionista;
	}
	public void setArrayTipoComisionista(VendedorDTO[] arrayTipoComisionista) {
		this.arrayTipoComisionista = arrayTipoComisionista;
	}

	public String getCodVendedorSeleccionado() {
		return codVendedorSeleccionado;
	}
	public void setCodVendedorSeleccionado(String codVendedorSeleccionado) {
		this.codVendedorSeleccionado = codVendedorSeleccionado;
	}
	public String getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodDistribuidor() {
		return codDistribuidor;
	}
	public void setCodDistribuidor(String codDistribuidor) {
		this.codDistribuidor = codDistribuidor;
	}
	public String getCodModalidadVenta() {
		return codModalidadVenta;
	}
	public void setCodModalidadVenta(String codModalidadVenta) {
		this.codModalidadVenta = codModalidadVenta;
	}
	public String getCodOficina() {
		return codOficina;
	}
	public void setCodOficina(String codOficina) {
		this.codOficina = codOficina;
	}
	public String getCodPeriodo() {
		return codPeriodo;
	}
	public void setCodPeriodo(String codPeriodo) {
		this.codPeriodo = codPeriodo;
	}
	public String getCodTipoCliente() {
		return codTipoCliente;
	}
	public void setCodTipoCliente(String codTipoCliente) {
		this.codTipoCliente = codTipoCliente;
	}
	public String getCodTipoComisionista() {
		return codTipoComisionista;
	}
	public void setCodTipoComisionista(String codTipoComisionista) {
		this.codTipoComisionista = codTipoComisionista;
	}
	public String getCodTipoContrato() {
		return codTipoContrato;
	}
	public void setCodTipoContrato(String codTipoContrato) {
		this.codTipoContrato = codTipoContrato;
	}
	public String getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(String codVendedor) {
		this.codVendedor = codVendedor;
	}
	public String getFacturaTercero() {
		return facturaTercero;
	}
	public void setFacturaTercero(String facturaTercero) {
		this.facturaTercero = facturaTercero;
	}
	public String getGlsTipoCliente() {
		return glsTipoCliente;
	}
	public void setGlsTipoCliente(String glsTipoCliente) {
		this.glsTipoCliente = glsTipoCliente;
	}
	public String getIndVtaExterna() {
		return indVtaExterna;
	}
	public void setIndVtaExterna(String indVtaExterna) {
		this.indVtaExterna = indVtaExterna;
	}
	public String getFlagFacturacionTercero() {
		return flagFacturacionTercero;
	}
	public void setFlagFacturacionTercero(String flagFacturacionTercero) {
		this.flagFacturacionTercero = flagFacturacionTercero;
	}
	public String getNumCuotas() {
		return numCuotas;
	}
	public void setNumCuotas(String numCuotas) {
		this.numCuotas = numCuotas;
	}
	public NumeroCuotasDTO[] getArrayCuotas() {
		return arrayCuotas;
	}
	public void setArrayCuotas(NumeroCuotasDTO[] arrayCuotas) {
		this.arrayCuotas = arrayCuotas;
	}
	public ModalidadPagoDTO[] getListaModalidadPago() {
		return listaModalidadPago;
	}
	public void setListaModalidadPago(ModalidadPagoDTO[] listaModalidadPago) {
		this.listaModalidadPago = listaModalidadPago;
	}
	public String getIndBusquedaVendedor() {
		return indBusquedaVendedor;
	}
	public void setIndBusquedaVendedor(String indBusquedaVendedor) {
		this.indBusquedaVendedor = indBusquedaVendedor;
	}

	private String aplicaFacturaTercero;
	
	public final String getAplicaFacturaTercero() {
		return aplicaFacturaTercero;
	}
	
	public final void setAplicaFacturaTercero(String aplicaFacturaTercero) {
		this.aplicaFacturaTercero = aplicaFacturaTercero;
	}
	
}
