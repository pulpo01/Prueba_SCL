package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

//import com.evermind.server.jms.filter.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OrdenServicioDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ValidaOOSSDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoVetadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoVetadoListDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamRegistroPlanDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.RegistroPlanDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.businessObject.bo.XMLDefault;
import com.tmmas.scl.operations.crm.fab.cim.manreq.businessObject.dao.ParseoXML;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ControlDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.DefaultPaginaCPUDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ParametrosCondicionesCPUDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.SeccionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ManAboVetaForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.JCondicionesComerciales;

public class ManAbosVetaAction extends BaseAction {
	private final Logger logger = Logger.getLogger(ManAbosVetaAction.class);

	private Global global = Global.getInstance();

	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();

	protected ActionForward executeAction(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);
		logger.debug("execute():start");
		ManAboVetaForm manAboVetaForm = (ManAboVetaForm) form;
		ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
		AbonadoVetadoListDTO listAbonadoDTO = null;
		String nombreAction = null;
		nombreAction = "ManAboVetaForm";
		System.out.println(":::::::" + nombreAction);
		HttpSession session = request.getSession(false);
		sessionData = (ClienteOSSesionDTO) session.getAttribute("ClienteOOSS");
		AbonadoDTO abonadoDTO = new AbonadoDTO();
		boolean continuaOS = true;
		RetornoDTO retornoDTO = new RetornoDTO();
		retornoDTO.setCodigo("0");
		String fwdError = null;

		String ultimaPagina = (session.getAttribute("ultimaPagina") != null ? ((String) session.getAttribute("ultimaPagina")) : "");

		if (!(ultimaPagina.equalsIgnoreCase("Resumen")) && !(ultimaPagina.equalsIgnoreCase("cargos")) && !(ultimaPagina.equalsIgnoreCase("inicio"))) {
			if (sessionData.getNumAbonado() != 0) {
				nombreAction = "ExisteOssPendiente";
				String osInvalida = global.getValor("osNoAbonado");
				session.setAttribute("error", osInvalida);
				fwdError=osInvalida;
				continuaOS = false;
			}
		}

		try {
			if (continuaOS) {
				sessionData.setCodCliente(sessionData.getCliente() != null ? sessionData.getCliente().getCodCliente() : 0);
				logger.debug("Codigo Cliente:" + sessionData.getCodCliente());
				logger.debug("Numero Abonado:" + sessionData.getNumAbonado());
				abonadoDTO.setCodCliente(sessionData.getCodCliente());
				abonadoDTO.setNumAbonado(sessionData.getNumAbonado());

				// Lectura de archivo XML de configuracion, parseo y carga en objeto de sesion

				DefaultPaginaCPUDTO definicionPagina = new DefaultPaginaCPUDTO();
				String dirXML = global.getValor("configAbonadosVetados");
				String dir = global.getPathInstancia() + dirXML;
				logger.debug("dir=" + dir);
				ParseoXML parseo = new ParseoXML();
				logger.debug("leyendo y parseando XML configuración:antes");
				definicionPagina = parseo.cargaXML(dir);
				logger.debug("leyendo y parseando XML configuracion:despues");
				sessionData.setDefaultPagina(definicionPagina);
				boolean isAbonados = false;
				String tipComp = "";
				List listaNumAbonadosS = new ArrayList();
				List listaNumAbonadosN = new ArrayList();

				// TODO: se realiza solo la primera vez
				if (manAboVetaForm.getAbonadosVetadosDTO() == null || manAboVetaForm.getAbonadosVetadosDTO().length < 1) {
					listAbonadoDTO = delegate.obtieneAbonadosVetados(abonadoDTO);
					isAbonados = listAbonadoDTO == null || listAbonadoDTO.getAbonadoVetadoList() == null ? false : true;
					manAboVetaForm.setAbonadosVetadosDTO(isAbonados ? listAbonadoDTO.getAbonadoVetadoList() : null);
				}

				if (isAbonados) {
					for (int i = 0; i < listAbonadoDTO.getAbonadoVetadoList().length; i++) {
						tipComp = listAbonadoDTO.getAbonadoVetadoList()[i].getTipo_Comportamiento();
						tipComp = tipComp == null ? "" : tipComp.trim();
						if (tipComp.equalsIgnoreCase("S")) {
							listaNumAbonadosS.add(String.valueOf(listAbonadoDTO.getAbonadoVetadoList()[i].getNumAbonado()));
						} else {
							listaNumAbonadosN.add(String.valueOf(listAbonadoDTO.getAbonadoVetadoList()[i].getNumAbonado()));
						}
					}

					manAboVetaForm.setListaNumAbonadosVetados(listaNumAbonadosS == null ? null : (String[]) ArrayUtl.copiaArregloTipoEspecifico(listaNumAbonadosS.toArray(), String.class));
					session.setAttribute("listaNumAbonadosVetados", manAboVetaForm.getListaNumAbonadosVetados());
					// manAboVetaForm.setListaNumAbonadosCheck(listaNumAbonadosS==null?null:(String[]) ArrayUtl.copiaArregloTipoEspecifico(listaNumAbonadosS.toArray(), String.class));
					// manAboVetaForm.setListaNumAbonadosNoVetados(listaNumAbonadosN==null?null:(String[]) ArrayUtl.copiaArregloTipoEspecifico(listaNumAbonadosN.toArray(), String.class));
				}

				OrdenServicioDTO ordenServicio = new OrdenServicioDTO();
				ordenServicio.setCliente(sessionData.getCliente());
				ordenServicio.setTipoComportamiento("AVET");

				ClienteDTO cliente = sessionData.getCliente();
				AbonadoDTO abonado = new AbonadoDTO();
				AbonadoListDTO abonadoLista = new AbonadoListDTO();
				AbonadoDTO[] abonados = new AbonadoDTO[1];
				if (sessionData.getNumAbonado() != 0) {
					abonado.setNumAbonado(sessionData.getNumAbonado());
					logger.debug("obtenerDatosAbonado :inicio");
					abonado = delegate.obtenerDatosAbonado(abonado);
					logger.debug("obtenerDatosAbonado :fin");
				} else {
					AbonadoListDTO lstAbonadoDTO =delegate.obtenerListaAbonados(cliente);
					abonado=lstAbonadoDTO.getAbonados()[0];
					abonado.setNumAbonado(0);
				}
				session.setAttribute("AbonadosSeleccionados", abonados);
				abonados[0] = abonado;
				abonadoLista.setAbonados(abonados);
				sessionData.setAbonados(abonadoLista.getAbonados());
				cliente.setAbonados(abonadoLista);
				sessionData.setCliente(cliente);

				session.setAttribute("AbonadosSeleccionados",abonadoLista.getAbonados());//EV 21/11/08
				
				session.removeAttribute("controlesList");
				XMLDefault objetoXML = new XMLDefault();
				DefaultPaginaCPUDTO objetoXMLSession = new DefaultPaginaCPUDTO();
				SeccionDTO seccion = new SeccionDTO();

				ArrayList controlesList = new ArrayList();
				objetoXMLSession = sessionData.getDefaultPagina();
				seccion = objetoXML.obtenerSeccion(objetoXMLSession, "piePaginaCargosPAG", "CargosCondicionesRegistroSS");
				ControlDTO control = seccion.obtControl("condicionesCK");
				controlesList.add(control);

				session.setAttribute("controlesList", controlesList);

				// cuando carga la pagina por PRIMERA vez por defecto coloca el check marcado
				if (manAboVetaForm.getCondicH() == null) {
					manAboVetaForm.setCondicH("SI");// form1.setCondicH(control.getValorDefecto());
				}

				String next = manAboVetaForm.getBtnSiguiente();
				next = next == null ? "" : next.trim().toUpperCase();
				if (next.equalsIgnoreCase("SIGUIENTE")) {
					List listaVetados = getlistaVetados(manAboVetaForm);
					List listaNoVetados = getlistaNoVetados(manAboVetaForm);
					
					// AbonadoVetadoDTO[] abonadosNoVetadosDTO = (AbonadoVetadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico( listaNoVetados.toArray(), AbonadoVetadoDTO.class);
					// AbonadoVetadoDTO[] abonadosVetadosDTO = (AbonadoVetadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico( listaVetados.toArray(), AbonadoVetadoDTO.class);

					if (listaNoVetados != null && listaNoVetados.size() > 0) {
						session.setAttribute("listaNoVetados", listaNoVetados);
					} else {
						session.removeAttribute("listaNoVetados");
					}

					if (listaVetados != null && listaVetados.size() > 0) {
						session.setAttribute("listaVetados", listaVetados);
					} else {
						session.removeAttribute("listaVetados");
					}

				}

				// validar ordenes pendientes plan

				ValidaOOSSDTO validaOS = new ValidaOOSSDTO();
				validaOS.setCodCliente(sessionData.getCliente().getCodCliente());
				// validaOS.setCodOS(String.valueOf(sessionData.getCodOrdenServicio())); ESTE NO VA
				validaOS.setCodPlanTarif(sessionData.getCliente().getCodPlanTarif());
				validaOS.setNumAbonado(sessionData.getAbonados()[0].getNumAbonado());
				if (isAbonados) {
					logger.debug("validaOossPendPlan():inicio");
					validaOS = delegate.validaOossPendPlan(validaOS);
					// retorna 1: si existen OossPendientes, 0: no existen;
					String codOssP = validaOS.getCodigo();
					// codOssP="1";
					codOssP = codOssP == null ? "" : codOssP.trim();
					if (codOssP.equals("1")) {
						nombreAction = "ExisteOssPendiente";
						String osInvalida = global.getValor("osPendiente");
						session.setAttribute("error", osInvalida);

					}
					logger.debug("validaOossPendPlan():fin");
				}

				if (!next.equals("SIGUIENTE")) {

					UsuarioDTO usuario = new UsuarioDTO();// vendedor

					usuario.setNombre(sessionData.getUsuario());
					usuario = delegate.obtenerVendedor(usuario);

					ParametrosCondicionesCPUDTO parametros = new ParametrosCondicionesCPUDTO();
					parametros.setCodOOSS(sessionData.getCodOrdenServicio());
					parametros.setCombinatoriaGenerada("-");
					parametros.setUsuario(String.valueOf(usuario.getCodigo()));
					parametros.setCodPlanTarifSelec(sessionData.getCliente().getCodPlanTarif());
					parametros.setTipoPlanTarifDestino(sessionData.getCliente().getCodTipoPlan());

					JCondicionesComerciales jCondicionesComerciales = new JCondicionesComerciales();
					retornoDTO = jCondicionesComerciales.getCondicionesComercialesOss(abonadoLista, parametros);
				}

				if (!("0".equals(retornoDTO.getCodigo()))) {
					// nombreAction="ExisteOssPendiente";
					fwdError = "ErrorEnActionDeCarga";
					String osInvalida = retornoDTO.getDescripcion();// global.getValor("valCondComOSS");
					session.setAttribute("error", osInvalida);
					// continua=false;
				}
				if (next.equals("SIGUIENTE")) {
					nombreAction = "FlujoManAboVetaForm";
				}
			}
		} catch (Exception e) {
			retornoDTO.setCodigo("NO HAY UN CODIGO DEFINIDO");
			retornoDTO.setDescripcion(e.getMessage());
			retornoDTO.setResultado(true);

			if (e instanceof ManReqException) {
				ManReqException me = (ManReqException) e.getCause();
				if (me.getCodigo() != null && !(me.getCodigo().equals(""))) {
					retornoDTO.setCodigo(me.getCodigo());
					retornoDTO.setDescripcion(me.getDescripcionEvento());
					retornoDTO.setResultado(true);
				}
			}
			String mensajeError = retornoDTO.getDescripcion();
			session.setAttribute("error", mensajeError);
			fwdError = "ErrorEnActionDeCarga";
			logger.error(e.getMessage(), e);
		}
		if (fwdError != null) {
			return mapping.findForward(fwdError);
		}
		logger.debug("execute():end");
		session.setAttribute("recalculado", "NO");
		session.setAttribute("ultimaPagina", "inicio");
		
		//(+) evera, 20/11/08 inicializa variable de session comun a CPU y Producto
		RegistroPlanDTO registroPlan=new RegistroPlanDTO();
		ParamRegistroPlanDTO param = new ParamRegistroPlanDTO();	
		
		param.setCombinatoria("");
		param.setNomUsuaOra("");
		param.setFecDesdeLlam("");
		param.setFecDesdeLlamTS(new Timestamp((new Date()).getTime()));
		param.setCodPlanTarifDestino("");
		param.setTipOOSS("");
		
		registroPlan.setParamRegistroPlan(param);
		
		session.removeAttribute("registroPlan");	    
		session.setAttribute("registroPlan", registroPlan);	
	//(-)
		
		return mapping.findForward(nombreAction);
	}

	protected List getlistaVetados(ManAboVetaForm manAboVetaForm) throws ManReqException {
		List listaVetados = new ArrayList();
		try {
			if (manAboVetaForm.getListaNumAbonadosCheck() != null) {
				String numAboVet = null;
				Timestamp fecTerminoVig = new Timestamp(new SimpleDateFormat("dd-MM-yyyy").parse("31-12-3000").getTime());
				for (int i = 0; i < manAboVetaForm.getListaNumAbonadosCheck().length; i++) {
					AbonadoVetadoDTO abonadoVetadoDTO = new AbonadoVetadoDTO();
					numAboVet = manAboVetaForm.getListaNumAbonadosCheck()[i];
					String tipCompBD = null;
					String numAbonado = null;
					for (int j = 0; j < manAboVetaForm.getAbonadosVetadosDTO().length; j++) {
						abonadoVetadoDTO = manAboVetaForm.getAbonadosVetadosDTO()[j];
						tipCompBD = abonadoVetadoDTO.getTipo_Comportamiento();
						tipCompBD = tipCompBD == null ? "" : tipCompBD.trim();
						numAbonado = String.valueOf(abonadoVetadoDTO.getNumAbonado());
						if (numAboVet.equals(numAbonado) && tipCompBD.equalsIgnoreCase("N")) {

							boolean finicioVig = abonadoVetadoDTO.getFec_Inicio_Vigencia() == null ? true : false;
							if (finicioVig) {
								abonadoVetadoDTO.setFec_Inicio_Vigencia(new Timestamp(System.currentTimeMillis()));
							}
							abonadoVetadoDTO.setFec_Termino_Vigencia(fecTerminoVig);
							abonadoVetadoDTO.setTipo_Comportamiento("PMOD");
							listaVetados.add(abonadoVetadoDTO);
						}
					}
				}
			}
		} catch (Exception ex) {
			throw new ManReqException(ex);
		}
		return listaVetados;
	}

	protected List getlistaNoVetados(ManAboVetaForm manAboVetaForm) throws ManReqException {
		List listaNoVetados = new ArrayList();
		try {

			// Crear lista de no vetados
			for (int i = 0; i < manAboVetaForm.getAbonadosVetadosDTO().length; i++) {
				int cont = 0;
				String numAbo = String.valueOf(manAboVetaForm.getAbonadosVetadosDTO()[i].getNumAbonado());
				String Tipo = manAboVetaForm.getAbonadosVetadosDTO()[i].getTipo_Comportamiento();
				boolean isCheckAny = manAboVetaForm.getListaNumAbonadosCheck() != null && manAboVetaForm.getListaNumAbonadosCheck().length > 0 ? true : false;
				for (int j = 0; isCheckAny && j < manAboVetaForm.getListaNumAbonadosCheck().length; j++) {
					String numAboCK = manAboVetaForm.getListaNumAbonadosCheck()[j];
					if (numAbo.equals(numAboCK))
						cont++;
				}
				// no esta en lista de vetados y tipo cambio de estado a no vetado
				if (cont == 0 && Tipo.equalsIgnoreCase("S")) {
					manAboVetaForm.getAbonadosVetadosDTO()[i].setFec_Termino_Vigencia(new Timestamp(System.currentTimeMillis()));
					manAboVetaForm.getAbonadosVetadosDTO()[i].setTipo_Comportamiento("PMOD");
					listaNoVetados.add(manAboVetaForm.getAbonadosVetadosDTO()[i]);
				}
			}
		} catch (Exception ex) {
			throw new ManReqException(ex);
		}

		return listaNoVetados;
	}

}
