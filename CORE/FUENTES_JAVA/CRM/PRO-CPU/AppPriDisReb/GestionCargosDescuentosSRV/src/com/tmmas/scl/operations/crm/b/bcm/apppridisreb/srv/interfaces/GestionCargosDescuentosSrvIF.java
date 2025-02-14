package com.tmmas.scl.operations.crm.b.bcm.apppridisreb.srv.interfaces;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.CargoImpuestoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ProrrateoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargoOcasionalListDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargoRecurrenteDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargoRecurrenteListDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ImpuestosDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.DatosGeneralesDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.PresupuestoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.RegistroSolicitudDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.RegistroSolicitudListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.RespuestaSolicitudDTO;
import com.tmmas.scl.operations.crm.b.bcm.apppridisreb.common.exception.AppPriDisRebException;

public interface GestionCargosDescuentosSrvIF {
	
	//public ObtencionCargosDTO obtenerCargos(ParametrosObtencionCargosDTO parametros)throws AppPriDisRebException;
	
	public RespuestaSolicitudDTO solicitarAprobacionDescuento(RegistroSolicitudListDTO registro)throws AppPriDisRebException;
	
	public RegistroSolicitudDTO consultarEstadoSolicitud(RegistroSolicitudDTO registro) throws AppPriDisRebException;
	
	public ImpuestosDTO obtenerImpuestos(ImpuestosDTO impuestos) throws AppPriDisRebException;	

	public RetornoDTO aceptarPresupuesto(PresupuestoDTO presup) throws AppPriDisRebException;	
	
	public RetornoDTO finalizarCargosFacturados(ProductoContratadoListDTO listaProductos) throws AppPriDisRebException;
	
	public RetornoDTO eliminarCargosFacturados(ProductoContratadoListDTO listaProductos) throws AppPriDisRebException;
	
	public RetornoDTO descontratarCargosRecurrentes(ProductoContratadoListDTO listaProductos) throws AppPriDisRebException;
	
	public RetornoDTO informarCargosOcasionales(CargoOcasionalListDTO cargosOc) throws AppPriDisRebException;
	
	public RetornoDTO informarCargosRecurrentes(CargoRecurrenteListDTO cargosReq) throws AppPriDisRebException;
	
	public RetornoDTO consultarEstadoFacturado(long numProceso) throws AppPriDisRebException;
	
	public PresupuestoDTO obtenerDetallePresupuesto(PresupuestoDTO presup) throws AppPriDisRebException;
	
	public DescuentoDTO obtenerCodConceptoDescuento(DatosGeneralesDTO sec) throws AppPriDisRebException;
	
	public RetornoDTO eliminaCodConceptoDescuento(long numTransaccion) throws AppPriDisRebException;	
	
	public RetornoDTO insertarConceptoDescuento(DescuentoDTO desc) throws AppPriDisRebException;
	
	public RetornoDTO eliminarSolicitud(RegistroSolicitudDTO registro) throws AppPriDisRebException;
	
	public RetornoDTO eliminarPresupuesto(RegistroFacturacionDTO registro) throws AppPriDisRebException;
	
	public RetornoDTO insertaCobroAdelantado(CargoRecurrenteDTO cargoRecurrenteDTO)	throws GeneralException;
	
	public ProrrateoDTO getCargoRecurrenteProrrateo(CargoRecurrenteDTO cargoRecurrenteDTO)throws GeneralException;
	
	public CargoImpuestoDTO getImpuestoImporte(CargoImpuestoDTO cargoImpuestoDTO)throws GeneralException;
}
