package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;
import java.util.Date;


public class DistribuidorResponseDTO implements Serializable  {
    /**
	 * Autor : Alejandro Lorca
	 */
	private static final long serialVersionUID = 1L;

	private String nomVendedor;
	private String codTipident;
	private String desTipident;
	private String numIdent;
	private String codCliente;
	
    private DistribBodegasDTO[] bodegasList;
    private RespuestaDTO respuesta;
    
	public DistribBodegasDTO[] getBodegasList() {
		return bodegasList;
	}
	public void setBodegasList(DistribBodegasDTO[] bodegasList) {
		this.bodegasList = bodegasList;
	}

	public String getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}
	
	public String getCodTipident() {
		return codTipident;
	}
	public void setCodTipident(String codTipident) {
		this.codTipident = codTipident;
	}
	
	public String getDesTipident() {
		return desTipident;
	}
	public void setDesTipident(String desTipident) {
		this.desTipident = desTipident;
	}
	public String getNomVendedor() {
		return nomVendedor;
	}
	public void setNomVendedor(String nomVendedor) {
		this.nomVendedor = nomVendedor;
	}
	
	
	public String getNumIdent() {
		return numIdent;
	}
	public void setNumIdent(String numIdent) {
		this.numIdent = numIdent;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	    
}