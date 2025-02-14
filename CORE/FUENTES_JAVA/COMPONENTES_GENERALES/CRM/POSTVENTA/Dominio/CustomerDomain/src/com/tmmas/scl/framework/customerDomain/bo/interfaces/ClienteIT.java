package com.tmmas.scl.framework.customerDomain.bo.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;



public interface ClienteIT {

	public ClienteDTO obtenerDatosCliente(ClienteDTO cliente) throws CustomerException;
	/**
	 * Obtiene los datos del cliente para las OOSS Aviso y Anulacion de Siniestro.
	 * Package: PV_DATOS_CLIENTES_PG.PV_OBTIENE_DATOS_CLIENTE2_PR
	 * @param cliente del tipo ClienteDTO
	 * @return ClienteDTO
	 * @throws CustomerException
	 * @author Santiago Ventura
	 * @date 15-04-2010 
	 */
	public ClienteDTO obtenerDatosCliente2(ClienteDTO cliente) throws CustomerException;	
}
