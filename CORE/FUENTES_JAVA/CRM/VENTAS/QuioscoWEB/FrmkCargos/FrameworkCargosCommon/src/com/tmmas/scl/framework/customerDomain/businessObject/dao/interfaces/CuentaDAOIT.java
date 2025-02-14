package com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteTipoPlanListDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.SubCuentaListDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;

public interface CuentaDAOIT {

	public ClienteTipoPlanListDTO obtenerDatosClienteCuenta(ClienteDTO cliente) throws CustomerException;
	
	public SubCuentaListDTO obtenerSubCuentas(ClienteDTO cliente) throws CustomerException;
	
}
