package com.tmmas.cl.scl.spnsclwscommon.quiosco.dto;

import java.io.Serializable;


public class WsStructuraClienteDTO implements Serializable{
	
	
	
	
	private WsStructuraActivacionLineaDTO activacion;
	private WsDireccionQuioscoInDTO       direccion;
	private WsStructuraAccesorioDTO[]     accesorios;
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String NombreCliente;
	private String NombreApeclien1;
	private String NombreApeclien2;			
	private String CodigoTipoIdent;  
	private String NumeroIdent;
    private String codigoOficina; 
    private String codigoCliente;
    private String codigoCategoria;
    private String codigoCategoriaCambio;
    private String codCrediticia;
    
    

	public String getCodigoCategoriaCambio() {
		return codigoCategoriaCambio;
	}
	public void setCodigoCategoriaCambio(String codigoCategoriaCambio) {
		this.codigoCategoriaCambio = codigoCategoriaCambio;
	}
	public String getCodCrediticia() {
		return codCrediticia;
	}
	public void setCodCrediticia(String codCrediticia) {
		this.codCrediticia = codCrediticia;
	}
	public String getCodigoCategoria() {
		return codigoCategoria;
	}
	public void setCodigoCategoria(String codigoCategoria) {
		this.codigoCategoria = codigoCategoria;
	}
	public String getCodigoOficina() {
		return codigoOficina;
	}
	public void setCodigoOficina(String codigoOficina) {
		this.codigoOficina = codigoOficina;
	}
	public String getCodigoTipoIdent() {
		return CodigoTipoIdent;
	}
	public void setCodigoTipoIdent(String codigoTipoIdent) {
		CodigoTipoIdent = codigoTipoIdent;
	}
	public String getNombreApeclien1() {
		return NombreApeclien1;
	}
	public void setNombreApeclien1(String nombreApeclien1) {
		NombreApeclien1 = nombreApeclien1;
	}
	public String getNombreApeclien2() {
		return NombreApeclien2;
	}
	public void setNombreApeclien2(String nombreApeclien2) {
		NombreApeclien2 = nombreApeclien2;
	}
	public String getNombreCliente() {
		return NombreCliente;
	}
	public void setNombreCliente(String nombreCliente) {
		NombreCliente = nombreCliente;
	}
	public String getNumeroIdent() {
		return NumeroIdent;
	}
	public void setNumeroIdent(String numeroIdent) {
		NumeroIdent = numeroIdent;
	}
	public WsStructuraActivacionLineaDTO getActivacion() {
		return activacion;
	}
	public void setActivacion(WsStructuraActivacionLineaDTO activacion) {
		this.activacion = activacion;
	}
	public String getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public WsDireccionQuioscoInDTO getDireccion() {
		return direccion;
	}
	public void setDireccion(WsDireccionQuioscoInDTO direccion) {
		this.direccion = direccion;
	}
	public WsStructuraAccesorioDTO[] getAccesorios() {
		return accesorios;
	}
	public void setAccesorios(WsStructuraAccesorioDTO[] accesorios) {
		this.accesorios = accesorios;
	}
	

}
