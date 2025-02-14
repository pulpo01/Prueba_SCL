package com.tmmas.scl.operation.crm.fab.cusintman.anulsinie.common.dataTransfertObject;

import java.io.Serializable;

import com.tmmas.scl.framework.ProductDomain.dto.SiniestrosDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PresupuestoDTO;

public class RegistrarAnulacionSiniestroDTO implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private SiniestrosDTO siniestrosDTO;
    private UsuarioAbonadoDTO usuarioAbonadoDTO;
    private SesionDTO sesionDTO;
    private PresupuestoDTO presupuestoDTO;
    private RegCargosDTO regCargosDTO;
    private String cmbCiclo;
    private String indMantListaNegra; 
    
    
	public String getIndMantListaNegra() {
		return indMantListaNegra;
	}
	public void setIndMantListaNegra(String indMantListaNegra) {
		this.indMantListaNegra = indMantListaNegra;
	}
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
	public SesionDTO getSesionDTO() {
		return sesionDTO;
	}
	public void setSesionDTO(SesionDTO sesionDTO) {
		this.sesionDTO = sesionDTO;
	}
	public SiniestrosDTO getSiniestrosDTO() {
		return siniestrosDTO;
	}
	public void setSiniestrosDTO(SiniestrosDTO siniestrosDTO) {
		this.siniestrosDTO = siniestrosDTO;
	}
	public UsuarioAbonadoDTO getUsuarioAbonadoDTO() {
		return usuarioAbonadoDTO;
	}
	public void setUsuarioAbonadoDTO(UsuarioAbonadoDTO usuarioAbonadoDTO) {
		this.usuarioAbonadoDTO = usuarioAbonadoDTO;
	}
	

}
