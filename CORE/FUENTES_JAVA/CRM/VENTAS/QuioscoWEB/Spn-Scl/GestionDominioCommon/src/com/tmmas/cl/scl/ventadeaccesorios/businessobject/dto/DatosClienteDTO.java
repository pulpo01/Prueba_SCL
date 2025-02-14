package com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto;

import java.io.Serializable;

public class DatosClienteDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String 		 codigoTipIdentif;
	private String 		 descipcionTipIdentif;
	private String 		 numIdent;
	private String 		 nomCliente;
	private String 		 apellidoPaterno;
	private String 		 apellidoMaterno;
	private int    		 codCategoria;
	private String 		 descripcionCategoria;	
	private DireccionDTO direccionDTO;
	private ClienteDTO   cliente;
	//INICIO P-CSR-11002
	private String		 codCategoriaCambio;
	private String		 desCategoriaCambio;
	private String       codCrediticia;
	private String       desCrediticia;
	//FIN P-CSR-11002
	
	private int 		 codError;
	private String 		 msgError;	
	private int 		 numEvento;
	
	public String getApellidoMaterno() {
		return apellidoMaterno;
	}
	public void setApellidoMaterno(String apellidoMaterno) {
		this.apellidoMaterno = apellidoMaterno;
	}
	public String getApellidoPaterno() {
		return apellidoPaterno;
	}
	public void setApellidoPaterno(String apellidoPaterno) {
		this.apellidoPaterno = apellidoPaterno;
	}
	public ClienteDTO getCliente() {
		return cliente;
	}
	public void setCliente(ClienteDTO cliente) {
		this.cliente = cliente;
	}
	public int getCodCategoria() {
		return codCategoria;
	}
	public void setCodCategoria(int codCategoria) {
		this.codCategoria = codCategoria;
	}
	public String getCodigoTipIdentif() {
		return codigoTipIdentif;
	}
	public void setCodigoTipIdentif(String codigoTipIdentif) {
		this.codigoTipIdentif = codigoTipIdentif;
	}
	public String getDescipcionTipIdentif() {
		return descipcionTipIdentif;
	}
	public void setDescipcionTipIdentif(String descipcionTipIdentif) {
		this.descipcionTipIdentif = descipcionTipIdentif;
	}
	public String getDescripcionCategoria() {
		return descripcionCategoria;
	}
	public void setDescripcionCategoria(String descripcionCategoria) {
		this.descripcionCategoria = descripcionCategoria;
	}
	public DireccionDTO getDireccionDTO() {
		return direccionDTO;
	}
	public void setDireccionDTO(DireccionDTO direccionDTO) {
		this.direccionDTO = direccionDTO;
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
	public String getCodCategoriaCambio() {
		return codCategoriaCambio;
	}
	public void setCodCategoriaCambio(String codCategoriaCambio) {
		this.codCategoriaCambio = codCategoriaCambio;
	}
	public String getCodCrediticia() {
		return codCrediticia;
	}
	public void setCodCrediticia(String codCrediticia) {
		this.codCrediticia = codCrediticia;
	}	
	public String getDesCategoriaCambio() {
		return desCategoriaCambio;
	}
	public void setDesCategoriaCambio(String desCategoriaCambio) {
		this.desCategoriaCambio = desCategoriaCambio;
	}
	public String getDesCrediticia() {
		return desCrediticia;
	}
	public void setDesCrediticia(String desCrediticia) {
		this.desCrediticia = desCrediticia;
	}	
	
}
