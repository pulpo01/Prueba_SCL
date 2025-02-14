
/**
 * Copyright © 2008 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 09/09/2008         Hernán Segura Muñoz                  Versión Inicial 
 * 
 *
 * 
 * DetalleDocumentoDTO
 * @author Hernán Segura Muñoz 
 * @version 1.0
 **/
package com.tmmas.scl.framework.CustomerDomain.CustomerBillABE.dto;

import java.io.Serializable;


public  class DetalleDocumentoDTO implements Serializable {
	private CargoDTO [] listCargoDTO;

	public CargoDTO[] getListCargoDTO() {
		return listCargoDTO;
	}

	public void setListCargoDTO(CargoDTO[] listCargoDTO) {
		this.listCargoDTO = listCargoDTO;
	}
}
