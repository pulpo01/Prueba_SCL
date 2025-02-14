package com.tmmas.scl.doblecuenta.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.doblecuenta.commonapp.dto.ClienteDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.OOSSDTO;
import com.tmmas.scl.doblecuenta.commonapp.exception.ProyectoException;
import com.tmmas.scl.doblecuenta.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.doblecuenta.form.IdenClienteForm;
//import com.tmmas.scl.doblecuenta.helper.Global;

import org.apache.commons.configuration.CompositeConfiguration; // MA
import com.tmmas.cl.framework20.util.*;

public class IdenClienteAction extends Action {
	
	private final Logger logger = Logger.getLogger(IdenClienteAction.class);
	//private Global global = Global.getInstance();
	
	private CompositeConfiguration config;

	
	private void setPropertieFile() {

//      inicio MA
         String strRuta = "/com/tmmas/cl/DobleCuentaWeb/web/properties/";
         String srtRutaDeploy = System.getProperty("user.dir");
         String strArchivoProperties= "DobleCuentaWeb.properties";
         String strArchivoLog="DobleCuentaWeb.log";
         String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + strArchivoProperties;
         config = UtilProperty.getConfiguration(strRutaArchivoExterno, strRutaArchivoExterno);
         UtilLog.setLog(strRuta + config.getString(strArchivoLog) );
         // fin MA           
}


	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		setPropertieFile(); // MA
		
		//String log = global.getValor("web.log");
		//PropertyConfigurator.configure(log);
		
		System.out.println("executeIdenClienteAction():start");
		
		logger.debug("executeIdenClienteAction():start"); // MA
		
		HttpSession session = request.getSession(false);
		
		String codCliente = (String) request.getParameter("codCliente");
		String codOOSS = (String) request.getParameter("ordenServicio");	
		String userName = (String) request.getParameter("userName");
		System.out.println("codCliente-->" + codCliente);
		
		logger.debug("codCliente:"+codCliente); // MA
		logger.debug("codOOSS:"+codOOSS); // MA
		logger.debug("userName:"+userName); // MA
		
		ManageRequestBussinessDelegate delegate = new ManageRequestBussinessDelegate();
		ClienteDTO datos = new ClienteDTO();
		IdenClienteForm formCliente = new IdenClienteForm();
		
		try{
			delegate.obtenerInformacionCliente(datos);
		}catch (ProyectoException e) {
			logger.error(e.getMessage());//MA
			request.setAttribute("error1", e.getMessage());
		}	
		
		 formCliente.setCodCliente(java.lang.String.valueOf(datos.getCodCliente()));
		 //formCliente.setNomCliente(datos.getNomCliente());
		 //formCliente.setApellido1(datos.getNomApeClien1());
		 //formCliente.setApellido2(datos.getNomApeclien2());	 
		 //formCliente.setCodIdentCliente(datos.getCodTipIdent());
		 //formCliente.setIdenCliente(datos.getNumIdent());	
		 formCliente.setCodOOSS(codOOSS);
		 formCliente.setUserName(userName);
		 
		 /* Recupera datos */ 	 
		 IdenClienteForm form1 = (IdenClienteForm)form;
		 OOSSDTO ooss = new OOSSDTO();
		 //ooss.setComentario(form1.getComentario());
		 
		 request.getSession().setAttribute("formCliente",formCliente);
		 System.out.println("executeIdenClienteAction():end");
		 
		 logger.debug("executeIdenClienteAction():end"); // MA
		 
		 return mapping.findForward("sucess1");
	}
}
