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

import org.apache.log4j.Category;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.DescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosReglaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PrecioDTO;
import com.tmmas.cl.scl.frameworkcargos.base.ReglaListaPrecio;
import com.tmmas.cl.scl.frameworkcargos.exception.FrameworkCargosException;

public class ReglasAccesorios extends ReglaListaPrecio{
	
	private static Category cat = Category.getInstance(ReglasAccesorios.class);
	
	public ReglasAccesorios(ParametrosReglaDTO parametros) {
		super(parametros);
	}

	public DescuentoDTO[] seleccionDescuentos() {
		cat.debug("Inicio:seleccionDescuentos()");
		cat.debug("Fin:seleccionDescuentos()");		
		
		return null;
	}

	public PrecioDTO[] seleccionPrecios() {
		cat.debug("Inicio:seleccionPrecios()");
		cat.debug("Fin:seleccionPrecios()");
		return null;
		
	}

	public boolean validacion() {
		cat.debug("Inicio:validacion()");
		cat.debug("Fin:validacion()");
		return false;
	}

	public ParametrosReglaDTO getAtributos() throws FrameworkCargosException {
		// TODO Auto-generated method stub
		return null;
	}

}
