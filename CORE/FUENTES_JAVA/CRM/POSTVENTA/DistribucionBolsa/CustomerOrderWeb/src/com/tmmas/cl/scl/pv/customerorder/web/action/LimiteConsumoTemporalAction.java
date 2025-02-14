package com.tmmas.cl.scl.pv.customerorder.web.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.AbonadoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustomerAccountDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustomerOrderSessionDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.LimiteClienteDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.LimiteConsumoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.LimiteConsumoTemporalDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.OrdenServicioDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductListDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.CustomerOrderException;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.TOLException;
import com.tmmas.cl.scl.pv.customerorder.web.delegate.CustomerOrderDelegate;
import com.tmmas.cl.scl.pv.customerorder.web.form.LimiteConsumoTemporalForm;
import com.tmmas.cl.scl.pv.customerorder.web.helper.ForwardOS;
import com.tmmas.cl.scl.pv.customerorder.web.helper.Global;


import org.apache.log4j.Category;
	import org.apache.commons.configuration.CompositeConfiguration;


public class LimiteConsumoTemporalAction extends Action{
	
	CustomerOrderDelegate delegate = CustomerOrderDelegate.getInstance();	
	private Category logger = Category.getInstance(LimiteConsumoTemporalAction.class);	
	private Map actions = null;
	private Global global = Global.getInstance();

	private CompositeConfiguration config; 
	
	private void LimiteConsumoTemporalAction() {
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
		logger.debug("Inicio LimiteConsumoTemporalAction");	
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
		logger.debug("execute");
		LimiteConsumoTemporalForm form = (LimiteConsumoTemporalForm) actionForm;

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
		CustomerAccountDTO cust = new CustomerAccountDTO();
		int i;
		
		boolean swFound = false;   /* RRG 43563 NIC */
		CustomerOrderSessionDTO sessionData = (CustomerOrderSessionDTO)session.getAttribute("CustomerOrder");
		logger.debug("Numero de cliente[" + sessionData.getCode() + "]");
		logger.debug("Numero de abonado[" + sessionData.getNumeroAbonado() + "]");

		AbonadoDTO abonado = new AbonadoDTO();
		abonado.setNum_abonado(sessionData.getNumeroAbonado());
		
		limiteCliente.setCod_cliente(sessionData.getCode());
		limiteCliente.setNum_abonado(sessionData.getNumeroAbonado());
		
		// Ejecutando carga de servicios suplementarios
		ProductListDTO productsList = null;
		try {
			logger.debug("getInstalledInvolvementProductBundle:start");
			productsList = (ProductListDTO) delegate.getInstalledInvolvementProductBundle(abonado);					
			logger.debug("getInstalledInvolvementProductBundle:end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException", e);
		}
		
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

		/* se obtiene valores para cada limite*/ 
		try {
			logger.debug("getInstalledInvolvementProductBundle:start");
			limiteCliente = (LimiteClienteDTO) delegate.getServiceLimitProfileValue(limiteCliente);					
			logger.debug("getInstalledInvolvementProductBundle:end");
		} catch (TOLException e) {
			logger.debug("TOLException", e);
		}	
		int j = 0;
		logger.debug("cantidad de valores ["+limiteCliente.getLimites().length+"]");
			for (i=0; i<productsList.getProducts().length; i++){
				
				if(productsList.getProducts()[i].getProfileId() == null || productsList.getProducts()[i].getProfileId().trim().equals("")){
					logger.debug(productsList.getProducts()[i].getCodPlan() + " No se carga el servicio, ya que no existe limite de consumo asociado");
				}else{
					
					swFound = false;
					for (j=0; j<limiteCliente.getLimites().length; j++){ /* for rrg*/  
						if( limiteCliente.getLimites()[j] != null  ){
							logger.debug("j:" + j);
							logger.debug("Cod Plan Mostrar Cliente ["+limiteCliente.getLimites()[j].getCod_servicio() +"]"); /* RRG 43563 21-09-2007 NIC*/
							logger.debug("Cod Plan Mostrar Producto ["+productsList.getProducts()[i].getCodPlan().toString() +"]"); /* RRG 43563 21-09-2007 NIC*/
							if ( productsList.getProducts()[i].getProfileId().compareTo(limiteCliente.getLimites()[j].getCod_servicio().toString() ) == 0 ) {
								swFound = true;
								limConTemporal = new LimiteConsumoTemporalDTO();
								logger.debug("limite.setMto_pago ["+limiteCliente.getLimites()[j].getMto_pago()+"]");
								logger.debug("limite.setMin_lc ["+limiteCliente.getLimites()[j].getMin_lc()+"]");
				
					limConTemporal.setCodigoServicio(productsList.getProducts()[i].getId()) ;
					limConTemporal.setNombreServicio(productsList.getProducts()[i].getName());
					limConTemporal.setLimiteActual(String.valueOf(limiteCliente.getLimites()[j].getMto_pago()));
					limConTemporal.setLimiteConsumido(String.valueOf(limiteCliente.getLimites()[j].getMin_lc()));
								limConTemporal.setCodigoLimiteConsumo(productsList.getProducts()[i].getProfileId()); 
								limConTemporal.setCod_plan(productsList.getProducts()[i].getCodPlan() ); /* RRG 43563 21-09-2007 NIC*/
								logger.debug("Servivio SS ["+ limConTemporal.getCodigoServicio()  +"]"); /* RRG 43563 21-09-2007 NIC*/
								logger.debug("Plan SS ["+ limConTemporal.getCod_plan()  +"]"); /* RRG 43563 21-09-2007 NIC*/
					limConTempList.add(limConTemporal);
								//j++;
			}
		}			
					} /* end for*/
					if (!swFound) {
						limConTemporal = new LimiteConsumoTemporalDTO();
						/*cat.debug("dto.getLimites()[i].getProfileId() ["+limiteCliente.getLimites()[i].getCod_servicio()+"]");*/
						
						limConTemporal.setCodigoServicio(productsList.getProducts()[i].getId()) ;
						limConTemporal.setNombreServicio(productsList.getProducts()[i].getName());
						limConTemporal.setLimiteActual(String.valueOf(0));
						limConTemporal.setLimiteConsumido(String.valueOf(0)); 
						limConTemporal.setCodigoLimiteConsumo(productsList.getProducts()[i].getProfileId()); 
						
						limConTemporal.setCod_plan(productsList.getProducts()[i].getCodPlan() );
						
						logger.debug("Servivio SS No Found["+ limConTemporal.getCodigoServicio()  +"]");
						logger.debug("Plan SS No Found["+ limConTemporal.getCod_plan()  +"]");
						
						limConTempList.add(limConTemporal);
						
					}
					
					/* rrg */
				}
			}
		//}			
		 
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
		LimiteClienteDTO limiteAbonado = new LimiteClienteDTO();
		LimiteConsumoDTO[] limites;						
		sessionData = (CustomerOrderSessionDTO)servletRequest.getSession().getAttribute("CustomerOrder");
		LimiteConsumoTemporalForm form = (LimiteConsumoTemporalForm) actionForm;
		ArrayList limconslis;
		LimiteConsumoTemporalDTO[] limConTempList;
		String[] checked;		
		String[] ValorAsignado;
		int i=0;
		int j=0;
		
		
		logger.debug("Recupera Orden de Servicio");	
		ooservicio.setNumeroOrdenServicio(sessionData.getNumeroOrdenServicio());
		ooservicio.setOrdenServicio(sessionData.getOrdenServicio());
		ooservicio.setNumeroAbonado(sessionData.getNumeroAbonado());
		ooservicio.setTipo(Integer.parseInt(global.getValor("tipo.abonado")));
		ooservicio.setUserName(sessionData.getUserName());
		limiteAbonado.setOoss(ooservicio);
		
		logger.debug("Recupera Cliente Abonado");
		
		limiteAbonado.setCod_cliente(sessionData.getCode());
		limiteAbonado.setNum_abonado(sessionData.getNumeroAbonado());
		
		
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
					limite.setCod_plan(limConTempList[j].getCod_plan());  /*RRG 43563 07-09-2007 NIC */
					
					limites[i] = limite;
					logger.debug("CodigoServicio ["+limConTempList[j].getCodigoServicio()+"]");
					logger.debug("ValorAsignado ["+ValorAsignado[i]+"]");
					logger.debug("[Abonado]Codigo Plan SS["+limites[i].getCod_plan()  +"]"); /* RRG 43563 07-09-2007 NIC*/
					logger.debug("[Abonado]CodigoServicio ["+ limites[i].getCod_servicio()+"]");
					/*  limConTempList[j].getCodigoServicio() */
					logger.debug("[Abonado]Profile ["+ limites[i].getProfileId()+"]");
					/* limConTempList[j].getCodigoLimiteConsumo()*/
					logger.debug("[Abonado]ValorAsignado Double["+Double.parseDouble(ValorAsignado[j])+"]"); /* RRG 43563 07-09-2007 NIC*/
					logger.debug("[Abonado]ValorAsignado ["+limites[i].getMto_pago() +"]");
					break;
				}
			}
			
		}
		
		limiteAbonado.setLimites(limites);
		servletRequest.getSession().removeAttribute("limiteAbonado");
		servletRequest.getSession().setAttribute("limiteAbonado",limiteAbonado);
		
		String forward = ForwardOS.forwardOS(sessionData.getForward(), 2);
		logger.debug("forward [" + forward + "]");		
		logger.debug("execute:fin");

		return actionMapping.findForward(forward);
	}	

}
