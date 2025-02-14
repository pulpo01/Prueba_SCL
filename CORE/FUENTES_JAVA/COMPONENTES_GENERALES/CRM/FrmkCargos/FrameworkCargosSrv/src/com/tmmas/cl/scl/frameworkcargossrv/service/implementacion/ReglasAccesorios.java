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
 * 04/04/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.frameworkcargossrv.service.implementacion;

import org.apache.log4j.Logger;

import com.tmmas.cl.scl.frameworkcargos.base.ReglaListaPrecio;
import com.tmmas.cl.scl.frameworkcargos.exception.FrameworkCargosException;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosReglaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioDTO;

public class ReglasAccesorios extends ReglaListaPrecio{
	
	//private static Category cat = Category.getInstance(ReglasAccesorios.class);
	private final Logger logger=Logger.getLogger(ReglasAccesorios.class);
	
	public ReglasAccesorios(ParametrosReglaDTO parametros) {
		super(parametros);
	}

	public DescuentoDTO[] seleccionDescuentos() {
		logger.debug("Inicio:seleccionDescuentos()");
		logger.debug("Fin:seleccionDescuentos()");		
		
		return null;
	}

	public PrecioDTO[] seleccionPrecios() {
		logger.debug("Inicio:seleccionPrecios()");
		logger.debug("Fin:seleccionPrecios()");
		return null;
		
	}

	public boolean validacion() {
		logger.debug("Inicio:validacion()");
		logger.debug("Fin:validacion()");
		return false;
	}

	public ParametrosReglaDTO getAtributos() throws FrameworkCargosException {
		// TODO Auto-generated method stub
		return null;
	}

}
