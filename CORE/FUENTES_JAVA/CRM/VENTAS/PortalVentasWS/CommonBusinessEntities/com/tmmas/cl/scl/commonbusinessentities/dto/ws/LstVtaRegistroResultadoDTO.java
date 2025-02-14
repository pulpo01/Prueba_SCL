package com.tmmas.cl.scl.commonbusinessentities.dto.ws;

import java.io.Serializable;

public class LstVtaRegistroResultadoDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private String codigoVendedor;
	private String nombreVendedor;
	private LstVtaRegistroVentaOutDTO[] registroVentas;
	
	private Long codError;
	private String msgError;
	private Long codEvento;
	
	public Long getCodEvento() {
		return codEvento;
	}
	public void setCodEvento(Long codEvento) {
		this.codEvento = codEvento;
	}
	public String getMsgError() {
		return msgError;
	}
	public void setMsgError(String msgError) {
		this.msgError = msgError;
	}
	public Long getCodError() {
		return codError;
	}
	public void setCodError(Long codError) {
		this.codError = codError;
	}
	public LstVtaRegistroVentaOutDTO[] getRegistroVentas() {
		return registroVentas;
	}
	public void setRegistroVentas(LstVtaRegistroVentaOutDTO[] registroVentas) {
		this.registroVentas = registroVentas;
	}
	public String getCodigoVendedor() {
		return codigoVendedor;
	}
	public void setCodigoVendedor(String codigoVendedor) {
		this.codigoVendedor = codigoVendedor;
	}
	public String getNombreVendedor() {
		return nombreVendedor;
	}
	public void setNombreVendedor(String nombreVendedor) {
		this.nombreVendedor = nombreVendedor;
	}

}
