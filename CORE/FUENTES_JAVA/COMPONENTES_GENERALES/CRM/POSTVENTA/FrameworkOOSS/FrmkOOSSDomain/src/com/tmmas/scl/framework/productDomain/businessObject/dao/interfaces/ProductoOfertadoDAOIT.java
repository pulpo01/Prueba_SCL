package com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces;

import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductOfferingException;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.ReglasListaNumerosListDTO;

public interface ProductoOfertadoDAOIT {
	
	
	public ProductoOfertadoListDTO obtenerDetalleProductos(ProductoOfertadoListDTO listaProductos) throws ProductOfferingException;

	public ReglasListaNumerosListDTO obtenerRestriccionesLista(ProductoOfertadoListDTO listaProductos) throws ProductOfferingException;
	
	public ProductoOfertadoListDTO obtenerProductosOfertables(AbonadoDTO abonado) throws ProductOfferingException;
}
