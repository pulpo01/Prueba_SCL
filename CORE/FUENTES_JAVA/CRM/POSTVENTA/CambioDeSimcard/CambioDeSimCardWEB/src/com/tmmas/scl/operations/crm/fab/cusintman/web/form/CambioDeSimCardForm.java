package com.tmmas.scl.operations.crm.fab.cusintman.web.form;

import org.apache.struts.action.ActionForm;

public class CambioDeSimCardForm extends ActionForm {
	private static final long serialVersionUID = 1L;
	
	private String causaCambio;
	private String tipoContrato;
	private long modalidadPago;
	private String cuotas;
	private String tipoTerminal;
	private String nroSerie;
	private long usoVenta;
	private String abonoDiferido;
	private long   cod_bodega;
	private long   cod_articulo;
	private long   tip_stock;
	private String condicionError;
	private String mensajeError;
	private String mensajeStackTrace;

	private String condicH;
	private String condicionesCK;

	private String btnSeleccionado;
	
	private long numTransaccionBloqDes;
	
	public long getNumTransaccionBloqDes() {
		return numTransaccionBloqDes;
	}
	public void setNumTransaccionBloqDes(long numTransaccionBloqDes) {
		this.numTransaccionBloqDes = numTransaccionBloqDes;
	}
	public long getTip_stock() {
		return tip_stock;
	}
	public void setTip_stock(long tip_stock) {
		this.tip_stock = tip_stock;
	}
	public long getCod_articulo() {
		return cod_articulo;
	}
	public void setCod_articulo(long cod_articulo) {
		this.cod_articulo = cod_articulo;
	}
	public long getCod_bodega() {
		return cod_bodega;
	}
	public void setCod_bodega(long cod_bodega) {
		this.cod_bodega = cod_bodega;
	}
	
	public String getBtnSeleccionado() {
		return btnSeleccionado;
	}
	public void setBtnSeleccionado(String btnSeleccionado) {
		this.btnSeleccionado = btnSeleccionado;
	}
	
	public String getMensajeStackTrace() {
		return mensajeStackTrace;
	}
	public void setMensajeStackTrace(String mensajeStackTrace) {
		this.mensajeStackTrace = mensajeStackTrace;
	}
	
	public String getMensajeError() {
		return mensajeError;
	}
	public void setMensajeError(String mensajeError) {
		this.mensajeError = mensajeError;
	}
	
	public String getCondicionError() {
		return condicionError;
	}
	public void setCondicionError(String condicionError) {
		this.condicionError = condicionError;
	}
	
	public String getAbonoDiferido() {
		return abonoDiferido;
	}
	public void setAbonoDiferido(String abonoDiferido) {
		this.abonoDiferido = abonoDiferido;
	}
	
	public long getUsoVenta() {
		return usoVenta;
	}
	public void setUsoVenta(long usoVenta) {
		this.usoVenta = usoVenta;
	}	
	
	public String getNroSerie() {
		return nroSerie;
	}
	public void setNroSerie(String nroSerie) {
		this.nroSerie = nroSerie;
	}
	
	public String getCondicH() {
		return condicH;
	}
	public void setCondicH(String condicH) {
		setCondicionesCK(condicH.equals("SI")?"on":null);
		this.condicH = condicH;
	}
	
	public String getCausaCambio() {
		return causaCambio;
	}
	public void setCausaCambio(String causaCambio) {
		this.causaCambio = causaCambio;
	}
	
	public String getCuotas() {
		return cuotas;
	}
	public void setCuotas(String cuotas) {
		this.cuotas = cuotas;
	}

	public long getModalidadPago() {
		return modalidadPago;
	}
	public void setModalidadPago(long modalidadPago) {
		this.modalidadPago = modalidadPago;
	}
	
	public String getTipoContrato() {
		return tipoContrato;
	}
	public void setTipoContrato(String tipoContrato) {
		this.tipoContrato = tipoContrato;
	}
	public String getTipoTerminal() {
		return tipoTerminal;
	}
	public void setTipoTerminal(String tipoTerminal) {
		this.tipoTerminal = tipoTerminal;
	}
	public String getCondicionesCK() {
		return condicionesCK;
	}
	public void setCondicionesCK(String condicionesCK) {
		this.condicionesCK = condicionesCK;
	}
	
} // CambioDeSimCardForm
