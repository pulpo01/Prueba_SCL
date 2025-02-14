package com.tmmas.cl.scl.commonbusinessentities.dto;

import java.io.Serializable;

public class FormularioDireccionDTO implements Serializable, Cloneable {

	private static final long serialVersionUID = 1L;

	private String COD_REGION;

	private String COD_PROVINCIA;

	private String COD_CIUDAD;

	private String COD_COMUNA;

	private String COD_TIPOCALLE;

	private String NOM_CALLE;

	private String NUM_CALLE;

	private String OBS_DIRECCION;

	private String ZIP;

	private String DES_DIREC1; //Colonia
	
	private String DES_DIREC2; //Direccion 2

	private String descripcionCOD_REGION;

	private String descripcionCOD_PROVINCIA;

	private String descripcionCOD_CIUDAD;

	private String descripcionCOD_COMUNA;

	private String descripcionCOD_TIPOCALLE;

	private String descripcionZIP;

	private boolean direccionReplicada;

	private String tipoDireccion;	
	
	public String getTipoDireccion() {
		return tipoDireccion;
	}

	public void setTipoDireccion(String tipoDireccion) {
		this.tipoDireccion = tipoDireccion;
	}

	public boolean isDireccionReplicada() {
		return direccionReplicada;
	}

	public void setDireccionReplicada(boolean direccionReplicada) {
		this.direccionReplicada = direccionReplicada;
	}

	public String getCOD_CIUDAD() {
		return COD_CIUDAD;
	}

	public void setCOD_CIUDAD(String cod_ciudad) {
		COD_CIUDAD = cod_ciudad;
	}

	public String getCOD_COMUNA() {
		return COD_COMUNA;
	}

	public void setCOD_COMUNA(String cod_comuna) {
		COD_COMUNA = cod_comuna;
	}

	public String getCOD_PROVINCIA() {
		return COD_PROVINCIA;
	}

	public void setCOD_PROVINCIA(String cod_provincia) {
		COD_PROVINCIA = cod_provincia;
	}

	public String getCOD_REGION() {
		return COD_REGION;
	}

	public void setCOD_REGION(String cod_region) {
		COD_REGION = cod_region;
	}

	public String getCOD_TIPOCALLE() {
		return COD_TIPOCALLE;
	}

	public void setCOD_TIPOCALLE(String cod_tipocalle) {
		COD_TIPOCALLE = cod_tipocalle;
	}

	public String getDES_DIREC1() {
		return DES_DIREC1;
	}

	public void setDES_DIREC1(String des_direc1) {
		DES_DIREC1 = des_direc1;
	}

	public String getDescripcionCOD_CIUDAD() {
		return descripcionCOD_CIUDAD;
	}

	public void setDescripcionCOD_CIUDAD(String descripcionCOD_CIUDAD) {
		this.descripcionCOD_CIUDAD = descripcionCOD_CIUDAD;
	}

	public String getDescripcionCOD_COMUNA() {
		return descripcionCOD_COMUNA;
	}

	public void setDescripcionCOD_COMUNA(String descripcionCOD_COMUNA) {
		this.descripcionCOD_COMUNA = descripcionCOD_COMUNA;
	}

	public String getDescripcionCOD_PROVINCIA() {
		return descripcionCOD_PROVINCIA;
	}

	public void setDescripcionCOD_PROVINCIA(String descripcionCOD_PROVINCIA) {
		this.descripcionCOD_PROVINCIA = descripcionCOD_PROVINCIA;
	}

	public String getDescripcionCOD_REGION() {
		return descripcionCOD_REGION;
	}

	public void setDescripcionCOD_REGION(String descripcionCOD_REGION) {
		this.descripcionCOD_REGION = descripcionCOD_REGION;
	}

	public String getDescripcionCOD_TIPOCALLE() {
		return descripcionCOD_TIPOCALLE;
	}

	public void setDescripcionCOD_TIPOCALLE(String descripcionCOD_TIPOCALLE) {
		this.descripcionCOD_TIPOCALLE = descripcionCOD_TIPOCALLE;
	}

	public String getDescripcionZIP() {
		return descripcionZIP;
	}

	public void setDescripcionZIP(String descripcionZIP) {
		this.descripcionZIP = descripcionZIP;
	}

	public String getNOM_CALLE() {
		return NOM_CALLE;
	}

	public void setNOM_CALLE(String nom_calle) {
		NOM_CALLE = nom_calle;
	}

	public String getNUM_CALLE() {
		return NUM_CALLE;
	}

	public void setNUM_CALLE(String num_calle) {
		NUM_CALLE = num_calle;
	}

	public String getOBS_DIRECCION() {
		return OBS_DIRECCION;
	}

	public void setOBS_DIRECCION(String obs_direccion) {
		OBS_DIRECCION = obs_direccion;
	}

	public String getZIP() {
		return ZIP;
	}

	public void setZIP(String zip) {
		ZIP = zip;
	}

	public String obtenerDireccionAMostrar() {
		String dirAMostrar = "";
		if (!this.getNOM_CALLE().equals("")) {
			dirAMostrar = dirAMostrar + this.getNOM_CALLE() + " ";
		}
		if (!this.getNUM_CALLE().equals("")) {
			dirAMostrar = dirAMostrar + this.getNUM_CALLE() + " ";
		}
		if (!this.getCOD_CIUDAD().equals("")) {
			dirAMostrar = dirAMostrar + this.getDescripcionCOD_CIUDAD() + " ";
		}
		if (!this.getDES_DIREC1().equals("")) {
			dirAMostrar = dirAMostrar + this.getDES_DIREC1() + " ";
		}
		if (!this.getCOD_COMUNA().equals("")) {
			dirAMostrar = dirAMostrar + this.getDescripcionCOD_COMUNA() + " ";
		}
		if (!this.getZIP().equals("")) {
			dirAMostrar = dirAMostrar + ". Código Postal " + this.getDescripcionZIP() + " ";
		}
		if (!this.getCOD_REGION().equals("")) {
			dirAMostrar = dirAMostrar + ". Departamento " + this.getDescripcionCOD_REGION() + " ";
		}
		if (!this.getCOD_PROVINCIA().equals("")) {
			dirAMostrar = dirAMostrar + ". Municipio " + this.getDescripcionCOD_PROVINCIA() + " ";
		}
		return dirAMostrar;

	}

	public Object clone() {
		Object clone = null;
		try {
			clone = super.clone();
		}
		catch (CloneNotSupportedException e) {
		}
		return clone;
	}

	public String getDES_DIREC2() {
		return DES_DIREC2;
	}

	public void setDES_DIREC2(String des_direc2) {
		DES_DIREC2 = des_direc2;
	}

}
