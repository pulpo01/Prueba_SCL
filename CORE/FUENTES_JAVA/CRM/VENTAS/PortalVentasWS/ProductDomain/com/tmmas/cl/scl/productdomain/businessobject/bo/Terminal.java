package com.tmmas.cl.scl.productdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.DescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosDescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosValidacionLogisticaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PrecioCargoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionLogisticaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.productdomain.businessobject.dao.TerminalDAO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ArticuloDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ParametrosCargoTerminalDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SimcardDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.TerminalDTO;
import com.tmmas.cl.scl.productdomain.businessobject.helper.Global;

public class Terminal extends Articulo{
		private static String IndProcedenciaInterna = "I";
	    private static String IndProcedenciaExterna = "E";

	    private TerminalDAO terminalDAO  = new TerminalDAO();
		private ParametrosGenerales parametrosGeneralesBO = new ParametrosGenerales(); //*-- MAYORISTA
		private Articulo articulosBO = new Articulo(); //*-- MAYORISTA
		
		private static Category cat = Category.getInstance(Terminal.class);
		Global global = Global.getInstance();

		public ResultadoValidacionLogisticaDTO validaLargoSerieTerminal(ParametrosValidacionLogisticaDTO entrada)
		throws ProductDomainException{
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
		throws ProductDomainException{
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
		
		public TerminalDTO getTerminal(TerminalDTO entrada)
		throws ProductDomainException{
			cat.debug("Inicio:getTerminal()");
			entrada.setProcedenciaExterna(IndProcedenciaExterna);
			entrada.setProcedenciaInterna(IndProcedenciaInterna);
			TerminalDTO resultado = terminalDAO.getTerminal(entrada); 
			cat.debug("Fin:getTerminal()");
			return resultado;
		}//fin getTerminal

		public PrecioCargoDTO[] getPrecioCargoTerminal_PrecioLista(ParametrosCargoTerminalDTO entrada) 
		throws ProductDomainException{
			PrecioCargoDTO[] resultado = null;
			cat.debug("Inicio:getPrecioCargoTerminal_PrecioLista()");
			resultado = terminalDAO.getPrecioCargoTerminal_PrecioLista(entrada); 
			cat.debug("Fin:getPrecioCargoTerminal_PrecioLista()");
			return resultado;
		}//fin getPrecioCargoTerminal_PrecioLista

		public PrecioCargoDTO[] getPrecioCargoTerminal_NoPrecioLista(ParametrosCargoTerminalDTO entrada) 
		throws ProductDomainException{
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
		 * @throws ProductDomainException
		 */
		public DescuentoDTO[] getDescuentoCargo(ParametrosDescuentoDTO entrada) throws ProductDomainException{
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
		 * @throws ProductDomainException
		 */
		
		public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada) throws ProductDomainException{
			cat.debug("Inicio:getCodigoDescuentoManual()");
			DescuentoDTO resultado = terminalDAO.getCodigoDescuentoManual(entrada);
			cat.debug("Fin:getCodigoDescuentoManual()");
			return resultado;
		}//fin getCodigoDescuentoManual


		public ResultadoValidacionLogisticaDTO  verificaRechazoSerie (ParametrosValidacionLogisticaDTO entrada)
		throws ProductDomainException{
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
		 * @throws ProductDomainException
		 */
		public TerminalDTO actualizaStockTerminal(TerminalDTO terminal) 
		throws ProductDomainException{
			TerminalDTO resultado = new TerminalDTO();
			cat.debug("Inicio:actualizaStockTerminal()");
			resultado = terminalDAO.actualizaStockTerminal(terminal); 
			cat.debug("Fin:actualizaStockTerminal()");
			return resultado;
		}//fin actualizaStockTerminal
		
		/**
		 * Obtiene estado anterior de la serie
		 * @param terminal
		 * @return resultado
		 * @throws ProductDomainException
		 */
		public TerminalDTO getEstadoAnterior(TerminalDTO terminal) 
		throws ProductDomainException{
			TerminalDTO resultado = new TerminalDTO();
			cat.debug("Inicio:getEstadoAnterior()");
			resultado = terminalDAO.getEstadoAnterior(terminal); 
			cat.debug("Fin:getEstadoAnterior()");
			return resultado;
		}//fin getEstadoAnterior

		/** Servicios Activaciones WEB - Colombia
		 * MAYORISTAS
		 * Obtine precio cargo mayorista Terminal
		 * @param ParametrosCargoTerminalDTO (entrada)
		 * @return PrecioCargoDTO (resultado)
		 * @throws ProductDomainException
	     * wjrc - Agosto 2007 */ 
		public PrecioCargoDTO[] getPrecioCargoTerminalMayorista(ParametrosCargoTerminalDTO entrada) 
		throws ProductDomainException{
			PrecioCargoDTO[] resultado = null;
			cat.debug("Inicio:getPrecioCargoTerminalMayorista()");
			entrada.setTipoStock(global.getValor("tipo.stock.mayorista"));
			resultado = terminalDAO.getPrecioCargoTerminal_PrecioLista(entrada); 
			cat.debug("Fin:getPrecioCargoTerminalMayorista()");
			return resultado;
		}//fin getPrecioCargoTerminalMayorista

		/**
		 * @author mwn40031
		 * @param numSerie
		 * @return
		 * @throws ProductDomainException
		 */
		public Boolean validaSerieLN(String numSerie) throws ProductDomainException {
			cat.info("Inicio");
			Boolean r =  terminalDAO.validaSerieLN(numSerie);
			cat.info("Fin");
			return r;
		}
		
		/** Servicios Activaciones WEB - Colombia
		 * MAYORISTAS
		 * Define el tipo de stock del terminal
		 * @param TerminalDTO (entrada)
		 * @return String (resultado)
		 * @throws ProductDomainException
	     * wjrc - Agosto 2007 */  	
		public String defineStockTerminal(TerminalDTO terminal) 
			throws ProductDomainException 
		{
			cat.debug("defineStockSimcard():inicio");
			
			String tipoStock = "";
			
			//-- aplica mayorista?
			String sAplicaMayorista = global.getValor("valor.falso");		
			ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
			parametrosGeneralesDTO.setCodigoproducto(global.getValor("valor.codigo.producto").trim());
			parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA").trim());
			parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.aplica.mayorista").trim());			
			parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
			sAplicaMayorista = parametrosGeneralesDTO.getValorparametro();
			cat.debug("sAplicaMayorista: " + sAplicaMayorista);			
			
			 //-- precio lista?
			String sPrecioLista = global.getValor("valor.falso");
			parametrosGeneralesDTO.setCodigoproducto(global.getValor("valor.codigo.producto").trim());
			parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA").trim());
			parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.preciolista").trim());
			parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
			sPrecioLista = parametrosGeneralesDTO.getValorparametro();
			
			if(sPrecioLista.equals(global.getValor("valor.falso").trim()))
				if (terminal.getModalidadVenta().equals(global.getValor("modalidad.venta.credito").trim()))
					if (terminal.getCanalVendedor().equals(global.getValor("codigo.canal.indirecto").trim()))
						if(terminal.getIndicadorValorar().equals(global.getValor("indicador.valorar.no").trim()))
							if (sAplicaMayorista.equals(global.getValor("valor.verdadero").trim()))
							{								
								//*-- venta mayorista?
								String sVentaMayorista = global.getValor("valor.falso").trim();
								ArticuloDTO articuloDTO = new ArticuloDTO();
								articuloDTO.setNumeroSerie(terminal.getNumeroSerie());
								articuloDTO = articulosBO.getVentaMayorista(articuloDTO);								
								if (articuloDTO.getDescripcion() != null)
									sVentaMayorista = global.getValor("valor.verdadero").trim();
								cat.debug("sVentaMayorista: " + sVentaMayorista);								
								//*-- serie numerada?
								String sSerieNumerada = global.getValor("valor.falso").trim();
								if (terminal.getNumeroCelular() != null && terminal.getEstado().equals(global.getValor("estado.serie.ok").trim()))
									sSerieNumerada = global.getValor("valor.verdadero").trim();
								cat.debug("sSerieNumerada: " + sSerieNumerada);
								cat.debug("sPrecioLista: " + sSerieNumerada);
								
								//-- stock mayorista?		
								sVentaMayorista = "TRUE";
								if (sVentaMayorista.equals(global.getValor("valor.verdadero").trim()))
								{
										tipoStock = global.getValor("tipo.stock.mayorista").trim();
								}
			}	
			cat.debug("defineStockSimcard():fin");
			return tipoStock;
		}//fin defineStockSimcard
		
//		INICIO INC 187717 26/09/2012
		/**
		 * Obtiene numero de la movimiento, utilizado para desreservar la serie 
		 * @param entrada
		 * @return resultado
		 * @throws ProductDomainException
		 */
		public TerminalDTO getNumMovimmiento(TerminalDTO simcard) 
			throws ProductDomainException
		{
			TerminalDTO resultado = new TerminalDTO();
			cat.debug("Inicio:getNumMovimmiento()");
			resultado = terminalDAO.getNumMovimmiento(simcard); 
			cat.debug("Fin:getNumMovimmiento()");
			return resultado;
		}
		//FIN INC 187717 26/09/2012		
}//fin Terminal
