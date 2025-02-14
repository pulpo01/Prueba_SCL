package com.tmmas.scl.operation.crm.fab.cusintman.cambsimcard.common.dataTransferObject;

import java.io.Serializable;

import com.tmmas.scl.framework.ProductDomain.dto.BodegaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaCamSerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CuotaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.UsoArticuloDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistrarOossEnLineaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistrarRenovaDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PresupuestoDTO;
import com.tmmas.scl.vendedor.dto.VendedorDTO;

import com.tmmas.scl.framework.productDomain.dataTransferObject.CartaGeneralDTO;

public class RegistraCambioDeSimcardActionDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private PresupuestoDTO presupuestoDTO;
	private SerieDTO serieDTO;
	private UsuarioAbonadoDTO usuarioAbonadoDTO;
	private UsoArticuloDTO usoArticuloDTO;
	private CuotaDTO cuotaDTO;
	private SesionDTO sesionDTO;
	private ModalidadPagoDTO modalidadPagoDTO;
	private BodegaDTO bodegaDTO;
	private CausaCamSerieDTO causaCamSerieDTO;
	private RegistrarOossEnLineaDTO registrarOossEnLineaDTO;
	private RegCargosDTO regCargosDTO;
	private String cmbCiclo;
	private VendedorDTO vendedorDTO;
	private RegistrarRenovaDTO registrarRenovaDTO;
	private CartaGeneralDTO cartaGeneralDTO;
	
	public PresupuestoDTO getPresupuestoDTO() {
		return presupuestoDTO;
	}

	public void setPresupuestoDTO(PresupuestoDTO presupuestoDTO) {
		this.presupuestoDTO = presupuestoDTO;
	}

	public VendedorDTO getVendedorDTO() {
		return vendedorDTO;
	}

	public void setVendedorDTO(VendedorDTO vendedorDTO) {
		this.vendedorDTO = vendedorDTO;
	}

	public BodegaDTO getBodegaDTO() {
		return bodegaDTO;
	}

	public void setBodegaDTO(BodegaDTO bodegaDTO) {
		this.bodegaDTO = bodegaDTO;
	}

	public CausaCamSerieDTO getCausaCamSerieDTO() {
		return causaCamSerieDTO;
	}

	public void setCausaCamSerieDTO(CausaCamSerieDTO causaCamSerieDTO) {
		this.causaCamSerieDTO = causaCamSerieDTO;
	}

	public String getCmbCiclo() {
		return cmbCiclo;
	}

	public void setCmbCiclo(String cmbCiclo) {
		this.cmbCiclo = cmbCiclo;
	}

	public CuotaDTO getCuotaDTO() {
		return cuotaDTO;
	}

	public void setCuotaDTO(CuotaDTO cuotaDTO) {
		this.cuotaDTO = cuotaDTO;
	}

	public ModalidadPagoDTO getModalidadPagoDTO() {
		return modalidadPagoDTO;
	}

	public void setModalidadPagoDTO(ModalidadPagoDTO modalidadPagoDTO) {
		this.modalidadPagoDTO = modalidadPagoDTO;
	}

	public RegCargosDTO getRegCargosDTO() {
		return regCargosDTO;
	}

	public void setRegCargosDTO(RegCargosDTO regCargosDTO) {
		this.regCargosDTO = regCargosDTO;
	}

	public RegistrarOossEnLineaDTO getRegistrarOossEnLineaDTO() {
		return registrarOossEnLineaDTO;
	}

	public void setRegistrarOossEnLineaDTO(
			RegistrarOossEnLineaDTO registrarOossEnLineaDTO) {
		this.registrarOossEnLineaDTO = registrarOossEnLineaDTO;
	}

	public SesionDTO getSesionDTO() {
		return sesionDTO;
	}

	public void setSesionDTO(SesionDTO sesionDTO) {
		this.sesionDTO = sesionDTO;
	}

	public UsoArticuloDTO getUsoArticuloDTO() {
		return usoArticuloDTO;
	}

	public void setUsoArticuloDTO(UsoArticuloDTO usoArticuloDTO) {
		this.usoArticuloDTO = usoArticuloDTO;
	}

	public UsuarioAbonadoDTO getUsuarioAbonadoDTO() {
		return usuarioAbonadoDTO;
	}

	public void setUsuarioAbonadoDTO(UsuarioAbonadoDTO usuarioAbonadoDTO) {
		this.usuarioAbonadoDTO = usuarioAbonadoDTO;
	}

	public PresupuestoDTO getAceptarPresupuestoDTO() {
		return presupuestoDTO;
	}

	public void setAceptarPresupuestoDTO(PresupuestoDTO presupuestoDTO) {
		this.presupuestoDTO = presupuestoDTO;
	}

	public SerieDTO getSerieDTO() {
		return serieDTO;
	}

	public void setSerieDTO(SerieDTO serieDTO) {
		this.serieDTO = serieDTO;
	}

	public RegistrarRenovaDTO getRegistrarRenovaDTO() {
		return registrarRenovaDTO;
	}

	public void setRegistrarRenovaDTO(RegistrarRenovaDTO registrarRenovaDTO) {
		this.registrarRenovaDTO = registrarRenovaDTO;
	}

	public CartaGeneralDTO getCartaGeneralDTO() {
		return cartaGeneralDTO;
	}

	public void setCartaGeneralDTO(CartaGeneralDTO cartaGeneralDTO) {
		this.cartaGeneralDTO = cartaGeneralDTO;
	}
	
	

}
