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
import com.tmmas.gte.integraciongtecommon.dto.AbonadoOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.ArticuloDTO;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaServicioDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsultaPukResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.EsTelefIgualClieDTO;
import com.tmmas.gte.integraciongtecommon.dto.NombreCamposDTO;
import com.tmmas.gte.integraciongtecommon.dto.ObtenerCampos;
import com.tmmas.gte.integraciongtecommon.dto.PuntoAccesoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.RespBooleanDTO;
import com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO;

public class ArticuloDTOServiceImpl implements ArticuloDTOService{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(ArticuloDTOServiceImpl.class);
	private com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAO 			abonadoDTODAO 		 = new com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.ArticuloDTODAO 			articuloDTODAO 		 = new com.tmmas.gte.integraciongtebo.dao.ArticuloDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAO 			auditoriaDAO		 = new com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.ArticuloDTODAO 			ArticuloDTODAO		 = new com.tmmas.gte.integraciongtebo.dao.ArticuloDTODAOImpl();
	
	public ArticuloDTOServiceImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongteservice/properties/IntegracionGTEService.properties");
	}

	/**
	 * Valida si el equipo asociado al número de teléfono consultado tiene soporte GPRS
	 */
	public com.tmmas.gte.integraciongtecommon.dto.RespBooleanDTO validarSoporteGprs(com.tmmas.gte.integraciongtecommon.dto.TerminalServicioDTO inParam0)
	throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		RespBooleanDTO respBoolean = new RespBooleanDTO();
		RespBooleanDTO respuestaGPRS = new RespBooleanDTO();
		AbonadoOutDTO datosAbonado = new AbonadoOutDTO();
		ArticuloDTO validarGPRS = new ArticuloDTO();
		EsTelefIgualClieDTO numTelefono = new EsTelefIgualClieDTO();
		RespuestaDTO resp = new RespuestaDTO();
		
		AuditoriaDTO	 		codPuntoAccesoDto		= new AuditoriaDTO();		
		AuditoriaDTO 	 		codAplicacionDto		= new AuditoriaDTO();		
		AuditoriaDTO 	 		codServicioDto			= new AuditoriaDTO();		
		AuditoriaDTO 	 		nombreUsuarioDto		= new AuditoriaDTO();	
		ArrayList 		 		campos					= new ArrayList();
		
		
		numTelefono.setNum_telefono1(inParam0.getNumeroTelefono());
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		logger.info("consultarAbonadoTelefono:start()");
		logger.info("consultarAbonadoTelefono:antes()");
		
		
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
				respBoolean.setRespuesta(puntoAcceso.getRespuesta());
				return respBoolean;
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
					respBoolean.setRespuesta(aplicacionValidada);
					return respBoolean;
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
				respBoolean.setRespuesta(servicioValidado);
				return respBoolean;
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
				respBoolean.setRespuesta(usuarioValidado);
				return respBoolean;
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
						respBoolean.setRespuesta(servicio);
						return respBoolean;
					}
	       }
	        	       
		}else
		{
			respBoolean.setRespuesta(auditoria.getRespuesta());
			return respBoolean;
		}
		// Fin Proceso de Auditoria 		
		
		

		datosAbonado = abonadoDTODAO.consultarAbonadoTelefono(numTelefono);
		logger.info("consultarAbonadoTelefono:despues()");
		logger.info("consultarAbonadoTelefono:end()");
		
		if (datosAbonado != null && datosAbonado.getRespuesta()!= null &&  datosAbonado.getRespuesta().getCodigoError()==0  )
		{
			if (datosAbonado.getListadoAbonados().length > 0 )
			{	
				validarGPRS.setNumAbonado(datosAbonado.getListadoAbonados()[0].getNumAbonado());
				validarGPRS.setCodTecnologia(datosAbonado.getListadoAbonados()[0].getCodTecnologia());
				if (validarGPRS.getCodTecnologia().equals("GSM")){
					validarGPRS.setNumImei(datosAbonado.getListadoAbonados()[0].getNumImei());
					validarGPRS.setNumSerie("0");
					validarGPRS.setCodServicio(inParam0.getCod_servicio());
				}else{
					validarGPRS.setNumImei("0");
					validarGPRS.setNumSerie(datosAbonado.getListadoAbonados()[0].getNumSerie());
					validarGPRS.setCodServicio(inParam0.getCod_servicio());
				}
				logger.info("validarSoporteGPRS:start()");
				logger.info("validarSoporteGPRS:antes()");
				respuestaGPRS = articuloDTODAO.validarSoporteGPRS(validarGPRS);
				logger.info("validarSoporteGPRS:despues()");
				logger.info("validarSoporteGPRS:end()");
				if (respuestaGPRS != null && respuestaGPRS.getRespuesta() != null && respuestaGPRS.getRespuesta().getCodigoError() == 0){
					respBoolean.setRespBoolean(true);
					resp.setCodigoError(respuestaGPRS.getRespuesta().getCodigoError());
					resp.setMensajeError(respuestaGPRS.getRespuesta().getMensajeError());
					resp.setNumeroEvento(respuestaGPRS.getRespuesta().getNumeroEvento());
					respBoolean.setRespuesta(resp);
				}else{
					respBoolean.setRespBoolean(false);
					resp.setCodigoError(respuestaGPRS.getRespuesta().getCodigoError());
					resp.setMensajeError(respuestaGPRS.getRespuesta().getMensajeError());
					resp.setNumeroEvento(respuestaGPRS.getRespuesta().getNumeroEvento());
					respBoolean.setRespuesta(resp);
				}
			}else{
				respBoolean.setRespBoolean(false);
				resp.setCodigoError(datosAbonado.getRespuesta().getCodigoError());
				resp.setMensajeError(datosAbonado.getRespuesta().getMensajeError());
				resp.setNumeroEvento(datosAbonado.getRespuesta().getNumeroEvento());
				respBoolean.setRespuesta(resp);
			}
		}else{
			respBoolean.setRespBoolean(false);
			resp.setCodigoError(datosAbonado.getRespuesta().getCodigoError());
			resp.setMensajeError(datosAbonado.getRespuesta().getMensajeError());
			resp.setNumeroEvento(datosAbonado.getRespuesta().getNumeroEvento());
			respBoolean.setRespuesta(resp);
		}
		return respBoolean;
	}
	
	/**
     * Servicio que permite consultar el PUK de una Serie Simcard
     */
     public com.tmmas.gte.integraciongtecommon.dto.ConsultaPukResponseDTO consultarPuk(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
                  throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
           UtilLog.setLog(config.getString("IntegracionGTEService.log"));
           ConsultaPukResponseDTO outParam0               = new ConsultaPukResponseDTO();
           AuditoriaDTO            codPuntoAccesoDto           = new AuditoriaDTO();         
           AuditoriaDTO            codAplicacionDto       = new AuditoriaDTO();        
           AuditoriaDTO            codServicioDto              = new AuditoriaDTO();         
           AuditoriaDTO            nombreUsuarioDto       = new AuditoriaDTO();   
           ArrayList                campos                            = new ArrayList();

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
                       outParam0.setRespuesta(puntoAcceso.getRespuesta());
                       return outParam0;
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
                            outParam0.setRespuesta(aplicacionValidada);
                            return outParam0;
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
                       outParam0.setRespuesta(servicioValidado);
                       return outParam0;
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
                       outParam0.setRespuesta(usuarioValidado);
                       return outParam0;
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
                            if (servicio == null &&  servicio.getCodigoError()!=0  )
                            {
                                  outParam0.setRespuesta(servicio);
                                  return outParam0;
                            }
                 }     
            }
           }else
           {
                 outParam0.setRespuesta(auditoria.getRespuesta());
                 return outParam0;
           }
           //Fin de Registro de auditoría     
           logger.info("consultarPuk:start()");
           logger.info("consultarPuk:antes()");
           outParam0 = ArticuloDTODAO.consultarPuk(inParam0);
           logger.info("consultarPuk:despues()");
           logger.info("consultarPuk:end()");
           return outParam0;

     }
}