package com.tmmas.scl.quiosco.web.form;

import org.apache.struts.action.ActionForm;

public class VentaForm extends ActionForm{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
    
	private String serie;
	private String cantidad;
	private String idLinea;
	private String idAccesorio;
	private String idKit;
	private String accionVenta;
	private String codPrestacion;
	
	//PAGO
	private String codBanco;
	private String codCajaQuiosco;
	private String numCuentaCorriente;
    private String numTarjetaCredito;
    private String sistemaPago;
	
    private String codTipTarjeta; // CSR-11002
    private String numDocumento; //CSR-11002

	public String getCodPrestacion() {
		return codPrestacion;
	}
	public void setCodPrestacion(String codPrestacion) {
		this.codPrestacion = codPrestacion;
	}

	public String getCodBanco() {
		return codBanco;
	}
	public void setCodBanco(String codBanco) {
		this.codBanco = codBanco;
	}
	public String getCodCajaQuiosco() {
		return codCajaQuiosco;
	}
	public void setCodCajaQuiosco(String codCajaQuiosco) {
		this.codCajaQuiosco = codCajaQuiosco;
	}
	public String getNumCuentaCorriente() {
		return numCuentaCorriente;
	}
	public void setNumCuentaCorriente(String numCuentaCorriente) {
		this.numCuentaCorriente = numCuentaCorriente;
	}
	public String getNumTarjetaCredito() {
		return numTarjetaCredito;
	}
	public void setNumTarjetaCredito(String numTarjetaCredito) {
		this.numTarjetaCredito = numTarjetaCredito;
	}
	public String getSistemaPago() {
		return sistemaPago;
	}
	public void setSistemaPago(String sistemaPago) {
		this.sistemaPago = sistemaPago;
	}
	public String getSerie() {
		return serie;
	}
	public void setSerie(String serie) {
		this.serie = serie;
	}
	public String getCantidad() {
		return cantidad;
	}
	public void setCantidad(String cantidad) {
		this.cantidad = cantidad;
	}
	public String getIdLinea() {
		return idLinea;
	}
	public void setIdLinea(String idLinea) {
		this.idLinea = idLinea;
	}
	public String getIdAccesorio() {
		return idAccesorio;
	}
	public void setIdAccesorio(String idAccesorio) {
		this.idAccesorio = idAccesorio;
	}
	public String getAccionVenta() {
		return accionVenta;
	}
	public void setAccionVenta(String accionVenta) {
		this.accionVenta = accionVenta;
	}
	public String getIdKit() {
		return idKit;
	}
	public void setIdKit(String idKit) {
		this.idKit = idKit;
	}
	public String getCodTipTarjeta() {
		return codTipTarjeta;
	}
	public void setCodTipTarjeta(String codTipTarjeta) {
		this.codTipTarjeta = codTipTarjeta;
	}
	public String getNumDocumento() {
		return numDocumento;
	}
	public void setNumDocumento(String numDocumento) {
		this.numDocumento = numDocumento;
	}

}
