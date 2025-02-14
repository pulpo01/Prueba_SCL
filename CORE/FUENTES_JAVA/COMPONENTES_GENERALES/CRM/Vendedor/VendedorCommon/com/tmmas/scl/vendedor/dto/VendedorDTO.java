package com.tmmas.scl.vendedor.dto;

import java.io.Serializable;
import java.util.Date;

public class VendedorDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String cod_vendedor = "";
	private String nom_vendedor = "";
	private String cod_vendealer = "";
	private String nom_vendealer = "";
	private boolean ind_interno = true;
	private String cod_oficina = "";
	private String nom_oficina = "";
	private String cod_tipcomis = "";
	private String nom_tipcomis = "";	
	private String numOOSS = "";
	private String usuario = "";
	private Date fecha ;
	private String cod_os = "";
	private String sub_tipo = "";
	private String cod_region = "";
	private String des_region = "";
	private String cod_ciudad = "";
	private String des_ciudad =  "";
	private String cod_provincia = "";
	private String des_provincia = "";
		
	
	public String getCod_ciudad() {
		return cod_ciudad;
	}
	public void setCod_ciudad(String cod_ciudad) {
		this.cod_ciudad = cod_ciudad;
	}
	public String getCod_provincia() {
		return cod_provincia;
	}
	public void setCod_provincia(String cod_provincia) {
		this.cod_provincia = cod_provincia;
	}
	public String getCod_region() {
		return cod_region;
	}
	public void setCod_region(String cod_region) {
		this.cod_region = cod_region;
	}
	public String getDes_ciudad() {
		return des_ciudad;
	}
	public void setDes_ciudad(String des_ciudad) {
		this.des_ciudad = des_ciudad;
	}
	public String getDes_provincia() {
		return des_provincia;
	}
	public void setDes_provincia(String des_provincia) {
		this.des_provincia = des_provincia;
	}
	public String getDes_region() {
		return des_region;
	}
	public void setDes_region(String des_region) {
		this.des_region = des_region;
	}
	public String getCod_os() {
		return cod_os;
	}
	public void setCod_os(String cod_os) {
		this.cod_os = cod_os;
	}
	public String getSub_tipo() {
		return sub_tipo;
	}
	public void setSub_tipo(String sub_tipo) {
		this.sub_tipo = sub_tipo;
	}
	public String getCod_oficina() {
		return cod_oficina;
	}
	public void setCod_oficina(String cod_oficina) {
		this.cod_oficina = cod_oficina;
	}
	public String getCod_tipcomis() {
		return cod_tipcomis;
	}
	public void setCod_tipcomis(String cod_tipcomis) {
		this.cod_tipcomis = cod_tipcomis;
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
	public Date getFecha() {
		return fecha;
	}
	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}
	public boolean isInd_interno() {
		return ind_interno;
	}
	public void setInd_interno(boolean ind_interno) {
		this.ind_interno = ind_interno;
	}
	public String getNom_oficina() {
		return nom_oficina;
	}
	public void setNom_oficina(String nom_oficina) {
		this.nom_oficina = nom_oficina;
	}
	public String getNom_tipcomis() {
		return nom_tipcomis;
	}
	public void setNom_tipcomis(String nom_tipcomis) {
		this.nom_tipcomis = nom_tipcomis;
	}
	public String getNom_vendealer() {
		return nom_vendealer;
	}
	public void setNom_vendealer(String nom_vendealer) {
		this.nom_vendealer = nom_vendealer;
	}
	public String getNom_vendedor() {
		return nom_vendedor;
	}
	public void setNom_vendedor(String nom_vendedor) {
		this.nom_vendedor = nom_vendedor;
	}
	public String getNumOOSS() {
		return numOOSS;
	}
	public void setNumOOSS(String numOOSS) {
		this.numOOSS = numOOSS;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}

	
	

}
