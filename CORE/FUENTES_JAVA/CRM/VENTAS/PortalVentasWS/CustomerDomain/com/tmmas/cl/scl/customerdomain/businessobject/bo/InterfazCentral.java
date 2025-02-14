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
 * 08/05/2007     Héctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.InterfazCentralDAO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.InterfazCentralDTO;

public class InterfazCentral {
	
	private InterfazCentralDAO interfazCentralDAO  = new InterfazCentralDAO();
	private static Category cat = Category.getInstance(InterfazCentral.class);
	

	/**
	 * Registra valores en ICC_Movimiento
	 * @param entrada
	 * @return 
	 * @throws CustomerDomainException
	 */

	public void provisionaLinea(InterfazCentralDTO entrada) throws CustomerDomainException{
		cat.debug("provisionaLinea():start");
		interfazCentralDAO.provisionaLinea(entrada);
		cat.debug("provisionaLinea():end");
	}
	
	

}
