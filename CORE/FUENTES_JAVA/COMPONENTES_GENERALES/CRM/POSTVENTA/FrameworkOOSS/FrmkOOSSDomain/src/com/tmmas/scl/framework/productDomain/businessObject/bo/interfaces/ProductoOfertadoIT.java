package com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces;

import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductOfferingException;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioListaDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.ReglasListaNumerosListDTO;

public interface ProductoOfertadoIT {
	
	public ProductoOfertadoListDTO obtenerDetalleProductos(ProductoOfertadoListDTO listaProductos) throws ProductOfferingException;	

	public ReglasListaNumerosListDTO obtenerRestriccionesLista(EspecServicioListaDTO especServicioLista) throws ProductOfferingException;
	
	public ProductoOfertadoListDTO obtenerProductosOfertables(AbonadoDTO abonado) throws ProductOfferingException;

}
