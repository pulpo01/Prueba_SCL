package com.tmmas.cl.scl.pv.customerorder.web.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.ArrayUtl;
//import com.tmmas.cl.framework20.util.UtilLog;
//import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.AbonadoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ActualizarSSClienteDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustomerAccountDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustomerOrderSessionDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustumerAccountProductInvolvementDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.OrdenServicioDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductListDTO;
import com.tmmas.cl.scl.pv.customerorder.web.delegate.CustomerOrderDelegate;
import com.tmmas.cl.scl.pv.customerorder.web.form.CustomerAccountProductForm;
import com.tmmas.cl.scl.pv.customerorder.web.helper.ForwardOS;

import org.apache.commons.configuration.CompositeConfiguration;
import com.tmmas.cl.framework20.util.*;
import org.apache.log4j.Category;


public class CustomerAccountProductAction extends Action{
	
	CustomerOrderDelegate delegate = CustomerOrderDelegate.getInstance();	
	private Category logger = Category.getInstance(CustomerAccountProductAction.class);	
	private Map actions = null;
	private CompositeConfiguration config;
	

	private void setLog() {
		String strRuta = "/com/tmmas/cl/CustomerOrderWeb/web/properties/";
		String srtRutaDeploy = System.getProperty("user.dir");
		String strArchivoProperties= "CustomerOrderWeb.properties";
		String strArchivoLog="CustomerOrderWeb.log";
		String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + strArchivoProperties;	
		config = UtilProperty.getConfiguration(strRutaArchivoExterno, strRutaArchivoExterno);		
		UtilLog.setLog(strRuta + config.getString(strArchivoLog) );
		logger.debug("Inicio CustomerAccountProductAction");	
	}
	
	private Map getMap() {
		if (actions == null) {
			actions = new HashMap();
			actions.put("mostrar", new Integer(1));
			actions.put("modificar", new Integer(2));
		}
		return actions;
	}	

	public ActionForward execute(ActionMapping mapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response) 
		throws Exception 
	{		
		setLog();		
		logger.debug("execute");
		CustomerAccountProductForm form = (CustomerAccountProductForm) actionForm;

		switch (((Integer) getMap().get(form.getAccion())).intValue()) {
		case 1:
			logger.debug("1");
			return mostrar(mapping, form, request);
		case 2:
			logger.debug("2");
			return guardarDatos(mapping, form, request);
		}
		logger.error("NO ENCONTRO UNA ACCION ADECUADA");
		return null;
	}
		
	public ActionForward mostrar(ActionMapping actionMapping,ActionForm form, HttpServletRequest servletRequest)
		throws Exception
	{
		
		setLog();	
		ProductDTO installedProductBundleList[];
		ProductDTO unInstalledProductBundleList[];
		
        ProductListDTO InstalledProductList = new  ProductListDTO();
        ProductListDTO UnInstallProductList = new  ProductListDTO();
        
        logger.debug("mostrar:inicio");
		
		CustomerAccountDTO CustomerAccount = new CustomerAccountDTO();
		CustomerOrderSessionDTO SessionData; 
		
		SessionData = (CustomerOrderSessionDTO)servletRequest.getSession().getAttribute("CustomerOrder");
		
		CustomerAccount.setCode(SessionData.getCode());
		CustomerAccount.setCodePlanRate(SessionData.getCodePlanRate());
		CustomerAccount.setDesPlanRate(SessionData.getDesPlanRate());
		CustomerAccount.setNames(SessionData.getNames());
		
						
		InstalledProductList = (ProductListDTO)delegate.getInstalledCustomerAccountProductBundle(CustomerAccount);
		UnInstallProductList = (ProductListDTO)delegate.getUnInstalledCustomerAccountProductBundle(CustomerAccount);
		
		/*if (InstalledProductList != null){
		    cat.debug("InstalledProductList.getProducts().length -- "+InstalledProductList.getProducts().length);
			String[] checked = new String[InstalledProductList.getProducts().length];
			int i=0;
			for (i=0; i<checked.length; i++){
				checked[i] = InstalledProductList.getProducts()[i].getId().toString();
				cat.debug("checked[i] -- ["+checked[i]+"]");
			}
			CustomerAccountProductForm formy = (CustomerAccountProductForm) form;
			formy.setCheckedInstall(checked);			
		}*/
							
		installedProductBundleList = InstalledProductList.getProducts();
		unInstalledProductBundleList = UnInstallProductList.getProducts();	
		
		logger.debug("installedProductBundleList.length ="+installedProductBundleList.length);
		logger.debug("installedProductBundleList ="+installedProductBundleList.equals(null));
		logger.debug("unInstalledProductBundleList.length ="+unInstalledProductBundleList.length);
		logger.debug("unInstalledProductBundleList ="+unInstalledProductBundleList.equals(null));
    	
		servletRequest.getSession().removeAttribute("CustomerAccount");
		servletRequest.getSession().setAttribute("CustomerAccount",CustomerAccount);
		servletRequest.getSession().removeAttribute("installedProductBundleList");
		servletRequest.getSession().setAttribute("installedProductBundleList",installedProductBundleList);
		servletRequest.getSession().removeAttribute("unInstalledProductBundleList");
		servletRequest.getSession().setAttribute("unInstalledProductBundleList",unInstalledProductBundleList);		
		
		logger.debug("mostrar:fin");
		
		return actionMapping.findForward("success");
	}	
	
	public ActionForward guardarDatos(ActionMapping actionMapping,ActionForm form, HttpServletRequest servletRequest)
		throws Exception
	{
		setLog();
		logger.debug("guardarDatos:inicio");
		int i=0; 
		int j=0;
		String[] checkedInstall;
		String[] checkedUnInstall;
		boolean pos;
		CustomerAccountDTO CustomerAccount = new CustomerAccountDTO();
		AbonadoDTO abonado = new AbonadoDTO(); 
		ProductDTO installedProductBundleList[];
		ProductDTO unInstalledProductBundleList[];
		ArrayList productsInstalled = new ArrayList();
		ArrayList productsUnInstalled = new ArrayList();
		ActualizarSSClienteDTO sscliente = new ActualizarSSClienteDTO();	
		OrdenServicioDTO ordenServicio = new OrdenServicioDTO();

        CustomerOrderSessionDTO SessionData = (CustomerOrderSessionDTO)servletRequest.getSession().getAttribute("CustomerOrder");;		
		ordenServicio.setNumeroOrdenServicio(SessionData.getNumeroOrdenServicio());
		ordenServicio.setOrdenServicio(SessionData.getOrdenServicio());
		ordenServicio.setNumeroAbonado(SessionData.getCode());
		//ordenServicio.setTipo(Integer.parseInt(global.getValor("tipo.cliente")));
		
		ordenServicio.setTipo(Integer.parseInt(config.getString("tipo.cliente"))); // MA
		
		ordenServicio.setUserName(SessionData.getUserName());
		CustomerAccount.setCode(SessionData.getCode());
        abonado.setNum_abonado(0);
        CustomerAccount.setAbonado(abonado);
		
		CustomerAccountProductForm fromy = (CustomerAccountProductForm) form;
		checkedInstall   = fromy.getCheckedInstall();
		checkedUnInstall = fromy.getCheckedUnInstall();
		
		installedProductBundleList = (ProductDTO[])servletRequest.getSession().getAttribute("installedProductBundleList");
		unInstalledProductBundleList = (ProductDTO[])servletRequest.getSession().getAttribute("unInstalledProductBundleList");			
		
	
		if ( checkedInstall != null ){
			logger.debug("checkedInstall.length ["+checkedInstall.length+"]");
			logger.debug("installedProductBundleList.length ["+installedProductBundleList.length+"]");
			
			for(i=0; i<installedProductBundleList.length ; i++){
				pos = true;
				for (j=0 ; j<checkedInstall.length; j++){
					logger.debug("checkedInstall[j] = ["+checkedInstall[j]+"]");
					if (installedProductBundleList[i].getId().equals(checkedInstall[j])){
						pos=false;
					}					
				}
				if(pos){
					logger.debug("productsUnInstalled ["+installedProductBundleList[i].getId()+"]");					
					productsUnInstalled.add(installedProductBundleList[i]);
				}								
			}
		}else{
			for(i=0; i<installedProductBundleList.length ; i++){
				logger.debug("productsUnInstalled ["+installedProductBundleList[i].getId()+"]");				
				productsUnInstalled.add(installedProductBundleList[i]);
			}
			
		}
		sscliente.setServDesactivar((ProductDTO[])ArrayUtl.copiaArregloTipoEspecifico(productsUnInstalled.toArray(), ProductDTO.class));
		
		logger.debug("checkedUnInstall"+(!(checkedUnInstall == null)));		
		if ( !(checkedUnInstall == null) ){
			logger.debug("checkedUnInstall.length :"+checkedUnInstall.length);						
			for(i=0; i<checkedUnInstall.length; i++){
				for (j=0; j<unInstalledProductBundleList.length; j++){
					
					logger.debug("checkedUnInstall[i] ["+checkedUnInstall[i]+"] == unInstalledProductBundleList[j].getId() ["+unInstalledProductBundleList[j].getId()+"]");
					
					if (unInstalledProductBundleList[j].getId().equals(checkedUnInstall[i])){						
						logger.debug("productsInstalled ["+unInstalledProductBundleList[j].getId()+"]");
						productsInstalled.add(unInstalledProductBundleList[j]);
						
					}
				}
			}		
		}
		sscliente.setServActivar((ProductDTO[])ArrayUtl.copiaArregloTipoEspecifico(productsInstalled.toArray(), ProductDTO.class));
		sscliente.setClientePago(CustomerAccount);
		sscliente.setClienteServicio(CustomerAccount);
		sscliente.setOoss(ordenServicio);
		
		
		servletRequest.getSession().removeAttribute("sscliente");
		servletRequest.getSession().setAttribute("sscliente",sscliente);
		
		String forward = ForwardOS.forwardOS(SessionData.getForward(), 2);
		logger.debug("forward [" + forward + "]");
		logger.debug("guardarDatos:fin");	
		return actionMapping.findForward(forward);
	}		
}
