package com.tmmas.scl.doblecuenta.action;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.StringTokenizer;

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
import com.tmmas.scl.doblecuenta.commonapp.dto.ClienteDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.FacturaDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.RetornoDTO;
import com.tmmas.scl.doblecuenta.commonapp.exception.ProyectoException;
import com.tmmas.scl.doblecuenta.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.doblecuenta.form.FacturacionDTO;
import com.tmmas.scl.doblecuenta.form.FacturacionDifForm;
import com.tmmas.scl.doblecuenta.helper.Global;

public class EliminaDobleFacturaAction extends Action {

	//private Global global = Global.getInstance();

	private static Logger logger = Logger.getLogger(EliminaDobleFacturaAction.class);
	
	private CompositeConfiguration config;

	private void setPropertieFile() {
//	  inicio MA
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
		
		setPropertieFile();//MA
		
		System.out.println("************estoy en el EliminaDobleFacturaAction***************************");
		
		logger.debug("execute EliminaDobleFacturaAction"); // MA
		logger.debug("estoy en el EliminaDobleFacturaAction"); // MA
		
		ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
		FacturacionDifForm factDifForm = (FacturacionDifForm) form;
		HttpSession session = request.getSession();
		ClienteDTO cliente = new ClienteDTO();
		FacturaDTO factura = new FacturaDTO();
		AbonadoDTO abonado = new AbonadoDTO();
		String [] listaCheckeados = null;
		String secuencialCliente = "";
		secuencialCliente = (String) session.getAttribute("numSecuencialCliente");
		
		logger.debug("secuencialCliente:" + secuencialCliente);//MA
		
		System.out.println("EL SECUENCIAL DEL CLIENTE EN ELIMINA ACTION ES--->" + secuencialCliente);
		String usuario = "";
		String secuencial = "";
		String numAbonado = "";
		String codClienteAsoc = "";
		String checkMasivo ="";
		checkMasivo = factDifForm != null ? factDifForm.getCheckMasivo() : "";
		System.out.println("EL VALUE DEL CHECK MASIVO ES---->" + checkMasivo);
		logger.debug("EL VALUE DEL CHECK MASIVO ES---->" + checkMasivo); // MA
		
		usuario = factDifForm != null ? factDifForm.getNombreUsuario() : "";
		listaCheckeados = factDifForm != null ? factDifForm.getListaCheckGrilla() : null;
		System.out.println("*******me llega la lista datosAsociadosChequeados*" + listaCheckeados.length);
		logger.debug("*******me llega la lista datosAsociadosChequeados*" + listaCheckeados.length); // MA
		String fila = "";
		String msg = "";
		
	try{	
		
		if(checkMasivo.equals("")){
			
			ArrayList listGri = session.getAttribute("listaGrilla")!=null?(ArrayList)session.getAttribute("listaGrilla"):new ArrayList();
			
			logger.debug("listaCheckeados:" + listaCheckeados.length);  // MA
			for(int j =0; j< listaCheckeados.length;j++){
				fila = listaCheckeados[j];
				
				StringTokenizer st = new StringTokenizer(fila,"|");
				numAbonado = st.nextToken();
				codClienteAsoc = st.nextToken();				
				if(!st.hasMoreTokens()){	
					msg = "Debe ingresar los datos anteriormente asociados.";
				}else{				
					secuencial = st.nextToken();
					
					logger.debug("Fila:"+j);
					logger.debug("setNumSecDetalleFd:" + Long.parseLong(secuencial));  // MA
					logger.debug("setCodClienteAsoc:" + Long.parseLong(codClienteAsoc));  // MA
					logger.debug("setNumAbonado:" + numAbonado);  // MA
					logger.debug("setUser:" + usuario);  // MA
					
					factura.setNumSecDetalleFd(Long.parseLong(secuencial));
					cliente.setCodClienteAsoc(Long.parseLong(codClienteAsoc));
					abonado.setNumAbonado(numAbonado);
					factura.setUser(usuario);
					delegate.updateFacturacionDiferenciadaCabecera(cliente, abonado, factura);
					
					
					for (Iterator iter = listGri.listIterator(0); iter.hasNext();) {
						FacturacionDTO element = (FacturacionDTO) iter.next();  
						if(element.getNumSecuenciaDetalle() != null){
							if(	(element.getNumSecuenciaDetalle().equals(secuencial)) && (element.getCodClienAsociado().equals(codClienteAsoc))&&
								(element.getCodigoAbonado().equals(numAbonado))){
								iter.remove();
							}
						}
			        }
					
					request.setAttribute("eliminado", "Los datos asociados fueron dados de baja con exito");				
				}				
					
			}			
			session.setAttribute("listaGrilla",listGri);				
			session.removeAttribute("listaCheckeados");	
			
		}else{
			ArrayList listGri = session.getAttribute("listaGrilla")!=null?(ArrayList)session.getAttribute("listaGrilla"):new ArrayList();
			
			long datoNumSecDetalleFd = factura.getNumSecDetalleFd();
			factura.setUser(usuario);
			if(secuencialCliente == ""){
				msg = "Debe ingresar los datos anteriormente asociados.";
			}else{				
				factura.setNumSecEncabezadoFd(Long.parseLong(secuencialCliente));
				delegate.bajaMasivaFacturacion(factura);				
	       		listGri.clear();    		        
				session.setAttribute("listaGrilla",listGri);
				request.setAttribute("eliminado", "Los datos asociados fueron dados de baja con exito");
			}				

			session.removeAttribute("listaCheckeados");				
		}		

	} catch (ProyectoException e) {
			request.setAttribute("error", e.getMessage());
	}	
		request.setAttribute("error", msg);
		return mapping.findForward("succesElimina");
	}
}

