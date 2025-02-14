package com.tmmas.scl.operations.crm.f.oh.comord.srvord.interfaces;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.IntarcelDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.BusquedaServiciosDefaultDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegistroServiciosListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ServiciosDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.ValidaServiciosDTO;
import com.tmmas.scl.operations.crm.f.oh.comord.common.exception.ComOrdException;

public interface GestionComplementoOrdenSrvIF {
	
	public ServiciosDTO obtenerServiciosDefaultPlan(BusquedaServiciosDefaultDTO param) throws ComOrdException;
	
	public RegistroServiciosListDTO validaServicioActDesc(ValidaServiciosDTO param) throws ComOrdException;
	
	public RetornoDTO insertaIntarcelAcciones(IntarcelDTO intarcel) throws ComOrdException;
}
