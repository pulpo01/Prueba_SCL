package com.tmmas.cl.scl.altacliente.presentacion.helper;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;

import com.tmmas.cl.scl.altacliente.presentacion.delegate.AltaClienteDelegate;
import com.tmmas.cl.scl.altacliente.presentacion.dto.RetornoValidacionAjaxDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.NumeroIdentificacionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;

public class ClienteFacturaAJAX {
	private final Logger logger = Logger.getLogger(ClienteFacturaAJAX.class);
	private Global global = Global.getInstance();
	
	AltaClienteDelegate delegate = AltaClienteDelegate.getInstance();	

	public RetornoValidacionAjaxDTO validarIdentificador(String tipoIdentif,String numIdentif){
		logger.debug("obtenerCiclosFacturacion:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);			
		RetornoValidacionAjaxDTO retorno = new RetornoValidacionAjaxDTO();
		
		if (!validarSesion(sesion)){
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;	
		}
		
		NumeroIdentificacionDTO param = new NumeroIdentificacionDTO();
		retorno.setValido(true);
		try{
			param.setCodigoModulo(global.getValor("codigo.modulo.GE"));
			param.setCorrelativo(Long.valueOf(global.getValor("param.identificador.correlativo")));
			param.setTipoIdentif(tipoIdentif);
			param.setNumIdentif(numIdentif);
			param = delegate.validarIdentificador(param);
			retorno.setIdentificadorFormateado(param.getFormatoNIT());
		}catch(Exception e){
			retorno.setValido(false);
		}
		logger.debug("obtenerCiclosFacturacion:fin()");
		return retorno;	
	}
	
	private boolean validarSesion(HttpSession sesion){

		if (sesion == null)	return false;
			
		ParametrosGlobalesDTO sessionData = (ParametrosGlobalesDTO)sesion.getAttribute("paramGlobal"); 
		if (sessionData == null) return false;
		
		return true;
	}		
}
