package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;


public class DireccionOutDTO  implements Serializable {
	
	/*
	 * Autor: Juan Daniel Muñoz Queupul
	 * */

	private static final long serialVersionUID = 1L;
    private String codTipoCalle;   
    private String codTipDireccion;
    private String desTipDireccion;
    private String codDireccion;   
    private String codProvincia;   
    private String desProvincia;   
    private String codRegion;      
    private String desRegion;      
    private String codCiudad;      
    private String desCuidad;      
    private String codComuna;      
    private String desComuna;      
    private String nomCalle;       
    private String numCalle;       
    private String numCasilla;     
    private String obsDirecc;      
    private String zip;            
    private String desDirec1;      
    private String desDirec2;      
    private String codPueblo;      
    private String codEstado;      
    private String numPiso;
    
	public static long getSerialVersionUID() {
		return serialVersionUID;
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

	public String getCodEstado() {
		return codEstado;
	}
	public void setCodEstado(String codEstado) {
		this.codEstado = codEstado;
	}
	public String getCodProvincia() {
		return codProvincia;
	}
	public void setCodProvincia(String codProvincia) {
		this.codProvincia = codProvincia;
	}
	public String getCodPueblo() {
		return codPueblo;
	}
	public void setCodPueblo(String codPueblo) {
		this.codPueblo = codPueblo;
	}
	public String getCodRegion() {
		return codRegion;
	}
	public void setCodRegion(String codRegion) {
		this.codRegion = codRegion;
	}
	public String getCodTipDireccion() {
		return codTipDireccion;
	}
	public void setCodTipDireccion(String codTipDireccion) {
		this.codTipDireccion = codTipDireccion;
	}
	public String getCodTipoCalle() {
		return codTipoCalle;
	}
	public void setCodTipoCalle(String codTipoCalle) {
		this.codTipoCalle = codTipoCalle;
	}
	public String getDesComuna() {
		return desComuna;
	}
	public void setDesComuna(String desComuna) {
		this.desComuna = desComuna;
	}
	public String getDesCuidad() {
		return desCuidad;
	}
	public void setDesCuidad(String desCuidad) {
		this.desCuidad = desCuidad;
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
	public String getDesTipDireccion() {
		return desTipDireccion;
	}
	public void setDesTipDireccion(String desTipDireccion) {
		this.desTipDireccion = desTipDireccion;
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
	public String getNumCasilla() {
		return numCasilla;
	}
	public void setNumCasilla(String numCasilla) {
		this.numCasilla = numCasilla;
	}
	public String getNumPiso() {
		return numPiso;
	}
	public void setNumPiso(String numPiso) {
		this.numPiso = numPiso;
	}
	public String getObsDirecc() {
		return obsDirecc;
	}
	public void setObsDirecc(String obsDirecc) {
		this.obsDirecc = obsDirecc;
	}
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	public String getCodDireccion() {
		return codDireccion;
	}
	public void setCodDireccion(String codDireccion) {
		this.codDireccion = codDireccion;
	}
}