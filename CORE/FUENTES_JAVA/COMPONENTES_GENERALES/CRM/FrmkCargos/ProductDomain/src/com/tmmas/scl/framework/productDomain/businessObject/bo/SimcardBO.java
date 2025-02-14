/** Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 *Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 19/07/2007            Raúl Lozano      					Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosDescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosValidacionLogisticaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ProcesoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ResultadoValidacionLogisticaDTO;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.SimcardBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.dao.SimcardDAO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.TerminalDAO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.SimcardDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCargoSimcardDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCargoSimcardRestitucionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.SimcardDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;







public class SimcardBO implements SimcardBOIT{
		
	
	private final Logger logger = Logger.getLogger(TerminalDAO.class);
	private SimcardDAOIT simcardDAO=new SimcardDAO();
	//private SimcardDAO simcardDAO  = new SimcardDAO();
		
		Global global = Global.getInstance();
		
		public ResultadoValidacionLogisticaDTO validaLargoSerieSimcard(ParametrosValidacionLogisticaDTO entrada)
		throws ProductException{
			ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
			logger.debug("Inicio:validaLargoSerieSimcard()");
			resultado = simcardDAO.getLargoSerieSimcard(entrada);
			if (resultado.getLargoSerie() == entrada.getNumeroSerie().length())
				resultado.setResultado(true);
			else
				resultado.setResultado(false);
			logger.debug("Fin:validaLargoSerieSimcard()");
			return resultado;
		}// fin validaLargoSerieTerminal
		
		public ResultadoValidacionLogisticaDTO existeSerieSimcard(ParametrosValidacionLogisticaDTO entrada)
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
		}//fin  existeSerieSimcard
		
		public SimcardDTO getSimcard(SimcardDTO entrada)
		throws ProductException{
			SimcardDTO resultado = new SimcardDTO();
			logger.debug("Inicio:getSimcard()");
			resultado = simcardDAO.getSimcard(entrada); 
			logger.debug("Fin:getSimcard()");
			return resultado;
		}//fin getSimcard
		
		public PrecioCargoDTO[] getPrecioCargoSimcard_PrecioLista(ParametrosCargoSimcardDTO entrada) 
		throws ProductException{
			PrecioCargoDTO[] resultado = null;
			logger.debug("Inicio:getPrecioCargoSimcard_PrecioLista()");
			resultado = simcardDAO.getPrecioCargoSimcard_PrecioLista(entrada); 
			logger.debug("Fin:getPrecioCargoSimcard_PrecioLista()");
			return resultado;
		}//fin getPrecioCargoSimcard_PrecioLista

		public PrecioCargoDTO[] getPrecioCargoSimcard_NoPrecioLista(ParametrosCargoSimcardDTO entrada) 
		throws ProductException{
			PrecioCargoDTO[] resultado = null;
			logger.debug("Inicio:getPrecioCargoSimcard_NoPrecioLista()");
			resultado = simcardDAO.getPrecioCargoSimcard_NoPrecioLista(entrada); 
			logger.debug("Fin:getPrecioCargoSimcard_NoPrecioLista()");
			return resultado;
		}//fin getPrecioCargoSimcard_NoPrecioLista
		
		/**
		 * Busca Descuentos asociados al Cargo de la simcard
		 * @param entrada
		 * @return resultado
		 * @throws ProductException
		 */
		public DescuentoDTO[] getDescuentoCargo(ParametrosDescuentoDTO entrada) throws ProductException{
			DescuentoDTO[] resultado = null;
			logger.debug("Inicio:getDescuentoCargo()");
			if (entrada.getClaseDescuento().equals(entrada.getClaseDescuentoArticulo()))
				resultado = simcardDAO.getDescuentoCargoArticulo(entrada);
			else
				resultado = simcardDAO.getDescuentoCargoConcepto(entrada);
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
			DescuentoDTO resultado = simcardDAO.getCodigoDescuentoManual(entrada);
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
			resultado = simcardDAO.getNumeroReservadoOK(entrada); 
			if (resultado.getResultadoBase() == 1){
				resultado.setResultado(true);
			}
			else if (resultado.getResultadoBase() == 0){
				resultado.setResultado(false);
			}
			logger.debug("Fin:numeroReservadoOK()");
			return resultado;
		}//fin  numeroReservadoOK

		/**
		 * Obtiene el indicador de telefono para una simcard
		 * @param entrada
		 * @return resultado
		 * @throws ProductException
		 */
		public SimcardDTO getIndicadorTelefono(SimcardDTO entrada)
		throws ProductException{
			SimcardDTO resultado = new SimcardDTO();
			logger.debug("Inicio:getIndicadorTelefono()");
			resultado = simcardDAO.getIndicadorTelefono(entrada); 
			logger.debug("Fin:getIndicadorTelefono()");
			return resultado;
		}//fin getIndicadorTelefono
		
		/**
		 * Valida autenticación de la serie 
		 * @param entrada
		 * @return resultado
		 * @throws ProductException
		 */
		public ProcesoDTO validaAutenticacionSerie(SimcardDTO entrada) 
		throws ProductException{
			ProcesoDTO resultado = new ProcesoDTO();
			logger.debug("Inicio:validaAutenticacionSerie()");
			resultado = simcardDAO.validaAutenticacionSerie(entrada); 
			logger.debug("Fin:validaAutenticacionSerie()");
			return resultado;
		}
		
		/**
		 * Obtiene imsi de la simcard, utilizado para isertar movimiento en centrales 
		 * @param entrada
		 * @return resultado
		 * @throws ProductException
		 */
		public SimcardDTO getImsiSimcard(SimcardDTO simcard) 
		throws ProductException{
			SimcardDTO resultado = new SimcardDTO();
			logger.debug("Inicio:getImsiSimcard()");
			resultado = simcardDAO.getImsiSimcard(simcard); 
			logger.debug("Fin:getImsiSimcard()");
			return resultado;
		}
		
		/**
		 * Actualiza stock simcard
		 * @param simcard
		 * @return resultado
		 * @throws ProductException
		 */
		public SimcardDTO actualizaStockSimcard(SimcardDTO simcard) 
		throws ProductException{
			SimcardDTO resultado = new SimcardDTO();
			logger.debug("Inicio:actualizaStockSimcard()");
			resultado = simcardDAO.actualizaStockSimcard(simcard); 
			logger.debug("Fin:actualizaStockSimcard()");
			return resultado;
		}//fin actualizaStockSimcard

		
		/**
		 * permite obtener el precio lista de una simcard para restitucion 
		 * CSR11003
		 * @param entrada
		 * @return
		 * @throws ProductException
		 */
		public PrecioCargoDTO[] getPrecioCargoSimcard_PrecioLista_Rest(ParametrosCargoSimcardRestitucionDTO entrada) 
		throws ProductException{
			
			PrecioCargoDTO[] resultado = null;
			logger.debug("Inicio:getPrecioCargoSimcard_PrecioLista_Rest()");
			
			resultado = simcardDAO.getPrecioCargoSimcard_PrecioLista_Rest(entrada); 
			
			logger.debug("Fin:getPrecioCargoSimcard_PrecioLista_Rest()");
			return resultado;
		}
		

		/**
		 * permite obtener el precio lista de una simcard para restitucion 
		 * CSR11003
		 * @param entrada
		 * @return
		 * @throws ProductException
		 */
		public PrecioCargoDTO[] getPrecioCargoSimcard_NoPrecioLista_Rest(ParametrosCargoSimcardRestitucionDTO entrada) 
		throws ProductException{
			
			PrecioCargoDTO[] resultado = null;
			logger.debug("Inicio:getPrecioCargoSimcard_NoPrecioLista_Rest()");
			
			resultado = simcardDAO.getPrecioCargoSimcard_NoPrecioLista_Rest(entrada); 
			
			logger.debug("Fin:getPrecioCargoSimcard_NoPrecioLista_Rest()");
			return resultado;
		}
}//fin Class Simcard

