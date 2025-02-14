package com.tmmas.cl.scl.altacliente.presentacion.form;

import org.apache.struts.action.ActionForm;

import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ConceptosRecaudacionComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ModalidadCancelacionComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.TipoCuentaBancariaComDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ParametroDTO;

public class AltaClienteFinalForm extends ActionForm {
	private static final long serialVersionUID = 1L;
	
	private String modalidadCancel;
	private boolean restriccionModalidadCancel; 
	private ModalidadCancelacionComDTO[] arrayModalidadCancel;
	private String sistemaPago;
	private String codSistemaPagoSeleccionado;
	private String banco;
	private ConceptosRecaudacionComDTO[] arrayBanco;
	private String sucursal;
	private String codSucursalSeleccionada;
	private String tipoTarjeta;
	private ConceptosRecaudacionComDTO[] arrayTiposTarjeta;
	private String numeroCuenta;
	private String numeroTarjeta;
	private String tipoCuentaBanc;
	private TipoCuentaBancariaComDTO[]  arrayTipoCuentaBanc;
	private String fechaVencimientoTarjeta;
	private String mesVencimientoTarjeta;
	private String agnoVencimientoTarjeta;
	private ParametroDTO[] arrayMeses;
	private ParametroDTO[] arrayAgnos;
	private String flagClientePrepago ="0"; 
	private String nombreTitularTarjeta;
	private String observacionesTarjeta;
	
	public String getFlagClientePrepago() {
		return flagClientePrepago;
	}
	public void setFlagClientePrepago(String flagClientePrepago) {
		this.flagClientePrepago = flagClientePrepago;
	}
	public ConceptosRecaudacionComDTO[] getArrayBanco() {
		return arrayBanco;
	}
	public void setArrayBanco(ConceptosRecaudacionComDTO[] arrayBanco) {
		this.arrayBanco = arrayBanco;
	}
	public ModalidadCancelacionComDTO[] getArrayModalidadCancel() {
		return arrayModalidadCancel;
	}
	public void setArrayModalidadCancel(
			ModalidadCancelacionComDTO[] arrayModalidadCancel) {
		this.arrayModalidadCancel = arrayModalidadCancel;
	}
	public TipoCuentaBancariaComDTO[] getArrayTipoCuentaBanc() {
		return arrayTipoCuentaBanc;
	}
	public void setArrayTipoCuentaBanc(
			TipoCuentaBancariaComDTO[] arrayTipoCuentaBanc) {
		this.arrayTipoCuentaBanc = arrayTipoCuentaBanc;
	}
	public ConceptosRecaudacionComDTO[] getArrayTiposTarjeta() {
		return arrayTiposTarjeta;
	}
	public void setArrayTiposTarjeta(ConceptosRecaudacionComDTO[] arrayTiposTarjeta) {
		this.arrayTiposTarjeta = arrayTiposTarjeta;
	}
	public String getBanco() {
		return banco;
	}
	public void setBanco(String banco) {
		this.banco = banco;
	}
	public String getFechaVencimientoTarjeta() {
		return fechaVencimientoTarjeta;
	}
	public void setFechaVencimientoTarjeta(String fechaVencimientoTarjeta) {
		this.fechaVencimientoTarjeta = fechaVencimientoTarjeta;
	}
	public String getModalidadCancel() {
		return modalidadCancel;
	}
	public void setModalidadCancel(String modalidadCancel) {
		this.modalidadCancel = modalidadCancel;
	}
	public String getNumeroCuenta() {
		return numeroCuenta;
	}
	public void setNumeroCuenta(String numeroCuenta) {
		this.numeroCuenta = numeroCuenta;
	}
	public String getNumeroTarjeta() {
		return numeroTarjeta;
	}
	public void setNumeroTarjeta(String numeroTarjeta) {
		this.numeroTarjeta = numeroTarjeta;
	}
	public String getSistemaPago() {
		return sistemaPago;
	}
	public void setSistemaPago(String sistemaPago) {
		this.sistemaPago = sistemaPago;
	}
	public String getSucursal() {
		return sucursal;
	}
	public void setSucursal(String sucursal) {
		this.sucursal = sucursal;
	}
	public String getTipoCuentaBanc() {
		return tipoCuentaBanc;
	}
	public void setTipoCuentaBanc(String tipoCuentaBanc) {
		this.tipoCuentaBanc = tipoCuentaBanc;
	}
	public String getTipoTarjeta() {
		return tipoTarjeta;
	}
	public void setTipoTarjeta(String tipoTarjeta) {
		this.tipoTarjeta = tipoTarjeta;
	}
	public boolean isRestriccionModalidadCancel() {
		return restriccionModalidadCancel;
	}
	public void setRestriccionModalidadCancel(boolean restriccionModalidadCancel) {
		this.restriccionModalidadCancel = restriccionModalidadCancel;
	}
	public String getCodSistemaPagoSeleccionado() {
		return codSistemaPagoSeleccionado;
	}
	public void setCodSistemaPagoSeleccionado(String codSistemaPagoSeleccionado) {
		this.codSistemaPagoSeleccionado = codSistemaPagoSeleccionado;
	}
	public String getCodSucursalSeleccionada() {
		return codSucursalSeleccionada;
	}
	public void setCodSucursalSeleccionada(String codSucursalSeleccionada) {
		this.codSucursalSeleccionada = codSucursalSeleccionada;
	}
	public String getNombreTitularTarjeta() {
		return nombreTitularTarjeta;
	}
	public void setNombreTitularTarjeta(String nombreTitularTarjeta) {
		this.nombreTitularTarjeta = nombreTitularTarjeta;
	}
	public String getObservacionesTarjeta() {
		return observacionesTarjeta;
	}
	public void setObservacionesTarjeta(String observacionesTarjeta) {
		this.observacionesTarjeta = observacionesTarjeta;
	}
	public String getMesVencimientoTarjeta() {
		return mesVencimientoTarjeta;
	}
	public void setMesVencimientoTarjeta(String mesVencimientoTarjeta) {
		this.mesVencimientoTarjeta = mesVencimientoTarjeta;
	}
	public String getAgnoVencimientoTarjeta() {
		return agnoVencimientoTarjeta;
	}
	public void setAgnoVencimientoTarjeta(String agnoVencimientoTarjeta) {
		this.agnoVencimientoTarjeta = agnoVencimientoTarjeta;
	}
	public ParametroDTO[] getArrayAgnos() {
		return arrayAgnos;
	}
	public void setArrayAgnos(ParametroDTO[] arrayAgnos) {
		this.arrayAgnos = arrayAgnos;
	}
	public ParametroDTO[] getArrayMeses() {
		return arrayMeses;
	}
	public void setArrayMeses(ParametroDTO[] arrayMeses) {
		this.arrayMeses = arrayMeses;
	}

}
