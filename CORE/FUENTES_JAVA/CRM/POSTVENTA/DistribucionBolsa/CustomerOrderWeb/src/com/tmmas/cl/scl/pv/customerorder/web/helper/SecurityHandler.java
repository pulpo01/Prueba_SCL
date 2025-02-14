/**
 * Copyright © 2005 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 25/08/2006     Jimmy Lopez              		Versión Inicial
 */
package com.tmmas.cl.scl.pv.customerorder.web.helper;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Category;
//import org.apache.log4j.Logger;

import com.tmmas.cl.framework.util.StrUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.AbonadoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustomerAccountDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustomerOrderSessionDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.SecurityDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.CustomerOrderException;
import com.tmmas.cl.scl.pv.customerorder.web.delegate.CustomerOrderDelegate;

public class SecurityHandler {
	private String userName;

	private String key;

	private String codigoCliente;

	private String numeroAbonado;

	private String numeroOrdenServicio;

	private String ordenServicio;

	private CustomerOrderDelegate delegate = CustomerOrderDelegate
			.getInstance();

	private Global global = Global.getInstance();

	private final Category logger = Category.getInstance(SecurityHandler.class);
	//private static Logger logger = Logger.getLogger(SecurityHandler.class);
	private CompositeConfiguration config;
	
	private void SecurityHandler() {
		setPropertieFile();
	}
	
	
	
	private void setPropertieFile() {
//		 inicio MA
		String strRuta = "/com/tmmas/cl/CustomerOrderWeb/web/properties/";
		String srtRutaDeploy = System.getProperty("user.dir");
		String strArchivoProperties= "CustomerOrderWeb.properties";
		String strArchivoLog="CustomerOrderWeb.log";
		String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + strArchivoProperties;
	
		config = UtilProperty.getConfiguration(strRutaArchivoExterno, strRutaArchivoExterno);
		
		UtilLog.setLog(strRuta + config.getString(strArchivoLog) );
		logger.debug("Inicio CommentariesAction");
		// fin MA	
	}
	

	public CustomerOrderSessionDTO validarSeguridad(HttpServletRequest req,
			HttpServletResponse resp) throws CustomerOrderException {
		logger.debug("validarSeguridad():start");
		CustomerOrderSessionDTO sessionData = null;

		userName = StrUtl.isNull(req.getParameter("userName"));
		logger.debug("userName[" + userName + "]");

		key = StrUtl.isNull(req.getParameter("key"));
		logger.debug("key[" + key + "]");

		codigoCliente = StrUtl.isNullCero(req.getParameter("codigoCliente"));
		logger.debug("codigoCliente[" + codigoCliente + "]");

		numeroAbonado = StrUtl.isNullCero(req.getParameter("numeroAbonado"));
		logger.debug("numeroAbonado[" + numeroAbonado + "]");

		numeroOrdenServicio = StrUtl.isNullCero(req
				.getParameter("numeroOrdenServicio"));
		logger.debug("numeroOrdenServicio[" + numeroOrdenServicio + "]");

		ordenServicio = StrUtl.isNullCero(req.getParameter("ordenServicio"));
		logger.debug("ordenServicio[" + ordenServicio + "]");

		//Valida los parametros de logueo
		validaParametros();
		
		SecurityDTO param = new SecurityDTO();
		param.setUserName(userName);
		param.setKey(key);

		//logger.debug("getSecurityData:antes");
		//SecurityDTO respuesta2 = delegate.getSecurityData(param);
		//logger.debug("getSecurityData:despues");

		
		
		sessionData = new CustomerOrderSessionDTO();
		sessionData.setSecurity(param);
		sessionData.setCode(Long.parseLong(codigoCliente));
		sessionData.setNumeroAbonado(Long.parseLong(numeroAbonado));
		sessionData.setNumeroOrdenServicio(Long.parseLong(numeroOrdenServicio));
		sessionData.setUserName(userName);
		String ordenServicioReal = global.getValor(ordenServicio);
		logger.debug("ordenServicioReal[" + ordenServicioReal + "]");
					
		if (ordenServicioReal == null) {
			String msg = "No se encuentra un mapping para la orden de servicio[" + ordenServicio + "]";
			throw new CustomerOrderException(msg);
		}
		sessionData.setOrdenServicio(Long.parseLong(ordenServicioReal));
		sessionData.setForward(ordenServicio);
		
		if (sessionData.getCode() != 0) {
			logger.debug("Detalle de cliente");

			CustomerAccountDTO parInput = new CustomerAccountDTO();
			parInput.setCode(Long.parseLong(codigoCliente));
			
			logger.debug("getCustomerAccountData:antes");
			CustomerAccountDTO respuesta = delegate.getCustomerAccountData(parInput);
			logger.debug("getCustomerAccountData:despues");
			sessionData.setNames(respuesta.getNames());
			sessionData.setCodePlanRate(respuesta.getCodePlanRate());
			sessionData.setDesPlanRate(respuesta.getDesPlanRate());
			//Indicador de data de cliente
			sessionData.setDatosdeCliente(true);
			
			logger.debug("nombre de cliente[" + sessionData.getNames() + "]");
			logger.debug("codigo de plan cliente[" + sessionData.getCodePlanRate() + "]");
			logger.debug("nombre de plan cliente[" + sessionData.getDesPlanRate() + "]");
			
		}
		else {
			logger.debug("Detalle de abonado");
			AbonadoDTO abonado = new AbonadoDTO();
			abonado.setNum_abonado(Long.parseLong(numeroAbonado));
			
			logger.debug("getInvolvementProductBundletData:antes");
			CustomerAccountDTO respuesta = delegate.getInvolvementProductBundletData(abonado);
			logger.debug("getInvolvementProductBundletData:despues");
			
			sessionData.setNumeroAbonado(abonado.getNum_abonado());
			sessionData.setCode(respuesta.getCode());
			sessionData.setNames(respuesta.getNames());
			sessionData.setCodePlanRateAbonado(respuesta.getCodePlanRate());
			sessionData.setDesPlanRateAbonado(respuesta.getDesPlanRate());
			sessionData.setNumeroCelular(respuesta.getAbonado().getNum_celular());
			//Indicador de data de abonado
			sessionData.setDatosdeCliente(false);
			
			logger.debug("nombre de cliente[" + sessionData.getNames() + "]");
			logger.debug("codigo de plan abonado[" + sessionData.getCodePlanRateAbonado() + "]");
			logger.debug("nombre de plan abonado[" + sessionData.getDesPlanRateAbonado() + "]");
			logger.debug("numero de celular[" + sessionData.getNumeroCelular() + "]");			
			
		}
		
		
		logger.debug("validarSeguridad():end");
		return sessionData;
	}

	private void validaParametros() throws CustomerOrderException {
		logger.debug("validaParametros():start");

		if (userName.equalsIgnoreCase("") || key.equalsIgnoreCase("")){
			logger.debug("Nombre de usuario o id de seguridad vacios");
			throw new CustomerOrderException("Invalidos parametros de logueo");
		}
		
		if (codigoCliente.equalsIgnoreCase("0") && numeroAbonado.equalsIgnoreCase("0")){
			logger.debug("Codigo de cliente y numero de abonado  sin valor");
			throw new CustomerOrderException("Invalidos parametros de logueo");
		}	
	
		if (numeroOrdenServicio.equalsIgnoreCase("0") || ordenServicio.equalsIgnoreCase("0")) {
			logger.debug("Codigo o numero de orden de servicio vacios");
			throw new CustomerOrderException("Invalidos parametros de logueo");
		}
		logger.debug("validaParametros():end");
	}

}
