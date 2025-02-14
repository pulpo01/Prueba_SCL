package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class VendedorOutDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	//-- Activaciones web Colombia
	private String nom_vendedor;
	private String nom_vendealer;
	private String nom_provincia;
	private String nom_ciudad;
	private String direccion;
	private String observacion;
	private String nom_oficina;
	private String tip_comisionista;
	private String cod_vendealer;
	private String cod_vendedor;
	private String tipo_Calle;
	
	private Long codError;
	private String msgError;
	private Long codEvento;
	
	public Long getCodError() {
		return codError;
	}
	public void setCodError(Long codError) {
		this.codError = codError;
	}
	public String getDireccion() {
		return direccion;
	}
	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}
	public String getNom_ciudad() {
		return nom_ciudad;
	}
	public void setNom_ciudad(String nom_ciudad) {
		this.nom_ciudad = nom_ciudad;
	}
	public String getNom_oficina() {
		return nom_oficina;
	}
	public void setNom_oficina(String nom_oficina) {
		this.nom_oficina = nom_oficina;
	}
	public String getNom_provincia() {
		return nom_provincia;
	}
	public void setNom_provincia(String nom_provincia) {
		this.nom_provincia = nom_provincia;
	}
	public String getNom_vendedor() {
		return nom_vendedor;
	}
	public void setNom_vendedor(String nom_vendedor) {
		this.nom_vendedor = nom_vendedor;
	}
	public String getObservacion() {
		return observacion;
	}
	public void setObservacion(String observacion) {
		this.observacion = observacion;
	}
	public String getTip_comisionista() {
		return tip_comisionista;
	}
	public void setTip_comisionista(String tip_comisionista) {
		this.tip_comisionista = tip_comisionista;
	}
	public Long getCodEvento() {
		return codEvento;
	}
	public void setCodEvento(Long codEvento) {
		this.codEvento = codEvento;
	}
	public String getMsgError() {
		return msgError;
	}
	public void setMsgError(String msgError) {
		this.msgError = msgError;
	}
	public String getNom_vendealer() {
		return nom_vendealer;
	}
	public void setNom_vendealer(String nom_vendealer) {
		this.nom_vendealer = nom_vendealer;
	}
	public String getTipo_Calle() {
		return tipo_Calle;
	}
	public void setTipo_Calle(String tipo_Calle) {
		this.tipo_Calle = tipo_Calle;
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
	
}//fin VendedorOutDTO
