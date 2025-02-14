package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class TipoContratoClienteDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Long codCliente;
	private String codPlanTarif;
	private Long codUso;
	private Long codProducto;
	private String codTipContrato;
	private String nombreContrato;
	private Long nroMesesContrato;
	private String nomUsuario;
	
	public String getNomUsuario() {
		return nomUsuario;
	}
	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}
	public Long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(Long codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodPlanTarif() {
		return codPlanTarif;
	}
	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}
	public Long getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(Long codProducto) {
		this.codProducto = codProducto;
	}
	public String getCodTipContrato() {
		return codTipContrato;
	}
	public void setCodTipContrato(String codTipContrato) {
		this.codTipContrato = codTipContrato;
	}
	public Long getCodUso() {
		return codUso;
	}
	public void setCodUso(Long codUso) {
		this.codUso = codUso;
	}
	public String getNombreContrato() {
		return nombreContrato;
	}
	public void setNombreContrato(String nombreContrato) {
		this.nombreContrato = nombreContrato;
	}
	public Long getNroMesesContrato() {
		return nroMesesContrato;
	}
	public void setNroMesesContrato(Long nroMesesContrato) {
		this.nroMesesContrato = nroMesesContrato;
	}
	
		
}
