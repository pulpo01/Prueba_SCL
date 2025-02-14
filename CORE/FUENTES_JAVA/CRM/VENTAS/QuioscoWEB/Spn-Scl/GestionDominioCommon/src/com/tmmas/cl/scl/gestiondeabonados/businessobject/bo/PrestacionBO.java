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
 * 14/05/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.gestiondeabonados.businessobject.bo;

import org.apache.log4j.Category;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.helper.Global;
import com.tmmas.cl.framework.exception.GeneralException;

import com.tmmas.cl.scl.gestiondeabonados.businessobject.dao.PrestacionDAO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.TipoPrestacionDTO;

public class PrestacionBO {
	
	private PrestacionDAO prestacionDAO  = new PrestacionDAO();
	private static Category cat = Category.getInstance(PrestacionBO.class);
	Global global = Global.getInstance();
	
	public TipoPrestacionDTO[] getTipoPrestacion(String codGrupoPrestacion, String tipoCliente)	
		/*throws ProductDomainException*/
	throws GeneralException
	{
		TipoPrestacionDTO[] resultado ;
		cat.debug("Inicio:getTipoPrestacion()");
		resultado = prestacionDAO.getTiposPrestacion(codGrupoPrestacion, tipoCliente); 
		cat.debug("Fin:getTipoPrestacion()");
		return resultado;    	
	}//fin getGruposPrestacion
	
}//fin class Prestacion
