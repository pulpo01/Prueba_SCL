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
import com.tmmas.gte.integraciongtecommon.dto.AbonadoPospagoOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.AltaPrepagoDTO;
import com.tmmas.gte.integraciongtecommon.dto.AltaPrepagoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaServicioDTO;
import com.tmmas.gte.integraciongtecommon.dto.BloqueoDTO;
import com.tmmas.gte.integraciongtecommon.dto.BloqueoInDTO;
import com.tmmas.gte.integraciongtecommon.dto.BloqueoOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.BloqueoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsAbonadoPospagoDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsCicloFactDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsClieFacturableDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsRenovacionDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsultarTipoAbonadoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.DatosLstCliCliDTO;
import com.tmmas.gte.integraciongtecommon.dto.EntServSupleDTO;
import com.tmmas.gte.integraciongtecommon.dto.EsClieTelefDTO;
import com.tmmas.gte.integraciongtecommon.dto.EsTelefIgualClieDTO;
import com.tmmas.gte.integraciongtecommon.dto.LstDatosCliNitDTO;
import com.tmmas.gte.integraciongtecommon.dto.NombreCamposDTO;
import com.tmmas.gte.integraciongtecommon.dto.ObtenerCampos;
import com.tmmas.gte.integraciongtecommon.dto.OrdenServicioDTO;
import com.tmmas.gte.integraciongtecommon.dto.OrdenServicioOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.PuntoAccesoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.RespBooleanDTO;
import com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO;
import com.tmmas.gte.integraciongtecommon.dto.TecnologiaDTO;
import com.tmmas.gte.integraciongteservice.helper.Global;

public class AbonadoDTOServiceImpl implements AbonadoDTOService{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(AbonadoDTOServiceImpl.class);
	private com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAO 			abonadoDTODAO 		= new com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.ClienteDTODAO 			clienteDTODAO 		= new com.tmmas.gte.integraciongtebo.dao.ClienteDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAO 			auditoriaDAO		= new com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.FacturaDTODAO 			facturaDTODAO 		= new com.tmmas.gte.integraciongtebo.dao.FacturaDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.ArticuloDTODAO			articuloDTODAO		= new com.tmmas.gte.integraciongtebo.dao.ArticuloDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.EquipoDTODAO				equipoDTODAO		= new com.tmmas.gte.integraciongtebo.dao.EquipoDTODAOImpl();

	public AbonadoDTOServiceImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongteservice/properties/IntegracionGTEService.properties");
	}

	/**
	* Entrega Datos del Abonado
	*/ 
	public com.tmmas.gte.integraciongtecommon.dto.RespBooleanDTO validarClienteTelefono(com.tmmas.gte.integraciongtecommon.dto.EsClieTelefDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		RespBooleanDTO respBoolean =  new RespBooleanDTO();
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		
		AuditoriaDTO	codPuntoAccesoDto	= new AuditoriaDTO();		
		AuditoriaDTO 	codAplicacionDto	= new AuditoriaDTO();		
		AuditoriaDTO 	codServicioDto		= new AuditoriaDTO();		
		AuditoriaDTO 	nombreUsuarioDto	= new AuditoriaDTO();	
		ArrayList 		campos				= new ArrayList();

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
		
		
		logger.info("consultarAbonadoCliTel:start()");
		logger.info("consultarAbonadoCliTel:antes()");
		com.tmmas.gte.integraciongtecommon.dto.AbonadoOutDTO outParam0 = abonadoDTODAO.consultarAbonadoCliTel(inParam0);
		logger.info("consultarAbonadoCliTel:despues()");
		logger.info("consultarAbonadoCliTel:end()");
		logger.info("consultarAbonadoCliTel:end()");
		logger.info("getRespuesta"+outParam0.getRespuesta());
		logger.info("getRespuesta().getCodigoError()"+ outParam0.getRespuesta().getCodigoError());
		if (outParam0 != null && outParam0.getRespuesta()!= null &&  outParam0.getRespuesta().getCodigoError()==0  )
		{
			if(outParam0.getListadoAbonados().length > 0){
				respBoolean.setRespBoolean(true);
				respBoolean.setRespuesta(outParam0.getRespuesta());
			}else{
				respBoolean.setRespBoolean(false);
				respBoolean.setRespuesta(outParam0.getRespuesta());
			}
		}else
		{
			respBoolean.setRespBoolean(false);
			respBoolean.setRespuesta(outParam0.getRespuesta());
		}
		logger.info("validarClienteTelefono:despues()");
		logger.info("validarClienteTelefono:end()");
		return respBoolean;
		}
		

	/**
	* retorna el numero de Cliente
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespBooleanDTO validarTelIgualCli(com.tmmas.gte.integraciongtecommon.dto.EsTelefIgualClieDTO inParam0)
	throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		
		RespBooleanDTO 	respBoolean 		=  new RespBooleanDTO();
		EsClieTelefDTO 	inParam1 			= new EsClieTelefDTO();
		AuditoriaDTO	codPuntoAccesoDto	= new AuditoriaDTO();		
		AuditoriaDTO 	codAplicacionDto	= new AuditoriaDTO();		
		AuditoriaDTO 	codServicioDto		= new AuditoriaDTO();		
		AuditoriaDTO 	nombreUsuarioDto	= new AuditoriaDTO();	
		ArrayList 		campos				= new ArrayList();

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
		
		logger.info("consultarAbonadoTelefono:start()");
		logger.info("consultarAbonadoTelefono:antes()");
		com.tmmas.gte.integraciongtecommon.dto.AbonadoOutDTO outParam = abonadoDTODAO.consultarAbonadoTelefono(inParam0);
		logger.info("consultarAbonadoTelefono:despues()");
		logger.info("consultarAbonadoTelefono:end()");
		if (outParam != null && outParam.getRespuesta()!= null &&  outParam.getRespuesta().getCodigoError()==0  )
		{
			if (outParam.getListadoAbonados().length > 0 )
			{	
				
				logger.info("numero telefon[" + inParam0.getNum_telefono2() + "]");
				logger.info("Codigo Cliente[" + outParam.getListadoAbonados()[0].getCodCliente() + "]");
				inParam1.setCodCliente(outParam.getListadoAbonados()[0].getCodCliente());
				inParam1.setNumeroTelefono(inParam0.getNum_telefono2());
				com.tmmas.gte.integraciongtecommon.dto.AbonadoOutDTO outParam0 = abonadoDTODAO.consultarAbonadoCliTel(inParam1);
				if (outParam0 != null && outParam0.getRespuesta()!= null &&  outParam0.getRespuesta().getCodigoError()==0 )
				{
					if(outParam0.getListadoAbonados().length > 0){
				    	respBoolean.setRespBoolean(true);
				    	respBoolean.setRespuesta(outParam0.getRespuesta());
					}else{
						respBoolean.setRespBoolean(false);
						outParam0.getRespuesta().setMensajeError("Los número de teléfono ingresados no pertenecen al mismo cliente");
						respBoolean.setRespuesta(outParam0.getRespuesta());
					}
					
				}else
				{
					respBoolean.setRespBoolean(false);
					outParam0.getRespuesta().setMensajeError("Los número de teléfono ingresados no pertenecen al mismo cliente");
					respBoolean.setRespuesta(outParam0.getRespuesta());
				}
			}else
			{
				respBoolean.setRespBoolean(false);
				respBoolean.setRespuesta(outParam.getRespuesta());
				
			}
		}else{
			respBoolean.setRespBoolean(false);
			respBoolean.setRespuesta(outParam.getRespuesta());
		}
		return respBoolean;
	}

	/**
	* Entrega Tecnología según número de teléfono del Abonado
	*/ 
	public com.tmmas.gte.integraciongtecommon.dto.TecnologiaDTO consultarTecnologia(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		TecnologiaDTO 			respuesta 				=  new TecnologiaDTO();
		AuditoriaDTO	 		codPuntoAccesoDto		= new AuditoriaDTO();		
		AuditoriaDTO 	 		codAplicacionDto		= new AuditoriaDTO();		
		AuditoriaDTO 	 		codServicioDto			= new AuditoriaDTO();		
		AuditoriaDTO 	 		nombreUsuarioDto		= new AuditoriaDTO();	
		ArrayList 		 		campos					= new ArrayList();

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
				respuesta.setRespuesta(puntoAcceso.getRespuesta());
				return respuesta;
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
					respuesta.setRespuesta(aplicacionValidada);
					return respuesta;
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
				respuesta.setRespuesta(servicioValidado);
				return respuesta;
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
				respuesta.setRespuesta(usuarioValidado);
				return respuesta;
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
						respuesta.setRespuesta(servicio);
						return respuesta;
					}
	       }
	        	       
		}else
		{
			respuesta.setRespuesta(auditoria.getRespuesta());
			return respuesta;
		}
		// Fin Proceso de Auditoria 

		logger.info("consultarAbonadoTelefono:start()");
		logger.info("consultarAbonadoTelefono:antes()");
		EsTelefIgualClieDTO telefono = new EsTelefIgualClieDTO();
		telefono.setNum_telefono1(inParam0.getNumeroTelefono());
		com.tmmas.gte.integraciongtecommon.dto.AbonadoOutDTO outParam0 = abonadoDTODAO.consultarAbonadoTelefono(telefono);
		logger.info("consultarAbonadoTelefono:despues()");
		logger.info("consultarAbonadoTelefono:end()");
		if (outParam0 != null && outParam0.getRespuesta()!= null &&  outParam0.getRespuesta().getCodigoError()==0  )
		{
			if(outParam0.getListadoAbonados().length > 0)
			{
				respuesta.setCodTecnologia(outParam0.getListadoAbonados()[0].getCodTecnologia());
				respuesta.setRespuesta(outParam0.getRespuesta());
			}else{
				outParam0.getRespuesta().setMensajeError("No ha sido posible obtener la tecnología asociada al número de teléfono consultado");
				respuesta.setRespuesta(outParam0.getRespuesta());
			}
		}else
		{
			outParam0.getRespuesta().setMensajeError("No ha sido posible obtener la tecnología asociada al número de teléfono consultado");
			respuesta.setRespuesta(outParam0.getRespuesta());
		}
		logger.info("validarClienteTelefono:despues()");
		logger.info("validarClienteTelefono:end()");
		return respuesta;
	}

	/**
	* Valida Numero de Telefono Pospago o Hibrido
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespBooleanDTO validarNumPospagoHibrido(com.tmmas.gte.integraciongtecommon.dto.NumeroPlanTarifDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		
		AbonadoPospagoOutDTO 	datosCliente			= new AbonadoPospagoOutDTO();
		ConsAbonadoPospagoDTO 	clientePospagoParametro = new ConsAbonadoPospagoDTO();
		ConsCicloFactDTO 		consCicloFact 			= new ConsCicloFactDTO();
		ConsClieFacturableDTO 	consClieFacturable 		= new ConsClieFacturableDTO();
		RespBooleanDTO 			respBoolean 			= new RespBooleanDTO();
		RespBooleanDTO			respuestaBoolean		= new RespBooleanDTO();
		RespuestaDTO 			respuesta 				= new RespuestaDTO();
		DatosLstCliCliDTO		codClienteDTO			= new DatosLstCliCliDTO();
		LstDatosCliNitDTO       codCicloDTO				= new LstDatosCliNitDTO();
		AuditoriaDTO			codPuntoAccesoDto		= new AuditoriaDTO();		
		AuditoriaDTO			codAplicacionDto		= new AuditoriaDTO();		
		AuditoriaDTO			codServicioDto			= new AuditoriaDTO();		
		AuditoriaDTO			nombreUsuarioDto		= new AuditoriaDTO();	
		ArrayList 				campos					= new ArrayList();
		
		logger.info("validarAbonadoPospago:start()");
		logger.info("validarAbonadoPospago:antes()");
		
		
		
		
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
				respBoolean.setRespuesta(respuesta);
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
					respuesta.setCodigoError(servicio.getCodigoError());
					respuesta.setMensajeError(servicio.getMensajeError());
					respuesta.setNumeroEvento(servicio.getNumeroEvento());
					respBoolean.setRespuesta(respuesta);
					return respBoolean;
				}
	        }	
		}else
		{
			respuesta.setCodigoError(auditoria.getRespuesta().getCodigoError());
			respuesta.setMensajeError(auditoria.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(auditoria.getRespuesta().getNumeroEvento());
			respBoolean.setRespuesta(respuesta);
			return respBoolean;
		}
		//Fin de Registro de auditoría 		
		
		
		/**
		* Retorna numAbonado y codCliente a partir de un numCelular pospago
		*/
		logger.info("consultarAbonadoPospago:start()");
		logger.info("consultarAbonadoPospago:antes()");
		datosCliente = abonadoDTODAO.consAbonadoPospagoHibrido(inParam0);
		logger.info("consultarAbonadoPospago:despues()");
		logger.info("consultarAbonadoPospago:end()");
		
		if (datosCliente != null && datosCliente.getRespuesta()!= null &&  datosCliente.getRespuesta().getCodigoError()==0  ){
			if (datosCliente.getListadoClientes()!=null&&datosCliente.getListadoClientes().length>0){
				consClieFacturable.setNumAbonado(datosCliente.getListadoClientes()[0].getNumAbonado());
				consClieFacturable.setCodCliente(datosCliente.getListadoClientes()[0].getCodCliente());	
				codClienteDTO.setCodCliente(consClieFacturable.getCodCliente());
								
				/**
				* Retorna codCiclo a partir de un codCliente pospago
				*/
				logger.info("consultarDatosCliente:start()");
				logger.info("consultarDatosCliente:antes()");
				codCicloDTO = clienteDTODAO.consultarDatosCliente(codClienteDTO);
				logger.info("consultarDatosCliente:despues()");
				logger.info("consultarDatosCliente:end()");
				if (codCicloDTO != null && codCicloDTO.getRespuesta()!= null &&  codCicloDTO.getRespuesta().getCodigoError()==0  ){
					consCicloFact.setCodCiclo(codCicloDTO.getListadoClientes()[0].getCodCiclo());
					/**
					* Retorna codCicloFact a partir de un codCiclo pospago
					*/
					logger.info("consultarCicloFact:start()");
					logger.info("consultarCicloFact:antes()");
					clientePospagoParametro = facturaDTODAO.consultarCicloFact(consCicloFact);
					logger.info("consultarCicloFact:despues()");
					logger.info("consultarCicloFact:end()");
					if (clientePospagoParametro != null && clientePospagoParametro.getRespuesta()!= null &&  clientePospagoParametro.getRespuesta().getCodigoError()==0  ){
						consClieFacturable.setCodCicloFact(clientePospagoParametro.getCodCicloFact());
						/**
						* Consulta si Cliente es Facturable
						*/
						logger.info("validarClieFacturable:start()");
						logger.info("validarClieFacturable:antes()");
						respuestaBoolean = clienteDTODAO.validarClieFacturable(consClieFacturable);
						logger.info("validarClieFacturable:despues()");
						logger.info("validarClieFacturable:end()");
						if (respuestaBoolean != null && respuestaBoolean.getRespuesta()!= null &&  respuestaBoolean.getRespuesta().getCodigoError()==0  ){
							respBoolean.setRespBoolean(true);
							respuesta.setCodigoError(respuestaBoolean.getRespuesta().getCodigoError());
							respuesta.setMensajeError(respuestaBoolean.getRespuesta().getMensajeError());
							respuesta.setNumeroEvento(respuestaBoolean.getRespuesta().getNumeroEvento());
							respBoolean.setRespuesta(respuesta);
						}else{
							respBoolean.setRespBoolean(false);
							respBoolean.setRespuesta(respuestaBoolean.getRespuesta());
						}
					}else{
						
						respBoolean.setRespBoolean(false);
						respBoolean.setRespuesta(clientePospagoParametro.getRespuesta());
					}
				} else{
					respBoolean.setRespBoolean(false);
					respBoolean.setRespuesta(clientePospagoParametro.getRespuesta());
				}
			}else{
				respBoolean.setRespBoolean(false);
				respBoolean.setRespuesta(datosCliente.getRespuesta());
			}	
		}else{
			respBoolean.setRespBoolean(false);
			respBoolean.setRespuesta(datosCliente.getRespuesta());
		}
		logger.info("validarAbonadoPospago:despues()");
		logger.info("validarAbonadoPospago:end()");
		return respBoolean;
	}
	/**
	 * Servicio que permite retornar el tipo de abonado (pospago, hibrido, prepago) asociado a un número de teléfono.
	 */
	public com.tmmas.gte.integraciongtecommon.dto.ConsultarTipoAbonadoResponseDTO consultarTipoAbonado(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		
		ConsultarTipoAbonadoResponseDTO consultarTipoAbonadoResponseDTO = new ConsultarTipoAbonadoResponseDTO();
		
		AuditoriaDTO		 codPuntoAccesoDto		= new AuditoriaDTO();		
		AuditoriaDTO	 	 codAplicacionDto		= new AuditoriaDTO();		
		AuditoriaDTO	 	 codServicioDto			= new AuditoriaDTO();		
		AuditoriaDTO	 	 nombreUsuarioDto		= new AuditoriaDTO();
		ArrayList 			 campos					= new ArrayList();
		RespuestaDTO 		 respuesta				= new RespuestaDTO();
		EntServSupleDTO 	 ArregloEntrada			= new EntServSupleDTO();
		Global  			 global 				= Global.getInstance();
		
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
			consultarTipoAbonadoResponseDTO.setRespuesta(puntoAcceso.getRespuesta());
			return consultarTipoAbonadoResponseDTO;
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
				consultarTipoAbonadoResponseDTO.setRespuesta(aplicacionValidada);
				return consultarTipoAbonadoResponseDTO;
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
			consultarTipoAbonadoResponseDTO.setRespuesta(servicioValidado);
			return consultarTipoAbonadoResponseDTO;
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
			consultarTipoAbonadoResponseDTO.setRespuesta(usuarioValidado);
			return consultarTipoAbonadoResponseDTO;
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
							return consultarTipoAbonadoResponseDTO;
						}
				}	
			}
			//Inicio de Obtención de Nombres de Campos del DTO interno 	
			logger.info("ObtenerCampos.getAttributes:start()");
			logger.info("ObtenerCampos.getAttributes:antes()");
			campos = ObtenerCampos.getAttributes(ArregloEntrada.getClass(),ArregloEntrada);
			logger.info("ObtenerCampos.getAttributes:despues()");
			logger.info("ObtenerCampos.getAttributes:end()");
			//Fin de Obtención de Nombres de Campos del DTO interno 
			//recorrido del ArraylList(obtencion de nombres de Campos) 
		
			}else
		{
			respuesta.setCodigoError(auditoria.getRespuesta().getCodigoError());
			respuesta.setMensajeError(auditoria.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(auditoria.getRespuesta().getNumeroEvento());
			return consultarTipoAbonadoResponseDTO;
		}
		//Fin de Registro de auditoría
		
		logger.info("consultarTipoAbonado:start()");
		logger.info("consultarTipoAbonado:antes()");

		logger.info("declaracion de variables para el metodo consultarTipoAbonado");
		//declaraciones
		logger.info("fin de la declaraciones de variables para el metodo consultarTipoAbonado");

		EsTelefIgualClieDTO telefonoCliente = new EsTelefIgualClieDTO(); 
		telefonoCliente.setNum_telefono1(inParam0.getNumeroTelefono());

		if (telefonoCliente.getNum_telefono1() != 0){
			
			logger.info("consultarAbonadoTelefono:antes()");
			com.tmmas.gte.integraciongtecommon.dto.AbonadoOutDTO abonado = abonadoDTODAO.consultarAbonadoTelefono(telefonoCliente);
			logger.info("consultarAbonadoTelefono:despues()");
			
			if (abonado != null && abonado.getRespuesta()!= null &&  abonado.getRespuesta().getCodigoError() == 0 ){

				consultarTipoAbonadoResponseDTO.setTipAbonado(abonado.getListadoAbonados()[0].getTipAbonado());
				consultarTipoAbonadoResponseDTO.setCodPrestacion(abonado.getListadoAbonados()[0].getCodPrestacion());
				consultarTipoAbonadoResponseDTO.setDesPrestacion(abonado.getListadoAbonados()[0].getDesPrestacion());
				
				if (abonado.getListadoAbonados()[0].getNumSerie() != null){
					
					AbonadoDTO abonadoDTO = new AbonadoDTO();
					abonadoDTO.setNumSerie(abonado.getListadoAbonados()[0].getNumSerie());
					
					logger.info("consultarKit:antes()");
					com.tmmas.gte.integraciongtecommon.dto.AbonadoProductoResponseDTO consultaTipProd = articuloDTODAO.consultarKit(abonadoDTO);
					logger.info("consultarKit:despues()");
					
					if (consultaTipProd != null && consultaTipProd.getRespuesta() != null && consultaTipProd.getRespuesta().getCodigoError() == 0){
						
						if (consultaTipProd.getTipProducto() != null){
							consultarTipoAbonadoResponseDTO.setTipProducto(global.getValor("tipo.producto.kit"));
							consultarTipoAbonadoResponseDTO.setRespuesta(consultaTipProd.getRespuesta());
						}else{
							consultarTipoAbonadoResponseDTO.setTipProducto(global.getValor("tipo.producto.simcard"));
							consultarTipoAbonadoResponseDTO.setRespuesta(consultaTipProd.getRespuesta());
						}
					}else{
						consultarTipoAbonadoResponseDTO.setRespuesta(consultaTipProd.getRespuesta());
						return consultarTipoAbonadoResponseDTO;
					}
				}
			}else{
		    	consultarTipoAbonadoResponseDTO.setRespuesta(abonado.getRespuesta());
			    return consultarTipoAbonadoResponseDTO;
			}
			
		}

		logger.info("consultarTipoAbonado:despues()");
		logger.info("consultarTipoAbonado:end()");
		return consultarTipoAbonadoResponseDTO;
	}
	
	/**
	* Consulta la fecha de Alta de un numero ingresado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.AltaPrepagoResponseDTO consultarFechaAltaPrepago(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		
		logger.info("declaración de variables:start()");
		AltaPrepagoResponseDTO altaPrepagoResponseDTOResp = new AltaPrepagoResponseDTO();
		AltaPrepagoDTO nuevaConsulta = new AltaPrepagoDTO();
		RespuestaDTO    respuesta = new RespuestaDTO();
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

		com.tmmas.gte.integraciongtecommon.dto.AltaPrepagoResponseDTO outParam0 = abonadoDTODAO.consultarFechaAlta(nuevaConsulta);
		if(outParam0 != null && outParam0.getRespuesta() != null && outParam0.getRespuesta().getCodigoError() == 0){
			altaPrepagoResponseDTOResp.setFechaAlta(outParam0.getFechaAlta());
			altaPrepagoResponseDTOResp.setRespuesta(new RespuestaDTO());
		}else{
			if(outParam0 != null && outParam0.getRespuesta() != null && outParam0.getRespuesta().getCodigoError() != 0){
				altaPrepagoResponseDTOResp.setRespuesta(outParam0.getRespuesta());
				return altaPrepagoResponseDTOResp;
			}else{
				respuesta = new RespuestaDTO();
				respuesta.setCodigoError(-10002);
				respuesta.setMensajeError("Se produjo un error no determinado al consultar la fecha de alta.");
				altaPrepagoResponseDTOResp.setRespuesta(respuesta);
				return altaPrepagoResponseDTOResp;
			}
		}
		logger.info("consultarFechaAlta:despues()");
		logger.info("consultarFechaAlta:end()");
		return altaPrepagoResponseDTOResp;
	}
	/**
	* se ingresa un numero de abonado, el metodo retorna el BloqueoDTO Los datos correspondiente
	*/
	public com.tmmas.gte.integraciongtecommon.dto.BloqueoResponseDTO consultarBloqueoTelefono(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		logger.info("consultarBloqueoTelefono:start()");
		logger.info("consultarBloqueoTelefono:antes()");
		logger.info("declaracion de variables para el metodo consultarFacturasPorCliente");
		BloqueoInDTO bloqueoInDTO = null;
		EsTelefIgualClieDTO telefono  = null;
		EsClieTelefDTO datosSituacion = null;
		AbonadoOutDTO datosAbonados = null; 
		AbonadoDTO abonado = null;  
		AbonadoDTO abonadoSituacion = null;  
		BloqueoResponseDTO  bloqueoResponseFinal = new BloqueoResponseDTO();
		RespuestaDTO nuevaRespuesta = null;
		Global global = Global.getInstance();
		AuditoriaDTO			codPuntoAccesoDto	= new AuditoriaDTO();		
		AuditoriaDTO 			codAplicacionDto	= new AuditoriaDTO();		
		AuditoriaDTO 			codServicioDto		= new AuditoriaDTO();		
		AuditoriaDTO 			nombreUsuarioDto	= new AuditoriaDTO();	
		ArrayList 				campos				= new ArrayList();
		logger.info("fin de la declaraciones de variables para el metodo consultarFacturasPorCliente");
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
				bloqueoResponseFinal.setRespuesta(puntoAcceso.getRespuesta());
				return bloqueoResponseFinal;
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
					bloqueoResponseFinal.setRespuesta(aplicacionValidada);
					return bloqueoResponseFinal;
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
				bloqueoResponseFinal.setRespuesta(servicioValidado);
				return bloqueoResponseFinal;
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
				bloqueoResponseFinal.setRespuesta(usuarioValidado);
				return bloqueoResponseFinal;
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
						bloqueoResponseFinal.setRespuesta(servicio);
						return bloqueoResponseFinal;
					}
	       }
	        	       
		}else
		{
			bloqueoResponseFinal.setRespuesta(auditoria.getRespuesta());
			return bloqueoResponseFinal;
		}
		// Fin Proceso de Auditoria 
		
		
		
		logger.info("utilizando metodo:consultarAbonadoTelefono");
		     	telefono = new EsTelefIgualClieDTO();
		     	if(inParam0 != null && inParam0.getNumeroTelefono() != 0){
		     		telefono.setNum_telefono1(inParam0.getNumeroTelefono());
		     		datosAbonados = abonadoDTODAO.consultarAbonadoTelefono(telefono);
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
		
		logger.info("construción para obtener los datos del Bloqueo");
		  if(abonado != null && abonado.getCodCliente()!=0 ){
			  
			   logger.info("utilizando metodo:consultarAbonadoCliTel");
			    datosSituacion = new EsClieTelefDTO();
			    datosSituacion.setCodCliente(abonado.getCodCliente());
			    datosSituacion.setNumeroTelefono(inParam0.getNumeroTelefono());
	     		datosAbonados = abonadoDTODAO.consultarAbonadoCliTel(datosSituacion);
		       logger.info("recuperacion de datos del abanado");
				if( datosAbonados != null 
				 && datosAbonados.getListadoAbonados() != null 
				 && datosAbonados.getListadoAbonados().length > 0){
					     		for(int i = 0 ; i < datosAbonados.getListadoAbonados().length; i++){
					     			abonadoSituacion = datosAbonados.getListadoAbonados()[i]; 
					     		}
				 }
				logger.info("cerrando metodo :consultarAbonadoCliTel");
				
				if(abonadoSituacion != null && abonadoSituacion.getNumAbonado()!=0){
					if (abonadoSituacion != null && abonadoSituacion.getCodSituacion() != null && !abonadoSituacion.getCodSituacion().equals("AAA")){
						  bloqueoResponseFinal = new BloqueoResponseDTO();
						  if(abonado.getTipAbonado() != null && 
							    !abonado.getCodTiplan().equals("") && 
							    (abonado.getCodTiplan().equals(global.getValor("tipo.tipPospago")) || 
							     abonado.getCodTiplan().equals(global.getValor("tipo.tipPospago")) ||
							     abonado.getCodTiplan().equals(global.getValor("tipo.tipHibrido")))){ 
								 
								 logger.info("construción para obtener los datos del Bloqueo de un abonado pospago");
								 bloqueoInDTO = new BloqueoInDTO();
								 bloqueoInDTO.setCodAbonado(abonado.getNumAbonado());
								 BloqueoDTO obtener = abonadoDTODAO.consultarBloqueoTelefonoPospago(bloqueoInDTO);
								 logger.info("construción del objeto de respueta para le cliente");
								 if(obtener != null && obtener.getRespuesta() != null && obtener.getRespuesta().getCodigoError() == 0){
									 ArrayList listaPospago = new ArrayList();
									 BloqueoOutDTO nuevo = new BloqueoOutDTO();
									 nuevo.setCodCaususp(obtener.getCodCaususp());
									 nuevo.setCodTipfraude(obtener.getCodTipfraude());
									 nuevo.setDesCaususp(obtener.getDesCaususp());
									 nuevo.setDesTipsuspension(obtener.getDesTipsuspension());
									 nuevo.setDesValor(obtener.getDesValor());
									 nuevo.setFecSuspbd(obtener.getFecSuspbd());
									 nuevo.setFecSuspcen(obtener.getFecSuspcen());
									 nuevo.setIndFraude(obtener.getIndFraude());
									 nuevo.setNumTerminal(obtener.getNumTerminal());
									 nuevo.setTipSuspencion(obtener.getTipSuspencion());
									 listaPospago.add(nuevo);
									 
									 bloqueoResponseFinal.setLstListadoBloqueos((com.tmmas.gte.integraciongtecommon.dto.BloqueoOutDTO[])
												com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(listaPospago.toArray(),
														com.tmmas.gte.integraciongtecommon.dto.BloqueoOutDTO.class));
									 bloqueoResponseFinal.setRespuesta(obtener.getRespuesta());
								 }else{
									 bloqueoResponseFinal.setRespuesta(obtener.getRespuesta());
								 }
								 logger.info("construción del objeto de respueta para le cliente");
								 logger.info("termina de obtener los datos del Bloqueo de un abonado pospago");
						}else if(abonado.getTipAbonado() != null && 
						    	 abonado.getCodTiplan().equals(global.getValor("tipo.tipPrepago"))){
							
								 logger.info("construción para obtener los datos del Bloqueo de un abonado prepago");
								 bloqueoInDTO = new BloqueoInDTO();
								 bloqueoInDTO.setCodAbonado(abonado.getNumAbonado());
								 BloqueoDTO obtener = abonadoDTODAO.consultarBloqueoTelefonoPrepago(bloqueoInDTO);
								 logger.info("construción del objeto de respueta para le cliente");
								 if(obtener != null && obtener.getRespuesta() != null && obtener.getRespuesta().getCodigoError() == 0){
									 ArrayList listaPospago = new ArrayList();
									 BloqueoOutDTO nuevo = new BloqueoOutDTO();
									 nuevo.setCodCaususp(obtener.getCodCaususp());
									 nuevo.setCodTipfraude(obtener.getCodTipfraude());
									 nuevo.setDesCaususp(obtener.getDesCaususp());
									 nuevo.setDesTipsuspension(obtener.getDesTipsuspension());
									 nuevo.setDesValor(obtener.getDesValor());
									 nuevo.setFecSuspbd(obtener.getFecSuspbd());
									 nuevo.setFecSuspcen(obtener.getFecSuspcen());
									 nuevo.setIndFraude(obtener.getIndFraude());
									 nuevo.setNumTerminal(obtener.getNumTerminal());
									 nuevo.setTipSuspencion(obtener.getTipSuspencion());
									 listaPospago.add(nuevo);

									 bloqueoResponseFinal.setLstListadoBloqueos((com.tmmas.gte.integraciongtecommon.dto.BloqueoOutDTO[])
												com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(listaPospago.toArray(),
														com.tmmas.gte.integraciongtecommon.dto.BloqueoOutDTO.class));
									 bloqueoResponseFinal.setRespuesta(obtener.getRespuesta());
								 }else{
									 bloqueoResponseFinal.setRespuesta(obtener.getRespuesta());
								 }
								 logger.info("construción del objeto de respueta para le cliente");
								 logger.info("termina de obtener los datos del Bloqueo de un abonado prepago");  
						}
					}else{
					    bloqueoResponseFinal = new BloqueoResponseDTO();
						nuevaRespuesta = new RespuestaDTO();
						nuevaRespuesta.setCodigoError(0);
						nuevaRespuesta.setMensajeError("El número de teléfono consultado no se encuentra bloqueado.");
						nuevaRespuesta.setNumeroEvento(0);
						bloqueoResponseFinal.setRespuesta(nuevaRespuesta);
						return bloqueoResponseFinal;
					}
				}else{
				    bloqueoResponseFinal = new BloqueoResponseDTO();
					nuevaRespuesta = new RespuestaDTO();
					if(datosAbonados != null && datosAbonados.getRespuesta() != null && datosAbonados.getRespuesta().getCodigoError() != 0 ){
						bloqueoResponseFinal.setRespuesta(datosAbonados.getRespuesta());
						return bloqueoResponseFinal;
					}else{
						nuevaRespuesta.setCodigoError(-10003);
						nuevaRespuesta.setMensajeError("El número de teléfono ingresado no existe, esta dado de baja o en proceso de baja.");
						nuevaRespuesta.setNumeroEvento(datosAbonados.getRespuesta().getNumeroEvento());
					}
					
					bloqueoResponseFinal.setRespuesta(nuevaRespuesta);
				}
		  }else{
			    bloqueoResponseFinal = new BloqueoResponseDTO();
				nuevaRespuesta = new RespuestaDTO();
				if(datosAbonados != null && datosAbonados.getRespuesta() != null && datosAbonados.getRespuesta().getCodigoError() != 0 ){
					bloqueoResponseFinal.setRespuesta(datosAbonados.getRespuesta());
					return bloqueoResponseFinal;
				}else{
					nuevaRespuesta.setCodigoError(-10003);
					nuevaRespuesta.setMensajeError("El número de teléfono ingresado no existe, esta dado de baja o en proceso de baja.");
					nuevaRespuesta.setNumeroEvento(datosAbonados.getRespuesta().getNumeroEvento());
				}
				
				bloqueoResponseFinal.setRespuesta(nuevaRespuesta);
		  }
		logger.info("terminar para obtener los datos del Bloqueo");
		
		
		logger.info("consultarBloqueoTelefono:despues()");
		logger.info("consultarBloqueoTelefono:end()");
		return bloqueoResponseFinal;
	}
	
	/**
	* Servicio que permite consultar si el último cambio de equipo realizado fue ejecutado por el módulo de renovación y obtener los datos asociados al cambio de equipo.
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsRenovacionDTO consultarDatosRenovacion(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		logger.info("consultarDatosRenovacion:start()");
		logger.info("consultarDatosRenovacion:antes()");
		logger.info("declaracion de variables para el metodo consultarDatosRenovacion");
		ConsRenovacionDTO consRenovacion = new ConsRenovacionDTO();
		OrdenServicioDTO ordenServicio = null;
		OrdenServicioOutDTO ordenServicioOut = null;
		EsTelefIgualClieDTO telefono  = null;
		AbonadoOutDTO datosAbonados = null; 
		AbonadoDTO abonado = null;  
		RespuestaDTO nuevaRespuesta = null;
		Global global = Global.getInstance();
		AuditoriaDTO			codPuntoAccesoDto	= new AuditoriaDTO();		
		AuditoriaDTO 			codAplicacionDto	= new AuditoriaDTO();		
		AuditoriaDTO 			codServicioDto		= new AuditoriaDTO();		
		AuditoriaDTO 			nombreUsuarioDto	= new AuditoriaDTO();	
		ArrayList 				campos				= new ArrayList();
		logger.info("fin de la declaraciones de variables para el metodo consultarDatosRenovacion");
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
				consRenovacion.setRespuesta(puntoAcceso.getRespuesta());
				return consRenovacion;
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
					consRenovacion.setRespuesta(aplicacionValidada);
					return consRenovacion;
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
				consRenovacion.setRespuesta(servicioValidado);
				return consRenovacion;
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
				consRenovacion.setRespuesta(usuarioValidado);
				return consRenovacion;
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
						consRenovacion.setRespuesta(servicio);
						return consRenovacion;
					}
	       }
	        	       
		}else
		{
			consRenovacion.setRespuesta(auditoria.getRespuesta());
			return consRenovacion;
		}
		// Fin Proceso de Auditoria 
		
		
		
		logger.info("utilizando metodo:consultarAbonadoTelefono");
		     	telefono = new EsTelefIgualClieDTO();
		     	if(inParam0 != null && inParam0.getNumeroTelefono() != 0){
		     		telefono.setNum_telefono1(inParam0.getNumeroTelefono());
		     		datosAbonados = abonadoDTODAO.consultarAbonadoTelefono(telefono);
		     	}
				logger.info("recuperacion de datos del abonado");
		     	if(   datosAbonados != null 
		     	   && datosAbonados.getListadoAbonados() != null 
		     	   && datosAbonados.getListadoAbonados().length > 0){
			     		for(int i = 0 ; i < datosAbonados.getListadoAbonados().length; i++){
			     			abonado = datosAbonados.getListadoAbonados()[i]; 
			     		}
		     	}
		logger.info("cerrando metodo: consultarAbonadoTelefono");
		
		logger.info("construción para obtener los datos de Renovación");
		  if(abonado != null && abonado.getNumAbonado()!=0 ){
			  logger.info("utilizando metodo:consultarOOSSEjec");
			  ordenServicio = new OrdenServicioDTO();
			  
			  ordenServicio.setCodOs(global.getValor("codigo.ooss.cambio.equipo"));
			  ordenServicio.setCodInter(abonado.getNumAbonado());
			  
			  ordenServicioOut = abonadoDTODAO.consultarOOSSEjec(ordenServicio);
			  
			  logger.info("recuperacion de datos última OOSS cambio de equipo ejecutada para el abonado");
			  if (ordenServicioOut != null 
					  && ordenServicioOut.getRespuesta() != null
					  && ordenServicioOut.getRespuesta().getCodigoError() == 0 
					  && ordenServicioOut.getOrdenServicio().getNumOs() != 0){

				  ordenServicio.setNumOs(ordenServicioOut.getOrdenServicio().getNumOs());
				  consRenovacion.setFecOs(ordenServicioOut.getOrdenServicio().getFechaOs());

				  logger.info("utilizando metodo:consultarIndRenova");
				  ConsRenovacionDTO consRenovacionLocal = null;
				  
				  consRenovacionLocal = abonadoDTODAO.consultarIndRenova(ordenServicio);
				  
				  logger.info("recuperacion de datos indicador renovación");
				  if (consRenovacionLocal != null
						  && consRenovacionLocal.getRespuesta() != null
						  && consRenovacionLocal.getRespuesta().getCodigoError() == 0){
					  consRenovacion.setIndRenovacion(consRenovacionLocal.getIndRenovacion());
					  
					  logger.info("utilizando metodo:consultarCauCamEq");
					  consRenovacionLocal = null;
					  consRenovacionLocal = equipoDTODAO.consultarCauCamEq(ordenServicio);
					  
					  if (consRenovacionLocal != null
							  && consRenovacionLocal.getRespuesta() != null
							  && consRenovacionLocal.getRespuesta().getCodigoError() == 0){
						  consRenovacion.setCodCausa(consRenovacionLocal.getCodCausa());
						  consRenovacion.setDesCausa(consRenovacionLocal.getDesCausa());
						  consRenovacion.setRespuesta(consRenovacionLocal.getRespuesta());
					  }else{
						  if (consRenovacionLocal != null 
								  && consRenovacionLocal.getRespuesta() != null
								  && consRenovacionLocal.getRespuesta().getCodigoError() != 0){

							    consRenovacion.setRespuesta(consRenovacionLocal.getRespuesta());
								return consRenovacion;
						  }else{
							  nuevaRespuesta = new RespuestaDTO();
							  nuevaRespuesta.setCodigoError(-10053);
							  nuevaRespuesta.setMensajeError("Se produjo un error al obtener los datos de la causa de cambio de equipo.");
							  nuevaRespuesta.setNumeroEvento(datosAbonados.getRespuesta().getNumeroEvento());
							  consRenovacion.setRespuesta(nuevaRespuesta);
						  }
					  }
					  logger.info("cerrando metodo: consultarCauCamEq");
				  }else{
					  if (consRenovacionLocal != null 
							  && consRenovacionLocal.getRespuesta() != null
							  && consRenovacionLocal.getRespuesta().getCodigoError() != 0){

						    consRenovacion.setRespuesta(consRenovacionLocal.getRespuesta());
						    consRenovacion.setIndRenovacion(null);

							return consRenovacion;
					  }else{
						  nuevaRespuesta = new RespuestaDTO();
						  nuevaRespuesta.setCodigoError(-10052);
						  nuevaRespuesta.setMensajeError("Se produjo un error al obtener indicador de renovación.");
						  nuevaRespuesta.setNumeroEvento(datosAbonados.getRespuesta().getNumeroEvento());
						  consRenovacion.setRespuesta(nuevaRespuesta);
						  consRenovacion.setIndRenovacion(null);
					  }
				  }
				  logger.info("cerrando metodo: consultarIndRenova");
			  }else{
				  if (ordenServicioOut != null 
						  && ordenServicioOut.getRespuesta() != null
						  && ordenServicioOut.getRespuesta().getCodigoError() == 0 
						  && ordenServicioOut.getOrdenServicio().getNumOs() == 0){
					  
					  nuevaRespuesta = new RespuestaDTO();
					  nuevaRespuesta.setCodigoError(-10050);
					  nuevaRespuesta.setMensajeError("No existen OOSS de cambio de equipo ejecutadas para el número de teléfono consultado.");
					  nuevaRespuesta.setNumeroEvento(ordenServicioOut.getRespuesta().getNumeroEvento());
					  consRenovacion.setRespuesta(nuevaRespuesta);
					  consRenovacion.setIndRenovacion(null);
				  }else{
					  if (ordenServicioOut != null 
							  && ordenServicioOut.getRespuesta() != null
							  && ordenServicioOut.getRespuesta().getCodigoError() != 0){

						    consRenovacion.setRespuesta(ordenServicioOut.getRespuesta());
						    consRenovacion.setIndRenovacion(null);
							return consRenovacion;
					  }else{
						  nuevaRespuesta = new RespuestaDTO();
						  nuevaRespuesta.setCodigoError(-10051);
						  nuevaRespuesta.setMensajeError("Se produjo un error al obtener OOSS de cambio de equipo ejecutadas para el número de teléfono consultado.");
						  nuevaRespuesta.setNumeroEvento(ordenServicioOut.getRespuesta().getNumeroEvento());
						  consRenovacion.setRespuesta(nuevaRespuesta);
						  consRenovacion.setIndRenovacion(null);
					  }
				  }
			  }
			  logger.info("cerrando metodo: consultarOOSSEjec");
		  }else{
				if(datosAbonados != null && datosAbonados.getRespuesta() != null && datosAbonados.getRespuesta().getCodigoError() != 0 ){
					consRenovacion.setRespuesta(datosAbonados.getRespuesta());
				    consRenovacion.setIndRenovacion(null);
					return consRenovacion;
				}else{
					nuevaRespuesta = new RespuestaDTO();
					nuevaRespuesta.setCodigoError(-10003);
					nuevaRespuesta.setMensajeError("El número de teléfono ingresado no existe, esta dado de baja o en proceso de baja.");
					nuevaRespuesta.setNumeroEvento(datosAbonados.getRespuesta().getNumeroEvento());
					consRenovacion.setRespuesta(nuevaRespuesta);
					consRenovacion.setIndRenovacion(null);
				}
		  }
		logger.info("terminar para obtener los datos de renovación");
		logger.info("consultarDatosRenovacion:despues()");
		logger.info("consultarDatosRenovacion:end()");
		return consRenovacion;
	}
}