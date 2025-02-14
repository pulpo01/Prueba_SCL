package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

import com.tmmas.scl.gestionlc.common.dto.SiniestroDTO;
import com.tmmas.scl.gestionlc.common.dto.common.GestionLimiteConsumoOutDTO;

public class EjecucionRestitucionEquipoOutDTO extends GestionLimiteConsumoOutDTO
		implements Serializable {

	private static final long serialVersionUID = 1L;

	private Long lonNumTerminal;
	private SiniestroDTO[] siniestroDTOs;
	private String strNomUsuario;
	/**
	 * @return the lonNumTerminal
	 */
	public Long getLonNumTerminal() {
		return lonNumTerminal;
	}
	/**
	 * @param lonNumTerminal the lonNumTerminal to set
	 */
	public void setLonNumTerminal(Long lonNumTerminal) {
		this.lonNumTerminal = lonNumTerminal;
	}
	/**
	 * @return the siniestroDTOs
	 */
	public SiniestroDTO[] getSiniestroDTOs() {
		return siniestroDTOs;
	}
	/**
	 * @param siniestroDTOs the siniestroDTOs to set
	 */
	public void setSiniestroDTOs(SiniestroDTO[] siniestroDTOs) {
		this.siniestroDTOs = siniestroDTOs;
	}
	/**
	 * @return the strNomUsuario
	 */
	public String getStrNomUsuario() {
		return strNomUsuario;
	}
	/**
	 * @param strNomUsuario the strNomUsuario to set
	 */
	public void setStrNomUsuario(String strNomUsuario) {
		this.strNomUsuario = strNomUsuario;
	}
	
	
}
