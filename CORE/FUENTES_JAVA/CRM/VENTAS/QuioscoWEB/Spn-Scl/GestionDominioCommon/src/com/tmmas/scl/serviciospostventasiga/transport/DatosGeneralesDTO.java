package com.tmmas.scl.serviciospostventasiga.transport;

import java.io.Serializable;

public class DatosGeneralesDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Long numSolicitud;
	private Long valCantTerminales;
	private String codOficina;
	private String codTipComis;
	private String codVendedor;
	private String codVendedorAgente;
	private String codVendedorDealer;
	private String codPlanTarif;
	private String codEstado;
	private String valCantVendidos;
	private String numIdent;
	
	
	
	private String nomParametro;
	private String codModulo;
	private String codProducto;
	
	private String valorParametro;
	
	
	
	public String getValorParametro() {
		return valorParametro;
	}
	public void setValorParametro(String valorParametro) {
		this.valorParametro = valorParametro;
	}
	public String getCodModulo() {
		return codModulo;
	}
	public void setCodModulo(String codModulo) {
		this.codModulo = codModulo;
	}
	public String getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(String codProducto) {
		this.codProducto = codProducto;
	}
	public String getNomParametro() {
		return nomParametro;
	}
	public void setNomParametro(String nomParametro) {
		this.nomParametro = nomParametro;
	}
	public String getNumIdent() {
		return numIdent;
	}
	public void setNumIdent(String numIdent) {
		this.numIdent = numIdent;
	}
	public String getCodEstado() {
		return codEstado;
	}
	public void setCodEstado(String codEstado) {
		this.codEstado = codEstado;
	}
	public String getCodOficina() {
		return codOficina;
	}
	public void setCodOficina(String codOficina) {
		this.codOficina = codOficina;
	}
	public String getCodPlanTarif() {
		return codPlanTarif;
	}
	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}
	public String getCodTipComis() {
		return codTipComis;
	}
	public void setCodTipComis(String codTipComis) {
		this.codTipComis = codTipComis;
	}
	public String getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(String codVendedor) {
		this.codVendedor = codVendedor;
	}
	public String getCodVendedorAgente() {
		return codVendedorAgente;
	}
	public void setCodVendedorAgente(String codVendedorAgente) {
		this.codVendedorAgente = codVendedorAgente;
	}
	public String getCodVendedorDealer() {
		return codVendedorDealer;
	}
	public void setCodVendedorDealer(String codVendedorDealer) {
		this.codVendedorDealer = codVendedorDealer;
	}
	public Long getNumSolicitud() {
		return numSolicitud;
	}
	public void setNumSolicitud(Long numSolicitud) {
		this.numSolicitud = numSolicitud;
	}
	public Long getValCantTerminales() {
		return valCantTerminales;
	}
	public void setValCantTerminales(Long valCantTerminales) {
		this.valCantTerminales = valCantTerminales;
	}
	public String getValCantVendidos() {
		return valCantVendidos;
	}
	public void setValCantVendidos(String valCantVendidos) {
		this.valCantVendidos = valCantVendidos;
	}
	
	
}
