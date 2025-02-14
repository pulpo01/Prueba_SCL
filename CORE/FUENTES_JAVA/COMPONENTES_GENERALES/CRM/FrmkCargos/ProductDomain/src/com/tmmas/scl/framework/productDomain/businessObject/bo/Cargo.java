package com.tmmas.scl.framework.productDomain.businessObject.bo;

import java.util.ArrayList;
import java.util.StringTokenizer;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.GaSSAdelantadoCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.GaSSAdelantadoCargosListDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ImpuestosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosCargoHabilitacionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioEquipoNuevoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioTerminalDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.CargoIT;
import com.tmmas.scl.framework.productDomain.businessObject.dao.CargoDAO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.CargoDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
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

public class Cargo implements CargoIT  {

	private CargoDAOIT cargoDAO = new CargoDAO();
	
	private final Logger logger = Logger.getLogger(Cargo.class);
	private Global global = Global.getInstance();
	
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
	
	public PrecioCargoDTO[] getParametrosAbonadoCero(ParamCargosAbonadoCeroDTO inValue)throws ProductOfferingPriceException{
		PrecioCargoDTO[] retValue = null;
		try {
			logger.debug("getParametrosAbonadoCero():start");
			retValue = cargoDAO.getParametrosAbonadoCero(inValue);
			logger.debug("getParametrosAbonadoCero():end");
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

	public PrecioCargoDTO getValorCargoAbonadoCero(ParamCargosAbonadoCeroDTO inValue) throws ProductOfferingPriceException {
		PrecioCargoDTO retValue = null;
		try {
			logger.debug("getValorCargoAbonadoCero():start");
			retValue = cargoDAO.getValorCargoAbonadoCero(inValue);
			logger.debug("getValorCargoAbonadoCero():end");
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

	public RetornoDTO getValidacionAbonadoCero(ParamCargosAbonadoCeroDTO inValue) throws ProductOfferingPriceException {
		RetornoDTO retValue = null;
		try {
			logger.debug("getValidacionAbonadoCero():start");
			retValue = cargoDAO.getValidacionAbonadoCero(inValue);
			logger.debug("getValidacionAbonadoCero():end");
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
	
	public PrecioTerminalDTO getRecPrecioEquipoActual(TerminalDTO terminalDTO)throws ProductOfferingPriceException{	
		PrecioTerminalDTO retValue = null;
	try {
		logger.debug("getValidacionAbonadoCero():start");
		retValue = cargoDAO.getRecPrecioEquipoActual(terminalDTO);
		logger.debug("getValidacionAbonadoCero():end");
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
	
	/**
	 * CSR11003
	 * permite obtener el precio para el equipo nuevo, será invocado desde la OOSS restitucion equipo
	 */
	public PrecioTerminalDTO getRecPrecioEquipoNuevo(PrecioEquipoNuevoDTO precioEquipoNuevoDTO)throws ProductOfferingPriceException{	
		
		PrecioTerminalDTO retValue = null;
		
		try {
			
			logger.debug("getRecPrecioEquipoNuevo():start");
			retValue = cargoDAO.getRecPrecioEquipoNuevo(precioEquipoNuevoDTO);
			logger.debug("getRecPrecioEquipoNuevo():end");
			
		} catch (ProductOfferingPriceException e) {
			
			logger.debug("ProductOfferingPriceException[", e);
			throw e;
		}catch (Exception e) {
			
			logger.debug("Exception[", e);
			throw new ProductOfferingPriceException(e);
		}		
		
		return retValue;
	}
	
	/**
	 * CSR11003
	 * permite obtener la estructura de cargos para el concepto de garantia
	 */
	public PrecioCargoDTO[] getPrecioCargoDifGarantia(Double pValorGarantia) 
	throws ProductOfferingPriceException{	
		
		PrecioCargoDTO[] retValue = null;
		
		try {
			
			logger.debug("getPrecioCargoDifGarantia():start");
			retValue = cargoDAO.getPrecioCargoDifGarantia(pValorGarantia);
			logger.debug("getPrecioCargoDifGarantia():end");
			
		} catch (ProductOfferingPriceException e) {
			
			logger.debug("ProductOfferingPriceException[", e);
			throw e;
		}catch (Exception e) {
			
			logger.debug("Exception[", e);
			throw new ProductOfferingPriceException(e);
		}		
		
		return retValue;
	}
	
	public GaSSAdelantadoCargosListDTO obtenerListaSSAdelantadoCargos(GaSSAdelantadoCargosDTO gaSSAdelantadoCargos) throws ProductOfferingPriceException{
		GaSSAdelantadoCargosListDTO retValue=new GaSSAdelantadoCargosListDTO();
		try {
			logger.debug("obtenerListaSSAdelantadoCargos():start");
			/**
			 * @description tratamiento cadena como parametro de entrada
			 */
			StringTokenizer tokens=new StringTokenizer(gaSSAdelantadoCargos.getCadenaSS(),"|");
			ArrayList listCargosAd= new ArrayList();
			while(tokens.hasMoreTokens()){  
				gaSSAdelantadoCargos.setCadenaSS(tokens.nextToken()+"|");
				GaSSAdelantadoCargosDTO gaSSAdelantadoCargosDTO=cargoDAO.obtenerCargoSSAdelantado(gaSSAdelantadoCargos);
					if (gaSSAdelantadoCargosDTO!=null){
						listCargosAd.add(gaSSAdelantadoCargosDTO);
					}
				}  	
			
			retValue.setGaSSAdelantadoCargosDTO((GaSSAdelantadoCargosDTO[])listCargosAd.toArray(new GaSSAdelantadoCargosDTO[listCargosAd.size()]));
				logger.debug("obtenerListaSSAdelantadoCargos():end");
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
	
}
