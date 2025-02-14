package com.tmmas.cl.scl.direccion.presentacion.helper;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;

import com.tmmas.cl.scl.commonbusinessentities.dto.CiudadDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.CodigoPostalDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ComunaDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.DatosDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.DireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ProvinciaDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.interfaz.TipoAtributoDireccion;
import com.tmmas.cl.scl.direccion.presentacion.delegate.DireccionDelegate;
import com.tmmas.cl.scl.direccion.presentacion.dto.RetornoListaAjaxDTO;

public class DireccionAJAX {
	private final Logger logger = Logger.getLogger(DireccionAJAX.class);
	private Global global = Global.getInstance();
	
	DireccionDelegate delegate = DireccionDelegate.getInstance();	
	
	public RetornoListaAjaxDTO obtenerRegion(){
		logger.debug("obtenerRegion:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession session = ctx.getHttpServletRequest().getSession(false);		
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();
		
		if (!validarSesion(session)){
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;	
		}
		
		DatosDireccionDTO[] listaRegiones = null;
		
		DireccionDTO direccionSession = new DireccionDTO();
		direccionSession = (DireccionDTO)session.getAttribute("direccionDTO");
	    
		if (direccionSession!=null && direccionSession.getConceptoDireccionDTOs()!=null){
			for(int i=0;i<direccionSession.getConceptoDireccionDTOs().length;i++){
				if (direccionSession.getConceptoDireccionDTOs()[i].getCodigoConcepto() == TipoAtributoDireccion.region){
						listaRegiones = direccionSession.getConceptoDireccionDTOs()[i].getDatosDireccionDTO();
						break;
				}					
			}
		}
		
		retorno.setLista(listaRegiones);
		logger.debug("obtenerRegion:fin()");
		return retorno;	
	}
	
	public RetornoListaAjaxDTO obtenerTipoCalle(){
		logger.debug("obtenerTipoCalle:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession session = ctx.getHttpServletRequest().getSession(false);		
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();
		
		if (!validarSesion(session)){
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;	
		}
		
		DatosDireccionDTO[] listaRegiones = null;

		DireccionDTO direccionSession = new DireccionDTO();
		direccionSession = (DireccionDTO)session.getAttribute("direccionDTO");
	    
		if (direccionSession!=null && direccionSession.getConceptoDireccionDTOs()!=null){
			for(int i=0;i<direccionSession.getConceptoDireccionDTOs().length;i++){
				if (direccionSession.getConceptoDireccionDTOs()[i].getCodigoConcepto() == TipoAtributoDireccion.tipoCalle){
						listaRegiones = direccionSession.getConceptoDireccionDTOs()[i].getDatosDireccionDTO();
						break;
				}					
			}
		}
		
		retorno.setLista(listaRegiones);
		logger.debug("obtenerTipoCalle:fin()");
		return retorno;	
	}
	public RetornoListaAjaxDTO obtenerProvincias (String codigoRegion) throws Exception {
		logger.debug("obtenerProvincias:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession session = ctx.getHttpServletRequest().getSession(false);			
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();
		
		if (!validarSesion(session)){
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;	
		}
		
		DatosDireccionDTO[] provincias = null;
		
		try{
			ProvinciaDireccionDTO provinciaDireccionDTO = new ProvinciaDireccionDTO();
			provinciaDireccionDTO.setCodigoRegion(codigoRegion);
			provinciaDireccionDTO = delegate.getProvincias(provinciaDireccionDTO);
			provincias = provinciaDireccionDTO.getDatosDireccionDTO();
		}catch(Exception e){
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al obtener provincias");
		}
		retorno.setLista(provincias);
		logger.debug("obtenerProvincias:fin()");
		return retorno;
	}
	
	public RetornoListaAjaxDTO obtenerCiudades (String codigoRegion, String codigoProvincia) throws Exception {
		logger.debug("obtenerCiudades:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession session = ctx.getHttpServletRequest().getSession(false);		
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();
		
		if (!validarSesion(session)){
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;	
		}	
		
		DatosDireccionDTO[] ciudades = null;
		
		try{
			CiudadDireccionDTO ciudadDireccionDTO = new CiudadDireccionDTO();
			ciudadDireccionDTO.setCodigoRegion(codigoRegion);
			ciudadDireccionDTO.setCodigoProvincia(codigoProvincia);
			ciudadDireccionDTO = delegate.getCiudades(ciudadDireccionDTO);
			ciudades = ciudadDireccionDTO.getDatosDireccionDTO();
		}catch(Exception e){
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al obtener ciudades");
		}
		retorno.setLista(ciudades);
		logger.debug("obtenerCiudades:fin()");
		return retorno;
	}
	
	public RetornoListaAjaxDTO obtenerComunas (String codigoRegion, String codigoProvincia, String codigoCiudad) throws Exception {
		logger.debug("obtenerComunas:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession session = ctx.getHttpServletRequest().getSession(false);			
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();
		
		if (!validarSesion(session)){
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;	
		}
		
		DatosDireccionDTO[] comunas = null;
		
		try{
			ComunaDireccionDTO comunaDireccionDTO = new ComunaDireccionDTO();
			comunaDireccionDTO.setCodigoRegion(codigoRegion);
			comunaDireccionDTO.setCodigoProvincia(codigoProvincia);
			comunaDireccionDTO.setCodigoCiudad(codigoCiudad);
			comunaDireccionDTO = delegate.getComunas(comunaDireccionDTO);
			comunas = comunaDireccionDTO.getDatosDireccionDTO();
		}catch(Exception e){
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al obtener comunas");
		}
		retorno.setLista(comunas);
		logger.debug("obtenerComunas:fin()");
		return retorno;
	}
	
	public RetornoListaAjaxDTO obtenerCodigosPostales (String codigoZona) throws Exception {
		logger.debug("obtenerCodigosPostales:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession session = ctx.getHttpServletRequest().getSession(false);			
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();
		
		if (!validarSesion(session)){
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;	
		}
		
		DatosDireccionDTO[] codigosPostales = null;
		
		try{
			CodigoPostalDireccionDTO codigoPostalDireccionDTO = new CodigoPostalDireccionDTO();
			codigoPostalDireccionDTO.setCodigoZona(codigoZona);
			codigoPostalDireccionDTO = delegate.getCodigosPostales(codigoPostalDireccionDTO);
			codigosPostales = codigoPostalDireccionDTO.getDatosDireccionDTO();
		}catch(Exception e){
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al obtener comunas");
		}
		retorno.setLista(codigosPostales);
		logger.debug("obtenerCodigosPostales:fin()");
		return retorno;
	}
	
	private boolean validarSesion(HttpSession sesion){

		return true;
	}		
}
