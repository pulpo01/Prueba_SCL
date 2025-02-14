package com.tmmas.scl.serviciospostventasiga.transport;

import java.io.Serializable;

public class UsuarioSIGADTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String numAbonado;
	private String nomUsuario;
	private String nomApellido;
	private String fecAlta;
	private String codTipIdent;
	private String numIdent;
	private String indEstado;
	private String IndSituacion;
	private String nomApellido2;
	private String fecNaci;
	
	private String codEstCivil;
	private String indSexo;
	private String indTipoTrab;
	private String nomEmpresa;
	private String codActemp;
	private String codOcupacion;
	private String numPerCargo;
	private String impBruto;
	private String indProcoper;

	private String nomConyuge;
	private String codPinUsuar;
	private String codRetorno;
	private String mensRetorno;

	
	
	
	private long codigoUsuario;
	private String codError;
	private String desError;
	private Integer numEvento;
	private boolean exitoCreacionUsuario;
	private ClienteSIGADTO clienteSIGADTO;
	private String codOperadora;

	public String getCodOperadora() {
		return codOperadora;
	}

	public void setCodOperadora(String codOperadora) {
		this.codOperadora = codOperadora;
	}

	public ClienteSIGADTO getClienteSIGADTO() {
		return clienteSIGADTO;
	}

	public void setClienteSIGADTO(ClienteSIGADTO clienteSIGADTO) {
		this.clienteSIGADTO = clienteSIGADTO;
	}

	public String getIndSituacion() {
		return IndSituacion;
	}

	public void setIndSituacion(String indSituacion) {
		IndSituacion = indSituacion;
	}

	public long getCodigoUsuario() {
		return codigoUsuario;
	}

	public void setCodigoUsuario(long codUsuario) {
		this.codigoUsuario = codUsuario;
	}

	public String getCodError() {
		return codError;
	}

	public void setCodError(String codError) {
		this.codError = codError;
	}

	public String getDesError() {
		return desError;
	}

	public void setDesError(String desError) {
		this.desError = desError;
	}

	public Integer getNumEvento() {
		return numEvento;
	}

	public void setNumEvento(Integer numEvento) {
		this.numEvento = numEvento;
	}

	public void setExitoCreacionUsuario(boolean exitoCreacionUsuario) {
		this.exitoCreacionUsuario = exitoCreacionUsuario;		
	}
	
	public boolean getExitoCreacionUsuario() {
		return exitoCreacionUsuario;		
	}

	public String getNumAbonado() {
		return numAbonado;
	}

	public void setNumAbonado(String numAbonado) {
		this.numAbonado = numAbonado;
	}

	public String getNomUsuario() {
		return nomUsuario;
	}

	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}

	public String getNomApellido() {
		return nomApellido;
	}

	public void setNomApellido(String nomApellido) {
		this.nomApellido = nomApellido;
	}

	public String getFecAlta() {
		return fecAlta;
	}

	public void setFecAlta(String fecAlta) {
		this.fecAlta = fecAlta;
	}

	public String getCodTipIdent() {
		return codTipIdent;
	}

	public void setCodTipIdent(String codTipIdent) {
		this.codTipIdent = codTipIdent;
	}

	public String getNumIdent() {
		return numIdent;
	}

	public void setNumIdent(String numIdent) {
		this.numIdent = numIdent;
	}

	public String getIndEstado() {
		return indEstado;
	}

	public void setIndEstado(String indEstado) {
		this.indEstado = indEstado;
	}

	public String getNomApellido2() {
		return nomApellido2;
	}

	public void setNomApellido2(String nomApellido2) {
		this.nomApellido2 = nomApellido2;
	}

	public String getFecNaci() {
		return fecNaci;
	}

	public void setFecNaci(String fecNaci) {
		this.fecNaci = fecNaci;
	}


	public String getCodEstCivil() {
		return codEstCivil;
	}

	public void setCodEstCivil(String codEstCivil) {
		this.codEstCivil = codEstCivil;
	}

	public String getMensRetorno() {
		return mensRetorno;
	}

	public void setMensRetorno(String mensRetorno) {
		this.mensRetorno = mensRetorno;
	}

	public String getCodActemp() {
		return codActemp;
	}

	public void setCodActemp(String codActemp) {
		this.codActemp = codActemp;
	}


	public String getCodOcupacion() {
		return codOcupacion;
	}

	public void setCodOcupacion(String codOcupacion) {
		this.codOcupacion = codOcupacion;
	}

	public String getCodPinUsuar() {
		return codPinUsuar;
	}

	public void setCodPinUsuar(String codPinUsuar) {
		this.codPinUsuar = codPinUsuar;
	}

	public String getCodRetorno() {
		return codRetorno;
	}

	public void setCodRetorno(String codRetorno) {
		this.codRetorno = codRetorno;
	}

	public String getImpBruto() {
		return impBruto;
	}

	public void setImpBruto(String impBruto) {
		this.impBruto = impBruto;
	}

	public String getIndProcoper() {
		return indProcoper;
	}

	public void setIndProcoper(String indProcoper) {
		this.indProcoper = indProcoper;
	}

	public String getIndSexo() {
		return indSexo;
	}

	public void setIndSexo(String indSexo) {
		this.indSexo = indSexo;
	}

	public String getIndTipoTrab() {
		return indTipoTrab;
	}

	public void setIndTipoTrab(String indTipoTrab) {
		this.indTipoTrab = indTipoTrab;
	}

	public String getNomConyuge() {
		return nomConyuge;
	}

	public void setNomConyuge(String nomConyuge) {
		this.nomConyuge = nomConyuge;
	}

	public String getNomEmpresa() {
		return nomEmpresa;
	}

	public void setNomEmpresa(String nomEmpresa) {
		this.nomEmpresa = nomEmpresa;
	}

	public String getNumPerCargo() {
		return numPerCargo;
	}

	public void setNumPerCargo(String numPerCargo) {
		this.numPerCargo = numPerCargo;
	} 
}
