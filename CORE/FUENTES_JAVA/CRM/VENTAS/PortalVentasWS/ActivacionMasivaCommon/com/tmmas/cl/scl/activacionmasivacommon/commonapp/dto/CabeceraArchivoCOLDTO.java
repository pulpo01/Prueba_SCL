package com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto;

import java.io.Serializable;

public class CabeceraArchivoCOLDTO extends CabeceraArchivoDTO implements Serializable  
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String nro_icc;
	private String nro_imei;
	private String proc_equipo;
	private String cod_planTarif;
	private String numero_celular;
	private String cod_canal;
	private String tipo_producto;
	private String codigoArticuloTerminal;	
	private String cod_cuota;
	private String numAnexo;
	private Long numMesesContrato;
	private String cod_estrato;
	
	public String getCod_cuota() {
		return cod_cuota;
	}
	public void setCod_cuota(String cod_cuota) {
		this.cod_cuota = cod_cuota;
	}
	public String getCodigoArticuloTerminal() {
		return codigoArticuloTerminal;
	}
	public void setCodigoArticuloTerminal(String codigoArticuloTerminal) {
		this.codigoArticuloTerminal = codigoArticuloTerminal;
	}
	public String getCod_canal() {
		return cod_canal;
	}
	public void setCod_canal(String cod_canal) {
		this.cod_canal = cod_canal;
	}
	public String getNumero_celular() {
		return numero_celular;
	}
	public void setNumero_celular(String numero_celular) {
		this.numero_celular = numero_celular;
	}
	public String getNro_icc() {
		return nro_icc;
	}
	public void setNro_icc(String nro_icc) {
		this.nro_icc = nro_icc;
	}
	public String getNro_imei() {
		return nro_imei;
	}
	public void setNro_imei(String nro_imei) {
		this.nro_imei = nro_imei;
	}
	public String getProc_equipo() {
		return proc_equipo;
	}	
	public void setProc_equipo(String proc_equipo) {
		this.proc_equipo = proc_equipo;
	}
	public String getCod_planTarif() {
		return cod_planTarif;
	}
	public void setCod_planTarif(String cod_planTarif) {
		this.cod_planTarif = cod_planTarif;
	}
	public String getTipo_producto() {
		return tipo_producto;
	}
	public void setTipo_producto(String tipo_producto) {
		this.tipo_producto = tipo_producto;
	}
	public String getNumAnexo() {
		return numAnexo;
	}
	public void setNumAnexo(String numAnexo) {
		this.numAnexo = numAnexo;
	}
	public Long getNumMesesContrato() {
		return numMesesContrato;
	}
	public void setNumMesesContrato(Long numMesesContrato) {
		this.numMesesContrato = numMesesContrato;
	}
	public String getCod_estrato() {
		return cod_estrato;
	}
	public void setCod_estrato(String cod_estrato) {
		this.cod_estrato = cod_estrato;
	}	
	
}
