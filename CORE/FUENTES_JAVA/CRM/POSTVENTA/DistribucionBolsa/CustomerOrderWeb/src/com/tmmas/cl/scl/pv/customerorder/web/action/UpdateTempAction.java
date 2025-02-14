package com.tmmas.cl.scl.pv.customerorder.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Category;
//import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.base.HashMapVO;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductDTO;



public class UpdateTempAction extends Action{
	
	private Category logger = Category.getInstance(UpdateTempAction.class);	
	private CompositeConfiguration config; 
	
	private void UpdateTempAction(){
		setLog();
	}
	
	private void setLog() {
		String strRuta = "/com/tmmas/cl/CustomerOrderWeb/web/properties/";
		String srtRutaDeploy = System.getProperty("user.dir");
		String strArchivoProperties= "CustomerOrderWeb.properties";
		String strArchivoLog="CustomerOrderWeb.log";
		String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + strArchivoProperties;
	
		config = UtilProperty.getConfiguration(strRutaArchivoExterno, strRutaArchivoExterno);
		
		UtilLog.setLog(strRuta + config.getString(strArchivoLog) );
		logger.debug("Inicio UpdateTempAction");
	}
	
	
	public ActionForward execute(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response) 
		throws Exception 
	{
		logger.info("UpdateTempAction::execute()->Star");	
		getInstalledProductBundleList(request);
		return actionMapping.findForward("UpdateTemp");
	}

	
	private void getInstalledProductBundleList(HttpServletRequest request)
	{
		logger.info("UpdateTempAction::getInstalledProductBundleList()->Star");
		HashMapVO list = new HashMapVO();
		
		for(int i=1; i<10; i++)
		{
			logger.info("UpdateTempAction::getInstalledProductBundleList()->ProductDTO p = new ProductDTO();");
			ProductDTO p = new ProductDTO();
			p.setId((new Integer(i)).toString());
			p.setSelected(i<6);
			p.setType("Tipo"+(new Integer(i)).toString() );

			
			p.setName("Mi descripcion");
			
			logger.info("UpdateTempAction::getInstalledProductBundleList()->add");
		}

		request.getSession().removeAttribute("UpdateTempList");
		request.getSession().setAttribute("UpdateTempList",list);
		
		logger.info("UpdateTempAction::getInstalledProductBundleList()->End");
	} 
}
