package com.tmmas.cl.scl.frameworkcargossrv.service.dto;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosReglaDTO;


public class ParametrosReglasBajaOptaPrepagoIndemnizacionDTO extends ParametrosReglaDTO{
	private static final long serialVersionUID = 1L;
	
	private long num_Abonado;
	private long cod_Producto;
	private String cod_TipContrato;
	private String cod_Actabo;
	private String cod_TipServ;
	private String cod_Servicio;
	private String meses_Contrato;
	private String num_meses;
	private String cod_Categoria;
	private String cod_Antiguedad;
	private String cod_Operacion;
	private String cod_IndCausa;
	private String cod_Causa;
	private String cod_ModPago;
	private String cod_Estado_dev;
	private ParametroDTO parametro;
	private String ind_Comodato;
	private String cod_Modulo;
	private String equipCargador;
	private String ind_Causa;
	private String estdDevlCargador;
	private String equipoEstado;
	private String numAbonado;
	
	
	public String getInd_Causa() {
		return ind_Causa;
	}
	public void setInd_Causa(String ind_Causa) {
		this.ind_Causa = ind_Causa;
	}
	public void setEquipCargador(String equipCargador) {
		this.equipCargador = equipCargador;
	}
	public String getCod_Modulo() {
		return cod_Modulo;
	}
	public void setCod_Modulo(String cod_Modulo) {
		this.cod_Modulo = cod_Modulo;
	}
	public String getInd_Comodato() {
		return ind_Comodato;
	}
	public void setInd_Comodato(String ind_Comodato) {
		this.ind_Comodato = ind_Comodato;
	}
	public String getCod_Actabo() {
		return cod_Actabo;
	}
	public void setCod_Actabo(String cod_Actabo) {
		this.cod_Actabo = cod_Actabo;
	}
	public String getCod_Antiguedad() {
		return cod_Antiguedad;
	}
	public void setCod_Antiguedad(String cod_Antiguedad) {
		this.cod_Antiguedad = cod_Antiguedad;
	}
	public String getCod_Categoria() {
		return cod_Categoria;
	}
	public void setCod_Categoria(String cod_Categoria) {
		this.cod_Categoria = cod_Categoria;
	}
	public String getCod_Causa() {
		return cod_Causa;
	}
	public void setCod_Causa(String cod_Causa) {
		this.cod_Causa = cod_Causa;
	}
	public String getCod_Estado_dev() {
		return cod_Estado_dev;
	}
	public void setCod_Estado_dev(String cod_Estado_dev) {
		this.cod_Estado_dev = cod_Estado_dev;
	}
	public String getCod_IndCausa() {
		return cod_IndCausa;
	}
	public void setCod_IndCausa(String cod_IndCausa) {
		this.cod_IndCausa = cod_IndCausa;
	}
	public String getCod_ModPago() {
		return cod_ModPago;
	}
	public void setCod_ModPago(String cod_ModPago) {
		this.cod_ModPago = cod_ModPago;
	}
	public String getCod_Operacion() {
		return cod_Operacion;
	}
	public void setCod_Operacion(String cod_Operacion) {
		this.cod_Operacion = cod_Operacion;
	}
	public long getCod_Producto() {
		return cod_Producto;
	}
	public void setCod_Producto(long cod_Producto) {
		this.cod_Producto = cod_Producto;
	}
	public String getCod_Servicio() {
		return cod_Servicio;
	}
	public void setCod_Servicio(String cod_Servicio) {
		this.cod_Servicio = cod_Servicio;
	}
	public String getCod_TipContrato() {
		return cod_TipContrato;
	}
	public void setCod_TipContrato(String cod_TipContrato) {
		this.cod_TipContrato = cod_TipContrato;
	}
	public String getCod_TipServ() {
		return cod_TipServ;
	}
	public void setCod_TipServ(String cod_TipServ) {
		this.cod_TipServ = cod_TipServ;
	}
	public String getMeses_Contrato() {
		return meses_Contrato;
	}
	public void setMeses_Contrato(String meses_Contrato) {
		this.meses_Contrato = meses_Contrato;
	}
	public long getNum_Abonado() {
		return num_Abonado;
	}
	public void setNum_Abonado(long num_Abonado) {
		this.num_Abonado = num_Abonado;
	}
	public String getNum_meses() {
		return num_meses;
	}
	public void setNum_meses(String num_meses) {
		this.num_meses = num_meses;
	}
	public ParametroDTO getParametro() {
		return parametro;
	}
	public void setParametro(ParametroDTO parametro) {
		this.parametro = parametro;
	}
	public String getEquipCargador() {
		return equipCargador;
	}
	public String getEquipoEstado() {
		return equipoEstado;
	}
	public void setEquipoEstado(String equipoEstado) {
		this.equipoEstado = equipoEstado;
	}
	public String getEstdDevlCargador() {
		return estdDevlCargador;
	}
	public void setEstdDevlCargador(String estdDevlCargador) {
		this.estdDevlCargador = estdDevlCargador;
	}
	public String getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(String numAbonado) {
		this.numAbonado = numAbonado;
	}
	
	
	
	

}
