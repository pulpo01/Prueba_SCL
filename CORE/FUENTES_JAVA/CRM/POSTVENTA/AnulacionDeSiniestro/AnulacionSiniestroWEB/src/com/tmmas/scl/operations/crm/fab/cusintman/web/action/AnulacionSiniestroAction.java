package com.tmmas.scl.operations.crm.fab.cusintman.web.action;

import java.sql.Timestamp;
import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.framework.ProductDomain.dto.ParametrosGeneralesDTO;
import com.tmmas.scl.framework.ProductDomain.dto.RestriccionesDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SiniestrosDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.SeccionDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ValoresJSPPorDefectoDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.AnulacionSiniestroBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cusintman.web.form.AnulacionSiniestroForm;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Global;
import com.tmmas.scl.operations.frmkooss.web.businessObject.bo.XMLDefault;
import com.tmmas.scl.operations.frmkooss.web.businessObject.dao.ParseoXML;

public class AnulacionSiniestroAction extends Action {
	
	private final Logger logger = Logger.getLogger(AnulacionSiniestroAction.class);
	private Global global = Global.getInstance();
	private AnulacionSiniestroBussinessDelegate delegate = AnulacionSiniestroBussinessDelegate.getInstance();
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

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
	    //-----------------------------------------------------
	    session.setAttribute("nombreOOSS", "Anulación de Siniestro");
	    session.setAttribute("operadora", global.getValor("NOM_OPERADORA"));
		// ------------------------------------------------------------------------------------
	   //Incluido santiago ventura 23-03-2010		
		//SE OBTIENE EL PARAMETRO GENERAL QUE VERIFICA SI EL NUMERO DE CONTRADENUNCIA ES REQUERIDO(ANULA NUM CONST POL)
		ParametrosGeneralesDTO pGeneralesDTO = new ParametrosGeneralesDTO();
		pGeneralesDTO.setNombreparametro(global.getValor("nom.parametro"));
		pGeneralesDTO.setCodigomodulo(global.getValor("modulo"));
		pGeneralesDTO.setCodigoproducto(global.getValor("producto"));
		pGeneralesDTO = delegate.getParametroGeneral(pGeneralesDTO);
		String reqContradenuncia = pGeneralesDTO.getValorparametro();
		logger.info("Parametro general que verifica si el numero de contradenuncia es requerido, valor = "+reqContradenuncia);
		session.setAttribute("reqContradenuncia", reqContradenuncia);
		// ------------------------------------------------------------------------------------	    
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
		
		
//--------------------------------------------------------------------
	    UsuarioAbonadoDTO usuarioAbonado = new UsuarioAbonadoDTO();

	    Long numAbonadoLong = new Long (sessionData.getNumAbonado());
	    usuarioAbonado.setNum_abonado(numAbonadoLong.longValue());

	    // Busco los datos para la cabecera de las paginas
	    usuarioAbonado = delegate.obtenerDatosUsuarioAbonado(usuarioAbonado);
	    session.setAttribute("usuarioAbonado", usuarioAbonado);

	    String codigoPrograma = global.getValor("codigoPrograma");
	    String versionPrograma = global.getValor("versionPrograma");
	    Long versionProgramaLong = new Long (versionPrograma);
	    
	    SesionDTO sesionDTO = new SesionDTO();
	    
	    sesionDTO.setCodCliente(sessionData.getCliente().getCodCliente());
	    sesionDTO.setCod_programa(codigoPrograma);
	    sesionDTO.setNum_version(versionProgramaLong.longValue());
	    sesionDTO.setNumAbonado(numAbonadoLong.longValue());
	    
	    // Almaceno el usuario del sistema
	    UsuarioSistemaDTO usuario = new UsuarioSistemaDTO();
	    usuario.setNom_usuario(sessionData.getUsuario());
	    sesionDTO.setUsuario(usuario);
	    
// 		------------------------------------------------------------------------------------
	    
	    // Ejecuta las restricciones de ejecucion para esta funcionalidad	
	    UsuarioSistemaDTO usuarioSistema = (UsuarioSistemaDTO)session.getAttribute("usuarioSistema");
	    session.setAttribute("usuarioSistema", usuarioSistema);
    
	    AnulacionSiniestroForm formBean = (AnulacionSiniestroForm)form;
	    session.setAttribute("formbean", formBean);
	    String condicion = formBean.getCondicionError();
	    
	    
	   
	    
	    if ((condicion != null)	&& (!(condicion.trim().equals(""))))	{ 
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
		    // Efectuo la grabacion
		    if ((formBean.getBtnSeleccionado() != null) && (formBean.getBtnSeleccionado().equals("grabar")))	{
		    	sessionData.setSinCondicionesComerciales(((AnulacionSiniestroForm)form).getCondicH());
		    	formBean.setBtnSeleccionado(null);
		    	session.setAttribute("ultimaPagina","negocio");//Controlador de Flujo
		    	sessionData.setCargosObtenidos(null);//Limpieza de Cargos
		    	return mapping.findForward("finalizar");
		    }
		    else	{
		    	// SE INICIA LA CARGA DE PAGINA
			    // Armo el string con todos los parametros separados con pipes
			    String actAvisoSin = global.getValor("ACT_ANULACIONSINIESTRO");
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
			    
//		 		------------------------------------------------------------------------------------		    	
			    // Carga de combos
			    
			    // Cargo los datos para la grilla
			    SiniestrosDTO[] listaSiniestros = delegate.recDatosSiniestroAboando(usuarioAbonado);
			    //------------------------------------------------------------------------------------
			    //Veo si no me trajo siniestros para mostrar el mensaje de error
			    
			    String srtFecHoy = "";
			    if (listaSiniestros==null || listaSiniestros.length==0){
			    	request.setAttribute("sinSiniestros", "No se encontraron siniestros para el abonado");
			    } else {
				    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd"); 				    
				    srtFecHoy = sdf.format(Calendar.getInstance().getTime());		    
				    
			    	for (int i = 0; i < listaSiniestros.length; i++) {
			    		SiniestrosDTO sin = listaSiniestros[i];
			    		logger.info("num siniestro "+sin.getNum_siniestro());
			    		logger.info("num constapol "+sin.getNum_constpol());
			    		logger.info("num terminal "+sin.getNum_terminal());
			    		logger.info("des terminal "+sin.getDes_terminal());
			    		if (listaSiniestros[i].getFec_anula()==null){
				    		logger.info("fec Anula "+srtFecHoy);
			    			listaSiniestros[i].setSrt_fec_anula(srtFecHoy);
			    		} else {
			    			listaSiniestros[i].setSrt_fec_anula(sdf.format(listaSiniestros[i].getFec_anula()));
			    		}
					}
			    }
			    
			    // ------------------------------------------------------------------------
			    
			    session.setAttribute("titulo", "Anulación de Siniestro");
				//Incluido santiago ventura 23-03-2010			    
			    session.setAttribute("listaSiniestros", listaSiniestros);
			    session.setAttribute("fec_Anula", srtFecHoy);
		    }	// else
	    }	// else

		return mapping.findForward("inicio");

	}  // execute
	
// ------------------------------------------------------------------------------------------------------------------------
	
}  // AnulacionSiniestroAction
