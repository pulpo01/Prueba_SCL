package com.tmmas.scl.operations.crm.fab.cusintman.web.action;

import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.scl.framework.ProductDomain.dto.CausaCamSerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.RestriccionesDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TecnologiaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoDeContratoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoTerminalDTO;
import com.tmmas.scl.framework.ProductDomain.dto.UsosVentaDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.OperadoraLocalDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.SeccionDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ValoresJSPPorDefectoDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.CambioSimCardBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cusintman.web.form.CambioDeSimCardForm;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Global;
import com.tmmas.scl.operations.frmkooss.web.businessObject.bo.XMLDefault;
import com.tmmas.scl.operations.frmkooss.web.businessObject.dao.ParseoXML;
import com.tmmas.scl.vendedor.dto.VendedorDTO;
public class CambioDeSimCardAction extends Action {
	
	private final Logger logger = Logger.getLogger(CambioDeSimCardAction.class);
	private Global global = Global.getInstance();
	private CambioSimCardBussinessDelegate delegate = CambioSimCardBussinessDelegate.getInstance();
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		/*
		// Configuro el path para el log4j
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);*/
		// ------------------------------------------------------------------------------------
		
		// Agrego una entrada al log
		logger.debug("execute():start");

		// Tomo los datos iniciales del cliente que estan en sesion
	    ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
	    HttpSession session = request.getSession(false);
	    sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
	    
	    //---------------------------------------------------
	    session.setAttribute("nombreOOSS", "Cambio de SimCard");
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
		
		
		
		
//------------------------------------------------------------------------------------------
	    
	    UsuarioAbonadoDTO usuarioAbonado = new UsuarioAbonadoDTO();

	    Long numAbonadoLong = new Long (sessionData.getNumAbonado());
	    usuarioAbonado.setNum_abonado(numAbonadoLong.longValue());

	    // Busco los datos para la cabecera de las paginas
	    usuarioAbonado = delegate.obtenerDatosUsuarioAbonado(usuarioAbonado);
	    session.setAttribute("usuarioAbonado", usuarioAbonado);

	    SesionDTO sesionDTO = new SesionDTO();
	    sesionDTO.setCodCliente(sessionData.getCliente().getCodCliente());
	    
	    // Almaceno el usuario del sistema
	    UsuarioSistemaDTO usuario = new UsuarioSistemaDTO();
	    usuario.setNom_usuario(sessionData.getUsuario());
	    sesionDTO.setUsuario(usuario);

	    // ------------------------------------------------------------------------
		String codigoPrograma = global.getValor("codigoPrograma");
	    String versionPrograma = global.getValor("versionPrograma");
	    Long versionProgramaLong = new Long (versionPrograma);
	    
	    sesionDTO.setCod_programa(codigoPrograma);
	    sesionDTO.setNum_version(versionProgramaLong.longValue());
	    sesionDTO.setNumAbonado(numAbonadoLong.longValue());
	    
// 		------------------------------------------------------------------------------------
	    
	    // Ejecuta las restricciones de ejecucion para esta funcionalidad	
	    UsuarioSistemaDTO usuarioSistema = (UsuarioSistemaDTO)session.getAttribute("usuarioSistema");
	    session.setAttribute("usuarioSistema", usuarioSistema);
	    
	    // Armo el string con todos los parametros separados con pipes
	    String actAvisoSin = global.getValor("ACT_SIMCARD");
	    String parametros = delegate.parametrosRestriccion("", actAvisoSin, usuarioSistema, usuarioAbonado, sessionData);

	    // Tomo el valor del properties y ejecuto las restricciones
	    RestriccionesDTO restriccion = new RestriccionesDTO();	                                                                                                                                                                                                                                                                                                                
	    restriccion.setCod_actuacion(global.getValor("ACT_SIMCARD"));
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
	    
// 		------------------------------------------------------------------------------------
	    
	    CambioDeSimCardForm formBean = (CambioDeSimCardForm)form;
	    String condicion = formBean.getCondicionError(); 
	    /***
	     * @author rlozano
	     * @description Se setea valor de numero transaccion de Bloqueo y Desbloqueo 
	     */
	    
	    session.setAttribute("numTransaccionBloqDes", String.valueOf(formBean.getNumTransaccionBloqDes()));

	    // ------------------------------------------------------------------------------------
	    // Configuracion de orden de servicio comisionable
	    // ------------------------------------------------------------------------------------
		
		objetoXMLSession = sessionData.getDefaultPagina();
		seccion = objetoXML.obtenerSeccion(objetoXMLSession, "OOSSComisionable", "Configuracion");
		session.setAttribute("oossComisionable", seccion.obtControl("ConfigComis").getHabilitado());
		// ------------------------------------------------------------------------------------
	    
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
	    else
		    // Si hay que efectuar el proceso de negocio
		    if ((formBean.getBtnSeleccionado() != null) && (formBean.getBtnSeleccionado().equals("grabar")))	{
		    	sessionData.setSinCondicionesComerciales(((CambioDeSimCardForm)form).getCondicH());
		    	formBean.setBtnSeleccionado(null);
		    	session.setAttribute("ultimaPagina","negocio");//Controlador de Flujo
		    	sessionData.setCargosObtenidos(null);//Limpieza de Cargos
		    	
//		 		------------------------------------------------------------------------------------
			    // No se selecciono ningun vendedor, la ooss debe finalizar
			    if ((session.getAttribute("Vendedor") == null) && (usuarioSistema.getCall_center().equals("S"))){ 
			    	if (!(session.getAttribute("oossComisionable").toString().equals("NO"))) {			    		
			    		return mapping.findForward("cerrar");
			    	}
			    }				
			    		
			    VendedorDTO vendedor = new VendedorDTO();
	    		if (session.getAttribute("Vendedor") == null){
	    			vendedor.setCod_vendedor(String.valueOf(usuarioSistema.getCod_vendedor()));
	    			vendedor.setNom_vendedor(usuarioSistema.getNom_usuario());
	    			vendedor.setCod_os(String.valueOf(sessionData.getCodOrdenServicio()));
	    			vendedor.setNumOOSS(String.valueOf(sessionData.getNumOrdenServicio()));
	    			vendedor.setFecha(new Date());
	    			vendedor.setCod_tipcomis(usuarioSistema.getCod_tipcomis());
	    			vendedor.setInd_interno(true);
	    			vendedor.setUsuario(usuarioSistema.getNom_usuario());
	    			vendedor.setCod_oficina(usuarioSistema.getCod_oficina());
	    			session.setAttribute("Vendedor", vendedor);
	    		}				    
//		 		------------------------------------------------------------------------------------	
			    
			    
			    
		    	
		    	/**
		    	 * @author ggaletti 
		    	 * @description se setea los valores para ser obtenidos en el action de cargos para l aactivacion de la regal de simcard
		    	 */
		    	
		    	session.setAttribute("CambioSimcardForm", form);
		    	
		    	sessionData.setModalidad(String.valueOf(formBean.getModalidadPago()));
		    	sessionData.setTipoContrato(formBean.getTipoContrato());
		    	
		    	String[] codAbonado=new String[1];
	    	
		    	return mapping.findForward("finalizar");
		    } // if
		    else	{	    	
		    	// SE INICIA LA CARGA DE PAGINA
			    // Carga de combos
			   // TipoDeContratoDTO[] tiposContratoLista = null;
		
			    CausaCamSerieDTO[] causaCambioLista = null;
			    causaCambioLista = delegate.obtenerCausaCambioSerie();
			    ArrayList listaContratos=new ArrayList();
			    TipoDeContratoDTO[] tiposContratoLista = null;
			    TipoDeContratoDTO tipoDeContratoDTO=new TipoDeContratoDTO();
			    
			    //tiposContratoLista = delegate.obtenerTiposDeContrato(sesionDTO);
			    tipoDeContratoDTO.setCod_tipcontrato(usuarioAbonado.getCodTipContrato());
			    tipoDeContratoDTO.setDes_tipcontrato(usuarioAbonado.getDes_tipcontrato());
			    listaContratos.add(tipoDeContratoDTO);
			    tiposContratoLista=(TipoDeContratoDTO[])ArrayUtl.copiaArregloTipoEspecifico(listaContratos.toArray(),TipoDeContratoDTO.class); 
			    
			    
			    
			    //------------------------------------------------------------------
			    //Para utilizarlo en el action de registrar
			    session.setAttribute("sesionDTO", sesionDTO);
			    
			    //--------------------------------------------------------------------
		
			    UsosVentaDTO[] usosLista = null;
			    usosLista = delegate.obtenerUsosVenta();
		
			    TecnologiaDTO tecnologia = new TecnologiaDTO();
			    tecnologia.setCod_tecnologia(null);
			    TipoTerminalDTO[] terminalesLista = null;
			    terminalesLista = delegate.obtenerTipoTerminal(tecnologia);
			    
			    // ----------------------------------------------------------
			    // Si es de grupo call center, debe levantar la pantalla  de seleccion de vendedor
			    if ((usuarioSistema.getCall_center() != null) && (usuarioSistema.getCall_center().equals("S")))
			    	request.setAttribute("showVendedor", "SI");
			    else
			    	request.setAttribute("showVendedor", "NO");
			    	
			    // Si NO es comisionable entonces no debe levantar la pantalla de seleccion de vendedor
			    if (session.getAttribute("oossComisionable").toString().equals("NO"))
			    	request.setAttribute("showVendedor", "NO");	
			    
			    request.setAttribute("terminalesLista", terminalesLista);
			    request.setAttribute("usosLista", usosLista);
			    request.setAttribute("tiposContratoLista", tiposContratoLista);
			    request.setAttribute("causaCambioLista", causaCambioLista);
			    request.setAttribute("titulo", "Cambio de SimCard");
		    }	// else
	    

	    return mapping.findForward("inicio");

	}  // execute
	
	
	
// ------------------------------------------------------------------------------------------------------------------------
	
}  // CambioDeSimCardAction
