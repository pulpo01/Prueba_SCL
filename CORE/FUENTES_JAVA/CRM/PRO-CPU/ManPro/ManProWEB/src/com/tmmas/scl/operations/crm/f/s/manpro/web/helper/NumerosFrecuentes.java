package com.tmmas.scl.operations.crm.f.s.manpro.web.helper;

import java.util.Date;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;

import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.NumeroFrecuenteValDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.RespuestaValidacionNumeroDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.exception.ManProException;
import com.tmmas.scl.operations.crm.f.s.manpro.web.delegate.ManageProspectBussinessDelegate;

public class NumerosFrecuentes {
	
	private final Logger logger = Logger.getLogger(NumerosFrecuentes.class);
	private Global global = Global.getInstance();
	private ManageProspectBussinessDelegate delegate = ManageProspectBussinessDelegate.getInstance();
	
	public RespuestaValidacionNumeroDTO obtenerTipoNumero(NumeroFrecuenteValDTO parametros) {
		
		log2("obtenerTipoNumero getNumero "+parametros.getNumero()+"-------------------------------------------------------------------------->");
		
		RespuestaValidacionNumeroDTO respuesta=null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		logger.debug("parametros.getNumero()           :"+parametros.getNumero());

		NumeroDTO param = new NumeroDTO();
		param.setNro(parametros.getNumero());
		NumeroDTO resultado=null;
		//ConversionDTO[] registrosConversion=null;
		respuesta = new RespuestaValidacionNumeroDTO();
		//NumeroDTO param=null;		
		try {
			logger.debug("obtenerConversionOOSS():inicio");
			param = new NumeroDTO();
			param.setNro(parametros.getNumero());
			
			resultado = delegate.obtenerTipoNumero(param);

			logger.debug("resultadoConversion.getDesCategoria     : "+resultado.getDesCategoria());
			logger.debug("resultadoConversion.getCodCategoriaDest : "+resultado.getCodCategoriaDest());
			respuesta.setNumero(Long.parseLong(resultado.getNro()));
			if(resultado.getDesCategoria() == null)
			{
				respuesta.setMensaje("El número "+parametros.getNumero()+" no es válido");
			}
			else
			{
				respuesta.setTipo(resultado.getDesCategoria());
				respuesta.setCodTipo(resultado.getCodCategoriaDest());
				log2("TIPO "+resultado.getDesCategoria()+"       CODIGOTIPO "+resultado.getCodCategoriaDest());
			}
			
	     // catch (ManProException e) {
//			e.printStackTrace();
//			logger.debug("ERROR (ManProException) :"+e.getDescripcionEvento());
//			respuesta.setMensaje(e.getDescripcionEvento());
//			parametros=null;
		
		} 
		catch (NumberFormatException e) {
			logger.debug("ERROR (Exception) :"+e.getMessage());
			respuesta.setMensaje("El número "+parametros.getNumero()+" no es válido");
			parametros=null;
			log2("NumberFormatException Long.parseLong "+e.getMessage()+" En NumerosFrecuentes");
			//e.printStackTrace();
		}
		catch (Exception e) {
			logger.debug("ERROR (Exception) :"+e.getMessage());
			respuesta.setMensaje(e.getMessage());
			parametros=null;
			e.printStackTrace();
		}
		logger.debug("obtenerTipoNumero():fin");
		return respuesta;
		
	}
	public void log2(Object o)
	{
		
	}
}
