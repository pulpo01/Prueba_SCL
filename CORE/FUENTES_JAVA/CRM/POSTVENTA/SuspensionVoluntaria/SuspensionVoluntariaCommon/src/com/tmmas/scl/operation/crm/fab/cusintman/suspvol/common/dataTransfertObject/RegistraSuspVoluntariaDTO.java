package com.tmmas.scl.operation.crm.fab.cusintman.suspvol.common.dataTransfertObject;

import java.io.Serializable;

import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.SuspensionAbonadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PresupuestoDTO;

public class RegistraSuspVoluntariaDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	// -- Cargos
	private PresupuestoDTO presupuestoDTO;
	private RegCargosDTO regCargosDTO;
	private String CmbCiclo;
	private ClienteOSSesionDTO clienteOSSesionDTO;
	private UsuarioSistemaDTO usuarioSistemaDTO; 
	private String montoTotal;
	private ObtencionCargosDTO obtencionCargosDTO; 
	private boolean oossComisionable;
	private String comentario;
	
	// -- OOSS
	private SuspensionAbonadoDTO suspension;
	private String opcionProceso;
	private ClienteOSSesionDTO sessionData;
	
	
	public ClienteOSSesionDTO getSessionData() {
		return sessionData;
	}

	public void setSessionData(ClienteOSSesionDTO sessionData) {
		this.sessionData = sessionData;
	}

	public String getOpcionProceso() {
		return opcionProceso;
	}

	public void setOpcionProceso(String opcionProceso) {
		this.opcionProceso = opcionProceso;
	}

	public SuspensionAbonadoDTO getSuspension() {
		return suspension;
	}

	public void setSuspension(SuspensionAbonadoDTO suspension) {
		this.suspension = suspension;
	}

	public String getComentario() {
		return comentario;
	}

	public void setComentario(String comentario) {
		this.comentario = comentario;
	}

	public boolean getOossComisionable() {
		return oossComisionable;
	}

	public void setOossComisionable(boolean oossComisionable) {
		this.oossComisionable = oossComisionable;
	}

	public ObtencionCargosDTO getObtencionCargosDTO() {
		return obtencionCargosDTO;
	}

	public void setObtencionCargosDTO(ObtencionCargosDTO obtencionCargosDTO) {
		this.obtencionCargosDTO = obtencionCargosDTO;
	}

	public String getMontoTotal() {
		return montoTotal;
	}

	public void setMontoTotal(String montoTotal) {
		this.montoTotal = montoTotal;
	}

	public ClienteOSSesionDTO getClienteOSSesionDTO() {
		return clienteOSSesionDTO;
	}

	public void setClienteOSSesionDTO(ClienteOSSesionDTO clienteOSSesionDTO) {
		this.clienteOSSesionDTO = clienteOSSesionDTO;
	}

	
	public UsuarioSistemaDTO getUsuarioSistemaDTO() {
		return usuarioSistemaDTO;
	}

	public void setUsuarioSistemaDTO(UsuarioSistemaDTO usuarioSistemaDTO) {
		this.usuarioSistemaDTO = usuarioSistemaDTO;
	}

	public String getCmbCiclo() {
		return CmbCiclo;
	}

	public void setCmbCiclo(String cmbCiclo) {
		CmbCiclo = cmbCiclo;
	}

	public PresupuestoDTO getPresupuestoDTO() {
		return presupuestoDTO;
	}

	public void setPresupuestoDTO(PresupuestoDTO presupuestoDTO) {
		this.presupuestoDTO = presupuestoDTO;
	}

	public RegCargosDTO getRegCargosDTO() {
		return regCargosDTO;
	}

	public void setRegCargosDTO(RegCargosDTO regCargosDTO) {
		this.regCargosDTO = regCargosDTO;
	}
}
