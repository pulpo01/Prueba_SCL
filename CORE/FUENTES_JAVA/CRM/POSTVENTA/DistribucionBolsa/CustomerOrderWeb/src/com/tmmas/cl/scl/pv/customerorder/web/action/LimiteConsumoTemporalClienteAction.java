package com.tmmas.cl.scl.pv.customerorder.web.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Category;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustomerAccountDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustomerOrderSessionDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.LimiteClienteDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.LimiteConsumoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.LimiteConsumoTemporalDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.OrdenServicioDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductListDTO;
import com.tmmas.cl.scl.pv.customerorder.web.delegate.CustomerOrderDelegate;
import com.tmmas.cl.scl.pv.customerorder.web.form.LimiteConsumoTemporalClienteForm;
import com.tmmas.cl.scl.pv.customerorder.web.helper.ForwardOS;

public class LimiteConsumoTemporalClienteAction extends Action{
	CustomerOrderDelegate delegate = CustomerOrderDelegate.getInstance();	
	private Category logger = Category.getInstance(LimiteConsumoTemporalClienteAction.class);	
	private Map actions = null;
	private CompositeConfiguration config;
	
	private Map getMap() {
		if (actions == null) {
			actions = new HashMap();
			actions.put("mostrar", new Integer(1));
			actions.put("modificar", new Integer(2));
		}
		return actions;
	}	

	private void LimiteConsumoTemporalClienteAction() {
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
		logger.debug("Inicio ActionForward");	
	}
	
	public ActionForward execute(ActionMapping mapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response)
		throws Exception 
	{		
		logger.debug("execute");
		LimiteConsumoTemporalClienteForm form = (LimiteConsumoTemporalClienteForm) actionForm;

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
	
	private ActionForward mostrar(ActionMapping actionMapping,ActionForm form, HttpServletRequest servletRequest)
		throws Exception 
	{

		HttpSession session = servletRequest.getSession();

		LimiteConsumoTemporalDTO limConTemporal = null; 
		ArrayList limConTempList = new ArrayList();
		LimiteConsumoDTO[] limites;
		LimiteConsumoDTO limite;
		LimiteClienteDTO limiteCliente = new LimiteClienteDTO();
		int i;
		
		CustomerOrderSessionDTO sessionData = (CustomerOrderSessionDTO)session.getAttribute("CustomerOrder");
		logger.debug("Numero de cliente[" + sessionData.getCode() + "]");
		logger.debug("Numero de abonado[" + sessionData.getNumeroAbonado() + "]");

		CustomerAccountDTO Customer = new CustomerAccountDTO();
		
		Customer.setSinLC(true);	//Solo consulto los servicios que no tienen limite de consumo
		Customer.setCode(sessionData.getCode());
		
		limiteCliente.setCod_cliente(sessionData.getCode());
		limiteCliente.setNum_abonado(sessionData.getNumeroAbonado());
		
		// Ejecutando carga de servicios suplementarios
		ProductListDTO productsList = null;

		logger.debug("getInstalledInvolvementProductBundle:start");
		productsList = (ProductListDTO) delegate.getInstalledCustomerAccountProductBundle(Customer);					
		logger.debug("getInstalledInvolvementProductBundle:end");

		
		logger.debug("cantidad de servicios ["+productsList.getProducts().length+"]");
		limites = new LimiteConsumoDTO[productsList.getProducts().length];
		for(i=0;i<productsList.getProducts().length;i++){
			logger.debug("Codigo Limite Consumo ["+productsList.getProducts()[i].getProfileId()+"]");
			
			limite = new LimiteConsumoDTO();
			limite.setProfileId(productsList.getProducts()[i].getProfileId());
			limite.setCod_plan(productsList.getProducts()[i].getCodPlan());
			
			limites[i] = limite;			
		}
		limiteCliente.setLimites(limites);
    
		logger.debug("getInstalledInvolvementProductBundle:start");
		limiteCliente = (LimiteClienteDTO) delegate.getServiceLimitProfileValue(limiteCliente);					
		logger.debug("getInstalledInvolvementProductBundle:end");

		
		logger.debug("cantidad de valores ["+limiteCliente.getLimites().length+"]");
		if (productsList.getProducts().length == limiteCliente.getLimites().length){			
			for (i=0; i<productsList.getProducts().length; i++){
				limConTemporal = new LimiteConsumoTemporalDTO();
				
				limConTemporal.setCodigoServicio(productsList.getProducts()[i].getId()) ;
				limConTemporal.setNombreServicio(productsList.getProducts()[i].getName());
				limConTemporal.setLimiteActual(String.valueOf(limiteCliente.getLimites()[i].getMto_pago()));
				limConTemporal.setLimiteConsumido(String.valueOf(limiteCliente.getLimites()[i].getMin_lc()));
				limConTemporal.setCodigoLimiteConsumo(productsList.getProducts()[i].getProfileId());
				limConTemporal.setCod_plan(productsList.getProducts()[i].getCodPlan());
				
				logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>> plan  ["+ limConTemporal.getCod_plan()+"]");
				
				/*limConTemporal.setCod_plan(productsList.getProducts()[i].getCodPlan() ); /* RRG 43563*/					
				
				limConTempList.add(limConTemporal);
			}
		}			
		 
		session.removeAttribute("limConTempList");
		session.setAttribute("limConTempList",limConTempList);

		return actionMapping.findForward("success");
	}	
	
	private ActionForward guardarDatos(ActionMapping actionMapping,	ActionForm actionForm, HttpServletRequest servletRequest)
		throws Exception 
	{

		logger.debug("guardarDatos:inicio");
		OrdenServicioDTO ooservicio = new OrdenServicioDTO(); 
		CustomerOrderSessionDTO sessionData = null;
		LimiteClienteDTO limitecliente = new LimiteClienteDTO();
		LimiteConsumoDTO[] limites;						
		sessionData = (CustomerOrderSessionDTO)servletRequest.getSession().getAttribute("CustomerOrder");
		LimiteConsumoTemporalClienteForm form = (LimiteConsumoTemporalClienteForm) actionForm;
		ArrayList limconslis;
		LimiteConsumoTemporalDTO[] limConTempList;
		String[] checked;		
		String[] ValorAsignado;
		int i=0;
		int j=0;
				
		logger.debug("Recupera Orden de Servicio");	
		ooservicio.setNumeroOrdenServicio(sessionData.getNumeroOrdenServicio());
		ooservicio.setOrdenServicio(sessionData.getOrdenServicio());
		ooservicio.setNumeroAbonado(sessionData.getCode());
		//ooservicio.setTipo(Integer.parseInt(global.getValor("tipo.cliente"))); // MA
		ooservicio.setTipo(Integer.parseInt(config.getString("tipo.cliente")));  // MA
		ooservicio.setUserName(sessionData.getUserName());
		limitecliente.setOoss(ooservicio);
		
		logger.debug("Recupera Cliente Abonado");
		
		limitecliente.setCod_cliente(sessionData.getCode());
		limitecliente.setNum_abonado(0);
				
		logger.debug("form.getChecked()");
		checked = form.getChecked();
		logger.debug("form.getValorAsignado()");
		ValorAsignado = form.getValorAsignado();
		
		limconslis = (ArrayList)servletRequest.getSession().getAttribute("limConTempList");
		limConTempList = (LimiteConsumoTemporalDTO[])limconslis.toArray(new LimiteConsumoTemporalDTO[limconslis.size()]);
		logger.debug("checked.length ["+checked.length+"]");
		limites = new LimiteConsumoDTO[checked.length];
		LimiteConsumoDTO limite;
		for(i=0;i<checked.length;i++){
			logger.debug(checked[i]);
			for(j=0;j<limConTempList.length;j++){
				logger.debug("checked[i] == limConTempList[j].getCodigoServicio() ["+checked[i]+"] == ["+limConTempList[j].getCodigoServicio()+"]");				
				if ( limConTempList[j].getCodigoServicio().equals(checked[i])){
					limite = new LimiteConsumoDTO();									
					limite.setProfileId(limConTempList[j].getCodigoLimiteConsumo());
					limite.setInd_unidad("V");
					limite.setMto_pago(Double.parseDouble(ValorAsignado[j]));
					limite.setCod_servicio(limConTempList[j].getCodigoServicio());
					limite.setProfileId(limConTempList[j].getCodigoLimiteConsumo()); /* MMC 43563 19-09-2007 NIC*/
					limite.setCod_plan(limConTempList[j].getCod_plan()); /* RRG 43563 07-09-2007 NIC*/
					limites[i] = limite; 
					
					logger.debug("[CLIENTE]Codigo Plan SS ["+limites[i].getCod_plan()+"]"); /* RRG 43563 07-09-2007 NIC*/
					logger.debug("[CLIENTE]CodigoServicio ["+limites[i].getCod_servicio()+"]");
					logger.debug("[CLIENTE]Profile ["+limites[i].getProfileId()+"]");
					logger.debug("[CLIENTE]ValorAsignado Double["+Double.parseDouble(ValorAsignado[j])+"]"); /* RRG 43563 07-09-2007 NIC*/
					logger.debug("[CLIENTE]ValorAsignado ["+limites[i].getMto_pago() +"]");
					
					break;
				}
			}
		}
		
		limitecliente.setLimites(limites);
		servletRequest.getSession().removeAttribute("limitecliente");
		servletRequest.getSession().setAttribute("limitecliente",limitecliente);
		
		String forward = ForwardOS.forwardOS(sessionData.getForward(), 2);
		logger.debug("forward [" + forward + "]");		
		logger.debug("execute:fin");

		return actionMapping.findForward(forward);
	}	

}
