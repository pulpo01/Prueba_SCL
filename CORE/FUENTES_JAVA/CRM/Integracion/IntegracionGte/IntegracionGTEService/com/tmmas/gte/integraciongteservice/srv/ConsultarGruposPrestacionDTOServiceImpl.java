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
import com.tmmas.gte.integraciongtecommon.dto.ConsultarGruposPrestacionResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.EntServSupleDTO;
import com.tmmas.gte.integraciongtecommon.dto.NombreCamposDTO;
import com.tmmas.gte.integraciongtecommon.dto.ObtenerCampos;
import com.tmmas.gte.integraciongtecommon.dto.PuntoAccesoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO;

public class ConsultarGruposPrestacionDTOServiceImpl implements ConsultarGruposPrestacionDTOService{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(ConsultarGruposPrestacionDTOServiceImpl.class);
	private com.tmmas.gte.integraciongtebo.dao.ConsultarGruposPrestacionDTODAO consultarGruposPrestacionDTODAO = new com.tmmas.gte.integraciongtebo.dao.ConsultarGruposPrestacionDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAO 		auditoriaDAO			= new com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAOImpl();

	public ConsultarGruposPrestacionDTOServiceImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongteservice/properties/IntegracionGTEService.properties");
	}

	/**
	* Entrega datos de los grupos de prestación existentes
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsultarGruposPrestacionResponseDTO consultarGruposPrestacion(com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		
		ConsultarGruposPrestacionResponseDTO respuesta = new ConsultarGruposPrestacionResponseDTO();
		
		AuditoriaDTO		 codPuntoAccesoDto		= new AuditoriaDTO();		
		AuditoriaDTO	 	 codAplicacionDto		= new AuditoriaDTO();		
		AuditoriaDTO	 	 codServicioDto			= new AuditoriaDTO();		
		AuditoriaDTO	 	 nombreUsuarioDto		= new AuditoriaDTO();	
		ArrayList 			 campos					= new ArrayList();
		EntServSupleDTO 	 ArregloEntrada			= new EntServSupleDTO();
		RespuestaDTO 		 puntoAccesoValidado    = new RespuestaDTO();
		
		
		
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
				
				respuesta.setRespuesta(puntoAcceso.getRespuesta());
				return respuesta;
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
					respuesta.setRespuesta(aplicacionValidada);
					return respuesta;
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
				respuesta.setRespuesta(servicioValidado);
				return respuesta;
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
				respuesta.setRespuesta(usuarioValidado);
				return respuesta;
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
						respuesta.setRespuesta(servicio);
						return respuesta;
					}
	        	}	
	       }
	        
		}else
		{
			respuesta.setRespuesta(auditoria.getRespuesta());
			return respuesta;
		}
		//Fin de Registro de auditoría
		
		logger.info("consultarGruposPrestacion:start()");
		logger.info("consultarGruposPrestacion:antes()");
		com.tmmas.gte.integraciongtecommon.dto.ConsultarGruposPrestacionResponseDTO outParam0 = consultarGruposPrestacionDTODAO.consultarGruposPrestacion();
		if (outParam0 != null && outParam0.getRespuesta()!= null &&  outParam0.getRespuesta().getCodigoError()==0  ){
			respuesta.setListadoPrestaciones(outParam0.getListadoPrestaciones());
		}else{
			outParam0.getRespuesta().setCodigoError(-1);
			outParam0.getRespuesta().setMensajeError("No ha sido posible obtener los grupos de prestaciones existentes");
			outParam0.getRespuesta().setNumeroEvento(0);
			respuesta.setRespuesta(outParam0.getRespuesta());
		}
		logger.info("consultarGruposPrestacion:despues()");
		logger.info("consultarGruposPrestacion:end()");
		return respuesta;
	}

}