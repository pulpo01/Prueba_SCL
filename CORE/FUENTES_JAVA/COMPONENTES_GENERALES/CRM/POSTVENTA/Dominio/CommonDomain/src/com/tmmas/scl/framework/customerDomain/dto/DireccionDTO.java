package com.tmmas.scl.framework.customerDomain.dto;

import java.io.Serializable;

public class DireccionDTO  implements Serializable {


	private static final long serialVersionUID = 1L;
	private long   cod_direccion;
	private RegionDTO region;
	private String cod_comuna;
	private String nom_calle;
	private String num_calle;
	private String num_piso;
	private String num_casilla;
	private String obs_direccion;
	private String des_direc1;
	private String des_direc2;
	private String cod_pueblo;
	private String cod_estado;
	private String zip;
	private String cod_tipocalle;
	

	public String getCod_comuna() {
		return cod_comuna;
	}
	public void setCod_comuna(String cod_comuna) {
		this.cod_comuna = cod_comuna;
	}
	public long getCod_direccion() {
		return cod_direccion;
	}
	public void setCod_direccion(long cod_direccion) {
		this.cod_direccion = cod_direccion;
	}
	public String getCod_estado() {
		return cod_estado;
	}
	public void setCod_estado(String cod_estado) {
		this.cod_estado = cod_estado;
	}
	public String getCod_pueblo() {
		return cod_pueblo;
	}
	public void setCod_pueblo(String cod_pueblo) {
		this.cod_pueblo = cod_pueblo;
	}
	public String getCod_tipocalle() {
		return cod_tipocalle;
	}
	public void setCod_tipocalle(String cod_tipocalle) {
		this.cod_tipocalle = cod_tipocalle;
	}
	public String getDes_direc1() {
		return des_direc1;
	}
	public void setDes_direc1(String des_direc1) {
		this.des_direc1 = des_direc1;
	}
	public String getDes_direc2() {
		return des_direc2;
	}
	public void setDes_direc2(String des_direc2) {
		this.des_direc2 = des_direc2;
	}
	public String getNom_calle() {
		return nom_calle;
	}
	public void setNom_calle(String nom_calle) {
		this.nom_calle = nom_calle;
	}
	public String getNum_calle() {
		return num_calle;
	}
	public void setNum_calle(String num_calle) {
		this.num_calle = num_calle;
	}
	public String getNum_casilla() {
		return num_casilla;
	}
	public void setNum_casilla(String num_casilla) {
		this.num_casilla = num_casilla;
	}
	public String getNum_piso() {
		return num_piso;
	}
	public void setNum_piso(String num_piso) {
		this.num_piso = num_piso;
	}
	public String getObs_direccion() {
		return obs_direccion;
	}
	public void setObs_direccion(String obs_direccion) {
		this.obs_direccion = obs_direccion;
	}
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	public RegionDTO getRegion() {
		return region;
	}
	public void setRegion(RegionDTO region) {
		this.region = region;
	}
}
