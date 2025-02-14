package com.tmmas.cl.scl.ss911correofax.dto;

import java.io.Serializable;

public class DireccionDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private long codDireccion;
	private String codProvincia;
	private String codRegion;
	private String codCiudad;
	private String codComuna;
	private String nomCalle;
	private String numCalle;
	private String numPiso;
	private String numCasilla;
	private String obsDireccion;
	private String desDirec1;
	private String desDirec2;
	private String codPueblo;
	private String codEstado;
	private String zip;
	private String codTipoCalle;
	private String desProvincia;
	private String desRegion;
	private String desCiudad;
	private String desComuna;
	private String desPueblo; 
	private String desEstado; 

	
	public DireccionDTO() {
		super();
	}
	
	public String getCodProvincia() {
		return codProvincia;
	}
	public void setCodProvincia(String codProvincia) {
		this.codProvincia = codProvincia;
	}
	public String getCodRegion() {
		return codRegion;
	}
	public void setCodRegion(String codRegion) {
		this.codRegion = codRegion;
	}
	public String getCodCiudad() {
		return codCiudad;
	}
	public void setCodCiudad(String codCiudad) {
		this.codCiudad = codCiudad;
	}
	public String getCodComuna() {
		return codComuna;
	}
	public void setCodComuna(String codComuna) {
		this.codComuna = codComuna;
	}
	public String getNomCalle() {
		return nomCalle;
	}
	public void setNomCalle(String nomCalle) {
		this.nomCalle = nomCalle;
	}
	public String getNumCalle() {
		return numCalle;
	}
	public void setNumCalle(String numCalle) {
		this.numCalle = numCalle;
	}
	public String getNumPiso() {
		return numPiso;
	}
	public void setNumPiso(String numPiso) {
		this.numPiso = numPiso;
	}
	public String getNumCasilla() {
		return numCasilla;
	}
	public void setNumCasilla(String numCasilla) {
		this.numCasilla = numCasilla;
	}
	public String getObsDireccion() {
		return obsDireccion;
	}
	public void setObsDireccion(String obsDireccion) {
		this.obsDireccion = obsDireccion;
	}
	public String getDesDirec1() {
		return desDirec1;
	}
	public void setDesDirec1(String desDirec1) {
		this.desDirec1 = desDirec1;
	}
	public String getDesDirec2() {
		return desDirec2;
	}
	public void setDesDirec2(String desDirec2) {
		this.desDirec2 = desDirec2;
	}
	public String getCodPueblo() {
		return codPueblo;
	}
	public void setCodPueblo(String codPueblo) {
		this.codPueblo = codPueblo;
	}
	public String getCodEstado() {
		return codEstado;
	}
	public void setCodEstado(String codEstado) {
		this.codEstado = codEstado;
	}
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	public String getCodTipoCalle() {
		return codTipoCalle;
	}
	public void setCodTipoCalle(String codTipoCalle) {
		this.codTipoCalle = codTipoCalle;
	}

	public long getCodDireccion() {
		return codDireccion;
	}

	public void setCodDireccion(long codDireccion) {
		this.codDireccion = codDireccion;
	}

	public String getDesProvincia() {
		return desProvincia;
	}

	public void setDesProvincia(String desProvincia) {
		this.desProvincia = desProvincia;
	}

	public String getDesRegion() {
		return desRegion;
	}

	public void setDesRegion(String desRegion) {
		this.desRegion = desRegion;
	}

	public String getDesCiudad() {
		return desCiudad;
	}

	public void setDesCiudad(String desCiudad) {
		this.desCiudad = desCiudad;
	}

	public String getDesComuna() {
		return desComuna;
	}

	public void setDesComuna(String desComuna) {
		this.desComuna = desComuna;
	}

	public String getDesPueblo() {
		return desPueblo;
	}

	public void setDesPueblo(String desPueblo) {
		this.desPueblo = desPueblo;
	}

	public String getDesEstado() {
		return desEstado;
	}

	public void setDesEstado(String desEstado) {
		this.desEstado = desEstado;
	}		
	
}
