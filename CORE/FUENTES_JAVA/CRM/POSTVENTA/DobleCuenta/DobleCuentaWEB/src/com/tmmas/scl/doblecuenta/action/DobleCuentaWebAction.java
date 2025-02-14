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
import com.tmmas.scl.doblecuenta.commonapp.dto.ClienteDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.ClientesAsociadosDTO;
import com.tmmas.scl.doblecuenta.commonapp.exception.ProyectoException;
import com.tmmas.scl.doblecuenta.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.doblecuenta.form.FacturacionDTO;


public class DobleCuentaWebAction extends Action {

	
	private CompositeConfiguration config;
	
	private static Logger logger = Logger.getLogger(DobleCuentaWebAction.class); // MA

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
		
		setPropertieFile();
		
		logger.debug("DobleCuentaWebAction execute"); // MA
		
		ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
		HttpSession session = request.getSession();
		ClienteDTO clienteDT = new ClienteDTO();
		ClientesAsociadosDTO[] clientesAsociadosDTO = null;
		
		String codigo = (String) session.getAttribute("clienteContratante");
		String tipValor = (String) session.getAttribute("tipValor");
		
		logger.debug("codigo:"+codigo); // MA
		logger.debug("tipValor:"+tipValor); // MA

		ArrayList listaClientesRelacionados = new ArrayList();
		clienteDT.setCodClienteContra(Long.parseLong(codigo));
		try{
			clientesAsociadosDTO = delegate.buscarClientesAsociados(clienteDT);

			for (int i = 0; i < clientesAsociadosDTO.length; i++) {
				
				logger.debug("Fila:"+i); // MA
				
				logger.debug("setCodigoAbonado"+clientesAsociadosDTO[i].getAbonado().getNumAbonado()); // MA
				logger.debug("setNumeroCelular"+clientesAsociadosDTO[i].getAbonado().getNumCelular()); // MA
				logger.debug("setDescAbonado"+clientesAsociadosDTO[i].getFactura().getUser()); // MA
				logger.debug("setCodClienAsociado"+String.valueOf(clientesAsociadosDTO[i].getCliente().getCodClienteAsoc())); // MA
				logger.debug("setDescClienAsociado"+clientesAsociadosDTO[i].getCliente().getNomCliente()); // MA
				logger.debug("setCodigoConcepto"+String.valueOf(clientesAsociadosDTO[i].getConcepto().getCodConceptoOrig())); // MA
				logger.debug("setDescConcepto"+clientesAsociadosDTO[i].getConcepto().getDescripcion()); // MA
				logger.debug("setValor"+clientesAsociadosDTO[i].getConcepto().getMontoConcepto()); // MA
				logger.debug("setNumSecuenciaDetalle"+String.valueOf(clientesAsociadosDTO[i].getFactura().getNumSecDetalleFd())); // MA

				
				FacturacionDTO facturaDTO = new FacturacionDTO();
				facturaDTO.setCodigoAbonado(clientesAsociadosDTO[i].getAbonado().getNumAbonado());
				facturaDTO.setNumeroCelular(clientesAsociadosDTO[i].getAbonado().getNumCelular());
				facturaDTO.setDescAbonado(clientesAsociadosDTO[i].getFactura().getUser());
				facturaDTO.setCodClienAsociado(String.valueOf(clientesAsociadosDTO[i].getCliente().getCodClienteAsoc()));
				facturaDTO.setDescClienAsociado(clientesAsociadosDTO[i].getCliente().getNomCliente());
				facturaDTO.setCodigoConcepto(String.valueOf(clientesAsociadosDTO[i].getConcepto().getCodConceptoOrig()));
				facturaDTO.setDescConcepto(clientesAsociadosDTO[i].getConcepto().getDescripcion());
				facturaDTO.setValor(String.valueOf(clientesAsociadosDTO[i].getConcepto().getMontoConcepto()));
				facturaDTO.setNumSecuenciaDetalle(String.valueOf(clientesAsociadosDTO[i].getFactura().getNumSecDetalleFd()));
				facturaDTO.setEstadoListaFact("listaAntigua");
				listaClientesRelacionados.add(facturaDTO);
			}
		} catch (ProyectoException e) {
				request.setAttribute("error", e.getMessage());
		}
		request.setAttribute("lista", listaClientesRelacionados);
		session.setAttribute("listaGrilla",listaClientesRelacionados);
		session.setAttribute("tipValor",tipValor);
		
        return mapping.findForward("success");
	}
}
