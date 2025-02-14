package com.tmmas.cl.scl.gestiondeclientes.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.dao.PlanComercialDAO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.PlanComercialDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.SumaPrecioPlanesDTO;


public class PlanComercialBO {
	private PlanComercialDAO planComercialDAO = new PlanComercialDAO();
	private static Category cat = Category.getInstance(PlanComercialBO.class);

	/**
	 * Obtiene plan comercial 
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public PlanComercialDTO getPlanComercial(PlanComercialDTO entrada) 
	throws GeneralException{
		cat.debug("Inicio:getPlanComercial()");
		PlanComercialDTO resultado = planComercialDAO.getPlanComercial(entrada);
		cat.debug("Fin:getPlanComercial()");
		return resultado;
	}//fin getPlanComercial

	/**
	 * Obtiene listado de planes comerciales segun calificacion del cliente
	 * @param N/A
	 * @return clienteDTO[]
	 * @throws CustomerDomainException
	 */	       
	public PlanComercialDTO[] getListPlanComercialCalCte(PlanComercialDTO entrada) 
	throws GeneralException{
		cat.debug("Inicio:getListPlanComercialCalCte()");
		PlanComercialDTO[] resultado = planComercialDAO.getListPlanComercialCalCte(entrada);
		cat.debug("Fin:getListPlanComercialCalCte()");
		return resultado;		
	}//fin getListPlanComercialCalCte
	
	public SumaPrecioPlanesDTO getSumaPrecioPlanesXAntiguedad(SumaPrecioPlanesDTO sumaPrecioPlanesDTO) 
	throws GeneralException{
		sumaPrecioPlanesDTO = planComercialDAO.getSumaPrecioPlanesXAntiguedad(sumaPrecioPlanesDTO);
		return sumaPrecioPlanesDTO;
	}
	
	
}//fin class PlanComercial
