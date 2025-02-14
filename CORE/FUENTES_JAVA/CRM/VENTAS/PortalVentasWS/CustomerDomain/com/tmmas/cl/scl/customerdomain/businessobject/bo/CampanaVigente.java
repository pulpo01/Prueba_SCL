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
package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.CampanaVigenteCOLDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CampanaVigenteDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.CampanaVigenteDAO;

public class CampanaVigente {

	private CampanaVigenteDAO campanaVigenteDAO = new CampanaVigenteDAO();

	private static Category cat = Category.getInstance(CampanaVigente.class);

	/**
	 * Obtiene listado de Campa�as Vigentes. No se define c�digo y descripci�n 
	 * como atributos debido a que el BO procesa y retorna un listado
	 * de Campa�as Vigentes 
	 * @param 
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public CampanaVigenteDTO[] getListadoCampanaVigente() throws CustomerDomainException {
		cat.debug("getListadoCampanaVigente():start");
		CampanaVigenteDTO[] resultado = campanaVigenteDAO.getListadoCampaniasVigentes();
		cat.debug("getListadoCampanaVigente():end");
		return resultado;
	}

	/**
	 * Obtiene listado de campa�as vigentes postpago
	 * @param N/A
	 * @return CampanaVigenteDTO[]
	 * @throws CustomerDomainException
	 */
	public CampanaVigenteDTO[] getListCampVigentesPostpago() throws CustomerDomainException {
		cat.debug("Inicio:getListCampVigentesPostpago()");
		CampanaVigenteDTO[] resultado = campanaVigenteDAO.getListCampVigentesPostpago();
		cat.debug("Fin:getListCampVigentesPostpago()");
		return resultado;
	}//fin getListCampVigentesPostpago	

	/**
	 * Registra campa�a vigente para el cliente
	 * @param entrada
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void registraCampanaVigente(CampanaVigenteDTO entrada) throws CustomerDomainException {
		cat.debug("Inicio:getListCampVigentesPostpago()");
		campanaVigenteDAO.registraCampanaVigente(entrada);
		cat.debug("Fin:getListCampVigentesPostpago()");
	}//fin registraCampanaVigente

	/**
	 * Obtiene datos campa�a
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public CampanaVigenteDTO getCampanaVigente(CampanaVigenteDTO entrada) throws CustomerDomainException {
		cat.debug("Inicio:getCampanaVigente()");
		CampanaVigenteDTO resultado = null;
		resultado = campanaVigenteDAO.getCampanaVigente(entrada);
		cat.debug("Fin:getCampanaVigente()");
		return resultado;
	}//fin getCampanaVigente

	/**
	 * Obtiene datos campa�a por defecto
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public CampanaVigenteDTO getCampanaVigenteDefault(CampanaVigenteCOLDTO entrada) throws CustomerDomainException {
		cat.debug("Inicio:getCampanaVigenteDefault()");
		CampanaVigenteDTO resultado = null;
		resultado = campanaVigenteDAO.getCampanaVigenteDefault(entrada);
		cat.debug("Fin:getCampanaVigenteDefault()");
		return resultado;
	}//fin getCampanaVigente

	/**
	 * @param codTiplan
	 * @return
	 * @throws CustomerDomainException
	 */
	public CampanaVigenteDTO[] getListadoCampaniasVigentesXCodTiplan(String codTiplan) throws CustomerDomainException {
		cat.info("getListadoCampaniasVigentesXCodTiplan, inicio");
		cat.debug("codTiplan [" + codTiplan + "]");
		CampanaVigenteDTO[] r = campanaVigenteDAO.getListadoCampaniasVigentesXCodTiplan(codTiplan);
		cat.info("getListadoCampaniasVigentesXCodTiplan, fin");
		return r;
	}

}//fin class CampanaVigente
