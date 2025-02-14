package com.tmmas.scl.operations.crm.fab.cusintman.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.scl.framework.ProductDomain.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.ss911correofax.negocio.ejb.ServSupl911CorreoFaxFacade;
import com.tmmas.scl.framework.ProductDomain.dto.ReglasSSDTO;
import com.tmmas.scl.framework.ProductDomain.dto.RestriccionesDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SSuplementarioDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.OperadoraLocalDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.SeccionDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ValoresJSPPorDefectoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.ServiciosSuplementariosBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cusintman.web.form.ServiciosSuplementariosForm;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Global;
import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException;
import com.tmmas.scl.operations.frmkooss.web.businessObject.bo.XMLDefault;
import com.tmmas.scl.operations.frmkooss.web.businessObject.dao.ParseoXML;

public class ServiciosSuplementariosAction extends BaseAction {
	
	private final Logger logger = Logger.getLogger(ServiciosSuplementariosAction.class);
	private Global global = Global.getInstance();
	private ServiciosSuplementariosBussinessDelegate delegate = ServiciosSuplementariosBussinessDelegate.getInstance();
	private HttpSession session;
	
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
	    
//	  -----------------------------------------------------
	    session.setAttribute("nombreOOSS", "Servicios Suplementarios");
	    String nombreOperadora = "";
	    OperadoraLocalDTO operadora = delegate.obtenerOperadoraLocal();
	    session.setAttribute("ultimaPagina",null);
	    if("TMG".equals(operadora.getOperadora()))
	     {
	    	 nombreOperadora = global.getValor("NOM_OPERADORA_TMG");
	    }else
	    {
	    	nombreOperadora = global.getValor("NOM_OPERADORA_TMS");
	    }
	    
	    
	    try{ 	
		    session.setAttribute("operadora", nombreOperadora);
	// 		------------------------------------------------------------------------------------
		    //
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
		
		    // ------------------------------------------------------------------------------------
		    // Configuracion de orden de servicio comisionable
		    // ------------------------------------------------------------------------------------
			
			seccion = objetoXML.obtenerSeccion(objetoXMLSession, "OOSSComisionable", "Configuracion");
			session.setAttribute("oossComisionable", seccion.obtControl("ConfigComis").getHabilitado());
			
			seccion = objetoXML.obtenerSeccion(objetoXMLSession, "ConfiguracionGeneral", "config");
			session.setAttribute("cantidad.maxima.celulares", seccion.obtControl("cantidad.maxima.celulares").getValorDefecto());
			// ------------------------------------------------------------------------------------			
		    
		    UsuarioAbonadoDTO usuarioAbonado = new UsuarioAbonadoDTO();
	
		    Long numAbonadoLong = new Long (sessionData.getNumAbonado());
		    usuarioAbonado.setNum_abonado(numAbonadoLong.longValue());
	
		    // Busco los datos para la cabecera de las paginas
		    
		   	usuarioAbonado = delegate.obtenerDatosUsuarioAbonado(usuarioAbonado);
	    
		    session.setAttribute("usuarioAbonado", usuarioAbonado);
		    
		    UsuarioSistemaDTO usuarioSistema = (UsuarioSistemaDTO)session.getAttribute("usuarioSistema");
	// 		------------------------------------------------------------------------------------
		    
		    ServiciosSuplementariosForm formBean = (ServiciosSuplementariosForm)form;
		    
	
			
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
			    String actAvisoSin = global.getValor("ACT_SERVICIOSSUPLEMENTARIOS");		    
			    
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
	
			    // Efectuo la grabacion
			    if ((formBean.getBtnSeleccionado() != null) && (formBean.getBtnSeleccionado().equals("grabar")))	{
			    	sessionData.setSinCondicionesComerciales(((ServiciosSuplementariosForm)form).getCondicH());
			    	formBean.setBtnSeleccionado(null);
			    	
	//		 		------------------------------------------------------------------------------------
				    // No se selecciono ningun vendedor, la ooss debe finalizar
				    if ((session.getAttribute("Vendedor") == null) && (usuarioSistema.getCall_center().equals("S")))
				    	if (!(session.getAttribute("oossComisionable").toString().equals("NO")))
				    		return mapping.findForward("cerrar");
	//		 		------------------------------------------------------------------------------------	    
	
			    	// Son los strigs para la grabacion de la ooss
			    	session.setAttribute("textoNoContratados", formBean.getTextoNoContratados());
			    	session.setAttribute("textoContratados", formBean.getTextoContratados());
	
			    	// -------------------------------------------------------------------------------------------
			    	// Esto se hace porque el pl recepta solo el uso de null
			    	if (formBean.getContratadosTabla().equals(""))
			    		session.setAttribute("contratadosTabla", null);
			    	else
			    		session.setAttribute("contratadosTabla", formBean.getContratadosTabla());
	
			    	if (formBean.getNocontratadosTabla().equals(""))
			    		session.setAttribute("nocontratadosTabla", null);
			    	else
			    		session.setAttribute("nocontratadosTabla", formBean.getNocontratadosTabla());
			    	
			    	if (formBean.getAdelantadosTabla().equals(""))
			    		session.setAttribute("adelantadosTabla", null);
			    	else
			    		session.setAttribute("adelantadosTabla", formBean.getAdelantadosTabla());
			    	
			    	// -------------------------------------------------------------------------------------------
			    	session.setAttribute("contactosTabla", formBean.getContactosTabla());
			    	session.setAttribute("grabarFax", formBean.getGrabarFax());
			    	// -------------------------------------------------------------------------------------------
			    	
			    	
			    	//Controlador de Flujo
			    	/*
			    	// LLeno todos los objetos para la grabacion
			    	sessionData.setCargosObtenidos(null);//Limpieza de Cargos
			    	request.setAttribute("mensajeOOSSAviso", "");
			    	*/
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
				 
					// ------------------------------------------------------------------------------------------------------------------
					// Estos valores se integran al script js on the fly para comparar si el ss seleccionado corresponde
					// a uno de estos grupos, ya que debe mostrarse un componente adicional.
					
					//	Obtiene valores de los grupos especiales 911 - FAX - CORREO MOVISTAR
					ParametrosGeneralesDTO parametro911 = new ParametrosGeneralesDTO();
					parametro911.setCodigoproducto(global.getValor("codigo.producto"));
					parametro911.setCodigomodulo(global.getValor("codigo.modulo.GA"));
					parametro911.setNombreparametro(global.getValor("parametro.911"));
					parametro911 = delegate.getParametroGeneral(parametro911);
					session.setAttribute("icgServicioAsistencia911", parametro911.getValorparametro() );
			
					ParametrosGeneralesDTO maxContactos = new ParametrosGeneralesDTO();
					maxContactos.setCodigoproducto(global.getValor("codigo.producto"));
					maxContactos.setCodigomodulo(global.getValor("codigo.modulo.GA"));
					maxContactos.setNombreparametro(global.getValor("parametro.max.contactos"));
					maxContactos = delegate.getParametroGeneral(maxContactos);
					session.setAttribute("maxContactos911", maxContactos.getValorparametro());		
			
					ParametrosGeneralesDTO parametroCMovistar = new ParametrosGeneralesDTO();
					parametroCMovistar.setCodigoproducto(global.getValor("codigo.producto"));
					parametroCMovistar.setCodigomodulo(global.getValor("codigo.modulo.GA"));
					parametroCMovistar.setNombreparametro(global.getValor("parametro.correo.movistar"));
					parametroCMovistar = delegate.getParametroGeneral(parametroCMovistar);		
					session.setAttribute("icgServicioCorreoMovistar", parametroCMovistar.getValorparametro());
			
					ParametrosGeneralesDTO parametroFAX = new ParametrosGeneralesDTO();
					parametroFAX.setCodigoproducto(global.getValor("codigo.producto"));
					parametroFAX.setCodigomodulo(global.getValor("codigo.modulo.GA"));
					parametroFAX.setNombreparametro(global.getValor("parametro.fax"));
					parametroFAX = delegate.getParametroGeneral(parametroFAX);
					session.setAttribute("icgServicioFax", parametroFAX.getValorparametro());

					SeccionDTO configuracionGeneral=new SeccionDTO();
					configuracionGeneral = objetoXML.obtenerSeccion(objetoXMLSession, "ConfiguracionGeneral", "enlaces");
					session.setAttribute("urlContactos911", configuracionGeneral.obtControl("contactos911").getValorDefecto());
   
				      //Obtiene cantidad de decimales usados en facturación
					ParametrosGeneralesDTO parametroDecimal = new ParametrosGeneralesDTO();
					parametroDecimal.setCodigoproducto(global.getValor("codigo.producto"));
					parametroDecimal.setCodigomodulo(global.getValor("codigo.modulo.GE"));
					parametroDecimal.setNombreparametro(global.getValor("parametro.decimal.facturacion"));
					parametroDecimal = delegate.getParametroGeneral(parametroDecimal);
					
					session.setAttribute("parametroDecimal", parametroDecimal.getValorparametro());
					
	//			  ------------------------------------------------------------------------------------------------------------------
				    		    
				    // Seteo los valores iniciales que tendra el formulario
				    SSuplementarioDTO[] srvServiciosAct = null;
				    srvServiciosAct = delegate.obtenerServiciosContratados(usuarioAbonado, 2);
	
				    SSuplementarioDTO[] listaServiciosDef = null;
				    listaServiciosDef = delegate.obtenerServiciosContratados(usuarioAbonado, 1);
				    
				    SSuplementarioDTO[] srvServiciosDisp = null;
				    srvServiciosDisp = delegate.obtenerServiciosDisplonibles(usuarioAbonado, sesionDTO);
	
				    // Busca en los servicios activados si alguno corresponde a fax, y si lo encuentra entonces lo elimina
				    // de los servicios suplementarios disponibles 
				    SSuplementarioDTO[] srvServicios = delegate.filtrarGrupoenSSDisponibles(srvServiciosAct, srvServiciosDisp, parametroFAX.getValorparametro());
				    srvServiciosDisp = srvServicios; 

				    // Obtengo las reglas de validacion
				    ReglasSSDTO reglasValidacion[]=null;
				    reglasValidacion = delegate.getReglasdeValidacionSS(usuarioAbonado, sessionData.getAbonados()[0]); 
	
				    // Codigo de vendedor
				    
				    // ----------------------------------------------------------
				    // Si es de grupo call center, debe levantar la pantalla  de seleccion de vendedor
				    if ((usuarioSistema.getCall_center() != null) && (usuarioSistema.getCall_center().equals("S")))
				    	request.setAttribute("showVendedor", "SI");
				    else
				    	request.setAttribute("showVendedor", "NO");
	
				    // Si NO es comisionable entonces no debe levantar la pantalla de seleccion de vendedor
				    if (session.getAttribute("oossComisionable").toString().equals("NO"))
				    	request.setAttribute("showVendedor", "NO");
				    					    
				    // Se llama al metodo para ver si tiene servicios BlackBerry contratos
				    // HGG 20/06/08
				    SSuplementarioDTO[] servBBContratados = delegate.getServiciosBBContratados(usuarioAbonado);
	
				    // Para evitar cualquier problema de null, uso este flag para el jsp a fin de crear el js on the fly
				    request.setAttribute("tieneServBBContratados", "NO");
				    // Puede ser nulo si no tiene servicios BB contratados
				    if (servBBContratados != null) {
					    request.setAttribute("tieneServBBContratados", "SI");
				    	request.setAttribute("servBBContratados", servBBContratados);
				    } // if
				    // ---------------------------------------------------------
				    
				    request.setAttribute("reglasValidacion", reglasValidacion);
				    request.setAttribute("listaServiciosAct", srvServiciosAct);
				    request.setAttribute("listaServiciosDef", listaServiciosDef);			    
				    request.setAttribute("listaServiciosDisp", srvServiciosDisp);
				    
				    request.setAttribute("titulo", "Activación y Desactivación de Servicios Suplementarios");
			    }	// else
		    }	// else
	    }
	    catch(GeneralException e){
	    	RetornoDTO retornoDTO=this.getMensajeErrorException(e);
	    	delegate.guardaMensajesError(request, "Ha ocurrido uno o varios errores al validar los Datos de la OOSS", retornoDTO.getDescripcion());
			return mapping.findForward("error");
	    }

		return mapping.findForward("inicio");

	}  // execute
	
	protected RetornoDTO getMensajeErrorException(Object obj){
		RetornoDTO retValue= new RetornoDTO();
		try{
			GeneralException geExep=(GeneralException)obj;
			int cont=0;
			while (geExep.getCodigo()==null&&cont<10){
				geExep=(GeneralException)geExep.getCause();
				cont++;
			}
			
			retValue.setCodigo(geExep.getCodigo());
			retValue.setDescripcion(geExep.getDescripcionEvento()+"[evento : "+geExep.getCodigoEvento()+"]");
			retValue.setResultado(false);
			
		}
		catch(Exception e){
			retValue.setCodigo("1");
			retValue.setDescripcion("NO es posible recuperar la descripción original del Error");
			retValue.setResultado(false);
		}
		return retValue;
	}
	
// ------------------------------------------------------------------------------------------------------------------------


}  // ServiciosSuplementariosAction
