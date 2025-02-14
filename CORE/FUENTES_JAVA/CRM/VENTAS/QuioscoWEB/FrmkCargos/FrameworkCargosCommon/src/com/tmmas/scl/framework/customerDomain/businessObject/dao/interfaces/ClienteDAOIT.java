package com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.itermediario.ClienteDTOInt;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;

public interface ClienteDAOIT {

	public ClienteDTO obtenerDatosCliente(ClienteDTO cliente) throws CustomerException; 	
	
	public ClienteDTO obtenerCategoriaTributaria(ClienteDTO cliente) throws CustomerException;
	
	//public ClienteDTO getCliente(ClienteDTO cliente) throws CustomerException;
	
	public ClienteDTOInt getCliente(ClienteDTOInt cliente) throws CustomerException;
	

}

