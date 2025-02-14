package com.tmmas.scl.quiosco.web.action;
import java.math.BigDecimal;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClasificacionDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ValorClasificacionDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsClasificacionOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsCrediticiaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListTarjetaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListadoCategoriaCambioDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListadoCategoriasClienteOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListadoRegionesOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListadoTiposIdentificacionOutDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.WsDatosDireccionOutDTO;
import com.tmmas.cl.scl.spnsclws.pa.SpnSclWS;
import com.tmmas.cl.scl.spnsclws.pa.SpnSclWSService;
import com.tmmas.cl.scl.spnsclws.pa.SpnSclWSService_Impl;
import com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraComercialOutDTO;
import com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraLineaDTO;
import com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraPagoDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.ArrayOfTipificacionDTO_Literal;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.ClienteDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.DatosClienteDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.DireccionDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsTiendaVendedorOutDTO;
import com.tmmas.scl.quiosco.web.VO.AccesorioVO;
import com.tmmas.scl.quiosco.web.VO.KitVO;
import com.tmmas.scl.quiosco.web.VO.LineaVO;
import com.tmmas.scl.quiosco.web.VO.TotalVO;
import com.tmmas.scl.quiosco.web.altaLinea.AltaLinea;
import com.tmmas.scl.quiosco.web.form.VentaForm;
/*import dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.ClienteDTO;
import dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.DatosClienteDTO;
import dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.DireccionDTO;
import dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TipificacionDTO;
import dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsTiendaVendedorOutDTO;
import dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListBancoOutDTO;
import dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListTarjetaOutDTO;
import dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoCategoriasClienteOutDTO;
import dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoRegionesOutDTO;
import dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoTiposIdentificacionOutDTO;
import dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraComercialOutDTO;
import dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraLineaDTO;
import dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraPagoDTO;
*/
public class VentaAction extends Action {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Logger logger = Logger.getLogger(this.getClass());
	CompositeConfiguration config;
	
	
	public VentaAction(){
		System.out.println("VentaAction:Start");
		config = UtilProperty.getConfigurationfromExternalFile("propiedadesQuioscoWEB.properties");
		UtilLog.setLog(config.getString("QuioscoWEB.log"));
		logger.error("VentaAction:End");
	}
	
	
	public ActionForward execute(ActionMapping mapping, ActionForm p_form, HttpServletRequest request, HttpServletResponse response){

		VentaForm form = (VentaForm) p_form;
		String target=new String();
		HttpSession session = request.getSession();
		
		LineaVO lineaVO = null;
		AccesorioVO accesorioVO = null;
		TotalVO totalVO =null;
		ArrayList<LineaVO> listaLineas =null;
		ArrayList<AccesorioVO> listaAccesorios =null;
		ArrayList<KitVO> listaKit =null;
		boolean seriado = true;
		logger.error("inicio:ActionForward()");
		try {
		//SESSION DE TOTALES	
			
		SpnSclWSService service = new SpnSclWSService_Impl(config.getString("ruta.webservice"));    
		SpnSclWS port = service.getSpnSclWSSoapPort();
		
		WsTiendaVendedorOutDTO tienda = (WsTiendaVendedorOutDTO)session.getAttribute("tiendaVendedor");

		
		 totalVO = (TotalVO)session.getAttribute("totalVO");
		if(totalVO==null){
			totalVO = new TotalVO();
			totalVO.setSubTotal(new BigDecimal("0.00"));
			totalVO.setTotal(new BigDecimal("0.00"));
			totalVO.setItbm(new BigDecimal("0.00"));
			totalVO.setIsc(new BigDecimal("0.00"));
		}
		
		//SESSION DE LINEAS
		listaLineas = (ArrayList<LineaVO>) session.getAttribute("listaLineas");
		if(listaLineas==null){
			listaLineas=new ArrayList<LineaVO>();
		}

		//SESSION DE ACCESORIOS
		 listaAccesorios =(ArrayList<AccesorioVO>) session.getAttribute("listaAccesorios");
		if(listaAccesorios==null){
			listaAccesorios=new ArrayList<AccesorioVO>();
		}
				
		//SESSION DE KIT
		listaKit = (ArrayList<KitVO>) session.getAttribute("listaKit");
		if(listaKit==null){
			listaKit=new ArrayList<KitVO>();
		}
		
		

		if("llamarVenta".equals(form.getAccionVenta())){
			logger.error("llamarPaginaVenta");
			
			totalVO.setSubTotal(new BigDecimal("0.00"));
			totalVO.setTotal(new BigDecimal("0.00"));
			totalVO.setItbm(new BigDecimal("0.00"));
			totalVO.setIsc(new BigDecimal("0.00"));
			listaAccesorios=new ArrayList<AccesorioVO>();
			listaKit=new ArrayList<KitVO>();
			listaLineas=new ArrayList<LineaVO>();
			
			//LLAMAR BANCOS
			com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListBancoOutDTO getListadoBancosPAC = new com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListBancoOutDTO();
			
			com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListBancoOutDTO bancos = port.getListadoBancosPAC();
					
				if(!"0".equals(bancos.getCodError())){
					logger.error("Error : "+ bancos.getMensajseError());
					request.setAttribute("desError",bancos.getMensajseError());
					target="globalErrorInesperado";
					return mapping.findForward(target);
				}
			    request.setAttribute("bancos",bancos.getWsBancoArrOutDTO());
				
		    //LLAMAR PRESTACIONES
				com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WsListTipoPrestacionOutDTO getTiposPrestacion = new com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WsListTipoPrestacionOutDTO();
				
				com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WsListTipoPrestacionOutDTO prestaciones = port.getTiposPrestacion(config.getString("grupo.prestacion.movil"), config.getString("tipo.cliente.prepago"));
						
					if(!"0".equals(prestaciones.getCodError())){
						logger.error("Error : "+ prestaciones.getMensajseError());
						request.setAttribute("desError",prestaciones.getMensajseError());
						target="globalErrorInesperado";
						return mapping.findForward(target);
					}
				    request.setAttribute("prestaciones",prestaciones.getTipoPrestacionDTO());
			    
				//LLAMAR TARJETAS
			    WsListTarjetaOutDTO getListadoTarjetas = new WsListTarjetaOutDTO();
			    WsListTarjetaOutDTO tarjetas = port.getListadoTarjetas();
			    
			    if(!"0".equals(tarjetas.getCodError())){
					logger.error("Error : "+ tarjetas.getMensajseError());
					request.setAttribute("desError",tarjetas.getMensajseError());
					target="globalErrorInesperado";
					return mapping.findForward(target);
				}
			    request.setAttribute("tarjetas",tarjetas.getWsTarjetaArrOutDTO());

			target="venta";
		}
		//Agregar articulos a la grilla de venta
		else if("agregarArticulo".equals(form.getAccionVenta())){	
			logger.error("agregarArticulo serie: "+form.getSerie().trim());
			
			String validacionRepeticion = validarSerieRepetida(form.getSerie(),listaLineas,listaAccesorios,listaKit);
			
			if(!"OK".equals(validacionRepeticion)){
				logger.error("Error serie repetida: "+validacionRepeticion);
				request.setAttribute("desError",validacionRepeticion);
				target="errorArticulo";
				return mapping.findForward(target);
			}
			
			
				logger.error("antes de rescatar datos");

				ArrayOfTipificacionDTO_Literal tipificacionDTOs = port.recuperaDatoTipificacion(form.getSerie().trim(),tienda.getCodVendedor() );
				
				
				
				if(tipificacionDTOs.getTipificacionDTO()[0].getCodError()!=0)
				{
					logger.error("Error serie: "+tipificacionDTOs.getTipificacionDTO()[0].getMsgError());
					request.setAttribute("desError",tipificacionDTOs.getTipificacionDTO()[0].getMsgError());
					target="errorArticulo";
					return mapping.findForward(target);
				}

				logger.error("despues de rescatar datos");
				if(config.getString("equi.acc.kit").equals(tipificacionDTOs.getTipificacionDTO()[0].getEquiAcc())){
					//KIT
					logger.error("es un kit");
					ArrayList<LineaVO> listaLineasKit =new ArrayList<LineaVO>();
					
					KitVO kitVO = new KitVO();
					kitVO.setNumeroKit(form.getSerie());
					kitVO.setDescripcionKit(tipificacionDTOs.getTipificacionDTO()[0].getDescripArticulo());
					
					
					
					BigDecimal precio = new BigDecimal(String.valueOf(tipificacionDTOs.getTipificacionDTO()[0].getPrecioArticulo())).setScale(4,BigDecimal.ROUND_HALF_UP);
					BigDecimal descuento = new BigDecimal(String.valueOf(tipificacionDTOs.getTipificacionDTO()[0].getDescuentoPrecio())).setScale(4,BigDecimal.ROUND_HALF_UP);
					BigDecimal precioKit = precio.subtract(descuento).setScale(4,BigDecimal.ROUND_HALF_UP);
					
																															
					kitVO.setPrecioKit(precioKit.toString());
					
					kitVO.setIdKit(Integer.toString(listaKit.size()));
																									
					BigDecimal itbm = new BigDecimal(String.valueOf(tipificacionDTOs.getTipificacionDTO()[0].getImpITMB()));																			
					kitVO.setItbm(itbm.toString());
					
					
					BigDecimal isc = new BigDecimal(String.valueOf(tipificacionDTOs.getTipificacionDTO()[0].getImpISC()));				
					kitVO.setIsc(isc.toString());
					
																						
					totalVO.setSubTotal(totalVO.getSubTotal().add(precio));					
					totalVO.setItbm(totalVO.getItbm().add(itbm));
					totalVO.setIsc(totalVO.getIsc().add(isc));																			
					
					listaKit.add(kitVO);
					
					for(int i=1; i<=tipificacionDTOs.getTipificacionDTO().length-1;i++){
						if(config.getString("tip.terminal.simcard").equals(tipificacionDTOs.getTipificacionDTO()[i].getTipTerminal())&&config.getString("equi.acc.kit").equals(tipificacionDTOs.getTipificacionDTO()[i].getEquiAcc())){
							//SIMCARD
							logger.error("es una simcard");
							lineaVO = new LineaVO();
							lineaVO.setCodigoSim(Integer.toString(tipificacionDTOs.getTipificacionDTO()[i].getCodArticulo()));
							lineaVO.setCelular(tipificacionDTOs.getTipificacionDTO()[i].getNumCelular());
							lineaVO.setSimcard(tipificacionDTOs.getTipificacionDTO()[i].getNumSerie());
							lineaVO.setDescripcionSim(tipificacionDTOs.getTipificacionDTO()[i].getDescripArticulo());
							lineaVO.setIdLinea(Integer.toString(listaLineas.size()));
							lineaVO.setNumKit(form.getSerie());
							listaLineasKit.add(lineaVO);
						}
						else if(config.getString("tip.terminal.imei").equals(tipificacionDTOs.getTipificacionDTO()[i].getTipTerminal())&&config.getString("equi.acc.kit").equals(tipificacionDTOs.getTipificacionDTO()[i].getEquiAcc())){
							//EQUIPO
							boolean noHaySimDisp = true;
							logger.error("es un equipo");

								for(int x=0;x<=listaLineasKit.size()-1;x++){
									if(listaLineasKit.get(x).getCodigoImei()==null){
										noHaySimDisp=false;
										listaLineasKit.get(x).setCodigoImei(Integer.toString(tipificacionDTOs.getTipificacionDTO()[i].getCodArticulo()));
										listaLineasKit.get(x).setDescripcionImei(tipificacionDTOs.getTipificacionDTO()[i].getDescripArticulo());
										listaLineasKit.get(x).setImei(tipificacionDTOs.getTipificacionDTO()[i].getNumSerie());
										break;
									}
								}
								
								if(noHaySimDisp){
									logger.error("Error serie: "+tipificacionDTOs.getTipificacionDTO()[0].getMsgError());
									request.setAttribute("desError","EN EL KIT NO EXISTEN SUFICIENTES SIMCARD PARA LOS TERMINALES");
									target="errorArticulo";
									return mapping.findForward(target);
								}
			
						}
						
					}
					
					//Agrego las lineas de los kit a la lista de lineas
					for(int i=0;i<=listaLineasKit.size()-1;i++){
						listaLineas.add(listaLineasKit.get(i));
					}
					target="kit";
				}
				else{
					logger.error("no es un kit");
					if(config.getString("tip.terminal.simcard").equals(tipificacionDTOs.getTipificacionDTO()[0].getTipTerminal())&&config.getString("equi.acc.equipo").equals(tipificacionDTOs.getTipificacionDTO()[0].getEquiAcc())){
						//SIMCARD
						logger.error("es una simcard");
						lineaVO = new LineaVO();
						lineaVO.setCodigoSim(Integer.toString(tipificacionDTOs.getTipificacionDTO()[0].getCodArticulo()));
						lineaVO.setCelular(tipificacionDTOs.getTipificacionDTO()[0].getNumCelular());
						lineaVO.setSimcard(tipificacionDTOs.getTipificacionDTO()[0].getNumSerie());
						lineaVO.setDescripcionSim(tipificacionDTOs.getTipificacionDTO()[0].getDescripArticulo());
						
						BigDecimal precio = new BigDecimal(String.valueOf(tipificacionDTOs.getTipificacionDTO()[0].getPrecioArticulo())).setScale(4,BigDecimal.ROUND_HALF_UP);
						BigDecimal descuento = new BigDecimal(String.valueOf(tipificacionDTOs.getTipificacionDTO()[0].getDescuentoPrecio())).setScale(4,BigDecimal.ROUND_HALF_UP);
						BigDecimal precioSim = precio.subtract(descuento).setScale(4,BigDecimal.ROUND_HALF_UP);
						
						lineaVO.setPrecioSim(precioSim.toString());
						
						lineaVO.setIdLinea(Integer.toString(listaLineas.size()));
						lineaVO.setTotal(lineaVO.getPrecioSim());
						
						BigDecimal itbm = new BigDecimal(String.valueOf(tipificacionDTOs.getTipificacionDTO()[0].getImpITMB()));
						lineaVO.setItbm(itbm.toString());
						
						BigDecimal isc = new BigDecimal(String.valueOf(tipificacionDTOs.getTipificacionDTO()[0].getImpISC()));
						lineaVO.setIsc(isc.toString());
						
						totalVO.setSubTotal(totalVO.getSubTotal().add(precioSim));
						
						totalVO.setItbm(totalVO.getItbm().add(itbm));
						totalVO.setIsc(totalVO.getIsc().add(isc));
						
						listaLineas.add(lineaVO);

						target="linea";
					}
					else if(config.getString("tip.terminal.imei").equals(tipificacionDTOs.getTipificacionDTO()[0].getTipTerminal())&&config.getString("equi.acc.equipo").equals(tipificacionDTOs.getTipificacionDTO()[0].getEquiAcc())){
						//EQUIPO
						boolean noHaySimDisp = true;
						logger.error("es un equipo");

							for(int i=0;i<=listaLineas.size()-1;i++){
								if(listaLineas.get(i).getCodigoImei()==null){
									noHaySimDisp=false;
									listaLineas.get(i).setCodigoImei(Integer.toString(tipificacionDTOs.getTipificacionDTO()[0].getCodArticulo()));
									listaLineas.get(i).setDescripcionImei(tipificacionDTOs.getTipificacionDTO()[0].getDescripArticulo());
									listaLineas.get(i).setImei(tipificacionDTOs.getTipificacionDTO()[0].getNumSerie());
									
									BigDecimal precio = new BigDecimal(String.valueOf(tipificacionDTOs.getTipificacionDTO()[0].getPrecioArticulo())).setScale(4,BigDecimal.ROUND_HALF_UP);
									BigDecimal descuento = new BigDecimal(String.valueOf(tipificacionDTOs.getTipificacionDTO()[0].getDescuentoPrecio())).setScale(4,BigDecimal.ROUND_HALF_UP);
									BigDecimal precioImei = precio.subtract(descuento).setScale(4,BigDecimal.ROUND_HALF_UP);
									listaLineas.get(i).setPrecioImei(precioImei.toString());
									
									BigDecimal precioSim = new BigDecimal(String.valueOf(listaLineas.get(i).getPrecioSim())).setScale(4,BigDecimal.ROUND_HALF_UP);
									BigDecimal totalLinea = precioSim.add(precioImei).setScale(4,BigDecimal.ROUND_HALF_UP);
									listaLineas.get(i).setTotal(totalLinea.toString());
									
									BigDecimal itbmSim = new BigDecimal(String.valueOf(listaLineas.get(i).getItbm()));
									BigDecimal itbmImei = new BigDecimal(String.valueOf(tipificacionDTOs.getTipificacionDTO()[0].getImpITMB()));
									BigDecimal itbm = itbmSim.add(itbmImei);
									listaLineas.get(i).setItbm(itbm.toString());
									
									BigDecimal iscSim = new BigDecimal(String.valueOf(listaLineas.get(i).getIsc()));
									BigDecimal iscImei = new BigDecimal(String.valueOf(tipificacionDTOs.getTipificacionDTO()[0].getImpISC()));
									BigDecimal isc = iscSim.add(iscImei);
									listaLineas.get(i).setIsc(isc.toString());
									
									
									totalVO.setSubTotal(totalVO.getSubTotal().add(precioImei));
									totalVO.setItbm(totalVO.getItbm().add(itbmImei));
									totalVO.setIsc(totalVO.getIsc().add(iscImei));
									
									break;
								}
							}
							
							if(noHaySimDisp){
								logger.error("Error serie: "+tipificacionDTOs.getTipificacionDTO()[0].getMsgError());
								request.setAttribute("desError","No Hay Simcard Disponibles");
								target="errorArticulo";
								return mapping.findForward(target);
								}

							target="linea";
					}
					else if(config.getString("equi.acc.accesorio").equals(tipificacionDTOs.getTipificacionDTO()[0].getEquiAcc())){
						//ACCESORIO
						logger.error("es una accesorio");
						seriado = false;
						
						
						
						accesorioVO = new AccesorioVO();
						accesorioVO.setCodigo(Integer.toString(tipificacionDTOs.getTipificacionDTO()[0].getCodArticulo()));
						logger.error("tipificacionDTOs[0].getCodArticulo() ["+tipificacionDTOs.getTipificacionDTO()[0].getCodArticulo()+"]");
						accesorioVO.setSerie(tipificacionDTOs.getTipificacionDTO()[0].getNumSerie());
						logger.error("tipificacionDTOs[0].getNumSerie() ["+tipificacionDTOs.getTipificacionDTO()[0].getNumSerie()+"]");
						if(null!=accesorioVO.getSerie()&&!"".equals(accesorioVO.getSerie().trim()))
							seriado=true;
						
						
						//Valido repeticion de serie
						if(seriado){						
							validacionRepeticion = validarSerieRepetida(accesorioVO.getSerie(),listaLineas,listaAccesorios,listaKit);
							if(!"OK".equals(validacionRepeticion)){
								logger.error("Error serie repetida: "+validacionRepeticion);
								request.setAttribute("desError",validacionRepeticion);
								target="errorArticulo";
								return mapping.findForward(target);
							}
						}
						
						if(seriado)
							accesorioVO.setCantidad("1");
						else
							accesorioVO.setCantidad(form.getCantidad());
						
						accesorioVO.setDescripcion(tipificacionDTOs.getTipificacionDTO()[0].getDescripArticulo());
						logger.error("tipificacionDTOs[0].getDescripArticulo() ["+tipificacionDTOs.getTipificacionDTO()[0].getDescripArticulo()+"]");
						
						
						logger.error("tipificacionDTOs[0].getPrecioArticulo() ["+tipificacionDTOs.getTipificacionDTO()[0].getPrecioArticulo()+"]");
						BigDecimal precio = new BigDecimal(String.valueOf(tipificacionDTOs.getTipificacionDTO()[0].getPrecioArticulo())).setScale(4,BigDecimal.ROUND_HALF_UP);
						logger.error("precio ["+precio+"]");
						
						logger.error("tipificacionDTOs[0].getDescuentoPrecio() ["+tipificacionDTOs.getTipificacionDTO()[0].getDescuentoPrecio()+"]");
						BigDecimal descuento = new BigDecimal(String.valueOf(tipificacionDTOs.getTipificacionDTO()[0].getDescuentoPrecio())).setScale(4,BigDecimal.ROUND_HALF_UP);
						logger.error("descuento ["+descuento+"]");
						
						logger.error("precio - descuento ["+precio+"] - ["+descuento.doubleValue()+"]");
						BigDecimal precioACC = precio.subtract(descuento).setScale(4,BigDecimal.ROUND_HALF_UP);
						logger.error("precioACC ["+precioACC.toString()+"]");
						
						accesorioVO.setPrecioUnitario(precioACC.toString());
						
						BigDecimal cantidad = new BigDecimal(Double.valueOf(accesorioVO.getCantidad()));
																													
						
						BigDecimal itbm = new BigDecimal(String.valueOf(tipificacionDTOs.getTipificacionDTO()[0].getImpITMB()));		
						itbm = itbm.multiply(cantidad);
						accesorioVO.setItbm(itbm.toString());
						logger.error("tipificacionDTOs[0].getImpITMB() * accesorioVO.getCantidad() ["+tipificacionDTOs.getTipificacionDTO()[0].getImpITMB()+"] * ["+accesorioVO.getCantidad()+"]");
						logger.error("itbm.toString() ["+itbm.toString()+"]");
						
																	
						BigDecimal isc = new BigDecimal(String.valueOf(tipificacionDTOs.getTipificacionDTO()[0].getImpISC()));	
						isc = isc.multiply(cantidad);
						accesorioVO.setIsc(isc.toString());
						logger.error("tipificacionDTOs[0].getImpISC() * accesorioVO.getCantidad() ["+tipificacionDTOs.getTipificacionDTO()[0].getImpISC()+"] * ["+accesorioVO.getCantidad()+"]");
						logger.error("isc.toString() ["+isc.toString()+"]");
													
						BigDecimal totalACC = precioACC.multiply(new BigDecimal(accesorioVO.getCantidad())).setScale(4,BigDecimal.ROUND_FLOOR);
						logger.error("totalACC ["+totalACC+"]");
						accesorioVO.setTotal(totalACC.toString());
						
						accesorioVO.setIdAccesorio(Integer.toString(listaAccesorios.size()));
						
						/*------------------------ Calcula totoales -------------------------------------*/
						
						
						
						BigDecimal totalACCBig = new BigDecimal(totalACC.toString()).setScale(4,BigDecimal.ROUND_HALF_UP) ;
						
						logger.error("totalACCBig ["+totalACCBig+"]");
						logger.error("totalVO.getSubTotal() ["+totalVO.getSubTotal()+"]");
						totalVO.setSubTotal(totalVO.getSubTotal().add(totalACCBig).setScale(4,BigDecimal.ROUND_HALF_UP));
						logger.error("totalVO.getSubTotal().add(totalACCBig).setScale(4,BigDecimal.ROUND_HALF_UP) ["+totalVO.getSubTotal().add(totalACCBig).setScale(4,BigDecimal.ROUND_HALF_UP)+"]");
												
								
						logger.error("totalVO.getItbm() ["+totalVO.getItbm()+"]");
						totalVO.setItbm(totalVO.getItbm().add(itbm));
						logger.error("totalVO.getItbm() ["+totalVO.getItbm()+"]");
								
						logger.error("totalVO.getIsc() ["+totalVO.getIsc()+"]");
						totalVO.setIsc(totalVO.getIsc().add(isc));
						logger.error("totalVO.getIsc() ["+totalVO.getIsc()+"]");
						
						listaAccesorios.add(accesorioVO);

						target="accesorio";
					}
					else{
						logger.error("Error serie: "+tipificacionDTOs.getTipificacionDTO()[0].getMsgError());
						request.setAttribute("desError","No se reconoce serie ingresada");
						target="errorArticulo";
						return mapping.findForward(target);
					}
				}
				
			
		}
		//Quitar una linea
		else if("quitarLinea".equals(form.getAccionVenta())){
			logger.error("quitarlinea serieSimcard: "+form.getSerie().trim());
			ArrayList<LineaVO> listaNueva = new ArrayList<LineaVO>();
			for(int i=0;i<=listaLineas.size()-1;i++){
				if(listaLineas.get(i).getIdLinea().equals(form.getIdLinea())){
					BigDecimal precioLinea = new BigDecimal(listaLineas.get(i).getTotal()).setScale(4,BigDecimal.ROUND_HALF_UP);
					totalVO.setSubTotal(totalVO.getSubTotal().subtract(precioLinea));
					
					BigDecimal itbmLinea = new BigDecimal(listaLineas.get(i).getItbm());
					totalVO.setItbm(totalVO.getItbm().subtract(itbmLinea));
					
					BigDecimal iscLinea = new BigDecimal(listaLineas.get(i).getIsc());
					totalVO.setIsc(totalVO.getIsc().subtract(iscLinea));
				}
				else{
					listaLineas.get(i).setIdLinea(Integer.toString(listaNueva.size()));
					listaNueva.add(listaLineas.get(i));
				}
			}
			
			listaLineas = listaNueva;

			target="linea";
		}
		//Quitar un Kit
		else if("quitarKit".equals(form.getAccionVenta())){
			logger.error("quitarKit numero kit: "+form.getIdKit());
			String numKit = new String();
			ArrayList<KitVO> listaNueva = new ArrayList<KitVO>();
			for(int i=0;i<=listaKit.size()-1;i++){
				if(listaKit.get(i).getIdKit().equals(form.getIdKit())){
					
					BigDecimal precioKit = new BigDecimal(listaKit.get(i).getPrecioKit()).setScale(4,BigDecimal.ROUND_HALF_UP);
					totalVO.setSubTotal(totalVO.getSubTotal().subtract(precioKit));
					
					BigDecimal itbmKit = new BigDecimal(listaKit.get(i).getItbm());
					totalVO.setItbm(totalVO.getItbm().subtract(itbmKit));
					
					BigDecimal iscKit = new BigDecimal(listaKit.get(i).getIsc());
					totalVO.setIsc(totalVO.getIsc().subtract(iscKit));
					
					numKit = listaKit.get(i).getNumeroKit();
				}
				else{
					listaKit.get(i).setIdKit(Integer.toString(listaNueva.size()));
					listaNueva.add(listaKit.get(i));
				}
			}
			
			
			ArrayList<LineaVO> listaNuevaLineasKit = new ArrayList<LineaVO>();
			for(int i=0;i<=listaLineas.size()-1;i++){
				if(!numKit.equals(listaLineas.get(i).getNumKit())){
					listaNuevaLineasKit.add(listaLineas.get(i));
				}
			}
			
			listaLineas = listaNuevaLineasKit;
			listaKit = listaNueva;

			target="kit";
		}
		//Quitar un Accesorio
		else if("quitarAccesorio".equals(form.getAccionVenta())){
			logger.error("quitarAccesorio serie: "+form.getSerie().trim());
			ArrayList<AccesorioVO> listaNueva = new ArrayList<AccesorioVO>();
			for(int i=0;i<=listaAccesorios.size()-1;i++){
				if(listaAccesorios.get(i).getIdAccesorio().equals(form.getIdAccesorio())){
					
					BigDecimal precioACC = new BigDecimal(listaAccesorios.get(i).getTotal()).setScale(4,BigDecimal.ROUND_HALF_UP);
					totalVO.setSubTotal(totalVO.getSubTotal().subtract(precioACC));
					
					BigDecimal itbmACC = new BigDecimal(listaAccesorios.get(i).getItbm());
					totalVO.setItbm(totalVO.getItbm().subtract(itbmACC));
					
					BigDecimal iscACC = new BigDecimal(listaAccesorios.get(i).getIsc());
					totalVO.setIsc(totalVO.getIsc().subtract(iscACC));
				}
				else{
					listaAccesorios.get(i).setIdAccesorio(Integer.toString(listaNueva.size()));
					listaNueva.add(listaAccesorios.get(i));
				}
			}		
			listaAccesorios = listaNueva;
			target="accesorio";
		}
		else if("llamarFormCliente".equals(form.getAccionVenta())){
			logger.error("llamarFormCliente");
			if(listaLineas.size()==0 && listaAccesorios.size()==0){
				request.setAttribute("desError", config.getString("error.no.articulos.venta"));
				target="globalError";
			}
			else if(listaLineas.size()==0){
			//Llamar alta de linea
				//EJECUTO ALTA
				AltaLinea altaLinea = new AltaLinea();
				ArrayList<WsStructuraLineaDTO> list = new ArrayList<WsStructuraLineaDTO>();
				String codDireccion =tienda.getCodDireccion(); 
				DatosClienteDTO clienteDTO = new DatosClienteDTO();
				
				clienteDTO.setCliente(new ClienteDTO());
				clienteDTO.getCliente().setCodCliente(new Long(tienda.getCodCliente()));
				clienteDTO.getCliente().setCodCuenta(new Long(tienda.getCodCuenta())); 
				
				//Levanto session de pago
				WsStructuraPagoDTO structuraPagoDTO = new WsStructuraPagoDTO();
				structuraPagoDTO.setCodBanco(form.getCodBanco());
				structuraPagoDTO.setCodCajaQuiosco(tienda.getCodCaja());
				structuraPagoDTO.setNumDocumento(form.getNumDocumento());
				structuraPagoDTO.setNumCuentaCorriente(form.getNumCuentaCorriente());
				structuraPagoDTO.setNumTarjetaCredito(form.getNumTarjetaCredito());
				structuraPagoDTO.setSistemaPago(form.getSistemaPago().split("#")[0]);
				
				structuraPagoDTO.setAplicapago("1".equals(tienda.getIndApliPAgo().trim()));
				
				structuraPagoDTO.setCodTipTarjeta(limpiarValor(form.getCodTipTarjeta())); // CSR-11002
				
				WsStructuraComercialOutDTO structuraComercialOutDTO = altaLinea.altaLinea(clienteDTO, tienda,list, listaAccesorios,structuraPagoDTO,request.getUserPrincipal().getName(),codDireccion, form.getCodPrestacion());

				logger.error("TRANSAC: "+structuraComercialOutDTO.getResultadoTransaccion());
				if("0".equals(structuraComercialOutDTO.getResultadoTransaccion())){
					if(null==structuraComercialOutDTO.getPdfAsBytes()){
						request.setAttribute("sinFactura", "si");
					}else{
						request.setAttribute("sinFactura", "no");
						session.setAttribute("pdf",structuraComercialOutDTO.getPdfAsBytes());
					}
					System.out.println("VENTA: "+structuraComercialOutDTO.getNumVenta());
					if(null==structuraComercialOutDTO.getNumVenta()){
						structuraComercialOutDTO.setNumVenta("No es posible mostrar el número de venta en estos momentos");
					}
					request.setAttribute("ventaNumVenta", structuraComercialOutDTO.getNumVenta());
			        target="globalExitoVenta";
				}
				else{
					request.setAttribute("errores",structuraComercialOutDTO.getErrores());
					target="globalErrorAltaLinea";
				}
				
				//Mato todas las sessiones menos los datos de la tienda y el vendedor	
				//session.setAttribute("tiendaVendedor", null);
				//session.setAttribute("usuarioPrincipal", null);
				//session.setAttribute("tienda", null);
				//session.setAttribute("cajasDTO", null);
				session.setAttribute("listaLineas", null);
				session.setAttribute("clienteRegistrado", null);
				session.setAttribute("listaStructura", null);
				session.setAttribute("categorias", null);
				session.setAttribute("regiones", null);
				session.setAttribute("tiposIdentificacion",null);
				session.setAttribute("pagoDTO", null);	
				session.setAttribute("totalVO", null);	
				session.setAttribute("listaAccesorios", null);
				session.setAttribute("listaKit", null);
				session.setAttribute("codPrestacion", null);
			}
			else{

				//Creo un cliente vacio para iniciar el registro
				DireccionDTO direccionDTO = new DireccionDTO();
				DatosClienteDTO clienteDTO = new DatosClienteDTO();
				clienteDTO.setCliente(new ClienteDTO());
				request.setAttribute("cliente",clienteDTO);
				request.setAttribute("direccion",direccionDTO);
				request.setAttribute("clienteCuenta",clienteDTO.getCliente());
				request.setAttribute("codPrestacion",form.getCodPrestacion());
				
				//INICIO CSR-11002
				session.setAttribute("codPrestacion",form.getCodPrestacion());
				//FIN CSR-11002
				
				//Listado Categoria
				//GetListCategorias getListCategorias = new GetListCategorias();
				
				WsListadoCategoriasClienteOutDTO categoriasClienteOutDTO = port.getListCategorias();
				
				if(!"0".equals(categoriasClienteOutDTO.getCodError())){
					logger.error("Error: "+ categoriasClienteOutDTO.getMensajseError());
					request.setAttribute("desError",categoriasClienteOutDTO.getMensajseError());
					target="globalError";
					return mapping.findForward(target);
				}
				
				com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClienteDTO[] categoriasTmp = categoriasClienteOutDTO.getClienteDTOs();
				
				com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClienteDTO[] categorias = new com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClienteDTO[1]; 
				
				if(categoriasTmp != null){
					
					for (int i = 0; i < categoriasTmp.length; i++) {
						com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClienteDTO clienteDTO2 = categoriasTmp[i];
						
						if(config.getString("cod.categoria.prepago").equals(clienteDTO2.getCodigoCategoria())){
							
							categorias[0] = clienteDTO2;
						}
					}
				}
				
				session.setAttribute("categorias", categorias);
				
				//Listado Regiones 
				//GetListadoRegiones getListadoRegiones = new GetListadoRegiones();
				WsListadoRegionesOutDTO regionesOutDTO = port.getListadoRegiones();
				
				
				
				if(!"0".equals(regionesOutDTO.getCodError())){
					logger.error("Error: "+ regionesOutDTO.getMensajseError());
					request.setAttribute("desError",regionesOutDTO.getMensajseError());
					target="globalError";
					return mapping.findForward(target);
				}
				session.setAttribute("regiones", regionesOutDTO.getRegionDTOs());
				
				//Listado Tipos Identificación 
				//GetTiposIdentificacion getTiposIdentificacion = new GetTiposIdentificacion();
				WsListadoTiposIdentificacionOutDTO identificacionOutDTO = port.getTiposIdentificacion();	
				
				if(!"0".equals(identificacionOutDTO.getCodError())){
					logger.error("Error: "+ identificacionOutDTO.getMensajseError());
					request.setAttribute("desError",identificacionOutDTO.getMensajseError());
					target="globalError";
					return mapping.findForward(target);
				}
				
				session.setAttribute("tiposIdentificacion",identificacionOutDTO.getIdentificadorCivilDTOs() );
				
				//P-CSR-11002 INI-01 - Listado Categorias Cambio.
				String strAplicaCategCambio = aplicarCategoriaCambio();
				if(strAplicaCategCambio.equals("1")){

					WsListadoCategoriaCambioDTO categoriasCambioOutDTO = port.getCategoriasCambio();

					if(!"0".equals(categoriasCambioOutDTO.getCodError())){
						logger.error("Error: "+categoriasCambioOutDTO.getMensajseError());
						request.setAttribute("desError", categoriasCambioOutDTO.getMensajseError());
						target="globalError";
						return mapping.findForward(target);
					}
					
					session.setAttribute("categoriasCambio", categoriasCambioOutDTO.getCategoriaCambioDTO());
				} else {
					if (strAplicaCategCambio.equals("-1")){
						logger.error("Error al obtener valor de properties: aplica.categoria.cambio");
						request.setAttribute("desError", "Error al obtener valor de properties: aplica.categoria.cambio");
						target="globalError";
						return mapping.findForward(target);
					}
				}

				request.setAttribute("flgAplicaCategoriaCambio",strAplicaCategCambio);				
				//P-CSR-11002 FIN-01				
				
				//inicio CSR-11002
				WsDatosDireccionOutDTO datosDireccion = port.getDatosDireccion(null);
				
				if(!"0".equals(datosDireccion.getCodError())){
					logger.error("Error: "+ datosDireccion.getMensajseError());
					request.setAttribute("desError",datosDireccion.getMensajseError());
					target="globalError";
					return mapping.findForward(target);
				}
				
				//anulamos si es que existe la coleccion de campos de direccion
				//cuando se busca un cliente
				session.setAttribute("datosDireccion2",null );
				
				//se setea coleccion de campos de direccion cuando el cliente es nuevo
				session.setAttribute("datosDireccion",datosDireccion );
				
				//obtener las clasificaciones
				WsClasificacionOutDTO clasificacionOutDTO = port.getClasificaciones();
				
				if(!"0".equals(clasificacionOutDTO.getCodError())){
					logger.error("Error: "+ clasificacionOutDTO.getMensajseError());
					request.setAttribute("desError",clasificacionOutDTO.getMensajseError());
					target="globalError";
					return mapping.findForward(target);
				}
				
				ClasificacionDTO[] clasificaciones = clasificacionOutDTO.getClasificaciones();
				
				//obtener las crediticias
				WsCrediticiaOutDTO crediticiaOutDTO = port.getCrediticia();
				
				if(!"0".equals(crediticiaOutDTO.getCodError())){
					logger.error("Error: "+ crediticiaOutDTO.getMensajseError());
					request.setAttribute("desError",crediticiaOutDTO.getMensajseError());
					target="globalError";
					return mapping.findForward(target);
				}
				
				ValorClasificacionDTO[] crediticias = crediticiaOutDTO.getCrediticias();
				
				//recorro estas clasificaciones para encontrar el de crediticia y determinar
				//si es visible y si se muestran todas las clasificaciones o solo la por defecto
				
				for (int i = 0; i < clasificaciones.length; i++) {
					ClasificacionDTO clasificacion = clasificaciones[i];
					
					if (clasificacion.getCodElemento().equalsIgnoreCase(config.getString("codigo.clasificacion.crediticia"))){
						
						logger.debug("clasificacion.getIndVisible(): " + clasificacion.getIndVisible());
						//determina si es visible o invisible el campo crediticia
						if(clasificacion.getIndVisible()==1){
						
							session.setAttribute("flagCtrlClasifCrediticia", 1);
						}else{
							session.setAttribute("flagCtrlClasifCrediticia", 0);
						}
						
						if(clasificacion.getIndActivo()==0)	{
							//crediticia por defecto
							ValorClasificacionDTO[] arrayCrediticiaDefecto = new ValorClasificacionDTO[1];
							
							for(int j=0; j<crediticias.length;j++){
								if (crediticias[j].getIndDefecto()==1){
									arrayCrediticiaDefecto[0] = crediticias[j];
									break;
								}
							}
							
							session.setAttribute("crediticias", arrayCrediticiaDefecto);
							
						}else{
							//se muestran todos los valores para crediticia
							session.setAttribute("crediticias", crediticias);
							
						}
					}
				}
				
				//fin CSR-11002
				
				//Levanto session de pago
				WsStructuraPagoDTO structuraPagoDTO = new WsStructuraPagoDTO();
				structuraPagoDTO.setCodBanco(form.getCodBanco());
				structuraPagoDTO.setCodCajaQuiosco(tienda.getCodCaja());
				structuraPagoDTO.setNumDocumento(form.getNumDocumento());
				structuraPagoDTO.setNumCuentaCorriente(form.getNumCuentaCorriente());
				structuraPagoDTO.setNumTarjetaCredito(form.getNumTarjetaCredito());
				structuraPagoDTO.setSistemaPago(form.getSistemaPago().split("#")[0]);
				structuraPagoDTO.setAplicapago("1".equals(tienda.getIndApliPAgo().trim()));
				structuraPagoDTO.setCodTipTarjeta(limpiarValor(form.getCodTipTarjeta())); // CSR-11002
				session.setAttribute("pagoDTO", structuraPagoDTO);	
				target="formularioCliente";
			}
			
		}						
				
		totalVO.setItbmRound(new BigDecimal(String.valueOf(totalVO.getItbm() )).setScale(4,BigDecimal.ROUND_HALF_DOWN));
		logger.error("String.valueOf(totalVO.getIsc()): "+String.valueOf(totalVO.getIsc()));
		totalVO.setIscRound(new BigDecimal(String.valueOf(totalVO.getIsc())).setScale(4,BigDecimal.ROUND_HALF_DOWN));
		logger.error("totalVO.getIscRound(): "+totalVO.getIscRound());
		totalVO.setSubTotalRound(new BigDecimal(String.valueOf(totalVO.getSubTotal())).setScale(4,BigDecimal.ROUND_HALF_DOWN));
		
		BigDecimal total = totalVO.getSubTotalRound().add(totalVO.getItbmRound()).add(totalVO.getIscRound());
		totalVO.setTotal(total);
		
		totalVO.setTotalRound(new BigDecimal(String.valueOf(totalVO.getTotal())).setScale(2,BigDecimal.ROUND_FLOOR));
							
		logger.error("TOTAL: "+totalVO.getTotal());
		
		session.setAttribute("totalVO", totalVO);	
		session.setAttribute("listaLineas", listaLineas);
		session.setAttribute("listaAccesorios", listaAccesorios);
		session.setAttribute("listaKit", listaKit);
				
		}catch(Exception e){
			logger.error("Error Inesperado: "+ e.getMessage());
			e.printStackTrace();
			request.setAttribute("desError","Error Inesperado.");
			target="globalErrorInesperado";
			return mapping.findForward(target);
		}
		logger.error("inicio:ActionForward()");
		return mapping.findForward(target);
	
	}
	
	/*
	 * Metodo para valida que la serie no se repita
	 */
	private  String validarSerieRepetida(String numSerie, ArrayList<LineaVO> listaLineas, ArrayList<AccesorioVO> listaAccesorios,ArrayList<KitVO> listaKit){
		String error = "OK";
		//Busco la serie en la lista de Lineas
		for(int i=0;i<=listaLineas.size()-1;i++){
			if(numSerie.trim().equals(listaLineas.get(i).getSimcard())){
				error="Serie ingresada es una SIMCARD ya agregada a la venta";
				break;
			}
			else if(numSerie.trim().equals(listaLineas.get(i).getImei())){
				error="Serie ingresada es una IMEI ya agregada a la venta";
				break;
			}
		}
		
		logger.error("+++++++++++++++++++++++++++++++++++++++++++INICIO MODIFICACION+++++++++++++++++++++++++++++++++++++++++++");
		//Busco la serie en la lista de accesorios
		logger.error("listaAccesorios.size(): "+listaAccesorios.size());
		for(int i=0;i<=listaAccesorios.size()-1;i++){
			if(numSerie.trim().equals(listaAccesorios.get(i).getSerie())){
				error="Serie ingresada es un ACCESORIO ya agregado a la venta";
				break;
			}	
			logger.error("ANTES PREGUNTAR NUMERO DE ARTIVCULO");
			logger.error("numSerie.trim(): "+numSerie.trim());
			if(!"1173".equals(numSerie.trim())){
				logger.error("listaAccesorios.get(i).getCodigo(): "+listaAccesorios.get(i).getCodigo());
				if(listaAccesorios.get(i).getCodigo().equals("1173")){
					error="Después de ingresar una recarga no puede ingresar más datos a la venta";
					break;
				}
			}
		}
		logger.error("+++++++++++++++++++++++++++++++++++++++++++FIN MODIFICACION+++++++++++++++++++++++++++++++++++++++++++");
		
		//Busco la serie en la lista de kit
		for(int i=0;i<=listaKit.size()-1;i++){
			if(numSerie.trim().equals(listaKit.get(i).getNumeroKit())){
				error="Serie ingresada es un KIT ya agregado a la venta";
				break;
			}
		}
		
		
		
		return error;
	}
	
	/**
	 * P-CSR-11002
	 * @param datosTributariosForm
	 *            Se configura en la operadora mostrar o no los campos de categoria de cambio. Se establece valor por
	 *            defecto de cat. de cambio, tabla: FA_TASA_CAMBIO_TD, columna: COD_CATEGORIA_CAMBIO.
	 */
	private String aplicarCategoriaCambio() {
		String strAplicaCategoriaCambio = "0";

			strAplicaCategoriaCambio = config.getString("aplica.categoria.cambio");
			logger.error("valorAplicaCategoriaCambio: " + strAplicaCategoriaCambio);
		if (null == strAplicaCategoriaCambio) {
			strAplicaCategoriaCambio = "-1";
			logger.error("Error al obtener valor de properties: " + "aplica.categoria.cambio");
		}
		return strAplicaCategoriaCambio;
	}
	
	/**
	 * permite limpiar el valor que se va a negocio
	 * @param region
	 * @return
	 */
	private String limpiarValor(String pValor) {

		String result = "";
		
		if(pValor == null){
			return pValor;
		}
		
		//si es un combo no obligatorio, envio nulo en ese valor
		if("seleccione".equals(pValor.trim())){
			return result;
		}
		
		return pValor.trim();
	}
}