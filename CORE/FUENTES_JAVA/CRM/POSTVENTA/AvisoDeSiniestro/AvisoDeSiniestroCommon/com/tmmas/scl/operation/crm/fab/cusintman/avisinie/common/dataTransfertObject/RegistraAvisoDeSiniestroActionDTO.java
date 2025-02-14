package com.tmmas.scl.operation.crm.fab.cusintman.avisinie.common.dataTransfertObject;

import java.io.Serializable;

import com.tmmas.scl.framework.ProductDomain.dto.CausaSiniestroDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoSiniestroDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoSuspencionDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PresupuestoDTO;

public class RegistraAvisoDeSiniestroActionDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private UsuarioAbonadoDTO usuarioAbonadoDTO;
	private TipoSiniestroDTO tipoSiniestroDTO;
	private TipoSuspencionDTO tipoSuspencionDTO;
	private CausaSiniestroDTO causaSiniestroDTO;
	private UsuarioSistemaDTO usuarioSistemaDTO;
	private String numOS;
	private String comentario;
	private PresupuestoDTO presupuestoDTO;
	private RegCargosDTO regCargosDTO;
	private String cmbCiclo;
	
	//Inicio Inc. 174755/CSR-11002/06-09-2011/FDL
	private Long nroCelularDesviado;
	//Fin Inc. 174755/CSR-11002/06-09-2011/FDL
	
	public String getCmbCiclo() {
		return cmbCiclo;
	}
	public void setCmbCiclo(String cmbCiclo) {
		this.cmbCiclo = cmbCiclo;
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
	public CausaSiniestroDTO getCausaSiniestroDTO() {
		return causaSiniestroDTO;
	}
	public void setCausaSiniestroDTO(CausaSiniestroDTO causaSiniestroDTO) {
		this.causaSiniestroDTO = causaSiniestroDTO;
	}
	public String getComentario() {
		return comentario;
	}
	public void setComentario(String comentario) {
		this.comentario = comentario;
	}
	public String getNumOS() {
		return numOS;
	}
	public void setNumOS(String numOS) {
		this.numOS = numOS;
	}
	public TipoSiniestroDTO getTipoSiniestroDTO() {
		return tipoSiniestroDTO;
	}
	public void setTipoSiniestroDTO(TipoSiniestroDTO tipoSiniestroDTO) {
		this.tipoSiniestroDTO = tipoSiniestroDTO;
	}
	public TipoSuspencionDTO getTipoSuspencionDTO() {
		return tipoSuspencionDTO;
	}
	public void setTipoSuspencionDTO(TipoSuspencionDTO tipoSuspencionDTO) {
		this.tipoSuspencionDTO = tipoSuspencionDTO;
	}
	public UsuarioAbonadoDTO getUsuarioAbonadoDTO() {
		return usuarioAbonadoDTO;
	}
	public void setUsuarioAbonadoDTO(UsuarioAbonadoDTO usuarioAbonadoDTO) {
		this.usuarioAbonadoDTO = usuarioAbonadoDTO;
	}
	public UsuarioSistemaDTO getUsuarioSistemaDTO() {
		return usuarioSistemaDTO;
	}
	public void setUsuarioSistemaDTO(UsuarioSistemaDTO usuarioSistemaDTO) {
		this.usuarioSistemaDTO = usuarioSistemaDTO;
	}
	
	//Inicio Inc. 174755/CSR-11002/06-09-2011/FDL
	public Long getNroCelularDesviado() {
		return nroCelularDesviado;
	}
	public void setNroCelularDesviado(Long nroCelularDesviado) {
		this.nroCelularDesviado = nroCelularDesviado;
	}
	//Fin Inc. 174755/CSR-11002/06-09-2011/FDL
	
}
