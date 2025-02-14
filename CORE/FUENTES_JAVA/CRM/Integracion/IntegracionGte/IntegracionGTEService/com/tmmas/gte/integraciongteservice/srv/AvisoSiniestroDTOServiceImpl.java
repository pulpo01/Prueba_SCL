/**
* Generated file - you can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongteservice.srv;
import java.util.ArrayList;
import java.util.Iterator;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.gte.integraciongtecommon.dto.AbonadoDTO;
import com.tmmas.gte.integraciongtecommon.dto.AbonadoOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaServicioDTO;
import com.tmmas.gte.integraciongtecommon.dto.BloqueoDTO;
import com.tmmas.gte.integraciongtecommon.dto.BloqueoInDTO;
import com.tmmas.gte.integraciongtecommon.dto.BloqueoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsAvisoSiniestroInDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsAvisoSiniestroResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.EsTelefIgualClieDTO;
import com.tmmas.gte.integraciongtecommon.dto.NombreCamposDTO;
import com.tmmas.gte.integraciongtecommon.dto.ObtenerCampos;
import com.tmmas.gte.integraciongtecommon.dto.PuntoAccesoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO;
import com.tmmas.gte.integraciongteservice.helper.Global;

public class AvisoSiniestroDTOServiceImpl implements AvisoSiniestroDTOService{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(AvisoSiniestroDTOServiceImpl.class);
	private com.tmmas.gte.integraciongtebo.dao.AvisoSiniestroDTODAO avisoSiniestroDTODAO = new com.tmmas.gte.integraciongtebo.dao.AvisoSiniestroDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAO auditoriaDAO	= new com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAO abonadoDAO = new com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAOImpl();
	
	public AvisoSiniestroDTOServiceImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongteservice/properties/IntegracionGTEService.properties");
	}

	/**
	*  Entrega Datos del Aviso Siniestro
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsAvisoSiniestroResponseDTO consultarAvisoSiniestro(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		ConsAvisoSiniestroInDTO inParam1 = new ConsAvisoSiniestroInDTO();
		ConsAvisoSiniestroResponseDTO avisoSiniestroResp = new ConsAvisoSiniestroResponseDTO();
		RespuestaDTO respuesta = new RespuestaDTO();
		Global global = Global.getInstance();
		AuditoriaDTO	codPuntoAccesoDto		= new AuditoriaDTO();		
		AuditoriaDTO	codAplicacionDto		= new AuditoriaDTO();		
		AuditoriaDTO	codServicioDto			= new AuditoriaDTO();		
		AuditoriaDTO	nombreUsuarioDto		= new AuditoriaDTO();	
		ArrayList 		campos					= new ArrayList();
		
		inParam1.setNumeroTelefono(inParam0.getNumeroTelefono());
		inParam1.setCodSiniestro("'" + global.getValor("aviso.siniestro") + "','" + global.getValor("formalizacion.aviso.siniestro") + "'");
		
		logger.info("consultarAvisoSiniestro:start()");
		logger.info("consultarAvisoSiniestro:antes()");
		

		// Realizando Proceso de Auditoria 
		// Validación de Punto Acceso
			codPuntoAccesoDto.setCodPuntoAcceso(inParam0.getAuditoria().getCodPuntoAcceso());
			logger.info("validarPuntoAcceso:start()");
			logger.info("validarPuntoAcceso:antes()");
			PuntoAccesoResponseDTO  puntoAcceso =  auditoriaDAO.consultarPuntoAcceso(codPuntoAccesoDto);
			logger.info("validarPuntoAcceso:despues()");
			logger.info("validarPuntoAcceso:end()");
			if (puntoAcceso.getRespuesta().getCodigoError()!=0)
			{
				respuesta.setCodigoError(puntoAcceso.getRespuesta().getCodigoError());
				respuesta.setMensajeError(puntoAcceso.getRespuesta().getMensajeError());
				respuesta.setNumeroEvento(puntoAcceso.getRespuesta().getNumeroEvento());
				avisoSiniestroResp.setRespuesta(respuesta);
				return avisoSiniestroResp;
			}
		// Fin Validación de Punto Acceso
		// Validación de Cod. Aplicacion
			codAplicacionDto.setCodAplicacion(inParam0.getAuditoria().getCodAplicacion());
			if ((codAplicacionDto.getCodAplicacion()!=null)&&!(codAplicacionDto.getCodAplicacion()).equals(""))
			{
				logger.info("validarAplicacion:start()");
				logger.info("validarAplicacion:antes()");
				com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO aplicacionValidada =  auditoriaDAO.validarAplicacion(codAplicacionDto);
				logger.info("validarAplicacion:despues()");
				logger.info("validarAplicacion:end()");
				if (aplicacionValidada.getCodigoError()!=0)
				{
					avisoSiniestroResp.setRespuesta(aplicacionValidada);
					return avisoSiniestroResp;
				}
			}
		// Fin validación de Cod. Aplicacion
		// Validación de Cod. Servicio
			codServicioDto.setCodServicio(inParam0.getAuditoria().getCodServicio());
			logger.info("validarServicio:start()");
			logger.info("validarServicio:antes()");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO servicioValidado =  auditoriaDAO.validarServicio(codServicioDto);
			logger.info("validarServicio:despues()");
			logger.info("validarServicio:end()");
			if (servicioValidado.getCodigoError()!=0)
			{
				avisoSiniestroResp.setRespuesta(servicioValidado);
				return avisoSiniestroResp;
			}
		// Fin Validación de Cod. Servicio
		// Validación de nombre Usuario
			nombreUsuarioDto.setNombreUsuario(inParam0.getAuditoria().getNombreUsuario());
			logger.info("validarNombreUsuario:start()");
			logger.info("validarNombreUsuario:antes()");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO usuarioValidado =  auditoriaDAO.validarNombreUsuario(nombreUsuarioDto);
			logger.info("validarNombreUsuario:despues()");
			logger.info("validarNombreUsuario:end()");
			if (usuarioValidado.getCodigoError()!=0)
			{
				avisoSiniestroResp.setRespuesta(usuarioValidado);
				return avisoSiniestroResp;
			}
		// Fin Validación de nombre Usuario
			
		// Inicio de Registro de auditoría 		
		logger.info("insertarAuditoria:start()");
		logger.info("insertarAuditoria:antes()");
		com.tmmas.gte.integraciongtecommon.dto.AuditoriaResponseDTO  auditoria =  auditoriaDAO.insertarAuditoria(inParam0.getAuditoria());
		logger.info("insertarAuditoria:despues()");
		logger.info("insertarAuditoria:end()");
		if (auditoria != null && auditoria.getRespuesta()!= null &&  auditoria.getRespuesta().getCodigoError()==0  )
		{
			AuditoriaServicioDTO auditoriaServicioDTO = new AuditoriaServicioDTO();
			auditoriaServicioDTO.setCodAuditoria(auditoria.getCodAuditoria());
			auditoriaServicioDTO.setNombreUsuario(inParam0.getAuditoria().getNombreUsuario());
			// Inicio de Obtención de Nombres de Campos del DTO de Entrada
			logger.info("ObtenerCampos.getAttributes:start()");
    		logger.info("ObtenerCampos.getAttributes:antes()");
			campos = ObtenerCampos.getAttributes(inParam0.getClass(),inParam0);
			logger.info("ObtenerCampos.getAttributes:despues()");
    		logger.info("ObtenerCampos.getAttributes:end()");
    		// Fin de Obtención de Nombres de Campos del DTO de Entrada
	        Iterator  i = campos.iterator();
	        //Recorrido del ArraylList(obtencion de nombres de Campos) 
	        while(i.hasNext())
	        {	
	        	NombreCamposDTO valorcampos = (NombreCamposDTO)i.next();
	        	
	        	auditoriaServicioDTO.setNomParametro(valorcampos.getNombreCampo());
	        	auditoriaServicioDTO.setValParametro(valorcampos.getValorCampo());
	        	logger.info("insertarServicios:start()");
	        	logger.info("insertarServicios:antes()");
	        	RespuestaDTO servicio =  auditoriaDAO.insertarServicios(auditoriaServicioDTO);
	        	logger.info("insertarServicios:despues()");
	        	logger.info("insertarServicios:end()");
				if (servicio != null &&  servicio.getCodigoError()!=0  )
				{
					respuesta.setCodigoError(servicio.getCodigoError());
					respuesta.setMensajeError(servicio.getMensajeError());
					respuesta.setNumeroEvento(servicio.getNumeroEvento());
					avisoSiniestroResp.setRespuesta(respuesta);
					return avisoSiniestroResp;
				}
	        }	
		}else
		{
			respuesta.setCodigoError(auditoria.getRespuesta().getCodigoError());
			respuesta.setMensajeError(auditoria.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(auditoria.getRespuesta().getNumeroEvento());
			avisoSiniestroResp.setRespuesta(respuesta);
			return avisoSiniestroResp;
		}
		//Fin de Registro de auditoría 				

		
		com.tmmas.gte.integraciongtecommon.dto.ConsAvisoSiniestroResponseDTO outParam0 = avisoSiniestroDTODAO.consultarAvisoSiniestro(inParam1);
	    
	    if (outParam0 != null && outParam0.getRespuesta()!= null && outParam0.getRespuesta().getCodigoError() == 0){
	    	if (outParam0.getListadoSiniestros().length > 0) {
	    		avisoSiniestroResp.setListadoSiniestros(outParam0.getListadoSiniestros());
	    		avisoSiniestroResp.setRespuesta(outParam0.getRespuesta());
	    	}else{
	    		avisoSiniestroResp.setRespuesta(outParam0.getRespuesta());
	    	}
	    }else{
	    	avisoSiniestroResp.setRespuesta(outParam0.getRespuesta());
		}
		logger.info("consultarAvisoSiniestro:despues()");
		logger.info("consultarAvisoSiniestro:end()");
		return avisoSiniestroResp;
	}

	

	/**
	*  Entrega Fecha de Formalización y Datos del Aviso Siniestro
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsAvisoSiniestroResponseDTO consultarFechaAvisoSiniestro(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		ConsAvisoSiniestroInDTO inParam1 = new ConsAvisoSiniestroInDTO();
		ConsAvisoSiniestroResponseDTO avisoSiniestroResp = new ConsAvisoSiniestroResponseDTO();
		RespuestaDTO respuesta = new RespuestaDTO();
		Global global = Global.getInstance();

		AuditoriaDTO	codPuntoAccesoDto		= new AuditoriaDTO();		
		AuditoriaDTO	codAplicacionDto		= new AuditoriaDTO();		
		AuditoriaDTO	codServicioDto			= new AuditoriaDTO();		
		AuditoriaDTO	nombreUsuarioDto		= new AuditoriaDTO();	
		ArrayList 		campos					= new ArrayList();
		
		inParam1.setNumeroTelefono(inParam0.getNumeroTelefono());
		inParam1.setCodSiniestro("'" + global.getValor("formalizacion.aviso.siniestro") + "'");
		
		logger.info("consultarFechaAvisoSiniestro:start()");
		logger.info("consultarFechaAvisoSiniestro:antes()");
	
		
		// Realizando Proceso de Auditoria 
		// Validación de Punto Acceso
			codPuntoAccesoDto.setCodPuntoAcceso(inParam0.getAuditoria().getCodPuntoAcceso());
			logger.info("validarPuntoAcceso:start()");
			logger.info("validarPuntoAcceso:antes()");
			PuntoAccesoResponseDTO  puntoAcceso =  auditoriaDAO.consultarPuntoAcceso(codPuntoAccesoDto);
			logger.info("validarPuntoAcceso:despues()");
			logger.info("validarPuntoAcceso:end()");
			if (puntoAcceso.getRespuesta().getCodigoError()!=0)
			{
				respuesta.setCodigoError(puntoAcceso.getRespuesta().getCodigoError());
				respuesta.setMensajeError(puntoAcceso.getRespuesta().getMensajeError());
				respuesta.setNumeroEvento(puntoAcceso.getRespuesta().getNumeroEvento());
				avisoSiniestroResp.setRespuesta(respuesta);
				return avisoSiniestroResp;
			}
		// Fin Validación de Punto Acceso
		// Validación de Cod. Aplicacion
			codAplicacionDto.setCodAplicacion(inParam0.getAuditoria().getCodAplicacion());
			if ((codAplicacionDto.getCodAplicacion()!=null)&&!(codAplicacionDto.getCodAplicacion()).equals(""))
			{
				logger.info("validarAplicacion:start()");
				logger.info("validarAplicacion:antes()");
				com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO aplicacionValidada =  auditoriaDAO.validarAplicacion(codAplicacionDto);
				logger.info("validarAplicacion:despues()");
				logger.info("validarAplicacion:end()");
				if (aplicacionValidada.getCodigoError()!=0)
				{
					avisoSiniestroResp.setRespuesta(aplicacionValidada);
					return avisoSiniestroResp;
				}
			}
		// Fin validación de Cod. Aplicacion
		// Validación de Cod. Servicio
			codServicioDto.setCodServicio(inParam0.getAuditoria().getCodServicio());
			logger.info("validarServicio:start()");
			logger.info("validarServicio:antes()");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO servicioValidado =  auditoriaDAO.validarServicio(codServicioDto);
			logger.info("validarServicio:despues()");
			logger.info("validarServicio:end()");
			if (servicioValidado.getCodigoError()!=0)
			{
				avisoSiniestroResp.setRespuesta(servicioValidado);
				return avisoSiniestroResp;
			}
		// Fin Validación de Cod. Servicio
		// Validación de nombre Usuario
			nombreUsuarioDto.setNombreUsuario(inParam0.getAuditoria().getNombreUsuario());
			logger.info("validarNombreUsuario:start()");
			logger.info("validarNombreUsuario:antes()");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO usuarioValidado =  auditoriaDAO.validarNombreUsuario(nombreUsuarioDto);
			logger.info("validarNombreUsuario:despues()");
			logger.info("validarNombreUsuario:end()");
			if (usuarioValidado.getCodigoError()!=0)
			{
				avisoSiniestroResp.setRespuesta(usuarioValidado);
				return avisoSiniestroResp;
			}
		// Fin Validación de nombre Usuario
			
		// Inicio de Registro de auditoría 		
		logger.info("insertarAuditoria:start()");
		logger.info("insertarAuditoria:antes()");
		com.tmmas.gte.integraciongtecommon.dto.AuditoriaResponseDTO  auditoria =  auditoriaDAO.insertarAuditoria(inParam0.getAuditoria());
		logger.info("insertarAuditoria:despues()");
		logger.info("insertarAuditoria:end()");
		if (auditoria != null && auditoria.getRespuesta()!= null &&  auditoria.getRespuesta().getCodigoError()==0  )
		{
			AuditoriaServicioDTO auditoriaServicioDTO = new AuditoriaServicioDTO();
			auditoriaServicioDTO.setCodAuditoria(auditoria.getCodAuditoria());
			auditoriaServicioDTO.setNombreUsuario(inParam0.getAuditoria().getNombreUsuario());
			// Inicio de Obtención de Nombres de Campos del DTO de Entrada
			logger.info("ObtenerCampos.getAttributes:start()");
    		logger.info("ObtenerCampos.getAttributes:antes()");
			campos = ObtenerCampos.getAttributes(inParam0.getClass(),inParam0);
			logger.info("ObtenerCampos.getAttributes:despues()");
    		logger.info("ObtenerCampos.getAttributes:end()");
    		// Fin de Obtención de Nombres de Campos del DTO de Entrada
	        Iterator  i = campos.iterator();
	        //Recorrido del ArraylList(obtencion de nombres de Campos) 
	        while(i.hasNext())
	        {	
	        	NombreCamposDTO valorcampos = (NombreCamposDTO)i.next();
	        	
	        	auditoriaServicioDTO.setNomParametro(valorcampos.getNombreCampo());
	        	auditoriaServicioDTO.setValParametro(valorcampos.getValorCampo());
	        	logger.info("insertarServicios:start()");
	        	logger.info("insertarServicios:antes()");
	        	RespuestaDTO servicio =  auditoriaDAO.insertarServicios(auditoriaServicioDTO);
	        	logger.info("insertarServicios:despues()");
	        	logger.info("insertarServicios:end()");
				if (servicio != null &&  servicio.getCodigoError()!=0  )
				{
					respuesta.setCodigoError(servicio.getCodigoError());
					respuesta.setMensajeError(servicio.getMensajeError());
					respuesta.setNumeroEvento(servicio.getNumeroEvento());
					avisoSiniestroResp.setRespuesta(respuesta);
					return avisoSiniestroResp;
				}
	        }	
		}else
		{
			respuesta.setCodigoError(auditoria.getRespuesta().getCodigoError());
			respuesta.setMensajeError(auditoria.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(auditoria.getRespuesta().getNumeroEvento());
			avisoSiniestroResp.setRespuesta(respuesta);
			return avisoSiniestroResp;
		}
		//Fin de Registro de auditoría 				

		
		
		com.tmmas.gte.integraciongtecommon.dto.ConsAvisoSiniestroResponseDTO outParam0 = avisoSiniestroDTODAO.consultarAvisoSiniestro(inParam1);
	    
	    if (outParam0 != null && outParam0.getRespuesta()!= null && outParam0.getRespuesta().getCodigoError() == 0){
	    	if (outParam0.getListadoSiniestros().length > 0) {
	    		avisoSiniestroResp.setListadoSiniestros(outParam0.getListadoSiniestros());
	    		respuesta.setCodigoError(outParam0.getRespuesta().getCodigoError());
	    		respuesta.setMensajeError(outParam0.getRespuesta().getMensajeError());
	    		respuesta.setNumeroEvento(outParam0.getRespuesta().getNumeroEvento());
	    		avisoSiniestroResp.setRespuesta(respuesta);
	    	}else{
	    		respuesta.setCodigoError(outParam0.getRespuesta().getCodigoError());
	    		respuesta.setMensajeError(outParam0.getRespuesta().getMensajeError());
		    	respuesta.setNumeroEvento(outParam0.getRespuesta().getNumeroEvento());
		    	avisoSiniestroResp.setRespuesta(respuesta);
	    	}
	    }else{
	    	respuesta.setCodigoError(outParam0.getRespuesta().getCodigoError());
    		respuesta.setMensajeError(outParam0.getRespuesta().getMensajeError());
	    	respuesta.setNumeroEvento(outParam0.getRespuesta().getNumeroEvento());
	    	avisoSiniestroResp.setRespuesta(respuesta);
		}
		logger.info("consultarFechaAvisoSiniestro:despues()");
		logger.info("consultarFechaAvisoSiniestro:end()");
		return avisoSiniestroResp;
	}
	
	


}