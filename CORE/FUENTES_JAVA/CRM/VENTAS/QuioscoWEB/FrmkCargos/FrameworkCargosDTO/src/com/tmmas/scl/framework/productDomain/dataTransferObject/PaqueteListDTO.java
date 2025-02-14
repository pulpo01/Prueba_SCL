/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 18/07/2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class PaqueteListDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private PaqueteDTO[] paqueteList;
	
	private EspecProductoListDTO especProdListDTO;
	private CargoListDTO	cargoListDTO;

	public PaqueteDTO[] getPaqueteList() {
		return paqueteList;
	}

	public void setPaqueteList(PaqueteDTO[] paqueteList) {
		this.paqueteList = paqueteList;
	}

	public CargoListDTO getCargoListDTO() {
		return cargoListDTO;
	}

	public void setCargoListDTO(CargoListDTO cargoListDTO) {
		this.cargoListDTO = cargoListDTO;
	}

	public EspecProductoListDTO getEspecProdListDTO() {
		return especProdListDTO;
	}

	public void setEspecProdListDTO(EspecProductoListDTO especProdListDTO) {
		this.especProdListDTO = especProdListDTO;
	}
	
	
	

}
