package com.tmmas.scl.doblecuenta.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.scl.doblecuenta.commonapp.dto.ClienteDTO;
import com.tmmas.scl.doblecuenta.commonapp.exception.ProyectoException;
import com.tmmas.scl.doblecuenta.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.doblecuenta.form.FacturacionDifForm;
import com.tmmas.scl.doblecuenta.helper.Global;

public class BuscaClienteAction extends Action {

	//private Global global = Global.getInstance(); MA

	private static Logger logger = Logger.getLogger(BuscaClienteAction.class);
	
	private CompositeConfiguration config; // MA
	
	private void setPropertieFile() {
//		  inicio MA
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

		setPropertieFile();// MA
		
		//String log = global.getValor("web.log"); // MA
		//log = System.getProperty("user.dir") + log; // MA
		//PropertyConfigurator.configure(log); // MA

		logger.debug("executeBuscaClienteAction():start");
		String codigCiclo = "";
		
		HttpSession session = request.getSession();
		codigCiclo = (String) session.getAttribute("codigoCiclo");
		ClienteDTO[] clienteDTO = null;
		String buscaClien = "";
		String codigoCliente = "";
		String numeroIdentificacion = "";
		String nombreCliente = "";
		String apellidoPaterno = "";
		String apellidoMaterno = "";
		String numSecuencialCliente = "";
		
		ArrayList listaClienteAsociados = session.getAttribute("listaClienteAsociados") != null ? (ArrayList) session.getAttribute("listaClienteAsociados")	: new ArrayList();
		
		FacturacionDifForm factDifForm = (FacturacionDifForm) form;
		ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
		buscaClien = factDifForm != null ? factDifForm.getBuscaClien() : "";
		codigoCliente = factDifForm != null ? factDifForm.getCodigoCliente(): "";
		numeroIdentificacion = factDifForm != null ? factDifForm.getNumeroIdentificacion() : "";
		nombreCliente = factDifForm != null ? factDifForm.getNombreCliente(): "";
		apellidoPaterno = factDifForm != null ? factDifForm.getApellidoPaterno() : "";
		apellidoMaterno = factDifForm != null ? factDifForm.getApellidoMaterno() : "";
		
		logger.debug("buscaClien:"+buscaClien); // MA
		logger.debug("codigoCliente:"+codigoCliente); // MA
		logger.debug("numeroIdentificacion:"+numeroIdentificacion); // MA
		logger.debug("nombreCliente:"+nombreCliente); // MA
		logger.debug("apellidoPaterno:"+apellidoPaterno); // MA
		logger.debug("apellidoPaterno:"+apellidoMaterno); // MA
		

	try{	
		if (codigoCliente != null && !"".equals(codigoCliente)) {
			ClienteDTO cliente = new ClienteDTO();
			cliente.setCodCliente(Long.parseLong(codigoCliente));
			cliente.setNumIdent(numeroIdentificacion);
			cliente.setNomCliente(nombreCliente);
			cliente.setNomApeClien1(apellidoPaterno);
			cliente.setNomApeClien2(apellidoMaterno);
			cliente.setCodCiclo(Long.parseLong(codigCiclo));
			
			clienteDTO = delegate.obtenerListaClientesAsociados(cliente);
			
			if(clienteDTO.length > 0){
				for (int i = 0; i < clienteDTO.length; i++) {
					ClienteDTO clienteList = new ClienteDTO();
					clienteList.setCodCliente(clienteDTO[i].getCodCliente());
					clienteList.setNumIdent(clienteDTO[i].getNumIdent());
					clienteList.setNomCliente(clienteDTO[i].getNomCliente());
					clienteList.setNomApeClien1(clienteDTO[i].getNomApeClien1());
					clienteList.setNomApeClien2(clienteDTO[i].getNomApeClien2());
					listaClienteAsociados.add(clienteList);
					session.setAttribute("listaClienteAsociados", listaClienteAsociados);
				} factDifForm.setCodigoCliente("");
			}else{
				factDifForm.setCodigoCliente("");
				request.setAttribute("error", "No existe el Cliente.");
			}
		}else {
	   		 session.removeAttribute("listaClienteAsociados");
	   		 listaClienteAsociados = (ArrayList) session.getAttribute("listaClienteAsociados");
        }
	} catch (ProyectoException e) {
		    logger.error(e.getMessage());//MA
			factDifForm.setCodigoCliente("");
			request.setAttribute("error", e.getMessage());
	}	
		
		return mapping.findForward("sucessClien");

	}

}
