package com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;

public interface ClienteIT {
	
	
	public ClienteDTO obtenerDatosCliente(ClienteDTO cliente) throws CustomerException;
	
	public ClienteDTO obtenerCategoriaTributaria(ClienteDTO cliente) throws CustomerException;
	
	public ClienteDTO getCliente(ClienteDTO cliente) throws CustomerException ;
	
}
