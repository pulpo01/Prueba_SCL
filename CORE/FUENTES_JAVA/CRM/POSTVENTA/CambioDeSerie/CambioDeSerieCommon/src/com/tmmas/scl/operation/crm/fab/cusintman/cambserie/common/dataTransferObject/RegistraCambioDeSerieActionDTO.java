package com.tmmas.scl.operation.crm.fab.cusintman.cambserie.common.dataTransferObject;

import java.io.Serializable;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistrarOossEnLineaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistrarRenovaDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCambioSerieDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PresupuestoDTO;
import com.tmmas.scl.vendedor.dto.VendedorDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CartaGeneralDTO;

public class RegistraCambioDeSerieActionDTO implements Serializable {

	

	/**
	 * @author TM-mAs
	 */
	private static final long serialVersionUID = -5569100845567819732L;

	private PresupuestoDTO presupuestoDTO;

	private RegCargosDTO regCargosDTO;

	private ParametrosCambioSerieDTO parametrosCambioSerieDTO;

	private VendedorDTO vendedorDTO;

	private String cmbCiclo;

	private RegistrarOossEnLineaDTO registrarOossEnLineaDTO;

	private String codTecnAnt;

	private RegistrarRenovaDTO registrarRenovaDTO;

	private boolean buscaSocketPS;

	private CartaGeneralDTO cartaGeneralDTO;

	public boolean isBuscaSocketPS() {
		return buscaSocketPS;
	}

	public void setBuscaSocketPS(boolean buscaSocketPS) {
		this.buscaSocketPS = buscaSocketPS;
	}

	public String getCodTecnAnt() {
		return codTecnAnt;
	}

	public void setCodTecnAnt(String codTecnAnt) {
		this.codTecnAnt = codTecnAnt;
	}

	public ParametrosCambioSerieDTO getParametrosCambioSerieDTO() {
		return parametrosCambioSerieDTO;
	}

	public void setParametrosCambioSerieDTO(ParametrosCambioSerieDTO parametrosCambioSerieDTO) {
		this.parametrosCambioSerieDTO = parametrosCambioSerieDTO;
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

	public String getCmbCiclo() {
		return cmbCiclo;
	}

	public void setCmbCiclo(String cmbCiclo) {
		this.cmbCiclo = cmbCiclo;
	}

	public RegistrarOossEnLineaDTO getRegistrarOossEnLineaDTO() {
		return registrarOossEnLineaDTO;
	}

	public void setRegistrarOossEnLineaDTO(RegistrarOossEnLineaDTO registrarOossEnLineaDTO) {
		this.registrarOossEnLineaDTO = registrarOossEnLineaDTO;
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
