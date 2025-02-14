/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 23/02/2007     Roberto P&eacute;rez Varas      					Versión Inicial
 */
package com.tmmas.cl.scl.productdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.DescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosDescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosValidacionLogisticaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PrecioCargoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ProcesoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionLogisticaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.productdomain.businessobject.dao.SimcardDAO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ArticuloDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.EquipoKitDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ParametrosCargoSimcardDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SerieDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SimcardDTO;
import com.tmmas.cl.scl.productdomain.businessobject.helper.Global;

public class Simcard extends Articulo{
		private SimcardDAO simcardDAO  = new SimcardDAO();
		private ParametrosGenerales parametrosGeneralesBO = new ParametrosGenerales(); //*-- MAYORISTA
		private Articulo articulosBO = new Articulo(); //*-- MAYORISTA
		
		private static Category cat = Category.getInstance(Simcard.class);
		Global global = Global.getInstance();
		
		public ResultadoValidacionLogisticaDTO validaLargoSerieSimcard(ParametrosValidacionLogisticaDTO entrada)
			throws ProductDomainException
		{			
			cat.debug("Inicio:validaLargoSerieSimcard()");
			ResultadoValidacionLogisticaDTO resultado = simcardDAO.getLargoSerieSimcard(entrada);
			/*if (resultado.getLargoSerie() == entrada.getNumeroSerie().length())
				resultado.setResultado(true);
			else
				resultado.setResultado(false);*/
			cat.debug("Fin:validaLargoSerieSimcard()");
			return resultado;
		}// fin validaLargoSerieTerminal
		
		public ResultadoValidacionLogisticaDTO existeSerieSimcard(ParametrosValidacionLogisticaDTO entrada)
			throws ProductDomainException
		{			
			cat.debug("Inicio:existeSerieSimcard()");
			ResultadoValidacionLogisticaDTO resultado = simcardDAO.existeSerieSimcard(entrada); 
			if (resultado.getResultadoBase() == 1){
				resultado.setResultado(true);
			}
			else if (resultado.getResultadoBase() == 0){
				resultado.setResultado(false);
			}
			cat.debug("Fin:existeSerieSimcard()");
			return resultado;
		}//fin  existeSerieSimcard
		
		public SimcardDTO getSimcard(SimcardDTO entrada)
			throws ProductDomainException
		{
			cat.debug("Inicio:getSimcard()");
			SimcardDTO resultado = simcardDAO.getSimcard(entrada); 
			cat.debug("Fin:getSimcard()");
			return resultado;
		}//fin getSimcard
		
		public PrecioCargoDTO[] getPrecioCargoSimcard_PrecioLista(ParametrosCargoSimcardDTO entrada) 
			throws ProductDomainException
		{
			cat.debug("Inicio:getPrecioCargoSimcard_PrecioLista()");
			PrecioCargoDTO[] resultado =simcardDAO.getPrecioCargoSimcard_PrecioLista(entrada); 
			cat.debug("Fin:getPrecioCargoSimcard_PrecioLista()");
			return resultado;
		}//fin getPrecioCargoSimcard_PrecioLista

		public PrecioCargoDTO[] getPrecioCargoSimcard_NoPrecioLista(ParametrosCargoSimcardDTO entrada) 
			throws ProductDomainException
		{			
			cat.debug("Inicio:getPrecioCargoSimcard_NoPrecioLista()");
			PrecioCargoDTO[] resultado = simcardDAO.getPrecioCargoSimcard_NoPrecioLista(entrada); 
			cat.debug("Fin:getPrecioCargoSimcard_NoPrecioLista()");
			return resultado;
		}//fin getPrecioCargoSimcard_NoPrecioLista
		
		/**
		 * Busca Descuentos asociados al Cargo de la simcard
		 * @param entrada
		 * @return resultado
		 * @throws ProductDomainException
		 */
		public DescuentoDTO[] getDescuentoCargo(ParametrosDescuentoDTO entrada) 
			throws ProductDomainException
		{
			DescuentoDTO[] resultado = null;
			cat.debug("Inicio:getDescuentoCargo()");
			if (entrada.getClaseDescuento().equals(entrada.getClaseDescuentoArticulo()))
				resultado = simcardDAO.getDescuentoCargoArticulo(entrada);
			else
				resultado = simcardDAO.getDescuentoCargoConcepto(entrada);
			cat.debug("Fin:getDescuentoCargo()");
			return resultado;
		}//fin getDescuentoCargo
		
		/**
		 * Obtiene Codigo Concepto Facturable del descuento manual 
		 * @param entrada
		 * @return resultado
		 * @throws ProductDomainException
		 */
		
		public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada) 
			throws ProductDomainException
		{
			cat.debug("Inicio:getCodigoDescuentoManual()");
			DescuentoDTO resultado = simcardDAO.getCodigoDescuentoManual(entrada);
			cat.debug("Fin:getCodigoDescuentoManual()");
			return resultado;
		}//fin getCodigoDescuentoManual

		/**
		 * Verifica que numero celular este bien reservado 
		 * @param entrada
		 * @return resultado
		 * @throws ProductDomainException
		 */
		public ResultadoValidacionLogisticaDTO numeroReservadoOK(ParametrosValidacionLogisticaDTO entrada)
			throws ProductDomainException
		{			
			cat.debug("Inicio:numeroReservadoOK()");
			ResultadoValidacionLogisticaDTO resultado =  simcardDAO.getNumeroReservadoOK(entrada); 
			if (resultado.getResultadoBase() == 1){
				resultado.setResultado(true);
			}
			else if (resultado.getResultadoBase() == 0){
				resultado.setResultado(false);
			}
			cat.debug("Fin:numeroReservadoOK()");
			return resultado;
		}//fin  numeroReservadoOK

		/**
		 * Obtiene el indicador de telefono para una simcard
		 * @param entrada
		 * @return resultado
		 * @throws ProductDomainException
		 */
		public SimcardDTO getIndicadorTelefono(SimcardDTO entrada)
			throws ProductDomainException
		{			
			cat.debug("Inicio:getIndicadorTelefono()");
			SimcardDTO resultado = simcardDAO.getIndicadorTelefono(entrada); 
			cat.debug("Fin:getIndicadorTelefono()");
			return resultado;
		}//fin getIndicadorTelefono
		
		/**
		 * Valida autenticación de la serie 
		 * @param entrada
		 * @return resultado
		 * @throws ProductDomainException
		 */
		public ProcesoDTO validaAutenticacionSerie(SimcardDTO entrada) 
			throws ProductDomainException
		{
			ProcesoDTO resultado = new ProcesoDTO();
			cat.debug("Inicio:validaAutenticacionSerie()");
			resultado = simcardDAO.validaAutenticacionSerie(entrada); 
			cat.debug("Fin:validaAutenticacionSerie()");
			return resultado;
		}
		
		/**
		 * Obtiene imsi de la simcard, utilizado para isertar movimiento en centrales 
		 * @param entrada
		 * @return resultado
		 * @throws ProductDomainException
		 */
		public SimcardDTO getImsiSimcard(SimcardDTO simcard) 
			throws ProductDomainException
		{
			SimcardDTO resultado = new SimcardDTO();
			cat.debug("Inicio:getImsiSimcard()");
			resultado = simcardDAO.getImsiSimcard(simcard); 
			cat.debug("Fin:getImsiSimcard()");
			return resultado;
		}
		
		/**
		 * Actualiza stock simcard
		 * @param simcard
		 * @return resultado
		 * @throws ProductDomainException
		 */
		public SimcardDTO actualizaStockSimcard(SimcardDTO simcard) 
			throws ProductDomainException
		{
			SimcardDTO resultado = new SimcardDTO();
			cat.debug("Inicio:actualizaStockSimcard()");
			resultado = simcardDAO.actualizaStockSimcard(simcard); 
			cat.debug("Fin:actualizaStockSimcard()");
			return resultado;
		}//fin actualizaStockSimcard

		/** Servicios Activaciones WEB - Colombia
		 * MAYORISTAS
		 * Obtine precio cargo mayorista Simcard
		 * @param ParametrosCargoSimcardDTO (entrada)
		 * @return PrecioCargoDTO (resultado)
		 * @throws ProductDomainException
	     * wjrc - Agosto 2007 */  		
		public PrecioCargoDTO[] getPrecioCargoSimcardMayorista(ParametrosCargoSimcardDTO entrada) 
			throws ProductDomainException
		{
			cat.debug("Inicio:getPrecioCargoSimcardMayorista()");
			entrada.setTipoStock(global.getValor("tipo.stock.mayorista")); 
			PrecioCargoDTO[] resultado =simcardDAO.getPrecioCargoSimcard_PrecioLista(entrada); 
			cat.debug("Fin:getPrecioCargoSimcardMayorista()");
			return resultado;
		}//fin getPrecioCargoSimcardMayorista

		/** Servicios Activaciones WEB - Colombia
		 * MAYORISTAS
		 * Define el tipo de stock de la simcard
		 * @param SimcardDTO (entrada)
		 * @return String (resultado)
		 * @throws ProductDomainException
	     * wjrc - Agosto 2007 */  	
		public String defineStockSimcard(SimcardDTO simcard) 
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
				if (simcard.getModalidadVenta().equals(global.getValor("modalidad.venta.credito").trim()))
					if (simcard.getCanalVendedor().equals(global.getValor("codigo.canal.indirecto").trim()))
						if(simcard.getIndicadorValorar().equals(global.getValor("indicador.valorar.no").trim()))
							if (sAplicaMayorista.equals(global.getValor("valor.verdadero").trim()))
							{								
								//*-- venta mayorista?
								String sVentaMayorista = global.getValor("valor.falso").trim();
								ArticuloDTO articuloDTO = new ArticuloDTO();
								articuloDTO.setNumeroSerie(simcard.getNumeroSerie());
								articuloDTO = articulosBO.getVentaMayorista(articuloDTO);								
								if (articuloDTO.getDescripcion() != null)
									sVentaMayorista = global.getValor("valor.verdadero").trim();
								cat.debug("sVentaMayorista: " + sVentaMayorista);								
								//*-- serie numerada?
								String sSerieNumerada = global.getValor("valor.falso").trim();
								if (simcard.getNumeroCelular() != null && simcard.getEstado().equals(global.getValor("estado.serie.ok").trim()))
									sSerieNumerada = global.getValor("valor.verdadero").trim();
								cat.debug("sSerieNumerada: " + sSerieNumerada);								
								cat.debug("sPrecioLista: " + sSerieNumerada);
								
								//-- stock mayorista?		
								sVentaMayorista = "TRUE";
								if (sVentaMayorista.equals(global.getValor("valor.verdadero").trim()))
								{									
									    cat.debug("Ingreso a define mayorista 6 cambia tipo stock 2");
										tipoStock = global.getValor("tipo.stock.mayorista").trim();
								}
			}	
			cat.debug("defineStockSimcard():fin");
			return tipoStock;
		}//fin defineStockSimcard
		
		
		public SerieDTO[] buscarSerie(SerieDTO entrada)
			throws ProductDomainException
		{
			cat.debug("Inicio:buscarSerie()");
			SerieDTO[] resultado = simcardDAO.buscarSerie(entrada);
			cat.debug("Fin:buscarSerie()");
			return resultado;
		}//fin buscarSerie
		
		public SerieDTO[] listarSerie(SerieDTO entrada)
			throws ProductDomainException
		{
			cat.debug("Inicio:buscarSerie()");
			SerieDTO[] resultado = simcardDAO.listarSerie(entrada);
			cat.debug("Fin:buscarSerie()");
			return resultado;
		}//fin buscarSerie
		
		public EquipoKitDTO getSerieEquipoKit(EquipoKitDTO entrada)
			throws ProductDomainException
		{
			cat.debug("Inicio:getSerieEquipoKit()");
			EquipoKitDTO resultado = simcardDAO.getSerieEquipoKit(entrada);
			cat.debug("Fin:getSerieEquipoKit()");
			return resultado;
		}//fin getSerieEquipoKit

		
		//INICIO INC 187717 26/09/2012
		/**
		 * Obtiene numero de la movimiento, utilizado para desreservar la serie 
		 * @param entrada
		 * @return resultado
		 * @throws ProductDomainException
		 */
		public SimcardDTO getNumMovimmiento(SimcardDTO simcard) 
			throws ProductDomainException
		{
			SimcardDTO resultado = new SimcardDTO();
			cat.debug("Inicio:getNumMovimmiento()");
			resultado = simcardDAO.getNumMovimmiento(simcard); 
			cat.debug("Fin:getNumMovimmiento()");
			return resultado;
		}
		//FIN INC 187717 26/09/2012
//		INICIO INC 192326 11/02/2013
		/**
		 * Obtiene Kit Prepago, para sacarlo de inventario 
		 * @param entrada
		 * @return resultado
		 * @throws ProductDomainException
		 */
		public SimcardDTO getKitAboPrepago(Long abonado) 
			throws ProductDomainException
		{
			SimcardDTO resultado = new SimcardDTO();
			cat.debug("Inicio:getKitAboPrepago()");
			resultado = simcardDAO.getKitAboPrepago(abonado); 
			cat.debug("Fin:getKitAboPrepago()");
			return resultado;
		}
		//FIN  INC 192326 11/02/2013
	
		
}//fin Class Simcard

