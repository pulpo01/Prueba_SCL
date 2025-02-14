package com.tmmas.scl.doblecuenta.businessobject.bo.interfaces;

import com.tmmas.scl.doblecuenta.commonapp.dto.ClienteDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.ClientesAsociadosDTO;
import com.tmmas.scl.doblecuenta.commonapp.exception.ProyectoException;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;

public interface ClienteBOIT {
	
	public ClienteDTO[] obtenerListaClientesAsociados(ClienteDTO cliente) throws ProyectoException;
	
	public ClienteDTO obtenerInformacionCliente(ClienteDTO clienteContratante) throws ProyectoException;
	
	public ClientesAsociadosDTO[] buscarClientesAsociados(ClienteDTO clienteContratante) throws ProyectoException;
	
	public SecuenciaDTO obtenerSecuencia(SecuenciaDTO parametro) throws ProyectoException;
}
