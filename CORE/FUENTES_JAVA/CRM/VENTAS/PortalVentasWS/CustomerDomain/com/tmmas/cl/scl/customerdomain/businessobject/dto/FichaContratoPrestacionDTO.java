package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class FichaContratoPrestacionDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String nomCliente;
	private String telefono;
	private String profesion;
	private String numIdent2;
	private String glosaDir;
	private String numIdent;
	private String desModVenta;
	private long numMeses;
	private long numFolio;
	
	DetalleFichaContratoPrestacionDTO detalle[];
	

	public DetalleFichaContratoPrestacionDTO[] getDetalle() {
		return detalle;
	}

	public void setDetalle(DetalleFichaContratoPrestacionDTO[] detalle) {
		this.detalle = detalle;
	}

	public String getGlosaDir() {
		return glosaDir;
	}

	public void setGlosaDir(String glosaDir) {
		this.glosaDir = glosaDir;
	}

	public String getNomCliente() {
		return nomCliente;
	}

	public void setNomCliente(String nomCliente) {
		this.nomCliente = nomCliente;
	}

	public String getNumIdent() {
		return numIdent;
	}

	public void setNumIdent(String numIdent) {
		this.numIdent = numIdent;
	}

	public String getNumIdent2() {
		return numIdent2;
	}

	public void setNumIdent2(String numIdent2) {
		this.numIdent2 = numIdent2;
	}

	public long getNumMeses() {
		return numMeses;
	}

	public void setNumMeses(long numMeses) {
		this.numMeses = numMeses;
	}

	public String getProfesion() {
		return profesion;
	}

	public void setProfesion(String profesion) {
		this.profesion = profesion;
	}

	public String getTelefono() {
		return telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	public String getDesModVenta() {
		return desModVenta;
	}

	public void setDesModVenta(String desModVenta) {
		this.desModVenta = desModVenta;
	}

	public long getNumFolio() {
		return numFolio;
	}

	public void setNumFolio(long numFolio) {
		this.numFolio = numFolio;
	}

	
}
