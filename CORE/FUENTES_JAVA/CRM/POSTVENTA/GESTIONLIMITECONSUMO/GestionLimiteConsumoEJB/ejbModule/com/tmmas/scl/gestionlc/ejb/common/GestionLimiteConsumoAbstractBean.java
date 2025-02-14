/**
 * Copyright © 2009 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
   17-12-2010			     Hugo Olivares      			Versión Inicial 
 * 
 **/
package com.tmmas.scl.gestionlc.ejb.common;

import com.tmmas.scl.gestionlc.common.dto.common.GestionLimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.common.helper.LoggerHelper;


public class GestionLimiteConsumoAbstractBean {
	
	private final LoggerHelper logger = LoggerHelper.getInstance();
	
	public GestionLimiteConsumoAbstractBean(){
		
	}

	public void loggerDebug(String mensaje){
		logger.debug(mensaje,this.getClass().getName());
	}
	public void loggerInfo(String mensaje){
		logger.info(mensaje,this.getClass().getName());
	}
	public void loggerError(String mensaje){
		logger.error(mensaje,this.getClass().getName());
	}
	public void loggerError(Throwable e){
		logger.error(e,this.getClass().getName());
	}
	public void loggerDTO(GestionLimiteConsumoOutDTO p_inDTO){
		logger.imprimeDTO(p_inDTO);
	}
	 public void imprimirPropiedades(Object dto){
		 LoggerHelper.imprimirPropiedades(dto);
	 }

}
