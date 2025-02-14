package com.tmmas.scl.serviciospostventasiga.transport;

import java.io.Serializable;


public class MigracionDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Long numCelular;
	private Long codCliente;
	private String codOficina;
	private String codPlanTarif;
	private String nomUsuarioVendedor;
	private String Imei;
	private String indProcEqTerminal;


	public String getIndProcEqTerminal() {
		return indProcEqTerminal;
	}
	public void setIndProcEqTerminal(String indProcEqTerminal) {
		this.indProcEqTerminal = indProcEqTerminal;
	}
	public String getImei() {
		return Imei;
	}
	public void setImei(String imei) {
		Imei = imei;
	}
	public Long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(Long codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodPlanTarif() {
		return codPlanTarif;
	}
	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}
	public String getNomUsuarioVendedor() {
		return nomUsuarioVendedor;
	}
	public void setNomUsuarioVendedor(String nomUsuarioVendedor) {
		this.nomUsuarioVendedor = nomUsuarioVendedor;
	}
	public Long getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(Long numCelular) {
		this.numCelular = numCelular;
	}
	public String getCodOficina() {
		return codOficina;
	}
	public void setCodOficina(String codOficina) {
		this.codOficina = codOficina;
	}
	
}
