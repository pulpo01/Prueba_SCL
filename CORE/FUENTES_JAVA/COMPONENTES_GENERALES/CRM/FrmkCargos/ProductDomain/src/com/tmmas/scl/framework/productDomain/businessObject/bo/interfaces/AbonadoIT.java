package com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosObtencionCargosDTO;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public interface AbonadoIT {
	
	public AbonadoListDTO obtenerListaAbonados(ClienteDTO cliente) throws ProductException;
	
	public AbonadoDTO obtenerDatosAbonado(AbonadoDTO abonado) throws ProductException;
	
	public void updCodigoSituacion(AbonadoDTO abonado)	throws ProductException;
	
	public ParametrosObtencionCargosDTO verificaRenovacion(ParametrosObtencionCargosDTO abonado) throws ProductException;
	
}
