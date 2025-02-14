package com.tmmas.scl.operations.crm.fab.cusintman.web.action;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.scl.framework.ProductDomain.dto.RestriccionesDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.OperadoraLocalDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.SeccionDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ValoresJSPPorDefectoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CausasSuspensionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DatosGeneralesSuspensionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.FechasSuspensionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PeriodoSuspencionAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.SuspensionAbonadoDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.SuspensionVoluntariaBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cusintman.web.form.SuspensionVoluntariaForm;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Global;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Utilidades;
import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException;
import com.tmmas.scl.operations.frmkooss.web.businessObject.bo.XMLDefault;
import com.tmmas.scl.operations.frmkooss.web.businessObject.dao.ParseoXML;
import com.tmmas.scl.operations.frmkooss.web.delegate.FrmkOOSSBussinessDelegate;

public class SuspensionVoluntariaAction extends BaseAction {
	
	private final Logger logger = Logger.getLogger(SuspensionVoluntariaAction.class);
	private Global global = Global.getInstance();
	private SuspensionVoluntariaBussinessDelegate delegate = SuspensionVoluntariaBussinessDelegate.getInstance();
	private FrmkOOSSBussinessDelegate delegateOOSS = FrmkOOSSBussinessDelegate.getInstance();
	
	public ActionForward executeAction(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws CusIntManException, Exception {

		// Configuro el path para el log4j
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		// ------------------------------------------------------------------------------------
		
		// Agrego una entrada al log
		logger.debug("execute():start");

		// Tomo los datos iniciales del cliente que estan en sesion
	    ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
	    HttpSession session = request.getSession(false);
	    sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
	    // -----------------------------------------------------
	    session.setAttribute("nombreOOSS", "Suspensión Voluntaria Programada");
	    String nombreOperadora = "";
	    OperadoraLocalDTO operadora = delegate.obtenerOperadoraLocal();
	    if("TMG".equals(operadora.getOperadora()))
	     {
	    	 nombreOperadora = global.getValor("NOM_OPERADORA_TMG");
	    }else
	    {
	    	nombreOperadora = global.getValor("NOM_OPERADORA_TMS");
	    }
	     	
	    session.setAttribute("operadora", nombreOperadora);
	    // ------------------------------------------------------------------------------------

		String archivo = System.getProperty("user.dir")+global.getValor("ruta.xml")+global.getValor("xml.valoresdefecto");
		ParseoXML parseo=new ParseoXML();
		logger.debug("leyendo y parseando XML configuración:antes");
		ValoresJSPPorDefectoDTO definicionPagina=parseo.cargaXML(archivo);
		logger.debug("leyendo y parseando XML configuracion:despues");
		sessionData.setDefaultPagina(definicionPagina);
		
		XMLDefault objetoXML    = new XMLDefault();
		ValoresJSPPorDefectoDTO objetoXMLSession = new ValoresJSPPorDefectoDTO();
		SeccionDTO seccion=new SeccionDTO();
		objetoXMLSession = sessionData.getDefaultPagina();
		seccion = objetoXML.obtenerSeccion(objetoXMLSession, "piePaginaCargosPAG", "CargosCondicionesRegistroSS");
		
		//Obtengo el valor div de condiciones comerciales
		String valorDivCondicionesComerc=seccion.obtControl("condicionesCK").getVisible();
		valorDivCondicionesComerc=valorDivCondicionesComerc!=null&&"".equals(valorDivCondicionesComerc)?"NO":valorDivCondicionesComerc.trim();
		valorDivCondicionesComerc="NO".equals(valorDivCondicionesComerc)?"NONE":"inline";
		request.setAttribute("condComCK",valorDivCondicionesComerc);

		// --------------------------------------------------------------------
	    
	    UsuarioAbonadoDTO usuarioAbonado = new UsuarioAbonadoDTO();

	    Long numAbonadoLong = new Long (sessionData.getNumAbonado());
	    usuarioAbonado.setNum_abonado(numAbonadoLong.longValue());

	    // Busco los datos para la cabecera de las paginas
	    usuarioAbonado = delegate.obtenerDatosUsuarioAbonado(usuarioAbonado);
	    session.setAttribute("usuarioAbonado", usuarioAbonado);
	    
	    UsuarioSistemaDTO usuarioSistema = (UsuarioSistemaDTO)session.getAttribute("usuarioSistema");
	    SuspensionVoluntariaForm formBean = (SuspensionVoluntariaForm)form;
	    
	    // ------------------------------------------------------------------------------------
	    // Configuracion de orden de servicio comisionable
	    // ------------------------------------------------------------------------------------
		
		seccion = objetoXML.obtenerSeccion(objetoXMLSession, "OOSSComisionable", "Configuracion");
		session.setAttribute("oossComisionable", seccion.obtControl("ConfigComis").getHabilitado());

		// ------------------------------------------------------------------------------------
		
	    String condicion = formBean.getCondicionError();
	    if ((condicion != null) && (!(condicion.equals(""))))	{ 
	    	if (formBean.getCondicionError().equals("ERROR"))	{
	    		// SI OCURRIO UN ERROR DEL SISTEMA GENERADO POR ALGUN TEMA DE AJAX DEBE MOSTRAR LA PAGINA DE ERROR
	    		// Formateo todo el texto para que pueda mostrarse correctamente
	    		String mens = formBean.getMensajeError();
	    		String stack = formBean.getMensajeStackTrace();
	    		
	    		delegate.guardaMensajesError(request, mens, stack);
	    		
	    		return mapping.findForward("error");
	    	} // if 
	    } // if
	    else	{
			String codigoPrograma = global.getValor("codigoPrograma");
		    String versionPrograma = global.getValor("versionPrograma");
		    String actAvisoSin = global.getValor("ACT_SUSPENSIONVOLUNTARIA");		    
		    
		    Long versionProgramaLong = new Long (versionPrograma);
		    
		    SesionDTO sesionDTO = new SesionDTO();
		    sesionDTO.setCodCliente(sessionData.getCliente().getCodCliente());
		    
		    // Almaceno el usuario del sistema
		    UsuarioSistemaDTO usuario = new UsuarioSistemaDTO();
		    usuario.setNom_usuario(sessionData.getUsuario());
		    sesionDTO.setUsuario(usuario);
		    
		    // ------------------------------------------------------------------------
		    sesionDTO.setCod_programa(codigoPrograma);
		    sesionDTO.setNum_version(versionProgramaLong.longValue());
		    sesionDTO.setNumAbonado(numAbonadoLong.longValue());
 			// ------------------------------------------------------------------------------------------------------------------		    

			String btnSelec=formBean.getBtnSeleccionado();
			btnSelec=btnSelec==null?"":btnSelec;
		    
			if (formBean.getBtnSeleccionado() != null && !formBean.getBtnSeleccionado().equals("anterior"))	{
		    	SuspensionAbonadoDTO suspension = new SuspensionAbonadoDTO();

		    	suspension.setNum_abonado(formBean.getNroAbonado());
		    	suspension.setUsuario(sessionData.getUsuario());
		    	
		    	if (formBean.getBtnSeleccionado().equals("anular")) {
		    		session.setAttribute("textoNumOOSS", "anulados");
		    	}
		    	else if (formBean.getBtnSeleccionado().equals("modificar")){
		    		session.setAttribute("textoNumOOSS", "modificados");
		    	}
		    	else {
		    		session.setAttribute("textoNumOOSS", "creados");
		    	}
		    			    	
    			if ((formBean.getBtnSeleccionado().equals("anular"))	|| (formBean.getBtnSeleccionado().equals("modificar"))) {
    			    SuspensionAbonadoDTO[] suspensionesAbonado = (SuspensionAbonadoDTO[]) session.getAttribute("suspensionesAbonado");
    			    suspension = suspensionesAbonado[formBean.getIndiceAnular()];
    			} // if
		    	
	    		if ((formBean.getBtnSeleccionado().equals("programar")) || (formBean.getBtnSeleccionado().equals("modificar"))) {
	    			CausasSuspensionDTO causa = new CausasSuspensionDTO();
	    			causa.setCodigoCausa(formBean.getCausaSuspension());
	    			suspension.setCausaSuspension(causa);
	    			
	    			suspension.setFechaSolicitud(Utilidades.devuelveDate(formBean.getFecSolicitud()));
	    			suspension.setFechaSuspension(Utilidades.devuelveDate(formBean.getFecSuspension()));
	    			suspension.setFechaRehabilitacion(Utilidades.devuelveDate(formBean.getFecRehabilitacion()));
	    			suspension.setDiasSus1(formBean.getCantDias());
	    			suspension.setDiasSus2(0);
	    		} // if


    			// -----------------------------------------------------------		    	
		    	// SOLO en el caso de programar, se necesitan 2 secuencias porq se generan 2 ooss 
		    	if (formBean.getBtnSeleccionado().equals("programar"))	{
					SecuenciaDTO secuencia = new SecuenciaDTO();
					if(sessionData.getNumOrdenServicio()== 0)	{
						logger.debug("obtenerSecuencia:antes");
						secuencia.setNomSecuencia("CI_SEQ_NUMOS");
						logger.debug("nomSecuencia :"+secuencia.getNomSecuencia());						
						
						secuencia = delegateOOSS.obtenerSecuencia(secuencia);
							suspension.setNumOsSus(secuencia.getNumSecuencia());
						secuencia = delegateOOSS.obtenerSecuencia(secuencia);
							suspension.setNumOsReh(secuencia.getNumSecuencia());

						logger.debug("obtenerSecuencia:despues");
					} // if
		    	} // if
    			
	    		// Para el final de la OOSS
		    	formBean.setOpcionProceso(formBean.getBtnSeleccionado());
		    	session.setAttribute("suspensionVoluntariaForm", formBean);
		    	
	    		// Se guarda la suspension para procesarla al final
			    session.setAttribute("suspensionAbonado", suspension);
			    
	    		sessionData.setSinCondicionesComerciales(((SuspensionVoluntariaForm)form).getCondicH());
		    	formBean.setBtnSeleccionado(null);
		    	
		    	// LLeno todos los objetos para la grabacion
		    	session.setAttribute("ultimaPagina","negocio");//Controlador de Flujo
		    	sessionData.setCargosObtenidos(null);//Limpieza de Cargos
		    	request.setAttribute("mensajeOOSSAviso", "");
				
		    	session.removeAttribute("suspensionesAbonado");
		    	session.setAttribute("indexFecSuspension", formBean.getIndexFecSuspension());
		    	return mapping.findForward("finalizar");
		    } // if
		    else	{
		    	// SE INICIA LA CARGA DE PAGINA
			    // Carga de combos
			    // Ejecuta las restricciones de ejecucion para esta funcionalidad	
			    session.setAttribute("usuarioSistema", usuarioSistema);

			    // Armo el string con todos los parametros separados con pipes
			    String parametros = delegate.parametrosRestriccion(actAvisoSin, usuarioSistema, usuarioAbonado, sessionData);

			    // Tomo el valor del properties y ejecuto las restricciones
			    RestriccionesDTO restriccion = new RestriccionesDTO();	                                                                                                                                                                                                                                                                                                                
			    restriccion.setCod_actuacion(actAvisoSin);
			    restriccion.setCod_modulo(global.getValor("MODULO"));
			    restriccion.setCod_producto(1);
			    restriccion.setCod_evento("FORMLOAD");	
			    restriccion.setParam_entrada(parametros);
			    
			    MensajeRetornoDTO mensajes = null;
			    mensajes = delegate.ejecutaRestrccion(restriccion);
			    
			    // verifico que restricciones se han cumplido y guardo el mensaje}
			    // si textoMensajeRestricciones==OK entonces no problem
			    String textoMensajeRestricciones = delegate.verificaEjecucionRestrccion(mensajes);
			    		
			    if (!(textoMensajeRestricciones.equals("OK")))	{
			    	delegate.guardaMensajesError(request, "Ha ocurrido uno o varios errores al validar las restricciones.", textoMensajeRestricciones);
					return mapping.findForward("error");
			    }	// if
			   
			    // Consulto las causas de suspension para el listbox
			    CausasSuspensionDTO[] causasSuspension = null;
			    causasSuspension = delegate.obtenerCausasSuspension();
			    request.setAttribute("causasSuspension", causasSuspension);
			    
			    // Consulto el listado de suspension para mostrarlo en la grilla
			    SuspensionAbonadoDTO[] suspensionesAbonado = null;
			    suspensionesAbonado = delegate.obtenerSuspensionesAbonado(usuarioAbonado);
			    session.setAttribute("suspensionesAbonado", suspensionesAbonado);
			    request.setAttribute("cantSuspensiones", String.valueOf(suspensionesAbonado.length));
			    
			    try	{
				    // Busco el numero de celular del abonado
				    AbonadoDTO abonado = new AbonadoDTO();
				    abonado.setNumAbonado(sessionData.getNumAbonado());
				    abonado = delegate.obtenerDatosAbonado(abonado);
				    
				    formBean.setNroTerminal(abonado.getNumCelular());
			    }	// try
			    catch (Exception ex){
			    	formBean.setNroTerminal(0);
			    } // catch
			    
			    formBean.setNroAbonado(usuarioAbonado.getNum_abonado());
			    
			    
			    FechasSuspensionDTO[] fecSuspension = delegate.recuperarFechasSuspension(sessionData);
			    request.setAttribute("fecSuspension", fecSuspension);	
			    
			    DatosGeneralesSuspensionDTO datosGenerales = delegate.obtenerDatosGeneralesSuspension();
			    request.setAttribute("datosGenerales", datosGenerales);
			    
			    // Busco todos los periodos de suspension del abonado
			    PeriodoSuspencionAbonadoDTO[] periodosSusp = null;
			    periodosSusp = delegate.obtenerPeriodosSuspensioAbonado(usuarioAbonado);
			    
			    // Si no tiene periodos entonces debo crear un periodo
			    if ((periodosSusp == null) || (periodosSusp.length == 0))	{
				    PeriodoSuspencionAbonadoDTO periodoSuspensionAbonado = new PeriodoSuspencionAbonadoDTO();
				    periodoSuspensionAbonado.setCod_cliente(sessionData.getCodCliente());
				    periodoSuspensionAbonado.setNum_abonado(usuarioAbonado.getNum_abonado());
				    
			    	delegate.agregaPeriodoSuspension(periodoSuspensionAbonado);
			    	periodosSusp = delegate.obtenerPeriodosSuspensioAbonado(usuarioAbonado);			    	
			    } // if
			    
			    request.setAttribute("periodosSusp", periodosSusp);
			    
			    // ------------------------------------------------------------------------------------------------------------------
			    		    
			    request.setAttribute("titulo", "Suspensión Voluntaria de Servicio");
			    
			    Date fechaHoy =  new Date(Calendar.getInstance().getTime().getYear(), Calendar.getInstance().getTime().getMonth(),Calendar.getInstance().getTime().getDate());
			    SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
				formBean.setFecSolicitud(formato.format(fechaHoy));

				// Guardo el index del listbox de fecha de suspension
				if (session.getAttribute("indexFecSuspension")==null)
					session.setAttribute("indexFecSuspension", "0");
				
			   // formBean.setFecSolicitud(String.valueOf(fechaHoy));
		    }	// else
	    }	// else

		return mapping.findForward("inicio");

	}  // execute
	
// ------------------------------------------------------------------------------------------------------------------------
	
}  // SuspensionVoluntariaAction
