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

import sun.net.www.protocol.gopher.GopherClient;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.gte.integraciongtecommon.dto.AbonadoDTO;
import com.tmmas.gte.integraciongtecommon.dto.AbonadoOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.AltaPrepagoDTO;
import com.tmmas.gte.integraciongtecommon.dto.AltaPrepagoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaServicioDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConPlanDTO;
import com.tmmas.gte.integraciongtecommon.dto.EsTelefIgualClieDTO;
import com.tmmas.gte.integraciongtecommon.dto.NombreCamposDTO;
import com.tmmas.gte.integraciongtecommon.dto.ObtenerCampos;
import com.tmmas.gte.integraciongtecommon.dto.PuntoAccesoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO;
import com.tmmas.gte.integraciongteservice.helper.Global;

public class AltaPrepagoResponseDTOServiceImpl implements AltaPrepagoResponseDTOService{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(AltaPrepagoResponseDTOServiceImpl.class);
	private com.tmmas.gte.integraciongtebo.dao.AltaPrepagoResponseDTODAO altaPrepagoResponseDTODAO = new com.tmmas.gte.integraciongtebo.dao.AltaPrepagoResponseDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAO auditoriaDAO	= new com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAO abonadoDAO	= new com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAOImpl();
	
	public AltaPrepagoResponseDTOServiceImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongteservice/properties/IntegracionGTEService.properties");
	}

	/**
	* Consulta la fecha de Alta de un numero ingresado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.AltaPrepagoResponseDTO consultarFechaAlta(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		
		logger.info("declaración de variables:start()");
		AltaPrepagoResponseDTO altaPrepagoResponseDTOResp = new AltaPrepagoResponseDTO();
		AltaPrepagoDTO nuevaConsulta = new AltaPrepagoDTO();
		RespuestaDTO    respuesta = new RespuestaDTO();
		EsTelefIgualClieDTO telefono  = null;
		AbonadoOutDTO datosAbonados = null; 
		AbonadoDTO abonado = null; 
		Global global = Global.getInstance();
		AuditoriaDTO	codPuntoAccesoDto		= new AuditoriaDTO();		
		AuditoriaDTO	codAplicacionDto		= new AuditoriaDTO();		
		AuditoriaDTO	codServicioDto			= new AuditoriaDTO();		
		AuditoriaDTO	nombreUsuarioDto		= new AuditoriaDTO();
		ArrayList 		campos					= new ArrayList();
		logger.info("fin de la declaración de variables:end()");
		
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
				altaPrepagoResponseDTOResp.setRespuesta(respuesta);
				return altaPrepagoResponseDTOResp;
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
					altaPrepagoResponseDTOResp.setRespuesta(aplicacionValidada);
					return altaPrepagoResponseDTOResp;
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
				altaPrepagoResponseDTOResp.setRespuesta(servicioValidado);
				return altaPrepagoResponseDTOResp;
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
				altaPrepagoResponseDTOResp.setRespuesta(usuarioValidado);
				return altaPrepagoResponseDTOResp;
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
							altaPrepagoResponseDTOResp.setRespuesta(respuesta);
							return altaPrepagoResponseDTOResp;
						}
			        }	
				}else
				{
					respuesta.setCodigoError(auditoria.getRespuesta().getCodigoError());
					respuesta.setMensajeError(auditoria.getRespuesta().getMensajeError());
					respuesta.setNumeroEvento(auditoria.getRespuesta().getNumeroEvento());
					altaPrepagoResponseDTOResp.setRespuesta(respuesta);
					return altaPrepagoResponseDTOResp;
				}
			//Fin de Registro de auditoría 				
		
		logger.info("consultarFechaAlta:start()");
		logger.info("consultarFechaAlta:antes()");
		if(inParam0 != null && inParam0.getNumeroTelefono()!= 0){
			nuevaConsulta.setNumTelefono(inParam0.getNumeroTelefono());
		}

		logger.info("utilizando AbonadoImpl");
		logger.info("utilizando metodo:consultarAbonadoTelefono");
		     	telefono = new EsTelefIgualClieDTO();
		     	if(inParam0 != null && inParam0.getNumeroTelefono() != 0){
		     		telefono.setNum_telefono1(inParam0.getNumeroTelefono());
		     		datosAbonados = abonadoDAO.consultarAbonadoTelefono(telefono);
		     	}
				logger.info("recuperacion de datos del abanado");
		     	if(   datosAbonados != null 
		     	   && datosAbonados.getListadoClientes() != null 
		     	   && datosAbonados.getListadoClientes().length > 0){
			     		for(int i = 0 ; i < datosAbonados.getListadoClientes().length; i++){
			     			abonado = datosAbonados.getListadoClientes()[i]; 
			     		}
		     	}
		logger.info("cerrando metodo :consultarAbonadoTelefono");
		logger.info("cerrando AbonadoImpl");
		
		if(abonado != null && abonado.getNumAbonado()!=0 && abonado.getTipAbonado() != null && !abonado.getTipAbonado().equals("")){
			if(abonado.getTipAbonado().equals(global.getValor("serviciosuplementario.consultarFechaAlta.tipPrepago"))){
					com.tmmas.gte.integraciongtecommon.dto.AltaPrepagoResponseDTO outParam0 = altaPrepagoResponseDTODAO.consultarFechaAlta(nuevaConsulta);
					altaPrepagoResponseDTOResp = outParam0;
			}else{
				if(abonado != null && abonado.getRespuesta() != null && abonado.getRespuesta().getCodigoError() == -1){
					altaPrepagoResponseDTOResp.setRespuesta(abonado.getRespuesta());
					return altaPrepagoResponseDTOResp;
				}else{
					respuesta = new RespuestaDTO();
					respuesta.setCodigoError(-1);
					respuesta.setMensajeError("El número teléfono no es prepago.");
					altaPrepagoResponseDTOResp.setRespuesta(respuesta);
					return altaPrepagoResponseDTOResp;
				}
			}
		}else{
			if(abonado != null && abonado.getRespuesta() != null && abonado.getRespuesta().getCodigoError() == -1){
				altaPrepagoResponseDTOResp.setRespuesta(abonado.getRespuesta());
				return altaPrepagoResponseDTOResp;
			}else{
				respuesta = new RespuestaDTO();
				respuesta.setCodigoError(-1);
				respuesta.setMensajeError("No existe número teléfono.");
				altaPrepagoResponseDTOResp.setRespuesta(respuesta);
				return altaPrepagoResponseDTOResp;
			}
		}
		logger.info("consultarFechaAlta:despues()");
		logger.info("consultarFechaAlta:end()");
		return altaPrepagoResponseDTOResp;
	}

}