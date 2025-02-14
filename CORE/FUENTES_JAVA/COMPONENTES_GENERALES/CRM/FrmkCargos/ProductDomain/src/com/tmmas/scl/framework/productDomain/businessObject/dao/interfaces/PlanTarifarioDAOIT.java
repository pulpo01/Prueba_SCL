package com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosDescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductOfferingException;



public interface PlanTarifarioDAOIT {
	
	public PlanTarifarioDTO getPlanTarifario(PlanTarifarioDTO planEntrada) throws ProductOfferingException;
	
	public PrecioCargoDTO[] getCargoBasico(PlanTarifarioDTO entrada) throws ProductOfferingException;
	
	public PlanTarifarioDTO getCategoriaPlanTarifario(PlanTarifarioDTO planEntrada) throws ProductOfferingException;
	
	public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada) throws ProductOfferingException;
}
