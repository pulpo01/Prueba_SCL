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
 * 27/02/2007     H&eacute;ctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.gestiondeabonados.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dao.ContratoDAO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.DatosValidacionDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ContratoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.TipoContratoClienteDTO;

public class ContratoBO {
	private ContratoDAO contratoDAO  = new ContratoDAO();
	private static Category cat = Category.getInstance(ContratoBO.class);
	/**
	 *Obtiene Datos del Cliente
	 * 
	 * @param 
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public DatosValidacionDTO getValidaNuevoContratoCliente(ContratoDTO contrato) throws GeneralException {
		DatosValidacionDTO resultado = new DatosValidacionDTO();
		cat.debug("listadoContratosCliente():start");
		resultado = contratoDAO.getValidaNuevoContratoCliente(contrato);
		cat.debug("listadoContratosCliente():end");
		return resultado;
	}
	
	/**
	 * Obtiene listado de Tipos de Contrato. No se define código y descripción 
	 * como atributos debido a que el BO procesa y retorna un listado
	 * de Tipos de Contrato 
	 * 
	 * @param 
	 * @return resultado
	 * @throws GeneralException
	 */
	public ContratoDTO[] getListadoTipoContrato(ContratoDTO contrato) throws GeneralException {
		cat.debug("getListadoTipoContrato():start");
		ContratoDTO[] resultado = contratoDAO.getListadoTipoContrato(contrato);
		cat.debug("getListadoTipoContrato():end");
		return resultado;
	}
	public ContratoDTO getListadoNumeroMesesContrato(ContratoDTO contrato) throws GeneralException {
		cat.debug("getListadoNumeroMesesContrato():start");
		ContratoDTO resultado = contratoDAO.getListadoNumeroMesesContrato(contrato);
		cat.debug("getListadoNumeroMesesContrato():end");
		return resultado;
	}
	
	public ContratoDTO getTipoContrato(ContratoDTO contrato) throws GeneralException {
		cat.debug("getTipoContrato():start");
		ContratoDTO resultado = contratoDAO.getTipoContrato(contrato);
		cat.debug("getTipoContrato():end");
		return resultado;
	}
	
	/**
	 * inserta contrato
	 * @param entrada
	 * @return
	 * @throws GeneralException
	 */
	
	public void altaContrato(ContratoDTO entrada)throws GeneralException{
		cat.debug("altaContrato():start");
		contratoDAO.altaContrato(entrada);
		cat.debug("altaContrato():end");
	}
	
	/**
	 * Busca el mayor numero de anexo asociado al contrato
	 * @param contrato
	 * @return contrato
	 * @throws GeneralException
	 */
    public ContratoDTO getMaxAnexoContrato(ContratoDTO contrato) throws GeneralException{
    	cat.debug("getMaxAnexoContrato():start");
		contratoDAO.getMaxAnexoContrato(contrato);
		cat.debug("getMaxAnexoContrato():end");
		return contrato;
	}
    
    /**
	 * Obtiene tipo contrato asociado al cliente
	 * @param codCliente 
	 * @return resultado
	 * @throws GeneralException
	 */	
    public TipoContratoClienteDTO obtieneTipContratoCliente(Long codCliente)
    	throws GeneralException		
    {	

    	cat.debug("ContratoBO.obtieneTipContratoCliente():start");
    	TipoContratoClienteDTO resultado = contratoDAO.obtieneTipContratoCliente(codCliente);
		cat.debug("obtieneTipContratoCliente.obtieneTipContratoCliente():end");
		return resultado;
	}
    
    /**
	 * Inserta tipo contrato asociado al cliente
	 * @param TipoContratoClienteDTO
	 * @throws GeneralException
	 */	
    public void insertaTipContratoCliente(TipoContratoClienteDTO entrada)
    	throws GeneralException		
    {	
    	cat.debug("ContratoBO.insertaTipContratoCliente():start");
    	contratoDAO.insertaTipContratoCliente(entrada);
		cat.debug("ContratoBO.insertaTipContratoCliente:end");		
	}
    
    public ContratoDTO getTipcontrato(ContratoDTO contrato) throws GeneralException{
    	cat.debug("ContratoBO.getTipcontrato():start");
    	contrato = contratoDAO.getTipcontrato(contrato);
		cat.debug("ContratoBO.getTipcontrato:end");		
		return contrato;
	}   	
    	
}
