package com.tmmas.scl.operations.crm.fab.cusintman.web.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.ProductDomain.dto.SerieDTO; //  RRG 23-09-2008 COL 70904
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioTerminalDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CargosObtenidosDTO;  // RRG 23-09-2008 COL 70904
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.SimcardDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.TerminalDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.CambioSerieBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cusintman.web.form.CambioDeSerieForm;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Global;
import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException;
import com.tmmas.scl.vendedor.dto.VendedorDTO;

import com.tmmas.scl.framework.commonDoman.exception.FrmkCargosException; // RRG 10-07-2009 COL 96723
import com.tmmas.cl.framework.exception.GeneralException;				  // RRG 10-07-2009 COL 96723
public class RecalcularCambSeriAction extends BaseAction{
	private Global global = Global.getInstance();
	private CambioSerieBussinessDelegate delegate =CambioSerieBussinessDelegate.getInstance();
	private final Logger logger = Logger.getLogger(RecalcularCambSeriAction.class);
	private String textoMensajeRestricciones;
	protected ActionForward executeAction(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {	
		HttpSession session = request.getSession(false);
		CambioDeSerieForm cambioDeSerieForm = (CambioDeSerieForm)session.getAttribute("CambioDeSerieForm");
		ClienteOSSesionDTO sessionData =null;  // RRG 23-09-2008 COL 70904
		boolean isErrorSerieSimcard=true; // RRG 23-09-2008 COL 70904
		UsuarioAbonadoDTO usuarioAbonado=null; // RRG 23-09-2008 COL 70904
		String montoTerminal="0.0"; // RRG 23-09-2008 COL 70904
		VendedorDTO vendedor = null;
		try{


			sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
			logger.debug("Cod Cliente: " + sessionData.getCodCliente());
//			ClienteOSSesionDTO sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS"); // RRG 23-09-2008 COL 70904
			sessionData.setCodActAboCargosUso(global.getValor("ACT_CAMBIOSERIE"));
			sessionData.setTipoPantallaPrevia("2");
			usuarioAbonado=(UsuarioAbonadoDTO)session.getAttribute("usuarioAbonado");
//			UsuarioAbonadoDTO usuarioAbonado=(UsuarioAbonadoDTO)session.getAttribute("usuarioAbonado"); // RRG 23-09-2008 COL 70904
			sessionData.setCargosObtenidos(null);//Limpieza de Cargos
			ArrayList listaCargos=new ArrayList();
			ParametrosObtencionCargosDTO paramObtCargos = new ParametrosObtencionCargosDTO();
			vendedor = (VendedorDTO)session.getAttribute("Vendedor");
			if (vendedor.getCod_vendealer()!=null && !vendedor.getCod_vendealer().equals("")) {
				paramObtCargos.setIndicadorTipoVenta(0);
			} else {
				paramObtCargos.setIndicadorTipoVenta(1);
			}
			
			
			logger.debug("Usuario: " + sessionData.getUsuario());
			paramObtCargos.setNombreUsuario(sessionData.getUsuario());
			
			long codCliente= sessionData.getCliente().getCodCliente();
			paramObtCargos.setCodigoClienteOrigen(String.valueOf(codCliente));
			paramObtCargos.setCodigoClienteDestino(String.valueOf(codCliente));
			paramObtCargos.setCodigoModalidadVenta(sessionData.getModalidad());
			//paramObtCargos.setTipoContrato(sessionData.getTipoContrato());
			// Recupero el plan tarifario desde el abonado
			//	ini-Proyecto p-mix-09003 OCB; 	
			paramObtCargos.setNumOsRenova(sessionData.getParamRenova());
			paramObtCargos.setOrdenServicio(String.valueOf(sessionData.getCodOrdenServicio()));
			//	fin-Proyecto p-mix-09003 OCB; 
			
			paramObtCargos.setCodigoPlanTarifOrigen(sessionData.getAbonados()[0].getCodPlanTarif());
			paramObtCargos.setCodigoPlanTarifDestino(sessionData.getAbonados()[0].getCodPlanTarif());
			logger.debug("codigo tipo Plan tarif: " + sessionData.getAbonados()[0].getCodTipoPlanTarif());
			paramObtCargos.setEstadoSimcard("7");
			paramObtCargos.setCodUso(String.valueOf(cambioDeSerieForm.getUsoVentaSim()));
			paramObtCargos.setCodArticulo(String.valueOf(cambioDeSerieForm.getCod_articulo()));
			paramObtCargos.setTipoStock(String.valueOf(cambioDeSerieForm.getTip_stock()));
//			 Creo la coleccion de abonados
			String[] codAbonado =new String [1];
			codAbonado[0]=String.valueOf(sessionData.getNumAbonado());
			paramObtCargos.setAbonados(codAbonado);
			String codTipContrato= cambioDeSerieForm.getTipoContrato();
			logger.debug("RECALCULAR.formBeanCambioSerie.getTipoContrato(): " + cambioDeSerieForm.getTipoContrato()); // INC-79469; COL; 10-03-2009; AVC
			paramObtCargos.setTipoContrato(cambioDeSerieForm.getTipoContrato()); // INC-79469; COL; 10-03-2009; AVC
			
			codTipContrato=codTipContrato==null||"".equals(codTipContrato)?"0":codTipContrato.trim();
			paramObtCargos.setNumeroMesesContrato(Integer.parseInt(cambioDeSerieForm.getTipoContrato().trim()));
			paramObtCargos.setIndCiclo(cambioDeSerieForm.getTipoContrato().equals("0")?"0":"1");

			paramObtCargos.setCodCausaCambioPlan(cambioDeSerieForm.getCausaCambio());
			
			ObtencionCargosDTO obtencionCargosSimcard = null;
//			ObtencionCargosDTO obtencionCargosSimcard = new ObtencionCargosDTO(); // RRG 23-09-2008 COL 70904
			
//			Si existe cambio de Simcard 
			
			
			String numSimcard=cambioDeSerieForm.getNroSerieSim()==null?"":cambioDeSerieForm.getNroSerieSim().trim();
			if (cambioDeSerieForm.getFlagBloqueo().equals("1")&&!"".equals(numSimcard)){
				paramObtCargos.setTipoPantalla("6");
				paramObtCargos.setNumSerieSimcard(numSimcard);
				SimcardDTO simcardDTO=new SimcardDTO();
				simcardDTO.setNumeroSerie(numSimcard);
				simcardDTO=delegate.obtenerSimcard(simcardDTO);
				//TODO : verificamos aplicamos cargos si tipo stock es distinto de 4 "dealer"
				if (!simcardDTO.getTipoStock().equals(global.getValor("parametro.mercaderia.dealer"))){
					obtencionCargosSimcard=delegate.obtencionCargos(paramObtCargos);
					if (obtencionCargosSimcard.getCargos()!=null && obtencionCargosSimcard.getCargos().length>0){
						logger.debug("codigoSimcard : "+obtencionCargosSimcard.getCargos()[0].getPrecio().getCodigoConcepto());
						session.setAttribute("codigoSimcard", obtencionCargosSimcard.getCargos()[0].getPrecio().getCodigoConcepto());
					}
				}
			}
			
			if (obtencionCargosSimcard!=null&&obtencionCargosSimcard.getCargos()!=null&&obtencionCargosSimcard.getCargos().length>0){
				for(int i=0;i<obtencionCargosSimcard.getCargos().length;i++){
					listaCargos.add(obtencionCargosSimcard.getCargos()[i]);
				}
			}
			isErrorSerieSimcard=false; // RRG 23-09-2008 COL 70904
			
//			
			
			/***
			 * @author rlozano
			 * @description Cargos obtenidos a traves de la causa seleccionada en pantalla inicial
			 *  			se debe setear en la misma lista de cargos para no alterar la estructura.
			 */
			
			String codigoCausa=cambioDeSerieForm.getCausaCambio();
			codigoCausa=codigoCausa==null?"":codigoCausa.trim();
			
			//TODO:buscamos el valor de la causa garantia en la ged parametros.*/
			 
			ParametroDTO parametro=new ParametroDTO();
			parametro.setCodModulo(global.getValor("MODULO"));
			parametro.setCodProducto(Integer.parseInt(global.getValor("parametro.producto.uno")));
			parametro.setNomParametro(global.getValor("parametro.causa.garantia"));
			parametro=delegate.obtenerParametroGeneral(parametro);
			boolean isAplicaGarantia=codigoCausa.equals(parametro.getValor())?true:false;
			
			
			//Inicio INC 183867 - 10/04/2012 - FADL
			//(+) EV 13/07/2010, no aplica garantia para prepagos
			//logger.debug("cambioDeSerieForm.getUsoVentaEquip()="+cambioDeSerieForm.getUsoVentaEquip());
			
			//if (cambioDeSerieForm.getUsoVentaEquip().equals(global.getValor("codigo.uso.prepago").trim())){
				//isAplicaGarantia = false;
				//logger.debug("NO APLICA GARANTIA");
			//}
			//(-) EV 13/07/2010
			//Fin INC 183867 - 10/04/2012 - FADL
			
			AbonadoDTO abonado =new AbonadoDTO();
			abonado=sessionData.getAbonados()[0];
			//tenologia del Abonado
			String codTecnologia=abonado.getCodTecnologia();
			codTecnologia=codTecnologia==null?"":codTecnologia;
			//TODO : en el DAO se setea en este parametro el IMEI debido a q el objeto del PL crea el campo Simcard en lugar de imei
			String numSerieTermAnt=abonado.getSimCard();
			/*******/
			
			
			/*********/
			parametro.setNomParametro(global.getValor("parametro.grupo.tecnologico.gsm"));
			/*********/
			parametro=delegate.obtenerParametroGeneral(parametro);
			String paramTechGSM=parametro.getValor();
			paramTechGSM=paramTechGSM==null?"":paramTechGSM;
			
			if (!codTecnologia.equals(paramTechGSM)){
				numSerieTermAnt=abonado.getNumSerie();
			}
			numSerieTermAnt=numSerieTermAnt==null?"":numSerieTermAnt;
			
			logger.debug("Numero serie Ant ::"+numSerieTermAnt);
			String numSerieTermWeb=cambioDeSerieForm.getNroSerieEquip();
			numSerieTermWeb=numSerieTermWeb==null?"":numSerieTermWeb;
			TerminalDTO terminalDTOAnt =new TerminalDTO();
			terminalDTOAnt.setNumeroSerie(numSerieTermAnt);
			//terminalDTOAnt=delegate.obtenerTerminal(terminalDTOAnt);
			terminalDTOAnt.setCodigoArticulo(String.valueOf(usuarioAbonado.getCodArtEquipo()));
			TerminalDTO terminalDTONewWeb =new TerminalDTO();
			terminalDTONewWeb.setNumeroSerie(numSerieTermWeb);
			terminalDTONewWeb=delegate.obtenerTerminal(terminalDTONewWeb);
			
		
			
			// Si el codigo del articulo de la serie nueva es distinto al código de articulo de la serie actual y la procedencia
			// del articulo es interna
			
			boolean isInterno="I".equals(cambioDeSerieForm.getProcedNuevoEquipo())?true:false;
			ObtencionCargosDTO obtencionCargosTerminalNewWeb	= null;
//			ObtencionCargosDTO obtencionCargosTerminalNewWeb	= new ObtencionCargosDTO(); RRG
			if (isInterno &&!terminalDTONewWeb.getTipoStock().equals(global.getValor("parametro.mercaderia.dealer"))){
				String codArticuloAnt=terminalDTOAnt.getCodigoArticulo();
				codArticuloAnt=codArticuloAnt==null?"":codArticuloAnt;
				
				String codArticuloNewWeb=terminalDTONewWeb.getCodigoArticulo();
				codArticuloNewWeb=codArticuloNewWeb==null?"":codArticuloNewWeb;
				
			//if (!codArticuloAnt.equals(codArticuloNewWeb)){ // RRG 23-09-2008 70904
				boolean codDist=!codArticuloAnt.equals(codArticuloNewWeb);	 // RRG 23-09-2008 70904
				logger.debug("La variable codDist es "+codDist);
					
					
					//TODO : Luego evaluamos el ind_valorar del equipo actual 
					String indValorar=terminalDTONewWeb.getIndicadorValorar();
					indValorar=indValorar==null?"0":indValorar.trim();
					
					logger.debug("La variable indValorar es "+indValorar);
					logger.debug("La variable isAplicaGarantia es "+isAplicaGarantia);
					
					if (codDist&&Integer.parseInt(indValorar)>0&&isAplicaGarantia){
//					if (Integer.parseInt(indValorar)>0&&isAplicaGarantia){ RRG 23-09-2008 70904
//						TODO : Obtenemos el valor del euqipo nuevo a través de la regla de obtencion de cargos
						logger.debug("Prueba Felipe Diaz 19-04-2012");
						String montoTerminalNewWeb="0.0";
						//if (cambioDeSerieForm.getFlagBloqueoEquipo().equals("1")&&!"".equals(numEquipo)){
						if (cambioDeSerieForm.getFlagBloqueoEquipo().equals("1")){
							paramObtCargos.setTipoPantalla("8");
							paramObtCargos.setCodArticulo(terminalDTONewWeb.getCodigoArticulo());
							paramObtCargos.setNumImei(terminalDTONewWeb.getNumeroSerie());
							paramObtCargos.setNumSerieSimcard(terminalDTONewWeb.getNumeroSerie());
							//Se asume q el usuario siempre ira a un GSM
							paramObtCargos.setCodigoTecnologia(codTecnologia);
//							paramObtCargos.setCodigoTecnologia(paramTechGSM); RRG 23-09-2008 70904
							
							obtencionCargosTerminalNewWeb=delegate.obtencionCargos(paramObtCargos);
							if (obtencionCargosTerminalNewWeb.getCargos()!=null && obtencionCargosTerminalNewWeb.getCargos().length>0){
								montoTerminalNewWeb=String.valueOf(obtencionCargosTerminalNewWeb.getCargos()[0].getPrecio().getMonto());
								logger.debug("codigoTerminal : "+obtencionCargosTerminalNewWeb.getCargos()[0].getPrecio().getCodigoConcepto());
								session.setAttribute("codigoTerminal", obtencionCargosTerminalNewWeb.getCargos()[0].getPrecio().getCodigoConcepto());
							}
						}
//						TODO : obtenemos  el valor del equipo actual/ant en la tabla historica de facturacion / ge_cargos
						PrecioTerminalDTO precioTerminalDTOAnt=delegate.obtenerPrecioEquipoActual(terminalDTOAnt);
						
						
//						TODO : Comparamos los valores de ambos terminales
						if (Float.parseFloat(montoTerminalNewWeb)>precioTerminalDTOAnt.getMonto()&&isAplicaGarantia){
							float diffTerminal=Float.parseFloat(montoTerminalNewWeb)-precioTerminalDTOAnt.getMonto();
							//TODO : Obtenemos el concepto facturable con el parametro CONCEPTO_DIF_GARANTI 
							parametro.setNomParametro(global.getValor("concepto.diferencia.garantia"));
							RetornoDTO retValue=delegate.verificaConcFactGarantia(parametro);
							if (retValue.isResultado()){
								parametro=delegate.obtenerParametroGeneral(parametro);
								if (obtencionCargosTerminalNewWeb.getCargos()!=null && obtencionCargosTerminalNewWeb.getCargos().length>0){
									obtencionCargosTerminalNewWeb.getCargos()[0].setDescuento(null);
									obtencionCargosTerminalNewWeb.getCargos()[0].getPrecio().setCodigoConcepto(parametro.getValor());
									obtencionCargosTerminalNewWeb.setMonto(diffTerminal);
									obtencionCargosTerminalNewWeb.getCargos()[0].getPrecio().setMonto(diffTerminal);
									listaCargos.add(obtencionCargosTerminalNewWeb.getCargos()[0]);
									//System.err.println(":::::Codigo simcard :::: "+obtencionCargosTerminalNewWeb);
									logger.debug(":::::Codigo simcard :::: "+obtencionCargosTerminalNewWeb);
								}
							}
							else{
								throw new CusIntManException("No se encontró concepto facturable para la garantía");
							}
							montoTerminal=montoTerminalNewWeb; //RRG 23-09-2008 70904
							
						}
						
					}
					else if (!isAplicaGarantia&&cambioDeSerieForm.getFlagBloqueoEquipo().equals("1")) {
//					else if (cambioDeSerieForm.getFlagBloqueoEquipo().equals("1")){ RRG 23-09-2008 70904
							paramObtCargos.setTipoPantalla("8");
							paramObtCargos.setCodArticulo(terminalDTONewWeb.getCodigoArticulo());
							paramObtCargos.setNumImei(terminalDTONewWeb.getNumeroSerie());
							paramObtCargos.setNumSerieSimcard(terminalDTONewWeb.getNumeroSerie());
							//Se asume q el usuario siempre ira a un GSM
							paramObtCargos.setCodigoTecnologia(codTecnologia);
							paramObtCargos.setOperacion(global.getValor("ACT_CAMBIOSERIE")); // CE  // INC-79469; COL; 10-03-2009; AVC
//							paramObtCargos.setCodigoTecnologia(paramTechGSM); RRG 23-09-2008 70904
							obtencionCargosTerminalNewWeb=delegate.obtencionCargos(paramObtCargos);
							if(obtencionCargosTerminalNewWeb.getCargos() !=null && obtencionCargosTerminalNewWeb.getCargos().length >0)
							{
								logger.debug("codigoTerminal : "+obtencionCargosTerminalNewWeb.getCargos()[0].getPrecio().getCodigoConcepto());
								session.setAttribute("codigoTerminal", obtencionCargosTerminalNewWeb.getCargos()[0].getPrecio().getCodigoConcepto());
								for(int i=0;i<obtencionCargosTerminalNewWeb.getCargos().length;i++){
									listaCargos.add(obtencionCargosTerminalNewWeb.getCargos()[i]);
//									montoTerminal=String.valueOf(obtencionCargosTerminalNewWeb.getCargos()[i].getPrecio().getMonto()); //RRG 23-09-2008 70904
								}
							}


							//listaCargos.add(obtencionCargosTerminalNewWeb.getCargos());
						
						
					}
					//Inicio Inc. 183867 - 19/04/2012 - FADL 
					else if(!codDist&&Integer.parseInt(indValorar)>0&&isAplicaGarantia){
						
						if (cambioDeSerieForm.getFlagBloqueoEquipo().equals("1")){
							String montoTerminalNewWeb;
							float precioEquipoNewWeb = (float) 0.00;
							paramObtCargos.setTipoPantalla("8");
							paramObtCargos.setCodArticulo(terminalDTONewWeb.getCodigoArticulo());
							paramObtCargos.setNumImei(terminalDTONewWeb.getNumeroSerie());
							paramObtCargos.setNumSerieSimcard(terminalDTONewWeb.getNumeroSerie());
							paramObtCargos.setCodigoTecnologia(codTecnologia);
							
							obtencionCargosTerminalNewWeb=delegate.obtencionCargos(paramObtCargos);
							if (obtencionCargosTerminalNewWeb.getCargos()!=null && obtencionCargosTerminalNewWeb.getCargos().length>0){
								montoTerminalNewWeb=String.valueOf(obtencionCargosTerminalNewWeb.getCargos()[0].getPrecio().getMonto());
								logger.debug("El valor del equipo es "+montoTerminalNewWeb);
								logger.debug("codigoTerminal : "+obtencionCargosTerminalNewWeb.getCargos()[0].getPrecio().getCodigoConcepto());
								session.setAttribute("codigoTerminal", obtencionCargosTerminalNewWeb.getCargos()[0].getPrecio().getCodigoConcepto());
								for(int i=0;i<obtencionCargosTerminalNewWeb.getCargos().length;i++){
									logger.debug("Se inserta precio cero");
									obtencionCargosTerminalNewWeb.getCargos()[0].getPrecio().setMonto(precioEquipoNewWeb);
									listaCargos.add(obtencionCargosTerminalNewWeb.getCargos()[i]);
//									montoTerminal=String.valueOf(obtencionCargosTerminalNewWeb.getCargos()[i].getPrecio().getMonto()); //RRG 23-09-2008 70904
								}
							}
						}
					}	
					//Fin Inc. 183867 - 19/04/2012 - FADL 
									//}
				}
			
			CargosDTO[] cargos=(CargosDTO[])ArrayUtl.copiaArregloTipoEspecifico(listaCargos.toArray(), CargosDTO.class);
//			if (cargos.length<1){
				//throw new Exception();
//			}
			CargosObtenidosDTO cargosObtenidosDTO=new CargosObtenidosDTO();
			if (obtencionCargosTerminalNewWeb!=null){ //RRG 23-09-2008 70904
			obtencionCargosTerminalNewWeb.setCargos(cargos);
} //RRG 23-09-2008 70904
			cargosObtenidosDTO.setOcacionales(obtencionCargosTerminalNewWeb);
			sessionData.setCargosObtenidos(cargosObtenidosDTO);
			session.setAttribute("montoTerminal", montoTerminal); // RRG 23-09-2008 70904
		
		
		} //catch (Exception e){ // RRG 10-07-2009 COL 96723
		catch (	GeneralException e){

			logger.debug("e.getMessage: " + e.getMessage()); // RRG COL 07-07-2009 96723
			logger.debug("e.getCause: " + e.getCause());	 // RRG COL 07-07-2009 96723
			logger.debug("e.getCodigo: " + e.getCodigo());	 // RRG COL 07-07-2009 96723
			logger.debug("e.getCodigoEvento: " + e.getCodigoEvento());	 // RRG COL 07-07-2009 96723
			logger.debug("e.getDescripcionEvento: " + e.getDescripcionEvento());	 // RRG COL 07-07-2009 96723
			
			StringBuffer layout = new StringBuffer();
// INICIO RRG 23-09-2008 70904
			logger.debug("Exception Cargos Action se procede a cambiar estado de la serie solicitada a disponible para reserva");
			SerieDTO serie = new SerieDTO();
			
			String serieEquipo=cambioDeSerieForm.getNroSerieEquip();
			serieEquipo=serieEquipo==null?"":serieEquipo;
			logger.debug("Serie Equipo ::"+serieEquipo);
			serie.setNum_serie(serieEquipo);
			TerminalDTO terminalDTO =new TerminalDTO();
			if (!"".equals(serieEquipo)){
					
				delegate.desReservaSerie(serie);
				terminalDTO =new TerminalDTO();
				terminalDTO.setNumeroSerie(serieEquipo);
				terminalDTO=delegate.obtenerTerminal(terminalDTO);
			}
			 String serieSimcard=cambioDeSerieForm.getNroSerieSim();
			 serieSimcard=serieSimcard==null?"":serieSimcard;
			 serie.setNum_serie(serieSimcard);
			 
			 SimcardDTO simcardDTO=new SimcardDTO();
			if (!"".equals(serieSimcard)){
				delegate.desReservaSerie(serie);
				
				simcardDTO.setNumeroSerie(serieSimcard);
				simcardDTO=delegate.obtenerSimcard(simcardDTO);
			}
			PlanTarifarioDTO planTarif=new PlanTarifarioDTO();
			String planT=usuarioAbonado.getCodPlantarif();
			planT=planT==null?"":planT.trim();
			planTarif.setCodPlanTarif(planT);
			planTarif=delegate.getCategoriaPlanTarifario(planTarif);
			String codArticulo=isErrorSerieSimcard?simcardDTO.getCodigoArticulo():terminalDTO.getCodigoArticulo();
			codArticulo=codArticulo==null?"":codArticulo;
			String numSerie=isErrorSerieSimcard?simcardDTO.getNumeroSerie():terminalDTO.getNumeroSerie();
			numSerie=numSerie==null?"":numSerie;
			String codUso=isErrorSerieSimcard?simcardDTO.getCodigoUso():terminalDTO.getCodigoUso();
			codUso=codUso==null?"":codUso;
			String tipoStock=isErrorSerieSimcard?simcardDTO.getTipoStock():terminalDTO.getTipoStock();
			tipoStock=tipoStock==null?"":tipoStock;
			String codCategoria=planTarif.getCodigoCategoria();
			codCategoria=codCategoria==null?"":codCategoria;
			String codEstado=isErrorSerieSimcard?(String)session.getAttribute("codEstAntS"):(String)session.getAttribute("codEstAntT");
			codEstado=codEstado==null?"":codEstado;
//FIN RRG 23-09-2008 70904			
			textoMensajeRestricciones="No existen tarifas para el equipo seleccionado. " +
			"No es posible llevar a cabo la transacción con el módulo de cargos, " +
			"favor verificar que exista la siguiente información:" ;
			
			layout.append("<table width='100%'>");
			layout.append("<tr>");
			layout.append("<td align='center'>" + textoMensajeRestricciones + "</td>");
			layout.append("</tr>");
			layout.append("<tr>");
			layout.append("<td align='center'>");
			layout.append("<table style='font-style:verdana; font-size: 8pt;width:400px'>");
			layout.append("<tr>");
			layout.append("<td class='textoColumnaTabla'>Producto</td>");
			layout.append("<td class='textoFilasTabla'>1</td>");
			layout.append("</tr>");
			layout.append("<tr>");
			layout.append("	<td class='textoColumnaTabla'>Código de Artículo</td>");
			layout.append("<td class='textoFilasTabla'>" + codArticulo+ "</td>");
//			layout.append("<td class='textoFilasTabla'>" + cambioDeSerieForm.getCod_articulo() + "</td>"); //RRG 23-09-2008 70904
			layout.append("</tr>");
			layout.append("<tr>");
			layout.append("<td class='textoColumnaTabla'>Número de Serie</td>");
			layout.append("<td class='textoFilasTabla'>" + numSerie + "</td>");
//			layout.append("<td class='textoFilasTabla'>" + cambioDeSerieForm.getNroSerieEquip() + "</td>"); //RRG 23-09-2008 70904
			layout.append("</tr>");
			layout.append("<tr>");
			layout.append("<td class='textoColumnaTabla'>Código Uso</td>"); //RRG 23-09-2008 70904
			layout.append("<td class='textoFilasTabla'>" + codUso + "</td>"); //RRG 23-09-2008 70904
			layout.append("</tr>"); //RRG 23-09-2008 70904
			
			layout.append("<tr>");
			layout.append("<td class='textoColumnaTabla'>Tipo Stock</td>");
			/**
			 * Pra el tipo de stock modificar pl y dao recinfserie
			 */
			layout.append("<td class='textoFilasTabla'>"+tipoStock+"</td>");
//			layout.append("<td class='textoFilasTabla'></td>"); //RRG 23-09-2008 70904
			layout.append("</tr>");
			layout.append("<tr>");
			layout.append("<td class='textoColumnaTabla'>Código de Categoría</td>");
			layout.append("<td class='textoFilasTabla'>"+codCategoria+"</td>");
//			layout.append("<td class='textoFilasTabla'></td>"); //RRG 23-09-2008 70904
			layout.append("</tr>");
			layout.append("<tr>");
			layout.append("<td class='textoColumnaTabla'>Modalidad de Venta</td>");
			layout.append("<td class='textoFilasTabla'>" + cambioDeSerieForm.getModalidadPago() + "</td>");
			layout.append("</tr>");
layout.append("<tr>");
			layout.append("<td class='textoColumnaTabla'>Tipo de Contrato</td>");
			layout.append("<td class='textoFilasTabla'>" + cambioDeSerieForm.getMesesProrroga()+ "</td>");
			layout.append("</tr>");
			layout.append("<tr>");
//			layout.append("<td class='textoColumnaTabla'>Código de Promedio Facturado</td>");  //RRG 23-09-2008 70904
//			layout.append("<td class='textoFilasTabla'></td>"); //RRG 23-09-2008 70904
				layout.append("<td class='textoColumnaTabla'>Código de Antigüedad</td>"); //RRG 23-09-2008 70904
				layout.append("<td class='textoFilasTabla'>0</td>"); //RRG 23-09-2008 70904
			layout.append("</tr>"); //RRG 23-09-2008 70904
			layout.append("<tr>"); //RRG 23-09-2008 70904
				layout.append("<td class='textoColumnaTabla'>Código de Estado</td>"); //RRG 23-09-2008 70904
				layout.append("<td class='textoFilasTabla'>"+codEstado+"</td>"); //RRG 23-09-2008 70904
			layout.append("</tr>");
			layout.append("</table>");
			layout.append("</td>");
			layout.append("</tr>");
			layout.append("<tr>");
			layout.append("<p><td align='center'>Si el problema persiste, favor comunicarse con el administrador de sistema.</td>");
			layout.append("</tr>");
			layout.append("</table>");
			
		/*
			"- Producto				:	1 \n" +
			"- Código de Artículo	:	"+formBeanCambioSerie.getCod_articulo()+"\n" +
			"- Número de Serie 		:	"+formBeanCambioSerie.getNroSerieEquip() +"\n" +
			"- Tipo Stock 			:	"+formBeanCambioSerie.getTip_stock()+"\n" +
			"- Código de Categoría  :	\n" +
			"- Modalidad de Venta 	:	"+formBeanCambioSerie.getModalidadPago()+"\n" +
			"- Meses de Prorroga 	:	"+formBeanCambioSerie.getMesesProrroga()+"\n" +
			"- Código de Promedio Facturado.\n" +
			"";
	*/
			delegate.guardaMensajesError(request, e.getMessage(), layout.toString()); // RRG
			return mapping.findForward("error");
		} catch (Exception e)			// RRG 10-07-2009 COL 96723
		{ // RRG
			//e.printStackTrace();
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("Error:"+loge);
			String message = "Error en el Módulo de Cargos";
			if (e.getMessage()!=null) {
				message = e.getMessage();
			}
			delegate.guardaMensajesError(request, "Error en el Módulo de Cargos", message);
			return mapping.findForward("error");
		} // RRG
		 return mapping.findForward("finalizar");
	}
	
	
}
