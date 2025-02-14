package com.tmmas.cl.scl.pv.customerorder.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Category;
//import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.DistribucionBolsaDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.PlanTarifarioDistDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.PlanTarifarioDistListDTO;
import com.tmmas.cl.scl.pv.customerorder.web.delegate.CustomerOrderDelegate;

public class RedistribucionCommentariesAction extends Action {
	private Category logger = Category.getInstance(RedistribucionCommentariesAction.class);
	CustomerOrderDelegate delegate = CustomerOrderDelegate.getInstance();
	
	private CompositeConfiguration config;
	
	private void setLog() {
		String strRuta = "/com/tmmas/cl/CustomerOrderWeb/web/properties/";
		String srtRutaDeploy = System.getProperty("user.dir");
		String strArchivoProperties= "CustomerOrderWeb.properties";
		String strArchivoLog="CustomerOrderWeb.log";
		String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + strArchivoProperties;
	
		config = UtilProperty.getConfiguration(strRutaArchivoExterno, strRutaArchivoExterno);
		
		UtilLog.setLog(strRuta + config.getString(strArchivoLog) );
		logger.debug("Inicio ActionForward");	
	}
	
	public ActionForward execute(ActionMapping mapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response) 
		throws Exception 
	{
		setLog();		
		logger.debug("executeAction():start");
		HttpSession session = request.getSession(false);
		PlanTarifarioDistListDTO planTarifarioList=(PlanTarifarioDistListDTO) session.getAttribute("planes");
		PlanTarifarioDistDTO[] planTarifarioArr = planTarifarioList.getPlanesTarifarios();
		String comentario = request.getParameter("comentarios").toString(); 
		delegate.setFreeUnitStockPlanTarifOOSS(planTarifarioArr, comentario);
		logger.debug("executeAction():end");
		return mapping.findForward("exito");							
	}
	
	public ActionForward execute1(ActionMapping mapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response) 
		throws Exception 
	{
		
		setLog();		
		logger.debug("executeAction():start");
		
		HttpSession session = request.getSession(false);
		PlanTarifarioDistListDTO planTarifarioList=(PlanTarifarioDistListDTO) session.getAttribute("planes");
		PlanTarifarioDistDTO[] planTarifarioArr = planTarifarioList.getPlanesTarifarios();
		PlanTarifarioDistDTO planTarifarioDistDTO = null;
		logger.debug("-------------Minutos por asignar-----ini-------------");
		logger.debug("----------------------------------------------Xplan");
		for(int j=0;j<planTarifarioArr.length;j++)
		{
			planTarifarioDistDTO = planTarifarioArr[j];
			logger.debug("CodigoPlanTarifario ["+planTarifarioDistDTO.getCodigoPlanTarifario()+"]");
			logger.debug("Cantidad de abonados["+planTarifarioDistDTO.getDistribucionBolsa().getBolsa().length+"]");
			logger.debug("guardarDistribucionBolsa:antes");
			//delegate.guardarDistribucionBolsa(planTarifarioDistDTO.getDistribucionBolsa());
			DistribucionBolsaDTO bolsaDistrib;
			int i ;
			
			bolsaDistrib = planTarifarioDistDTO.getDistribucionBolsa();//(DistribucionBolsaDTO)request.getSession().getAttribute("BolsaDistrib");		
			bolsaDistrib.getServiceOrder().setComentario(request.getParameter("comentarios").toString()); 
			
			for (i = 0; i < bolsaDistrib.getBolsa().length; i++){
				logger.debug("abonado["+bolsaDistrib.getBolsa()[i].getNum_abonado()+"] minutos["+bolsaDistrib.getBolsa()[i].getCnt_unidad()+"] porcentaje["+bolsaDistrib.getBolsa()[i].getPrc_unidad()+"]");
			}				
			logger.debug("Comentarios ["+bolsaDistrib.getServiceOrder().getComentario()+"]");
			
			logger.debug("Antes de Delegate");
			delegate.setFreeUnitStock(bolsaDistrib);
			logger.debug("Despues de Delegate");
			
			logger.debug("guardarDistribucionBolsa:despues");
			logger.debug("----------------------------------------------fin plan");
		}
		logger.debug("-------------Minutos por asignar-----fin-------------");
		logger.debug("executeAction():end");
		return mapping.findForward("exito");							
	}
	
	public ActionForward executeOriginal(ActionMapping mapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response) 
	throws Exception 
	{
		
		setLog();		
		logger.debug("executeAction():start");
		
		DistribucionBolsaDTO BolsaDistrib;
		int i ;
		
		BolsaDistrib = (DistribucionBolsaDTO)request.getSession().getAttribute("BolsaDistrib");		
		BolsaDistrib.getServiceOrder().setComentario(request.getParameter("comentarios").toString()); 
		
		for (i = 0; i < BolsaDistrib.getBolsa().length; i++){
			logger.debug("Minots por asignar =  Abonado : "+BolsaDistrib.getBolsa()[i].getNum_abonado()+"  Minutos : "+BolsaDistrib.getBolsa()[i].getCnt_unidad()+"  Porcentaje : "+BolsaDistrib.getBolsa()[i].getPrc_unidad());
		}				
		logger.debug("Comentarios ["+BolsaDistrib.getServiceOrder().getComentario()+"]");
		
		logger.debug("Antes de Delegate");
		delegate.setFreeUnitStock(BolsaDistrib);
		logger.debug("Despues de Delegate");
		
		logger.debug("executeAction():end");
		return mapping.findForward("exito");							
	}
}
