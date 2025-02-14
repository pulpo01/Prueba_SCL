package com.tmmas.scl.framework.productDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ImpuestosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.CargoIT;
import com.tmmas.scl.framework.productDomain.businessObject.dao.CargoDAO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.CargoDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CargoListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DatosGeneralesDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.BolsaDinamicaDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.BusquedaFormasPagoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.BusquedaTiposDocumentoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoIndemnizQTDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargosDevlEquipoAccesorioQTDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.DocumentoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.FormaPagoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ParamBajaIndemnizacionQTDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PresupuestoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PvGaImpenalizaQTDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.exception.ProductOfferingPriceException;

public class Cargo implements CargoIT  {

	private CargoDAOIT cargoDAO = new CargoDAO();
	
	private final Logger logger = Logger.getLogger(Cargo.class);
	private Global global = Global.getInstance();
	
	public RetornoDTO actualizarCargoBolsaDinamica(BolsaDinamicaDTO bolsa)
			throws ProductOfferingPriceException {
		RetornoDTO retorno = null;
		try {
			logger.debug("actualizarCargoBolsaDinamica():start");
			retorno = cargoDAO.actualizarCargoBolsaDinamica(bolsa);
			logger.debug("actualizarCargoBolsaDinamica():end");
		} catch (ProductOfferingPriceException e) {
			logger.debug("ProductOfferingPriceException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductOfferingPriceException(e);
		}		
		return retorno;	

	}

	public ImpuestosDTO obtenerImpuestos(ImpuestosDTO impuestos) throws ProductOfferingPriceException{
		ImpuestosDTO retorno = null;
		try {
			logger.debug("obtenerImpuestos():start");
			retorno = cargoDAO.obtenerImpuestos(impuestos);
			logger.debug("obtenerImpuestos():end");
		} catch (ProductOfferingPriceException e) {
			logger.debug("ProductOfferingPriceException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductOfferingPriceException(e);
		}		
		return retorno;	
	}
	
	public CargoListDTO obtenerDetalleCargos(CargoListDTO cargoList) throws ProductOfferingPriceException {
		CargoListDTO retorno = null;
		try {
			logger.debug("obtenerDetalleCargos():start");
			retorno = cargoDAO.obtenerDetalleCargos(cargoList);
			logger.debug("obtenerDetalleCargos():end");
		} 
		catch (ProductOfferingPriceException e) {
			logger.debug("ProductOfferingPriceException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductOfferingPriceException(e);
		}		
		return retorno;	
	}
	
	public RetornoDTO aceptarPresupuesto(PresupuestoDTO presup) throws ProductOfferingPriceException{
		RetornoDTO retorno = null;
		try {
			logger.debug("aceptarPresupuesto():start");
			retorno = cargoDAO.aceptarPresupuesto(presup);
			logger.debug("aceptarPresupuesto():end");
		} catch (ProductOfferingPriceException e) {
			logger.debug("ProductOfferingPriceException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductOfferingPriceException(e);
		}		
		return retorno;			
	}
	
	public FormaPagoListDTO obtenerFormasPago(BusquedaFormasPagoDTO param) throws ProductOfferingPriceException{
		FormaPagoListDTO retorno = null;
		try {
			logger.debug("obtenerFormasPago():start");
			retorno = cargoDAO.obtenerFormasPago(param);
			logger.debug("obtenerFormasPago():end");
		} catch (ProductOfferingPriceException e) {
			logger.debug("ProductOfferingPriceException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductOfferingPriceException(e);
		}		
		return retorno;				
	}

	public DocumentoListDTO obtenerTiposDocumentos(BusquedaTiposDocumentoDTO param) throws ProductOfferingPriceException{
		DocumentoListDTO retorno = null;
		try {
			logger.debug("obtenerTiposDocumentos():start");
			retorno = cargoDAO.obtenerTiposDocumentos(param);
			logger.debug("obtenerTiposDocumentos():end");
		} catch (ProductOfferingPriceException e) {
			logger.debug("ProductOfferingPriceException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductOfferingPriceException(e);
		}		
		return retorno;		
		
	}
	
	public PrecioCargoDTO[] getCargosDevolucionEquipoAccesorio(CargosDevlEquipoAccesorioQTDTO cargosDevlEquipoAccesorioQTDTO)throws ProductOfferingPriceException{
		PrecioCargoDTO[] retValue = null;
		try {
			logger.debug("getCargosDevolucionEquipo():start");
			retValue = cargoDAO.getCargosDevolucionEquipoAccesorio(cargosDevlEquipoAccesorioQTDTO);
			logger.debug("getCargosDevolucionEquipo():end");
		} catch (ProductOfferingPriceException e) {
			logger.debug("ProductOfferingPriceException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductOfferingPriceException(e);
		}		
		return retValue;
	}
	
	public PrecioCargoDTO[] getCargosPenalizacion(PvGaImpenalizaQTDTO pvGaImpenalizaQTDTO)throws ProductOfferingPriceException{
		PrecioCargoDTO[] retValue = null;
		try {
			logger.debug("getCargosPenalizacion():start");
			retValue = cargoDAO.getCargosPenalizacion(pvGaImpenalizaQTDTO);
			logger.debug("getCargosPenalizacion():end");
		} catch (ProductOfferingPriceException e) {
			logger.debug("ProductOfferingPriceException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductOfferingPriceException(e);
		}		
		return retValue;
	}
	public PrecioCargoDTO[] getCargosIndemnizacion(CargoIndemnizQTDTO inValue)throws ProductOfferingPriceException{
		
		PrecioCargoDTO[] retValue = null;
		try {
			logger.debug("getCargosPenalizacion():start");
			retValue = cargoDAO.getCargosIndemnizacion(inValue);
			logger.debug("getCargosPenalizacion():end");
		} catch (ProductOfferingPriceException e) {
			logger.debug("ProductOfferingPriceException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductOfferingPriceException(e);
		}		
		return retValue;
		
	}
	
	public ParamBajaIndemnizacionQTDTO[] getParametrosbajaIndemnizacion(ParamBajaIndemnizacionQTDTO inValue)throws ProductOfferingPriceException{
		ParamBajaIndemnizacionQTDTO[] retValue = null;
		try {
			logger.debug("getParametrosbajaIndemnizacion():start");
			retValue = cargoDAO.getParametrosbajaIndemnizacion(inValue);
			logger.debug("getParametrosbajaIndemnizacion():end");
		} catch (ProductOfferingPriceException e) {
			logger.debug("ProductOfferingPriceException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductOfferingPriceException(e);
		}		
		return retValue;
	}
	
	public RetornoDTO consultarEstadoFacturado(long numProceso) throws ProductOfferingPriceException{
		RetornoDTO retorno = null;
		try {
			logger.debug("consultarEstadoFacturado():start");
			retorno = cargoDAO.consultarEstadoFacturado(numProceso);
			logger.debug("consultarEstadoFacturado():end");
		} catch (ProductOfferingPriceException e) {
			logger.debug("ProductOfferingPriceException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductOfferingPriceException(e);
		}		
		return retorno;		
	}
	
	public PresupuestoDTO obtenerDetallePresupuesto(PresupuestoDTO presup) throws ProductOfferingPriceException{
		PresupuestoDTO retorno = null;
		try {
			logger.debug("obtenerDetallePresupuesto():start");
			retorno = cargoDAO.obtenerDetallePresupuesto(presup);
			logger.debug("obtenerDetallePresupuesto():end");
		} catch (ProductOfferingPriceException e) {
			logger.debug("ProductOfferingPriceException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductOfferingPriceException(e);
		}		
		return retorno;		
	}	
	
	public DescuentoDTO obtenerCodConceptoDescuento(DatosGeneralesDTO sec) throws ProductOfferingPriceException{
		DescuentoDTO retorno = null;
		try {
			logger.debug("obtenerCodConceptoDescuento():start");
			retorno = cargoDAO.obtenerCodConceptoDescuento(sec);
			logger.debug("obtenerCodConceptoDescuento():end");
		} catch (ProductOfferingPriceException e) {
			logger.debug("ProductOfferingPriceException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductOfferingPriceException(e);
		}		
		return retorno;				
	}
	
	public RetornoDTO eliminaCodConceptoDescuento(long numTransaccion) throws ProductOfferingPriceException{
		RetornoDTO retorno = null;
		try {
			logger.debug("eliminaCodConceptoDescuento():start");
			retorno = cargoDAO.eliminaCodConceptoDescuento(numTransaccion);
			logger.debug("eliminaCodConceptoDescuento():end");
		} catch (ProductOfferingPriceException e) {
			logger.debug("ProductOfferingPriceException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductOfferingPriceException(e);
		}		
		return retorno;		
	}
	
	public RetornoDTO insertarConceptoDescuento(DescuentoDTO param) throws ProductOfferingPriceException{
		RetornoDTO retorno = null;
		try {
			logger.debug("insertarConceptoDescuento():start");
			retorno = cargoDAO.insertarConceptoDescuento(param);
			logger.debug("insertarConceptoDescuento():end");
		} catch (ProductOfferingPriceException e) {
			logger.debug("ProductOfferingPriceException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductOfferingPriceException(e);
		}		
		return retorno;			
	}
	
	public RetornoDTO eliminarPresupuesto(RegistroFacturacionDTO registro) throws ProductOfferingPriceException{
		RetornoDTO retorno = null;
		try {
			logger.debug("eliminarPresupuesto():start");
			retorno = cargoDAO.eliminarPresupuesto(registro);
			logger.debug("eliminarPresupuesto():end");
		} catch (ProductOfferingPriceException e) {
			logger.debug("ProductOfferingPriceException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductOfferingPriceException(e);
		}		
		return retorno;			
	}
	
	public AbonadoDTO obtenerCodigoModalidad(AbonadoDTO abonado) throws ProductOfferingPriceException{
		AbonadoDTO retorno = null;
		try {
			logger.debug("obtenerCodigoModalidad():start");
			retorno = cargoDAO.obtenerCodigoModalidad(abonado);
			logger.debug("obtenerCodigoModalidad():end");
		} catch (ProductOfferingPriceException e) {
			logger.debug("ProductOfferingPriceException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductOfferingPriceException(e);
		}		
		return retorno;				
	}
}
