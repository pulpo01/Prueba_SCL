package com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto;

import java.io.Serializable;

public class VendedorDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private long 	codVendedor;
	private long 	codVendedorAgente;
	private String 	codOficina;
	private String 	codTipComis;
	private String 	codCiudad;
	private String 	codRegion;
	private String 	codProvincia;
	private String 	codPlaza;
	
	public String getCodCiudad() {
		return codCiudad;
	}
	public void setCodCiudad(String codCiudad) {
		this.codCiudad = codCiudad;
	}
	public String getCodOficina() {
		return codOficina;
	}
	public void setCodOficina(String codOficina) {
		this.codOficina = codOficina;
	}
	public String getCodPlaza() {
		return codPlaza;
	}
	public void setCodPlaza(String codPlaza) {
		this.codPlaza = codPlaza;
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
	public String getCodTipComis() {
		return codTipComis;
	}
	public void setCodTipComis(String codTipComis) {
		this.codTipComis = codTipComis;
	}
	public long getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(long codVendedor) {
		this.codVendedor = codVendedor;
	}
	public long getCodVendedorAgente() {
		return codVendedorAgente;
	}
	public void setCodVendedorAgente(long codVendedorAgente) {
		this.codVendedorAgente = codVendedorAgente;
	}
}
