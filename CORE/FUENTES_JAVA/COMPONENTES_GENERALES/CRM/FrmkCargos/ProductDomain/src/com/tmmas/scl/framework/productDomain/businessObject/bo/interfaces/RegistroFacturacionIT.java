package com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ImpuestosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ProcesoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistroCargosBatchDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ArchivoFacturaDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public interface RegistroFacturacionIT {
	
	public RegistroFacturacionDTO getCodigoPromedioFacturado(RegistroFacturacionDTO entrada) throws ProductException;
	
	public RegistroFacturacionDTO getCodigoCicloFacturacion(ClienteDTO cliente) throws ProductException;
	
	public void ejecutaPrebilling(RegistroFacturacionDTO entrada) throws ProductException;
	
	public RegistroFacturacionDTO getSecuenciaProcesoFacturacion(RegistroFacturacionDTO parametroEntrada) throws ProductException;
	
	public RegistroFacturacionDTO getModoGeneracion(RegistroFacturacionDTO registroFacturacion) throws ProductException;
	
	public ImpuestosDTO getDatosPresupuesto(ImpuestosDTO parametroEntrada) throws ProductException;
	
	public ProcesoDTO actualizaFacturacion(RegistroFacturacionDTO parametroEntrada)throws ProductException;
	
	public ArchivoFacturaDTO obtenerRutaFactura(ArchivoFacturaDTO factura) throws ProductException;
	
	public RetornoDTO registraCargosBatch(RegistroCargosBatchDTO registro) throws ProductException;
}
