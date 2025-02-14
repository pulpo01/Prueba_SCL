package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.ConceptoVenta;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DependenciasModalidadDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.ModVentaDAO;

public class ModalidadVenta  {

	private ModVentaDAO modVentaDAO  = new ModVentaDAO();
	private static Category cat = Category.getInstance(ModalidadVenta.class);
	
	public ConceptoVenta recalcularModalidadVenta (DependenciasModalidadDTO entrada) 
		throws CustomerDomainException
	{		   
	    cat.debug("Inicio:recalcularModalidadVenta()");
		ConceptoVenta resultado=null;
		resultado = modVentaDAO.calcularModalidad(entrada);
		cat.debug("Fin:recalcularModalidadVenta()");
		return resultado;
	}
	
	public void updateModalidaVenta(Long numVenta, Long codModVenta) 
		throws CustomerDomainException
	{		   
	    cat.debug("Inicio:updateModalidaVenta()");		
		modVentaDAO.updateModalidaVenta(numVenta, codModVenta);
		cat.debug("Fin:updateModalidaVenta()");
	}
	
}
