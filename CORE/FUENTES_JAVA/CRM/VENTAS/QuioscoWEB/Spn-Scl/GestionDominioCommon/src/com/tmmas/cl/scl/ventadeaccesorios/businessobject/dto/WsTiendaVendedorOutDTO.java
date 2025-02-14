package com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto;

import java.io.Serializable;

public class WsTiendaVendedorOutDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String desTienda;
	private String nomUsuario;
	private String desBodega;
	private String nomVendedor;
	private String codCaja;
	private String desCaja;
	private String codOficina;
	private String numIdentCli;
	private String codCliente; 
	private String codCuenta; 
	private String codDireccion; 
	private String indApliPAgo;
	
	
	private String codVendedor; // Codigo de vendedor
	private String codBodega;
	
	private int 			codError;
	private String 			msgError;	
	private int 			numEvento;
	

	public int getCodError() {
		return codError;
	}
	public void setCodError(int codError) {
		this.codError = codError;
	}
	public String getDesBodega() {
		return desBodega;
	}
	public void setDesBodega(String desBodega) {
		this.desBodega = desBodega;
	}
	public String getDesTienda() {
		return desTienda;
	}
	public void setDesTienda(String desTienda) {
		this.desTienda = desTienda;
	}
	public String getMsgError() {
		return msgError;
	}
	public void setMsgError(String msgError) {
		this.msgError = msgError;
	}
	public String getNomUsuario() {
		return nomUsuario;
	}
	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}
	public String getNomVendedor() {
		return nomVendedor;
	}
	public void setNomVendedor(String nomVendedor) {
		this.nomVendedor = nomVendedor;
	}
	public int getNumEvento() {
		return numEvento;
	}
	public void setNumEvento(int numEvento) {
		this.numEvento = numEvento;
	}
	public String getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(String codVendedor) {
		this.codVendedor = codVendedor;
	}
	public String getCodCaja() {
		return codCaja;
	}
	public void setCodCaja(String codCaja) {
		this.codCaja = codCaja;
	}
	public String getCodOficina() {
		return codOficina;
	}
	public void setCodOficina(String codOficina) {
		this.codOficina = codOficina;
	}
	public String getDesCaja() {
		return desCaja;
	}
	public void setDesCaja(String desCaja) {
		this.desCaja = desCaja;
	}
	public String getNumIdentCli() {
		return numIdentCli;
	}
	public void setNumIdentCli(String numIdentCli) {
		this.numIdentCli = numIdentCli;
	}
	public String getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodCuenta() {
		return codCuenta;
	}
	public void setCodCuenta(String codCuenta) {
		this.codCuenta = codCuenta;
	}
	public String getCodDireccion() {
		return codDireccion;
	}
	public void setCodDireccion(String codDireccion) {
		this.codDireccion = codDireccion;
	}
	public String getCodBodega() {
		return codBodega;
	}
	public void setCodBodega(String codBodega) {
		this.codBodega = codBodega;
	}
	public String getIndApliPAgo() {
		return indApliPAgo;
	}
	public void setIndApliPAgo(String indApliPAgo) {
		this.indApliPAgo = indApliPAgo;
	}
}
