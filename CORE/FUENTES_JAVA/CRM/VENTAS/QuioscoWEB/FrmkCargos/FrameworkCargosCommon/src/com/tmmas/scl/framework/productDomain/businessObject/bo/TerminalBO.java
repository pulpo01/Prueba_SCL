package com.tmmas.scl.framework.productDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosDescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosValidacionLogisticaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ResultadoValidacionLogisticaDTO;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.TerminalBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.dao.TerminalDAO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.TerminalDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCargoTerminalDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.TerminalDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;



public class TerminalBO implements TerminalBOIT{
		private static String IndProcedenciaInterna = "I";
	    private static String IndProcedenciaExterna = "E";
		private TerminalDAOIT terminalDAO  = new TerminalDAO();
		private final Logger logger = Logger.getLogger(TerminalDAO.class);
		Global global = Global.getInstance();

		/*public ResultadoValidacionLogisticaDTO validaLargoSerieTerminal(ParametrosValidacionLogisticaDTO entrada)
		throws ProductException{
			ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
			logger.debug("Inicio:validaLargoSerieTerminal()");
			resultado = terminalDAO.getLargoSerieTerminal(entrada);
			if (resultado.getLargoSerie() == entrada.getNumeroSerieTerminal().length())
				resultado.setResultado(true);
			else
				resultado.setResultado(false);
			logger.debug("Fin:validaLargoSerieTerminal()");
			return resultado;
		}// fin validaLargoSerieTerminal*/
		
		/*public ResultadoValidacionLogisticaDTO  existeSerieTerminal(ParametrosValidacionLogisticaDTO entrada)
		throws ProductException{
			ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
			logger.debug("Inicio:existeSerieTerminal()");
			resultado = terminalDAO.existeSerieTerminal(entrada); 
			if (resultado.getResultadoBase() == 1){
				resultado.setResultado(true);
			}
			else if (resultado.getResultadoBase() == 0){
				resultado.setResultado(false);
			}
			logger.debug("Fin:existeSerieTerminal()");
			return resultado;
		}//fin existeSerieTerminal*/
		
		public TerminalDTO getTerminal(TerminalDTO entrada)
		throws ProductException{
			TerminalDTO resultado = new TerminalDTO();
			logger.debug("Inicio:getTerminal()");
			entrada.setProcedenciaExterna(IndProcedenciaExterna);
			entrada.setProcedenciaInterna(IndProcedenciaInterna);
			resultado = terminalDAO.getTerminal(entrada); 
			logger.debug("Fin:getTerminal()");
			return resultado;
		}//fin getTerminal*/

		public PrecioCargoDTO[] getPrecioCargoTerminal_PrecioLista(ParametrosCargoTerminalDTO entrada) 
		throws GeneralException{
			PrecioCargoDTO[] resultado = null;
			logger.debug("Inicio:getPrecioCargoTerminal_PrecioLista()");
			resultado = terminalDAO.getPrecioCargoTerminal_PrecioLista(entrada); 
			logger.debug("Fin:getPrecioCargoTerminal_PrecioLista()");
			return resultado;
		}//fin getPrecioCargoTerminal_PrecioLista*/

		public PrecioCargoDTO[] getPrecioCargoTerminal_NoPrecioLista(ParametrosCargoTerminalDTO entrada) 
		throws ProductException{
			PrecioCargoDTO[] resultado = null;
			logger.debug("Inicio:getPrecioCargoTerminal_NoPrecioLista()");
			resultado = terminalDAO.getPrecioCargoTerminal_NoPrecioLista(entrada); 
			logger.debug("Fin:getPrecioCargoTerminal_NoPrecioLista()");
			return resultado;
		}//fin getPrecioCargoTerminal_NoPrecioLista	*/
		
		/**
		 * Busca Descuentos asociados al cargo del Terminal
		 * @param entrada
		 * @return resultado
		 * @throws ProductException
		 */
		public DescuentoDTO[] getDescuentoCargo(ParametrosDescuentoDTO entrada) throws ProductException {  
			DescuentoDTO[] resultado = null;
			logger.debug("Inicio:getDescuentoCargo()");

			logger.debug("TerminalBO:parametrosDescto.getNombreUsuario():" +  entrada.getNombreUsuario() ); // RRG
			logger.debug("TerminalBO:parametrosDescto.getCodigoOperacion():" + entrada.getCodigoOperacion() ) ; // RRG

			if (entrada.getClaseDescuento().equals(entrada.getClaseDescuentoArticulo()))  
				resultado = terminalDAO.getDescuentoCargoArticulo(entrada);
			else
				resultado = terminalDAO.getDescuentoCargoConcepto(entrada);
			logger.debug("Fin:getDescuentoCargo()");
			return resultado;
		}//fin getDescuentoCargo*/
		
		/**
		 * Obtiene Codigo Concepto Facturable del descuento manual 
		 * @param entrada
		 * @return resultado
		 * @throws ProductException
		 */
		
		public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada) throws ProductException{
			logger.debug("Inicio:getCodigoDescuentoManual()");
			DescuentoDTO resultado = terminalDAO.getCodigoDescuentoManual(entrada);
			logger.debug("Fin:getCodigoDescuentoManual()");
			return resultado;
		}//fin getCodigoDescuentoManual*/


		public ResultadoValidacionLogisticaDTO  verificaRechazoSerie (ParametrosValidacionLogisticaDTO entrada)
		throws ProductException{
			ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
			logger.debug("Inicio:verificaRechazoSerie()");
			resultado = terminalDAO.verificaRechazoSerie(entrada); 
			resultado.setResultado(resultado.getResultadoBase()== 1?true:false);
			logger.debug("Fin:verificaRechazoSerie()");
			return resultado;
		}//fin verificaRechazoSerie

		/**
		 * Actualiza stock terminal
		 * @param terminal
		 * @return resultado
		 * @throws ProductException
		 */
		/*public TerminalDTO actualizaStockTerminal(TerminalDTO terminal) 
		throws ProductException{
			TerminalDTO resultado = new TerminalDTO();
			logger.debug("Inicio:actualizaStockTerminal()");
			resultado = terminalDAO.actualizaStockTerminal(terminal); 
			logger.debug("Fin:actualizaStockTerminal()");
			return resultado;
		}//fin actualizaStockTerminal*/
		
		/**
		 * Obtiene estado anterior de la serie
		 * @param terminal
		 * @return resultado
		 * @throws ProductException
		 */
		/*public TerminalDTO getEstadoAnterior(TerminalDTO terminal) 
		throws ProductException{
			TerminalDTO resultado = new TerminalDTO();
			logger.debug("Inicio:getEstadoAnterior()");
			resultado = terminalDAO.getEstadoAnterior(terminal); 
			logger.debug("Fin:getEstadoAnterior()");
			return resultado;
		}//fin getEstadoAnterior*/
		
		
		public PrecioCargoDTO[] getPrecioCargoTerminal_NoPrecioLista_PV(ParametrosCargoTerminalDTO entrada) 
		throws ProductException{
			PrecioCargoDTO[] resultado = null;
			logger.debug("Inicio:getPrecioCargoTerminal_NoPrecioLista_PV()");
			resultado = terminalDAO.getPrecioCargoTerminal_NoPrecioLista_PV(entrada); 
			logger.debug("Fin:getPrecioCargoTerminal_NoPrecioLista_PV()");
			return resultado;
		}//fin getPrecioCargoTerminal_NoPrecioLista	*/
}//fin Terminal
