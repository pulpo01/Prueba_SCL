package com.tmmas.cl.scl.frameworkcargos.srv.gcd.interfaces;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.commonDoman.exception.FrmkCargosException;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CargoOcasionalListDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CargoRecurrenteListDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ImpuestosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioEquipoNuevoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioTerminalDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DatosGeneralesDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.TerminalDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PresupuestoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegistroSolicitudDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegistroSolicitudListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RespuestaSolicitudDTO;

public interface GestionCargosDescuentosSrvIF {
	
	public ObtencionCargosDTO obtenerCargos(ParametrosObtencionCargosDTO parametros)throws FrmkCargosException;
	
	public RespuestaSolicitudDTO solicitarAprobacionDescuento(RegistroSolicitudListDTO registro)throws FrmkCargosException;
	
	public RegistroSolicitudDTO consultarEstadoSolicitud(RegistroSolicitudDTO registro) throws FrmkCargosException;
	
	public ImpuestosDTO obtenerImpuestos(ImpuestosDTO impuestos) throws FrmkCargosException;	

	public RetornoDTO aceptarPresupuesto(PresupuestoDTO presup) throws FrmkCargosException;	
	
	public RetornoDTO finalizarCargosFacturados(ProductoContratadoListDTO listaProductos) throws FrmkCargosException;
	
	public RetornoDTO descontratarCargosRecurrentes(ProductoContratadoListDTO listaProductos) throws FrmkCargosException;
	
	public RetornoDTO informarCargosOcasionales(CargoOcasionalListDTO cargosOc) throws FrmkCargosException;
	
	public RetornoDTO informarCargosRecurrentes(CargoRecurrenteListDTO cargosReq) throws FrmkCargosException;
	
	public RetornoDTO consultarEstadoFacturado(long numProceso) throws FrmkCargosException;
	
	public PresupuestoDTO obtenerDetallePresupuesto(PresupuestoDTO presup) throws FrmkCargosException;
	
	public DescuentoDTO obtenerCodConceptoDescuento(DatosGeneralesDTO sec) throws FrmkCargosException;
	
	public RetornoDTO eliminaCodConceptoDescuento(long numTransaccion) throws FrmkCargosException;	
	
	public RetornoDTO insertarConceptoDescuento(DescuentoDTO desc) throws FrmkCargosException;
	
	public RetornoDTO eliminarSolicitud(RegistroSolicitudDTO registro) throws FrmkCargosException;
	
	public RetornoDTO eliminarPresupuesto(RegistroFacturacionDTO registro) throws FrmkCargosException;
	
	public PrecioTerminalDTO getRecPrecioEquipoActual(TerminalDTO terminalDTO)throws GeneralException;
	
	public PrecioTerminalDTO getRecPrecioEquipoNuevo(PrecioEquipoNuevoDTO precioEquipoNuevoDTO)throws GeneralException;
	
}
