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
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaServicioDTO;
import com.tmmas.gte.integraciongtecommon.dto.CodPrestacionDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsPrestacionesDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsPrestacionesInDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsPrestacionesResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.EsTelefIgualClieDTO;
import com.tmmas.gte.integraciongtecommon.dto.GrupoPrestacionDTO;
import com.tmmas.gte.integraciongtecommon.dto.IdTipoPrestacionInDTO;
import com.tmmas.gte.integraciongtecommon.dto.NombreCamposDTO;
import com.tmmas.gte.integraciongtecommon.dto.ObtenerCampos;
import com.tmmas.gte.integraciongtecommon.dto.PrestacionResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.PuntoAccesoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO;
import com.tmmas.gte.integraciongtecommon.dto.TipoServicioResponseDTO;

public class PrestacionesDTOServiceImpl implements PrestacionesDTOService{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(PrestacionesDTOServiceImpl.class);
	private com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAO 			auditoriaDAO			= new com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.PrestacionesDTODAO 		prestacionDTODAO 		= new com.tmmas.gte.integraciongtebo.dao.PrestacionesDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAO 			abonadoDTODAO 			= new com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAOImpl();
	
	public PrestacionesDTOServiceImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongteservice/properties/IntegracionGTEService.properties");
	}

	/**
	* Retorna todas las Prestaciones existentes para clientes Prepago ó clientes Pospago e Híbrido
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsPrestacionesResponseDTO consultarCodigosPrestacion(IdTipoPrestacionInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		
		ConsPrestacionesInDTO grpPrestacion = new ConsPrestacionesInDTO();
		ConsPrestacionesResponseDTO grpPrestacionesResp = new ConsPrestacionesResponseDTO();
		grpPrestacion.setGrpPrestacion("");
		grpPrestacion.setIdTipoPrestacion(inParam0.getIdTipoPrestacion());
		RespuestaDTO respuesta = new RespuestaDTO();

		AuditoriaDTO		codPuntoAccesoDto	= new AuditoriaDTO();		
		AuditoriaDTO		codAplicacionDto	= new AuditoriaDTO();		
		AuditoriaDTO		codServicioDto		= new AuditoriaDTO();		
		AuditoriaDTO		nombreUsuarioDto	= new AuditoriaDTO();	
		ArrayList 			campos				= new ArrayList();
		GrupoPrestacionDTO 	ArregloEntrada		= new GrupoPrestacionDTO();
		
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		logger.info("consultarCodPrestacion:start()");
		logger.info("consultarCodPrestacion:antes()");
		
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
				grpPrestacionesResp.setRespuesta(respuesta);
				return grpPrestacionesResp;
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
					grpPrestacionesResp.setRespuesta(aplicacionValidada);
					return grpPrestacionesResp;
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
				grpPrestacionesResp.setRespuesta(servicioValidado);
				return grpPrestacionesResp;
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
				grpPrestacionesResp.setRespuesta(usuarioValidado);
				return grpPrestacionesResp;
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
	        	if (!(valorcampos.getNombreCampo()).equals("GrpPrestacionList"))
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
	        			respuesta.setCodigoError(servicio.getCodigoError());
	        			respuesta.setMensajeError(servicio.getMensajeError());
	        			respuesta.setNumeroEvento(servicio.getNumeroEvento());
	        			grpPrestacionesResp.setRespuesta(respuesta);
	        			return grpPrestacionesResp;
	        		}
	        	}
	        }
	        // Inicio de Obtención de Nombres de Campos del DTO interno 	
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
	        	for (int cont=0;cont<inParam0.getGrpPrestacionList().length;cont++)
				{
	        		auditoriaServicioDTO.setValParametro(inParam0.getGrpPrestacionList()[cont].getGrpPrestacion());
	        		logger.info("insertarServicios:start()");
	        		logger.info("insertarServicios:antes()");
					RespuestaDTO servicio2 =  auditoriaDAO.insertarServicios(auditoriaServicioDTO);
					logger.info("insertarServicios:despues()");
	        		logger.info("insertarServicios:end()");
					if (servicio2 == null &&  servicio2.getCodigoError()!=0  )
					{
						respuesta.setCodigoError(servicio2.getCodigoError());
						respuesta.setMensajeError(servicio2.getMensajeError());
						respuesta.setNumeroEvento(servicio2.getNumeroEvento());
						grpPrestacionesResp.setRespuesta(respuesta);
						return grpPrestacionesResp;
					}
				}	
			}
		}else
		{
			respuesta.setCodigoError(auditoria.getRespuesta().getCodigoError());
			respuesta.setMensajeError(auditoria.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(auditoria.getRespuesta().getNumeroEvento());
			grpPrestacionesResp.setRespuesta(respuesta);
			return grpPrestacionesResp;
		}
		//Fin de Registro de auditoría 		
		
		if (inParam0!=null && inParam0.getGrpPrestacionList().length>0){
			for (int i = 0; i < inParam0.getGrpPrestacionList().length; i++){
				if (i == inParam0.getGrpPrestacionList().length-1 && inParam0.getGrpPrestacionList()[i].getGrpPrestacion()!="" && inParam0.getGrpPrestacionList()[i].getGrpPrestacion()!=null){
					grpPrestacion.setGrpPrestacion(grpPrestacion.getGrpPrestacion() + "'" + inParam0.getGrpPrestacionList()[i].getGrpPrestacion());
				}
				if (i==0 && i < inParam0.getGrpPrestacionList().length-1){
					grpPrestacion.setGrpPrestacion(inParam0.getGrpPrestacionList()[i].getGrpPrestacion() + "',");
				}
				if (i==0 && i == inParam0.getGrpPrestacionList().length-1){
					grpPrestacion.setGrpPrestacion(inParam0.getGrpPrestacionList()[i].getGrpPrestacion());
				}
				if(inParam0.getGrpPrestacionList()[i].getGrpPrestacion()!="" && inParam0.getGrpPrestacionList()[i].getGrpPrestacion()!=null && i > 0 && i < inParam0.getGrpPrestacionList().length-1){
					grpPrestacion.setGrpPrestacion(grpPrestacion.getGrpPrestacion() + "'" + inParam0.getGrpPrestacionList()[i].getGrpPrestacion()+ "',");	
				}
			}
		}
		
		com.tmmas.gte.integraciongtecommon.dto.ConsPrestacionesResponseDTO outParam0 = prestacionDTODAO.consultarCodigosPrestacion(grpPrestacion);
		logger.info("consultarCodPrestacion:despues()");
		logger.info("consultarCodPrestacion:end()");
		
		if (outParam0 != null && outParam0.getRespuesta()!= null &&  outParam0.getRespuesta().getCodigoError()==0  ){
			if (outParam0.getListPrestaciones().length > 0){
				grpPrestacionesResp.setListPrestaciones(outParam0.getListPrestaciones());
				respuesta.setCodigoError(outParam0.getRespuesta().getCodigoError());
				respuesta.setMensajeError(outParam0.getRespuesta().getMensajeError());
				respuesta.setNumeroEvento(outParam0.getRespuesta().getNumeroEvento());
				grpPrestacionesResp.setRespuesta(respuesta);
				if (outParam0.getListPrestaciones().length == 0){
					respuesta.setCodigoError(-10025);
					respuesta.setMensajeError("No ha sido posible obtener los códigos de prestación para los datos ingresados.");
					respuesta.setNumeroEvento(0);
					grpPrestacionesResp.setRespuesta(respuesta);
				}
			}else{
				respuesta.setCodigoError(-10025);
				respuesta.setMensajeError("No ha sido posible obtener los códigos de prestación para los datos ingresados.");
				respuesta.setNumeroEvento(0);
				grpPrestacionesResp.setRespuesta(respuesta);
			}
		}else{
			respuesta.setCodigoError(-10025);
			respuesta.setMensajeError("No ha sido posible obtener los códigos de prestación para los datos ingresados.");
			respuesta.setNumeroEvento(0);
			grpPrestacionesResp.setRespuesta(respuesta);
		}
		return grpPrestacionesResp;
	}
	
	/**
	* Entrega datos de los grupos de prestación existentes
	*/
	public com.tmmas.gte.integraciongtecommon.dto.PrestacionResponseDTO consultarGruposPrestacion(com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		
		PrestacionResponseDTO respuestaFinal = new PrestacionResponseDTO();
		
		AuditoriaDTO		 codPuntoAccesoDto		= new AuditoriaDTO();		
		AuditoriaDTO	 	 codAplicacionDto		= new AuditoriaDTO();		
		AuditoriaDTO	 	 codServicioDto			= new AuditoriaDTO();		
		AuditoriaDTO	 	 nombreUsuarioDto		= new AuditoriaDTO();	
		ArrayList 			 campos					= new ArrayList();

		// Realizando Proceso de Auditoria 
		// Validación de Punto Acceso
		codPuntoAccesoDto.setCodPuntoAcceso(inParam0.getCodPuntoAcceso());
		logger.info("validarPuntoAcceso:start()");
		logger.info("validarPuntoAcceso:antes()");
		PuntoAccesoResponseDTO  puntoAcceso =  auditoriaDAO.consultarPuntoAcceso(codPuntoAccesoDto);
		logger.info("validarPuntoAcceso:despues()");
		logger.info("validarPuntoAcceso:end()");
		if (puntoAcceso.getRespuesta().getCodigoError()!=0)
		{
			
			respuestaFinal.setRespuesta(puntoAcceso.getRespuesta());
			return respuestaFinal;
		}
		// Fin Validación de Punto Acceso
		// Validación de Cod. Aplicacion
		codAplicacionDto.setCodAplicacion(inParam0.getCodAplicacion());
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
		codServicioDto.setCodServicio(inParam0.getCodServicio());
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
		nombreUsuarioDto.setNombreUsuario(inParam0.getNombreUsuario());
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
		com.tmmas.gte.integraciongtecommon.dto.AuditoriaResponseDTO  auditoria =  auditoriaDAO.insertarAuditoria(inParam0);
		logger.info("insertarAuditoria:despues()");
		logger.info("insertarAuditoria:end()");
		if (auditoria != null && auditoria.getRespuesta()!= null &&  auditoria.getRespuesta().getCodigoError()==0  )
		{
			AuditoriaServicioDTO auditoriaServicioDTO = new AuditoriaServicioDTO();
			auditoriaServicioDTO.setCodAuditoria(auditoria.getCodAuditoria());
			auditoriaServicioDTO.setNombreUsuario(inParam0.getNombreUsuario());
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
					if (servicio == null &&  servicio.getCodigoError()!=0  )
					{
						respuestaFinal.setRespuesta(servicio);
						return respuestaFinal;
					}
	        	}	
	       }
	        
		}else
		{
			respuestaFinal.setRespuesta(auditoria.getRespuesta());
			return respuestaFinal;
		}
		//Fin de Registro de auditoría
		
		logger.info("consultarGruposPrestacion:start()");
		logger.info("consultarGruposPrestacion:antes()");
		
		logger.info("prestacionDTODAO.consultarGruposPrestacion:antes()");
		com.tmmas.gte.integraciongtecommon.dto.PrestacionResponseDTO outParam0 = prestacionDTODAO.consultarGruposPrestacion();
		logger.info("prestacionDTODAO.consultarGruposPrestacion:despues()");
		if (outParam0 != null && 
		    outParam0.getRespuesta()!= null &&  
		    outParam0.getRespuesta().getCodigoError()==0 &&
		    outParam0.getListadoPrestaciones() != null &&
		    outParam0.getListadoPrestaciones().length > 0){
			if(outParam0.getListadoPrestaciones() != null && outParam0.getListadoPrestaciones().length > 0){
				respuestaFinal.setListadoPrestaciones(outParam0.getListadoPrestaciones());
				respuestaFinal.setRespuesta(outParam0.getRespuesta());
			}else{
				RespuestaDTO nuevaRespuesta = new  RespuestaDTO();
				nuevaRespuesta.setCodigoError(-10026);
				nuevaRespuesta.setMensajeError("No ha sido posible obtener los grupos de prestaciones existentes.");
				respuestaFinal.setRespuesta(nuevaRespuesta);
			}
		}else{
			if(outParam0 != null && outParam0.getRespuesta()!= null &&  outParam0.getRespuesta().getCodigoError() != 0){
				respuestaFinal.setRespuesta(outParam0.getRespuesta());
			}else{
				RespuestaDTO nuevaRespuesta = new  RespuestaDTO();
				nuevaRespuesta.setCodigoError(-10026);
				nuevaRespuesta.setMensajeError("No ha sido posible obtener los grupos de prestaciones existentes.");
				respuestaFinal.setRespuesta(nuevaRespuesta);
			}
		}
		logger.info("consultarGruposPrestacion:despues()");
		logger.info("consultarGruposPrestacion:end()");
		return respuestaFinal;
	}
	
	/**
	* Servicio que permite consultar la descripción de la prestación asociada a un número de teléfono
	*/
	public com.tmmas.gte.integraciongtecommon.dto.TipoServicioResponseDTO consultarTipoServicio(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		
		TipoServicioResponseDTO tipoServicioResponseDTO = new TipoServicioResponseDTO();
		
		AuditoriaDTO		 codPuntoAccesoDto		= new AuditoriaDTO();		
		AuditoriaDTO	 	 codAplicacionDto		= new AuditoriaDTO();		
		AuditoriaDTO	 	 codServicioDto			= new AuditoriaDTO();		
		AuditoriaDTO	 	 nombreUsuarioDto		= new AuditoriaDTO();
		ArrayList 			 campos					= new ArrayList();
		RespuestaDTO 		 respuesta				= new RespuestaDTO();

		//Realizando Proceso de Auditoria 
		//Validación de Punto Acceso
		codPuntoAccesoDto.setCodPuntoAcceso(inParam0.getAuditoria().getCodPuntoAcceso());
		logger.info("validarPuntoAcceso:start()");
		logger.info("validarPuntoAcceso:antes()");
		PuntoAccesoResponseDTO  puntoAcceso =  auditoriaDAO.consultarPuntoAcceso(codPuntoAccesoDto);
		logger.info("validarPuntoAcceso:despues()");
		logger.info("validarPuntoAcceso:end()");
		if (puntoAcceso.getRespuesta().getCodigoError()!=0){	
			respuesta.setCodigoError(puntoAcceso.getRespuesta().getCodigoError());
			respuesta.setMensajeError(puntoAcceso.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(puntoAcceso.getRespuesta().getNumeroEvento());
			tipoServicioResponseDTO.setRespuesta(respuesta);
			return tipoServicioResponseDTO;
		}
		//Fin Validación de Punto Acceso
		//Validación de Cod. Aplicacion
		codAplicacionDto.setCodAplicacion(inParam0.getAuditoria().getCodAplicacion());
		if ((codAplicacionDto.getCodAplicacion()!=null)&&!(codAplicacionDto.getCodAplicacion()).equals("")){
			logger.info("validarAplicacion:start()");
			logger.info("validarAplicacion:antes()");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO aplicacionValidada =  auditoriaDAO.validarAplicacion(codAplicacionDto);
			logger.info("validarAplicacion:despues()");
			logger.info("validarAplicacion:end()");
			if (aplicacionValidada.getCodigoError()!=0){
				tipoServicioResponseDTO.setRespuesta(aplicacionValidada);
				return tipoServicioResponseDTO;
			}
		}
		//Fin validación de Cod. Aplicacion
		//Validación de Cod. Servicio
		codServicioDto.setCodServicio(inParam0.getAuditoria().getCodServicio());
		logger.info("validarServicio:start()");
		logger.info("validarServicio:antes()");
		com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO servicioValidado =  auditoriaDAO.validarServicio(codServicioDto);
		logger.info("validarServicio:despues()");
		logger.info("validarServicio:end()");
		if (servicioValidado.getCodigoError()!=0){
			tipoServicioResponseDTO.setRespuesta(servicioValidado);
			return tipoServicioResponseDTO;
		}
		//Fin Validación de Cod. Servicio
		//Validación de nombre Usuario
		nombreUsuarioDto.setNombreUsuario(inParam0.getAuditoria().getNombreUsuario());
		logger.info("validarNombreUsuario:start()");
		logger.info("validarNombreUsuario:antes()");
		com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO usuarioValidado =  auditoriaDAO.validarNombreUsuario(nombreUsuarioDto);
		logger.info("validarNombreUsuario:despues()");
		logger.info("validarNombreUsuario:end()");
		if (usuarioValidado.getCodigoError()!=0){
			tipoServicioResponseDTO.setRespuesta(usuarioValidado);
			return tipoServicioResponseDTO;
		}
		//Fin Validación de nombre Usuario
		
		//Inicio de Registro de auditoría 		
		logger.info("insertarAuditoria:start()");
		logger.info("insertarAuditoria:antes()");
		com.tmmas.gte.integraciongtecommon.dto.AuditoriaResponseDTO  auditoria =  auditoriaDAO.insertarAuditoria(inParam0.getAuditoria());
		logger.info("insertarAuditoria:despues()");
		logger.info("insertarAuditoria:end()");
		if (auditoria != null && auditoria.getRespuesta()!= null &&  auditoria.getRespuesta().getCodigoError()==0){
			AuditoriaServicioDTO auditoriaServicioDTO = new AuditoriaServicioDTO();
			auditoriaServicioDTO.setCodAuditoria(auditoria.getCodAuditoria());
			auditoriaServicioDTO.setNombreUsuario(inParam0.getAuditoria().getNombreUsuario());
			// Inicio de Obtención de Nombres de Campos del DTO de Entrada
			logger.info("ObtenerCampos.getAttributes:start()");
			logger.info("ObtenerCampos.getAttributes:antes()");
			campos = ObtenerCampos.getAttributes(inParam0.getClass(),inParam0);
			logger.info("ObtenerCampos.getAttributes:despues()");
			logger.info("ObtenerCampos.getAttributes:end()");
			//Fin de Obtención de Nombres de Campos del DTO de Entrada
			Iterator  i = campos.iterator();
			//Recorrido del ArraylList(obtencion de nombres de Campos) 
			while(i.hasNext()){	
				NombreCamposDTO valorcampos = (NombreCamposDTO)i.next();
				auditoriaServicioDTO.setNomParametro(valorcampos.getNombreCampo());
				auditoriaServicioDTO.setValParametro(valorcampos.getValorCampo());
				logger.info("insertarServicios:start()");
				logger.info("insertarServicios:antes()");
				RespuestaDTO servicio =  auditoriaDAO.insertarServicios(auditoriaServicioDTO);
				logger.info("insertarServicios:despues()");
				logger.info("insertarServicios:end()");
					if (servicio == null &&  servicio.getCodigoError()!=0  ){
						respuesta.setCodigoError(servicio.getCodigoError());
						respuesta.setMensajeError(servicio.getMensajeError());
						respuesta.setNumeroEvento(servicio.getNumeroEvento());
						tipoServicioResponseDTO.setRespuesta(respuesta);
						return tipoServicioResponseDTO;
					}
					
				}
		}else{
			respuesta.setCodigoError(auditoria.getRespuesta().getCodigoError());
			respuesta.setMensajeError(auditoria.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(auditoria.getRespuesta().getNumeroEvento());
			tipoServicioResponseDTO.setRespuesta(respuesta);
			return tipoServicioResponseDTO;
		}
		//Fin de Registro de auditoría
		
		logger.info("consultarTipoServicio:start()");
		logger.info("consultarTipoServicio:antes()");

		logger.info("declaracion de variables para el metodo consultarTipoServicio");
		CodPrestacionDTO codPrestacionDTO = new CodPrestacionDTO();
		logger.info("fin de la declaraciones de variables para el metodo consultarTipoServicio");

		
		
		EsTelefIgualClieDTO telefonoCliente = new EsTelefIgualClieDTO(); 
		telefonoCliente.setNum_telefono1(inParam0.getNumeroTelefono());

		if (telefonoCliente.getNum_telefono1() != 0){
			logger.info("consultarAbonadoTelefono:antes()");
			com.tmmas.gte.integraciongtecommon.dto.AbonadoOutDTO abonado = abonadoDTODAO.consultarAbonadoTelefono(telefonoCliente);
			logger.info("consultarAbonadoTelefono:despues()");
			if (abonado != null && abonado.getRespuesta()!= null &&  
				abonado.getListadoAbonados() != null && 
				abonado.getListadoAbonados().length > 0 &&  
				abonado.getRespuesta().getCodigoError() == 0){
				
					codPrestacionDTO.setCodPrestacion(abonado.getListadoAbonados()[0].getCodPrestacion());
					logger.info("consultarTipoServicio:antes()");
					TipoServicioResponseDTO consultarTipoServicio = prestacionDTODAO.consultarDescPrestacion(codPrestacionDTO);
					logger.info("consultarTipoServicio:despues()");
					
					if (consultarTipoServicio != null && consultarTipoServicio.getRespuesta()!= null &&  consultarTipoServicio.getRespuesta().getCodigoError() == 0){
						tipoServicioResponseDTO.setCodPrestacion(abonado.getListadoAbonados()[0].getCodPrestacion());
						tipoServicioResponseDTO.setDesPrestacion(consultarTipoServicio.getDesPrestacion());
						tipoServicioResponseDTO.setRespuesta(respuesta);
					}else{
						if(consultarTipoServicio != null && consultarTipoServicio.getRespuesta() != null && consultarTipoServicio.getRespuesta().getCodigoError() != 0){
							tipoServicioResponseDTO.setRespuesta(consultarTipoServicio.getRespuesta());
						}else{
							respuesta.setCodigoError(-10011);
				    		respuesta.setMensajeError("No ha sido posible obtener el código y descripción de prestación asociado al número de teléfono consultado.");
				    		tipoServicioResponseDTO.setRespuesta(respuesta);
						}
						return tipoServicioResponseDTO;
					}
			}else{
				if(abonado != null && abonado.getRespuesta() != null && abonado.getRespuesta().getCodigoError() != 0){
					tipoServicioResponseDTO.setRespuesta(abonado.getRespuesta());
				}else{
					respuesta.setCodigoError(-10011);
		    		respuesta.setMensajeError("No ha sido posible obtener el código y descripción de prestación asociado al número de teléfono consultado.");
				}
				tipoServicioResponseDTO.setRespuesta(respuesta);
			}  
		}else{
			respuesta.setCodigoError(-10011);
    		respuesta.setMensajeError("No fue posible obtener datos de cliente.");
    		
    		tipoServicioResponseDTO.setRespuesta(respuesta);
		}

		
		
		
		logger.info("consultarTipoServicio:despues()");
		logger.info("consultarTipoServicio:end()");
		return tipoServicioResponseDTO;
	}  

}