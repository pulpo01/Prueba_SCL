/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 26/07/2011     Giovanni Petroli Avalos      					Versión Inicial
 */
package com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;

public class WsDatosDireccionOutDTO extends RetornoDTO  implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private DireccionDTO direccionDTO;

	public DireccionDTO getDireccionDTO() {
		return direccionDTO;
	}

	public void setDireccionDTO(DireccionDTO direccionDTO) {
		this.direccionDTO = direccionDTO;
	}
	
}
