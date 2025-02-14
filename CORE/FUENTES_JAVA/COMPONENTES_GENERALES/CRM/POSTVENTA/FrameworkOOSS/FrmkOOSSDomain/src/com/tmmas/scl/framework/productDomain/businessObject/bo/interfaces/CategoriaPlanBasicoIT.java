package com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces;

import com.tmmas.scl.framework.productDomain.dataTransferObject.CategoriaListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductOfferingException;

public interface CategoriaPlanBasicoIT {
	
	public CategoriaListDTO obtenerCategoriaPlanBasico(PlanTarifarioDTO planTarif) throws ProductOfferingException;
}
