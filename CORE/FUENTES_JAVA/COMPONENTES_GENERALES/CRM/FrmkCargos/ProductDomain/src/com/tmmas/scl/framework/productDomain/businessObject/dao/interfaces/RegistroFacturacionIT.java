package com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ImpuestosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public interface RegistroFacturacionIT {
	
	public RegistroFacturacionDTO getCodigoPromedioFacturado(RegistroFacturacionDTO entrada) throws ProductException;
	
	public RegistroFacturacionDTO getCodigoCicloFacturacion(ClienteDTO cliente) throws ProductException;
	
	public void ejecutaPrebilling(RegistroFacturacionDTO entrada) throws ProductException;
	
	public RegistroFacturacionDTO getSecuenciaProcesoFacturacion(RegistroFacturacionDTO parametroEntrada) throws ProductException;
	
	public RegistroFacturacionDTO getModoGeneracion(RegistroFacturacionDTO registroFacturacion) throws ProductException;
	
	public ImpuestosDTO getDatosPresupuesto(ImpuestosDTO parametroEntrada) throws ProductException;
		
}
