package com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.OrdenServicioDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.marketSalesDomain.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CambioPlanComercialDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CausaBajaListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CuentaPersonalDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DesactServFreDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ListaFrecuentesDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PaqueteContratadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PaqueteContratadoListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanServicioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ReordenamientoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.TraspasoPlanDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public interface ProductoContratadoIT {

	public RetornoDTO registraReordenamientoPlan(ReordenamientoDTO datos) throws ProductException;	
	public RetornoDTO registroCambPlanComer(CambioPlanComercialDTO datos) throws ProductException;	
	public RetornoDTO validaDesacListaFrecuente(ListaFrecuentesDTO lista) throws ProductException;	
	public RetornoDTO registraTraspasoPlan(TraspasoPlanDTO traspaso) throws ProductException;	
	public RetornoDTO registraDesActSerFre(DesactServFreDTO param) throws ProductException;	
	public RetornoDTO registroCambPlanServ(PlanServicioDTO plan) throws ProductException;	
	public RetornoDTO validaCuentaPersonal(CuentaPersonalDTO cuenta) throws ProductException;	
	public RetornoDTO activar(ProductoContratadoListDTO productos) throws ProductException;		
	public RetornoDTO activar(PaqueteContratadoListDTO paquetes) throws ProductException;	
	public RetornoDTO notificar(VentaDTO venta) throws ProductException;	
	public RetornoDTO actualizarEstado(VentaDTO venta) throws ProductException;	
	public AbonadoDTO obtenerDatosCambPlanServ(AbonadoDTO abonado) throws ProductException;	
	public ProductoContratadoListDTO obtenerProductoContratado(OrdenServicioDTO ordenServicio) throws ProductException;	
	public ProductoContratadoListDTO obtenerProductosContratadosVenta(VentaDTO venta) throws ProductException;	
	public RetornoDTO desactivar(ProductoContratadoListDTO listaProductosContratados) throws ProductException;	
	public CausaBajaListDTO obtenerCausaBaja() throws ProductException;	
	public PaqueteContratadoDTO obtenerProductosContratadosPorPaquete(PaqueteContratadoDTO paqueteContratado) throws ProductException;	
	public RetornoDTO descontratar(ProductoContratadoListDTO listaProductosContratados) throws ProductException;
	public ProductoContratadoListDTO obtenerDetalleProductoContratado(ProductoContratadoListDTO listaProductos) throws ProductException;
	
}
