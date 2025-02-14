package com.tmmas.cl.scl.altacliente.presentacion.helper;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;

import com.tmmas.cl.scl.altacliente.presentacion.delegate.AltaClienteDelegate;
import com.tmmas.cl.scl.altacliente.presentacion.dto.RetornoListaAjaxDTO;
import com.tmmas.cl.scl.altacliente.presentacion.dto.RetornoValidaTarjetaDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ConceptosRecaudacionComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ModalidadCancelacionComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ModalidadPagoComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.TarjetaDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;

public class AltaClienteFinalAJAX {
	private final Logger logger = Logger.getLogger(AltaClienteFinalAJAX.class);
	private Global global = Global.getInstance();
	
	AltaClienteDelegate delegate = AltaClienteDelegate.getInstance();	

	public RetornoListaAjaxDTO obtenerModalidadesPago(String codModalCancel){
		logger.debug("obtenerModalidadesPago:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);		
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();
		
		if (!validarSesion(sesion)){
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;	
		}
		
		ModalidadPagoComDTO[] listaModPago = null;
		try{
			ModalidadCancelacionComDTO modalCancel = new ModalidadCancelacionComDTO();
			modalCancel.setCodigo(codModalCancel);
			listaModPago = delegate.getModalidadesPago(modalCancel);
		}catch(Exception e){
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al obtener modalidades de pago");
		}
		retorno.setLista(listaModPago);
		logger.debug("obtenerModalidadesPago:fin()");
		return retorno;	
	}

	public RetornoListaAjaxDTO obtenerSucursales(String codBanco){
		logger.debug("obtenerSucursales:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);			
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();
		
		if (!validarSesion(sesion)){
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;	
		}
		
		ConceptosRecaudacionComDTO[] listaSucursales = null;
		try{
			ConceptosRecaudacionComDTO conceptosRec = new ConceptosRecaudacionComDTO();
			conceptosRec.setCodigoBanco(codBanco);
			listaSucursales = delegate.getSucursalesBanco(conceptosRec);
			
		}catch(Exception e){
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al obtener sucursales del banco");
		}
		retorno.setLista(listaSucursales);
		logger.debug("obtenerSucursales:fin()");
		return retorno;	
	}
	public RetornoValidaTarjetaDTO ValidaTarjeta(String codTarjeta,String TipTarjeta){
		logger.debug("validaTarjeta:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);			
		
		TarjetaDTO tarjetaDTO= new TarjetaDTO();
		RetornoValidaTarjetaDTO retorno=new RetornoValidaTarjetaDTO();
		
		if (!validarSesion(sesion)){
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			retorno.setValido(false);
			return retorno;	
		}
		
		try{
			retorno.setValido(true);
			tarjetaDTO.setNumTarjeta(codTarjeta);
			tarjetaDTO.setTipoTarjeta(TipTarjeta);
			tarjetaDTO=delegate.validarTarjeta(tarjetaDTO);
		}catch(Exception e){
			retorno.setValido(false);
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al validar tarjeta");
		}
		logger.debug("validaTarjeta:fin()");
		return retorno;	
	}
	
	private boolean validarSesion(HttpSession sesion){

		if (sesion == null)	return false;
			
		ParametrosGlobalesDTO sessionData = (ParametrosGlobalesDTO)sesion.getAttribute("paramGlobal"); 
		if (sessionData == null) return false;
		
		return true;
	}	
}
