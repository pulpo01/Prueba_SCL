package com.tmmas.scl.doblecuenta.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.scl.doblecuenta.commonapp.dto.AbonadoDTO;
import com.tmmas.scl.doblecuenta.commonapp.exception.ProyectoException;
import com.tmmas.scl.doblecuenta.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.doblecuenta.form.FacturacionDifForm;
import com.tmmas.scl.doblecuenta.helper.Global;

public class BuscaAbonadoAction extends Action {

	//private Global global = Global.getInstance();
	
	private CompositeConfiguration config; // MA

	private static Logger logger = Logger.getLogger(BuscaClienteAction.class);
	
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

		setPropertieFile(); // MA
		logger.debug("BuscaAbonadoAction execute"); //MA
         
		HttpSession session = request.getSession();
		AbonadoDTO[] abonadoDTO = null;
		//String itemChequeados[]= null;
		String buscaAbon = "";
		String numCelu = "";
		String codigoCliContratante = "";

		FacturacionDifForm factDifForm = (FacturacionDifForm) form;
		ArrayList listaAbonados = session.getAttribute("listaAbonados") != null ? (ArrayList) session.getAttribute("listaAbonados")	: new ArrayList();
		ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
		///itemChequeados = request.getParameterValues("itemChequeados");
		numCelu = factDifForm != null ? factDifForm.getNumeroCelular() : "";
		codigoCliContratante = factDifForm != null ? factDifForm.getCodigo() : "";
		
		logger.debug("codigoCliContratante:"+codigoCliContratante); // MA
		logger.debug("NumCelular:"+numCelu);// MA

		buscaAbon= factDifForm != null ? factDifForm.getBuscar() : "";
		
		try {
				if ((numCelu != null && !"".equals(numCelu)))
				{
					AbonadoDTO abonado = new AbonadoDTO();
					abonado.setNumCelular(numCelu);
					abonado.setCodCliente(codigoCliContratante);
					abonadoDTO = delegate.obtenerListaAbonado(abonado);
					
					if(abonadoDTO.length > 0){
						
						logger.debug("getNumAbonado:"+abonado.getNumAbonado()); // MA
						logger.debug("abonadoDTO.length:"+abonadoDTO.length); // MA
						
						System.out.println("el numero de abonado es" + abonado.getNumAbonado());
						System.out.println("la lista de abonados es " + abonadoDTO.length);
						
						for (int i = 0; i< abonadoDTO.length; i++) {
							AbonadoDTO abonadoList = new AbonadoDTO();
							abonadoList.setNumAbonado(abonadoDTO[i].getNumAbonado());
							System.out.println("el num abonado en el for es " + abonadoDTO[i].getNumAbonado());
							abonadoList.setNumCelular(abonadoDTO[i].getNumCelular());
							abonadoList.setNomUsuario(abonadoDTO[i].getNomUsuario());
							abonadoList.setNomApellido1(abonadoDTO[i].getNomApellido1());
							abonadoList.setNomApellido2(abonadoDTO[i].getNomApellido2());
							listaAbonados.add(abonadoList);
							session.setAttribute("listaAbonados", listaAbonados);
						}factDifForm.setNumeroCelular("");
					}else{
						
						factDifForm.setNumeroCelular("");
						request.setAttribute("error", "Abonado no pertenece al Cliente Contratante o no esta de Alta.");
					}
				}else {
			   		 session.removeAttribute("listaAbonados");
			   		listaAbonados = (ArrayList) session.getAttribute("listaAbonados");
		        }		
		} catch (ProyectoException e) {
			    logger.error(e.getMessage() ); // MA
				request.setAttribute("error", e.getMessage());
		}
		return mapping.findForward("sucessAbon");

	}

}
