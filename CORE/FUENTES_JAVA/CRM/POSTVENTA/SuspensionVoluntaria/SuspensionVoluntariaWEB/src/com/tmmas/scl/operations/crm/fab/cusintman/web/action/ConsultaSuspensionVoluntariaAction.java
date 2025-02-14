package com.tmmas.scl.operations.crm.fab.cusintman.web.action;

import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ValoresJSPPorDefectoDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.SuspensionAbonadoDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.SuspensionVoluntariaBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cusintman.web.form.ConsultaSuspensionVoluntariaForm;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Global;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Utilidades;
import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException;
import com.tmmas.scl.operations.frmkooss.web.businessObject.dao.ParseoXML;

public class ConsultaSuspensionVoluntariaAction extends BaseAction {
	
	private final Logger logger = Logger.getLogger(ConsultaSuspensionVoluntariaAction.class);
	private Global global = Global.getInstance();
	private SuspensionVoluntariaBussinessDelegate delegate = SuspensionVoluntariaBussinessDelegate.getInstance();
	
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
	    session.setAttribute("operadora", global.getValor("NOM_OPERADORA"));
	    // ------------------------------------------------------------------------------------

		String archivo = System.getProperty("user.dir")+global.getValor("ruta.xml")+global.getValor("xml.valoresdefecto");
		ParseoXML parseo=new ParseoXML();
		logger.debug("leyendo y parseando XML configuración:antes");
		ValoresJSPPorDefectoDTO definicionPagina=parseo.cargaXML(archivo);
		logger.debug("leyendo y parseando XML configuracion:despues");
		sessionData.setDefaultPagina(definicionPagina);
		
		// --------------------------------------------------------------------
	    
	    UsuarioAbonadoDTO usuarioAbonado = new UsuarioAbonadoDTO();

	    Long numAbonadoLong = new Long (sessionData.getNumAbonado());
	    usuarioAbonado.setNum_abonado(numAbonadoLong.longValue());

	    // Busco los datos para la cabecera de las paginas
	    usuarioAbonado = delegate.obtenerDatosUsuarioAbonado(usuarioAbonado);
	    session.setAttribute("usuarioAbonado", usuarioAbonado);
	    
	    UsuarioSistemaDTO usuarioSistema = (UsuarioSistemaDTO)session.getAttribute("usuarioSistema");
	    ConsultaSuspensionVoluntariaForm formBean = (ConsultaSuspensionVoluntariaForm)form;
	    
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

		    // Efectuo la busqueda
		    if ((formBean.getBtnSeleccionado() != null) && (formBean.getBtnSeleccionado().equals("consultar")))	{
		    	formBean.setBtnSeleccionado(null);
		    	
			    // Consulto las causas de suspension para el listbox
		    	SuspensionAbonadoDTO suspensionesAbonado[] = null;

		    	Date fechaDesde = null;
		    	Date fechaHasta = null;
		    	try	{
		    		fechaDesde = Date.valueOf(Utilidades.formateaFecha(formBean.getFechaDesde()));
		    	}
		    	catch(Exception ex)	{}
		    	try	{
		    		fechaHasta = Date.valueOf(Utilidades.formateaFecha(formBean.getFechaHasta()));
		    	}
		    	catch(Exception ex)	{}
		    	
		    	suspensionesAbonado = delegate.obtenerSuspensionesHistoricasAbonado(usuarioAbonado.getNum_abonado(), fechaDesde, fechaHasta);
			    
		    	if (suspensionesAbonado.length>0)	{
			    	request.setAttribute("suspensionesAbonado", suspensionesAbonado);
		    		request.setAttribute("mensajeOOSSAviso", null);
		    	}
			    else	{
			    	request.setAttribute("suspensionesAbonado", null);
			    	request.setAttribute("mensajeOOSSAviso", "No existen datos para la consulta realizada.");
			    }
			    
			    formBean.setBtnSeleccionado(null);
			    
		    	return mapping.findForward("inicio");
		    } // if
		    else	{
		    	// SE INICIA LA CARGA DE PAGINA
			    // Carga de combos
			    // Ejecuta las restricciones de ejecucion para esta funcionalidad	
			    session.setAttribute("usuarioSistema", usuarioSistema);
			    // ------------------------------------------------------------------------------------------------------------------
			    			 
			    request.setAttribute("titulo", "Consulta de Suspensiones voluntarias de Servicio");
		    	request.setAttribute("mensajeOOSSAviso", null);
 		    }	// else

		    request.setAttribute("consultaForm", formBean);
		    return mapping.findForward("inicio");
	    }	// else

	    return mapping.findForward("error");

	}  // execute
	
// ------------------------------------------------------------------------------------------------------------------------
	
}  // ConsultaSuspensionVoluntariaAction
