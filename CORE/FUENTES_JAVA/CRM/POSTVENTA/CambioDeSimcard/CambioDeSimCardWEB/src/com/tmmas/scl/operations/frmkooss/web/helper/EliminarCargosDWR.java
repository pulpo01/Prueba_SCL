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
 * 19/10/2007     			 Raúl Lozano              		Versión Inicial
 */
package com.tmmas.scl.operations.frmkooss.web.helper;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import uk.ltd.getahead.dwr.ExecutionContext;
import uk.ltd.getahead.dwr.WebContextFactory;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.CambioSimCardBussinessDelegate;
import com.tmmas.scl.operations.frmkooss.web.form.CargosForm;
import com.tmmas.scl.operations.frmkooss.web.form.PresupuestoForm;

public class EliminarCargosDWR {
	private final Logger logger = Logger.getLogger(EliminarCargosDWR.class);
	private Global global = Global.getInstance();
	private CambioSimCardBussinessDelegate delegate =CambioSimCardBussinessDelegate.getInstance();
	
	public RetornoDTO eliminarCargos() throws GeneralException{
		
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("eliminarCargos():start");
		RetornoDTO retorno=new RetornoDTO();
		try {
			HttpSession session = WebContextFactory.get().getSession();
			PresupuestoForm formPresupuesto=(PresupuestoForm)session.getAttribute("PresupuestoForm");
			CargosForm cargosForm=(CargosForm)session.getAttribute("CargosForm");
			boolean isACiclo=cargosForm.getRbCiclo().trim().equals("NO")?true:false;
			RegistroFacturacionDTO registro = new RegistroFacturacionDTO();
			registro.setNumeroProcesoFacturacion(String.valueOf(formPresupuesto.getNumProceso()));
			registro.setNumeroVenta(String.valueOf(cargosForm.getNumVenta()));
			if (isACiclo){
				retorno=delegate.eliminarPresupuesto(registro);
			}
			
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}
		
		logger.debug("eliminarCargos():end");
		return retorno;		
	}
}
