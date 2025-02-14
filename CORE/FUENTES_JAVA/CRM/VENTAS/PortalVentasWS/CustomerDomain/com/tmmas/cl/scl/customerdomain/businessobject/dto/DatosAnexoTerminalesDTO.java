package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class DatosAnexoTerminalesDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String nomCliente;
	private String tipIdent;
	private String numIdent;
	AnexoTerminalDTO[] anexoTerminalDTOs;
	
	public AnexoTerminalDTO[] getAnexoTerminalDTOs() {
		return anexoTerminalDTOs;
	}
	public void setAnexoTerminalDTOs(AnexoTerminalDTO[] anexoTerminalDTOs) {
		this.anexoTerminalDTOs = anexoTerminalDTOs;
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
	public String getTipIdent() {
		return tipIdent;
	}
	public void setTipIdent(String tipIdent) {
		this.tipIdent = tipIdent;
	}
}
