package com.tmmas.scl.operations.crm.fab.cusintman.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.scl.framework.ProductDomain.dto.CambioPlanPendienteDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaSiniestroDTO;
import com.tmmas.scl.framework.ProductDomain.dto.RestriccionesDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoSiniestroDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoSuspencionDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.OperadoraLocalDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.SeccionDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ValoresJSPPorDefectoDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.AvisoSiniestroBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cusintman.web.form.AvisoSiniestroForm;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Global;
import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException;
import com.tmmas.scl.operations.frmkooss.web.businessObject.bo.XMLDefault;
import com.tmmas.scl.operations.frmkooss.web.businessObject.dao.ParseoXML;
import com.tmmas.scl.operations.frmkooss.web.delegate.FrmkOOSSBussinessDelegate;

public class AvisoSiniestroAction extends BaseAction {
	
	private final Logger logger = Logger.getLogger(AvisoSiniestroAction.class);
	private Global global = Global.getInstance();
	private AvisoSiniestroBussinessDelegate delegate = AvisoSiniestroBussinessDelegate.getInstance();
	private FrmkOOSSBussinessDelegate delegate2 = new FrmkOOSSBussinessDelegate();
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
		
	    //---------------------------------------------------
	    session.setAttribute("nombreOOSS", "Aviso de Siniestro");
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
	    // 	------------------------------------------------------------------------------------

		
		 AvisoSiniestroForm formBean = (AvisoSiniestroForm)form;
		
		/**
		 * @author rlozano
		 * @description se setea BI-DIRECCIONAL en el tipo de suspensión como valor por defecto.
		 */
		String botonSeleccionado=formBean.getBtnSeleccionado();
		if (formBean.getTipoSuspensionSel() != null && !formBean.getTipoSuspencion().equals(formBean.getTipoSuspensionSel())){
			formBean.setTipoSuspencion(formBean.getTipoSuspensionSel());
		}
		botonSeleccionado=botonSeleccionado==null?"":botonSeleccionado;
		String tipoSuspension="";
		if ("".equals(botonSeleccionado)){
			seccion = objetoXML.obtenerSeccion(objetoXMLSession, "tipoSuspension", "tipoSuspencionSeccion");
			
			//Obtengo el valor del xml 
			tipoSuspension=seccion.obtControl("tipoSuspensionCB").getValorDefecto();
			tipoSuspension=tipoSuspension!=null&&"".equals(tipoSuspension)?"NO":tipoSuspension.trim();
						request.setAttribute("tipoSuspension",tipoSuspension);
			formBean.setTipoSiniestro("");
		}	
//--------------------------------------------------------------------
	    
	    
	    UsuarioAbonadoDTO usuarioAbonado = new UsuarioAbonadoDTO();

	    Long numAbonadoLong = new Long (sessionData.getNumAbonado());
	    usuarioAbonado.setNum_abonado(numAbonadoLong.longValue());

	    // Busco los datos para la cabecera de las paginas
	    usuarioAbonado = delegate.obtenerDatosUsuarioAbonado(usuarioAbonado);
	    session.setAttribute("usuarioAbonado", usuarioAbonado);

// 		------------------------------------------------------------------------------------
	    
	   
    
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
		    String actAvisoSin = global.getValor("ACT_AVISOSINIESTRO");		    
		    
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
		    
		    // No acepto el cambio de plan comercial
		    if ((formBean.getBtnSeleccionado() != null) && (formBean.getBtnSeleccionado().equals("noAceptaPlanComercial")))
		    	return mapping.findForward("cerrar");
		    
		    // Efectuo la grabacion---ya no graba, se traspásó a registrar action
		    if ((formBean.getBtnSeleccionado() != null) && (formBean.getBtnSeleccionado().equals("grabar")))	{
		    	sessionData.setSinCondicionesComerciales(((AvisoSiniestroForm)form).getCondicH());
		    	formBean.setBtnSeleccionado(null);
		    	session.setAttribute("ultimaPagina","negocio");//Controlador de Flujo
		    	
		    	sessionData.setCargosObtenidos(null);//Limpieza de Cargos
		    	return mapping.findForward("finalizar");
		    } // if
		    else	{
		    	// SE INICIA LA CARGA DE PAGINA
			    // Carga de combos
			    // Ejecuta las restricciones de ejecucion para esta funcionalidad	
			    UsuarioSistemaDTO usuarioSistema = (UsuarioSistemaDTO)session.getAttribute("usuarioSistema");
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
			    logger.debug("mensajes.getMensaje()["+mensajes.getMensaje()+"]");
			    // verifico que restricciones se han cumplido y guardo el mensaje}
			    // si textoMensajeRestricciones==OK entonces no problem
			    String textoMensajeRestricciones = delegate.verificaEjecucionRestrccion(mensajes);
			    logger.debug("textoMensajeRestricciones["+textoMensajeRestricciones+"]"); 		
			    if (!(textoMensajeRestricciones.equals("OK")))	{
			    	delegate.guardaMensajesError(request, "Ha ocurrido uno o varios errores al validar las restricciones.", textoMensajeRestricciones);
			    	logger.debug("mapping.findForward(error)"); 
			    	return mapping.findForward("error");
					
			    }	// if
			    
//			  ------------------------------------------------------------------------------------------------------------------
			    		    
			    // Seteo los valores iniciales que tendra el formulario
			    formBean.setNroAbonado(sessionData.getNumAbonado());
			    formBean.setTecnologia(usuarioAbonado.getDes_terminal());

			    try	{
				    // Busco el numero de celular del abonado
				    AbonadoDTO abonado = new AbonadoDTO();
				    AbonadoDTO abonadoParam = new AbonadoDTO();
				    abonadoParam.setNumAbonado(sessionData.getNumAbonado());
				    abonadoParam.setCodCliente(sessionData.getCodCliente());
				    abonado = delegate2.obtenerDatosAbonado2(abonadoParam);
				    abonadoParam = delegate.obtenerDatosAbonado(abonadoParam);
					abonado.setNumCelular(abonadoParam.getNumCelular());
					abonado.setNumSerie(abonadoParam.getNumSerie());
					abonado.setSimCard(abonadoParam.getSimCard());
					abonado.setCodTecnologia(abonadoParam.getCodTecnologia());
					abonado.setCodSituacion(abonadoParam.getCodSituacion());
					abonado.setDesSituacion(abonadoParam.getDesSituacion());
					abonado.setCodPlanServ(abonadoParam.getCodPlanServ());
					abonado.setCodTipContrato(abonadoParam.getCodTipContrato());
					abonado.setFecAlta(abonadoParam.getFecAlta());
					abonado.setFecFinContrato(abonadoParam.getFecFinContrato());
					abonado.setIndEqPrestado(abonadoParam.getIndEqPrestado());
					abonado.setFecProrroga(abonadoParam.getFecProrroga());
					abonado.setFlgRango(abonadoParam.getFlgRango());
					abonado.setImpCargoBasico(abonadoParam.getImpCargoBasico());
					abonado.setCodCentral(abonadoParam.getCodCentral());
					abonado.setCodUso(abonadoParam.getCodUso());
					abonado.setCodVendedor(abonadoParam.getCodVendedor());		
					abonado.setCodCiclo(abonadoParam.getCodCiclo());
				    
				    formBean.setNroTerminal(abonado.getNumCelular());
			    }	// try
			    catch (Exception ex){
			    	formBean.setNroTerminal(0);
			    } // catch

			    CausaSiniestroDTO[] causaSiniestroLista;
			    causaSiniestroLista = delegate.obtenerCausasSiniestro(usuarioAbonado, actAvisoSin);
			    if (causaSiniestroLista != null){
			    	for (int i=0;i<causaSiniestroLista.length;i++){
			    		logger.debug("causa cod causa     [" + i + "] (" + causaSiniestroLista[i].getCod_causa() + ")");
			    		logger.debug("causa cod causausp  [" + i + "] (" + causaSiniestroLista[i].getCod_caususp() + ")");
			    		logger.debug("causa cod servicio  [" + i + "] (" + causaSiniestroLista[i].getCod_servicio() + ")");
			    		logger.debug("causa des causa     [" + i + "] (" + causaSiniestroLista[i].getDes_causa() + ")");
			    		logger.debug("causa lvcod servicio[" + i + "] (" + causaSiniestroLista[i].getLv_cod_servicio() + ")");
			    	}
			    }
			    
			    TipoSiniestroDTO[] tipoSiniestroLista;
			    tipoSiniestroLista = delegate.obtenerTiposDeSiniestros(usuarioAbonado);
			    
			    TipoSuspencionDTO[] tipoSuspencionLista;
			    tipoSuspencionLista = delegate.obtenerTiposDeSuspencion();
			    logger.debug("Despues de obtener los tipos de suspencion");
			    for( int i=0;(tipoSuspencionLista!=null)&&i<tipoSuspencionLista.length;i++){
			    	logger.debug("codTipoSupencion " + i + " [" + tipoSuspencionLista[i].getCod_TipoSuspencion() + "]");
			    	logger.debug("desTipoSupencion " + i + " [" + tipoSuspencionLista[i].getDes_TipoSuspencion() + "]");
			    	String codTipSusp=tipoSuspencionLista[i].getCod_TipoSuspencion();
			    	codTipSusp=codTipSusp==null?"":codTipSusp;
			    	if (codTipSusp.equals(tipoSuspension)){
			    		formBean.setTipoSuspencion(tipoSuspension);
			    	}
			    		
			    }

			    CambioPlanPendienteDTO cambioPlan = new CambioPlanPendienteDTO();
			    cambioPlan.setCod_cliente(usuarioAbonado.getCod_cliente());
			    cambioPlan.setNum_abonado(usuarioAbonado.getNum_abonado());
			    cambioPlan.setCod_plantarif(usuarioAbonado.getCodPlantarif());
			    cambioPlan = delegate.validarCambioPlanPendiente(cambioPlan);

			    request.setAttribute("retornoCambioPlan", cambioPlan.getCod_retorno());
			    request.setAttribute("glosaCambioPlan", "El abonado tiene cambio de plan pendiente, si continúa la programación será anulada.");
			    
			    request.setAttribute("tipoSuspencionLista", tipoSuspencionLista);
			    request.setAttribute("tipoSiniestroLista", tipoSiniestroLista);
			    request.setAttribute("causaSiniestroLista", causaSiniestroLista);
			    request.setAttribute("titulo", "Aviso de Siniestro");
		 		
		    }	// else
	    }	// else

		return mapping.findForward("inicio");

	}  // execute
	
// ------------------------------------------------------------------------------------------------------------------------
	
}  // AvisoSiniestroAction
