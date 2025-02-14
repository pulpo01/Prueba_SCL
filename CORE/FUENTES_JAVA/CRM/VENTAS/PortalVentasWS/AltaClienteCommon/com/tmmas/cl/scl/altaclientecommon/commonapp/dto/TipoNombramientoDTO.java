/*P-CSR-11002 JLGN 04-05-2011*/
package com.tmmas.cl.scl.altaclientecommon.commonapp.dto;

import java.io.Serializable;

public class TipoNombramientoDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	
	//Inicio datos tipo nombramiento
	private String tipNombramiento;
	private String nombreNombramiento;
	private String apellido1Nombramiento;
	private String apellido2Nombramiento;
	private String tipIdentNombramiento;
	private String numidentNombramiento;
	private String nacionalidadNombramiento;
	private String estadoCivilNombramiento;
	private String ocupacionNombramiento;
	private String domicilioNombramiento;	
	private String direccionOficina;
	//Fin datos tipo nombramiento
	
	public String getApellido1Nombramiento() {
		return apellido1Nombramiento;
	}
	public void setApellido1Nombramiento(String apellido1Nombramiento) {
		this.apellido1Nombramiento = apellido1Nombramiento;
	}
	public String getApellido2Nombramiento() {
		return apellido2Nombramiento;
	}
	public void setApellido2Nombramiento(String apellido2Nombramiento) {
		this.apellido2Nombramiento = apellido2Nombramiento;
	}
	public String getDireccionOficina() {
		return direccionOficina;
	}
	public void setDireccionOficina(String direccionOficina) {
		this.direccionOficina = direccionOficina;
	}
	public String getDomicilioNombramiento() {
		return domicilioNombramiento;
	}
	public void setDomicilioNombramiento(String domicilioNombramiento) {
		this.domicilioNombramiento = domicilioNombramiento;
	}
	public String getEstadoCivilNombramiento() {
		return estadoCivilNombramiento;
	}
	public void setEstadoCivilNombramiento(String estadoCivilNombramiento) {
		this.estadoCivilNombramiento = estadoCivilNombramiento;
	}
	public String getNacionalidadNombramiento() {
		return nacionalidadNombramiento;
	}
	public void setNacionalidadNombramiento(String nacionalidadNombramiento) {
		this.nacionalidadNombramiento = nacionalidadNombramiento;
	}
	public String getNombreNombramiento() {
		return nombreNombramiento;
	}
	public void setNombreNombramiento(String nombreNombramiento) {
		this.nombreNombramiento = nombreNombramiento;
	}
	public String getNumidentNombramiento() {
		return numidentNombramiento;
	}
	public void setNumidentNombramiento(String numidentNombramiento) {
		this.numidentNombramiento = numidentNombramiento;
	}
	public String getOcupacionNombramiento() {
		return ocupacionNombramiento;
	}
	public void setOcupacionNombramiento(String ocupacionNombramiento) {
		this.ocupacionNombramiento = ocupacionNombramiento;
	}
	public String getTipIdentNombramiento() {
		return tipIdentNombramiento;
	}
	public void setTipIdentNombramiento(String tipIdentNombramiento) {
		this.tipIdentNombramiento = tipIdentNombramiento;
	}
	public String getTipNombramiento() {
		return tipNombramiento;
	}
	public void setTipNombramiento(String tipNombramiento) {
		this.tipNombramiento = tipNombramiento;
	}
}
