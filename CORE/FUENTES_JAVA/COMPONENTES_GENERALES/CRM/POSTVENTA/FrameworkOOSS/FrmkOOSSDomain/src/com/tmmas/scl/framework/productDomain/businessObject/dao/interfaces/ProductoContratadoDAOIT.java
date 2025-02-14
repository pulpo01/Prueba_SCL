package com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.OrdenServicioDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.marketSalesDomain.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PaqueteContratadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoContratadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public interface ProductoContratadoDAOIT 
{		
	public RetornoDTO activar(ProductoContratadoDTO producto) throws ProductException;	
	public RetornoDTO activar(PaqueteContratadoDTO paquete) throws ProductException;		
	public RetornoDTO notificar(VentaDTO venta) throws ProductException;	
	public RetornoDTO actualizarEstado(VentaDTO venta) throws ProductException;			
	public ProductoContratadoListDTO obtenerProductosContratadosVenta(VentaDTO venta) throws ProductException;	
	public RetornoDTO desactivar(ProductoContratadoListDTO listaProductosContratados) throws ProductException;	
	public ProductoContratadoListDTO obtenerProductosContratados(OrdenServicioDTO ordenServicio)throws ProductException;	
	public PaqueteContratadoDTO obtenerProductosContratadosPorPaquete(PaqueteContratadoDTO paqueteContratado) throws ProductException;	
	public RetornoDTO descontratar(ProductoContratadoListDTO productoContratadoList) throws ProductException;		
	public SecuenciaDTO obtenerSecuencia(SecuenciaDTO secuencia) throws ProductException;
	public ProductoContratadoListDTO obtenerDetalleProductoContratado(ProductoContratadoListDTO listaProductos) throws ProductException;
}
