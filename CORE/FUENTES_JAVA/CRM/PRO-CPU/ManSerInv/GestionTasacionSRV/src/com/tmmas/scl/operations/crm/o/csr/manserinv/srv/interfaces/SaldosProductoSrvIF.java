package com.tmmas.scl.operations.crm.o.csr.manserinv.srv.interfaces;

import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.SaldoProductoCliente;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.SaldoProductoTasacionListDTO;
import com.tmmas.scl.operations.crm.o.csr.manserinv.common.exception.ManSerInvException;

public interface SaldosProductoSrvIF {
	public SaldoProductoTasacionListDTO obtenerSaldosProducto(SaldoProductoCliente productoCliente) throws  ManSerInvException;
}