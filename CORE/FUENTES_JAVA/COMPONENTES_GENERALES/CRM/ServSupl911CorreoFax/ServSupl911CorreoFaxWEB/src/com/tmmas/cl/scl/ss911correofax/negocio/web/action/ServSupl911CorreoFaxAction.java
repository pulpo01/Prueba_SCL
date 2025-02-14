package com.tmmas.cl.scl.ss911correofax.negocio.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.commonbusinessentities.dto.DireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;
import com.tmmas.cl.scl.ss911correofax.dto.DatosSessionDTO;
import com.tmmas.cl.scl.ss911correofax.dto.TipDireccion911CorreoFaxDTO;
import com.tmmas.cl.scl.ss911correofax.negocio.web.delegate.ServSupl911CorreoFaxDelegate;
import com.tmmas.cl.scl.ss911correofax.negocio.web.form.ServSupl911CorreoFaxForm;

public class ServSupl911CorreoFaxAction extends BaseAction{

	
	private final Logger logger = Logger.getLogger(this.getClass());
	private CompositeConfiguration config;
	private  ServSupl911CorreoFaxDelegate delegate= ServSupl911CorreoFaxDelegate.getInstance();
	
	public ServSupl911CorreoFaxAction(){
		config = UtilProperty.getConfiguration("ServSupl911CorreoFax.properties","com/tmmas/cl/scl/ss911correofax/negocio/web/properties/webpropiedades.properties");
		UtilLog.setLog(config.getString("ServSupl911CorreoFaxWEB.log"));	
	}
	protected ActionForward executeAction(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest httpServletRequest, HttpServletResponse httpServletReponse) throws Exception {
		UtilLog.setLog(config.getString("ServSupl911CorreoFaxWEB.log"));
		String mapping="";
		HttpSession session = httpServletRequest.getSession(false);
		session.removeAttribute("codServicioSS");
		DatosSessionDTO datosSessionDTO =new DatosSessionDTO();
		session.removeAttribute("DatosSessionDTO");
		
		/*ParametrosGlobalesDTO param =  new ParametrosGlobalesDTO();
		session.setAttribute("paramGlobal",param);*/
		
		
		try{
			ServSupl911CorreoFaxForm formBean=(ServSupl911CorreoFaxForm)actionForm;
			
			switch (formBean.getAccion())
			{
				case 1:
						session.setAttribute("codServicioSS", this.getServSuplementario911CorreoFax("911"));
						this.procesosIncio(formBean,httpServletRequest);
						mapping="inicio";
			}
		
		}
		catch(Exception e){
			UtilLog.setLog(config.getString("ServSupl911CorreoFaxWEB.log"));
			mapping="Error";
		}
		session.setAttribute("DatosSessionDTO", datosSessionDTO);
		return actionMapping.findForward(mapping);
	}
	
	protected void procesosIncio(ServSupl911CorreoFaxForm formBean,HttpServletRequest request)throws Exception{
		UtilLog.setLog(config.getString("ServSupl911CorreoFaxWEB.log"));
		logger.debug("inicio: procesosIncio");
		try{
			//delegate.getTipoDireccionLista;
			TipDireccion911CorreoFaxDTO []tipoDireccionLista =new TipDireccion911CorreoFaxDTO [4];
			/*
			 *
			 */
			for (int j=0;j<4;j++){
				tipoDireccionLista[j]=new TipDireccion911CorreoFaxDTO();
			}
			tipoDireccionLista[0].setDesTipDireccion("Particular");
			tipoDireccionLista[1].setDesTipDireccion("Comercial");
			tipoDireccionLista[2].setDesTipDireccion("Correspondencia");
			tipoDireccionLista[3].setDesTipDireccion("Instalación");
			
			// Se carga datos de Direccion
			
			DireccionDTO direccionDTO= new DireccionDTO();
			
			direccionDTO=delegate.getDatosDireccion(direccionDTO);
			
			request.setAttribute("tipoDireccionLista", tipoDireccionLista);
			request.setAttribute("direccionDTO", direccionDTO);
		}
		catch(Exception e){
			UtilLog.setLog(config.getString("ServSupl911CorreoFaxWEB.log"));
			logger.error(e.fillInStackTrace());
			throw(e);
		}
		logger.debug("fin: procesosIncio");
	}
	
	protected String getServSuplementario911CorreoFax(String codGrupoSS)throws Exception{
		UtilLog.setLog(config.getString("ServSupl911CorreoFaxWEB.log"));
		logger.debug("inicio: procesosIncio");
		String retValue="";
		try
		{
			String valorServ="911";
			retValue=valorServ.equals(codGrupoSS)?valorServ:(valorServ.equals(codGrupoSS)?valorServ:(valorServ.equals(codGrupoSS)?codGrupoSS:""));
			
		}
		catch(Exception e)
		{
			UtilLog.setLog(config.getString("ServSupl911CorreoFaxWEB.log"));
			logger.error(e.fillInStackTrace());
			throw(e);
		}
		logger.debug("getServSuplementario911CorreoFax");
		return retValue;
	}

}
