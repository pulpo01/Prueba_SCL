package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.ProspectoDAO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ProspectoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;

public class Prospecto {
	private ProspectoDAO prospectoDAO  = new ProspectoDAO();
	private static Category cat = Category.getInstance(Prospecto.class);
	Global global = Global.getInstance();

	/**
	 * Obtiene prospecto del Cliente
	 * @param prospecto
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ProspectoDTO getProspectoCliente(ProspectoDTO prospecto) 
	throws CustomerDomainException {
		
		cat.debug("Inicio:getProspectoCliente");
		ProspectoDTO resultado = prospectoDAO.getProspectoCliente(prospecto);
		cat.debug("Fin:getProspectoCliente");
		return resultado;
	}//fin getProspectoCliente
	
	/**
	 * Obtiene prospecto de la direccion
	 * @param prospectoDTO
	 * @return prospectoDTO
	 * @throws CustomerDomainException
	 */
	public ProspectoDTO getProspectoDireccion(ProspectoDTO prospectoDTO) 
	throws CustomerDomainException {
		cat.debug("Inicio:getProspectoDireccion");
		prospectoDAO.getProspectoDireccion(prospectoDTO);
		cat.debug("Fin:getProspectoDireccion");
		return prospectoDTO;
	}//fin getProspectoDireccion

}//fin class Prospecto
