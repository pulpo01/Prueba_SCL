package com.tmmas.cl.scl.portalventas.web.form;

import org.apache.struts.action.ActionForm;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.TipoComportamientoDTO;

/**
 * @author JIB
 *
 */
public class TiposComportamientoForm extends ActionForm {

	/**
	 * © 2010 - TM-mAs
	 */
	private static final long serialVersionUID = 5620717451694411124L;

	String desEstadoActual;
	
	long numSolScoring;

	TipoComportamientoDTO[] tipos;

	public TipoComportamientoDTO[] getTipos() {
		return tipos;
	}

	public void setTipos(TipoComportamientoDTO[] tipos) {
		this.tipos = tipos;
	}

	String tiposSeleccionadosEnCSV;

	public String getTiposSeleccionadosEnCSV() {
		return tiposSeleccionadosEnCSV;
	}

	public void setTiposSeleccionadosEnCSV(String csvSeleccionados) {
		this.tiposSeleccionadosEnCSV = csvSeleccionados;
	}

	public long getNumSolScoring() {
		return numSolScoring;
	}

	public void setNumSolScoring(long numSolScoring) {
		this.numSolScoring = numSolScoring;
	}

	public String getDesEstadoActual() {
		return desEstadoActual;
	}

	public void setDesEstadoActual(String desEstadoActual) {
		this.desEstadoActual = desEstadoActual;
	}

}
