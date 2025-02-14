package com.tmmas.scl.framework.productDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosGeneralesDTO;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ParametrosGeneralesIT;
import com.tmmas.scl.framework.productDomain.businessObject.dao.ParametrosGeneralesDAO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.ParametrosGeneralesDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.exception.ProductOfferingException;

public class ParametrosGenerales implements ParametrosGeneralesIT{
	
	private ParametrosGeneralesDAOIT ParametrosGeneralesDAO  = new ParametrosGeneralesDAO();
	private final Logger logger = Logger.getLogger(ParametrosGenerales.class);
	Global global = Global.getInstance();
	
	/**
	 * Obtiene Parametros Generales
	 * @param parametroGeneral 
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public ParametrosGeneralesDTO getParametroGeneral(ParametrosGeneralesDTO parametrogeneral)
	throws ProductOfferingException{
		ParametrosGeneralesDTO resultado = new ParametrosGeneralesDTO();
		logger.debug("Inicio:ParametrosGenerales:obtieneParametroGeneral()");
		resultado = ParametrosGeneralesDAO.getParametroGeneral(parametrogeneral); 
		logger.debug("Fin:ParametrosGenerales:obtieneParametroGeneral()");
		return resultado;
	}//fin getParametroGeneral
	
	public ParametrosGeneralesDTO getParametroFacturacion(ParametrosGeneralesDTO parametrogeneral) throws ProductOfferingException{
		ParametrosGeneralesDTO resultado = new ParametrosGeneralesDTO();
		logger.debug("Inicio:ParametrosGenerales:getParametroFacturacion()");
		resultado = ParametrosGeneralesDAO.getParametroFacturacion(parametrogeneral); 
		logger.debug("Fin:ParametrosGenerales:getParametroFacturacion()");
		return resultado;
	}//fin getParametroGenera
	
	public ParametrosGeneralesDTO getParametroGrupoTecnologico(ParametrosGeneralesDTO parametroGeneral) throws GeneralException{
		ParametrosGeneralesDTO resultado = new ParametrosGeneralesDTO();
		try{
			logger.debug("Inicio:ParametrosGenerales:getParametroGrupoTecnologico()");
			resultado = ParametrosGeneralesDAO.getParametroGrupoTecnologico(parametroGeneral); 
			logger.debug("Fin:ParametrosGenerales:getParametroGrupoTecnologico()");
			
		}catch(GeneralException e){
			e.printStackTrace();
		}
		return resultado;
	}
	

}//fin ParametrosGenerales


