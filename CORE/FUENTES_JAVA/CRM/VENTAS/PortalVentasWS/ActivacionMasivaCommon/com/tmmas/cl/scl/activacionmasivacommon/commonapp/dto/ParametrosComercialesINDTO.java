package com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto;

import java.io.Serializable;

public class ParametrosComercialesINDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private String cod_vendedor;
	private String cod_vendealer;
	private String cod_canal;
	private String cod_cliente;
	private String tipo_producto;
	private String cod_planTarif;
	private String cod_tipContrato;
	private String forma_pago;
	private String nro_cuotas;
	private String proc_equipo;
	private String nro_icc;
	private String nro_imei;
	private String cod_articulo;
	private String nom_usuarora;
    private String numSolicitud;
    private String ind_ofiter;
    private String cod_Uso;
    	

    private ServSupActLineaDTO[] servSupActLineaDTO;
	
	public ServSupActLineaDTO[] getServSupActLineaDTO() {
		return servSupActLineaDTO;
	}
	public void setServSupActLineaDTO(ServSupActLineaDTO[] servSupActLineaDTO) {
		this.servSupActLineaDTO = servSupActLineaDTO;
	}
	public String getCod_articulo() {
		return cod_articulo;
	}
	public void setCod_articulo(String cod_articulo) {
		this.cod_articulo = cod_articulo;
	}
	public String getCod_canal() {
		return cod_canal;
	}
	public void setCod_canal(String cod_canal) {
		this.cod_canal = cod_canal;
	}
	public String getCod_cliente() {
		return cod_cliente;
	}
	public void setCod_cliente(String cod_cliente) {
		this.cod_cliente = cod_cliente;
	}
	public String getCod_planTarif() {
		return cod_planTarif;
	}
	public void setCod_planTarif(String cod_planTarif) {
		this.cod_planTarif = cod_planTarif;
	}
	public String getCod_tipContrato() {
		return cod_tipContrato;
	}
	public void setCod_tipContrato(String cod_tipContrato) {
		this.cod_tipContrato = cod_tipContrato;
	}
	public String getCod_vendealer() {
		return cod_vendealer;
	}
	public void setCod_vendealer(String cod_vendealer) {
		this.cod_vendealer = cod_vendealer;
	}
	public String getCod_vendedor() {
		return cod_vendedor;
	}
	public void setCod_vendedor(String cod_vendedor) {
		this.cod_vendedor = cod_vendedor;
	}
	public String getForma_pago() {
		return forma_pago;
	}
	public void setForma_pago(String forma_pago) {
		this.forma_pago = forma_pago;
	}
	public String getNom_usuarora() {
		return nom_usuarora;
	}
	public void setNom_usuarora(String nom_usuarora) {
		this.nom_usuarora = nom_usuarora;
	}
	public String getNro_cuotas() {
		return nro_cuotas;
	}
	public void setNro_cuotas(String nro_cuotas) {
		this.nro_cuotas = nro_cuotas;
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
	public String getTipo_producto() {
		return tipo_producto;
	}
	public void setTipo_producto(String tipo_producto) {
		this.tipo_producto = tipo_producto;
	}
	public String getNumSolicitud() {
		return numSolicitud;
	}
	public void setNumSolicitud(String numSolicitud) {
		this.numSolicitud = numSolicitud;
	}
	public String getInd_ofiter() {
		return ind_ofiter;
	}
	public void setInd_ofiter(String ind_ofiter) {
		this.ind_ofiter = ind_ofiter;
	}
	public String getCod_Uso() {
		return cod_Uso;
	}
	public void setCod_Uso(String cod_Uso) {
		this.cod_Uso = cod_Uso;
	}
	
}
