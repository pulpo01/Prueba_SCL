/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 03/09/2007     			 Elizabeth Vera              		Versión Inicial
 */
package com.tmmas.scl.operations.frmkooss.web.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ArchivoFacturaDTO;
import com.tmmas.scl.operations.frmkooss.web.delegate.FrmkOOSSBussinessDelegate;
import com.tmmas.scl.operations.frmkooss.web.form.CargaPdfForm;
import com.tmmas.scl.operations.frmkooss.web.form.PresupuestoForm;
import com.tmmas.scl.operations.frmkooss.web.helper.Global;

public class CargaPdfAction extends BaseAction {
	
	private final Logger logger = Logger.getLogger(CargaPdfAction.class);
	private Global global = Global.getInstance();
	
	private FrmkOOSSBussinessDelegate delegate = FrmkOOSSBussinessDelegate.getInstance();

	public ActionForward executeAction(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("execute():start");
		
		CargaPdfForm cargaPdfForm = (CargaPdfForm)form;
		
		HttpSession session = request.getSession(false);
		PresupuestoForm presupuestoForm = new PresupuestoForm();
		cargaPdfForm.setMensaje((String)session.getAttribute("mensajeOOSSAviso"));
		if(session.getAttribute("PresupuestoForm")!=null)
			presupuestoForm = (PresupuestoForm)session.getAttribute("PresupuestoForm");

		if(cargaPdfForm.getAccion()!=null && cargaPdfForm.getAccion().equalsIgnoreCase("Consultar")){
			cargaPdfForm.setNumIntento(cargaPdfForm.getNumIntento() + 1);
			
			if (cargaPdfForm.getNumIntento() == cargaPdfForm.getMaxIntentos()){
				cargaPdfForm.setAccion("TerminarConsulta");
			}
			//solo para probar:
			//presupuestoForm.setNumProceso(2418608);
			
			//llamar a consultarEstadoFacturado
			boolean facturaLista = delegate.consultarEstadoFacturado(presupuestoForm.getNumProceso()).isResultado();
			
			if (facturaLista){
				
				long numProceso = presupuestoForm.getNumProceso();
				
				ArchivoFacturaDTO factura = new ArchivoFacturaDTO();
				factura.setNumProceso(numProceso);
				
				//obtiene  ruta de factura
				logger.debug("obtenerRutaFactura():ini");
				factura =  delegate.obtenerRutaFactura(factura); //corregir pl
				logger.debug("obtenerRutaFactura():fin");
				
				//solo para probar
				//factura.setRutaFactura("D:/downloads/archivo.pdf");
				
				//carga archivo
				File f = new File(factura.getRutaFactura());
					
				//Configurar el tipo de archivo.
				response.setContentType("application/pdf"); 
								
				//Obtener el Nombre del archivo.
				String nombrePDF = f.getName().substring(f.getName().lastIndexOf("/") + 1,f.getName().length());
								
				//Configurar cabecera y nombre de archivo a desplegar en DialogBox.
				response.setHeader("Content-Disposition",("attachment;filename=\"" + nombrePDF+ ".pdf\""));
	
				InputStream in = new FileInputStream(f);
				ServletOutputStream outs = response.getOutputStream();
	
				//lee y escribe archivo
				int bit = 256;
				while ((bit) >= 0) {
				        	bit = in.read();
				        	outs.write(bit);
				}
				outs.flush();
				outs.close();
				in.close();
				
			}//fin facturaLista
			
		}//Consultar

		//configuracion inicial
		if (!cargaPdfForm.isFlgIniciado()){
			cargaPdfForm.setFlgIniciado(true);
			
			//obtener intervalo milisegundos
			String moduloGA =  global.getValor("codigo.modulo.GA");
			String codProducto = global.getValor("codigo.producto");
			
			ParametroDTO parametro = new ParametroDTO();
			parametro.setCodModulo(moduloGA);
			parametro.setCodProducto(Integer.parseInt(codProducto));
			parametro.setNomParametro("TPO_ESPERA_IMPRESION");
			parametro = delegate.obtenerParametroGeneral(parametro);
			
			int numReintentos = Integer.parseInt(global.getValor("param.numero.reintentos"));			
			long intervalo = Integer.parseInt(global.getValor("param.intervalo.espera.seg"))*1000;
			
			cargaPdfForm.setIntervaloMilisegundos(intervalo); 
			cargaPdfForm.setMaxIntentos(numReintentos); 
			cargaPdfForm.setNumIntento(0);
			cargaPdfForm.setAccion("Consultar");
			
		}
	
		logger.debug("execute():end");
		return mapping.findForward("cargaPdf");
	
	}//fin execute
	
}
