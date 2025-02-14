package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class FichaClienteDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private long numAbonado;
	private String nomCliente;
	private String fecNacimiento;
	private String profesion;
	private String telefono;
	private String glosaDir;
	private String glosaIdent;
	private long codVendealer;
	private String nomVendealer;
	private String desOficina;
	private String nomVendedor;
	private String descTerminal;
	private String icc;
	private String imei;
	private String nomUsuarora;
	private long numCelular;
	
	public long getCodVendealer() {
		return codVendealer;
	}
	public void setCodVendealer(long codVendealer) {
		this.codVendealer = codVendealer;
	}
	public String getDescTerminal() {
		return descTerminal;
	}
	public void setDescTerminal(String descTerminal) {
		this.descTerminal = descTerminal;
	}
	public String getDesOficina() {
		return desOficina;
	}
	public void setDesOficina(String desOficina) {
		this.desOficina = desOficina;
	}
	public String getFecNacimiento() {
		return fecNacimiento;
	}
	public void setFecNacimiento(String fecNacimiento) {
		this.fecNacimiento = fecNacimiento;
	}
	public String getGlosaDir() {
		return glosaDir;
	}
	public void setGlosaDir(String glosaDir) {
		this.glosaDir = glosaDir;
	}
	public String getGlosaIdent() {
		return glosaIdent;
	}
	public void setGlosaIdent(String glosaIdent) {
		this.glosaIdent = glosaIdent;
	}
	public String getIcc() {
		return icc;
	}
	public void setIcc(String icc) {
		this.icc = icc;
	}
	public String getImei() {
		return imei;
	}
	public void setImei(String imei) {
		this.imei = imei;
	}
	public String getNomCliente() {
		return nomCliente;
	}
	public void setNomCliente(String nomCliente) {
		this.nomCliente = nomCliente;
	}
	public String getNomUsuarora() {
		return nomUsuarora;
	}
	public void setNomUsuarora(String nomUsuarora) {
		this.nomUsuarora = nomUsuarora;
	}
	public String getNomVendealer() {
		return nomVendealer;
	}
	public void setNomVendealer(String nomVendealer) {
		this.nomVendealer = nomVendealer;
	}
	public String getNomVendedor() {
		return nomVendedor;
	}
	public void setNomVendedor(String nomVendedor) {
		this.nomVendedor = nomVendedor;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public long getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(long numCelular) {
		this.numCelular = numCelular;
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
	

}
