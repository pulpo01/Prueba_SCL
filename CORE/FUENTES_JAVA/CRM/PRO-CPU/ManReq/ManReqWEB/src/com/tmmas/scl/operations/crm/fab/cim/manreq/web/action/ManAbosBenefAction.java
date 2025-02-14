package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OrdenServicioDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ValidaOOSSDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoBeneficiarioDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoBeneficiarioListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.businessObject.bo.XMLDefault;
import com.tmmas.scl.operations.crm.fab.cim.manreq.businessObject.dao.ParseoXML;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ControlDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.DefaultPaginaCPUDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ParametrosCondicionesCPUDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.SeccionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ManAboBeneForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.JCondicionesComerciales;

public class ManAbosBenefAction extends BaseAction {
	private final Logger logger = Logger.getLogger(ManAbosBenefAction.class);

	private Global global = Global.getInstance();

	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();

	protected long codigoCliente;

	protected long numAbonadoSessionData;

	protected ActionForward executeAction(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		String log = global.getValor("web.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);
		logger.debug("execute():start");
		ManAboBeneForm manAboBeneForm = (ManAboBeneForm) form;
		ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
		AbonadoBeneficiarioListDTO listAbonadoDTO = null;
		String nombreAction = null;
		RetornoDTO retornoDTO = new RetornoDTO();	
		retornoDTO.setCodigo("0");
		String fwdError = null;
		nombreAction = "ManAboBeneForm";
		HttpSession session = request.getSession(false);
		sessionData = (ClienteOSSesionDTO) session.getAttribute("ClienteOOSS");
		AbonadoDTO abonadoDTO = new AbonadoDTO();
		AbonadoBeneficiarioListDTO listaAbonadosEliminados = null;
		AbonadoBeneficiarioListDTO listaAbonadosAgregados = null;
		boolean continuaOS = true;		
		String next = manAboBeneForm.getBtnSiguiente();
		next = next == null ? "" : next.trim();
		String ultimaPagina = null;		
		if (!next.equals("SIGUIENTE") && sessionData.getCodCliente() != 0) {
			ultimaPagina = (session.getAttribute("ultimaPagina")!=null?((String)session.getAttribute("ultimaPagina")):"");
			if (!(ultimaPagina.equalsIgnoreCase("Resumen")) && !(ultimaPagina.equalsIgnoreCase("cargos"))) {
				nombreAction = "ExisteOssPendiente";
				String osInvalida = global.getValor("osNoCliente");
				session.setAttribute("error", osInvalida);
				continuaOS = false;				
			}
		}
		if (continuaOS) {
			sessionData.setCodCliente(sessionData.getCliente() != null ? sessionData.getCliente().getCodCliente() : 0);
			logger.debug("Codigo Cliente:" + sessionData.getCodCliente());
			logger.debug("Numero Abonado:" + sessionData.getNumAbonado());
			abonadoDTO.setCodCliente(sessionData.getCodCliente());
			abonadoDTO.setNumAbonado(sessionData.getNumAbonado());
			numAbonadoSessionData = sessionData.getNumAbonado();
			codigoCliente = sessionData.getCodCliente();
			boolean isAbonados = false;

			// Lectura de archivo XML de configuracion, parseo y carga en objeto de sesion
			DefaultPaginaCPUDTO definicionPagina = new DefaultPaginaCPUDTO();
			String dirXML = global.getValor("configAbonadosBeneficiarios");
			String dir = System.getProperty("user.dir") + dirXML;
			logger.debug("dir=" + dir);
			ParseoXML parseo = new ParseoXML();
			logger.debug("leyendo y parseando XML configuración:antes");
			definicionPagina = parseo.cargaXML(dir);
			logger.debug("leyendo y parseando XML configuracion:despues");
			sessionData.setDefaultPagina(definicionPagina);

			ClienteDTO cliente = sessionData.getCliente();
			AbonadoDTO abonado = new AbonadoDTO();
			AbonadoListDTO abonadoLista = new AbonadoListDTO();
			AbonadoDTO[] abonados = new AbonadoDTO[1];
			if (sessionData.getNumAbonado() != 0) {
				abonado.setNumAbonado(sessionData.getNumAbonado());
				logger.debug("obtenerDatosAbonado :inicio");								
				try {
					abonado = delegate.obtenerDatosAbonado(abonado);
				} catch (Exception e) {					
					retornoDTO.setCodigo("NO HAY UN CODIGO DEFINIDO");
					retornoDTO.setDescripcion(e.getMessage());
					retornoDTO.setResultado(true);		
					
					if (e instanceof ManReqException) {				
						ManReqException me =(ManReqException)e.getCause();		
						if (me.getCodigo()!=null && !(me.getCodigo().equals(""))){
							retornoDTO.setCodigo(me.getCodigo());
							retornoDTO.setDescripcion(me.getDescripcionEvento());
							retornoDTO.setResultado(true);		
						} 
					}		
			    	String mensajeError = retornoDTO.getDescripcion();
			    	session.setAttribute("error", mensajeError);
			    	fwdError="ErrorEnActionDeCarga";	
					logger.error(e.getMessage(), e);	    	
				}
				if (fwdError!=null){return mapping.findForward(fwdError);}					
				
				logger.debug("obtenerDatosAbonado :fin");
			} else {
				abonado.setNumAbonado(0);
			}
			abonados[0] = abonado;
			abonadoLista.setAbonados(abonados);
			sessionData.setAbonados(abonadoLista.getAbonados());
			cliente.setAbonados(abonadoLista);
			sessionData.setCliente(cliente);

			OrdenServicioDTO ordenServicio = new OrdenServicioDTO();
			ordenServicio.setCliente(sessionData.getCliente());
			ordenServicio.setTipoComportamiento("ABEN");

			// TODO: se realiza solo la primera vez
			//se obtiene la lista de abonados
			if (manAboBeneForm.getListaEncolar() == null) {								
				try {
					listAbonadoDTO = delegate.obtieneAbonadosBeneficiarios(abonadoDTO);	
				} catch (Exception e) {					
					retornoDTO.setCodigo("NO HAY UN CODIGO DEFINIDO");
					retornoDTO.setDescripcion(e.getMessage());
					retornoDTO.setResultado(true);		
					
					if (e instanceof ManReqException) {				
						ManReqException me =(ManReqException)e.getCause();		
						if (me.getCodigo()!=null && !(me.getCodigo().equals(""))){
							retornoDTO.setCodigo(me.getCodigo());
							retornoDTO.setDescripcion(me.getDescripcionEvento());
							retornoDTO.setResultado(true);		
						} 
					}		
			    	String mensajeError = retornoDTO.getDescripcion();
			    	session.setAttribute("error", mensajeError);
			    	fwdError="ErrorEnActionDeCarga";	
					logger.error(e.getMessage(), e);	    	
				}
				if (fwdError!=null){return mapping.findForward(fwdError);}				
								
				manAboBeneForm.setAbonadosDTO((listAbonadoDTO == null || listAbonadoDTO.getAbonadoBeneficiarioList() == null) ? null : listAbonadoDTO.getAbonadoBeneficiarioList());
				isAbonados = true;
			} else {
				// Retornar los Eliminados
				listaAbonadosEliminados = listaEliminados(manAboBeneForm);
				// Retorna Los Agregados
				listaAbonadosAgregados = listaAgregados(manAboBeneForm);

				session.setAttribute("listaAbonadosEliminados", listaAbonadosEliminados);
				session.setAttribute("listaAbonadosAgregados", listaAbonadosAgregados);
			}

			// TODO : Llamada a Flujo
			next = next == null ? "" : next.trim().toUpperCase();
			if (next.equals("SIGUIENTE")) {
				nombreAction = "FlujoManAboBeneForm";
			}

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
			if (manAboBeneForm.getCondicH() == null) {
				manAboBeneForm.setCondicH(control.getValorDefecto());
			}

			// validar ordenes pendientes plan
			ValidaOOSSDTO validaOS = new ValidaOOSSDTO();
			validaOS.setCodCliente(sessionData.getCliente().getCodCliente());
			// validaOS.setCodOS(String.valueOf(sessionData.getCodOrdenServicio())); ESTE NO VA
			validaOS.setCodPlanTarif(sessionData.getCliente().getCodPlanTarif());
			validaOS.setNumAbonado(sessionData.getAbonados()[0].getNumAbonado());

			logger.debug("validaOossPendPlan():inicio");												
			try {
				validaOS = delegate.validaOossPendPlan(validaOS);	
			} catch (Exception e) {					
				retornoDTO.setCodigo("NO HAY UN CODIGO DEFINIDO");
				retornoDTO.setDescripcion(e.getMessage());
				retornoDTO.setResultado(true);		
				
				if (e instanceof ManReqException) {				
					ManReqException me =(ManReqException)e.getCause();		
					if (me.getCodigo()!=null && !(me.getCodigo().equals(""))){
						retornoDTO.setCodigo(me.getCodigo());
						retornoDTO.setDescripcion(me.getDescripcionEvento());
						retornoDTO.setResultado(true);		
					} 
				}		
		    	String mensajeError = retornoDTO.getDescripcion();
		    	session.setAttribute("error", mensajeError);
		    	fwdError="ErrorEnActionDeCarga";	
				logger.error(e.getMessage(), e);	    	
			}
			if (fwdError!=null){return mapping.findForward(fwdError);}			
			
			String codOssP = validaOS.getCodigo();
			// codOssP="1";
			codOssP = codOssP == null ? "" : codOssP.trim();
			if (codOssP.equals("1")) {
				nombreAction = "ExisteOssPendiente";
				String osInvalida = global.getValor("osPendiente");
				session.setAttribute("error", osInvalida);

			}
			/*
			 * if(codOssP.equals("1")){ nombreAction="ExisteOssPendiente"; }
			 */
			logger.debug("validaOossPendPlan():fin");
			RetornoDTO retValue = new RetornoDTO();
			retValue.setCodigo("0");
			try {
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
					retValue = jCondicionesComerciales.getCondicionesComercialesOss(abonadoLista, parametros);
				}
			} catch (ManReqException e) {
				e = (ManReqException) e.getCause();
				retValue.setCodigo(e.getCodigo());
				retValue.setDescripcion(e.getDescripcionEvento());
				retValue.setResultado(true);
			}

			if (!("0".equals(retValue.getCodigo()))) {
				//nombreAction = "ExisteOssPendiente";
				nombreAction = "ErrorEnActionDeCarga";
				String osInvalida = retValue.getDescripcion();// global.getValor("valCondComOSS");
				session.setAttribute("error", osInvalida);
				// continua=false;
			}

		}//FIN DEL IF continuaOS

		logger.debug("execute():end");
		session.setAttribute("recalculado", "NO");
		session.setAttribute("ultimaPagina","inicio");
		return mapping.findForward(nombreAction);
	}

	protected AbonadoBeneficiarioListDTO obtieneAbonadosBeneficiariosPorNumCelular(AbonadoDTO abonadoDTO) throws Exception {
		String log = global.getValor("web.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);
		AbonadoBeneficiarioListDTO retorno = null;
		logger.debug("obtieneAbonadosBeneficiariosPorNumCelular():start");

		try {
			retorno = delegate.obtieneAbonadosBeneficiariosPorNumCelular(abonadoDTO);

		} catch (ManReqException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}
		logger.debug("obtieneAbonadosBeneficiariosPorNumCelular():end");
		return retorno;
	}

	protected AbonadoBeneficiarioListDTO listaEliminados(ManAboBeneForm manAboBeneForm) {
		String numAbonadoDelegate = null;
		String numAbonadoForm = null;
		List listaAbonadosEliminados = new ArrayList();
		AbonadoBeneficiarioListDTO abonadosBeneficiarioListDTO = null;
		boolean existEliminado = false;

		for (int i = 0; (manAboBeneForm.getAbonadosDTO() != null && i < manAboBeneForm.getAbonadosDTO().length); i++) {
			int contNum = 0;
			numAbonadoDelegate = String.valueOf(manAboBeneForm.getAbonadosDTO()[i].getNum_Abonado_Beneficiario());
			numAbonadoDelegate = numAbonadoDelegate.trim();

			// TODO : Se realiza búsqueda de los Eliminados
			for (int j = 0; j < manAboBeneForm.getListaEncolar().length; j++) {
				numAbonadoForm = manAboBeneForm.getListaEncolar()[j];
				numAbonadoForm = numAbonadoForm.trim();
				if (numAbonadoDelegate.equals(numAbonadoForm)) {
					contNum++;
				}
			}

			if (contNum == 0) {
				existEliminado = true;
				System.out.println("numAbonadoEliminado::" + numAbonadoDelegate);
				listaAbonadosEliminados.add(manAboBeneForm.getAbonadosDTO()[i]);
			}

		}
		if (existEliminado) {
			AbonadoBeneficiarioDTO[] abonadoBeneficiarioDTO = (AbonadoBeneficiarioDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaAbonadosEliminados.toArray(), AbonadoBeneficiarioDTO.class);
			abonadosBeneficiarioListDTO = new AbonadoBeneficiarioListDTO();
			abonadosBeneficiarioListDTO.setAbonadoBeneficiarioList(abonadoBeneficiarioDTO);
		}
		return abonadosBeneficiarioListDTO;
	}

	protected AbonadoBeneficiarioListDTO listaAgregados(ManAboBeneForm manAboBeneForm) {
		String numAbonadoDelegate = null;
		String numAbonadoForm = null;
		List listaAbonadosAgregados = new ArrayList();
		AbonadoBeneficiarioListDTO abonadosBeneficiarioListDTO = null;
		boolean existAgregado = false;
		for (int j = 0; j < manAboBeneForm.getListaEncolar().length; j++) {
			numAbonadoForm = manAboBeneForm.getListaEncolar()[j];
			numAbonadoForm = numAbonadoForm.trim();
			int contNum = 0;

			for (int i = 0; (manAboBeneForm.getAbonadosDTO() != null && i < manAboBeneForm.getAbonadosDTO().length); i++) {
				numAbonadoDelegate = String.valueOf(manAboBeneForm.getAbonadosDTO()[i].getNum_Abonado_Beneficiario());
				numAbonadoDelegate = numAbonadoDelegate.trim();

				// TODO : Se realiza búsqueda de los Agregados
				if (numAbonadoForm.equals(numAbonadoDelegate)) {
					contNum++;
				}
			}
			if (contNum == 0) {
				AbonadoBeneficiarioDTO abonadoBeneficiarioDTO = null;
				System.out.println("Numero Abonado Agregado::" + numAbonadoForm);
				for (int k = 0; k < manAboBeneForm.getListaEncolar().length; k++) {

					if (manAboBeneForm.getListaEncolar()[k].equals(numAbonadoForm)) {
						abonadoBeneficiarioDTO = new AbonadoBeneficiarioDTO();
						abonadoBeneficiarioDTO.setCodCliente(codigoCliente);
						abonadoBeneficiarioDTO.setNumAbonado(numAbonadoSessionData);
						abonadoBeneficiarioDTO.setNombre(manAboBeneForm.getListaEncolarNombre()[k]);
						abonadoBeneficiarioDTO.setNumCelular(Long.parseLong(manAboBeneForm.getListaEncolarNumCelular()[k]));
						abonadoBeneficiarioDTO.setNum_Abonado_Beneficiario(Long.parseLong(numAbonadoForm));
						abonadoBeneficiarioDTO.setTipo_Comportamiento(manAboBeneForm.getListaEncolarTipoComportamiento()[k]);
						abonadoBeneficiarioDTO.setFec_Inicio_Vigencia(new Timestamp(System.currentTimeMillis()));
						// Se setea Fecha de 30-12-3000 colocar en un properties
						String fecha = "30-12-3000";
						// Date d=;
						try {
							abonadoBeneficiarioDTO.setFec_Termino_Vigencia(new Timestamp(new SimpleDateFormat("dd-MM-yyyy").parse(fecha).getTime()));
						} catch (ParseException e) {
							e.printStackTrace();
						}
						listaAbonadosAgregados.add(abonadoBeneficiarioDTO);
					}

				}
				existAgregado = true;
			}
		}
		if (existAgregado) {
			AbonadoBeneficiarioDTO[] abonadoBeneficiarioDTO = (AbonadoBeneficiarioDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaAbonadosAgregados.toArray(), AbonadoBeneficiarioDTO.class);
			abonadosBeneficiarioListDTO = new AbonadoBeneficiarioListDTO();
			abonadosBeneficiarioListDTO.setAbonadoBeneficiarioList(abonadoBeneficiarioDTO);
		}
		return abonadosBeneficiarioListDTO;
	}
}
