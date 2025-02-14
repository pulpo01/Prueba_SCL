package com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.itermediario.AbonadoDTOInt;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroVentaDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public interface AbonadoDAOIT {
	
	public AbonadoListDTO obtenerListaAbonados(ClienteDTO cliente) throws ProductException;

	public AbonadoDTO obtenerDatosAbonado(AbonadoDTO abonado) throws ProductException;
	
	public void updCodigoSituacion(AbonadoDTO abonado)	throws ProductException;
	
	public AbonadoDTOInt[] getListaAbonadosVenta(RegistroVentaDTO registroventa) throws ProductException;
	
	public AbonadoDTOInt[] getListaAbonadosVentaKit(RegistroVentaDTO registroventa) throws ProductException;
	
	public AbonadoDTOInt[] getListaAbonadosVentaNoKit(RegistroVentaDTO registroventa) throws ProductException;
	   
	
}
