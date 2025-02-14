package com.tmmas.scl.operations.crm.o.csr.supcusintman.srv.interfaces;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CuentaPersonalDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ContratanteBeneficiarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RestriccionesContratacionDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RestriccionesContratacionListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;
import com.tmmas.scl.operations.crm.o.csr.supcusintman.common.exception.SupCusIntManException;

public interface GestionValidacionesSrvIF {
	
	public RetornoDTO validaCuentaPersonal(CuentaPersonalDTO cuenta) throws SupCusIntManException;	
	public NumeroDTO obtenerTipoNumero(NumeroDTO numero) throws SupCusIntManException;
	public ClienteDTO validarCliente(ClienteDTO cliente) throws SupCusIntManException;
	public RestriccionesContratacionListDTO obtenerRestriccionesContratacion(RestriccionesContratacionDTO restricciones) throws SupCusIntManException;
	public RetornoDTO validarContratanteBeneficiario(ContratanteBeneficiarioDTO contratanteBeneficiarioDTO) throws SupCusIntManException;

}
