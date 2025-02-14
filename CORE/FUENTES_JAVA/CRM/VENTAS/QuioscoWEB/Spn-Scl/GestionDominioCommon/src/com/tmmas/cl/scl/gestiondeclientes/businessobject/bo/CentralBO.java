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
 * 22/03/2007     Héctor Hermosilla     					Versión Inicial
 */

package com.tmmas.cl.scl.gestiondeclientes.businessobject.bo;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.dao.CentralDAO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CeldaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CentralDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.DireccionCentralDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.HomeLineaDTO;

public class CentralBO {
	private CentralDAO centralDAO  = new CentralDAO();
	private Logger cat = Logger.getLogger(CentralBO.class);


	/**
	 * Obtiene listado de centrales 
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */

	public CentralDTO[] getListadoCentrales(CeldaDTO entrada)throws GeneralException{
		CentralDTO[] resultado = null;
		cat.debug("Inicio:getListadoCentrales()");
		resultado = centralDAO.getListadoCentrales(entrada); 
		cat.debug("Fin:getListadoCentrales()");
		return resultado;
	}	

	/**
	 * Obtiene datos de la central 
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public CentralDTO getCentral(CentralDTO entrada)
	throws GeneralException{
		CentralDTO resultado = null;
		cat.debug("Inicio:getCentral()");
		resultado = centralDAO.getCentral(entrada); 
		cat.debug("Fin:getCentral()");
		return resultado;
	}//fin getCodigoTecnologia

	public CeldaDTO getCentral(CeldaDTO entrada)
	throws GeneralException{
		CeldaDTO resultado = null;
		cat.debug("Inicio:getCentral()");
		resultado = centralDAO.getCentral(entrada); 
		cat.debug("Fin:getCentral()");
		return resultado;
	}


	public HomeLineaDTO[] getHomeLinea(DireccionCentralDTO direccionCentralDTO)
	throws GeneralException{
		HomeLineaDTO[] homeLineaDTOs = null;
		cat.debug("Inicio:getHomeLinea()");
		homeLineaDTOs = centralDAO.getHomeLinea(direccionCentralDTO); 
		cat.debug("Fin:getHomeLinea()");
		return homeLineaDTOs;
	}


	public CentralDTO getCentralTecnologia(CentralDTO central) 
	throws GeneralException{	
		cat.debug("Inicio:getCentralTecnologia()");
		central = centralDAO.getCentralTecnologia(central); 
		cat.debug("Fin:getCentralTecnologia()");
		return central;
	}	


}//fin Central
