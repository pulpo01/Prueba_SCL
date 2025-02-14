package com.tmmas.scl.operations.crm.f.sel.negsal.interfaces;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.IngresoVentaDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.exception.NegSalException;

public interface GestionPresupuestoSrvIF {
	
	public RetornoDTO registrarVenta(IngresoVentaDTO venta) throws NegSalException;

}
