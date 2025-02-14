package com.tmmas.scl.framework.productDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosDescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosValidacionLogisticaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ProcesoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ResultadoValidacionLogisticaDTO;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.KitBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.dao.KitDAO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.TerminalDAO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.KitDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.KitDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCargoKitDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public class KitBO implements KitBOIT{
		
	
	private final Logger logger = Logger.getLogger(TerminalDAO.class);
	private KitDAOIT kitDAO = new KitDAO();
			
		Global global = Global.getInstance();
		
/*		public ResultadoValidacionLogisticaDTO validaLargoSerieKit(ParametrosValidacionLogisticaDTO entrada)
		throws ProductException{
			ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
			logger.debug("Inicio:validaLargoSerieSimcard()");
			resultado = kitDAO.getLargoSerieSimcard(entrada);
			if (resultado.getLargoSerie() == entrada.getNumeroSerie().length())
				resultado.setResultado(true);
			else
				resultado.setResultado(false);
			logger.debug("Fin:validaLargoSerieSimcard()");
			return resultado;
		}// fin validaLargoSerieTerminal*/
		
/*		public ResultadoValidacionLogisticaDTO existeSerieKit(ParametrosValidacionLogisticaDTO entrada)
		throws ProductException{
			ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
			logger.debug("Inicio:existeSerieSimcard()");
			resultado = simcardDAO.existeSerieSimcard(entrada); 
			if (resultado.getResultadoBase() == 1){
				resultado.setResultado(true);
			}
			else if (resultado.getResultadoBase() == 0){
				resultado.setResultado(false);
			}
			logger.debug("Fin:existeSerieSimcard()");
			return resultado;
		}//fin  existeSerieSimcard*/
		
		public KitDTO getKit(KitDTO entrada)
		throws GeneralException{
			KitDTO resultado = new KitDTO();
			logger.debug("Inicio:getKit()");
			resultado = kitDAO.getKit(entrada); 
			logger.debug("Fin:getKit()");
			return resultado;
		}//fin getKit
		
		public PrecioCargoDTO[] getPrecioCargoKit_PrecioLista(ParametrosCargoKitDTO entrada) 
		throws GeneralException{
			PrecioCargoDTO[] resultado = null;
			logger.debug("Inicio:getPrecioCargoKit_PrecioLista()");
			resultado = kitDAO.getPrecioCargoKit_PrecioLista(entrada); 
			logger.debug("Fin:getPrecioCargoKit_PrecioLista()");
			return resultado;
		}//fin getPrecioCargoKit_PrecioLista

		public PrecioCargoDTO[] getPrecioCargoKit_NoPrecioLista(ParametrosCargoKitDTO entrada) 
		throws ProductException{
			PrecioCargoDTO[] resultado = null;
			logger.debug("Inicio:getPrecioCargoKit_NoPrecioLista()");
			resultado = kitDAO.getPrecioCargoKit_NoPrecioLista(entrada); 
			logger.debug("Fin:getPrecioCargoKit_NoPrecioLista()");
			return resultado;
		}//fin getPrecioCargoKit_NoPrecioLista
		
		/**
		 * Busca Descuentos asociados al Cargo del Kit
		 * @param entrada
		 * @return resultado
		 * @throws ProductException
		 */
		public DescuentoDTO[] getDescuentoCargo(ParametrosDescuentoDTO entrada) throws ProductException{
			DescuentoDTO[] resultado = null;
			logger.debug("Inicio:getDescuentoCargo()");
			if (entrada.getClaseDescuento().equals(entrada.getClaseDescuentoArticulo()))
				resultado = kitDAO.getDescuentoCargoArticulo(entrada);
			else
				resultado = kitDAO.getDescuentoCargoConcepto(entrada);
			logger.debug("Fin:getDescuentoCargo()");
			return resultado;
		}//fin getDescuentoCargo
		
		/**
		 * Obtiene Codigo Concepto Facturable del descuento manual 
		 * @param entrada
		 * @return resultado
		 * @throws ProductException
		 */
		
		public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada) throws ProductException{
			logger.debug("Inicio:getCodigoDescuentoManual()");
			DescuentoDTO resultado = kitDAO.getCodigoDescuentoManual(entrada);
			logger.debug("Fin:getCodigoDescuentoManual()");
			return resultado;
		}//fin getCodigoDescuentoManual

		/**
		 * Verifica que numero celular este bien reservado 
		 * @param entrada
		 * @return resultado
		 * @throws ProductException
		 */
		public ResultadoValidacionLogisticaDTO numeroReservadoOK(ParametrosValidacionLogisticaDTO entrada)
		throws ProductException{
			ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
			logger.debug("Inicio:numeroReservadoOK()");
			resultado = kitDAO.getNumeroReservadoOK(entrada); 
			if (resultado.getResultadoBase() == 1){
				resultado.setResultado(true);
			}
			else if (resultado.getResultadoBase() == 0){
				resultado.setResultado(false);
			}
			logger.debug("Fin:numeroReservadoOK()");
			return resultado;
		}//fin  numeroReservadoOK

/*		/**
		 * Obtiene el indicador de telefono para una simcard
		 * @param entrada
		 * @return resultado
		 * @throws ProductException
		 *
		public KitDTO getIndicadorTelefono(KitDTO entrada)
		throws ProductException{
			KitDTO resultado = new KitDTO();
			logger.debug("Inicio:getIndicadorTelefono()");
			resultado = kitDAO.geti(entrada); 
			logger.debug("Fin:getIndicadorTelefono()");
			return resultado;
		}//fin getIndicadorTelefono*/
		
		/**
		 * Valida autenticación de la serie 
		 * @param entrada
		 * @return resultado
		 * @throws ProductException
		 */
		public ProcesoDTO validaAutenticacionSerie(KitDTO entrada) 
		throws ProductException{
			ProcesoDTO resultado = new ProcesoDTO();
			logger.debug("Inicio:validaAutenticacionSerie()");
			resultado = kitDAO.validaAutenticacionSerie(entrada); 
			logger.debug("Fin:validaAutenticacionSerie()");
			return resultado;
		}
		
	/*	/**
		 * Obtiene imsi de la simcard, utilizado para isertar movimiento en centrales 
		 * @param entrada
		 * @return resultado
		 * @throws ProductException
		 *
		public SimcardDTO getImsiSimcard(SimcardDTO simcard) 
		throws ProductException{
			SimcardDTO resultado = new SimcardDTO();
			logger.debug("Inicio:getImsiSimcard()");
			resultado = kitDAO.getImsiSimcard(simcard); 
			logger.debug("Fin:getImsiSimcard()");
			return resultado;
		}*/
		
		/**
		 * Actualiza stock simcard
		 * @param simcard
		 * @return resultado
		 * @throws ProductException
		 */
		public KitDTO actualizaStockKit(KitDTO kit) 
		throws ProductException{
			KitDTO resultado = new KitDTO();
			logger.debug("Inicio:actualizaStockKit()");
			resultado = kitDAO.actualizaStockKit(kit); 
			logger.debug("Fin:actualizaStockKit()");
			return resultado;
		}//fin actualizaStockKit

}//fin Class Simcard