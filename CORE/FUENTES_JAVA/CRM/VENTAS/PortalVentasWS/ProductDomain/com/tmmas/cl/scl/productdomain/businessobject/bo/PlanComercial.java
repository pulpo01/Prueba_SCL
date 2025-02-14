package com.tmmas.cl.scl.productdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.productdomain.businessobject.dao.PlanComercialDAO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.PlanComercialDTO;

public class PlanComercial {
	private PlanComercialDAO planComercialDAO = new PlanComercialDAO();
	private static Category cat = Category.getInstance(PlanTarifario.class);

	/**
	 * Obtiene plan comercial 
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public PlanComercialDTO getPlanComercial(PlanComercialDTO entrada) 
	throws ProductDomainException{
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
	throws ProductDomainException{
		cat.debug("Inicio:getListPlanComercialCalCte()");
		PlanComercialDTO[] resultado = planComercialDAO.getListPlanComercialCalCte(entrada);
		cat.debug("Fin:getListPlanComercialCalCte()");
		return resultado;		
	}//fin getListPlanComercialCalCte
	
}//fin class PlanComercial
