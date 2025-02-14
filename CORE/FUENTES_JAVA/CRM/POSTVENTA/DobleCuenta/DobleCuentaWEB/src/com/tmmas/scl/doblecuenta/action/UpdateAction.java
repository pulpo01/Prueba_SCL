package com.tmmas.scl.doblecuenta.action;

import java.util.Date;

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
import com.tmmas.scl.doblecuenta.commonapp.dto.ConceptoDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.FacturaDTO;
import com.tmmas.scl.doblecuenta.commonapp.exception.ProyectoException;
import com.tmmas.scl.doblecuenta.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.doblecuenta.form.DobleCuentaForm;



public class UpdateAction extends Action {

	
	private CompositeConfiguration config;
	
	private static Logger logger = Logger.getLogger(FacturacionDifAction.class);

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
		
		setPropertieFile(); // MA
		
		ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
		HttpSession session = request.getSession();
				
		FacturaDTO factura    = new FacturaDTO();
		AbonadoDTO abonado    = new AbonadoDTO();
		ClienteDTO cliente    = new ClienteDTO();
		ConceptoDTO concepto  = new ConceptoDTO();
		
		String usuario =(String) session.getAttribute("usuario");
		String secuencia = (String) session.getAttribute("secuencia");
		
		System.out.println("LA SECUENCIA EN SESION DEL ENCABEZADO ES--->" + (String) session.getAttribute("secuenciaInsert"));
		
		logger.debug("SECUENCIA:"+(String) session.getAttribute("secuenciaInsert")); // MA 
		String secuenciaInsert = (String) session.getAttribute("secuenciaInsert");
		long secuenciaInsertar = Long.parseLong(secuenciaInsert);
		
		/* Recupera datos */
		DobleCuentaForm datos = (DobleCuentaForm)form;	
		
		logger.debug("setNumSecDetalleFd:"+Long.parseLong(datos.getNum_Secuencia_Detalle())); // MA
		logger.debug("setCodClienteAsoc:"+Long.parseLong(datos.getCod_Clien_Asociado())); // MA
		logger.debug("setNumAbonado:"+datos.getCodigo_Abonado()); // MA
		logger.debug("setUser:"+usuario); // MA
		
		factura.setNumSecDetalleFd(Long.parseLong(datos.getNum_Secuencia_Detalle()));
		cliente.setCodClienteAsoc(Long.parseLong(datos.getCod_Clien_Asociado()));
		abonado.setNumAbonado(datos.getCodigo_Abonado());
		factura.setUser(usuario);
		
		concepto.setCodConceptoOrig(Long.parseLong(datos.getCodigo_Concepto()));
		concepto.setMontoConcepto(Float.parseFloat(datos.getValor_1().trim()));
		
		logger.debug("setCodConceptoOrig:"+Long.parseLong(datos.getCodigo_Concepto())); // MA
		logger.debug("setMontoConcepto:"+Float.parseFloat(datos.getValor_1().trim())); // MA
		
		factura.setFecIngRegistro(new Date());
		
			try {	
					/* Baja doble cuenta*/
					delegate.updateFacturacionDiferenciadaCabecera(cliente, abonado, factura);
															
					/* Alta doble cuenta*/
					if(secuencia.equals("0")){
						factura.setNumSecEncabezadoFd(secuenciaInsertar);
					}else{
						factura.setNumSecEncabezadoFd(Long.parseLong(secuencia));
					}
					delegate.insertarFacturacionDiferenciadaDetalle(factura, abonado, cliente, concepto);
					request.setAttribute("error", "Los datos fueron modificados correctamente.");
			
			} catch (ProyectoException e) {
					request.setAttribute("error", e.getMessage());
			}
        return mapping.findForward("success");
	}
}

