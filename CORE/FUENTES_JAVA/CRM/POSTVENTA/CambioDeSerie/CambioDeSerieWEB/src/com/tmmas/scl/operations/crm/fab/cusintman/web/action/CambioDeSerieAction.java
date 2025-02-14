package com.tmmas.scl.operations.crm.fab.cusintman.web.action;

import java.util.ArrayList;
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

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.scl.framework.ProductDomain.dto.BodegaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaCamSerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.MesesProrrogasDTO;
import com.tmmas.scl.framework.ProductDomain.dto.RestriccionesDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TecnologiaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoDeContratoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.UsosVentaDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.OperadoraLocalDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.SeccionDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ValoresJSPPorDefectoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.CambioSerieBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cusintman.web.form.CambioDeSerieForm;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Global;
import com.tmmas.scl.operations.frmkooss.web.businessObject.bo.XMLDefault;
import com.tmmas.scl.operations.frmkooss.web.businessObject.dao.ParseoXML;
import com.tmmas.scl.operations.frmkooss.web.delegate.FrmkOOSSBussinessDelegate;
import com.tmmas.scl.vendedor.dto.VendedorDTO;
public class CambioDeSerieAction extends Action {
	
	private final Logger logger = Logger.getLogger(CambioDeSerieAction.class);
	private Global global = Global.getInstance();
	private CambioSerieBussinessDelegate delegate = CambioSerieBussinessDelegate.getInstance();
	private FrmkOOSSBussinessDelegate delegateFrmkOSS=FrmkOOSSBussinessDelegate.getInstance();
	
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
	    

		String archivo = System.getProperty("user.dir")+global.getValor("ruta.xml")+global.getValor("xml.valoresdefecto");
		ParseoXML parseo=new ParseoXML();
		logger.debug("leyendo y parseando XML configuración:antes");
		//logger.debug("archivo "+archivo);
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
	    session.setAttribute("nombreOOSS", "Cambio de Serie");
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
	    
		// --------------------------------------------------------------------
	    
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

		logger.debug("codigoPrograma:" + codigoPrograma); // RRG COL 08-03-2009 78629

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
	    String actAvisoSin = global.getValor("ACT_CAMBIOSERIE");
	    String parametros = delegate.parametrosRestriccion("", actAvisoSin, usuarioSistema, usuarioAbonado, sessionData);

	    // Tomo el valor del properties y ejecuto las restricciones
	    RestriccionesDTO restriccion = new RestriccionesDTO();	                                                                                                                                                                                                                                                                                                                
	    restriccion.setCod_actuacion(global.getValor("ACT_CAMBIOSERIE"));
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
	    CambioDeSerieForm formBean = (CambioDeSerieForm)form;
	    String condicion = formBean.getCondicionError(); 
	    
	    
	    session.setAttribute("numTransaccionBloqDes", String.valueOf(formBean.getNumTransaccionBloqDes()));

	    // ------------------------------------------------------------------------------------
	    // Configuracion de orden de servicio comisionable
	    // ------------------------------------------------------------------------------------
		objetoXMLSession = sessionData.getDefaultPagina();
		seccion = objetoXML.obtenerSeccion(objetoXMLSession, "OOSSComisionable", "Configuracion");
		String osComiHabilitado = seccion.obtControl("ConfigComis").getHabilitado();
		logger.debug("osComiHabilitado[" + osComiHabilitado+"]");
		session.setAttribute("oossComisionable", seccion.obtControl("ConfigComis").getHabilitado());
		// ------------------------------------------------------------------------------------
		
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
		
		/**
		 * @author rlozano
		 * @description se cargan valores por defecto
		 * 
		 */
		String botonSeleccionado=formBean.getBtnSeleccionado();
		botonSeleccionado=botonSeleccionado==null?"":botonSeleccionado.trim();
		if (botonSeleccionado.equals("Anterior"))	{
			String isExterno=formBean.getFlagBloqueoEquipoEx();
			isExterno=isExterno==null?"":isExterno.trim();
			if ("1".equals(isExterno)){
				formBean.setProcedNuevoEquipo("E");
			}
		}
		
		
	    
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
		    	sessionData.setSinCondicionesComerciales(((CambioDeSerieForm)form).getCondicH());
		    	formBean.setBtnSeleccionado(null);
		    	session.setAttribute("ultimaPagina","negocio");//Controlador de Flujo
		    	sessionData.setCargosObtenidos(null);//Limpieza de Cargos
		    	request.setAttribute("codArticuloEx",formBean.getCodArticuloTerminal());
//		 		------------------------------------------------------------------------------------
			    // No se selecciono ningun vendedor, la ooss debe finalizar
			    if ((session.getAttribute("Vendedor") == null) && (usuarioSistema.getCall_center().equals("S")))
			    	if (session.getAttribute("oossComisionable").toString().equals("SI"))			    	
			    		return mapping.findForward("cerrar");
//		 		------------------------------------------------------------------------------------	    
		    	
		    	/**
		    	 * @author ggaletti 
		    	 * @description se setea los valores para ser obtenidos en el action de cargos para l aactivacion de la regal de simcard
		    	 */
		    	
		    	session.setAttribute("CambioSerieForm", form);
		    	
		    	sessionData.setModalidad(String.valueOf(formBean.getModalidadPago()));
		    	sessionData.setTipoContrato(formBean.getTipoContrato());
		    	
		    	String[] codAbonado=new String[1];
		    	
		    	
	    	
		    	return mapping.findForward("finalizar");
		    } // if
		    else{	    	
		    	// SE INICIA LA CARGA DE PAGINA
		    	// Carga de combos
			    TipoDeContratoDTO[] tiposContratoLista = null;
			    CausaCamSerieDTO[] causaCambioLista = null;
			    ArrayList lista = new ArrayList() ;
			    
			    String codSeguro = delegate.consultarSeguroAbonado(numAbonadoLong);
			    causaCambioLista = delegate.obtenerCausaCambioSerie();
			    
			    logger.debug("codSeguro[" +  codSeguro+"]");
			    logger.debug("causaCambioLista.length[" +  causaCambioLista.length+"]");
			    if("".equals(codSeguro))
			    {
			    	logger.debug("El abonado no tiene seguro, se procede a filtrar[" +  codSeguro+"]");
			    	for(int i=0;i<causaCambioLista.length;i++)
			    	{
			    		if(causaCambioLista[i].getIndSeguro() == 0)
			    		{
			    			lista.add(causaCambioLista[i]);
			    		}
			    	}
			    	causaCambioLista = (CausaCamSerieDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), CausaCamSerieDTO.class);
			    	logger.debug("causaCambioLista.length(ftr)[" +  causaCambioLista.length+"]");
			    }

			    BodegaDTO[] bodegasLista = null;
		
			    // ------------------------------------------------------------------------
			    bodegasLista = delegate.obtenerBodegas(sesionDTO);

				logger.debug("usuarioAbonado.getInd_procequi():" +  usuarioAbonado.getInd_procequi());// RRG

				sesionDTO.setOrigenSerie(  usuarioAbonado.getInd_procequi() ); // RRG COL 07-03-2009 78629
				sesionDTO.setCod_programa("T"); // RRG COL 07-03-2009 78629
				sesionDTO.setOrigenSerie("I"); // RRG COL 07-03-2009 78629

			    tiposContratoLista = delegate.obtenerTiposDeContrato(sesionDTO);	    
			    // ------------------------------------------------------------------------
			    //Buscamos numero de mes q corresponde a usuario
			    String codTipCont;
			    String numMeses="";
			    for (int k=0;k<tiposContratoLista.length;k++){
			    	codTipCont=tiposContratoLista[k].getCod_tipcontrato().trim();
			    	String codTip=usuarioAbonado.getCodTipContrato().trim();
			    	
			    	if (codTipCont.equals(codTip)){
			    		numMeses=tiposContratoLista[k].getNum_meses();
			    	}
			    }
			    MesesProrrogasDTO[] mesesLista = null;
			    mesesLista = delegate.obtenerMesesProrroga();
			    
			    TecnologiaDTO[] tecnologiasLista = null;
			    tecnologiasLista = delegate.obtenerTecnologia();
			    
			    /***
			     * @author : rlozano
			     * @description : se setea en session el valor de GRUPO_TEC_GSM de l a ged Parametros
			     */
			    ParametroDTO parametroDTO =new ParametroDTO();
			    parametroDTO.setCodModulo(global.getValor("MODULO"));
			    parametroDTO.setCodProducto(Integer.parseInt(global.getValor("parametro.producto.uno")));
			    parametroDTO.setNomParametro(global.getValor("parametro.grupo.tecnologico.gsm"));
			    parametroDTO=delegateFrmkOSS.obtenerParametroGeneral(parametroDTO);

			    // NO APLICA PARA COLOMBIA
			    // CategoriaTributariaDTO[] categoriasTribLista = null;
			    // categoriasTribLista = delegate.obtenerCatTributaria(sesionDTO);
			    
			    UsosVentaDTO[] usosLista = null;
			    usosLista = delegate.obtenerUsosVenta();
			                 
			    request.setAttribute("usosLista", usosLista);
			    // request.setAttribute("categoriasTribLista", categoriasTribLista);
			    request.setAttribute("tecnologiasLista", tecnologiasLista);
			    request.setAttribute("mesesLista", mesesLista);
			    request.setAttribute("bodegasLista", bodegasLista);	    
			    request.setAttribute("tiposContratoLista", tiposContratoLista);
			    request.setAttribute("causaCambioLista", causaCambioLista);
			    request.setAttribute("titulo", "Cambio de Serie");
			    request.setAttribute("tipTerminalSimcard", global.getValor("TIP_TERMINAL_SIMCARD"));
			    request.setAttribute("numMeses", numMeses);
			    request.setAttribute("grupoTecnoGSM", parametroDTO.getValor());
			    
//			  Si es de grupo call center, debe levantar la pantalla  de seleccion de vendedor
			    VendedorDTO vendedorDTO=new VendedorDTO();
			    vendedorDTO=(VendedorDTO)session.getAttribute("Vendedor");
			    String shwVend=vendedorDTO==null?"":vendedorDTO.getCod_vendedor().trim();
			    session.removeAttribute("codArticulo");
			    //valor por defecto de seleccion de radiobutton;
			    //(+) EV 23/07/2010
			    //formBean.setProcedNuevoEquipo("I");
			    if (formBean.getProcedNuevoEquipo()!=null && formBean.getProcedNuevoEquipo().equals("E")){
			    	formBean.setProcedNuevoEquipo("E");
			    }else{
			    	formBean.setProcedNuevoEquipo("I");
			    }
			    //(+) EV 23/07/2010			    
			    
			    /*040809 */
			    session.setAttribute("Equipo",formBean.getProcedNuevoEquipo() );
			    logger.debug(" session.setAttribute(Equipo) = "+formBean.getProcedNuevoEquipo());
			    /*040809 */
			    if ("".equals(shwVend)&&(usuarioSistema.getCall_center() != null) && (usuarioSistema.getCall_center().equals("S"))){
			    	request.setAttribute("showVendedor", "SI");
			    	//formBean.setProcedNuevoEquipo("I");
			    }
			    else{
			    	/*String isExterno=formBean.getFlagBloqueoEquipoEx();
					isExterno=isExterno==null?"":isExterno.trim();
					if ("1".equals(isExterno)){
					//	formBean.setProcedNuevoEquipo("E");
					}*/

					//session.setAttribute("Equipo",formBean.getProcedNuevoEquipo() );
					request.setAttribute("showVendedor", "NO");
			    }	
//			  Si NO es comisionable entonces no debe levantar la pantalla de seleccion de vendedor
			    if (session.getAttribute("oossComisionable").toString().equals("NO"))
			    	request.setAttribute("showVendedor", "NO");
			    
			    
			    session.setAttribute("codArticulo", formBean.getArticulos());

			    // ------------------------------------------------------------------------	    
			    // Dejo chequeado en "Interno" por defecto el radio de Procedencia 
			    // del equipo nuevo
			    
			  //  formBean.setProcedNuevoEquipo("I");
			    
			    // Cargo el numero de contrato para los textboxs
			    if (usuarioAbonado.getNumContrato() != null)	{
				    formBean.setNroContratoParte1(usuarioAbonado.getNumContrato().substring(0,3));
				    formBean.setNroContratoParte2(usuarioAbonado.getNumContrato().substring(3,12));
				    formBean.setNroContratoParte3(usuarioAbonado.getNumContrato().substring(12));
			    } // if
			    
			    usuarioAbonado.setCodTecDestino(global.getValor("codigo.tecnologia.GSM"));
			    String codTecnologia=usuarioAbonado.getCod_tecnologia();
			    codTecnologia=codTecnologia==null?"":codTecnologia;
			    if (!global.getValor("codigo.tecnologia.GSM").equals(codTecnologia)){
			    	usuarioAbonado=delegate.getPlanTarifarioDefault(usuarioAbonado);
			    	request.setAttribute("nuevoPlan", usuarioAbonado.getNuevoPlanTarif());
			    }
			    request.setAttribute("nuevoPlan", usuarioAbonado.getNuevoPlanTarif());
			    
		    }	// else
	    
	    
	    session.setAttribute("CambioDeSerieForm", (CambioDeSerieForm)form); 
		return mapping.findForward("inicio");
	}  // execute

}  // CambioDeSerieAction
