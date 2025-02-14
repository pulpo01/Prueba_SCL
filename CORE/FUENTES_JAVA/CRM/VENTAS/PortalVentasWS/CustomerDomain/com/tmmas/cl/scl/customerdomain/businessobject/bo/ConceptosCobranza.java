package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.ConceptosCobranzaDAO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ConceptosCobranzaDTO;

public class ConceptosCobranza {

	private ConceptosCobranzaDAO conceptosCobranzaDAO  = new ConceptosCobranzaDAO();
	private static Category cat = Category.getInstance(Ciudad.class);
	
	/**
	 * Obtiene descricion codigo 123
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ConceptosCobranzaDTO getDescripcion123(ConceptosCobranzaDTO parametroEntrada) 
	throws CustomerDomainException{
		ConceptosCobranzaDTO resultado;
		cat.debug("Inicio:getDescripcion123()");
		resultado =conceptosCobranzaDAO.getDescripcion123(parametroEntrada); 
		cat.debug("Fin:getDescripcion123()");
		return resultado;
	}//fin getDescripcion123	

	/**
	 * Obtiene descricion codigo ABC
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ConceptosCobranzaDTO getDescripcionABC(ConceptosCobranzaDTO parametroEntrada) 
	throws CustomerDomainException{
		ConceptosCobranzaDTO resultado;
		cat.debug("Inicio:getDescripcionABC()");
		resultado =conceptosCobranzaDAO.getDescripcionABC(parametroEntrada); 
		cat.debug("Fin:getDescripcionABC()");
		return resultado;
	}//fin getDescripcionABC

    /**
	 * Inserta pago automatico
	 * @param parametroEntrada
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void insPagoAutomatico(ConceptosCobranzaDTO entrada) 
	throws CustomerDomainException{
		cat.debug("Inicio:creaAbonado()");
		conceptosCobranzaDAO.insPagoAutomatico(entrada); 
		cat.debug("Fin:creaAbonado()");		
	}//insPagoAutomatico
	
}//fin ConceptosCobranza
