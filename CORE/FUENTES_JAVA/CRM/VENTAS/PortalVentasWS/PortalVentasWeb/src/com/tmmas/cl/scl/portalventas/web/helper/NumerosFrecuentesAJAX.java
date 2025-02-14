package com.tmmas.cl.scl.portalventas.web.helper;

import org.apache.log4j.Logger;

import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.dto.RetornoFrecuentesAjaxDTO;

public class NumerosFrecuentesAJAX {
	private final Logger logger = Logger.getLogger(NumerosFrecuentesAJAX.class);
	private Global global = Global.getInstance();
	
	PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();	
	
	public RetornoFrecuentesAjaxDTO obtenerTipoNumero(String numero){
		logger.debug("obtenerTipoNumero:inicio()");
		RetornoFrecuentesAjaxDTO retorno = new RetornoFrecuentesAjaxDTO();

		try{
			//numeroDTO= delegate.obtenerTipoNumero(numeroDTO);
			/*para pruebas*/
			retorno.setTipo("MOVILES");
			retorno.setCodTipo("RDF");
		}catch(Exception e){
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al obtener Tipo Numero");
		}

		logger.debug("obtenerTipoNumero:fin()");
		return retorno;	
	}
		
}
