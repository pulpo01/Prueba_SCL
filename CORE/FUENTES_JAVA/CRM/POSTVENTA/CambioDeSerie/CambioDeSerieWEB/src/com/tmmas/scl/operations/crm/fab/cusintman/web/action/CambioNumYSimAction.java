package com.tmmas.scl.operations.crm.fab.cusintman.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ValoresJSPPorDefectoDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.CambioSerieBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cusintman.web.form.CambioDeSerieForm;
import com.tmmas.scl.operations.crm.fab.cusintman.web.form.CambioNumYSimForm;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Global;
import com.tmmas.scl.operations.frmkooss.web.businessObject.dao.ParseoXML;
public class CambioNumYSimAction extends Action {
	
	private final Logger logger = Logger.getLogger(CambioNumYSimAction.class);
	private Global global = Global.getInstance();
	private CambioSerieBussinessDelegate delegate = CambioSerieBussinessDelegate.getInstance();
	
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

//		------------------------------------------------------------------------------------
	    session.setAttribute("nombreOOSS", "Cambio de SimCard");
	    session.setAttribute("operadora", global.getValor("NOM_OPERADORA"));
// 		------------------------------------------------------------------------------------
	    
	    UsuarioAbonadoDTO usuarioAbonado = new UsuarioAbonadoDTO();

	    Long numAbonadoLong = new Long (sessionData.getNumAbonado());
	    usuarioAbonado.setNum_abonado(numAbonadoLong.longValue());

	    // Busco los datos para la cabecera de las paginas
	    usuarioAbonado = delegate.obtenerDatosUsuarioAbonado(usuarioAbonado);
	    session.setAttribute("usuarioAbonado", usuarioAbonado);
	    usuarioAbonado.setNum_abonado(numAbonadoLong.longValue());

	    UsuarioSistemaDTO usuarioSistema = (UsuarioSistemaDTO)session.getAttribute("usuarioSistema");
	    session.setAttribute("usuarioSistema", usuarioSistema);

// 		------------------------------------------------------------------------------------
	    
	    CambioNumYSimForm formBean = (CambioNumYSimForm)form;
    	if ((formBean.getCondicionError() != null) && (formBean.getCondicionError().equals("ERROR")))	{
    		// SI OCURRIO UN ERROR DEL SISTEMA GENERADO POR ALGUN TEMA DE AJAX DEBE MOSTRAR LA PAGINA DE ERROR
    		// Formateo todo el texto para que pueda mostrarse correctamente
    		String mens = formBean.getMensajeError();
    		String stack = formBean.getMensajeStackTrace();
    		
    		delegate.guardaMensajesError(request, mens, stack);
    		
    		return mapping.findForward("error");
    	} // if 
    	else	{
		    // Si hay que efectuar el proceso de negocio
		    if ((formBean.getBtnSeleccionado() != null) && (formBean.getBtnSeleccionado().equals("grabar")))	{
		    	session.setAttribute("CambioNumYSimForm", form);
		    	return mapping.findForward("finalizar");
		    } // if
		    else	{	    	
			    // Seteo el valor del textbox nro.de serie
			    formBean.setUsoVenta(request.getParameter("uso"));
			    request.setAttribute("causaCambio", request.getParameter("causa"));
			    request.setAttribute("tecnologia", request.getParameter("tecnologia"));
				return mapping.findForward("inicio");
	    	} // else				
    	} // else
   	
	}  // execute

}  // CambioNumYSimAction
