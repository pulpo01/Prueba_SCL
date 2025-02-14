package com.tmmas.cl.scl.gestiondeclientes.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ArticuloDTO;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.dao.ConceptosCobranzaDAO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ConceptosCobranzaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;



public class ConceptosCobranzaBO {

	private ConceptosCobranzaDAO conceptosCobranzaDAO  = new ConceptosCobranzaDAO();
	private static Category cat = Category.getInstance(ConceptosCobranzaBO.class);
	
	/**
	 * Obtiene descricion codigo 123
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ConceptosCobranzaDTO getDescripcion123(ConceptosCobranzaDTO parametroEntrada) 
	throws GeneralException{
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
	 * @throws GeneralException
	 */
	public ConceptosCobranzaDTO getDescripcionABC(ConceptosCobranzaDTO parametroEntrada) 
	throws GeneralException{
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
	 * @throws GeneralException
	 */
	public void insPagoAutomatico(ConceptosCobranzaDTO entrada) 
	throws GeneralException{
		cat.debug("Inicio:insPagoAutomatico()");
		conceptosCobranzaDAO.insPagoAutomatico(entrada); 
		cat.debug("Fin:insPagoAutomatico()");		
	}//insPagoAutomatico
	
	 /**
	 * Valida Formato de la tarjeta de Crédito
	 * @param entrada
	 * @return conceptosCobranzaDTO
	 * @throws GeneralException
	 */
	public ConceptosCobranzaDTO validaTarjeta(ConceptosCobranzaDTO entrada) 
	throws GeneralException{
		cat.debug("Inicio:validaTarjeta()");
		ConceptosCobranzaDTO conceptosCobranzaDTO = conceptosCobranzaDAO.validaTarjeta(entrada); 
		cat.debug("Fin:validaTarjeta()");		
		return conceptosCobranzaDTO;
	}//validaTarjeta
	
	
	 /**
	 * Valida Formato de la tarjeta de Crédito
	 * @param entrada
	 * @return conceptosCobranzaDTO
	 * @throws GeneralException
	 */
	public RetornoDTO getInformacionPrecio(ArticuloDTO articuloDTO)throws GeneralException{
		RetornoDTO retValue=new RetornoDTO();
		try{
			cat.debug("Inicio:validaTarjeta()");
			retValue= conceptosCobranzaDAO.getInformacionPrecio(articuloDTO); 
			cat.debug("Fin:validaTarjeta()");
		}catch(GeneralException e){
			cat.debug("GeneralException ["+e.getStackTrace()+"]");
			throw(e);
		}	
		return retValue;
	}//validaTarjeta
	
}//fin ConceptosCobranza
