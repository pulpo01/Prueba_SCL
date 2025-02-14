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
 * 08/02/2007     Héctor Hermosilla      					Versión Inicial
 */


package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.EstadoProcesoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.EstadoProcesoDAO;

public class EstadoProceso  {
	
	private EstadoProcesoDAO progresoProcesoDAO  = new EstadoProcesoDAO();
	private static Category cat = Category.getInstance(EstadoProceso.class);
	
	/**
	 * Obtiene progreso del proceso.
	 * @param 
	 * @return resultado
	 * @throws VentasException
	 */
	public EstadoProcesoDTO getProgreso(EstadoProcesoDTO progreso) throws CustomerDomainException {
		cat.debug("getProgreso():start");
		EstadoProcesoDTO resultado = progresoProcesoDAO.getProgreso(progreso);
		cat.debug("getProgreso():end");
		return resultado;
	}
	public void insertaProceso(EstadoProcesoDTO proceso) throws CustomerDomainException {
		cat.debug("insertaProceso():start");
		progresoProcesoDAO.insertaProceso(proceso);
		cat.debug("insertaProceso():end");
	}
	public void modificaProceso(EstadoProcesoDTO proceso) throws CustomerDomainException {
		cat.debug("modificaProceso():start");
		progresoProcesoDAO.modificaProceso(proceso);
		cat.debug("modificaProceso():end");
	}

	/**
	 * elimina estado de proceso
	 * @param N/A
	 * @return N/A
	 * @throws CustomerDomainException
	 */	
	public void eliminaProceso(EstadoProcesoDTO estadoProcesoDTO) 
	throws CustomerDomainException{
		cat.debug("eliminaProceso():start");
		progresoProcesoDAO.eliminaProceso(estadoProcesoDTO);
		cat.debug("eliminaProceso():end");		
	}//fin eliminaProceso
	
}//fin class EstadoProceso
