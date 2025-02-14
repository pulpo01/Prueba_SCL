package com.tmmas.scl.quiosco.web.form;

import org.apache.struts.action.ActionForm;

public class MantenedorTiendaForm extends ActionForm{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	//Datos Tienda
	private String codTienda;
	private String nomTienda;
	private String usuaVendedor;
	private String usuacajero;
	private String usuaTien;
	private String codClienteTien;
	private String codCaja;
	private String desCaja;
	private String indApliPago;
	
	//Accion del Formulario
	private String accionMantTienda;

	//Transporte data
	private String cadenaTienda; //Cada parametro esta separado por # y cada linea esta $

	//
	public String getCodTienda() {
		return codTienda;
	}

	public void setCodTienda(String codTienda) {
		this.codTienda = codTienda;
	}

	public String getNomTienda() {
		return nomTienda;
	}

	public void setNomTienda(String nomTienda) {
		this.nomTienda = nomTienda;
	}

	public String getUsuaVendedor() {
		return usuaVendedor;
	}

	public void setUsuaVendedor(String usuaVendedor) {
		this.usuaVendedor = usuaVendedor;
	}

	public String getUsuacajero() {
		return usuacajero;
	}

	public void setUsuacajero(String usuacajero) {
		this.usuacajero = usuacajero;
	}

	public String getUsuaTien() {
		return usuaTien;
	}

	public void setUsuaTien(String usuaTien) {
		this.usuaTien = usuaTien;
	}

	public String getCodClienteTien() {
		return codClienteTien;
	}

	public void setCodClienteTien(String codClienteTien) {
		this.codClienteTien = codClienteTien;
	}

	public String getAccionMantTienda() {
		return accionMantTienda;
	}

	public void setAccionMantTienda(String accionMantTienda) {
		this.accionMantTienda = accionMantTienda;
	}

	public String getCadenaTienda() {
		return cadenaTienda;
	}

	public void setCadenaTienda(String cadenaTienda) {
		this.cadenaTienda = cadenaTienda;
	}

	public String getCodCaja() {
		return codCaja;
	}

	public void setCodCaja(String codCaja) {
		this.codCaja = codCaja;
	}

	public String getDesCaja() {
		return desCaja;
	}

	public void setDesCaja(String desCaja) {
		this.desCaja = desCaja;
	}

	public String getIndApliPago() {
		return indApliPago;
	}

	public void setIndApliPago(String indApliPago) {
		this.indApliPago = indApliPago;
	}

}
