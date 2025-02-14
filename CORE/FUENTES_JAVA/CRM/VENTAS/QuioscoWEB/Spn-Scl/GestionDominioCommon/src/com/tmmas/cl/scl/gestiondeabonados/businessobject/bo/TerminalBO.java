package com.tmmas.cl.scl.gestiondeabonados.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dao.TerminalDAO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.DescuentoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ImeiWSDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ParametrosCargoTerminalDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ParametrosDescuentoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ParametrosValidacionLogisticaDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.PrecioCargoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ResultadoValidacionLogisticaDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.TerminalSNPNDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.helper.Global;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ResultadoValidacionVentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;

public class TerminalBO extends ArticuloBO{
		private static String IndProcedenciaInterna = "I";
	    private static String IndProcedenciaExterna = "E";
		private TerminalDAO terminalDAO  = new TerminalDAO();
		private static Category cat = Category.getInstance(TerminalBO.class);
		Global global = Global.getInstance();

		public ResultadoValidacionLogisticaDTO validaLargoSerieTerminal(ParametrosValidacionLogisticaDTO entrada)
		throws GeneralException{
			ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
			cat.debug("Inicio:validaLargoSerieTerminal()");
			resultado = terminalDAO.getLargoSerieTerminal(entrada);
			if (resultado.getLargoSerie() == entrada.getNumeroSerieTerminal().length())
				resultado.setResultado(true);
			else
				resultado.setResultado(false);
			cat.debug("Fin:validaLargoSerieTerminal()");
			return resultado;
		}// fin validaLargoSerieTerminal
		
		public ResultadoValidacionLogisticaDTO  existeSerieTerminal(ParametrosValidacionLogisticaDTO entrada)
		throws GeneralException{
			cat.debug("Inicio:existeSerieTerminal()");
			ResultadoValidacionLogisticaDTO resultado = terminalDAO.existeSerieTerminal(entrada); 
			if (resultado.getResultadoBase() == 1){
				resultado.setResultado(true);
			}
			else if (resultado.getResultadoBase() == 0){
				resultado.setResultado(false);
			}
			cat.debug("Fin:existeSerieTerminal()");
			return resultado;
		}//fin existeSerieTerminal
		
		public TerminalSNPNDTO getTerminal(TerminalSNPNDTO entrada)
		throws GeneralException{
			cat.debug("Inicio:getTerminal()");
			entrada.setProcedenciaExterna(IndProcedenciaExterna);
			entrada.setProcedenciaInterna(IndProcedenciaInterna);
			TerminalSNPNDTO resultado = resultado = terminalDAO.getTerminal(entrada); 
			cat.debug("Fin:getTerminal()");
			return resultado;
		}//fin getTerminal

		public PrecioCargoDTO[] getPrecioCargoTerminal_PrecioLista(ParametrosCargoTerminalDTO entrada) 
		throws GeneralException{
			PrecioCargoDTO[] resultado = null;
			cat.debug("Inicio:getPrecioCargoTerminal_PrecioLista()");
			resultado = terminalDAO.getPrecioCargoTerminal_PrecioLista(entrada); 
			cat.debug("Fin:getPrecioCargoTerminal_PrecioLista()");
			return resultado;
		}//fin getPrecioCargoTerminal_PrecioLista

		public PrecioCargoDTO[] getPrecioCargoTerminal_NoPrecioLista(ParametrosCargoTerminalDTO entrada) 
		throws GeneralException{
			PrecioCargoDTO[] resultado = null;
			cat.debug("Inicio:getPrecioCargoTerminal_NoPrecioLista()");
			resultado = terminalDAO.getPrecioCargoTerminal_NoPrecioLista(entrada); 
			cat.debug("Fin:getPrecioCargoTerminal_NoPrecioLista()");
			return resultado;
		}//fin getPrecioCargoTerminal_NoPrecioLista	
		
		/**
		 * Busca Descuentos asociados al cargo del Terminal
		 * @param entrada
		 * @return resultado
		 * @throws GeneralException
		 */
		public DescuentoDTO[] getDescuentoCargo(ParametrosDescuentoDTO entrada) throws GeneralException{
			DescuentoDTO[] resultado = null;
			cat.debug("Inicio:getDescuentoCargo()");
			if (entrada.getClaseDescuento().equals(entrada.getClaseDescuentoArticulo()))
				resultado = terminalDAO.getDescuentoCargoArticulo(entrada);
			else
				resultado = terminalDAO.getDescuentoCargoConcepto(entrada);
			cat.debug("Fin:getDescuentoCargo()");
			return resultado;
		}//fin getDescuentoCargo
		
		/**
		 * Obtiene Codigo Concepto Facturable del descuento manual 
		 * @param entrada
		 * @return resultado
		 * @throws GeneralException
		 */
		
		public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada) throws GeneralException{
			cat.debug("Inicio:getCodigoDescuentoManual()");
			DescuentoDTO resultado = terminalDAO.getCodigoDescuentoManual(entrada);
			cat.debug("Fin:getCodigoDescuentoManual()");
			return resultado;
		}//fin getCodigoDescuentoManual


		public ResultadoValidacionLogisticaDTO  verificaRechazoSerie (ParametrosValidacionLogisticaDTO entrada)
		throws GeneralException{
			ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
			cat.debug("Inicio:verificaRechazoSerie()");
			resultado = terminalDAO.verificaRechazoSerie(entrada); 
			resultado.setResultado(resultado.getResultadoBase()== 1?true:false);
			cat.debug("Fin:verificaRechazoSerie()");
			return resultado;
		}//fin verificaRechazoSerie

		/**
		 * Actualiza stock terminal
		 * @param terminal
		 * @return resultado
		 * @throws GeneralException
		 */
		public TerminalSNPNDTO actualizaStockTerminal(TerminalSNPNDTO terminal) 
		throws GeneralException{
			TerminalSNPNDTO resultado = new TerminalSNPNDTO();
			cat.debug("Inicio:actualizaStockTerminal()");
			resultado = terminalDAO.actualizaStockTerminal(terminal); 
			cat.debug("Fin:actualizaStockTerminal()");
			return resultado;
		}//fin actualizaStockTerminal
		
		/**
		 * Obtiene estado anterior de la serie
		 * @param terminal
		 * @return resultado
		 * @throws GeneralException
		 */
		public TerminalSNPNDTO getEstadoAnterior(TerminalSNPNDTO terminal) 
		throws GeneralException{
			TerminalSNPNDTO resultado = new TerminalSNPNDTO();
			cat.debug("Inicio:getEstadoAnterior()");
			resultado = terminalDAO.getEstadoAnterior(terminal); 
			cat.debug("Fin:getEstadoAnterior()");
			return resultado;
		}//fin getEstadoAnterior
		
		/**
		 * Valida formato del numero serie terminal
		 * @author Héctor Hermosilla
		 * @param TerminalSNPNDTO
		 * @return resultado
		 * @throws GeneralException
		 */
		
		public ResultadoValidacionLogisticaDTO validaFormatoTerminalGSM(TerminalSNPNDTO TerminalSNPNDTO)
		throws GeneralException{
			cat.debug("Inicio:validaFormatoTerminalGSM()");
			ResultadoValidacionLogisticaDTO resultado =  terminalDAO.validaFormatoTerminalGSM(TerminalSNPNDTO);
			cat.debug("Fin:validaFormatoTerminalGSM()");
			return resultado;
		}// fin validaFormatoTerminalGSM
		
		/**
		 * Valida las veces que puede estar asociada el terminal a uno o mas abonados
		 * @author Héctor Hermosilla
		 * @param TerminalSNPNDTO
		 * @return resultado
		 * @throws GeneralException
		 */
		public ResultadoValidacionVentaDTO validaRepeticionTerminal(TerminalSNPNDTO TerminalSNPNDTO)
		throws GeneralException{
			cat.debug("Inicio:validaRepeticionTerminal()");
			ResultadoValidacionVentaDTO resultado =  terminalDAO.validaRepeticionTerminal(TerminalSNPNDTO);
			cat.debug("Fin:validaRepeticionTerminal()");
			return resultado;
		}// fin validaRepeticionTerminal
		
		
		/**
		 * Valida las veces que puede estar asociada el terminal a uno o mas abonados
		 * @author Héctor Hermosilla
		 * @param TerminalSNPNDTO
		 * @return resultado
		 * @throws GeneralException
		 */
		public  RetornoDTO  validaImeiGSM(ImeiWSDTO imeiWS)
		throws GeneralException{
			cat.debug("Inicio:validaImeiGSM()");
			RetornoDTO resultado =  terminalDAO.validaImeiGSM(imeiWS);
			cat.debug("Fin:validaImeiGSM()");
			return resultado;
		}// fin validaRepeticionTerminal	
		
		
		public String validaRangoTerminal(TerminalSNPNDTO TerminalSNPNDTO)
		throws GeneralException{
			cat.debug("Inicio:validaImeiGSM()");
			String resultado =  terminalDAO.validaRangoTerminal(TerminalSNPNDTO);
			cat.debug("Fin:validaImeiGSM()");
			return resultado;
		}// fin validaRepeticionTerminal	
		
		
		public String getSerieHexa(TerminalSNPNDTO TerminalSNPNDTO) 
		throws GeneralException{	
			cat.debug("Inicio:validaImeiGSM()");
			String resultado =  terminalDAO.getSerieHexa(TerminalSNPNDTO);
			cat.debug("Fin:validaImeiGSM()");
			return resultado;
		}
		
		public void setNumeracionTerminalPortada(TerminalSNPNDTO terminal) 
		throws GeneralException{
			cat.debug("Inicio:setNumeracionSimPortada()");
			terminalDAO.setNumeracionTerminalPortada(terminal); 
			cat.debug("Fin:setNumeracionSimPortada()");
		}//fin actualizaStockSimcard		

}//fin Terminal
