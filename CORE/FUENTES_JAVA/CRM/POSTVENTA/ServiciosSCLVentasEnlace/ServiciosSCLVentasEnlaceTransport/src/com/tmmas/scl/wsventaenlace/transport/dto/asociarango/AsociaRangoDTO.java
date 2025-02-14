package com.tmmas.scl.wsventaenlace.transport.dto.asociarango;

import java.io.Serializable;

import com.tmmas.scl.wsventaenlace.transport.dto.OOSSFase2DTO;

public class AsociaRangoDTO extends OOSSFase2DTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -504582689976108672L;
	/**
	 * 
	 */

	private CargaAsociaRangoDTO cargaAsociaRangoDTO;
	private EjecucionAsociaRangoDTO ejecucionAsociaRangoDTO;

	public String toString() {
		StringBuffer buffer = new StringBuffer("AsociaRangoDTO: ");

		buffer.append("numOOSS = ").append(getNroOOSS());

		buffer.append(", cargaAsociaRangoDTO = ");
		buffer.append(cargaAsociaRangoDTO);
		buffer.append("\n");
		buffer.append("ejecucionAsociaRangoDTO = ");
		buffer.append(ejecucionAsociaRangoDTO);
		buffer.append("\n");

		return buffer.toString();
	}

	public CargaAsociaRangoDTO getCargaAsociaRangoDTO() {
		return cargaAsociaRangoDTO;
	}

	public void setCargaAsociaRangoDTO(CargaAsociaRangoDTO cargaAsociaRangoDTO) {
		this.cargaAsociaRangoDTO = cargaAsociaRangoDTO;
	}

	public EjecucionAsociaRangoDTO getEjecucionAsociaRangoDTO() {
		return ejecucionAsociaRangoDTO;
	}

	public void setEjecucionAsociaRangoDTO(EjecucionAsociaRangoDTO ejecucionAsociaRangoDTO) {
		this.ejecucionAsociaRangoDTO = ejecucionAsociaRangoDTO;
	}
}
