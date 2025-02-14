package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.ConceptosRecaudacionDAO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ConceptosRecaudacionDTO;

public class ConceptosRecaudacion {

	private ConceptosRecaudacionDAO conceptosRecaudacionDAO  = new ConceptosRecaudacionDAO();
	private static Category cat = Category.getInstance(ConceptosRecaudacion.class);
	
	/**
	 * Obtiene lista de bancos segun PAC
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ConceptosRecaudacionDTO[] getListBancosPAC(ConceptosRecaudacionDTO entrada)
	throws CustomerDomainException{
		cat.debug("Inicio:getListBancos()");
		ConceptosRecaudacionDTO[] resultado = conceptosRecaudacionDAO.getListBancosPAC(entrada);
		cat.debug("Fin:getListBancos()");
		return resultado;
	}//fin getListBancos	

	/**
	 * Obtiene sucursales del banco 
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ConceptosRecaudacionDTO[] getListSucursalesBancos(ConceptosRecaudacionDTO entrada)
	throws CustomerDomainException{
		cat.debug("Inicio:getListSucursalesBancos()");
		ConceptosRecaudacionDTO[] resultado = conceptosRecaudacionDAO.getListSucursalesBancos(entrada);
		cat.debug("Fin:getListSucursalesBancos()");
		return resultado;
	}//fin getListSucursalesBancos	

	/**
	 * Obtiene listado de tarjetas 
	 * @param N/A
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ConceptosRecaudacionDTO[] getListTarjetas() 
	throws CustomerDomainException{
		cat.debug("Inicio:getListTarjetas()");
		ConceptosRecaudacionDTO[] resultado = conceptosRecaudacionDAO.getListTarjetas();
		cat.debug("Fin:getListTarjetas()");
		return resultado;
	}//fin getListTarjetas	

	/**
	 * Obtiene modalidades de pago 
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ConceptosRecaudacionDTO[] getListModalidadPago(ConceptosRecaudacionDTO entrada) 
	throws CustomerDomainException{
		cat.debug("Inicio:getListModalidadPago()");
		ConceptosRecaudacionDTO[] resultado = conceptosRecaudacionDAO.getListModalidadPago(entrada);
		cat.debug("Fin:getListModalidadPago()");
		return resultado;
	}//fin getListModalidadPago	
	
}//fin class ConceptosRecaudacion
