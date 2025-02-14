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
import com.tmmas.gte.integraciongtecommon.dto.ConPlanDTO;
import com.tmmas.gte.integraciongtecommon.dto.GrpCodPrestacionDTO;
import com.tmmas.gte.integraciongtecommon.dto.GrpCodPrestacionListDTO;
import com.tmmas.gte.integraciongtecommon.dto.GrupoPrestacionDTO;
import com.tmmas.gte.integraciongtecommon.dto.NombreCamposDTO;
import com.tmmas.gte.integraciongtecommon.dto.ObtenerCampos;
import com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioDTO;
import com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioResponseOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.PuntoAccesoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO;

public class PlanTarifarioDTOServiceImpl implements PlanTarifarioDTOService{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(PlanTarifarioDTOServiceImpl.class);
	private com.tmmas.gte.integraciongtebo.dao.PlanTarifarioDTODAO planTarifarioDTODAO = new com.tmmas.gte.integraciongtebo.dao.PlanTarifarioDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAO auditoriaDAO	= new com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAOImpl();

	public PlanTarifarioDTOServiceImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongteservice/properties/IntegracionGTEService.properties");
	}

	/**
	* Retorna plan Tarifario correspondiente a numero de teléfono
	*/
	public com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioResponseOutDTO consultarPlanTarifario(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		logger.info("declaración de variables:start()");
		PlanTarifarioResponseOutDTO planTarifarioResp = new PlanTarifarioResponseOutDTO();
		ConPlanDTO nuevaConsulta = new ConPlanDTO();
		RespuestaDTO respuesta = new RespuestaDTO();
		AuditoriaDTO	codPuntoAccesoDto		= new AuditoriaDTO();		
		AuditoriaDTO	codAplicacionDto		= new AuditoriaDTO();		
		AuditoriaDTO	codServicioDto			= new AuditoriaDTO();		
		AuditoriaDTO	nombreUsuarioDto		= new AuditoriaDTO();
		ArrayList 		campos					= new ArrayList();
		logger.info("fin de la declaración de variables:end()");
		
		logger.info("consultarPlanTarifario:start()");
		logger.info("consultarPlanTarifario:antes()");
		
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
				planTarifarioResp.setRespuesta(respuesta);
				return planTarifarioResp;
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
					planTarifarioResp.setRespuesta(aplicacionValidada);
					return planTarifarioResp;
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
				planTarifarioResp.setRespuesta(servicioValidado);
				return planTarifarioResp;
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
				planTarifarioResp.setRespuesta(usuarioValidado);
				return planTarifarioResp;
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
						planTarifarioResp.setRespuesta(respuesta);
						return planTarifarioResp;
					}
		        }	
			}else
			{
				respuesta.setCodigoError(auditoria.getRespuesta().getCodigoError());
				respuesta.setMensajeError(auditoria.getRespuesta().getMensajeError());
				respuesta.setNumeroEvento(auditoria.getRespuesta().getNumeroEvento());
				planTarifarioResp.setRespuesta(respuesta);
				return planTarifarioResp;
			}
		//Fin de Registro de auditoría 				

		if(inParam0 != null && inParam0.getNumeroTelefono()!= 0){
			nuevaConsulta.setNumeroTelefono(inParam0.getNumeroTelefono());
		}
		logger.info("consultarPlanTarifario:antes()");
		com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioResponseDTO outParam0 = planTarifarioDTODAO.consultarPlanTarifario(nuevaConsulta);
		logger.info("consultarPlanTarifario:despues()");
		if (outParam0 != null && outParam0.getRespuesta()!= null &&  outParam0.getRespuesta().getCodigoError()==0  ){
			if ( outParam0.getListPlanTarifario() != null && outParam0.getListPlanTarifario().length > 0){
				PlanTarifarioOutDTO plan = new PlanTarifarioOutDTO();
				for(int i= 0; i < outParam0.getListPlanTarifario().length; i++){
					PlanTarifarioDTO obj =  outParam0.getListPlanTarifario()[i];
					if(obj != null){
						plan.setCodPlanTarifario(obj.getCodPlanTarifario());
						plan.setDesPlanTarifario(obj.getDesPlanTarifario());
					}
				}
				com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioDTO planIn = new com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioDTO();
				planIn.setCodPlanTarifario(plan.getCodPlanTarifario());
				logger.info("consultarBolsaPlanTarifario:antes()");
				com.tmmas.gte.integraciongtecommon.dto.BolsaResponseDTO outParam1 = planTarifarioDTODAO.consultarBolsaPlanTarifario(planIn);
				logger.info("consultarBolsaPlanTarifario:despues()");
				if (outParam1 != null && outParam1.getRespuesta()!= null &&  outParam1.getRespuesta().getCodigoError()==0  ){
					plan.setCntBolsa(outParam1.getCntBolsa());
					plan.setCodBolsa(outParam1.getCodBolsa());
					plan.setIndUnidad(outParam1.getIndUnidad());
					plan.setDesUnidad(outParam1.getDesUnidad());
					plan.setFecIniVig(outParam1.getFecIniVig());
					plan.setFecTerVig(outParam1.getFecTerVig());
				}
				else{
					if(outParam1 != null && outParam1.getRespuesta()!= null){
						planTarifarioResp.setRespuesta(outParam1.getRespuesta());
					 }else{
						respuesta.setCodigoError(-10049);
						respuesta.setMensajeError("Se ha producido un error al consultar los datos de la bolsa asociada al plan tarifario.");
						respuesta.setNumeroEvento(0);
						planTarifarioResp.setRespuesta(respuesta);
					 }
				}
				planTarifarioResp.setPlanTarifario(plan);
				planTarifarioResp.setRespuesta(outParam0.getRespuesta());
			}else{
				if(outParam0 != null && outParam0.getRespuesta()!= null){
					planTarifarioResp.setRespuesta(outParam0.getRespuesta());
				 }else{
					respuesta.setCodigoError(-10024);
					respuesta.setMensajeError("Se ha producido un error al consultar los datos del plan tarifario.");
					respuesta.setNumeroEvento(0);
					planTarifarioResp.setRespuesta(respuesta);
				 }
			}
		}else{
			if(outParam0 != null && outParam0.getRespuesta()!= null){
				planTarifarioResp.setRespuesta(outParam0.getRespuesta());
			 }else{
				respuesta.setCodigoError(-10024);
				respuesta.setMensajeError("Se ha producido un error al consultar los datos del plan tarifario");
				respuesta.setNumeroEvento(0);
				planTarifarioResp.setRespuesta(respuesta);
			 }
		}
		logger.info("consultarPlanTarifario:end()");
		return planTarifarioResp;
	}

	/**
	* Retorna todos los planes tarifarios vigentes filtrando por grpPrestacion y codPrestacion
	*/
	public com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioResponseDTO consultarPlanesDisponibles(GrpCodPrestacionListDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		PlanTarifarioResponseDTO planTarifarioResp = new PlanTarifarioResponseDTO();
		RespuestaDTO respuesta = new RespuestaDTO();
		GrpCodPrestacionDTO grpCodPrestacion = new GrpCodPrestacionDTO();

		AuditoriaDTO		codPuntoAccesoDto	= new AuditoriaDTO();		
		AuditoriaDTO		codAplicacionDto	= new AuditoriaDTO();		
		AuditoriaDTO		codServicioDto		= new AuditoriaDTO();		
		AuditoriaDTO		nombreUsuarioDto	= new AuditoriaDTO();	
		ArrayList 			campos				= new ArrayList();
		GrupoPrestacionDTO 	ArregloEntrada		= new GrupoPrestacionDTO();
		CodPrestacionDTO 	ArregloEntrada1   	= new CodPrestacionDTO();
		
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		logger.info("consPlanesDispXgrpYcodPrestacion:start()");
		logger.info("consPlanesDispXgrpYcodPrestacion:antes()");
	
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
				planTarifarioResp.setRespuesta(respuesta);
				return planTarifarioResp;
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
					planTarifarioResp.setRespuesta(aplicacionValidada);
					return planTarifarioResp;
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
				planTarifarioResp.setRespuesta(servicioValidado);
				return planTarifarioResp;
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
				planTarifarioResp.setRespuesta(usuarioValidado);
				return planTarifarioResp;
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
			
		    //	Inicio de Obtención de Nombres de Campos del DTO interno 	
	        logger.info("ObtenerCampos.getAttributes:start()");
	        logger.info("ObtenerCampos.getAttributes:antes()");
	        campos = ObtenerCampos.getAttributes(ArregloEntrada.getClass(),ArregloEntrada);
	        logger.info("ObtenerCampos.getAttributes:despues()");
	        logger.info("ObtenerCampos.getAttributes:end()");
   		// Fin de Obtención de Nombres de Campos del DTO interno 
   		Iterator  i1 = campos.iterator();
   		//recorrido del ArraylList(obtencion de nombres de Campos) 
	        while(i1.hasNext())
	        {	
	        	NombreCamposDTO valorcampos = (NombreCamposDTO)i1.next();
	        	auditoriaServicioDTO.setNomParametro(valorcampos.getNombreCampo());
	        	for (int cont=0;cont<inParam0.getGrpPrestacionList().length;cont++)
				{
	        		auditoriaServicioDTO.setValParametro(inParam0.getGrpPrestacionList()[cont].getGrpPrestacion());
	        		logger.info("insertarServicios:start()");
	        		logger.info("insertarServicios:antes()");
					RespuestaDTO servicio1 =  auditoriaDAO.insertarServicios(auditoriaServicioDTO);
					logger.info("insertarServicios:despues()");
	        		logger.info("insertarServicios:end()");
					if (servicio1 == null &&  servicio1.getCodigoError()!=0  )
					{
						respuesta.setCodigoError(servicio1.getCodigoError());
						respuesta.setMensajeError(servicio1.getMensajeError());
						respuesta.setNumeroEvento(servicio1.getNumeroEvento());
						planTarifarioResp.setRespuesta(respuesta);
						return planTarifarioResp;
					}
				}	
			}    
	    //	Inicio de Obtención de Nombres de Campos del DTO interno 	
	        logger.info("ObtenerCampos.getAttributes:start()");
	        logger.info("ObtenerCampos.getAttributes:antes()");
	        campos = ObtenerCampos.getAttributes(ArregloEntrada1.getClass(),ArregloEntrada1);
	        logger.info("ObtenerCampos.getAttributes:despues()");
	        logger.info("ObtenerCampos.getAttributes:end()");
   		// Fin de Obtención de Nombres de Campos del DTO interno 
   		Iterator  i2 = campos.iterator();
   		//recorrido del ArraylList(obtencion de nombres de Campos) 
	        while(i2.hasNext())
	        {	
	        	NombreCamposDTO valorcampos = (NombreCamposDTO)i2.next();
	        	auditoriaServicioDTO.setNomParametro(valorcampos.getNombreCampo());
	        	for (int cont=0;cont<inParam0.getCodPrestacionList().length;cont++)
				{
	        		auditoriaServicioDTO.setValParametro(inParam0.getCodPrestacionList()[cont].getCodPrestacion());
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
						planTarifarioResp.setRespuesta(respuesta);
						return planTarifarioResp;
					}
				}	
			}
		}else
		{
			respuesta.setCodigoError(auditoria.getRespuesta().getCodigoError());
			respuesta.setMensajeError(auditoria.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(auditoria.getRespuesta().getNumeroEvento());
			planTarifarioResp.setRespuesta(respuesta);
			return planTarifarioResp;
		}
		//Fin de Registro de auditoría 		
		
		grpCodPrestacion.setGrpPrestacion("");
		grpCodPrestacion.setCodPrestacion("");
		if (inParam0!=null && inParam0.getGrpPrestacionList().length>0){
			for (int i = 0; i < inParam0.getGrpPrestacionList().length; i++){
				if (i == inParam0.getGrpPrestacionList().length-1 && inParam0.getGrpPrestacionList()[i].getGrpPrestacion()!="" && inParam0.getGrpPrestacionList()[i].getGrpPrestacion()!=null){
					grpCodPrestacion.setGrpPrestacion(grpCodPrestacion.getGrpPrestacion() + "'" + inParam0.getGrpPrestacionList()[i].getGrpPrestacion()+ "'");
				}
				if(inParam0.getGrpPrestacionList()[i].getGrpPrestacion()!="" && inParam0.getGrpPrestacionList()[i].getGrpPrestacion()!=null && i < inParam0.getGrpPrestacionList().length-1){
					grpCodPrestacion.setGrpPrestacion(grpCodPrestacion.getGrpPrestacion() + "'" + inParam0.getGrpPrestacionList()[i].getGrpPrestacion()+ "',");	
				}
			}
		}
		if (inParam0!=null && inParam0.getCodPrestacionList().length>0){
			for (int i = 0; i < inParam0.getCodPrestacionList().length; i++){
				if (i == inParam0.getCodPrestacionList().length-1 && inParam0.getCodPrestacionList()[i].getCodPrestacion()!="" && inParam0.getCodPrestacionList()[i].getCodPrestacion()!=null){
					grpCodPrestacion.setCodPrestacion(grpCodPrestacion.getCodPrestacion() + "'" + inParam0.getCodPrestacionList()[i].getCodPrestacion()+ "'");
				}
				if(inParam0.getCodPrestacionList()[i].getCodPrestacion()!="" && inParam0.getCodPrestacionList()[i].getCodPrestacion()!=null && i < inParam0.getCodPrestacionList().length-1){
					grpCodPrestacion.setCodPrestacion(grpCodPrestacion.getCodPrestacion() + "'" + inParam0.getCodPrestacionList()[i].getCodPrestacion()+ "',");	
				}
			}
		}
		
		com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioResponseDTO outParam0 = planTarifarioDTODAO.consultarPlanesDisponibles(grpCodPrestacion);
		logger.info("consPlanesDispXgrpYcodPrestacion:despues()");
		logger.info("consPlanesDispXgrpYcodPrestacion:end()");
		if (outParam0 != null && outParam0.getRespuesta()!= null &&  outParam0.getRespuesta().getCodigoError()==0  ){
			if (outParam0.getListPlanTarifario().length > 0){
				planTarifarioResp.setListPlanTarifario(outParam0.getListPlanTarifario());
				respuesta.setCodigoError(outParam0.getRespuesta().getCodigoError());
				respuesta.setMensajeError(outParam0.getRespuesta().getMensajeError());
				respuesta.setNumeroEvento(outParam0.getRespuesta().getNumeroEvento());
				planTarifarioResp.setRespuesta(respuesta);
			}else{
				respuesta.setCodigoError(outParam0.getRespuesta().getCodigoError());
				respuesta.setMensajeError(outParam0.getRespuesta().getMensajeError());
				respuesta.setNumeroEvento(outParam0.getRespuesta().getNumeroEvento());
				planTarifarioResp.setRespuesta(respuesta);
			}
		}else{
			respuesta.setCodigoError(outParam0.getRespuesta().getCodigoError());
			respuesta.setMensajeError(outParam0.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(outParam0.getRespuesta().getNumeroEvento());
			planTarifarioResp.setRespuesta(respuesta);
		}
		return planTarifarioResp;
	}
	
	/**
	* Retorna todos los planes tarifarios vigentes filtrando por grpPrestacion
	*/
	public com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioResponseDTO consultarPlanesDisponibles(com.tmmas.gte.integraciongtecommon.dto.GrupoPrestacionListDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		PlanTarifarioResponseDTO planTarifarioResp = new PlanTarifarioResponseDTO();
		RespuestaDTO respuesta = new RespuestaDTO();
		GrupoPrestacionDTO grpPrestacion = new GrupoPrestacionDTO();
		
		AuditoriaDTO		codPuntoAccesoDto	= new AuditoriaDTO();		
		AuditoriaDTO		codAplicacionDto	= new AuditoriaDTO();		
		AuditoriaDTO		codServicioDto		= new AuditoriaDTO();		
		AuditoriaDTO		nombreUsuarioDto	= new AuditoriaDTO();	
		ArrayList 			campos				= new ArrayList();
		GrupoPrestacionDTO 	ArregloEntrada		= new GrupoPrestacionDTO();
		
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		logger.info("consPlanesDispXgrpPrestacion:start()");
		logger.info("consPlanesDispXgrpPrestacion:antes()");
		
		
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
				planTarifarioResp.setRespuesta(respuesta);
				return planTarifarioResp;
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
					planTarifarioResp.setRespuesta(aplicacionValidada);
					return planTarifarioResp;
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
				planTarifarioResp.setRespuesta(servicioValidado);
				return planTarifarioResp;
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
				planTarifarioResp.setRespuesta(usuarioValidado);
				return planTarifarioResp;
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
			
//	    	Inicio de Obtención de Nombres de Campos del DTO interno 	
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
						planTarifarioResp.setRespuesta(respuesta);
						return planTarifarioResp;
					}
				}	
			}
		}else
		{
			respuesta.setCodigoError(auditoria.getRespuesta().getCodigoError());
			respuesta.setMensajeError(auditoria.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(auditoria.getRespuesta().getNumeroEvento());
			planTarifarioResp.setRespuesta(respuesta);
			return planTarifarioResp;
		}
		//Fin de Registro de auditoría 		
		
		
		grpPrestacion.setGrpPrestacion("");
		if (inParam0!=null && inParam0.getGrpPrestacionList().length>0){
			for (int i = 0; i < inParam0.getGrpPrestacionList().length; i++){
				if (i == inParam0.getGrpPrestacionList().length-1 && inParam0.getGrpPrestacionList()[i].getGrpPrestacion()!="" && inParam0.getGrpPrestacionList()[i].getGrpPrestacion()!=null){
					grpPrestacion.setGrpPrestacion(grpPrestacion.getGrpPrestacion() + "'" + inParam0.getGrpPrestacionList()[i].getGrpPrestacion()+ "'");
				}
				if(inParam0.getGrpPrestacionList()[i].getGrpPrestacion()!="" && inParam0.getGrpPrestacionList()[i].getGrpPrestacion()!=null && i < inParam0.getGrpPrestacionList().length-1){
					grpPrestacion.setGrpPrestacion(grpPrestacion.getGrpPrestacion() + "'" + inParam0.getGrpPrestacionList()[i].getGrpPrestacion()+ "',");	
				}
			}
		}
		
		com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioResponseDTO outParam0 = planTarifarioDTODAO.consultarPlanesDisponibles(grpPrestacion);
		logger.info("consPlanesDispXgrpPrestacion:despues()");
		logger.info("consPlanesDispXgrpPrestacion:end()");
		if (outParam0 != null && outParam0.getRespuesta()!= null &&  outParam0.getRespuesta().getCodigoError()==0  ){
			if (outParam0.getListPlanTarifario().length > 0){
				planTarifarioResp.setListPlanTarifario(outParam0.getListPlanTarifario());
				respuesta.setCodigoError(outParam0.getRespuesta().getCodigoError());
				respuesta.setMensajeError(outParam0.getRespuesta().getMensajeError());
				respuesta.setNumeroEvento(outParam0.getRespuesta().getNumeroEvento());
				planTarifarioResp.setRespuesta(respuesta);
			}else{
				respuesta.setCodigoError(outParam0.getRespuesta().getCodigoError());
				respuesta.setMensajeError(outParam0.getRespuesta().getMensajeError());
				respuesta.setNumeroEvento(outParam0.getRespuesta().getNumeroEvento());
				planTarifarioResp.setRespuesta(respuesta);
			}
		}else{
			respuesta.setCodigoError(outParam0.getRespuesta().getCodigoError());
			respuesta.setMensajeError(outParam0.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(outParam0.getRespuesta().getNumeroEvento());
			planTarifarioResp.setRespuesta(respuesta);
		}
		return planTarifarioResp;
	}
	
	/**
	* Retorna todos los planes tarifarios vigentes 
	*/
	public com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioResponseDTO consultarPlanesDisponibles(AuditoriaDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		PlanTarifarioResponseDTO planTarifarioResp = new PlanTarifarioResponseDTO();
		RespuestaDTO respuesta = new RespuestaDTO();
		
		AuditoriaDTO		codPuntoAccesoDto	= new AuditoriaDTO();		
		AuditoriaDTO		codAplicacionDto	= new AuditoriaDTO();		
		AuditoriaDTO		codServicioDto		= new AuditoriaDTO();		
		AuditoriaDTO		nombreUsuarioDto	= new AuditoriaDTO();	
		
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		logger.info("consultarPlanesDisponibles:start()");
		logger.info("consultarPlanesDisponibles:antes()");
		
		
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
				respuesta.setCodigoError(puntoAcceso.getRespuesta().getCodigoError());
				respuesta.setMensajeError(puntoAcceso.getRespuesta().getMensajeError());
				respuesta.setNumeroEvento(puntoAcceso.getRespuesta().getNumeroEvento());
				planTarifarioResp.setRespuesta(respuesta);
				return planTarifarioResp;
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
					planTarifarioResp.setRespuesta(aplicacionValidada);
					return planTarifarioResp;
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
				planTarifarioResp.setRespuesta(servicioValidado);
				return planTarifarioResp;
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
				planTarifarioResp.setRespuesta(usuarioValidado);
				return planTarifarioResp;
			}
		// Fin Validación de nombre Usuario
			
		// Inicio de Registro de auditoría 		
		logger.info("insertarAuditoria:start()");
		logger.info("insertarAuditoria:antes()");
		com.tmmas.gte.integraciongtecommon.dto.AuditoriaResponseDTO  auditoria =  auditoriaDAO.insertarAuditoria(inParam0);
		logger.info("insertarAuditoria:despues()");
		logger.info("insertarAuditoria:end()");
		if (auditoria != null && auditoria.getRespuesta().getCodigoError()!=0  )
		{
			respuesta.setCodigoError(auditoria.getRespuesta().getCodigoError());
			respuesta.setMensajeError(auditoria.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(auditoria.getRespuesta().getNumeroEvento());
			planTarifarioResp.setRespuesta(respuesta);
			return planTarifarioResp;
		}
		//Fin de Registro de auditoría 		
		
		
		com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioResponseDTO outParam0 = planTarifarioDTODAO.consultarPlanesDisponibles();
		logger.info("consultarPlanesDisponibles:despues()");
		logger.info("consultarPlanesDisponibles:end()");
		if (outParam0 != null && outParam0.getRespuesta()!= null &&  outParam0.getRespuesta().getCodigoError()==0  ){
			if (outParam0.getListPlanTarifario().length > 0){
				planTarifarioResp.setListPlanTarifario(outParam0.getListPlanTarifario());
				respuesta.setCodigoError(outParam0.getRespuesta().getCodigoError());
				respuesta.setMensajeError(outParam0.getRespuesta().getMensajeError());
				respuesta.setNumeroEvento(outParam0.getRespuesta().getNumeroEvento());
				planTarifarioResp.setRespuesta(respuesta);
			}else{
				respuesta.setCodigoError(outParam0.getRespuesta().getCodigoError());
				respuesta.setMensajeError(outParam0.getRespuesta().getMensajeError());
				respuesta.setNumeroEvento(outParam0.getRespuesta().getNumeroEvento());
				planTarifarioResp.setRespuesta(respuesta);
			}
		}else{
			respuesta.setCodigoError(outParam0.getRespuesta().getCodigoError());
			respuesta.setMensajeError(outParam0.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(outParam0.getRespuesta().getNumeroEvento());
			planTarifarioResp.setRespuesta(respuesta);
		}
		return planTarifarioResp;
	}

}