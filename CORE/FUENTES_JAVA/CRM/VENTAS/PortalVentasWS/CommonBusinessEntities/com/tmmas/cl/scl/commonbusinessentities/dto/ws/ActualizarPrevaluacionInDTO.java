/**
 * 
 */
package com.tmmas.cl.scl.commonbusinessentities.dto.ws;

import java.io.Serializable;

/**
 * @author mwn90113
 *
 */
public class ActualizarPrevaluacionInDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4880220549219486954L;
	private String numSolicitud;
	private String codPlantarif;
	
	public String getCodPlantarif() {
		return codPlantarif;
	}
	public void setCodPlantarif(String codPlantarif) {
		this.codPlantarif = codPlantarif;
	}
	public String getNumSolicitud() {
		return numSolicitud;
	}
	public void setNumSolicitud(String numSolicitud) {
		this.numSolicitud = numSolicitud;
	}
	
	
	

}
