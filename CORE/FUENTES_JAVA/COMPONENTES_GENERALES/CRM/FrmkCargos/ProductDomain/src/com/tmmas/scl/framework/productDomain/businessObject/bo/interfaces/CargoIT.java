package com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.GaSSAdelantadoCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.GaSSAdelantadoCargosListDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ImpuestosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosCargoHabilitacionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioEquipoNuevoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioTerminalDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CargoListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DatosGeneralesDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParamCargosAbonadoCeroDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.TerminalDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoIndemnizQTDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargosDevlEquipoAccesorioQTDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ParamBajaIndemnizacionQTDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PresupuestoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PvGaImpenalizaQTDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.exception.ProductOfferingPriceException;

public interface CargoIT {

	//public RetornoDTO actualizarCargoBolsaDinamica(BolsaDinamicaDTO bolsa) throws ProductOfferingPriceException;
	
	public ImpuestosDTO obtenerImpuestos(ImpuestosDTO impuestos) throws ProductOfferingPriceException;	

	public CargoListDTO obtenerDetalleCargos(CargoListDTO cargoList) throws ProductOfferingPriceException;
		
	public RetornoDTO aceptarPresupuesto(PresupuestoDTO presup) throws ProductOfferingPriceException;
	
	//public FormaPagoListDTO obtenerFormasPago(BusquedaFormasPagoDTO param) throws ProductOfferingPriceException;

	//public DocumentoListDTO obtenerTiposDocumentos(BusquedaTiposDocumentoDTO param) throws ProductOfferingPriceException;		
	
	public PrecioCargoDTO[] getCargosDevolucionEquipoAccesorio(CargosDevlEquipoAccesorioQTDTO cargosDevlEquipoAccesorioQTDTO)throws ProductOfferingPriceException;
	
	public PrecioCargoDTO[] getCargosPenalizacion(PvGaImpenalizaQTDTO pvGaImpenalizaQTDTO)throws ProductOfferingPriceException;
	
	public PrecioCargoDTO[] getCargosIndemnizacion(CargoIndemnizQTDTO inValue)throws ProductOfferingPriceException;
	
	public ParamBajaIndemnizacionQTDTO[] getParametrosbajaIndemnizacion(ParamBajaIndemnizacionQTDTO inValue)throws ProductOfferingPriceException;
	
	public RetornoDTO consultarEstadoFacturado(long numProceso) throws ProductOfferingPriceException;
	
	public PresupuestoDTO obtenerDetallePresupuesto(PresupuestoDTO presup) throws ProductOfferingPriceException;
	
	public DescuentoDTO obtenerCodConceptoDescuento(DatosGeneralesDTO sec) throws ProductOfferingPriceException;
	
	public RetornoDTO eliminaCodConceptoDescuento(long numTransaccion) throws ProductOfferingPriceException;	
	
	public RetornoDTO insertarConceptoDescuento(DescuentoDTO param) throws ProductOfferingPriceException;
	
	public RetornoDTO eliminarPresupuesto(RegistroFacturacionDTO registro)throws ProductOfferingPriceException;
	
	public PrecioCargoDTO[] getParametrosAbonadoCero(ParamCargosAbonadoCeroDTO inValue)throws ProductOfferingPriceException;
	
	public PrecioCargoDTO getValorCargoAbonadoCero(ParamCargosAbonadoCeroDTO inValue)throws ProductOfferingPriceException;
	
	public RetornoDTO getValidacionAbonadoCero(ParamCargosAbonadoCeroDTO inValue)throws ProductOfferingPriceException;
	
	public AbonadoDTO obtenerCodigoModalidad(AbonadoDTO abonado) throws ProductOfferingPriceException;
	
	public PrecioTerminalDTO getRecPrecioEquipoActual(TerminalDTO terminalDTO)throws ProductOfferingPriceException;
	
	public PrecioTerminalDTO getRecPrecioEquipoNuevo(PrecioEquipoNuevoDTO precioEquipoNuevoDTO)throws ProductOfferingPriceException;
	
	public GaSSAdelantadoCargosListDTO obtenerListaSSAdelantadoCargos(GaSSAdelantadoCargosDTO gaSSAdelantadoCargos) throws ProductOfferingPriceException;
	
	public PrecioCargoDTO[] getPrecioCargoDifGarantia(Double pValorGarantia) throws ProductOfferingPriceException;
	
}
