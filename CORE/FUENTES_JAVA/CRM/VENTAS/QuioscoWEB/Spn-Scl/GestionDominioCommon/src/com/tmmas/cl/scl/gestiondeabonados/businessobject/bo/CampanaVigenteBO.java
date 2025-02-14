/**
 * Copyright � 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal informaci�n y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 16/01/2007     H�ctor Hermosilla      					Versi�n Inicial
 */
package com.tmmas.cl.scl.gestiondeabonados.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dao.CampanaVigenteDAO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.CampanaVigenteDTO;

public class CampanaVigenteBO  {
	
	private CampanaVigenteDAO CampanaVigenteDAO  = new CampanaVigenteDAO();
	private static Category cat = Category.getInstance(CampanaVigenteBO.class);
	
	/**
	 * Obtiene listado de Campa�as Vigentes. No se define c�digo y descripci�n 
	 * como atributos debido a que el BO procesa y retorna un listado
	 * de Campa�as Vigentes 
	 * @param 
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public CampanaVigenteDTO[] getListadoCampanaVigente() throws GeneralException {
		cat.debug("getListadoCampanaVigente():start");
		CampanaVigenteDTO[] resultado = CampanaVigenteDAO.getListadoCampanaVigente();
		cat.debug("getListadoCampanaVigente():end");
		return resultado;
	}
	
	/**
	 * Obtiene listado de campa�as vigentes postpago
	 * @param N/A
	 * @return CampanaVigenteDTO[]
	 * @throws GeneralException
	 */
	public CampanaVigenteDTO[] getListCampVigentesPostpago() 
	throws GeneralException{
		cat.debug("Inicio:getListCampVigentesPostpago()");
		CampanaVigenteDTO[] resultado = CampanaVigenteDAO.getListCampVigentesPostpago();
		cat.debug("Fin:getListCampVigentesPostpago()");
		return resultado;
	}//fin getListCampVigentesPostpago	

	/**
	 * Registra campa�a vigente para el cliente
	 * @param entrada
	 * @return N/A
	 * @throws GeneralException
	 */
	public void registraCampanaVigente(CampanaVigenteDTO entrada) 
	throws GeneralException{
		cat.debug("Inicio:getListCampVigentesPostpago()");
		CampanaVigenteDAO.registraCampanaVigente(entrada);
		cat.debug("Fin:getListCampVigentesPostpago()");
	}//fin registraCampanaVigente

	/**
	 * Obtiene datos campa�a
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public CampanaVigenteDTO getCampanaVigente(CampanaVigenteDTO entrada) 
	throws GeneralException{
		cat.debug("Inicio:getCampanaVigente()");
		CampanaVigenteDTO resultado = null;
		resultado = CampanaVigenteDAO.getCampanaVigente(entrada);
		cat.debug("Fin:getCampanaVigente()");
		return resultado;
	}//fin getCampanaVigente		
	
}//fin class CampanaVigente
