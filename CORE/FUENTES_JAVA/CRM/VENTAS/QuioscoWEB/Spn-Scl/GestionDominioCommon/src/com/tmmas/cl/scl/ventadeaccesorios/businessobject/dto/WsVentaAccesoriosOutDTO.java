package com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto;

import java.io.Serializable;

public class WsVentaAccesoriosOutDTO implements Serializable{
	
private static final long serialVersionUID = 1L;
	
	private String 			nombreUsuario;
	private long 			numTransaccion;	
	private String 			tipFoliacion;
	private int				codTipDocument;	
		
	private ArticuloDTO[] 	articulo;
	private VendedorDTO 	vendedor;	
	private VentaDTO		venta;
	private ClienteDTO		cliente;
	
	private int 			codError;
	private String 			msgError;	
	private int 			numEvento;
	
	public ArticuloDTO[] getArticulo() {
		return articulo;
	}
	public void setArticulo(ArticuloDTO[] articulo) {
		this.articulo = articulo;
	}
	public ClienteDTO getCliente() {
		return cliente;
	}
	public void setCliente(ClienteDTO cliente) {
		this.cliente = cliente;
	}	
	public int getCodTipDocument() {
		return codTipDocument;
	}
	public void setCodTipDocument(int codTipDocument) {
		this.codTipDocument = codTipDocument;
	}
	public String getNombreUsuario() {
		return nombreUsuario;
	}
	public void setNombreUsuario(String nombreUsuario) {
		this.nombreUsuario = nombreUsuario;
	}
	public long getNumTransaccion() {
		return numTransaccion;
	}
	public void setNumTransaccion(long numTransaccion) {
		this.numTransaccion = numTransaccion;
	}
	public String getTipFoliacion() {
		return tipFoliacion;
	}
	public void setTipFoliacion(String tipFoliacion) {
		this.tipFoliacion = tipFoliacion;
	}
	public VendedorDTO getVendedor() {
		return vendedor;
	}
	public void setVendedor(VendedorDTO vendedor) {
		this.vendedor = vendedor;
	}
	public VentaDTO getVenta() {
		return venta;
	}
	public void setVenta(VentaDTO venta) {
		this.venta = venta;
	}
	public int getCodError() {
		return codError;
	}
	public void setCodError(int codError) {
		this.codError = codError;
	}
	public String getMsgError() {
		return msgError;
	}
	public void setMsgError(String msgError) {
		this.msgError = msgError;
	}
	public int getNumEvento() {
		return numEvento;
	}
	public void setNumEvento(int numEvento) {
		this.numEvento = numEvento;
	}	
}
