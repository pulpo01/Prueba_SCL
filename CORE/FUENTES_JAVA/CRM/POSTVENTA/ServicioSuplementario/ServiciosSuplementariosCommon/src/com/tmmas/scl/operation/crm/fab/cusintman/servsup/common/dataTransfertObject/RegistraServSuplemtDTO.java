package com.tmmas.scl.operation.crm.fab.cusintman.servsup.common.dataTransfertObject;

import java.io.Serializable;

import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PresupuestoDTO;
import com.tmmas.scl.vendedor.dto.VendedorDTO;

public class RegistraServSuplemtDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private PresupuestoDTO presupuestoDTO;
	private RegCargosDTO regCargosDTO;
	private String CmbCiclo;
	private String contratTabla;
	private String noContratTabla;
	private String contactosTabla;
	private ClienteOSSesionDTO clienteOSSesionDTO;
	private UsuarioSistemaDTO usuarioSistemaDTO; 
	private String montoTotal;
	private VendedorDTO vendedorDTO;
	private ObtencionCargosDTO obtencionCargosDTO; 
	private boolean oossComisionable;
	private String comentario;
	private String grabarFax;
	private String numeroFax;
	
	
	public String getGrabarFax() {
		return grabarFax;
	}

	public void setGrabarFax(String grabarFax) {
		this.grabarFax = grabarFax;
	}

	public String getNumeroFax() {
		return numeroFax;
	}

	public void setNumeroFax(String numeroFax) {
		this.numeroFax = numeroFax;
	}

	public String getContactosTabla() {
		return contactosTabla;
	}

	public void setContactosTabla(String contactosTabla) {
		this.contactosTabla = contactosTabla;
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

	public String getContratTabla() {
		return contratTabla;
	}

	public void setContratTabla(String contratTabla) {
		this.contratTabla = contratTabla;
	}

	public String getNoContratTabla() {
		return noContratTabla;
	}

	public void setNoContratTabla(String noContratTabla) {
		this.noContratTabla = noContratTabla;
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

	public VendedorDTO getVendedorDTO() {
		return vendedorDTO;
	}

	public void setVendedorDTO(VendedorDTO vendedorDTO) {
		this.vendedorDTO = vendedorDTO;
	}
}
