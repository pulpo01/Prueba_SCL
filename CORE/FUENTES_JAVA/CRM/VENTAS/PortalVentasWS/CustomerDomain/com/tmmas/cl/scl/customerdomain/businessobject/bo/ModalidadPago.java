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
 * 16/01/2007     Héctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.ModalidadPagoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.NumeroCuotasDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.ModalidadPagoDAO;

public class ModalidadPago  {
	
	private ModalidadPagoDAO modalidadPagoDAO  = new ModalidadPagoDAO();
	private static Category cat = Category.getInstance(ModalidadPago.class);
	
	/**
	 * Obtiene listado de Modalidades de Pago. No se define código y descripción 
	 * como atributos debido a que el BO procesa y retorna un listado
	 * de Modalidades de Pago.
	 * 
	 * @param 
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ModalidadPagoDTO[] getListadoModalidadPago(ModalidadPagoDTO modalidad) throws CustomerDomainException {
		cat.debug("getListadoModalidadPago():start");
		ModalidadPagoDTO[] resultado = modalidadPagoDAO.getListadoModalidadPago(modalidad);
		cat.debug("getListadoModalidadPago():end");
		return resultado;
	}
	
	
	/**
	 * Obtiene listado de Numero de Cuotas de Modalidad de Pago. No se define código y descripción 
	 * como atributos debido a que el BO procesa y retorna un listado
	 * de Modalidades de Pago.
	 * 
	 * @param 
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public NumeroCuotasDTO[] getListadoNumeroCuotas(ModalidadPagoDTO modalidad) throws CustomerDomainException {
		cat.debug("getListadoNumeroCuotas():start");
		NumeroCuotasDTO[] resultado = modalidadPagoDAO.getListadoNumeroCuotas(modalidad);
		cat.debug("getListadoNumeroCuotas():end");
		return resultado;
	}

	/**
	 * Obtiene listado de Numero de Cuotas de Modalidad de Pago. No se define código y descripción 
	 * como atributos debido a que el BO procesa y retorna un listado
	 * de Modalidades de Pago.
	 * No tiene parámtros de entrada
	 * @param 
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public NumeroCuotasDTO[] getListadoNumeroCuotas() throws CustomerDomainException {
		cat.debug("getListadoNumeroCuotas():start");
		NumeroCuotasDTO[] resultado = modalidadPagoDAO.getListadoNumeroCuotas();
		cat.debug("getListadoNumeroCuotas():end");
		return resultado;
	}
	
	/**
	 * Consulta los datos de la modalidad de pago
	 * 
	 * @param modalidad
	 * @return modalidad
	 * @throws CustomerDomainException
	 */
	public ModalidadPagoDTO getModalidadPago(ModalidadPagoDTO modalidad) throws CustomerDomainException{
		cat.debug("getIndicadorCuotas():start");
		modalidad = modalidadPagoDAO.getModalidadPago(modalidad);
		cat.debug("getIndicadorCuotas():end");
		return modalidad;
	}

	/**
	 * Obtiene modalidades de pago segun indicador manual
	 * @param N/A
	 * @return ModalidadPagoDTO[]
	 * @throws CustomerDomainException
	 */
	public ModalidadPagoDTO[] getListModalidadPagoIndManual(ModalidadPagoDTO entrada) 
	throws CustomerDomainException{
		cat.debug("Inicio:getListCatgetListModalidadPagoIndManualegorias()");
		ModalidadPagoDTO[] resultado = modalidadPagoDAO.getListModalidadPagoIndManual(entrada);
		cat.debug("Fin:getListModalidadPagoIndManual()");
		return resultado;		
	}//fin getListModalidadPagoIndManual

}//fin class ModalidadPago
