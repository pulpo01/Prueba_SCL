package com.tmmas.cl.scl.logistica.service.servicios;

import javax.ejb.SessionContext;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosValidacionLogisticaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionLogisticaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.TipoStockValidoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.logistica.service.helper.Global;
import com.tmmas.cl.scl.productdomain.businessobject.bo.Articulo;
import com.tmmas.cl.scl.productdomain.businessobject.bo.ParametrosGenerales;
import com.tmmas.cl.scl.productdomain.businessobject.bo.Simcard;
import com.tmmas.cl.scl.productdomain.businessobject.bo.Terminal;
import com.tmmas.cl.scl.productdomain.businessobject.bo.TipoStockSerie;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ArticuloDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SimcardDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.TerminalDTO;


public class LogisticaSrv {
	
	private Simcard simcardBO  = new Simcard();
	private Terminal terminalBO = new Terminal();
	private TipoStockSerie tipoStockSerieBO = new TipoStockSerie();
	private ParametrosGenerales parametrosGeneralesBO = new ParametrosGenerales(); //*-- MAYORISTA
	private Articulo articulosBO = new Articulo(); //*-- MAYORISTA
	
	Global global = Global.getInstance();
	
	private final Logger logger = Logger.getLogger(LogisticaSrv.class);
	private SessionContext context = null;
	private CompositeConfiguration config;
	
	public LogisticaSrv()
	{
		logger.debug("AltaClienteSrv():Begin");
		config = UtilProperty.getConfigurationfromExternalFile("PortalVentas.properties");
		UtilLog.setLog(config.getString("LogisticaSrv.log"));
		logger.debug("AltaClienteSrv():End");		
	}
	
	public ResultadoValidacionLogisticaDTO validacionesSerieTerminal(ParametrosValidacionLogisticaDTO parametrosEntrada)
		throws ProductDomainException
	{
		logger.debug("Inicio:validacionesSerieTerminal()");
		
		ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
		
		parametrosEntrada.setCodigoProducto(global.getCodigoProducto());
		parametrosEntrada.setCodigoModulo(global.getCodigoModuloAL());
		parametrosEntrada.setNombreParametro(global.getLargoSerieTerminal());
		
		resultado = terminalBO.validaLargoSerieTerminal(parametrosEntrada);
				
		//Valida el largo de serie terminal
		//if(resultado.isResultado()==true)
		if(parametrosEntrada.getLargoSerieTerminal() == parametrosEntrada.getNumeroSerieTerminal().length())
		{
			/*resultado = terminalBO.existeSerieTerminal(parametrosEntrada);
			//Valida que la serie exista
			if(resultado.isResultado()==true)
			{*/
			TerminalDTO terminal = new TerminalDTO();
			terminal.setNumeroSerie(parametrosEntrada.getNumeroSerieTerminal());
			terminal = terminalBO.getTerminal(terminal);
			if (terminal.getIndProcEq().equals(global.getValor("equipo.procedencia.interna")))
			{	
				resultado.setEstado("OK");
				resultado.setDetalleEstado("-");
				/*if( parametrosEntrada.getTipoProducto().trim().equals("0"))
				{
					if(!terminal.getCodigoUso().trim().equals("2"))
					{
						resultado.setEstado("NOK");
						resultado.setCodigoError("-0000");
						resultado.setDetalleEstado("Terminal no corresponde a tipo de producto pospago");
					}else {
						resultado.setEstado("OK");
						resultado.setDetalleEstado("-");
					}
				}else if( parametrosEntrada.getTipoProducto().trim().equals("2"))
				{ //Tipo producto = 2(hibrido)
					if(!terminal.getCodigoUso().trim().equals("10"))
					{
						resultado.setEstado("NOK");
						resultado.setCodigoError("-0000");
						resultado.setDetalleEstado("Terminal no corresponde a tipo de producto hibrido");
					}else{
						resultado.setEstado("OK");
						resultado.setDetalleEstado("-");
					}
				}*/
				
				if(!resultado.getEstado().trim().equals("NOK"))
				{
					//////////////////////////////////////////////////////
					//*-- MAYORISTA /inicio
					logger.debug("INICIO validaciones serieSimcard 2.4 ");
					String sValidarUso = global.getValor("valor.verdadero");
			
					//-- OBTIENE PARAMETRO : APLICA MAYORISTA
					String sAplicaMayorista = global.getValor("valor.falso");
					ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
					parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
					parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
					parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.aplica.mayorista"));
					parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
					sAplicaMayorista = parametrosGeneralesDTO.getValorparametro();
					logger.debug("sAplicaMayorista: " + sAplicaMayorista);
					logger.debug("INICIO validaciones serieSimcard 2.5 ");
					if (sAplicaMayorista.equals(global.getValor("valor.verdadero")))
					{
						logger.debug("INICIO validaciones serieSimcard 2.6 parametrosEntrada.getCodigoCanal() : " + 
								parametrosEntrada.getCodigoCanal());
						logger.debug("INICIO validaciones serieSimcard 2.6 parametrosEntrada.getCodigoModalidadVenta() : " + 
								parametrosEntrada.getCodigoModalidadVenta());
						logger.debug("INICIO validaciones serieSimcard 2.6 sAplicaMayorista : " + 
								sAplicaMayorista );
						
						//*-- omite validacion uso?
						String sOmiteUsoVenta = global.getValor("valor.falso");
						if (parametrosEntrada.getCodigoCanal().equals(global.getValor("codigo.canal.indirecto")))
							//Se saca esta validacion ya que si se realizan ventas mayoristas al contado
							//if (parametrosEntrada.getCodigoModalidadVenta().equals(global.getValor("modalidad.venta.credito")))
								if(terminal.getTipoStock().trim().equals("4"))
									if (sAplicaMayorista.equals(global.getValor("valor.verdadero")))
									{
										//-- OBTIENE PARAMETRO : OMITE USO VENTA
										parametrosGeneralesDTO = new ParametrosGeneralesDTO();
										parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
										parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
										parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.omite_uso_venta"));
										parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
										sOmiteUsoVenta = parametrosGeneralesDTO.getValorparametro();		
											
										logger.debug("sOmiteUsoVenta: " + sOmiteUsoVenta);
									
										//*-- serie numerada?
										String sSerieNumerada = global.getValor("valor.falso");
										if (terminal.getNumeroCelular() != null && terminal.getEstado().equals(global.getValor("estado.serie.ok")))
											sSerieNumerada = global.getValor("valor.verdadero");
										logger.debug("sSerieNumerada: " + sSerieNumerada);
					
										//*-- venta mayorista?
										String sVentaMayorista = global.getValor("valor.falso");
										ArticuloDTO articuloDTO = new ArticuloDTO();
										articuloDTO.setNumeroSerie(terminal.getNumeroSerie());										
										articuloDTO = articulosBO.getVentaMayorista(articuloDTO);										
										if (articuloDTO.getDescripcion() != null)
											sVentaMayorista = global.getValor("valor.verdadero");
										logger.debug("sVentaMayorista: " + sVentaMayorista);
					
										//-- validar uso?
										if (sVentaMayorista.equals(global.getValor("valor.verdadero")))
											if (sOmiteUsoVenta.equals(global.getValor("valor.verdadero")))
												if (sSerieNumerada.equals(global.getValor("valor.verdadero")))
												{
													sValidarUso = global.getValor("valor.falso");
													resultado.setEsMayoristaTerminal(true);
												}else resultado.setEsMayoristaTerminal(false);
										logger.debug("sValidarUso: " + sValidarUso);
								}
					}//fin if (sAplicaMayorista.equals(global.getValor("valor.verdadero")...
						
					logger.debug("INICIO validaciones serieSimcard 2.7 ");
					if (sValidarUso.equals(global.getValor("valor.verdadero")))
					{
						//*-- MAYORISTA /fin
						//////////////////////////////////////////////////////
						//Verifica que el uso de la serie corresponda a venta pospago
						if(terminal.getCodigoUso() == Integer.parseInt(parametrosEntrada.getUsoVentaPostpago()) || 
								terminal.getCodigoUso() == Integer.parseInt(parametrosEntrada.getUsoVentaHibrido()))
						{
							TipoStockValidoDTO datosStockSerie=new TipoStockValidoDTO();
							datosStockSerie.setTipoStockaValidar(Integer.parseInt(terminal.getTipoStock()));
							logger.debug("codigo modalidad de venta: " + parametrosEntrada.getCodigoModalidadVenta());
							datosStockSerie.setModalidadVenta(Integer.parseInt(parametrosEntrada.getCodigoModalidadVenta()));
							datosStockSerie.setCodigoProducto(Integer.parseInt(global.getCodigoProducto()));
							if(parametrosEntrada.getCodigoCanal().trim().toUpperCase().equals("D")) 
							{
								datosStockSerie.setCodigoCanal("0");
							}else datosStockSerie.setCodigoCanal("1");
							resultado=tipoStockSerieBO.validaTipoStockSerie(datosStockSerie);						
							if (resultado.isResultado()){
								logger.debug("Terminal OK ultima instanciacion");
								resultado.setEstado("OK");
								resultado.setDetalleEstado("-");
							} else {							
								resultado.setEstado("NOK");
								resultado.setCodigoError("-2224");
								resultado.setDetalleEstado("La serie terminal tiene un tipo de stock no permitido");
							}
						} else {						
							resultado.setEstado("NOK");
							resultado.setCodigoError("-2225");
							resultado.setDetalleEstado("El uso de la serie del terminal no Corresponde a la venta Pospago");
						}
					}			
				}
			}
			else
			{
				/*TerminalDTO terminal = new TerminalDTO();
				terminal.setNumeroSerie(parametrosEntrada.getNumeroSerieTerminal());
				terminal = terminalBO.getTerminal(terminal);*/				
				resultado.setEstado("NOK");
				resultado.setCodigoError("-2226");
				resultado.setDetalleEstado("La serie terminal no se encuentra");				
			}
		}
		else
		{
			resultado.setEstado("NOK");
			resultado.setCodigoError("-2227");
			resultado.setDetalleEstado("El largo de la serie terminal no es correcto");
		}
		logger.debug("Fin:validacionesSerieTerminal()");
		return resultado;
	}
	
	public ResultadoValidacionLogisticaDTO validacionesSerieSimcard(ParametrosValidacionLogisticaDTO parametrosEntrada)
		throws ProductDomainException
	{
		logger.debug("Inicio:validacionesSerieSimcard()");
		ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
		resultado.setEstado("OK");
		//Valida el largo de la serie Simcard
		if(parametrosEntrada.getLargoSerieSimcard() == parametrosEntrada.getNumeroSerie().length())
		{
			logger.debug("INICIO validaciones serieSimcard 2 ");
			SimcardDTO simcard = new SimcardDTO();
			simcard.setNumeroSerie(parametrosEntrada.getNumeroSerie());
			simcard = simcardBO.getSimcard(simcard);
			logger.debug("INICIO validaciones serieSimcard 2.1 ");
			
			//Verifica que la serie exista
			if(simcard!=null)
			{				
				
				if( resultado.getEstado().trim().equals("OK"))
				{
					logger.debug("INICIO validaciones serieSimcard 2.3 ");
					//Verifica que la serie a vender sea nueva
					logger.debug("parametrosEntrada.getEstadoNuevoSimcard(): " + parametrosEntrada.getEstadoNuevoSimcard());
					logger.debug("simcard.getEstado(): " + simcard.getEstado());
					if(simcard.getEstado().equals(parametrosEntrada.getEstadoNuevoSimcard()))
					{
		            //*-- MAYORISTA /inicio
							logger.debug("INICIO validaciones serieSimcard 2.4 ");
						String sValidarUso = global.getValor("valor.verdadero");
					
						//-- OBTIENE PARAMETRO : APLICA MAYORISTA
						String sAplicaMayorista = global.getValor("valor.falso");
						ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
						parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
						parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
						parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.aplica.mayorista"));
						parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
						sAplicaMayorista = parametrosGeneralesDTO.getValorparametro();
						logger.debug("sAplicaMayorista: " + sAplicaMayorista);
						logger.debug("INICIO validaciones serieSimcard 2.5 ");
						if (sAplicaMayorista.equals(global.getValor("valor.verdadero")))
						{
							logger.debug("INICIO validaciones serieSimcard 2.6 parametrosEntrada.getCodigoCanal() : " + 
									parametrosEntrada.getCodigoCanal());
							logger.debug("INICIO validaciones serieSimcard 2.6 parametrosEntrada.getCodigoModalidadVenta() : " + 
									parametrosEntrada.getCodigoModalidadVenta());
							logger.debug("INICIO validaciones serieSimcard 2.6 sAplicaMayorista : " + 
									sAplicaMayorista );
							
							//*-- omite validacion uso?
							String sOmiteUsoVenta = global.getValor("valor.falso");
							if (parametrosEntrada.getCodigoCanal().trim().toUpperCase().equals(global.getValor("codigo.canal.indirecto")))
								//if (parametrosEntrada.getCodigoModalidadVenta().equals(global.getValor("modalidad.venta.credito")))
									if (simcard.getTipoStock().trim().equals("4"))
										if (sAplicaMayorista.equals(global.getValor("valor.verdadero")))
										{
											//-- OBTIENE PARAMETRO : OMITE USO VENTA
											parametrosGeneralesDTO = new ParametrosGeneralesDTO();
											parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
											parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
											parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.omite_uso_venta"));
											parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
											sOmiteUsoVenta = parametrosGeneralesDTO.getValorparametro();		
												
											logger.debug("sOmiteUsoVenta: " + sOmiteUsoVenta);
										
											//*-- serie numerada?
											String sSerieNumerada = global.getValor("valor.falso");
											if (simcard.getNumeroCelular() != null && simcard.getEstado().equals(global.getValor("estado.serie.ok")))
												sSerieNumerada = global.getValor("valor.verdadero");
											logger.debug("sSerieNumerada: " + sSerieNumerada);
						
											//*-- venta mayorista?
											String sVentaMayorista = global.getValor("valor.falso");
											ArticuloDTO articuloDTO = new ArticuloDTO();
											articuloDTO.setNumeroSerie(simcard.getNumeroSerie());
											articuloDTO = articulosBO.getVentaMayorista(articuloDTO);
											if (articuloDTO.getDescripcion() != null)
												sVentaMayorista = global.getValor("valor.verdadero");
											logger.debug("sVentaMayorista: " + sVentaMayorista);
						
											//-- validar uso?
											if (sVentaMayorista.equals(global.getValor("valor.verdadero")))
												if (sOmiteUsoVenta.equals(global.getValor("valor.verdadero")))
													if (sSerieNumerada.equals(global.getValor("valor.verdadero")))
													{
														sValidarUso = global.getValor("valor.falso");
														resultado.setEsMayoristaSimcard(true);
													}else resultado.setEsMayoristaSimcard(false);									
											logger.debug("sValidarUso: " + sValidarUso);
									}
						}//fin if (sAplicaMayorista.equals(global.getValor("valor.verdadero")...
							
						logger.debug("INICIO validaciones serieSimcard 2.7 ");
						if (sValidarUso.equals(global.getValor("valor.verdadero")))
						{
							//*-- MAYORISTA /fin
							logger.debug("INICIO validaciones serieSimcard 2.8 simcard.getCodigoUso() :  " + simcard.getCodigoUso());
							logger.debug("INICIO validaciones serieSimcard 2.8 parametrosEntrada.getUsoVentaPostpago() :  " + parametrosEntrada.getUsoVentaPostpago());
							logger.debug("INICIO validaciones serieSimcard 2.8 parametrosEntrada.getUsoVentaHibrido() :  " + parametrosEntrada.getUsoVentaHibrido());
							//Verifica que el uso de la serie corresponda a venta pospago
							if(Integer.parseInt(parametrosEntrada.getUsoVentaPostpago()) == simcard.getCodigoUso() 
									|| Integer.parseInt(parametrosEntrada.getUsoVentaHibrido()) == simcard.getCodigoUso())
							{
								logger.debug("INICIO validaciones serieSimcard 2.9 ");
								TipoStockValidoDTO datosStockSerie=new TipoStockValidoDTO();
								datosStockSerie.setTipoStockaValidar(Integer.parseInt(simcard.getTipoStock()));
								datosStockSerie.setModalidadVenta(Integer.parseInt(parametrosEntrada.getCodigoModalidadVenta()));
								datosStockSerie.setCodigoProducto(Integer.parseInt(global.getCodigoProducto()));								
								if(parametrosEntrada.getCodigoCanal().trim().toUpperCase().equals("D")) 
								{
									datosStockSerie.setCodigoCanal("0");
								}else datosStockSerie.setCodigoCanal("1");
								
								logger.debug("TIPO STOCK codigoCanal: " +  datosStockSerie.getCodigoCanal());
								logger.debug("TIPO STOCK codigoProducto: " +  datosStockSerie.getCodigoProducto());
								logger.debug("TIPO STOCK modalidadVenta: " +  datosStockSerie.getModalidadVenta());
								logger.debug("TIPO STOCK tipoStock: " +  datosStockSerie.getTipoStockaValidar());
								
								resultado=tipoStockSerieBO.validaTipoStockSerie(datosStockSerie);
								logger.debug("INICIO validaciones serieSimcard 2.10 ");
								if (resultado.isResultado())
								{
									logger.debug("Simcard OK");	
									logger.debug("INICIO validaciones serieSimcard 3 NOK");
									resultado.setEstado("OK");
									resultado.setDetalleEstado("-");
								} else {
									resultado.setEstado("NOK");
									resultado.setCodigoError("-2219");
									logger.debug("INICIO validaciones serieSimcard 4 NOK");
									resultado.setDetalleEstado("La serie simcard tiene un tipo de stock no permitido");
								}
							} else {
								resultado.setEstado("NOK");
								resultado.setCodigoError("-2220");
								logger.debug("INICIO validaciones serieSimcard 5 NOK");
								resultado.setDetalleEstado("El uso de la Serie Simcard no Corresponde a venta Pospago");
							}
							
								//Validaciones asociadas al tipo de producto
								//Tipo producto = 0(pospago)				
								if( parametrosEntrada.getTipoProducto().trim().equals("0"))
								{
									
//									//Incidencia 65043 se modifica validación de uso JC- NRCA [12-05-2008, desarrollo P-COL-08009]
									if(simcard.getCodigoUso() != 2 && simcard.getCodigoUso() != 10)
 									{
										resultado.setEstado("NOK");
										resultado.setCodigoError("-1");
										resultado.setDetalleEstado("Uso de Simcard no valido para venta postpago");
									} else{
										resultado.setEstado("OK");
										resultado.setDetalleEstado("-");						
									}
								}else if( parametrosEntrada.getTipoProducto().trim().equals("2")){ //Tipo producto = 2(hibrido)
									if(simcard.getCodigoUso() != 10 && simcard.getCodigoUso()!= 2)

									{
										resultado.setEstado("NOK");
										resultado.setCodigoError("-1");
										resultado.setDetalleEstado("Uso de Simcard no valido para venta hibrido");
									}else{
										resultado.setEstado("OK");						
										resultado.setDetalleEstado("-");
									}
								}else {
									resultado.setEstado("OK");						
									resultado.setDetalleEstado("-");
								}
						} else {
							/*TipoStockValidoDTO datosStockSerie=new TipoStockValidoDTO();
							datosStockSerie.setTipoStockaValidar(Integer.parseInt(simcard.getTipoStock()));
							datosStockSerie.setModalidadVenta(Integer.parseInt(parametrosEntrada.getCodigoModalidadVenta()));
							datosStockSerie.setCodigoProducto(Integer.parseInt(global.getCodigoProducto()));
							if(parametrosEntrada.getCodigoCanal().trim().toUpperCase().equals("D")) 
							{
								datosStockSerie.setCodigoCanal("0");
							}else datosStockSerie.setCodigoCanal("1");
							resultado=tipoStockSerieBO.validaTipoStockSerie(datosStockSerie);*/
							if(simcard.getTipoStock().trim().equals("4")) resultado.setResultado(true);
							if (resultado.isResultado())
							{
								logger.debug("Simcard OK");	
								resultado.setEstado("OK");
								resultado.setDetalleEstado("-");
							} else {
								logger.debug("INICIO validaciones serieSimcard 6 NOK");
								resultado.setEstado("NOK");
								resultado.setCodigoError("-2219");
								resultado.setDetalleEstado("La serie simcard tiene un tipo de stock no permitido");
							}
						}
					} else {
						logger.debug("INICIO validaciones serieSimcard 7 NOK");
						resultado.setEstado("NOK");
						resultado.setCodigoError("-2221");
						resultado.setDetalleEstado("Serie Simcard No es Nueva");
					}
				}
			} else {
				logger.debug("INICIO validaciones serieSimcard 8 NOK");
				resultado.setEstado("NOK");			
				resultado.setCodigoError("-2222");
				resultado.setDetalleEstado("Serie Simcard No Existe");
			}
		} else {
			resultado = new ResultadoValidacionLogisticaDTO();
			logger.debug("INICIO validaciones serieSimcard 9 NOK");
			resultado.setEstado("NOK");
			resultado.setCodigoError("-2223");
			resultado.setDetalleEstado("Largo Serie Simcard Incorrecto");
		}
		
		logger.debug("Fin:validacionesSerieSimcard()");
		return resultado;
	}

}