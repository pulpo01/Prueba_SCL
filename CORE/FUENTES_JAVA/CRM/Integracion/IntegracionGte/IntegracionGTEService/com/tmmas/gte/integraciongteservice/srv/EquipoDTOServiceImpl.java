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
import com.tmmas.gte.integraciongtecommon.dto.ConsultarTerminalResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.EquipoAbonadoDTO;
import com.tmmas.gte.integraciongtecommon.dto.EquipoDTO;
import com.tmmas.gte.integraciongtecommon.dto.EsTelefIgualClieDTO;
import com.tmmas.gte.integraciongtecommon.dto.NombreCamposDTO;
import com.tmmas.gte.integraciongtecommon.dto.ObtenerCampos;
import com.tmmas.gte.integraciongtecommon.dto.PuntoAccesoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO;

public class EquipoDTOServiceImpl extends ArticuloDTOServiceImpl implements EquipoDTOService{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(EquipoDTOServiceImpl.class);
	private com.tmmas.gte.integraciongtebo.dao.EquipoDTODAO 		equipoDTODAO 			= new com.tmmas.gte.integraciongtebo.dao.EquipoDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAO 		auditoriaDAO			= new com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAO 		abonadoDTODAO 			= new com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAOImpl();

	public EquipoDTOServiceImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongteservice/properties/IntegracionGTEService.properties");
	}
	
	/**
	* Servicio que permite consultar la descripción de un terminal asociado a un número de teléfono
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsultarTerminalResponseDTO consultarTerminal(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		
		ConsultarTerminalResponseDTO consultarTerminalResponseDTO = new ConsultarTerminalResponseDTO();
		
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
		if (puntoAcceso.getRespuesta().getCodigoError()!=0)
		{
			respuesta.setCodigoError(puntoAcceso.getRespuesta().getCodigoError());
			respuesta.setMensajeError(puntoAcceso.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(puntoAcceso.getRespuesta().getNumeroEvento());
			consultarTerminalResponseDTO.setRespuesta(respuesta);
			return consultarTerminalResponseDTO;
		}
		//Fin Validación de Punto Acceso
		//Validación de Cod. Aplicacion
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
				consultarTerminalResponseDTO.setRespuesta(aplicacionValidada);
				return consultarTerminalResponseDTO;
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
		if (servicioValidado.getCodigoError()!=0)
		{
			consultarTerminalResponseDTO.setRespuesta(servicioValidado);
			return consultarTerminalResponseDTO;
		}
		//Fin Validación de Cod. Servicio
		//Validación de nombre Usuario
		nombreUsuarioDto.setNombreUsuario(inParam0.getAuditoria().getNombreUsuario());
		logger.info("validarNombreUsuario:start()");
		logger.info("validarNombreUsuario:antes()");
		com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO usuarioValidado =  auditoriaDAO.validarNombreUsuario(nombreUsuarioDto);
		logger.info("validarNombreUsuario:despues()");
		logger.info("validarNombreUsuario:end()");
		if (usuarioValidado.getCodigoError()!=0)
		{
			consultarTerminalResponseDTO.setRespuesta(usuarioValidado);
			return consultarTerminalResponseDTO;
		}
		//Fin Validación de nombre Usuario
		
		//Inicio de Registro de auditoría 		
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
			//Fin de Obtención de Nombres de Campos del DTO de Entrada
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
							respuesta.setCodigoError(servicio.getCodigoError());
							respuesta.setMensajeError(servicio.getMensajeError());
							respuesta.setNumeroEvento(servicio.getNumeroEvento());
							consultarTerminalResponseDTO.setRespuesta(respuesta);
							return consultarTerminalResponseDTO;
						}
				}	
			}
			
			}else
		{
			respuesta.setCodigoError(auditoria.getRespuesta().getCodigoError());
			respuesta.setMensajeError(auditoria.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(auditoria.getRespuesta().getNumeroEvento());
			consultarTerminalResponseDTO.setRespuesta(respuesta);
			return consultarTerminalResponseDTO;
		}
		//Fin de Registro de auditoría
		
		logger.info("consultarTerminal:start()");
		logger.info("consultarTerminal:antes()");

		logger.info("declaracion de variables para el metodo consultarTerminal");
		EquipoDTO equipo = new EquipoDTO();
		EquipoAbonadoDTO inParamEqAbo = new EquipoAbonadoDTO();
		logger.info("fin de la declaraciones de variables para el metodo consultarTerminal");
		
		
		EsTelefIgualClieDTO telefonoCliente = new EsTelefIgualClieDTO(); 
		telefonoCliente.setNum_telefono1(inParam0.getNumeroTelefono());
		
		if (telefonoCliente.getNum_telefono1() != 0){
			
			logger.info("consultarAbonadoTelefono:antes()");
			com.tmmas.gte.integraciongtecommon.dto.AbonadoOutDTO abonado = abonadoDTODAO.consultarAbonadoTelefono(telefonoCliente);
			logger.info("consultarAbonadoTelefono:despues()");
			if (abonado != null && 
				abonado.getRespuesta()!= null && 
				abonado.getRespuesta().getCodigoError() == 0 &&
				abonado.getListadoAbonados()!= null &&
				abonado.getListadoAbonados().length > 0){    

				if (abonado.getListadoAbonados()[0].getCodTecnologia().equals("GSM")){
					equipo.setNumSerie(abonado.getListadoAbonados()[0].getNumImei());
				}else{
					equipo.setNumSerie(abonado.getListadoAbonados()[0].getNumSerie());
				}
				logger.info("Carga Parámetros equipo-abonado a DTO:antes()");
				inParamEqAbo.setAbonado(abonado.getListadoAbonados()[0]);
				inParamEqAbo.setEquipo(equipo);
				logger.info("Carga Parámetros equipo-abonado a DTO:despues()");
				
				logger.info("Equipo x n°telefono:antes()");
				com.tmmas.gte.integraciongtecommon.dto.EquipoResponseDTO outParamEq = equipoDTODAO.consultarTerminal(inParamEqAbo);
				logger.info("Equipo x n°telefono:despues()");
				
				if (outParamEq != null && outParamEq.getRespuesta()!= null &&  outParamEq.getRespuesta().getCodigoError() == 0 ){
					consultarTerminalResponseDTO.setCodArticulo(outParamEq.getEquipo().getCodArticulo());
					consultarTerminalResponseDTO.setDescEquipo(outParamEq.getEquipo().getDescEquipo());
					consultarTerminalResponseDTO.setRespuesta(outParamEq.getRespuesta());
					return consultarTerminalResponseDTO;
				}else{
		    		consultarTerminalResponseDTO.setRespuesta(outParamEq.getRespuesta());
				    return consultarTerminalResponseDTO;
				}
			}else{ 
				 if (abonado != null && abonado.getRespuesta() != null && abonado.getRespuesta().getCodigoError() != 0){
						consultarTerminalResponseDTO.setRespuesta(abonado.getRespuesta());
					    return consultarTerminalResponseDTO;
				 }else{
					 respuesta = new RespuestaDTO();
					 respuesta.setCodigoError(-10011);
			    	 respuesta.setMensajeError("No ha sido posible obtener los datos del Terminal asociado al número de teléfono consultado.");
  					 consultarTerminalResponseDTO.setRespuesta(respuesta);
					 return consultarTerminalResponseDTO;
				 }
			}
		}else{
			consultarTerminalResponseDTO = new ConsultarTerminalResponseDTO();
			respuesta = new RespuestaDTO();
			respuesta.setCodigoError(-10011);
    		respuesta.setMensajeError("No fue posible obtener datos de cliente.");	
    		consultarTerminalResponseDTO.setRespuesta(respuesta);
		}
		logger.info("consultarTerminal:despues()");
		logger.info("consultarTerminal:end()");
		return consultarTerminalResponseDTO;
	}

}