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
import com.tmmas.gte.integraciongtecommon.dto.ActDesSSDto;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaServicioDTO;
import com.tmmas.gte.integraciongtecommon.dto.ComponentesDTO;
import com.tmmas.gte.integraciongtecommon.dto.ComponentesResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConServSupleDTO;
import com.tmmas.gte.integraciongtecommon.dto.EntServSupleDTO;
import com.tmmas.gte.integraciongtecommon.dto.EsTelefIgualClieDTO;
import com.tmmas.gte.integraciongtecommon.dto.LstComponentesDTO;
import com.tmmas.gte.integraciongtecommon.dto.NombreCamposDTO;
import com.tmmas.gte.integraciongtecommon.dto.ObtenerCampos;
import com.tmmas.gte.integraciongtecommon.dto.PuntoAccesoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO;
import com.tmmas.gte.integraciongtecommon.dto.SecuenciaDTO;
import com.tmmas.gte.integraciongtecommon.dto.SeguroInDTO;
import com.tmmas.gte.integraciongtecommon.dto.SeguroOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.SeguroResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.ServicioSupleRespondeDTO;
import com.tmmas.gte.integraciongtecommon.dto.ServicioSuplementarioDTO;
import com.tmmas.gte.integraciongteservice.helper.Global;


public class ServicioSuplementarioDTOServiceImpl implements ServicioSuplementarioDTOService{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(ServicioSuplementarioDTOServiceImpl.class);
	
	private com.tmmas.gte.integraciongtebo.dao.ServicioSuplementarioDTODAO	servicioSuplementarioDTODAO = new com.tmmas.gte.integraciongtebo.dao.ServicioSuplementarioDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAO 				abonadoDAO					= new com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAO 				auditoriaDAO				= new com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.ParametrosGeneralesDTODAO	parametrosGeneralesDTODAO   = new com.tmmas.gte.integraciongtebo.dao.ParametrosGeneralesDTODAOImpl();
	
	public ServicioSuplementarioDTOServiceImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongteservice/properties/IntegracionGTEService.properties");
	}

	/**
	* Entrega Datos de los servicios suplementario
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ServicioSupleRespondeDTO consultaServicioSuplem(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0) throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		logger.info("declaracion de variables para el metodo consultaServicioSuplem");
		ConServSupleDTO parametrosServiciosSuplementario = null;
		EsTelefIgualClieDTO telefono  = null;
		AbonadoOutDTO datosAbonados = null; 
		AbonadoDTO abonado = null;         
		RespuestaDTO    respuesta = new RespuestaDTO();
		ServicioSupleRespondeDTO   respuestaFinal = new ServicioSupleRespondeDTO();
		AuditoriaDTO	codPuntoAccesoDto		= new AuditoriaDTO();		
		AuditoriaDTO	codAplicacionDto		= new AuditoriaDTO();		
		AuditoriaDTO	codServicioDto			= new AuditoriaDTO();		
		AuditoriaDTO	nombreUsuarioDto		= new AuditoriaDTO();
		ArrayList 		campos					= new ArrayList();
		logger.info("fin de la declaraciones de variables para el metodo consultaServicioSuplem");
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
				respuestaFinal.setRespuesta(respuesta);
				return respuestaFinal;
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
					respuestaFinal.setRespuesta(aplicacionValidada);
					return respuestaFinal;
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
				respuestaFinal.setRespuesta(servicioValidado);
				return respuestaFinal;
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
				respuestaFinal.setRespuesta(usuarioValidado);
				return respuestaFinal;
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
							respuestaFinal.setRespuesta(respuesta);
							return respuestaFinal;
						}
			        }	
				}else
				{
					respuesta.setCodigoError(auditoria.getRespuesta().getCodigoError());
					respuesta.setMensajeError(auditoria.getRespuesta().getMensajeError());
					respuesta.setNumeroEvento(auditoria.getRespuesta().getNumeroEvento());
					respuestaFinal.setRespuesta(respuesta);
					return respuestaFinal;
				}
			//Fin de Registro de auditoría 				
		logger.info("utilizando AbonadoImpl");
		logger.info("utilizando metodo:consultarAbonadoTelefono");
		     	telefono = new EsTelefIgualClieDTO();
		     	if(inParam0 != null && inParam0.getNumeroTelefono() != 0){
		     		telefono.setNum_telefono1(inParam0.getNumeroTelefono());
		     		datosAbonados = abonadoDAO.consultarAbonadoTelefono(telefono);
		     	}
				logger.info("recuperacion de datos del abanado");
		     	if(   datosAbonados != null 
		     	   && datosAbonados.getListadoAbonados() != null 
		     	   && datosAbonados.getListadoAbonados().length > 0){
			     		for(int i = 0 ; i < datosAbonados.getListadoAbonados().length; i++){
			     			abonado = datosAbonados.getListadoAbonados()[i]; 
			     		}
		     	}
		logger.info("cerrando metodo :consultarAbonadoTelefono");
		logger.info("cerrando AbonadoImpl");
		
		
		logger.info("construción para obtener los datos de los servicios suplementario, con el tipo Nº 1");
			   if(abonado != null && abonado.getNumAbonado()!=0){
				   parametrosServiciosSuplementario = new ConServSupleDTO();
				   parametrosServiciosSuplementario.setNumeroAbonado(abonado.getNumAbonado());
				   parametrosServiciosSuplementario.setTipo(1);
				   logger.info("consultaServicioSuplem:antes()");
				   com.tmmas.gte.integraciongtecommon.dto.ServicioSupleRespondeDTO outParam01 = servicioSuplementarioDTODAO.consultarServicioSuplem(parametrosServiciosSuplementario);
				   logger.info("consultaServicioSuplem:despues()");

				   logger.info("se comienza a construir la siguiente lista (listaServiciosDefectoalPlan)");
				   if(   outParam01 != null 
				      && outParam01.getListaServiciosDefectoalPlan() != null 
				      && outParam01.getListaServiciosDefectoalPlan().length > 0
				      && outParam01.getRespuesta() != null 
				      && outParam01.getRespuesta().getCodigoError() == 0){
					   		respuestaFinal.setListaServiciosDefectoalPlan(outParam01.getListaServiciosDefectoalPlan());
				   }else{
					   ServicioSuplementarioDTO[] listaServiciosDefectoalPlan = null;
					   respuestaFinal.setListaServiciosDefectoalPlan(listaServiciosDefectoalPlan);
					   respuestaFinal.setRespuesta(outParam01.getRespuesta());
				   }
				   logger.info("se termina la construccion de la lista (listaServiciosDefectoalPlan)");
			   }else{
				    if(datosAbonados!= null && datosAbonados.getRespuesta() != null && datosAbonados.getRespuesta().getCodigoError() != 0){
						   respuestaFinal.setRespuesta(datosAbonados.getRespuesta());
						   return respuestaFinal;
				    }else{
				    	respuesta = new RespuestaDTO();
				    	respuesta.setCodigoError(-10003);
				    	respuesta.setMensajeError("El número de teléfono ingresado no existe, esta dado de baja o en proceso de baja.");
				    	respuestaFinal.setRespuesta(respuesta);
				    	return respuestaFinal;
				    }
				   
			   }
	    logger.info("termina la obtención de los datos los datos de los servicios suplementarios, con el tipo Nº 1");
		
	    
		logger.info("construción para obtener los datos de los servicios suplementario, con el tipo Nº 2");
		   if(abonado != null && abonado.getNumAbonado()!=0){
			   parametrosServiciosSuplementario = new ConServSupleDTO();
			   parametrosServiciosSuplementario.setNumeroAbonado(abonado.getNumAbonado());
			   parametrosServiciosSuplementario.setTipo(2);
			   logger.info("consultaServicioSuplem:antes()");
			   com.tmmas.gte.integraciongtecommon.dto.ServicioSupleRespondeDTO outParam02 = servicioSuplementarioDTODAO.consultarServicioSuplem(parametrosServiciosSuplementario);
			   logger.info("consultaServicioSuplem:despues()");

			   logger.info("se comienza a construir la siguiente lista (listaServiciosContratados)");
			   if(   outParam02 != null 
				  && outParam02.getListaServiciosDefectoalPlan() != null 
				  && outParam02.getListaServiciosDefectoalPlan().length > 0 
				  && outParam02.getRespuesta() != null 
				  && outParam02.getRespuesta().getCodigoError() == 0){
				   			respuestaFinal.setListaServiciosContratados(outParam02.getListaServiciosDefectoalPlan());
			   }else{
						   ServicioSuplementarioDTO[] listaServicioSuplementario = null;
						   respuestaFinal.setListaServiciosContratados(listaServicioSuplementario);
						   respuestaFinal.setRespuesta(outParam02.getRespuesta());
			   }
			   logger.info("se termina la construccion de la lista (listaServiciosContratados)");
		   }else{
			    if(datosAbonados!= null && datosAbonados.getRespuesta() != null && datosAbonados.getRespuesta().getCodigoError() != 0){
					   respuestaFinal.setRespuesta(datosAbonados.getRespuesta());
					   return respuestaFinal;
			    }else{
			    	respuesta = new RespuestaDTO();
			    	respuesta.setCodigoError(-10003);
			    	respuesta.setMensajeError("El número de teléfono ingresado no existe, esta dado de baja o en proceso de baja.");
			    	respuestaFinal.setRespuesta(respuesta);
			    	return respuestaFinal;
			    }
		   }
		logger.info("termina la obtención de los datos los datos de los servicios suplementarios, con el tipo Nº 2");
		
		logger.info("contuyendo el ServicioSupleRespondeDTO para el return");
		   if(datosAbonados != null && datosAbonados.getRespuesta() != null && datosAbonados.getListadoAbonados() != null && datosAbonados.getListadoAbonados().length == 0){
			   if(datosAbonados.getRespuesta().getCodigoError() == 0 ){
				   datosAbonados.getRespuesta().setCodigoError(-10027);
				   datosAbonados.getRespuesta().setMensajeError("Error, No es posible obtener datos del abonado para el teléfono consultado.");
				   datosAbonados.getRespuesta().setNumeroEvento(0);
			   }
			      respuestaFinal.setRespuesta(datosAbonados.getRespuesta());

		   }else{
			   if((respuestaFinal.getListaServiciosDefectoalPlan()!= null 
				&& respuestaFinal.getListaServiciosDefectoalPlan().length == 0) &&
				  (respuestaFinal.getListaServiciosContratados() != null 
				&& respuestaFinal.getListaServiciosContratados().length == 0) ){

				   datosAbonados.getRespuesta().setCodigoError(-10028);
				   datosAbonados.getRespuesta().setMensajeError("Error, No fue posible obtener los servicios suplementarios contratados por el abonado asociado al número de teléfono ingresado");
				   datosAbonados.getRespuesta().setNumeroEvento(0);
				   
			   }
			   respuestaFinal.setRespuesta(datosAbonados.getRespuesta());
		   }
		logger.info("fin de la contucción el ServicioSupleRespondeDTO");

		return respuestaFinal;
	}

	/**
	* Activa o desactiva Servicios Suplementarios
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO activarDesactivarSS(com.tmmas.gte.integraciongtecommon.dto.ActDesServSupleDto inParam0)
		 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		Global global = Global.getInstance();
		//String concat="";
		String concat = null;
		ActDesSSDto 		 actDesSSDto	 		= new ActDesSSDto();				//DTO para enviar a Activar y desactivar Servicios
		SecuenciaDTO 		 secuenciaDto 			= new SecuenciaDTO();				//DTO para recuperar el numero de Secuencia
		RespuestaDTO 		 respuesta				= new RespuestaDTO();				//Dto de Respuesta
		EsTelefIgualClieDTO  inParam1	 			= new EsTelefIgualClieDTO();		// Dto para setear el numero de telefono para recuperar el codigo cliente
		AuditoriaDTO		 codPuntoAccesoDto		= new AuditoriaDTO();		
		AuditoriaDTO	 	 codAplicacionDto		= new AuditoriaDTO();		
		AuditoriaDTO	 	 codServicioDto			= new AuditoriaDTO();		
		AuditoriaDTO	 	 nombreUsuarioDto		= new AuditoriaDTO();	
		ArrayList 			 campos					= new ArrayList();
		EntServSupleDTO 	 ArregloEntrada			= new EntServSupleDTO();
		RespuestaDTO 		 puntoAccesoValidado    = new RespuestaDTO();
		
		
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
				puntoAccesoValidado.setCodigoError(puntoAcceso.getRespuesta().getCodigoError());
				puntoAccesoValidado.setMensajeError(puntoAcceso.getRespuesta().getMensajeError());
				puntoAccesoValidado.setNumeroEvento(puntoAcceso.getRespuesta().getNumeroEvento());
				return puntoAccesoValidado;
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
					return aplicacionValidada;
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
				return servicioValidado;
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
				return usuarioValidado;
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
	        	if (!(valorcampos.getNombreCampo()).equals("ListaActDesSS"))
	        	{
	        		auditoriaServicioDTO.setNomParametro(valorcampos.getNombreCampo());
	        		auditoriaServicioDTO.setValParametro(valorcampos.getValorCampo());
	        		logger.info("insertarServicios:start()");
	        		logger.info("insertarServicios:antes()");
	        		RespuestaDTO servicio =  auditoriaDAO.insertarServicios(auditoriaServicioDTO);
	        		logger.info("insertarServicios:despues()");
	        		logger.info("insertarServicios:end()");
					if (servicio != null &&  servicio.getCodigoError()!=0  )
					{
						return servicio;
					}
	        	}	
	       }
	        //	Inicio de Obtención de Nombres de Campos del DTO interno 	
	        logger.info("ObtenerCampos.getAttributes:start()");
    		logger.info("ObtenerCampos.getAttributes:antes()");
	        campos = ObtenerCampos.getAttributes(ArregloEntrada.getClass(),ArregloEntrada);
	        logger.info("ObtenerCampos.getAttributes:despues()");
    		logger.info("ObtenerCampos.getAttributes:end()");
    		// Fin de Obtención de Nombres de Campos del DTO interno 
    		Iterator  i2 = campos.iterator();
    		//recorrido del ArraylList(obtencion de nombres de Campos) 
	        while(i2.hasNext())
	        {	
	        	NombreCamposDTO valorcampos = (NombreCamposDTO)i2.next();
	        	auditoriaServicioDTO.setNomParametro(valorcampos.getNombreCampo());
	        	for (int cont=0;cont<inParam0.getListaActDesSS().length;cont++)
				{
	        		auditoriaServicioDTO.setValParametro(inParam0.getListaActDesSS()[cont].getCodServicio());
	        		logger.info("insertarServicios:start()");
	        		logger.info("insertarServicios:antes()");
					RespuestaDTO servicio2 =  auditoriaDAO.insertarServicios(auditoriaServicioDTO);
					logger.info("insertarServicios:despues()");
	        		logger.info("insertarServicios:end()");
					if (servicio2 != null &&  servicio2.getCodigoError()!=0  )
					{
						return servicio2;
					}
				}	
			}
		}else
		{
			respuesta.setCodigoError(auditoria.getRespuesta().getCodigoError());
			respuesta.setMensajeError(auditoria.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(auditoria.getRespuesta().getNumeroEvento());
			return respuesta;
		}
		//Fin de Registro de auditoría 		
		
		inParam1.setNum_telefono1(inParam0.getNumTelefono());				// setiando el numero de telefono
		logger.info("consultarAbonadoTelefono:start()");
		logger.info("consultarAbonadoTelefono:antes()");
		com.tmmas.gte.integraciongtecommon.dto.AbonadoOutDTO outParam = abonadoDAO.consultarAbonadoTelefono(inParam1);
		logger.info("consultarAbonadoTelefono:despues()");
		logger.info("consultarAbonadoTelefono:end()");
		if (outParam != null && outParam.getRespuesta()!= null &&  outParam.getRespuesta().getCodigoError()==0  )
		{
			secuenciaDto.setNomSecuencia(global.getValor("nombre.secuenciaSS"));
			logger.info("consultarSecuencia:start()");
			logger.info("consultarSecuencia:antes()");
			com.tmmas.gte.integraciongtecommon.dto.SecuenciaDTO responseSecuencia = parametrosGeneralesDTODAO.consultarSecuencia(secuenciaDto);
			logger.info("consultarSecuencia:despues()");
			logger.info("consultarSecuencia:end()");
			if (responseSecuencia != null && responseSecuencia.getRespuesta()!= null &&  responseSecuencia.getRespuesta().getCodigoError()==0  )
			{
				
				if ((inParam0.getListaActDesSS()!=null)&&(inParam0.getListaActDesSS().length>0))
				{
					for (int i=0;i<inParam0.getListaActDesSS().length;i++)
					{
						concat = "|"+inParam0.getListaActDesSS()[i].getCodServicio();
					}
					concat += "|";
					concat=concat.trim();
					actDesSSDto.setNumAbonado(outParam.getListadoAbonados()[0].getNumAbonado());
					actDesSSDto.setNumTelefono(inParam0.getNumTelefono());
					if (inParam0.isActDes()==true)
					{
						actDesSSDto.setListaSSAct(concat);
					}else
					{
						actDesSSDto.setListaSSDes(concat);
					}
					actDesSSDto.setNumSecuencia(responseSecuencia.getNumSecuencia());
					actDesSSDto.setCodOOSS(global.getValor("codigo.ooss"));
					actDesSSDto.setImporTotal(Long.parseLong(global.getValor("importe.total")));
					actDesSSDto.setUsuario(inParam0.getAuditoria().getNombreUsuario());
					actDesSSDto.setComentario(global.getValor("comentario.ooss"));
					logger.info("actDesServicioSuplem:start()");
					logger.info("actDesServicioSuplem:antes()");
					respuesta = servicioSuplementarioDTODAO.activarDesactivarSS(actDesSSDto);
					logger.info("actDesServicioSuplem:despues()");
					logger.info("actDesServicioSuplem:end()");
					if (respuesta.getCodigoError()==0)
					{
						respuesta.setMensajeError("El sistema informa que la activación/desactivación de los servicios suplementarios fue exitosa");
					}
				}
				else
				{
					respuesta.setCodigoError(-10029);
					respuesta.setMensajeError("No se han ingresado códigos de servicio para activar y/o desactivar. ");
					return respuesta;
				}
			}
			else
			{
				respuesta.setCodigoError(-10030);
				respuesta.setMensajeError("No es posible obtener un número de secuencia para la OOSS.");
				return respuesta;
			}
		}
		else
		{	
			respuesta.setCodigoError(outParam.getRespuesta().getCodigoError());
			respuesta.setMensajeError("No es posible obtener datos del abonado para el teléfono consultado");
			respuesta.setNumeroEvento(outParam.getRespuesta().getNumeroEvento());
			//return respuesta;
		}
		return respuesta;
	}

	/**
	* Entrega numero Secuencia
	*/
	public com.tmmas.gte.integraciongtecommon.dto.SecuenciaDTO consultarSecuencia(com.tmmas.gte.integraciongtecommon.dto.SecuenciaDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		logger.info("consultarSecuencia:start()");
		logger.info("consultarSecuencia:antes()");
		com.tmmas.gte.integraciongtecommon.dto.SecuenciaDTO outParam0 = parametrosGeneralesDTODAO.consultarSecuencia(inParam0);
		logger.info("consultarSecuencia:despues()");
		logger.info("consultarSecuencia:end()");
		return outParam0;
	}	

	/**
	* Entrega una lista de Servicios Suplenetarios activos y otra de Servicios Suplementarios Inactivos
	* (Consultar Estado de los Componentes)
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ComponentesResponseDTO consultarEstadoComponentes(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
		 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
	
		AuditoriaDTO		 	codPuntoAccesoDto		= new AuditoriaDTO();		
		AuditoriaDTO	 	 	codAplicacionDto		= new AuditoriaDTO();		
		AuditoriaDTO	 	 	codServicioDto			= new AuditoriaDTO();		
		AuditoriaDTO	 	 	nombreUsuarioDto		= new AuditoriaDTO();	
		ArrayList 			 	campos					= new ArrayList();
		ArrayList 			 	listSSActivos			= new ArrayList();
		ArrayList 			 	listSSInactivos			= new ArrayList();
		ComponentesResponseDTO 	componentesResponseDTO 	= new ComponentesResponseDTO();
		AbonadoDTO 				abonadoDTO 				= new AbonadoDTO();
		EsTelefIgualClieDTO 	telefonoDTO 			= new EsTelefIgualClieDTO();
				
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
				componentesResponseDTO.setRespuesta(puntoAcceso.getRespuesta());
				return componentesResponseDTO;
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
					componentesResponseDTO.setRespuesta(aplicacionValidada);
					return componentesResponseDTO;
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
				componentesResponseDTO.setRespuesta(servicioValidado);
				return componentesResponseDTO;
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
				componentesResponseDTO.setRespuesta(usuarioValidado);
				return componentesResponseDTO;
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
						componentesResponseDTO.setRespuesta(servicio);
						return componentesResponseDTO;
					}
	       }
	        	       
		}else
		{
			componentesResponseDTO.setRespuesta(auditoria.getRespuesta());
			return componentesResponseDTO;
		}
		//Fin de Registro de auditoría 		
		
		componentesResponseDTO = new ComponentesResponseDTO();
		telefonoDTO.setNum_telefono1(inParam0.getNumeroTelefono());				// setiando el numero de telefono
		logger.info("consultarAbonadoTelefono:start()");
		logger.info("consultarAbonadoTelefono:antes()");
		com.tmmas.gte.integraciongtecommon.dto.AbonadoOutDTO outParam = abonadoDAO.consultarAbonadoTelefono(telefonoDTO);
		logger.info("consultarAbonadoTelefono:despues()");
		logger.info("consultarAbonadoTelefono:end()");
		if (outParam != null && outParam.getRespuesta()!= null &&  outParam.getRespuesta().getCodigoError()==0  ){
			abonadoDTO.setNumAbonado(outParam.getListadoAbonados()[0].getNumAbonado());
			logger.info("consultarSSActivos:start()");
			logger.info("consultarSSActivos:antes()");
			LstComponentesDTO lstComponentesActivos = servicioSuplementarioDTODAO.consultarSSActivos(abonadoDTO);
			logger.info("consultarSSActivos:despues()");
			logger.info("consultarSSActivos:end()");
			if (lstComponentesActivos != null && lstComponentesActivos.getRespuesta()!= null &&  lstComponentesActivos.getRespuesta().getCodigoError()==0  )
			{
				for(int i=0;i< lstComponentesActivos.getSerciviosSuplementarios().length;i++){
					ComponentesDTO componentesDTO = new ComponentesDTO();
					componentesDTO.setCodNivel(lstComponentesActivos.getSerciviosSuplementarios()[i].getCodNivel());
					componentesDTO.setCodServicio(lstComponentesActivos.getSerciviosSuplementarios()[i].getCodServicio());
					componentesDTO.setCodServsupl(lstComponentesActivos.getSerciviosSuplementarios()[i].getCodServsupl());
					componentesDTO.setDesServicio(lstComponentesActivos.getSerciviosSuplementarios()[i].getDesServicio());
					listSSActivos.add(componentesDTO);
				}
				
				componentesResponseDTO.setSsActivos((com.tmmas.gte.integraciongtecommon.dto.ComponentesDTO[])
						com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(listSSActivos.toArray(),
												com.tmmas.gte.integraciongtecommon.dto.ComponentesDTO.class));
				
				
				
				
				abonadoDTO.setNumAbonado(outParam.getListadoAbonados()[0].getNumAbonado());
				logger.info("consultarSSInactivos:start()");
				logger.info("consultarSSInactivos:antes()");
				LstComponentesDTO lstComponentesInactivos = servicioSuplementarioDTODAO.consultarSSInactivos(abonadoDTO);
				logger.info("consultarSSInactivos:despues()");
				logger.info("consultarSSInactivos:end()");
				if (lstComponentesInactivos != null && lstComponentesInactivos.getRespuesta()!= null &&  lstComponentesInactivos.getRespuesta().getCodigoError()==0)
				{
					for(int i=0;i< lstComponentesInactivos.getSerciviosSuplementarios().length;i++)
					{
						ComponentesDTO componentesDTO = new ComponentesDTO();
						componentesDTO.setCodNivel(lstComponentesInactivos.getSerciviosSuplementarios()[i].getCodNivel());
						componentesDTO.setCodServicio(lstComponentesInactivos.getSerciviosSuplementarios()[i].getCodServicio());
						componentesDTO.setCodServsupl(lstComponentesInactivos.getSerciviosSuplementarios()[i].getCodServsupl());
						componentesDTO.setDesServicio(lstComponentesInactivos.getSerciviosSuplementarios()[i].getDesServicio());
						listSSInactivos.add(componentesDTO);
					}
				
				        componentesResponseDTO.setSsInactivos((com.tmmas.gte.integraciongtecommon.dto.ComponentesDTO[])
							com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(listSSInactivos.toArray(),
													com.tmmas.gte.integraciongtecommon.dto.ComponentesDTO.class));
				   
				     componentesResponseDTO.setRespuesta(lstComponentesInactivos.getRespuesta());
					
				}else{
					outParam.getRespuesta().setMensajeError("No ha sido posible consultar el estado de los componentes asociados al número de teléfono ingresado");
					componentesResponseDTO.setRespuesta(outParam.getRespuesta());
				}
				
			}
			else
			{
				outParam.getRespuesta().setMensajeError("No ha sido posible consultar el estado de los componentes asociados al número de teléfono ingresado");
				componentesResponseDTO.setRespuesta(outParam.getRespuesta());
			}
		}
		else
		{	
			outParam.getRespuesta().setMensajeError("No ha sido posible consultar el estado de los componentes asociados al número de teléfono ingresado");
			componentesResponseDTO.setRespuesta(outParam.getRespuesta());
		}
		return componentesResponseDTO;
	}	
	
	/**
	* se ingresa el numero de abonado y retorna un SeguroDTO con todos los datos del seguro.
	*/
	public com.tmmas.gte.integraciongtecommon.dto.SeguroResponseDTO consultarSeguroTelefono(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		
		logger.info("declaracion de variable:start()"); 
		SeguroInDTO seguroEntrada = null;
		EsTelefIgualClieDTO telefono  = null;
		AbonadoOutDTO datosAbonados = null; 
		AbonadoDTO abonado = null; 
		RespuestaDTO respuesta = new RespuestaDTO();
		SeguroResponseDTO  segurosResponde      = new SeguroResponseDTO();
		AuditoriaDTO	codPuntoAccesoDto		= new AuditoriaDTO();		
		AuditoriaDTO	codAplicacionDto		= new AuditoriaDTO();		
		AuditoriaDTO	codServicioDto			= new AuditoriaDTO();		
		AuditoriaDTO	nombreUsuarioDto		= new AuditoriaDTO();
		ArrayList 		campos					= new ArrayList();
		logger.info("fin de la declaracion de variable:end()");
		
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
				segurosResponde.setRespuesta(respuesta);
				return segurosResponde;
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
					segurosResponde.setRespuesta(aplicacionValidada);
					return segurosResponde;
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
				segurosResponde.setRespuesta(servicioValidado);
				return segurosResponde;
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
				segurosResponde.setRespuesta(usuarioValidado);
				return segurosResponde;
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
							segurosResponde.setRespuesta(respuesta);
							return segurosResponde;
						}
			        }	
				}else
				{
					respuesta.setCodigoError(auditoria.getRespuesta().getCodigoError());
					respuesta.setMensajeError(auditoria.getRespuesta().getMensajeError());
					respuesta.setNumeroEvento(auditoria.getRespuesta().getNumeroEvento());
					segurosResponde.setRespuesta(respuesta);
					return segurosResponde;
				}
			//Fin de Registro de auditoría 
		
				logger.info("utilizando AbonadoImpl");
				logger.info("utilizando metodo:consultarAbonadoTelefono");
				     	telefono = new EsTelefIgualClieDTO();
				     	if(inParam0 != null && inParam0.getNumeroTelefono() != 0){
				     		telefono.setNum_telefono1(inParam0.getNumeroTelefono());
				     		datosAbonados = abonadoDAO.consultarAbonadoTelefono(telefono);
				     	}
						logger.info("recuperacion de datos del abanado");
				     	if(   datosAbonados != null 
				     	   && datosAbonados.getListadoAbonados() != null 
				     	   && datosAbonados.getListadoAbonados().length > 0){
					     		for(int i = 0 ; i < datosAbonados.getListadoAbonados().length; i++){
					     			abonado = datosAbonados.getListadoAbonados()[i]; 
					     		}
				     	}
				logger.info("cerrando metodo :consultarAbonadoTelefono");
				logger.info("cerrando AbonadoImpl");		
		
		
				logger.info("consultarSeguroTelefonico:start()");
				if(abonado != null && abonado.getCodCliente()!=0 && abonado.getNumAbonado() != 0){
					seguroEntrada = new SeguroInDTO();
					seguroEntrada.setNumeroAbonado(abonado.getNumAbonado());
					logger.info("consultarSeguroTelefonico:antes()");
					com.tmmas.gte.integraciongtecommon.dto.SeguroDTO outParam0 = servicioSuplementarioDTODAO.consultarSeguroTelefonico(seguroEntrada);
					logger.info("consultarSeguroTelefonico:despues()");
					if(outParam0 != null && outParam0.getRespuesta() != null && outParam0.getRespuesta().getCodigoError() == 0 && outParam0.getCodSeguro() != null && !outParam0.getCodSeguro().equals("")){
						segurosResponde = new SeguroResponseDTO();
						ArrayList listaRespuestaAlCliente = new ArrayList();
						SeguroOutDTO vistaCliente = new SeguroOutDTO();
						vistaCliente.setCodSeguro(outParam0.getCodSeguro());
						vistaCliente.setDesSeguro(outParam0.getDesSeguro());
						vistaCliente.setNumeroEventos(outParam0.getNumeroEventos());
						vistaCliente.setImporteEquipo(outParam0.getImporteEquipo());
						vistaCliente.setFecAlta(outParam0.getFecAlta());
						vistaCliente.setFecFinContrato(outParam0.getFecFinContrato());
						vistaCliente.setNumMaxen(outParam0.getNumMaxen());
						vistaCliente.setTipCobertura(outParam0.getTipCobertura());
						vistaCliente.setDesValor(outParam0.getDesValor());
						vistaCliente.setDeducible(outParam0.getDeducible());
						vistaCliente.setImpSegur(outParam0.getImpSegur());
						
						listaRespuestaAlCliente.add(vistaCliente);
						logger.info("contruyendo la  responde de seguro:inicio()");
						segurosResponde.setLstListadoSeguros((com.tmmas.gte.integraciongtecommon.dto.SeguroOutDTO[])
									com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(listaRespuestaAlCliente.toArray(),
											com.tmmas.gte.integraciongtecommon.dto.SeguroOutDTO.class));
						logger.info("finaliza la construcción:fin()");
						
						segurosResponde.setRespuesta(outParam0.getRespuesta());
						return segurosResponde;
					}else{
						segurosResponde = new SeguroResponseDTO();
						respuesta = new RespuestaDTO();
					    if(outParam0 != null && outParam0.getRespuesta() != null && outParam0.getRespuesta().getCodigoError() != 0 ){
					    	respuesta.setCodigoError(outParam0.getRespuesta().getCodigoError());
					    	respuesta.setNumeroEvento(outParam0.getRespuesta().getNumeroEvento());
					    	respuesta.setMensajeError(outParam0.getRespuesta().getMensajeError());
					    }else{
					    	respuesta.setCodigoError(-10033);
					    	respuesta.setMensajeError("No ha sido posible obtener los datos asociados al seguro contratado por el abonado");
						}
					    segurosResponde.setRespuesta(respuesta);
					}
				}else{
					segurosResponde = new SeguroResponseDTO();
					respuesta = new RespuestaDTO();
				    if(datosAbonados != null && datosAbonados.getRespuesta() != null && datosAbonados.getRespuesta().getCodigoError() != 0 ){
				    	respuesta.setCodigoError(datosAbonados.getRespuesta().getCodigoError());
				    	respuesta.setNumeroEvento(datosAbonados.getRespuesta().getNumeroEvento());
				    	respuesta.setMensajeError(datosAbonados.getRespuesta().getMensajeError());
				    }else{
				    	respuesta.setCodigoError(-10003);
				    	respuesta.setMensajeError("El número de teléfono ingresado no existe, esta dado de baja o en proceso de baja.");
					}
				    segurosResponde.setRespuesta(respuesta);
					
				}
          		logger.info("consultarSeguroTelefonico:end()");
		return segurosResponde;
	}	
	
}